package com.yahoo.infographics.series
{
	import com.yahoo.infographics.data.AxisData;
	import com.yahoo.infographics.data.events.DataEvent;
	import com.yahoo.renderers.Renderer;
	import com.yahoo.infographics.styles.CartesianStyles;
	import com.yahoo.infographics.cartesian.Graph;

	/**
	 * Cartesian is the base class for Cartesian Graphs. The Cartesian class is an abstract 
	 * base class; therefore, you cannot call Cartesian directly.
	 */
	public class Cartesian extends Renderer implements ISeries
	{
		/**
		 * @private
		 * Reference to style class used.
		 */
		private static var _styleClass:Class = CartesianStyles;
	
		/**
		 * Constructor
		 */
		public function Cartesian(series:Object) 
		{
			super();
			if(series)
			{
				this.parseSeriesData(series);
			}
			this.initializeStyleProps();
		}

		/**
		 * @private
		 */
		private var _type:String = "cartesian";
		
		/**
		 * Indicates the type of graph.
		 */
		public function get type():String
		{
			return this._type;
		}

		/**
		 * @private (setter)
		 */
		public function set type(value:String):void
		{
			this._type = value;
		}
		
		/**
		 * Total number of series of this type in the graph.
		 */
		public function get length():int
		{
			return this._graph.getSeriesLengthByType(this._type);
		}

		/**
		 * @private 
		 * Storage for <code>order</code>
		 */
		protected var _order:int;
		/**
		 * Order of this ISeries instance of this <code>type</code>.
		 */
		public function get order():int
		{
			return this._order;
		}

		/**
		 * @private (setter)
		 */
		public function set order(value:int):void
		{
			this._order = value;
		}
		
		/**
		 * @private 
		 * Storage for <code>xcoords</code>.
		 */
		protected var _xcoords:Vector.<int> = new Vector.<int>();

		/**
		 * x coordinates for the series.
		 */
		public function get xcoords():Vector.<int>
		{
			return this._xcoords;
		}

		/**
		 * @private (setter)
		 */
		public function set xcoords(value:Vector.<int>):void
		{
			this._xcoords = value;
		}
		
		/**
		 * @private (protected)
		 * Storage for <code>ycoords</code>
		 */
		protected var _ycoords:Vector.<int> = new Vector.<int>();

		/**
		 * y coordinates for the series.
		 */
		public function get ycoords():Vector.<int>
		{
			return this._ycoords;
		}
		
		/**
		 * @private (setter)
		 */
		public function set ycoords(value:Vector.<int>):void
		{
			this._ycoords = value;
		}

		/**
		 * @private 
		 * Storage for <code>graph</code>.
		 */
		protected var _graph:Graph;
		
		/**
		 * Reference to the parent graph.
		 */
		public function get graph():Graph
		{
			return this._graph;
		}

		/**
		 * @private (setter)
		 */
		public function set graph(value:Graph):void
		{
			this._graph = value;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function getStyleClass():Class
		{
			return _styleClass;
		}		
		
		/**
		 * @private
		 * Storage for xAxisData
		 */
		private var _xAxisData:AxisData;
		
		/**
		 * Reference to the <code>AxisData</code> instance used for assigning 
		 * x-values to the graph.
		 */
		public function get xAxisData():AxisData
		{ 
			return _xAxisData;
		}

		/**
		 * @private (setter)
		 */
		public function set xAxisData(value:AxisData):void
		{
			if (value !== _xAxisData)
			{
				if(this.xAxisData) 
				{
					this.xAxisData.removeEventListener(DataEvent.NEW_DATA, this.xAxisDataChangeHandler);
					this.xAxisData.removeEventListener(DataEvent.DATA_CHANGE, this.xAxisDataChangeHandler);
				}
				_xAxisData = value;			
				this.xAxisData.addEventListener(DataEvent.NEW_DATA, this.xAxisDataChangeHandler);
				this.xAxisData.addEventListener(DataEvent.DATA_CHANGE, this.xAxisDataChangeHandler);
				this.setFlag("axisDataChange");
			}
		}
		
		/**
		 * @private
		 * Storage for yAxisData
		 */
		private var _yAxisData:AxisData;
		
		/**
		 * Reference to the <code>AxisData</code> instance used for assigning 
		 * y-values to the graph.
		 */
		public function get yAxisData():AxisData
		{ 
			return _yAxisData;
			
		}

		/**
		 * @private (setter)
		 */
		public function set yAxisData(value:AxisData):void
		{
			if (value !== _yAxisData)
			{
				if(this.yAxisData) 
				{
					this.yAxisData.removeEventListener(DataEvent.NEW_DATA, this.yAxisDataChangeHandler);
					this.yAxisData.removeEventListener(DataEvent.DATA_CHANGE, this.yAxisDataChangeHandler);
				}
				_yAxisData = value;
				this.yAxisData.addEventListener(DataEvent.NEW_DATA, this.yAxisDataChangeHandler);
				this.yAxisData.addEventListener(DataEvent.DATA_CHANGE, this.yAxisDataChangeHandler);
				this.setFlag("axisDataChange");
			}
		}
		
		/**
		 * @private
		 * Storage for xKey
		 */
		private var _xKey:String;
		
		/**
		 * Indicates which array to from the hash of value arrays in 
		 * the x-axis <code>AxisData</code> instance.
		 */
		public function get xKey():String
		{ 
			return _xKey; 
		}

		/**
		 * @private (setter)
		 */
		public function set xKey(value:String):void
		{
			if (value !== _xKey)
			{
				_xKey = value;
				this.setFlag("xKeyChange");
			}
		}
		
		/**
		 * @private
		 * Storage for yKey
		 */
		private var _yKey:String;
		
		/**
		 * Indicates which array to from the hash of value arrays in 
		 * the y-axis <code>AxisData</code> instance.
		 */
		public function get yKey():String
		{ 
			return _yKey; 
		}

		/**
		 * @private (setter)
		 */
		public function set yKey(value:String):void
		{
			if (value !== _yKey)
			{
				_yKey = value;
				this.setFlag("yKeyChange");
			}
		}

		/**
		 * @private (protected)
		 */
		protected var _graphOrder:int;

		/**
		 * Gets or sets the order in relation to all series in a graph.
		 */
		public function get graphOrder():int
		{
			return this._graphOrder;
		}

		/**
		 * @private (setter)
		 */
		public function set graphOrder(value:int):void
		{
			this._graphOrder = value;
		}

		/**
		 * @private (protected)
		 */
		protected var _topPadding:Number = 0;

		/**
		 * @private (protected)
		 */
		
		protected var _rightPadding:Number = 0;
		/**
		 * @private (protected)
		 */
		
		protected var _bottomPadding:Number = 0;
		/**
		 * @private (protected)
		 */
		
		protected var _leftPadding:Number = 0;
		
		/**
		 * @private (protected)
		 */
		protected var _xMin:Number;
		
		/**
		 * @private (protected)
		 */
		protected var _xMax:Number;
		
		/**
		 * @private (protected)
		 */
		protected var _yMin:Number;
		
		/**
		 * @private (protected)
		 */
		protected var _yMax:Number;

		/**
		 * @private (protected)
		 * Storage for xCoords
		 */
		protected var _xCoords:Vector.<int>;

		/**
		 * @private (protected)
		 * Handles updating the graph when the x < code>AxisData</code> values
		 * change.
		 */
		protected function xAxisDataChangeHandler(event:DataEvent):void
		{
			if(this.xKey) this.setFlag("axisDataChange");
		}

		/**
		 * @private (protected)
		 * Handles updating the chart when the y <code>AxisData</code> values
		 * change.
		 */
		protected function yAxisDataChangeHandler(event:DataEvent):void
		{
			if(this.yKey) this.setFlag("axisDataChange");
		}
		
		/**
		 * @private
		 */
		protected function setAreaData():void
		{
			var nextX:int, nextY:int,
				dataWidth:Number = this.width - (this._leftPadding + this._rightPadding),
				dataHeight:Number = this.height - (this._topPadding + this._bottomPadding),
				xcoords:Vector.<int> = new Vector.<int>(),
				ycoords:Vector.<int> = new Vector.<int>(),
				xScaleFactor:Number = dataWidth / (this._xMax - this._xMin),
				yScaleFactor:Number = dataHeight / (this._yMax - this._yMin),
				xData:Array = xAxisData.getDataByKey(xKey),
				yData:Array = yAxisData.getDataByKey(yKey),
				dataLength:int = xData.length, 	
				midY:Number = dataHeight/2,
				xmax:Number = this._xMax,
				xmin:Number = this._xMin,
				ymax:Number = this._yMax,
				ymin:Number = this._yMin,
				leftPadding:Number = this._leftPadding,
				topPadding:Number = this._topPadding;
			for (var i:int = 0; i < dataLength; ++i) 
			{
				//Math.round hack. gain 1 to 2 ms on loops of 10000. needs more testing.
				nextX = int(0.5 + (((Number(xData[i]) - xmin) * xScaleFactor) + leftPadding)),
				nextY = int(0.5 +((dataHeight + topPadding) - (Number(yData[i]) - ymin) * yScaleFactor)),
				xcoords.push(nextX);
				ycoords.push(nextY);
			}
			this._xcoords = xcoords;
			this._ycoords = ycoords;
		}

		/**
		 * @private (protected)
		 */
		protected function setDimensions():void
		{
			var padding:Object = this.getStyle("padding");
			this._topPadding = Number(padding.top);
			this._rightPadding = Number(padding.right);
			this._bottomPadding = Number(padding.bottom);
			this._leftPadding = Number(padding.left);
		}

		/**
		 * @private
		 */
		protected function drawGraph():void
		{
		}
		
		/**
		 * @private (override)
		 */
		override protected function render():void
		{
			var dataChange:Boolean = this.checkDataFlags(),
				resize:Boolean = this.checkResizeFlags(),
				styleChange:Boolean = this.checkStyleFlags(),
				w:Number = this.width,
				h:Number = this.height;
		
			this.updateStyleProps();

			if(dataChange)
			{
				this._xMin = xAxisData.minimum as Number;
				this._xMax = xAxisData.maximum as Number;
				this._yMin = yAxisData.minimum as Number;
				this._yMax = yAxisData.maximum as Number;
			}
			
			if(resize)
			{
				this.setDimensions();
			}

			if ((resize || dataChange) && (!isNaN(w) && !isNaN(h) && w > 0 && h > 0))
			{
				this.setAreaData();
				if(this._xcoords && this._ycoords) 
				{
					this.setLaterFlag("drawGraph");
				}
				return;
			}
			
			if(this.checkFlag("drawGraph") || (styleChange && this._xcoords && this._ycoords)) this.drawGraph();
		}

		/**
		 * @private (protected)
		 */
		protected function parseSeriesData(series:Object):void
		{
			if(series.hasOwnProperty("xAxisData"))
			{
				this.xAxisData = series.xAxisData as AxisData;
			}
			if(series.hasOwnProperty("yAxisData"))
			{
				this.yAxisData = series.yAxisData as AxisData;
			}
			if(series.hasOwnProperty("xKey"))
			{
				this.xKey = series.xKey;
			}
			if(series.hasOwnProperty("yKey"))
			{
				this.yKey = series.yKey;
			}
		}
	
		public function checkDataFlags():Boolean 
		{
			return this.checkFlags({
				axisDataChange:true,
				xKeyChange:true,
				yKeyChange:true
			});
		}

		public function checkResizeFlags():Boolean
		{
			return this.checkFlags({
				padding:true,
				resize:true
			});
		}

		public function checkStyleFlags():Boolean 
		{
			return false;
		}

		protected function initializeStyleProps():void
		{
		}
		
		/**
		 * @private (protected)
		 * Updates local references to style properties.
		 */
		protected function updateStyleProps():void
		{
		}
	}
}