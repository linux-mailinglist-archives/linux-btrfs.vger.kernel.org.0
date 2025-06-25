Return-Path: <linux-btrfs+bounces-14935-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E81FAE7F3C
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 12:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3611883D63
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 10:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145AC29B233;
	Wed, 25 Jun 2025 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BbG4YHhc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jxCyrn50"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01AC26E6EF
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Jun 2025 10:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750847329; cv=fail; b=RLPvnlp9wF4w4CUg21hZSNq+CuQyv8KM3KVtcNJtnxVjSf6uA1A9kO4sPIqrfzsvLAInVotwk+IRYNnGBXXjLa3jCg49s4fVXU1g1/v21EalErGy8Y54RwCffrm7k9pk1F4vpZzmT665Td3W9HJGI3Ncl7hMM1xM7PKmqUBzAHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750847329; c=relaxed/simple;
	bh=KFoDPp80fp4G4sEG2m3mnXN+bkOnp/FhAkRPbjGsQIg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JQzkpMin16b55kdGh0qRSUCcjxebOWxAQ5zuCXbXTnG4qeMxeMjPT+yPu62HOwqk9+ypZMxF8o3TIZt546CNAiH4h+yjE1ytDRnjJLOR+tiiLj9p//2eKk9WMBKkzLYxAEVh+njJmBMe9BBEjc25RtscC8V7nRy+Uf8VJWexcfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BbG4YHhc; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=jxCyrn50; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750847327; x=1782383327;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KFoDPp80fp4G4sEG2m3mnXN+bkOnp/FhAkRPbjGsQIg=;
  b=BbG4YHhcJUPEUq5XNnBCPZIST6dKuVJ4ZnN4OigMZ4H1pVljPd2SE6yD
   iSwaDkGbCXQkgaRaoOsR2SewyZ6NKylB+I955kyLrY3FKNTCPmjMcfRNe
   9gm0Mv/aEuglZ6TlGC0TCwynwap7X87sgf9HDie271Gl9wc2pgYU+vusF
   qsZnaSl0DqXdw1hgl5z0lefhyMWOLgBxizsJRuyrRwcrfd/a/zTWqLUWM
   4JleHRQWQ4kr16F3cs3URMgBgCYF+vV98F7n2Vh//9isVCdBNoFogBw12
   RTrGqkWcDDPWzdGEz76KvzykkLvhExlQZW8y9Ka0oT6suy5+TkUfN/O8e
   Q==;
X-CSE-ConnectionGUID: 3pHAFct/RzawCtZxfziC0w==
X-CSE-MsgGUID: 7Sf0FbVdThe7MgEvjwI5xg==
X-IronPort-AV: E=Sophos;i="6.16,264,1744041600"; 
   d="scan'208";a="85204124"
Received: from mail-bn8nam11on2069.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([40.107.236.69])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2025 18:28:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7ugvIHz6npkIS/p3Cg4tvVCbtb0enYkoresmW2eIvLohNjzjimh9G+cQNeV4EW51TQ4TUcfM90Ca98Q5VwHLacL3MNBdChpu3Yz5EF75bUgv8zEPc9LI+QqBq+XpZ1W98c+lQKFtKLkmffa9yK39lTA2+XDba9kkMaboSkkNLtSlMpmuHGJmliOE3T9dqpJY0zO6XtHfVlm2/RV7juVWfMywGmEebat+g/LsZ9oC0ObHe6GidltHwJW1CiDGUfe0/ZpW2LeOn3o1x+b+uBoBA1gQz5zbvnsYVSz7rStb0nfN4eXt+pHaCipKsprmNpC7AGevAtKbfsxYmPtvyXVyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFoDPp80fp4G4sEG2m3mnXN+bkOnp/FhAkRPbjGsQIg=;
 b=BU+iznyWmb56Jb3BV7oq6h7tNXFO10rWfETQsWNY+H1GwU2nk7MQdKoCQhB/hnf6V981pgtw0t/WkHaAERmrQPgDJDLyyqzuZLoHrJixeA3fP7sE6H3FQ1WiT3477QImKljrBihy8LDU3noB/KNUCfCCEn9JbVwTIH1ojkXuYqUx3kO+NpNL1zU17vkGW8dvWy9W1d8IC8QAVwUjO9JsYqAv4cy2IklkjJxvG/fcSRvxXFxxAcEWJucv3bx//OgJ9ozSweWCrlBnurX6Ty38J53DX/0UcKMVntbQPI9WyrdX+YXQfX+sQ0IOEKzWWJumQ+EG/6lVzY5MXmtSyD9djQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFoDPp80fp4G4sEG2m3mnXN+bkOnp/FhAkRPbjGsQIg=;
 b=jxCyrn50vDHuqR5XUVqk3441Mb8wLWJQqFZzLpMFL3J3qlJAywy3qP2eDPBy8tN16NYv3Sg57aNMm0UpAWcz0oUSbkuZYgx9eVLBmETRN6gW5Rz1Pmj5BQ0yYK8sFDV+7mSL0H5Gn6zmw/fkbWfsN5E4FwPxsCDZRcItuCEaiOc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH5PR04MB9623.namprd04.prod.outlook.com (2603:10b6:610:215::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 10:28:38 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 10:28:37 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC: Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2 1/3] btrfs: zoned: get rid of relocation_bg_lock
