Return-Path: <linux-btrfs+bounces-10906-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DABACA097AB
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 17:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F20EA3AA988
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 16:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2E3212F9D;
	Fri, 10 Jan 2025 16:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="TXH2kLj1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8FA205AAE;
	Fri, 10 Jan 2025 16:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736527176; cv=fail; b=k8B+Fs7VYZVP+Uja/qUJJR2n7Sig5tSo/xFB4AhzsRl+JxC3WfaEpdnMWEBLlO+3TjIeyEskFdXdJ5DYWyTKknB5g4aBMAu6ZyqEmXNE2hwc2DHbn2J17VJC57BQN6/tQTZZQrRmvTdd/kNgdI2lmYvFLJSzF1Jx6QwZqzc/2uA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736527176; c=relaxed/simple;
	bh=TeeL1ebGJwkrxO+JB34XGoMuLHMKXbAv27KQ399wnz8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=sygvjmlYswkD5vxrmIqX/VaU9n+wWG+LK7rXQqPKIBeVC04SR2/4X2m03rahNuZnaEx7sKreGUdI9aLyJ//NcVr8UE7NdgvRl0RRYf/sKlpoLiDq6arz1ZjLiZbwuXGSaF75Dedw90W7PeVyq/NlKMFYRhZoiEjgEDE1ZDPv0LU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=TXH2kLj1; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50AFOXHe029457;
	Fri, 10 Jan 2025 08:39:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=TeeL1ebGJwkrxO+JB34XGoMuLHMKXbAv27KQ399wnz8=; b=
	TXH2kLj1vjzlfJ8Kz2GD3iyN8Sug87BX3h9jJHuEXauMuCgwhAjlL83w9k/UtDwH
	acHPFN2Qu9Lcc6Q4PaqPPYTxsknFdWziFZahMu4fPLyPdR92kzwJiruqz/K1GiOD
	VEGGfNYAMLoMRpQFtc7zsvQ7UXdJdEOmVTZ0c9vmNidbzwKwO9plxGtOs0gQkm8q
	7MxZeBB32aImrwMoCCfViwxpZVJ//zcZuZkWoqZhrdYsuCd9XxfFzWNIigAF+Psc
	afyXAWfjbvQadFHK6T35M/WTkcOHDwpMfl3k7sKnIWtDZY8Dpo0wvOvM39uZaBXL
	EyJv7fdGLDEKYST3/WNmsQ==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 44365p8fr6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 08:39:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wbv6/OJZCX8/mOBCHNnlPIlFl/QCqZDCqHlVk0aYB42z/+tlV6W2rWyQwZ044eIvRlCwAANMsTYtbrzQm4vhW/UKmaXGUpBNLmbKVXnQzGshV/qf7RPMlHdA4CVXV3VaX+/8n4/ON8sGjNTL7GgOWc35Gq66b//YiykKQMpPU+n1Ohl9jgEakQL0CtPxmZDoPAKd1bOe153TjROb76VXbZXKjP6THmQ2R13g+s26Ky3fZt3C8TTPdouQkyZG8K5z9W/AcdqXuKupg8hmhpdLZoLTZALmwR8j6m1+gGSEt86CDBk26vyz49mYh/qp8iEIvJyohCW+tyX0mN1adTErBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTbf2CqJW5Q4WIT8GqdTgCjl409nlF6hCVDRS1LzXyM=;
 b=sV57a/myo10bQXCrbf7B9GyVKUltaEp1yhp5WQdnwcwxHox/jI5ZRH8rn0qTTWkgx1vpnDglV5z+edR1HJXz2U8Dy7Abs42iifhLu9XZAQuy6saju0MRN7oxe7q931Wik8+PnwNeapbgIMArH44/+rmWa9CYSSwPwfYs4SiPVVTB6yKo/e6rfD6wCz1WYKGxvtyp0Lpz5YXVTDFXNxiHrmYPXvkRdVcODqabypvMdQD9xybydIsLq7jQPqIzXERJcOaXslLj73pL+MRQCkYYJSZ0CJpFJc+jCEHGKfipUCgXtmZ++Ya0IBhR35na6IvivX1OrAh3YGNfTLI+13MhUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by MW4PR15MB4426.namprd15.prod.outlook.com (2603:10b6:303:103::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Fri, 10 Jan
 2025 16:39:29 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%5]) with mapi id 15.20.8335.010; Fri, 10 Jan 2025
 16:39:29 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: Anand Jain <anand.jain@oracle.com>, Mark Harmstone <maharmstone@meta.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "zlang@kernel.org" <zlang@kernel.org>
