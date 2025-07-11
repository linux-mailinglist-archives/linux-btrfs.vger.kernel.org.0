Return-Path: <linux-btrfs+bounces-15453-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 049EFB015E6
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 10:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06BD1C8352D
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 08:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8FD2046A6;
	Fri, 11 Jul 2025 08:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nA2gyqJu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VZCTI+3Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DB41FBE8A
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 08:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222339; cv=fail; b=SE7h/YsDZ62Vr4ZC2IdQyi9jbbX2Ce3joIGyMh23gZV5RkO2UUeuWLSCIfIaeKNCLva/ii+ab954GV41gmzd+steu1H0bW7Cb+nmsDhVHlfChTNPy3cPXrKIYI3Dw/YbQXtR/5Fg8j8SnTtPpbkD7oAKjnt8cbvqY3o9jqnwHQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222339; c=relaxed/simple;
	bh=8Sqongv+eYoXVM9SQ9GN8AbDwlTKUd85SWRG9K4hE6E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HsNu6Tfvdf9fk8MqATThzQp5AW5aNLXiydQObdA5bdRCaSq7fqBbKkeNxhpRcgaIcZdo/omq0tElfkaELwSfvec1xZM5x19bE4iX0fk1kcjHMOMIp9MuRnPm6a8ObDXDLIHVl/uxrdfbcIkDfzyfEGeSJQUd61h6DWq/69TCScw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nA2gyqJu; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=VZCTI+3Z; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752222337; x=1783758337;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=8Sqongv+eYoXVM9SQ9GN8AbDwlTKUd85SWRG9K4hE6E=;
  b=nA2gyqJurRP6h6AoLtJ7+WClLjOXYhUeh7JzQTYN3icXkdOF9SeLuQRc
   dgqVjGnkLlS7zDAZa6ucsdUD8ze2inNLYvX1svLw75kQH75tcLyHkGWS0
   evfjsYBpl4Cxrwyyz8/d1DfD0CSNRIBfVf4iEzbC5pMFtDUiGy6oGysIP
   TNopPQEYTVpd25mdZ9lKKvBua7Svtexknbjmg2/gbkWRZ4OPiELQnMoWC
   sCMT3Aqh3S8El0MKGm0n0KgjDool6ikGUoIK8yED1EyCKHXCq3YiSG3pw
   SGC5DFdVuOqryP49R4ye3N22b5jR73T8eKvZLhq8Ag+qZJd0EJC8Si9Nl
   A==;
X-CSE-ConnectionGUID: UEnN7LSLRHqt6rzpY1IOGw==
X-CSE-MsgGUID: KDprAnqvSXe5n0YnU9E6ag==
X-IronPort-AV: E=Sophos;i="6.16,303,1744041600"; 
   d="scan'208";a="86861076"
