Return-Path: <linux-btrfs+bounces-9506-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 498BB9C5233
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 10:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC89C1F21CD8
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 09:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F56220E03C;
	Tue, 12 Nov 2024 09:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HK65OyUx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="no8c8aIh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724F91ABEC2;
	Tue, 12 Nov 2024 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731404263; cv=fail; b=JNOWqAyAjmkZUBunHGu269SOsx++4mWrVVjPdPmUqJ8aebSpj8NEVy9ldXY0rqMV3Ypzmw32lt0HY5J4U6Z05ixZ9pYj01I4a7J4fwquPErCbl8xYiADCIhz7d9gneDr+SDIyA0HgeD9E35flvBBLpA9LPGjZRoVTTdRQkBI6Jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731404263; c=relaxed/simple;
	bh=G8SU/wYvUsE6TEMJqjD1otgIiWP4SFZ8YLSDCkZi6yo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=prHi0ixhus8+xvMMKBN2E8LUfAMUhHwP6W8XfTQIHiql9FRYLdK1CciGMYECR8S0yIDqkle3x9YjgalUWx1RWlBsTv6pRHeasiPJkdQdEZBxPS9XzohZOj8MApaejW4T+Uj8a0PJM3+kXWFuMcBNTcS/CCtFjDptKHYvrr/BsJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HK65OyUx; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=no8c8aIh; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731404261; x=1762940261;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=G8SU/wYvUsE6TEMJqjD1otgIiWP4SFZ8YLSDCkZi6yo=;
  b=HK65OyUxmJbZSuQ5LMBwp8fRej35YUT5Rd63r7C5RiF7zWaAy4xopfZy
   hDaZliI6Bs22YAzqxgGVOmYGCljAsfEkH0jZnis7+Qms37PAiMdlp5qcX
   sFhWlWTdR9Dw0xY9xnD7sy2cfTAJDeN//DGpj8TEeV51KaqiAs8cw5G4N
   Quy+m2eIjz02bUTwhJlRg1GwDtOThmhx/Ki6dkyHCD2zhEyS6cFTfjtWF
   UkdI00Cy5JtH1dBd3Cmm8F0kRBj4RdAScGsD5bDxs8dgGPsi9CZuve9z5
   mMqbIVCQOpTNHr8I3oL9pqjYOMH/DpDIUQvnC+EGbNHMIuYSyHUa8JY+T
   g==;
X-CSE-ConnectionGUID: C70AAwGdTGqYV17x8DHE8g==
X-CSE-MsgGUID: 10zkyjOnRymIi5LwDcH5Tw==
X-IronPort-AV: E=Sophos;i="6.12,147,1728921600"; 
   d="scan'208";a="31354936"
