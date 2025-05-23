Return-Path: <linux-btrfs+bounces-14187-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC83FAC2236
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 May 2025 13:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7511A5038E5
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 May 2025 11:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F832356DC;
	Fri, 23 May 2025 11:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="D9As2q3i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D3E22A1E1
	for <linux-btrfs@vger.kernel.org>; Fri, 23 May 2025 11:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748001255; cv=fail; b=Ug+UT7qRPQzdSudjS639Zyr7eKcHk7ZXSW4O5G/oJ4tSYPZ1jz+QRkjuuH5TeVrM/j9pwqEEB4BbFaJhU7Dsi+4W37pu9I1hCV9S5a+DnYMnDr64bGCtH8YdkP8GiE9L1M3AB9L4YHHV/Q5qufnqkxiN8NEew772suf2dabPWi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748001255; c=relaxed/simple;
	bh=1w/7/Oe8rgHRPmOSebBazbQTbxeqiXCxsY0AxAkDTgQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=U0JyPbV1SXIkfVVLWThSJtXW6TEdxSb+X3UkFkV8+VcnAvV/jiOI8BhYQ/ZHO/htGstFxtD7yIF5AeA9j+b7EUjbjSHXv+HRADZQRPf/eLJs1NWN5sH+7VeMfNbAF0XijgfOAkxj+OFDCr2Cw2Ki8+oXEsgRwmXbdkszCX7m9uA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=D9As2q3i; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MMxSPd024496
	for <linux-btrfs@vger.kernel.org>; Fri, 23 May 2025 04:54:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=j991C5K+5bY7VdOleOvVWXUIf9tQMtu/XNDZ7DufjpE=; b=
	D9As2q3i0pmAmGsIaRdVf2Se5zG73IPg72sPg8YrYpJ00NPvbB2hc1LKm0XVcJFy
	W2bby/fIHy36giPCCKqkD3VdWH+o6WhcKbcvFcwX3rbtnF05futE7KZcd58z8g0r
	1jL8Kr8C0SWfCNvsESpOK8/uoVMonhh5L0zAg/xwN4ly//wG5qjDqmxVWAa51iv2
	WPmhYgjHS14CLSVRqxZkeKCkxb+7AUDGbTCfAahdnAvelMGzofJdqswyqJ9wiVJh
	4rFguKjtPBG6d14MJvOrNoUVgHuQs9BlJZow0/WHdqC4kaoPD9VWnr4fb/rvH1nZ
	fz6YLR5dscf1vcdN8RzlCA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46syca2kgv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Fri, 23 May 2025 04:54:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZKJKEtUcr1aw+UaTm8WjZ+xFRrlM/+CU9XTxybNW0GaVj/Dl/32BasNceR7rWCcMXvz779DBblVvSwJhY7CYa458y2/OcjmZWDOmBV2FFCCEF9db/xHbbLE8L4XbpjNZmATx8LI5vxVvSdNj67tfLSy8G5k+fj3tnJl3jVRIH38eofQyco2mR9nxKmeanqunzQ61dpnUzH5c6CgEQR4rtlYpEdfrkCkV6kBtZNGXb2+kgQmSksMwxnU8oF6E1t+4zv6lhN9+t/HNc8YzgTk8UZqseoFCCSNKgKixebCqrEz0/9YnpEHwfGyizWjA1ZAKY7V6pEgqfBDiEybU2xMUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnnTvuuXLmYjbMwmYb0zAabggrpgNI5rFyFGM9YJ/gU=;
 b=GjNhX8acq67VC6ejsuAnDjKHyB+pMbc7BOPiIIE1y2uQCjxS37/WXyzGDGireEpHW7wTPLDWe9bWnRC/HTkMZJwEP+qZHibmzKAW5e2yZFgmizxqZ7V/D2fuJyqYjsW/5oHi8fQISwjkONySohyi7gYsUVb5OT6jGynMv3K9e8AkqjH4zzHMhPVR1Xd9ONSEMKs/dARrheRuTAZ6uuczoOrJRJcO0OD17eV/nADxhol2iD6NdWu+AC/7Zf2O+UVCL/GJfSByX0o/y8zaqLuJKljQGX7L3TpaKhDjHWfUSwamY69/S+FmxmOwbJJe+0tTq8FrieeXgZ2MsS/zx3Melg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from PH0PR15MB5659.namprd15.prod.outlook.com (2603:10b6:510:282::21)
 by DM3PPF7911AB4DD.namprd15.prod.outlook.com (2603:10b6:f:fc00::422) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Fri, 23 May
 2025 11:53:54 +0000
