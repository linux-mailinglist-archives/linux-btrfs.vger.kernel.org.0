Return-Path: <linux-btrfs+bounces-13460-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58404A9F34F
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 16:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A98B3AECBA
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 14:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8459526C387;
	Mon, 28 Apr 2025 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XjpOY3SG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rceQTfnG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF01F1B86EF
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Apr 2025 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745850071; cv=fail; b=BqUHw4v0CIqP/XdfIR4y1KfX5djTyo7TLutax1QFeSAMb/AAj0Ia5kUUVvJi7H3+53fJfwnSIOkj6nAO5vH662W4zjBqmuX5A6+lad4N7fLuAoaoIELx+OvLrOW8VCFeN1kuy4NbXIlm66znwGb3ZkNLufB22XVQBx6SfW+nLKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745850071; c=relaxed/simple;
	bh=pyP1Z+4eQtiLvW9LPhYQ2U9jRcqBdVOhs+NuEJmDFIU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YoPeH26eWBxt3fCMDuMlaajIRysRZD99d3MGppygTHCOvwVun9HgVP7RskdSgghHs46sA2kv3dwqyalHcSVDi9DZvrjSXrcUZ4Bd2VFy/D7f9SFRd/jOQ38wqJ7bevNisbJ6Fct++qWNdlPjligHbjYV5zbmG7r5JnjoaClBoTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XjpOY3SG; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=rceQTfnG; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745850069; x=1777386069;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=pyP1Z+4eQtiLvW9LPhYQ2U9jRcqBdVOhs+NuEJmDFIU=;
  b=XjpOY3SG2sxT+Y1MA4Y8Q3QIy29AK96GMqZcSEXQWwtiwynFzbN4QN4N
   yokEIBipJSJkwaOqDFfwV6FiQd4dfm03XNlwISVyvSIwh3LXaYlNRfASi
   b36heTFeJjaQVPqBzmSqjRJarx5d1NSwJ/hl6qT9Re0b+VraEmZnnpEPq
   F7lkigo6ectfYH3M5MCyJBlhGEQBoxattNf2Fs2eYrZSRV8EbgcQl8dLm
   TIKJV95SniyftOxYt89KQpl/JZgHdO6H3W2fJ/e6zapjgqAv/9ui5juV0
   d3O6yrIkeaTkKUJR6TLB9PPRp5mtgPwLqmRt8vktczXVwxQl3zUi2RQ/v
   Q==;
X-CSE-ConnectionGUID: ShwMyTttQ3i1+TAwyu7AzA==
X-CSE-MsgGUID: dLGFTOvCR1SGaxzBenJEJA==
X-IronPort-AV: E=Sophos;i="6.15,246,1739808000"; 
   d="scan'208";a="82661286"
Received: from mail-centralusazlp17011030.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([40.93.13.30])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2025 22:21:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNBwrCuz6Etxr5NK705wu0Uy3NTm5JdQ5Tyd9sXqwkb9JWYJ+hjPePwcIrw91rTJmAhobsDzPp1hMf3t0xwuqL3P8UnHOfjKvM2vL2hIng9Z1pBFW7UW9xiSjMi/Q6HLN0P+SkHdo9wDpgKje5SXOUmeTh4e58padycvmDeNLOiyGTXWBitxRJk7UdyDUA6YpgBSw01i04MfjP07ABe2qsbl7a7hrO9ouK52KqubEgWaOFWnK7vBbE5nAQ5yOmZHv2LdTr4nOK6YS6ucN8jh88kxL4h5dZgB+JY75p9oI4CIbKQmvNwSEx8YPkeY/AUr34vuKPawpN9uo142yssgwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyP1Z+4eQtiLvW9LPhYQ2U9jRcqBdVOhs+NuEJmDFIU=;
 b=ViFGI5UKqBb6V4bG3GfvvREMUE+f1sAFzO5RsuR2ZixAWK60xBiMyIWCNBQRUp+DuLDTzOwBbaMHQqjnM3rbGeywyc9ipkBktbw7HYQqNcpaU9vL29lSskg6HOw7vYRFLDWDYqrS9AVdlpUoIfPFKf1i5I1QNOxmpUWEVsBe3F2CE6iZWAVjV1vdkdUh2LNkAZfRWE257SRoXnQkqCmPeDhK6RPgrOkOSOjZ0zaF0g0CTFEeZovyCEhM0DThwujhKChvqrrxAydSMgyrjH8Mk2pb0Mt0JwdtirIxrkQ1N3tnbRVbZiCK4t7OiDGt/9zNV/9LDrnpr6UEvrL/0OXenQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyP1Z+4eQtiLvW9LPhYQ2U9jRcqBdVOhs+NuEJmDFIU=;
 b=rceQTfnGbcNRxLcbT79qqBeu5Lqs8lmig7Hq3bZjPtoFeyUtR31uqGpyycphmis80iEvjghHwHdBWmElqf5nl+/wQhLczYUJfqfbbw2k0vSkbX6/JkZbFMG4sDMtqWbMipu5xD/WZR8uooH17q6Uyy6TPEen8qx1YRsDODkLkXs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL3PR04MB7929.namprd04.prod.outlook.com (2603:10b6:208:338::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 14:21:06 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8678.025; Mon, 28 Apr 2025
 14:21:06 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] btrfs: merge btrfs_read_dev_one_super() into
 btrfs_read_disk_super()
