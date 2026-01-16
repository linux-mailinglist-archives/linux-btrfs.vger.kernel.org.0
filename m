Return-Path: <linux-btrfs+bounces-20609-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0F2D2CF75
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 08:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 727523026514
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 07:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8999F34D926;
	Fri, 16 Jan 2026 07:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="c9vfZfOt";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="uSKPcJz8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EED9344035
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Jan 2026 07:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768547414; cv=fail; b=c1rD6gdi0Nnt7bTcjXG/9EIMxSQSuB3YjM6pbSva6edyaRx+uXZcqFLWtbysZCdXaufEj0I8mUVTgI32F2TSw9dDlggkr2aAmwAlzO+nUYBeAfdOAW3n7wzSdhG9FS5/fAYj7Ho8866SOFTk84ytwku2dAwLu/hoJm+PBSHQDqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768547414; c=relaxed/simple;
	bh=eSY8wc8nuYVW8EA/ZsU4L6dh/RN4d9f75hmW+elX3/0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qY98L23GPHDP71vzm45hQfAxxHI5GLfz1+5VcNitfA31EK0H+BPPdFj/eAcgKUurYp9pkDgMRkYQdVVyH1mUgYjGt/rgWY02laz9xTBpdU+GOCduteG87CxBZWqcUHcjZeY/wwcAz0fi2dDdzZTS0cr4RvauNDhojaGM19OSpj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=c9vfZfOt; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=uSKPcJz8; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768547413; x=1800083413;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eSY8wc8nuYVW8EA/ZsU4L6dh/RN4d9f75hmW+elX3/0=;
  b=c9vfZfOtt52K6HqNa01vR3IypmuQ+8hy3WDw3b9hkJCbDgOtwJ+jKExz
   3cJbO3zVSuL+ZYDBaaxs6AmlGNSFdSrIF0R5SO6iDnCakddhGHvdArPDd
   p4AewGOSeUwJkYn5cE8M8U4LUVODLTvUmrqNJLeOvtYcz0QZgd5c+n7iC
   MJWm9aMYOFmmcM2q5zrR3nwB9jms3wIjQDDDta7ZOlibNqSYx5Iv4bF8l
   C7firMeL6rFKvANa2hy8r8yX4ChLLRX/mufUPZrd/AIDf/pseEvuWFcKP
   BohdYHEugQtLAtQjLIHRm9zXdWxIuX1f31puTS8cZ21huKQk6D1jRps/C
   w==;
X-CSE-ConnectionGUID: 26oj1kn2S0uG65SqJG0t4g==
X-CSE-MsgGUID: +RtcJWwdRxmgavXoYMT+JQ==
X-IronPort-AV: E=Sophos;i="6.21,230,1763395200"; 
   d="scan'208";a="140092432"
Received: from mail-westus2azon11012052.outbound.protection.outlook.com (HELO MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.52])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2026 15:10:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UYxDgzeU+bE1UPwYG/TlyjONibb/khg+CgbAX4Y99f2u3A93p9rteYyGfbZPaEw1Y5M2/kPQkbZzwxHoBBcIzb3EoJqFX1T2HaYO3m99Q5QSbIuJT8JhEAHEChrEFIuAsCgf6cT9BGwz7Czln8hv+yr1Tqa2NkR918u9qni9N3KCbT3/ZL3eCIQgH3x20YcPxC7gQfiLvJXGPOE4S1/ntGUSJUZVynCCM/JzijrPYi9xMbQTbHn2WIYyAseMzd48oF5cNMyEiASheusfKpJ6O7vCyxZx1JOSva1ikPdG5Vv54q+oLK/MsLQooEoY4wPZhYXxOQAjsRe51hKYzUpCxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSY8wc8nuYVW8EA/ZsU4L6dh/RN4d9f75hmW+elX3/0=;
 b=FCXsWCDDKVFxLenp0Qvy//Tr6CjaVwsXFVhPnPaSfT890Bshl1+NcPgN8T3vQvIrbBjEfUlK9vgyhAyTrylk6Pvrd31fDMlZu+nDoq8ArqX7JXKnrDj1LewwBRpcdgJbI1RC6WbTUb3JMZr/B2FfiK3CbAqcOHTjgu0NiTvfElOVmqoKu0Df406Y+Kj/Qtehy/7LlpqrtlsvnTCm9WEkqIxEsjim+/4YA2foVPet/IFVqmF/9d9GNaKRsLRLZGlKZAdm6W6Ma3nIlVVxeZIWQbGxdqDdYtm25jU6o/gDW1B62cOJdFbvAGbxuA0ypszFXTk+pKPwcOw+LaK2C7ByPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSY8wc8nuYVW8EA/ZsU4L6dh/RN4d9f75hmW+elX3/0=;
 b=uSKPcJz8j9vPfplP/uKTsh79i5As9IFUezSBYc5qH0Wy6i5MngFP516LycRf15MKoQQa2egwy4qbpEVLaDghd3zQhBKU/RYw/7YJQKvk92OLxenwjxTF92BGYtTFJr6lbwjP+5u3hMs62kXQXow/1NPvNm+Lw7aC817kgLZ59Zk=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by DM6PR04MB6777.namprd04.prod.outlook.com (2603:10b6:5:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.2; Fri, 16 Jan
 2026 07:10:04 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9499.004; Fri, 16 Jan 2026
 07:10:04 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Boris Burkov <boris@bur.io>, "fdmanana@kernel.org" <fdmanana@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2] btrfs: add and use helper to compute the free space
 for a block group
