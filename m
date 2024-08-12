Return-Path: <linux-btrfs+bounces-7113-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C886594E990
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 11:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED2381C2177B
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 09:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639D516D33B;
	Mon, 12 Aug 2024 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="nUcTFP2P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD77314D712
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2024 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723454425; cv=fail; b=gd/TWY6vmFyitKcYv+5+MuSFxVYRF0atLU23kKjDvewur0pMxcDUbEsYPTIHUeXDs2zUxJHAVO/uEKrnpRr/bsTnnrJ80LjvCYWJym3z26+J2y6PH048DVFN/Mih3Ul6ZC8QObLnPaA0FqnrMR4WifKENYEBIrGoNmDnkyFthe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723454425; c=relaxed/simple;
	bh=SJz5uoJSrMppySD8fuLovWkBUn8ep2waRDw81fhFKRg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RijsfvpAeTB13sIXYSKYrb2RX7J2hcurjlnTwONy+ajw6gNdZhVK51UYepnmh+kkFnBy/0TrRB8FTgCW35nXUTwCFsc7F55JP/Wfkb5AHEwLBP39USn5SPaNK41Q1k0HLjW3vg+Eicdi7h7ZZg7L/hkMeCfnzX1sPvCVK+T0CsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=nUcTFP2P; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47C5gQkI008718
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2024 02:20:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=s2048-2021-q4; bh=SJz5uoJSrMppySD8fuLovWkBUn8ep2waRDw81fhFKRg
	=; b=nUcTFP2PRl8DtoqTV81myBQ3TnikRyyUjxBr0aXz73lP4BsJBTwyJocvdLB
	Ig8dyr9ozqQSA3UZyeh3DWZz7QTyr9OeXwJQNCXAm8bz86Vs716m3lkuqeSrRI0m
	+dj2y6avEa2rN3nh3jTCJLShvLRkfRSHrPV6JtX0DBAIhXZ3SUNMSVrGptPe0n54
	yXyGQBSTf/QU/lFeT6FQaPACL6IAVfMVMZ8OJufDI1pQBIXx5WoIZzzokBaztdyD
	VdB9IKtxJfU4jFx8NHEZMTTnoNXA9Fe9Y3l9Qj7lJCSLpEU8HiqpTPLEOEf1Lczc
	ktB/sJJ+Ka1x7J7jdC6zUmyDHEg==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 40ycfrh1h4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2024 02:20:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZScfpR9WF/MNv8aNq5O0OqOSD5KrHh6GLT7eYjci0PDQ766UbyUk5teomd/vMjdVdfqdqKTadnJRoSE1umoC6utG9E+fJsNjUyQ6cDLVJA9VaVLM0Zk2JXf+1sVReGxMwxepTYftcKrer4tomdUTMtLus+tV1QTL3xdd4FxtflI+Vj6fbIjhHTWR1l3swJIfdkCA01nr4eO3JMiB10kwBrEuujz2nclbjtthPKK2QR/t+bA3o/SZw67taTIIpeWh8oSzxz63UvsZQS0OTYTv87yjnLlUszp/sK/ojlWC4zb43SO4MaxynT/Q4i2l/4n67R6tSSNTycZ8xaPOA7XMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJz5uoJSrMppySD8fuLovWkBUn8ep2waRDw81fhFKRg=;
 b=tOQCtfPtmT9iK5Gi1wn72G1T42On1Zjfy1bJlNHYFFHmtpsqcafXbzRbU1ihHwWJY4h9Etr54OA+wxe4wdqt6d14mYjPApa5sP8S0jkpnhMQxhQTcKC/sbyIP0RxKdhTFMVa76wS/UERx7qNB4VReS+Ad9OP1ZU3YzZ2w+fUpI6WYDTMNZdCMvGSXhx077r/kuz71JD/cgKKCY7CwhKZTjtkrnMSAAt0sAmTBeDIqmtxaMNL1QAs+6h6wD2hmf9iJFfBIaKTiokkNTTxHiGM0SNAUSxXrLvp1yG6g5RVysX8spPicIPNeAi0tPgfWSYJSghi5O0uCsUmitnsEnSp9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by BY3PR15MB4995.namprd15.prod.outlook.com (2603:10b6:a03:3ca::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 09:20:19 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%2]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 09:20:19 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: add io_uring interface for encoded reads
Thread-Topic: [PATCH] btrfs: add io_uring interface for encoded reads
Thread-Index: AQHa6oKXcffdr/iQJkqMwwpZ694dJLIfQHcAgAQcNQA=
Date: Mon, 12 Aug 2024 09:20:19 +0000
Message-ID: <879d0861-9a67-4e02-b6ec-60f2c6c6cb40@meta.com>
References: <20240809173552.929988-1-maharmstone@fb.com>
 <20240809183418.GC25962@twin.jikos.cz>
