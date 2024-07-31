Return-Path: <linux-btrfs+bounces-6921-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D319436E7
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 22:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1C3F1F22911
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 20:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585681662E9;
	Wed, 31 Jul 2024 20:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UEHkafRF";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="sqeKe2WG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5831E219E1;
	Wed, 31 Jul 2024 20:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722456817; cv=fail; b=S0mLkgQ3UFnyA5cWuZovT2hbRkLFpa5SC4PbP1iPIYNAJF7MjMKBd4973quSKJcP8PxPcnLo6PpEPDaNi96wLkRM1XEMvDPdNPuYk88o01gnFm9xtbDJ09PJYJEfPoyrVNfi93wZrBnmPAZSsQkNyNM/9E4xCcHfD0hJE0hIiXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722456817; c=relaxed/simple;
	bh=C3ioAX0Nc4BM8ygagCeQeBgyAfPYW/+oYUNMIR72Cd8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GuJbUUbe8qk/o2UgvCF8mg69D0ydj3UsrMhRYEDvHjIMujkFQxg/ed3OlaTf9e/9LmsUTWAjqrPRIlFp9CRBGM8LmaLhdlaIKu6MTzJ49wugf1GBfkAwyDaogQ8o+I2R2k3dSTJmnPgG5euC3rFyzoGUKTIqwSywtl98rMyyaF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UEHkafRF; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=sqeKe2WG; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1722456814; x=1753992814;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=C3ioAX0Nc4BM8ygagCeQeBgyAfPYW/+oYUNMIR72Cd8=;
  b=UEHkafRFNgu5NocBaVn1gMX7sVmdCE/B2G4TQgBRL41mC5N1MuMpsMzG
   fAMakfVfAkVeZAeesCoecHN5qigyxqcJnBlpTkBv5jJNnRHsCCXoBmTdb
   JiRp7l6YTlJp6DaxnYksgr4+m4Fo5DVz093t6qcv+Dgdv8/ZKzwEDGbjJ
   dHMMaiJ4P0sy6u6FkZ58sgryn4EZReExUPJCZAw9peR3b4+pkdmXTjhAy
   mLDx0iphytNVUwc+n5mz1alVSxjo/mLUn2RTOw9qOd6XkK7auXivJKy9c
   r38+8K3ub+l4CXhEO3KwJymdQux/GDGHUpNRm+Z1ql9JQCfgISQc2x4kt
   A==;
X-CSE-ConnectionGUID: 5tB3kmFpStqK3Gmjf0xONg==
X-CSE-MsgGUID: x4saEiCwQBWKke/uTgUzGA==
X-IronPort-AV: E=Sophos;i="6.09,251,1716220800"; 
   d="scan'208";a="22550369"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2024 04:13:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qzzl0ya2SMLXZo+lgszVomeg8qoWvqiehggtHjt9qUGoSO6WawXtvW1twkKxvskzvFrXKrvzyaCGAZsenxyCQIhkeLNNn2b8ohFXXx9ebIk1rpjGj+3lnsfOVu0aOIBzxZe0FI0j/l+/qrPsF7IgYJjk2JF9xgQLoh/Pco/e5XhLBylA/piBeksieR0480HcrekMTgFvJgsP54Fs+K2GwsjZLYDfGOHXiJ4dk9Km6UYE0x1swgqcQgEYnz41fhbfcBnxO7vAy5RUkiTqdFdxdfZapJ2BbNXLyEMxh12em3HUgJTkmr23TTIH/1pyVITKA0zPE9v/N9zViosFXP6ufg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3ioAX0Nc4BM8ygagCeQeBgyAfPYW/+oYUNMIR72Cd8=;
 b=SBa9bK0fsA9AqoxGHKzp664r5KHJBX6tOjUipBpOHIboUUjO8za3WCgPsinKgQuSYo0z+mIw/ZyFImdMdlPqM9gmzi4XJqWdRhN+oY5aMjwk8HJXDGyYF4Euf5u0TT967u339NlOkFGlG3y6JGpElas0FIUMWjcVuFpW/AJrBnwE+dGVhLZOcgcC9tLOsGlDgMoppDG1NrOqXUNhF+6Hvn+0Nep6r2+lP3bYrKO45ReQ0yCmW1kDyzglD5MWXYtFwH4I/VnRZ+Rj2LpPBwvoF/sszUdQVT96yaYWn7isQ/fSePNQ8+lkBw7NufapovCJY0gBY+c4NoT95p2LVms9Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3ioAX0Nc4BM8ygagCeQeBgyAfPYW/+oYUNMIR72Cd8=;
 b=sqeKe2WG26yP5d4KxfLpkFtcZOvyrWdbymC3r40KtOFPgLWutxXbDe2awEcUM8wi/LAvI7wWUiQXflNWS0NeACHFb2eu9ngx8gyNBvB/6so5HMqEEK2QIuFk+xsu8OPG4hGHcg7sXIIRj6pLLa/TCfrVk0rfnuThi+eI/15NgDE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN0PR04MB8160.namprd04.prod.outlook.com (2603:10b6:408:144::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 20:13:23 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 20:13:23 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Johannes Thumshirn <jth@kernel.org>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Johannes
 Thumshirn <jthumshirn@wdc.com>, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2 0/5] btrfs: fix relocation on RAID stripe-tree
 filesystems
