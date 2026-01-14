Return-Path: <linux-btrfs+bounces-20510-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C02EAD1F501
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 15:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC56F30119FB
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 14:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1370228467C;
	Wed, 14 Jan 2026 14:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=belden.com header.i=@belden.com header.b="opCzXiAt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00015a02.pphosted.com (mx0a-00015a02.pphosted.com [205.220.166.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557A81B532F
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Jan 2026 14:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768399479; cv=none; b=L4oKzeBZTmTPnopX4BFF7PZ1Eb3A2recoY4yvr/9SjDUoxn8Y03pLvoV3QpwUaQc3kKRSlO8XguGHCTP8lkewmWYwAA16MaoLrju0QAfQNP8E6jeDr5rW/8SEN4zqsoISFH4YEq8CY+SzWeLGqtTxD3L0sDz/AYY7jz80hg1WLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768399479; c=relaxed/simple;
	bh=6L9aIyNE+rJD3vbW/kZa4ex0rXuAY9mv8pmnjiuElqU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=LQo0oA+sGW9lVVqN+QO4exx0bXiV30KKUVmMjcmnAXEqT/5+QVc4BN4ghyxCsyw0tCH1vw430mBjY+dwfZMHCFT490yA4geB0EgzzbhxekWkpkCmgAQtNtS/YLDpj3xcqHI3nE80ffeSe/sReGEN3reLykfVgMfmfD9pTwOSQmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=belden.com; spf=pass smtp.mailfrom=belden.com; dkim=pass (2048-bit key) header.d=belden.com header.i=@belden.com header.b=opCzXiAt; arc=none smtp.client-ip=205.220.166.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=belden.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=belden.com
Received: from pps.filterd (m0382794.ppops.net [127.0.0.1])
	by mx0a-00015a02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60E81ixc2992785;
	Wed, 14 Jan 2026 09:04:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=belden.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=podpps1; bh=cM
	13lnwjFhDDArj8Ka8MxbkAPrMJfM8cPXc0HNZmrW8=; b=opCzXiAtiytYdCmtCe
	ZDJ32vIdXJiqt4fAeXJ4FKZLBw3CcAbot6ZXKo6J3bHcCdYdO50p8XpkrBGioqJY
	67uS8gwq8EObPuB+woUnDC6vTFctwXqfcKnM49iKGMt13g5B+QjOcJxiEkGyfPM/
	xyP5aqNoGbi+JKnWphe/lnosVFnEU0pjObDRcpvjgDBjvHwhrtmcWHKBiBOAskMh
	b5dkPxq+Zhxpj94Q+LMtuwWa2qMoiVKrgSTQYeJbTNXkKaUUzVBT3Vs9SSTMUBNs
	hHXWsf6gCtVBTsqre10Tg9zkOXnpvE2B4jjwTqh1Rb2K8dSlJFuM4S37C4Gut6Xn
	nXtQ==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
	by mx0a-00015a02.pphosted.com (PPS) with ESMTPS id 4bm83v7mmd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 09:04:33 -0500 (EST)
Received: from SA1PR18MB5692.namprd18.prod.outlook.com (2603:10b6:806:3a8::9)
 by SJ4PPF03B844E7F.namprd18.prod.outlook.com (2603:10b6:a0f:fc02::f05) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 14:04:29 +0000