Received: from PH0PR15MB5659.namprd15.prod.outlook.com
 ([fe80::dffe:b107:49d:a49d]) by PH0PR15MB5659.namprd15.prod.outlook.com
 ([fe80::dffe:b107:49d:a49d%5]) with mapi id 15.20.8746.030; Fri, 23 May 2025
 11:53:54 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Mark Harmstone <maharmstone@meta.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC PATCH 06/10] btrfs: redirect I/O for remapped block groups
Thread-Topic: [RFC PATCH 06/10] btrfs: redirect I/O for remapped block groups
Thread-Index: AQHbxbeQ9ZfuQ0xjMEKFdnsAKEMY17PgCfgAgAAdToA=
Date: Fri, 23 May 2025 11:53:54 +0000
Message-ID: <76aee017-6488-4185-92cf-c9442f1a36e1@meta.com>
References: <20250515163641.3449017-1-maharmstone@fb.com>
 <20250515163641.3449017-7-maharmstone@fb.com>
 <d5aeaff6-3e04-4525-861d-36dfa358eb45@gmx.com>
In-Reply-To: <d5aeaff6-3e04-4525-861d-36dfa358eb45@gmx.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR15MB5659:EE_|DM3PPF7911AB4DD:EE_
x-ms-office365-filtering-correlation-id: 3c4d4946-3949-434e-fa80-08dd99f07e09
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?alNkY2VHTC9JSWh0aXJGVHdmckNOd0RWWittYU1vVVdWYW5ncmRTUGhtQWF3?=
 =?utf-8?B?eE9xa0h1aWVxQ2FhaEFZVFdIRElEdW01V1ptTGJBN2dkaWQ3elRVdEVNSmZq?=
 =?utf-8?B?clJaVEljOEQ4TVhmYzdkdy9FdHdqZ1lYK2lIZm9UdXVHVXUrRzhXMnhSU0Nh?=
 =?utf-8?B?L2k5K0hhcCs5VHdENU1seTdqOUVUcHh0S0xPajRqZjBPV3NqNkVhcHA3L255?=
 =?utf-8?B?NWx2NTdhV0tpT1NIQmRzWXVadzVYb0hXaVc3MDJOeHlIb2NMTzgwSWdxeCtu?=
 =?utf-8?B?QXBQQ3RVQ0RFTmJzandyUWk4cmNHLzgyS2NyM2dTUlZpYm1jY1JDY3p1dDFq?=
 =?utf-8?B?eUNjeXlETmtvZUNnOXpWb1JOc01tR1JMYmR6aXNPekFBYlFqRHA0SGhXNlk1?=
 =?utf-8?B?TFkrUnF0cWdWejlqZGJ3dkViTmpheG4zTnZRendBUFFRaGlrY0FQVVRsSkxV?=
 =?utf-8?B?anZTeWZEbWp4ODJ2SUFJZnVxbjd3WDFVZUhBeGZJWUlqM0Qxbm9aRE9zN25k?=
 =?utf-8?B?MlFXNit1MEJuazU4SWg4b01odm1ma1M3ZXEzZjh0Z0o2SzNTckhJc1RkbHZ5?=
 =?utf-8?B?NVFCcVNFbURUMVlTK2RTd24wdmJWQzMrL2ZnRS9lMkp0WStxOEhLOHNhdXdJ?=
 =?utf-8?B?YVhJWW9LdzEwb1VIYkpqVEFIcCtYWGZoZ2JZUlg1cFFsWXFSR1gyQkg1RWZS?=
 =?utf-8?B?OHUweGYvaDhmUkU2UzJNdlgrb1dJSXpxeGFWM2hlZS9BZHVLRjlEOWhZNDIz?=
 =?utf-8?B?QmcwWmhac1hPdm9QYzQyMkJxazltODhJNHEvVFZ1c2JDQm0wYlNNNXBxS0Z1?=
 =?utf-8?B?ZlhJeWxMM21adjd4Nm5tWEphOElPMDVteEc1M3FtaEFzTnNRMk5wYTRoZ2dV?=
 =?utf-8?B?NDE1eHhqYnI3TlN6VVBuNnd1WkJuUThLd2Q1NjVKWFVEcXZyMTV6bElPS2pZ?=
 =?utf-8?B?U2xsUlFtNllUMTFDMGdWZUJKaTh4dlZQRnB3WGJkL2t3OXRGbUk4QXpUakxJ?=
 =?utf-8?B?YlRPMXRlZWNxZWtNQk1zdkJ4WUMyUkxFR0ptdnhHUjRTTmdWUHVIdFMvbVR0?=
 =?utf-8?B?WWlHcXFQQlIxc1piZCtJaEV0enIwcERQdkFaTEl5Znd2QkhzMjlwdW16cFo2?=
 =?utf-8?B?eFp0VmNTR3JkZE5xaFIrT0x2YlAxY3RVTWVqamNvZzQ2RjRJaDliM1ROR2JF?=
 =?utf-8?B?T2ZPeWdBZTMreG5DUml4aXJibU9lMitOOFIzc3Nnbk9hdVlYdjE1cGEzV2U0?=
 =?utf-8?B?T1dweFg4SUEvSEN2ZXV2bk1UQ2NFU1VNQlVrUk9XZ2EvUzFKYjhQeE9rSkNO?=
 =?utf-8?B?Y3dPZUlaNXZwL2RPSmROSWt2eGw2RVk5SENuc2k2b2RTaFZneGZML24vVlRK?=
 =?utf-8?B?NTNSbWY3bUQvNzV2enNyNEViczZPSWVzRDVMWitML21vS1BEZTJVYzQ4K0FF?=
 =?utf-8?B?ZGVMRzNHc1VYNEtxVHpkK3BsbjlXTndqV0lYcldwMDlGdG9neHFMOFNPNGJ4?=
 =?utf-8?B?bTRLb0ZmRE5MRmF3Q0h1N0pBVTZ5NEVuMGk5cG5uRHgwYjQ4OWR6UWVmWVNL?=
 =?utf-8?B?UjE3OHEzZ1JVSjlMdjZTN2g3OXZmVmdLaDhNSkF5dDlhWTJ6aE9JMmwweEEx?=
 =?utf-8?B?MlFhZVpRcUVmQ1ZoNkJBaHp3K0xtMFNHZ0xscUZXeGtDYktkZVRJSlpkTFBh?=
 =?utf-8?B?T1lJeXJHbmZkUi9FOTE4Q2t4QjhrVE9zMVlrZXpVVUd2dkRDeWhybk5mV0N4?=
 =?utf-8?B?RUZzZFQ1Wi9hNUN6V3pFdG1ZTHZyOEVROWFPbWloT2hPYW44QnMrRzZqU2k5?=
 =?utf-8?B?WVM3N251dkxRWWRjVjhDUVh6RndiOXlTdDZzMlJCY0JJanlhS0hQOW96MVRD?=
 =?utf-8?B?b0hLanJYNGhMeUFkZ2xLODhodE9acnNCSG9wVHNrY245SkF5Q0w3R0JlMy9l?=
 =?utf-8?B?Yk1LYTdwMEZTYlMxazNzQUNHaHE0MUhac3UvVVBXWmRSbEFQVzJKZDBEVGE0?=
 =?utf-8?Q?Y7xeAUBBieV+vjQ7h5F9uE/9MSVk8o=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5659.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aXM2ZWRzdU9LYWljb3d6QlFmc1FDY2xmVUc5TG5vbFNSTUNaK3BabGp0Vy9B?=
 =?utf-8?B?V2g0ejZxU24zSU9TK0ZVdm1XVndUbVY0dmtETlZOUXVlcFJIQXZ3cEx5VEhm?=
 =?utf-8?B?U1VhYUdmSWNPNE9tY3FRcWtuemV3M2FlaVVqNGYzTGhNNnkrTUViQzZEMGJ6?=
 =?utf-8?B?eTZueFRZZCtBb2VQZ28zU0lEMUwzYnd3MU0yQ3ZNVHNyT0JxLzEwaTZiSTRw?=
 =?utf-8?B?dzViamVOcXc4OEZlSmQ2Z3c3S0RMNEtuWUM2UmlvQjVXOEEyK2ptcGJIeWtI?=
 =?utf-8?B?WFk2VmNaSlp4dVQxV3pITHl3NldLZHUzeHBwZU9WRnpPVzhZdVYzOERrUy9K?=
 =?utf-8?B?VE9DNzVEM0xreUVTbGlLbFJ1RERJWVJlaDN1OTRVNUVGR29HaFFoaW5XbDBa?=
 =?utf-8?B?dDV0NTkzNDUwSm10ZXBrWXlnK1VxVzBObWQ2aUhXT3JNaWJlQ3pWd3VMUXRW?=
 =?utf-8?B?M3gxSm1IT2s4ZWVqamNQTjI3STJDaU5uNS8xQkJMSGhraUtRRTlUZjRrYkIy?=
 =?utf-8?B?RDd6NXhUaEUzR1FRb1kzV3NGbUgyWENGa3RLV2lzS1ZpRzkycGM2TEhRY0xD?=
 =?utf-8?B?MUtOeW95b05jdlFPRlNrNTFtRnpaUlJzZ0VPQWdoaGZCUWRxc2lNTjFMcHI5?=
 =?utf-8?B?UkpUblVBTGVoc3JIYSs0K3VObmZSc3NSYXhkSHUxei9jWXZLZkQxQ0VnSlpQ?=
 =?utf-8?B?dVJQaE1JY1FnaHBnSEN0T08vTDlMaisxbXR5TGJFTUFlS1ppeUp3N1ZrdlFZ?=
 =?utf-8?B?S0VBOGp4YnNsc0xtVWFNN29PekVVS0ZuZ0V0OVpVMFJ4UGxXL0hqZ3RZVXdZ?=
 =?utf-8?B?ejVEOUc3aERUS0pVZHlzeVdTTktwTnE5bFlObWZNbDZqWFFWd01CU1VuNTFs?=
 =?utf-8?B?SDNWZ0JYdXF2RU5mazViNFVaN1FJQVpNVnJ3emNGTEx6UXdJbTcrVk1nM2lt?=
 =?utf-8?B?eVN0cHdER1NkRzB6aDVCT1FGc1dmclpWMXlKSWFaakd2Q2tYUzNVZmU1SVND?=
 =?utf-8?B?am5ZMGpWazRPb2t0SEQ2UTU2ZWlQZkFlNlRYREdNYUVUaCt3Qm9SR2NRS3hG?=
 =?utf-8?B?b0hYVUZTWU4rTVVzUkpRYkhRMVhSWEliMElMRmNMdzBsK0ltZWNVU3ZDWEN6?=
 =?utf-8?B?TDJObzUwOGJtdFBoUVB1bDNuZy9uS0VWYTZGcEZGYkJCK2FFd0RReHFmMS9x?=
 =?utf-8?B?RlFWS3lCR0l6T1o2ZTNVZ0c1RVBUY1ViQnBpMXhQN3I1S1UvQ1M4MG1yamc0?=
 =?utf-8?B?Qnowc0RabG1QNDRxUndMbUlIdUxybFZDTUNtTnBpbXNWSGlwS0dtcTBtSGIv?=
 =?utf-8?B?T2lzMXR0QlBFQU1hdkI1S3U2YWxvL05pSzRLeFYxNnVDNm5xM096NW9ZaDFZ?=
 =?utf-8?B?VzFMSEloU3YzSHVWelVkYjBmVy9xaTNLakRDTWt3OGxsNmJ5Zmh5MHZzQmx6?=
 =?utf-8?B?NVAxUndqU0F1MFJ0ZCtpKzlabWpPTjlpWDgzWW1ROG9CRmFOcGRrNXludldC?=
 =?utf-8?B?a2ZpS1N4eVRjVVNwelArdE9FSTlySThWY2dXVHVpOWIxWUY1dllvaWk2RXc4?=
 =?utf-8?B?cVV6Uno1K1VpelI2S05YV01rTWh1K056OUhGWUsvanprQTB1RjNjMXNFNm56?=
 =?utf-8?B?SnBSTnVzNERXaUlhaE5LVldCeXhIeERheUFUTFpoUi8zQ0NsaHkwSzZLYlJN?=
 =?utf-8?B?a1dybC95UTFHalRYNWJEY1UzNDVPeGVmY3ZYQUFZWEc3dzd1cHpaVHhIOTdw?=
 =?utf-8?B?blZ5MWlIZXJmZ2dRSUxQa05ZcFZjY2xDYWRmUERjdG5QYk9PTTVNbjk5ZXhB?=
 =?utf-8?B?N2IvaWc1NUV5M2ZWRUt1bnUyMVRsaXdRVkdqWTB0eElOYUs1NklKbi9pbW82?=
 =?utf-8?B?eVFiNkh3WElNRC9HQURzckpaYmllZGVtQXk4b3pwdmhPdVd2ZW5PQ2I3M01J?=
 =?utf-8?B?OVJoMjhkeDhxbzg1Z280NWFjdW5vWWdvZTNadTlxUXRTM294VG1qRUtMZDli?=
 =?utf-8?B?TVZxOWhvREJkcmM2VVJFWU9Xd2swWS9MeG9DY0NubFBsQStjeEFBTEptc1Fk?=
 =?utf-8?B?R21GOHE3WHBGRjVpVTB0VXRzOWFVZExTMDhnSXZRS3dReThjemg5MUJQU0pW?=
 =?utf-8?Q?05zQ=3D?=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB5659.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4d4946-3949-434e-fa80-08dd99f07e09
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 11:53:54.1700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ji7W6sI/pLerUNNDpqAE5ClL2YKVcYaWZEPbDRgWWs1VGpPdW/Prv3+cdxMuzwSdsvVGv2Q6HPWg7OddpMNaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF7911AB4DD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <AB38ACC500A29443B2D217D4EBD44A92@namprd15.prod.outlook.com>
X-Proofpoint-GUID: emrdele1pOWVrazC25T_xpPVcx1jAgKO
X-Authority-Analysis: v=2.4 cv=CLUqXQrD c=1 sm=1 tr=0 ts=683061e4 cx=c_pps a=TbfGeTIpFbm9CS5WQd39hg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=FOH2dFAWAAAA:8 a=k2V0E7TfCpLqQOjRFj4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: emrdele1pOWVrazC25T_xpPVcx1jAgKO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEwNCBTYWx0ZWRfX9hC42Q70cU9v Oh4uixK8R7k5o+hRVrMzszxin03N+JPwfzGqv5Uwfc01cOYKnS9JW0oh15Klb47eWtJKovgm4E2 fwo5VbtR9xzWqlGlne1Pxza+a+uQBov3rBwsBdr8WE3pWMENsyWMuuC1gprGAa4uC9oktBgxpHw
 EC99/eSpVLJWPL8iA43zoOsrg1uR01lgB2bsuEHmCVQiDT4egPoy5D0XQLK4EEyr3G9g3CZeJEp 9/npFrp3Ja8edr6JAI5G0geOH5WqB5hMUtgCzicYukr/FxKw6lD5D24t97HTquWSonXeuUrPjDP gTgjgszQaIHuOEdbgB6uVHfjrd1pHX4G7AjE3ez80+P+YRkmUjjygHjuWWbp8us3XsGRf4v1Td3
 0RNOLxCinswTQvD3Ny8K51jAu2xWQwbDL8wSbaYDO0+T2j9i+40lIgaWQ/IjSge9d/+0SGgu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_03,2025-05-22_01,2025-03-28_01

