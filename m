Return-Path: <linux-btrfs+bounces-15715-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254F0B13D79
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 16:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B01F63B9090
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 14:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30A026FDAC;
	Mon, 28 Jul 2025 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NYe1RYuT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZJiw8K5f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BCE26FD88
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753713745; cv=fail; b=p8wVmXfhRy4rUETQYUidOAGJn2PVkiMk34w3lTNMmCHdvzWhpUZ9/GbcGrNFIAIT9dUwM3pgTyCe7wWUx9VDifgSV+m52MUG3t1rrk3XhBfd9EyHEejbaqIxXAu/753fdhv/ZRMHO1AeYP4mmBX9p/dHVcAZpGndhnEj2u7Q3xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753713745; c=relaxed/simple;
	bh=ARTpn4JF662++9o1UYO1sjUfK7ro0B35u35n+BFwXn4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jdgEHe7+zNWzRziYMnlZYRYRDqwm+nXsT6CyRBdgIXkokoIVSnfwoAla3uenTgKdPJd7BoaaAl2VQ7nNVFCeorDzO0OCfeHSeXCVpcdlCDP2rQqaZYgBUSQikGIx3cpvTxsPV9EmO8qe3yCgjnwMeulv97/ek9jjIF5dlhPxADA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NYe1RYuT; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ZJiw8K5f; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1753713743; x=1785249743;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=ARTpn4JF662++9o1UYO1sjUfK7ro0B35u35n+BFwXn4=;
  b=NYe1RYuTykzXJ2LiVPM8lf1M4Zi3wj5hGfS9mkwIR2x8Orr3j9zIP+UI
   hZMcBnewPve/WE3Xkridki5EoWAnt1qr2JuDBR4gSeCFuGYG+EoXGqskD
   kOO2HDfqGGJstJiyiJtsgqfD87k+bLu79cSynMmicXs7Io4cKkjfDfxhA
   QPoTrM5tJfq/Wa8PW2seL9QV0mxp5M6dHUaSdvM/Yw678D8TJpwn03V5+
   6w0aHEiTCufR0MoOoCtydc/UJ4ZzaseY9vTsqK+Z15Z2/ZMnyZLVdon8f
   J8xRZI0SfON70NwFujEUn2pCQKTTO+I6YRsjft6MBy9XCeed35hfW4GYg
   g==;
X-CSE-ConnectionGUID: NPSwFwNiSmeoAKT2rsB3KA==
X-CSE-MsgGUID: H0ra5B0WQ6K2+2DHORkXmA==
X-IronPort-AV: E=Sophos;i="6.16,339,1744041600"; 
   d="scan'208";a="104025393"
Received: from mail-bn8nam11on2062.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([40.107.236.62])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2025 22:42:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QK0LZkvTz4foFXKRL5SeWnLuLBAU5HN/xq0DJ5v4Z186a9ZrRm1/lbSSCf77siYp+pU+MzAwKKLqYCAs7ARmXZuwH7nINHXd4yOpwCQOTKF1NchUX+EZs8zV6NQ7aVrb8vyDXDqr+lGvixujKiKf5ibbOsCNsIdykMyh0m5yhcIJN+TDL6SQCpiH03J11aL3Jl5vP/1Far96za/WyN4VnNWvxUrWY5SxQ0uyAoT137r3l8FhWJNlYGtDgHLvPzJALGr9tUg/VNiHHvOqOTuNlCJ1ZcdTAlbLB6k31cEu1RCLsC1yB5tZcIR22c6cV2xlZdKwbB3p1mfVLsjqkIG4oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARTpn4JF662++9o1UYO1sjUfK7ro0B35u35n+BFwXn4=;
 b=xGkmErTdw30oB+nlLrWEvxVxs9qtvrOvRJglWYkUK6EVQxY2v/91D8X2co6S/rP0jlNRkye8xKZco2Tt7t8NVWFygfekgLACH5EH5IdpUeB6ojX2qOQ2kqxp1mg3bWz04TGuWSBpt8RaN6WXEi+/Wr2AkpCoBnr70BLLCd+gcuqZpK9jYm2ynbJOnI/X6nspPwDxN0VvZPCLAwWTyI9W1s2YH4T7cgbhJ8DxtWpKTCioHA9SVj1SiFDOMcGQmds9KWSJnXmQsTID7o7g8zu2OPuFQcudwZT/0P1/GywonCL5BEUPo6lP50SFiUYei4T6jgKFWQjcN4lsZcwlM9lI9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARTpn4JF662++9o1UYO1sjUfK7ro0B35u35n+BFwXn4=;
 b=ZJiw8K5fLFxVgtEVDR/FOaYv2DtLNU0ZBpo18Mu0ABp0AsoyLP9QPXcebWkbGa68coaEJpeqtbiKPMX4e9/3hl+GtCQ6Zw/WtqOmSoTmX6OgGTQdeHIyEG3wiH4eQfm44ETTsU/7nMhI2HkDntQrdK6On3XlUsW7WuKkMnQTeDs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB7570.namprd04.prod.outlook.com (2603:10b6:303:a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Mon, 28 Jul
 2025 14:42:19 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 14:42:18 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] btrfs: simplify error handling logic for btrfs_link()
