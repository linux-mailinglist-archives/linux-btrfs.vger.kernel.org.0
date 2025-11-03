Return-Path: <linux-btrfs+bounces-18571-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 46322C2C47A
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 14:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 459B94E6921
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 13:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E5D274B23;
	Mon,  3 Nov 2025 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PpkqAAQ9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wPHXW0qn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A9D26B75B;
	Mon,  3 Nov 2025 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762178201; cv=fail; b=pi6VIyyikdKh9Wcqkv71gSXKcWrVvX4bUnsv7e5ZxwJMTpdFu8mzpP2jU2isgleMrf4ASM943XNT2nxb1dg97zEUiknnEjfLxvEQIv2QCrVxQy1ld7PGVpn5wWrrtQTxmBurMucGKIdemmAM+WUcVfKIs0YtmYnIdqYq9Cz95qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762178201; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=udMfQ0AXmAhLfr8QzDPgEGX+/RhkYmbhku+2GbcwbLWoXedQcnDU+vAoSYQPZj1H3Vq/0FCV8rnE0nwhsOH66z4vQb3NyhHwVVRFby+0i8Dmm46nl55flmtmEZy8iQ06C2j3snGNq4X3XdIAIW+Gq1EHZoUFncOw8+02upIEToM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PpkqAAQ9; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=wPHXW0qn; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1762178199; x=1793714199;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=PpkqAAQ9YpJwyNrizvselXMS3/3zKUujNCYVWQOQdiFLFKS6C5zR2CDl
   fwj4bkQjgfjiXlO9RrlPk0xJ3WlDiDhfx26rTpEPFvxykpVFDnrokfR1P
   EK7KmiVj6GPm1LSvXE+JAFRQq+vbH4Z9Pp4aCCp3EDJ/AerFtkGFOiThV
   6+NKHDJZPFjXayRPKsScN1GU0FofdC9Wq8ZrBMm+oY9KFXZtWct+yj++R
   2jmz07nj6yI0klHrzrPkKUeb4gVHkw4YedbNXZwcSBJ37FmHyhjbduQk5
   KlteTbwPn3nDX8hsR6vVeV3XDkYilLHYZspA4gA8EAbvAIKhvphmK449m
   A==;
X-CSE-ConnectionGUID: YjAIxrheQfOi8NwJqbcj6w==
X-CSE-MsgGUID: STasZmiVTdi2fy6i8XVDwQ==
X-IronPort-AV: E=Sophos;i="6.19,276,1754928000"; 
   d="scan'208";a="131392192"
