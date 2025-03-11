Return-Path: <linux-btrfs+bounces-12200-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8D4A5CDE4
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 19:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F89B189CD5F
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 18:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102EE2641EA;
	Tue, 11 Mar 2025 18:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="caKycxwb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDBD263F41
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 18:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741717631; cv=fail; b=CDXS02vupErZmfxjS/cCRxF607K/o2p3reTqtrEDipmxl96co5nxK8z7NcPlAOTlcGfVbbiOtpfQcZd3mPgTPeF7xz2tdGLSn01LwREuUT7oNPGkddPLLlQQdO/r5oiHsDbXhn2sgonczUmMcfxCG4+HEnr3xRpGNMk3tvUbQj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741717631; c=relaxed/simple;
	bh=BcjX13Ld4vQ2zqx9o8Lopg4SxFh5TZ8j9UiUAKBJEDE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=PINhj2gaNwAlL+TZ0X0XZcbvvxXHqvYWVo/YKa1WopOt1RblweCaKYZIM08kgY3+fhNwopirfeS7oYEMt2jXkP1XTyZdqa/ULsUUzostNbglKo0tFyuzquIyU/6lfiEN/ddkK4I77Pt+YytbeuqgAEL40ceoHm963XNmnq8qOlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=caKycxwb; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BGPoxR009095
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 11:27:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=YZ35F7jiPlVuDEcz0V0Gz++oCdZfR/GsUZ/DbTcRUW8=; b=
	caKycxwb5ueLBdAzdJ0RkqUk8oa9buTEuhfV5oY8c4EWhPVFbhOuWCXAkUyTp8Rl
	XmFncY1sIEYMSwmV7iYwuIdKvtYBBlNjW42XsPIXjPA7nz3iACIt+rQrT/ZL2PdZ
	+9TYSQqdg23n7oZk+7n2qOdy/EguQLJIiLMuNds06MIyOxoCCJoFZyhIXFIcuMwJ
	hTTb7Jupfbd1qrm3L6K1etzdI552HJdTSo+T+61zjLHhhMmFgIs0Rav5l2tp+rsd
	lYm96MwB1sVMo1R94tRAn/a0RZcylX9Uug6re90al+eTgHWrO4mdQT3ISDl4FRL1
	DU/lbFm/7SGV9UBeIU8VWg==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 45ah8rv86f-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 11:27:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpv8zPTwOW3efq7Kf4zN0S6q7oOfhAx+BxO5hbWIddLWPEVF57mSASdLPJAKhcXHSEdK2zBug6fOVq7/SAaUHMdR8Rh3ITVoJcg7c1umiw7BYqiJJdyPtlNB6IQcX5obmShov75aB9uJEKRNJffls2R1K+H5tfkhbjT2VvX1aGSroa9FMoY6SzTyc2XDRRbWOh8++eV+au6JsYqSKShE0lkDY03eSPkoOyTDMiVuDUh1GAYb/Zve020LkSGHPaS0wTDh33n762oJTPkLhUzCQkX7ynfaUAkcerAn/RU/DT7wr2QVKCCkoH2a+8sr2xWmd07XHd0n+QIKaRVQAgJWSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsK+EDfO4XyOGh3TuTgktwMPklQP+Y9Q4i7JY6It9PQ=;
 b=fpkwh+JivAVzA3zZbYsUlgQTglVEFDF91GNQugbjYlOAJfMMkJQv4STkyLas8R+zeuLcwMKAGQYWJ21o6C04TZ20oFLPbUD1HIJhW7d9okD6ckn2V96R42iNfd++2O2T+qjS6oS04ZO3MlRECNW1sMLBUxmzg6L1IIVbPLGQv/tq301X1kdr++plJHeH8tR5Gt277USgbBFXSwXgO4r/gB/W+DnvlG15xkLNNxCvvT5eFk7qug9cLg9eL4cQPuWcNxQUNyYLPWmgJ9cZin6srEfK0I3c5Op9VmNKPJ1ZlOmJ/uU+UGG9NsLgEJ8XeS0dxQUb5C5NyFxZ4yV94J+ULA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by SJ2PR15MB6421.namprd15.prod.outlook.com (2603:10b6:a03:570::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 18:27:05 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%6]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 18:27:05 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: Filipe Manana <fdmanana@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Qu Wenruo
	<wqu@suse.com>
