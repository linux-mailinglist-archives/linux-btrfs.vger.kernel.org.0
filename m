Return-Path: <linux-btrfs+bounces-19528-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7D5CA4D81
	for <lists+linux-btrfs@lfdr.de>; Thu, 04 Dec 2025 19:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31C35305059D
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Dec 2025 18:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B9D350D7A;
	Thu,  4 Dec 2025 18:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cDL+7zzh";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bHv+y1YZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B17EDDAB
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Dec 2025 18:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764871475; cv=fail; b=LXel5hwdNWZl9KqbAKmq8MbDzl4sg06C3XKuwPuDY6xNRsuR9+xaCca5liNE2gXnxqIIWeJ3q4NISjJ3lIZ4lRt0wE9zUj/UnDvSNawZSABbqRMHoj35dvU+a/MRSnof18TgrdT995lruuKYpFjyJgRIi7RKtvi/wOEwkKmuMac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764871475; c=relaxed/simple;
	bh=Q31tenjbDtqVAUaWMSg9HHsio82NKFDVJsJjP8IQroI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uWx+nDOHoluadDUaWFIQ+iS87r0o/Jk8mBQw/bepUtcTixcIzIfrwdJrAuPm2LYXeYRpeBsgItYwkcWVQ0cAeS/V8kwGFPcOcWo/dlkPWtDC2z2rwVOy+L2V0/39Lxr00aawbUZqGD5+LgjnOw2ZaOBMu6L1GBz6ZgbtZLTiS40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cDL+7zzh; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=bHv+y1YZ; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764871473; x=1796407473;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Q31tenjbDtqVAUaWMSg9HHsio82NKFDVJsJjP8IQroI=;
  b=cDL+7zzho2WoVV0qW1L9nHO8NczGoMytdiWiZKGYlf1W2twwjBAUpaUA
   GD+pbhh8Z7Up6YHFGyEwZRDNOt2kjQDYAterkl0KvJSvIhJXRIoG1L4Lv
   aC9tsGI+FYLRFa6+XWaugheAuYmS2drXtwi3Vm2T4A1GxxJwnOmJb7Aiw
   o/MgXZbyL9+d4KcfdQQBg5rC+qsOyOXW9gaeBA8kTkPFZ+/7psE6/XBlW
   Fy4INeq2TzDh69WK33YUwidTU3anFm77O9G1je5QP0faVqrsHG/YoGL04
   MIKObPt9YjigkDAtL56whtBbywQogv9kYUx+5eL0F58DL6GI0lrlJYuQs
   Q==;
X-CSE-ConnectionGUID: KopOEgqfQwm9cRfX3BFdPw==
X-CSE-MsgGUID: 1G5RVDFORuGW17Jn48dNKA==
X-IronPort-AV: E=Sophos;i="6.20,249,1758556800"; 
   d="scan'208";a="136347147"
