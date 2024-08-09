Return-Path: <linux-btrfs+bounces-7068-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A45EA94CCF9
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 11:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886C51C20D64
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 09:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BA5191494;
	Fri,  9 Aug 2024 09:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="gPyQ9M7w"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0715EBA41
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Aug 2024 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723194597; cv=fail; b=n9ZJ3oB9hzWEyiRDUhjzFqGtv056cCWKuYxdAaPELg5u0qN44kSB8Y0f7gu7zlcNA3Mcax3qfiG5jDozZUHEv26puz39GyZyzymbgD1Wg0HdZihskxmHy2GsjNGuPEGbfrgYav02jomqXpAm5iLJLPLIvyRHXvrGwPHcfzWx/ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723194597; c=relaxed/simple;
	bh=EkMBmb/AvuCFJjkH5KoLn7Tt/V3homCuXaRVfWECxFY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rUEG2mN8zP/GyIdWLyZeXmDOY8MxgFxhFS7qUTrr7/2KqQkpT1uN0X6vxoIg6u4FwShm3NEpLmVS6toiBsO/f/YKnJOMuWzBSPNBKfFPl/2SaT2nMpcwz3ZXxfZVGEmBU4G4XEu7y+FeG+Fx2bFiUbtkRwFfVasiEFxe5cxUL+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=gPyQ9M7w; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 478Nupab025159
	for <linux-btrfs@vger.kernel.org>; Fri, 9 Aug 2024 02:09:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:subject:date:message-id:references:in-reply-to:content-type
	:content-id:content-transfer-encoding:mime-version; s=
	s2048-2021-q4; bh=EkMBmb/AvuCFJjkH5KoLn7Tt/V3homCuXaRVfWECxFY=; b=
	gPyQ9M7wjPvcJGF62kroC1xsCzNtmCqy3f84kvN7gDi0PutqsdAruP8DPO2k1nhy
	DdioE6FoKzCV9DTYkAG2g8V6FDwWWdFw/+Cmix//7/ypyH+CvlzWnnNF7PD6/Qla
	sGu/ujGkXTeO2Xje29+Wu47tfaae+x9dvh6ZToa+uR0IzePSjWZ2QA8k3BvZk4at
	plhA1TQ7/Wg7txk2sfY+7trBmhbqH0j2rG1g3XwiU2wVT6LloROIMigJHvlAV6oQ
	tqN4IMeG9NrjIZyY3lhby7nUzw+eDYSA6PD0+uJ5nzyptdlSSzE4Vh7zC6n9V8i1
	czjC4Fjw1GWsMLqmO6pPgQ==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 40vjdrsxj1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Fri, 09 Aug 2024 02:09:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ku0tQGvfBZX0eKqTE8SKJihjjX+3h+YII9IN51yEFLTmTnvTpv/dTe4puIUkaaE9Z4E/MmHN37kbIdfS7Gpq1lzaVkiTzQbtkK1lWluLle/XRvifUec4sAI1VbEy14BXKysbbOZu0DTMUT3FzyLn4QawloMWK7Gic865QqjykbpnUGsFXXoZ+p2jkMO5mTWrplTJCtfnV/WOwyMb/hMY0/zjVgK9WwEgoSeRDsnbk8rctCF5Bplmmn+LOnDRicJgmwTSWTlVv4Lx6XDCucqqoA4OjEWUGGhAGdybBIivDYjTslutsCLchGZeDO/C3Ohjy+oCcJnLum1asDzyUS4EMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkMBmb/AvuCFJjkH5KoLn7Tt/V3homCuXaRVfWECxFY=;
 b=tKTF3vAoY7c7xZJolM0bwXP9UD1mkDhtgNx0Sb6ec35gDpwrGrV3lCE9TfkpJjZF3YCSvazcq/JjUothpWGV8jpB63wOVvuK1aCpHFC0LqCqQb2YEv0/ShvZpQN8/1DUo6C9D1D3gX5LySygY7DBSTfrKZE/iYLwXxW8wrea3/xW3xs6wvs49YGWLw6NUlevV51NKfzFR4YomJt/MwrjsJJzbKXpX89mrQPrFD+zR2SXuFHLiOGcgJeiMowuwAXFOBYuSa2W0oQPkhJZwZB9AG13/UuSWrVtWlcEqssrEKbLBP25js1PViIzD8g0Wgw5+Se8k+9T5LTpB1tt1PX9WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by DM6PR15MB3846.namprd15.prod.outlook.com (2603:10b6:5:2b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.17; Fri, 9 Aug
 2024 09:09:52 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%2]) with mapi id 15.20.7849.008; Fri, 9 Aug 2024
 09:09:51 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4] btrfs-progs: add --subvol option to mkfs.btrfs