Subject: Re: [PATCH] btrfs: don't clobber ret in btrfs_validate_super()
Thread-Topic: [PATCH] btrfs: don't clobber ret in btrfs_validate_super()
Thread-Index: AQHbkqQvldS+cpKQBkOHhgZFIypSZbNuJxkAgAAZ/gA=
Date: Tue, 11 Mar 2025 18:27:04 +0000
Message-ID: <f41a50af-bcdd-476d-8f08-bfc9f005b733@meta.com>
References: <20250311163931.1021554-1-maharmstone@fb.com>
 <CAL3q7H5aMFgD_p5vE_9jkLN=-vMK-qQinZPaR1d1GUN5iTYjgA@mail.gmail.com>
In-Reply-To:
 <CAL3q7H5aMFgD_p5vE_9jkLN=-vMK-qQinZPaR1d1GUN5iTYjgA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|SJ2PR15MB6421:EE_
x-ms-office365-filtering-correlation-id: 46ebf7ed-464b-4f7b-0569-08dd60ca5312
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cFFYUFdxR1g0SWsycFpMYlVBbTlKQWVEaTJpOUVxTFh1TGpiUmlLRXdHamRY?=
 =?utf-8?B?U2tydEFIMGd1VERNSVc3Wm9Dd0drWG1zZlJrTXl3SEZmT2VLbUVmcWdWTXlm?=
 =?utf-8?B?N05ibUN5Rm1qQlB3TmZHNFpRWHloZ09IZjBEYUVneG1hUG1TTUNoOStSenFa?=
 =?utf-8?B?QTV2TlVEWkpDeXp5ZUxnaVFMUmQwZEZqNkRhZUtRQ0hraFJyY01HbWV2ck45?=
 =?utf-8?B?TWRYUVVJZjNnNHNlSWNZSU1ENEgvd1dNYnZ6MWJFR3lLNkM0Y1VIaFRwUWEz?=
 =?utf-8?B?T0lMNHVGTEM4VU42WnFvZ29uRXNmNmhOQmRUMWRLRG9PR0dRM2lCMElhSlB0?=
 =?utf-8?B?RWRaUWhUd1V1RFo2YjAzUjgyRlUvOFNkWTZweTlwTS9wUXd0R2ZPSnRXUVV1?=
 =?utf-8?B?SjhFS24vZGtmQ09GMEZMejNiSmNmUERWbGllbEFYaHJILzFWcEZOZ1BhR2ln?=
 =?utf-8?B?dmlIbTFnTnp4ODNaNFFFelVDTnA0M1NqSTdBVHh6a2VZNnlEWXdteUpVNEt1?=
 =?utf-8?B?cGpsRlRnb1IrZUJTUHEzUnZveFF0MGF0eDJsbXdTVjNrREpGNXVCaUExMElv?=
 =?utf-8?B?OWlPaEVwWE9Gd2ZXYUtOaFdTZDZ3YUpqYjUra255dDlzLzFIY3dmVmp3V2x0?=
 =?utf-8?B?aXhBOUNtTlQ5WTNnTFExaWk4Q2RNZkFQSG4xNzFrU0hyWjhqaGdpWDVYNzFJ?=
 =?utf-8?B?Q1c3NWwxaS9sUnM0Vm1tVTNyWEw1a2E4WUIrSHRTWEJOTjViNFptRzZuM0U5?=
 =?utf-8?B?T3ZFNXRvTXZCdnlsNmM2SmRTUjRJYUtib1FURmtBb1daOU1oSW44ckcxU0Jy?=
 =?utf-8?B?aWxNdmpGYVFUK0wvOXFGdWY2ZktwYmdpcVJZNGp5ZnpsdmwzWjcwYmFud3Ry?=
 =?utf-8?B?bDlkQVl1M1BYRG1odmtydnAydGtGazdMVjMwYTdieG1zNWRBMUJ0WjlyNkdU?=
 =?utf-8?B?M0RwNDF0c3JBTkVHV05JdHd2ay9GaE81NHhHYzFhdU5UaVhzbEQxNzJpYWhl?=
 =?utf-8?B?L0lnc3U0bmdiSnd6Yml6eEZKZkxtWXBGcDhnb2ZMNlFJQzdPbHFxMTdaT0cz?=
 =?utf-8?B?WGttbCtRbUhBMHN5VFVMTi9CclNQZEJzb1ViYktNSWxXR3JWMGRqeWJVMUh4?=
 =?utf-8?B?STRlTWVTZlpCWGNjRGJLdWVKUXBnaDJRZElxQVIySU0yQVJvWkdhWTFDTU1u?=
 =?utf-8?B?Uk94NkZMWjRUR2UzSTlhN2NPUFlzN05TQWpUYTJVQ1d5dnhoRHV0L2hJUVdl?=
 =?utf-8?B?MmVwNjc1VDRxSUFyT2doTXc0RnZZdEI3ek9rczNaV01zcWpGaExFWGFKbUNl?=
 =?utf-8?B?Tkc3eThVK1hWVXJOY2lXTzBLM3BhMUtPNk1Wd2dyWHBDWEhCYzd0VEZGRmRH?=
 =?utf-8?B?UkVlZEE0cGtwZjZKVk9uOENkQjNsendEOXZYQWhyblBaeUF4dWdFSVExQVBu?=
 =?utf-8?B?VGc5aTZxdmVQQXFucTg0STFEcWxGeU41MHpMR2NWcXBMRFduVHdRYmJMdFh1?=
 =?utf-8?B?K0NGSHhzVlE0RHdXQTlyQlBWMkxNd1Q2VVJzT2E1NVRRSFBBUndtRlNaejFZ?=
 =?utf-8?B?WEVLZExxSlo1SVlaVStIQXNiQWVVekdyVnVhbStCdUtVNlBXQ2lIcm1DTW5O?=
 =?utf-8?B?T1pueDNUN0F2eWVGaFA0Rmt1ZHhBK0drNzQ2dkdaMk03R1M0WkVybk5UNG5R?=
 =?utf-8?B?SUZKWm10em1ueTRORkc0MmJ1REVPZ2E2Vno4RWllWm5QRmJ2dEJkTm9rTmtY?=
 =?utf-8?B?VmlGWDhXRGtPcFhDUGtXSWNRWWdBcXZNN0FJZE5iekdPcDhWNmNUVTVOMXQ1?=
 =?utf-8?B?TUo3ZVBmVHNxcW8vRjBVbTFEU2lDQm5LU0dKem53M002UDVvOVp4OFZUTzRk?=
 =?utf-8?B?T1d1TFFvMTNPSis1VUpBbmdLc3pzWm0wVno0amNSMkhrQzQxV3ptWVRCZmZU?=
 =?utf-8?Q?3N9+8xHmuI6SgL2g574W79NDWWv+RD8g?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dkJUYlVFT0VYMERwWXppNndITituMXNsSVVFNk9JQ0pJeDhyOC9Kbk5WTkdP?=
 =?utf-8?B?QzFMcUd1cUFIbFNmSU1KME5uaG1aMURRZjhVMVZjVFJuQWJoNDUvSmc1WXhN?=
 =?utf-8?B?aTJBSlVjbkxQTi9TelY0UzNFc3dJOFBCbWR2Z2draUtrenZia3p3NHE2ay9M?=
 =?utf-8?B?MTk4THNxZ2RnZUpVR0RsdWVmcU9BWXU2bkliZHZxdllIZWxCeTI3WjRkSGRI?=
 =?utf-8?B?d3NRbHB2VVFuWUt2T21HMXpjL21ZVm9IeWZ1Q0pnUHZnaVhmVERWTWxVM0M5?=
 =?utf-8?B?QVRrOE05NVVuWllVZi9JRjBucHZDNEl1eVRWeVAxV0pHSUFKR1dkMWJhNUY4?=
 =?utf-8?B?eGRydUtlNC9HSjRtQW4vQ2VRR1k0bDZueHFSWTc1Y2pZT3hzQzM5Q3lobWJY?=
 =?utf-8?B?RlVPYnkrTExtNUszb2hablNadzdHdXJyRDJxY2F3L0RHUDloTGNiT2Jld2pG?=
 =?utf-8?B?QkNvSnB3aEs0Y1hvNDcyTzdlckZPU0I5bnZua2s5ZzFNSWVpMmxPMXJGY3Q1?=
 =?utf-8?B?OHRVd1FLbGtOMFA5ODNTOExybXBxMG1oVXNvajJwOGcvSnBJNkpiMml1c2ZE?=
 =?utf-8?B?WEU5blpYbk1xOXJvOXVsQkVlSjlJeDc3ZVBhbXJJMkpDcnNFN3NSQU5QMks3?=
 =?utf-8?B?d0pBVjhHTkliSHhoVk5DK0x2ZExnNjlYSUNSdS9sL3l2aWhvRlRLbnljcVhs?=
 =?utf-8?B?Z20rWTJSK2pyalFFWkxmVDJLblBXTlVMTXBFQzV0OExrcHp4TXI4VlpPUWFq?=
 =?utf-8?B?NEJlMTduT1l1dEx4UldnTHVPenRtckNqRCt5dFNqWFZBQ1ozWU9GZjRrdEc3?=
 =?utf-8?B?MFNkTUIrSHZsdFVNRXlHRVZwQU9wVllmOEFhczFCUTZHUlVuNDUzS1F0MVpL?=
 =?utf-8?B?ZElOWGxaMjhWUHIrYlJGOGllbEdBVWhwY0VtUUxhYUpHeGFJdXQxdE9Pa3Fs?=
 =?utf-8?B?WG14OHoxc1VUbW9YUjk0Q0VIUmN3N2ZiMVBmYjE5bTBOR3NpRTJEZnVLdFh3?=
 =?utf-8?B?bzBwQnJSczArcW11TFpPRWVOV0RuVExQWXFYelYyR3IwYzhJSnQ3QVJHVkMx?=
 =?utf-8?B?YUFKbE5SUGgvMzZlWDFRNFNqclFLYSsvQ29hUUdFVHpqM3dCNDUxRktKTlQw?=
 =?utf-8?B?K1JlOTNWbzBrVGF1bkN6SmdXdEtQZ1ZiQmRqUENhMkpCTUtpYXpIQm5rNUR1?=
 =?utf-8?B?YlB3Z01LdXY4V2VkMGhUSFZ1WFpweldqSmJybWRTUkt0bGZERW1xZy8wS2ph?=
 =?utf-8?B?VUt4dU5lSk1pb2VrazdzSE5hNTIxdEpOV1dQTzVHRVkwMDhYMmZJUW9Jb2JY?=
 =?utf-8?B?elptOFBWOGovYS9jZ2sxMVgxSDkzTmViVzFUeDhGUjBmYWNQM3pBNWplN2Ru?=
 =?utf-8?B?Ymd5MnAyK0FaUFQxS0tEaC9LaFdtdlV2Sm1oTDlIa3UvWVIxaTVmeW9tdmd3?=
 =?utf-8?B?K0RJNkUrSE5uSlhXZ3htTTc0M2hmcVh4RnlRUGFneXJrUDZwcm1Nc3Eyd0Fq?=
 =?utf-8?B?c2hndXNzRXd5akxkNmVPQSt6Zkx0V0gzbnh1dXl6VW01SlpVQ282cHNnYkd4?=
 =?utf-8?B?czFtWmFhSTdQT0llTUdxc25RMDNTODlQMFhCSlBwNDJ6cjhnUE4yb2dOTVdR?=
 =?utf-8?B?d0VIQTJER1QrWWRpZ0p5L1lkRFlXMTliVFFMSnF3RHBubThBYnp2V2pscGlH?=
 =?utf-8?B?QTVNMDl2NWI0dWlhQ292L1pFWUN1TzhxaHdoeEZPYUFvMjVvcGUzZzNsWmh1?=
 =?utf-8?B?QnRNc3RQaFF3azNqNnZpd1FtazhhQk0wVHdJY0ZyMGVCb0hpeEJPL1lkV1hr?=
 =?utf-8?B?OTQ5U2tuN05YVUxNdmJLTkxhT0tPYlo2TlBYaEZwQUt6RnFNaUVXMG5wNERJ?=
 =?utf-8?B?QUV0V21BK25iUXZmUFR1cWQ3SEN5SFpUSWVCQisrVFE1aDVJK1ZKUTdOZlpi?=
 =?utf-8?B?TFF0ZVVYb2Q2TnZreXNLSkdSeTk0MURXcUJuMkxqcTU3d2h6Z2FtZ2Qvc2d3?=
 =?utf-8?B?WWVhQ3ZMMFZZUGhRbFFKL2p2Nnp4OTVVM205RG5tRWYvaWpRN29DY3NJczN5?=
 =?utf-8?B?MEpwZmJXL2c0QStuS2IzdTBmWkFpM3RLS1NQVWtxTjN0eTZIU0tGQmxPV2Rj?=
 =?utf-8?B?Q0FFdDg0OEJ4VTRUZmQrSThPcUtqSmRTcDUyWnRYbDlzMWRjRDYrSWgxNVFh?=
 =?utf-8?Q?TD3sH2TgdzQxvqyjaYaM8/0=3D?=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ebf7ed-464b-4f7b-0569-08dd60ca5312
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 18:27:04.9644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ng/jRwNKbfi5gU74+wdod5ediVd22C1pAEjxzX5ndWZebGAOuHQXe0xargA/+Uk2UIJuhp6xuhdczXxQiElGZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR15MB6421
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <D12134813CE3C340992EA8A7BB99FA0C@namprd15.prod.outlook.com>
X-Proofpoint-GUID: NCVVBVzZc4-uzIYZOcdB_nEQ0RCB5msT
X-Proofpoint-ORIG-GUID: NCVVBVzZc4-uzIYZOcdB_nEQ0RCB5msT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_05,2025-03-11_02,2024-11-22_01

