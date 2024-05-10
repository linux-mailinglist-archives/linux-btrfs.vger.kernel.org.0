Return-Path: <linux-btrfs+bounces-4885-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFFF8C203D
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 11:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 954C61F2295F
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 09:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A6715FD03;
	Fri, 10 May 2024 09:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jrR02nnT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LZwLx76z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F6638396
	for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2024 09:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332178; cv=fail; b=ftxoirsB9HlGuscNM4jdprp3/sGvYXsmlg95EI8veAVlG0eKddQu/QdGB/iFvNL3BVRkI9tnknv4XlDcFsrTaxzG/40LWl4H1XGWpwbneeRmxrt63DY/JQC3XTe2wDRA2N6+40rI00E8V4cVY1tFlTWloaqsaW+1qnWlEfqjsOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332178; c=relaxed/simple;
	bh=aWpYKDj6JtN7Mdy9xXQskSPY1UQ4zdwLfiyCUUQ69II=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oIM4j+recnnTk7jFV+0L+rvRBB2f6/Am9ffzpdchnlpAINknoRz3Y8WJWaKrg5dxQi1rQheMZCsFffL4QdwMR+pHI3HXIN0yXZ8SqqB5PRoq+e+9gseD6kPF5TM3AvFlRnIPQdPpejMZpmywc/SlW2aJD2hrP+rdM8364sM3Sqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jrR02nnT; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=LZwLx76z; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1715332175; x=1746868175;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aWpYKDj6JtN7Mdy9xXQskSPY1UQ4zdwLfiyCUUQ69II=;
  b=jrR02nnT726edX0F2wCyAdQezbRfXOo/kBd/nZ7ZVMVPiNqGFCCiZDjZ
   0ciAhzGmINUPFYjdWz42o51Yc2iZaMwnIs8iK7CiM5iKodVUE2Hdrlb6K
   xZKhfjKMafjW2EG3shDzY+5MGYeVXVhQ7GPWs74IqM0b7Qr+7drfdXmU4
   Z2GZgRroZx22FHTMUg/MMkgm869iQuGbOTYQvg9uUG/d86xlnijgPnodg
   hgmexCOudpWdvZe9j1cGGVpYl25uiGIcoslw8Mi/gIz/l84GhY4LJyU+7
   j6FrmlFuWCy7g2+GkqZTZUnw3/U5MwiOgmexvSm8BmFT0hOMNB4+Njxsm
   w==;
X-CSE-ConnectionGUID: HDBRblZCSc6EiPlSGVjDGw==
X-CSE-MsgGUID: hTLyTvxwStaJ3foOJ2wHiA==
X-IronPort-AV: E=Sophos;i="6.08,150,1712592000"; 
   d="scan'208";a="16076295"