Thread-Topic: [PATCH v2 0/5] btrfs: fix relocation on RAID stripe-tree
 filesystems
Thread-Index: AQHa4mvrvMwPFKdi2kSf1zJO5imaaLIPy4wAgAF7zIA=
Date: Wed, 31 Jul 2024 20:13:23 +0000
Message-ID: <5382a028-5a2f-4d96-b522-3865c7eea31d@wdc.com>
References: <20240730-debug-v2-0-38e6607ecba6@kernel.org>
 <c7fb2333-8797-4b6b-bc1e-192b2ef82e8b@gmx.com>
In-Reply-To: <c7fb2333-8797-4b6b-bc1e-192b2ef82e8b@gmx.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN0PR04MB8160:EE_
x-ms-office365-filtering-correlation-id: 4e585014-3321-4186-a0d4-08dcb19d3afc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Qm1kelQ2aDRzekpvU0tMRmdMTG9aQmJGNGQ4Sk1wQ0lIaXYvcGJ1b0FTVmJY?=
 =?utf-8?B?d0lnMHVidXgwQnc3aE1ELzdBckpEMGRacmcwYUs3T0FHY3U2YTVGa1pyR3hW?=
 =?utf-8?B?a0diL2VxdmJySWtKTHhmaHlJV1QxRlNUbVNhOXBrc3BJa1JjU003N1o0eUJV?=
 =?utf-8?B?SzdteUU5cko5T29aL1Fmd3c5bWcvbmNGdFVDeUVKSytCSEMvcGpOUUk1SGwz?=
 =?utf-8?B?M0l0RFVQaHNrVlFNQ1NvUE9mUFl1UGRFYXFTWkhzd3pEaEhaazA5bDkycGtH?=
 =?utf-8?B?bUpmdUc3UnVva2RaNWVFaEJrYTlQQTRYR1luazlxQlJKbUg4Rm1sWkc0Nnk3?=
 =?utf-8?B?V09yNHpvc2EzZzVZM0JDUnNmMGZQS0lGTW1hTzFHNnM5MVl6SEFQd3cwZ1Vp?=
 =?utf-8?B?eHA0MUV0cUtXQkVJazZyWFp3RlE5VVZGaDA5OHBvZnM4SjJzakY4Z1orK254?=
 =?utf-8?B?ZXkxV2FNb0FMYjI4UEMwK2VMYmIvMEQzcHRnZ0dEa01NWVdNMFNITTRhTkxt?=
 =?utf-8?B?c2ZQUE1qMC9JMFdESndlZStpZFhjOTdjOFZLbWp2UW10MWFtQjJCV09qWExU?=
 =?utf-8?B?Sld3OXpoS3JaT2U1MUdFdWxDbWs5Y082U05kNGwrQU02ODRXeDNNMmM2UmU0?=
 =?utf-8?B?eUIwMGlQbjlmNlQyNWVKbjNOWnAzUjc3bDRmRFRtRVAxWkV3MkZQZzlORWJh?=
 =?utf-8?B?TE43SzdNUmxCL3UrOWV3N1R3ZGtlN0t1aVRRcmdyRHgxS0xIUkM0RkF3YWpt?=
 =?utf-8?B?Z0VlM0FscUI3L05Tazc2THZEaUx1Y1U5b1Y3TEg1ZlBQZ3U4SkRpMlUzTk41?=
 =?utf-8?B?cUFsZGZlYUJCamUyNmFUTnVMdlNzM2ZxWUJYYlAvOGs5SGZjK1dqdjF6V1R1?=
 =?utf-8?B?aTl3TzhBdlBGczlxZ3ovKzJXUWM1ZWl0VmlzV2FheGF3NFNubXkycEh6VGV4?=
 =?utf-8?B?RUJ5ZTVUaWVKVzdYN1lSZm8wQmxKTFJZUjhwNmR2SUlvQU0wRVJ2Z0RQVnNJ?=
 =?utf-8?B?eHRsVXV5MW5NeHgvZmhPeXFyNzFMRm16UWdkSkRNVEpPd1NpNmZuUUd0WFYv?=
 =?utf-8?B?RFVLRWoydlF6RC9xU1F0eVp0TFFHTFRPcnlObUZoME1RZENJL2J3RUZkc21V?=
 =?utf-8?B?M00xWkVZVGYzVDhDczdFNlBOWnM2MjlaS1FPdXRFUUl2a3BkYWJSRnV2SWJC?=
 =?utf-8?B?MmZIMnloeWVic01XSVFpdHpabzhIbk81eDR5SHNLeWwyb3ZiNTMxVGxEaXJM?=
 =?utf-8?B?NnlxMEQrcHlFSHJsTTQ0eGltdDBDTUIwNDZiTkI3UEY1am5BVVAveVNlQnZk?=
 =?utf-8?B?aXdHeDJUNStsaCtIYUhZRDdhSlZhZ2FNV3FrZlQ5N3FReXJ6SlVZeGh5Yjhh?=
 =?utf-8?B?c25HYm9LNndYNGNYQWRZZktRUng4NUFnS2JTVVVOaTc1Z2htVHk5QmhMZjNB?=
 =?utf-8?B?c1FHbEpQZ2F1ZSt5cCtGL1IzelZsVjljWXQ0QU1QaHBYK01qcXBqZEM5ZVcv?=
 =?utf-8?B?OFlIVjBEQ2pGYitnNGIyTkNKUnJnYmF3YlFFbVRqNGZsdEhWVkdYZjZoQ2hy?=
 =?utf-8?B?bVZGWjBhUDJuQm92dFZBbjhGbEdPRVJnei8ycHlXSzdxemtUMzdsTSsxRjla?=
 =?utf-8?B?cFVjRHlpUU9vVW91N2ZqVCs0L3Zmd0N6SDM4bkJ4SklOc2ZFWmFFSGZxTkk2?=
 =?utf-8?B?V2s4SzdZclpvOXpROC9QQ1Z4VE1uTDhaWCszdFE0ZmN1dHVXQWNBRUF1MlVL?=
 =?utf-8?B?TWxlbGgrU054QVVzK2V1WFRpR0RMVmRiZFljQjNPTTRaV0RKMTJ0VHRxdlhB?=
 =?utf-8?Q?xz7H0+lnb06fzSv4KixoIw3ayiJ1mrUVy7pyk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WFpGK2plL0hEb0N0Vmk0QlQvNzRxcUI5V2g5WVBQUUE4SjRTVzdjakcwWXMr?=
 =?utf-8?B?QVUyLy9pMDNSSi9Nd3pTbGhoaThpRXBxTmlxSndPRll2UklwLzdkTy9Pd21V?=
 =?utf-8?B?UlNyeVlWaUJMcERTWFRibTZxSTFMWHhpVE9idnlraUd6b3NUYmFwdEZwb0ZJ?=
 =?utf-8?B?dXJDa2FCQVFoRGVLWWdXSUd3U0pFL2Q3UTRUM292bE0wSVdmdzlLREZ0V1RI?=
 =?utf-8?B?L1VXZVBPQStiNnc4d1R6MnpWM1EwV2gzU1JMT3Fxcm42eklvalZMbU9XOW5B?=
 =?utf-8?B?NmN3Z1NNRjZvcW5xbXYxaC8wN09NQ3RsR3BxRlFMbys5bE1hRU5Edk5hVkg4?=
 =?utf-8?B?OEZWZndCd1Urd1BCUkU4NEorUUFiS09VUWhqZXhzYnhjbkhJSDc3eUlFQlp2?=
 =?utf-8?B?UUtOdWE3bEFLUWVhd1h3Y3FTZG9UUTVKeFNlNzFKMG9xa2h1WmdudXZkVHh1?=
 =?utf-8?B?YUYwKzJJS2JEckVhVHpuamNBcnRMejVaN054dnN5MWNUSXJmenM5dkZ5R3BH?=
 =?utf-8?B?cThHK1Y0VHpTWDNjU3VhQzI4K1J5L3hxd3VEUjU4ZEo3RUM5K09GTG50Mzhs?=
 =?utf-8?B?cWV0eWJzeUNkRXFjekFMSDllZldzcjVYRG02aFFDeC91WGdhRC9CR0Z1M3Fn?=
 =?utf-8?B?OHFHNGs2WFM4VHN1Ujl6enJKdzhKRXZBSStJcURUZ0FpUnhDc0dpaVZnZG1m?=
 =?utf-8?B?S21oU21HRytVYXQ1ckF4THJZaHNGcXp3cE5yR2s5WksrMk1wczZaSE5PL2gv?=
 =?utf-8?B?TTd3Sm9NNFJsTEZ3MlQ1M0J0S2RDaVVmOEJhbytPQlhNeVU4YzF5SnZRclBt?=
 =?utf-8?B?cDBEbXVicjZzY0gyb05kTzAyeGN6aW1WakhNOFpLUWdaVUNpYmowTHZOL0hU?=
 =?utf-8?B?K3JUSnZKcXpXa3hwM0VPaFNNWVc0aVpHV0wvUnFRdDNIRWtIWEFlVERxUU1w?=
 =?utf-8?B?YUlCY2NaQ2lmNng2NUVORjh1Z0g3dDViVHZRczhSWXRiR3VIZDRTbFZGbGlR?=
 =?utf-8?B?c0ExWkp0Z1VYN2p6TVF4SnRiZzhwZzl1Y085bVN3U2xqODRDZm1OREY0azFq?=
 =?utf-8?B?VWZFbk9NLzk1ZnVxd0FqaVZjalNjMWdhWGRuaE1JZ3Rka3JoZnE5OHRKWlQ4?=
 =?utf-8?B?WVhiWGtFK21WRkVmS3pCYkV3ZERRZG52VEtyOWVqdC91cWNuY0E2dXEvTDdU?=
 =?utf-8?B?SlYraXZzMnBJWjY5V3luOW9rWjR4eGs2NnBxMk5tV2lsaDVHVVJMd0F2cnoy?=
 =?utf-8?B?emJQZ3ZQZVFMdzROcGlTN21IcWNvdGlOUm1hcEFTT0tNRjhBeXR1UHVSMDc3?=
 =?utf-8?B?bnZmemMvSVZmV1BpUlRJaXNCZDdCdkVibzdrOHF6Q3RqbVNUKzdoQzQ3aE5G?=
 =?utf-8?B?N2NrcGVibEVqZ290cmlpdmhjTUxuaXFodTJDdXI3YzZxakdodStnSjJaR3oz?=
 =?utf-8?B?Y1E2TDlDUldrZXVIenFwTGhaU1IwbEF2eHkzSnVzdjFMb0RFSk1JTk82WXpJ?=
 =?utf-8?B?dlpiYnVha3Y2UW1oU0w1ZE1TZitudHRuRDFlcDBkd3VvSXBYVkFUdXM2SEhQ?=
 =?utf-8?B?SnVsSDFpUkljMGRFdnlwdmpDY0xZNVpkYTBoNUZFTjdsQkYzOGpzUTd4YXli?=
 =?utf-8?B?WE5XRytYeEs2RlZ6Z0RvTDJ4dmNDMEpQdS9RQTI0N09WWVJML0lPeVRSNWF2?=
 =?utf-8?B?TmFpanVxOE8zc2k3RjBXd3k4Y0Uxa3g1eFg0WG9uWG0xc3NYc1dkV2VvRHpJ?=
 =?utf-8?B?anpoSmI1RmVmOVJ5VjI2QUZDbENtTktxVmpyMjdONDVBdG96Z3RzdkNCOWlF?=
 =?utf-8?B?R2l0MFdHM284bk1YRncyam1qSU8vVndtMFpXczVzM3hkUGl4eVVqL1d4S0tC?=
 =?utf-8?B?ZDREYmZKVk5IcytERDBvaExyRjdvbEE2eEhRaE5weG1ocCtmOXh5dWhGckFk?=
 =?utf-8?B?WEphYjZ1N3lsOVhoaE1hTU5xMUZGK1ZEeVhlcXhkTmI1RzhWOERlc3FxTzdN?=
 =?utf-8?B?bkNkSWlqRGl6WTNpVVkzMEw1ZzJrbU5FS3lHd21ENWZsN1VPbE00SHBuSWg0?=
 =?utf-8?B?YkdhSUREMDNPTjMvRlpHUmNmS2MvemtuWlptMUplaklnTHlkT0dFdWFKNm1s?=
 =?utf-8?B?SHlEOFBwT1pVSjFoOFJlRGQzRjVIMmhaQ0VYb2ZHNkdaNXhMRjJLK1YzNG53?=
 =?utf-8?B?Z0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E525ABCA0E2A5844A531963F631411DE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/cTxB7lQ5pS4QLqBqVvc7yyQXge6ZPwkByytGFHvRL62qOfVWZ7c+180gxHeOJ5xPAj13RAePaFDhNwPnGKv1j4s/u6I9IElC5SBrJ+XTDXifrXgNJjTQlDOKLVlurS+KjxlGNwM0Fr/dSxnKDNXDZEe2R6Zw59OnJJWWe1ijHpY8+3rm0PD9Gczg+HWo348hRUp/gAdsbsllRm/fT0rADm5GzN2W0Gs/bxlT8/gPTR54msfDTgRnYOZOCMJrzh8/ZlrcUcfy4nBk5Vl+hnDvm3bmHq+N4Ml1y/fkUxmVAu8X/2tr64fdPJlpn7xq/8G7kLk+PTCJQTFkij20q8vOFGbXJuY08nQdCFMFq2MaQCI3zeB5bdI2OvBqAQwYyEDTFpotiuzrHS0TFSTvvIDjQj5ztzIPNI8mvJJAVVsmpoK/TV+VSP7bbfqYFRYOxrfg//o4lQv8/qmi50XkEoDzrGuOUk4kfIjaxADLYSroeQY9/nAUAHCgv7aNXzgH+px1E2qUJhikNSGv0k5u4MjL2xEOLCaXbDlGR3j6/QBd6DflT0CFETABBihJl/xBGxPf+GGxiR5ibuix9+TfSGYruCJXJxRUt90KKHToCjcXU8ca84zt08bf5q202QeXPlL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e585014-3321-4186-a0d4-08dcb19d3afc
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2024 20:13:23.6944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hSpvYP0vCHNM2Hjjie2r4lEL2PnCvIpdh6jRvNRKIDq62fHKtnNS+H6j5tVni9zRxUOJYauaSlEpY4n/9wcB33vjbvA2dfKpftjias45rAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8160

