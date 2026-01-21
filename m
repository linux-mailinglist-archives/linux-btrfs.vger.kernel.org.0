Return-Path: <linux-btrfs+bounces-20835-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6H+LFsH3cGmgbAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20835-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 16:58:57 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF165992B
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 16:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77322A4CF28
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 15:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C451478E59;
	Wed, 21 Jan 2026 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LejF1OZP";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vVtg3Wb5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBE342315E
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 15:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007689; cv=fail; b=NKsW39hh4bqYM4RjEtg1BVkWZ5fgYVcJOmMC/wwj1lhzjjJkytG06WSxV6Y8FMO2lqPQzij0T9xN1u9LvzcgEiu9959+ypBMJ2L8qyvCc1l7po+A1v6L0GN/YkvXV/gEeVT4HMr1eb9asVvvL9M9UxgpVWchtpnhrWp53WJr5yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007689; c=relaxed/simple;
	bh=Rf25bHA1PGxNm9ReQn4VS40nGmj3TeYSvpkhnDeJhW8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KNNrpUBCZNbZzTTlzCeli1L4iU17UlHsnhHCNNzZXsQ+6Uewh79H8UhjHVNNqt7RsWs43AKBws4nKInDx9LKg/SwjfrVdS/N9DqOJd4gcit/W4SaIRtr4CYbJfRBVXYnaFdcqlFmjOxQkQJtwaUWvUwsYE9lM80jrsiatTnCuRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=LejF1OZP; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=vVtg3Wb5; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769007688; x=1800543688;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Rf25bHA1PGxNm9ReQn4VS40nGmj3TeYSvpkhnDeJhW8=;
  b=LejF1OZPookvQdP4dKXO2h1rjS3eJu3z90612OH2s1+a11qs8pTI7OvS
   gUc3SAJ/bYgxpP0kekHV3zOOVB7XRpM8O4di4K2gWFu7ZLJI/QxmlEVnQ
   /gJlKC1aGjf1NlOZegtDOpYlFmo3HacHK5YMbh+32RcYUJHTXx7hFunZt
   T1FudOAK0NEwbrtpXFicJuBk11wBgFhrXE9uvKti67hF6zWeCn2rlSYzQ
   eer8bQLRFNJ3oqN2pWeEDrheoVB4gMnyJdQSn+7dww7UkR7PrGE8IU2YG
   lRdTdTMSIGKjbymnmA7wBxQ0fYeaiE3EpSNg8mVdZJGjK7hzPsxiXiYR8
   A==;
X-CSE-ConnectionGUID: Q/G95ZksQAKVcbQ2la3uzw==
X-CSE-MsgGUID: 2g1GVw9IQiOzWImBSjdr0Q==
X-IronPort-AV: E=Sophos;i="6.21,242,1763395200"; 
   d="scan'208";a="138956535"