On 23/5/25 11:09, Qu Wenruo wrote:
> >=20
>=20
>=20
> =E5=9C=A8 2025/5/16 02:06, Mark Harmstone =E5=86=99=E9=81=93:
>> Change btrfs_map_block() so that if the block group has the REMAPPED
>> flag set, we call btrfs_translate_remap() to obtain a new address.
>=20
> I'm wondering if we can do it a little simpler:
>=20
> - Delete the chunk item for a fully relocated/remapped chunk
>  =C2=A0 So that future read/write into that logical range will not find a=
 chunk.
>=20
> - If chunk map lookup failed, search remap tree instead
>=20
> By this we do not need the REMAPPED flag at all.
>=20
> Thanks,
> Qu

You would still need the REMAPPED flag, as that's also set on=20
partially-remapped block groups.

The life cycle is:
* Normal block group
* Block group with REMAPPED flag set and identity remaps covering its=20
data. The REMAPPED flag is an instruction to search the remap tree for=20
this BG, and also means that no new allocations can be made from it
* Block group with a mixture of identity remaps and actual remaps
* Fully-remapped block group, with no chunk stripes and no identity=20
remaps left

My concern with making fully-remapped block groups implicit is that it=20
makes it harder to diagnose corruption. If we see an address that's=20
outside of a block group but has no remap entry, is it a bit-flip error=20
or a bug in the remap tree code?