Thread-Topic: [PATCH 3/3] btrfs: simplify error handling logic for
 btrfs_link()
Thread-Index: AQHb/6Oe9lofMPkFrEqkjmQC2uX24rRHnFsA
Date: Mon, 28 Jul 2025 14:42:18 +0000
Message-ID: <847191e9-e4f3-4359-bdf6-22b1bd95a0ec@wdc.com>
References: <cover.1753469762.git.fdmanana@suse.com>
 <fcedbeb4d8f0c9afbd99d0c768ad181842b41dad.1753469763.git.fdmanana@suse.com>
In-Reply-To:
 <fcedbeb4d8f0c9afbd99d0c768ad181842b41dad.1753469763.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB7570:EE_
x-ms-office365-filtering-correlation-id: 8a3b640b-511a-45ad-2f39-08ddcde4f42f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SUpvTjRaMmtHTDFxL0ZRUnV0K1crNTdZdmRuQk1sYjBxdjNkYkdVRDNESURP?=
 =?utf-8?B?cWVMcjMzMVoxOXNGZ2doUkszcUhLVFQwZnRrclVJV0IyYTB4Q2VZWk92dUNY?=
 =?utf-8?B?ZjFxNTIxUGZINzhmRzZHaWNuRjhzdDMweGMyQU9tSU1YSXRSNkQ1UXRGaGd6?=
 =?utf-8?B?R1o0RXF4dlRHVXNhNWhuWVNxOGg3K1F3K2VDSm9MRCtWQWkzTkgxa1VsdXZN?=
 =?utf-8?B?U3RNQmptb3prWHZYbnhQNlNzYVI2MjR4UGF6cWJNTUU1TDR2cTRnbkRvZStM?=
 =?utf-8?B?RmF5MnBSK2Fla0lQN2RUTXVoeWFBZmtFNVVZK1l1QmQ1a1pocktSWnMvdGJJ?=
 =?utf-8?B?Qk4vbTFaakxZTG1BcTAxTm5QMkFadFo4Zk5NcG1EZHJSZzZpZWlNNWk4STNG?=
 =?utf-8?B?a3BEZlBGVzRTUEllWHFBeDhlbHZNZG5vTU1lN2VmdnROWVAraFlVOVREU0Rw?=
 =?utf-8?B?YnJHTm5zcG55K1NKRU10aFlpY21vM25yVXV6UStCeVorR3ZNWmYyVmJacGhn?=
 =?utf-8?B?NTA0eGtiM0U4a0cwRWN5d2xwb1krY1JXU0tyYU9hc1ZVZXJhWEJpL2hyZWJJ?=
 =?utf-8?B?d1d4SEhvTGhremdjK0hhVENIQ3g4RTBLbklXSnRBYnJuVDNEeFc1R0RGb2lR?=
 =?utf-8?B?UkkzdkI2ODhLaG92cFdPMzYwbzhuM0E5azJWbm1uMVhud0tvYmpYQnpSN2Yz?=
 =?utf-8?B?QVNGUTVVTHBrTS9PRG1xTzM2VVR1YVY4NkVoWW9FNlNQUW5qZlBQNFpzZHUw?=
 =?utf-8?B?L0hEdHJwc0t5VzZNQlY3MTZWM0pYbUJwU0c5ZVJHZHRPVmlyc2RrcUxiUXhv?=
 =?utf-8?B?djc1VGVnQmhTSHNPVWNGQi9lb0NXYzhtMmVQOVZpL2JVOVcrNDBuazV3amty?=
 =?utf-8?B?a3NpbVdJcUhzck5sdi9xVmR3eDM1OVd6MVYvT3VnN0t2dS9hMTZLeFFWckRx?=
 =?utf-8?B?VzEwdnNPWXZaMlFhR0VPSjFzaUdwUGg0TnFtVEI2NXFsc3hYaUFjYmRhMWJx?=
 =?utf-8?B?SURPZzZnMmJlYXF5OTQ2bktESU03bk14WjQvUGxMSFFVVnhsYnBWQTFNVUtz?=
 =?utf-8?B?YTVtT29OeHBHTnEydU9oSTAza0gzazlmbnBaMkN0MDN1ZjhCb3lOMXNHUnJj?=
 =?utf-8?B?WndJb21OMHlpT2hNUEFvUHAxY0IrU1lQS2xRUml6aStRMHljV1hiTCs4dlFz?=
 =?utf-8?B?Q2lRQXRja0k2V3pHME05RGxWemJ1VlpQaTFxcWxaUmdWQy9ZMVI1Q2Yyd1FW?=
 =?utf-8?B?cWM3d0o0eXRRWUx0c1J6bGJ4Uy8zL2RxOElNQlFMTmhOZ0FWTERUMVpLdENC?=
 =?utf-8?B?bFQwZ3NTWjJPc2VkTWxvTWNlOG56Nk56bS9TbHVNQ3VieG4wdzRZWTkyRnNM?=
 =?utf-8?B?c2pEMldLRWpnY3RBN2ZKVXM1UVhqWUdNaHVwd0VCcWdQaWF0U1dsRmZKbTZa?=
 =?utf-8?B?UUI5Z1FBL29TWDIzUHo4UVpjcXNiNjVrbkEyZm0yOGtzUEdwdzlrTEFCazVF?=
 =?utf-8?B?TFZYdkFyUG9kbVhLdkJ1bThyWnZCSHRJQVZHanR3OWVDQ3NaeDRwS3c2ZXRz?=
 =?utf-8?B?MlBrdzg2U2NWY0lJaVFmYm1Cazg0UlJkQXI3ei9CdEVYYVdacFdQd0xRYkdn?=
 =?utf-8?B?Z245SXZOdGtwYmJTT3lKc0FvR2I5elAwK2NCOTM4RWs3dE1IZWNyL21kZlRN?=
 =?utf-8?B?MmJQUTY2T0FZMTdJbklGa2YyQ3JhZWtYQ05rdWpoalFzUkF0MHZkUDFZTnlY?=
 =?utf-8?B?VVV0TmxpTEl5WFhyWWhkTDhNRnhpa2RqL3VnVzJFT2VRQWwwNG5HZDhHYlhm?=
 =?utf-8?B?aitNcnNUQmEwcWpJYjE4V21od2NzUEZRamlCRFQ1aHZSeDBXUjJiNi9RNTRD?=
 =?utf-8?B?VWdwdHpUaEtPaUZLYUlMWXZOdlVWZkhqSTVUc1pXVTdOemw4NFJrZUFESll3?=
 =?utf-8?B?d1RhRGsvanVPalNldVdQMXlpYWF0M0UxM3Zmd3BYWk10SG9mbjFsc1MvbTJO?=
 =?utf-8?B?OUNpYnIvUk5BPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YytZSFF5MTMzbUY5b2pweHo1UUZTQlorSFp6SzEvZWRyNmJjOW5HWDNqamxE?=
 =?utf-8?B?YWVNeWpKcUJPc1FkOGEyKzB2Y3kzaFZ0WWVEVndwY2hTeVJuNGFyOTk4RG1k?=
 =?utf-8?B?eEFGeUtkM0JOMEVWSmh5NFZZT3p0TTlqZDJMRDhaMHBLQkFuVnBLTEwvOWVL?=
 =?utf-8?B?V0Y0OVF4RjFqTmFsOWp2d0UxTXpYcnhTSWV2SkZWcUgzdStNOEwxM2dZOXVq?=
 =?utf-8?B?Z04xNEdaUm0rMEJtL0tjMWtJb2NZYnNhOFlPNUJqeW9rS1V6UmcwdDBwUTdT?=
 =?utf-8?B?dzBDYTdWNVE2Q29yZmxCU0J0NkNVVS9VYW84YjduYlZzMm9XVFhkcmN3WFpy?=
 =?utf-8?B?ekZXSmpoTkxOT3RCYVVYYXRhY3QxZk5yZkVrZk02c3ZiZDNFYmxvMmJlSVox?=
 =?utf-8?B?YzVxZExGMEJTMFA5Z2pPWmdWTThjSWhHQmxRUFo1dHIzU1A1b0t0M3Ivc0lo?=
 =?utf-8?B?T2VmM3NYdHhxbEVWNGE3NzJjRHl5cklYUTh4QzFKcE1IYUFIWHJnUzZBblpN?=
 =?utf-8?B?TzBUc09OcXd3WHB3KytMZHh3dS9QRTVDV1pMYTk4NHZ2Nk1tenNnMmdYdXlN?=
 =?utf-8?B?czhFYnR1ZkxNOE9mT05JZkZBY3JVaDlZQlRkcVNoQnhtYmFkaEF6ZjhFOXI0?=
 =?utf-8?B?OXlIRjFna2hwUkd4MWp5Mnh0SCtqUUlFU0dYMVFPS2Q1bS8rS0RrZk9RRWVV?=
 =?utf-8?B?MnEvVzFhNWJrL3FhamFRRENQNVAreGxiZnJmZHgySWxUWE5yRVVLOE5IOFVT?=
 =?utf-8?B?WFdIZWhBMk5tclRjNHZLTFV2S1h3Um5Sclg4UGEyZGNDdlBKYlFnNDNjYkI4?=
 =?utf-8?B?eVVjc3k1MDNsVUovV2oyRmE4U2M3NWhQaXRQUzlmbWs3b3VsV2hJYXUxa3Ev?=
 =?utf-8?B?dmRKS2g0YmFnVmV3T2k2RDlZWXkvV0xVbmtLTFhWOVNWNE80M0E3K00zWFVH?=
 =?utf-8?B?OUpFNSt4QXV1MzNBNUNRRkUxc2JQbEhjcFFSTjBpM3VxdDEwUUxlZFhTUkZs?=
 =?utf-8?B?ZXFpb082V2FYanJWdmV6OTMzNU56WDJvSTlFOE00cHdLdjQwQVRQY2p1UmNm?=
 =?utf-8?B?bWNNMG1JOUR6a3pQZnIzekxkUldkMG8wR2k3SFNNREVlQ2JrbStObENDbS83?=
 =?utf-8?B?SEFTdDlqMHJJZGdvbFA0SGdrZUFuVVZqYUl5N21RNEZLYXEzeVR5dHRDQTFF?=
 =?utf-8?B?SlRadEFHY01zUzQxeGtBYW1EeTVxWXBPNVFNcUdOZlR5RUovZWxqV2tTOEVJ?=
 =?utf-8?B?QnBCQTV0SHVBZGo5TUd1aFVwKzNIMlRNcWI0cFJvQ0p2QXJWVG53bFlONVhI?=
 =?utf-8?B?VzE0a20rcGdRcFU0T3VWOWJDaTdQaS80NjBLT3htMnd0Z05FTm1lNXkrMk4z?=
 =?utf-8?B?MmlGYWpnZkZhdnZGeDYwYjl2ZGJlYjhnbVBQMHRLWWo0U2IxVkJjcnBhUHIw?=
 =?utf-8?B?ajAvL2hjQXAvamFBblRWelBzd21rTW80OThiMEw2QUZIdGRseUpsb0FWbnh0?=
 =?utf-8?B?MDNWazR0K20rVktpWmdXWEhvYUZCZUVXbUhvMEdKVlpIM2Zmc1NUeFB4WWxn?=
 =?utf-8?B?L3NSa2NCNDBMTFo4Smt5dCtkSUJIcUM0d2ZxcTlKL0wxWjMzemZ3M3R3VGlh?=
 =?utf-8?B?Mmg4MENvUm8zdC9uQlJzT0ZZazZJQUZWNXpqVGhzNGxQL1gxTzZyNWJsd0VK?=
 =?utf-8?B?NEdwVFJrRGVNWTVramZVWXVYanV3NVM5aE5aUkMxVThla0FOekdaajlrUDNN?=
 =?utf-8?B?WVJaTzNSdHkwVTUrc3dhdStsYU5oQmZ6VTRTaXUzU1ByeGlxejZ6Z3hIWU95?=
 =?utf-8?B?T21kTitrVFJHMGxaNDdNWnVCQm9iV1FoREpxZ1o3Z3RNSmhaT0hoUTl0RHpB?=
 =?utf-8?B?VjI4NTd3Y1BwNzFiMGxIZDhOQm5pT0RrRVZkMVRRSmtoZmFBV1hGU1UvaDJR?=
 =?utf-8?B?QmVuNGU1Wk50MnNxL2sxL2RGVEhsSmRib1B0NUtvWnNHbjNRTlpDaUk0MWt0?=
 =?utf-8?B?T0dwbFE1R0JTTVJqVlcrNHl5cjl3NS9NcnhRT3h4OS9JTFFxeWF6VnZjTjNJ?=
 =?utf-8?B?eko2OUZZMEwwNVd1QUxBenRsckpDaUZDRG1HWUFzM3gyNlBLZGU0WEg1V0g2?=
 =?utf-8?B?ZVNJbmUrTUoyS3lxSU03dTI1WU44dDFhMXlwV09zR3pWSWdiM1F3Q1h3ZmpQ?=
 =?utf-8?B?bXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E6D855E70497446AD080C2EE9F430C4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Rs3r3/2WWatAou6dmNb5TKKJ5RkoS4VEVfY/g758nmHn0iRak7QRLwrsqE3zJHf86aydHyJorXBMc/hntPmREscUEk+6kNg9UMfCQLY6dDVKpsF0DLJnR3EeHRSWxLogEIx4Gw9hUBI513MgNxEZAQVcH1gCVcQ7wJqgp+CusneoeOeaaS/r0IdPTTJ36PJsPHX+kZPJX54CDnL2xQ/vSjBXgPYwmta9kpJo4m1bntRBrLpWAaVgH5ku35Er8t4GEdiOFrikas8DxfjqsJiVvH3eyJQNAIAf2s8xKQqAY38b2MoLwOkkxVcSTzDFxZ7Aa33z+1nzPb9Sgpure1yi8ayhgmz7CieaFevHHKq3GrWOHyQwxgnuibn/EfQPEKIDhBHlmZCNoNKT/Ax3+xxz2xDwCnrbf5kI8JjUXo22N6/43oM6BWzeb6SSAvX+gSlcn2HlN3kCUGFb0JBPRJjLmbUuEzOH1mlYYJ/DgqVQEpK42ZQA7MFMO4OkqSeQ6F0KI94nAEYXRpJOr1Icu4A9Zx0ekBKsitSJeB/G4TX7hA9NR7ozM7nODoKuzwuKVQ52RstO5utf926d6ZGWPZEqJ+qYvJlXnBETeGC/V8aIAm7AxkRRHStxoBXQxFAdNOr6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3b640b-511a-45ad-2f39-08ddcde4f42f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 14:42:18.9240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LUCa4E+HYGf/Jau53wCczALCdmUzYGfIXwfC5EISnUExeeDx2zC5+Pki22T0yPYsSjUCfKqjnMSlRoDqStL11ZLCLrzu3SdziWHOFzgvz5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7570

