Return-Path: <linux-btrfs+bounces-5200-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8738CBC29
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 09:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C2891C21470
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 07:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029587D3F8;
	Wed, 22 May 2024 07:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="m/3lbTe6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VF2J8feQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBA73BBC9
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 07:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716363534; cv=fail; b=UrqzJy8HQLAV+jpVAamJpJsGbUMbSIE2IwGSvX9v1S95JU7aqB6TlOvCv0PGkzEQKT05S6p/JO4h7WJSjAWE3jEEZD7JgwyxcZWoT6QLpnrUrcFqSEks4Vd8ikxG5EtTW8P2ACwY8eAoeaDIeqoO/06poB9ggjWbCqxDND964xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716363534; c=relaxed/simple;
	bh=busVcGw8jhyFWOtjTqH132FkkAsKoY4pCrMOQO1p0ow=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iFAIPkx7QPwiYz3JLhgo7GganP/dpK+3V8dW5FOGLZH60WuOnq0MylhvnzCtwBchOXFza652/tsS3b6QxUpkut2aprm+tHcT/faNjDKeVixpapyX4tbdlkVGRTE1HBYMHVbPYHTDeqDNjfYfoZeHnTBNEEokePLC4Xx67EOC33Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=m/3lbTe6; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=VF2J8feQ; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716363531; x=1747899531;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=busVcGw8jhyFWOtjTqH132FkkAsKoY4pCrMOQO1p0ow=;
  b=m/3lbTe6EXvGSN2dApPDtiaECIu7Pxx5IjrbrubGcR4fuc4CoDybd15M
   IjVkSB5qaawTDLFnan/j2+ZTt6LN/AyJWcyQqiy2UwDOgsX9FXKmEZj0r
   e1cX74c5R2+rj8py1ZOAO815C+fu9UiXKhnt69QAdtHijJbHwtQAuVfIW
   HtSMZBakJdN90/HbLgdEdLTgpR0iyqIesWtnhd/O2zytDwWeZ92iRQy+/
   pYXKcni9ei34fxK79Si7AlsPSLXJd3EIX0oJfBsX8l1/I542onuw5Bclj
   WFiCTgSt1Z6CrY3libGMjIy/z43ShWmDXFRruZMTvFiYBt3ea1IfsleWN
   Q==;
X-CSE-ConnectionGUID: d/O1Z0ceRwOKjaHnXcYJEA==
X-CSE-MsgGUID: F1uo1DvAS/W9+4lIgks/UA==
X-IronPort-AV: E=Sophos;i="6.08,179,1712592000"; 
   d="scan'208";a="16993969"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 22 May 2024 15:38:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTw84zKxLMt2GXnyFybUzhpl4fYh23cUVlMw33diVDXv2T10lpoz+iQHNWgstJPtPQyWz8tPbsPsI5rUfFw0jN9zLUTqMwaI99MwdJMjSe/uqdFqVGrlaZ8HDnZVdywRfuscI02JZjXgpd6y7X68+WrSHxahBIMLsi4K+K7TcubeV+Rfy1YeLa4/OYsc0dbFUiBkmmk0vdFYgl0ug+Z+PyiiI6r83cnhrypC/NVO002MTl14T79JWrtWWg5AdfEN++wMqqZnlsKCtENzanI/PoPdFbOxwvAJY4OF65fAiepaTNsm6azdTt2SkMjSVDAcphAdENl6fdCIiipsY1kIOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=busVcGw8jhyFWOtjTqH132FkkAsKoY4pCrMOQO1p0ow=;
 b=l/YyBp9jurF3Rn5ln2st2lrjaMenUsNhLYn+6ok1gqUFqvmgrkXGPhrdk9Py+RF2kMVySIQkCXuPRXffxqjRTQTjBJStgaSLBOUbJzMtpEVODUyaWPeeiyUVcB9SU3RGEQT7KsSIolAsYqKR3BpWq5NxJBu6h040VkirYA3K2ACCABUxLxpfvovrZV5DGxdQr4anHGOfAACK5Q42Ly9DHXLBEKsBMl4jnzxBnQgCQ0FFp5W9lkDEDjUG9MUYWx3L3s0zSMiPYR43GkvAddkwiSbBIJndXW35qyPXVxgxDi0qyNUx2EpZmMYpR3wHyc3zJNdS2Fcsg2RCWIvk4KYecg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=busVcGw8jhyFWOtjTqH132FkkAsKoY4pCrMOQO1p0ow=;
 b=VF2J8feQ1TNCFvhumbm9bfoQii5vlZTv6mGkK5HbLwbOe70/8RUTaNV1wcFbIbfvEALp1NhHCo3uBQuPnPL9B1Ie5mC6RoBeu9LCBlrSXTwbHMEe0EGNbrKWzzUVykQE1j/Q1PnCZFlMdXJlX+9+OPLtW1EevWOBnM2PSg2BrNs=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CO6PR04MB7732.namprd04.prod.outlook.com (2603:10b6:303:af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 07:38:43 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%6]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 07:38:42 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 05/10] btrfs-progs: mkfs: align byte_count with
 sectorsize and zone size
