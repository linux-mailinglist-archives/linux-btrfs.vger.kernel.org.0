Return-Path: <linux-btrfs+bounces-8955-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 769D29A079B
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 12:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F40111F26643
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 10:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C684206E6D;
	Wed, 16 Oct 2024 10:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="F9nx+CHx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A4EB67E
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Oct 2024 10:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729075273; cv=fail; b=evCkLAmArVS93hB8wxLTnMLbWe4BSQvcw0p/RzMBT1zkxcSTumf33zGxg4JRSb0FLSvtyHx9W1dG/3a3O8tkMRVydw1srTpoR8f9qRNb/g6oAV72PL1dWEDiF/50BOd0mb+x50Nlj5QABXqyMwcb60XuUflPPyICJbpNymmTf5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729075273; c=relaxed/simple;
	bh=VeQAXApGgdklXdfWEn8nLMzFmJ0wdMKSOdHktc/pvmU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=JmVmSvNkfH8s4zrHKOKc5rlKLmEu2FfwEgirwglpZJa5tROc/K5UYQvSzElPwCaKm7ksXhUh9dyIafSZ+oDaW6PJK7HF8/UH0BLKQ1v1WFRyPAlfm4fQOx1oM6UH1LJiMGSYsTa6ep6QF6cIzvi7zfUA9OpP3RIgRVLxYpS0Qeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=F9nx+CHx; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G6d6Vs022728
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Oct 2024 03:41:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=EY32MWiGVDv6JISpePL6UXlRBX6SqMmCWjEXrrTBtf4=; b=
	F9nx+CHxEO32M/fU3+Sjam3j8Fhr19wZIL57IPUdTLCh7RyB51YxdU0X8/CntpbW
	CEvZaiW/DKFunUBKikqShN3RoaZ2/EGwpL7d6AuVDXIBHUFC14UIbqnUIArhxPnD
	MHGSDH5jw0ivzi9piqENghX7Sn2XY5TCC0IDieP+msxYUzehSCzaZVMk2E9muNxZ
	TkzhjUqEEmqb+WrQfKMkE6zGKaFIF4zE2Jq0k+rvtFJ5DPk8mdDJUY+F9JBExBJT
	4lbRxpjxh8v8mFrf9mgufrFXa9QZ2ZAs3X6zTGEVw5JJrAjnl6/Xhtgd8+9yxDFL
	ttgai/iwwubam+ius5Cy0Q==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42a8dah41e-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Oct 2024 03:41:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LCwD6QbhqicNb73KVrcW1jzApz5LLX9u/nYUA7/DGlYY5cXuE7rzPYzt9aaJb/n9tLfV5Vjo8bVdhq9cyCscoqJwyLbudZywk5AlYUqALf5k33A6GHg9iApvzAi4R1wwGHaCsbISCNOlMHM5TeC5hQi264Izkjc5bZ/7WPBWGwsJGZAmu35QgxiAzCAehp/C+komyCLeFe4WIz/8DgUA4OXzZ8nqtHJHmitAUlojKRHKtkin1cR7HRoJ2XxVLloZIzda6Xgf3l6pDEvZcrMCb0eE9Vb+dqzfpzGxd5W/YFlQJfQ0a3RTsw84BnOBHZLl4COr5YxO1UCQENlB9iliFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlHEJR0aufOIW1RJjxxafz0DVOCA90LxFnv1oqT8sXw=;
 b=cvsipOxRcs+900Uc5MtIaAHyX53XYA69y1nTXuIbbqjF3wJxtY2iEEoEWZSZwYzk58hswnA/c+w2uYr+HUvK5o7kLt0yL/35hYHYroE+oq6L6nvuYRPlcx/HehhxStakRutg9sqIooLhZSeKukuAz2PxJOPbaD/iEdjMxHicyeiglIxfOk4YpLiZZ4zffAiAOPM9sPNpWmbwD3lR3+czsbuLxNvPC+jXl8zOPYIQytfSvHizEBEHrYaqb6/FmQtWP0P7Tow5UjY1Sz+vistkhl6RFtP5fz4hxtxbuwaZJUJCBREIYNGeOBlQqTBCfC4ukD/aE4+tnkawjgD4yes9Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA3PR15MB5654.namprd15.prod.outlook.com (2603:10b6:806:320::15)
 by SN7PR15MB5684.namprd15.prod.outlook.com (2603:10b6:806:345::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 10:41:06 +0000
Received: from SA3PR15MB5654.namprd15.prod.outlook.com
 ([fe80::bf27:429d:bb10:6bab]) by SA3PR15MB5654.namprd15.prod.outlook.com
 ([fe80::bf27:429d:bb10:6bab%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 10:41:06 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS
	<linux-btrfs@vger.kernel.org>
Subject: Re: kernel 6.8.5, bad tree block start, couldn't read tree root,
 including any of the backup roots
Thread-Topic: kernel 6.8.5, bad tree block start, couldn't read tree root,
 including any of the backup roots
Thread-Index: AQHbHxC5PZiiDoyPPEaA4NRSgMk0L7KJMayA
Date: Wed, 16 Oct 2024 10:41:06 +0000
Message-ID: <6a648270-bf74-443a-bdf2-02026b97d927@meta.com>
References: <4717ca78-1d70-4aa7-bebb-d303c4ada4ca@app.fastmail.com>
In-Reply-To: <4717ca78-1d70-4aa7-bebb-d303c4ada4ca@app.fastmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR15MB5654:EE_|SN7PR15MB5684:EE_
x-ms-office365-filtering-correlation-id: d74bdf90-ed4f-4061-2d05-08dcedcf0a41
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b1BXR25CZmh1a2FkbldLRFVteEY1MlFGQ3h4NEYvdEMvRkVPaGdZbkl4RW52?=
 =?utf-8?B?TGRrOVlpOG5wQlRVMmlCQkdNSStUWDVhYlZqVmEwa3hLMTJvOHhrVDNRaDBN?=
 =?utf-8?B?am5VaVV6WXNVNGduMmRmaG83c0VGUGs4LzNIVkFxU2M2UkxQUDc2QkpqMVNN?=
 =?utf-8?B?ZGdNazZId3E5TDBtRlRhSjA5MFpyVVp0blZ0NUk1WFE0ZVplVUFsTFg2N0tK?=
 =?utf-8?B?ZStjZVFRTDlOZDMrVHdHZGo5eEdENzdOOWx2UnpZN1RsNnRtdVM4SW1TY3V0?=
 =?utf-8?B?TDNEZ0JrL1dRNlJ3UEl0UHV1SXd2YXZFZEpma3owWGZKWVk2MWhKc2JtZlZu?=
 =?utf-8?B?clJmTTlwSXkxWkVvbm8xK1F2TktVNVM5WGNvVi9MbVdjNS9hTlQxb0hkdnMv?=
 =?utf-8?B?M29wMEgvSWpHT0VlNGNuOXIzcFJZb3JWTXBkTU1EM2F1WndSR3o5dnEyWnhl?=
 =?utf-8?B?MlVRUmNYQy9SRi95clNnczNCWStRcnNpRElyKzNxRGtNZGJlck1Vd2pvMmsy?=
 =?utf-8?B?ODJCNDlTY2VSbURLUFZuU0tPMEord1NVMUM5SFJCUENtNUEyb1E2cDVYeG0w?=
 =?utf-8?B?R2pQbDR4aEZmQ2hXN0pzOXFjSkR1c2w1akZzeitsNXorcm94MmxFc0RIWU5D?=
 =?utf-8?B?VzBVcEpmN1NUMUYvd3NyWlBUdjBXUk5leGhjNFBqTGM2bDdzeHJhQVZDdGZo?=
 =?utf-8?B?NnZ4b2tGT3ZoSkw5V295ZVcwa0krazVSdWxvQ0xLdFV2NTRTV1FlNE0vYmNN?=
 =?utf-8?B?a0dRNDZKcXkvbTVZVlZMUWw3cUdramRkVFpENWF6WWppaVlieUc3SktHY0c2?=
 =?utf-8?B?Q2E4Uy9mV09JUUk3OGUyemwyL1MrWi8rdGUrNTUrVHJSdnczcmkyemZXQkFy?=
 =?utf-8?B?b2VOVmthcTFnK0FqeStFL3VCa2l0K2ZiS3V4QllqbHI5dHd0RzVVOEdUZzVL?=
 =?utf-8?B?bG4yWFJrQmgvWXN1bDNNVFZMeWRLWjAwU2IwaTcxbCs3ZXF2cEtxbGNXbWsw?=
 =?utf-8?B?MTlzcC81ZG0ybEtqVWNSdHRqN3V6Z2cyR1ZBaDhXakxPOVAvSTRhZzlrTTJY?=
 =?utf-8?B?LzU0N3BKN3hseWpzU0FTM1ZFdWVWcjhJR3kyeTNrOVhnVFV0TzBJb2lxbjVi?=
 =?utf-8?B?YVc1aHU2SXRhc1RoeGpVL2UzbE1UTmJ5MVhhWlR0NXJmbDRXa25DOVVmZHQz?=
 =?utf-8?B?ekZZR3pXcCtUdmNYVFpBQjVsWFF2UXNHajdVT0JjUksxaTBaTHhGdWtVQkdi?=
 =?utf-8?B?STNrSm04S0VtcXRkNWVLOWpIaG5XM1dUSWVzY1psdlBIbG1tVHFvNzlXdjg3?=
 =?utf-8?B?V0d1MFVVWUZsRFZkQXpoRHFXL3dYN01uby9paWY1OEFWK1FqOEFsdHBoYS9P?=
 =?utf-8?B?WFdSQWZGR1llSWw2eHRicExyRG5hOTV4UENRNDE0UnROMlpjOVIvc1RiWTBa?=
 =?utf-8?B?bllaY2VSNlhKUkNZdVYvdnJ6T0V2WGNEaEQ4U2drNWx5UW1qZnBta1hvcmJO?=
 =?utf-8?B?M0lPeXJtTXc2ek9zaXpWUm5NN3JBejNNWGRHbXVCcEJPT0huc3czSjd2TEZZ?=
 =?utf-8?B?VEl1L0xvelRTbXlGYWNicm9iQ3R5eEoyVGh2TGZiYWcvc0ZxeTlHNzJEOFR3?=
 =?utf-8?B?NWVydGNWekkxbXFaeGt1U1V5YzVQbTBURVV2cCtqaExDcEZVSzlIOE5QZ0hw?=
 =?utf-8?B?SHZObE9YQzJKYlNsL01hUzF2d0FnQ05Xd0JnQktXcXEzaTRzRW02M2dBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR15MB5654.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M2hQVThXR2FQNzFVRC95S0pTYXFEU2xadENxeFMzYUZwRjdteVhhc3NZUUho?=
 =?utf-8?B?VE5KZWhLdyt4dHlhMGFjU25vTm82c0JablhwT2ZEdjMweDRneGdxMGZGZlhy?=
 =?utf-8?B?RzVTN2FkZytOa3FxM0NLSUdncnhPS3FzOWZtUkJRK3NaUTdwQVZrZUJHOURN?=
 =?utf-8?B?aVJScHNZL1RJZTF2bS8zeFpBUlhmV2sxc2t3TjZ0SGMxOW5QQzJpUFVRWFd4?=
 =?utf-8?B?OXJCN0ZJZjRWWGRlenZpcjUyQVphMEpZTDJpbzJ3d3dZUlg0RTltZ2NGbmU1?=
 =?utf-8?B?SzZDNS91amlHV1NxKzNKUktKZkszSkM2TTdaRk9jbHRYZjVvTTd5RzNSU2Zw?=
 =?utf-8?B?TU5VaXV2RGU5OFZNWTRXQ25SUlRhL1M2dlM5R3dqWVJ6ckhONndqL1BRZ0Rl?=
 =?utf-8?B?R1EzMERxOXVUSlhmajVsSktsQzBjQldoUFUyOEZOUFJUa28xaHdLaTJMdzJW?=
 =?utf-8?B?NWhlNm9PVlBoKzJuTWQyZUxtT0FJS3Y4dUtqTmRFMTlpRDBmNFNoazdUdkhl?=
 =?utf-8?B?bmw0Qzg0eFFnOVlwanRuV3ZZRlREMDlLb2ZCU3JFSHF6T1p0VnJzVXk0UTJo?=
 =?utf-8?B?MFVTdEFROUFTeUt2L0tDQUhnaFBCK1M0azQrRmZOeXlCVTlxVnExSTE5SW1m?=
 =?utf-8?B?OTJrMVpEZFgvSk50aElzSHdOV0RnV09kWjV4ZHQ5WlM4MGpYK0M3Tk1ySVEr?=
 =?utf-8?B?WWhHd3JCeEowR2pBWjVoYStjak1FQW5tVzRWb3A3cmdwNEFmdWgxTUo1cGVU?=
 =?utf-8?B?cXNGSVNIdS9YNERSSWd6dVNBVHJDSklwUUkxNC9TNHNnQXFZZ3gzamhoSndG?=
 =?utf-8?B?MDR1VTN2VkQ4SDI3UTRjM1JhNGp2aVRlQXEyMk42VElPZkVKYkczdXNvQito?=
 =?utf-8?B?aFlyanJMQVVwRDNwNmxSZ1MwVHAzbW10RHhTKzBrclZKV2dQVXdIL1JVRXNN?=
 =?utf-8?B?aU4yMi9ZT0UyNWhnN1NUZHZmempTSVRjcFI4UnN0YUF4Uk1oa2laNGdjRFd6?=
 =?utf-8?B?cVpkZzBXWnBMY0hPMUdsWXJoVjlWdk5RYW8zeEJvMnVqZkM4T21IcG4vQkZx?=
 =?utf-8?B?ckhFcmF1VWpuOFdvS2NjYWlZSVNmWCthZWt4Ykw4TzRKWE5JK0h4bHU1S0tM?=
 =?utf-8?B?c2RTcUk4ajM1NFd6eHBML3JqVXFyMVhvYnVuSDVkM0xNV2lPZ1BSMHl5TU9u?=
 =?utf-8?B?VURSd0h3V05CT2tNZWlSZWtzdHlYTk8vMmI3cWF1TmIyS3ZpcWNyNHo2Kytj?=
 =?utf-8?B?ZjBOUzB0RWFvUlQ0UXRGNS93L0pzbk43U0lqYTVoU3MxNmkrR2xKYnFuT2M1?=
 =?utf-8?B?c3BWd1Fqei8wUGpKNU5ydWVmdmtKRllxdFp3aEcwNVczVUwrMnY5aEp0ZU1t?=
 =?utf-8?B?UndmWEdtb0RrRW1zV1o5dTFvdEVsMnpubGhEV3M1b29HZGE1d0xNRnRWN3VM?=
 =?utf-8?B?SHhCQ2tEdDhRWmtla2JZbENUTDE0bTkzRTdJd0xKdTVvTEsyd3RuOS8rVVZy?=
 =?utf-8?B?bzF6dVpvazlVREg3aHM4WU4vUHZqdDFZSHdWOEZKcTYwdkhGWTRSS29NcmxT?=
 =?utf-8?B?M0JVQW5LTDB0aStJSTNtZTN1b0h3ZWhOVGNROU0vdGJiVUpaOWkvOEdNcUcr?=
 =?utf-8?B?TC9iV216OFo4ZDNuOFg4NVJ1eTZZK1NBUmhWVjkvaHZsemYxd1YwbjFITGZD?=
 =?utf-8?B?aUZnVHdJQ0FYSzVueDEybHFhQVZqVlIyejk1SS9UWEwrZmpwYlJ3NEFwUmcz?=
 =?utf-8?B?WFFya3ZsL1pJMlBKNlV3MStXbEgzaUgxcjY4RURIKzNKU2h0aUtGYTFwVnRX?=
 =?utf-8?B?ajU1RXJteWRlOTIrbmkvMmtNS3pWemQwa2VFYU9uY0lDWG9qb21YNnFKNkZa?=
 =?utf-8?B?UVBVNnkwd0NHZzRxUzd6ZFNERWFVL0ZHaTQ2aHJoQkVCSE5OczJCTy9rb3dT?=
 =?utf-8?B?OHVJc3d4M3lRTVE1R0RGODhZZmJqbG1ERW1Fb05jaTlQSVMyL1N5anUza3JF?=
 =?utf-8?B?VDVxc0VEYVk3Rk81MkRIaU1hSW1mdjZQRFNkVlFndnFtRGNJUnNmb1p5SjRx?=
 =?utf-8?B?OGFCdHQ3djJnWjdoY2lYVnhmdVJVMWhJeUI1RzFXWEJWVXdXT3p0K3o0R3JV?=
 =?utf-8?B?dFVsNElsaW9BY1pLUVZVRTRoNnVCMWdhRUw0L2RNQ29ZT3pjaHB0c1BWQ3hh?=
 =?utf-8?Q?aEb3M5MVBnbyJZ71mDFmAhk=3D?=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR15MB5654.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d74bdf90-ed4f-4061-2d05-08dcedcf0a41
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 10:41:06.5380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YRZcFZI8qTS986fxaw6ufr5glfC9cuQbfHUC8LbxaRD0ge92sU/iM08FGaYJLPr7Z/ktE6ZrnWdUOhZJmr+I1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB5684
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <05B9DD98955A3E4D9524D32B6C019EBF@namprd15.prod.outlook.com>
X-Proofpoint-GUID: 6Ly03KPwT1sUzkzjNK9NCNf1aIIDY197
X-Proofpoint-ORIG-GUID: 6Ly03KPwT1sUzkzjNK9NCNf1aIIDY197
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

This looks like a disk error to me.

This was interesting though:
 > checksum verify failed on 808009728 wanted 0x00000000 found 0xca72d647
 > checksum verify failed on 808009728 wanted 0x780fa0fd found 0x2ce4b8af

Why would btrfs check be reporting two different "found" values for the=20
same block?

Mark

On 15/10/24 15:43, Chris Murphy wrote:
> >=20
> Fedora user report:
> kernel 6.8.5-301.fc40.x86_64
> btrfs-progs 6.8
> Kioxia NVMe KXG80ZNV1T02, firmware 11304102 (used by Dell, seems firmware=
 is current)
> https://urldefense.com/v3/__https://discussion.fedoraproject.org/t/stuck-=
in-emergency-mode-after-force-shutdown/133615__;!!Bt8RZUm9aw!6m27MG8w3IYorE=
7KW3kmXdlLaSPpbskKASUnTigu4mMYKmsfvKrUgGv1nB13_24XicYXvDPOt1cF_G_j0w$
>=20
> Description:
> User reports system was suspended, and wouldn't wake from suspend. And po=
wer was forced off to recover. The problem appears on the subsequent boot. =
This post contains the most relevant photo of kernel messages showing the m=
ount errors, including both copies (DUP metadata) of all the backup tree ro=
ots.
>=20
> https://urldefense.com/v3/__https://discussion.fedoraproject.org/t/133615=
/15__;!!Bt8RZUm9aw!6m27MG8w3IYorE7KW3kmXdlLaSPpbskKASUnTigu4mMYKmsfvKrUgGv1=
nB13_24XicYXvDPOt1dplAlvvg$
>=20
> Supers all look good:
>=20
> superblock: bytenr=3D65536, device=3D/dev/nvme0n1p3
> ---------------------------------------------------------
> csum_type		0 (crc32c)
> csum_size		4
> csum			0x79e5611c [match]
> bytenr			65536
> flags			0x1
> 			( WRITTEN )
> magic			_BHRfS_M [match]
> fsid			2c03e734-1b38-49e9-991a-1f85b9cc97f7
> metadata_uuid		00000000-0000-0000-0000-000000000000
> label			fedora
> generation		38863
> root			808009728
> sys_array_size		129
> chunk_root_generation	32970
> root_level		0
> chunk_root		24854528
> chunk_root_level	0
> log_root		0
> log_root_transid (deprecated)	0
> log_root_level		0
> total_bytes		1022505254912
> bytes_used		81702764544
> sectorsize		4096
> nodesize		16384
> leafsize (deprecated)	16384
> stripesize		4096
> root_dir		6
> num_devices		1
> compat_flags		0x0
> compat_ro_flags		0x3
> 			( FREE_SPACE_TREE |
> 			  FREE_SPACE_TREE_VALID )
> incompat_flags		0x371
> 			( MIXED_BACKREF |
> 			  COMPRESS_ZSTD |
> 			  BIG_METADATA |
> 			  EXTENDED_IREF |
> 			  SKINNY_METADATA |
> 			  NO_HOLES )
> cache_generation	0
> uuid_tree_generation	38863
> dev_item.uuid		0aab31a2-3c63-4c6f-bc4c-8f4b4bad66ac
> dev_item.fsid		2c03e734-1b38-49e9-991a-1f85b9cc97f7 [match]
> dev_item.type		0
> dev_item.total_bytes	1022505254912
> dev_item.bytes_used	89145737216
> dev_item.io_align	4096
> dev_item.io_width	4096
> dev_item.sector_size	4096
> dev_item.devid		1
> dev_item.dev_group	0
> dev_item.seek_speed	0
> dev_item.bandwidth	0
> dev_item.generation	0
> sys_chunk_array[2048]:
> 	item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096)
> 		length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
> 		io_align 65536 io_width 65536 sector_size 4096
> 		num_stripes 2 sub_stripes 1
> 			stripe 0 devid 1 offset 22020096
> 			dev_uuid 0aab31a2-3c63-4c6f-bc4c-8f4b4bad66ac
> 			stripe 1 devid 1 offset 30408704
> 			dev_uuid 0aab31a2-3c63-4c6f-bc4c-8f4b4bad66ac
> backup_roots[4]:
> 	backup 0:
> 		backup_tree_root:	803454976	gen: 38861	level: 0
> 		backup_chunk_root:	24854528	gen: 32970	level: 0
> 		backup_extent_root:	802881536	gen: 38861	level: 2
> 		backup_fs_root:		30572544	gen: 9	level: 0
> 		backup_dev_root:	73252864	gen: 36528	level: 0
> 		csum_root:	801767424	gen: 38861	level: 2
> 		backup_total_bytes:	1022505254912
> 		backup_bytes_used:	81702764544
> 		backup_num_devices:	1
>=20
> 	backup 1:
> 		backup_tree_root:	804864000	gen: 38862	level: 0
> 		backup_chunk_root:	24854528	gen: 32970	level: 0
> 		backup_extent_root:	804093952	gen: 38862	level: 2
> 		backup_fs_root:		30572544	gen: 9	level: 0
> 		backup_dev_root:	73252864	gen: 36528	level: 0
> 		csum_root:	801931264	gen: 38862	level: 2
> 		backup_total_bytes:	1022505254912
> 		backup_bytes_used:	81702899712
> 		backup_num_devices:	1
>=20
> 	backup 2:
> 		backup_tree_root:	808009728	gen: 38863	level: 0
> 		backup_chunk_root:	24854528	gen: 32970	level: 0
> 		backup_extent_root:	806535168	gen: 38863	level: 2
> 		backup_fs_root:		30572544	gen: 9	level: 0
> 		backup_dev_root:	73252864	gen: 36528	level: 0
> 		csum_root:	803799040	gen: 38863	level: 2
> 		backup_total_bytes:	1022505254912
> 		backup_bytes_used:	81702764544
> 		backup_num_devices:	1
>=20
> 	backup 3:
> 		backup_tree_root:	801734656	gen: 38860	level: 0
> 		backup_chunk_root:	24854528	gen: 32970	level: 0
> 		backup_extent_root:	800374784	gen: 38860	level: 2
> 		backup_fs_root:		30572544	gen: 9	level: 0
> 		backup_dev_root:	73252864	gen: 36528	level: 0
> 		csum_root:	797999104	gen: 38860	level: 2
> 		backup_total_bytes:	1022505254912
> 		backup_bytes_used:	81702764544
> 		backup_num_devices:	1
>=20
>=20
> btrfs insp dump-t -b 808009728 $DEV
> btrfs-progs v6.8
> checksum verify failed on 808009728 wanted 0x00000000 found 0xca72d647
> checksum verify failed on 808009728 wanted 0x780fa0fd found 0x2ce4b8af
> Couldn't read tree root
> checksum verify failed on 808009728 wanted 0x00000000 found 0xca72d647
> checksum verify failed on 808009728 wanted 0x780fa0fd found 0x2ce4b8af
> ERROR: failed to read tree block 808009728
>=20
> btrfs insp dump-t -b 80486400 $DEV
> btrfs-progs v6.8
> checksum verify failed on 808009728 wanted 0x00000000 found 0xca72d647
> checksum verify failed on 808009728 wanted 0x780fa0fd found 0x2ce4b8af
> Couldn't read tree root
> checksum verify failed on 80486400 wanted 0x00000000 found 0x973bc4ee
> checksum verify failed on 80486400 wanted 0x00000000 found 0x14f430d1
> ERROR: failed to read tree block 80486400
>=20
>=20
> btrfs insp dump-t -b 803454976 $DEV
> btrfs-progs v6.8
> checksum verify failed on 808009728 wanted 0x00000000 found 0xca72d647
> checksum verify failed on 808009728 wanted 0x780fa0fd found 0x2ce4b8af
> Couldn't read tree root
> checksum verify failed on 803454976 wanted 0x080fd04c found 0x4431a259
> checksum verify failed on 803454976 wanted 0x00000000 found 0x3be418cb
> ERROR: failed to read tree block 803454976
>=20
>=20
> btrfs insp dump-t -b 801734656 $DEV
> btrfs-progs v6.8
> checksum verify failed on 808009728 wanted 0x00000000 found 0xca72d647
> checksum verify failed on 808009728 wanted 0x780fa0fd found 0x2ce4b8af
> Couldn't read tree root
> checksum verify failed on 801734656 wanted 0x080fd04c found 0x69344e69
> checksum verify failed on 801734656 wanted 0x00000000 found 0x818d4e83
> ERROR: failed to read tree block 801734656
>=20
>=20
> But I'm not sure where to suggest the user go from here since none of the=
 tree roots can be read. That seems like quite a lot of problems all at onc=
e to different parts of the media.
>=20
> thanks,
>=20
>=20
> --
> Chris Murphy
>=20