Received: from mail-centralusazlp17013022.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.22])
  by ob1.hgst.iphmx.com with ESMTP; 10 May 2024 17:09:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ehm9nShOmdddKYdEizXhP+LYhrSuAYxGtcrr4NdOTAKZa5W9qmeJghVIosEtZA1lxgI5DneDpmwyDfqoXHiQ18R5FTK5da6iPnT4fKA2iczE9uDXd3AUBPgBhJuAbevYX7trPJZhIwzA6WeITM5KIWpmD0ADrXnM1fCNiVO3wqGQjhK/6ZEcZnfIrZQ5C/xMc5DBgOQXV5i/WKfF+oxRi7vME7VtAJ+H9nfxOdUDL0mKm9RVkumesVRcXhc+o/vfqNSQZi97l4kdErkXUGGl5HDK2Cs0joUFfEYsSfhxoQ/ediAS+tbFDBJxylQSndlfMN9ttjMAL5sQEMy2NDm8kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWpYKDj6JtN7Mdy9xXQskSPY1UQ4zdwLfiyCUUQ69II=;
 b=U6Dqj7qZmeepiwBW3Ym0Ub+HcOIIFGZ8bC4hOC3eAAywy0T2+nR1A5W5N2fZ8NQ+mR7YpW0IexpLDKb26/aYAu0aiMD7hJWi46IaxzuhPnvZfXv1FEqeZzdRnCo9i49J4efg8fOosSpKEarbsZRZS+qCoIDWFK7xRg1EP9OIc+USNRfP8HrWgETlIJZ/pTnLW29TnzsnhouS0RAVOG05MYfsyPRxedu7+FKIbpRM20vMcJQ/KyibaziJb35J3S5WKMGsK/mPKUXsgZpjHsTICqP/IWB4ULZSVpZx97R+5fRdF5tQgBOxpbzG7lgU1d5jzih9CvHrIEDFxD6eGzPgGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWpYKDj6JtN7Mdy9xXQskSPY1UQ4zdwLfiyCUUQ69II=;
 b=LZwLx76zzDAm4vjt9btb3w6UnODKGCtG+ntHWYAksblhvZyv9vbeAkeCOwXnVkUsmapInxpWx9dCYWaBoonn/8ZPOsLtz28xzGzNDeHhMXAmiBvvDZT5YdmN5Wi3AyVB7iwQigUskslXgCszXrG5KTCiC+ZZKr/ZmC8dr6gU40o=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL3PR04MB8185.namprd04.prod.outlook.com (2603:10b6:208:348::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 09:09:26 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 09:09:26 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>, Johannes Thumshirn <jth@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Filipe Manana
	<fdmanana@kernel.org>
Subject: Re: [PATCH v2 0/2] don't hold dev_replace rwsem over whole of
 btrfs_map_block
Thread-Topic: [PATCH v2 0/2] don't hold dev_replace rwsem over whole of
 btrfs_map_block
Thread-Index: AQHaoTyJkV6lfDXEQkKSU3JjIbRc3rGPLVIAgAEDtoA=
Date: Fri, 10 May 2024 09:09:26 +0000
Message-ID: <1d84c2d0-62fa-4212-b884-8bad9ec4bc3b@wdc.com>
References: <20240508114016.18119-1-jth@kernel.org>
 <20240509173952.GM13977@twin.jikos.cz>
In-Reply-To: <20240509173952.GM13977@twin.jikos.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL3PR04MB8185:EE_
x-ms-office365-filtering-correlation-id: 5d97c05f-8cf6-4165-ed34-08dc70d0e426
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?WkhhY0xRZ0NLMFdPbjUrWjhSbFA3SG5Jd2RMZHpNc0U0Y3IvcGZvZjgvb0lC?=
 =?utf-8?B?L1FwamVhMHpWdTZlWU44WHdoa0FWZ0dwd2NrR1loWjhhUGJCTUcwQlNMOE1G?=
 =?utf-8?B?VDdKTzBBVDYzQjNqc01hdS9SeEVHWGIxcmsyYllYVnh5U0NSSHlScjQreUdh?=
 =?utf-8?B?dk1RR0h5RjFpaDdCUzFMTmRFZk90ODU3c3Nya05VN1VzemxJZENDRjRLUG9I?=
 =?utf-8?B?dGY4ODk0WXd1QkJmanF6emxOUHdNUWlIYzV5WGdJWk9DSE13WlpqL1h2WDJH?=
 =?utf-8?B?QWZJNnlMYUVtUzN0V280YTBBRTA2NTdROEdqR1BnbHJNM0VSTmFWVThjQitV?=
 =?utf-8?B?dTlRSjQwZk5uMG91ejd3R09LbEZXQU1YOWhhaHVZeElhQjc1YVNmQURTRzlC?=
 =?utf-8?B?SWdTNzlRWUNsbE1TMDJuT0FLMTVrcE5aampmeVkyOWFybTZsRmF0Q1J2V0FY?=
 =?utf-8?B?bGQzbjBoUkIwQWg1Y2JHZDVja1NqWUFwWUFaeGJ2NlMzVHlCZFV5VlRvU3JJ?=
 =?utf-8?B?ZW9HaUNFMVRFVFZTY1BFOTZLYytoYWI1Y1RjTG1YVHZ3N2o1Qmh5aXdyb0JT?=
 =?utf-8?B?cTdHVWYwL3BqZnZqMnFHTm1sZFhhTUdIenNmV3JiajBJakpLbmM0VE1zdmZ1?=
 =?utf-8?B?a0tCbm9OZXhaa3Z4QzdwbU0rZDdlb3YySUsvNmpRd0FqRmJaMlhkWUZFT1RN?=
 =?utf-8?B?am4vSENIQmhMN0x0cmNDSGJSdHpqV296bjRSM3YxZjdGWkYvWmJya1YwNnk3?=
 =?utf-8?B?ZlZuaG42enVxQ0RHbDYrVjhvdWdMek5nVzlLU2lDZUtUQnltTFNlZ3pjU1k3?=
 =?utf-8?B?UkQwdDVaWlNlMXEwL2hUWFZzQ1V6cU5ubkkwUGdtTVdGRS9UL0RRS0V5WjQr?=
 =?utf-8?B?SE9XcERVdzBNaGNaM29RaUhFMkJ2Kzh6L0p0TWs1bEZmYVJUWGR3TmI1Q3B4?=
 =?utf-8?B?R2NrdHJVUXptaU1sYTl5YjdDaC82MHZKNm82WW9zTEgxcjdyWEtPSUUySUVT?=
 =?utf-8?B?Z3R1QUNobFUySDZpNGxCVkVHV0lKOTFKbmNtM28vVHlzaTdJYVdIYS9Ud3cv?=
 =?utf-8?B?OTdMNzNDNEtYaWxVMkIwYVhkWDEwZnBzdGtmemt6TyttV1pVTFp6L0tPRVZM?=
 =?utf-8?B?MExra243cnFOcGJETkR2N1FpUWxzbEwyc2p6RVQxWndmZ2wxRm1IMTZ5cmRa?=
 =?utf-8?B?a1Jtak5Db3Z5Tk9lL1BLZk40SGp4TWMyT2ZJNTNQU3lZR2NjbXlkek8xbzUv?=
 =?utf-8?B?Q1p0ZTZieEdtTnJ2SEx3NStndFNOK29Sd1BLVHJBQUx3dmtLVlZaN1FlODJH?=
 =?utf-8?B?OElnc2pUdk56U09leU05Z2QyNlVkdnRrWmdTUmNyRG45azZiZWRkcUVSQWRk?=
 =?utf-8?B?L1J6dzNjVUZmbTNlcDFwTUdSNUd6M3dmS0VodnRHWHBwK2ppeGlJc3pyOTB1?=
 =?utf-8?B?S0JSMEFSYzE4dXN3UXcydWRkRi9TYmphbkFmN0xqMkdRdTFaSjZkUU02ZjR1?=
 =?utf-8?B?dTR5RElzMDlyY2U0OHB2MW5Wd01xb0RCeVJrVmJBcXVMaW9rbEdPbWN3cVJt?=
 =?utf-8?B?N3ppV2U0Nm55SFBEZFBGSUVXOGVrUys0ZVU1U3BOWFlNWkVaVmRKdUJRZkVq?=
 =?utf-8?B?WThYV1ZyUGZtazVoeGZJbnJBM0l1VXN3U0tsZlYrWjFiT0pDNzRxYVVHVUxa?=
 =?utf-8?B?L2ZVZjN4TWdnQlQxRzJvWlVnQ0hJRzFndTAzS3hZc0NmUnlxck9mbThBWFJ3?=
 =?utf-8?B?bUpEY3NaejlpZ3Y4UTRsUEF0N0Q1WHNvSm1mY1YwblptVi9ZNWNza0xFSmFN?=
 =?utf-8?B?cThhTlhiRzlZTnk5ZHVDZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RmZQTjBKeWxPRE5EWjhTYjBhMS9MdEIvN0M0Y2RES0JWUmJaL0pWV3RoY2k2?=
 =?utf-8?B?RTRQSUhHTmZBeEhHa0JWN09xQjhWNjRVWmlRNDE5RXZRTFJFRVdCWVhraEhX?=
 =?utf-8?B?dGxqZGJZbzJ3eWlhaStDVDhhWlorZmxaUzVMWkNvSE9aZGJBQkp0RnFXRmx0?=
 =?utf-8?B?WHhwc2RVQTFYRjRDem96cHVjdXJqeUttbXZrcC9jWmVBN0Y2czhkQlBMRENB?=
 =?utf-8?B?Z0FaYVduYzBUR25jNS9xOThHSWNrQTFSNStwMkRZU1N3MGRvK3J3T0YrVG1N?=
 =?utf-8?B?SDZWL0k5cHZuMGcwWTN4dVEzODlpZ3o1ZklpcXI5VnpJZkw5elRuZHF6S0lG?=
 =?utf-8?B?a2lPZFduNUxSMEprR3J4bkkyc3NJSWdmUjBycjFDRjNpYS9YUTJUY1FDSmpI?=
 =?utf-8?B?SFM4ZEF1UDRzUys0VFRhdTY0Ri9vYmc1MlNoeGNBcXJ1ZjZMcjRCVS91UW1J?=
 =?utf-8?B?Qm82YUZaTmpZMFVCVXpsN0pDZkdVYW42Y29jK1FVZUFrYjFkd2dYVHV4NkVw?=
 =?utf-8?B?UTRiNGxwTExkYllHakVPbkZja1pTU2htRjVSU2hReEFHc3R4VWlBb0t0RzFG?=
 =?utf-8?B?Y0JvMFVGU28vREFWQWNyYUtrTFVDM0JNaFN5M1o5NStVaHlZNjJidW1HaE0y?=
 =?utf-8?B?RkFhTEZ3aHROQ0ZVQU8yaWU0cFBIT2J5S010SHpPYkltSllmY0Q1QmdsSno4?=
 =?utf-8?B?OERFT2hlV25JaGFxdjFLbHBWNFlCM3hzazdJbUpiY2ZhdFVIcWtQakt5ZzE4?=
 =?utf-8?B?dlR2NU5zL29JbjdwdXp4OHJiY09xbjMzdGJYZzZjeTE2S2VpRjd6VVdOSjZ2?=
 =?utf-8?B?dE1jVllOcnVtcWcwd0VEV3MwOVdsK29rQ2VISnBrc3lHb1FpNzJmMUNObmlp?=
 =?utf-8?B?dEs1eWtCcWNPNzRKOTN1dXdHTnZaK3N6dWlocE56QnpXYzU4dG1YYjdJenFX?=
 =?utf-8?B?T0h4Yllha0pGaUwvNHA0bEFuMCt1OXlLOVVybnBERDBac3F5RWtyb0s0eC8y?=
 =?utf-8?B?MzQxMUxySVM5SEhmUXlpL0l0dFplcDAwT1VoZEJwSzlyeTBtdkNNbFUxOHBi?=
 =?utf-8?B?VmhxT1NoUUJiSDh5Y1cxeEpvOHlmRGtwdVBqQzlqbmRWejBBZUNtVE9KYlZE?=
 =?utf-8?B?OWp5UWdkR0RhT0VnckVOUEZraFQrK3VzL0VzamZGYXdwTExhQ0VmdlNiMmpE?=
 =?utf-8?B?ZWU3eDQ0aDhqWmUrOGtCWFA2anpHQTNCcjJMNU9LbzhlRkVKWXEzbFk5Z0Vu?=
 =?utf-8?B?RWFxRVRuQzRZb2pOZWhzSisyK0xlS3ZDeWZWU2kwK28xMldvSGlqTkgvdkVF?=
 =?utf-8?B?bWdWc2EwaCtaMEJBTmpHMkhibGJqYkFiSzkwV1k4S2R4MnlGT3E5TUR0Qjd4?=
 =?utf-8?B?TDM4SHhkVUUvZzFEQTYzUXRHSGtHa0FJZEpuNTFubFVuVGxoRkNuZEdnTitu?=
 =?utf-8?B?OUZHZnFJZENoVG1KUDhnZ0ZOVnVhQ0kxSHR1SitLSVhBbStKUHdzZTNyMDVz?=
 =?utf-8?B?aDE5ZGZvOFdqMitLQ0VuTTN1cHF3SnBTYXNoTTdwZHAxK0o0eU1mU2NrMnJs?=
 =?utf-8?B?QWYrUTY0bWRpSDJPK0JMVFlCNmFTekhHYm5MYWx3dWlPSW9LenVydFluclJ0?=
 =?utf-8?B?WTJnaTFtVU5pNUVBTEVCU3FsR25kNjJMREpWS2ovNGwzbXpaWTlSanZoN1Fl?=
 =?utf-8?B?dWVUeThQRkRseVM0TmFCUU5uOXo4aGlxZGZ3WWVnTUNFcllZdWxSNEhLNlVS?=
 =?utf-8?B?UWZDVk84OWcrbzcyMmVPcVl2Ti9KdXd6Y3J3K2RBZC93N0xmMC82eUdva0xo?=
 =?utf-8?B?RzFLakhkTlZXR2lSWVB3a1pwM1FOL0U0aUc2eE1GeEtFd1MwMWxVTkx1cDlk?=
 =?utf-8?B?TTNoYUorbENCMXNJNWM4eVFWZ0ZGNnRTdnpSNm1palNrTUt2QmJEaWZHdGp1?=
 =?utf-8?B?RVhZNmNLQVA2U3ZBTTZqVS9YeHFYYTZ0WktoMzYzd2xUZGtwQm1aazFvNzZy?=
 =?utf-8?B?VTlwUVYwK2lISVI1TFFrTFNyWFlSbW5Dc0pENEFFdXlBaXJzYWJYd1RIS0JG?=
 =?utf-8?B?alByLzM0bE5oQVAzRmhqdmFMcmpycUtoalQrcEk0QjBmU0NkMkJvNFg2Smc4?=
 =?utf-8?B?WVQxTGpXY2FDd2dmeGFEbzlndWdBYkpJdWNxVnptNldjQnpRRW9XOFhXdG9U?=
 =?utf-8?B?Y3hjdHVCVnZDdW9JelBlY2MyQWl4cFR1TVVUV1JEOE5odXRTcnVIQ25zUW9s?=
 =?utf-8?B?U0ZlR1plK1kwMWxQMjZOZ2RsT0pBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <313A8175CD4BC741983832F88CA0B9F7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BD1+EJy93LNeoXHKg7g2GB0vRoQ5ZOImS7Mk23L9U/plVJWvzRmb8pdRpc9Gno6sE2WLuEfvS081DBOXgsH0ftVYPvOejiqY1oeIiL26W9snquCcWnTxiMqmeHngomEDgXLWmoFIIt3zd6CNXdNc3tRXDKPgsMQ7CaoUzXYQaO4WY5u++CpJ4kUVXoKJHpLH9QsMgMsFzOlOthuVeLudeh6a70ngwoVU2+2t/JP6FsooTFtUZ/U7ej8wqWIneG8RhUL7jH2qWaHAa1eUN5IiVC9dd1smcKGaV7nAhs4dD8EBbDuDqQYLXF6xa7HsfYa6akH7ff0nfnbcaiLWCypRwdlqieJsP4jxxJHnUfrvjIirLlrlU6yCSVv9VQ7qhaIr2loARuv3RudZLd6mzdHLAyuVNF1cL5uzDOOo1BR3dbjPzq0w4HVVniXrSoOP3otppUOI77kPyxO/a9sz4MByjJ70CEyDUEPCmaxkZZRgrqfnpVlAWLYZmUfsmFgCTtLJjv4jCO5BA+cIbHzfRFEazj/DpamaHdbplXJGl9ymr6sX8FDuO4uJsU5+VPOEnCwTQZ0cvmXwATm8vyTaTl/D+jcmX8kdP31hM57NEOgC+QePsrjbegSYfGIXsB/3ysn5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d97c05f-8cf6-4165-ed34-08dc70d0e426
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 09:09:26.2637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +0ZvIuQHhrbLpTU8bDkeLcpemwn4UqVGH21qh3ZLeslankW+0CMXXHXB1vP1aJ4fKmBifgLUoskV0wLwfK5zm7DPo+ypDHb2FQzYW2EFhMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8185

T24gMDkuMDUuMjQgMTk6NDAsIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4gT24gV2VkLCBNYXkgMDgs
IDIwMjQgYXQgMDE6NDA6MTRQTSArMDIwMCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4g
RnJvbTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCj4+
DQo+PiBUaGlzIGlzIHRoZSB2MiBvZiAnYnRyZnM6IGRvbid0IGhvbGQgZGV2X3JlcGxhY2Ugcndz
ZW0gb3ZlciB3aG9sZSBvZg0KPj4gYnRyZnNfbWFwX2Jsb2NrJyBzZW50IGFzIGEgc2VyaWVzIGFz
IEkndmUgYWRkZWQgYSAybmQgcGF0Y2gsIHdoaWNoDQo+PiBJJ3ZlIGNhbWUgYWNjcm9zcyB3aGls
ZSBsb29raW5nIGF0IHRoZSBjb2RlLg0KPj4NCj4+IEBGaWxpcGUsIHVuZm9ydHVuYXRlbHkgSSBj
YW4ndCBmaW5kIHRoZSBvcmlnaW5hbCByZXBvcnQgZnJvbSB0aGUgQ0kNCj4+IGFueW1vcmUsIHNv
IEkgZG9uJ3QgaGF2ZSB0aGUgc3RhY2t0cmFjZSBoYW5keS4NCj4gDQo+IEkgY2FuIHJlcHJvZHVj
ZSBpdC4gUGxlYXNlIGVkaXQgaXQgYSBiaXQgZm9yIHRoZSBvZiBjaGFuZ2Vsb2cuDQo+IA0KDQpU
aGFua3MgYSBsb3QsIGFkZGVkIGl0IHRvIHRoZSBjaGFuZ2Vsb2cuDQoNCg==

