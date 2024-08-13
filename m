Return-Path: <linux-btrfs+bounces-7156-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 162B2950287
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 12:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C287D282399
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2024 10:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4E6194C8F;
	Tue, 13 Aug 2024 10:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BVdwLvBX";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LOxCZQOx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6383208AD;
	Tue, 13 Aug 2024 10:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723545263; cv=fail; b=XGtdGRrSI6QTOf6OBKP4ZkFX9auZNuyHL8S3I8pflni+cLxif0T4YsCWcY2p2H67JYb7ZyLdc8HMwM0IROIj6zXH3OMgicjFgQAJoQj+BjrAV8o7UMERkrpziKMBMmqhJ8scL+riHuBmMR1W+Sq8h6R7cJGFv7h+/D83+hAGWu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723545263; c=relaxed/simple;
	bh=WQMlJQDSJb4JPNYjkRHxkJBTKvDWms+EdL0a8MWYW+w=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TaF/DtbKeGGPZqfnyxSwNvhuaFLItA75ircXNSo0Gw4jPSalnef05MIE/tovWuSv+L2AsIcPU03yiT6rAB4tBiQQ4bLVfafIsErSLGlnVdlC0qGJEKbl/Htu4nQN1iCWpQmnSm1aLtNuhycNbYnT4k/h9wyIZw7xkjG6GDRRIS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BVdwLvBX; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=LOxCZQOx; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1723545261; x=1755081261;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=WQMlJQDSJb4JPNYjkRHxkJBTKvDWms+EdL0a8MWYW+w=;
  b=BVdwLvBXE87w//6++b5/7/Qn+tutHi0CZQEHZClfTQXPVO3OAh4DMrXx
   QA8uvMI2E9yxdkMMOH/T9ZQ0U6GF9rK0W2GERg8s2L3NqT881faumLoXK
   2lSyBtwhiGX7zwYwAsklxJg/W9gQYzVvZOhJl81pHMUdjnSeNcphu3rF2
   f49R/s1FGFC6HSEstIUwTWlo4XzBwekMKDnXogw1wxzN4SnO4zr3PB6EG
   nHSrlnmB9dHr74FxL3U3PzIDG4oMsPmgdZmteiTzjGsJPOIrp/8oshYEd
   YNMpWZvjYw88N3FzpX6ckGvReMtjAwOsMa2D4/4s6rTjpWvEN7YkU1Li0
   Q==;
X-CSE-ConnectionGUID: c/n4HnCFRo+UyD+g30IWXA==
X-CSE-MsgGUID: 9KfxqlcdTk2Yk45oV7EkUw==
X-IronPort-AV: E=Sophos;i="6.09,285,1716220800"; 
   d="scan'208";a="25155033"
