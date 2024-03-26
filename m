Return-Path: <linux-btrfs+bounces-3594-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8234588C2F7
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 14:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C1230233C
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 13:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F0170CC2;
	Tue, 26 Mar 2024 13:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AhEtctjv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="O4qLn2Vn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BD528E8
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 13:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458320; cv=fail; b=FDk9UcFfF7e7hyaEUXC/oTHfyOUPgkKmjOH6OH+vmDgesyS+DnfBMo0heeBm815baQkCknrWNi6Hy2pqU7SpWnIlP9lIUuYdJuBed8zrKMGP+tu9FVoyj2wd/ONTROmbETaM4FDVUhMUvLaRdVW40iNkJvKHfju34JHrnNiz9as=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458320; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PP1RdJ6Zr+qo3VQfW13whVXQPvBEaf37jx7O4KAW/1xMsmg/3SLKmXXmyaVlvTg9D6YDgipVdhZMBZ4IOzOS2f8uWY5SPVz5V10x9wRdB3/icD/egZ4IbCnMwP1/RsyuGvbGOq8DTemmv/4f3hQPKQ/ZFFOciZ9HwPbInQyIsq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AhEtctjv; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=O4qLn2Vn; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1711458318; x=1742994318;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=AhEtctjve2pheb390Pe6aSosR8rNjCBAkeYenxcpRFDmyxSZ0ABHNs9G
   Xd31M29kP5F7Hg9MpnjYxotY8i8xlW7inCc3iBTeW/5fJ4rKdy7HGQxCP
   VzsKwZi5QVP/reBfImO/3H3GgkgF77N+vTcke/UDgV7a9NwcDucipEcO6
   2Y9ymHEyuXLIZaln4g97v3ctxDoHOVh3JwXqE+zooHkb2DH0NFN8En9Av
   R5s6bazs5YH+SC6kV3KiIwJdmBbz8RVRcwZnL13rQ4XqiN+/jEK6NMkKn
   aTvG7QysLFdGZlU8ZSRMyYX5/kD4fe205IpOrAcddDCSWcRsPCgi8YOg8
   g==;
X-CSE-ConnectionGUID: q7E7UyEySlmFH8ZlYj8nRQ==
X-CSE-MsgGUID: AVjeOKecSOSx9mokip9S3Q==
X-IronPort-AV: E=Sophos;i="6.07,156,1708358400"; 
   d="scan'208";a="12499048"
Received: from mail-bn1nam02lp2040.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.40])
  by ob1.hgst.iphmx.com with ESMTP; 26 Mar 2024 21:05:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X08ePhgw0QoOPITKJWj1BDM3OOFVEiYCnev93+6bI/25htsDCNR2/F60QdBh7LjXRQVq2TlS45Alzo4ZKT7H+qtBukoWTeM2As92uFCZlxN+s3fGpjdyambVReyPuPM0z4ObD/x1IOhmP/bK+AKwkRh878Rhkx2yMRtmk2+eHSsB5MR3CkM956019kTCsmpd5h0ROrBe4mcNDnxch8+Pdnjr0MZi1PPUQSXjKpPbYS2xqVen2j5P/YFrEQnAm8CbbxgiBjOPjGURhuGosHEywBOmuPgUmmska/OvlDbt4RnBpkBnfvcr35PRL9Z8DAD7I2/3a82vPPgKf5WBk4aPew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=H0v1RlYG7ea8wr21zpcmRKW3IG1bQ3AvF6FBHCJvaaIZ65wbDAhSHi+Rr991/oWkIrbGzkY3f0CpPPFM4DmhMC/oT3u9o9BAuzzDDot3vcZMhvo0NncvKq2j37pjkCRVCk5gdNnY5tAcbrk+YMV3nhXOzSN/QzfArv3jvv0E0gwLDU4jUI5lrnSPk6kYJQ/y7LaFhJxhAvC3VhpxlmP5iiU8VE3qTEqFi1Qk21gkNQrQIvbCv7gYEkoh4fS41FBZknh506yh2PJx6nXyBK1GpTtCvdKxNbHSVogYY3dL+z5YrdaYGZe1Ld5JRSVlT1PQbsj9oG7Gy8PwkYJJ9iTLBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=O4qLn2VnWN7Hmr7inbCPuLtrVl1lJWXdTOFmvqSpCH2/LZ79CY4K55P5ddzrmW6WX9RW2A2laDDvP/htWDOo80heaITdYjjqkg0Ntq38MLgXCrCg7b7jUax5fSfjb4OvYv5iZCQiVQvcKa9EG4vqPPhXVFCsY4iZT0UxOOJ1Qis=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB8148.namprd04.prod.outlook.com (2603:10b6:610:f0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 13:05:14 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a814:67f1:24ab:508e]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a814:67f1:24ab:508e%7]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 13:05:14 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: Julian Taylor <julian.taylor@1und1.de>, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] btrfs: do not wait for short bulk allocation