Thread-Topic: [PATCH 1/2] btrfs: merge btrfs_read_dev_one_super() into
 btrfs_read_disk_super()
Thread-Index: AQHbt9swSf8Dg5s5D0iCNXhlr/qWNrO5IdgA
Date: Mon, 28 Apr 2025 14:21:06 +0000
Message-ID: <1cfd4998-e220-43da-b78d-2a7efa3f681e@wdc.com>
References: <cover.1745802753.git.wqu@suse.com>
 <b251d716c8cd93ee8b9ee32fdd399bd0fff28669.1745802753.git.wqu@suse.com>
In-Reply-To:
 <b251d716c8cd93ee8b9ee32fdd399bd0fff28669.1745802753.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL3PR04MB7929:EE_
x-ms-office365-filtering-correlation-id: 5a75dbaa-ce66-4515-6b7a-08dd865fea34
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SHNMZzR6OWVlTy9HVFh2SUNYS3NIRVpZa3o2dyszY1ZScWliRDVWZTAxZTBl?=
 =?utf-8?B?K3dzemRtb3k1bHgyYW5DT0xyNVlBS21qWnhyWW43V0RtUjZYQmNhVk5xdEJP?=
 =?utf-8?B?Tjg3a2pwZ2lyN0IrOUF3Njk5Vk05blRPcDVCd0tnRnNEZmx1MXd6ZlFjTlpO?=
 =?utf-8?B?ZTRpdFExMWNObHVJTm9XT1IzRnFrWXpZaVVvaXVnaTNzNjQxMnIyb2c1MFEy?=
 =?utf-8?B?OTZCQmNlUFJxRklabUUxcVdVWGxOckpuQ05xa2xRZC85cnAvL0gzanp2Vzda?=
 =?utf-8?B?czcveDRjUXFrUWphR0hwbzdLWHh6czRVaWFhQnFYZ1VaU2JpbkNyenNUcXha?=
 =?utf-8?B?WkNvTzYxN0hjUU9BN0NGVlhvSHBRYUsza0Y4WEVHUzJzSDUwVVBwc2pQbVN6?=
 =?utf-8?B?OEpPQ1ZSaCttdnpxblJrYmVRbHFoTTBBR0xrbzdLWVZpc2FvdUZEL1l3VFU5?=
 =?utf-8?B?MWUrYlJpbnFPNVhvUEZwMmVPem81ckh2OVIxN1VCeFlibUxyeFE2UVdhK0wv?=
 =?utf-8?B?bkVCN29OM2lVSFVscGxYazdzbm0xdUpjU0F6bUdsbDFBeGhBU01NMGQ3MWJM?=
 =?utf-8?B?aytjcW1idlZaeExEeGJGdjNWK3VpYlBCUVo0ejhRVllabmlkSHluUG5jdnpD?=
 =?utf-8?B?cG95cHg0VUZYTmhpRFN4ZFhWQzZnZUw0QklPQUdrSnA4MXBkSzlHUGs0MEha?=
 =?utf-8?B?Rzc0WFpFSEcwZERnU2Y5bkt6c2F3alJ6dklYYVN3NkF1dSthU2pBOWdPb0do?=
 =?utf-8?B?RE1UTWxuMXN4b25uYUtiU1ZsSXduMHVXU3p6ZE5CcVIvdk1NNWZ6bWs5L0Ew?=
 =?utf-8?B?b1grdzZMc09JNTBWaHk5aEMwdG55dkp3bEhOYnhQQTY5K2E5bnRyU0ZOVW9v?=
 =?utf-8?B?Ky9hODQrc3IzWS9lL1JydEpOb3lFbzU0enNlRzhNeXZXQVNmS1pUUzBQcGh0?=
 =?utf-8?B?MnFnU3UySS92OXMzeFllWGpXL3ZYamR2SzdUb2JtVHJiZ1o1cHYvcGRoTkpt?=
 =?utf-8?B?Skg3Zm9PMWF6WENUbHFUa2RydWFuY0RoZXh0bE0xcTlmQTFreDFFbW5BNDhw?=
 =?utf-8?B?dE0xOXZCREV1czkxTnNjT2RyRCtkaXhJMnVPVDNwRDEvQnd1VlZiZEROd1Zw?=
 =?utf-8?B?N0pTNjZ6WGs4STFzUTVvaFBtUkZjSDdJeCtUT1ZEZDRDU0RoQmorTzJXWk5H?=
 =?utf-8?B?MXFvUjAyYU1PdVRhNW9PWVRDeG1oVldiN0oveUxvY0F1Q01mMUNkMDZrbU9Z?=
 =?utf-8?B?TTY2SkFzeFI2ZzFrUG4yZUhabi8wbVpqc0ZJNC8yK1lHRXNtcHplR3VPa0NB?=
 =?utf-8?B?WkF2SFVuSmVDOU1ESlp1OUs2YkpJbHBLS05GUmVUSFB2SUQ4T01mRHNmWFFL?=
 =?utf-8?B?aUVadEQ4aTlDaG1iY1FraUlVZzlJU1lnUlpDV0Nqa3Bpc2NQM3lXNVZNVDJM?=
 =?utf-8?B?YUNPeG9mUEZvY3kyam1Ldk40b0VSWU15d0hKT3dWb3hHd2dZTlc4RXBPRjU5?=
 =?utf-8?B?S01jUGNQcU1UR0d5RGNlVDZSZ3N2UkZMalRGajUvM3A4SDlaVENzUXYza3Iz?=
 =?utf-8?B?ZmI4OVMxYnozWVlOVncxQnhGcW1QUnRaYS9sUDZ0QU1HVHcxZk4xUFJSaDIx?=
 =?utf-8?B?NXJxUmx3ZlI4T3NTb1dkS2RocEdGbVNHcDlFSEkrZzF6bUxIeFZpSjc4N0Vk?=
 =?utf-8?B?S1JnS2JyY25ZODRFRmVmMWRITWVoSVM4UnIzbGVqUWYrcjhBS1RSTFdCS1RZ?=
 =?utf-8?B?a1VsWXpNQXl5bVQ1aU1TRHJBNzhaME9hME9VeFlvc2JpK1ZuY2NyUjc2K0FS?=
 =?utf-8?B?Rk5TcnI0c2I0ZHdIcEZQeGZtRGxYYlhRZFl2Y0FURTdJT1hxTG1LT1JUbkhH?=
 =?utf-8?B?RkNyRDFlcE8yNk5MQURaQUU3Y2swOUdaL0R4aitwZVI2UU04dDg3c2ZtY0xK?=
 =?utf-8?B?YW5EL0FmZzVYQ3RHMHVBRm9PZGloVE9uK2I1UHgyTWpibmRaOXloZzVkWERC?=
 =?utf-8?B?dGppTXpKZGpRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aFVvSmVQNHI2RzN6eWhJNDVtSEpyQjJ1OHYvTENRbDRRbFNHa3p1eUxibFgx?=
 =?utf-8?B?N3AvWWg2SjBrWjhLd0UzU0hlMU1qRHJEb3pGYk96eTUzMVh0WC83V3FsT1N1?=
 =?utf-8?B?alBjYVpmdVJuRlF5WUc2V3YybCtlZDg0NUMyektqNHlYVkFrVDZoSDBGR1pH?=
 =?utf-8?B?TVlaRHVUNTMwU29rVWUraGRzclI5a3V2K0V2UXNGajhwaFRXZGRLWjU0WmR6?=
 =?utf-8?B?MFp2VFhpc2NjNU1yOE5KUnM0VGJjSnJGeEl3SlpoRkEwYnNsRHlHWExRSFJE?=
 =?utf-8?B?VCtpOTB4VDhIamxvOCtTQ0JxaTJRNWxteEdGbTV2TnNSeGltbGZ5OFBYVlhY?=
 =?utf-8?B?WW1SWnZPNzJGT2lNR0lUcFByWDFjMGFFUXBIbk1oRW82Y0ZLb0pYUFdDOXda?=
 =?utf-8?B?bXZTaU4rR1pJSStGQVNybVlZWVFoUWVrcUpMOXRDRlErbDZVODBHTHNiNWxr?=
 =?utf-8?B?VGpmMk42N3NxQklXVFVjSnRSSlNPVlhUZXhHOXRZNFNORHN4ek82ZEh0ajBG?=
 =?utf-8?B?aUpPTzljeDhCUWF3K2RQRDVOZXBHeDBFK1RIT0JaTGJ6Mm9HYVV1TDJUeWVL?=
 =?utf-8?B?b2xhaTVhTERWZWs3ZzUwSkI3ZFJXZWF4WUUvbE4vMlRxSkRWV3c5dlVIclpT?=
 =?utf-8?B?RVlZNzBlUXl3NDNaT282ZFYzWGp3ODl6c1lwRmx2TUJTQUk0WE1uSVZwdkFq?=
 =?utf-8?B?SHVIUm9OdVJjN2RiZDZnOVZlUUUvSWVRM3Y3SFlKaDFIYWRSbW9JSFp1OC84?=
 =?utf-8?B?ZzZQelZNWk9vSVZhQ3pFWHVuUGttb2NjQnhoWWhnMGRvM3kySjRXWUpUUnVp?=
 =?utf-8?B?NWdaY1RwU0lUTVBUME5KN3FiTDdyN3FDU0VucjY5U210NDFWWEVWc29uQkJK?=
 =?utf-8?B?RTRZdTgrd1FQSGxWWE0yY0wydy9IRXZlRHlwY2hjamw0QXBGWHBKb0EyNXRq?=
 =?utf-8?B?KzRKYVc3WXJkd2pDclhiZExHL1VuUEw3ZkEvOXJYSFpsRnQ0dWpraVFrcWtD?=
 =?utf-8?B?bTgveUxHZ1VhcUc0Ynp5T3ZheWdmSGFJa01wSUJ3Zk81VTRuNG1CYVpBSC9j?=
 =?utf-8?B?QVVZSEhYemlKdGFwTXNQajdySDFmTzJXYzlqOE1tQm1xS3UvaWw4eTNGYktW?=
 =?utf-8?B?OEJKSjBoL1pzTDZkQ0U4R2lhR2pudzBNU0NOcUE3WGRQZUNtTy9yRTYwcE1D?=
 =?utf-8?B?SHF2T0k0L0M4TS9QNEtNL05Ba3o4TFRiN0lqa1VOc1Q2RmdOL2dxUW1ML3Z6?=
 =?utf-8?B?UDJ2N2s5ZnpORGZLYXJvSmg3cWJrM1I1WEVrOTJwTTFSbGtNbi9qUkErenF3?=
 =?utf-8?B?T09oMUZSNmxwNUVhakQ0M0FCN3FFbENab1ZmZnZYY1c0dWQ4UnVuSUxXZG1D?=
 =?utf-8?B?eGZTR01ocDk5YUlhZ0ZadGUySjJIWVJYTHJtNWZOemlxR1k1eUFsUEk2WTRq?=
 =?utf-8?B?b0t4bldNV3BpRVl0MlBnWFdwbzRQWlQ4N1Z1eHNCaWNvR2orUDNQNmRXZHlo?=
 =?utf-8?B?QS9wRWZsMllSdGR0N05ETi9vSEJaRUFMMWdyN051eFU1OUN3YUs3YUFVNHY4?=
 =?utf-8?B?RHNoYzdPWlE4SllPUFdiYmw0di92Ky8rdllXYTJUR1doL2tBSW5objJqRnBx?=
 =?utf-8?B?a2x6akd1ZDJVYW42Z3dLTTY5bnZhWUlCeUtmYTJtUkFIcDVHS3BhV2N3UE93?=
 =?utf-8?B?T21wYXJEclRkdTdnck9ZYVdwOXAwRkNEVnN5WGRNcklQMlFaV2Q3TDhUc2lw?=
 =?utf-8?B?alJyU0tIQzJPVldlaVVxK0xEdjRmZGorY0VRR2ZDSUJWRTBBRzFySWwxNFlO?=
 =?utf-8?B?S1FXNFZQNmFMODgrQmZKM2t0OGpGQ00vWFpYaUxkTHdoMmN1WUgwRWJ0amhp?=
 =?utf-8?B?MGUzUmU1SlliTG5HeUI0cDJIZHZIaUJrSk54blBQM1FnVVlXOEZFazlWaVA5?=
 =?utf-8?B?QkxZdll6UTRQZnpJc3ZKbEVsaDFsbTVrMTFsd1V2NzM4VVdlZGVxMVlvRGtR?=
 =?utf-8?B?N3o1STVRUlV0bHovY3d4N09JUFVDZkhyVUZjM1NqcHl2djZCNjlmcmdIUHY0?=
 =?utf-8?B?RXRnTCtQalhSNzJrVnRHVTdITUNJT3ZjOUN0NmN6aUhVclo3anp6Y1VKVVZG?=
 =?utf-8?B?K013Um8xbkNobmcrUmFxQ1Erc2d0MnlpWWNkTTBUODIvM3VGZU9aVnRqOFNP?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FC6BC8F36AA3F46A60ADE41C08D0044@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	myMvaj1toZw6iN6MPESmvE0oEJxFIs73jiB59mcTgydfwdy4htF0QKmzk5Q/Oc7szB6yq6jG2WmK0xaER8FbTkAxalG58f7PxVxZSpBLt7p3jnxWD6CE/zGjZunOSmJKuo6hp2FKurva51RaSuvUxDMbyaK0/c6tJaGhb4lg8KE9sibot0IFw7gSj9bE+4Lx3ZRuwn08pYpBVxuccwMXIBoawNm2Uv8GrQ+4oDcsfIxDk4PfHhZLg5ijEZACcieHSXc/SCMozPTMMSIj8NFAfc3oDxy54GPO8Mbq7IUJS8l7kcIRI+Jt+E8CSK49pxlrEhpFESda7ZBZkTh38WfSbaVHB0Y5p6jdFYJoFOAQV8HA4IO4VaUVhpcZ93/EHQS2X2X9SUkezDSoJqS62kYdonaY1PS/TNZ20f4502SjQ+utQxK3d0SuIa7jY+Eb4aYWuVYUG5GHclu2JggqouHchJh0Bzapao1K5HMvCeVztq4b6JP88+dOk7pKqwgnRU3/zDSrLAIu07qZ0ia9r1eVrX19/ekYhDWP2CRDj+98y8HxGVhvWZvXjRRrVlzBV0rcuSZ7/xcMQsf+k3q0+oY43/MIfyq+egoO2cCVbb8uljDpxxLHIu5TFJu5EUB0kdiM
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a75dbaa-ce66-4515-6b7a-08dd865fea34
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 14:21:06.5389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fe0yIokxfbeB2DvR42o6hY3MlChyocVgX8eZdb75M8aaYtCUPkO2nWtt/SNaf32oill2KwRI+zcefpgPrRHGE4lIp0T0pLtvCQh3xB0hW7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB7929

T24gMjguMDQuMjUgMDM6MTYsIFF1IFdlbnJ1byB3cm90ZToNCj4gKwlyZXQgPSBidHJmc19zYl9s
b2dfbG9jYXRpb25fYmRldihiZGV2LCBjb3B5X251bSwgUkVBRCwgJmJ5dGVucik7DQo+ICsJaWYg
KHJldCA9PSAtRU5PRU5UKQ0KPiArCQlyZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsNCj4gKwllbHNl
IGlmIChyZXQpDQo+ICsJCXJldHVybiBFUlJfUFRSKHJldCk7DQoNCk5pdDogZWxzZSBhZnRlciBy
ZXR1cm4gaXMgc3VwZXJmbHVvdXMuDQoNCk1heWJlIGV2ZW46DQoNCglpZiAocmV0KSB7DQoJCWlm
IChyZXQgPT0gLUVOT0VOVCkNCgkJCXJldCA9IC1FSU5WQUwNCgkJcmV0dXJuIEVSUl9QVFIocmV0
KTsNCgl9DQo=