Received: from mail-dm3nam02on2047.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([40.107.95.47])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2025 16:25:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gVnJTzztPGqyZmWHOXG0BHrw6rqbnJ6OucT+9RWoOmk9mMUH9fhXx7481pSE4uMXXXB4W2URkdYgj3ynpSwnn0qVwb3LDeM/WG8Oi4lXK58/3ecHUBbq49eIuQ2T9/C5NJwz/XBEuleT+5O3ccmdgNyVpcZwejq9r6ggSoSdi9/y9y2GVO6UJoXiDZkUkzjFJHGjGSCdYBgN0xAD8IfljBdwJ39DBRpX+x9WmcK/O4u+IxOTFOMmOfTF+Qo8qdCC5+0iBVakCgCPAI6z+dYAy4b23EG64jHZSp6sjvfWsSRSGRcpz2PgxbJ6S3rfWMhFw3WBqNVropfdJT4I2I/+mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Sqongv+eYoXVM9SQ9GN8AbDwlTKUd85SWRG9K4hE6E=;
 b=aRD5z8RKSj4acaxbkK3sGwbUdXVbFcl6pwqE7XstYPbSjs+qkUdtZj0Ord+0KrLYzi4NiZxAY0LoA+rkR2Z1HZ8CNS+BUBbiVMI2fmHmuzCTsp25HQlvTPTsuOOnUZK5SWuVyK/QgzQzi7pYFkebY9eZCXHrh/RB8YRmS5qB2bTkACtwml/CGh8hg063MSjHuUmbwXeeNDJnx5ong9qvCtOEj74v4kIx88fwFaDPNLk4q9HTS+OP1VQZ/1Hox9Q+WkFQDE9DAuW+yJj3Wwq2OGid7i37rpHy1N5EbbsUWyiQfN5wE37DCzAyCkaH4+YijfWFl6nW+fB2Ncwj+nEoHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Sqongv+eYoXVM9SQ9GN8AbDwlTKUd85SWRG9K4hE6E=;
 b=VZCTI+3ZwvPyRaIOpcXMYzmNQx8gVupOJgtcx+3cjzsrX7dTOTrOWBENH0j1cweJjtYvWxpDDSPfByaTUxC0+Nr7vVppofrAuHycA097wVrwYUUi8Y90BkUmMChYiYnH2Jx+ycuXEviEDZJ9STkc+V0CLX+dqPMEW6WUGIHDvaU=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SJ0PR04MB7246.namprd04.prod.outlook.com (2603:10b6:a03:296::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Fri, 11 Jul
 2025 08:25:32 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%5]) with mapi id 15.20.8922.023; Fri, 11 Jul 2025
 08:25:32 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] btrfs: zoned: limit active zones to max_open_zones
Thread-Topic: [PATCH v2 3/3] btrfs: zoned: limit active zones to
 max_open_zones
Thread-Index: AQHb8jTWJiu3f6Uts0aDF72Iu7PRA7QsllCA
Date: Fri, 11 Jul 2025 08:25:32 +0000
Message-ID: <28d15a75-5217-4288-b607-6c989ad5e7c7@wdc.com>
References: <cover.1752218199.git.naohiro.aota@wdc.com>
 <99393b24788a89f01d2cd36cdc819c3caafc948e.1752218199.git.naohiro.aota@wdc.com>
In-Reply-To:
 <99393b24788a89f01d2cd36cdc819c3caafc948e.1752218199.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|SJ0PR04MB7246:EE_
