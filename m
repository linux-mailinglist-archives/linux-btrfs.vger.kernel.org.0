Return-Path: <linux-btrfs+bounces-9056-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC15A9A9A7E
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 09:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CC101F233BF
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 07:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF3E149E13;
	Tue, 22 Oct 2024 07:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pr/cpLut";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="j1Ki7NBx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0D81487DC
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2024 07:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729580860; cv=fail; b=mgOOjhvdcUYuWubykTDZZoJoCOxj976ixGyms/YIEgKXvwiK9QOQpRs9WT9mh31mvZCqlEdTR6W6p9TxbQg+KT5NZJYoiFZbpWkjy7tnFr6kFYd0QS5BPWJIgUGaltKCsGFulGlQiXLII3sVQof/4xx+vlblvj7oIIl3CthJFq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729580860; c=relaxed/simple;
	bh=YN+6hO5FebKbVIuKb1aOfnnGqgAhC/s6uIw4g3mt6bY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lGAwGOoqgsJKwVG7JESLpLH/hqK2vqOyXrrnN/6qumOvyx2DYpfHDt/fAwvpX2WiN0747POo7vS65D9rCOpjD1nvitSoR8T27LEHyMybSQMYnwz9HxqxrSzNMacMYJZTecYWBxuFw9U/QD9OHVHskABMNaKy/AbfaZoMz33gioc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=pr/cpLut; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=j1Ki7NBx; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729580858; x=1761116858;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YN+6hO5FebKbVIuKb1aOfnnGqgAhC/s6uIw4g3mt6bY=;
  b=pr/cpLutyNPbSOg+o3b4HEcFUCOB/wYR/KJzIoPvmSMXlhwPY6N+DE3L
   tC+baxe90ZYSpibKWh3JPKWnE1W4cbrL/WiDlDfbUtAXwNBrNcS8+JEKc
   Ha4a6P1ieqTlGuPS6LdrM4FXbO+cI3NN7O9bHkhcoOzhL+/atV9Z1CJZl
   //4Gwp22HCdApJzTRDkcI0lXmeDKlKpD3tOjh89Ek05VsunoBpeV44cnF
   LqM3XzWpnREPg95cvtsVF2mzUCoh3p0WL/Fi1zKXhWV3D25s8Z96bmvsx
   XAjY1jMiNGHvxYbHyQeUTF86h5N8Fhtzbg/5FBoDcnGNrVNuud4uXTg8Y
   Q==;
X-CSE-ConnectionGUID: hNKT4nA4QpqSwu6Kcy0L/A==
X-CSE-MsgGUID: HlARqaNqQfCwQAlFtkISEQ==
X-IronPort-AV: E=Sophos;i="6.11,222,1725292800"; 
   d="scan'208";a="30531095"
