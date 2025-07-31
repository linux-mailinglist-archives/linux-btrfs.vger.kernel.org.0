Return-Path: <linux-btrfs+bounces-15776-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14714B16A1C
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Jul 2025 03:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B3AB56311C
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Jul 2025 01:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CC686353;
	Thu, 31 Jul 2025 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="D219AR4A";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="h0U6oTzL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5AA339A1
	for <linux-btrfs@vger.kernel.org>; Thu, 31 Jul 2025 01:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753924830; cv=fail; b=COD+7uDgHWI6qe8eN3Pp1GnEZSNcYXTjsrKce5IhwP96vdtOTWGSpJtDfCKSVYDrx3CHc103QzPoCzOOMiy+ER8vsFGKwstvmgu4wn95rMSC8SQbpbo3UH7PNJqHAhvWYKksX4paH/0U4gSh8dG7CTm7zCx1/YKXbHCgRystqxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753924830; c=relaxed/simple;
	bh=/7QX7dM26r4N3WhGih9fE6PZPHHbOMl7+bzme5bTFj8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gxSwG24Q3xplten1L8gHk5MciS6ePvw1KkqtPBorHCQvMjAzN35N64CKx41yan/4gogbfaW9wSrOGpsoyUnpsczFFCXjOZJuHGPYkQhhq+qDFQkYEoie4YOoJzdjRGE5yhLKXY1MYEiFhWCL/gWeaWYbRfdNQYrGEUve3KWs3u0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=D219AR4A; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=h0U6oTzL; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1753924829; x=1785460829;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=/7QX7dM26r4N3WhGih9fE6PZPHHbOMl7+bzme5bTFj8=;
  b=D219AR4Aibpdys3TGmPs8XP2Z4IJmTaTN0386nATanpFVpkXH5DNIyl9
   CJnydsgwLKYqRUQ9X7e4pc8wd88jy3ZG75B4WEZBsWEWf0mCVj+W6z/rU
   XSmWkd1GBoI02+oEyXnfmiNtIloCvrZ7//lVgKyyN1am0r1ZKWD716TLT
   5OMbglMTPP+Q9x+JmH8JCl4zzeNZ3F32E/Nme6IbH21rJh8Inh1jqHTxs
   tU2vUx4a8UAoX9oWszkvJFumL44H9WojSCyWVHyQBXaRHpmbu9mURHXZv
   1LDp322v93hoIcXeILI+vpgqpgy6YqnQ6NYhmViFKnB8ZdMwz8VOxNTOS
   Q==;
X-CSE-ConnectionGUID: yuGHaRdIQ7Gwa5kAwqmdUQ==
X-CSE-MsgGUID: VrzQZfHbRUSQ6voKyoCnEg==
X-IronPort-AV: E=Sophos;i="6.16,353,1744041600"; 
   d="scan'208";a="103476555"
Received: from mail-dm3nam02on2071.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([40.107.95.71])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jul 2025 09:20:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FjHHF750acQuQcLdaLoSNd5D0IMJ+9e0b0JiEELJhrfKKvDT58Av1IBAfwPsHdhEp7ndLvyDKMhCf7DR1bGKl4oY+1yDJmL3JSLK0ogqj8Nc0TXUtuUSbVdVAHMMrMPZOlCLqfviZcwjM6TGSK4H4BvZRs24LwFFs1hRqXrJzTVF0/ltn/9wafgg19O8sYi7bm3okKOP/dWu9PpY9HMyc8ljS79Vt3mZQCjwgzIo0oDpo4iWFA7NO7SGZOv6cvJbx6MouE+j3qyvaNlvfBQO5rkTbsZMO4cHzRlGxXhOS8hTIOCJy7lJhDazjYG6ftFcyKJG+RUZGYXgcN+aF8da7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7QX7dM26r4N3WhGih9fE6PZPHHbOMl7+bzme5bTFj8=;
 b=G82feEyl9lIM/ntivBJ2oVDN+8IrmBF+Hgb2M+h3+paCpMUhAaVnnTT00xpVU5xej0psE3ebvcLtemL1+xHTfeKdyTn4hQTh1c6FpRbt28OKSefS/d8CZfcJ985pX2XwumnbU2Wmk7Ib2EAdbx7lsWbORdwx+Gk9TVNDJPa80i8rnHGll3wJCDBXErZ5fwYDnfAcU8AIe7E5dfYvPtXp1me5CcnJyMyLqyzcKuL7niV/WuQG/x1GuDoDI9KqazxoPRNXMaQUBpwpUR18KCDoCTFnNsYPBXaT2eqK4bYdlGizNI2OhAaWrY1fCGKYm6ZRIpudTcTlVzGTTh7graYjHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7QX7dM26r4N3WhGih9fE6PZPHHbOMl7+bzme5bTFj8=;
 b=h0U6oTzLmtcnkPM1uq6TBrBNBRh9UL9co8yDJJNNP8H8ooqTNVfSFciOKXJwj/kw9HnlFLPns0rqXHT7JVjTdpAODpqiEjpa0P5Ik1iMmmAZWZ3iz1doweEUV+IZTQWcSKVRPUG3oiKUhjLYXqmH7GijY3rWOWO3xeUK0ZieEaA=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SA3PR04MB8747.namprd04.prod.outlook.com (2603:10b6:806:2f3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 31 Jul
 2025 01:20:26 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%4]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 01:20:26 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: clear TAG_TOWRITE from buffer tree when submitting
 a tree block