x-ms-office365-filtering-correlation-id: 073a4a05-0f25-434d-a139-08ddc05480a1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eTU0RUhubG55allGTHNxTDhxQTJGWkZGTDZZeG9UYkhoWHZNMlkrc010UkFj?=
 =?utf-8?B?QXlrQnROZXk4UUxlVnUrSWwyanJhR2MyaDcrRHp6T2pkUFFCNEtEakdzWEQ3?=
 =?utf-8?B?eTlUbmh4RnBHeEFrcGRXS2ZhWXRvZ25GbkwyYkxoZ1hjQTdPV3VGSHhkMHVU?=
 =?utf-8?B?QlpUYjdTQ3NSVDQ3TmpZSmZQZTZJMlJLblBYL1FuK3k3RmNxQkFnZytsNUNR?=
 =?utf-8?B?QktkdStyMXpBUzRLclBUNTBaUzNPemg1VzRoNkQ0ZVNiK0x6OHRqT0Zlckdw?=
 =?utf-8?B?MjB6QnJqT0l5MVRiU3F3a1ljbWZFS3hiY1ZneER5ZkZqbmcvckx6alE3eWxl?=
 =?utf-8?B?aUR2azZVSjhuM2lRelFSZzIyb1RJTXgzbkVuSVpadEdZcnJwZWI5RVVrM1E3?=
 =?utf-8?B?dFppb1JBbU9PMzJudGxOWW1FdmUzRUVuV0pYRGk4RmJuVS9wallMa2E3bUwz?=
 =?utf-8?B?SHkrd0kvZTk5ckRPNlhDWkg2UmV3eDN5S21DVVJXaENYYmJ3VVpwSk9ROE0w?=
 =?utf-8?B?WTB1Tm41VGZuMXU4Qkl4OVJCUysvOFk5Vnc0c0lBT2dMZlBLQjIzcy96Zk9W?=
 =?utf-8?B?V21SZDB4VEpMWlFYVXVrcHBmMDdYTzhhcGhjY0h0VjN1S0t0QU1wTGl1M2F6?=
 =?utf-8?B?anhOTWZyaDF3WnVHWWN2czZjUGNKZEJWdkRxL2R0MHV5SDFZaElkMDQ4VFEx?=
 =?utf-8?B?b2w5aUVOcmtxWk9ON3dPbVVGY1NpUVR6RWpROG5KazlqNnJsckM0d1BYS3Zq?=
 =?utf-8?B?UFp3Z283UEdsVjdZajRtbXZoekt4ODhQdGxkWXIvaHNUbG43dGxGdnU3aUdY?=
 =?utf-8?B?R3k2ZE1vOGtwYUpHcXNzanN3T3Z4VzhqNVNwTUFwa1VSeVovWXFGU3J5UXov?=
 =?utf-8?B?dlFjclZHbWJiSHBOVGI0a3JnY2M2OEozdnJQTFh4UXJaTVI4cTVuQWR0QWY4?=
 =?utf-8?B?NDZHUGI0ZXFyR2pCdkpSQmUwREc4Y0p2akhzU0QwZnFDWWFJbG4wcmNmcCs2?=
 =?utf-8?B?dmNEaVhaK2RLSnIzQ1V3Vkk3dC9ZRGg1bEk4KzZhTjBld241NndLV2FXbHZs?=
 =?utf-8?B?ZEpRMlBvNDNGRW9oWklTWEVGelIwWWN3YnNRQlFiMDVYajlCQm4wQ2hueEpU?=
 =?utf-8?B?RjdocWw1ejZtY01YK0h2NDB6OXJIZ0pjd3RXUTZoRytLcWNXa0U3RVdoVFQr?=
 =?utf-8?B?TUFnT2RMbTFWZ0ZobWNDV0VBUXFjRlVITFNoc0NvS1FTSUpjV3o1R3IvMy9u?=
 =?utf-8?B?Y2Q4cWt4cTNPSUhydzNhOTFLVVhKc2xRL1U0V2pKc0o3MTh4Y1ZCVlZKR2wv?=
 =?utf-8?B?R0ZCdnJCdWZGWlYvNkNVelpWM0x4ZjJqN3NSdlM5UklLYzRFREtQTkE1cHZK?=
 =?utf-8?B?eDRUMWtXNy9NNWFlcGtibFFoMjF3R2x3dkhheVp1L2pnMmp4ZXNUS0hTVDgz?=
 =?utf-8?B?ZVFoaFV6RWFXS1VMWVUzcm9LUFJmTTEyR3kxQ2RGQ3ZuVDZkNkt2anQwUnBx?=
 =?utf-8?B?d2hWQ1RFdDUycmdsUEJFMWNUZzdnN0hTL1NJa2V1WTFFY3p3dWN0eHQrUjJk?=
 =?utf-8?B?QnBRRzVIZzZkUjZTdmMyZDZ5THRvZ3VXN0xzN3FzOE1iQ3ViM3cwRlYvLysr?=
 =?utf-8?B?dEc0cFBUMm9rS3JZNzhHRUFrNzIwTVpKeFlDdkJrK2UrVnpYZk8vQkticDVp?=
 =?utf-8?B?M040eVlLaGdUSSt0WHBLUjF4bEorK2QvMmlFWHB1dHBocWRacVdDYnpLRHVS?=
 =?utf-8?B?QTlWYVFieDd3WkMvaWthMkdPOEkxTWNHaStEczllQldGc0dvcXBSUTRxb0RR?=
 =?utf-8?B?MzBXU2JLeGdCVnk1QktzQzNnQ0lOSEJneG1FZDFIUWVkcXl0eWRmTjZwZjZG?=
 =?utf-8?B?V0dINmkvcnkrbFpsVCt2cVFiSlg2SExmbWlwQnpjTTlLTkltbFYvNVN3M3BM?=
 =?utf-8?B?UGYycDJicGsyVEhWRnVQNEM1ZUx5K3lZMU5pb1lYVFhkc1dmL1d1UmVLSFpo?=
 =?utf-8?Q?hI2967FBliQ+tM2IxOoYbPMaqd0HDc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWhCQkVobFZPbFpmc1krVjFCaUZENXloS1htYU1LZllKT2pRenpjWmZDa05Z?=
 =?utf-8?B?ZEQ5bk5obVV0WWloZDFMc3oya0VVNHFQWWFBMUFWY01MZnJ5S1ppY1pJMHIw?=
 =?utf-8?B?RXhxL1pUNktPU3M3cTI2dmJibEMydndFNHV1Wk0xaEkxUGNFSXdVTHYyV0dh?=
 =?utf-8?B?eW9VOFdNVHFlWnArQmhzTlZLWTZvanM4eVF1d0NnTXVwT3hEem9UNjdJNTFO?=
 =?utf-8?B?Q3hYSWp0NTU1dmRYR0VYYTQ5UzYwNmhqWkpsa1N0YnhRZHhpYTlRd1NqeTFY?=
 =?utf-8?B?dUp2RmU4VnREZ3JjcGJvam1uaURpT0xFZjZMY1A2OFBabjhTYzY5OHUvNkcz?=
 =?utf-8?B?Zjl3RG9MaXpXclJ6TktDR3drakNOQjBVazVOQ1o0eGVGbUhXU3Y2TmZMaEVN?=
 =?utf-8?B?a053S09jQXExckg2eGpaNFQ0VXJheEFFd2JDcE05RGpycmtaekswRkZ4WUdj?=
 =?utf-8?B?WGxmS2VHT1RNRjBZSER2Wjd6YzBjSkJMNHpua1FmQTdsYTB6eHppU1hBSEZm?=
 =?utf-8?B?eHFvZjRwT2NjOWdsaE0ycnZwZ2RMcUhaRVdBQkNrRFN6STZzWUNYUC90YnY1?=
 =?utf-8?B?WitiTzJUdTU3dnhjNjYvYzRJWFVFaU1NR1J4T01WRTlRTDJNMGVVNTdMTmlj?=
 =?utf-8?B?bSszSmVtdE9rNjdPVHpscHFUMjJwc1l3anBNd1ZSVHZFSzA2alJpVW40UHNl?=
 =?utf-8?B?bTh5NlBGNjlpajJucXZSOXNwdVJmQkRXNmJsMDBkRWQrVEJSTGozYVpGUnd4?=
 =?utf-8?B?Y2w4MEtKZjR3TnBId2FnSWQxN0lQRDF1clpXUFN2TUlORXdTMjg1RUtlQ1lZ?=
 =?utf-8?B?cjhPTG1PM1ljWUtkVStWM2t0UkFDTnRtYnpmQ2FZa1QzT3BBMVRqUE5tZzVC?=
 =?utf-8?B?ZVhyeWErZnQ2VHZmTjRxSkdWVnU3WEYwWFlMeXZiRGhXY3k5c1I2ZjFadXR5?=
 =?utf-8?B?R0ZwZzloU0hiTkw5Rlh2K1FtMGFlTzVDSVRSdjE5L3BJb1hlZCtUbzgwMWZa?=
 =?utf-8?B?cGtpZjhSY3ZDNXhNSnRpNHVBZXZWZTZ3d3FDcHFRQVNtSTQ5YnhtS3BZb0Q0?=
 =?utf-8?B?a3pTb1BHWHJVYk9GcHpRckUwNEZwREt5M1VneStqZUNFZzNPcWtBYjVuSzBq?=
 =?utf-8?B?RlBTbjVPeHFQdnhLZnlEakJDM1VmUlR5QmFHcXZ1QXBlVlJ6S0JKQlhBNlQr?=
 =?utf-8?B?V2tpRXJIR1phTnZVb2JpaVFobHZBYWNXakI4MGV6c2w4czZEMWZBbjRJNDZ5?=
 =?utf-8?B?eWdycnJNK3ZpdGY1SDBWVnZXNDN5MjI4dC94alhZT3BtdFB2ZTJqeXdGRDZ6?=
 =?utf-8?B?UUkvV2w4N0QvcEkwTkliZ3kyMmxnNVdtUVNWSHhRSzdseXlpK3prQWNoUjBs?=
 =?utf-8?B?R3NGKyt5YWphYXpwUVR6K2dJeUVsMGV4bzNtOWpFRVdHZmtiSkN1VGNFcCs4?=
 =?utf-8?B?U3ZieWYvNmhhWXI3N2pDYk5zRHVtdUNmM0pycE1JK2NIbi8wTDNDQXhSWlhZ?=
 =?utf-8?B?NStoQlc3V01EK2NFT0l0MmhCLzZib1dhR1ZOWmt5T0FFWDFkQWxTN3ppODlh?=
 =?utf-8?B?cWVTUmJCVW1EWDFWdzVqZHA5MUcxTE1HMHY2NGVIejRPUmlMRUorYlgzYjRT?=
 =?utf-8?B?SjNUMmRYWDhOZlc4YmtRdVl0SkgyTWsxT3dOQ1M5eEtlc1d3QjVRVHlaWDZq?=
 =?utf-8?B?a2VXbERKVWd2aWYvLzlxTm80UDdxREo0SlQ4L2IweENmdENFRkN2R2ZBem5l?=
 =?utf-8?B?ZVNPR3BqVXdTZnlIUWF3VFMzU0xZMy9BRXBmMlRyS0hvdnNnVHhZTlpyT3lU?=
 =?utf-8?B?TTQxTWZTWGlFRWdZUUV0UnZWN0ZLd3M1WEVMUTkyL0hEV1VYc1NpYjlXQnBo?=
 =?utf-8?B?UzNFVnJ4T25yUkdSUlJNS3JuOUNSdit4Yllxa3RtbzcxTHgzWVc3ajAzZmpK?=
 =?utf-8?B?MWU5N1lNbkF2aHNaRGpyZU1MUHUyNzQ5QTBraVNqeUhqSkQ0WHFDb3FqKytT?=
 =?utf-8?B?L0pjb1pkZ3VwNFI5WGFjZjhTZ1UxeVdoK3VPb1V2ZFg0S0c3cExsL0pWMXJN?=
 =?utf-8?B?azU3U0Z4ZUV1dG4ySno1aTc0Vmt4WDBza25WcUF1bXdPN1B6WkpQbUlWM0FP?=
 =?utf-8?B?RSsrNEh2aU1XQ2d3c0pYZXRIcTdrYzNsUDZSS2ZzZUNpVjBNSk1ITXVQK2xU?=
 =?utf-8?B?RVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C56F0212D4C848498F9A14FBC369D13A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1MU434nTR2MhSA6n8f5720IDmWW68e42P1bquD1pbt5FJwxS9LLQnQCZOTAAxdQ97YjTusTyAqzUdfeI4p67hSzoazQFciuhKfdxMyjGEDMoDNTqRO21esUqOsJFL6GnZHSxUZ9MOdFOWKLZ3TUDLVH5r0Pv8f/Z2UGNXXcxHHrDLWSJxkdyOCcxmojTp4L+22NPJPhcFIypbM/3e7jQ0ZrXJLINwmrTq9K0s9AYpMReEiVwqrSpE1TS0jbq5PYrER5sDRCWId47Qd8fQkMda7vr15iQJMiCiIlN9gojpesWoEjvjq7oly51e0bU423MRepZGca8Hd2aKuq9mf7k5m68cDrTd6j31l5QTVcPZOK3E6F8SET0xEA/zVf7we31VJAexDPKYFJOxB7KPdpV08D+zg21sr8N04zLOprn/sP3cfzXinDWlXYOkZJL+3C89IvlLBLYKJKXauXhfaHuJ8T5ZtVTRUuPGInt7Bzp+7MthCWRFLC+3GM/PxvNZfdGHM2kzuPHXed9Qt2NhBoG5b+C9t77vSoLKkmBrPUMBFJAtWtwQjcjQqG0/Nx11O/2cwMVVHkjM00m4WN/oUHV66q+rnGRIrDPVUxt/b0JjU8+oergoJQCE7AZQER1Ux2U
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 073a4a05-0f25-434d-a139-08ddc05480a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 08:25:32.4291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RvdhXzwZpNtkn9HX3KUW5WLH32QR1kbCZu3r/JSxjK3vyt0iDCwvWjUPCydCfLDZg3sVymKdFvhWV/6v9qOiJFqV9lOMe4KWr3CK8TMm/Ns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7246

