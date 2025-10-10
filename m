Return-Path: <linux-btrfs+bounces-17613-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5839BCBEB7
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Oct 2025 09:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2BD3B9ADF
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Oct 2025 07:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A22A273D6F;
	Fri, 10 Oct 2025 07:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XNgEB8ur";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Bl1lFa+C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1131F5435
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Oct 2025 07:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760081386; cv=fail; b=b/EIG7eXPaM+okbutaXIZnCI/jULc6GjcE9jHB8qNwBzoxrX3XZVtSyznRAV8aXmCYRexRHZC21F83YSfGUP8HN/Tcv0SZxFxRmhyVAM3wFjQ4GpVFCeo5Vi4qoLbEO3YJPrT76mIie+hXMrcFzEta+VgkzaOG3mEyAFJ+Yw/c4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760081386; c=relaxed/simple;
	bh=YlrGomrNZe+S1oDcJqt2yeGTy1wuAw1/Mfluc9bwUWo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WOr5p7H+9MfhgkB7z2Khs0zaxxKq1KvQYFYEPWTWA201LGSvt4iWeGH/NEwFtnUMzi4osHBmu619a4rL/bCs0fgfvU0Az3u8vMYN3IoeWuUu3hStZfiI4nO04KDAu+4jnYyjSXmoVGWxYL5VbrAV0gE253caGOfv6d61u9OisJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XNgEB8ur; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Bl1lFa+C; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760081385; x=1791617385;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=YlrGomrNZe+S1oDcJqt2yeGTy1wuAw1/Mfluc9bwUWo=;
  b=XNgEB8urKcupZa0aK4gIjhtJzKXHm9F24psScSTuN4mp8nMr+VKq4cIE
   b0aDcCaNHmSPVn+XDJMFoL0t3sYAshIy42gr70dQIlcKpFodvo8gC8yvv
   F6bLhmbcAJ9cWKT9MdDTA6sV9M9Izh5QO99S1Il866qkaBDTp2Wam/nk1
   u0jlwo3lWJr5WYWITUKgmUyApDLofnsk8LUryp5PJijnrQw2Eb+GNdZW3
   Ytf1KZkbBCseeKDSqmN3pvfdijv8+gU89xSozlQhCSJTF6AX26oFSb67g
   TPDNscAopQ0Ar+SIrTlzLn2kr8b807ijs8eBe6vNZaybuPPog8NT6Hcbs
   g==;
X-CSE-ConnectionGUID: RSFynhBLTbyEjWx5jHfxcA==
X-CSE-MsgGUID: 3YsthaP/TgKvoDFa78sZ2A==
X-IronPort-AV: E=Sophos;i="6.19,218,1754928000"; 
   d="scan'208";a="133908244"