In-Reply-To: <20240809183418.GC25962@twin.jikos.cz>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|BY3PR15MB4995:EE_
x-ms-office365-filtering-correlation-id: 3c5982fb-86e1-43c7-10e9-08dcbaaffc1c
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RjAyRXJrVi9jS3BmRS9yR3Y3K0NjSzIxVEhWcFFlWmlBTks4OG9EWVNPSzBI?=
 =?utf-8?B?cHdlQ0EvdWozWjdvK3dPV1JLVW56UWJ4WFFBOG9Ga2lhc2dpQXBIcVdWRTZD?=
 =?utf-8?B?YVRGRU44ZmFsNk9xQ0VqTVdmY01iamZaaHllVk0veWlGYWt3ZDdhM3V5TGlv?=
 =?utf-8?B?QjluVTJLWldPNjBnQlVHc213aGhuWFBiT3V2eDN4SGN2UWtWbTZYeEhRaWh3?=
 =?utf-8?B?endxSDE4NExSZ2VWVHZMZC84M21lSkVxTkZLL1RRcFlWNWJ1RWtRTXBVZEZr?=
 =?utf-8?B?OVFVWUtnUWM0WWFuRGYyNjVhWkNNUG94aHBWWk95Q0UwYW03aEpNcFRYWC9j?=
 =?utf-8?B?VmxzbVZGcTV4Y1JnWDZLaWt3M3A2U3owMC9hOEdwOVMzOFJjMThmK3NER0JK?=
 =?utf-8?B?Y3AxbkxaRy84SVNjbWdVSjNtT2pzQ0ZOUkdia01EbVlnb1dTR0tacG1sOEha?=
 =?utf-8?B?bUZJaVlETEpoV0djbDZycXBaenM2cWRPNHN2QklreHNaak1ZZTIwZmFtVjhF?=
 =?utf-8?B?TElmVjd1eUhPTzhOQnMvaVIxQitqMXZuaHVCLy9hZDJYcVI3dElCMTFMZTE3?=
 =?utf-8?B?MEw0cmh5YmNlNjBXYkh3Z2Ywc3NsaHQxMEsxWFlhcmpNRXRpWDd4UTNBaTJM?=
 =?utf-8?B?STBaR2VDQkxNeXBIRVA1bHg2ZTRpK2NDV09BWWhMSGI1REZhcVpsTER5cFMr?=
 =?utf-8?B?M0NyK0podWZBUE1CUFRUcmRBNzZwWkQvSzFtNHl5V1RqN1g4MXdxWDlXejRN?=
 =?utf-8?B?U2NUSVFncStDN25mTXJqOVdOR3VvS2lYMkl1djJKUFFWVm1WSzFpeFpZOXE5?=
 =?utf-8?B?ellPY1Ryem95WmlYMmwxRkY1QVU0S2hnOXY1NTBJdU5jU3dLQ3pWOE14OFIw?=
 =?utf-8?B?blhaaVpDTU5TdE81NUhGWkNYc0hObGY1K1BJTkxtd0NWUkxveEhNL3AwU1dG?=
 =?utf-8?B?b1A5aThBSTFYakh1c21EYjFRc1Y5eEIyVzlQSTdjOGw3bUlUMjhTeFp4MFNk?=
 =?utf-8?B?cFQwdldwZExqajRLVXBUL0QzRWk3QWd1MmdWRHJpSyt6dUIyL3hxU1JSbjQ4?=
 =?utf-8?B?NXFWYWNSTjVpemJmUzRTYVFLYjBmUFF1MUFWWHVpdkt3L2lyRk1QcElnM1lL?=
 =?utf-8?B?aVBvZzFuOXh4bm9RMXJMWm9iK1FRVzNFc1gvVktIN1lXUXFEbGk2ZVgybDVF?=
 =?utf-8?B?dVpac3YvdERuTXJIN0ZHbzlXWDlwTjduOWV5NWdob01saUh6amEzME42TlR0?=
 =?utf-8?B?T0hiOUI3elE1ck4yNFJLQzVIUHlIU2NMYjVNaFM2NFgxMzRPakY4TEhTQW94?=
 =?utf-8?B?T05ySkdpd1JMbnRmUHY5S2ZQMERscEdwTzBmWXFETTJEZXhGY29WeThxVHRa?=
 =?utf-8?B?SENPSW5sR2hXZ0RIT1AzWmFxb1MyS09CNDZ6RHMvV1diVEdaUWkvRXFCbFds?=
 =?utf-8?B?cHhNVkhoUExFY0s1RTZ0dzh6NUFuLzBScGVsY09pYzV2THh5dFdqYmp4UXRD?=
 =?utf-8?B?QnpLb1BWTXJQcU1jWi9Pa2JpZjVEV0l0OXJMWVA4UmN0aFJta3A1V0VrRitH?=
 =?utf-8?B?TmgwdzBxRlVhOUF4TnFwdXZaNVA1MEQyN0x0RlBlYkJ6azNCemRTQ2Uxakhp?=
 =?utf-8?B?YTFzTE1maXJLa3dDaGxXaXBBOHJRMUJzL3dZbmhQMXZjYnBuNUd6enFvdjJt?=
 =?utf-8?B?T3R5QVFmejB3bVlVbWNXM3Y0MjJORFNhQWcyNTUzbklPQktYMkMvNmUrZVk0?=
 =?utf-8?B?RFd2K1FYMFlpQmF4M05hUXI2UWwwZ21ydFJ1MjVrSGtVQlkvVlM0NmpQWVl0?=
 =?utf-8?B?T2RaSjZDYTVCM1R4cFk1Sit6YW5uWE5HRkVQNkN1RTNWVU9UUmFuYlhXMEJK?=
 =?utf-8?B?UFQrOFZPZ3ZpUEFEQ0RXOUxIS1dSRTRmbVc4Ky9lY2F3WXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UGdnUmxnMUtMcnIxUE5lc20vQm4xU0RubVBQcEFhMFhlemdnN3BWTENUWWJ1?=
 =?utf-8?B?d0QwalpmejNxVElyM3BKcldyTSs4YXU0Y2dDS3RYN0xrZzlqTkNVckdwdmZ1?=
 =?utf-8?B?aVhiWmdFc1Y1QzJLZnlFcXViV0djM25tSXBxdCt3dDEvYjhhc2JnSStLUXRO?=
 =?utf-8?B?d0JHa3l0MWFieXQvRE5mOC9qSi9QME1iUDd6Ykp4ZUpka1k5NG9DbVF5eHY0?=
 =?utf-8?B?eHhPTnVvZ1hyUnU2am53WVdmYVdSV1BkbnNuNHJWZnJ0MXNFWDVlOVVNeDNK?=
 =?utf-8?B?V3docyt2NlAzdEhnQk1KRlo0M3lNRlIrWThJei9WN1NMOTFUZm1jc3pORkZs?=
 =?utf-8?B?NEZuMUVXMUw5ajR0OUpodGU3TkFIOFExQlMrNUVjbUNlMCtQbnZPYlY4Ylcv?=
 =?utf-8?B?Slo0ZWlxa1F0LzU5U2REY3Q4UHFzY1NlcHpYQThXV1pnWXhMQTl6Q0NqSXlU?=
 =?utf-8?B?YUM2TW1ockYrQWdMZUdPNVhFazF0TnV6czhyYjlleU5KT1Fsa2tkTDhTMHdJ?=
 =?utf-8?B?NU9BTGFwaUhsS2FXSDUvbWcxd05pVW9EYlFUZzJCcWdvT3VWVkxIdEprWE4z?=
 =?utf-8?B?VnNKSzR2d0kwZXJCbnllRDQrVDBCMWNiRDErUHBoa1BIMmphZDVabGV2aGpl?=
 =?utf-8?B?NS9nZE51UE5vRVQxVUJyOWhNZGVzek9OZUdjRmJnN0djaVhubysySWo1SStS?=
 =?utf-8?B?N1BvQmFlSEFTaGpxRjZ0eHc1ZHBJZ2VHSCtjczdUVWtVOHFRSzlJTlVBdnhC?=
 =?utf-8?B?djRDZlltTzZTT3RQVnh0cm92eWhYQlB6NUN0YXI1RHFLU3VpanpIYTRRaXpI?=
 =?utf-8?B?Y21MZ1Y3T1BhaERnYkVZRldVazgwUzYzeC9LcXVObnUxTCtvT0NnZ0RuTXE4?=
 =?utf-8?B?bG1LajhQTE5FTzVrQlpCcVA2U3lhdFVHbWFnTURoS1BEeDBWSmIzazZ2YmRu?=
 =?utf-8?B?QUNObThuZndVKzVrVU52QUdSckFnUkluLzV5NjRTL2JIVXNQZ21HWklGdkNm?=
 =?utf-8?B?U0RpWEZUTWttb1FETCtEWkppbnBIbUthYmsyUmZNdzFKV0RLRjllWEVIQWVZ?=
 =?utf-8?B?SXN5OURzL2ZpdmlDWm1wU2ZKby92aHY2bFRyVFgycTJmR3BBNUkvV0p5QVBP?=
 =?utf-8?B?SmwvV0xObEhmZHFVM2J3dDhyWVVKR0duM1d2L2c0WElwQmFGUWIreURxL3NK?=
 =?utf-8?B?OHF4OEVCcEdDK2c0SWZxa0VZMjhoRU9rdU5BZHprYXd2ZEdCdWx0TzFJMXZJ?=
 =?utf-8?B?ang2VlN2WmlpS3pqQk42a0hmMzZ3SVlHWklvTE9Dc080UkpDMG1zUmJEYTFm?=
 =?utf-8?B?THBRZWxkdjhmT0p1NjRlRGx3aHBuL1pUMVA2THdoV3QyUnI2Y1VpVHVLUnly?=
 =?utf-8?B?UjZ0VGJNQUpEZWFmSk9UVE5rdTh4b0VGb0RMNnFHYUdOTGk2RmdyV01OL2JM?=
 =?utf-8?B?NDZDMDZmZytjWGs1SnFvOC9KVG5Od1UyTWlqT0JXZlhLTW5VQVM3ZDRQN1Yy?=
 =?utf-8?B?cXYvdTV5WUZEaWNsTXlUb1pickNtMzM4VWRxekgvMXNWVkloM1U2RklWeUQ4?=
 =?utf-8?B?bmVOU2U0bXd6RmQ3Qko0Tlo0NFdhdUFOM3BBK3RoNkhtQjhscGxtRTZaMmFw?=
 =?utf-8?B?bUJUWUt1VnhjbXNYbzV4U0tDY201NXV3VkVTR3JyQkFOZXFpUlZrZVRsSHh4?=
 =?utf-8?B?ZFVBd1dQTkZxWUN1bVdhdUNzWGpocFVQTlRQc1RraitrOUlmd3JGc3pSbVVO?=
 =?utf-8?B?ak5aWjQ4MXo3TUZncmF6ZlhzdTRPYmhhOGVicHo2WkNwWmN2OFlhb09CU2tk?=
 =?utf-8?B?WUpEcHprazl3MjZZd3ZTemt6QWhOeG1ZR1puQmd3ZWdOa3ZMaEkrT3EvSTBR?=
 =?utf-8?B?Y1R1L0FFbGFlM2pLSTQvQU9ONW5ITnhQQlkwcHM3d21McmZOYVdBcEpSdnp4?=
 =?utf-8?B?dG5yZ3BRa0QyR1JFRVhCR2RhbExEQVZTYU55Sm1tOFRVU3czL0lLZExVZlBo?=
 =?utf-8?B?clR0OFI4OXVBTzN4NEMrZzR1cDhYaER2Sk15QkF6Ung5WTF2RFlXdVlHKzhH?=
 =?utf-8?B?QmtmbHpWMHJrY3BFMnNtN29Mdm83Smk4Tmd1dzA0LzZzWVo0d0c5UlFlWitj?=
 =?utf-8?Q?Dsk0sWo5arN2YOOWHL5D30FVg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0BF6B092516F0489160795231D065C1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5982fb-86e1-43c7-10e9-08dcbaaffc1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 09:20:19.0910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ZOIqtmZVPhT4B35sMIT6A+YYmgDrwSZE9nMOA+Edn15zz6NqGJ/TM6V7GzE2Q7PYzoNbqlvREVXijk3OQC/JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4995
