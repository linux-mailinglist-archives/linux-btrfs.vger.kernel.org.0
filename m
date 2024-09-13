Return-Path: <linux-btrfs+bounces-7990-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A719778E5
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2024 08:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30B0EB24EF2
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2024 06:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BCF1BA86F;
	Fri, 13 Sep 2024 06:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DIPLxAHx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="L8fMXq9j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B488C184558
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Sep 2024 06:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726209586; cv=fail; b=LKHW4M+wDv/cGnC8RV9usv3+rSvNGwCBpcpldK80Q3pcscsZrbrGb3481g1r9FE5OPoRsdKzR2nx3Su60cjccwlA/oUDbNrSoVtpPiZ8APDNMWVaQ82JQDISiBdrQT2AEmZwXUlLJWT4SeSw5McDxzzzjGopHU004LaH8M2eQy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726209586; c=relaxed/simple;
	bh=PgGwkHA6VxAhmDV2vHHPe6/H+0g48Ro8YKNwrjLbaSU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WyZSo1txslWCfm9xQZmuB/e65SWrEXqCAV8m7yWNA+iUPjUu1sPGDI1R8dW12kHDth7hQtx1aoD33zxjluBX6lw5kK4IN3+IIOuBALDro042j5T9kDuMHeBa2sqNVXRRJJ+KB3vxZKt8N4NyDlwnfQLakWHIFdbCOpLiUTyE/YA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=DIPLxAHx; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=L8fMXq9j; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1726209585; x=1757745585;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PgGwkHA6VxAhmDV2vHHPe6/H+0g48Ro8YKNwrjLbaSU=;
  b=DIPLxAHxXXZsT/tXgGu9NmHyGCNRRw2XOS8EmLyefXXXYuPf2ZuoIwTx
   6nTiaZpiWuEygWH+Vp/n9qFNUP6xYRfTv6fYmdh2lRjKHz69iQa0shCUU
   gMQ6uFskOUDxZ3T5r5jHvQKvMuftptkFCS9rVw+PBvQLAIdn5FzFSabU0
   TJsp2K44x71yUk+PMs8rvIKfCK7A7hpNatoZdfE3Ev9xEuuxtaqQtfSVc
   uHCIxjA6xlB6UMFQN0OtcOu8Qg9APIy8VeAX1JJWYF46PLXKVHJWuIxTA
   0CRJslaxXwCDR7ra7/jmo8NZ9OHKg8sEDLOiHhK6taOXG23YHxi2FxqBY
   A==;
X-CSE-ConnectionGUID: IqjJfm0qSVWo5Ma/iM7vbA==
X-CSE-MsgGUID: fDTfF5jGQrK1sLsucFKozA==
X-IronPort-AV: E=Sophos;i="6.10,225,1719849600"; 
   d="scan'208";a="26605590"