T24gMTEuMDcuMjUgMDk6MjQsIE5hb2hpcm8gQW90YSB3cm90ZToNCg0KPiAtCW1heF9hY3RpdmVf
em9uZXMgPSBiZGV2X21heF9hY3RpdmVfem9uZXMoYmRldik7DQo+ICsJbWF4X2FjdGl2ZV96b25l
cyA9IG1pbl9ub3RfemVybyhiZGV2X21heF9hY3RpdmVfem9uZXMoYmRldiksDQo+ICsJCQkJCWJk
ZXZfbWF4X29wZW5fem9uZXMoYmRldikpOw0KPiArCWlmICghbWF4X2FjdGl2ZV96b25lcyAmJiB6
b25lX2luZm8tPm5yX3pvbmVzID4gQlRSRlNfREVGQVVMVF9NQVhfQUNUSVZFX1pPTkVTKQ0KPiAr
CQltYXhfYWN0aXZlX3pvbmVzID0gQlRSRlNfREVGQVVMVF9NQVhfQUNUSVZFX1pPTkVTOw0KPiAg
IAlpZiAobWF4X2FjdGl2ZV96b25lcyAmJiBtYXhfYWN0aXZlX3pvbmVzIDwgQlRSRlNfTUlOX0FD
VElWRV9aT05FUykgew0KDQpDYW4gbWF4X2FjdGl2ZV96b25lcyBiZSAwIGhlcmU/DQoNCklzbid0
IGl0IGVpdGhlciAnYmRldl9tYXhfYWN0aXZlX3pvbmVzKGJkZXYpJywgDQonYmRldl9tYXhfb3Bl
bl96b25lcyhiZGV2KScgb3IgQlRSRlNfREVGQVVMVF9NQVhfQUNUSVZFX1pPTkVTPw0KDQpJZiBt
aW5fbm90X3plcm8oKSByZXR1cm5zIDAgQU5EIHpvbmVfaW5mby0+bnJfem9uZXMgPD0gDQpCVFJG
U19ERUZBVUxUX01BWF9BQ1RJVkVfWk9ORVMgd2UgY2FuIGVuZCB1cCBpbiB0aGUgY2FzZSB3aGVy
ZSANCm1heF9hY3RpdmVfem9uZXMgaXMgc3RpbGwgMC4NCg0KU2F5IHdlIGhhdmUgYSBoeXBvdGhl
dGljYWwgZGV2aWNlIHdpdGggTUFaID0gMCBhbmQgTU9aID0gMCBidXQgbnJfem9uZXMgDQo9IDEy
MCwgdGhlbiB3ZSBnZXQgbWF4X2FjdGl2ZV96b25lcyA9IDAgYW5kIHRoZW4gZG86DQoNCnpvbmVf
aW5mby0+bWF4X2FjdGl2ZV96b25lcyA9IG1heF9hY3RpdmVfem9uZXM7DQoNCk9yIGFtIEkgdGFs
a2luZyBCUyBub3c/DQo=