X-Proofpoint-GUID: 8d8QUGZbC_Rbws_qLZSq75mdQYbw69JW
X-Proofpoint-ORIG-GUID: 8d8QUGZbC_Rbws_qLZSq75mdQYbw69JW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_25,2024-08-07_01,2024-05-17_01

T24gOS84LzI0IDE5OjM0LCBEYXZpZCBTdGVyYmEgd3JvdGU6DQo+IFdoZXJlIGlzIHRoZSBDQVBf
U1lTX0FETUlOIGNoZWNrIGRvbmU/IEl0J3Mgbm90IGluIHRoaXMgcGF0Y2ggc28gSQ0KPiBhc3N1
bWUgaXQncyBzb21ld2hlcmUgaW4gaW9fdXJpbmcgYnV0IEkgZG9uJ3Qgc2VlIGl0LiBUaGFua3Mu
DQoNCkl0IHN0aWxsIGdldHMgZG9uZSBpbiBidHJmc19pb2N0bF9lbmNvZGVkX3JlYWQsIHdoaWNo
IGdldHMgY2FsbGVkIGJ5IA0KaW9fdXJpbmcgaW4gYSB0YXNrIHdpdGggdGhlIHByb2Nlc3MgY29u
dGV4dC4NCg0KTWFyaw0K