Received: from mail-centralusazon11011049.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.49])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2025 02:04:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxnba2b9Eld0vUjl2bqms6LHVlahHPMzppnpaTlJL/JFb1nOaJddGnpHxlChaZsM5KOcup1n8uvy/ojaOE0xV9Oaf76NPAcMqhlibCaTDtv1BBUBTIEmorVOg9diGDktOoMKESMCtnXJhZDyjrY1Y+QVkMtjfoCFU/92hXzGIHJMbjssMBQorMHRgLvV5B3DVYzQ65To0pbeY+Ftu0kiZ4IzD86TbPqGbOxQqPQT3bA+SF8YleEZmmhCPAgHZsm+h6wcwdnN/TJkNjvvti3UuH6orV7oNKEckuf2SDe93EcaQ5eBeWJVXnAI13NBEZxF8+toe3U/urcLmMUx2xwRJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q31tenjbDtqVAUaWMSg9HHsio82NKFDVJsJjP8IQroI=;
 b=i4wuCsvQ1fGVeBo/P0t+Yey0tO411tVPzQLBWnMf+6oCFBc5loV2ihy8CatJcBrUv7igjQjb9TPiYF/9FG39WI+eYw2ce/0INTyuxz3HZB6iOSFBnS59v+MQ2SYTU2sMwIwWo7t0KVXfOp/2FnHXWjqZ0IcXDRyRqQUc7ioV9HlAXL2H9z2Mal9Sjy1A417l0U+G1J3MZv97qjFeRo2qfheYOO2FnbPDXePOKh6f83LidfCRQsXB+yiPJ9Oyb50FMdoN7iRESSWpdQRpqUDHHdXN284H4Ca53AFNKmMG9Nq1c4ICugf/aJ3yd3dwODhKxb/djrCGDc5+qFhJFFGdCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q31tenjbDtqVAUaWMSg9HHsio82NKFDVJsJjP8IQroI=;
 b=bHv+y1YZAZBbqxwoKtW53W3Y6hTfU6O9c5toiyECpXkwWChOp0//NsHC8HVo6yFbnQBCXnfKbDFO+pi+JrnGXbyNwp5D14P+RbZpzsK/WO5OjZRziZ31FeEaAB649UbZqjiVey/mPvSQSdF8McA0+IIaGwTDuNAUTO0E9uMMHX0=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by SJ2PR04MB8510.namprd04.prod.outlook.com (2603:10b6:a03:4fb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.15; Thu, 4 Dec
 2025 18:04:28 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 18:04:28 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, hch
	<hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>, WenRuo Qu <wqu@suse.com>
Subject: Re: [PATCH v3 2/5] btrfs: move btrfs_bio::csum_search_commit_root
 into flags
Thread-Topic: [PATCH v3 2/5] btrfs: move btrfs_bio::csum_search_commit_root
 into flags
Thread-Index: AQHcZRt6NJ0sNq33702Fpi2BYGH0b7URegqAgABMmoA=
Date: Thu, 4 Dec 2025 18:04:28 +0000
Message-ID: <4f4c35f9-bffe-43fd-9a7f-1669e0a14608@wdc.com>
References: <20251204124227.431678-1-johannes.thumshirn@wdc.com>
 <20251204124227.431678-3-johannes.thumshirn@wdc.com>
 <CAL3q7H7rB-WghdPAOjJmoKhV+e6ftj=3DK+aDdGnjBRjUHcPZg@mail.gmail.com>
In-Reply-To:
 <CAL3q7H7rB-WghdPAOjJmoKhV+e6ftj=3DK+aDdGnjBRjUHcPZg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|SJ2PR04MB8510:EE_