Thread-Topic: [PATCH] btrfs: clear TAG_TOWRITE from buffer tree when
 submitting a tree block
Thread-Index: AQHcAaRbTgE8/NeTOEqkUgzh+wYavbRLbsmA
Date: Thu, 31 Jul 2025 01:20:25 +0000
Message-ID: <DBPUF6RJJPEO.1E1Y41X6XHDCU@wdc.com>
References:
 <4390972b1e06fa09068ed6f1d60dd60c46e69b87.1753915741.git.wqu@suse.com>
In-Reply-To:
 <4390972b1e06fa09068ed6f1d60dd60c46e69b87.1753915741.git.wqu@suse.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SA3PR04MB8747:EE_
x-ms-office365-filtering-correlation-id: 82492bc8-3637-4440-d17e-08ddcfd06ddd
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UkZCY2ptazY0c0dyOFdKc0RaMEw3aXhOTTFqcHNhOC9pc1Qwb3BrZjc3akly?=
 =?utf-8?B?TmhxS0g1RWVQbVZHSVN5M05kRFA0SVZlbnlOR2F6TWdWN1ZNYWNOWWlXR01T?=
 =?utf-8?B?ZmtJVS9sY2ZGTSttZmJyNEoxMGxZdU9iVXRraWRzTGtwTXBBZGdwV2dRWHVF?=
 =?utf-8?B?YjR5Q0w0Y3JoY0ZRTmU1Q2wxM3hra0pOR0M2bnEyeGJZT1lTY1NmeXF2RGUw?=
 =?utf-8?B?STRTRm9pQU10T0R5Q25wL25jNlhtT0kwTWZxMG5hbzBIZE1VeFBibFFlMWsw?=
 =?utf-8?B?M1puNmkxdnN4bHBmTENwYUt6R1RxWTNyZXhveEk3ZTVGVnQ3a2VURUhDbFh4?=
 =?utf-8?B?QmFEcDFWN2xaM0ZGVEtENmRtWGErVDVySUlqamFNZ1k4aW03QWZSd1VWQkcv?=
 =?utf-8?B?Q21BcXI4WjdYbW95NUIrNU9XTGduL3NPcW1NQVFwZUQ1UmhWc1RpL2RKc2Qx?=
 =?utf-8?B?dzhHaEJRUlFlckhNQk40TkNQVGdBejh6TlFUb0JMNkdEVlltZmo5emtuQ3c3?=
 =?utf-8?B?QkRJbVBjaU15eHI0NUZ2eWxHS0U4MGxxaHB5MzJIMUJNZWtSSytRZGlGNU9V?=
 =?utf-8?B?UWdlVktnOVk0aEtrY3RIdmxWNjZ6aVB3aFNkVGtRQVZoLys1ZlY5dDlHZGxn?=
 =?utf-8?B?cFRXRS9yMWhVYVViVDVtN0cwRWVHTGM0VTZhbk53d2Q3U3NJWDhlbStSS01Y?=
 =?utf-8?B?R3lpRFM2RE9XNEJSdTBBbHpaTkcyOGRpRTFKNnFRTk5nQlIrekpvSDZWU2Er?=
 =?utf-8?B?eDVFMG9SK3VGL2xkc01NTW1NVjQ2TGdNZE9VRVZaSUUwMVo0a2VCQ095VWFM?=
 =?utf-8?B?SGNZVHdNWVEya0JpUmtrcHZWT3kraDRPUGRueGwxMHozWEFBNndkODFHMWg3?=
 =?utf-8?B?L0VCbWQwcWdtZ1BIUUdkNnRVQVhON0EvWVAwalBEV1R2ak5nUHhwQUZMcGxY?=
 =?utf-8?B?RjNTQTk1Y1lJa3laU2NXTTBJMElReXlNSFhpUXRtMkt2TjlxOVB2MHlCenNq?=
 =?utf-8?B?RkpSQ0JrWHFBbTAzbGtnaEx6cUw5eUdYdEoySUp0S09Lbm5Ca3FLUE1jems3?=
 =?utf-8?B?U1QxRDcwdStmSTJmMkk0cGhtaTF0L25uSyttZnBxNFVkSW9qTDFOZjJtTWNu?=
 =?utf-8?B?bzNGd1FFWVNBWWxWMmF4K3h2TUhaK2YveHdsNEU0OW1SV2ovazRVZmhuTEkx?=
 =?utf-8?B?SEJsUU1hY0FpOHc5MkRha1JhekVJeFNNQVJzWi9JVU1Sem4vRU5MTEJQbGU1?=
 =?utf-8?B?QWRlckE0Sm1ZMEpIaEtBWVhnUEwyTk1jdEgrOXVpWmFSYkpKZ0xDZlZJVEFG?=
 =?utf-8?B?cFE3ckhRVVM5N3R3VVVpNllUbDRObExiMTdMUGgxMnJxQ1VFMjRPUk50UTZS?=
 =?utf-8?B?K1VISmVtODBpbStnVGNNZEhCT3FFWXgrWjB6MGNuTFk1blNONFlZaXpXd0Y0?=
 =?utf-8?B?SXB4R3RjN0U1ZVg0VFVYWjlPYXNsTEdRVGhVSXNDeUVNSzQzaEw0TyttZndm?=
 =?utf-8?B?Q1hweTdDbVZVUDBwazlhbTdCT2NrL2RNcmNoaXZIU2JWQ2psaTZBL2hWK2Ru?=
 =?utf-8?B?Y2lOcmppNkI1NjBBblhTQkNJQS9KYmtQbzhncTZsT0ZnSW9GTmV2UGtadHZs?=
 =?utf-8?B?andJamhYdEhOY1VFRDg3NTN5QnVIT0pMWUFlZWV5ZlN5SzlJRkF4ZTYzOG11?=
 =?utf-8?B?TTdUeXRWMTVyVW1SK2h5VEdrZmE5VkhiTysyK3pjMldPMTFaQjdpRjZrMGdl?=
 =?utf-8?B?T1dkL2xYckRlUE04VlVTRVNEUmVCMGpvZ1F1dnExVE1majRwWHIzbCtScnF3?=
 =?utf-8?B?aGwvcVpRVkFHMlZJUzUvQXVpclVYL2FHL29GNHU3WXl4bjFJdjJPQVNJMXFY?=
 =?utf-8?B?TFJ3NzZ4TzFpRTVYd29JS2dycjRjakQxU2FDNW96eG1jWitIaStpVVhZc1N4?=
 =?utf-8?B?NFRRN0p2RVU2UjhnR20zOUtHNFVCaUUzcW5sSC8vR2RXN0ZzMGJ2clA3bXpL?=
 =?utf-8?B?UTBKNUowSnhnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RGNkTGtpZm95ZGd0Mk5wS2VOblNJUlMwT1l2RmVGUlZFcUdRbGFOQUR0TUoz?=
 =?utf-8?B?d0Jhd2NYZ28rR3BFY2JPYWNKTlV6MWhuNTdCNFJkeklrdmh4d05ISW5WQURI?=
 =?utf-8?B?Z012emVBeXpzQ2dwV1paZ21CWTJ5Q2JvUzIrM2dueTcxZEd6cmxIK3Z1QjJN?=
 =?utf-8?B?SnZ4YnlFcUw1NmpvYStaWVdxQ2JFb1J3K0hWQ0ptdVM2L1liZW4zSHJoVVFo?=
 =?utf-8?B?MHVuRitVYnJBODJFTVU2bFNqL1ExczVKWjFsdkNsVHNWd1VoTGVTTXpzUngy?=
 =?utf-8?B?SDVkb3RUdmVXMGQ3Zm9vcEMzN1ZCSHdHL01XT01DL0krKzBqNEtJa1ZIbmJt?=
 =?utf-8?B?QWxjSG1TSU1NRnpvVHpSL0VTdzNZOS9LUnpaTFBDT29FSzZwUUhCQzBxb2o0?=
 =?utf-8?B?MFdiVG5pQjFKQldlV2w1STY1SWMzOUcrUU45c0o3RGZnSXdBM3ZiTk0waVR5?=
 =?utf-8?B?dHBoUGtGcjc0WnNPdllyYjBNOEhvcVRyRy9ZdHZmd0VSZTJPV3dhV2NkYnRX?=
 =?utf-8?B?T3hOTWZNcHJlNzZZNXRMdERwOXpGRHA1bHd1ZUJtZWF0S0xHTTM3MWg3bTZH?=
 =?utf-8?B?Z0g4bEQ1U1drMnJhb3lpdE1sSVlFcTJCRElFUzJobnJRYW4xYXBIbm1mbXJZ?=
 =?utf-8?B?R29NTStvRkRJL3BabUd0QWc4cUpFanNlalRKcGUyR3Q1VTRtY203SjRqR1lX?=
 =?utf-8?B?bXFUWFdVSVNxVDlQUW5NMGFQQkZ6aXNrbXF4RTFkNnJGY25Bd2VxZi8wYWlr?=
 =?utf-8?B?MkxYY1JKMHlKbStINWdXSzE4bS9VVDVsdzE4S0dCMTJyQVZnNU5TNnA2eDdj?=
 =?utf-8?B?MmxuWHBkdHg3ejZweUwweFZoQ0VBQXo2NFAzRWRSWEMxTE1UbzZKa01vcXhY?=
 =?utf-8?B?UTFKTHlBYjBBYUFXVUwrdWdIbFFvWlp2YmFKOVUzbUZuakU2ZEdML01sa2VB?=
 =?utf-8?B?OVdHWlJhVFViYmNUYnFyOWl6Y0VIVGsvci9NdS9BTE04SUw5M2xwVUJFOHVl?=
 =?utf-8?B?ZGZWQXNtTDZONkYvcitlOFVETHdiOEl3elRMUDFjSmxYbmFCRi9EazlsNjd6?=
 =?utf-8?B?SkdpLzN3SWJCcldtWmJXUVRKeXlxTlRLZll5eFVzYSt5QXMwU2tkRHFZK1Vu?=
 =?utf-8?B?UmcrNGVyQTFwK0NRZjUwY2hkeGYrcE5lTG8vWlZaYzRNM2lZZ3RDcytJRi9S?=
 =?utf-8?B?OVRRVUFmZHQxWDUrQlVKNzJSanArc2tQUG9FUUlFaXZCaW5mYW5Rc0VMTjgr?=
 =?utf-8?B?MCtkNjh0bm51d0JWbTU5Qmg5R3kvbUp1UFErRTRzaUtCUmM0SEFqRE1xcnZX?=
 =?utf-8?B?dzNSaHFTeHdUZXIrWGo4YmEwMVdPSDZHcXoreHlPeU9tMkFLM2hUTW5VQmpB?=
 =?utf-8?B?QnJKbmNrbUZHbW50YVEzWkZFVUs1SmFmb1NGUkY4YmtIUDRTNXc1M1VPaTJn?=
 =?utf-8?B?WmxVaWZMMW1ZbUxjSXFBY0JWL0czVTBGK3FTZzRzOTVLaXdMRG5LRkNsRWti?=
 =?utf-8?B?WXJWWnVwK0FYMFdqVWVVdk5YRHpFa2NTeVE5U2JjSko1eElYMHlxcVEwQXIv?=
 =?utf-8?B?dlc5d21obkJWN0xTR0F2ak9tb2p2ZGNkM3ZGNys1Wk5KYVpkaUZEQWVFRmZC?=
 =?utf-8?B?eTNZSnpwUGJZMENmelMvWGhsV3pKOHpDS3NRSEptNVNocjNsK01KWDZyUmFK?=
 =?utf-8?B?QVozOGF6dlMxYjVGUHZYYlljSDN4WEJkWG9mS2RmWGNYb1Q5eVFmNXRNeWhk?=
 =?utf-8?B?THJaak9ZL3V4R3pXWnltM01CQXo5S1k3MUc3RW1JSUtvNkFHZlhnU09FTzZH?=
 =?utf-8?B?blIwU29PVUYvRzZJdDUrZklsN3dlVWdGUnlzMDhXV0VpS1I5WjY2WlQySjRP?=
 =?utf-8?B?bTArUTFhTjFaUkJoREc3UE5CcmpXTzV3elFmZ0V0UHJhOEFGODFhcnFGRDZh?=
 =?utf-8?B?bXlxc2orVm8wNkU2WmRhQUpiTGFuRGNBMndXcEFhdDZnTERqWlk4WEo4MW01?=
 =?utf-8?B?dnBiVGdFVFpuK1g0Nnl0MUthYjhybXNFSjRObVNDNmxPYnlwWHVmV2w2Y0h5?=
 =?utf-8?B?TmFFZ1dsWklod3RQLzVRQWpNb081blYrYmR1Q09nWFRPOXRSTzY2WDk4dk9X?=
 =?utf-8?B?aHI0MGVKL05sTzFLV2U4VUZVZWZKYjZuNTRBY05UMTJZM3E2VUhVTXdLRkh1?=
 =?utf-8?B?Qmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E22AEFA5BD770749B38C721FCB98B507@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yBNK7vnpMXncnOplx4+ZCmRO+6jHB0pf4DHpMCIL9k6B2LVK49letKa6qtNpTzUOYCE5emocB1qAoginEy61DzKxy1/cNAUvrIkiA+Je6VcrC8spfL7p7/ZLSuZhTYxchAyTBDlbaegPwe4z1fUB57cf6pikUAXLd39wZfyPos9cG4Tr+aSuOlLw1xj013QjRlmOGsAURnXtPVzIgUHz6Fgk1WgC1zUIxsJtavE86H+s9Ze+bm8Iaiph07xp2cOyoowdPRoUO5twpbCOD3SrcfMA0T0Waw37ddpZtKmIL9z6FJQ0CstXR73DgXqcOpfIUZvSLtE0ZJycr7TYeGfxVwviFWcuRUuYe5KTUqGnSkqy7ionHK03BUZ6dv0v7XoACRepR9G6j1LwHGYb3lS+WteoOJ1MDYQDyaJVFSHjXbQrrcDNtv+k+aElv6dmUS5vNitPT4djVxT6UPG0dCf8vyrC53X+W5ZfW9YSPCL300hWbegVwJfsPR81EjlMwSr3j7dvf2LIxNp2FeocN1wxipmYsuLiPpH0esRE9LE5OJRVvTVcc39aRDu2ZekYpq72i3+DVSkLAEkH94ZmhE1uqzfAxyPT6/azbsNW23is9GPnnV5F4kYDiZTiSibwrwRb
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82492bc8-3637-4440-d17e-08ddcfd06ddd
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2025 01:20:25.9547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kyWtmZyTC/nytLacfamik1HwCTopVk8UZWNQ19qbhJ068TFDYNWFCdM3mHarJ+XX5GdpQj8GiXj7GbCi1V/ZCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8747