Thread-Topic: [PATCH v2] btrfs: do not wait for short bulk allocation
Thread-Index: AQHafwZsX1aQL/lJzkSs+aVu6oMFhrFJ/m2A
Date: Tue, 26 Mar 2024 13:05:13 +0000
Message-ID: <1920b128-18bf-49de-875a-a787df23b7a7@wdc.com>
References:
 <3484c7d6ad25872c59039702f4a7c08ae72771a2.1711406789.git.wqu@suse.com>
In-Reply-To:
 <3484c7d6ad25872c59039702f4a7c08ae72771a2.1711406789.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH0PR04MB8148:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Zk0O5VOOji+b3POjA/dcy/OdcrIRdfi46mt9JbmPyEZo4Muh8PkbcBA8c3jMDV4S0PgS7UhpL0clNZyRI67cYNvU7lf/v3y94RmDk0QLQc7Iemey0+vsJaiiy7SpiCpFanVNIB20DXY7DgLPeMsqn2p1m9a+ciHXZ6f6cnhEQuYSfO8BIvfalfTObthb+7QoVCCipn2MRMRYbtbJjIM4vz+T7MKHirN9kNnHtjQo47dp2lyHgkEbHDGYHUBBhoxv/HPHO69hRuYXiH1Qx6HOUedfqtp9KoqD5WxaJ/FtBzSxOD22BT862qzL+CskMS04Yz1oJdVagjcvFl1n5yecvHhkrrdSQe5L8y641FZ2WhjaPZ4w81OWPLlP1Nt0PdbD6fXIeLFZAcXoFk1GcRLD7ZgoiCvAxsK90+/+F28P5j4dzXvN6UHFUslWs2GzMtJ+EosNp5dls1p/iPPxDIlsKWHEzLXi+X4mNT85S1RTn0m39+ciZ0JfxQU8aO0qnPsz4HZr5MjDRzgRbbamkvV4FBkCt2OEbSf2AG4Ryf/BtSkV/U/T5afwTU5UBMmxWVHJpvYNvsb4hmcV4dah1mrqL9BV8mp3UMG3xCZ0RGiDx+mTzGva0gnmZflz1X/RMWSvdZudPOnI1g0kwGQ9Idr85GbeZ+ACyOLtLnU0qvu/KeM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Zi93WHNpTjNNalp6YUFmeHZpSy8xM0ttRkttcEhDZUpsZnlXam5tOVgyQzhq?=
 =?utf-8?B?ajY1SC9yVnlOcXQyS2RvSG9naEdSTEZLTE9UalBDakxGWXc4aGJIdUl2Y0VT?=
 =?utf-8?B?SHJsNXJKVWMwbWRPci9Zd2RWYjBKbis2Qk42LzRvK1JUaVZTWWVac1hFWllV?=
 =?utf-8?B?RFR4elRKdDBpVWd5dERVR3h5SmpwSnZLVmJMUmNHc3REaXU5NVZtcjJ1TFht?=
 =?utf-8?B?bCtOYzRCT2RjMEVPeWEvM3hwMFRuV2NrTzFGMUYrSk50YkcvRWN0eWJHbEF0?=
 =?utf-8?B?SjBlMVJ5S1lGT3RROVA3b2QrVDVsTlVieXVvR1l0REptR0JzbzNjeEswaEZP?=
 =?utf-8?B?dE9seXMvem5YQUV4ckJNQjN4MnlVTElSL1JHeHNqQUtid2RnYi9IK2dPOVda?=
 =?utf-8?B?TW8wekg5WTFsWUdFS1NlUTdkblVjZkhQc0pSdHp6azk2V0hwSnh2Z0NsSGFh?=
 =?utf-8?B?c1R0cTU3c3lBK0tKVUlHaW45OWRkMm0vZVJ6Q1RrS3Q4K3JldDJrWEFlRVVQ?=
 =?utf-8?B?VC80Z2RZTFhFcG1CTzJPZEtraUJLM1dWNEJoNHZwK2RFZXN0RmhaQno1c3V0?=
 =?utf-8?B?NkFTVEtYd2J6YW9NZkJ3Mkk5VmlRd1lVWnowQVMwWnIwOUhscFhOdEh0RCsr?=
 =?utf-8?B?elJGbUtMcnVaM3NlUHlOaFhxdUZscDZ1UCs1K3ZDczF0THBoZ283eHlVYi9C?=
 =?utf-8?B?WkNUaHMrTElRdjA1N0RoNDMxekxFbCsyeS9HK1VaamllcnZHYmxlTndLaDRJ?=
 =?utf-8?B?bXljbEhiUW5SSENacmdrUm1RYkdCbFZvbXU3VUswSjlycytDakplaGhZRU4y?=
 =?utf-8?B?ZWFPalN4RXE4NFM4cUI4dTRrQm1nc0dvQVB6TFdCMlU0Uk5vdExzcTNETkRM?=
 =?utf-8?B?OEJCdDE0TjRTb2VIV1dwZkkzcGYvZkpmdUFGSlo5YUd5djZFTmV2a1B3N2tu?=
 =?utf-8?B?RFgyeWhkQmJIeGdyVlZLd1FzaWdUb211VXliQ0x1T2N1aTJKd084eHpJKzVX?=
 =?utf-8?B?Y09QdHNTZ3JHTWlweHhzamV6WTYzcHdtNm56RWdpb3RDemhQeHRIVlZuV2tr?=
 =?utf-8?B?UlRsNDNuRC9iZEZRdnVxWWduREVGTVhVcS9kTTk0bEU2QlVSTHg4QUJ3TmRr?=
 =?utf-8?B?WitVVDBXOS9kb2xXQWQraTI1b0VjYk94T21JaXlWNEJuWEt5MWJ6WVlPaEtl?=
 =?utf-8?B?bDIxa0t6R2FtUEQ1Y1FBckc1SmI2OHU5TG9IMm5rN3hIMkluWWV1Nm9ScTVW?=
 =?utf-8?B?Zi9INmVqT0pwOGtKRWxxcDN5OXF5K2QvTVlGcHNDa2JqUjZnQlFXeDVTYXVz?=
 =?utf-8?B?dDg1VmVyQkxuY293K2FWMUo2aTNIWVdsNmI2QzRHbHRDUm5TdmlUYzFBcWdw?=
 =?utf-8?B?eGlqRUxDZjlWVVFvalFLSXFJcHVTVldabmtBV1pXRW1yazYra0l1ZEJiTlNv?=
 =?utf-8?B?SjdHNjQzU0p1bTMyaXFqR3JWZ3FCb2xCcmN3V2puMmo2dC9MNElXQkFrRERj?=
 =?utf-8?B?dkRicVhrUGJ6UkR1MGFEUUtqVnhGMVh6VkZzeHlqV1RIeWo1Umt4b1NWVjQr?=
 =?utf-8?B?RXdJcXRCc0NRa1U5eE1uSlBYTCtmaDUxUjJzbmtYTHZxRFBOWWxibWp0em9W?=
 =?utf-8?B?ZzhIbTBVRjk2NjBNNG5Rbk5vRTkwclExQWRlTWdoMzZTWGlJRGxMSW5MQllx?=
 =?utf-8?B?d3llWlNCRnY2TFlQTjFkSmNyc2xsOGpibitPK1RrTTZZd05YQkRYakF5a2Fa?=
 =?utf-8?B?VnZjTmUveFlqbTRYMEp3YXdBNVRsWmdldUNPNjByVmptNEl5T2hjT2dVdk5L?=
 =?utf-8?B?enFrY0tORTVKa1FwNzFJSkl1bkdnSWp5WGJzbFpZWC9ZN2kwendoOGMxK0dM?=
 =?utf-8?B?aStNQ1pHdWcrRWM4NDhqSW5HbERZNmI3aERSRi94Skt2Q3h3VU95QXNjY1pV?=
 =?utf-8?B?RHFoZmN2eWpQUWNXcU9GVmRTV29CdHl5ODJmWHlvUjdZYjZuU1g2U1ZMZlNQ?=
 =?utf-8?B?ZTcwRDJ6YlZVWUJlbHhQR056bkFUNVpJZmxUL3psNWtPa05YOWVPRXhtUkxP?=
 =?utf-8?B?b3kvQkpoSDFYQ1Fubk5XSFp1QmRVQm9zMUtucS9QdmxZVnFqcElYOEhKSTgv?=
 =?utf-8?B?aFlTcWNuazdXemdkMzgvV3VBWnVmNXFpelg0VDViNS9DMUt3eEFwNFpQWkJG?=
 =?utf-8?B?TXpTNUppa01LUTFTUWNMekdBU0lhSXcvZ1o0K29HZWFsNXZlU3BBaUZKUjJl?=
 =?utf-8?B?em1Cdm9LSjl5dmFxa2hPc3pZUkhnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F14D04BD304CF419F616D802615E92A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	R8Z2RrQoDm7/SE8FZjzDaSrC2fUGU08pkMQ649+7KNq9wqTw/ZC665ZyxifjJ59e4KmWhzH2iHDuStvL2fuu1QvChZVFuuk53nOKbu04s82UgYe70RhP0ypQy5yKVCmJj9GhJrWwmwrNRRtqQunU2vEsnQChjHKoM5jGIEEcz+X8vwTKtOjG85lFvd7gd4qArca4obXK6EqjR1VsjGWn4TNpvkZ5OZ843fF+7onwsc8KzVmbpAk3SrlLV7Bzs7F2w4VL/bPWhjP26MvhO7hJ+7HFY40ak9lHFgbTReH6bU86UEbk1Jl7sHXzJ5r/qDxqZ8vrJy2UR13C/28SgT/8A3jcKFvU0lOxG4xpyb3IPTAOWbk8ce0MlhjnKvP8TokkS2C8C36xaBNwuV3pxo2xn6hEkQEQ+SEph5oYvBO/rUhmVslm20Vh+akxT6xcxJPJqgMiZZUMuOE3SDR9BQkBkFIh7xtdIRbHqhdvmufDlPtNRgZAmUNhe9cwUnw8u6onOc9hM63DzK65D0ZFmic8yvEqwSQpAYNxH9tRVWTvn95YkvtAu9l584c8drgCEDfuI7VQ/NsBSzdoUum4X20wzt6BHRm9sx/LiyHYiaFIeMBUtH2Bljq4Z6zCNW7VJPHt
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 216f3209-5d65-469f-b394-08dc4d956041
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 13:05:13.9633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uYw4MjBKatVg1Bwz2ahb2dBo7UIBgo9fjBCFXmRCrnb+s5bV7vvE1VFe6DdE4a9ZKC2/L+fuQX9OPqC8HEvYDEjg2pRl3onHuEet58wML9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8148

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