CC: "neelx@suse.com" <neelx@suse.com>,
        "Johannes.Thumschirn@wdc.com"
	<Johannes.Thumschirn@wdc.com>
Subject: Re: [PATCH v4 2/2] btrfs: add test for encoded reads
Thread-Topic: [PATCH v4 2/2] btrfs: add test for encoded reads
Thread-Index: AQHbYEOL8yANOfbvsUamymoXj1OS+7MMbgwAgAPN2wA=
Date: Fri, 10 Jan 2025 16:39:29 +0000
Message-ID: <92429a09-4ee9-4561-8c0b-4e8abdc78f57@meta.com>
References: <20250106140142.3140103-1-maharmstone@fb.com>
 <20250106140142.3140103-2-maharmstone@fb.com>
 <b085669a-3684-4031-9e0d-3275289e86b6@oracle.com>
In-Reply-To: <b085669a-3684-4031-9e0d-3275289e86b6@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|MW4PR15MB4426:EE_
x-ms-office365-filtering-correlation-id: c6bbd25c-19f4-4841-d692-08dd31955a41
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aGhaSUwyRGZlYlNiWUJiRk5JNVFaMWJKWWJKRXh2N3RlRXdjRHNkNlB5elRm?=
 =?utf-8?B?Y2VkaUwwbStjbGswb00xb1R3TDhOcm1MbVZENUQ0WFZxMzlISnRTNEN5ME1O?=
 =?utf-8?B?WU5uUkNIM2pHT1gvbStxVUNDZ3h6ZFZlL3pBc3paaE1tbmJzN2RKdGl3cCtk?=
 =?utf-8?B?NkVuaFE4YUR2R0xocFMyVDBHMDgxWStybzZ0MG9UU0JPOHAxU3dMT1RFQmlq?=
 =?utf-8?B?OFlhOTBUQWp0TjdKTWNUY1c5d2tOYWkxdE5EV2lmSkcvdlgvVmFuWWw4NFd1?=
 =?utf-8?B?MVlhUldlb0RLN3czUzRKVWJ6b0lFVWJVL0FqZFgxc1NHWDlvMkRkazhucWRD?=
 =?utf-8?B?TGdXd2JLUUVKUkZQK3htMHVFT0VVTGFES3JDdEttVTJ6c1hqQnJrdTRNVTlU?=
 =?utf-8?B?WkVxQTRDbGJaQStraXdBVnJtZU1CaU81L1dLdlQ4R0c5MTQvRW9DTmNUS1dY?=
 =?utf-8?B?c08vUVcxa29pNytBaDI3TFBTNFd5QitlMHAzcys1bmtYaHQwL092WlZyK3Bt?=
 =?utf-8?B?MXI3S1B0V0NOb2FnYnVVOFNzQldrdFNBWENQc0xFWXNlc0ZGTUxySE5Nb3JP?=
 =?utf-8?B?QVoyVmtaTnpQZVJTUmFiNk5XblpaUVdwZlQxMXdURll6UUN4eE1PNk9DbTNH?=
 =?utf-8?B?c3VjV3REUUsva0ZyUlNFMEhzaFIraytzaWQraUdOa0pxZW1HSFE0S3BXRGFU?=
 =?utf-8?B?d0pUQ1ZwRnBKR2R5aEl5MS92NVZRaSsxUFNFRDc3Rjl5dnNmUXRkRmRhY3Mz?=
 =?utf-8?B?UEFkc1E1RytEenhkcTh5eUtIRmRETnl4WHVNQVVaN24zcFhJM09WbUsvKy9M?=
 =?utf-8?B?aWhIYTNwZUFad0RFcjRiWGZGWUMvbVk2MVVUa0piLy9WWG1hS2M0YnV4L2hN?=
 =?utf-8?B?UFdkNnp3M3BOQ3UyU1RmUXhNVFBtdFBxMmpaeTl4TFJzZWpMUEoxUFlsbnpt?=
 =?utf-8?B?bTRsSXJKOHJnUm96d1E5Sk5uMXBKd0oybGEzUHRsMCtnSGswbkEzVnNqTThJ?=
 =?utf-8?B?SzZrZzZmMThGV3F1WEE1aEN0bndFTTVtOGMvZ0FFWkZtV2FueVBOc1d2TUtO?=
 =?utf-8?B?L3I2Q2xHNE5ZT3kvSWVENmozLy9IV0xkK2c3bXdyVjh3RjUxYnZiU2F6aEhQ?=
 =?utf-8?B?YUFoRmdldTZtcVVFb01ROWZvTjRuRFFkMVhkdGpJWDA4a1VWOTJLd3o0dU9W?=
 =?utf-8?B?M2J3TzVmRFZSZC9nSmlReSt0NXNhbzhJRVgvZmNSMEY1K1BiYklSRzl6Ym94?=
 =?utf-8?B?UUJ6WFd4MDh2czNyZ1F3ZE5yOEQ0TmthMTJjWjZuUld1WTdEOUs5QVJVNk5y?=
 =?utf-8?B?NmlCcnNxbUxTZGdyUi8rV3lBQlZKZ044Sk0wZTByeXNLWEIyNVRFV2RmV1Ir?=
 =?utf-8?B?N2JSTVUxZUN4SU1sZVJSQjg3dTBsWUx4SmpBb3g4L1ppMGp5MWMrUStvWFhE?=
 =?utf-8?B?bjBtOUM4aGVVekdZUTNnMDRKa21IbWtsMmxsWTFOYXMwOTUyd2drN3hFcFgy?=
 =?utf-8?B?NC84dkVJc29BYVZld3EwanBhY3NveExzL083T292WWM5SFNjd05Ca1Y2SXNW?=
 =?utf-8?B?d2E2SHVTaU5HVm5od05sZzdHZk5ZVVBEc090R3dmamY4VVN2SDloQmZsMEFw?=
 =?utf-8?B?bG9ZMUhpVXI5ZUZHcEkxbWpVNXBQRjIza1NVdFpYTDlJRXVFQlEyYWx5bEgx?=
 =?utf-8?B?QWIwRVVBU1FGOVEwMktIOVdNdThoRkY2T21vcWR4VGFrakZEK09qMldweE9F?=
 =?utf-8?B?M1UwSVlQb09ocTNnMkpzT0lhUkxMMUlGMmR6bUx6aHIvVWhod3lJUjRaMGlM?=
 =?utf-8?B?ak9IRXcvOGJIL3FSZmtkc0RvalgvMjkxaGN5MlNBYkJQcGlPUnp1b1E4RTlj?=
 =?utf-8?B?bDh3TXZGbmk0azk0RWpsdXlrdFNYYzRLSkZtRVB6ekVYVHFhbVFkTTZLK1pp?=
 =?utf-8?Q?VeltiOEWb3/hmM7voiVkGtOSp28aofYv?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YlorWllMK3FPWUY1THc2eEZtWVVjbU5MWDJONVAvTytUa0MrSzdvb25NbGZH?=
 =?utf-8?B?dzllVzBTM2w4WGJIV0VsR0NIeUN3a2xaSFQ5MVJiMGF6OXZtbS9XMUwvc1BW?=
 =?utf-8?B?MUp4SWQrYnpsTTB3c1pWT1IwdlBJMWRZa3FFaTZUdnpESnVhUEg1R1JJS2hD?=
 =?utf-8?B?eE42WGkwbFZIVkZiYVhoRFV5VWs0VzlKaXhpSWtEdVZlSDc1amFCNDNVYXZl?=
 =?utf-8?B?Z0ludWlaTkFOQ1lVcmVZTVNtTkkyaVFxWHZKV2RLR2JpZ3VsOTBpbHBjaGE3?=
 =?utf-8?B?VUdOTUdjQytEcENqaHFEeXBkNGlDS2dyUTdxTUNESnRaeld3NTVqN0g2RXJ2?=
 =?utf-8?B?VGZjbmt2UzRHaEc4Uk1zTnlMdFNicVk3NDl5UXBEN0lCTDRWRzM5UEJRRGU4?=
 =?utf-8?B?MVZaQnhrYTlMUnhRY1c3RlgybE9sdW8xdUhTQjVJaW5HazFoZDR2Q0ZRL2l0?=
 =?utf-8?B?QjNEZ3BiVVZBNEhrRzNYdGJQSjV6YVc3QnJyS3ZQMEVBYjBtMytyWTdMMXQz?=
 =?utf-8?B?UXkvemtjVWZTNVRpVW9oSlhBQnlqMTNtc0k4eklTbzg1WWJXakVQcTM4NldQ?=
 =?utf-8?B?bkIxSjdGdTJZV1JGL1FQTVo0aXQzdTlqdk1lSWxwVk9uZkVnMmlzVlg2WmJu?=
 =?utf-8?B?TnNGMEE0RkRXRnV3WWwxbkRjbXF5TW40Q3lEKzE1RVRMbVFKbFpSVENzYi9U?=
 =?utf-8?B?WFJ2WUlZSUlaNUMyMUN5dTRGU0xhM1ZZcDRqem9EczdmMEVkWU5CWFZVdnRB?=
 =?utf-8?B?NnVPaWV0L01wcTkxT0NLY3U3OXp1RGFhdHhzNU45eHBuSTJqOVIvNlRnYm5n?=
 =?utf-8?B?QUZWWlJOZUk2S01iQWErL1BRcDJqZk5FYUoxL0IvN2crZnI0Mm5CVWNqcWVX?=
 =?utf-8?B?amY4SDA3SHN5QXFqQXVnMjFWVnZUSE81eUJSYnF1aU5UT1lKekpXdldRekJQ?=
 =?utf-8?B?aUpqWWcwQkd5aUVNOExPY09oc29heEVTWFJMOXlLQ1EwVHhoY3BaTGF3eTl4?=
 =?utf-8?B?ZUswc2lyMnl5UFNKckV4SW16YS9ZVDJBUUhTSFZJWmU0SFpqOWJPZjM3eDlq?=
 =?utf-8?B?SFNKOWhqRUtUT2FXRWlCZ2Z5NTdTY1dGeGVzREZpNVdBSEt3NElVZ1I5eGdm?=
 =?utf-8?B?cElkcnVrZGg0dDJOY3kwMitreG04Z0xEMTN3bUN6TnVqTlg2QlFWdkgyaHlX?=
 =?utf-8?B?QWJMNW5IRGFaNFpOK1oxbkRZTEZhLzBPcmRFWnluaE96VEd3N2NKV2xtQ0tJ?=
 =?utf-8?B?RE5GQ2xwY2N3WWtWQXJiS0U2akF0Q2ZaNFA1eWs1TDE5ZGF5OVdIY3FZRDNV?=
 =?utf-8?B?R1QrekRCSllaKytjWWQvREY2RFhUMUpYdkRaT1BQYnZ4VGNRNXRXU0JCTHhq?=
 =?utf-8?B?WHNZL2dQZXF5ZDJoZFdrSEdwY3ZVMk1qNEptSkdraVZMVGN0eUNRYlhFSmRY?=
 =?utf-8?B?RnpiMHZyUHJWR3NKMk1Mdkd2aDZ4UjUwcGRkd0JpL1NIdjNUbjA4cC9sRDQ1?=
 =?utf-8?B?R09Xd0plTlhLdTU4UzJkNGxMd0hSUVBhL1RhWWVrRXBxRndZSDJ3TmFtcUNV?=
 =?utf-8?B?QkVpUmo5NHpuNitmbUIzMnpsS0hnQXc4V0NCMVlZMjlUZURvQnVKOXBLVlpz?=
 =?utf-8?B?bit3WEZZYjM1TzVRYWVnT2M4ZEU4TllDeDkyVURRVUVuNTUwZFpWODZhSnh2?=
 =?utf-8?B?bjdJS2hlT2d2dGc1TDk2clpZd282anZnaVZkQ044bXBEMzlCcVA5OFQxcnFG?=
 =?utf-8?B?SU9OSVRFMzVIMkZCV1pObHJNVDlwRnJWaE1hWU5WN2lpU3hDL3VUMVVHQmlN?=
 =?utf-8?B?SjlZTjJUdUk5dFFaVWVZTXQvdmEyMTZXcXJRaU90NlNiRHpJa3FZVTl4UFV2?=
 =?utf-8?B?ZlpBM3czWkJVK0ZTN0VUZC9hTndqV2N0bFdXdlg1eFUvU013Y3VxYktkeXh1?=
 =?utf-8?B?WXlNajdvZ1k4OWtWcHZUTXFZTFZFZnBVQS9tSTBPRjhTODJTU1gwaSsxUHNV?=
 =?utf-8?B?WjN6WEFnUlhWWTRCRVpQajhFT0JvMFZJWkV6bUJGZ2pzdmRSczA4OGhrR1lX?=
 =?utf-8?B?Tmtad2FGVDM3QVNwNTdvMnJNOVBXb3NPRC9XUVNGcXN5aWZLMzY0Z2NmQmJH?=
 =?utf-8?B?Q1FIN1l4RldVRXI0ZGFlY2p6aHJhZ2tkZ2kyWVNXSDU2U3VDWGFSV1FaQ2ww?=
 =?utf-8?Q?+06PXSnxV8Vb3TEC6adgV1Q=3D?=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6bbd25c-19f4-4841-d692-08dd31955a41
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 16:39:29.0366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A5EMG3q37HEfBb9DOlLfgDeTzDWgFqykJ1Hdq/BkFCMzseTNJETpx3k37jB5FoxtCXwZvnHyPUrYl3amR9M0TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4426
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <6968088D24073245AB17EEEA9A61FE7C@namprd15.prod.outlook.com>
X-Proofpoint-ORIG-GUID: 5d9obDxV8FFxHDZLALpY-olGTW6lH6Wu
X-Proofpoint-GUID: 5d9obDxV8FFxHDZLALpY-olGTW6lH6Wu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

On 8/1/25 06:33, Anand Jain wrote:
> >=20
> On 6/1/25 19:31, Mark Harmstone wrote:
>> Add btrfs/333 and its helper programs btrfs_encoded_read and
>> btrfs_encoded_write, in order to test encoded reads.
>>
>> We use the BTRFS_IOC_ENCODED_WRITE ioctl to write random data into a
>> compressed extent, then use the BTRFS_IOC_ENCODED_READ ioctl to check
>> that it matches what we've written. If the new io_uring interface for
>> encoded reads is supported, we also check that that matches the ioctl.
>>
>> Note that what we write isn't valid compressed data, so any non-encoded
>> reads on these files will fail.
>>
>> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
>> ---
>=20
>=20
> Looks good. Add to the group io_uring and ioctl.
>=20
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
>=20
> Thx.

Thanks Anand.

Zorro, can you please add io_uring and ioctl to the _begin_fstest line?=20
Or do you want me to resubmit?

Thanks

Mark

