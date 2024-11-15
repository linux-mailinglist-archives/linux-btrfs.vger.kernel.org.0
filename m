Return-Path: <linux-btrfs+bounces-9681-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6606A9CD6F7
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 07:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41F11F21A54
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 06:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EAA181CE1;
	Fri, 15 Nov 2024 06:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AWEU4dPr";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JbLRi1cU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4BF13AD39
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 06:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731651337; cv=fail; b=BkhrNZBZSPyDcsDry9pRww+6ZdxqDAnRC5iXxO8xVw9E+hy08ZfI2CuhKdApXgsEMYyay47/q4O2l6NdmSZ/hmGIZkcMPBFdnOe5u2lxl5e5pyynw84xXCJ63Txc/c/xIS3wtLVXsiSbYJ2UL4q8/QyhlRQm58Mf+Kj3AKP28Hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731651337; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pf2Of31AoAgRvIVpJMb69oHnyLQScgSPmKR77Es3NDu7WJwK9dzcMyOQBOptnyyIbGXyB63S/JkUMyg9GPTT1y3EfIAUe+X/17kN7NpmjlUT85bBNSTYLJVO4ZutxxiuvTElHlSZlsmjVls4VwOYGWpc30wz7YpVoYOjN35pkII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AWEU4dPr; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=JbLRi1cU; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731651335; x=1763187335;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=AWEU4dPr8tdXgHEOXv9Vg+qKB0IQl9MoAg49i/hiKUoPaf5sZ2GsF/KI
   UUM4jA4xNVKH5bSUq7DGs+CG+GGgtTJJ4guIZoTAI5FsO5NmqcRweCsnF
   kchwtnyQpyNCjgDhSUo6A/RjjXEKb9mMKvUI0BGApZvPSHP/DNPECKHK3
   xoscaZxSca4YosBUwxXcPhQHx48Wed6BlsApVk8KK0n6hVrHkWGWUXn/b
   uZb3V1KAXoPLN/CWkBY52cVknMZFAtrsYUCiHeD/PnKQEYAD+z3Id5Mca
   zCrAy2cRgPBQe8Vqx6pPUZWq+7sOMumjzN0LRIDRrXGGNBTazLq8wGIzr
   w==;
X-CSE-ConnectionGUID: fnr99Xv4TbuYnaXi4wZwlg==
X-CSE-MsgGUID: vqmPfngXSB2GE7RVgL0pkQ==
X-IronPort-AV: E=Sophos;i="6.12,155,1728921600"; 
   d="scan'208";a="30921256"
Received: from mail-centralusazlp17011031.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([40.93.13.31])
  by ob1.hgst.iphmx.com with ESMTP; 15 Nov 2024 14:15:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/2nyfN+Oveszu3/7kiDQKrPZZBMFTUGHQzKMVOmWTQCNAzve1iU1ZEM8wrAjiRWnVkEkkbBy/gCmEzXEiRgeqHdrRJndP1CjqjAoaGYNbhg2b6+HaulpwxTAlrJmvjGoO6rFgXsJ9D37Em4mTighchnX8gwbvVpSn8Tp1WPiPGs50djP/2p4tOip3WE7Iw7hJ5SL4xDh7n0Jz/xTy+aFsTG6H/JhR5ugDK6oJNu7KcZgWKGrWoOUm1XVwkJbp+hrveL+XtpEPwyoXyWqBYZx5HpdgIqD/aE/ZYF8eYRlI4hdk+zJbe6tSsD1MCqWp7vEDlgDsDv0VoeqZ4dJYsfYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=a6hwQsEotTBT0CWyw4xlis/q6mUvLfSDX/lfNZwecBtUwTIYkAT91VgWbi7e3wYzsygg/4Gxb1TG/O8MdHIvxTfVx00KoxpFyzu6u0+I7eQS1xXspUpAfm48N7uD7LPuZLfTRhPEniPiBBnve0QtZTTl7kKjMyF3wngMDzdYqWmMJaMmZN//z3Qtlfzf6KT9wF4CNhI3yWAsRM/gwtTFcehKVwHRiTDPAOHCbzPvajYEpO9wVw5DnxiD8AcSy2bBAmQHJ0ieke5hQaraqfLFiF9g8jOrVyxEPUxTvc0iapgP2wVd1ISS8/oAJqTfo7728dlgCpQr/CovDX5KOvRv3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=JbLRi1cUTd33Kp9ZbvL2mGZ87TDy0qSydS5OVJ77CZyqyj3bX2bTaXxmMVgDTOydTZ2rGHdJtWxxHw6xNccTlPKM1E2hdL9T9mdXmAwMYHIZ1Z/qqQ2DiRMoTGqdaekMciyqcXzgeZmpvwoULnPNjMRXQcDkf4fOPNXe+voWIQ0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH7PR04MB9643.namprd04.prod.outlook.com (2603:10b6:610:24e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Fri, 15 Nov
 2024 06:15:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 06:15:25 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: sysfs: advertise experimental features only if
 CONFIG_BTRFS_EXPERIMENTAL=y