Thread-Topic: [PATCH v2] btrfs: add and use helper to compute the free space
 for a block group
Thread-Index: AQHchmlIPLDBGXEe4E6RvQEY0dRWdbVTzlQAgACTHwA=
Date: Fri, 16 Jan 2026 07:10:04 +0000
Message-ID: <04469920-1dbb-46d4-ba8a-b4ac986ffff1@wdc.com>
References:
 <2ba3b023e186d4eec78b8515bb375f310b4b2390.1768512027.git.fdmanana@suse.com>
 <9f70166505b58147e580c51d0ea498b0e9f30ea2.1768513901.git.fdmanana@suse.com>
 <20260115222309.GA2118372@zen.localdomain>
In-Reply-To: <20260115222309.GA2118372@zen.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|DM6PR04MB6777:EE_
x-ms-office365-filtering-correlation-id: 67759466-0786-4994-e115-08de54ce45f2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WFlXQ0Y2eEJyc05FVUZCNTVvTURCTmJyL2djSGtCSlBKL3RWWmxXNHFCK0kx?=
 =?utf-8?B?dE9TWTVtaWwxdVFpTHlYY09IRno5SHpudzJYWndYUFBIZ3JxZHVickJBZ2VN?=
 =?utf-8?B?MEsyVHdESG5SbFhPYjB5c2JqdWdUdUwzODF2am44OWJGeE5xL3FRbE9JMHRh?=
 =?utf-8?B?dkphVnBYYktKeDlwaTdRejRUdWdHUGhTblFrVTc0QXd6am1jMHJVRHVXYUpQ?=
 =?utf-8?B?dDIvOE8zYitUN01XelR1NUlUSWxXc2doQmljNDRTdFJWTTh2RVRFc1JISGUy?=
 =?utf-8?B?bWppeElEYldPdWQ5Tmd5WjNmN2FxUEx6T2pRSVpnRFd6ODFtSXJyc0lRMFl6?=
 =?utf-8?B?N0pCN3ZYYzVpSFppL3NDemdjUjBrTjE3RjR1T1RmUy9mRG1ZNWlKUHZUVmUv?=
 =?utf-8?B?QndyeUFiVERScTNvWHBxV0xSWS8zdHMyeURaTXdIUnpJUVJtK3pmaU9wa1U3?=
 =?utf-8?B?MnBYWWRVOEF0emVKNXFkdDV5b1JFRWs4NHVBek5FSXBNblJWdTQ5WFJManRY?=
 =?utf-8?B?WHQ5NzMyRU93TEo0Z2laVzRqVkhMZWFNaHFoMDJvd1pBYk9NdkdzbTVlZVU1?=
 =?utf-8?B?aWF5OEFTZW81NCtwRmRwYVdYV25qeWhBeldiSHpQY0t5UUdZQUZaL1hldUxC?=
 =?utf-8?B?MXVSRDc1czFGRHRTWk9lK2EzQ3BPanV5S3JPalNjdGVQZmYxOG1sUmQrQllk?=
 =?utf-8?B?Sy9LWnNDWERmVFdDMUVCMWxxNEpaUGx2QUphTkNHTTdqblBWdkZzTHo5NkNH?=
 =?utf-8?B?Zmh2MG5CU3l6Zm5nMytyWG02WTRtSUYvekRpUG9yaWUrQmd1WGxVS085ZU1T?=
 =?utf-8?B?a1FsZkVBV2xpT2M5MkNYRHpZVCtIeHU5RDQ0RVA2My93bHFQZWdINlFuL1A3?=
 =?utf-8?B?MSsvOWV1dCtwQTNrSnltWE03WHVpTTFrSjlya0ZIMlorVFZHNXhUMXM2dHJJ?=
 =?utf-8?B?YXg5VjRWQUI0NGlPM3dCSVpTdnF5SG9Bc2orSlM5VFdCMHo3SkZLMTQ4b1ky?=
 =?utf-8?B?RzBEZzhmNklldm1SOEpyWjUrVGVVVlJPZzhFdlpudjJSVXZUV1dwL09qd1lR?=
 =?utf-8?B?NCt3d2Voc25xc21kSHRtRUJDQjh6ZFgxdEgvc08wbDkyTXBJak9qaFF5VTNh?=
 =?utf-8?B?Zlk4RWt1MWlUdWJ5TW5OcTBNWDdJY2U4OHh3Z0FyZ3RxWXFBZVVrRzlBdkF0?=
 =?utf-8?B?aGlZeWwydmM0dHZmZnVQQ3FHNnk0WC9acklXSU5NYUREeHJNK1pveDB3blNN?=
 =?utf-8?B?R2ErOTZjbXJ6ZFhyN0djcTZYSFpsT1Erc0ZjMWJ6anpMUlFvZDhLUGwyR3VI?=
 =?utf-8?B?bmVZeUxhdkt6T2J3L2ZUam5GUDJ4azYrV2pTd20rY1RIQXZocFE1TXA5cmhK?=
 =?utf-8?B?KzM2NExsSDNUU1VDUU9KbkQzN2VhS1RidkZBWGE2b0R2aE9LL3JwVHBFRGwz?=
 =?utf-8?B?YUdjTGxTVU81aGF5NE1lRDZkb3NyVjZMRHFrTTdPdWVvUWVhUnBqVnZJb1Br?=
 =?utf-8?B?VkZWSmtBbWI4V29ZODJNY3pBVlA5Qkl4SE1tY0F6cnJLaDRUNGpFM0tIVlN6?=
 =?utf-8?B?MmkvNStBK281dEovTm9McXErOUp0MUQxc2czTlNLbElvODB4K2xsOG90aVJC?=
 =?utf-8?B?Q01Qbk1hSEp3TXhEdGplU3ZaSzBPNTlhbTErbTBxM1k5WllubU9aOTBHWERV?=
 =?utf-8?B?TU1jankvM0loOFpObGcza1IvZ2Z5NktYWWVNcDZJZWJzR3JWaHZveTFtZVFL?=
 =?utf-8?B?UnUrTncyMURGQ0JCT0luNnhobmdsVkhmWFJudUZJc0lVYjkybjZpZHBSMU8z?=
 =?utf-8?B?WmVEa3ZSSWgrL1F5OTNUUFIyZEwvb1RBVHdsdXpmUlNLQW5oNHJIYmRIK3pP?=
 =?utf-8?B?RVo4MUVJcmg2UTdQSDZmMDJiUmw5c0tMM1kybjJmc08yMmxoWXFObWg2dlhK?=
 =?utf-8?B?ZXF0dUxBRWJHSjhLV1VrYUVCRG5TekhJK3dHUG1IQ0I1RExYMm5BVGdFVHlT?=
 =?utf-8?B?Z1huQVJPQVczZk9NSFB0d0EySUE3b3ZIU0daRUtrQjNrTFpaMXQ4T1VESklZ?=
 =?utf-8?B?UTcxaDhvUGJZUy9kYlVUc0FJejlzSHF2aGxTK1NzUUg0U1E1UFgrd1lqZkRT?=
 =?utf-8?B?OGVDck0vdjZQa2pMV0lYeEtpMVBWUzNyOTFRd0hzQ1dveHVwZ0Nac0RhQU40?=
 =?utf-8?Q?i769IatOCkMOSj2hEt4CgdM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bWhLYzlqbGxlVHRVRVhxQXFpUEZHdy8wYkovMGVTMmZoQ0xHNVJNSVFXMWpI?=
 =?utf-8?B?SXdwS0wrRThrTENXRnZHYjluM1hZYWpFem44czVrY05aS1BjeEh4QUxJcWhH?=
 =?utf-8?B?cEgwSldqUndnYTZVSlVMblpRNUU5QktvMDgzOGwwMHdMUlVNMkJXUDRNaWx5?=
 =?utf-8?B?bnk5WWpSVFRxOS9jZ3hwbkZXVjQ3N3RWNFBWZ1ZoSmlaNE1KRTd1WFdiVDFN?=
 =?utf-8?B?UjhLTFBwT292alQ5RTFNRVpsQStGa2dDWXNKakdNaFN0ODRjSnU0WGUxMmNH?=
 =?utf-8?B?RHJqTDRZS1ZOVk1wNHNFWWxSOFMxMzFCWXRISG42b0dPaEg1eUpIMjNaTFd3?=
 =?utf-8?B?eGUzc2FPU00xUzFwQkptS2o0dVk2TXJZOGZVald5dS9pRWc3Ly9lbTVrT0Vo?=
 =?utf-8?B?NE50cU0vallpNHR2Wi8waVM0NUdhUnZKWHJENUsyWmVpMDdURDdMY3BIU3dw?=
 =?utf-8?B?ZGlkK051V1hIT0Z2NXA1VTc4MEtYamcyR0I4N2x6UXR6aXpFRkU0QjBleEt5?=
 =?utf-8?B?d0c2RHFMVWFhMk1SN0pYQzVvV0FxUUcvK2p0Smo2NnVQYzM1eFJ4TXZSeTFK?=
 =?utf-8?B?SXpWL0tONUp1V0JkcnlsWVJZUEVVZm1rWWl5ekxacHhoRXZBZE9tVG1WOUJa?=
 =?utf-8?B?Z05xUjZKSDRxamNINmMxNVRGN2V3ZUMzNmFwRjVKU3FMb1BKOWNkYTRsUE9I?=
 =?utf-8?B?b3ZTa0xma2Z2cmFFWXA5VHprdDlSc3BqaDloaEdJanN1aUkyT3VqZ2dndmEw?=
 =?utf-8?B?Nzh2bnE0NTlNMllEdmhPcTNTNEdZRGtQOVIyK2k4TzBpcmJnQWhzNWRnOVN3?=
 =?utf-8?B?a1RpMTlUU1BmSE1mdXhZLzlJMTdycEY0dGQzVTVCcWwrejFDUXM1YVUrSlBz?=
 =?utf-8?B?VjBCcjNiMThDNUk2YllVakNXNFNISjhneit1SnBUS3VJQStmTzliMFRpUUtU?=
 =?utf-8?B?U1RPN0xhOGZPZ3VzU1VuQW9hVGwrVzNXeHQ2VWhIZ3I1a3JmSDhSci83ZmVB?=
 =?utf-8?B?Q2x5d3p6NjdIeUZLZGJweDdyelJoQzNhekdlMXA1emtFRVdoRCtuMW81YXpu?=
 =?utf-8?B?L3lHa0xhWXFlSEsrSFVtbGhpU0xUWGsraFpwRFczMXZIWnhvRzBIc2x2aHVu?=
 =?utf-8?B?ajUydnFYeXpFZnRJVWV1MnlOL2hXblRUWHF1dlNDWjhpd2JWa0F5MFd0ZXg5?=
 =?utf-8?B?Q3dPQTR6Skk4cGVFejZLcnlYcjU5R010dDZqMUxRbEdIN25sWkhGY2hTYVRv?=
 =?utf-8?B?cUlOcEtVdWY5T1hjNjBMVk5QdFFwdTdPWGRLaDFWNjJ3Y25MWWpGOGprbzl0?=
 =?utf-8?B?emhPZnRjOG1CTngwWUkxVGwwY3VMVVhPcVpoelZhMkd2ZTdGK0NIN3pETEta?=
 =?utf-8?B?enltSjJYVWlzOUd4KzZCb2hIMGZNUDcvbEh2T1QvK0lnUVpPeDczSWRwckZB?=
 =?utf-8?B?V2pxMzMrU2J5YUdTTkV5QkVjM1hBSS8zcnZUVW9NOURNWUlpMmJvV01IUDg0?=
 =?utf-8?B?dkc2bGRLQWhmVVVaaTZKRHdBMzN3NGhQUTFraDJBUUU2ZzZYRC9wcVNHOXFF?=
 =?utf-8?B?K0ZpOVFwMG05dER2cW9hUGQ3ZXpQYkgvUUdBYkRLZUljQVVMZGJmdVFCWURu?=
 =?utf-8?B?YXlQU0NRT0p4TjhsL1VEWGpNbzdITmZrSHVaYTVHYWlQcGpKL3Y5WXNBKzI5?=
 =?utf-8?B?SVRiM29GVnF2QUVSdkNPQzdWUmxDRnU1MXIzZWtWVmh4STFrZFlMZlMvYW1t?=
 =?utf-8?B?aTFTRUZhdk5FWGRnWGx0SXZoZ29GVnQ5NFZBTFNsdys4QnAyTGhzc2VETUdt?=
 =?utf-8?B?R0dGZkNIN01EamJFY2JFbXl5YllLY2RZc0hhUmhTWGVNZ1hrRzFxbnoxSmdT?=
 =?utf-8?B?YVVDblp2L1dyQ21tMlZFTUNNSnVBV0x5L0dQTWFJbkZ5Kzl1cUdjTU0yNFVj?=
 =?utf-8?B?c1B5RU5hYTRKaVNHYkczT1FXSnp0RjhISzVyRkpuZ21kUGpNRHMzb1pxSitO?=
 =?utf-8?B?M2hQZlozUTQwT1VWdjh1ME5hTDhuMlZXOExaSUZ4OHpUM0NIVnJ4c01CQVpU?=
 =?utf-8?B?UmhFdUFyS3pKZDRaKy9UNlBBVmV0SmM0cHlxNXVPMmFsZEMzTnZGc3NVU0x3?=
 =?utf-8?B?MzdvRlNLSU5MQUliOGpNaXVLR3BJODRpQW9FM0FJSFU4M2F5c29FS01lQVpp?=
 =?utf-8?B?Z21KVjBRM1FMQVRmM3dmOStDOGZyaWFVS1gwbUcrb3RHMU5nRTFQMWhhb2ww?=
 =?utf-8?B?emFaOGY0ai90S1lUeDA0S0RwTXdZbGZNMlZxUkVySGgyVXE5WFkvb2ZRcXRo?=
 =?utf-8?B?WFRrVHQrSitYK2NGa2daQ0lpVUx4WU5JWXd0dmxjV0tpVnlKNDIzWE82ZmNk?=
 =?utf-8?Q?M4iSMId6iGNKi1NvhclI7FmtMooLxqTn7LVzEr8EYDfwW?=