Received: from mail-westusazon11010028.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.28])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2025 15:29:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7jVzEpdDii7vKL22h/jJwnNtcR00+oOKAzenjdrFe1OC31tmEx0mNfo3vvzdPtgVrJlDlqT1Nfu+kF5KDcEXXYkYF9xxCCoqufcN42dVtCA4JlrmCs3TOQCjybW6v7uPIiooJd/u0cOxi7nq+meTHV2vnqdUw3qF7hZmZxEWz5mTU6sXmYovGUPdyL0SG/YD9XsFImVXw4hWIdrrHE9IfOSouzVwluRHMh/8IY2p8PtMR+oid7qgThoNzzR5oe6L7NVhULaDZpXGV3MZyUHYRdRX0D0tH5F2wJFQrzSk3GXLSKYWXMVxM0XyDE77mc+OvUH31rtptooWlVz7iqZGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlrGomrNZe+S1oDcJqt2yeGTy1wuAw1/Mfluc9bwUWo=;
 b=SJGS8pAoEvgOpzVWcLP0/pQAEH9Zzg6HxjF0EJ4smhap+WtjAFulI64DafSXDDTAdSQS6MRpEEh9J8e7VxNug8/ovfIEfwNqk7/lfIuZw5hZjp5veJE6JQe+MamvUlL0vVH8kREg7jb4O1UZjcV3z6gpgIur6eZJ/NF+Xa3mHAsT+QNN18ukpf+c5R4z8ZNLSMjH5sFQeooV0grEQ52UGKupGfCulbUAbgEcSBg6r9rHcJVuRTxG9Gp0OZK9KsDDuBOFx10GaQFqsXftOHsVTCN0KL4PeVbJpMrWV/2Bmkm7MaPFIwiMxSBe0XZZAiqVzAtiimz5C+Xbjeaxub4lyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlrGomrNZe+S1oDcJqt2yeGTy1wuAw1/Mfluc9bwUWo=;
 b=Bl1lFa+Cyejs3IOlVfcOiS+mmbGCkDRT2daem6VeHJgGN/MKDJPESRSlxkV6yfFxh+YEzfeTqC5G+mhr5c+4k1XDi37eIEUIkN+iweJPQ+m+4FWbX+hUTAgrPNaDKjIOcmWLHIZbR5+72ToPmtNJL/fo0ESV9rywYqNzdechx98=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6895.namprd04.prod.outlook.com (2603:10b6:208:1e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 07:29:41 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 07:29:41 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v6 3/5] btrfs: reject delalloc ranges if in shutdown state
Thread-Topic: [PATCH v6 3/5] btrfs: reject delalloc ranges if in shutdown
 state
Thread-Index: AQHcOaLmJ9bu/9pWwEey6AP9xgmet7S68hCAgAAFJoCAAATLAA==
Date: Fri, 10 Oct 2025 07:29:41 +0000
Message-ID: <4831f2ed-114d-46b8-a4b5-ffe62e1c43d1@wdc.com>
References: <cover.1760069261.git.wqu@suse.com>
 <4c244c7f13e63941f3c366867264c50d4392a8ed.1760069261.git.wqu@suse.com>
 <56575026-9cc0-4ca9-866b-06ec115197cb@wdc.com>
 <44915bc8-9ea6-4776-9b2e-037e35b79f32@suse.com>