Received: from mail-westcentralusazlp17012039.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.6.39])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2024 17:37:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5hqwumQn6f+BsWNxN4T5RdSRSzAab1ZRg8PxHh2XXFOUN7SqD/FlYahEMFzqy2xtmTrx4keWfUfSeO7/qK+3Af7YMv+OT1oI+ZR/2yDrLqO0jni3dlhUsdjNL/SS7FTQelc/r7OuJk3HY10X6mqQC7/xYxG299ZuK85tcKWht5AGGY0vlZiDY5JsfQE0nx07af/qNxQ+TvUjCkIVZBLTqNiSDs3qZdHuI2bDlIRkrFP/IZzW9+rSnxLnlYpQE9KeY4EmfEa1NYZFy1vythC+2a7VUeXvxcH4zSujCMh0AYLFPKRXo25i0N/fCOfU5F2lHS0m/x0fpy+9g7R/9mWPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8SU/wYvUsE6TEMJqjD1otgIiWP4SFZ8YLSDCkZi6yo=;
 b=qkRPGu/YWr3dsoNaFpvHOB0XRzV4NE6Aqde5wljuF0VljRlPenGpNPjqzPU9TOnYyldPCJhXN32/ThASVn0ZUxl4J/pkHm3i1CcCH+Gl6EKZsIaohPC20f0HOXI6LNMyuMDcF04m39OlGCPjWur0iFszmpKm36FBSE91c243yTyL/OOsCOOdzDaXoH2Fthu69dRJIFWQVFNr1NOabFOh5Yq9vdFaF9KIEqz97SrPDzNZeq1179fkDxsOnkhFkbHSKrpL4gCU+KA47DfHTWk9sdv6IuLdI/9i1KpwVy23JTWssb8xRn41Q6otUS8eqXr7h4+qH83WySbcFljPQbptUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8SU/wYvUsE6TEMJqjD1otgIiWP4SFZ8YLSDCkZi6yo=;
 b=no8c8aIhcQ5MT9JNY8UJmtUC77ylzAKf+cHks7hahLhgLNK0aQbCkRyM9JSmUa+JLqZY1NCk96RIkH7Gv7MfU19pMvjzF8oeZowLTQ7aYx7/xLSD4D5GOY4uNskdFwxmP2gDzOmRgDnNF3m+dKTxK1uFHGUDF0m4Zhtl+Ic9leU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB7619.namprd04.prod.outlook.com (2603:10b6:303:ae::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Tue, 12 Nov
 2024 09:37:31 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 09:37:31 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Mark Harmstone <maharmstone@fb.com>, "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: add test for encoded reads
Thread-Topic: [PATCH] btrfs: add test for encoded reads
Thread-Index: AQHbNEniaq8NpBtZMEa4JGq7F4qOsLKzZGgA
Date: Tue, 12 Nov 2024 09:37:31 +0000
Message-ID: <bf3e4e63-6496-46f9-972c-c0b5c7c4de39@wdc.com>
References: <20241111145547.3214398-1-maharmstone@fb.com>
In-Reply-To: <20241111145547.3214398-1-maharmstone@fb.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB7619:EE_
x-ms-office365-filtering-correlation-id: 097002d0-5b3c-44c0-d244-08dd02fda168
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?di9rTEFyZE9Gd1dKTlhXYy9UM2dsLy92ZmRFakNIUXQ4MUp3NnQ3YXBHeXJt?=
 =?utf-8?B?YVVoZlNCemt2VmEzMG55K1ZCcEMrWUlhaW15VWpSbnhRZEFmRUlqZnZaRzFF?=
 =?utf-8?B?a052R0VhYnp1UlRtYWdFMURlOHFYMGh3SlNHODlHckpwZmNjbGdaeEt6RkxB?=
 =?utf-8?B?NVB1aEFGcW9SUUlMcWFlQ0l2OGhqMzdVWFBER2JVb01Za2U5Mk5mcWtoU3Aw?=
 =?utf-8?B?NXZ2SUVSN0lNRVBhS3psWGttQTdSYjd3OHhXcThzN1pIUzV3VzU4TkZqdXVp?=
 =?utf-8?B?b2VNK2wrU0RLUDJyWDlhSGZNYkcySFJVdlQzUjkxK1N0RktMUDcxUVRjUmJR?=
 =?utf-8?B?Y2VkUGhWOVl0T1p4WDZ5Y0tIVUdqTjB6Q2J1YUJSTnBjcVdpTk5lWUNWQU5k?=
 =?utf-8?B?S2VmdzNFZ0p6T3kvZGlTNzNzRmNCWlNUWlYwc0NMZEorc1BMRVlDenFzdUJt?=
 =?utf-8?B?blk2ZFVXa3JYQTJuUER2Z0pkbHJDWEhhR05ETEZhU2s3R0puYy9vMERudFRY?=
 =?utf-8?B?Z3pFM05LTzlBYWFtNU8wOFFJdUpZNUlQcXh2QlUyWFU2bEtIb05SMGgvSEtv?=
 =?utf-8?B?WjRtdTRWaU1KNkQ4MHI1Um92b3llKzVvdzhGN1ZzNDFJWGp1S0xwSDNmREps?=
 =?utf-8?B?d0dFM2l2M3ZKSEVpOEdSQmtxNEhNY1kzYnNPYlV3RGpWSjBKUU5wQXg3T1VW?=
 =?utf-8?B?b3JabWpoSTMrSldmUTVJSk9jOTB4dC9RSnJtVTA0KzY5SUE2N0RicCtNdDZL?=
 =?utf-8?B?aWpVdkpMTDd6WW1RN3BUKzhRK2JWUUpEdkVRWXk0a20yMmkwWDNlbThXYitn?=
 =?utf-8?B?QW9NQjFvRVdSa1V0ckcreE5RN2hSWlgyL0llK1ZYaXJJaXZ1NzVBcHZRamRT?=
 =?utf-8?B?SzBJZ2NqVkIxNnJEQlFZd0w5L09WWkE1c29uaVRtT3pVZmY1d0hZYXoxcW9j?=
 =?utf-8?B?TlpiVGtkUXZ6cGxCcHk3MFJDbDZKY2ZxL2MxSkVyUlNZS216VDc3cFZ1MkJJ?=
 =?utf-8?B?V0pGZmY1NFhIMkNCczZvOWFVd082ZHp5YllRMFZVYk5yTGJsTURvcFM2QlZY?=
 =?utf-8?B?Y2FIdlU4YjFBNzR3NmVBTUhQRmxSQTUxbDlLTkIyQ3ZzRi9uK3VaVXBvbXFx?=
 =?utf-8?B?ek5oRkg4TG9hTytScmRpWENxL1RHTlBGV0l1NERCTmZkZDFOQThIVjlTRHRt?=
 =?utf-8?B?VitxRWhVQnpxWUpJMnNtSFJjWDZ0Q1dwcE9XME91OVBUa3JyNk9YSGRkWFlV?=
 =?utf-8?B?U1UvL2tZRDk1eWxHdWJsWUt5ZW9ibStCMDNvbnM4bEw0b0gybmk2TjhxMC9P?=
 =?utf-8?B?S3N4RjlMSVdSUER0cXBxRXo2T25FRVdySUdKRzN3bEFxM1o4UUNZVnRabHhX?=
 =?utf-8?B?amo2YjNicjE3dXU4QzJLOGJ4YkpwR2ZncVVrRXpwVEM0WFZJSmhUQ1VueCtk?=
 =?utf-8?B?cUhEM3BtY1V4N29VSEQ3djNXYXdrblErOFdFWXpjNTI2STYvYm81U1BLcFBT?=
 =?utf-8?B?UGJJVkpMMlo4bmZ6L0lpOHg1SFRDL293Uis5THdpaTdpVjgvbUZFajEwUEtX?=
 =?utf-8?B?aTZDNllYM1BZMzVEREFObHBtSllnMGFlRXN5VlI5OGxscDZuUU9YRzlHeHhW?=
 =?utf-8?B?S3QwN3lLV0tWT0pocEFsdldkNlRDeHYvM0sxSUtpUXRkWUkwUzZVczNCNnQ2?=
 =?utf-8?B?Y0VWS0pPWmU4aE90UG1ITWNhbU80NnBkSmxLZUxhcU91aDBKNlZOMkg1L3dq?=
 =?utf-8?B?V1FQQnh6VWJsUTZlaTE5R1Z3WE5WVmdtWEZWOGRUMEhlZlowU2JCOE5RZkJT?=
 =?utf-8?Q?kEItTR2j/dskOFuYmqSr/SPUEn97SJGwxUL8k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TG1aZW82K1RCTjhSc1ljclJYUzdNaWtlYVVBZXN0Wm5TdXBVUTM3eW9rRjlV?=
 =?utf-8?B?TUIvWUU3Zk56Q3lpcHB2a1VpamordXhUNTVPQzI3U0w4Y3QvM1ZSRjR3SnNW?=
 =?utf-8?B?VkVRY2FtSExHdjllR2JSQi9xU0ZNQmdUNHVYNU1aR1VQUCtwYUhIdnVPeFRk?=
 =?utf-8?B?ekkyaDdqY2o3RkZzb09keE5UZ1pPb3NCK1dXb1RzOHE5NS9oTld0SGhuazk2?=
 =?utf-8?B?YnhrMEZtNjYwK1VXTUkwcWlFdlU5bzg2OWM1blNUKzdJWlVocGE1QXNaQTF6?=
 =?utf-8?B?TFVWVnA3aDRyQk43R2RJc0Q5N0RpOVZIbzlmcHpRTnlZVlh3am5ZUlN0aFVV?=
 =?utf-8?B?c21IWnFBTUdMeHlqWWdjYmdZNkpFTXorRHdCanJ2akNoU2lRSWt2cWV1b2t1?=
 =?utf-8?B?NmJPR1NmekpCRGkzY0lGZjJZdW1SMUtuU0JSejZ3QlAwaVFnVTkwS1RyYVJs?=
 =?utf-8?B?cnZZaFNRQ0RWc3RQZmVtb1d6dXNXR1dWZjVmSERGbUxkeDFqUWRHUW1QK0wy?=
 =?utf-8?B?Szg1RkxTbFB5akVxSEhCU1lpMXp6aGRONDVaZ0h3S2RJQUFBemZPWTVZVGNh?=
 =?utf-8?B?elN6SUxWMEpRWnpPTUxJS0VyQk5jWStSNCtjdmRYRmRXY0hJVHJDSmpxMFFr?=
 =?utf-8?B?bm9UV1RZVE0vYWlmSFpEN0tUT0lkb2pLR0Rpb3gxYTdTUU04UGl3UmUzcXVw?=
 =?utf-8?B?RDd2cEtJNlU4b054OGk5M3BVWkFLMDlWYlpDVncxM3FaQ1UzQzFQRHoxTSs2?=
 =?utf-8?B?empQN1VqdFJCMloydXM5dE4zb1Z2M1YvY1lnSVJaVUJnSTRDcjlNZFZGSVJa?=
 =?utf-8?B?TFlmcGZJMGw5TGF1V2FheVVRaHYyM3N1dHZSUnRMNTJWc3RsTzY0cmR2Zzdh?=
 =?utf-8?B?TFFsbGdRUjhCc3VXQ1BTWmZkRldLRHpEcWw1dWdvaUxlSnl3cnBEM2dhZ01w?=
 =?utf-8?B?enU4bjhteG50TDQrb3VJb1RwMktnKzBTVm9ISFpoSjhNN0plcldUdHNvYjJ6?=
 =?utf-8?B?ejEzU0lsZ2lLYmlXaWtGcnpma2VJREZJYWx0d1l2Wmw4b2xUZmJFUHNlYis4?=
 =?utf-8?B?TzNkeXg2NnhqZU5kR2tFbkVJV0ZOVm1aU3hVTWpOOXRXekpoNnNmb0VCbk5a?=
 =?utf-8?B?RlJrZm1CWnA5MEFoZ0ZVU1VvcEhEb1E0Tjd6ejZGRlM3ZlEwRzVxSnJPaU5Y?=
 =?utf-8?B?dkJ0VFJRamh2Nm5rMS9BRGpodkdmaUJvQWhHcDhsM2lzczJIMXc1djY0TXBx?=
 =?utf-8?B?N09TNDUwdmlpNXZVTEZEMS9SL3M0dzQ1cnJFSkVsVndrQnRNK3AvdUk3TUds?=
 =?utf-8?B?YkZXaEhWK0J3eUhIaW9jblZIaHVITFVpU2xIaDZOQUFCSm9waWQ1aDRHS1pT?=
 =?utf-8?B?T1BhNmEwOXJadERKaWl5VUYveUVTa3pZWTdVT040WFp6clJRSXNHL3Q2bzBq?=
 =?utf-8?B?NmZFNmxqdjc5SE1OSmIrWnZua1NFay9YOGtUN0p2ZUFmdDVjKy91MjhucXdQ?=
 =?utf-8?B?Uk1CeHgxSHM3ekhtbTRUVitPc2hZbkxQVnRzaWtiS1BsWXAwYldaejdZSEdK?=
 =?utf-8?B?bkdjS3QrK0FyMEFod0JUWDQ4VHNpVmJaNFA2R0NjWFMrOWNPU2g5MXk4UkUx?=
 =?utf-8?B?UVZqZHBiWkJqK2Z0aEFQS3pMZklwSzliOTRWUjdDYVRVVkx0bTQzcGVpUHJH?=
 =?utf-8?B?RmRoZmxBa3I5WXNscUhsMnRnWmV3aFJBekJRQ0hkaHNvR0dWY3lZM0xLanoz?=
 =?utf-8?B?OURFZGRGMkw5R3VtMkEwanZXY3RiR1R1RUp1czRSZmZJbytkTnZreCtGNWlw?=
 =?utf-8?B?bDNMUFRaTDEzcXVHd1Nta0xMS2RuMkNrTWN1Qi90SUJ2RDVsTGk4K1d3ZzMz?=
 =?utf-8?B?eWZ3NmlWVHlrVkVRdjVmWjZZVGhNZ2Q1RkJtQ2drQVFxb2ltNEVycG9rNkNa?=
 =?utf-8?B?WmZES3dFdG83dHY4cmlkWUFmbXladGJmZWlJZzJwUnlNZjdoOU5wNXJiSkRV?=
 =?utf-8?B?Q1pzaCtGVVlycGE4OVN2L2tNdnMra2RTRW5SQ2c0b1JSMCs4ZnNvZTlHMEYw?=
 =?utf-8?B?SXY2UGpDNVhLM1FFU3p3MjdPSy9yalJHaVpuYmtrN3BOeU5HZ2E3bXliUmFQ?=
 =?utf-8?B?QmUrZE5lOVFTWHd5SnVRRWJLVy81eGEydWovYThUQ2pGNnZGTmYxamU2Um52?=
 =?utf-8?B?aEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB93B8D1AB4EA54287B0E0E0ACD3F45C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vHx3PXSYNOycOl6OQtqsH8Tp0+W9JrZFPL9CexP262n2gZIhP4TCeVghyB5mVw0ZJSLnZ1yBDhc5jxuDg9yExDqbOldkjVT4LHWUsyDx3pK0+hdbqCw6QZA4EZI6/P405QfADXbxHhtp8n6j+xV0IC46nwhYolEH5/CEkdo/cAzCSU0FflSBvsSkWjH+UYkR6Kr3EEdgI1oyjTU/J2Ruv2necXYuKiDS2L2mYyZbAEadUq4asCuBjQ/uKJKYRuuUXg8xXGDf6JHhuIxgKJ56gL3KEGVtsrzIfa9HqRn9QGBpwXkqZTr8z5fzMN1Mujq4nhbT+wv34wtDGxBX8My6jVIl1cQdY/76jCy9CWVsBTvEctBE9onenC8kCfnUE7+lv+GpyiIKA/xNlW6oBIbHZxL0+/dGZxpxrgZBxN82ZpbvxH6BdGZv6kq8FhXO0ngrUC2zh96+lsVbFiJoVdHQrpQagvSNj0ou5MTEtuv+Mcb9KUfvBas6KZ+VP0a7xzUOIl4niiPzHhspjyntRrgGEUbn3WJ0mXEqQ7aBOWTlIc05FWnIzf6wjGbs1jBdNzMFsUILmDqXjras35hS3OEMtFvHHTCdyIIMyvxvDmrCFeBPc51fsLV6CJaKpxVSAX84
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 097002d0-5b3c-44c0-d244-08dd02fda168
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 09:37:31.4116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z6FecioxdAJzt7k1X0e/kjPZLkKGABW9OMSwvB0sbgjTQid1rxMcIH2Yb8e/ouFOhdL0gbcYoq3JxXwaurElxwXqy2aqCNTyUt7daOGbt7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7619

T24gMTEuMTEuMjQgMTU6NTYsIE1hcmsgSGFybXN0b25lIHdyb3RlOg0KPiBBZGQgYnRyZnMvMzMz
IGFuZCBpdHMgaGVscGVyIHByb2dyYW1zIGJ0cmZzX2VuY29kZWRfcmVhZCBhbmQNCj4gYnRyZnNf
ZW5jb2RlZF93cml0ZSwgaW4gb3JkZXIgdG8gdGVzdCBlbmNvZGVkIHJlYWRzLg0KPiANCj4gV2Ug
dXNlIHRoZSBCVFJGU19JT0NfRU5DT0RFRF9XUklURSBpb2N0bCB0byB3cml0ZSByYW5kb20gZGF0
YSBpbnRvIGENCj4gY29tcHJlc3NlZCBleHRlbnQsIHRoZW4gdXNlIHRoZSBCVFJGU19JT0NfRU5D
T0RFRF9SRUFEIGlvY3RsIHRvIGNoZWNrDQo+IHRoYXQgaXQgbWF0Y2hlcyB3aGF0IHdlJ3ZlIHdy
aXR0ZW4uIElmIHRoZSBuZXcgaW9fdXJpbmcgaW50ZXJmYWNlIGZvcg0KPiBlbmNvZGVkIHJlYWRz
IGlzIHN1cHBvcnRlZCwgd2UgYWxzbyBjaGVjayB0aGF0IHRoYXQgbWF0Y2hlcyB0aGUgaW9jdGwu
DQo+IA0KPiBOb3RlIHRoYXQgd2hhdCB3ZSB3cml0ZSBpc24ndCB2YWxpZCBjb21wcmVzc2VkIGRh
dGEsIHNvIGFueSBub24tZW5jb2RlZA0KPiByZWFkcyBvbiB0aGVzZSBmaWxlcyB3aWxsIGZhaWwu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJrIEhhcm1zdG9uZSA8bWFoYXJtc3RvbmVAZmIuY29t
Pg0KPiAtLS0NCj4gICAuZ2l0aWdub3JlICAgICAgICAgICAgICAgIHwgICAyICsNCj4gICBzcmMv
TWFrZWZpbGUgICAgICAgICAgICAgIHwgICAzICstDQo+ICAgc3JjL2J0cmZzX2VuY29kZWRfcmVh
ZC5jICB8IDE3NSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gICBzcmMvYnRyZnNf
ZW5jb2RlZF93cml0ZS5jIHwgMjA2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+ICAgdGVzdHMvYnRyZnMvMzMzICAgICAgICAgICB8IDIyMCArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPiAgIHRlc3RzL2J0cmZzLzMzMy5vdXQgICAgICAgfCAgIDIg
Kw0KPiAgIDYgZmlsZXMgY2hhbmdlZCwgNjA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgc3JjL2J0cmZzX2VuY29kZWRfcmVhZC5jDQo+ICAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IHNyYy9idHJmc19lbmNvZGVkX3dyaXRlLmMNCj4gICBjcmVhdGUgbW9k
ZSAxMDA3NTUgdGVzdHMvYnRyZnMvMzMzDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL2J0
cmZzLzMzMy5vdXQNCj4gDQo+IGRpZmYgLS1naXQgYS8uZ2l0aWdub3JlIGIvLmdpdGlnbm9yZQ0K
PiBpbmRleCBmMTYxNzNkOS4uZWZkNDc3NzMgMTAwNjQ0DQo+IC0tLSBhLy5naXRpZ25vcmUNCj4g
KysrIGIvLmdpdGlnbm9yZQ0KPiBAQCAtNjIsNiArNjIsOCBAQCB0YWdzDQo+ICAgL3NyYy9hdHRy
X3JlcGxhY2VfdGVzdA0KPiAgIC9zcmMvYXR0ci1saXN0LWJ5LWhhbmRsZS1jdXJzb3ItdGVzdA0K
PiAgIC9zcmMvYnN0YXQNCj4gKy9zcmMvYnRyZnNfZW5jb2RlZF9yZWFkDQo+ICsvc3JjL2J0cmZz
X2VuY29kZWRfd3JpdGUNCj4gICAvc3JjL2J1bGtzdGF0X251bGxfb2NvdW50DQo+ICAgL3NyYy9i
dWxrc3RhdF91bmxpbmtfdGVzdA0KPiAgIC9zcmMvYnVsa3N0YXRfdW5saW5rX3Rlc3RfbW9kaWZp
ZWQNCj4gZGlmZiAtLWdpdCBhL3NyYy9NYWtlZmlsZSBiL3NyYy9NYWtlZmlsZQ0KPiBpbmRleCBh
MDM5NjMzMi4uYjQyYjgxNDcgMTAwNjQ0DQo+IC0tLSBhL3NyYy9NYWtlZmlsZQ0KPiArKysgYi9z
cmMvTWFrZWZpbGUNCj4gQEAgLTM0LDcgKzM0LDggQEAgTElOVVhfVEFSR0VUUyA9IHhmc2N0bCBi
c3RhdCB0X210YWIgZ2V0ZGV2aWNlc2l6ZSBwcmVhbGxvX3J3X3BhdHRlcm5fcmVhZGVyIFwNCj4g
ICAJYXR0cl9yZXBsYWNlX3Rlc3Qgc3dhcG9uIG1rc3dhcCB0X2F0dHJfY29ycnVwdGlvbiB0X29w
ZW5fdG1wZmlsZXMgXA0KPiAgIAlmc2NyeXB0LWNyeXB0LXV0aWwgYnVsa3N0YXRfbnVsbF9vY291
bnQgc3BsaWNlLXRlc3QgY2hwcm9qaWRfZmFpbCBcDQo+ICAgCWRldGFjaGVkX21vdW50c19wcm9w
YWdhdGlvbiBleHQ0X3Jlc2l6ZSB0X3JlYWRkaXJfMyBzcGxpY2UycGlwZSBcDQo+IC0JdXVpZF9p
b2N0bCB0X3NuYXBzaG90X2RlbGV0ZWRfc3Vidm9sdW1lIGZpZW1hcC1mYXVsdCBtaW5fZGlvX2Fs
aWdubWVudA0KPiArCXV1aWRfaW9jdGwgdF9zbmFwc2hvdF9kZWxldGVkX3N1YnZvbHVtZSBmaWVt
YXAtZmF1bHQgbWluX2Rpb19hbGlnbm1lbnQgXA0KPiArCWJ0cmZzX2VuY29kZWRfcmVhZCBidHJm
c19lbmNvZGVkX3dyaXRlDQo+ICAgDQo+ICAgRVhUUkFfRVhFQ1MgPSBkbWVycm9yIGZpbGwyYXR0
ciBmaWxsMmZzIGZpbGwyZnNfY2hlY2sgc2NhbGVyZWFkLnNoIFwNCj4gICAJICAgICAgYnRyZnNf
Y3JjMzJjX2ZvcmdlZF9uYW1lLnB5IHBvcGRpci5wbCBwb3BhdHRyLnB5IFwNCj4gZGlmZiAtLWdp
dCBhL3NyYy9idHJmc19lbmNvZGVkX3JlYWQuYyBiL3NyYy9idHJmc19lbmNvZGVkX3JlYWQuYw0K
PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMC4uYTUwODJmNzANCj4gLS0t
IC9kZXYvbnVsbA0KPiArKysgYi9zcmMvYnRyZnNfZW5jb2RlZF9yZWFkLmMNCj4gQEAgLTAsMCAr
MSwxNzUgQEANCj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ICsvLyBD
b3B5cmlnaHQgKGMpIE1ldGEgUGxhdGZvcm1zLCBJbmMuIGFuZCBhZmZpbGlhdGVzLg0KPiArDQo+
ICsjaW5jbHVkZSA8c3RkaW8uaD4NCj4gKyNpbmNsdWRlIDxzdGRsaWIuaD4NCj4gKyNpbmNsdWRl
IDxzdHJpbmcuaD4NCj4gKyNpbmNsdWRlIDxlcnJuby5oPg0KPiArI2luY2x1ZGUgPGZjbnRsLmg+
DQo+ICsjaW5jbHVkZSA8dW5pc3RkLmg+DQo+ICsjaW5jbHVkZSA8c3lzL3Vpby5oPg0KPiArI2lu
Y2x1ZGUgPHN5cy9pb2N0bC5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L2J0cmZzLmg+DQoNCkZvciB0
aGlzIEkgbmVlZA0KDQorI2luY2x1ZGUgPGxpbnV4L2lvX3VyaW5nLmg+DQoNCm90aGVyd2lzZSBJ
IGdldDoNCg0KICAgICBbQ0NdICAgIGJ0cmZzX2VuY29kZWRfcmVhZA0KL2Jpbi9zaCAuLi9saWJ0
b29sIC0tcXVpZXQgLS10YWc9Q0MgLS1tb2RlPWxpbmsgL3Vzci9iaW4vZ2NjLTEzIA0KYnRyZnNf
ZW5jb2RlZF9yZWFkLmMgLW8gYnRyZnNfZW5jb2RlZF9yZWFkIC1nIC1PMiAtZyAtTzIgLURERUJV
RyANCi1JLi4vaW5jbHVkZSAtRFZFUlNJT049XCIxLjEuMVwiIC1EX0dOVV9TT1VSQ0UgLURfRklM
RV9PRkZTRVRfQklUUz02NCANCi1mdW5zaWduZWQtY2hhciAtZm5vLXN0cmljdC1hbGlhc2luZyAt
V2FsbCAtREhBVkVfRkFMTE9DQVRFIA0KLURORUVEX0lOVEVSTkFMX1hGU19JT0NfRVhDSEFOR0Vf
UkFOR0UgICAtbGhhbmRsZSAtbGFjbCAtbHB0aHJlYWQgLWxydCANCi1sdXVpZCAtbGdkYm1fY29t
cGF0IC1sZ2RibSAtbGFpbw0KICAtbHVyaW5nICAgLi4vbGliL2xpYnRlc3QubGENCmJ0cmZzX2Vu
Y29kZWRfcmVhZC5jOiBJbiBmdW5jdGlvbiAnZW5jb2RlZF9yZWFkX2lvX3VyaW5nJzoNCmJ0cmZz
X2VuY29kZWRfcmVhZC5jOjEwMDoyNjogZXJyb3I6ICdJT1JJTkdfT1BfVVJJTkdfQ01EJyB1bmRl
Y2xhcmVkIA0KKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKTsgZGlkIHlvdSBtZWFuICdJT1JJ
TkdfT1BfTElOS0FUJz8NCiAgIDEwMCB8ICAgICAgICAgaW9fdXJpbmdfcHJlcF9ydyhJT1JJTkdf
T1BfVVJJTkdfQ01ELCBzcWUsIGZkLCAmZW5jLCANCnNpemVvZihlbmMpLCAwKTsNCiAgICAgICB8
ICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+DQogICAgICAgfCAg
ICAgICAgICAgICAgICAgICAgICAgICAgSU9SSU5HX09QX0xJTktBVA0KYnRyZnNfZW5jb2RlZF9y
ZWFkLmM6MTAwOjI2OiBub3RlOiBlYWNoIHVuZGVjbGFyZWQgaWRlbnRpZmllciBpcyANCnJlcG9y
dGVkIG9ubHkgb25jZSBmb3IgZWFjaCBmdW5jdGlvbiBpdCBhcHBlYXJzIGluDQpidHJmc19lbmNv
ZGVkX3JlYWQuYzoxMDE6MTI6IGVycm9yOiAnc3RydWN0IGlvX3VyaW5nX3NxZScgaGFzIG5vIG1l
bWJlciANCm5hbWVkICdjbWRfb3AnDQogICAxMDEgfCAgICAgICAgIHNxZS0+Y21kX29wID0gQlRS
RlNfSU9DX0VOQ09ERURfUkVBRDsNCiAgICAgICB8ICAgICAgICAgICAgXn4NCg0KZHVyaW5nIGNv
bXBpbGF0aW9uLg0KDQpOb3Qgc3VyZSBpZiBhIC4vY29uZmlndXJlIG1hY3JvIHRoaW5neSBzaG91
bGQvd291bGQgc29sdmUgdGhpcy4NCg0K

