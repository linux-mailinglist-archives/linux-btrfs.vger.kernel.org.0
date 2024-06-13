Return-Path: <linux-btrfs+bounces-5711-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C290D90748E
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 16:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31D11F217E3
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 14:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02201DFFC;
	Thu, 13 Jun 2024 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gAqSD2MI";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hc3oLxem"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB7D9476
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718287491; cv=fail; b=FWYfFPUM8x7ASHuK+FIxAJe2hFsmIY2anlA8FD2GUUF66ipBNc3GDjvKu8nz/7VqrZDn55CuOmnKT0VB/u6BjG+dVsF0dXify524FPGYrZpk9pLzE4FzoAO5e5+E+pkqpAEK6Xy+A1mKPTtrHOWuMT6vaaHAdBFQ0uvzSisf500=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718287491; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=deC7GGmmEsry+X7wStdLezlvU+mhGiK6QECeMUmpR/ch84q2nBYrmaIT3gcLnGcientP4fzZxiVXXvQ1nW1HMxzLmkj2sPgoKv973HCi3YbGCIrByTLtSMweWFQroY/+yGH6GsZ4oioZ7g0UGh0KuScGdZHrffFI8UkE0SJYomw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gAqSD2MI; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=hc3oLxem; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718287489; x=1749823489;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=gAqSD2MIzbQbHPebsog0wUU/U4n/OiDiIXlXunZ4XaqIRBrxFnEJ5tvc
   7N36NW146EplYfz4bdJ63IYfji8f80EpG6RFXopMH671MDwSkas1qKSoO
   ANHhjXkrZRsEqyyf0s5ieMidynvkGtQNq5Ho9LJXnEUM1tE5pJwFDF13m
   tC7CLr9w+gyUHi9hb/KEez6VoQuM3KQtz1DnDVoZDisdIq//rfho81UXs
   wREtrEJKBcl+wCJFA45dUFQK9l+3romZ6SQt08POddQesj8DoCJ+/g9bK
   njBG2wNdldlmVPgQRo8u68V5VHzmtym4I3IqhsPziqKJNF1g/3zIBEcN4
   Q==;
X-CSE-ConnectionGUID: yy7Uxt0CSXmwYN27rOlX3A==
X-CSE-MsgGUID: yf29378lQT+NRvjjYHXjdQ==
X-IronPort-AV: E=Sophos;i="6.08,235,1712592000"; 
   d="scan'208";a="19352670"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2024 22:04:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Su/pn7LDtE/IW1/ZbZt2AodIM5yU5VzWcNo/A/ha0mlqlMsh8jECBaM1fue88L43JjlmgzPNoU4TKM+qF+jg+VP2s6jiRRdwkzh4fkDO+nWQRMKzSPPlxQUQYGdffTIpenShcEymAOyhJVB+If3GHoLJuf7tzPX9LauR4mbll6oHhNLdE3FjqLJ0t57QipB7nCgN4OHRa0gmYQ8z7pt9Ey+/x/Omaik0yFnkXXr+fmsJihj6dado7zyPtf3J0+8wx0Gqrgu5O17e/+3YBLL+tMB/X810sZBwIDhaVixSlh89y7u8C5R3CWtIRPqk1VCNN+5ipZSlQ4CIXDQMzYgxjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=CxDxqEEdJFVft+ia13BMvvgLKqIBXsiXAB4Mzhu03wJ9XJj+EsG6u8Ph3+0NlOJNZQ4yDEVsYndrpPSEzwvl13+yh9ldsV2tr4juuz7As70z8kWazX9A2jW/ywOGySofopOLLrszIF7VuNsvXufo65sYR5iK0DNjU/On9zwDHdMufMGzP0l1vNaMSHestMVNKaM2QV8fRvIjNN5zPsv3bvJACHiadt8S8w1yBUpcGDZ6ym4CHAQ5eygTnnO0fuUshD1+y8h2Nsqv8hdAKUQ0hNclH9Ild10gzrOk382D/X0ZOquKwFFGMbysqZrz1clT/jTDX5YzUXzD+vyoqQKSSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=hc3oLxemm3ZADytAf3ZCtMYRE267fNUvtOkLOXFB3E9vGegknvGyijLVLQe7+vjx/DzbSIWA68jpkihHW+gvyXt+lDN3narNXHKkxL3Z40RUfut4Es4u5YOI+20ViJkhOgrBvgXi+7t4ymf1drmiE0iSXa1tWZyPjBmcK2Xb6Nc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ2PR04MB9010.namprd04.prod.outlook.com (2603:10b6:a03:561::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Thu, 13 Jun
 2024 14:04:35 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 14:04:35 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/4] btrfs: fix a deadlock with reclaim during logging/log
 replay