Thread-Topic: [PATCH v2 1/3] btrfs: zoned: get rid of relocation_bg_lock
Thread-Index: AQHb5OuaOtdql1iF6USymlzbowPAR7QSPl8AgAFvm4A=
Date: Wed, 25 Jun 2025 10:28:37 +0000
Message-ID: <f892a8dc-28f4-4467-b7c5-a13155d350d5@wdc.com>
References: <20250624093710.18685-1-jth@kernel.org>
 <20250624093710.18685-2-jth@kernel.org> <DAURLBJDUGQJ.1W5C4RDQ8GJHF@wdc.com>
In-Reply-To: <DAURLBJDUGQJ.1W5C4RDQ8GJHF@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH5PR04MB9623:EE_
x-ms-office365-filtering-correlation-id: bc516071-5eb0-4742-f3c1-08ddb3d30c13
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Vk1WaVpIU0NZbWJhUk5jS001NnVlRWlSR0lYYU9EaWIydjV3Sy9jUFI2Z1ZK?=
 =?utf-8?B?c0xHTkk1V1d5dmdNS0xoYXVmekI3TG9VVVY1aVdZM0cwMmlCNENzVGpteWoz?=
 =?utf-8?B?blhnaE9LdWs2U0dDQzUxL2FZa1VNS2NyRndOMEppU21xQ0g2UTBVY2FMcnFx?=
 =?utf-8?B?TmlCU0M0RWZ2SCttZnZYbUVJaTZkR01YNlQ4SmpSaGNIT0lkekNDTXB3UXQr?=
 =?utf-8?B?cWN6ZUdFZ1c5Z0pPcG9OWjRTK012ZDRHS000SUtucm1CZGVKcXQyWFBUcHp3?=
 =?utf-8?B?TVJMZldHL1psZUZ5RnlFZjVJU2UreDBpdklzNjZDek5xMjE0Y0ovVnRSMmp1?=
 =?utf-8?B?d0s3VWVUSDZEVDNHOEltNDNocDU4TEZIOU1HQUNDT1dkMzhoOHpUZ2ptMmRR?=
 =?utf-8?B?TWYzU0FTdzNqZ1VOSC9CS3RKTWNYcGxjTTdVUHpTRlB1OUZtMm11ZmR5aE5r?=
 =?utf-8?B?bUl0NVg2N1lLNDVad043TzBMMkVTYnRjSmV2T3BtL2FmZ2xqQjc2S0hiYWxn?=
 =?utf-8?B?a20vTjEwK0tiYXozUjc0aXluRFJ0OEVPWTlZUis5UGRPN3N4YlBOVlorV3pX?=
 =?utf-8?B?NldPa0pMRDFONXdYeEEwOGh4RGJXSFViNmVTK3llL3dCT09DWXd5cHFGcFR3?=
 =?utf-8?B?eFdLano5TDhZdmZtZktwcHdrOTVIMENqdFZsMTNjbzRjUFdURkMrcnJZUlJy?=
 =?utf-8?B?RllGYzBvbW1aVk5jRTRUZW5SNlhCQ2RtbmRkYUhpQzlrZ2ZqTVA1Wm13b042?=
 =?utf-8?B?SE82V084WFQ4TldGd2UxVkxVWmxZTHAyOUN4dHhIM3RJc2Q1bCtUY3RrNWxl?=
 =?utf-8?B?YkUrSDU0czJQYTF6MEx3a28zUTVjbnh3cmtiSUZBdmhmUFVod25McmIrSWQ4?=
 =?utf-8?B?UG0rQ0s0Z2xKclFocjZlelJBTnpKZUM5SkR6eDI1ckg3bjd0MVBLTWZrdWtz?=
 =?utf-8?B?T3FhVm9kT1dDb0lPZGNTYThuNDlWQjhIYUhBR0FKZ214RU9NbXFheERpSDdt?=
 =?utf-8?B?OVZ4VTdZWjkySG9TQll2eE83YUVmNEozWjRkRWhKc3pZWWs3YU5SYURYMVRj?=
 =?utf-8?B?V2pSR0FPbnBsbUkzNDByZ09iWU9FZFlxWUdSLzJHTFMvOWlQSXdVSGlIN2pT?=
 =?utf-8?B?K2RDNDdnSWNZc3Z6aXdHT0dZaWxZbk9NN2o5ODZwTnRabXBMTjJweXlOMnFD?=
 =?utf-8?B?b1lic3FnV3pTaFRmT3dIbjBDQWlYMEtKaklEY3dQaU0yTlYrdHd6NDlsWW54?=
 =?utf-8?B?ZS9oSlNYOGRPYkxISWJWOXlBQWhVMXllYUhtVmhXUVFJM1VkVm9PSzE1VkQr?=
 =?utf-8?B?R1ZpR3Ryc3pmN2crdzdBaDVFWHl4cllHYnR1U3VSY1dpWG5XSnpGWUxLajhv?=
 =?utf-8?B?NlcvbXE0Z3lOVkZGRm9UY3lEaW9tRENMRG9WWDl0cU41emkwR2FweHQ0MUlE?=
 =?utf-8?B?TE9rRE1yZU1wQTUrZG44VDgreFJ6ZGxkdm5Iai85SXNQMzBLenJGUEdFd3M2?=
 =?utf-8?B?WHBBZGNpUjdHZG1WVCtsTTJydktTbkVFb20vTXJZcUtwT0ErTFpnRDQxdjdT?=
 =?utf-8?B?b1Z1VkdwdXpvb2FPMjNEQjN5b0ZCOVM1U3djZDB5YU9qUkVaaWpkcGtWd2R5?=
 =?utf-8?B?SkpkNkdjdEZ3ZzRmV1l3MTlJRHloNGJGUDlJQXluTTJOZzlDSm41dC8rbVcz?=
 =?utf-8?B?ZmxzNGorVXVGNzNoTFQ1SERkbVN2M3BGaERGSUorNEs0Z0M2TlJYS2N5N1Y3?=
 =?utf-8?B?Z1MzejFjQ2xYeDkveVl1VVcwRVR3cFc1dzZ6Uzd0MlNhdHZDVEFJSlJudGpY?=
 =?utf-8?B?Tmo5dm4zM3daVzRvdmhhNmR0aHVFSFZkbndIQ0NLUXBVaDF4UEJxM3BjWUdi?=
 =?utf-8?B?bDlSY0VtcEEzWnJsRGorUXdxVjcyTXVPejF1WWxuc3M4R00xZldnTk9OZHlQ?=
 =?utf-8?B?SXBLVXBaQzVEVTQrZG1rVHFiQlZsTndOYUZEUURSVENqcG9FVmp5Z3lsblp0?=
 =?utf-8?B?bVhUMFA0c2hnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S2QrcHViTUNvMmlIYXRtZW40a3BjTnNwck5RTW9ReGlJUFRLSUpmTTVZOHE2?=
 =?utf-8?B?YjQ4K2w0YjVxV1NhRzhmc0k4Z1hVNVNZdGZCK2JUc1ZxaUl3MGxXV0VZUlA3?=
 =?utf-8?B?b1JaclZldkxmZnVteXpySXFUcFkvbldNQUVINmlDdGdDNXNad3dtaXpLQ1gv?=
 =?utf-8?B?SDA0TllQc3JHMmhWSnFSZXpjWWUrL0JTSzBCSGN1SHVuNHRsTC9EcSsxR0Zu?=
 =?utf-8?B?bVdZbUtrbjBuWlhsUDFqR1pYUjhZL1d1TldUTVBBYUE1QXhsSXIzOCs0TlVy?=
 =?utf-8?B?K0FzYVNVbkNHUVc0bi8vcjZvNXBRYUN3aHkzcUxtZ2ZwLy9XL0NURW1jU2dy?=
 =?utf-8?B?dEZ6RnlDUmtURVRaS2dkdkwzTnppaDdhaHRZNE9DUmZhRWlURTdjMDMxakFm?=
 =?utf-8?B?OHRqYmU2azcrWmppdjZHOUEvRkhzbVBrZi9aVm9tOUxqRVIrWkFDWXk5OW5k?=
 =?utf-8?B?V1Q5S2k4cCs3bE5YeVJyZkRQbDdXRnJVNFc0WVNVR3Y5V1QwVUxsQVRyeStQ?=
 =?utf-8?B?MUlXT3hia1Y3VHA3SHlxd0JYcGtOWkFKaWZPZEkzTDZ1VDN0aTR3UE1ETnZ6?=
 =?utf-8?B?Tzd4ZUgxTjZqVE1xdFFOOXFYMjM0RjNMRmFycjZZVFc4SWI5eWx3L29HWkkw?=
 =?utf-8?B?SExyK3hGZ040aC9LWEtReXBmMXZWTTJianZyZ1pRcWt0SVY3b3ZZR0Vpamoy?=
 =?utf-8?B?TVY0Y1M2L2VVUUJUY2tBTzJwbUU3T3g2R3hJdUpDbVVNWVh5ZGJlcFFtWU1H?=
 =?utf-8?B?cHl1NEZIS0p5VWVtRTg2SE1aSWNObWJJL3UveVkzSVhCSDlJamNKL3RZSFJu?=
 =?utf-8?B?dWh0a3N6dmVtOG1Vc01OVnlWdTBQbExvcVdSN0hQZk9OaTBJakIzZVA1aU9m?=
 =?utf-8?B?WWFyaStrRWM1ditTdkRSbStGVm5yWWNIM3krVFVaclFBTjZzbkorWXZpcWhL?=
 =?utf-8?B?MmNIOEpXejdVL2tFZVFyQmVjMy9URnNjaTZ3dFJ2ZXY5dnhWVitPUlRlSkRK?=
 =?utf-8?B?cnVpTENrK1J4bDBpTi9udGIrRUJqa1docGpjdVoyQVFEdjBvWFJTazQveXox?=
 =?utf-8?B?Q3JoS05qKzdSRjFGaE1GWVozOEZXT21tak1DS1h5NkVTQmhUdGphMmtZSFZz?=
 =?utf-8?B?eFFSUVhmRTdVSCtxcWZ6Y2NCZzUwOFVUQkFnR0ZXakZWbGhzc1N3dWtUOGZF?=
 =?utf-8?B?MElvTUdKNStHYUd3VWdvenFQcitoeUw2TnI0MHlObUVTd1c0elZOZ3F6czRZ?=
 =?utf-8?B?VExoSlFqRHJUZUZJNjg3L3N6RW4rQ3FYWEQ1SHAwMmhreG9INjYwUHM5bUNo?=
 =?utf-8?B?K3h0TWJkM0hRVGdtVkV4TWNkS0Z2c3R6VThTcVNoU0RFYlJhTGtEdWZYbW1a?=
 =?utf-8?B?WTNQMlM1d0hSTzF2UjNNVDRHZk9LT0drUXJrd1hqN3kxbkhFMWtMMytTUEVK?=
 =?utf-8?B?ckRSUnQ1YzhrMTk2TVpCNDJibTFRb0NvYkJpZENaUVBJUHYvRDlqS2h3TkFY?=
 =?utf-8?B?MWkvUVI1NXFKd1JLUzFucWQ5Mmlrb1RlMlZLSjNGaHJIaXY4bVNJRHhNeWJQ?=
 =?utf-8?B?TnFBRG5UU3E1bnF1MmlqdHBBMmFhWGJVbXVOK1FXY2tPTEVVUFVNODF3K2dJ?=
 =?utf-8?B?TzFURFEyMEVZYnZGVkN1czVtRHYyZDg3Y21VOXJiRGp4K3pRUzU1RGdlNkFr?=
 =?utf-8?B?SGo0N2h3dEM3OG5qOVNQQ242Tm5vYWxYK2pXSklaOGJKYUV5QXNXay9JaHpj?=
 =?utf-8?B?VC9RL3RPc2diQU8wNkR1aW54dHgrakJwV3FFRzRvVXFUQWF5S1RKUWROdTJl?=
 =?utf-8?B?S3VIQUZ2UkZnZ04zeE9LOGg0QXFGdUFab2tWODZNSVNlaHJLMk1PNERRZXdm?=
 =?utf-8?B?WHZaVlN1ckdWU2RTOWkvMWxZd0E5SmhqOEFNV2NTbmUycHEyYWpGOWFPbzFI?=
 =?utf-8?B?U0FCRGZSbjNiakVOZDVxaWsrR2JOTk1aMnRtK1V4cU5iRXRDTUxkVE5PZHVo?=
 =?utf-8?B?V0VQM1JFc0J0RWVBWU9LaWpHVzY3cy96c2ZxU2s0VFBmU05SbCtoN0FSTTY2?=
 =?utf-8?B?NXBTYjgxSnVrZ2FFRmVLVjlwQjMyV3ZuWXlNMnI3WDVCQW5ocUdxT0ptdlJt?=
 =?utf-8?B?S0NES2ErNE5zeXN1R1JYZFZnYXBwa2xHOW5ZS2NDZGUxamY1YVpjcEtQK0RI?=
 =?utf-8?B?SHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40CD967D2D802C4BB12DCA4DEDBDCAF0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TCWA9UYK8nc5kzHYfNTZI7mrwIjjOjgB5YzRWPd+2ZIy4qJh+FuHkHQ6p5kDTWEtjcYgBRQAYVO6JFX2IkyXveZoeaSzwSZrkhbmKFTaeuQqwlRPPfM6yEYp0aqW52ONFJfpaZs1ChyqJve70p7QokOcjZA4J+mWLEVXnZtuqmM/6bVQL4SLgPLv5ghJGWrdnU5nLoCgL/YxYMgljzsQGgQVxwt+qCpamQT185igSwQpEv/JnzTjUvhvoKZeMBqy9d4Lg2J1v17trelOgZAm0O1kDwxeuRZ/fUrUQ9mAWCwrAaBD1CPA6pFy1fjr7WC2WZV+rdUoV9WpDAS8Lid1FlPxEudAxKQ2Ub6AGXLkuePXOziGD7GmKRUq1gVD/VPliHiRQtzY9VSEjDODxHLsUdnNrxuSTTvnac+gsRF+6rec7QdS1dV4VqxULOXyyklFz26LhVUAG5VRPwJu3ZfFda5SJo6yp7TM4P5S07w4uln0rE3tk+pzixSIWa59BQQRAfJl40AdMGldzQdv6lPwEtXaQ0GOjsODVjvTCoWjTdW5s2I6P0OA/DmLnus2d3gj/+skqVs0mxnybmaLLmKXMklrCG2hWb93BgerpYy+YewoU3tZvk7RRCwwXFsRUy8p
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc516071-5eb0-4742-f3c1-08ddb3d30c13
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 10:28:37.8386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M0As3ulLtqI1IBSIefqBfcuN62OeKenF8F91gccTjAA0qxtVSs7khYc2TRuZ48HBh9JLOOeTXdoVRCo7mR0KADPfvhCWOGxt243D6LuzSdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR04MB9623