On 11/3/25 16:54, Filipe Manana wrote:
> >=20
> On Tue, Mar 11, 2025 at 4:39=E2=80=AFPM Mark Harmstone <maharmstone@fb.co=
m> wrote:
>>
>> Commit 2a9bb78cfd36 introduces a call to validate_sys_chunk_array() in
>> btrfs_validate_super(), which clobbers the value of ret set earlier.
>> This has the effect of negating the validity checks done earlier, making
>> it so btrfs could potentially try to mount invalid filesystems.
>>
>> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
>> Cc: Qu Wenruo <wqu@suse.com>
>> Fixes: 2a9bb78cfd36 ("btrfs: validate system chunk array at btrfs_valida=
te_super()")
>> ---
>>   fs/btrfs/disk-io.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 0afd3c0f2fab..4421c946a53c 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -2562,6 +2562,9 @@ int btrfs_validate_super(const struct btrfs_fs_inf=
o *fs_info,
>>                  ret =3D -EINVAL;
>>          }
>>
>> +       if (ret)
>> +               return ret;
>> +
>>          ret =3D validate_sys_chunk_array(fs_info, sb);
>=20
> While this fixes the problem, the function is structured in a way that
> is easy to get into this sort of issue.
> Rather than set 'ret' to -EINVAL every time some check fails and then
> continue, I'd rather have it return -EINVAL immediately.
>=20
> Anyway, this fixes a bug, so:
>=20
> Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks. Yes, I did think that, but if there's multiple reasons why your=20
FS won't mount you probably want to know all of them.

>=20
> Thanks.
>=20
>>
>>          /*
>> --
>> 2.45.3
>>
>>