Received: from mail-westusazlp17010002.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([40.93.1.2])
  by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2024 18:34:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OvyEIVkAGvGsGzanfthEYDKtr6Q94Y65nFrPkmSdUjZYeKD2jPc2efVTUMcFTCU5fjNipegFLOihez+aGHcwyTAGumiTC1puzqCgBkiG+9vlaewczU5eojb/4pu9QY2sr+w471dwhdKzzQKinMbUwE756CRfIpwU7Z9iC2rpVQg8OB4jXNrT2LNny/DJALJ86lYOaUhszLlC6AyBbZfbvPIQi8ZVDkRd2V6ep5PWUU8b08xHHzbxDui+rH1fVKtmBwoevg3mwUhFbyr2GA7+QmSJRewDd2vfpbQpOPupiTfBinyVNtP9yBSpW8CUgIyjaMYoSONVwnHYSU4d8mpDtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQMlJQDSJb4JPNYjkRHxkJBTKvDWms+EdL0a8MWYW+w=;
 b=xwO9jl3m/HBBDWuaaxqRd1DS3TGvkiG/PMmlJLODoIu/hXeXNZAIuqa+n90aBNykXXz/oTbhSg/0kXM4UTu/Yj4fTfkdrCDg6ERqqItzNU3bBRz7mhO7uEoB7dHi+mVjz0p0qNRZKUX8eewpT3D4hHsUI+Gr6t35zXFeDfwhDAdnzN6j4M1fpprPSQ3XhRZ3cCZsMWs7DbcJSJ3Y2scXbeYjFkYmvpb83lej64UQJntKOBSljcaXbQMzNOL0Fdf8Jafh+peeCHtKLaqBZetHpwLh0KBW6VTjTTeKMGvMkQ+PVN/PpOBFuBemvNQTMrRSpvAJyHqvp23NcEJxYrvR+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQMlJQDSJb4JPNYjkRHxkJBTKvDWms+EdL0a8MWYW+w=;
 b=LOxCZQOx28CSFcJ7cx779gVb1F0gY1VKJTafpfE/1M1UVTXu8yXOKQdCCpzGbAVi7dSxxAImzX60HdCER1tNXcSARA4fQ6htIE+DNVNCQTCJqiaOpyBLr4FtAb56jPSrvizzZqSJMzpPUKJnuLQVKxh3OfeZ+13xClphQHEtbUQ=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by PH8PR04MB8758.namprd04.prod.outlook.com (2603:10b6:510:256::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 10:34:13 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 10:34:13 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Johannes Thumshirn <jth@kernel.org>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, "open list:BTRFS FILE SYSTEM"
	<linux-btrfs@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] btrfs: reduce chunk_map lookups in btrfs_map_block
Thread-Topic: [PATCH] btrfs: reduce chunk_map lookups in btrfs_map_block
Thread-Index: AQHa7NkPeggSEGI4Bk+8V7RYNXxykLIkNWIAgADJmAA=
Date: Tue, 13 Aug 2024 10:34:13 +0000
Message-ID: <9b270d10-a62d-46ae-ba4c-3325b0877942@wdc.com>
References: <20240812165931.9106-1-jth@kernel.org>
 <d1408143-13f2-4e0d-ac60-286bba4d72ab@gmx.com>