In-Reply-To: <44915bc8-9ea6-4776-9b2e-037e35b79f32@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6895:EE_
x-ms-office365-filtering-correlation-id: e3329a4a-652a-4701-2870-08de07cec6ab
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|1800799024|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ekNnb1hoYzkrTzhWUm1PaWdiRjhuSXFLTXZoS2FkWnIwbHpoSmV2dXFLV1Rs?=
 =?utf-8?B?bklxclEwUW5HREVkc2JDQVZUcTRuT1Q1K20veGY3QUlBYWVFRkhPNnlaOFBS?=
 =?utf-8?B?VGIzcllmbHVvaXpMdTNldVVMdlFSUzhPdnFZanZzcU82VXRlTGlOeGo3MkI4?=
 =?utf-8?B?VEc4ZDFxMFZJOGdEOUNrd2hLdlBJZTRRNGl3ejVqY3htZGNpYU9rM3R6cFIy?=
 =?utf-8?B?YUdESTNXcDNoOWd5MFIrUjUvV1FmTTNxb1N1UE1JQytOWTRKN2VLZ0dGOUt1?=
 =?utf-8?B?TURiVTM0aGUyZkNoQVB0Z0NacEd4ajdhbTJXU2JGU1FvRmFUTlNzUi9lMWtJ?=
 =?utf-8?B?UkQwZXN4ejNIZGRlWmZoaEVKR2o1Q2cxTmdqQVo5ZVpPK2k3WFJySjNJWVBz?=
 =?utf-8?B?T1BPQ3A5WHkyUkpJOGlVa2RCWUVoazZBQUErRGVRTWVxS3MyZ3NVaUN1YjNl?=
 =?utf-8?B?RVRrdW4zOXpoNk5paTZWWXFNd09qU0JkVnNQckFaUlBVWTRiRGVCV0NQdStU?=
 =?utf-8?B?cnJlNHZ1WHNGRWpCbkQzMno5STJTY3ovQUhpTG5LK0NsMjlvUWF3T1NSbUhF?=
 =?utf-8?B?czdVbFUzeUxPSUdFbEZzREIvSGt5M05JT3BESlZacHpZVmFwNUtDamhHRWFv?=
 =?utf-8?B?c3V1Vm5NOW1nZU52N25YNDdqTmhueVVEeXZrZ3ZLaysyRC9iYUg2M0o5ZGtR?=
 =?utf-8?B?d0FkQ1hzTFU5MVZwODdtRWtLRHJBbDNTZ2RpeVEwZzBURXJlaERSMUQ3QnF4?=
 =?utf-8?B?ejh0d0NYU29mWUlSMk1KNEZqWXFSMlFjQkpDQXZ1VlhaWnQxY2NJRVF2aS80?=
 =?utf-8?B?Wm5sU0pneGhaMDlrWGU3T05maThBRjJwSlIyamhJNHgrN2FwUm55clk3ck1Q?=
 =?utf-8?B?bi82Z2tuM2k1eGNVdUhIbGRzTlV0NnMwZGpBSktYU0NRWlJkRFlSdjh3OGlx?=
 =?utf-8?B?SDBmU3FSWXZZY3dPU2NEZEk3UTRNU0RkU29tTU5hNGh3Z01wZ0xyTVUyS3Zu?=
 =?utf-8?B?WTJTM1dOc0N0TDMrODI1N1pWUlZGVWxwTmZpbDN3cHA3RzAvVmZyKzlaWGdP?=
 =?utf-8?B?OFJGM2F5THI2aWF0b0xYSlZMdk9kelRyN0tIZmVUME91YUtnR0xrMDJFYTZ4?=
 =?utf-8?B?WGpjMFRCZlNDR0ZuN1g4YlhUZHNhNGdaYkZNZnY4eDMrdllkR1g1RHdDdHRy?=
 =?utf-8?B?eUpjamV4NEJPK2JJRzVKb0pTeXNYK2p0RWN1VUNCRlYxWTM1eEYvNmhoeEJa?=
 =?utf-8?B?S3FCMlJMTFRCeFhRUXhKcG5Yc21DTXJjT3RZajBpem14TzljYm5yWmtadE9U?=
 =?utf-8?B?L1BXc3hWckJ6TUVyMGhERGZGYm9qTng2by83ajEvZFVmR3lBckQwMUZWbXV4?=
 =?utf-8?B?SGJNRDVsRWpLM3lnUGJydGFidGVFZnowN2JQbVVjRTdwV2J2cDU0QjMxclFE?=
 =?utf-8?B?b3lhRCtoby93dWpRckNzdEJMRzIrRHU3U3JjeDFSbjRib0VidGJzdWJSR2Iv?=
 =?utf-8?B?b09NODgydUdTd3Fyam9LZEx6M2pIcnhzMTg0RlNwTkxPUGhsQkRISXR5Q01l?=
 =?utf-8?B?T0NUVlltUVB3Yng1U3ZHTTA3WXNYZlhxMCswbEFyYnNrNVpFem12aFl0cHJI?=
 =?utf-8?B?OE1WZXoxREc1bnhqK0ZZcEp2YVpOUWw4ZysyeUowU3I2S3NtK0NPZWtFQ29N?=
 =?utf-8?B?dkdJZFltWVJxeldVVUFQeU5QZStSNHl4WjJjVkc4THdqTW83NThVdENFdy9S?=
 =?utf-8?B?YWNBUWlwN0EycyttclptZVBhVWwxblBtRFN1bDNqNjJZVVkyRDh4T1pMbnh6?=
 =?utf-8?B?bis3VEtyTG9kcHV6ZlFLNWRmWHZBVE8rR2NnRk1HakZSQXp3ZmlhdzJIL3Fs?=
 =?utf-8?B?NFA0Ym5FUW1BN1d3YlBTVGwrOUR2QzFqSTRjTjZ0bnJlQXU2MmdHeXlhYUxm?=
 =?utf-8?B?cUpHc1NpWTlmZDArNGYxeEs3S2lrNmV2QlN5VWhqVGRydXhvWmVuZzFUdkhM?=
 =?utf-8?B?Wm5WOG5CdGcyUDlRbTM5VktTcTRjbnZrVmlhMm5GU1IzVk4vakdYQ2VieXl1?=
 =?utf-8?Q?p+MUAT?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dzJ5WXBnUi9mUHI5eXZtUjdsMklsaUJkMU1EeVVueHFIVXlEWEJPOFFOd25U?=
 =?utf-8?B?c0xlNWd1ZFQxNmNKdC8xWkhrWmd6WGVCY3NNOEpLZ2pxNWdXaG1CeEhtSDR5?=
 =?utf-8?B?K0VhQmF5RjRrd1IvNHBFK3I1c3BGRUdXZHZVZVF0SlJYTkpIYU5qUkp6U05U?=
 =?utf-8?B?RndZby9NcWVqU29xV0g4RHhad0JscW01VW4zb2p5TDNHS056NWV6Q0dFeVRm?=
 =?utf-8?B?UnJjWFEvYmlnbkduWStlSmhGQUZXcTVHcGhUU2x5MyttTkkxalZFTDU2RmJl?=
 =?utf-8?B?ZEhoMVpMYWZpOTV3Mzl5QURMei81OHBicnBQVi9mbS8yR1dwbHVJc0pmNDlz?=
 =?utf-8?B?ZUZHS2hYeHpaZjdZMjJMbFRpbE1yZkgzRjFGSEpJYzRMZkRQTlFQOThJS0lj?=
 =?utf-8?B?cVY2MTBiQndMMjJRWHBxKzhtY3FDd1A5UEt4cVdNMWI5T0dOUjNVdWx2Mnlj?=
 =?utf-8?B?ZmlkeTRNdTQ1bUg0RmRiUXFNWDdMVDR4WitzL1Z3bWxhVERnVjBtZndaQkxD?=
 =?utf-8?B?cWxzbzZRTEEwZ25TZXJoRVl6bTNxN1luNGp6WTVSa0tQd2Z3T1FDNlBjd0pK?=
 =?utf-8?B?dVhta1NEWE9HTnRNbmJpbmhqbld4UFZkb09YYy84U3BNOE40aktNR1ErYlhR?=
 =?utf-8?B?UmNleFZaZ0xvcmpWWFAySnBZV2dWM0V1b1pqVUEyZ29mVDBXck1odkxpcnlH?=
 =?utf-8?B?dkxONkZ4QmR0UFByN2F2RE9naU12Qk9lUTdVdWRINENHVTJOU0MvOG5wd3k5?=
 =?utf-8?B?dkpINENJSHRFT3U5SE1LM1R6Z1B1L2JudFY1REhQckJvdUwyK0lyZ0J4Sitv?=
 =?utf-8?B?Z2NrR2dBVlAxSlZyQ3N2NU5vd01UVEJWVjBNMkxtc2k0QVVaQzhzL2xqbnBi?=
 =?utf-8?B?WVNNMDdaOFA4ckpMbi8yekxEOExRZVNCNXgyOTJGNTdxMFRQZXQ1RC9kUTR2?=
 =?utf-8?B?OUl2WjFEdjlkdG9kOUp6bjJMUGlLemxVYVNCWE56Yi9NZklJMGYvLzhJWlRK?=
 =?utf-8?B?MTBCcmswVXIvV2sxSnM0VUh6dkkxeXJTdlJ6U2V5VWc3UHQzelZrZzNSSUFq?=
 =?utf-8?B?RUU1bTBVSVUxU1dkS2ExVEdqeWxDWEpyeTJvVGw5aksrSm93T3BCLzdXVEp0?=
 =?utf-8?B?WjJKOU9nZVFiT3k5cC8yaENveEVxeElTSFBwRFhBejRSa1dMbXdpV3JMSnRI?=
 =?utf-8?B?WHZ6UkhnS2M1RlR3bm5WVW5QZjFmbU1BMGQxMS9aa0lZaFZnYTVrYTRPN1V1?=
 =?utf-8?B?M2tienlJK2VkckY4SUI4cm9EakY1c0hKeHNrK1NqbjU3eUVVaG9hRS9lVDl4?=
 =?utf-8?B?YlZjbExaRjc5MkFTMnd3NTFGT01zNkNhRk8zSlU5dXJRS0VCRVVLajJZcGI5?=
 =?utf-8?B?WXM3d1QyaUt2UnNzeFR0bExSSDVpclgwL29QZzdnb2lkMXovNWp4Ulh0ZDZB?=
 =?utf-8?B?V3VCUmE2MmJVTDljNlNtdmxTU0dXbmV5WDJNa2oxdTJNZ25CaUppMDIwbTVJ?=
 =?utf-8?B?am96RXQrK1JDcURQTjV6Y2ZBeVZaZzZ4T1RjWUN1RS8zZXNUcjZaeC91aHAy?=
 =?utf-8?B?T2R0VmVPMDREWXBtUDVUYU0yNHZiY2R5anVpRHVBWExsMzJ1QklDZGdBbXlW?=
 =?utf-8?B?eEo4QXhRZmdUaytmdm82Rm9JTGhYTHZuM0FTN3FQKzh4OU9qUDJWZ2liRzE3?=
 =?utf-8?B?TDRGdFdlYWpCL1pTUjczdllKaE9Oc2dMaW96eXZTYk5nMCtKTlM3MXBrY29z?=
 =?utf-8?B?cUhuVk41YjNZNTF4S2hpMGVPVGx5S09oNkRQR2g4OU1IMnBHaERZTm5Qd3dZ?=
 =?utf-8?B?Y0RNdVZxQ2ExU1pTRDRWTG56Tk5zV1poQ05VQW5xTmEyMG1Odm1XaWhkOXlm?=
 =?utf-8?B?SXd6U0thNkVVclZQNHpLSXRJbnh2MUJQMWYxV0RES0NVWUNnTDBEVlF1QkJm?=
 =?utf-8?B?U3orWldXK3U3cm5vL0NzTE1lNUp5cGc3Zmd2SnI3OGE4QTl4MjAvcU95QzNB?=
 =?utf-8?B?by9oYStvVjR2dXprV3FGcnVKMkg2Q3ltWnZGWDNSazROMnRrTDRydVIzdkd4?=
 =?utf-8?B?MkNyYlVXd3hQdVRpbGpGeHF1YWpKMTZicFdxeTcyU3hLR0ZvSEoySzR6dytR?=
 =?utf-8?B?NWFJS28xOTFsTjBXRGtlY2JVRDY3OWQvTzdmUVcvVFJkM3kzVjJxQ2NLRkxL?=
 =?utf-8?B?ekVDZzRLYlpJT3BVQ0dYSlk2bklKdFVxNkNLMnRuTHROdzQxRnZwRURZM3Zu?=
 =?utf-8?B?NWc0VHVwbEppY0F2QS9rbTR5M2xnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <478FED72395DFA4E9BD9ABDF1AE08E9A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+mSh9QNGnnCJx0Ti20EH5TW9WOxQW5TcxbOxqPhBbmkwD/bDtPQxW3IYxaMtC3Fpy2kCRbr6grd7/FtQ1D/FnQwoiXhSdFE0IBdExzUT26ufoQ5dCy/UNzF68ei2IYKONa3TXAmuG1tAa0JackBRAERaeXTWOxGIKayn3uMedWA4MOI8+VYs0JLakp7DYQ2K7LN8Z9uva0HD3UjD+jhvji0uQhhxrD0FRVrWtkTP/4omlFc6ArzceZ4RMzc1492J9Cng/dc73dRthBVZJMpVKPtJdltG4q1BeJAJ463hzWtCqFtS5eU8qeVDYkpGrSmOJc+IISc4aWdepPA6HySAk0K+apv3cYvbfWWiqguvRdWcmN+k7mWviFQNu5fqvCyqgOgbKPCxyDrc7C3k71w4d0h3wKJgEpXZJeNUkVKt7uC9VT77zGjK4ml624oEi1jEoQ4hORwqw3hrIdUVqLdy6nM4uvef4y246ln9eHFRwU7WMC76n7qgyvimAwgIrERt76GM6/fRbtdvMpEq7mWilOHJRtHH4cusmIVCszh0sBZCZmbV/9KuuKQdBfKKlY0RrIKbNppDBHehNfgspPKTJ+NIBmH7KFzlqQ+mV+O+TwvDgLB8WHeSEPv+jaENAOyO
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3329a4a-652a-4701-2870-08de07cec6ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2025 07:29:41.0833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5lhp1gLi0UcoT+HJG8oYrbw/JnpkcSZ+1VWmij7RNQdQf39tSZEeLaoGNewlJDXZgiAq8HjuD4hKQmWwN7YkO1u8jNdhBwc77E3+Bp4TZ3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6895

