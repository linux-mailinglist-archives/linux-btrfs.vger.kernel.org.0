Return-Path: <linux-btrfs+bounces-13945-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E2AAB4321
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E93D91701CE
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3D729711A;
	Mon, 12 May 2025 18:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l227spMq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LRHPulZH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E091629B21C
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073554; cv=fail; b=ert2lw1QrKdd2h6wD592TuyGXGHn3gi4imgAKCAQuXZnuSjQJjAgFtTQToSrkNZDIlpCEZPrEnbO9/BlxF7JfX/wlOV4puOTam+AGksnxGgILYoTVpdwSkacZpVdme3NEfmKe7rw1PGr9BxcJnL/bSr19zcSVixvSiidTB3UR+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073554; c=relaxed/simple;
	bh=BlcxwOEt8/5dO5D3doZmUaHhF3QoUV9Gi6CdagL+Bew=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tEQ+MG4M4PZAxONh6csngCGoe8rxNnQVevl1jgujf2vF06TnYoa2IkBXhp9EHeOrPpM0GP6WuAFCu8iLVOLHK9xTZqYR69U3D7OZGne8RNy2wiagPBvBMflh0RqsjIugeH2U7YirzghCjNnGr44zoeY+z8fgoiSoPW2Utf/SQPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l227spMq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LRHPulZH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CH0tiT003931
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:12:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wyvgFphlm4lbVDyTheSV9EjF4Et3w13ejt0uVDQfRew=; b=
	l227spMqXWXUilgIQhAuaB+AimqqT/KgiROfl0bC6G4OyvPJOayNiACeEIbrDGGV
	A/oXferU/bjar9XOxvkse/Pn7KZ3ZeIWTYmlhy5yB6aWhISsAWBalokn7rnt3V86
	BNBMMivVG0jpxxdfOljop+q+JQOx1hUQ9IoU7VUro/Kb0SFTVMPCVfgPo7rzV4BP
	dcwkBC438LKFMYLJbBfcC7KBRG9si7YUJW2jl5yM96QtycXaj0kkMI9CMvZEquNq
	eZXYo55sDq41ycoraeWMwi5eJchhKKCY1vKQtFMUJSEObCu6lP+5cLRSjteDb2aw
	HIdXltusCm6e4N0Oe9lDPQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j0gwk740-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:12:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54CHfHQ2022329
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:12:29 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013077.outbound.protection.outlook.com [40.93.1.77])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46hw88qc20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:12:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=noVbdOo5EMJ1GiaD+Yh5aPfYI5vo7aIeJOJU/HMdF5suC+oFXHe8O38F0IMQ2w+S8ZZqSVLfMvAi8E6X2gsMhiDFcKB8TFjtkOu+/j7E/TfIYjzl6RDNF617LAlN9GJ86p4q4JyxPZMtBL6+kb6wdxntDGrFbrm5snxnwukyO6QYDqMlWdgDH96vB32PzNZVOMPALKemP35PYr+e2UdF72Z9Gv035gqQugXfdrf6s0RxhMzQc/LyhGXNhJwGd7/krvO8acF9TJyrk+7X8nRk4OV2IDbSWqmvRcijS0VS2qBX+iDpsuFR+Cqr8Wh6Jnw5QMBuzIkLHbgvoxqi4mK3YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyvgFphlm4lbVDyTheSV9EjF4Et3w13ejt0uVDQfRew=;
 b=NHaE+hT8qEYbwSK1pCNBNqdbgdXMyLkbyniBsezBTQ0sYrVchKAr5KmMwehJUTWkzOIhbw/L3IUoX8woj0aRpyTqh0OKF/knUh7zsIFghS6ZcOoxWS6tE45W4rhaaWUaBJhaqCEF9Ba7u0Ru7MTNb29IogtN+VhSp/7a7lL7m7adF1nUjpnJ62wDftO2zxYwdR/eEmQK1n6gg7gy1/j0cyoHMeb/RwSOA5tIok7Xm3xEEyGXtAQD0MpZLSG1Pt7rprT9lQIMV24NEZhUBaNFAZUyrgmeLHHZKpTqggmv+U0CMqF79jUfYb3i3aucZ0ZiGSLnacvVIHxcSlALd1KMKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyvgFphlm4lbVDyTheSV9EjF4Et3w13ejt0uVDQfRew=;
 b=LRHPulZHFiH30bBXLH/FC8SkE42wtX8FVzsHtbVi8qob4x8Fw1MHR58NPPYyaE2u/DMvpjXFrDEVX+zlNmDci3BvMjkFwXSCIT3NNdjBYcydH+bQ3fG+dH1w79DGWUtSbdyg9PQNBTHOCnZKt6jaKPSmFdNNWOT/u4GTwaRLbkU=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by CO6PR10MB5789.namprd10.prod.outlook.com (2603:10b6:303:140::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 18:12:26 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 18:12:26 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] fstests: btrfs/366: add test for device role-based chunk allocation