Thread-Topic: [PATCH 0/4] btrfs: fix a deadlock with reclaim during
 logging/log replay
Thread-Index: AQHavYGgvgwfmsAq80CLQBCUZo+HJLHFujkA
Date: Thu, 13 Jun 2024 14:04:35 +0000
Message-ID: <eac1c097-aa37-4f13-aef1-5dd21bc81618@wdc.com>
References: <cover.1718276261.git.fdmanana@suse.com>
In-Reply-To: <cover.1718276261.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ2PR04MB9010:EE_
x-ms-office365-filtering-correlation-id: f777259f-4f2d-4d26-fe85-08dc8bb1c185
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|1800799019|366011|376009|38070700013;
x-microsoft-antispam-message-info:
 =?utf-8?B?YTc2bmsvdU9FM09qUzlkNXN3Q3RacWRaWXVUSlM3RmFITmF6M1FYWWYvZmo4?=
 =?utf-8?B?aVEwSTg5UTVqTjhneTA0eGxmL0RsQ0ZEQjdmU21tTExYUmRGM0FteGt5ZFlh?=
 =?utf-8?B?bEJJV3hRUmxURDFNU0FWYmZ5ZXV2aURGRjk0aXREZEE0N0M1UXE2eWE0QWVy?=
 =?utf-8?B?R2VybHRidmN3RDgxRk0vZ01WUFZMbjYwQ3RMSzJ2OW5HY1BRWmRpNGdtQ3hz?=
 =?utf-8?B?MkR6SFJOeTlpbzh2YmdXek5BbWg1cVp0T0FKdnMvcEd1WDZ0L1g1SXBXbm9P?=
 =?utf-8?B?YmtKT2gyQW95eENoWkh0MlJMQkJKMkhKdkxDQnRSNHQ3aFg3RjFqdGpqK1NG?=
 =?utf-8?B?Yk01T1MyOG9laWl0OTdiNjkrRCtOdjQ1WU8yMUhkcmNsR3pXZEZROUpKbzNm?=
 =?utf-8?B?Y3hnTjNxWDc4RVQxSXpTRWthTWhySkpMQ3gzS2I1a3NFaTM0RmJvQjBWWi9t?=
 =?utf-8?B?RDdsbzh6cXYyWWJ2NmJiTFJHVUdHY0E0bThFVFgxdVdTOU1lM0IzZGcydGhJ?=
 =?utf-8?B?dVhUSlFuWGhVUU5TeDFwZ2dxTXJKRnBWOEdXaE8rNGlRellQbUVHeDloVmtj?=
 =?utf-8?B?dVNwUVR4MGYrZmlFTXZoQlYwc1hZZzJQbCsvVEJBV1B6cHZOVkNRQzhObWpK?=
 =?utf-8?B?dktRZFF6YXFOWGRJZlJ3dTlXSHp2U1M4VHdMWTNSUG54MzZXaWVGajJqb2hs?=
 =?utf-8?B?ZVdRTkNCNGdlYUFHdTNjb2ZVeFg5cmxqK01sbzAraEYvejhXUjdqNzJJQldI?=
 =?utf-8?B?bGFWRVdDbmt4VDVRd2JhS3A4QVVFTTQ4VWp1TWxCUWRCZEpEYWIvSlEwbVZr?=
 =?utf-8?B?YnZ3aHJ4R0JDZ0ZOWVgxZHZrWENuUGFMckNoSHFXYzZLZVU5VXBvcUZTbHFO?=
 =?utf-8?B?WW96bi9ERVk1N200Y292UEowNFQ0Y1ZOaHlFQ1NqNXYzRmpWUkRQVEZramU2?=
 =?utf-8?B?VU9ydkR6b1BiTzgwZFMzYzdEcTFxejNNOEt3dFZDdDFQa2xiaTdDc1BBNk14?=
 =?utf-8?B?RG0wMHhpeDQzaTNEcmZ1Q2JEOUUyTnpuWFVYdUxXWmhxT25lVUNTbjJ6dmdC?=
 =?utf-8?B?b0FIZ0N4VUtPWHlrT1hISjNoMHhJLytMVzM1VHVwN3R5eDFZUjd0UzlIcTFL?=
 =?utf-8?B?RzJ0cXF5L0VnNXFSK25nbEp2a1J2UnBrWC8zRTA3MHJxa0pVVzFmUUZuNEJL?=
 =?utf-8?B?NUNmVHp0N0E5SWVxVWNxclRHS3RCcDBkbm90elpmc3EyRkl1YmFyK01pMWJI?=
 =?utf-8?B?V0dhK3FNbzlrT2d0Uk0rdC9UM252N0N0RE1QKy9KR09zZEJsSzBMQU1SNUFN?=
 =?utf-8?B?VThOSjVhTFZxako4TkJSaUZpM2RtRXU4SWh5eERyd01sRnk2M2syaGZaRTVx?=
 =?utf-8?B?cjVOVzJGL0h0a2Q3ZngrVStRSDdPaWlEWkhTalcrQWxBMWxiVnk1dkNnL0pk?=
 =?utf-8?B?aWVXQjZkQ0FYTmxVMFlHRFdpbGxqYXV4WnBoNTVhU1FQQ3ZCU1BpRHVrMXhZ?=
 =?utf-8?B?MlJmV3o2NXp6MmxWUktSVTFjSjRSYlVFeXNKUXZLQVN4Y1NYK3FPakxqVnR3?=
 =?utf-8?B?Z0VIcndka3VYaVRFdlJRNzkzVnJHU0VLeEhsQkdMYXFoQXU5N2IwNVdHeU1B?=
 =?utf-8?B?YWVESmRBR3AzbUcvS3RxWXFxLzVvS2o5TGpvZGNOSG5vZjJQaDZ3R0U2R2tm?=
 =?utf-8?B?aWxFTkR4bE13YkxKTThFS1YzQXVjRnlYS2pyeFJJUHZuMlRDcU1HWGJMMzZu?=
 =?utf-8?B?MUhhbmJDMXhXQ09ORWt4ODZzS3A2MExCcWJEMUgxR2VBVWdMK0NPS01YTDl1?=
 =?utf-8?Q?HLk2ffGHBVhvvwbTgh6GkCha8apvJoArKrMOA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WHN0ZkNjSDFFYnh3SWwzNFFTbnNNVXZaSHFwL2t1cjBWSXRpRnV1K3RLNytw?=
 =?utf-8?B?VTB5Y1NZNmtZYVp5RHJPOEFVQis5YThoYkNPdEh0WVNmQnNjR0RWUHJUb3ZX?=
 =?utf-8?B?YWRIYzhUamRpRXVaSmhxMURqN3FSbEFRSXZGZk9xLzd5b1hyVHBXcWVJUm5C?=
 =?utf-8?B?WVBqNFMrTFUvd0pjOHRFeDQzWENGS0xuUTZkb2Z6YVFOQ2ZIVjNmWkhsQVNU?=
 =?utf-8?B?U2lMeTc0alM4V0NNRFlHa1pEVWYyWDlUYUIrcFBTRG1XWVVHUGM1YnpwMVN0?=
 =?utf-8?B?R0NhM0NGRTMydXV5WHpCUFVtSUNURkU1cFloSHJtVWdPUjdWbzhTaEp1TVIv?=
 =?utf-8?B?RkRSeGxKZjdERTFUVHdRZDJHMFFSMzJDZ3ptODUxcVVUVXlWaTZ2ckNaa2V3?=
 =?utf-8?B?dFZuMUpmV3VYK3ZvRWJna1g1Ri9UNDJoRUxGdjJGZitsenhqeUVvZE5zWHZD?=
 =?utf-8?B?Y3hiWmIrZ3Fidk9qdDRvbWlBZy9hTlNEQnRzWG9hWWdSV0ROejViWlFKUURs?=
 =?utf-8?B?LzYyN3RQRllvdVg0U2l6ZFU0ZHdTVFhTeEVzcnpCVjlVVXZITVc3LzhFZ0lT?=
 =?utf-8?B?NDZoWWFFaWR0TFBJZ1FFUHY5S2cwZDYyMVFVVDdJZklUTzhVdTRXcnJlRVFY?=
 =?utf-8?B?M0pxUEorR1lvRFFGODdvaitjaWhUVHpQRnFQZmY3QTRFVmNvSm9mRjNNSGZm?=
 =?utf-8?B?YlluV3UzNzN4aGEzbHV0Z0NBNXpQYWN3SUYwQ1NlaEkwRnl0T25Oci9qYk02?=
 =?utf-8?B?bFJLUFNRQ2RkUm5KYWRMUnM3U3NONFV4UTdCTVUwWGJJVytsWlF5MzB5Y0c1?=
 =?utf-8?B?ZXQ0M2p5eDVoamxHSDMwb0JnaFBQeFpQMVVkRVhubCtpWVgwRHdSRTE1T2pB?=
 =?utf-8?B?ZExRKzUrMVVraEZKS1FpVlN3NXd4Y05EMmZtL1ZNNFNrc0NpTW5aRytRd3ZN?=
 =?utf-8?B?WUJNRXo5SlJoQWxzMlZkanUvbCtJV1Y2czJCZDlaeWZwSmM1QXZQU0JZWGVN?=
 =?utf-8?B?WVZXR1l3bjdzakt4SlRmMmRMdy8xV092OVZwcVRvdE1Nb3hNRW9FWStrRUdp?=
 =?utf-8?B?TjMxbnNHbThmQ2tPOG9WTjU2bWI2OGFESlAvWCtibGx3L3Q2bFcwTnZwL1l5?=
 =?utf-8?B?NHFBSnJzTE42dVVyNUVIQllEQTJIOW1paloyOXRjSHRQdFFrK0Q5ZUQ0Q0d1?=
 =?utf-8?B?UGpGVUQ0cXd2MXJyQkszRzQzdHRkY1czazNaaXRMbEtGZ3Z0Z1prOWhFOG1W?=
 =?utf-8?B?Z1Q2a09waVdSVWU5VjJlMHFacjJwbVcvczZoZHJIQm5jRks4b3BxdE5kTU9D?=
 =?utf-8?B?ZTNyejlHWmFvWmQ1bjd1a2RCK1FYK3dOVmFSUll4cWw5MWhHVFU4cExNQTVp?=
 =?utf-8?B?bUhGSjlRM3NBTEtCQ1pTL0Z5MzB0cDRBRk5QVXNhOTR6d2NQMnprekhreTZl?=
 =?utf-8?B?d1Y5Nk5vbExoTG1iUU1UTUtZR1R5Rm1LOEs3cjhiOEtxNkxwSFI1WFhrUW8z?=
 =?utf-8?B?UE81WDltRVErMnRYNnlwTldrSVk1eENicnd6ZjhLZkxwRjVOM0NHRUFyUkN4?=
 =?utf-8?B?ZTduUmkxSVY3NUFOZGl4ekJDdmEwTExKNW5pbnU1T2hEd1pkcDZFR052WVJF?=
 =?utf-8?B?K01PSmM0SFJhY0FpcTBqdlBUREJqc0Y0eFpKMWlMTDhMT1FZSHVYZUUrT3E1?=
 =?utf-8?B?Mm53eXdVZlZ4YzNtTVczWmdxOStrUE92NDRwZUl3MzE3NnBqZVM1T3NNdDNk?=
 =?utf-8?B?SWVEaHBWb3RUb2NKdUNCRWU1OVN0aWJlZXBXRDBLbm82bUl4NnVkZy9HSVVw?=
 =?utf-8?B?bEpaMWZZK1BBVTZhMkJnMzk5YlU0NlNoaHpYNmZtNC90SVh5L012S2lVenF4?=
 =?utf-8?B?T1VLeG41VUNwdU52ZEtpNXBmeFVmMGZ4UXBWNzJsWTJxaVJuYXVzR2NjbE1r?=
 =?utf-8?B?YlRkMDdtYVFEVU5NTUcyYzZlMmhaRWRYeEFLakEwT1hWYWFrdkkvUXorM1RI?=
 =?utf-8?B?c1FyU0wyOG00cUpkbURNMytQbDJ5L0lTc3JJQnFTKzBiRVhSNVRsS2JGaWdD?=
 =?utf-8?B?c01ZSEI5QXZIQkFsRGJ1eWt6N2t6bEZ3cEhwMGNvQzZNdFoxMENHcENWK2xO?=
 =?utf-8?B?RE92K2NaVzhXcFk4YW5lUjhseG1rTGRJenRGVUxseVNCcmUxb0g0cVgxRUZx?=
 =?utf-8?B?dFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <151074F66FA58C41A5890A4D5A7630A4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tuha7rEVv5ZVgpsmHYuaY0c/QEozmdGRAlFG1ovww2x1vgDM3QziE25YQzU6jqpdNU4WBlFtNvniE1thGwsTqy+AnHoATU3PmP7DU5PGhMxQaaj+gQMZ9ttYe4qzsjS41oek3iFLuxa+Cc0ZmWhitqS86j7E2fRSaYR8EGDTRyIn4RB8Ht9yxeH7wbXFHwaZglBAwXgcdFsjYu/H6FZU2VQ8DuZPhezIk261I9NU20emwMGkV/mLrYD+nyhtwL5q9U5d6+maBc43Xh4DiC0zxRUDMBapi4N6FeZLA5ucjZnBI1ekYl+mMo1/qc8NjZwRJYrMfZJ6uPUplSURpQ51F//m4ikK+hj/AE4mSG2A8YljsQ86Dz1mVaPRUP9nh+8wPVHZuFTF4YqBQBGK+XqP1hlx/zQSxsfXm3bbO3cNCPjTpMaBAX2DCueMTijMhP/VWWeXs0zYlHFd4hp4P+YoZd0B/2uJUeTLPjRQPX4E4zxs90FGnpXZ4x4kaVJQ4bLr+wMN6LgBrzMV8gHoUfOhdtzpo8R6knTbbKsz8srtjAT50/W1xj4RgUKy5JLVmKohkZ6Ch8vgi7VrYA7Hue6KTau+sRXZ5yn6BXhUvcRWxNQh/SU+SOu1aIK+9DduPQL4
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f777259f-4f2d-4d26-fe85-08dc8bb1c185
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 14:04:35.1743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oujjyneHi9ebWJbEWMc5yjMevoTgRhmsX0GE5mAiuG1u4l2rTJX9o1tXdtZGLesLMcHPGxL32nexdNVvJCfRWQDzZkB9YmkANZPMga7vsJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB9010

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