In-Reply-To: <d1408143-13f2-4e0d-ac60-286bba4d72ab@gmx.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|PH8PR04MB8758:EE_
x-ms-office365-filtering-correlation-id: 95df1695-24c9-4a98-4beb-08dcbb83798b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bkRwWEZRN09BR004SG1lZmtvdWdUS0ptMnkxTEhvbXNwa2g0a3NmTWV1RXZJ?=
 =?utf-8?B?RnB3S1puNFZKTkp1WHBQZSs1OG5MMGwrbElBRjB0ZUpEMkNTMitZVzQ5WVRI?=
 =?utf-8?B?STZHaHJwMVBUMlpRRGUxSFhBNytVZzh4RkppaldWR0FMQmwvVzF1aGk3RHcr?=
 =?utf-8?B?RDl1dWE3blJoYkZhYzN0K3B0S2NTVXlKazNIdE1tejY3aFJoT1BmeEJyWnhE?=
 =?utf-8?B?MEdiaG1jeFFWWHUvZk54SGlWN1QwbzJqVVhrMUxpbUJvZ1gxYmJkQlRKdEw3?=
 =?utf-8?B?Vnh2cXdBZ2J6ZEdlaXB4K0tHczhuSkM0WE10MzRXVThqYnZJb1NkQ1kxTC9o?=
 =?utf-8?B?R3c2MUxWUzE3R2xBdHVidndibVk0YkIwZmR6bE1XSENDVTdtTFU1YVZSSDhT?=
 =?utf-8?B?RU02LzVrY0lUSTZLZ2NnREVUb3RET0M3cDU0SWo3cGQ4cGVKZnBESjJnRDNF?=
 =?utf-8?B?VC9EbENwall6eGVacXFBL3o4VTJRVUozb0RkbFMwOGwweE53MmJiUGRscXVs?=
 =?utf-8?B?V09lZE9iLzNxOWZsYzFSdTRJbm5NeDRBcktjT04yZ0JUT1BSTlZqejhMUG1W?=
 =?utf-8?B?Q0xFV0ZzbXNITStlNHN4Y0dCc250QlhrQ3ZSVDJ2VHdMM1ZPU2VYc1ZZNG4x?=
 =?utf-8?B?enB0VjdWcXpoeXdjVUR4c3RLYklHS0E1cGl2endJU1JORFBQaFByMld6bkQw?=
 =?utf-8?B?OUJvWmkxenQ4aStCZXdZVVBDc3NkZS9zV2dXUlZlTWhadW5yNVVxL0dKL3lG?=
 =?utf-8?B?V05DWHZJaUNHK25JaUpzMGozUllCb1k0ZTRZSjg4ZW9VakNBRmd3MnpEVWhJ?=
 =?utf-8?B?SzBMbGVNS0xpQ1BRa2VHVE5LQW9OakFDY3JCa2p4UlRabk15cWJ3b3BQZUln?=
 =?utf-8?B?OUpDUElrd29YOHNYWHJiZDhsMmw1WDhGc1lKNmM3eUlESEpxdXN3NnliMXRY?=
 =?utf-8?B?dEpndGpSNWZlRG92UjVTVVcrelBHblZWU3RUbU9RMWxHakVLeGovaHRQY1Uv?=
 =?utf-8?B?SjI0Q0FzWmtwaEFNSHA0QkhKeXMvMkdvelhnN2ppM2kwTEFEY09hWjZtL1lU?=
 =?utf-8?B?WEZvWTR2dmpwYlFEanQvU2FlOW9jNVBmcDB3VWlqRDJlaE1kMURFU2MyaHc4?=
 =?utf-8?B?OVd4MkxoK2JpMFgvV3RibXA1TS85Z0lldFZuL2ZSRTN2UmdEY2E4N0liUEtx?=
 =?utf-8?B?Y2ZrOTd3N2lacDVFRGlseE5lc1R6dFBCRU5SNG9pY3RZZ1lGcXAxcTE2YWh4?=
 =?utf-8?B?WHdhdi9kUE42TVlrdFdXR01aYWhPTXMxSE1XTk9GMVlqSHZqSEdJZm5sVEZh?=
 =?utf-8?B?ZmdwaUF5VVFaQlhWQVEwTGtKdmswWXpDSTFIRTdhL3EyaEJoL1puTC9PTEZw?=
 =?utf-8?B?aUhaN3Nnd3loNGY0bWhWZy9VOGx2ZnR3KzdlMTZ5ZDl0elUxdDBEVitpMEJC?=
 =?utf-8?B?aWNTd1dvK1dLM2lzNTdJc2E5bmcyRU8zOUR4RXR6aXNVK3JMdHlFRkxFU25R?=
 =?utf-8?B?UEU0Q0QwNWROd1pTSENGdWZhWWRQRUlQVEJ3UElEUW45MGxkNnBNZXdKNzg4?=
 =?utf-8?B?ZDRLZUhtZmdRTG85OGdrVFg4UHI3TGVGMmFYdmtTVmtLVFZtYUVYYmJpRmhL?=
 =?utf-8?B?R0JmdHlDd1VBeFRXNC8weEYxdE95dUtKUXVKaVY5T0lwdm5FVHoxb2RCOWFL?=
 =?utf-8?B?NGQyb2VZWUcreG0vMG9tTEN3OXMyYll4SU9lREg3RTg5WlZsSm9FM2tPRGZD?=
 =?utf-8?B?L0c3LzdjUE5aQzhEYVg1dFRjU2x1aFg3R2h6ZkpFMGtZVCt0eml3QkFzNFU2?=
 =?utf-8?B?Y1o2WnRxWnpGR3pFZzIwVXpHc3BRa0R2NURSbWdRTUFacHlRbjJ5bkowVkxq?=
 =?utf-8?B?SEd0WmxaMzZQNy81d1lXMnNyTTJRVGsxSHpTWHM5YnJQaVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M2c4R3pxZkZ0eUcyZXAzOHVlbE5RRG4vTUFKVllPMjQxdWNiZ1hxeTBudC9a?=
 =?utf-8?B?aDNsc0JBZHJBcURXa3FFSXRoTXhTUUZjQlQxNzB1dVh4amJYZ2JsUFo1QW1Z?=
 =?utf-8?B?M3BtQjdkM0lLWFlteXFkd1poWXF4aTBIKzBkdkhUZEdxNlg0eitSeVR3N3FV?=
 =?utf-8?B?a05abEtGa01WUW10akxUR2Y2TXJLVzc1MFN1MXUxRU12UklWbWN6S3lZaWRM?=
 =?utf-8?B?NUNnWUJPajlYYW5HZ3V3K1VoM3U0WTdOd0N6ajRmYkVYOTB3QklqZTVaNXE3?=
 =?utf-8?B?YU94bVR6c0xnUndFUkpianBXSnYrdklXbUlFU0haMjZMUEVBRXpTSFI2V0tQ?=
 =?utf-8?B?MHQzb0ZpRGNEMStNZ1RlMkdvS2Z2bjNpdDM0MDZZcGNyVmNLL1RqY0xDZU9E?=
 =?utf-8?B?eWhyc2tGNmI2SWNWTUROc2VkV1dUbTc4a1JMVkl6cGZwZnZtRDlYK1JWeS9q?=
 =?utf-8?B?ZVY5blk5SnVuZGtUM2hjZkNkTnQzV1dFUVM2eFN1UjZ4OEs5aGJ2L2t1Qmg3?=
 =?utf-8?B?TmZ3WHhHU0ZhYnRxZHlGMHVNZGFZdHkyMU9BWUdxVy9tMlpNWG5kUFFEcGJP?=
 =?utf-8?B?MUJiZWd0Vi9jQ09lQk1UalMvaEZ2UXZ5Mk5CTDZZUnM3L0liM3FxWnRsWU0r?=
 =?utf-8?B?VGszUVhPQW1uaG1KVDVZVW9yMHRMN1I1NnJVS2xiaXJwenlwTkN2L055MGpa?=
 =?utf-8?B?YnR0RmFrZWI5alIzSWpoTWxCTUdoREovZTRXZ3ZwVnkzc25SQ0N6eTR5RWow?=
 =?utf-8?B?UVBvTjNkdkduMy9oUGNOUjF4WHFRL09CWDhta2pIaEFRMjZSUE8vazMxT2ps?=
 =?utf-8?B?Tnc5Z1F2NnJiTGF6VnI1Y1VkU2FHR1VRRVFyK2xydTFmN2JXNE9mSG5RZEtX?=
 =?utf-8?B?NkJ4aDBpMTA0b1pIK0RLY1hyYTN6YkkwVjMyOXlsTG9tWklKMFFrdHFad0hE?=
 =?utf-8?B?NHhEWklUY0x1bURrYXlqQktsNndzaTJoZkdpL1ZhY09HM2lpMXIvbEhGUjJD?=
 =?utf-8?B?eVRPWVhTZEQ4ZHV1QlpjVGlpaTZoeXU1WEl6NTFYSm9McnlFRHNOeHd4WDJo?=
 =?utf-8?B?bW45MEswV2lYU1FocXVVL0dEL3NQR0UzRWlZNHFjVzErNG5pcCt0L1JpWFlv?=
 =?utf-8?B?VE1sSVJqMTlLVjFBTVNrMFRhdnFvNktPdTdDR1E0M0RLaWVWdWV1V082QmU0?=
 =?utf-8?B?THNGVDZkUDJwWk00ZCtSZ3A0ZjAzUjVrNURQRFdXKzlzVVN5blgwRUhwOEh5?=
 =?utf-8?B?QU91SFJmNVY5YnFRNmE1ZFl2Ykd1a3Y5Y2JNbnlEWUkrSUVDY2EvZStyVHlq?=
 =?utf-8?B?TnFWMGQvTmd5d2pnQXRJQ2lOcmdiLzJnNnVnZ2hGZHdoZEFKc0hkTHpoay91?=
 =?utf-8?B?YU45YTVlZnJMUXJpazE4RXNVakFaNXJPL2wyRzUzOEI4OHVLUHNUa2Y2Ukha?=
 =?utf-8?B?N3JlWHhSZkE2aUszeGpJWkg2RXhmV1J3ckp3U2RXTUFsY3k5amtoQk9hRkJs?=
 =?utf-8?B?NTlBaTFLS2JwbU9GNk92TjlBd1FQb3hkeHpZM3AvODhOYzRON2FYajU2dDN3?=
 =?utf-8?B?SXAvcThMRXRabCtlbVlVT1pyUzR6MFJQTGVVQnlaZlFwSGs3cnBDR1JkdEpF?=
 =?utf-8?B?ZXA4d1FGT0tac0Z3TzU0dDRBdXFoSnk2OFFCQnBuUDJTQTBPaVlYL3ByS1ds?=
 =?utf-8?B?ejJjc1Y3MGduQzdhRVlYZklRNklyczgwT0FHVzJ6R2oycEsrQzZKTHFiU2xC?=
 =?utf-8?B?c05nTnV5MnQvTWREdmlGUDRjM3lseEZUNmF6Z3lQWjcvRGF6am1LY09hRzkr?=
 =?utf-8?B?c2MvZE1VbmNrajVvWHRNaWFXUXRZZjhyUXVCMEc4aXBlM2lWQStRNUlJRHd2?=
 =?utf-8?B?NE1ncFdKWkpsRys5b1NjdlB5Ym5uS1VINkFDZVltT24vMDMvT0t1NEhldVVy?=
 =?utf-8?B?d1paOWM5U09CSWxrSEpJRFoxTHVPaUVCc0VKZERNRVZ3aVhtbG5MMmpWYUFY?=
 =?utf-8?B?R3ErZDZnRC9LVEFJc014NDJaOUlTUnBzT0xHU3RjTjNoM2hvUHlldTdTZSsy?=
 =?utf-8?B?Mmx2d0FCZFRLUmZyOHJRdVNCTFFhelI1ZUFreWMwMUc2MnNJd3JHQ3lLVjZp?=
 =?utf-8?B?ZzgwSUxiK0J4TEZoVVB3SjFJY0F6KzNRRjlma04wTDQ3MEdFSEJSRFRGamZR?=
 =?utf-8?B?aHUybk16cktLdlpNbGhvZUYxdndXTDV1NDVnVERlWmdTYU14ZG04dDdva1Nw?=
 =?utf-8?B?aUIyd3RzYzBmbUFuZ1NsaG1aSXJnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B67368076B92E340BBBA0A4B3B9DEBF7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	//etqq+35zd65VDp5E1Lult73ZzKpT8XVeCoEei/HwF7TTdpLpkHD9Grr+9vNgfb0FuXrPJl2jK6YoBeU48Um80wPYmii6ZOab10Bp5Vdxc9JLdYQ/gV+vCMDXD5xX+EF8MKzJFTDM5zZEF6UnWelWKdCf39/B2mzxEjzQufHRofmPsjQ/ogO1g4+p/Gx49EqWtgtGVH1xPSr2JKzbEeZJfv2nqrhS8Q9K54TGGzqUcBpT42k8M4/Xxc9IhOJVLQg6tYn/Oqell9gR6KNFpJ0hGp8cDZGjCTQ9cMxZRIXpHVr9WhMcW4hbModVcttstQNL64kJxE0mlCvJgwns3Pz7laTkHYo8uQzBb1iA0J4WPZKT+hmwIC7UAQgjc0m7wGc3P5vqmuI1IhJBoE8YNOPTTWSVbf+Fgyru5efAwziL/BqqTONYmeDiaTCEw09SpUMmBlAz3nGk/Zlp7IGW2vT0d/WcAnPvKoaMfKMNL6fthmmJqGoVxHOo1eNhac/YNLBAfV2OGI8Dhnk9xxe+UELQOIO1MfDOln4q0eW/Jfx/M7Nt9C4ueRL3JdawFUYMqEEq4ZQiX3cRO+02Tou6wmjw7wlSLeBS/iWno+3xiTvFR/FmDKgKNNSyk75qqGwlFM
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95df1695-24c9-4a98-4beb-08dcbb83798b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 10:34:13.3823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hmMnAVacHuEhYJktPEcFZwyTVqJBSBj00ZUKgYVuvP1PvbxPpUzc3AUz/9xO1dZEWYUpZHkCP9efpy6RK0qOuonoj/iyFlc4tXfoiuJLX3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB8758