Thread-Topic: [PATCH v3 05/10] btrfs-progs: mkfs: align byte_count with
 sectorsize and zone size
Thread-Index: AQHarA3OVyCLtEbdpk6dZ1SNvKiIPLGizqAAgAAC1wCAAAyQAA==
Date: Wed, 22 May 2024 07:38:42 +0000
Message-ID: <hbd52gdhh4vqyeo6b4rf6lxskgc7rzbxocesc6u6o6sbmwuoqv@hddql72fwqpd>
References: <20240522060232.3569226-1-naohiro.aota@wdc.com>
 <20240522060232.3569226-6-naohiro.aota@wdc.com>
 <d959127a-d0f0-4444-a69a-0ffa1002d5f1@gmx.com>
 <qxt22d23dea6fb3kipftgoa7v3lxegh3ynxpgz3iutnfxpxqba@chnvkin2on6k>
In-Reply-To: <qxt22d23dea6fb3kipftgoa7v3lxegh3ynxpgz3iutnfxpxqba@chnvkin2on6k>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|CO6PR04MB7732:EE_
x-ms-office365-filtering-correlation-id: 0c4c2d81-8109-4b52-2411-08dc7a32349f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?cWt1Q2RmSFRQOCtGSDhNaVZnQlRDaHVIWmpONUxCRlJZQUg3RzVUeUNwNExE?=
 =?utf-8?B?RHhHcmRnUjdOQVNESEZaL242Sm5jMlVTRFM0bDBFNnM3SlpJSDJuaHdKRTcw?=
 =?utf-8?B?WlRLMk94ZE5FZitvcW9LR0dSbmpxTHQ1Um1FWkZHem80VXNiTWdnNldUYk5l?=
 =?utf-8?B?elo4MzMxU05sSzRmTklQZ0MzcmJGcHk1eHltQ0lDL3hEYXlSbk9IbjhubkIx?=
 =?utf-8?B?bk5xSUlUay9uQmVzcytqNDdQdnJZQ3dyNmxvVFhsOU1oR1FWeVlNUFIreU1x?=
 =?utf-8?B?eTk3OEgyeE92SEVMWlJCUEg0Qlg1ZDRwdXJKeDN2dWVSTm8xZGdxK3U1bm9v?=
 =?utf-8?B?S2FDSjd6RElJN25jblE5d3g0NVptWlB1T3dWZmdCMTdhRXhrUzJQbGozRWha?=
 =?utf-8?B?RjlXVnpka0IyckNXVjNhck9HbC9CVWJtdHg4K3N6bDFOUFloZ1VQZFJQTmo4?=
 =?utf-8?B?aGs0ZGVTS2xvWmJ3UFg1OGVEem1nbVhBM1dzY2h1ek5zSm94a21DNWFJYVMw?=
 =?utf-8?B?dXZlVE9JSnVYdWJFaDh0NUdXcndSeVViSTZCWDJobHhPY2dISGZEMnZmUjll?=
 =?utf-8?B?eTZ0cEU3akRRUVJ5REdqL01Dd05VdFJDUThGNFJOTERCdVUwMGdFclRuaHJV?=
 =?utf-8?B?b1VQZEpyWlVHUlhLakxiaktOK2w1cEUwSWRSVTFUQ0J4bHUzZkM0TXVXUlZz?=
 =?utf-8?B?U3M1VVVldFpDV0tUamxlSVpiVmNieEppMStKSnBqMnZCbmg3SWFZaDVJb0N2?=
 =?utf-8?B?QzNSK290K2NBNHI2SklLd0FXdUpvQ2NSMFVoVVYxdTVFMk9Qb0k4ZEd4OGVW?=
 =?utf-8?B?bURJYVBVb0xEY05xenhpUEQwYUdOMUJDRTcrN0NYSWtSSDNxZmk2TjMrS2I3?=
 =?utf-8?B?RzRqb2tXTVpFdldjTVBDZ1V0NkdGUnBZbDE5SjErWHFMeU1DY0pYeXAxNXNV?=
 =?utf-8?B?UEVjb2RSODNyRVdYUnNZd1JGbkU4R0Q0anAzbGlDWkdXVzg2R2VNL0lFcXpz?=
 =?utf-8?B?MXYxY3VJQ29KTmZtK3V6SkhYYlpRdmlVRDY5TUxiYk9TYkR3NDA1WjErcXZX?=
 =?utf-8?B?bWlzN0Q1Vis2eENtbWc2eHZVMFFmQUdONTFQUS9INS9FdU5KajhtNHZsVlEr?=
 =?utf-8?B?Z0g0N2h1d2VPVlliV2dzbkdLcmdNek9xVE9jVDUwZmVPM2U4T3YxSFZUcmNu?=
 =?utf-8?B?VUNvRkI4YjkyY2xWZXhYUldnQmtZN1B6Z2VlZ2JrUFNkWGlWeFdvNjg3Z2Ru?=
 =?utf-8?B?d0ZTcDhPdWJUR2R6WGNRQ1gvZW80dWVNR0crWE50T0RTb0ovR2o1N2tMNU0z?=
 =?utf-8?B?cVpUTzR3b3J5Qm1qSWdHQXhDNXI0Q0VyYUFzVlhDeis5MWpNcGxlbFFhM2xv?=
 =?utf-8?B?VDlzZzVJNWY0S1UvY3IyR0FISlBxeFNmaERwRkRPWjdDT3U5NXFhb2hlM2pr?=
 =?utf-8?B?SE9VNWVKTmRpcHY4eGY2NTFHSzlXSkZnMjBCNEJ4azMxZHV1Vi8rR1VlV0Jm?=
 =?utf-8?B?WG1Sc3RrcWd4aU81bGlSZjZldFVzWFowcDVaVkwwSkw4aHRINzJyditBQ1Uy?=
 =?utf-8?B?TnZhUjJadk1CUlQrNVlLMDVXMnpoVTdVcGtheDZyelM5V0Fsb2dOT1BhZ2NJ?=
 =?utf-8?B?WFdBTXNNbmVwdmt5Uy9OR3h5Z3IzUTI3TENjZ2l2VjdVL1JkeG45WE9JLzcx?=
 =?utf-8?B?emlSeFF6aGNQVWJyZEYydGJyWnhXaVNBYmYyM3lodS9VcHVaMTF5dEdvcDNT?=
 =?utf-8?B?ZGNtbFRwS0N2SW5zMEdrVnhMQlFtYmMrbTJkK3dJcmFEaEZ4K0VkQmVjdGgw?=
 =?utf-8?B?REtLSzBzK2Vma3NSYmJQdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cGFPV1M1QlhRM3dmQjh5SndIWFhWMmFRb1FDZlF3bC9qUjRlelhzOVhwR2RZ?=
 =?utf-8?B?bGE2clB6dlB2bGdqUWhGYVZoMW5OYythTGNQUXh6T0RzSVkzWUpxRkJZb1ZT?=
 =?utf-8?B?Qm5xRk1EQ1hsMUxZdGxxMGhUeStodkpaSWREYnBPZ0IzY25qeXB6RmduVFdH?=
 =?utf-8?B?R0J3UzZqcTdNdnRoeTF0STM4ejhPZFYvSmw1bnhyUmh3dlladE5nRUthYk5j?=
 =?utf-8?B?cElHbGs1eWdYWGcxd1Y0cTVYQUxVRm1saHZyMk54YXRIWHl5RFUyN1JEenYr?=
 =?utf-8?B?dXBQSGtWcEFlUmpPdzJsYUEzcFN5SjRDY21YYnB1dGZjWlBBV1hLa2JLVU0z?=
 =?utf-8?B?b3lTWThod2xXRUFad2ttNjYwMCtTQ0FUaHFzaFRwQkwyZ0o2REZHQzRQNWRr?=
 =?utf-8?B?U3MvOW8rMHRCYmhzTGJGUkV1eUw3MWhkQk9iTDk1MGNEcHlRaUY4Y1FXeHY4?=
 =?utf-8?B?UFBvQmkzVEZpeHNreWFiR0hLYysyS3c3YXRITVRob1lURTlxeGNuSjVaaVBR?=
 =?utf-8?B?Q0ZOZ3NMc0hYQm0vMDlWd0h2blYrVWJMRmlqekhQTGFqMlk4eVRONGpUWERr?=
 =?utf-8?B?Yk5GZ0hoNWlsL1QydXl5NEV6K2ZsU0s0Zm91Ulh0S04weVgrWFN2dXRNcFE0?=
 =?utf-8?B?ekNMRlZoZm4yRDZZV1d1eGwzcG9mRGtIK3luTk9HRXBVQ3BVb1V6cUxEY0x0?=
 =?utf-8?B?dmk0bGJlSENxUXRpWWhjRElFNjFnUkxEVHZBTzFZaWJocUJoRUNia0QyTWZr?=
 =?utf-8?B?V0dOeFRqMGJGN0t2ak12S0RJandQblBzbTBPd1l0L09xd0VCajBzQ2VBa3Ar?=
 =?utf-8?B?UENmVHRDL0Z2Tk8xVSsxeVFJM2pHd1hCVUZIb3RIY1V2RlM0TzdSVzJXMVU5?=
 =?utf-8?B?RXMxSGNFWXVXNm9SSHY5UlE4TS84MXIrcGRCcGo0OHg0VC83RHhFbVBnaFhQ?=
 =?utf-8?B?b1VyYmpUbVFXYnd0V3pSSWRpZ08zeHdRM0pZRGFZYUxvL01Vb0V2QlZkbHEr?=
 =?utf-8?B?aW9QUDllZVVqQnY5dWk2dXNHa2tHOW94b2RETzJkMW1vTDVoZHFzeGNrQWVH?=
 =?utf-8?B?cXQyZ2VJOWV5UEhaNnVwVEFJNWc3Qm5iTmE1M1NyV3VSaldkZ3BMZ0pEK1dQ?=
 =?utf-8?B?YU53S29Wbis5eEZUcHI2M0xzVVBuRDlFeUJBWWN3UW1RbDUydzdIQXNHbkY3?=
 =?utf-8?B?d1VHaHhZOVFnWlVCMTRGSDhtcGJHNVIrMXNpMHg1amM1dGo0Sno0VlQ0Z2xj?=
 =?utf-8?B?OVZZMEV2V254WjZURUFlTDcrcEhPM2xWdm92anNuQUFacXRtdVNwK2FRcUVs?=
 =?utf-8?B?QjR3ZkkzM050UWhXZ09CZHEyR25XeDVwVFdna0FYU2hXa0NKUzh2SEFudDh2?=
 =?utf-8?B?L1puTWNYUnpVT095VUI0YmZ1c01kZnpzdDBmWVAwVVFZSGFHckZYWEVhK3hL?=
 =?utf-8?B?anlHbXBJaWZDbXRRVlJoS0RLRDZNMDhUSHdLak9abityT2dLeThyUnJFWitZ?=
 =?utf-8?B?aGFkYVdPRnlacEp6cE1lN0hPU3VUNFR6UE5ZSU1rUmNIMGpnR2U3NkY1N2RH?=
 =?utf-8?B?WFN5NmVacVJXZXUxV2dJQkJEZUlKeVdMTXljV0FXT3IrL0gwM2l5U3J4R205?=
 =?utf-8?B?TmtCZU95R1VIR3J5UUlydmplY3g2ZVpkZ0IvTk1Ba0ZYK1RjeDNMU2FsdnZP?=
 =?utf-8?B?djJlQ2NuS3JBMzVxWE96Z3NNYXFkN05hdWx4YkZFS1VvRXBqb1l3NVgzWXBG?=
 =?utf-8?B?VUMwdHJmblc3TkhjQzlJckQ5VzQvbndNdUVFTnpXaGxGbGdyc1l6b1RnTEtZ?=
 =?utf-8?B?RUUwRVZLc2V5NERSTDVKcjdvV0hZSlNxZWFBazc5YlFEUkY3ZFRZekllQzRH?=
 =?utf-8?B?UzRGQlJ2YTQ4ZjR5OFJEb3hxRi9VOTQxQ3djekt4Y0xXU2JCNWRzck4xK0Y1?=
 =?utf-8?B?R3JHTzB1ME9jejBiUlBSUGVhbFpqQld1MFJIOW1jQ0hPVUM5WUZZVThHaVVk?=
 =?utf-8?B?ZnNqRVpUZkpVOTJtRlY3dm84QU9tT3VaNFdYUzJNUVNJU3h1N2c0M2xpeUtt?=
 =?utf-8?B?L2lDbzdVY3hNUmg2WGlMRnA3TU1MbmM0ZFUzZG1nMzhzY3kzd25rL1c4WUlP?=
 =?utf-8?B?d2lPcmRGUnJ0bTFNcXQwTHdTazhvbjRyTHRDWkRaTGhacmlMQWc4QUdyYW9t?=
 =?utf-8?B?WHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A0DEA00678B294A8BE481DD21982525@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zeecL+o3W0CTSJG6ugiEd5O64ysIQ4N6MVcyhzQCw4O42gl2p2LtHdnAdzQustVJt/0lkWZ5/srgJYbFaIQXoucz/tSi7ipdIoe0Lev7KAdgxY4Ga70l+dnNb0ozVRsowUhM01xXQb847pasDoUfmbMLklSPxUnjcFkkxHpdKnAboohfOPSjsatn/DTba4YwKe7sd+905pZa8/U/qlgPSFsr3jggO4uF9KbN8C3U6HOPwCRPiiKmrSD/kaPNqgcCqQPvBum1sDAncxJ5Yl22OYG/eM6kqHiz+1PDeckAtw0jHPVRZ9Sch6KEskQNadXL1tJU1BKZxPpsmLmSmIzvQ9Osx4QaqIU/wMl5ta8b1nNAis9wN7AaCOA/5B7P+SwfkGH7kVBqZwJ1Sv65+pcABJXBzGZTtwwttbeuNqlY5ao3AVuZgCautX8Smd9yAbyEyv3dEW54Dw3yzkMh1CbKaWXHBdjWwh9IKs35AMQ/mYbweJMFEsr3Zut4UPhGrm4fLIf7pukdnjkEFl3AtNyHU5nS67Vo4gDqQlB7HpezNuuSCNK849bPFXKfc1mWyWDul4esKv+MiqCIfIwre6OnY40xc2CKRajujAM2XEMDyJo0tOVYpXeWtmqF2MuSJfrd
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c4c2d81-8109-4b52-2411-08dc7a32349f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 07:38:42.8973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M4lrTBzpMW3FAW6U8REZfhen1lsuSgLYskOOG5SH6HBZG35t0OIwysz0uDsQMUphWS9bUMomx/cborCNljqIUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7732