T24gMTAvMTAvMjUgOToxMiBBTSwgUXUgV2VucnVvIHdyb3RlOg0KPg0KPiDlnKggMjAyNS8xMC8x
MCAxNzoyNCwgSm9oYW5uZXMgVGh1bXNoaXJuIOWGmemBkzoNCj4NCj4+IFN0dXBpZCBxdWVzdGlv
biwgZ29pbmcgdG8gZXJyb3IgaGVyZSB3aWxsIGdpdmUgdXMgYSBlcnJvciBwcmludA0KPj4gKHJ1
bl9kZWxhbGxvY19ub3djb3cgZmFpbGVkLCByb290PSAuLi4gKS4gSXMgdGhpcyBpbnRlbnRpb25h
bCBvciB3b3VsZA0KPj4gYmFpbGluZyBvdXQgYmVmb3JlIGFsbG9jYXRpbmcgYSBwYXRoIGFuZCBl
cnJvcmluZyBtYWtlIG1vcmUgc2Vuc2U/DQo+IFRoYXQgZXJyb3IgbWVzc2FnZSBpcyBtb3N0bHkg
dG8gaGVscCBkZWJ1Z2dpbmcgdmFyaW91cyBsZWFrYWdlIHJlbGF0ZWQNCj4gdG8gb3JkZXJlZCBl
eHRlbnRzLg0KPg0KPiBJbiB0aGlzIHNodXRkb3duIGNhc2UsIHN1Y2ggZXJyb3IgbWVzc2FnZSB3
aWxsIHN0aWxsIGhlbHAsIGJlY2F1c2UgaXQncw0KPiBubyBkaWZmZXJlbnQgdGhhbiBhbiBpbmpl
Y3RlZCBlcnJvci4NCj4gSWYgbGF0ZXIgd2UgaGl0IHNvbWUgb3JkZXJlZCBleHRlbnQgcmVsYXRl
ZCBidWdzIChpbmNsdWRpbmcgdGhlIGZvbGlvJ3MNCj4gb3JkZXJlZCBmbGFnKSwgc3VjaCBlcnJv
ciBtZXNzYWdlIHdpbGwgc2hvdyB0aGUgcG9zc2libGUgaW52b2x2ZWQgcGF0aHMuDQo+DQpNeSBj
b25jZXJuIGhlcmUgaXMsIHRoYXQgd2Ugd2lsbCBnZXQgdXNlciByZXBvcnRzIGJlY2F1c2Ugb2Yg
dGhlIGVycm9yIA0KbWVzc2FnZXMuIElmIGl0IGlzIGEgZGVidWcgb25seSBtZXNzYWdlLCBpdCBz
aG91bGQgYmUgYnRyZnNfZGVidWcoKS4NCg==

