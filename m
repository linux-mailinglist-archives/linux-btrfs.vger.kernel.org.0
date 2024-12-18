Return-Path: <linux-btrfs+bounces-10549-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA62A9F6245
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 11:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BB4D18880ED
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 10:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F60199934;
	Wed, 18 Dec 2024 10:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HiKF4ZmG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="G0jnbuWy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E12194C75
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734516035; cv=fail; b=BNt254wTfO6a9BzNWutSxYVm7+pdqiCKYA/HsTPPU5XGQ8yvqFGTcNSGxnDtCyzmbx0MLBM0uI2iSBJYwAIkZfOve0hxPNjPOTQlinE8+9/0iD125PimpBGkJgc/pYMMgURpTIYOP/WdMhD9GDbPHJAynDuWPDPzA1LRP+Dgx/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734516035; c=relaxed/simple;
	bh=f78QxcXa3fhytAyGjL8CohDiDwhpXXlPjmwgiwlZ+aA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gCxodce1RNR9fSM5w7EYweAOSLxDKIjuav3Wm+iIHFucSzyrUIsADJ9eLq9dy3LpBx1fv20T1TJddqkhXAc9zF5xSyy4djPwWUHAgtC6Aal4UKIk429cgo2y5fwN5qSKKhirbgKcmNzUyaLtp5QHYja1qilx3b9gvALLLFWQx1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HiKF4ZmG; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=G0jnbuWy; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1734516033; x=1766052033;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f78QxcXa3fhytAyGjL8CohDiDwhpXXlPjmwgiwlZ+aA=;
  b=HiKF4ZmGtY61c+uSgePhXQUCB7+RLPkNDxF+f8GggbrwJ2CbvB2w5jRB
   i9SHLquvTinJyeGHwPKnwz8O/TtnYLY1YLvVi+UC5VLLkDO9SSbOYYpZ2
   kqxdAYRXIKxKXb2sYPuJJIlTbK1dRF5I+KU8NpFAVREhTjXonG1L3xetd
   AOCzVQjZLo9L3dHXv5bvZyYcl2/mD+op/wZPLLtl8FEXuzOlAPhjWWXJG
   Ht7Ze4Q+i7fjcFrscXS6PL/yq72cl6bLZoOw35DTvMUpiqTaj9ObBxlxX
   st3lySnxoUrRRZMDffhP9yymYzSBMjr3Y4J9+/imcgoEAWxRYYaAiOhkt
   A==;
X-CSE-ConnectionGUID: XQtk7KswRCijeKsip76BRw==
X-CSE-MsgGUID: xiTIDcg8SuCly6Zsn+rMdQ==
X-IronPort-AV: E=Sophos;i="6.12,244,1728921600"; 
   d="scan'208";a="34655954"