T24gMjQuMDYuMjUgMTQ6MzIsIE5hb2hpcm8gQW90YSB3cm90ZToNCj4gV2hhdCBoYXBwZW5zIHR3
byB0aHJlYWRzIHJlYWNoIGhlcmUgYXQgdGhlIHNhbWUgdGltZSBhbmQgZWFjaCBoYXMgYQ0KPiBk
aWZmZXJlbnQgYmxvY2sgZ3JvdXAgbG9ja2VkPyBPbmUgb2YgdGhlbSB3aWxsIGdldCBhbiB1bmV4
cGVjdGVkIHN0YXRlLg0KPiANCj4gQXBwYXJlbnRseSwgaXQgZG9lcyBub3QgaGFwcGVuIGJlY2F1
c2Ugd2UgaGF2ZSB0aGUgc3BhY2VfaW5mby0+bG9jaw0KPiBhcm91bmQsIGJ1dCBwYXRjaCAzIHdp
bGwgcmVtb3ZlIGl0Li4uDQoNCkJ1dCBjYW4gdGhpcyByZWFsbHkgaGFwcGVuLCBub3cgdGhhdCB3
ZSBoYXZlIGRlZGljYXRlZCBzcGFjZV9pbmZvcyBmb3IgDQpyZWxvY2F0aW9uIGFuZCB0cmVlbG9n
Pw0K