Received: from mail-westus3azon11010026.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.26])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jan 2026 23:01:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IwpiJWeSXlTCwyqD7BfrZBvPzNRsRIqA4Df2sIOQA9cporlXZ+RpVCjzMqB82lyNWjA+jwtzboCknaNuYMS5VvRLfuHZqr4Vi/WAhC/Ry8rxYMEXXPH0vK2v9eRU9PDH+QNdU2Uin4CUje2NTqyqYbOgr0jrKgtBfWx+eha+qyMRaSQxw5GJ7lQF0QFpcD+donrNAj0qLJdqFJadCWf7RfRys0CYFfs/KGKIon7y2c9FlNWgcdLDHglxr94eWUlvPHYKOfAg7cP/m4vacp4vIlrK6698rZUZY0NMhUaX8B0r3Jlh0PT2+CoVdsBqtCAhzidU4QqUhMRdsNJSdn7rFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rf25bHA1PGxNm9ReQn4VS40nGmj3TeYSvpkhnDeJhW8=;
 b=Xh0uObf00aNU6Noit2Mg2k/CSD9MrLB+6F+/KLbU+B/LCF1mHeP+DLBkud9r8Wits3sltwlpuWLBOrzUjer6dlUsdee8jataZ6q9LFlpIo7FT2fqyOoQiGuNRi/OZjjMKmzmcAC1DBgOHcAO+usJslr3yA1xixpn0focDeleC/ZlcdLnNa0xXkyEPFLKaQDavAEAjzvEy07pH203OQg4lPAh0CrugXo5aart+tE5RZmbJviLFzuur18A7CeMUF5fo0Pk8hmdkkiaAM+tV3tR8NmAK2ku3TBHu8WL3Psb96lFiCk+HXTr4mplREEK0sFSK2cmtjUpjOHCqb3+IWrcoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rf25bHA1PGxNm9ReQn4VS40nGmj3TeYSvpkhnDeJhW8=;
 b=vVtg3Wb5XvTTfAa7Y+QFcuPM5nFEoLilYsKXGksWeojaudXe4EsG0DTv21YGwUmSt9rx6bw9Sy6rTA4OTV0H3QfiKAOdnI5efhuhfLVjrzZoXLme60MC3/YKm7kCg+HAQ8d+FIdWY2rDRDJ6Tf4+e9l/Gj3UvH4Z+vhJ/BuXwAI=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by MN2PR04MB7101.namprd04.prod.outlook.com (2603:10b6:208:1ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.2; Wed, 21 Jan
 2026 15:01:15 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 15:01:15 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 03/19] btrfs: remove pointless out labels from send.c
Thread-Topic: [PATCH 03/19] btrfs: remove pointless out labels from send.c
Thread-Index: AQHciskGPL/DjALwr0q/TJRihaUt67VcuAAA
Date: Wed, 21 Jan 2026 15:01:14 +0000
Message-ID: <61899ce2-57a7-4735-b2e6-33223bc3b289@wdc.com>
References: <cover.1768993725.git.fdmanana@suse.com>
 <9684a687dd031bdc506fd15472be9356369a163c.1768993725.git.fdmanana@suse.com>
In-Reply-To:
 <9684a687dd031bdc506fd15472be9356369a163c.1768993725.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|MN2PR04MB7101:EE_