Date: Tue, 13 May 2025 02:11:41 +0800
Message-ID: <092097c319fde45298613562307e893de2bb35ed.1747070864.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747070864.git.anand.jain@oracle.com>
References: <cover.1747070864.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0183.apcprd06.prod.outlook.com (2603:1096:4:1::15)
 To IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|CO6PR10MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f59178c-0ccf-48d0-f434-08dd91808ce5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnF0SmdBOFNJeGpZQUFxU01nT2JBK3Z6cW5ja0IveGwzeXI5QlkwbnN5Zlc3?=
 =?utf-8?B?cjR0aDFLNWUyYXh1MFdwSXpodjRDa1h3dWJlSFhxaVJiRGZxUDliSXozTko5?=
 =?utf-8?B?Q2h1bHRNOGsvaytrMmczRUZMMXN1TWRLQm0vVXNhOVdBdG1TQnBKN3VmMnFm?=
 =?utf-8?B?RUtXQTlVNXhjZGFLZGJ5dUNlN3I1dXpCbWZ1NFZlRmVER0EvQVhMbG9NdHZn?=
 =?utf-8?B?SnhaV1hxY3lZTE1NWkVqRFhqVnhYd2RHWXVmcHQ3cW5ybHZ4R0s0TUdZY0NF?=
 =?utf-8?B?WU02Ri94WU9vODZ1NTZ4alJuRzhJTnpzSVBQR0V4Z0JyMExRbHAyMksyK1kr?=
 =?utf-8?B?SWhQOVZHYi9JdVdsMlBMTm0wSjY0azhUalJqbHk4d3AyN29xQTYyM1Y0Wmtp?=
 =?utf-8?B?K3hHVWgzZCtMcFMvMmdKU0RtbHM0d0JTUi9NaUpLcU1ndmlWU3Zhb2twajVT?=
 =?utf-8?B?bS96V3U4ejhKUmRtNE5jZ1l4ekJ5Y3N5aGVBaGlGNkxEWlBZVVZoL0NScFNQ?=
 =?utf-8?B?ZlBhazBsanBjWENkOStsZVg5ai9aM1hyL2IyMHp6RW5hS3Q3YS9kQ0VUUTVs?=
 =?utf-8?B?alBJK1V0VmUxVDRWL2tKWW1FaDFrdVhDUE1nMmhadFNXWlFDdmhJb09UZTdC?=
 =?utf-8?B?Ym5tSEQ2MWowWjFDdUlmZERCOGhDVmhLVGJSQVJGa1VZYUVnaklOeVFOaFNF?=
 =?utf-8?B?czlXeUZJdHNkSkQwUmI5OWg5N2w4NWJuQlhTVEtOeWpRVEIxeTRVaFViN09z?=
 =?utf-8?B?aGo2WitlNWdUTzJPOGRlZ0svd2RzTmRjNU4vNmEyOVZnK0dncUN1b1VaVEJX?=
 =?utf-8?B?ZDc3T1QrdDZRUzYyaWxPWFk2a1ZabW5lZFBHa1VhVGlQOGhwVTBBV2p1dUxL?=
 =?utf-8?B?QXpsblZMTS9wR09WOVR4V0JwQldJVW1rTXZLNHdsOGdwNUVrSEhWeDNSWHVr?=
 =?utf-8?B?QlRpM0Y5MUNvZEFxRUZjUFhNNVFGR3g1RTM2OUFGZjBVVHAzK0NhQWh5eDVY?=
 =?utf-8?B?UFd1RFVScDd4Zy8zVC9OQnJqckVHQWpHbG5ZeFZqenJEU3JuMGMzN3dmNXBt?=
 =?utf-8?B?TVVLR25IbVA2NWlpVFBBdE9FRkJlSHBRMU95cW9uRmIvcm55dzB5Q2diSTM5?=
 =?utf-8?B?OVlBVmp3N085NFNtenlRSkNaYTVuOCtQU0ZXRUhZQXYyTGNrRkFQaXBsYitj?=
 =?utf-8?B?UGtJd2R0N0pyYUQ4VHlTYVVNZ2MvWkFidUU2bEdsWk9WSWgranhyM09IMXo0?=
 =?utf-8?B?d2oxV1NqRlVXeVdqUUxXc2REenl1R1hwbGVXaVpFNm5FeUE4SlNST1o0OVVV?=
 =?utf-8?B?K1l0dVdPUU1FNXJCZ2xHTVJWOEVUV3A0U1BLN3NyNk9pTHlXSGViOEw3RFA2?=
 =?utf-8?B?QmxSUWhlYmpHcGNIZzI5MGlGMmo0MEhBWk9ISVVOOUhxQUs4ZmlkY2JRVnpk?=
 =?utf-8?B?S1orYW1sRGlsZVBrWWxndVhWZUtUaTFZTnc5K1g1VDBPTGdvcDVPYXllRExF?=
 =?utf-8?B?eklhTDNxbUptNzYxUW5mNzRxRGRSNGszRmdnSDhZTmlNOStJUjNTY21RSGov?=
 =?utf-8?B?M2p5TWNUdmhaRExIcFZqUXRGU1F2ZUVLK1hxZGxscUNJaHJ3cHRUajI5d1BF?=
 =?utf-8?B?YUFsZFRNTkVTU1NqUFplcEVlNkNlbmFWbldUTnVmS05FK3pwelBIRERMb21w?=
 =?utf-8?B?d1JvRTlXQkVLNUdKSTVtOHQ5bUFqTjFsY05UdlFjUDVFRC85RWM3VnVrN21o?=
 =?utf-8?B?dnRKYzloSkkwbERBUElwREVzcnRVM2V3aE01c3gybzFIQTVMamgxWjJ4VWtu?=
 =?utf-8?B?Q0YwWmJ4MWRKVDRKaUxnYnRBQlZhV0kzMUJGM1pGNTRPMU9rNmFuQWlqTEd5?=
 =?utf-8?B?WVkxMlBpVzZhS3BaRXRtTHU1RVlKRFBhMEdHc3YrT2pWeVVPOHhkWWUvODdB?=
 =?utf-8?Q?S2df6noqU2U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDZ6WTZQb1oxRVF4NjRLeDZoZWFGb094UDkzUUo5cjM4OXd2RGVERisrWGgv?=
 =?utf-8?B?dG5SWEZKVGNVNXNnSk14S0ZJYWpmZU4zWkhETFhsUFpZclo2R0tKdDBCN3gr?=
 =?utf-8?B?Y2xMK0VyY3JBQlNKaGZnR3I0WFZQaytPSlJ4U1ZjemcwRXRibmJxaXVKOGNt?=
 =?utf-8?B?T2hPVXBrTW9OY3QvemdUZmoyeWxnY3JBMGlZMzYyMWVxbDRMQXdaYkpqc3Fu?=
 =?utf-8?B?K0IrU05TVHM4Y0NReUcycWJjSGErVkdNRFRXNFlNYW5jOERDUm9TdTNBZjRk?=
 =?utf-8?B?blBrS0FVL053UGhZem10UEF1Ty9SdmJiN05TTjhwQ0FGSlh3WTVjV1JUVGtk?=
 =?utf-8?B?dkNwdXphZHZsdVNIaVUwUnY3N3dVeUZWZkxtb3cyOUwxV05HVHZ0MS96QWZG?=
 =?utf-8?B?cFNzUW5RZ013SElPOWdnQitRUUdLd3lERVcxMzI2NlBnNzFnNHNGNnpNVGtX?=
 =?utf-8?B?TFZTU1N2YlVEeVFaL0xSQlJFTE82NWJQeDBadzdwWGQrdTlFMGFEYnFSNUht?=
 =?utf-8?B?cTZVTmlCcGJoM0t0YlR1SndUVlQ2MDBySFRDditmckFmNnB1WTBaVCtMRmFQ?=
 =?utf-8?B?ZUxlbUZ4VWl0WHlsRUZPSW05SXFjUmhWOVFTMWlBSWpsYWZLSThBUkRiUHVM?=
 =?utf-8?B?a3djRHpoN1RPbVAzVFpWVlZUSHJScVlDVHM1bmRCUlYrTFJROXpDNStOQWNw?=
 =?utf-8?B?WGJSNFEzdy92YzVoMFk5NGN2eUNNOUQ5azQ4OHhoZ0NCdDF1TGZrdjZZbkt6?=
 =?utf-8?B?aTdBY2F5OEthdlhlNVozZU5aczFweGRSTUdJTEliSUNTUXVtNjBTSGFRaC9P?=
 =?utf-8?B?NnBkYkZZSm1rTGUrdktodVBkKzBEWU51QTZ6SEF1Z3RyS25rTGQyazhycmJp?=
 =?utf-8?B?MjVhemt3NTFFdWdLZUZXVkpHZ2Q0cE9qdFdCdmNKM3QyNVVXbTZ5R1VuY2Jm?=
 =?utf-8?B?Smt3VnNJNTdNOEtmZEV5Z2VhT2N1RGdsaWlVN0IvdlV4MjJOV2FRUWhvQ1lX?=
 =?utf-8?B?TmlvSGlNbmJKOXR4aGVZNW9LWDBCeEdBVXFCRWpsSEoxUEpOdDFZWHlkc0tS?=
 =?utf-8?B?UEd2MmVKSnM5UE1na0VneXpnVmVCRXYrSDdDMTdWTFV2YTY1ZERUSjYxL1gx?=
 =?utf-8?B?YkR2VjhMNzdzSzkvRHpvNXNvVFAyUStna0NENmRUVVE0akJhTEdIZVd1MGN6?=
 =?utf-8?B?M01xZks2THRNb2JWSDF4ZjZrRGw5cXlrOXBQR2s5NjJwWnZRSHFraS8xdU80?=
 =?utf-8?B?N1p4VnBXc3JkUndJR2pmRkhxK2ZOcGt4a3VBOG1RNWpSTW1yMzMyMCs5ZjZt?=
 =?utf-8?B?KzA0TkgvclAwUkJPVUN4bkZKRmlhOFo5bldHYi9CTjlQWjQ3Q3dKOHpwa3l1?=
 =?utf-8?B?a3lkOFdoa3VlYU1jNkZBUW0yNkFBVnRjdm5BK2h4YkZMQXN2d2J6b2FIYi9F?=
 =?utf-8?B?c1ZmdU1XSjJBaUVORG83NEZmQkxQcVR0Y25wRzJTQUx0Um04RU5sMGZhTzQy?=
 =?utf-8?B?dDhqWmJLbHpTM1A2OVVYeHJCbFg0RUFNYitsNnA4UE9ldjEyS3d5NHhMdGFS?=
 =?utf-8?B?cEsveC95QVdDM2JZdzd6ZnFZV21teWRLUXdRVy9SY2ZCYWgwMTZlcUdiYTZ4?=
 =?utf-8?B?SU1XZnNvTkJGc3lJTlhaZDlvZ3FNUk4zODZNc1ZtQ3h2VEk4NHdzd1VRV2Vz?=
 =?utf-8?B?d0dWT2tHZGYwZS92cUlmSy9hWDFvTEM4WjlncklHNWtLdlB1c2YwaGxldDNz?=
 =?utf-8?B?T0J1TkxIcXhGNzhWaGFDbUx2U2gxWldPMk1JQXZoVmI5SmxwMnY5d2tmKzha?=
 =?utf-8?B?blBVM1Uvb3plUUFTTUMrczVEQVhHU0JjdzU3ZXMvMS9Mbi85TDQySXFPS3Vx?=
 =?utf-8?B?bGFQTWFmYStkVXV6SS81NE51WXJEOFRTbHlycEZ1NFMwUDZoQ2NxUUlGZVBM?=
 =?utf-8?B?S0RvQVNvQ2M5NFc4UEFOTndRZEY4eWhqZUlDcEsyYU93NFBGOHg3Q0p6VTlZ?=
 =?utf-8?B?clY3YmJqK21XVXhqNDNVeXdpQ3ZSNk1RYlZZRGZHcE45bEtoQVhVM0xlR3Uw?=
 =?utf-8?B?a05LQVhTbjd2RlltYlZic0d4bmk2bkhMQWpUbjhJcy9qaWtncTRsVjFNdDFr?=
 =?utf-8?Q?vqgPxp8Y0qd2SBbS2uOjz1Klj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bi8YsYNkDZF6AaMvxU1ZHG07kxRdBlKx2yCQROYFRpiuT//ddIPCJc9TlcUz11UiWfjxOF99gjq4XD+shpolYHDgA/JzaJl3Fe0FsBFH/TR6vIVpZ0kVeKROHKxVuVSIYBx0BNpkqdcEKSTxiuamKdKjRwjyKhcich9S9qf0JqeCPAXxFN9wk12FPBKBi6zW6rTsFQ5BHxR3hSvuFxWsDNyiJbsjimS5XMx1KtXOAMTtuU1BXm30pngb1zKJnK2HVSwa2xNy0ICueqDq3PdYMWFjvNUdd1QhtB3wCNfQL1ElEGxJTXYKPm9QlZKj+9RgGIwpSIGzj7b5PdxVItSBq8wSoaSj+8aeg/Qg7c9y08Tv0YRy3S1IVRCXUjalbWRIraXS5uGaS0IaA0b42KfiERaK1FfcmPQgVbfPYIBNd9sRIU4+vB52H5FlqHgaf2CHco4ZT64Zu48nEZn0FhAA9hStlAwV3EPlHetCesggZCU/TWFo918IxrioOxZTosN4M6cq+UnaQUIDRbLpcy6JCsy7fJMggfjRH/nhynaVp9WyHVrvSuIHkZLUJa0ImD8nkMaRPgT9Ncyp/j3zht6YuNkcKa7b2W8E0/HhE2wxrfg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f59178c-0ccf-48d0-f434-08dd91808ce5
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 18:12:26.5788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HDczHRhAav5Ja8Gxd7E/DahS187NGU2UD92i9Am7ZZgog/WTkMF8/tHldnQbXq1pXTuzH29XUIvuSmZaAJHTIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5789
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505120187
X-Authority-Analysis: v=2.4 cv=M8hNKzws c=1 sm=1 tr=0 ts=68223a0e cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=wRMfDo9w51eDp8D3sOwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: nfCITRMabif3AZ7XxO-sX6PcgflKqKES
X-Proofpoint-ORIG-GUID: nfCITRMabif3AZ7XxO-sX6PcgflKqKES
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE4NyBTYWx0ZWRfX553FnzbvX+YB om4/leuEXYDEt4IH+fohxsviB8WBCtf36aIMAkZT7HivH25CYjBDzQsmiJvOpjfZBbfRceUjG6B +mQ20WR0FscR+b2bxxbdMTdZ38H9p9ewVuRhdWQ/lPfl8+vv/eIgL35+NS5+Iu0z2WnLpMkWpwc
 zEQKuSJFtbBSO190lKqtYRgZTehs/PsXRMHInlsCuz194LSD0zhJl+BYuIj4kI32GxEtnEstTEn S/5G7P3rDkugOqsiEp1RdnyMaXSXTcFITKUa7xSpl2AU8QN3fc2/fN4E5vC55kDeKEMHDfTleqU KCFmlwff0Qh0TaVJGvKGHuzPKHBOmWvcA3it/aI0nX+jtEPcF8TvRlIZPvE68T4nU+JjhA8cbLm
 XScebYIK2VTcItfMiyHf7+kM7arcx2mTdC75O7dvc0YszIuZ0z5SqZ6Huq4yiZxtv47zQjpk