x-ms-office365-filtering-correlation-id: 17f43b58-b598-45ab-4d54-08de335f9104
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|10070799003|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TXJUMDk1eU1hdW5sN0FvK0Izc1V4ZEtraGMxOWJCeTFKU1pGcXZPSGFUdm0x?=
 =?utf-8?B?NldmZFhaZ0c0TmdSVU1YbXFWV1k2TjI1dnpWR3FZdU15TTBXYnJ0MGlETjBL?=
 =?utf-8?B?SXpESkVvait0UHBEVk9iVXladm1sUHhnWk1sSEpqNFMybjUrc3NxN09Jc1oy?=
 =?utf-8?B?dXo3N3dwRndsS09saUJVeHVDMXhFWlltQ2ZpWDRjUlRXWXdMRVk3K2VnV0lU?=
 =?utf-8?B?ZWZpclRsWUcrMmt0T0VvSmNBc3FGWmdCSjFrN3FxS3Y2ZHNmY1VrYTFiNWNX?=
 =?utf-8?B?Q0VMSWpVY2JWbG5BdFMrOVlMOXRJQU5xeVdyYzR5RlFZOFRBeXVrN081U1Fz?=
 =?utf-8?B?bFk2ZDU5NjhHWGc1RVJ3TlJieVNYWUQ2TlMzL1ZXRDJXakhtMkdtZk9NWlZW?=
 =?utf-8?B?MnpWNTRPNW5jZ3ZBWEJsVzlXMGpMUEZVVEJEWHhON3RmSTYwRGI3aXZCZGZl?=
 =?utf-8?B?ekdWK2J6ZGR6bC9waUxwZW8zdGg2cDZ0Nkl0aW5iWjkyNDhkb3ROVHAyakNM?=
 =?utf-8?B?cFE3dk5Zc0hSZG5Idk0zNE9kMFk1SG1GY3o4UDJPSkEvbG0xVVNxNEJkKzdH?=
 =?utf-8?B?NjV4bEtOaTdGdkQ0ZFhKSm5mc25FeDNwMnlUQTNKVVd4citNMlZ2Vkt3TW9V?=
 =?utf-8?B?aHNWRGxDTkNuVCtWRUxyekpvbld1ZkFVbkRBRTVWaUpzeTdrYWRxcDVCVWho?=
 =?utf-8?B?bFFKV2djM29vZ1crVHovcVNkSFNpa25OT2VycUlyWTgydHVlNUtmMiszYUdj?=
 =?utf-8?B?UUF5aW5FakNIMmdZSTBFS3J0VDNNcGlvRTRWYW8vZTRJVThFRVNDbk81akNy?=
 =?utf-8?B?cVpIZnpjWFIwTDE3K1JZRHk0U0pYZFEvRTJHQTdjcW43Rnh5SXRxWWovNVdk?=
 =?utf-8?B?QUg5Q1Uza0hLeWhvSndJWkdIQUFXTDM2YUwyVGpOVTFMWU5kZ01TV05QNVo2?=
 =?utf-8?B?eDVjbnY4ckV5YVpqN3BtcERWc3djaitvam9LRzZnaHNhajZpQU9NSm1ETkdZ?=
 =?utf-8?B?ZWx5T05SWG5hTkk4RTVFSjl2Mzh3T0NZSnBWSWEzdDJVdTJNTHZ3bjV6RWd6?=
 =?utf-8?B?OGFkQThRSjBqNTJUSldGOXhkUUZYNDlDbUtyUVVYcHdtTVFMNmwxUkhaa3V3?=
 =?utf-8?B?Y3VoNnhuLzR3MmppN0RpamIvcHFmSnBDTG4vaW9XU1QzVVZIV04wRndkRFJl?=
 =?utf-8?B?U2pVR25kYmNIV3RpSkJlYUdiTHdEaTRmVVBvVnBZb2x4RElCVUhRV1MvSXF4?=
 =?utf-8?B?RU9ydXp1Zk03UjBOVFNweXhMYnhUclJ3eG5OblZ3ejFjVGhkMFE3T1g1YlZZ?=
 =?utf-8?B?bmtwZDJ5T0NhcklyeVkyemdNRWNxMENFaEhmOVltWXZ6R0xhR1dIL0Rqbmdr?=
 =?utf-8?B?SStxbUM3TGNsZndERlFQelRxMW9UOTdleml4RlpvWXhLeERGdURxMHUvS1F0?=
 =?utf-8?B?MXRoSmUvZWdmVlJIYlJKb0ppb3NUMXNjTnI5RHZUTGd3V2VhamY2Z1dIVURM?=
 =?utf-8?B?bzgvVHEvdEVMM0M4aFJ5NU9rNmNHM2paYThsb0w4cnBtL3Vwb2dHTnhnV0NN?=
 =?utf-8?B?Q21DVFZ0WmhjSzlnRnRrdTl4aDRRUVN4ZXhVa3BEZXhWNjB2YjViM25LaTVk?=
 =?utf-8?B?UnM2YWJ6VExWNDFuc3FFMmpTSUV0Vk84bTRBT0ZHM1A5RStNU3Vrdjd6S1ZU?=
 =?utf-8?B?cU0vWU8vaUN5Nm55eHMzbWxTNFBJU0tmUTlndUFBZlFTZm9uL29ua3dtZUJu?=
 =?utf-8?B?eXMwaGtXVEtRSFVkQkdKSmZuOGl6MkEydlFYL2ZpZXE1VUZHV0VrSVNGb2dp?=
 =?utf-8?B?dnNpTE5vcDZER0wwbmg3d3ZzNDk1ZWpkMWxRcEZ1ZkgxWlVSSWdxN2d4S2ht?=
 =?utf-8?B?WGVZMEN4RlM5Ymd0WWdJSjlOVmJBcmdIMzRXMUIyV3lHakhVVkpsa0NTUlBU?=
 =?utf-8?B?QURZTVhwVWovb0hVZkVqTko0cTQ4STR3Z3JHQnJTcndTYVgzK2xyWFBraG1T?=
 =?utf-8?B?UEN1UHZlWW9uN0h0K01wdnlyRGNjS0FqK0FOYXNPUzI4QmtnU25TcXcxNlhO?=
 =?utf-8?Q?fKzYKf?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SER6T3Vkb3NmQXc2eTdpSUlPbmJVeHg2SGhaVzJSWTFkRnc0RFVhZUg0aGhC?=
 =?utf-8?B?Sk9CNjZNY2JEeGl6YzBSb2NkUTFIbFBRS0RnUDcwWXMvc2ZtRjBuNTc1TG1r?=
 =?utf-8?B?Tnp6Z081NHJTbGpSelpQRGRpa2RJL0RMZ2FmVTh6N2VWbmJ5a2ZQYmlEN0d4?=
 =?utf-8?B?REtoNXN4MG82YUVpeC95M3cwT3JuT2pObnRyOUdqcWNhdmxLSS83QnZTeHhn?=
 =?utf-8?B?aFFaUnNTOXNPcXY0cjA3N2RKb0k4V0I2dm1zQTNPajQ0cjkxT3Q0UFRsYUdP?=
 =?utf-8?B?T0N0OXBRVTlBK1lOM084MmplR0Zob1JTVXI5UHkyUlFyeDh1eURqK0tLdFdr?=
 =?utf-8?B?bjJZdS9sKzlTeFZvdm1aYzMzRjNCb3ZjOU9FZ0s2YmVJZ1FoRmtnakJiVUh4?=
 =?utf-8?B?aUdCeldhcytLSzkvR2RSNXA4eW54ZkU3OU5GM3cvV3NDVmVaUU5pSkRXdEZU?=
 =?utf-8?B?Wm5DS1FkRnNHTWlOT2JUNkRHU2tmN1dFLzUwQmN0UlBtRU1OR0lwd2pRM0tO?=
 =?utf-8?B?R3NEYXk1TE5FbWpwcXNKSVQ0WkY4TFBBOFBnTWpiTkMxbHloM3NyUFJxTU90?=
 =?utf-8?B?UXlzc29ONWQ1eWRYbVVQd0hlTnBaWjlQNHhWTWdyMFZ3MVRrdXNaY2VCVStS?=
 =?utf-8?B?aUJWc2pqZ0ZoT2N1V0c4SGRVeDVENzhrY0V1RmRkbkpHN1pWbmFheFR4NDZE?=
 =?utf-8?B?YU80c2ZDaVd4TG5EWVQ0bklVUTh6QWRodCtyK1dsamlsQ0xZZVpwTXFMaG1B?=
 =?utf-8?B?TWxYaHo0cElZMmpMRWlBOEk5bmJNSXFyelRIc1lOMXYxZ2FRUjBUM0xScElS?=
 =?utf-8?B?TGNUaXNDbDI1MmpBUWQyYkdickdCYTFLQ3RxZ3IxZnJOV1Fqclg5cEg5SzFo?=
 =?utf-8?B?cjhMaW1FOThpMWVRcVM2WERjQlhxMVc5VHhuMXgwWCsxOGJ4NDhCZ3lWZ0dK?=
 =?utf-8?B?S3VFU0tCUTJlbXhIdVQ1UXdqN2xBb0xEU1M4OEdqNGxnWldnLy9JaVE5dDRx?=
 =?utf-8?B?VGh6a3hiQkRwbWdxNENFSk1vY2NkYUNSZWZodm8wTmNva1JYcGdyeGgwWEJI?=
 =?utf-8?B?eTVZNjVFM1RncWFhL2t2ZElKdEJVYjVmR1hwd2J6Y1crQWpWNG1kcUdaVXph?=
 =?utf-8?B?UXBLMEZkMW1STXFiRW9neVkrNndSb1lLYVdrTU94enhCbW0vMHdXQUFnYlQ5?=
 =?utf-8?B?Q0pRc3RUSWhOcXlnSlRiWkhHclkybjVHQnN5NS9xR1pqZk02YjJkb0g0dU9K?=
 =?utf-8?B?djYwWGErVlFOSUFWZUdmYmIyb1o3UnovdkJZMUFmWHI4NWVzYTdQWEhKTk5t?=
 =?utf-8?B?d3VybW5ycStsRThRMW9SUDhJT1hWeGZzeS9WYTNIS2VMbERGYjZCT3J0RWYx?=
 =?utf-8?B?YW9rNXZDOWhaNFhtLzROdFhlRUZCOGdNOWg1bkRMQit6dmtWT3lCRE5vUTFU?=
 =?utf-8?B?UzRxVTI4TnI1T3o3TFg3QkhPeEloalJsQmJ1S1RTekVxUjhhNG1SNDBVbjhH?=
 =?utf-8?B?Y0M3SEtXeFBDTnQ4emxTVXllbWZRVytNNURKUUFYaGExSENNbzdmczRuaFM4?=
 =?utf-8?B?R0dVYUhueWNFUXMvVlNwdnRCaXFYNTVyaksyL00rdlE4djlYWE9RWHFZbDVT?=
 =?utf-8?B?R3lXNERCREphSHpEYW5nN0gzcWliZTM4ZUtQUFlCT2RMOThLdG8vVU1sdkJY?=
 =?utf-8?B?Z2NVdDdKYjRraHl4N0VhQTd2aEwvTWNEN3BPYXJDVzZDTVVBNkFBQklxZTl2?=
 =?utf-8?B?eVJGTUkybWZ4S0hWQnNVN0dKVzUxOUMwSGhFSHFIUHZtTGhXY21HK1IwR0xN?=
 =?utf-8?B?K3hCdFo3a0JqaVZzUitFVzk1S0h4R1dUbFdjVDRvZ2lyTnVINHZveldZaVRY?=
 =?utf-8?B?YVpoaUpkTWpMaTU5aDZvRngxNWlyTURlU0xneHBVdHNTNVBhdHQ4RzNLcXRS?=
 =?utf-8?B?ZGhia1IrT0ZTRkVxejgzZ0J3UVRYZmRrWkhKWEFwYzkwMEZFNGZETi9tUlFH?=
 =?utf-8?B?eTJUcnQxVVpENlRQUFNTYW9ibXJ3aGxINWhGWTRUZDN5dmdKZGw1VU9Eb3JG?=
 =?utf-8?B?ayt0dWFKRVlOUWdGczlqSlZsVExVQWRhR0dMcStLQ2liN3ZoZVhVVDJRWlpm?=
 =?utf-8?B?Y2dnNEdxek9lbW4ySVczQVRYZkpYdUQxaEtRN001eGVWdzBpaGdGRXNNdC81?=
 =?utf-8?B?M2NRdHdjZjVFTTZTY1RpeTNuTENOTUl6THFQOEJNUjZuKzkxdUNzQitvRXh4?=
 =?utf-8?B?RXoxYUVGLzUxaXlpdUhkY2F6MEFRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9983B495E2ECCA44BC72B1E0E11DA958@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	t2VZstPx4L6gKAwBXpdRr6kViHhVMkhpNZ4XXqXRSrK0qkCdMx+7NRR63d4voPmORja0aSoTkDtYdwJlYvhkCGT6ZH6SoA1dnrt1jKtAxozotDaSFC4m1+6Q7Yw1Xd1H7ysL44rF+MMjWXbqY0RTFbfVzftPqODQ/XQiMflW0jmjq9yYL3L51BweKunROFHmlqjRUTPiA9G4EqD6HPhYJi0ot5fb4mb0HpBcM/tDorowrVD3ahGAvA9v2KBxCh8RuuFAPRsmW5MQSvE5ljx+k3YBAdXbiuYoeLTzmHq9w87NkvJm6R+HzX7PLCtHuQbDN++rk3GdGYGGyfhmbl/6ibivraYTmwMG95uAoWJ/WnjFO7M2KoOiITyb+rfN1JIXCxkCHuA64ihMcug5FaMqjK26A+Yk4hnRg3ckmbNkKrQrnSCObdKlsODluPWExYRTnyR7EANGDEKG15eG3CPOjKdsTyIwjBjSdfNt6EbCzEDpiQZfzsqrpZBs0Wf00Lk4exP1NGLYxoJP/AvJadsfhBNBdU62p/gfbwOeGDoYrVKb0idE6dr8SdgTQ/hIDkdDYEEDkCm8TyjGRaRPM6TxOCf+q174+kWri63I1lLLKPN7yH47tjE0j9Y9cpL4ZYn4
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f43b58-b598-45ab-4d54-08de335f9104
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2025 18:04:28.0683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rD81hP+xdfOb8QRdyXWKaIkXqktUE79YPxb4ptZsFyFSfxsTj272Kw7+80xwdzgsC/12AVRzO14vtG3EmK1Ro8yGsvic4x+E5wwLO6i7JLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8510

