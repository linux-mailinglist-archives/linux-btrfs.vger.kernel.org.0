Return-Path: <linux-btrfs+bounces-4048-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C72C89D4BD
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 10:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD1C21C219EB
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 08:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC88C3BBD8;
	Tue,  9 Apr 2024 08:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="W6iWfSgX";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xqA7CzpP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1C22AD2A;
	Tue,  9 Apr 2024 08:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712652180; cv=fail; b=boKvklNmeSdi5eu0j4hUPa5y3rB9G59+nNilmjd9Gj8xVnW2UkoW8E35aaxmTi3nqjAowR5uJOM3+YFJrhE/YFJD5xCP40dBnhMneHUnAmTraBQpAXR9BAWQ9HmGilEJwgGDrcTwU7kYlZpcSJpKI1SL9tzLNepyP5SSpi+HLug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712652180; c=relaxed/simple;
	bh=u9pB30NcjfWihA3RirEFNr+oYovzHQMs4cyoCIh8SA0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VPO8Rpps1RrT4qk76K471g36UxBIhUO2T4w0/RrHvSHhP6Po59Y9Z66ogeLXBBFXDHVQvqedhPD33RSVdWUSp+aTBjvbzs6cMxVoKUbxBA+AssUrEJqMCRVR+Hr1ccA5zz/bGzWpHYWXQwzlngmLxzHYA37tgK2Lck6XuzoPdlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=W6iWfSgX; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=xqA7CzpP; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712652178; x=1744188178;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=u9pB30NcjfWihA3RirEFNr+oYovzHQMs4cyoCIh8SA0=;
  b=W6iWfSgXB45aTP0UPxUCwBK35ibJbbjgOUlcUTrVWjjFymN3Hu0yIDWk
   SxVUfCquDgjx0zbCkwd8z4QL0cxenTHb9nYLlIuzZrVaIBbmWZ8milofs
   2mLwuh6S7r3rDMe2v0iXaimLo443cvqo+f/z12MLpl93p6fShJ4/nTiCI
   V4bocfNAM8+QzZOqdGn8YnGSkEN9p88hXLvMgQCYxqkxqPHkzA6x8nYIR
   YzpehyvUsWjwzPWWk8GTWak6T3pvBLcRskGmpcqZLQFsVCGm68VC7fdSv
   glgrUctZYHt7LpnqDjdQ06Mf2FbXD8TEGBGVwLlFuJV6DrK9GV9/8SY13
   Q==;
X-CSE-ConnectionGUID: IxySeDIASBiePwLsiG0v2Q==
X-CSE-MsgGUID: Hs2o2BTvTOmDolmnZs7YCA==
X-IronPort-AV: E=Sophos;i="6.07,189,1708358400"; 
   d="scan'208";a="13052313"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2024 16:42:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhW7OdP05QenMw3GFLnQOyweQYVF7VQB6NshAn+zqjp99KP/7CttH7uH0Xlzkv01GZ43OrhBfCTMNNWft3wIGreBZRU1dF3LEz9lf3FwhQA0obH99F+6S5ZX55n39hGBW82avT1GR/mcYBJ4EwRn4v/FKg98Mjq3NsryXlW2FGkj4znfGqM8WlimsIuUvkpoSxMXnQOIRnWZl/8W1PQYQfIm5LzizS6OLATC1PUf/LxBqHdh8XmKnIz9dB2AqDlbEF26VTnf+XkV0n4ZKj0Gq74NR5v1AvTmODa0cV8RMBTcqEJCa6sbuccjfm7WZFgV62VEckyrGyae016vtPF45Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9pB30NcjfWihA3RirEFNr+oYovzHQMs4cyoCIh8SA0=;
 b=MEZgqZrp2EltaKchECXdPyLJmEnh+4nLvnXpMWNBlr5quAKu5hKyvUyt4VWg3TnUtzY557jTMmvR8x5d2fd+Vrr9OskXJJrBoak64TBpycr47GejL39aBB3XGZ/aVt4Yde3MpFZHgIi42ZNCH477mjh5DefIhjwk8dI0FN99AZq0YFVWityMGAy6VNZy+j/zgHM6MuFtmeadhtYmGClGTB0VTai81NmuAICXPHBW49IW02Ge1Cf4CnbdP3UCJn/DyGY0yd5P+3Y6W0wULIaDnf3bPNAPbyVgq+zKO6AQfirLz7KrzpC+7o8IgDabwNsaXACJWcahxns2YJr8hYmXfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9pB30NcjfWihA3RirEFNr+oYovzHQMs4cyoCIh8SA0=;
 b=xqA7CzpPO4KLeF2dsV2I+ePQzGauKw5tSWoBS61kbXB/9pdAJk07XRnKob9xVG3D0BzxeX88asH7WsSbx066QFccEBccsoNIN+YUsgf7fZu6GjezXqJboH0cNiClxLyi/JIHieTiS9cKu5auXtcSYIdxHshqt++d0oB+kbSjQLY=