T24gVGh1IEp1bCAzMSwgMjAyNSBhdCA3OjUwIEFNIEpTVCwgUXUgV2VucnVvIHdyb3RlOg0KPiBb
UE9TU0lCTEUgQlVHXQ0KPiBBZnRlciBjb21taXQgNWUxMjFhZTY4N2I4ICgiYnRyZnM6IHVzZSBi
dWZmZXIgeGFycmF5IGZvciBleHRlbnQgYnVmZmVyDQo+IHdyaXRlYmFjayBvcGVyYXRpb25zIiks
IHdlIGhhdmUgYSBkZWRpY2F0ZWQgeGFycmF5IGZvciBleHRlbnQgYnVmZmVycywNCj4gYW5kIGEg
bG90IG9mIHRhZ3MgYXJlIG1pZ3JhdGVkIHRvIHRoYXQgYnVmZmVyIHRyZWUsIGxpa2UNCj4gUEFH
RUNBQ0hFX1RBR19UT1dSSVRFL0RJUlRZL1dSSVRFQkFDSy4NCj4NCj4gVGhpcyBmcmVlcyB1cyBm
cm9tIHRoZSBsaW1pdHMgb2YgcGFnZSBmbGFncywgYnV0IHRoZXJlIGlzIGEgbmV3DQo+IGFzeW1t
ZXRyaWMgYmVoYXZpb3IsIHdlIGNhbGwgYnVmZmVyX3RyZWVfdGFnX2Zvcl93cml0ZWJhY2soKSB0
byBzZXQNCj4gUEFHRUNBQ0hFX1RBR19UT1dSSVRFIGZvciB0aGUgaW52b2x2ZWQgcmFuZ2VzLCBi
dXQgdGhlcmUgaXMgbm8gb25lIHRvDQo+IGNsZWFyIHRoYXQgdGFnLg0KPg0KPiBCZWZvcmUgdGhh
dCByZXdvcmssIHdlIHJlbHkgb24gdGhlIHBhZ2UgY2FjaGUgdGFnIHdoaWNoIGlzIGNsZWFyZWQg
d2hlbg0KPiBmb2xpb19zdGFydF93cml0ZWJhY2soKSBpcyBjYWxsZWQuDQo+IEFsdGhvdWdoIHRo
aXMgaGFzIGl0cyBvd24gcHJvYmxlbXMgKGUuZy4gdGhlIGZpcnN0IG9uZSBjYWxsaW5nDQo+IGZv
bGlvX3N0YXJ0X3dyaXRlYmFjaygpIHdpbGwgY2xlYXIgdGhlIHRhZyBmb3IgdGhlIHdob2xlIHBh
Z2UpLCBpdCBhdA0KPiBsZWFzdCBjbGVhcmVkIHRoZSB0YWcuDQo+DQo+IEJ1dCBub3cgb3VyIHJl
YWwgdGFncyBhcmUgc3RvcmVkIGluIHRoZSBidWZmZXIgdHJlZSwgbm8gb25lIGlzIHJlYWxseQ0K
PiBjbGVhcmluZyB0aGUgUEFHRUNBQ0hFX1RBR19UT1dSSVRFIHRhZyBub3cuDQo+DQo+IFtGSVhd
DQo+IFRoYW5rZnVsbHkgdGhpcyBpcyBub3QgZ29pbmcgdG8gY2F1c2UgYW55IHJlYWwgYnVnLCBi
dXQganVzdCBzb21lDQo+IGluZWZmaWNpZW5jeSBpdGVyYXRpbmcgdGhlIGV4dGVudCBidWZmZXJz
Lg0KPg0KPiBBcyBpZiB3ZSBoaXQgYW4gZXh0ZW50IGJ1ZmZlciB3aGljaCBpcyBub3QgZGlydHkg
YnV0IHN0aWxsIGhhcyB0aGUNCj4gUEFHRUNBQ0hFX1RBR19UT1dSSVRFIHRhZywgbG9ja19leHRl
bnRfYnVmZmVyX2Zvcl9pbygpIHdpbGwgc2tpcCBpdCBzbw0KPiB3ZSB3b24ndCB3cml0ZWJhY2sg
dGhlIGV4dGVudCBidWZmZXIgYWdhaW4uDQo+DQo+IFRvIHByb3Blcmx5IGZpeCB0aGUgaW5lZmZp
Y2llbmN5LCBqdXN0IGNsZWFyIHRoZSBQQUdFQ0FDSEVfVEFHX1RPV1JJVEUNCj4gaW5zaWRlIGxv
Y2tfZXh0ZW50X2J1ZmZlcl9mb3JfaW8oKS4NCj4NCj4gVGhlcmUgaXMgbm8gZXJyb3IgcGF0aCBi
ZXR3ZWVuIGxvY2tfZXh0ZW50X2J1ZmZlcl9mb3JfaW8oKSBhbmQNCj4gd3JpdGVfb25lX2ViKCks
IHNvIHdlJ3JlIHNhZmUgdG8gY2xlYXIgdGhlIHRhZyB0aGVyZS4NCj4NCj4gU2lnbmVkLW9mZi1i
eTogUXUgV2VucnVvIDx3cXVAc3VzZS5jb20+DQoNCkxvb2tzIHJlYXNvbmFibGUuDQoNClJldmll
d2VkLWJ5OiBOYW9oaXJvIEFvdGEgPG5hb2hpcm8uYW90YUB3ZGMuY29tPg==