Received: from mail-centralusazlp17010003.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.3])
  by ob1.hgst.iphmx.com with ESMTP; 18 Dec 2024 18:00:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJ77uXRaBcHKay6F8P0BgqHyEW4yRzPZ71vTKYxzVQIWlYXmsT3SHe87R8SmGKWLpH6UN52fDhRVnWhxoA/3lcFu3HT5DtiJvYLAlDXsNk35bVROcjFR6nHKPNbf7UbymsRckYRIOEl/1AyW+RDPGcUeWsGoqbUEUryReh8OFDmpNXbR2dPvLJzC0WdybtAkXc2VTLRQ3zs/tFbY3Hsm1wN64AIgR4wBXID0A/KgVG7ECcj331Go7IhnaF+WAZ6GE5UMnY584cpfQiUu4zSQnn5BFYcpr0DZjus8x5ZPa6g4vSoOt6g/3RBuB+OJ7I5Iw7ZsF3N1gTJ+OmpxD5DUWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f78QxcXa3fhytAyGjL8CohDiDwhpXXlPjmwgiwlZ+aA=;
 b=Oqxkyuv4eBxt9OKRWIK/MH9BzV67+UAKGkWyZUu1asJdyZ76ELkz/2JjvdVShYgydBylSzab++Bea0F4JYDqUmGNgclwWqwnkrKAKDmEh5YFZZ+SAkr55BToCF3fHMRSJvsrLSqMMeZBioRatmEtYliaX708+AmadD5s6f7O5GNCEcaGXJ3PlN5FXpwqfuXouj28J/AfcCnTJovxjVWe1IOixCHJlQD9R7jGqUNKrc6zr2OrCCteKqRD7AnGpGJb/QEiGwE4pA/Oj85EGdfHPOOBUNdePX4ocjk8e9raOcj4WCWVDATW99X4KMHKpvjTgMwUTKs4EA+QrqZHJCPEEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f78QxcXa3fhytAyGjL8CohDiDwhpXXlPjmwgiwlZ+aA=;
 b=G0jnbuWyi+Pj/ZClQowimP8sITiwyzW72k25T5y5MwV9vswrXQUd2BDVLvCF8W0xnuyL5WXTjJsbz+c6ruW5/qjkwBypPfBT3wvXkTsqn3A+vbzgXsRfn0opygGcA2TIMth2R9SQaGVAVkbEYkFJyJAJqHA0axSDdj2El0jpBds=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6443.namprd04.prod.outlook.com (2603:10b6:5:1ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 10:00:30 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 10:00:30 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>, Johannes Thumshirn <jth@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Josef Bacik
	<josef@toxicpanda.com>, Damien Le Moal <dlemoal@kernel.org>, David Sterba
	<dsterba@suse.com>, Naohiro Aota <Naohiro.Aota@wdc.com>, WenRuo Qu
	<wqu@suse.com>, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 08/14] btrfs: don't use btrfs_set_item_key_safe on RAID
 stripe-extents
Thread-Topic: [PATCH 08/14] btrfs: don't use btrfs_set_item_key_safe on RAID
 stripe-extents
Thread-Index: AQHbTGtO524p8aoAt0aPhr9t93fs4rLqpw2AgAEncoA=
Date: Wed, 18 Dec 2024 10:00:30 +0000
Message-ID: <0f7391ae-9c76-4492-8f8a-23735baee247@wdc.com>
References: <cover.1733989299.git.jth@kernel.org>
 <1b225c76de3d41571e080a03d971a961de26d9bb.1733989299.git.jth@kernel.org>
 <CAL3q7H7+AFOfQs090Ta=tv+H+D7qObZh2gBOfmzN3hcxUmrxjQ@mail.gmail.com>
In-Reply-To:
 <CAL3q7H7+AFOfQs090Ta=tv+H+D7qObZh2gBOfmzN3hcxUmrxjQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6443:EE_