Received: from mail-southcentralusazlp17012050.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.14.50])
  by ob1.hgst.iphmx.com with ESMTP; 13 Sep 2024 14:39:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGdWpCGFWRKkQdJyCQ2iTXs70Sk1Nf4MitwyNnOMQl2FtsmiyoGZdYh89GMH8wE3tkac+lsDYsjBSWCBg7fQpdwe6+eNYis4TnSe9t600n9GczcF9C2gCE8YXdSeposh1/qBX1DeDekUoQWR5SjuWh2oH+cCuI5VD+gIHavSYbjX3ZQlnWcf1kLvvlyZdOEuMZ+5brYFay87MrzOMZ0OWccn0i/2kprdFy6T/R9FwCpeSvdL5GscKXFrxigpLO8t7cjE2/9RjVx+A9mjGkoavOhMhubdUPlwEZeQOAS2Q2RbM03tII6/Un8CRE1AGHovsWTXeVVmwzvqEpO1+5/mUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgGwkHA6VxAhmDV2vHHPe6/H+0g48Ro8YKNwrjLbaSU=;
 b=Inteym/CUoeV8Gg39isCYAS7v1PL+3L0kTRFQzwbyZz393JuRKQjimk++NtMVAeXaqshUgRLxrbhTFWLkerjJ0hPRH8n90IclAc7+gyn6ynhlSAD24iOuVVoGUKsiHpM+MMLEX3+CZJcd4WeE/6+Bgi6prSXB20MC4a0wkP25qP1P5uenbMpuq/vVmFmoreAcf5S3MgeOnQo6/NwVZ8JaNT94rRSJ9XIsqDjauK+0Ws+wrC9Z6OFwc/Yt3ctR8hlDQOlqPzoLYBHafvKRToOtRMqURLFUagIPth5qlGqdHM8MoccZoYhqKquhIs3h2ajg2Us5ElPMLZlwNCQt4lKKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgGwkHA6VxAhmDV2vHHPe6/H+0g48Ro8YKNwrjLbaSU=;
 b=L8fMXq9j/JQQuJ7CDljgaSipbZXGq1mw0cXfHciX2fJlZnWtlTrnBsj+pfN0qYCGsfz8RYHuLgl+JF1izbeICvf28MiNXtvvQxwK1koyhPzT2HKI8Lv8K/bnuwNJfmQM0k2tkNSH/uoEu9VNXoXZfj6oJzcHz4OyCmnzGkoH/uE=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by PH7PR04MB8663.namprd04.prod.outlook.com (2603:10b6:510:24a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.29; Fri, 13 Sep
 2024 06:36:47 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.7962.017; Fri, 13 Sep 2024
 06:36:47 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: "xuefer@gmail.com" <xuefer@gmail.com>
Subject: Re: [PATCH] btrfs: zoned: clear SB magic on conventional zone
Thread-Topic: [PATCH] btrfs: zoned: clear SB magic on conventional zone
Thread-Index: AQHbBYMBP9yxp9pgBka7Dir0MXtiU7JVQ5aA
Date: Fri, 13 Sep 2024 06:36:47 +0000
Message-ID: <aecafe2f-a3e8-45dd-8c06-27e5925896a6@wdc.com>
References:
 <98ef25697d52cd3e17b44a846e60eba9e5dfb39c.1726193590.git.naohiro.aota@wdc.com>
In-Reply-To:
 <98ef25697d52cd3e17b44a846e60eba9e5dfb39c.1726193590.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|PH7PR04MB8663:EE_
x-ms-office365-filtering-correlation-id: 5ca9690b-f8b6-4f94-1f6c-08dcd3be7155
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ejNYaXRDOTRZcmMwTjc4Z0wrRGJabkxrdGZwY2NxUG9VR1J1QTJXbktqdkZq?=
 =?utf-8?B?TlNZbVhrWkEvMHB4ZnBtb1I4bzlpN1g5a21MU2tFTXJvMTBCUUk1ZkU3cGpP?=
 =?utf-8?B?VnJMc2pPTWhDbHl3OGlJTFBrUnlmMGd0YkxVdXlZdTFGNUF1ZFhvWEhEeGlH?=
 =?utf-8?B?MzNVRWN0YjZnV0FnV3dFNDd0VTI3WWJRaXpjc1NnMFgvYnRnMjFidEoyaHM4?=
 =?utf-8?B?OHZ2bDlSSEhhWkJIMWNJNXFCc1RvOGRVM3QrNnBEV0xxSE52aHhaYnlncWtn?=
 =?utf-8?B?L3JWUVRXd0dyaDNGV2RGS0xyZTVzMmVZL05va1hoSHFHOVY2OHZteWF2dGcz?=
 =?utf-8?B?QkJjc2c5RlV6WlJpNjVGeGJvNEJEWjNCUjJFWVBPSDQrTGdpUDQ0d2cvS2Rq?=
 =?utf-8?B?M2Qya1ZXdmovNjJBK0YxN0s5b3g3bVNWZXMxSTBTbTZiK2tDSGo4QldwR0NX?=
 =?utf-8?B?RXh0aFFQcERMMWpSZFNaN1ZGeXkrQnpHRXg1MTRTRE9VR1c1N3l4OEZ5aENV?=
 =?utf-8?B?WFc3UWM5N2VwbDMxVlozNkpYQytSb3VSZmdSMTQzMVE5N3FrZmtwZHhEZXJH?=
 =?utf-8?B?b2xaTURWSUw3Z1dYSzBLRVpFb1BzSFZFOVNJdXJOYmlxV2krVS92ajlMODNC?=
 =?utf-8?B?NFA2SWhMRHpiRGwydlVnL08rdnppRGp4RUpPdVJZemZ4ckRac3hPaUNRQW45?=
 =?utf-8?B?TnJsbjVGNE0zbWN5MytRK3ZOYnBCVmdqQTduZXpoZmNqRmZtQXAzTjZleTcw?=
 =?utf-8?B?V2pUeVBFY29ucE5BYmJnV3cwZkFJVGhvRFRaUWV2REZMSGdmS0gzR1pqUTVw?=
 =?utf-8?B?SS9TVTQrRkJDT3FIeEFZODcyRWFtL2l6ZW9LTURPT2YxckR2TEVsVnlFaEJw?=
 =?utf-8?B?Z3luNk4yMTUwbWVoQXZ2c0d6N3BiV0J5a0dZQ2ZPUTNLbW00WlFlNGR3S3ox?=
 =?utf-8?B?ZEQ5SDBkaEt1UDd3OFJRait0RmRMTjNDeE5zbGQvVEFva3hWaUN2aDR5RUVh?=
 =?utf-8?B?WXROMGJrWlV1UVRlOGpSUlJ1QkthVXRrQUNycXRwc25WWkpoUHAxNHAzMkVT?=
 =?utf-8?B?N1NGc1FCNHB5UjVtZEpUQi95dExUbU1JZGIzMy9WOVRBUVpxaEEzMEFKMmxx?=
 =?utf-8?B?Q3hTV1F6MGZRSitDYkxxT2pOOTRPa2NFcGxRMDhPRnNIRXdibWJ3K2pWNWdv?=
 =?utf-8?B?dTBIQVFFaWJaTFgyQ0V6SUdQUFpBM0RlbnFTUkI1VHo0emY5UGtKK25CckNV?=
 =?utf-8?B?N0YzeGJpczB5b2N2QjYxMkVYUlg1Y0VVUEFKeHFTTDl5cm8vYU1TaUdxdXQ0?=
 =?utf-8?B?YnRZY0xzMXhlTDdwMWdxR2JjZks5NGFvUGNZSWh3RkxtMWphQit1dVJNejdO?=
 =?utf-8?B?ZlA1RDhiMWFSb1RnME5lZFRBSkpTaVlvUnRmak9OWkJoY1RWc21ZQ0hzYVBs?=
 =?utf-8?B?TjRDcGk4ZDl5cWxoZUZZUmQ0eEl1bS9NemZzcDhTd0c0QlhMMFZGbnE3YWpC?=
 =?utf-8?B?YkdITTVQYzN0a3Z1L2JwNzRHeEt3YzJIN3E0cUo0aWFXNFMra2t3bmNpTDlD?=
 =?utf-8?B?WkErZTdkZC9LRU1Nb2NJOW1MMzgxYXVIckgwZnFmeHJVamVuZ3NKY0pZdVJr?=
 =?utf-8?B?SkdYZmtHQXVDT2pmeUlDUlY1QnJDYzlyUXdqZTRYNnJBSlNneEU0STBLTWRJ?=
 =?utf-8?B?aVV6WURqOEtySXBueHkzY0pKNWh1N1FDMTAwbmJCRFlEc08wbGtvcEh1YUVa?=
 =?utf-8?B?a0lEbFJ0Zm93WHNPTytCZ2JDVll5MFlVQnlxc0MzeEJJeGtZU1lXY090R1hh?=
 =?utf-8?B?N20xNml4RktFR0xqTERyN3pqRlo1YXgyZldsRVlKNlJFd0VxVU1MWEtHVWQ1?=
 =?utf-8?B?a24yQ2tRajZvVHduTCt4WHVyTFBubXdIU09XenRPV3h1c1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R0swdU4yZ21JcjkyZmV0Wi9vL1lpcHpmY3FncDUvT0ptOEV3VWEwT0krTnFG?=
 =?utf-8?B?R0FlbU5OMW1BVVlpcVRNekpWR0J0NC9MZHdJaFI5OFloWFFya3dISkxmeUY5?=
 =?utf-8?B?S0FHR01qeVJNUitoU3daN08wakVUWDkvS0l0VHh1WnU2aTJLTGpoRFNjRHli?=
 =?utf-8?B?aUZXZWhPNU9PWjFvdFE1a1NmVXhaWitNOEx3QzlZcS93bzlodmUwQWloMEtC?=
 =?utf-8?B?alBiQm1mdGp3YUYyeU5pWHBVOVhsTmRzTXJqNlpLWndQbmUreHpLVHZHbVZq?=
 =?utf-8?B?emYvNVBadkpySmMwekhuYkRHdVVMZW9WckNzSEZwVVRTRDVrdml1NXZTN3V2?=
 =?utf-8?B?Qnl1d2k2dU1ZVmtTSE5veHM1eFEwdE5jVWhFZlczRVNBdERkKzIyL1JMc3RL?=
 =?utf-8?B?M3dwbEltYnNXN3J4NEVWcmZYZUg4R2QyVzN6MlpnSGtETCtEenN1Y0x3TWZq?=
 =?utf-8?B?S1R1dlZHcitZcDRvbTdGckwwQTVRWm1HUmhKZVMrV25YRmQ5VC9FVVdsb3lW?=
 =?utf-8?B?K3FoSDdYT3R0SWgzL0pzbnhoL2pScGJXQUVaT01rRTBhbzF1VHZBamZSRVpL?=
 =?utf-8?B?RXNUYkVaV25hdEdtSTZmT2l6NFVvQ3FhVFlwS1ZzQW1nQWxwK1RrWmN2d0ZG?=
 =?utf-8?B?RE9JSFp2Nmp6SENFWDBDTFFDT240dWN5N0x0M1NWSXlqbEZKYjZMUWZRb1lH?=
 =?utf-8?B?eGlVTGJncndVZm4zRmpDU2pURU54MVRSSTUvRW95VE5FK0h1MnJiQ1NBOVRw?=
 =?utf-8?B?WXN2V2x3TTlKdmlZNmxDdjlMZ29HbFdxVFNZZDBEeldsb1JCL0tmUUJYMXh3?=
 =?utf-8?B?WU53bGpPMGdSa1g3SEw4OUdpc21jUTRUdjN4N2hocE9HRU4zYUxKQjVaRVdL?=
 =?utf-8?B?N3RFWjFKNUxSdXJqUWd0anorYVlzNUZzRW13dXFqVUdtcHlQS1BQSzBjdGNR?=
 =?utf-8?B?cFAxTksvNkQxWUkwRTZJc1RZNmJ2aG1jK2x0a3RSdmFkSFdRc1NKb0NmbWU4?=
 =?utf-8?B?K2pQTmx2a0swaktHUHRwN1RKak5tVjZlSklHdmFkNHN4MnhOY21lRTF3SnFi?=
 =?utf-8?B?Sm5xQ1VyMXFYYzBWclF1TnQxR0ZIVkUvazA2aS9LUkU2dGlJS1ZoV2R0dy91?=
 =?utf-8?B?MUhTa2d1VXJsT1ZaYUI5eXJ1S3phdGxJWC9zQnZTQ0EyUUhRMnhqeVpNOGM3?=
 =?utf-8?B?TTdNRWdnWlhQSE5wWlNYWERtRjNOVldlTUMwMCt3M21rcmFsbjEwVDg2QzVM?=
 =?utf-8?B?VkN3enMzVTFBOXozeS9MZDlKd0lyR3QwM2k3SG1qUWh4NFJYM29MY0pJVVlp?=
 =?utf-8?B?SW42K3ZVQkwwZ0Y0bDlMbkZQbU04R05YVEY4cyt2TVZIZ2dkQzl5K0J6U2sw?=
 =?utf-8?B?MHJ6d24wZmNHamJ6bG0yQkRCbkwvVGw1T3VKNXVDdFdRR0YrN3VQclRpWjNw?=
 =?utf-8?B?TWI5eG5lM3hWU01CdmR6SWhTNHJPdHFibTNnQjMxS2M5MzlnVEppK2U3bFhW?=
 =?utf-8?B?eit3TXdMekI5ZzdNeFc1emIzT1Uzay9saU1xV1k1VVFRYWluN0IrVnJCZzZK?=
 =?utf-8?B?NzNORkhzeW9tTEpqSllaejl3UVdaVHgraHdIQzd5bXFHdEV5cS95OGViUHBY?=
 =?utf-8?B?SnVteXQ2dVlXK2RtTzZCaDhjL2ZZZXJnWUxVTlhMQ0VlSUhCQlFreDVLczdB?=
 =?utf-8?B?SzdLRUI0MkNjaS9WVklXbXFlSy90c25EZG1wNjkxTkt4R2ViUitlZExwOFRr?=
 =?utf-8?B?VGpqTHd2VDdieGY5R05EV25CRmZpbUEveUVPK1lud2dGUWt6T1NlczRYdGkx?=
 =?utf-8?B?VCtKNFJYU3hJMjRWejB3aHVtNmViMmYwMVg2V0lVK2RDZlBiQjBsU2xjd1Bi?=
 =?utf-8?B?MHVTdmNSTjYrSk5zQTNUTTlZSENIQ09uemoxZzlFVFg3R3JoRDZMNWtLRVN3?=
 =?utf-8?B?aFRDVWQwQ1RzdzJjVmErekVGa0JkMDVlTEE4a3pITHp1dVZxYUlva0ZPNFZE?=
 =?utf-8?B?djFTNitFSU5kQ1A3ZTdaOFErT0ZNdUxndlhna2p0VHdyMTR0emNYUE5XTVpT?=
 =?utf-8?B?MjB6QnNxRFpiQUwwb3laSUJZYjc4Z0oyUkdvbXZ2MXlUVFVFb1phSUlxMVJZ?=
 =?utf-8?B?MHptSm9LbGZJa2twcXYvbTBJSWpQcXh0c1owOXRTM28wVGlVRVY3UGJ4Qlds?=
 =?utf-8?B?TFJ3c0hLK1pvaWcrRklReDFRdDlFdi9pcGZqc0syV0pNVHNiajlmWURCTWI4?=
 =?utf-8?B?NzdmaEJHWHdteFJCMWVIWE4yaHBRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4A2ADEE71F4A64BA633651EDD656736@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	t8TunxewFCJIytTR1U2m9VbaSNOwWODkBJTQbjJI+2J2FhVqOhJUaYRy5gsEYXe5dz5g3rPf8elQOS+IK6kMHYi++7k6qgkWlK8LXFr6BrIxCnOk5RarFCJihhY8ZMYhWQjHGJ5ueD4OqD/vqC+SxBrfvTQe0f2nBd4YyFlaFnbAHcQ/3+fjDKqEw5xgYtkxehtLUwW8OgJH6s9lV+voza3AeoSBBWVPn5+yLsANLEY/nMKWUnAEsGshz5Jjm4RV6neplGW6Gis5XD5Q9l0x7NIy4K1hijxGuvGltdVeMybu/NHJj4Vb7MG1FP7XUXVkkUcHpQ39LnZrQp5GQYLsqrXi8c+WgEqDl38g8onjv8r/MUrjL3jY+G6cIOdeWQ04f1LL5nMZaeU/1zljkuCdecaQjehlQMkACWMksDGWnE+ReA4eOSIU6nsOd41TRRuLMRIKwLHZFsZubOhhjZPulmH3Du2GDLVGRb7MvPKNKdMH7sqF/Pu/N2BPCXODP3iT8ZNNGXtZmVXjh7z7x1smBxMKdoq2pmBYbheIRmr+Awu4fqfEFR2hkk/BaoaYIFzf/6zHzZvyuw06Ef1rLMg/JwPGmZMa6DvVwILRV5ExJ0oZfA2P/mX9XVOqN7Ga1FPb
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca9690b-f8b6-4f94-1f6c-08dcd3be7155
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2024 06:36:47.8263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k8j/+DnYIGRr3hPnbXM4UV/HvOmeMtckK/0V3R6ugBHvo478H5QcTSt8d4ZExZdmhmz7QfkRDd9TPHa7GnpLqefPp9zqZa5Iau2lZD3+j1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8663

T24gMTMuMDkuMjQgMDQ6MTYsIE5hb2hpcm8gQW90YSB3cm90ZToNCj4gKwl6b25lID0gJnppbmZv
LT5zYl96b25lc1tCVFJGU19OUl9TQl9MT0dfWk9ORVMgKiBtaXJyb3JdOw0KPiArCWlmICh6b25l
LT50eXBlID09IEJMS19aT05FX1RZUEVfQ09OVkVOVElPTkFMKSB7DQo+ICsJCS8qDQo+ICsJCSAq
IElmIHRoZSBmaXJzdCB6b25lIGlzIGNvbnZlbnRpb25hbCwgdGhlIFNCIGlzIHBsYWNlZCBhdCB0
aGUNCj4gKwkJICogZmlyc3Qgem9uZS4NCj4gKwkJICovDQo+ICsNCj4gKwkJdTY0IGJ5dGVuciA9
IHpvbmUtPnN0YXJ0IDw8IFNFQ1RPUl9TSElGVDsNCj4gKwkJdTY0IGJ5dGVucl9vcmlnID0gYnRy
ZnNfc2Jfb2Zmc2V0KG1pcnJvcik7DQo+ICsJCXN0cnVjdCBidHJmc19zdXBlcl9ibG9jayAqZGlz
a19zdXBlcjsNCj4gKwkJY29uc3Qgc2l6ZV90IGxlbiA9IHNpemVvZihkaXNrX3N1cGVyLT5tYWdp
Yyk7DQo+ICsNCj4gKwkJZGlza19zdXBlciA9IGJ0cmZzX3JlYWRfZGlza19zdXBlcihkZXZpY2Ut
PmJkZXYsIGJ5dGVuciwgYnl0ZW5yX29yaWcpOw0KPiArCQlpZiAoSVNfRVJSKGRpc2tfc3VwZXIp
KQ0KPiArCQkJcmV0dXJuIFBUUl9FUlIoZGlza19zdXBlcik7DQo+ICsNCj4gKwkJbWVtc2V0KCZk
aXNrX3N1cGVyLT5tYWdpYywgMCwgbGVuKTsNCj4gKwkJZm9saW9fbWFya19kaXJ0eSh2aXJ0X3Rv
X2ZvbGlvKGRpc2tfc3VwZXIpKTsNCj4gKwkJYnRyZnNfcmVsZWFzZV9kaXNrX3N1cGVyKGRpc2tf
c3VwZXIpOw0KPiArDQo+ICsJCXJldCA9IHN5bmNfYmxvY2tkZXZfcmFuZ2UoZGV2aWNlLT5iZGV2
LCBieXRlbnIsIGJ5dGVuciArIGxlbiAtIDEpOw0KPiArCX0gZWxzZSB7DQo+ICsJCXVuc2lnbmVk
IGludCBub2ZzX2ZsYWdzOw0KPiArDQo+ICsJCS8qDQo+ICsJCSAqIEZvciB0aGUgb3RoZXIgY2Fz
ZSwgYWxsIHpvbmVzIG11c3QgYmUgYSBzZXF1ZW50aWFsIHJlcXVpcmVkDQo+ICsJCSAqIHpvbmUu
DQo+ICsJCSAqLw0KPiArI2lmZGVmIENPTkZJR19CVFJGU19BU1NFUlQNCj4gKwkJZm9yIChpbnQg
aSA9IDA7IGkgPCBCVFJGU19OUl9TQl9MT0dfWk9ORVM7IGkrKykgew0KPiArCQkJQVNTRVJUKHpv
bmUtPnR5cGUgIT0gQkxLX1pPTkVfVFlQRV9DT05WRU5USU9OQUwpOw0KPiArCQkJem9uZSsrOw0K
PiArCQl9DQo+ICsJCXpvbmUgPSAmemluZm8tPnNiX3pvbmVzW0JUUkZTX05SX1NCX0xPR19aT05F
UyAqIG1pcnJvcl07DQo+ICsjZW5kaWYNCj4gKw0KPiArCQlub2ZzX2ZsYWdzID0gbWVtYWxsb2Nf
bm9mc19zYXZlKCk7DQo+ICsJCXJldCA9IGJsa2Rldl96b25lX21nbXQoZGV2aWNlLT5iZGV2LCBS
RVFfT1BfWk9ORV9SRVNFVCwgem9uZS0+c3RhcnQsDQo+ICsJCQkJICAgICAgIHpvbmUtPmxlbiAq
IEJUUkZTX05SX1NCX0xPR19aT05FUyk7DQo+ICsJCW1lbWFsbG9jX25vZnNfcmVzdG9yZShub2Zz
X2ZsYWdzKTsNCj4gKw0KPiArCQlpZiAoIXJldCkgew0KPiArCQkJZm9yIChpbnQgaSA9IDA7IGkg
PCBCVFJGU19OUl9TQl9MT0dfWk9ORVM7IGkrKykgew0KPiArCQkJCXpvbmUtPmNvbmQgPSBCTEtf
Wk9ORV9DT05EX0VNUFRZOw0KPiArCQkJCXpvbmUtPndwID0gem9uZS0+c3RhcnQ7DQo+ICsJCQkJ
em9uZSsrOw0KPiArCQkJfQ0KPiArCQl9DQo+ICsJfQ0KPiArDQo+ICsJaWYgKHJldCkNCj4gKwkJ
YnRyZnNfd2FybihkZXZpY2UtPmZzX2luZm8sICJlcnJvciBjbGVhcmluZyBzdXBlcmJsb2NrIG51
bWJlciAlZCAoJWQpIiwgbWlycm9yLA0KPiArCQkJICAgcmV0KTsNCj4gKw0KDQpJcyB0aGVyZSBh
IHJlYXNvbiB3ZSBjYW4ndCBnbyB0aHJvdWdoIHRoZSBkaXNjYXJkIGNvZGUgZm9yIHRoaXM/IElu
IHRoZSANCnNlcXVlbnRpYWwgem9uZSBjYXNlIHdlIGVuZCB1cCB3aXRoIFJFUV9PUF9aT05FX1JF
U0VUIGluIGJvdGggY29kZSANCnBhdGhzLCBpbiB0aGUgY29udmVudGlvbmFsIGNvZGUgY2FzZSwg
d2UgY2FuIGRvIGEgUkVRX09QX0RJU0NBUkQgb3IgDQpSRVFfT1BfV1JJVEVfWkVST0VTIGZvciB0
aGUgd2hvbGUgNGsgb2YgdGhlIHN1cGVyYmxvY2suDQoNCg==