Received: from BYAPR04MB5431.namprd04.prod.outlook.com (2603:10b6:a03:ce::16)
 by SN7PR04MB8675.namprd04.prod.outlook.com (2603:10b6:806:2dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 08:42:55 +0000
Received: from BYAPR04MB5431.namprd04.prod.outlook.com
 ([fe80::2ab2:43a3:658b:b8c9]) by BYAPR04MB5431.namprd04.prod.outlook.com
 ([fe80::2ab2:43a3:658b:b8c9%7]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 08:42:54 +0000
From: =?utf-8?B?SsO4cmdlbiBIYW5zZW4=?= <Jorgen.Hansen@wdc.com>
To: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, Fan Ni
	<fan.ni@samsung.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Navneet
 Singh <navneet.singh@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/26] cxl/mem: Read dynamic capacity configuration from
 the device
Thread-Topic: [PATCH 03/26] cxl/mem: Read dynamic capacity configuration from
 the device
Thread-Index: AQHafmd1sNKtljYSzku01AWUaCY0RrFU6HuAgAUjeACABasQgA==
Date: Tue, 9 Apr 2024 08:42:54 +0000
Message-ID: <a5bc469b-424f-4a57-9df3-da3817fb94f6@wdc.com>
References: <20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com>
 <20240324-dcd-type2-upstream-v1-3-b7b00d623625@intel.com>
 <79ebeecc-1650-4fcc-a5c5-db64ac16316d@wdc.com>
 <66103e5045e1c_e9f9f2941@iweiny-mobl.notmuch>
In-Reply-To: <66103e5045e1c_e9f9f2941@iweiny-mobl.notmuch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR04MB5431:EE_|SN7PR04MB8675:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 sF5yFNCcSE0QX+nWmm6ifort0YEbTsvkYSC7M7hZeRcwH6Lmdiim4REtYAYIilnCMrynnRQ1GQovNYtnfAs9QVQpzMSElOwwikzWhUv92442lzhFnAefeEffDmVklPpQc/yopqYhbz6lUVrEs5FhfabLnMal6sP/f02TDNh5FsIxiSdbyTr0WT277+bdA2zyQAbuSLZVtIZptDXrWimhSBHqcM3RRy3SocBpdOG7uBiSUgoFO2OxFfZlWim9262xH8bkmLg514AEVq70KaKF0hhTqT8f7kzuF4kWbvb8J5/sBOfqcnYBcX4gx5x6fZMXeqtwo4m9HJZq8fYemPNPBVZJsjvr3kODe9Xxftz40LQuLmT+ZhgPbmxke33Y8vBGxT2+Y/XIJCG5byEqwS/zL/u8cpX3I4LkFh9LkFb+mXuJ88QO9ASFo6j0Rxrn9uUUTQRbBD2M5HGCTKnRjUU3aPOdAQ6sKtVnJF35umAlX5Y125IdNqqzGCvfJeb1yLM4IiRrxYXfibn2NcE0IFW4iFPJtc018oKnCN/bI9MIS1UV7qiWmMxco8WV6IC3UhGlgqYM639A4WMAo2DcaEC4Ri9n4EMi5Z+53iLYT9qV8kSV6WLFasu5ut65CJuNkCVOGqWx6XhuMfBoFc6ip4a+u/N6Mw41wKqve453oNPCbpw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB5431.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZUdmdGkwSmVQOXNlbTQ4WjlkQm5KUEtwVmZScFVQR1lFUHVHZkV6N1Npa09q?=
 =?utf-8?B?NTRKRmlvdkRaT2Flckx3b1pnTTN4aG4rRUk2cnA0Z0hjM1p0emFDNHc1empC?=
 =?utf-8?B?L2psUnlWWXVjMXI3SGlGczVhQlZVUURoc3BZb0RoWGVsY3NleUZTdXFYTzN4?=
 =?utf-8?B?QUM3eFRzYlJjNnI1MjBxTWhlUlVsSW05VktvNHFiaFRVdU5wTkZGazVuN21J?=
 =?utf-8?B?VElzWWpvTy9kT0xLb1p3RTVkMSsxMm9IK0lpWmV1aWh5b1JvMTFHdGFPSktO?=
 =?utf-8?B?YnZ6T1g4NWRDSTNqby81NE95NURDcTNQQ3BVQld6Z01uUWdoVk5DeVVSSHRT?=
 =?utf-8?B?aUo5dm4xeWdxNFEzR1d3MmVBY1JvWVcvbU5vRjlPL2xJclpJNXhPQlVMVkpv?=
 =?utf-8?B?REgrQ2tMUDlqSG5JdUZMeVRqNityOExVQ1czQmxJdXN4b0lZa2VnRm13aW5D?=
 =?utf-8?B?a3I5eFlyV3NGWVJIQUkvSEE1Z3YzUmd6a2hDR2NkbXROTWdYWG9Ed3Z0aHJR?=
 =?utf-8?B?dXdlUDlEdmFHLzcxLzUzWExUa0Nyc3I1aHJKREpLZmxrMFVpbzZjbzBYeDEy?=
 =?utf-8?B?aE1oYTdrRGg4R25CYU1idGdxQkZIQkZ1Sk9ZZjRzSXlOcmFsSGtjNXhRSUsv?=
 =?utf-8?B?QXVBZ1lnU0w4anZRNngrOXpLZnVXazZ3dHBIN1RPT3N0Q3JTaXBBU2hMczBo?=
 =?utf-8?B?aitwYmxua015SUt5SjRlbGdsK1hIN0htRy96Rzk3OGJIWTBZMVhZL1I3bFpE?=
 =?utf-8?B?Z1o4ajFwYW5KM0dibHk5ei9oS0JHMDJzQWRQbEM1NjJUcWlRWDVGUWhDODM1?=
 =?utf-8?B?MnpnZlBjdmg4dEVJeGR3WUtmcHN4dzBaMUZsM2JleWlWRjk2RGduZm00eG15?=
 =?utf-8?B?emVTYXl6M0hPNkxhZ1JIejRCeGlQbzk3anh4bWxONEw5ZEswSlpsM3pCNzVU?=
 =?utf-8?B?QWVndCtQVGJWZ2RDdkxaWGFPN01NRytWMnlSMDB6L2FaNDNmMVlTMDdEQmFo?=
 =?utf-8?B?S1daK21zdFQ4RkZaQk5TWDJmZE5tOVJtT0w1V01xN0pPSE1qa1F0M1FpckVI?=
 =?utf-8?B?d1krWWM1d1hkWkdUNFdubDFPdi9NTEJwcityZThJWWM1VjV2WUtRZVQzK0Iv?=
 =?utf-8?B?UkhRdlFMdk94QTZpTXFJTFp1dUJhRUxpNVFSenZQdEhsY2k4cmRqcFhZem0z?=
 =?utf-8?B?eEhOREh3bS9VSDlYLzlUZTBDL3UwbzBxclY5UEJGVGNQemZVR1JkNlB0L2hQ?=
 =?utf-8?B?T1dWOXA0R3FPZGNkNkNUUW9Fa3ZJWEdHNjhzbVpBL2FNRTNEdUhNUy9SbkdX?=
 =?utf-8?B?ZFpUZDIwVFNNbnYxMXlkamVYZmZtNVpMbXozSjE4UjAzdDB3NGhoQUZ1dnlY?=
 =?utf-8?B?RFF2WWZKcDh2KzRmVEpnelVLSzQ4bHNGVzBMY3lRZFArSXBKeVhTcUk1aW1a?=
 =?utf-8?B?ZlB5dUY2VFdPNm5oVlozYmd3R0x0bEc2SGkrdVlld3MydDdlcXRINUlrQ2Vj?=
 =?utf-8?B?cW9MMlFwK0RrUVRkc0VLSnVqSE0xZkhhQWJOZzUzV2Y1aG9yZWt1bHRaY3dE?=
 =?utf-8?B?VElnMmFVTC8vWDlkVkEyU1dIMnRDVDRpcld1c09mMnkwd05maVAzTWNwMXlY?=
 =?utf-8?B?QVBGbEsvNDJ2WE03dm1IRTlsMUFQNU5BTmVaOXoxMHVNWFhrd3cvTWwvVHdn?=
 =?utf-8?B?ekpoMkpGMHlqUlIrNjN2c0hlazdZUVFNL2ZmSmJHbk9oZHFqK2NBdlkxRnB3?=
 =?utf-8?B?V3BrTzEvMVFHZWh2OEJXNmxQK01Na3ZnNG5XUnRnUVV6WXF1eEVsWnlWd0c3?=
 =?utf-8?B?WmhwU1FQOHB4UlJGamtWUW11VEdNM09qU3hxNy91c0dpRmJvOTZzeXlTWHda?=
 =?utf-8?B?TkhROUtUMWFBS09najhLTEl1MkZ2eUVaWTZneFlwVTZiSDVaRDlNbHNDV1hn?=
 =?utf-8?B?OXZxVkZhUjhGL2MvdHg4emdMeWUrbVo1SkFjaTlUbHVxZjF4V2szQVd1Q1pt?=
 =?utf-8?B?WkNQQ3VXNnBSa1dhT2VWelhwVGo2Zi9raXJ1eStJdzVKcUlodi9WbzVEQ0Y0?=
 =?utf-8?B?NzJtMzUvWm9JVHg2MkNOaWhGZ05xV1JqN240SXZaRjFlY2R6bVdCSlNBaHpi?=
 =?utf-8?B?U3l6aGYydyt6K1FtRlBKZkNFYzdoNWw1cEdHd2dEYjR2U0JrNUIyekZYUlBB?=
 =?utf-8?B?dFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71C7DA93F4C5B14B93AAA96018C379FD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	o2/3DN/HNyp77kyHUsnQfwsH8Y6S25k6dQUTkipN1PnzE5oTceFu6AOUSnA2XG0xOOjnxJzUzY7OXvSJ1AMeIMkQI+XsADI6QxmkPJAEY2omXpGmdOMpw+ZpKIa2Oz0LuE1rNU83/xShD4WVJsj43tAW5Vc5BhnYZYptkBzRBF+X9KNwCWkPRD7tZ08qYFVuLXKNEp+51B5/36YEiArrz2nI0IhBwgPKw1Qv07YZRntuO+eCRBtN/JghWYMd3/Pk7Jj/9q25VsHRu9E95vVoFc3lvNJMVl7fhddrcGBGKh7oFdpprd0rvw5psCQg55MLXq5nGB7lLVO/5N/i8mD/LbPDGpgizhXeDsZnn6KQfO6chs+yDvjCTGDvhGEKCSx125/IuV0t75pl3o/e19NSJkV9AC6hvvGaDtb5r1lMPLW9dMyFUEpUH+3PR9K6MhAeJ8YNfvJba1euOY63nENb9gYcSA3jWey5BBdFu8JTYuQQQ3S/+MZnQtIN/mddPOIe8pAo/nkGap8AXn8y38jvGplXaGfqeM7b2oGBZ4FJZudBXJBXBiyW9uQUR/4ORbAzw/T9l63aTwcJ1SBvNaaEXtqdGHSWIbxyEJvjgV9ar1OJRpSNkPto97TqWjcPDebx
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB5431.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b04f5c-a561-45e5-e95c-08dc58710c94
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 08:42:54.5048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M+ki93OvrHVOhTrzH0fFPJ33ZBgqerhx90LHWFypIUi/g/Mex5vMZO9GpacwuThJM1OwCQYY+7+Y6JXyCBGUGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8675

T24gNC81LzI0IDIwOjA5LCBJcmEgV2Vpbnkgd3JvdGU6DQo+IErDuHJnZW4gSGFuc2VuIHdyb3Rl
Og0KPj4gT24gMy8yNS8yNCAwMDoxOCwgaXJhLndlaW55QGludGVsLmNvbSB3cm90ZToNCj4+DQo+
Pj4gRnJvbTogTmF2bmVldCBTaW5naCA8bmF2bmVldC5zaW5naEBpbnRlbC5jb20+DQo+Pj4NCj4g
DQo+IFtzbmlwXQ0KPiANCj4+PiAgICAvKioNCj4+PiAgICAgKiBzdHJ1Y3QgY3hsX21lbWRldl9z
dGF0ZSAtIEdlbmVyaWMgVHlwZS0zIE1lbW9yeSBEZXZpY2UgQ2xhc3MgZHJpdmVyIGRhdGENCj4+
PiAgICAgKg0KPj4+IEBAIC00NjcsNiArNDgyLDggQEAgc3RydWN0IGN4bF9kZXZfc3RhdGUgew0K
Pj4+ICAgICAqIEBlbmFibGVkX2NtZHM6IEhhcmR3YXJlIGNvbW1hbmRzIGZvdW5kIGVuYWJsZWQg
aW4gQ0VMLg0KPj4+ICAgICAqIEBleGNsdXNpdmVfY21kczogQ29tbWFuZHMgdGhhdCBhcmUga2Vy
bmVsLWludGVybmFsIG9ubHkNCj4+PiAgICAgKiBAdG90YWxfYnl0ZXM6IHN1bSBvZiBhbGwgcG9z
c2libGUgY2FwYWNpdGllcw0KPj4+ICsgKiBAc3RhdGljX2NhcDogU3VtIG9mIHN0YXRpYyBSQU0g
YW5kIFBNRU0gY2FwYWNpdGllcw0KPj4+ICsgKiBAZHluYW1pY19jYXA6IENvbXBsZXRlIERQQSBy
YW5nZSBvY2N1cGllZCBieSBEQyByZWdpb25zDQo+Pg0KPj4gSG93IGFib3V0IG5hbWluZyB0aGVz
ZSB0b3RhbF9yYW5nZSwgc3RhdGljX2NhcCBhbmQgZHluYW1pY19yYW5nZSB0byBtYWtlDQo+PiBp
dCBjbGVhciB0aGF0IHRoZSBEUEEgcmFuZ2Ugb2NjdXBpZWQgYnkgREMgcmVnaW9ucyBpc24ndCBu
ZWNlc3NhcmlseQ0KPj4gdXNhYmxlIGNhcGFjaXR5IChhcyBvcHBvc2VkIHRvIHRoZSBzdGF0aWNf
Y2FwIHdoZXJlIHRoZSBzcGVjIGRlZmluZXMgaXQNCj4+IGFzIHVzYWJsZSBjYXBhY2l0eSkuDQo+
IA0KPiBJIHRob3VnaHQgdGhpcyB3YXMgYSBnb29kIGlkZWEgYnV0IG9uIHNlY29uZCB0aG91Z2h0
IHRoZXNlIGFyZSBub3QgcmFuZ2UNCj4gdmFyaWFibGVzIGF0IGFsbC4gIFRoZXkgcmVhbGx5IHJl
cHJlc2VudCB0aGUgdmFyaW91cyBsZW5ndGhzIG9mIHRoZQ0KPiByZXNvdXJjZXMuDQo+IA0KPiBG
b3IgdG90YWxfYnl0ZXMgdGhlIGRvY3VtZW50YXRpb24gYWxyZWFkeSBzYXlzICdzdW0gb2YgYWxs
IF9fcG9zc2libGVfXw0KPiBjYXBhY2l0aWVzID4NCj4gSSB0aGluayB5b3UgaGF2ZSBhIHBvaW50
IGZvciB0aGUgbmV3IGZpZWxkcyB0aG91Z2guICBUaGV5IHNob3VsZCBhbGwgYmUNCj4gbmFtZWQg
aW4gc29tZSBjb25zaXN0ZW50IG1hbm5lciBhbmQgZG9jdW1lbnRlZCBhcyBzdWNoLg0KPiANCj4g
U28gSSBwcm9wb3NlOg0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3hsL2N4bG1lbS5oIGIv
ZHJpdmVycy9jeGwvY3hsbWVtLmgNCj4gaW5kZXggOTQ1MzFhZjAxOGY4Li45YzE4YjIyOWY2OWEg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY3hsL2N4bG1lbS5oDQo+ICsrKyBiL2RyaXZlcnMvY3hs
L2N4bG1lbS5oDQo+IEBAIC00ODEsOSArNDgxLDkgQEAgc3RydWN0IGN4bF9kY19yZWdpb25faW5m
byB7DQo+ICAgICogQGRjZF9jbWRzOiBMaXN0IG9mIERDRCBjb21tYW5kcyBpbXBsZW1lbnRlZCBi
eSBtZW1vcnkgZGV2aWNlDQo+ICAgICogQGVuYWJsZWRfY21kczogSGFyZHdhcmUgY29tbWFuZHMg
Zm91bmQgZW5hYmxlZCBpbiBDRUwuDQo+ICAgICogQGV4Y2x1c2l2ZV9jbWRzOiBDb21tYW5kcyB0
aGF0IGFyZSBrZXJuZWwtaW50ZXJuYWwgb25seQ0KPiAtICogQHRvdGFsX2J5dGVzOiBzdW0gb2Yg
YWxsIHBvc3NpYmxlIGNhcGFjaXRpZXMNCj4gLSAqIEBzdGF0aWNfY2FwOiBTdW0gb2Ygc3RhdGlj
IFJBTSBhbmQgUE1FTSBjYXBhY2l0aWVzDQo+IC0gKiBAZHluYW1pY19jYXA6IENvbXBsZXRlIERQ
QSByYW5nZSBvY2N1cGllZCBieSBEQyByZWdpb25zDQo+ICsgKiBAdG90YWxfYnl0ZXM6IGxlbmd0
aCBvZiBhbGwgcG9zc2libGUgY2FwYWNpdGllcw0KPiArICogQHN0YXRpY19ieXRlczogbGVuZ3Ro
IG9mIHBvc3NpYmxlIHN0YXRpYyBSQU0gYW5kIFBNRU0gcGFydGl0aW9ucw0KPiArICogQGR5bmFt
aWNfYnl0ZXM6IGxlbmd0aCBvZiBwb3NzaWJsZSBEQyBwYXJ0aXRpb25zIChEQyBSZWdpb25zKQ0K
PiAgICAqIEB2b2xhdGlsZV9vbmx5X2J5dGVzOiBoYXJkIHZvbGF0aWxlIGNhcGFjaXR5DQo+ICAg
ICogQHBlcnNpc3RlbnRfb25seV9ieXRlczogaGFyZCBwZXJzaXN0ZW50IGNhcGFjaXR5DQo+ICAg
ICogQHBhcnRpdGlvbl9hbGlnbl9ieXRlczogYWxpZ25tZW50IHNpemUgZm9yIHBhcnRpdGlvbi1h
YmxlIGNhcGFjaXR5DQo+IEBAIC01MTUsOCArNTE1LDggQEAgc3RydWN0IGN4bF9tZW1kZXZfc3Rh
dGUgew0KPiAgICAgICAgICBERUNMQVJFX0JJVE1BUChleGNsdXNpdmVfY21kcywgQ1hMX01FTV9D
T01NQU5EX0lEX01BWCk7DQo+IA0KPiAgICAgICAgICB1NjQgdG90YWxfYnl0ZXM7DQo+IC0gICAg
ICAgdTY0IHN0YXRpY19jYXA7DQo+IC0gICAgICAgdTY0IGR5bmFtaWNfY2FwOw0KPiArICAgICAg
IHU2NCBzdGF0aWNfYnl0ZXM7DQo+ICsgICAgICAgdTY0IGR5bmFtaWNfYnl0ZXM7DQo+ICAgICAg
ICAgIHU2NCB2b2xhdGlsZV9vbmx5X2J5dGVzOw0KPiAgICAgICAgICB1NjQgcGVyc2lzdGVudF9v
bmx5X2J5dGVzOw0KPiAgICAgICAgICB1NjQgcGFydGl0aW9uX2FsaWduX2J5dGVzOw0KDQpUaGF0
IGxvb2tzIGdvb2QuIE15IG1haW4gY29uY2VybiB3YXMgdGhhdCB0aGUgREMgcmVnaW9ucyBtYXkg
YmUgDQpzZXBhcmF0ZWQgYnkgZ2FwcyB0aGF0IHRha2UgdXAgcGFydCBvZiB0aGUgRFBBIHJhbmdl
IGJ1dCBpc24ndCBwYXJ0IG9mIA0KdGhlIHVzYWJsZSBjYXBhY2l0eS4gUHJlLURDRCwgdG90YWxf
Ynl0ZXMgd2FzIGluIGZhY3QgYWxsIHRoZSB1c2FibGUgDQpjYXBhY2l0eSBvZiB0aGUgZGV2aWNl
IGFzIHJlcG9ydGVkIGJ5IHRoZSBkZXZpY2UgaXRzZWxmLCBidXQgbm93IGl0IA0KaW5jbHVkZXMg
dGhlIHBvdGVudGlhbCBnYXBzIGJldHdlZW4gREMgcmVnaW9ucyBhcyB3ZWxsIGFzIHRoZSBwb3Rl
bnRpYWwgDQpnYXAgYmV0d2VlbiBzdGF0aWMgYW5kIGR5bmFtaWMgcmVnaW9ucy4NCg0KVGhhbmtz
LA0KSsO4cmdlbg==