T24gMTMuMDguMjQgMDA6MzMsIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+IA0KPiDlnKggMjAyNC84
LzEzIDAyOjI5LCBKb2hhbm5lcyBUaHVtc2hpcm4g5YaZ6YGTOg0KPj4gRnJvbTogSm9oYW5uZXMg
VGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCj4+DQo+PiBDdXJyZW50bHkg
d2UncmUgY2FsbGluZyBidHJmc19udW1fY29waWVzKCkgYmVmb3JlIGJ0cmZzX2dldF9jaHVua19t
YXAoKSBpbg0KPj4gYnRyZnNfbWFwX2Jsb2NrKCkuIEJ1dCBidHJmc19udW1fY29waWVzKCkgaXRz
ZWxmIGRvZXMgYSBjaHVuayBtYXAgbG9va3VwDQo+PiB0byBiZSBhYmxlIHRvIGNhbGN1bGF0ZSB0
aGUgbnVtYmVyIG9mIGNvcGllcy4NCj4+DQo+PiBTbyBzcGxpdCBvdXQgdGhlIGNvZGUgZ2V0dGlu
ZyB0aGUgbnVtYmVyIG9mIGNvcGllcyBmcm9tIGJ0cmZzX251bV9jb3BpZXMoKQ0KPj4gaW50byBh
IGhlbHBlciBjYWxsZWQgYnRyZnNfY2h1bmtfbWFwX251bV9jb3BpZXMoKSBhbmQgZGlyZWN0bHkg
Y2FsbCBpdA0KPj4gZnJvbSBidHJmc19tYXBfYmxvY2soKSBhbmQgYnRyZnNfbnVtX2NvcGllcygp
Lg0KPj4NCj4+IFRoaXMgc2F2ZXMgdXMgb25lIHJidHJlZSBsb29rdXAgcGVyIGJ0cmZzX21hcF9i
bG9jaygpIGludm9jYXRpb24uDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSm9oYW5uZXMgVGh1bXNo
aXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCj4gDQo+IFJldmlld2VkLWJ5OiBRdSBX
ZW5ydW8gPHdxdUBzdXNlLmNvbT4NCj4gDQo+IEp1c3Qgb25lIG5pdHBpY2sgaW5saW5lZCBiZWxv
dy4NCj4gDQo+PiAtLS0NCj4+ICAgIGZzL2J0cmZzL3ZvbHVtZXMuYyB8IDUwICsrKysrKysrKysr
KysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+ICAgIDEgZmlsZSBjaGFuZ2Vk
LCAyOSBpbnNlcnRpb25zKCspLCAyMSBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEv
ZnMvYnRyZnMvdm9sdW1lcy5jIGIvZnMvYnRyZnMvdm9sdW1lcy5jDQo+PiBpbmRleCBlMDc0NTIy
MDc0MjYuLjQ4NjNiZGI0ZDZmNCAxMDA2NDQNCj4+IC0tLSBhL2ZzL2J0cmZzL3ZvbHVtZXMuYw0K
Pj4gKysrIGIvZnMvYnRyZnMvdm9sdW1lcy5jDQo+PiBAQCAtNTc4MSwxMCArNTc4MSwzMyBAQCB2
b2lkIGJ0cmZzX21hcHBpbmdfdHJlZV9mcmVlKHN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZv
KQ0KPj4gICAgCXdyaXRlX3VubG9jaygmZnNfaW5mby0+bWFwcGluZ190cmVlX2xvY2spOw0KPj4g
ICAgfQ0KPj4NCj4+ICtzdGF0aWMgaW50IGJ0cmZzX2NodW5rX21hcF9udW1fY29waWVzKHN0cnVj
dCBidHJmc19jaHVua19tYXAgKm1hcCkNCj4+ICt7DQo+PiArCWVudW0gYnRyZnNfcmFpZF90eXBl
cyBpbmRleCA9IGJ0cmZzX2JnX2ZsYWdzX3RvX3JhaWRfaW5kZXgobWFwLT50eXBlKTsNCj4+ICsN
Cj4+ICsJLyogTm9uLVJBSUQ1NiwgdXNlIHRoZWlyIG5jb3BpZXMgZnJvbSBidHJmc19yYWlkX2Fy
cmF5LiAqLw0KPj4gKwlpZiAoIShtYXAtPnR5cGUgJiBCVFJGU19CTE9DS19HUk9VUF9SQUlENTZf
TUFTSykpDQo+PiArCQlyZXR1cm4gYnRyZnNfcmFpZF9hcnJheVtpbmRleF0ubmNvcGllczsNCj4+
ICsNCj4+ICsJaWYgKG1hcC0+dHlwZSAmIEJUUkZTX0JMT0NLX0dST1VQX1JBSUQ1KQ0KPj4gKwkJ
cmV0dXJuIDI7DQo+PiArDQo+PiArCS8qDQo+PiArCSAqIFRoZXJlIGNvdWxkIGJlIHR3byBjb3Jy
dXB0ZWQgZGF0YSBzdHJpcGVzLCB3ZSBuZWVkDQo+PiArCSAqIHRvIGxvb3AgcmV0cnkgaW4gb3Jk
ZXIgdG8gcmVidWlsZCB0aGUgY29ycmVjdCBkYXRhLg0KPj4gKwkgKg0KPj4gKwkgKiBGYWlsIGEg
c3RyaXBlIGF0IGEgdGltZSBvbiBldmVyeSByZXRyeSBleGNlcHQgdGhlDQo+PiArCSAqIHN0cmlw
ZSB1bmRlciByZWNvbnN0cnVjdGlvbi4NCj4+ICsJICovDQo+PiArCWlmIChtYXAtPnR5cGUgJiBC
VFJGU19CTE9DS19HUk9VUF9SQUlENikNCj4+ICsJCXJldHVybiBtYXAtPm51bV9zdHJpcGVzOw0K
Pj4gKw0KPj4gKwlyZXR1cm4gMTsNCj4gDQo+IElJUkMgYWJvdmUgaWYoKXMgaGF2ZSBjaGVja3Mg
YWxsIHByb2ZpbGVzLg0KPiANCj4gVGh1cyBzaG91bGQgd2UgY2FsbCBBU1NFUlQoKSBpbnN0ZWFk
PyBPciByZXR1cm4gbWFwLT5udW1fc3RyaXBlcyBzaW5jZQ0KPiB0aGF0J3MgdGhlIG9ubHkgcmVt
YWluaW5nIHBvc3NpYmxlIGNhc2UuDQoNCkkgd2FzIGFsc28gdGhpbmtpbmcgb2YgYW4gQVNTRVJU
KCksIGJ1dCBtb3ZpbmcgdGhhdCBjYXNlOg0KDQogPj4gKwkvKiBOb24tUkFJRDU2LCB1c2UgdGhl
aXIgbmNvcGllcyBmcm9tIGJ0cmZzX3JhaWRfYXJyYXkuICovDQogPj4gKwlpZiAoIShtYXAtPnR5
cGUgJiBCVFJGU19CTE9DS19HUk9VUF9SQUlENTZfTUFTSykpDQogPj4gKwkJcmV0dXJuIGJ0cmZz
X3JhaWRfYXJyYXlbaW5kZXhdLm5jb3BpZXM7DQoNCnRvIHRoZSBlbmQgd291bGQgYmUgZW5vdWdo
ICh3aXRob3V0IHRoZSBpZiBvYnZpb3VzbHkpLg0KDQo=

