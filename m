Return-Path: <linux-btrfs+bounces-10277-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5A59EDEAB
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 06:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B69FB283893
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 05:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A45C1632CA;
	Thu, 12 Dec 2024 05:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oekOjups";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fjNbYmRN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3B613A244
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 05:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733979641; cv=fail; b=fmRXxa0c9rB+7BXj0Xr2/iyr/O/Er+W4BU0+RgRmk+r3Jg/kwNGfg3SVHoojDWpa9365l9k3yiBBjeFg3nNz98SLcLkWJuE6fQXOFSk4y5zH+SVBwAw526+WD1/wat+GsnFsNTQIcswPtkWMDzHlKOv/vUai1/+hNQDTu/yChic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733979641; c=relaxed/simple;
	bh=bjmdImfWx10AEI+Wt4Ko565TjkRZK78uAZE23QUwWOI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BW6SdMripp19kgnEzbNQrp4LXDbH9fmj143e2twOZBAhvKVvGef4FhlGKBnWpfsF87wE79sE2lH2h8FbkqYuhHPfDOQnzOvVQBON+9S3wOIvdwb9s4MCv/jsynSSGbyHd05+Mee/yjiyi5Fz9/uIkVKJRAY67wKfarV0WJvGSJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=oekOjups; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=fjNbYmRN; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733979638; x=1765515638;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bjmdImfWx10AEI+Wt4Ko565TjkRZK78uAZE23QUwWOI=;
  b=oekOjupsBD6mumCXfI+Kl7lE7aNDQcLzinf1d/Dgz2FNJQXF2OIVvDCH
   9qVpUu+gQ7YEe0QgcK1WXht80i3leP0H+0xUMHFwFaxMar4Jz7N9k6gJL
   kvCw4GeZwV1dqAlGpAQX9j+Lx6n+txIzGGYUkdwnWiPMqyyq32nGJZK+5
   XHsssRSAjSlUW0UlB7DIeQo4lhGFOOPPUk3me5870FWlyuffJeAvQFhfT
   5U1S3KLF+dtCYU+rbSsr2COG+qnXvuf6xGyPQk8JC/4piBK0P+hfNVFo3
   ScWVGD6Sde+DdDUYv38z1hoGMZRHXQKUGzKeKkA5KhZ8EzeGrC+RVe2kO
   Q==;
X-CSE-ConnectionGUID: +gdNQGRQQlW4pBXtTuQHFQ==
X-CSE-MsgGUID: +ll3n5CIR+OBJjrt8s/PJw==
X-IronPort-AV: E=Sophos;i="6.12,227,1728921600"; 
   d="scan'208";a="34687585"
Received: from mail-eastus2azlp17010021.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([40.93.12.21])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2024 12:59:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uiDw0I4wiFb7QkEVOtjsFkPLrLnwiZ5gmFA0T9zJdVeElBiUdzd/Iy3QeWn72cQwrE4onmF+9K56E3cQkx1QlV4fSq/fx1S3D2kx8m1in4gCZCN93PXYXQzTWM+yulOR+v66N3W4vZA4oxBdT0UQO+h9YM2b6g7Tpdcl79M128i0Bd9XHkVeV+e/Vo61mHQRzVolglU1kaUzJC4ByM69jvwcLx5TIdplwYmZeJHpso+ZyE5GJhqbBOCxHl5DeeEprdb24XlmDeQc2RFdzpWH7iXG8fieetSIA4VyCRASUIhRe/M7/4PHXawL7KerJIl3BffXDzMqlq+XiZ3wYlOxdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RdX3lLHTt5YNWQ7qYWxxhupXd3cC4Z1NmJGy2tCwao=;
 b=XcRh8UkYVaUO0VcoV8jgBbt/KIhKryOFKwl135ur89i64A+08EiZ4850lzhjgq/0UT65VM90a4gDaUm+mGpyZPpRnYPZlwZUdi0ZGhUbxl/BE/Ws//69QTOPdhT+8M/fGpBvylDTOzzNCpMcolwcYFQyetPGkBM0Buv3zRmsHaVSMU4RYzcOuO6L/84G/7lXA7SH+gUYWoF85pl/fXBkasPL1uxD0Axt7KzFC6J3Mp1zFwiaAWxAD8GcvFCCzmdKeU7tDjk36FM7JGU/a1v2lDHnJjzqxeBje3za/zRR7YohEp39icDYnvvC2cc36jEZGjalo4IjKdtPXi1HHeJPrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RdX3lLHTt5YNWQ7qYWxxhupXd3cC4Z1NmJGy2tCwao=;
 b=fjNbYmRNeUKn9/+PoVrdMUBV+B7G59JjZXTP1+DSoeqN/v1WBv1pDHtVKcFECGswDxbod6pndeQvP/MXBEOh7LxzAqxkP/NHZlB3qJ9NH8YMaRYKG2j8Er4OyzEnDQSq/vKGcfJb0IbDApKp3hsVhkcD/gtd0sOeD/RCEcuNtjQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH2PR04MB6677.namprd04.prod.outlook.com (2603:10b6:610:95::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15; Thu, 12 Dec 2024 04:59:27 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%5]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 04:59:27 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: hch <hch@lst.de>