x-ms-exchange-antispam-messagedata-1: VX0n+0Lewka08ZRbvsbi7NJ1RBqL/weISpg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <165AF872B2C04844AB18FBCC2384EC46@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qEjCsASyq3++DESMfu2I5M2J6J73ogTJcr1o+dEWrQ8b1YCdVE98WQOtHRvlJAjSU22xqXr1pBKt32DjB1z8zSkVvQ91wY8d3dC0wxaubmtYC4cZ67EQrwTA5ZB5/AbQ+JrJIDfDXKVoAmMH7kD2ylYrSgpc0WIxkwBedLN7U5nj0boHUvZJzZb/nuLfjWXyNZjpM/DzAVLDYJnCWeZsJoZ0Zl5GswUx5KuO33bTbBal9cqEEZSVsPxvuFikKNk5/Ou0zse0YoEAQ7HjChgD+eawTMvVO9eaYNxhGEE4NRTzlr+UGMmsGKCKsoC9N8KU4hdaMp/XoLMqRrlurnGLNCVD46oThK8Qafs0AUg65J2ld2ZIE3c/+WnvKYHohnGsZKk6BMbjCH6ftWXc9NmmaS3UyTLuIc105abChHAZFgCbMcKZ/BqWpr6Kz+9osoEq+4CmGktI0Na34DvlGq3wpxLLo9f0nNvQzEKvkOkp+700QwWweMzxuhjfoV+hn7MBViK4jL9Q4lJ5xCSyCCHR+dJrOGGiQz7iYg8WsdK4fqHh6F8Ngnkr1DGHnjfyYPlDyDkSoYj77fJ/KwlUSGwoYJ1I6yaU9boUURNaJPRh/SC6Cd0EruWjf78E8/ZUENKj
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67759466-0786-4994-e115-08de54ce45f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 07:10:04.6241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qc3lHqKiC8xlLPgs0DlP+0MXIEJ17hY0SYW+1XeTJ8szKpAiF3Os4IHD85HgP1WVwpQrsUlC5osaYaPixdPZxUmKl7myxxLbM85By1gIZc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6777