Thread-Topic: [PATCH v4] btrfs-progs: add --subvol option to mkfs.btrfs
Thread-Index: AQHa6NzkMybiEKjqSUqwug5dkAqnGrIcYyKAgAE1QoCAAFVoAIAAuEKA
Date: Fri, 9 Aug 2024 09:09:51 +0000
Message-ID: <ac0eb5ba-a70b-47ee-acb2-75773ead2627@meta.com>
References: <20240807151707.2828988-1-maharmstone@fb.com>
 <80981aba-5434-42d6-9180-5ecf2625b3ba@gmx.com>
 <231c34dd-43fc-4829-82d7-94a6f9886691@meta.com>
 <722d228d-7607-478c-b531-54688a74ac3c@gmx.com>
In-Reply-To: <722d228d-7607-478c-b531-54688a74ac3c@gmx.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|DM6PR15MB3846:EE_
x-ms-office365-filtering-correlation-id: b3f754b5-a7c3-489d-3b66-08dcb85306d9
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U1ZNdTJUUVhOZ09IaTJrcmVKY25NcUs4enNvaFFNaXNYOGpGMkp1eS9wOE91?=
 =?utf-8?B?MXZWM2xBS3hYVDZjak1aRlRWTzgxeFM5RGxHYXRJRHh5NXNUam00TGJWRlRk?=
 =?utf-8?B?Z2Y1cDFsZ3lRcTcxUHdWSmU5VUZVcllvTmxjMFVvczBUQUVVekJrUURvZ3R5?=
 =?utf-8?B?TzdiNDV2RUF1djJtQmhNaTBwekN0NklhQzVuek1PWlNtSUR4Ym9ncnFrVitT?=
 =?utf-8?B?SS93SGtWZk13WjgvRmxKbkVyZTFhWUFlb0haQjNoWUE0K1hwcGMweVh0cGtu?=
 =?utf-8?B?ZFRBd0xnUDRhZU1RYXM4elIzM2s5R1o1cjFRNGErRkl6VWhIV0VvNlNNMWFl?=
 =?utf-8?B?V0d4TVBEekdkMkgrREk3enhQRFJZeHRBbkV6QUZGK3hmb3UyK2JIM2ZJbXlX?=
 =?utf-8?B?NWtKQ0VRNUh1Mk1IS1JCd1VyQWxoMHFWbjFVd1BhQjA3aEQyNGYvbXR5Y1BK?=
 =?utf-8?B?TkF3dnZ4eTlSNVJ1TzRyc0JMbzZPeG5HaVJQNU9HSDdJanFqUXRINU5UZEtv?=
 =?utf-8?B?WGd3TUw5YkpSdFZhWFhyV015QUxUWjJqN1psWUYyNHdyYVlybFhCMXdZeXFT?=
 =?utf-8?B?ek9nQ253NjRCWXFYTkhrRWM5UVlRZzFUZmQrWHM3bnZERnFKdWNUOGFqMzNn?=
 =?utf-8?B?VGVvT2xzNGtaY01qWlhlTVozcnFXUUM5bGJvYkowTnFCWDE0dDIzdWVIbHp3?=
 =?utf-8?B?eEZ5eDIwV1VXNTQ1VFlzR0FiZHI2bm9ZUDJzeUNGNzB6cVlJeGt5MlR6Y01i?=
 =?utf-8?B?STI1eEJ6NzFzVFJSaU10cm96eEpSQmprMHNtanAyY0pxTzAweHdGdkM4Y1BT?=
 =?utf-8?B?RjliQVBXblFhQXJNQzVySTVpbjBSWkN6akxiVFJVVjNncjdMMHhXR3phWnl2?=
 =?utf-8?B?S0tjeDBOUVV3N1FuclliYW9oL0c0ckdrek90ME5LSnMrT3dOcVNwT1NuSlB6?=
 =?utf-8?B?QXptMGU3UXJrbWhYaDRUWXhDYUdNLzVBcGw1YzZ5c25VMGFKaEFuQ0pIVGtv?=
 =?utf-8?B?WnNBcEkxU0NDb2U3ZDltRlJ0Kzk3OU9EQmovcjIxNHg5V3U0Y2xaSU1yNDJI?=
 =?utf-8?B?alBVNUJWYlVNU0psTWF0QWpmQk9OdUZ0MGhjOVJUek5pSFhnMG9BMFEyZHJr?=
 =?utf-8?B?a0gyNjJnYWloRyttNWVBTnJDWGtKdXRlOGJFZ2c3bWo2Y3R2T3gwRHNLTE5K?=
 =?utf-8?B?bGhHd2VuQ3BMU2NsWmJoSXFFUFlYN0xDNTdOeWJBN2hQTllpOW1yUisyQldV?=
 =?utf-8?B?dVp1b0wzTHFFYjRlSDl5aXlReE00a29ZWFplNUZTYm0wMUFNUlR2U3F5YjMr?=
 =?utf-8?B?ZFQxajQvdXQ2M1M5TEo2NzZJczBHa0lOVmJKYVBUQkltbnhDSE4xVjRxbWxa?=
 =?utf-8?B?T2FhMnB1MXVwUTdWd2l2VFp3UGU3dzVwbjFvdExYV2ljRXR2Y3lHLzBNSEhK?=
 =?utf-8?B?MW13V2FKQXZOMGpFMkc4WmVWTlhZTitIYXY1Rk8rR201eE90eGN4U3RsV2NM?=
 =?utf-8?B?dEJtNWZQVlAyM3pQelc0bGNha2RCZVFrY3ZzWDc5bGMrSDR3bzB5Wm9JSGpa?=
 =?utf-8?B?a1NUZEF5SE9LdWZ6aUh2VTZoVmt1alR2RHBVU0hoMTU1UUpXdmtGM0lJUlJR?=
 =?utf-8?B?SDdqd2hrV0dWbEtTbXQwVzZBWk9TcWdQU3dGM1pSYUZROFlRT0RLbTh3ZWdu?=
 =?utf-8?B?c0d0aHYrbS8vTEhlQVlKczJzMWlBcklzV080ZVpQM2w5ZDQ4VFBKZ3B6cTlo?=
 =?utf-8?B?YjFvQlluWlNmbkVUOUUrVzNZN1lJVU5TMlk3M1l2TlNpSnlDajljOHROY2dO?=
 =?utf-8?B?N05rV05TWFVVaUtXY1pJK1Nmdm5yQUZiSGhhY1ZNcytIejRjaE9lMlc0UVNM?=
 =?utf-8?B?NHpGMk1IYzk1dFlleTUwZVcrK21ka2JWV21tdjRCVVl6ZVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R1BxNkdGQ2NWZGg2UzZqK091c0Y5UEpKNk5yUlg4dTVMZlIyandhOXl4UEM4?=
 =?utf-8?B?eDFtRk5JeDVzK3dkV3JhdUpCSjZtWDl1aXpnRk94TFBBejdGTUxSR2xzK1dj?=
 =?utf-8?B?SndMa1NHN080VncrOVM1VklQcTk2bmd3OENEWmptcG1UMHM2UzEvUFRMbHpr?=
 =?utf-8?B?NjJ3SkU4Z0lQOVh4UmdXL0dzcFdwbmIxd1E3NDZtaFE5RjdxdE44NWU5dWFj?=
 =?utf-8?B?Y3R6ZmRIcVJ6c3BpUzVURXg4US9lWHhPVVZTQ0NRd2JKTXZZcTlDaC9KNlQw?=
 =?utf-8?B?bDJQeWFnZG1MWGRGT2lIcEdTNUlhTGE2UWg4VlZBd1A0M2hua3cySkpvejBY?=
 =?utf-8?B?amlCaG9uSVdHQjZKZ2p3Qktid1hNanBzUlI4U1J2VHF6YTVyNUdDNEV6cjE3?=
 =?utf-8?B?bUZUdXQ1c1F6UVNvMlJFUEcwSUxmcFptMkVjS1BDbU83MGFSdjY5bjlFNUpZ?=
 =?utf-8?B?VVoxOGprRmI5MFJHNEZqTDIzMnVCZjhhdnFqNTBmTmY5ekdnN29KU0lORFdQ?=
 =?utf-8?B?eXZXOGNvTXlJZmcyNlB5endsUUVabCs0bXJUdXkveE9Ta25lWDFhMTlBNVhp?=
 =?utf-8?B?aGlhdE5FeXBDSyt4OUlzcTMzcCt5YVQ4WXJKVGExQTFnRWdIUmpuVkF5R2pU?=
 =?utf-8?B?SmtYTU9xMkt1eGVMWm16c2FrK0gzY2xiNjFybk1lSE5LTWFkZ1dtOFh6bHhs?=
 =?utf-8?B?T1puQVFXbUdReXI0SVY5OTRIbWR1blQ1QW5Ya1JPNEdnQkY0MFE5eFc3bnYv?=
 =?utf-8?B?ZFFkTEQ1N1FkR0Y1UGFZS2lPSkE0bmxtWGFKUnZxVmZBR1JSb3RMZnhBVEZY?=
 =?utf-8?B?TnZ3Sis3MWRXTzYvVXVTZ2ZES0g4MDl5Tit5Nk1weFZpUjRURXkvYW9vMDk1?=
 =?utf-8?B?RmcvRTVkYVlkdXpwY2JNVkpESG1nUEJhSldmT25jODhjb0IyTjJkcm5OVENE?=
 =?utf-8?B?VmRFcmphWE9BQmJjUnA5UWNRZVF2a3VIbDdJTTV3Y2tJTW1wSER4eG43UUJQ?=
 =?utf-8?B?NVVqMDZZQkpYakwzakJwQTdrM1NYQ2s5M1hjVW5jaUFZdE5ZU3Z3aG04OXQ1?=
 =?utf-8?B?N0U5MzRpT2JvVTdkSXpNemtVQVNnenY2Szc2SmJSRkFFV29SVHBwb0l2Tzc0?=
 =?utf-8?B?bERmdjg2T3Qvc1MraFZKcDlKcE1ZUlZIU0RlN0NFeTNEeHZMWVNXeGJkaTdS?=
 =?utf-8?B?OTZTalN3R3VyTEFvbEhjaFlYT2JFOU1iaGRJYVBJRkZSNjdiY2RZd3NWR1B6?=
 =?utf-8?B?bmhOSHZvb21LT1EzM0h2ME9MYS9MOXI5YXZqSG1VaFMxT0hxOUg2QVVrRlJ3?=
 =?utf-8?B?RHhGTEExSG9PNUJ2cytJZ3FUaFhzUUJyOWNYS0JjeGVSd3hPVE1WRm1Scmx2?=
 =?utf-8?B?WmMzM1BOOXJ3ajdoekZlYmdZZXBFekdjTmc2NWRYODZIWmFUdlN3L3htYjM3?=
 =?utf-8?B?ZHJyL0p0QTEvczZhdk5xdWdpbytIWUNCaTRmcmNualhZLytmbDVTbUZCV0hI?=
 =?utf-8?B?R0ZTb2gvZ25QOUwzQ2tYcXhFYS9mekVlQndJd2lTcTdWRjhhR1AxTEYxeTVD?=
 =?utf-8?B?OGowU2RYMTc2azNWbGxLWWdOR1dFZmppbi9FTXlaT1JEaEFmaUFSdzIzTWVj?=
 =?utf-8?B?RGxJQUpHc1RFbVcrSUZVVU9LWUhjM2dEajNUVnNPZGlQRFFJRFBUcURYN2dY?=
 =?utf-8?B?RHpySmptV3ROaG80bktaSjJCeWl6OFNUcldPRW9zYUJHZjBYaHpPS2c1TSti?=
 =?utf-8?B?cFhvZlV1UW1NVUZLSDVBdG5wVUxiMC9NY0FieTZydVpMa3B1RURoZjg3cHR2?=
 =?utf-8?B?ZzEzSzVpaW1iWTBNL0xvN3g2dElCZ2JYb3U5Mzh1U01HMEtQSWdKM21rYW9x?=
 =?utf-8?B?SXNDcDJGbG4vVXhrbDEyWmxKeDhmTDZIS1BQSmFsVEthT2xzYzVvam92MDNV?=
 =?utf-8?B?NmhZVjA3anM0ZmNYMHB6ZENRZ0hTaXBmWlVDbkNZZmxIUUlEUXZQNVMyWU1Q?=
 =?utf-8?B?R3JZQ1E1RmhuNHcxRzIwSDVyb2FZVUNxTHZGRHRDUVpNUjN1MC9UZEpMbTU3?=
 =?utf-8?B?RDc1MXd6emQ5cXJwREVpSjlueUhNVGVEcHpJcGVHMUV5OXdPNmd0aW94MHV5?=
 =?utf-8?Q?NHOgjwxX+nLFScQzfLvs0ttpP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8775290E1C5F1428A5F5AF5078B94E6@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f754b5-a7c3-489d-3b66-08dcb85306d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 09:09:51.6250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HRV8gSFtznMs/TuRK606EADTwX0pF9ej0pi+9qCm7Lnxej0wHFiqAY6hZACR4xzMZkl4JwiyGYGz8nvsQJMFKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3846
X-Proofpoint-GUID: hO2zPBvwlajqcvb84xYVExEc6Dam-J3j
X-Proofpoint-ORIG-GUID: hO2zPBvwlajqcvb84xYVExEc6Dam-J3j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_05,2024-08-07_01,2024-05-17_01

T24gOC84LzI0IDIzOjEwLCBRdSBXZW5ydW8gd3JvdGU6DQo+IA0KPiBXaHk/IFlvdSByZW1vdmVk
IGl0IGZyb20gdGhlIGxpc3QgYW5kIGZyZWUgdGhlIG1lbW9yeS4NCj4gDQo+IEFuZCBhdCB0aGUg
ZmluYWwgY2xlYW51cCwgdGhlcmUgd2lsbCBiZSBubyBlbnRyeSBsZWZ0Lg0KDQpPa2F5IC0gaWYg
eW91IGNhbiBjb21taXQgcGF0Y2ggdjUgdG8gdGhlIHJlcG8sIEknbGwgc2VuZCB0aHJvdWdoIGEg
cGF0Y2ggDQpmb3IgdGhpcy4NCg0KVGhhbmtzDQoNCk1hcmsNCg0K