Received: from mail-southcentralusazon11011060.outbound.protection.outlook.com (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.60])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2025 21:56:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UAJ+cDsOTVErDEmeg5tDT3cjr57gTZByNOMLBEGmgSuFy/8B/gXetgrZoNNJXRmjzCbL/o6fPnsTuSRpDSV3b+8qX24s9ZOeIa/jgpbDTopIh1HLHtREheZ9p9HkeTemhrV0FvKVHafac6t3scFhtHnm+9qBos9SeKCjPt/s6o+fupHwScfe+pV+vkC2zRGjdHkh0PFQb5HkiVLv3RGpus1Nfq1tQ03oxpQTeCARna77/NHbpoMC3GHYpQfMxS8RMmTCJuV0GDAlBhPliFiI8aMMVQ33Tt3vfHcuv/DIG143tzsMrZWrApU/9BI4Ile45tSfDObyB8IsZ9JwbsN5Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=NB5yqrFmy/y9EN35WduLTaEY+6gmdREMGCbRLkSqieSLWzJI9vCK985BJdfSuTwc0f1lhYxw8QrIizuWj3hx+FGsmLZmmZNio8bbpPdoCQsjs7eQXmCbAi5kl/7VitwEYCnVa4syH+/WoAhIwOE9K+jmaJjtjG7nvASlCdmZxb9zT5lc+LlX0TI5yp+Om+ERbFaq57oZy83LzUSoHpmNnUeG5kzr8yHtQLgyX4XAaA495qsX7Bo7qsq/MIJW7twTBVipRbwhjuwVKI8cFIbYuJXWM6Iqrc8nBJMQD2J5aN86pjHLMp9ozO6bUbkFHWX5zWQDorQcc7zuZNlA59+pLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=wPHXW0qnyfpMIG/PZQjC5/kH9oBpKhU2qnioLB8HE3X1m7DFSClMEHwySHxQQJxgjJCosBwOHiDs8GFAj0RbB0IMO0v8+MDYgOEs+NqJ/PEGrTSjuG9JIGnpLq/8ILVF0FJNh3fLpXBGVHf9N7QkXTFRMOq+IbUxo2xilD45FFU=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SJ0PR04MB7773.namprd04.prod.outlook.com (2603:10b6:a03:302::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 13:56:35 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 13:56:35 +0000
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
Subject: Re: [PATCH v2 03/15] block: cleanup blkdev_report_zones()
Thread-Topic: [PATCH v2 03/15] block: cleanup blkdev_report_zones()
Thread-Index: AQHcTMbX7pBQOrsW3kGIyacGHBNRFLTg+ceA
Date: Mon, 3 Nov 2025 13:56:35 +0000
Message-ID: <87e9b8c6-09f8-4a28-b7a8-1f95c9301392@wdc.com>
References: <20251103133123.645038-1-dlemoal@kernel.org>
 <20251103133123.645038-4-dlemoal@kernel.org>
In-Reply-To: <20251103133123.645038-4-dlemoal@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|SJ0PR04MB7773:EE_
x-ms-office365-filtering-correlation-id: 926aa6c9-f7b5-450e-b17f-08de1ae0cd98
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|19092799006|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?aitBNFB0L29ibnFyYS9NRTFwRWtXS2VMY3Vrbk9jVlhoMmlWMFFWZW1sSzVX?=
 =?utf-8?B?L2E1U2RoQTFuV1Rwb0R3SWp4dEZSdU9OQlBLK0p4ekpTRHJSTWkzZzV2Y1h3?=
 =?utf-8?B?NEh5TlRrd3h1Y0I2Z0hrUXBGMFYydFZObUVnMkxLcndnbDRuT0psTVowZ1VO?=
 =?utf-8?B?djBTa0pRWExoK2tGQTVkM0kyd0syU0ZEOTVZNmkvTUl5aFpXWnJ4QlFMdnFC?=
 =?utf-8?B?OWZNTnBiSVZBNDU2bUtUdmFQNE1FeThvRXFMYjF3aWhVU2lBSm1wcEZzaHdV?=
 =?utf-8?B?QTZyOXJuVVYzWXFBVG1VYVAvcXd1QmFTZno2cnl3bWZOVjdvaVoxZkpXRUpk?=
 =?utf-8?B?aC80RWF6KzlvY0s3V0ZlUWlIYjc4T0lIR0pXK0ppbktuN0pRbC8yOFN0aWNY?=
 =?utf-8?B?WHlKVkdMdVpONnZGTllleXpvY3VvUnZjUmFiR3R1MzljMWRHRE9kL2xsbmlR?=
 =?utf-8?B?eVpOZG1pMDVqZXJ3ckVvdUU5eWVvcmRVQXdjVVJFT0FCUmVVRXk4THZKNnRu?=
 =?utf-8?B?bFpKZTYrS1liS1BFMllDZ1BRQjRyRTRoZmFGdEtxdWZJUERjOUhEVU00QmFX?=
 =?utf-8?B?ZGI0SitQVnk2UFp3TEZmSGFtdlNGZm9SMWFtcm1KeWc2V1NwNS91U0tjbWh6?=
 =?utf-8?B?NlBZQlFxYmdjSC8valBnYnNjaHZBRXZBSkFBczdVODJsYmZ3SmdKM2xRSTBL?=
 =?utf-8?B?OUdyTkhnS3JKNXNPZ3N4djBwOGE0RmJ0Z3NkMHZFdTJiMEFralhIcUJnbTc5?=
 =?utf-8?B?UnBYY2pZaGJSL2x4Vmd0ZXYyZDlNMmM2WlNIQVgyQUhQbnI5NTdQbG9kdDJn?=
 =?utf-8?B?SDRNNWVWVThoV2VsTEFnT3dvSUZSUmtJdGtsajRoNTF6MlRuaXVPaXc4cDJC?=
 =?utf-8?B?QU5xd1gvRkkvTW41bUZYd1ArVTFvVTQ5NEpsbUpJZGQzRWt3bmRmaGFMbVNC?=
 =?utf-8?B?dUVYMnI3WGM1SEdHMXR3dDROTDMxWmNTK3lHc3JVcXc3MlBvcGNkNmgzV1hu?=
 =?utf-8?B?QjI0Y2RTWGxMQW1EaEtuaWlTZEMwSjRNTTBKV041akduK1A0eUtVSmo5NjZG?=
 =?utf-8?B?NTl2RXdjUXhIdUxnVkRIV3pRRGZXQjBrZkFxRENnM2tjU2sya2lwZUpOTmxi?=
 =?utf-8?B?TzRhOE5ycmw3TGpvYlhPWGFsS3RoMUxlc1c2UUcrKy9rOStpSXJ5a0Zvcy91?=
 =?utf-8?B?RzdCTzhLVHhMRDByS2huOCtwRDFMNTYyRXlNZFRzR2VYajJsUm1YNFZtaTdQ?=
 =?utf-8?B?QmpkZ2RKcjRUdWxHeHpLK1g1dExidG03NS9RRDBxOVhMczJzZjhHN1dVdDVy?=
 =?utf-8?B?c0hQbVJwK05rTXdyLytjQXRBOXo3RmkyNFZpRFFjRnN0WXFwczR5N2ZPSFpY?=
 =?utf-8?B?Z0JneXQ4anhqdnU5MkxEQmhNQjJTek10T3BvcWNlNmZSUXRZbEdESlNWZlhD?=
 =?utf-8?B?SEp1NlZ6aEt4WG40MFlqU3dVZWUzU0k2OXpRVmNpRFJWbGJmeVRReEVtVmhG?=
 =?utf-8?B?RzBwMlhhVm5MdjdDOUtROE9DV005OGZhRUd4ZEh1YVVQTzJhWGE1UmVJRTd0?=
 =?utf-8?B?U0Ywdit1dkxOOG03d3FBTCtyUXFFUFY2ZXcrQ3lvZGtoUldQUEpVMCs2d1Zu?=
 =?utf-8?B?ZTIzYlRuWTlidkpuZjRuYytlUlFxSENoMlpzNlRSOTNjMElwSDEyUk45dFhx?=
 =?utf-8?B?U3dwZmR4TDVvOENOaTN1UXJPc0FuQVB5YmE2TVdubU0zK2Y3QUF6TTRYeCtE?=
 =?utf-8?B?Z1JLeDk0SmxKNHVqN05WTEV4cFNZYmdId2FEcUlwRHdxMDVEMWp6RGU0Ny9h?=
 =?utf-8?B?Y0d0TkpET08zcmdpSEd3T21kU3kvdlJrZW5XRVV5c29wZVk4OVNSQlBhRERH?=
 =?utf-8?B?V09WL1ZlWjFuejNzQkd5UUYvZ2t4dnJTajF6NUw4YXFkMkZ0SFFEWGtNV3dp?=
 =?utf-8?B?cjJtUm43eEN0ZWhsQWtTeTNSSEJaT1B5bVplTjlZVEx4S2wzZ3FuRG43WUhP?=
 =?utf-8?B?L0V1RlBRSDRUVjVJaCtneFplc1c4UmUyNVIyOEg5eGRZZzcweDkzK1NQcVBP?=
 =?utf-8?B?blJqLzd2SmlUcjlYYTdGN3BFUStDQkwzTXRIZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(19092799006)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aEcrZXh4cENzSnpWME1iVFJJbVV2dzZkNk1zQ2lwMjEwcVpaUi9jNHlCc3hp?=
 =?utf-8?B?Z0VtbXQxMmdCMFVtZi9GcC9mKzJwdEtpNmZaNDFzNmhNb0hXSCtlTEFJMno4?=
 =?utf-8?B?bHNKV01VTi80R21hMTN5Z2JDZTU4K1RtdThXa3dCcGNqMDRDSCs0NktBSlhV?=
 =?utf-8?B?eXJFdERFL1JjNmREKzV5ZUFKaXc4bjN2WFFhM210Zzd2MitmeWkrY3U2bTJZ?=
 =?utf-8?B?eTRwc2pjeDYxNHVTeU5EZUl0ZGJJc3NXZDdRa1hhdkUxQWxHVkdRdEU4Uzk1?=
 =?utf-8?B?ay80QW1aMjN0VTZ0VURINnprUENkWVZrUzFNSjBsMWI4YURSQ2ZQdXdFWGgv?=
 =?utf-8?B?YnZHZk8xV1RkbmNEbFdrRE1YbXNHSFNkSnN0TnlFMEp6Y29DdFh3eXJOZy9C?=
 =?utf-8?B?a2YwdGMwaEJvODNGbm5IUjFpZkJXN3YvY1N4dWRUWkwwd01qdVVzK2JWNzRL?=
 =?utf-8?B?UWF0MExYMHFsS2hIYU5mRmxnUDJvTW9FZlJXSUR1QzJmRjl3YmIwTkQ0clli?=
 =?utf-8?B?NXp4bHZnQjNsYVBFSU5jWHhIV0NRcDlicDFVVmRwcnVzU1VqU3RHZGEvS09U?=
 =?utf-8?B?Nks3eFo5dzVhNW5QVkpmMHFiWmVWTHQvOVloQUZHdTVJWmlXc0xid0hnOUpG?=
 =?utf-8?B?YzUyY0QwakFOTlo1ajg4T2xsbjVpMkpqdVJhYTlWK2Zxd1czcTNJZ0Q2d3pE?=
 =?utf-8?B?R2ZHcTRaVTQrNTJ1VE9ERkxlNFkyWS95bEg0OW90aytlY1lOWC9uZnFUNlBi?=
 =?utf-8?B?UXRVYjJjNVpoWnhxTlFhdmYwZjdSZlBEd2FGc3R5SUV3ZkRDcGxMVE1aWkdX?=
 =?utf-8?B?UkxnYnZhOW8yWFNNcWFVVEZoMXJKbkNxUm1sTkxLbEtsVXN1SloyTlY4bkYx?=
 =?utf-8?B?S0ZqY0lrdTNtcjhYWFdEbnFnbStHUTBvTXp0dGFvVGx3UmUzbzAyWnJIRDd6?=
 =?utf-8?B?ajc4dDVRUVc2b2VXRDJoVWNjZFhrcjhSdkhaanZpd1hYOGcrc2g3ZjJ2VS9h?=
 =?utf-8?B?aVA0TkFEU3o5RkF0Zzd4UW9SREUydm5GQllTeU9UYURqN3N2WEQxTWlnR2ds?=
 =?utf-8?B?S2FZRDJ3N09ubmZhbllOcVFKZHBIMERHYkY0Z3U1WG93bDFxRnNnSmdzOUU1?=
 =?utf-8?B?VlBLelZJNjg3YXFlVXhoZVluN1UzU0hYNmVGR3dRWlgwY0owME55WE1HUW12?=
 =?utf-8?B?K00vSVZiWUsvNkdEa0dWYlEralNVM3dRMnAzdFowalh3Vk9QVTN3YmtYNFIw?=
 =?utf-8?B?bGNHSFRaODRJaEhuck10V0ZrbXRaRlQyK0hhd3ZOYlVmQVptdTRhUThMMVAy?=
 =?utf-8?B?cXZqZjRJNGRLK3J3VnBUN2VmZmVXaDNOanFpMDRkVEZxL0hCdUxqZ0ZVU0lJ?=
 =?utf-8?B?TmNGZzhxd1UrNytBNVFpN3pOV0VEZUdYYi9uLzdvVWVrSTZGQjJac1NKbkFn?=
 =?utf-8?B?YnpyUGFMUVpCT2ZnK2QwQU5qZU9TcExGWS94MmF3RnJneTdZT011UDdVcmYx?=
 =?utf-8?B?bzRRUW5PWEtHbDVLT0twNnpiT1RBTTZFS0FkSDVpbjd2WG9EalpkdWgzekpM?=
 =?utf-8?B?cndsajB2Z3pVUk54ZVBoRThyWGN5R01TcS94bmFQaEs1MVlaYUV2ZlNWU0M2?=
 =?utf-8?B?NUh1SnJlU2JDcDBiYnFHM0U4dTJ6Y29VeXpTcU1mbk9yeE84ekovSFhMNnJx?=
 =?utf-8?B?Q2hyRE9kSU5RUEUzZmJPMUlGUFZESS9NMmt1RndDMzFBd01tc3ZGYW9vRGRq?=
 =?utf-8?B?MU9jQTVHcW90MFFyc1JEMDB2aTl0cUJXQXMyWUFMV0VjMUFRNE9qYkp5S2FU?=
 =?utf-8?B?TUlnbmExeVBkMmlmWWg2NnVTTEZ2QjVzV3JEcXFsMkFodjNCVUF0YS9aTkJF?=
 =?utf-8?B?MDd0V2kxU3RqRmFqUGpJM2VzNnF2N0cyRS9ndTNqSjJhQkI3TmxrN05KdTdE?=
 =?utf-8?B?YjVpY0d2Qkcrcnkwa3ZwSlJ0UllHSWxrWkJaY2lIWWt2MTdGbEVEU3VTWHF0?=
 =?utf-8?B?d1dFcEhCTUtqM2ZDQkRPQkdnVlRRelFIUC9qelNhZFJJUXh5QjgwK2ZkMFcr?=
 =?utf-8?B?THV1dDJMTHZkbzF1TWJOMFJ2OFRNVytUZDVieDBpYk1nZUlTaUs5MGZ5aUJq?=
 =?utf-8?B?S3VwMnk2QUdMRDhtcEJ1eGZWd1hDYXF5Q0RWWVVsTkJwaGRmbU1PZmxURDFw?=
 =?utf-8?B?aGhHWjhadnRDdkRWTEI4QWJyNzFYRFZDdjZaeUlhL1hSdnRucjlCcVRIdUps?=
 =?utf-8?B?eTNKTjBvd0EzQUphTTZDYmwxbkNBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55EFD298C6239A4A95C69ABB8DF37E27@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6LGjLbGAJD25+xIzEkg0kfIRiLnyY3X+M2GVFc1FieKzD00M8bH1A+ejDJVaiorH0t9p6FG8sjZ50E/m6R3oJkSXhmrjdCRUP/WVtRdNLQfYpnyHZS/hVEsYkOGnKgwLkp6EnWZXDRA0CEJU6oug1PWdXqct5TjJdGpj2GAydsG/VopqaPUhJuhJ4WsvoJuru9ym5Gk2mLsPkyZU6cLK/utqSEQpvoxSSUB/GbhCKRxNbFgU12PvP58nKUZuWe18uUv5fqCIFGzGbiiYyyZ/n7FXFt9EoZG7kC0GSzQAQtQas45HjP5g6ARK1TwMGPsDt3s1t0usp/Rtm9MPC9LaU9KyqUH05DqMVCW1eY1/pxSZuFWT66aQLtlrWINpEGcn4KZpERRVIqr19Gl6/P8W0YlSjqnEu5wReBioqsK5rMuTPbiiCm/6xPou/THyp/NLLN77ke1Ursd9oIar4PI8gSQYyl70YLZu0r9Qy+ecZdxQCMl/PnZ+atJ8JHMhjjvJ48ala+8avRNz9JntBsbMWdaFg+eXcht6TJv5TCdMCm0zoJ2r43Vo8yp7YV8Pqs4wXkbwgPpYQQ7xXtvrgG2eq7Oc11DXjVED6ynzGY65Y8LHUf4XRnIPunkRbtsbCF0G
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 926aa6c9-f7b5-450e-b17f-08de1ae0cd98
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 13:56:35.7149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Pd2ZF0rIAdL3g5RUNmxFcICnfC+zbkB76kJJ+p3vLsAf6bUPVHOA0XKDVO6VyhYPBrrdX+m1H3dQPVVizM4KwDeFs+4BV87Fo9daUhifmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7773

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