Received: from mail-westcentralusazlp17011029.outbound.protection.outlook.com (HELO CY4PR02CU008.outbound.protection.outlook.com) ([40.93.6.29])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2024 15:07:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OuCF6W+GG/Qp/LDLq7BBycako/0WrlYgQaXcIbuah7nTw2dZL0UoG8RQ8VUTSI0nQdAsw6uM4lwZbXM4UqEynWI/uUjAySqD11ZNiIJggHFbEHa4yFIBJvyg2XpEshyjrwY1AHhW3O0wMQlEJAjz+btdYjEjB51AenNsvx+uyNnhgIw6OMXoLEpl6mD0k0MJ6J/r6FMfTiycrEZyAAbvMoDOQYnaYmZAT5aXyq1TDuNfeUDt+so8Z+W+L/5USLrFAXFUYSZk5UsMCxyjaJIzy1vViatDAQp+kSqTHlhoW/OtKkFprpyxivxA1CBz2JezB7qZ6mX17CmZCGGeICAaTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YN+6hO5FebKbVIuKb1aOfnnGqgAhC/s6uIw4g3mt6bY=;
 b=G2mWQNi5p6WHuUSn/NyJksrTebubgoPji1oFfBKX0CoIZuieeqIdcHLM5iJnL8v0KBzGbEr/8ag9QVnlV3oNfZhnW+8P2p/W4XAOUSHe1CnQ8k1ob02/kFIbEiwbmQH9e8virtLUW6DHwrWskls0fT1dacd/JBosSBeHzP8qNcC5+V2bDSHO9OlcCGbmdT4BI2b610Y2CEMTgHZz3p0QuGaj8F7f2ckKr5jCyVQESM/vuLe+h7TilAh+63TaPJSpBjsqShHiESntQpSVHQoY1PI54uSCq1DgoQVVU/wpxrYozBmQ7gj2ZFPlaywS1Nic5Px/XE6RtRpmgEGahfASug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YN+6hO5FebKbVIuKb1aOfnnGqgAhC/s6uIw4g3mt6bY=;
 b=j1Ki7NBxOxIICbinIohkj+5A7nLsjEzGObbHH/uJ/dp45UlETquIr9nOqVMDTssvcnQ6gN8UcvMe30MIc4SYGHGOmT14i7gIQhvDNSgx2O8EYHBpAMfUvhuRLojO27e657NaLCyxlzKaJlvqpd5QknRIxd4Ux8YmLuLbfLv81AQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA2PR04MB7593.namprd04.prod.outlook.com (2603:10b6:806:14b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 07:07:35 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 07:07:35 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "waxhead@dirtcellar.net" <waxhead@dirtcellar.net>, Anand Jain
	<anand.jain@oracle.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: "dsterba@suse.com" <dsterba@suse.com>, WenRuo Qu <wqu@suse.com>,
	"hrx@bupt.moe" <hrx@bupt.moe>
Subject: Re: [PATCH v2 0/3] raid1 balancing methods
Thread-Topic: [PATCH v2 0/3] raid1 balancing methods
Thread-Index: AQHbG4hRQKVUvYnBy0+DcIXEy+G/rrKRVP8AgAEWEwA=
Date: Tue, 22 Oct 2024 07:07:35 +0000
Message-ID: <ebfc50e3-18b6-44ca-b0a6-cb3c438f9a59@wdc.com>
References: <cover.1728608421.git.anand.jain@oracle.com>
 <09a3eabc-5e03-3ec9-d867-f86d4b40e2da@dirtcellar.net>
In-Reply-To: <09a3eabc-5e03-3ec9-d867-f86d4b40e2da@dirtcellar.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA2PR04MB7593:EE_
x-ms-office365-filtering-correlation-id: 5774ee23-b72d-45ee-f20c-08dcf26834a5
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RHdvdDc5TEN2MkhQMVNtWnM0ZkEwZ1hVREtESXZuSnpxblI4Q050UklXcWN6?=
 =?utf-8?B?alM4dHZSem9NY0xnMHpIUjdUOG9wSlJiaDBYVU9ZSGxlOGRiaWo4TFQ1Z1dM?=
 =?utf-8?B?dk1xQ0tOYTBhTGs4aklOTkhvZGpxYjlXbEJOekJCbkRYOWhoZDJyQWp0L0d0?=
 =?utf-8?B?MHVMdmZUYXhhSm1VQTNHY3plWkVFNWsvM2VtQ3QyZkJwNmlqMXAxakEwWCtH?=
 =?utf-8?B?UzZISm9LVFViQlhhc3R6TDBaTm9odlFoL3RacTZSNERCbkhrWW5WUmNiV2Uw?=
 =?utf-8?B?ZDBPbUwzSVVzZDJOR0tRZEpZR1lwamdyWWdDNDVMRml6NUR6L2tYZk95VDcx?=
 =?utf-8?B?akJsd1VPeFRNckIxUDRBaUhZOWVxWHFjc3M0dHJmSktZWWZpbkY3MjFES0ph?=
 =?utf-8?B?MFp2YStwWkQ1L2duSGY0UkFXTkNwM0pIRjd1SExIa2owYVl3enhQZ1dXOFdi?=
 =?utf-8?B?bGRBQ0J3Q01WdkNXMEdrYTk0bkNRZW93ak5TaXlYTFRIZldnNkZJLzFYVEk4?=
 =?utf-8?B?MTNiSkRybXpFV1M2NzJkL3ZnekQ0eFQxRmZoSFR1OHVaZ2puZXNDb1dtdmhp?=
 =?utf-8?B?VkVJeFBMY0NEKzRWOG9uL2s2a0pVUCtCWEp0TU1JUHdON1lDbTFIUDZxVUVj?=
 =?utf-8?B?WFA1TDFoRFpYYXlZZERaWlp3dHlqb0VOT0lGc3U1ZlRtdEJ6ZkYvUDlEVXFx?=
 =?utf-8?B?UDd4S0hDY1ZhMjBsQ1JRT0VIL2tuRVc3VUVnQUowRTJiT1dFclBIaFo4ZkM5?=
 =?utf-8?B?T0ovdlRsT1hRY0lZUzM4dWI3N0ZiZmtMcHhuMllaQUkwUmo3VTNqbEdoSFVi?=
 =?utf-8?B?VlZnS1Fsc0QvOURRZjBQZ3VhcE16REhyOXBtMHh5M0xIVWpsa1RPMFV2ZVRa?=
 =?utf-8?B?eHJoMXQxYmdOTko1allWTDlnVjErK0ZMN0FmdHZwb3YvREVuWWhmQnNPZ0tU?=
 =?utf-8?B?WVhlb3B0L3VSbENjd3pKem5vWURWclNjenQxRWZ0Z1Y0eW9MYUxWWURYT2Jn?=
 =?utf-8?B?VFRkQkxFdDhVaGoyWXQwSlQveDdDbDA3QVRUMjE0b1hzZGhNMThFVllLOUdm?=
 =?utf-8?B?VFFkRlFNcXMxcGxLVkNVZXhEaDF5TjZPc0ZLNzlWNlhXRW82dEpZWlJoZjFO?=
 =?utf-8?B?UzlVc0w1M0NSTjZjZ1Fwek1XcXJzaWljUmFuU3B2TklvN2Y2TGRiQjU3NHFI?=
 =?utf-8?B?bWJiait5aFFmYUdNYTV0cHNibTJLK0hiZEIwSDQvVjNCMjJ6NzFSVlZMVkQr?=
 =?utf-8?B?aXljUUVndVBudlRRM2xuSXo1bHA1a040U0pxbkpVaWZzc3ppMGU4S3dSaWVP?=
 =?utf-8?B?QSsrOVZ0SW8zeDdyVE5BL1FhRjREYllScC81Zy81bHhuTmx3LzM3RFJCWWkr?=
 =?utf-8?B?UHg3N3NtODJGaFQ3NVpHNmNtV1EwVW1EcUhZRDJjcVRiTmtzQ2RhcTRlN1NP?=
 =?utf-8?B?QjNUQW16bjU0QmxrWVBNRjZJY3U3NmZzSzhCWmNFYjhjNGQyT0ZOYzAvYTA5?=
 =?utf-8?B?eXd6WnF3SjM2Qks4Lzc5ZEdtcWNKLzVHOXVSRGw4ZXZNNFJUWmd3RUZKVzNr?=
 =?utf-8?B?TUx1aVJlM09kaTlMQitOYkN5SFM1NUR5T0hsOU1mUDM5U1pibThDeS9XcExE?=
 =?utf-8?B?ajduZWZoZ05uR080KzI5NGdLdGFhdnhGMUYzZXhqZkJuMWdyYVRHcmZBamNP?=
 =?utf-8?B?QjQzaEpJWVlvNjRESnI0K3RPbG00R3BlWHlFaW1IRUdmaTRsSGRxdGZxWG45?=
 =?utf-8?B?KzlzN0xHVTExWWUxUkZwU3pJMVdUYlQxelNjUWVzUXBoTXNsNzhPeEpLNENX?=
 =?utf-8?Q?mCJjmSQ2LlCdu2e5IrI2t062YDha21/0NXL+M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TXR1VkFHamIrcHJLRC9WUzhDSlowQkJaM040NDlpM3JYYkM0dWV3QW4rZ1h3?=
 =?utf-8?B?ckhZdnBKZ0dLNzdOejVkZDdhbUQzeHhYUFEvTFVNRDlmYjJldmY3QTFWQWtH?=
 =?utf-8?B?cHhiWENPTTFGdFR6QktMSkw3c0taRWdza2tjODlvbWtheXgzYmVnZGM4VVpG?=
 =?utf-8?B?ajF3enVpa2lIbHdOb1VlRTVGUVEzdDMrYS9GdnRnVW5mY1pFZTRDMVZOaFIv?=
 =?utf-8?B?NTY1OWVzRzNIdmhyTUJMQkNqNjZoaWhkcXhkL2NWdk5YMHlIUC8ycWYyUFNQ?=
 =?utf-8?B?bmtzS0xwK2tXRFNyU3lmMFZka0RUZ2ZwVjZueDQ1dkl6RWZUT3Z3ZjJYS05q?=
 =?utf-8?B?eXN4T1JKdEluUWVnb0gvSURLVHZmbnpNdE10bGtUNmszNUEwQzBON2NqSUtU?=
 =?utf-8?B?alQyZkFaeDRNbmlUNFk3MWpma3FQU0hQYjM3NDl0SnVUT2NMbEJaM0oyNHZI?=
 =?utf-8?B?UllZSUFMN1hWYzlRMUVWNnlZM1pmS3ltMzhTbVpkYTdFOXZ0NXNOTGJXa1pl?=
 =?utf-8?B?WGtZdlY3ZkE2U1FNTjY0Q25uc3Boc0R4T29ZY2MzeXZ4ekp2WGFDRi9TVVo2?=
 =?utf-8?B?cjN3bjNoNGpLcU1qbXJxcmN5T1N2UUhyZ2xGMHNLUzBjRWgrNEVEZzBsajVu?=
 =?utf-8?B?Q3VDK3A5cENzc3A5QVRCMXY4Y1BmMVhMVHNnOFcwNlNGL3dwSG9vYmpvRlBI?=
 =?utf-8?B?djRPWi90Tk5XN3F1Q01ncHZNOVRydzB6TmpObU9RT1N4ZEtCRVUxY2ZXV0Zs?=
 =?utf-8?B?TlNyVUY5bDlrd21iQjNmSzFtNXNJZmZmUy9HRUtacXk2Ri84WHRGdHJ6Z0Yy?=
 =?utf-8?B?MFkwN3FDTWFaRmlDWnA0cXJnTHhFLzUvR0lpaXA0YXNFOEFtUDhpODA2TGRV?=
 =?utf-8?B?YkU4dGsyUWVOTW8vTXRGUXlKSEVBdDFmZnVGV3lBZjk3cmRORGcvT1lBQ1lC?=
 =?utf-8?B?MnJiRVRIK0Q3N3o0VThBYnh4M3EzOHVFdFAwOW01cmFCWmhZMXdDcTBhZ2Yr?=
 =?utf-8?B?cDVPWU1Hb293ZElKR2Nadld5SFMrY0c3bFZ2ZFJ2NStyalA5OHdXWXhKOERp?=
 =?utf-8?B?NDZPbnlPL3ZIcUR0QnJ0bEFYbDZKRi9DVmlpbnE4eXRLaGI0NEZkbXYvdHBU?=
 =?utf-8?B?cktuZGt6ODNZWUtldkpoWVNqTjNEQ2xNRVFLRTVqYlQ4TGhUVjJJNDFkUUpq?=
 =?utf-8?B?SkRUN0krZkkva01MZ01uUnUzdTFyTE95KzRVY2EvSFBxWTFJREdTMVNvYkI0?=
 =?utf-8?B?SUJvQmRaTXNaT0dBZmdHVDVRTTIzV1pRV0c3aG5TaFhsVHNnSG5KK0hzaWx3?=
 =?utf-8?B?WnlCRlpidTVMQi9BdzRNZFlwNXFQQXgzSlVWaElTWk5lM3kzM253UmRpeWRw?=
 =?utf-8?B?dFQzdDZ5dzg0NnpiODdNNU5ENnJUVXVUSkFwVWVKbjF5VHBycUpLSUYyeGdu?=
 =?utf-8?B?Q2hkaFoycWcyWjNzMWxVQVdPMUpjMTdoV2tGeHlUKzgrYi8zTDVzWVZvNnFC?=
 =?utf-8?B?ZVR2ZFdCNU5GaEV4Tm1nMkpLaVJQNTg0cTFxMEJtNkhoRytDUFI3SjFPMlNz?=
 =?utf-8?B?OHNoTUpNQjMxR0U5azNHOVRTNHBDMjFZNnAyOGZZRW9OQlpIRjdnbjZYWUdq?=
 =?utf-8?B?akFPMkt1Yi9VNnNVQzJDVE8yWFZ6MmNqZ2RFZUZCcVpaSXAwSUxQNWpQREx3?=
 =?utf-8?B?dElZOUxlTnJNN0JMK1dNYkNuazFsNnBsZUY4aEpjRVE1elYxTXFseEEwLzNR?=
 =?utf-8?B?MEdEbndBWTliaEVPLzRhQ0lEN085NHNIWU5JYWtBMlBCbWVmWHFMZUE5Smtp?=
 =?utf-8?B?dkhrYVY0L2UzeE5hR3VvdGcvM1YydkFIYWEvT2RwSnVObnhldjJVd1hPeVFl?=
 =?utf-8?B?bzZJSTJlUnVnMFNhK285OXlHYWoxWUxnbjVMemZtV0NLdnFDTDd2aXlEZ3VK?=
 =?utf-8?B?NytFR0k4VldNL3ZjQ2I0N3BEbTdlN1ZJZTZGY0M5N2c2MGRrdVdIL3h6N0Y3?=
 =?utf-8?B?SGNJUkw5WlpHaFFHSkZGcTZPR282bjI0R3gzZ1dEQVF1RkxEN01WeHV0NUE4?=
 =?utf-8?B?aTV0WWIzWDRnWWF0VXA2OE83STFkUWViMkFQTDJYM21VRy9wbUVEZ284Ny9Y?=
 =?utf-8?B?V2hnSHFuUXNXZml4aUxaSzNRVUhPMHpuWnhSOHFySDF5QmVVM042Z1FQWHRu?=
 =?utf-8?B?OERJMk53eER0Zmp5NVJpR0NpMCtDNm10eG4xSWRuMFN2aXM2YzZFWFIrUjlR?=
 =?utf-8?B?MG1oR0grVWhaWmJ3dEJ4K3JlUGlBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05EE60CBCF87F940AEDAB0FE98D07D01@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iMhPXPvYHSibIiMykarHmycDe5iYa6b8WRug+KF9XWUMJ8akRxunelS33iM67UbWACrWhbvuhGSTXb40Vwv0SoItg33lBjakflu58mu2a/WgKlGowHizC6vPkFl34krE5p0C+qlZD0Lm1f7WkrK7DOIDX5U9nkD7v/GVd0jbiVxTnB0O6jq6GTpddALtSr/scGfUb9LxkNs4/hyMXi/x02s93CLqYeiWLge9L15wGgaLV84HRbU/xwwOZsfRC+4Kn6JOAyWrpWM3ZQqh3T7WT+e+AX/p5CoAXot2ZanP5qeFl4B6Ab7KVreGiPJORhzCDloapcLk2KApGvH7EgiHj9vJlUI7FAHtusqMwt/cGxjxJsRMQv3cw3o/1x84qlkpekW28nRh8C0f6ifcKPgY5QVaRCnp26V/9KRkcQARj1sUE0EcZm8wRS8WBssfWipKzZjSGD+7ZoS4d7Yx+XJ41uHmf3VFP/ykD7g6dtviYn8yko9ZJ/ioF9rOfcD2fZKYkUJnP3kMoN7C24AcIGQf9xI4VbwdFCk/Spz5oppp2bcEZkjhHRqGeqzkz0vddaH2geXLGwCp7BHD0VU36aYyw/qccesMKC/lejIIeDzrXIxyHOKOgtI5zSBarJp97qt0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5774ee23-b72d-45ee-f20c-08dcf26834a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 07:07:35.3510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8f2+31xUGAMJqRbMAl5rQpJdWEAK1S7LE4Jge4akAi+f1lfV/aOrm5CswusZz0Ics/4JUx84XEqHSdrHKja7rrP7qBm3vI9xOBRkI4lnyh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7593

T24gMjEuMTAuMjQgMTY6MzIsIHdheGhlYWQgd3JvdGU6DQo+IE5vdGUgdGhhdCBhcyBvZiB3cml0
aW5nIHRoaXMgSSBiZWxpZXZlIHRoYXQgUkFJRDAvMTAvNS82IG1ha2UgdGhlIHN0cmlwZQ0KPiBh
cyB3aWRlIGFzIHRoZSBudW1iZXIgb2Ygc3RvcmFnZSBkZXZpY2VzIGF2YWlsYWJsZSBmb3IgdGhl
IGZpbGVzeXN0ZW0uDQo+IElmIEkgYW0gd3JvbmcgYWJvdXQgdGhpcyBwbGVhc2UgaWdub3JlIG15
IGphYmJlcmluZyBhbmQgbW92ZSBvbi4NCg0KTm9wZSwgeW91J3JlIGNvcnJlY3QgYW5kIHRoaXMg
aXMgYSBodWdlIHByb2JsZW0gZm9yIGJpZ2dlciAoaW4gbnVtYmVycyANCm9mIGRyaXZlcykgYXJy
YXlzLg0KDQpCdXQgaXQncyBhbHNvIG9uIG15IGxpc3Qgb2YgdGhpbmdzIEkgd2FudCB0byBjaGFu
Z2UgaW4gaG93IHdlIGhhbmRsZSANClJBSUQgd2l0aCB0aGUgUkFJRCBzdHJpcGUtdHJlZS4gVGhp
cyB3YXkgd2UgY2FuIGRvIGRlY2x1c3RlcmVkIFJBSUQgYW5kIA0KZWFzZSBvbiByZWJ1aWxkIHRp
bWVzLiBBbHNvIHdlIGNhbiBkcmFzdGljYWxseSBlbmhhbmNlIHdyaXRlIHBhcmFsbGVsaXNtIA0K
dG8gYW4gYXJyYXkgYnkgZGlyZWN0aW5nIGRpZmZlcmVudCB3cml0ZSBzdHJlYW1zIHRvIGRpZmZl
cmVudCBzZXRzIG9mIA0Kc3RyaXBlcy4gV2hpY2ggYnR3IGF0bSBpc24ndCBldmVuIGRvbmUgZm9y
IFJBSUQxLCBhcyB3ZSdyZSBwaWNraW5nIGEgDQpibG9jay1ncm91cCBhdCBhIHRpbWUgdW50aWwg
aXQncyBmdWxsIHdoaWNoIHRoZW4gZ2V0cyB3cml0dGVuLCBpbnN0ZWFkIA0Kb2YgY3JlYXRpbmcg
bmV3IGJsb2NrIGdyb3VwcyBvbiBuZXcgZHJpdmUgc2V0cyBmb3IgZGlmZmVyZW50IHdyaXRlIA0K
c3RyZWFtcyAoaS5lLiBkaWZmZXJlbnQgZmlsZXMsIGV0Yy4uKQ0K