CC: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: calculate max_zone_append_size properly on
 non-zoned setup
Thread-Topic: [PATCH] btrfs: zoned: calculate max_zone_append_size properly on
 non-zoned setup
Thread-Index: AQHbS33UyNgxf9upfUqpAIsBHjOykbLgkpqAgAF7pgA=
Date: Thu, 12 Dec 2024 04:59:27 +0000
Message-ID: <5ekbh62el3blxzyohzezz763v2sql7f372nzp2pyr5gpaq6kwo@a37neqm7uclu>
References:
 <9c00c066e9529f1a6439c1c8895a8f0d010a07e5.1733887702.git.naohiro.aota@wdc.com>
 <20241211062037.GB12285@lst.de>
In-Reply-To: <20241211062037.GB12285@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH2PR04MB6677:EE_
x-ms-office365-filtering-correlation-id: 985e0638-2e41-48d6-9dd2-08dd1a69c12e
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1tJgLRN/QERgZeUrUN35pF6koA0hwShtTEs8+rLzHU1ZCodrhXz57uBsKnVp?=
 =?us-ascii?Q?PJAzluUioWVDBW+llw+VIJ+ZukAxF6JcRLsCpemDBSmAHDg2746Uz0UJQqPX?=
 =?us-ascii?Q?bEAsgvLBb5hIJ8cc0ZokF1JM1i53e7mxnfZRuq8KOrXvN2VWdjxVidVucALk?=
 =?us-ascii?Q?I/NaNDe0ixQjBpUGdsB70YLlMzlVAm+i5qvio/imIfP9SyzP+h/+wy+/Xqxm?=
 =?us-ascii?Q?915Pv8jECxUTZwotYTeM2bXPXTK+ve98rYJ44ssyRSyxD0rMGFSwaQrAwHJs?=
 =?us-ascii?Q?hBK7nzLmqEOyy/U+w3SzjKtk5LoC44I+j4OsMP0/+UPFLC+qoUlPyt5Rl/qT?=
 =?us-ascii?Q?2tryrjE3LxqsL/KRsGc3ogEmAP/lcYdX42at/HyWrRRTBsgWJQMFJrUzHRlJ?=
 =?us-ascii?Q?mSGkyy/wQxE7kieH5flU0JfckFtxsP8o5vTnWCrhrmsqjY3PNAiHIyAki7Wi?=
 =?us-ascii?Q?uefSleRsHWApqrRzKbV+LY7rd8NTvkCzBqHUjgOeS5dmIAIDhIndWo3wawEA?=
 =?us-ascii?Q?/su+fpkqRQyXk3teJB+tM2YsXl/EK7lRcxJny4GvzeJGl/i9CPeJtNCupd0q?=
 =?us-ascii?Q?8sTBWlCiDtxM7jBaf0Hvek8DEzjAJARv+SnajlcyLSlxcFDovcZmquM6bTpe?=
 =?us-ascii?Q?qSJXVDsFFteYogZYtN+k9nAp4jxDGL6T6r/KiLwvzxkCyIWG6oeV4DD1xStg?=
 =?us-ascii?Q?4Qcvuopo2maQyLmYrWy9NonyUaNa9gO0aPWXw2XrpiBPA87XD5LJMy/tNb62?=
 =?us-ascii?Q?ESRs+8m7PYKOE2+qHeL0Ayi2KWe8B8IrvxCIVmf4KwHAtcuTPsQ9u4wEwzNL?=
 =?us-ascii?Q?OsXA71OfDAwd9PNMuZJ8j3lIAvneaLJhEYDaH1jVAMk0PvT0+v6Tx+cGlBHU?=
 =?us-ascii?Q?kJyMxfZW3qBSG8tfFw8pd61P5EdDGTacCOvpYBTOXrvWLEDJvYOPlBJe3kro?=
 =?us-ascii?Q?ai5Rks9HOJDsBmoYjKRJWZfSJmTsRD2SM4B30i0r8VnHsGahBaASx0x1atHc?=
 =?us-ascii?Q?hUBovnLht5k26pzP3+1xWAsnYvk1difrslEtmh4I9m5RZhNfKyFfY4S6iNgx?=
 =?us-ascii?Q?HLcdoJHGN5MC/NUtx/C+1lGax9qou1SePNjNl7US0uCDz9njxnoHZPgrPn++?=
 =?us-ascii?Q?y/rRYLdSglVRMOYWkYoZ4/ZjsYpJCbuc83XID3Jck3VjZTdKWsWkhFk5VJaQ?=
 =?us-ascii?Q?xbNAPX9dZq0VWw4+0rc1OX+Gvy93CNFEh4k3CmyQDThN4h7kVPB+VUwCNXQU?=
 =?us-ascii?Q?qPQ8PXIMnAPGmCQPqMy2C8IkMq6V/NifYzpKLmVHRf6pw6213IlmSvYRbubg?=
 =?us-ascii?Q?zf1AWd61ThPjS2i2XGO5hsx9tQt9UeKi1dn5Qhc4PxHgKuwrq19l5oH6JOCs?=
 =?us-ascii?Q?bdErSkBixDMPS3cXg7rEZmZfxhE/EwxSdh1P1Ngcjxgwf88MMw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2UUmHtLw/Opx7kcOSvgvW0R5NZ7KhTq7y/NEDnSna09S167T52clx7JzmEqo?=
 =?us-ascii?Q?QJyYCQgp73iznno0cDmaepg8U9Tijvlba6bnM6YVelC3tyOwFTFipAd1p634?=
 =?us-ascii?Q?YrIYDWAxcXSyXZ4rPV4nOHM9z5n+SPXLuBjFjjBt0hh9Bx3zx1MYiVz94Gbp?=
 =?us-ascii?Q?c8mrjkob7wxOLeCzzOGq8zriZKA2oBiCKvNhdpXEZ+2wOJCE85baLR63uEzg?=
 =?us-ascii?Q?vvw1hgiNzex0Rvo/rYb02UJNm6+lU1ntmy8vgvRSFWIFfA5O+MGflmXWAmc/?=
 =?us-ascii?Q?wyJHi3gpXGJXzBkUCoywVxZcoAWHGLlOMJ+zkJ9QKmWHZKu8ZGW54EgwCVJ5?=
 =?us-ascii?Q?EHdDICiUrCnMgivl3Mpw2mUKVK8xh4jJpqzlIMjyat3LdsQH0IVo+95sdnBc?=
 =?us-ascii?Q?/E9LytcLWvmUsFiWoC8P/Y6y99O1qtrgagWMFfRleCFmwrzJr4lEIP1M140U?=
 =?us-ascii?Q?p4ma+kRUV5uWmsEIESuIR53lglN/Hom4oIRcMesnIez9mBW6sG2GoY2umPO1?=
 =?us-ascii?Q?opXj80rddSFjiyF0GD3TTNgEaZVvJhJL9Xs2IPpZY1a2Y3T9q2uXHuM8Ktia?=
 =?us-ascii?Q?rlWHzoSE3UhXMe4M+fwEoeForc+0SeFWMaoXzdL1xthm3pG0o7JBNuD5LRCD?=
 =?us-ascii?Q?8xXCWAf4GjXI3JiThJc9ZHjrxLEPv0NKH9CLWsUMdmFwBHla76CoihWS1OBu?=
 =?us-ascii?Q?3ur+fapAnJWtGur0dzMc3aFgQSG0ze2HYKTm36gwJT6TuaDBc5lKNSKwLCPw?=
 =?us-ascii?Q?6o+MC81tJikGB5ddTRGKW/u3aF5jbOH80HL1C1O++oGIW7ys/c3ntzzUYIEf?=
 =?us-ascii?Q?SvPi2Ylr/AWwllZqH7JhQYyFmlNxbCk2+OYO0jj7ff1asfDzKtmKjhPIneAO?=
 =?us-ascii?Q?igspu6XddQWYwJQmFE4ypBFgdGp7FJUSAeAabdMHcRrY20ETdhW3YHt7JLgO?=
 =?us-ascii?Q?kkXfgrv8nQVuzbuP+UHG07RY4b+i8AEhT9L+tpLYokveWjXqX+hm6ZnOhuHX?=
 =?us-ascii?Q?zJ3T+1fb/i1Sfw/CQpcfMmYhWoSNo6MuZCG+Mldtir6lgMeVBcCgaYgOOvUJ?=
 =?us-ascii?Q?pcYqeMhddGID1UOOtQc9HEqkWSjZpn88TtA7LoUGt7QMJo7GQJTiymwYVBdo?=
 =?us-ascii?Q?pTCyneiqT89t2VSGE8YY1g4Q5cCwwxvP4BG+SquAjwrhaG4DWSw639ws4kUJ?=
 =?us-ascii?Q?dibZXsh8hZOfG1L51M4Rx1C14omYj2p+EKPPwvfCI2dSjd1tQX+U88ugb1Ex?=
 =?us-ascii?Q?jNeDlfJwTyLkjIcxh2Omft3zk8y88rFE8cO+IrH+/nQ5aGWXQJCz/MQ34oD+?=
 =?us-ascii?Q?/ZZlrEGTbkeT+/hx7239QXv5KQeTmbTJIlig8gT7vM29Lqzz+UhHz+vaPaLB?=
 =?us-ascii?Q?SnxIwYV1KkMOVomF1LAx4g9sq12AnZMcrcjz9UrY+TvZbNmX+ni0/6/K//19?=
 =?us-ascii?Q?lRF3y50WeGCmgPOxbNly0lT9KSXy0YOJ4+9jHZmR7Et5PTwA+DRkeXleK9p3?=
 =?us-ascii?Q?Av5pmVgzmRWPXIrOxE6qYxs4m4KEj2biOp0AlIPS7IEdg/Q8wUsyqoVaHZVi?=
 =?us-ascii?Q?CJqgumvDZWyc+k5bd93zm1N8JsQbWvFuR5wt4wmY3upRNJESM8IK1WvNcYrM?=
 =?us-ascii?Q?/egs+AP0JOXuwv+QNcriSag=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <87028EE8E20FC24E9C4B6A034DBF14E3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UlZZ+yfXMGJUJlF7/3vfYWrlvHEA+kSKf9qK4vZzVMYOICsroc9In82Oy0gLphMuV8CV2dcKKX1OWjjHu1rn6JTMWBCzDiwNcVQlwm2JMhEjIVE8IlOFX1XkFhsxN+k8H5tVNbHYGkDkMkyw8qhFOsL61Mg0xayNZRR3isa0T/UURL9N+CK0UxTwAsPxD4e5+Kfu+8nKDtZPKGgBs/INFBDgfM1kVovpHIOmiCPinIEnkXqLV+trq63ksg5vacu65NvOHcng6jLgmd2qvXqoLRJ/tYmfRKrZ7pNxnyqqGuoVNH6nhPfb7p1wbPXRt82K4fi1tqmiSpM5orHgsZtmavAizQapg1NOrMflirLLWVRH0HWZ45k0NX1DSoDfSfZ/MVXd665qBXeX0Z0msZScbwywC5wSOFkkL9bJIkzWQZtHTR535l9Sq+1VHVIUx5c96XiW+hv2S+1cn66P1tMY0LMWcGvc4hKAEVBcJ3ZOHuAL+f78k7O9MuWs+I+CYA7q8q85zkv08W2aQHwJEBWI/fcPpUPLYOa+PVm/q8thAsIdc+ZDqaUB833woqPbSZgTYxD84EgSKaNZhL257YMgiDfaXPqsumQU3z9k8+PCeb3HBAMKfoqm48fLxGivr/yF
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 985e0638-2e41-48d6-9dd2-08dd1a69c12e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 04:59:27.0999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: accS3N+2oJS9jX83BI4L3jJEpU7TzZqRkVT/4TDi1kXWkhU84d8+Lufh3QhnyHureSzC9+VV5qvE7aBHFpSb0yhys1MQqkR8VWSBxBFf/i8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6677