x-ms-office365-filtering-correlation-id: d66edca0-0355-4c3c-5145-08dd1f4ace29
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cklCWEJyZHBrNjhuYXZhNHZub2RMVm9VMG5JZUZObjZTeFRqVE5NZzR0UDlF?=
 =?utf-8?B?TnhjZVdpRE9lMm51THNtT0ZmRUpKMUIwNFEzVTF2enA4eEtYZUovWnNLWEw4?=
 =?utf-8?B?cmNjNnAvTzNabVV6VUN2SVgrS2tscHdiYzVMMGtKNXpwcWZvRmo4S2tkcko2?=
 =?utf-8?B?WE1DMlp0US8yVlRjL2xoNXJBc0J3d0xROHZxT3h4bThLOEV5UHFwdERYYldF?=
 =?utf-8?B?V3lPcVJQeloyL0ViOFUzZ0JmSTdWVWs4VHdGNzhFWHZ4c0hGMlo2NXRHc2dr?=
 =?utf-8?B?aTh1c0NGY2Nhb1lqK29QS0VNMjFMYjF5NFJVMmxWb3F0SDl6QnNScFZrTkdm?=
 =?utf-8?B?UXBzSzBUWk55ZFVDSGI5ZE1FS0lKam10S2gxbFBJZmRnNURnM2xONWhOVFl0?=
 =?utf-8?B?UlppRk1Iajk5TnBvRkZRejdHaFA0bFY2SXBKekZiVENENVIyTy85WTV4MDVU?=
 =?utf-8?B?Q25JblhsZkw3QmdxZ1Fsd1ZTTHNMdnB3aG5JNmJJQnR1ZEFTMjdtYTFveG4x?=
 =?utf-8?B?cHJNaFFuWDNPWTFFT0lYMEQyYTJXeFRFaTNMaU0vQXR6Yk5mdWlNUU9BSElj?=
 =?utf-8?B?TVRnTFowR1FReDhhejJ6S1pKYmFXQ2RGRmlRVTVCdXg2Z0JWYmljUlYzcmlH?=
 =?utf-8?B?cWw3a2lUTmtDaWNuNWUvY3RyMWJuMXF6Y0hLbkVwL1FZR0l2aDUwMUIyZFRM?=
 =?utf-8?B?RHYraWh6NkRqNDJuNERxL2xMc0xxNG5QMEVYQXpwaTVBY2JWT0tmQjZFbG0w?=
 =?utf-8?B?a2xDeENtc010cGFEdmVXSzFCSkJKWVcyRE9DRFhPNmE5U3NkRFNucmxTWnNV?=
 =?utf-8?B?bnc5bzgyc0dnbjdReTJLS2d6SmtxdEN3UmlCaFQwNFV6cUNrR2lGbGtYeW1k?=
 =?utf-8?B?YmZBQ3Rlc2FJTmZaRitXcHpUZ00zaGxDQXhtSW50U2ZqNGFSWXJEbHkzV2NM?=
 =?utf-8?B?eHlSN3QyUEVEbXkyNFl0dDhmaVBQUlVuaWxQWTRVMHlKZElCMG9VTk9ZZ3Jl?=
 =?utf-8?B?eVdKOWFDeGFPb3ZXV3FUbmNuOEc3QnBCWC9OTkxoOElySFBnL3NEQVh4Z2xs?=
 =?utf-8?B?MnplaWUyMFpZOWRXeGhpcmhGVXRKcmlvbnlEMWphVG91dC9WazV4TjBrbVpI?=
 =?utf-8?B?SmdGdS8zeC9JS096dUFLK0EyTm9vbFZCdWxUdDlndlVTMTZlTVdaQzhRM3lx?=
 =?utf-8?B?dGlzakNic0NPZlZmODJTS3BHUHFKUVVRSndpOGh6OFNZZkdGY0diek4xRER4?=
 =?utf-8?B?dXQwOFljSnA2T2RTSGZuRTUwb1JHcHNaYTlDVW0yRFZFRkcxalR5aXgrODc2?=
 =?utf-8?B?ZElvNCtaeXZTUkRkWHZhaHkxdFUwVHZFenZzMExCTVFMMlY0QUdUejlPM21D?=
 =?utf-8?B?anJZcWJlUHM4dWx4SUtBQ1pGaEpNdThtaU12MjdMK0dmYTRKc3pxY2txbXhv?=
 =?utf-8?B?NExZbnhVYzdmQ2NubUdRTEk1R1N5SmE4T0Iwem4zQ01Ja0lCMmk4T05BRW1H?=
 =?utf-8?B?RDh2YjBQanRnTzhvZG5lZXIycitadmw4c0d6TStLZUN5R3VCVi9EVzU3N2RV?=
 =?utf-8?B?TExoUHNFQWd2TUFuTlorbmR2b0lDTUJuenpuQUcxdHVsNmdTaXkyV2M5elQx?=
 =?utf-8?B?T211eFZqWXQ5QmFGb3c1TFQzZC9tdDQwVk9wYjFIQlpmcE9ndk8yYjRnWHRS?=
 =?utf-8?B?UXBPS0hGblAvc0JHRHBJUXZQQlhRZGliYmluaEp3d1o1ZHNiK0ViRndhaW11?=
 =?utf-8?B?TE5CUndvdVdJd2xXeHF4ZDRMYjF1RzFKSk1UNno5cldXRDc0Nzhtcm5YUVd2?=
 =?utf-8?B?N3dUU0lWYk1RQnJQL2lNYXIySXp3TW1HL0Yzb1ltR1J1NWtmTnJvcmE3WHdX?=
 =?utf-8?B?R3JqOE9IWTJGSnlCeDBNNjVUalhaUDYyVC82OTlRYk5La3NuWlYvYXFvMWcy?=
 =?utf-8?Q?11jHIOmYmyurKgS51jrd4gme1lXhIp0K?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RDVEUWlBeUJrWlJnN0Fzb1lUSldLdU1Zck4vc29yalNlNmxGUGRacWZObHN1?=
 =?utf-8?B?cnJpQ3ZXTkhRVVFrdUZ0ZUk0N1pSZ2UxampyQmNmb29oTC9XNlYvTGVUV2k5?=
 =?utf-8?B?eEFrZmR2N3IzTHpNZzVSOHB6cWpwM0EvbzFuZ1AzV2dhV2ZEMGRRQnpDbGlL?=
 =?utf-8?B?bnZjU0x0Um82MWhXOWM2UVhNVDh4d3dKQ1lpck5PMWVrUEd2MDQwVnlDc1pB?=
 =?utf-8?B?YnVVNUEzb2RFQXFDQWZiamRBc2pVNXBjV0oxQXBtOGlpTnI0RGNVVktuYlJn?=
 =?utf-8?B?UkFFaFlBWWxSUHk3QUo3ZUorMzZLTXRVRWIwVWdwZWJYTG5FOG5ZUDloNlJo?=
 =?utf-8?B?eVR6dndaYVd6aGVSdHRoRmwrWjZJelFKd2lKS0t3S3lCT2ZEYVkyK3BtZ3hB?=
 =?utf-8?B?Z2xxa2g3YzdGcDBld0s2RFl2TTBLQ2E3YjVWWnQ5ZWk1NlBoZk8rYlErSHl6?=
 =?utf-8?B?Wis1QUwwNUxBcGF4N242S2x1Vk5MRkJqY045YW1qTU5iQVpITThOa1J1dnA2?=
 =?utf-8?B?b3lvQkp4ek1LU0FlL1F3ZG83blVQLzFqYksvbGVtU1JvV1dOaktmSXRsYVFB?=
 =?utf-8?B?RzVqeDZQZ2gxZWpEeVNSemlJY01NdENxUkVVNWVpVHNJT0twS05xMlBjVE9B?=
 =?utf-8?B?a00xcm1mUURCSFBTUCt2VUV5Skdkek1Uc1dHdFJneVRrakY3TG9EeEZtb3Vk?=
 =?utf-8?B?NGVKYVhoQis3L3NZRG5ubkhNdmtQeG1BeVptelByZXpkcHROMG5maGs0NUVS?=
 =?utf-8?B?dTdFcG9IUHBXNWVCdU1USXdzaTUyRUFiTTMzMWRWejB1c1M5RFhXSjZYekho?=
 =?utf-8?B?UU5XaXdwRHpBUEYxNVN5c3Z2OVhzRHRuQ01TRENCeFZkSEFUTTVmYjZVRnZp?=
 =?utf-8?B?L3BlODBHNlJkeFB4MlVQejZMY1JabFh1ZlhMUUpteTVDK1BIK2p6citINDBw?=
 =?utf-8?B?cndPQlFUc21nZm44L2ROTjhqMlhBcW9uRjVoSHo5ZWFTR1JRYVBOUkU0TDdT?=
 =?utf-8?B?VlArdXRKQlJDN0oxcm5XU1F6a3pzblp0R2xaUlFCY1l6amJBYlF0eFVBcERP?=
 =?utf-8?B?blRXRTAzZ24wMlM2bnFtS09wekYrZks2bGF6SmpINzByS0JjOW9UdjFvNU1J?=
 =?utf-8?B?N29EZTVCa09TcnFRcTVpRHpLd2NUUHF0Ty8yOUdvSUJOc3AyMk4yRmtZaU03?=
 =?utf-8?B?MWM5Q1Z0NVNOREphVXV6K1hlRlcvR0lEWWYzNkU0OVVZR1BjbzlIN3l6Z3M0?=
 =?utf-8?B?UENJenZrQ3dtdkV0RGpBUVNzeEZ4bUNjSFZwZ3dOUk1PcEl6dG55KzMzK3pV?=
 =?utf-8?B?QWlvbjJJMmhoSVBPVXBDQm9xL0RhWTUwckNCajNEVXMxajFxRFlwZHJzTTF4?=
 =?utf-8?B?NWVaT1JBcmlGZW40UDlwUnI3SnRXNjdYcUJWT0Z6QkJyZHFoN1RqOVE3U0NV?=
 =?utf-8?B?cmoybnpVRTBGUW5Ga0dtcE1QVUpna2RzY05JYlNROHMyUkNNdmdCeWtoc1U2?=
 =?utf-8?B?dGRoNlJxU3hXM1VJN0tnR0RxbUNRcmpKSFhyaDBkVmZ6REdMRzA1L1kzWkw3?=
 =?utf-8?B?UEljeDZqMzVrQWVnOVIvTWMxYzNqb241MDNqUkJWSDJqajlRMklDbjJZbG9y?=
 =?utf-8?B?KzNnaTgzUDYyaG81dUt0ZVZKK2RLdEk2N2FxUzNHMUFEbkJtc2lnTFZ4RVo5?=
 =?utf-8?B?ZXZ1bDFSNmgzcEYrbUxHbzNma2tMZTBGa2lMd0dUWUc3Q1BLUGluQWtuTEhI?=
 =?utf-8?B?WnlVOU1EN2MrVXR6U2xwck5xVFEzYXNLMDNreS9vdkdjR1ZHWklycWNHTTZu?=
 =?utf-8?B?VE1ZMXAwVU1ESXAyaDFOZFNldWkxOENGbVhxQktTUCtydkpKUDBpUmdoVVRM?=
 =?utf-8?B?Z290TnJsWllWaEk5YzIwMFpVRmVXekxMQ3h5ejBvN2VyQ2pZcTZId1RGbG9m?=
 =?utf-8?B?R0FqZmFtQ1JFUlBESWlhTkFmNjdmaXZpajRjNElIV3Z1ZFNDRVlENmVTaGpC?=
 =?utf-8?B?d3lBMmUzL2c4aXI0WHpsS2lVcDlWR3BSRnJYMGNsSnRvVjFFQVkreG1objJx?=
 =?utf-8?B?MzNTU0FBTEh2eWRYL211SkVUWWZieTZqeS9SOVFpd2dLZ3ZybDZ5NlRET0dB?=
 =?utf-8?B?Q2pUeGljRFRjVmtidXdSNEFMVHZYTFFUVU9qVDlJbFoySXV1TWFUQzYwUXhG?=
 =?utf-8?B?RXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F13F10BC1486694080B4FF776387DAC8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xqtfoJgPn7uf3tR6/djyvhpAYB7FecsWM1rLuKWFnPmQsdEKWgZnzRm/7lfR/p/VXjCQ1/kwO8crcVE89fJZilVHOiOKow6Ao8VLhg2lddJKkhN1NvRy9g1MUB3JW9KSEwHj+pfed2W0vSx8Ac0qNf2gEZinmIBCypn0fIjyzp3KOtkVsAUW8Z7p/bpDuUnlheGr4X37hwZf07GejP2+rH/4ykEYnb5B7PJkyRi6U64jJ6fujFgfa9DVO1Ntap74mVY3wZOgqP5oTD2ssMWYtVYGQSGKlJgf2Hexm9ey4x2AFdPIkbYr06e//8YuCHJN0f5u1bAkoexnNdfD5grQYLti0IM5nQElyAMt6gDbBiGmILsVWkPp6fQxonj4h/o4gk+TklYejsGP6shvsYqqS2OwEhsbpdoobqVVN+aRWeSu4cY5vIRIU6Hnu9jyGOyXRet62QUeuaoPZEfXUOVdYjtumEwijf2I4gZg3ggtI/7h5aD9qcCgtJZlSmzmiOQtVDa9sTHyofmqi/ILlcg/YVzW8YWM5LihLDbpP4E/hO+aboLquNp99As6U7bZMoDQVu7rBjFy/uVpyp9Wpd/YSMkYwoTAsM1cYccq31WGoipF/K7V1f43LAvKM2FBZdLr
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d66edca0-0355-4c3c-5145-08dd1f4ace29
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 10:00:30.2994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t+wh2xcDx7tgu1KLX3aVpghFV6gpY9oyMjnbzJdN1yDtR5mGKxtqVa6Pe9/l1znad8krfnumGD5CdWXmcw6Ja/IYNI8DQT2sYMYcpbty9pE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6443