x-ms-office365-filtering-correlation-id: 10e8908f-4001-4f52-41f6-08de58fdec66
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|10070799003|366016|376014|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dlU2T2ZEMllqazZmY2ZHdXlDUEVHeHl3Q2VaTXVDamN2eExNQktCS2dOaXY0?=
 =?utf-8?B?VkNrTklHTHZVT0h5Z3JDb2s2Z2NaSGVGT3k2RjlYTEsvT3dRbDk1eXk0a0dF?=
 =?utf-8?B?aDdMMmk0MGtwV0Q2WVdpMjRIRFlOaU1TcG9rZ01lclVmMzBvMTVlS2YvckN5?=
 =?utf-8?B?TEhldXI2T2pOWlJNVmRZcUR3NlNYcjVueGxzcHY1MUZVd1NLMWtjalg4Y2dh?=
 =?utf-8?B?NCs5azJXRWJlMC9yUGJwVHlIRE4vbnNnOEdjeC9lcEEzVlVvRkQ5ZXlzMElP?=
 =?utf-8?B?Z3BwUDJjMVA3NDNnK2cxbTFvQkRCWnVSZmtCWUhnMjRzSWRKN1l1eU5XYTl1?=
 =?utf-8?B?Z1pONTEzV2ZPUERaTml0NitOYnF3dlo5NHVlTWhqUnZ5WnJwUFpNZGdUbVE4?=
 =?utf-8?B?MjJlSFV3UzQzK1YyRmgyYVhvUFIyK0NEamVmZWJrSURLN0hFcERZSHc3djNK?=
 =?utf-8?B?WVRlTWg5R1Y4a2xyeWF4U2JHc3JOV29Ickp1QUM4Tk9CMjd0UXZJM2J5K3M3?=
 =?utf-8?B?cW95YUxsMWlENjNta0ovV1NJbGNhVTIreVVjZGpaT1RmZ2wwMUc4SjgzUGhR?=
 =?utf-8?B?bFNJZDlPNHdJdjhEK0dlMW4zREY1WVBVTG9wMzJhbHc3MExIdVdwVVIwYkxo?=
 =?utf-8?B?czhLaDY2Q2JEQnY2NWttQU5VZWhQMmg5Y29NWUxzNnVMQ0RUMUtqSVJRU1Jr?=
 =?utf-8?B?MmMxTG9temZ4U0h6b1JrazZLTHU0eS9IT3RrV092RE9oV3hINVhMUzZTOEZR?=
 =?utf-8?B?NHFNV2FML3pxbHFaNWFZLy9tK1ZyYmlqandxS01LcnRFSDFFZzVkVEcyM0VP?=
 =?utf-8?B?bi9xbUN5dFFiTE5xZEZMenFUUzZ6SnFqekNCNjQ2eVMxNjJvSjJ5Q3dLREk5?=
 =?utf-8?B?MW5Ma2JXenBlZFhyN1NXTE5vRENBVE5zVkNmVVpGNHdWeGlENnZXb3NvVWtI?=
 =?utf-8?B?ckUvalJ3ZFNWL041MWYxOGRlaE0zeHZBTGRvWVpXY3g3OUJ0MU9TZmlzMHUr?=
 =?utf-8?B?UU5KVTZNbmt2cVBXU1dydUFrWWJuZmVtZlYrWFlRWlFOVmxIbklwR2VGdGZt?=
 =?utf-8?B?eXRsREVrSDQwM0FSV2VkeDQ3QXd4NUNZUUE0YW5sSm1aRE9ybjdxblkwaEth?=
 =?utf-8?B?cFZkcUwvK09LaTY1cFV1ZHMyQ3JtNFlzSHdpcXFTaDBvR1B0VTZqSVhuVWxx?=
 =?utf-8?B?N1dlZnpldmdGVXBITVVxL0ROdDJEYU84YW5BK080SThzbW5NMU1CdUdaL2JG?=
 =?utf-8?B?ZE9HUEgwajdkcGZWS2c2ay9MZDNLWmtibHd2NkhSUjAvVkJWcWh1OVBMVXh4?=
 =?utf-8?B?RUhSYkxRQ0ZkL2Q3RFhHUWx2dUZDaHdMcWNQbTV4S3VpbG12eVEwWlhKT1Bl?=
 =?utf-8?B?K25QeUFPdXEyamVHOGhFVjJqZU9JaWZ5VjNEdi9qOFNCeGR1OGV1SSsyaFN0?=
 =?utf-8?B?Qkd0RnR0UzNadXJ1dkdwVi9mcGRLR2psWXlYcG5UWXlBTXVyUWxHaTN4WGN5?=
 =?utf-8?B?RzhQMmt3bytOaXV1VjgrRm5FK2VnRzIwWG00OTNKYWp4Und2UHFHYVFxU3RI?=
 =?utf-8?B?L0llTXQzQW0renNQWTRmV3REWVhmQStzQXRuYjV1KytrVXBJdkQ2cElmMEJD?=
 =?utf-8?B?R1dZWDl3d3dWaTlMM2JWaXF5b0hYejNJSmluTGdhcEZCMjBJQXNPOVlPb0JE?=
 =?utf-8?B?Q1NSUUVUalgyaDZKTVZOU3R6aDJ4ajh3MjhwRjlYUUczRDBJcjIvSDg3R28x?=
 =?utf-8?B?YzZla3p6ZWFOdkdnN0l2U0dCdFAwM1M1Z2dOMjk4eWtjL0o2T0dVblhYUDRm?=
 =?utf-8?B?ZEVyU3IzSW94OHRxRkJOZGkyem1kZEloNW9iTGR5c0t1aGxkUHoyc3dDenRt?=
 =?utf-8?B?YVpEd3pPM1ZzU3podWs1QVhiVEZXa2U1ZTdBaWlQd21SaDZOdnJIUkdwN0hz?=
 =?utf-8?B?Z2Vma0ZONzVkL0krcEMrQ0l0SU1paFU4ZURtaTdpOHNGMTNvSUpSeWxXVWdv?=
 =?utf-8?B?WFhsZWhjNW5aYmY0aWdqNy9uai83dnpmV01BMkkveFVzU2lzbVJNMVh4bW1H?=
 =?utf-8?B?OGU5RFdTRXVEcTdWaHQxL0lzTU5YajhvclViejhtUDlOSkoxbzZxMXpnL3Ir?=
 =?utf-8?B?S1g3NHUxUUEvWkJNbzFHV3V0N0RBK2krTHN6ZFpqd29Yd3ZOUFRGVzhmM1Qv?=
 =?utf-8?Q?ZmBzq77SjzPsL4B5jsbHRbc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(10070799003)(366016)(376014)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aEo5SC9wbGprNGVQTkd1cHFHZ2RZNkgzVWIvU203dE5MMDNxb29WaFdsbjkx?=
 =?utf-8?B?bldHR1htRlNzTkt6Tko2T3JPb3NnSmdpUWpiSThyN0RMMUVVYm82UWQxNWth?=
 =?utf-8?B?d2hkTG5ZR0c1RUlxcHdyLzhDTHEyZmlGVE9qbFUwck5BVzYreUxWZTdhN0Ra?=
 =?utf-8?B?UGE5OUE5dWpaem1oblRodmN5L3Y3N0hIeU9IRm9zaEQ5bWw5WWVnVndVZ3cv?=
 =?utf-8?B?K2JYY0FId0xBY0ZhSGJ5dVcrMUsxckRraW1yNm9TTUdGeXJrdHNVSzBFK0JG?=
 =?utf-8?B?ZXhhWEwveDdYZm5aK1VrN2tGNnpCbCs2b2kzY2tNR1Bla1I2NjFVMmxQWlVa?=
 =?utf-8?B?OU5qMDJkK3UySGliQVhkSlhtV0E3RkpCNEVMb3BZRzlyVnVjaFl0U0FGaGpp?=
 =?utf-8?B?UzRCK1Z5Z3ExT052Mm1IZG1lTWw2UFg4bVNmMkxxdmpXcHRnUk1jY1dSMnNN?=
 =?utf-8?B?bWJkSnNaVy9pNzcvaUNFUU1sc3JDdHVZOU9wNThESnkvS1htTm1ydm5UNG5a?=
 =?utf-8?B?NzY0SU9KSXUzSTBnc01uUG9tNEtQWEFPWGl1K3hxQTFRdjA1ZHpvemNoTTd2?=
 =?utf-8?B?MWxBU1hFOElUcW5aaEVpMjNwT21qeFhuVWFIWXJySzlCb1lHYkVJVkVMSmNQ?=
 =?utf-8?B?K2lhU3hyQ2JJb1IwYzFleHVUUkM4bXdQM2ovdWJCemJTdFlyUW1uUUorL1NV?=
 =?utf-8?B?V0V5a1NNTnZxMnZ5SVlITE1NRkN0d1crbGRaaG52cFJJMTBTY2lHKzlOSnJK?=
 =?utf-8?B?SllNV1BqZ1VTVUcwakNidlpDM2dzeFJYN0tzMzAwSUxFREdrbmEzazl6OUJj?=
 =?utf-8?B?WkFjQTIrZ2FrNXpVWVNaVVd4L0lFd0NpRm1KMFkrU0xsVFcxbU53WmFVMWdJ?=
 =?utf-8?B?cEszMWhyRFNicmVtd0hRRnFkQTc4bCt6Rzl2bDJGYlNUY2ozV3JWV205ZnFG?=
 =?utf-8?B?SjV2U0FlZmxBQ2VBQ2dzT0krSFZwV1Rlbm5ubXYrUGxiYjFuUEQrTDRiS0g2?=
 =?utf-8?B?Mmc0Zm4zRmhPck15cElCeFBXSm4vTTNNcHdwMWhoL1cvVStHcXZQZDhHN0R3?=
 =?utf-8?B?ZE1EMVRaclM0elhqNkJSajdSSWlBMTFuL0E1dktwRFVXUjUzVWRqVW5NZ2NZ?=
 =?utf-8?B?bWFnT0svNzlXSU1HZFRiUEloYlZpVkhaM1I4WVdxQURnSE1MK3QvaHZnQS9H?=
 =?utf-8?B?Rm1RdXVZY0JTQWtZTGlaVHljMHdjNHU5VTNaeGR6R1FyNEpRLzNXOFhlL2pj?=
 =?utf-8?B?cEUwZjRTdlArM2tvS29ZTUVTSzBvdFBSNHQyZXlHMHNpYnJRZXNTQUtJTnp2?=
 =?utf-8?B?ZStXK200K3FHaldFVmRLTjdZdHpPbnNQdTY0bjl3WmZWOHF1bktLaDBhamlt?=
 =?utf-8?B?ekdwa2h2YWErT01DZFB3L2xKR09GaUFPK2tBaEM4cUZnbnJsM0FTcDBtS0VE?=
 =?utf-8?B?dGs0WFRHREN0ZUZWbDJWSGJ1WWlUdnJSVjB0SmFCWnVCaVdGQkp6MG1LZmto?=
 =?utf-8?B?SFNjTGUyeWJCZ1l1KzZpR0thOEZ6ODE5eW5HSkQ2QTFGM1IvVGVGd3FlZktq?=
 =?utf-8?B?eEIxa3VlSnFOMDJ0Z0xMeUY0aW9YU1RxSi9QUzRtdXp6dkVYTDRjVmtJS0pu?=
 =?utf-8?B?WVF3cmZwbEdLU3JBdWpqUlZDQ2lOckRKWXpMM0QwbGZRemJWbExPYXJ2U015?=
 =?utf-8?B?ZHNJUHFCb2lUcEFkSXNQOXNFbDZTOWpMaVhUelIxaDI4VUt4a0pRWE16OWZ1?=
 =?utf-8?B?c2YzR1hOWlN1MzFlVWkwWjM0YXNWNzZKTXBXTVNWWHlIRVNKVFU4S1luTEtG?=
 =?utf-8?B?c09EZXR5M1ZyTlo1VVpPNHp2S3pta0NVamlQTC9Ld1JQNmgzODNkV3Y2L0FP?=
 =?utf-8?B?aDJQM3ZTRmFyTGdFYVFxNC9DWW1rbWV0bmdGaFgzK1lRM280MFNDWlpkcGlV?=
 =?utf-8?B?R1R1c08rMjJ5dDhEeXFFdUJhRGdobUFBRVU5Y3dnRHlNQ3UyODlvK01oUHM1?=
 =?utf-8?B?amNWTW1VaU4rdjZST092WlZVYk9nbXBZWEhIaG40N05xN09taThxckYrT3c0?=
 =?utf-8?B?V3JMK0xNZHVGZ1hWN2lIN1cxWXhHcy85cnhoeFdGWVFsRlY3NnRPRzZUWWl0?=
 =?utf-8?B?U2xxUkxsSXBaQnV6NWpCTFhHejIxTlFXQ2tMY0FXVUhSQy84eFVEb2xCRm1H?=
 =?utf-8?B?WGpDc083Q0FDNzU1QUR4YU4zbWtDWk9VbFExUHY1cG1JQmNWRWorNHhGL0xq?=
 =?utf-8?B?RGVPNDNzMTlDVGFvbndvZFJyMnNjQ2VrcjlzcDdWQVkrT091RmlaL2wxSWtp?=
 =?utf-8?B?VHpVd2EvWDZnWVgzeHh4K1VaTVAvY242bzVpQlZBUTNzNmhraUJXVGhsWE5Z?=
 =?utf-8?Q?voNVnpc4A+/0lbSApGXymy4smHtHDpk8FMlpXq/TxSwgr?=