Add a new test to verify the btrfs device-role feature.

Earlier, chunk allocation depended only on available device space.
With device roles, allocation is guided by assigned roles. This test
creates scratch devices of varying sizes, triggers relocations, and
checks if chunk placement follows the role-based policy.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/336     | 259 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/336.out | 153 ++++++++++++++++++++++++++
 2 files changed, 412 insertions(+)
 create mode 100755 tests/btrfs/336
 create mode 100644 tests/btrfs/336.out

diff --git a/tests/btrfs/336 b/tests/btrfs/336
new file mode 100755
index 000000000000..703e0279ebe9
--- /dev/null
+++ b/tests/btrfs/336
@@ -0,0 +1,259 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Oracle.  All Rights Reserved.
+#
+# FS QA Test 336
+#
+# Verify the device role is working.
+
+. ./common/preamble
+_begin_fstest auto quick volume
+
+. ./common/sysfs
+. ./common/filter.btrfs
+
+_require_test
+_require_loop
+_require_btrfs_command inspect-internal dump-tree
+_require_btrfs_command inspect-internal list-chunks
+_require_btrfs_feature_device_roles
+_require_fs_sysfs_attr_policy $TEST_DEV device_allocation role-then-space
+
+_cleanup()
+{
+	losetup -d ${DEV[@]} > /dev/null 2>&1
+	rm -f ${IMG[@]} > /dev/null 2>&1
+}
+
+declare -a TEST_VECTORS=(
+# $m_profile:$d_profile:$monly_nr:$m_nr:$none_nr:$d_nr:$donly_nr
+"single:single:0:4:4:4:0"
+"dup:single:0:1:1:1:0"
+"raid1:single:0:2:1:2:0"
+"raid10:raid10:0:4:1:4:0"
+# Unusual config but must pass.
+"raid1:raid1:0:1:0:1:0"
+# Must fail as of now.
+"single:single:1:0:0:0:1"
+)
+
+# Check if at least 4Gb space is available.
+_require_fs_space $TEST_DIR $((4*1000*1000))
+
+# Make sure TEST_VECTORS would need not more than MAX_NDEVS scratch devices of
+# different size.
+MAX_NDEVS=12
+for testcase in "${TEST_VECTORS[@]}"; do
+	IFS=':' read -ra args <<< $testcase
+	ndevs=$((args[2] + args[3] + args[4] + args[5] + args[6]))
+
+	if (( MAX_NDEVS < ndevs )); then
+		_fail "'$testcase' needs more than max '$MAX_NDEVS' devs"
+	fi
+done
+
+declare -a IMG="(  )"
+declare -a DEV="(  )"
+
+# As the disk allocaiton depend on the free space, create scratch devices with
+# different sizes
+# Make sure there are MAX_NDEVS elements here
+sizes=(256 768 512 1280 1024 1536 2048 1792 2304 3072 2816 3328)
+for ((i=0; i<MAX_NDEVS; i++)); do
+	size=${sizes[i]}
+	path=$TEST_DIR/$$_${i}_${size}.img
+	truncate -s ${size}M ${path} || _fail "truncate ${path}"
+
+	DEV[$i]=$(_create_loop_device ${path})
+	IMG[$i]=$path
+	echo $(stat --format=%n,%s,%i ${IMG[$i]}) ${DEV[$i]} >> $seqres.full
+done
+
+filter()
+{
+	awk '
+	{
+		for (i = 1; i <= NF; i++) {
+			is_excluded_value = 0
+			# Check the preceding field only if we are not on the
+			# first field
+			if (i > 1) {
+				if ($(i-1) == "num_stripes" || \
+				    $(i-1) == "sub_stripes" || \
+				    $(i-1) == "stripe" || $(i-1) == "devid") {
+					is_excluded_value = 1
+				}
+			}
+
+			# Check if the current field consists only of digits
+			is_numeric = ($i ~ /^[0-9]+$/)
+
+			# If it is numeric and its preceding keyword is not in
+			# the exclusion list, sanitize it
+			if (is_numeric && !is_excluded_value) {
+				$i = "X"  # Replace the number with "X"
+			}
+		}
+		print $0
+	}' "$@"
+}
+
+extract()
+{
+	awk '
+	/^[ \t]*item [0-9]+ key/ {
+		if (keep && block) { print block }
+		block = $0
+		keep = 0
+		next
+	}
+	!/^[ \t]*item [0-9]+ key/ && block {
+		block = block "\n" $0
+		if ($0 ~ /type (METADATA|DATA)/) {
+			keep = 1
+		}
+	}
+	END {
+		if (keep && block) { print block }
+	}' "$@"
+}
+
+dump_tree()
+{
+	local dev=$1
+
+	# make sure the ondisk has the mkfs
+	sync
+	$BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 ${dev} | \
+		grep -A2 DEV_ITEMS | grep -E 'devid|type' | \
+		perl -pe 's/(?<!devid |type )\b\d+\b/X/g'
+	$BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 ${dev} | \
+		extract | grep -v 'io_align' | grep -E 'DATA|stripe' | filter
+}
+
+dump_chunks()
+{
+	# Make sure relocation chunks are synced before dumping them.
+	$XFS_IO_PROG -c sync $SCRATCH_MNT
+
+$BTRFS_UTIL_PROG inspect-internal list-chunks --raw --sort lstart $SCRATCH_MNT >> \
+								${seqres}.full
+
+	# We don't care how many chunks there are, but we do ensure that all of
+	# are on the correct device.
+$BTRFS_UTIL_PROG inspect-internal list-chunks --raw --sort lstart $SCRATCH_MNT | \
+		$AWK_PROG '{print $1" "$3}' | grep -E 'Data' | sort -u
+
+$BTRFS_UTIL_PROG inspect-internal list-chunks --raw --sort lstart $SCRATCH_MNT | \
+		$AWK_PROG '{print $1" "$3}' | grep -E 'Metadata' | sort -u
+}
+
+verify()
+{
+	IFS=':' read -ra args <<< $1
+	local m_profile=${args[0]}
+	local d_profile=${args[1]}
+	local monly_nr=${args[2]}
+	local m_nr=${args[3]}
+	local none_nr=${args[4]}
+	local d_nr=${args[5]}
+	local donly_nr=${args[6]}
+
+	local assigned_devs_string=""
+	local ref_dev
+	local dev_idx=0 # Keeps track of indexing 'DEV' array
+	local i # Loop counter
+
+	# --- Loop to assign devices based on roles ---
+
+	# Assign devices for metadata only role (monly)
+	for ((i=0; i<monly_nr; i++)); do
+		assigned_devs_string+=" ${DEV[$dev_idx]}:monly"
+		((dev_idx++))
+	done
+
+	# Assign devices for metadata role (m)
+	for ((i=0; i<m_nr; i++)); do
+		assigned_devs_string+=" ${DEV[$dev_idx]}:m"
+		((dev_idx++))
+	done
+
+	# Assign devices for data role (d)
+	for ((i=0; i<d_nr; i++)); do
+		assigned_devs_string+=" ${DEV[$dev_idx]}:d"
+		((dev_idx++))
+	done
+
+	# Assign devices for data only role (donly)
+	for ((i=0; i<donly_nr; i++)); do
+		assigned_devs_string+=" ${DEV[$dev_idx]}:donly"
+		((dev_idx++))
+	done
+
+	# Assign devices with no specific role (none)
+	# Make sure role-none gets devs with larger size.
+	dev_idx=$MAX_NDEVS
+	for ((i=0; i<none_nr; i++)); do
+		assigned_devs_string+=" ${DEV[$dev_idx]}"
+		((dev_idx--))
+	done
+
+	# Remove potential leading space
+	assigned_devs_string="${assigned_devs_string# }"
+
+	# Print the results for verification/debugging
+	echo "mkfs opt: $m_profile $d_profile \"$assigned_devs_string\"" >> \
+								$seqres.full
+	ref_dev=$(echo $assigned_devs_string | sed 's/:.*//g')
+	echo $ref_dev >> ${seqres}.full
+
+	# --- End of assignment loop ---
+
+
+	echo -e "\nTest Vector: $1"
+
+	# Roles like metadata_only or data_only aren’t supported yet. Just make
+	# sure they fail cleanly.
+	echo $assigned_devs_string | grep -q only
+	if [[ $? == 0 ]]; then
+		_try_mkfs_dev "-q -m $m_profile -d $d_profile $assigned_devs_string"
+		return
+	else
+		_mkfs_dev "-q -m $m_profile -d $d_profile $assigned_devs_string"
+	fi
+
+	# Make sure the golden output verifies that the roles are updated in the
+	# on-disk structure.
+	dump_tree $ref_dev
+
+	# Keep data seperate use max_inline
+	_mount "-o max_inline=0" $ref_dev $SCRATCH_MNT
+	$XFS_IO_PROG -f -c "pwrite -i /dev/zero 0 1M" $SCRATCH_MNT/foo > \
+								/dev/null 2>&1
+
+	_set_fs_sysfs_attr ${ref_dev} device_allocation space
+	_get_fs_sysfs_attr ${ref_dev} device_allocation
+	_run_btrfs_balance_start $SCRATCH_MNT >> $seqres.full
+
+	# When testing with different options like ^free-space-tree,
+	# block-group-tree, etc the number of allocated chunks can vary and they
+	# might not be on the same device. Therefore, when we are not using
+	# role-then-space, do not dump chunk location so that the golden output
+	# remains compatible.
+	#dump_chunks
+
+	_set_fs_sysfs_attr ${ref_dev} device_allocation role-then-space
+	_get_fs_sysfs_attr ${ref_dev} device_allocation
+	_run_btrfs_balance_start $SCRATCH_MNT >> $seqres.full
+
+	dump_chunks
+
+	_scratch_unmount
+}
+
+for testcase in "${TEST_VECTORS[@]}"; do
+	verify $testcase
+done
+
+status=0
+exit
diff --git a/tests/btrfs/336.out b/tests/btrfs/336.out
new file mode 100644
index 000000000000..c4d519462538
--- /dev/null
+++ b/tests/btrfs/336.out
@@ -0,0 +1,153 @@
+QA output created by 336
+
+Test Vector: single:single:0:4:4:4:0
+		devid 1 total_bytes X bytes_used X
+		io_align X io_width X sector_size X type 40
+		devid 2 total_bytes X bytes_used X
+		io_align X io_width X sector_size X type 40
+		devid 3 total_bytes X bytes_used X
+		io_align X io_width X sector_size X type 40
+		devid 4 total_bytes X bytes_used X
+		io_align X io_width X sector_size X type 40
+		devid 5 total_bytes X bytes_used X
+		io_align X io_width X sector_size X type 0
+		devid 6 total_bytes X bytes_used X
+		io_align X io_width X sector_size X type 0
+		devid 7 total_bytes X bytes_used X
+		io_align X io_width X sector_size X type 0
+		devid 8 total_bytes X bytes_used X
+		io_align X io_width X sector_size X type 100
+		devid 9 total_bytes X bytes_used X
+		io_align X io_width X sector_size X type 100
+		devid 10 total_bytes X bytes_used X
+		io_align X io_width X sector_size X type 100
+		devid 11 total_bytes X bytes_used X
+		io_align X io_width X sector_size X type 100
+length X owner X stripe_len X type METADATA|single
+		num_stripes 1 sub_stripes 1
+stripe 0 devid 1 offset X
+length X owner X stripe_len X type DATA|single
+		num_stripes 1 sub_stripes 1
+stripe 0 devid 1 offset X
+[space] role-then-space
+space [role-then-space]
+10 Data/single
+4 Metadata/single
+
+Test Vector: dup:single:0:1:1:1:0
+		devid 1 total_bytes X bytes_used X
+		io_align X io_width X sector_size X type 40
+		devid 2 total_bytes X bytes_used X
+		io_align X io_width X sector_size X type 100
+length X owner X stripe_len X type DATA|single
+		num_stripes 1 sub_stripes 1
+stripe 0 devid 1 offset X
+length X owner X stripe_len X type METADATA|DUP
+		num_stripes 2 sub_stripes 1
+stripe 0 devid 1 offset X
+stripe 1 devid 1 offset X
+[space] role-then-space
+space [role-then-space]
+2 Data/single
+1 Metadata/DUP
+
+Test Vector: raid1:single:0:2:1:2:0
+		devid 1 total_bytes X bytes_used X
+		io_align X io_width X sector_size X type 40
+		devid 2 total_bytes X bytes_used X
+		io_align X io_width X sector_size X type 40
+		devid 3 total_bytes X bytes_used X
+		io_align X io_width X sector_size X type 100
+		devid 4 total_bytes X bytes_used X
+		io_align X io_width X sector_size X type 100
+length X owner X stripe_len X type DATA|single
+		num_stripes 1 sub_stripes 1
+stripe 0 devid 1 offset X
+length X owner X stripe_len X type METADATA|RAID1
+		num_stripes 2 sub_stripes 1
+stripe 0 devid 4 offset X
+stripe 1 devid 2 offset X
+[space] role-then-space
+space [role-then-space]
+4 Data/single
+1 Metadata/RAID1
+2 Metadata/RAID1
+
+Test Vector: raid10:raid10:0:4:1:4:0
+		devid 1 total_bytes X bytes_used X
+		io_align X io_width X sector_size X type 40
+		devid 2 total_bytes X bytes_used X
+		io_align X io_width X sector_size X type 40
+		devid 3 total_bytes X bytes_used X
+		io_align X io_width X sector_size X type 40
+		devid 4 total_bytes X bytes_used X
+		io_align X io_width X sector_size X type 40
+		devid 5 total_bytes X bytes_used X
+		io_align X io_width X sector_size X type 100
+		devid 6 total_bytes X bytes_used X
+		io_align X io_width X sector_size X type 100
+		devid 7 total_bytes X bytes_used X
+		io_align X io_width X sector_size X type 100
+		devid 8 total_bytes X bytes_used X
+		io_align X io_width X sector_size X type 100
+length X owner X stripe_len X type METADATA|RAID10
+		num_stripes 8 sub_stripes 2
+stripe 0 devid 5 offset X
+stripe 1 devid 6 offset X
+stripe 2 devid 7 offset X
+stripe 3 devid 8 offset X
+stripe 4 devid 1 offset X
+stripe 5 devid 2 offset X
+stripe 6 devid 3 offset X
+stripe 7 devid 4 offset X
+length X owner X stripe_len X type DATA|RAID10
+		num_stripes 8 sub_stripes 2
+stripe 0 devid 1 offset X
+stripe 1 devid 2 offset X
+stripe 2 devid 3 offset X
+stripe 3 devid 4 offset X
+stripe 4 devid 5 offset X
+stripe 5 devid 6 offset X
+stripe 6 devid 7 offset X
+stripe 7 devid 8 offset X
+[space] role-then-space
+space [role-then-space]
+1 Data/RAID10
+2 Data/RAID10
+3 Data/RAID10
+4 Data/RAID10
+5 Data/RAID10
+6 Data/RAID10
+7 Data/RAID10
+8 Data/RAID10
+1 Metadata/RAID10
+2 Metadata/RAID10
+3 Metadata/RAID10
+4 Metadata/RAID10
+5 Metadata/RAID10
+6 Metadata/RAID10
+7 Metadata/RAID10
+8 Metadata/RAID10
+
+Test Vector: raid1:raid1:0:1:0:1:0
+		devid 1 total_bytes X bytes_used X
+		io_align X io_width X sector_size X type 40
+		devid 2 total_bytes X bytes_used X
+		io_align X io_width X sector_size X type 100
+length X owner X stripe_len X type METADATA|RAID1
+		num_stripes 2 sub_stripes 1
+stripe 0 devid 2 offset X
+stripe 1 devid 1 offset X
+length X owner X stripe_len X type DATA|RAID1
+		num_stripes 2 sub_stripes 1
+stripe 0 devid 1 offset X
+stripe 1 devid 2 offset X
+[space] role-then-space
+space [role-then-space]
+1 Data/RAID1
+2 Data/RAID1
+1 Metadata/RAID1
+2 Metadata/RAID1
+
+Test Vector: single:single:1:0:0:0:1
+ERROR: Metadata_only and or Data_only is not yet supported
-- 
2.49.0