Mark

>=20
>>
>> btrfs_translate_remap() searches the remap tree for a range
>> corresponding to the logical address passed to btrfs_map_block(). If it
>> is within an identity remap, this part of the block group hasn't yet
>> been relocated, and so we use the existing address.
>>
>> If it is within an actual remap, we subtract the start of the remap
>> range and add the address of its destination, contained in the item's
>> payload.
>>
>> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
>> ---
>> =C2=A0 fs/btrfs/ctree.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 11 ++++---
>> =C2=A0 fs/btrfs/ctree.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++
>> =C2=A0 fs/btrfs/relocation.c | 75 ++++++++++++++++++++++++++++++++++++++=
+++++
>> =C2=A0 fs/btrfs/relocation.h |=C2=A0 2 ++
>> =C2=A0 fs/btrfs/volumes.c=C2=A0=C2=A0=C2=A0 | 19 +++++++++++
>> =C2=A0 5 files changed, 105 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
>> index a2e7979372cc..7808f7bc2303 100644
>> --- a/fs/btrfs/ctree.c
>> +++ b/fs/btrfs/ctree.c
>> @@ -2331,7 +2331,8 @@ int btrfs_search_old_slot(struct btrfs_root=20
>> *root, const struct btrfs_key *key,
>> =C2=A0=C2=A0 * This may release the path, and so you may lose any locks =
held at the
>> =C2=A0=C2=A0 * time you call it.
>> =C2=A0=C2=A0 */
>> -static int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path=20
>> *path)
>> +int btrfs_prev_leaf(struct btrfs_trans_handle *trans, struct=20
>> btrfs_root *root,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stru=
ct btrfs_path *path, int ins_len, int cow)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_key key;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_key orig_key;
>> @@ -2355,7 +2356,7 @@ static int btrfs_prev_leaf(struct btrfs_root=20
>> *root, struct btrfs_path *path)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_release_path(path);
>> -=C2=A0=C2=A0=C2=A0 ret =3D btrfs_search_slot(NULL, root, &key, path, 0,=
 0);