x-ms-exchange-antispam-messagedata-1: tXeav4Xo2NUDititVmdQbm9oMtL+J0e6J5w=
Content-Type: text/plain; charset="utf-8"
Content-ID: <17DD640799ED884680720BD24B8C8CAC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NHxtgLkRIO3X+ZRiEIYfiDeHbZAJwanxx3MOeslBqEmHPXF54fDtwVZmSPZD7GvRysKUs1XpTdf5TXOqVO9b8qZFbfP8JS91Af5kA4QReqW7GG83a+uwVx13Vi4JuApxhxiKT1FLwpCW6AU5OjVad+SjfWV9nkCgqSve/t6f6nn697sdGx/0GNMnWeXxn7+hEYTtO3k+rOlpofhVHytEnEJqpgxAMPicy7LwiPGMyTYO2huAxfHbE/BnBU1Oweb+SCy8rZHaJOcN7dAOgZpdirfebk1GjXzIY8EqQDq5xtH6ibn9iwc+Gr5udOJ0n8FcBwg3mzxVxDdVeftED4+xom1UD/T9B1ezhhZAki4CF2G+PFc8cjEupMULz3hJ6UkGzgml3Fip+BeJjV1SUP8095Fzd6I8GRGGvk139oY6/LXuYZKPI9BL/g2KngwwJ1Yf+yN2Wxc1UVe9qdp4qvPeyUJz89jQbJjS5BMNrkjnRvajQHY81++dsWlxX3T6Q+wJ7Ul9C2SyHiMnV7EeR0ZZekS1EkybG8ATwgdBEkupQEBcEJ9Dc5a6TPiE04y1JbFWM5DV65RUm1ABQuL8q1Y7aTrj5TdhcwpYiNbRF31qXKQ2VmdEdUUrp9T0YCrE5Y/b
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e8908f-4001-4f52-41f6-08de58fdec66
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 15:01:14.8943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 87g4/VRDX9GgEqKHfKUZez/F849YAl9qGaK4oH0jhsOdHFwE9WzGQVyfFtvf5PknmJoGDTyizlsqT+gtmL16sfCaB8I2+u5eU1IpqV4vAUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7101
X-Spamd-Result: default: False [3.14 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[wdc.com : No valid SPF, DKIM not aligned (relaxed),quarantine];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20835-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_REJECT(0.00)[wdc.com:s=dkim.wdc.com];
	DKIM_TRACE(0.00)[wdc.com:-,sharedspace.onmicrosoft.com:+];
	MIME_TRACE(0.00)[0:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	DKIM_MIXED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: BEF165992B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gMS8yMS8yNiAxMjoyOCBQTSwgZmRtYW5hbmFAa2VybmVsLm9yZyB3cm90ZToNCj4gICAJaWYg
KHNjdHgtPmN1cl9pbm8gPT0gMCkNCj4gLQkJZ290byBvdXQ7DQo+ICsJCXJldHVybiAwOw0KPiAg
IAlpZiAoIWF0X2VuZCAmJiBzY3R4LT5jdXJfaW5vID09IHNjdHgtPmNtcF9rZXktPm9iamVjdGlk
ICYmDQo+ICAgCSAgICBzY3R4LT5jbXBfa2V5LT50eXBlIDw9IEJUUkZTX0lOT0RFX0VYVFJFRl9L
RVkpDQo+IC0JCWdvdG8gb3V0Ow0KPiArCQlyZXR1cm4gMDsNCj4gICAJaWYgKGxpc3RfZW1wdHko
JnNjdHgtPm5ld19yZWZzKSAmJiBsaXN0X2VtcHR5KCZzY3R4LT5kZWxldGVkX3JlZnMpKQ0KDQoN
Ck5pdDogYSBuZXdsaW5lIGFmdGVyIHRoZSBpbnNlcnRlZCByZXR1cm4gc3RhdGVtZW50cyBoZXJl
IHdvdWxkIGJlIG5pY2UuDQoNCg==