T24gNy8yOC8yNSAxMTo0MCBBTSwgZmRtYW5hbmFAa2VybmVsLm9yZyB3cm90ZToNCj4gKwkvKiBM
aW5rIGFkZGVkIG5vdyB3ZSB1cGRhdGUgdGhlIGlub2RlIGl0ZW0gd2l0aCB0aGUgbmV3IGxpbmsg
Y291bnQuICovDQo+ICsJaW5jX25saW5rKGlub2RlKTsNCj4gKwlyZXQgPSBidHJmc191cGRhdGVf
aW5vZGUodHJhbnMsIEJUUkZTX0koaW5vZGUpKTsNCj4gICAJaWYgKHJldCkgew0KPiAtCQlkcm9w
X2lub2RlID0gMTsNCj4gLQl9IGVsc2Ugew0KPiAtCQlzdHJ1Y3QgZGVudHJ5ICpwYXJlbnQgPSBk
ZW50cnktPmRfcGFyZW50Ow0KPiArCQlidHJmc19hYm9ydF90cmFuc2FjdGlvbih0cmFucywgcmV0
KTsNCj4gKwkJZ290byBmYWlsOw0KPiArCX0NCg0KDQpEb24ndCB3ZSBuZWVkIHRvIGNhbGwgImlu
b2RlX2RlY19saW5rX2NvdW50KGlub2RlKTsiIGhlcmU/IEl0IHVzZWQgdG8gYmUgDQppbiB0aGUg
b2xkICJkcm9wX2lub2RlIiBjYXNlIGJ1dCBpdCdzIGdvbmUgbm93LiBBbmQgaW4gdGhlIGNvbW1p
dCANCm1lc3NhZ2UgeW91IHN0YXRlOg0KDQpbLi4uXVRoaXMgbWFrZXMgdGhlIGVycm9yIGhhbmRs
aW5nIGxvZ2ljIHNpbXBsZXIgYnkgYXZvaWRpbmcgdGhlIG5lZWQgZm9yIHRoZSAnZHJvcF9pbm9k
ZScNCnZhcmlhYmxlIHRvIHNpZ25hbCBpZiB3ZSBuZWVkIHRvIHVuZG8gdGhlIGxpbmsgY291bnQg
aW5jcmVtZW50IGFuZCB0aGUgaW5vZGUgcmVmY291bnQNCmluY3JlYXNlIHVuZGVyIHRoZSAnZmFp
bCcgbGFiZWwuWy4uLl0NCg0KU28gdGhlICJ1bmRvIGlub2RlIHJlZmNvdW50IGluY3JlYXNlIiBw
YXJ0IGlzIGdvbmUgbm93Lg0KDQo=