>> +=C2=A0=C2=A0=C2=A0 ret =3D btrfs_search_slot(trans, root, &key, path, i=
ns_len, cow);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret <=3D 0)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> @@ -2454,7 +2455,7 @@ int btrfs_search_slot_for_read(struct btrfs_root=20
>> *root,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (p->slots[0] =
=3D=3D 0) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D btrfs_prev_leaf(root, p);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D btrfs_prev_leaf(NULL, root, p, 0, 0);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (ret < 0)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (!ret) {
>> @@ -5003,7 +5004,7 @@ int btrfs_previous_item(struct btrfs_root *root,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (1) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (path->slots[0=
] =3D=3D 0) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D btrfs_prev_leaf(root, path);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D btrfs_prev_leaf(NULL, root, path, 0, 0);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (ret !=3D 0)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> @@ -5044,7 +5045,7 @@ int btrfs_previous_extent_item(struct btrfs_root=20
>> *root,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (1) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (path->slots[0=
] =3D=3D 0) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D btrfs_prev_leaf(root, path);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D btrfs_prev_leaf(NULL, root, path, 0, 0);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (ret !=3D 0)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>> index 075a06db43a1..90a0d38a31c9 100644
>> --- a/fs/btrfs/ctree.h
>> +++ b/fs/btrfs/ctree.h
>> @@ -721,6 +721,9 @@ static inline int btrfs_next_leaf(struct=20
>> btrfs_root *root, struct btrfs_path *pa
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return btrfs_next_old_leaf(root, path, 0);
>> =C2=A0 }
>> +int btrfs_prev_leaf(struct btrfs_trans_handle *trans, struct=20
>> btrfs_root *root,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stru=
ct btrfs_path *path, int ins_len, int cow);
>> +
>> =C2=A0 static inline int btrfs_next_item(struct btrfs_root *root, struct=
=20
>> btrfs_path *p)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return btrfs_next_old_item(root, p, 0);
>> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
>> index 02086191630d..e5571c897906 100644
>> --- a/fs/btrfs/relocation.c
>> +++ b/fs/btrfs/relocation.c
>> @@ -3897,6 +3897,81 @@ static const char *stage_to_string(enum=20
>> reloc_stage stage)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "unknown";
>> =C2=A0 }
>> +int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 u64 *length)
>> +{
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +=C2=A0=C2=A0=C2=A0 struct btrfs_key key, found_key;
>> +=C2=A0=C2=A0=C2=A0 struct extent_buffer *leaf;
>> +=C2=A0=C2=A0=C2=A0 struct btrfs_remap *remap;
>> +=C2=A0=C2=A0=C2=A0 BTRFS_PATH_AUTO_FREE(path);
>> +
>> +=C2=A0=C2=A0=C2=A0 path =3D btrfs_alloc_path();
>> +=C2=A0=C2=A0=C2=A0 if (!path)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>> +
>> +=C2=A0=C2=A0=C2=A0 key.objectid =3D *logical;
>> +=C2=A0=C2=A0=C2=A0 key.type =3D BTRFS_IDENTITY_REMAP_KEY;
>> +=C2=A0=C2=A0=C2=A0 key.offset =3D 0;
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D btrfs_search_slot(NULL, fs_info->remap_root,=
 &key, path,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0, 0);
>> +=C2=A0=C2=A0=C2=A0 if (ret < 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 leaf =3D path->nodes[0];
>> +
>> +=C2=A0=C2=A0=C2=A0 if (path->slots[0] >=3D btrfs_header_nritems(leaf)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_next_leaf(fs_i=
nfo->remap_root, path);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn ret;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 leaf =3D path->nodes[0];
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 btrfs_item_key_to_cpu(leaf, &found_key, path->slots[=
0]);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (found_key.objectid > *logical) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (path->slots[0] =3D=3D 0)=
 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D btrfs_prev_leaf(NULL, fs_info->remap_root, path,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0, 0);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
ret) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (ret =3D=3D 1)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -ENOENT;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 leaf=
 =3D path->nodes[0];
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path=
->slots[0]--;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_item_key_to_cpu(leaf, =
&found_key, path->slots[0]);
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (found_key.type !=3D BTRFS_REMAP_KEY &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 found_key.type !=3D BTRFS_ID=
ENTITY_REMAP_KEY) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOENT;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (found_key.objectid > *logical ||
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 found_key.objectid + found_k=
ey.offset <=3D *logical) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOENT;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (*logical + *length > found_key.objectid + found_=
key.offset)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *length =3D found_key.object=
id + found_key.offset - *logical;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (found_key.type =3D=3D BTRFS_IDENTITY_REMAP_KEY)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> +
>> +=C2=A0=C2=A0=C2=A0 remap =3D btrfs_item_ptr(leaf, path->slots[0], struc=
t btrfs_remap);
>> +
>> +=C2=A0=C2=A0=C2=A0 *logical =3D *logical - found_key.objectid +=20
>> btrfs_remap_address(leaf, remap);
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> =C2=A0 /*
>> =C2=A0=C2=A0 * function to relocate all extents in a block group.
>> =C2=A0=C2=A0 */
>> diff --git a/fs/btrfs/relocation.h b/fs/btrfs/relocation.h
>> index 788c86d8633a..f07dbd9a89c6 100644
>> --- a/fs/btrfs/relocation.h
>> +++ b/fs/btrfs/relocation.h
>> @@ -30,5 +30,7 @@ int btrfs_should_cancel_balance(const struct=20
>> btrfs_fs_info *fs_info);
>> =C2=A0 struct btrfs_root *find_reloc_root(struct btrfs_fs_info *fs_info,=
=20
>> u64 bytenr);
>> =C2=A0 bool btrfs_should_ignore_reloc_root(const struct btrfs_root *root=
);
>> =C2=A0 u64 btrfs_get_reloc_bg_bytenr(const struct btrfs_fs_info *fs_info=
);
>> +int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 u64 *length);
>> =C2=A0 #endif
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 77194bb46b40..4777926213c0 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -6620,6 +6620,25 @@ int btrfs_map_block(struct btrfs_fs_info=20
>> *fs_info, enum btrfs_map_op op,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(map))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(ma=
p);
>> +=C2=A0=C2=A0=C2=A0 if (map->type & BTRFS_BLOCK_GROUP_REMAPPED) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 new_logical =3D logical;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_translate_rema=
p(fs_info, &new_logical, length);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn ret;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (new_logical !=3D logical=
) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrf=
s_free_chunk_map(map);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 map =
=3D btrfs_get_chunk_map(fs_info, new_logical,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 *length);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
IS_ERR(map))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(map);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 logi=
cal =3D new_logical;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num_copies =3D btrfs_chunk_map_num_copies=
(map);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (io_geom.mirror_num > num_copies)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>=20