T24gMS8xNS8yNiAxMToyMyBQTSwgQm9yaXMgQnVya292IHdyb3RlOg0KPiBPbiBUaHUsIEphbiAx
NSwgMjAyNiBhdCAwOTo1MjowNlBNICswMDAwLCBmZG1hbmFuYUBrZXJuZWwub3JnIHdyb3RlOg0K
Pj4gRnJvbTogRmlsaXBlIE1hbmFuYSA8ZmRtYW5hbmFAc3VzZS5jb20+DQo+Pg0KPj4gV2UgaGF2
ZSBjdXJyZW50bHkgdGhyZWUgcGxhY2VzIHRoYXQgY29tcHV0ZSBob3cgbXVjaCBmcmVlIHNwYWNl
IGEgYmxvY2sNCj4+IGdyb3VwIGhhcy4gQWRkIGEgaGVscGVyIGZ1bmN0aW9uIGZvciB0aGlzIGFu
ZCB1c2UgaXQgaW4gdGhvc2UgcGxhY2VzLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEZpbGlwZSBN
YW5hbmEgPGZkbWFuYW5hQHN1c2UuY29tPg0KPiBUaGlzIGlzIG5pY2UsIHRoYW5rcy4NCj4NCj4g
RldJVywgSSBwZXJzb25hbGx5IGtpbmQgb2YgcHJlZmVyIGEgbmFtZSBpbnZvbHZpbmcgImF2YWls
YWJsZSIsIGFzIEkNCj4gdGhpbmsgImZyZWUiIGlzIGxlc3MgZGVzY3JpcHRpdmUgb2YgdGhlIHpv
bmVfdW51c2FibGUgYXNwZWN0LCBmb3INCj4gZXhhbXBsZS4gQW5kIGdlbmVyYWxseSBldm9rZXMg
c29tZSBraW5kIG9mIGNvcnJlbGF0aW9uIHRvIHRoZSBzdGF0ZSBvZg0KPiB0aGUgZnJlZSBzcGFj
ZSBlbnRyaWVzLg0KDQpXZWxsIHRoaXMgZGVwZW5kcyBvbiBob3cgeW91IGludGVycHJldCBmcmVl
IEkgZ3Vlc3MuIEknZCBpbnRlcnByZXQgaXMgYXMgDQphIGZyZWUgKG9yIGF2YWlsYWJsZSkgdG8g
YWxsb2NhdGUgZnJvbS4NCg0KQW5kIGZvciB6b25lX3VudXNhYmxlIHRoaXMgaXMgc3RhbGUvb2xk
IGdlbmVyYXRpb25zIG9mIGRhdGEsIHdoaWNoIHdlIA0KY2FuJ3Qgb3ZlcndyaXRlIGR1ZSB0byBk
ZXZpY2UgY29uc3RyYWludHMuIFNvIGl0IGVzc2VudGlhbGx5IGlzIG5vdCBmcmVlIA0KdG8gYWxs
b2NhdGUgZnJvbS4NCg0KQnV0IHRoaXMgaXMgbWUgYmVpbmcgYSBub24tbmF0aXZlIEVuZ2xpc2gg
c3BlYWtlciwgdGhpcyBtaWdodCBiZSANCmRpZmZlcmVudCBmb3IgbmF0aXZlIEVuZ2xpc2ggc3Bl
YWtlcnMuDQoNCg==