T24gMzAuMDcuMjQgMjM6MzQsIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+IA0KPiDlnKggMjAyNC83
LzMwIDIwOjAzLCBKb2hhbm5lcyBUaHVtc2hpcm4g5YaZ6YGTOg0KPj4gV2hlbiBkb2luZyByZWxv
Y2F0aW9uIG9uIFJTVCBiYWNrZWQgZmlsZXN5c3RlbXMsIHRoZXJlIGlzIGEgcG9zc2liaWxpdHkg
b2YNCj4+IGEgc2NhdHRlci1nYXRoZXIgbGlzdCBjb3JydXB0aW9uLg0KPj4NCj4+IFNlZSBwYXRj
aCA0IGZvciBkZXRhaWxzLg0KPj4NCj4+IENJIExpbms6IGh0dHBzOi8vZ2l0aHViLmNvbS9idHJm
cy9saW51eC9hY3Rpb25zL3J1bnMvMTAxNDM4MDQwMzgNCj4+DQo+PiAtLS0NCj4+IENoYW5nZXMg
aW4gdjI6DQo+PiAtIENoYW5nZSBSU1QgbG9va3VwIGVycm9yIG1lc3NhZ2UgdG8gZGVidWcNCj4+
IC0gTGluayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI0MDcyOS1kZWJ1Zy12
MS0wLWYwYjNkNzhkOTQzOEBrZXJuZWwub3JnDQo+Pg0KPj4gLS0tDQo+PiBKb2hhbm5lcyBUaHVt
c2hpcm4gKDUpOg0KPj4gICAgICAgICBidHJmczogZG9uJ3QgZHVtcCBzdHJpcGUtdHJlZSBvbiBs
b29rdXAgZXJyb3INCj4+ICAgICAgICAgYnRyZnM6IHJlbmFtZSBidHJmc19pb19zdHJpcGU6Omlz
X3NjcnViIHRvIHJzdF9zZWFyY2hfY29tbWl0X3Jvb3QNCj4+ICAgICAgICAgYnRyZnM6IHNldCBy
c3Rfc2VhcmNoX2NvbW1pdF9yb290IGluIGNhc2Ugb2YgcmVsb2NhdGlvbg0KPj4gICAgICAgICBi
dHJmczogZG9uJ3QgcmVhZGFoZWFkIHRoZSByZWxvY2F0aW9uIGlub2RlIG9uIFJTVA0KPj4gICAg
ICAgICBidHJmczogY2hhbmdlIFJTVCBsb29rdXAgZXJyb3IgbWVzc2FnZSB0byBkZWJ1Zw0KPiAN
Cj4gUmV2aWV3ZWQtYnk6IFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPg0KPiANCj4gVGhlIHNvbHV0
aW9uIGxvb2tzIGZpbmUgdG8gbWUsIGJ1dCBJIGhhdmUgb25lIGV4dHJhIHF1ZXN0aW9uIHJlbGF0
ZWQgdG8NCj4gdGhlIHJlYWRhaGVhZC4NCj4gDQo+ICAgICBEb2VzIHRoZSByZWFkYWhlYWQgZmFp
bCBiZWNhdXNlIGl0J3MgcmVhZGluZyBzb21lIHJhbmdlIG5vdCBjb3ZlcmVkIGJ5DQo+ICAgICBh
bnkgZXh0ZW50Pw0KDQpUQkggSSdtIG5vdCAxMDAlIGNlcnRhaW4gaG93IGl0IGhhcHBlbnMuIFRo
ZSByZWFkYWhlYWQgZmFpbHMgYmVjYXVzZSB3ZSANCmhhdmUgYSBSU1QgbG9va3VwIGVycm9yLiBU
aGlzIGNvdWxkIGJlIGJlY2F1c2Ugb2YgcHJlYWxsb2NhdGVkIGV4dGVudHMgDQooSm9zZWYncyBh
c3N1bXB0aW9uKSBvciBzb21ldGhpbmcgZWxzZS4NCg0KSSBjb3VsZCBub3QgMTAwJSB2ZXJpZnkg
dGhhdCBpdCBpcyBvbmx5IHByZWFsbG9jYXRlZCBleHRlbnRzLCBidXQgbXkgDQpkZWJ1ZyBjb2Rl
IGNvdWxkJ3ZlIGJlZW4gaW5jb21wbGV0ZSBhcyB3ZWxsLg0KDQpJIHdvdWxkIHJlYWxseSByZWFs
bHkgbG92ZSB0byBoYXZlIGEgYmV0dGVyIGV4cGxhbmF0aW9uLCBidXQgSSBkb24ndCANCmhhdmUg
b25lIHlldC4NCg0KSSdtIHNvcnJ5IHRvIGRpc2FwcG9pbnQgeW91IGhlcmUuDQoNCkJ5dGUsDQoJ
Sm9oYW5uZXMNCg0K

