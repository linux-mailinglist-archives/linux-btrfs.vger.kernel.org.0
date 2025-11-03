Return-Path: <linux-btrfs+bounces-18581-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC63C2CD32
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 16:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36935189D806
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 15:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA82324B22;
	Mon,  3 Nov 2025 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IY/QK/K9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="w9KCbNmp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26034322755;
	Mon,  3 Nov 2025 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183624; cv=fail; b=F25Qz+Ngv3tU+IO1sw7v0/vqnWqUAa9hTYdPSZdUD+7E27GXyFaOvjDjMLn0QvHRacKtpPhp7kpKe13yqodQfR4WZoMyqJpHoCC2lyEapDi92TKlTjs5M1NWu2oyA9aCTW2XFt2v4FpUL4jBqd6voQS37uW9UZLk6/8cXLAN/Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183624; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ecCja5JvFSTlVQnHpEUDnkmGcW4xZYCwQTbjCqffKZ7QbVknS7W6K9T1L6R6zN5NFU1hxyUtaWOzzncWsptTyWGOR9PehqusQ7LswFDMzBJBYg3C2xDhTQZnnPDBPVL3zRBWWiPAWbPc7sZAD3FRn0xQPtY/djrQRAP5378xdt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=IY/QK/K9; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=w9KCbNmp; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762183623; x=1793719623;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=IY/QK/K9KQj+mzR20My+JfhnyBwX9IfkhdxTDJMY7gTUzwwJiuSSJMLR
   297uHP2y0p4Kt23kaPm3kZ4pBPE3D/MifsJ0Dmy1Dp2NOOA8zRUPb2vdV
   toKrqHcHO1PRhtNmyK89le941RbrVVp1XXfLNbL0cUjMsEW6xoBWxcLJB
   2Z+BjSUpoykxJCj27KFBx2zKH6ID+4D9WaoIPpUfYpbGUpw9zwM/2o8lM
   9JB/9ngoy2Oy1AWFIpbH4990dtPamx8K8TrFtkyLK0c2y1flsOkWGEJ4Y
   7M1ERMWKVG5J8R2LpL04mvDTX/7d4xLCzchbab1RotjBYIe0hBZkBzZVa
   w==;
X-CSE-ConnectionGUID: CjSQDYh3Qo67DFdbPRWAww==
X-CSE-MsgGUID: E9KndF8dSO+OwsiU7EWClA==
X-IronPort-AV: E=Sophos;i="6.19,276,1754928000"; 
   d="scan'208";a="135347761"