Thread-Topic: [PATCH] btrfs: sysfs: advertise experimental features only if
 CONFIG_BTRFS_EXPERIMENTAL=y
Thread-Index: AQHbNrvnTL2gwrp710uR+oK+3DpXibK33gyA
Date: Fri, 15 Nov 2024 06:15:25 +0000
Message-ID: <3a112b78-a507-450c-b8d7-dec2046b3e0d@wdc.com>
References:
 <c7b550091f427a79ec5a9aa6c5ac6b5efbdb4e8f.1731605782.git.fdmanana@suse.com>
In-Reply-To:
 <c7b550091f427a79ec5a9aa6c5ac6b5efbdb4e8f.1731605782.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH7PR04MB9643:EE_
x-ms-office365-filtering-correlation-id: 5b344d22-43f3-4bd2-9701-08dd053ce539
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L2VpS0cyd1JGSEZqNkUwK1BHQThydFFOTnkwWHhKNnVVMUVEeE94VUhwN29n?=
 =?utf-8?B?WGMxKzhnQ2kxSkNxU1Q2OGlOcTBNTGdqMHlzZHI2SXpaL21vdzVJcEswZzcx?=
 =?utf-8?B?VTVES0cvY1JZRlFWbk9LNlZLdTJqVFg4MkxhaDBId3I5S2FDeUQxS0JyN2xI?=
 =?utf-8?B?S3JNejBzUzNNdFN0OWhtSFh3SU81WU1YSWc3cGIvWVJNS2V3WWhKUDhYaXhQ?=
 =?utf-8?B?T0k0Yjhmek1vMVNwdzhPaHNxVzJTdHZFcWRrZFNIRExudmN6bksrM3M4NFhp?=
 =?utf-8?B?UWlKQTNSWThkeWVpQjFuNUF0eHRRa3ZGNmI4bXV0Z1FvN0ZEM2IxVUU2TW5I?=
 =?utf-8?B?R1V4aXVWdC8wTFFYSk5Dd1VHcTFBWEZLRCtrSW1nZC8rVEZpMUt6M00ra1Yv?=
 =?utf-8?B?d1Y3T2FQQWtkMHJ0L3dWRTdZdmFnMkt1VTJMYkYxMENqeGRKb0l3SjhSMS94?=
 =?utf-8?B?cHlkZDRqWnhhQkNHb0dNVVo1bEgwU3B6b3h0K2JsK0R1clJDaSs4aHA4YlFF?=
 =?utf-8?B?SmwyZFdoV2JneWEzWmltY3VNRElNYkVzbDJlRnAyUzV5dWhteXc1WW1nQlU0?=
 =?utf-8?B?L3hUSnEzRlNhNks1YkNhYnA4SzMzWmNkblNuVjZXK0JkTHFvdk8yOHI4eUxY?=
 =?utf-8?B?TGFBSVFMSWltZDNOc2NoNThUcEpzTnRXbW9yeStwOTBmQkVubFhzU2Rzdndt?=
 =?utf-8?B?bjFwTzBTdk40TGkwL1VuVklkcWtzNW5BRlcrRWN1dzZOVXdweG5BbGRPTGMw?=
 =?utf-8?B?Ylh5WVAwRkZiZnM1SFk1dlY5Q1ZWcVptc1JtMUc4UGRKWkpWb0hRY3cwZUJN?=
 =?utf-8?B?ODFleVpWQjY4ek91b3Y5S2lhaTZlNVdYS1JsTTY1WXNKSlkrd3JrcThzM0NL?=
 =?utf-8?B?SHNGcUY0azg3ODZZOG9kQnI0SCtJdUFOWjh2RVdnVklqTEFKM0dIRVVJZEhi?=
 =?utf-8?B?WUVGUjgyQkVXa1ZORGdTb0o1UzJhNFByMmVLY1RYNlZTc3hJWVJSa3VyZ0NV?=
 =?utf-8?B?dy9KYXcyNCt1SXR6bmxieFZYN2FTUUtJQ24rM2M0dkxmdmZtYmtZT1Q5YzlI?=
 =?utf-8?B?SHVVYW9nUGNGYVdCMzZ2WW1JTVBab3RYR2psRS9wWDI0bHR0R1hKMWM4eC9H?=
 =?utf-8?B?OXVITll2b2VBRHFObW1xSzBxRFNjdGdZTFhOZlhPcHdPZEJpZWV1dmEyQVl4?=
 =?utf-8?B?UkMvQ0d0ZG9uenZNa21JTUhXR2J4cXVabVd2WlV0L3lmdE5IczNlSUxBUWxp?=
 =?utf-8?B?U0E3eDdwNWh1SUplbTBhckk4RlA0Y1hHcnlHVHVuK1F1WTNJRjJWa1dxZDk2?=
 =?utf-8?B?STFxMlU4Um5RV1R4VEFxN3ZGVldJejJRYlhOa0ZYcXpGeDZaaWhOWVpPb3dX?=
 =?utf-8?B?WStoU3ZRRUx5Sk0rK2ppMElKR3R0WnNVZ05POGFwNEdrWTZrMUwzMFFRWkJJ?=
 =?utf-8?B?eWJKOE80TFhyUFpFZ2MybjRtQ3FxdWVSQ2pQcWNvRHNTU3JINXJrUytjUElH?=
 =?utf-8?B?cGRJbGZrVWVsRHhZQkE0eURrMFcvc21jSkJEdXd2UGFQSFkvcDFsbXJBVVpa?=
 =?utf-8?B?MHJnaWtvZG1VNWdpdlRScnI2T1ZPVTVHczVzQkpqN3I0eVA3b01BRlkrS1c1?=
 =?utf-8?B?cE1vRU92YUdlNEZnSGxJY1BJWjl1TyttWVFZcEpaU3R4c1VyWFZocFdwcjRs?=
 =?utf-8?B?WTBkdDVKWTNwaE16VTVkdjRUaUJzb1NwMXNCeENzc2VrYm1sR0IzY285a2sx?=
 =?utf-8?B?QXl4aERHY1QyUFhHUG9wZkJrZFllSXl6ZmowZnJkUENnaVR4QkQ0aXQ3NVY0?=
 =?utf-8?Q?uIOdtSoYJSY366d1ZowaUA1BlsqbtTvV47fa4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WXoyZWFvdGFzV1FQeFRJOTN1Y25zQjFiRENoYnFlL2JYQzJtbThGK1lIMmFz?=
 =?utf-8?B?b3dKY0NlUEswa0YyeU16YXNTV0dFQjJicm16TnYvZ1pkQi8xSU1pNFRDUm5I?=
 =?utf-8?B?bmg2NFkySURzMkMwK2ljVnQ0dm16Q3ZjRmlpcmk2RDNrenV0WVJhdExhQ09a?=
 =?utf-8?B?S2NTdnZudllyTXVjL2RtYnlmMktLdGcxZU80RTFmRENKa2MrWnJPMm41SXYr?=
 =?utf-8?B?U0NxRkZ1ZWRXM1FVc0dmTzdxdXVWbHJMUWdST1hFb09oQVIxV24zTU1LcEhv?=
 =?utf-8?B?d0JZT2l2b3RRQ1ZRaFRyaTIyNlZiZ08wUVZhMjM5bTRreDJLWWNxSlVoSjh2?=
 =?utf-8?B?QnhxakExS3FaNUZhaXhuNjNUQTdZSmZ0bHhWRlR1dGJ6WmtwSEIzdGlFVTNr?=
 =?utf-8?B?TGcvVElkLzhZWDJpSkhBV2MxRVV4Tk9xNGZLV1QyOTBpUThYTE4rZ3F0blBH?=
 =?utf-8?B?Tkg3dzNiK0k4Q281QS9VZUpNQi9vbDlxYjNlVWVCRzVtNkNySnVFSlQ3QXh2?=
 =?utf-8?B?aHE2aytrKzJNcnVmdTUwUUdKdFhHL0JnODRrTzQrZ3B5YThXcGY1eWQ4WmJK?=
 =?utf-8?B?S0ExSWwwK215NGFBVkIyU3dVZjlqaGRyQ1Y2eU5MQk5ERk00QnpxWkJSUFZB?=
 =?utf-8?B?TDYzRFdKT2k3a1lnY2wyK2FtUFFPTlArV1pDRm1qYjBRUG03RzFIRHJrU2wv?=
 =?utf-8?B?SS9pdEZ2MDBXeW9QamVQWDlVaG5mZ0d1UExNYUtLOUt0NlBadUFWK0k2Y1dF?=
 =?utf-8?B?VlB3ODZjSjNWWklySmc4M0JjekhJNmhzaHlQN3E5R3d6YW1yQ2tVWSs0VWJQ?=
 =?utf-8?B?SDhyY3FJOTFtS3JETjBtc3VFSGQ4ZTZ1VkgyaFM4c3IvYnVSSXJQQjVMMVFU?=
 =?utf-8?B?NVBlYUtXYUMzSTBQYlNsWVpVcUlFWUVnL0l1K3d6N3pIQ2MwYUNXYXFabWNP?=
 =?utf-8?B?cjFYZ2VUWTlvZzJwazFnSVBWR2pWaUFTNlErb2xPUnQ1MnZEV3JPaWo4dFRZ?=
 =?utf-8?B?QzFOWXlnenl4WGc2QXF4bE9RbEU4Uzl0emJMdEZIWjlSMXJBallVV1dPY25a?=
 =?utf-8?B?OU9DdzFPMEVFVmJRQzVyb2ZpNHNJUEN6eGxQTzNmQnFyZkFTYXYzRm14OVVF?=
 =?utf-8?B?QTdBZUErWGg4czNGejJEVEVVd0JGVnJHODFKcUprdU5sVlZObCtQckd6Wkov?=
 =?utf-8?B?cm9SZEl4bHArc3N3STQxMnF3UWtwY3FYTm4ySkdORHNMdmlBUUd6SE02aFVO?=
 =?utf-8?B?WHMycEs3YTl1UW92dkNLS0lQOFhMRmhtMDlIVjJJME1IamZ2V0tFTWl0Rm1s?=
 =?utf-8?B?b1hlQmlHRzdhamZvY2VRckhhT212Y0JQdllDY0V5SEtOZVVMYU5PdUY2N2Fw?=
 =?utf-8?B?YU9KeUJweG5VZGhlYVdKd09UdTlRam8zd1ZNR3RGY2FVeGorcjIzU2JlWXZ6?=
 =?utf-8?B?V3Q0TVZMTnhhTzM5KzVRbFdsUEI2SXlsUHdZeWJaQXpUTzNySlg1NjViRkcz?=
 =?utf-8?B?SzNyV29Zdi9lYzE3ZmZIYTJYRHl4dmNsS0c2S21iOW12K0RWb29ZeXM3T3pG?=
 =?utf-8?B?MERQS0Y2RHhwUDdEdVBCeHA2bm9DRHNhUlJMTlNnM0dIWUptUHpQcGhMS0FQ?=
 =?utf-8?B?dnRncXJadGgxdXFlOStsVVNzbWgwTjNVMGRaS21Jd0ljcW1wRjZYcSt3Y2k2?=
 =?utf-8?B?UVRURFB3R1hqeVFaZHp0OS9leDdWd1RCbmhaZzYvL3hiaUhCMFp5eCtkd3U5?=
 =?utf-8?B?SDY4TDNUdE9wRDhkWGNDM0ozNG85c2FVWHhMNGlnODFiWTB5TmdXZ1Q5Y0x2?=
 =?utf-8?B?bHZYeXNpZEVUNHpHbTV1YUgvTlRGOUR2R2VzK1VHd0tQNklNbGtCT252QXZZ?=
 =?utf-8?B?cG1sYzZ4N3ZIY1JyN00xUXdYblQrUUxveUlNS2JOK1ZxMXByYXdXYVU0Q0NI?=
 =?utf-8?B?WXlRd1JLZEYwcG12NlVXNWNYR3pnQS9MZ0g2Z2t4OFJHdnR1Vm1OM2o2ck9V?=
 =?utf-8?B?Zy9JOE11dklicVlXK2RmTHVnZ1VkWTNyTW5KMUJTL3ArNmhLelFDRzA4WkRk?=
 =?utf-8?B?OUlRVGNSbnh2cXBiS2dmczliN0hzZTRNV0ZyS2ZBNVVDbEt3L3d4RkVkeXRP?=
 =?utf-8?B?OVlFT2ErclVuYnY4MWEzdU5TWEdIWVFvNkprcHNvSmFkclE2UmRTNmY3d1p6?=
 =?utf-8?B?c3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A316C2A43E56F24B81BB9C7EB0FEAD45@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uS1kZDTrc0bHwh/+w0OvMs8kfi8bk/O26mPYiddyCjRlOQSjStcWs8FTQXQSu3gjSjz2/P9BdnAJagrKPJzBG21FcNNTRbcWOoT2gASuNp9cFQD0T0xVhGvq/27XppMWJr18O+lYk2NzMzoy2noqBGlgOqj0v7pUlmSlxorzdRTG8wMEkn/RU91M5T8pC9u5IumdwNA1GMUDgA7hWHqkWzvx8Xy36UBEdwGfyk+OVHgypDhk8TXAhjlSzndv9WBNY+sMin9z//3QFoq7rvujRKUMjbjC2TtekSwFNukxoPHd59wKMkfYuTeYKAqtXkS9Esfv+pTzNsRyTbfgIV+CyanT1fHWf3Jf+/QOlx6EUWPxFijCtmL85EM96nYvjEBMr0o9HMTDAEddlTHP+fDojln7WNkVSJ5esvlOqlBpAOALbaqob4nSW4+iT+fmdvUywYJWZykl3nan6Lb3ax+57UbCpCOKQ1JSVRs2qnS+eDf1/v370p57Y8kJA1bzyfYYvbQyKpC4N8zn21uFG6TvEzPUrz+sd97m/jE9k3b6pI1h9HMXwuR/G1now4ITIToKKiB6sYv/eDmz//2ZZ/m4xD1CkSO/3+d0jaocMjJtX6c4mEW2GZRDZRWDTCiJ9znW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b344d22-43f3-4bd2-9701-08dd053ce539
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 06:15:25.8132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BfvIHk9RFKzcM9D4IjMGRK8ybpvlWhVxzdv88w9mSXNGjNrsp43UUn8Ge8yVEGxMqx/Abqga3CvbFxWaOXESi7SPKslveRNCsvlmUfLygMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR04MB9643

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