Received: from SA1PR18MB5692.namprd18.prod.outlook.com
 ([fe80::2461:6b6c:ad97:fe60]) by SA1PR18MB5692.namprd18.prod.outlook.com
 ([fe80::2461:6b6c:ad97:fe60%5]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 14:04:29 +0000
From: Aleksandar Gerasimovski <Aleksandar.Gerasimovski@belden.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: RE: btrfs stopps working when stressed
Thread-Topic: btrfs stopps working when stressed
Thread-Index: AdyFNmudS0nKqt7tR/aX56jro//3CQABuz4AAAfC97A=
Date: Wed, 14 Jan 2026 14:04:29 +0000
Message-ID:
 <SA1PR18MB5692EBE3FFC7694F733E6007998FA@SA1PR18MB5692.namprd18.prod.outlook.com>
References:
 <SA1PR18MB56922F690C5EC2D85371408B998FA@SA1PR18MB5692.namprd18.prod.outlook.com>
 <f53f9520-9168-49a3-8354-33d90d2ee3e5@gmx.com>
In-Reply-To: <f53f9520-9168-49a3-8354-33d90d2ee3e5@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB5692:EE_|SJ4PPF03B844E7F:EE_
x-ms-office365-filtering-correlation-id: e626ab06-09c9-4135-0f4e-08de5375d593
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bXVpK1R2anVGbG9GcUpnc3M1VEt4WDFOampwMVFUTFdKd3U0YzZVaVZQVTVa?=
 =?utf-8?B?WXY5TTcxZWhxZm4vY0M5OHlIQmN4STI4WThON3dEWXRZSDgyY3oyYlMrRncy?=
 =?utf-8?B?VGpNd3JxY0VqOWdrcG9NWlpkeUs5S3pJZExWOUpyalRaNWVaLzFzeDVPK0lx?=
 =?utf-8?B?K2RJWGdhQzdHaTV2NTNUZks0eFE0dDZmSWFjbUt3c1N6OUF3MGErbFpyb0Zr?=
 =?utf-8?B?a2VFdnZVZ2NwbG5uOG5ZR01TS1VlYzYybUdndXNhZHlkYTk5OVRzZU1PTFc1?=
 =?utf-8?B?RTVaVmU3aklURUU4ZllWMXdMNW9lU1VBYW1HdFZaZnZ2Q3AzUmNTYjhGTjRs?=
 =?utf-8?B?SERKNWk0amtVUEFrQ1dCNytjdklyZlp6amJkZGpGbDBYNFBSVlppRXN2bXJ1?=
 =?utf-8?B?YkJrQ0JjNjVra0NOeTRvb3g5VW1uWUF0cEovN0xub0oxdUg4UXFEdDZ6aXNM?=
 =?utf-8?B?N0x3T0tudG4wbWdRV2syR2NnR2VHM0U0SWFPOElvdTBSaHN5SGdKQjhBN3dQ?=
 =?utf-8?B?UU14OGVoMEJMbmNZS1BneW1NRGhkQkxuTVJ0TDRuSkRTME5jd2NBL0VLcEZh?=
 =?utf-8?B?d0EyazBOT09rVmFobi9oZGxPTzUxRTA3aWxnWkcyZXFuYkRaaWRUbzBmUnd3?=
 =?utf-8?B?eFdBZXBjVXVKMkg1SXczOURlV3V2MnhuTjg1L0x1UzdyU1RZay9uODhrSkV1?=
 =?utf-8?B?S2kxbWx2NHc0LzArRFNtSWpqR1FVWjJYR1hGZm9qb2kxL1FuTnVYTlpUQmlJ?=
 =?utf-8?B?YzByZWZRaGt5ZFNaeUNUL1NYeVRJWXQyQkhLd0Q0cjlBN0VUWlB2SjAyUHpI?=
 =?utf-8?B?V0tPYm12TmgvdW83YlM5WjR0OWIvSU1WZFpONW9mTXh4Q2dRc1QrY3BGUjM2?=
 =?utf-8?B?ZzRUS1NpYXRKYTA3QnZUV1NDUWJRa0tzR2k1K1NDUVlVVkhma1JDVjI3VU81?=
 =?utf-8?B?R3gxRkp0MFNXdGpQTXI4L0IrbmJIRVUveVBVU0x3Ymk3REF5dlVMb0hwblJz?=
 =?utf-8?B?cWcxUFp0MCt1cCtJM01DUFc2dkllS0o4WFVJV2xEci9UcE56S1RtN0pTbGlC?=
 =?utf-8?B?R1l6M3R0ODN4b3VDeG5SaHV0bDFYQ3c2SWJNUlRwbTBMRmpVV0t6Njc4akhq?=
 =?utf-8?B?NWJ5bExyd0FpSHJWU0VleVBaaGtQY0tNZ1ErZ3JvQ29zTitkK2hLK05HMVVH?=
 =?utf-8?B?Ym12bFZMUWgycCtHc2o0WXhDVUkyTEt0bmJaY2xTeE9LQVhJdUdFS1JUdHlw?=
 =?utf-8?B?bDhBSnFlM1FyMVZZaVVJL254L1dBdjlTNG94RUh4Tzlvd1hKT2oxSXJsTXNw?=
 =?utf-8?B?czdkNmVNbUpMazVGQ0d2S1htdldIZlZ5WTJlSUlDZkMvRENadkdEdVQ4RUhZ?=
 =?utf-8?B?dWRIY0RiRnllLzdDTFJDWG1IL2ZsZWFqbWNGa20xc3RDYXorOVRCTE4rRnhU?=
 =?utf-8?B?YXN6Y0xmNDdRd0MwaWxFL0tZdnBGY3BXcXlLWnMxZEV0L0lhL1BSUTR0RkRz?=
 =?utf-8?B?czZoM3VXOUtyRmVLUTM2M2F5WituMzQ1ZDhSb3QxWVZaZGlqWGZ6cmFYdFVM?=
 =?utf-8?B?REZOUlAwOFhXNDRkdS9RY1RaMytkU3I2dDFyR3FLLzhBS1FrWFVUM29wM2Za?=
 =?utf-8?B?QlRNN2ZjSWthYm5temtJYk5GV2daUzZrYXRMZ3luemdvTHl3Y0dQTHFqcDAx?=
 =?utf-8?B?ZUtsTkJJWkJMSE5HRnVOMWthSXUyZEJwZSs1OXZFTjRNVkpKSU9pM3N3aHh1?=
 =?utf-8?B?SzFpQ1RJUXJkU0ZVZW9lNmtObjlsVEptcUNaWEhTNzZ6bUNsL3lpWG5EaTlG?=
 =?utf-8?B?YkJYUEdDOUR6ODl0b3VUWkZXRG1pSmlOL1Q1Y05GZmMyRXdDN21zZG9pcHVF?=
 =?utf-8?B?MDlubjhFeUlyYjZ2R0ZJd2hQaUlUK2J6am1Ndm1KSVVEQnYzdEFLcnY4SWZQ?=
 =?utf-8?B?SjhpbndLdEMvOWVWajRjN2hFWHROUjBpaWNTL0g5RWZhSC9mZHpQdHhsTEVh?=
 =?utf-8?B?eUpDSnpVL25rd0M4Q0JZam9xSkc2RS83L0o5c3ZpTEdFdmFNM25rRkFkVmtm?=
 =?utf-8?B?UTZXV1JlYlJpYWFzcjRKdFppTEhwOEp4SnRSOE5KMFFCaEJUTEJTcWhmNVhl?=
 =?utf-8?B?RElQcXdXbjhwS3pyaUYrdWd4TTRGMXBOVjZuMmhOcTFuZ1N6eFdUUTV4NXE2?=
 =?utf-8?Q?vMpquPSr5oJ2D+4LbfBh0NM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB5692.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SVBxcXhTWDdhYmI5QmdzYjRCc2lHMlF0c25iTUNFZ2ZGOXNGWERWSXpzVGZD?=
 =?utf-8?B?OFAvVUtCK0N0cXlXNUNSTHdGL3FlT3dBTUQrWTFOSzRaUExlNktxN2QxcUNp?=
 =?utf-8?B?Rm5sR0phTW1TdWNod2g5UmNLems4d05CbTdDWkQxOVZNdThxMVA4bFNWRlBU?=
 =?utf-8?B?UzM2SjVnWmp6V3EzZUxkcU85enY1R3hieVhBVFVrWE1NSElsTlpxQ04xRDRN?=
 =?utf-8?B?bnJQWmU5Skx2eFg2TGNDRHlGbjNwYnk3Rk1La296VmQ1bnFrRXpuWkswaUF1?=
 =?utf-8?B?Q3dJU2kvaVNIcHhiUDl0N1J0QTNHTmE1bkZQcU9VSktwSGhUTUpncExaajRa?=
 =?utf-8?B?TkZIZi9RdDU5d3d6a1JsRGo0cnFPeWNENnA4WXFxZWdyVkp6SHIwRUV2TEor?=
 =?utf-8?B?dFBwWjVuUThRL09CWTVaUm9ndDdOU1JDSkFqbEVUZ1JXQTVvYTNEaWQzNEln?=
 =?utf-8?B?cHc1eVUzZEFxSm1zNndhcVQ2Q2M3by9JS1lONEhnMDUwRGQ1Qy81eStBNXlp?=
 =?utf-8?B?UDYvMW1CYTZLNGdVcEw0ckxNR041MHpqdFJULzQwdVBvZEFwSTlqREFvRlBk?=
 =?utf-8?B?VnA2aGtqUTQwbXJGdnVGYU96OHdTZUYvbjdUZ3FFbVUzRk0wdEFWR2h1cGxj?=
 =?utf-8?B?cVZJVEkxT3Q3ZXRBWUxRUmxmMmk2T1l2MWJRYnNDTWtKcStrK1greU9lOWQ3?=
 =?utf-8?B?Q1kvaXB6VFdFQ0dmcDYybXI2NEhuYUVpNFNRdVZ5WDNndTFRMnJLVThaSVIz?=
 =?utf-8?B?UEszcnN2cDY4YnpJOGVGbEExaTNObGwzZzB0S2Yxc081VDhOZ3dRRVJNRFhN?=
 =?utf-8?B?NkVLWTVUclM3djI0ZWd6ajFjcVpaSFlzcnkzcEtSVlpyNUk4bG1od3VDcGlj?=
 =?utf-8?B?Y0s4eExtTElTT0xXeklhNk9BQXpEZzlabGhoTXRQdm04RjVlMlRzUTdMdkg1?=
 =?utf-8?B?V0xMT2JaUTY1dmZyaitUcWsrVVgyOU55SHZ5UjdLNmFuNFZmbWd6UXdhd0VL?=
 =?utf-8?B?WG9TRlNNclVBUFZndDlvNGpuVERwOWhWekl2cmNGNUFuTjc4UC9pU20wVU9G?=
 =?utf-8?B?MUFiZUN2R1drK21lOEVHbGxYeHNnSDhNUkl0M0R2bDdaYWZ3K1VkZXB6U1Vs?=
 =?utf-8?B?anZ4Vk1zMDgxWVMxQU4wbnNWb01HalgvTDNvUW5FUHpETW0vMFhHN25MWitO?=
 =?utf-8?B?Y1Rha0p1UEg3NVFvc1ZXVVF3REdYUUhHVXZpdlQwWHRGK05uaWlvY3EwQy9o?=
 =?utf-8?B?SmU2VUluT01QK0hiOC9GUDE2TWxQRWF3eE1tT0tEZU5UbE5sMFdDYkpBZEFp?=
 =?utf-8?B?VXh3ZHBPUjVTNFJic1I2eDFpVW9OeTZRSVRaRXNiSEsyak1sdWwzVW5xVHF2?=
 =?utf-8?B?SUxWVVZ1bTgyOGtIeng3RnhVL1FvQ0syeTYxSDV5N0c3MEJ0Wmc1YU1QMzhO?=
 =?utf-8?B?UDNrSzZpUjZReDhpNGFhaExrR0d3bTVKckkyTGpMV2FTTDlMYmFrWkJoZ0cv?=
 =?utf-8?B?cUh5Y0Q3N0hvcEZXT2xwVjFpV0dMemVvRjZYNnAxUko5MEI4a3RqTGRCVDdl?=
 =?utf-8?B?VGNkeGxZQyszS1BhMkNBM2QrQ2xRWWE5c09Qemx2aWRsS0daT1hEN1BFV2x3?=
 =?utf-8?B?dDI0V3BmRkhlNDI1b0pTV3NWNmlVMXNmSHVqNGJIakRzNml6SzdnR1ExS2NO?=
 =?utf-8?B?SmFpRUpFdC91dzN1NzY4cmV2Qm5VNlZDK2VibkpnVDNaRzQ1dEswQkNYTnd0?=
 =?utf-8?B?TUNtZFpnWDFzWlBleXlqWWsySTZqS3ZjeDdqZFB4dTNPeGxtM21JY1RWNTBq?=
 =?utf-8?B?S2VnVkVXd216NlRGSU1yOUcvWUFCbU9HMWJ3eFdMWW5kenNFNzBhSkI4TkVy?=
 =?utf-8?B?RVYrZjlCUWpoRVBIMHMxdVlvWVN5U0Z3MWQ0Q3ZIUHVMbVcxQ2VPd0xPbzFG?=
 =?utf-8?B?elU4eEZNNzUzdGo3YStnOVhyTndYNG9nNDJYZ2FiK21MVnp3N0FVblF4YnB4?=
 =?utf-8?B?TFlyeVdwWjU5R1luT2tDWHkwTHpmMWVPZTBVeTRvUkExYXVjbi9tcXVZaVJJ?=
 =?utf-8?B?ajVHWVF3M0pYZ3hEdU9sR0tDcUNEQ0EwMjFmVHFoNTNDQi9FelpWM082TVhm?=
 =?utf-8?B?RHovRlZObUNmMTc1WktxUTFRQWw1MThPMHhTSEJiVVZpOTJyaS9LOUFDQTlM?=
 =?utf-8?B?bEo1RVFpcDRySHQ3VDdDMWp0S3VHWXp4QnNSeHo1Slcvd0ZzL2twOEUzVFhy?=
 =?utf-8?B?VnVwT3JkNGR1L3NSUXJEZHJLMjJ2eGxGb3h4K25hWmxjdlQzSTFiSXhwNkZ6?=
 =?utf-8?B?QWpBamYzSzIrRlpsaEtXVlA1bHloNGdTeW9yVFdrZDZHTXgySzVDbVM1eGhJ?=
 =?utf-8?Q?4Q5RN58hbor5zjp3wp8mYfQGHXdKCqVpEar+UsTu6/nB/?=
x-ms-exchange-antispam-messagedata-1: 7g4Za8OjobwtJyMMQfDOqgju6BkUhCeEM0A=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ga2TCXj9PU/6A0jwkYrw641AOMYrCM/g6hteHtAmd6tujF96Z+meBac5TH/3djVoNYY5m8LGO3ZAsnXb4feKVdrASrWMGMFdzGk7dKmts/CpcsiZhY33/gTGZf88TR4NQNIOYygqkUbxwLFyL8Aa8IWHfSZdIeTgvz37YIqb13+uOpwbfNeVChDkGq4lHaynN6fdB24yv8heC31Ec+q1EDRGZBBt0F3p7ExCVmjC5CWCEZbNp8XAcNChyuFPDvS392RtiDDr55YweSgBB1PVJFBHafmBS3WbNppxKAcxTVRXGaePHnNpX5XPGYtAQd4SvdjgwJnxVFeU5wsGJfOVrR5XBtt6hNOFt6mspcDPX2M1FqnymFRFSFjFfcBEb5ggM16pbAl4IdYVb1SvVEfW6BzxspSvP2FnkVXqgxyRzWcDppQYtNraGxjKTdu3TLFi6s1s1ljn7ENEodqKLWp1NWl6WsOK7BUKMQId5Wt/YIpMPbvxbQ8m1/HZGIPAM+4EVK3u6bwFxX3ElkOFK7Z5SdNmoAYndU2RUm2qIgfSsO5CF9e4smt4OD7XHOpkpuOSJRmHsJF6zTSd5GyfP/HMxfszw0hBvmHUAARLBN/iVqZTgfn/lBFCsFQDbFfwr+BW3E35wzs+n9zny7EQfjmsFg==
X-OriginatorOrg: belden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB5692.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e626ab06-09c9-4135-0f4e-08de5375d593
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 14:04:29.1683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0f7367b1-44f7-45a7-bb10-563965c5f2e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qIJcAZ3tBSb4VXAhw9J1UAOn6GywdZI0TIp/j5jQN//49cQfhjCvuCcUpMKlSR7J+NdfvugBUDXFIJah+xKd6T56Atx/tgouLsHVRBPuMJuSE3cZNS+GTvFJKa8Hwi/t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPF03B844E7F
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: QWOZlRrOe0nqHXSMAAJVb3kAj_LR83oH
X-Proofpoint-GUID: QWOZlRrOe0nqHXSMAAJVb3kAj_LR83oH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDExNyBTYWx0ZWRfX7WGk+ZIcuFld
 vPWfcYwWZDFfNPFAsKh3ejk1cYoGxi93QnI61She4wKD5wQiEshvKnvQTebUNDVgeFD3vdIwFKF
 yH5tS2uu+GFO29yWLhdmm3H50y4i/bqtDiX+we+YpObc3mceHiVuB6j7YJ6iklOX46lCr4jAIiq
 EWNhZFV3G0dmKImZ6bHLydbK+5uYiwALvByv+yGHI4nsrdHMjk1e1hyvC/Jxm+lzKJ7RhIL9w74
 luW3jM/lXGpddB+pRVtmaDGRaqP9YW2Z3cDF/CXdfsTDg55CQ5kiOWoBo92418D/+IEs2sc8t/1
 POKqN7vrxBVvdNOh4N2a+dZB+Tc+MsMZghKLTSosDDR7Z1oTfBvu3FFNmzsK2VZLs+R4Os+wnpm
 +UoIizxEx69CF/YdjS4la2fb3Az4Sspy4nicvxZr+KYWj+CMR8Ygls4Fg1QGvCllKXsQqSbHDJ8
 hB6JV1y7SePQ6BNIC2g==
X-Authority-Analysis: v=2.4 cv=WJJyn3sR c=1 sm=1 tr=0 ts=6967a271 cx=c_pps
 a=C5fyF0bn1LKt8LWMWUNbGg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=mCf63rc527wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RpNjiQI2AAAA:8 a=7YfXLusrAAAA:8 a=WDlp8lUfAAAA:8 a=VwQbUJbxAAAA:8
 a=T9MP2bJvxsCNM8oCa30A:9 a=PRpDppDLrCsA:10 a=QEXdDO2ut3YA:10
 a=SLz71HocmBbuEhFRYD3r:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140117
X-Proofpoint-TriggeredRule: module.spam.rule.outbound_notspam
X-Proofpoint-SSN: Sensitivity3
Content-Type: text/plain; charset="utf-8"

Hi Qu,

Many thanks for answering:

No, our setup has single device (btrfs output is posted below).

We are on an embedded device so the specific partition with btrfs is 1GiB, =
so if you really suggest 10GiB minimum than do we indeed do wrong FS select=
ion?

We could for sure try if mixed-bg improves the robustness.
Is this known limitation of the btrfs?

BTRFS status before the test:
------------------------------------------------------------
# btrfs filesystem usage /mnt/data
Overall:
    Device size:                   1.00GiB
    Device allocated:            350.38MiB
    Device unallocated:          673.62MiB
    Device missing:                  0.00B
    Device slack:                    0.00B
    Used:                         20.80MiB
    Free (estimated):            885.20MiB      (min: 548.39MiB)
    Free (statfs, df):           884.20MiB
    Data ratio:                       1.00
    Metadata ratio:                   2.00
    Global reserve:                5.50MiB      (used: 0.00B)
    Multiple profiles:                  no

Data,single: Size:232.00MiB, Used:20.43MiB (8.80%)
   /dev/mmcblk1p9        232.00MiB

Metadata,DUP: Size:51.19MiB, Used:176.00KiB (0.34%)
   /dev/mmcblk1p9        102.38MiB

System,DUP: Size:8.00MiB, Used:16.00KiB (0.20%)
   /dev/mmcblk1p9         16.00MiB

Unallocated:
   /dev/mmcblk1p9        673.62MiB
-------------------------------------------------------

------------------------------------------------------
# btrfs filesystem df /mnt/data/
Data, single: total=3D232.00MiB, used=3D20.43MiB
System, DUP: total=3D8.00MiB, used=3D16.00KiB
Metadata, DUP: total=3D51.19MiB, used=3D176.00KiB
GlobalReserve, single: total=3D5.50MiB, used=3D0.00B

Running the test:
# bonnie++ -d test/ -m NITROC -u 0 -s 256M -r 128M -b
Using uid:0, gid:0.
Writing a byte at a time...done
Writing intelligently...done
Rewriting...done
Reading a byte at a time...done
Reading intelligently...done
start 'em...done...done...done...done...done...
Create files in sequential order...[  971.162957] BTRFS warning (device mmc=
blk1p9): Skipping commit of aborted transaction.
[  971.170964] ------------[ cut here ]------------
[  971.175668] BTRFS: Transaction aborted (error -28)
[  971.180579] WARNING: CPU: 2 PID: 845 at /fs/btrfs/transaction.c:2027 btr=
fs_commit_transaction+0x9ec/0xb34
[  971.190238] Modules linked in: omap_rng rng_core mac80211(O) cfg80211(O)=
 firmware_class compat(O)
[  971.199251] CPU: 2 UID: 0 PID: 845 Comm: bonnie++ Tainted: G           O=
       6.12.62-coreos-cn913x-tiny #1
[  971.209161] Tainted: [O]=3DOOT_MODULE
[  971.212684] Hardware name: belden nitroc VNX/NetModule CN9131 based NITR=
OC platform V1, BIOS 2024.10-g97cd8f3422eb 10/01/2024
[  971.224059] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[  971.231082] pc : btrfs_commit_transaction+0x9ec/0xb34
[  971.236182] lr : btrfs_commit_transaction+0x9ec/0xb34
[  971.241281] sp : ffff8000822a3c70
[  971.244628] x29: ffff8000822a3ca0 x28: ffff0001012a3000 x27: ffff0001012=
a3c9c
[  971.251854] x26: ffff0001012a3000 x25: ffff000100432b90 x24: ffff0001004=
32b90
[  971.259076] x23: ffff000100432a78 x22: ffff0001012a3000 x21: ffff0001004=
32b28
[  971.266294] x20: 00000000ffffffe4 x19: ffff0001012e4c00 x18: 00000000000=
0000a
[  971.273513] x17: 0000000000000000 x16: 0000000000000000 x15: ffff8000822=
a36d0
[  971.280732] x14: 0000000000000000 x13: 2938322d20726f72 x12: 72652820646=
57472
[  971.287951] x11: 0000000000000293 x10: ffff800080f0a730 x9 : ffff800080f=
62760
[  971.295170] x8 : ffff00013f795708 x7 : ffff00013f795708 x6 : ffff00013f7=
976f0
[  971.302387] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 00000000000=
00000
[  971.309604] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff00010f9=
11e00
[  971.316821] Call trace:
[  971.319298]  btrfs_commit_transaction+0x9ec/0xb34
[  971.324051]  btrfs_sync_file+0x43c/0x488
[  971.328028]  vfs_fsync_range+0x68/0x84
[  971.331833]  vfs_fsync+0x1c/0x28
[  971.335108]  do_fsync+0x30/0x58
[  971.338296]  __arm64_sys_fsync+0x18/0x28
[  971.342272]  invoke_syscall.constprop.0+0x74/0xc8
[  971.347034]  do_el0_svc+0x90/0xb0
[  971.350396]  el0_svc+0xbc/0x104
[  971.353581]  el0t_64_sync_handler+0x84/0x12c
[  971.357899]  el0t_64_sync+0x190/0x194
[  971.361604] ---[ end trace 0000000000000000 ]---
[  971.366654] BTRFS info (device mmcblk1p9 state A): dumping space info:
[  971.373230] BTRFS info (device mmcblk1p9 state A): space_info DATA has 5=
62245632 free, is not full
[  971.382247] BTRFS info (device mmcblk1p9 state A): space_info total=3D58=
3663616, used=3D21417984, pinned=3D0, reserved=3D0, may_use=3D0, readonly=
=3D0 zone_unusable=3D0
[  971.396066] BTRFS info (device mmcblk1p9 state A): space_info METADATA h=
as -5767168 free, is full
[  971.404994] BTRFS info (device mmcblk1p9 state A): space_info total=3D53=
673984, used=3D475136, pinned=3D53116928, reserved=3D16384, may_use=3D57671=
68, readonly=3D65536 zone_unusable=3D0
[  971.420375] BTRFS info (device mmcblk1p9 state A): space_info SYSTEM has=
 8355840 free, is not full
[  971.429389] BTRFS info (device mmcblk1p9 state A): space_info total=3D83=
88608, used=3D16384, pinned=3D16384, reserved=3D0, may_use=3D0, readonly=3D=
0 zone_unusable=3D0
[  971.443110] BTRFS info (device mmcblk1p9 state A): global_block_rsv: siz=
e 5767168 reserved 5767168
[  971.452117] BTRFS info (device mmcblk1p9 state A): trans_block_rsv: size=
 0 reserved 0
[  971.459991] BTRFS info (device mmcblk1p9 state A): chunk_block_rsv: size=
 0 reserved 0
[  971.467865] BTRFS info (device mmcblk1p9 state A): delayed_block_rsv: si=
ze 0 reserved 0
[  971.475915] BTRFS info (device mmcblk1p9 state A): delayed_refs_rsv: siz=
e 0 reserved 0
[  971.483876] BTRFS: error (device mmcblk1p9 state A) in cleanup_transacti=
on:2027: errno=3D-28 No space left
[  971.493414] BTRFS info (device mmcblk1p9 state EA): forced readonly
Can't sync directory, turning off dir-sync.
Can't create file 000000028fIyc
Cleaning up test directory after error.
Bonnie: drastic I/O error (rmdir): Read-only file system
------------------------------------------------------------------------

BTRFS status after the failing test:
---------------------------------------------
# btrfs filesystem usage /mnt/data
Overall:
    Device size:                   1.00GiB
    Device allocated:            675.00MiB
    Device unallocated:          349.00MiB
    Device missing:                  0.00B
    Device slack:                    0.00B
    Used:                         21.36MiB
    Free (estimated):            885.20MiB      (min: 710.70MiB)
    Free (statfs, df):           884.20MiB
    Data ratio:                       1.00
    Metadata ratio:                   2.00
    Global reserve:                5.50MiB      (used: 0.00B)
    Multiple profiles:                  no

Data,single: Size:556.62MiB, Used:20.43MiB (3.67%)
   /dev/mmcblk1p9        556.62MiB

Metadata,DUP: Size:51.19MiB, Used:464.00KiB (0.89%)
   /dev/mmcblk1p9        102.38MiB

System,DUP: Size:8.00MiB, Used:16.00KiB (0.20%)
   /dev/mmcblk1p9         16.00MiB

Unallocated:
   /dev/mmcblk1p9        349.00MiB
-------------------------------------------------

Regards,
Aleksandar

From: Qu Wenruo <quwenruo.btrfs@gmx.com>=20
Sent: Wednesday, January 14, 2026 11:06 AM
To: Aleksandar Gerasimovski <Aleksandar.Gerasimovski@belden.com>; linux-btr=
fs@vger.kernel.org
Subject: Re: btrfs stopps working when stressed

=E5=9C=A8 2026/1/14 19:=E2=80=8A55, Aleksandar Gerasimovski =E5=86=99=E9=81=
=93: > Hello everyone, > > I'm looking for a solution for a problem that we=
 have with the btrfs. > > We have tried to do some initial investigation on=
 our side however we have limited



=E5=9C=A8 2026/1/14 19:55, Aleksandar Gerasimovski =E5=86=99=E9=81=93:
> Hello everyone,
>=20
> I'm looking for a solution for a problem that we have with the btrfs.
>=20
> We have tried to do some initial investigation on our side however we hav=
e limited knowledge and experience in this area.
> I hope you can give us some pointers how to investigate this further and =
in what corners we shall start looking.
>=20
> So, on our products using the btrfs we see that the filesystem sometimes =
stops working when we stress it with bonnie++ tool.
> We see the problem with mainstream 6.12 and 6.18 Kernels, our current gue=
ss from the debugging done so far is that
> we run in kind of a concurrency	and/or scheduling issue were the asynchro=
n meta data space reclaiming is not executed on time,
> and this leads to metadata space to not be free up on time for the new da=
ta. We can even see that adding a printk trace in a specific
> point is covering the problem.

Did your setup have multiple devices involved?

If so there is a known bug that slightly unbalanced device size can=20
trick btrfs into it can still over-commit metadata, but it can not in=20
fact and error out at one of the critical path that we can not do=20
anything but aborting the transaction.


Although even without that specific quirk, it's still known that btrfs=20
has some other problems related to metadata space reservation.

>=20
> To reproduce the problem, we run: "bonnie++ -d test/ -m BTRFS -u 0 -s 256=
M -r 128M -b"
> Note that the tested partition is for sure not full we have 800MB space t=
here and we test with 256MB so it's not a space issue.

Unfortunately it's too small for btrfs.

Btrfs has the requirement to strictly split metadata and data space,=20
thus it's possible to let unbalanced metadata and data chunk usage to=20
exhaust one while the other has a lot of free space.

You can consider it as the ext4/xfs inode number limits vs data space=20
usage. One can exhaust all the available inodes way before exhausting=20
the available data.

It's just way worse in btrfs for smaller fses.

[...]
> [ 174.013001] BTRFS info (device mmcblk0p7 state A): space_info DATA has =
234418176 free, is not full
> [ 174.022018] BTRFS info (device mmcblk0p7 state A): space_info total=3D2=
55852544, used=3D21434368, pinned=3D0, reserved=3D0, may_use=3D0, readonly=
=3D0 zone_unusable=3D0

You have only 244MiB of data chunk, which is already tiny for btrfs.
The worse part is, there is only 20MiB utilized

> [ 174.035829] BTRFS info (device mmcblk0p7 state A): space_info METADATA =
has -5767168 free, is full
> [ 174.044752] BTRFS info (device mmcblk0p7 state A): space_info total=3D5=
3673984, used=3D1146880, pinned=3D52445184, reserved=3D16384, may_use=3D576=
7168, readonly=3D65536 zone_unusable=3D0

Your metadata is tiny, only less than 52MiB (and will be doubled by the=20
default DUP profile for single dev setup).

This means your fs is only around 350MiB?

This is definitely not a good disk size for btrfs.

My recommendation for any btrfs is at least 10GiB.

This will allow btrfs to use 1Gib chunk stripe size (the max), so that=20
we won't have those tiny metadata blocks, and greatly reduce the problem=20
caused by unbalacned data/metadata.


But still, flipping RO is not a good behavior, although in such small=20
fs, you may have a better experience using mixed-bg feature, which will=20
let data and metadata share the same block groups, resolving the=20
unbalance problem (but introducing more limits).

Thanks,
Qu

> [ 174.060221] BTRFS info (device mmcblk0p7 state A): space_info SYSTEM ha=
s 8355840 free, is not full
> [ 174.069252] BTRFS info (device mmcblk0p7 state A): space_info total=3D8=
388608, used=3D16384, pinned=3D16384, reserved=3D0, may_use=3D0, readonly=
=3D0 zone_unusable=3D0
> [ 174.082979] BTRFS info (device mmcblk0p7 state A): global_block_rsv: si=
ze 5767168 reserved 5767168
> [ 174.091989] BTRFS info (device mmcblk0p7 state A): trans_block_rsv: siz=
e 0 reserved 0
> [ 174.099865] BTRFS info (device mmcblk0p7 state A): chunk_block_rsv: siz=
e 0 reserved 0
> [ 174.107739] BTRFS info (device mmcblk0p7 state A): delayed_block_rsv: s=
ize 0 reserved 0
> [ 174.115794] BTRFS info (device mmcblk0p7 state A): delayed_refs_rsv: si=
ze 0 reserved 0
> [ 174.123787] BTRFS: error (device mmcblk0p7 state A) in cleanup_transact=
ion:2027: errno=3D-28 No space left
> [ 174.133336] BTRFS info (device mmcblk0p7 state EA): forced readonly
> Can't sync file.
> Cleaning up test directory after error.
> Bonnie: drastic I/O error (rmdir): Read-only file system
> ------------------------------------------------
>=20
> Trying to follow the "btrfs_add_bg_to_space_info" that is in "async_recla=
im_work" context:
> -------------------------------------------------
> @@ -322,15 +322,21 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_inf=
o *info,
>          struct btrfs_space_info *found;
>          int factor, index;
>=20
>          factor =3D btrfs_bg_type_to_factor(block_group->flags);
>=20
>          found =3D btrfs_find_space_info(info, block_group->flags);
>          ASSERT(found);
>          spin_lock(&found->lock);
> +       pr_info("%s(%d): %s %lld %lld\n", __func__, __LINE__, space_info_=
flag_to_str(found), found->total_bytes, block_group->length);
> +       // OK: trigger twice free space is freed at second attempt.
> +       // METADATA 53673984 6291456
> +       // ..
> +       // METADATA 59965440 117440512
> +
> +       // KO: triggered one, no space
> +       // METADATA 53673984 6291456
> +       // crash...
> -------------------------------------------------
>=20
> Also maybe interesting to know is that trying to trace (printk) "btrfs_ad=
d_bg_to_space_info" influence the reproducibility.
>=20
> Any hints to resolve this problem are welcome.
>=20
> Regards,
> Aleksandar
>=20
>=20
>=20
>=20
> **********************************************************************
> DISCLAIMER:
> Privileged and/or Confidential information may be contained in this messa=
ge. If you are not the addressee of this message, you may not copy, use or =
deliver this message to anyone. In such event, you should destroy the messa=
ge and kindly notify the sender by reply e-mail. It is understood that opin=
ions or conclusions that do not relate to the official business of the comp=
any are neither given nor endorsed by the company. Thank You.
>=20

**********************************************************************
DISCLAIMER:
Privileged and/or Confidential information may be contained in this message=
. If you are not the addressee of this message, you may not copy, use or de=
liver this message to anyone. In such event, you should destroy the message=
 and kindly notify the sender by reply e-mail. It is understood that opinio=
ns or conclusions that do not relate to the official business of the compan=
y are neither given nor endorsed by the company. Thank You.