T24gMTIvNC8yNSAyOjMxIFBNLCBGaWxpcGUgTWFuYW5hIHdyb3RlOg0KPiBBbHNvLCB3aGF0J3Mg
dGhlIG1vdGl2YXRpb24gZm9yIHRoaXMgYW5kIHRoZSBvdGhlciBzaW1pbGFyIHBhdGNoZXM/DQo+
IERvZXMgaXQgcmVkdWNlIHRoZSBzaXplIG9mIHRoZSBzdHJ1Y3R1cmU/IElmIHNvLCBwbGVhc2Ug
bWVudGlvbiBpdCBpbg0KPiB0aGUgY2hhbmdlbG9nIGFuZCB3aGF0IGFyZSB0aGUgb2xkIGFuZCBu
ZXcgc2l6ZXMuDQoNCkl0IGRvZXNuJ3Qgc28gSSBkaWRuJ3QgZmVlbCB0aGUgbmVlZCB0byBkb2N1
bWVudCBpdC4gQXMgZm9yIHRoZSANCm1vdGl2YXRpb24sIGJvdGggUXUgYW5kIG1lIGhhZCB0aGUg
aWRlYSB0byBjb2xsYXBzZSB0aGUgYm9vbGVhbnMgaW50byBhIA0KZmxhZ3MgZmllbGQgYXMgYSBy
ZXNwb25zZSB0byANCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWJ0cmZzLzIwMjUxMjA0
MDkyNjQ5LkdCMTk4NjZAbHN0LmRlDQoNClRoYXQgd2FzIHRoZSB3aG9sZSByZWFzb24gZm9yIHRo
aXMgZXhlcmNpc2UuIEkgb25seSByZWFsbHkgY2FyZSBhYm91dCANCjEvNSBvZiB0aGlzIHNlcmll
cyBhcyBpdCBmaXhlcyBhbiBBU1NFUlQoKSBJIGhhZCBvbiBvbmUgb2YgbXkgdGVzdCANCm1hY2hp
bmVzLiBUaGVyZSdzIHN0aWxsIHJvb20gZm9yIDMgbW9yZSBib29sZWFucyB1bnRpbCB0aGUgc3Ry
dWN0IGdyb3dzIA0Kc28gdGhlIG5lZWQgZm9yIDItNS81IGlzbid0IGVtaW5lbnQgeWV0Lg0KDQo=