T24gMTcuMTIuMjQgMTc6MjMsIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQo+IEFsc28sbG9va2luZyB0
aHJvdWdoIGFsbCB0aGVzZSBmaXhlcywgYW5kIHByZXZpb3VzIG9uZXMgZnJvbSB0aGUgcGFzdCwN
Cj4gSSBjYW4ndCBzdG9wIHRoaW5raW5nOg0KPiANCj4gVGhpcyBpcyB0aGUgc2FtZSBwcm9ibGVt
IHNvbHZlZCBieSBidHJmc19kcm9wX2V4dGVudHMoKSwgYnV0IGluc3RlYWQNCj4gb2YgZmlsZSBl
eHRlbnQgaXRlbXMsIGl0J3MgZm9yIHN0cmlwZSBleHRlbnQgaXRlbXMuDQo+IEJ1dCBpdCdzIGJh
c2ljYWxseSB0aGUgc2FtZSAtIHdlIGhhdmUgaXRlbXMgdGhhdCByZXByZXNlbnQgcmFuZ2VzIGFu
ZA0KPiB3ZSB3YW50IHRvIGRlbGV0ZSBhbmQgdHJpbS9hZGp1c3QgaXRlbXMgdGhhdCBvdmVybGFw
IGEgZ2l2ZW4gcmFuZ2UuDQo+IA0KPiBJbiBmYWN0IHRoaXMgaXMgYSBzaW1wbGlmaWVkIGNhc2Ug
b2YgYnRyZnNfZHJvcF9leHRlbnRzKCksIGJlY2F1c2UNCj4gdW5saWtlIGZpbGUgZXh0ZW50IGl0
ZW1zLCB0aGVyZSBhcmUgbm8gcmVmZXJlbmNlcyAoaW4gdGhlIGV4dGVudCB0cmVlKQ0KPiBmb3Ig
c3RyaXBlIGV4dGVudCBpdGVtcywgb3IgaW5saW5lIGV4dGVudHMgb3IgaXRlbXMgcmVwcmVzZW50
aW5nIGhvbGVzDQo+IChkaXNrX2J5dGVuciA9PSAwIGluIHRoZSBjYXNlIG9mIGZpbGUgZXh0ZW50
IGl0ZW1zKS4NCj4gDQo+IFNvIGl0IHNlZW1zIGJ0cmZzX2RlbGV0ZV9yYWlkX2V4dGVudCgpIGNv
dWxkIGJlIGxpdGVyYWxseSBhIHJpcC1vZmYgb2YNCj4gYnRyZnNfZHJvcF9leHRlbnRzKCksIHVz
aW5nIHN0cmlwZSBleHRlbnQgaXRlbXMgaW5zdGVhZCBvZiBmaWxlIGV4dGVudA0KPiBpdGVtcyBh
bmQgcmVtb3ZpbmcgYWxsIHRoYXQgZmF0IHRoYXQgZG9lc24ndCBleGlzdCBmb3Igc3RyaXAgZXh0
ZW50DQo+IGl0ZW1zLg0KPiANCj4gVGhpcyB3YXkgd2Ugd291bGQgZ2V0IGFsbCB0aGUgY29ycmVj
dG5lc3MgYW5kIG9wdGltaXphdGlvbnMgZnJvbSB0aGUNCj4gYnRyZnNfZHJvcF9leHRlbnRzKCkg
YWxnb3JpdGhtIHdoaWNoIGhhcyBiZWVuIHRlc3RlZCBmb3Igd2VsbCBvdmVyIGENCj4gZGVjYWRl
Lg0KPiBEb2VzIGl0IG1ha2Ugc2Vuc2U/DQoNClRvdGFsbHkgYW5kIGJlY2F1c2Ugb2YgdGhlIHRl
c3QgY2FzZXMgbGF0ZXIgaW4gdGhpcyBzZXJpZXMgd2UgY2FuIGNoZWNrIA0KZm9yIGNvcnJlY3Ru
ZXNzLiBMZXQgbWUgdHJ5IGRvaW5nIGEgY29weSAmIHBhc3RlIG9mIGJ0cmZzX2Ryb3BfZXh0ZW50
cygpLg0K