T24gV2VkLCBNYXkgMjIsIDIwMjQgYXQgMDY6NTM6NDRBTSBHTVQsIE5hb2hpcm8gQW90YSB3cm90
ZToNCj4gT24gV2VkLCBNYXkgMjIsIDIwMjQgYXQgMDQ6MTM6MzRQTSBHTVQsIFF1IFdlbnJ1byB3
cm90ZToNCj4gPiANCj4gPiANCj4gPiDlnKggMjAyNC81LzIyIDE1OjMyLCBOYW9oaXJvIEFvdGEg
5YaZ6YGTOg0KPiA+ID4gV2hpbGUgImJ5dGVfY291bnQiIGlzIGV2ZW50dWFsbHkgcm91bmRlZCBk
b3duIHRvIHNlY3RvcnNpemUgYXQgbWFrZV9idHJmcygpDQo+ID4gPiBvciBidHJmc19hZGRfdG9f
ZnNfaWQoKSwgaXQgd291bGQgYmUgYmV0dGVyIHJvdW5kIGl0IGRvd24gZmlyc3QgYW5kIGRvIHRo
ZQ0KPiA+ID4gc2l6ZSBjaGVja3Mgbm90IHRvIGNvbmZ1c2UgdGhlIHRoaW5ncy4NCj4gPiA+IA0K
PiA+ID4gQWxzbywgb24gYSB6b25lZCBkZXZpY2UsIGNyZWF0aW5nIGEgYnRyZnMgd2hvc2Ugc2l6
ZSBpcyBub3QgYWxpZ25lZCB0byB0aGUNCj4gPiA+IHpvbmUgYm91bmRhcnkgY2FuIGJlIGNvbmZ1
c2luZy4gUm91bmQgaXQgZG93biBmdXJ0aGVyIHRvIHRoZSB6b25lIGJvdW5kYXJ5Lg0KPiA+ID4g
DQo+ID4gPiBUaGUgc2l6ZSBjYWxjdWxhdGlvbiB3aXRoIGEgc291cmNlIGRpcmVjdG9yeSBpcyBh
bHNvIHR3ZWFrZWQgdG8gYmUgYWxpZ25lZC4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTog
TmFvaGlybyBBb3RhIDxuYW9oaXJvLmFvdGFAd2RjLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gICBt
a2ZzL21haW4uYyB8IDExICsrKysrKysrKy0tDQo+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA5IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9t
a2ZzL21haW4uYyBiL21rZnMvbWFpbi5jDQo+ID4gPiBpbmRleCBhNDM3ZWNjNDBjN2YuLmJhZjg4
OTg3M2I0MSAxMDA2NDQNCj4gPiA+IC0tLSBhL21rZnMvbWFpbi5jDQo+ID4gPiArKysgYi9ta2Zz
L21haW4uYw0KPiA+ID4gQEAgLTE1OTEsNiArMTU5MSwxMiBAQCBpbnQgQk9YX01BSU4obWtmcyko
aW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0KPiA+ID4gICAJbWluX2Rldl9zaXplID0gYnRyZnNfbWlu
X2Rldl9zaXplKG5vZGVzaXplLCBtaXhlZCwNCj4gPiA+ICAgCQkJCQkgIG9wdF96b25lZCA/IHpv
bmVfc2l6ZShmaWxlKSA6IDAsDQo+ID4gPiAgIAkJCQkJICBtZXRhZGF0YV9wcm9maWxlLCBkYXRh
X3Byb2ZpbGUpOw0KPiA+ID4gKwlpZiAoYnl0ZV9jb3VudCkgew0KPiA+ID4gKwkJYnl0ZV9jb3Vu
dCA9IHJvdW5kX2Rvd24oYnl0ZV9jb3VudCwgc2VjdG9yc2l6ZSk7DQo+ID4gPiArCQlpZiAob3B0
X3pvbmVkKQ0KPiA+ID4gKwkJCWJ5dGVfY291bnQgPSByb3VuZF9kb3duKGJ5dGVfY291bnQsICB6
b25lX3NpemUoZmlsZSkpOw0KPiA+ID4gKwl9DQo+ID4gPiArDQo+ID4gPiAgIAkvKg0KPiA+ID4g
ICAJICogRW5sYXJnZSB0aGUgZGVzdGluYXRpb24gZmlsZSBvciBjcmVhdGUgYSBuZXcgb25lLCB1
c2luZyB0aGUgc2l6ZQ0KPiA+ID4gICAJICogY2FsY3VsYXRlZCBmcm9tIHNvdXJjZSBkaXIuDQo+
ID4gPiBAQCAtMTYyNCwxMiArMTYzMCwxMyBAQCBpbnQgQk9YX01BSU4obWtmcykoaW50IGFyZ2Ms
IGNoYXIgKiphcmd2KQ0KPiA+ID4gICAJCSAqIE9yIHdlIHdpbGwgYWx3YXlzIHVzZSBzb3VyY2Vf
ZGlyX3NpemUgY2FsY3VsYXRlZCBmb3IgbWtmcy4NCj4gPiA+ICAgCQkgKi8NCj4gPiA+ICAgCQlp
ZiAoIWJ5dGVfY291bnQpDQo+ID4gPiAtCQkJYnl0ZV9jb3VudCA9IGRldmljZV9nZXRfcGFydGl0
aW9uX3NpemVfZmRfc3RhdChmZCwgJnN0YXRidWYpOw0KPiA+ID4gKwkJCWJ5dGVfY291bnQgPSBy
b3VuZF91cChkZXZpY2VfZ2V0X3BhcnRpdGlvbl9zaXplX2ZkX3N0YXQoZmQsICZzdGF0YnVmKSwN
Cj4gPiA+ICsJCQkJCSAgICAgIHNlY3RvcnNpemUpOw0KPiA+ID4gICAJCXNvdXJjZV9kaXJfc2l6
ZSA9IGJ0cmZzX21rZnNfc2l6ZV9kaXIoc291cmNlX2Rpciwgc2VjdG9yc2l6ZSwNCj4gPiA+ICAg
CQkJCW1pbl9kZXZfc2l6ZSwgbWV0YWRhdGFfcHJvZmlsZSwgZGF0YV9wcm9maWxlKTsNCj4gPiA+
ICAgCQlpZiAoYnl0ZV9jb3VudCA8IHNvdXJjZV9kaXJfc2l6ZSkgew0KPiA+ID4gICAJCQlpZiAo
U19JU1JFRyhzdGF0YnVmLnN0X21vZGUpKSB7DQo+ID4gPiAtCQkJCWJ5dGVfY291bnQgPSBzb3Vy
Y2VfZGlyX3NpemU7DQo+ID4gPiArCQkJCWJ5dGVfY291bnQgPSByb3VuZF91cChzb3VyY2VfZGly
X3NpemUsIHNlY3RvcnNpemUpOw0KPiA+IA0KPiA+IEkgYmVsaWV2ZSB3ZSBzaG91bGQgcm91bmQg
dXAgbm90IHJvdW5kIGRvd24sIGlmIHdlJ3JlIHVzaW5nIC0tcm9vdGRpcg0KPiA+IG9wdGlvbi4N
Cj4gPiANCj4gPiBBcyBzbWFsbGVyIHNpemUgd291bGQgb25seSBiZSBtb3JlIHBvc3NpYmxlIHRv
IGhpdCBFTk9TUEMuDQo+ID4gDQo+ID4gT3RoZXJ3aXNlIGxvb2tzIGdvb2QgdG8gbWUuDQo+IA0K
PiBUaGUgY29tbWl0IGxvZyB3YXMgdmFndWUgYWJvdXQgdGhhdCwgYnV0IGFjdHVhbGx5IHRoZSBz
b3VyY2UgZGlyDQo+IGNhbGN1bGF0aW9ucyBhcmUgcm91bmRlZCB1cCBpbiB0aGUgY29kZS4gU29y
cnkgZm9yIHRoZSBjb25mdXNpb24uDQoNCkNoZWNraW5nIHRoaXMgbGluZSBhZ2Fpbi4gSSB0aGlu
ayBidHJmc19ta2ZzX3NpemVfZGlyKCkgcmV0dXJucyBhDQoic2VjdG9yc2l6ZSIgYWxpZ25lZCBz
aXplIGluIHRoZSBmaXJzdCBwbGFjZS4gU28sIEkgdGhpbmsgSSBjYW4ganVzdCBkcm9wDQp0aGlz
IGxpbmUgZGlmZi4NCg0KPiANCj4gUmVnYXJkcywNCj4gDQo+ID4gDQo+ID4gVGhhbmtzLA0KPiA+
IFF1DQo+ID4gPiAgIAkJCX0gZWxzZSB7DQo+ID4gPiAgIAkJCQl3YXJuaW5nKA0KPiA+ID4gICAi
dGhlIHRhcmdldCBkZXZpY2UgJWxsdSAoJXMpIGlzIHNtYWxsZXIgdGhhbiB0aGUgY2FsY3VsYXRl
ZCBzb3VyY2UgZGlyZWN0b3J5IHNpemUgJWxsdSAoJXMpLCBta2ZzIG1heSBmYWlsIiw=