On Dec 11, 2024 / 07:20, Christoph Hellwig wrote:
> On Wed, Dec 11, 2024 at 12:36:00PM +0900, Naohiro Aota wrote:
> > Since commit 559218d43ec9 ("block: pre-calculate max_zone_append_sector=
s"),
> > queue_limits's max_zone_append_sectors is default to be 0 and it is onl=
y
> > updated when there is a zoned device. So, we have
> > lim->max_zone_append_sectors =3D 0 when there is no zoned device in the
> > filesystem.
>=20
> Which makes sense as zoned append isn't used on conventional devices.
>=20
> >=20
> > That leads to fs_info->max_zone_append_size and fs_info->max_extent_siz=
e to
> > be 0, which causes several errors. One example is the divide error as
>=20
> But max_extent_size =3D=3D 0 is a real problem.  Can you try the patch be=
low?
>=20
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 11ed523e528e..27f4472fb559 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -748,8 +748,9 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_i=
nfo)
>  		     (u64)lim->max_segments << PAGE_SHIFT),
>  		fs_info->sectorsize);
>  	fs_info->fs_devices->chunk_alloc_policy =3D BTRFS_CHUNK_ALLOC_ZONED;
> -	if (fs_info->max_zone_append_size < fs_info->max_extent_size)
> -		fs_info->max_extent_size =3D fs_info->max_zone_append_size;
> +
> +	fs_info->max_extent_size =3D min_not_zero(fs_info->max_extent_size,
> +			fs_info->max_zone_append_size);
> =20
>  	/*
>  	 * Check mount options here, because we might change fs_info->zoned

I tried this change instead of Naohiro's fix patch, and observed the btrfs/=
001
failure goes away. This change also looks good from problem fix point of vi=
ew.=