Received: from mail-southcentralusazon11012022.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.22])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2025 23:27:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oB3/y55TRSd1svuFwh3KqnIFBfCNgld8Ms+21+FtzcTt0wmylBizNkwvjIKhCuBvUioJ8vx+mDHCs0ERsnWIlc/yXzavUD6WstN8bEr2j4WJhcV7qa0jZyGkVvPWA8v0d/9eiICAZY3Ly3EKcPqcY75/SYD19R9AJdavloiZcARK8fJp4D9YiGqgEJWI9J3GmS89DPk6LzXxXYBBZnq5DDOiZBjsDaPaEvy4rBFEyo795OvAajtGkpnsOCgAE2nYpiAxKAqYUJK6buGzrieB0sJ+GBFci8x52XmR1Z+qulvLf6ZOg0E6+h/YAgqJyxtPVzV5Gp0chN8r8e8xbqQ1hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=UqiMe5a4pvrDDzYe7qHPMPTOTV0RKlpxzCDO4lm4dMVNPjpmEKs6uRtftGTrsEMxNjBVuB7K66rlbHS0YYhl93z6SrbEoANyMXh9CJmxQbFn3+TCtcR1HOo4qCT4zA5eNEO9FIyB+2vY0siao+4am/26PHuu0q8JTTEek3OJOtNGeOKBhxCvm1q24XoHfn6thIeCBz+e8j8ReT/Bu8iRM+wVOwzzcOBkQVlMdiWcvP0W72raLsxJ0HsaAo3XDoAVw5x2DnevhNDyiOwActdHaKxzn9zFZwu5rrN39Jx5bgNdbbiFfkzbA5k/gdDS7QL96AX+RIfIInCcG744TTyQZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=w9KCbNmpvO8KN4gVU6903EkhnxT6d819fv2sU6nImzO93umrbaFXjH2bGE7o96VbrZ97/7Nj/82YMXTi5xKF1mLYDEjKSNWeXqqkYNyztivcQf9BhzMsQeo0NgXHDQU0vLmeID5qkpIlXem8v12RRlLs87Rbd4orvF9KC3I3C5Y=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by CO6PR04MB8428.namprd04.prod.outlook.com (2603:10b6:303:147::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 15:26:52 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 15:26:51 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <keith.busch@wdc.com>, hch <hch@lst.de>, "dm-devel@lists.linux.dev"
	<dm-devel@lists.linux.dev>, Mike Snitzer <snitzer@kernel.org>, Mikulas
 Patocka <mpatocka@redhat.com>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>, Carlos Maiolino <cem@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, David Sterba
	<dsterba@suse.com>
Subject: Re: [PATCH v2 14/15] btrfs: use blkdev_report_zones_cached()
Thread-Topic: [PATCH v2 14/15] btrfs: use blkdev_report_zones_cached()
Thread-Index: AQHcTMdMC9BiKQ9h6ECcJVpHQ6ElrLThEv+A
Date: Mon, 3 Nov 2025 15:26:51 +0000
Message-ID: <adbedb62-a5f5-4b41-a40c-9f02d67df60b@wdc.com>
References: <20251103133123.645038-1-dlemoal@kernel.org>
 <20251103133123.645038-15-dlemoal@kernel.org>
In-Reply-To: <20251103133123.645038-15-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|CO6PR04MB8428:EE_
x-ms-office365-filtering-correlation-id: bf099e82-2d26-4a1c-1f4b-08de1aed69e5
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|19092799006|366016|376014|7416014|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?cTRqOTlET2lTR25WUktMYnV5ZjBBVUNiTmhyMGtpbDlyZWNPY3JvYUJTdzlD?=
 =?utf-8?B?R01nWUV0ajVMcDRBTzNxSTlhU09GWlNlOWJkM3RtaWRvRTV2TTRaLzZPWGd1?=
 =?utf-8?B?bUxjYTZLRTl3ckpuSUZrMGQ0SE8vbGozL2d6UFMvNUVwNXJlV2E0aHVlZlRZ?=
 =?utf-8?B?dllNTG16YzZlemVHS1o5cG9qRlZGWDFqaVp6UHh2Z0ZLdjMrTFZDS1NnSTFB?=
 =?utf-8?B?V2NFWjcrS3J6YjN5QXVid3djYVJTMmozamlXK0NHZ0Y5eXRJYm13ZGlTUU1X?=
 =?utf-8?B?RGtYTUFUV25jRWk1SEpTOGdpdURJQ0V5LytjN2lwTStGWDdXdEhrVG94cEhW?=
 =?utf-8?B?RW9JSE44YnFYRmhsblovV0szdUVaOVdUU3ZLSy85NThLTVBZaDFMQ3NSMkxN?=
 =?utf-8?B?a2VjS241U2FDbFVGVndEZjhFUG9VajVFOUhBMWx2c2NvaVBFRGJuUUxRNk5N?=
 =?utf-8?B?TFZISk00cWw5dDFxQU4vOUVEaDdETVRkNjBDUzVWWXlHaXJESUt5NGZLUmtZ?=
 =?utf-8?B?c3NRY1lTMEN0QUNZRm1uQVdBa3RIbXF0WUxYZzZYSmJtMTY0MXB0VDBiYUtR?=
 =?utf-8?B?ZTB4YS9WZXZ6ekJiVHVUWHd3MzFQRGxmcHROTlByeEUxVElXOUNoUnIwUlFV?=
 =?utf-8?B?VW1HZGJBRjk4V2Y3THRpOG0wLzVLUVJsUFhiWXJxemlOSGdMQWxGK21DSzhW?=
 =?utf-8?B?UUF1VDIxUTd6Vm95N2cvcmxFcW1pRG1nZjJwaGxGZGs2emZnQ0thV3pzVG5T?=
 =?utf-8?B?dUU1NnJ6ZU8vRjN0K0ZaOTF5VTVodEZLak9ZYTIzNC8wMHJablJnQkEwdk9h?=
 =?utf-8?B?RGRxSFZ0K2ZPSEpJVFNOekVZeFFQQXMrUW5mdFNaeHkwYTUvYk9EckEvSW5y?=
 =?utf-8?B?YnkwaXVqM0pNZTZIVDhlL01iOHhEcFFSd2VYQ0pRSTVEMlMwdjlxcTRSNEoy?=
 =?utf-8?B?SEN3UVE4YUtQVldQNXg4KzFRaGdEeEh4aDE1TjFobDA2cGxHWGRVWDdVRnFS?=
 =?utf-8?B?OG9UWkxCTUtZOTlSZ0ZqLzhRVXY1MFdUUncyaWFqeHhEaC9LaHhGUlljWWw2?=
 =?utf-8?B?ZXkvRkVqb243UWxrNWtVcTdaa3QxdzlyMG0yeGM5MUROcjU0enBVYUFPTS8w?=
 =?utf-8?B?VnB2c1h4OGx3bXJqY292VFl3cklGdklxazJlQk50a1hONk8zNGkyZU5JRzNl?=
 =?utf-8?B?ZG5xbngvTHRvaENPMTBmbWFyamI3bHF4M2NUdDFWQytXMS9LKzgyTUliWTRa?=
 =?utf-8?B?bkhvMzJINVlQeDRDY2hvaXluZWpWY1BrdXZEQWpoUmZoMDdieUZxMkFHZ3dQ?=
 =?utf-8?B?VElFY3FnS3MzMkM3ZlByMndFMTBvMjRhOU56Ym9tK3ovMWErN3A1YjdkaVl6?=
 =?utf-8?B?aWZPbUx6V21pSzVLRjN6V3gvbWlxbS8zRW40czk2VVJVbTArYVN1NmtBOTE5?=
 =?utf-8?B?UW1lUUY5c2ZFSlMvR0lsYU1udExSL0VWczdXWVVMZXdCVkU0Q2xRT2cwcHFh?=
 =?utf-8?B?Q0ZRbWdEaEd2S2RYUDR3ODlBYmwvUUgrUkVjSWxQVTFVdlhoY0NpWGV3NGZj?=
 =?utf-8?B?SDA0TG9lekF0Q2NwUGpvL0ZSQ3FySldVM3hUZkRIL3Z1a2pURnJwdmprZGI0?=
 =?utf-8?B?cEx6OFN0bld3YnlUSFRHQk9DZnlKOGZFWUo5TmUycDlpUTRYV0NTbTYzVWZy?=
 =?utf-8?B?U3RvQyt3YkRMTWJjRUhMUUV4WnNKeGNuMlhFZlVCM09GY2Y3cFYxOVh3MGox?=
 =?utf-8?B?N2s1SVJ6Tmh0VFZORVRVRVFBK3g2aEo2MjliTGxSYU9UN0ZtbUlnN2dvUWZV?=
 =?utf-8?B?WU13R2NYTWkvTTgzRmlNZ1NqTlREM0tIeWdmM1d5cmFxTlkyUTgrYU5kMnpL?=
 =?utf-8?B?dXdyeEZZV0VIQnVsRDhYVDlHUm5XQXlrV2NnMllOc3M0ZXFDcURYZUJtZGhP?=
 =?utf-8?B?MGUveXVrQWRXNDF1WjY3UEJJYmVkeGhnKytEZXNUOW5DWkdHeTlZMjFYQ3JN?=
 =?utf-8?B?c1dGYnhXa0VFMktUQ0xQZElkVEYyQ09ld2xJbXZIZ0NYdlFqNVdxamhQWHk1?=
 =?utf-8?B?ZmJlVHJDUG9wY0JkOWxFUVFEeXJYWGRDNXpNdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(19092799006)(366016)(376014)(7416014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TjRKdUlTZUNseXF5RmQ4TXZla3Q4Qzdnai90TlBDV25zTkZBcnlzaXVtWit2?=
 =?utf-8?B?VHk0eDYxVkl1TWg3cmdOMXVkK3dtOE5qZEVuWGRLYzhRVkxvY3o3OHRSY3FO?=
 =?utf-8?B?Qm8ycW9TVi9sZW9QZ3o4RURxc3R3ZDZxc2FKTWEvZitYdXJZS2IrVy9nN0xT?=
 =?utf-8?B?ckIwaVR4ODNFbVZaU0s4L2V4UnRyMkV4OVBsUCtNR1c4UDFPbDgvZGtnRXhx?=
 =?utf-8?B?L0ZTWVVWa3pMOUhPOUxmbUNzeit2ekNwTG9MTVpDU0xtL3hmSE9MMTk2amp0?=
 =?utf-8?B?bUdPZjVNNVR1OTN5aXJ5QWRpUjZGNjU1R0xwVUx4d2REcld6ckFYTVllVndQ?=
 =?utf-8?B?cGNSUlhlRnB1OXRLZWV5RE1aSktxWlhPV0YxNDc2UllzVU9YWjhRZ214aTU5?=
 =?utf-8?B?WXIvZVhpajBCc2o2TStQWHMyYjkvenR3d3plQU01YkRFTUY2Yi9JamRRVnZp?=
 =?utf-8?B?MkJ2YnlYUk1KOFJJVC9sWHdjQU16NHcrVmFxVVRFVFNteSt6Z0pUb3dFaHgx?=
 =?utf-8?B?UEQyaHhWSDk1bHEzWTc5QUl5YUIyU3d1VElnaVFMaEJYdk1oQS9KbjFPYzFu?=
 =?utf-8?B?Ukw0ekFCWnBwckVMSTljOUljbE1qalZNaXpCdXpDOTB5eG8rZDk5a09MbW8y?=
 =?utf-8?B?RndXYzl3ZG44SFlpVGZvMlNpek1kOGVqQTNoNFY4VHlXdHhDNmN2Q0J6enQr?=
 =?utf-8?B?Z2U4dGRvRlNQNURDR1NnZVRCVzRCYURtOUR0TzRHVktncUhPNCt2SWZJd1l2?=
 =?utf-8?B?YmVHa0dTTU5YKzhSd3Y4WDNudlMzR3pjNDBjM1gxelQvZ0Z5OVJ5QzdxK3J2?=
 =?utf-8?B?QzZOQzNYZUdVUCs4ZU9iTTBqTEZ6d0prTXlESlAyeWtqdjNuTGpjWW0yTkdU?=
 =?utf-8?B?Nng2NHZ5RHFFci9NWkd4MUwxb2NaeDdmUjdqei9NYnYxNTZnQmdCeUI1QVJG?=
 =?utf-8?B?amh2eHVpNDJuT1IyN1ZYUDVCRk0yemliaWVnWUdXMEpFSFFTZDRlYXA2M2RE?=
 =?utf-8?B?ajFScDJNeGpCazZjZW0ra1QvTUE4U2lBVnh3THdleUZtMlVMRlc5OXhzaGlp?=
 =?utf-8?B?MDNudzVENEJIMytjcTB3Z05iZytVVnM3c0ZsUE53WU4xSkdNVTBDSkdzWFNz?=
 =?utf-8?B?S3FkOU45RkF0YS9lSmc2V2xUckd3TUMyYytOYzhuanhlbDhlV2hOU2k2VXdP?=
 =?utf-8?B?TGxnL09iUGJxNW1jV1UwMkk2WkJrU0pIMml1Mzg5SXJiVUdmajJ4UFd5eEV0?=
 =?utf-8?B?ZVlQVUNCWDRObHoyOVVVSDZVTDlMSStyQ0QwS29RdzhkL3BMYmtxKzcrK0ty?=
 =?utf-8?B?YjFqMmtJV1lObTkxWGlVUmdLdWlzdGNDZ1ptMzhPV0xYYUIzMjVCZU1LL3hm?=
 =?utf-8?B?aUNGMzhEQ2lOaXNMOVN5MjdHMWFYdjdGbE9YeXdmWnQxcFllWFg4cUlVdE0w?=
 =?utf-8?B?NCt1aWRFcldWdy9jTnZ2b2wwRis5MVRBb1NocGRaRUNQZytYOGpkd0VEK0dp?=
 =?utf-8?B?ekNVUENvT0xFZXpKLzZiU25SbzNseGIxb0t1MmlKb096RmVQYW9TcWhKVFY2?=
 =?utf-8?B?dW8yV240a2xWa3laS0dzdmRCeG56dFVuS2kxWmRJelhaaDBMbGN5bkorUTh5?=
 =?utf-8?B?ZHQ1WnNadnpkMW5tWFp1SFpRVHFaRnpYSWVlQ1hUYnFteDdmd0xhY2lkdi8x?=
 =?utf-8?B?ZnpRNnJvRm8xakhGVW42ZDlmMUNQdlY4dno3WFNRangwN0ltSGpQU0VoUUp4?=
 =?utf-8?B?eTRLeXNKNC9xTnVvWjlrRHNOUE43VDJyeFo4aUhnSFNRWlVtSnNqWkhQcUg4?=
 =?utf-8?B?c2wxTWRzOEZWTzJNOThLSjc1WXR2UDhDZFJGZG9zUmJ4RzB0RVRGK1U1SGNy?=
 =?utf-8?B?TE16aU4ySGUrSmJnbUJVNmtkaEVLSm5CdDdlSXY3TVlwaDlHd080NVdWWW9W?=
 =?utf-8?B?NkpnWjhFOWg1MFVtNTFRM3l3dExiMHlMYXluZWJSV2taemNqRnprditmbGNU?=
 =?utf-8?B?QTJJQURrNm13ZStVVzl5YWUwT1N0ODQ1WkgvaFZYaXZFcER4OUVOdFUxSkEr?=
 =?utf-8?B?VlJrQWJvV3VXRFNxR0NlODJnOVNVcFlIUExvQ2d3UnF3QjVsZmtHRjlFcnZ5?=
 =?utf-8?B?SVBHd1psQnBsTGZVU3c4cmhRd0gxSklpWlh6dkcwRk5HRXdnRjNWUEN2UEhV?=
 =?utf-8?B?dU5NeFNzYWUvZ0ZGMGorVE1XY0Nod0M3bDBLSW55eGk2NFFSUEtCWUdHVGYw?=
 =?utf-8?B?ei9wajl3WmNOcnMvdklJR25IU2d3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4DAECF5F30685745B125619146FB7B85@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	26gRbY7aFSIYfNfkYgr/jRAtz9cbV46cDATpqgx1sKKJiHLD5C9A3bhz1xxiA756OYsYlCiUmmZBa+NMc2+RPVQiVH63MiMsfo0iQSyUJRThQOOYQ+rP9Xrkm+I6Hpv3KIa4Wo55r+SBQea3hTxzypTvhlkdU2vvGvkOI7qMfddk0fFVnf4OkoHFPcexlpT+V5zav2F6WtnnadNOmRC+Qh/9WksenZeXMi9q0aIJecQdPLcNwtncglEpwc4IBwbjLtbs3P/fWQ9AHQTFQMPjZ7nq293ZO26drhdmoOpyiF10cwxYi9rRuUSC6ud4fX7MTVST58/iHewu7nqJeW52W1xszUKd0xYB3oFnUBzgdzlW48Cp/+LcYEllHpEd1ucfbdnSxQulMzusH2xgQrMIFYvmjxSGS93UZX5YxCJTw3yn3xBeWGEDtKmKJrPD0XtJU2+4oIBPTqzFsXsGSl/MVwTYIMzKmDL9uadVxuMFbQdjZhpuc4Bk8Cnbgqqb4AdywDNiO/AXgXP3SfFZV2PKPJ268idAXeVn56ms996hrzdCaWa1CJjyiGedHAT3ntsi/giQdC+i9PN/ZbNXs76w7UhdeYHUiYSPTq8j6N0dWTFWMm1iWfC0E294Js7IJT0j
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf099e82-2d26-4a1c-1f4b-08de1aed69e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 15:26:51.9317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +L/V6k7OcsWw97PM60G9b85v15L4BlGRehx92hOD58AKirL17lbbr3rvFDj4whZGt2d0evxQGpL54LvDpXXYsGUvSOV+j4VFcI50lAHsJZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8428

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

