Return-Path: <linux-btrfs+bounces-13924-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C31A0AB42C2
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C60AF3BDA77
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715D82989BA;
	Mon, 12 May 2025 18:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Otj9K8Ok";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gWEf1yaV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD73A298999
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073286; cv=fail; b=nXVKYYT4tUtHgp1fmwuG3K4mUZ+JQzyS4CYrwfnTCOpxkwv91RIpJPylllXRe32AaP91+ox99iQ0goznaKexokuNIUR9c/ynWm6qzXtcXFo96BPPWirqHNOZyLb68pvrjAk1z1eMOTqTPgVKpRKnPXPWnjkHvESONWiJyhNgntc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073286; c=relaxed/simple;
	bh=7k2tIB3CH0EJi0X1E728WyxFvMFnElg2vqjBwRZ8pVo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cg4yH78iMAug3RLXMkbUoPRu4pIWOioRrCZai7/ZZ6nXWc0NalvJE5pncNXNTeFR4vHmORZhfjHxVMJeBjK2kV8/0s5GnEMdTyy0Ce6rmLK/2AnGe2XrL7sVTKfhXIq0H9jv4W7PqO08tpJA3NhBsy41E4H/Qor0c62wsxyHigU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Otj9K8Ok; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gWEf1yaV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CH0x9k004056
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:08:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8lKw5lBa0Tdeg4UCE706eqcaMiDVouTvU9xoIO+Ddw4=; b=
	Otj9K8Ok9/iP2fSw0IyzYy6xTx+IaPKQoSSr6gXAVe7WhEynJL+KOJPbBc+acWLd
	Wk5bl5PZ3Pfw6V/FrU6b9a4LrlkyQhU5OkF8SNIos126aXfgoGdbCOrieg/wbwZI
	mhQL36pl6otBvSrmCpri1pnD2iijAkxN/9HOU4My1TDniaoTp7Mo1tlU6HP6BRK3
	M5bP2t0y4pdCRFTbLzU3uW0rBpVtVjT+JEj4OtFw3tFg6sTElNJeEgrlcxP+Sdph
	DpCKFMI4xxEIb5FRexgLn5WfNX+Adk12cpC6qruSDMdlQWtR4Dt9ZlnSpQHyANOw
	2e9lRz2hrFtY7Ndj0OHfVA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j13r355c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:08:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54CGWkoO022377
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:08:03 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010006.outbound.protection.outlook.com [40.93.6.6])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46hw88q741-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:08:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y02naTlK3zermbUMqvcykuHRi8ecIKgRn2NrbhhZpv9+l0zIUfA/9oZZGHqbj9H4w6lVGPDYygJS9HQ1v4/tl3+IG92KgQq5o8YmBf+83iizg4Bs3l8bgqi92e3pEl+WcmJW9sJlhV6MAvUUiFD9R3A4gdiD6UB4F66oKabaaSTy6YtUous/XCnvJjYDHDEmFDnQ/Of9yVN1YPDW0xxJD66EpJmwcYu19Ii+ufIPEdE9NrLQZn29J0paRcOxIqKE3XlAA5X+uKIWrSGyvNzdtN6kWSsIgHkd0e/JNE9Tave/DXcIOc1TtCMWPCPReIz4VxpFHp5Ty/THTAZ9Z6nIAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lKw5lBa0Tdeg4UCE706eqcaMiDVouTvU9xoIO+Ddw4=;
 b=Btq8B2ESIGJWBZmr2h7RlSdhPU08tNkczeQQKfZpT2a6sty9MEOtIjDMxqcddxg8qEL7rdyvgjOejq5O4CMksUXXrQySJ4yY5MNeDW9DP4emt1svuEFHgUeQ70CDGnXNOpdxEtR13Q6msQO6dbK3y50ja4rhd1DlRqbG2Za9YDcBnRqXLIIQn8F//KZl92W9XEy9Xfwf6HitjpxphqPm78y1CG9yaq4Mmz4XghT0mNGYnBI4JKyQn65AX0rBBhFjspRHarc/RZhDUNfA28XfJGueM7irs/t5rx0o5pE2L3At8nk1iW5wPOk8olvSq7eHT1bdjaQ3OdwA3L3T61f9Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lKw5lBa0Tdeg4UCE706eqcaMiDVouTvU9xoIO+Ddw4=;
 b=gWEf1yaVTEqwhOv+5Yb7W6/Mo7QpdFjmQhn+VG8e1H2hA+tJ+4qDbp56VqbLat9A9inR4Ub9zzJeg7Sb3LfT2qF6kBUI4j/BodUMdRUiS3cqo5llm28o5iN15N+a+eG1B3S+mNJgolBZdJeW6ZmGKOwdX//7v8lPwzLYiMoXun8=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by DS0PR10MB8199.namprd10.prod.outlook.com (2603:10b6:8:1fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Mon, 12 May
 2025 18:08:01 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 18:08:01 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 07/10] btrfs: refactor chunk allocation device handling to use list_head
Date: Tue, 13 May 2025 02:07:13 +0800
Message-ID: <35b49f3742e290e8f19101ce624d57b7db256d4e.1747070147.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747070147.git.anand.jain@oracle.com>
References: <cover.1747070147.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0015.APCP153.PROD.OUTLOOK.COM (2603:1096::25) To
 IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|DS0PR10MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: ca3eab50-56ff-49ef-7918-08dd917fee91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w/W/qtIGVLjB+xrVtvi1nCliU1YXeEVCwC8yWqBXkAMwjTOdNIjlJ3kfywoB?=
 =?us-ascii?Q?RU+5x6paIjXNn7ua1zMHGn8psT+J369ybXFawiLj/LEoS2IVsgNJdII9TsX5?=
 =?us-ascii?Q?Lg/pbjBLcRtQfCb5eQtbFPBLC/QoPN9pvvnvRh2m25iECcSAsgP1Xjg/sCzZ?=
 =?us-ascii?Q?m4QpZn1N7et4pmZmA9lP4oHpTL5SU8sLSBOIdULC40hpKjMqkcGZGixqZnJp?=
 =?us-ascii?Q?Df9jUMra2lhs9mf/AUFyK7iAiiiC7z/+UFTK0I8Frr+XdFbnYcAl8PjA1/fl?=
 =?us-ascii?Q?RjKTDx3rPWB6cxSysS+hFViZLQGEr+qZdJMf4IgMyeOjVF7XMVaGus+lS8oK?=
 =?us-ascii?Q?EnjdyaqQG8uAKDK4Y/6tza1wmfFzS3Nxlve4Cwp60qq/oOTzBKCBp+pbMhQ0?=
 =?us-ascii?Q?cJc6uVqApIs8X9E1SaVwfnK9UmEPAIXmITw/FVli51rabV6uPojUpuUu4NQ+?=
 =?us-ascii?Q?D4SnLUvpaa+TzzHaEIbqTGjqzWQMuo4lWbZxeeaUq9tIco8v8L7pdsR6mA0A?=
 =?us-ascii?Q?51pcqANqXcv5RAxuayFHtJN2kXEM951H+oMbMzxn+8/vwtlAgVsQylYASrK6?=
 =?us-ascii?Q?HJFmMIyu7iIGtm6WDbTTC7WQEj6EVmjfxhlbvCbmZ1Sw0I/Vh7mp48gWgC3D?=
 =?us-ascii?Q?8FqzyWJ/uNXD/Q+iHynB9TCXczm+lrn+x6rLLJYACA7nvrZXrgKInEEuqono?=
 =?us-ascii?Q?t2ljhI63rYNe80WKdhbNds8p19LVU4N/oki/VW8sQdtPN7feQquRwOSxSSdc?=
 =?us-ascii?Q?9rjkTZGpWbLJrY/NjE4pEMrfyGIGGrKYsM+Wiw6bRhPEHU/McznKrrpm5U29?=
 =?us-ascii?Q?lTm96pZNIk8gooABDXGjp6Bb6QD9eBbqCVrjGrCHBGT9N22EwMf8lkD2X3G6?=
 =?us-ascii?Q?XIxQIFPtfbDxNBHK0ruGgOH7khDAdVUv5zqANWC4ULIp2bHSdE1GWEaOPLLv?=
 =?us-ascii?Q?ohFjswVc6JfZ8MjFcBL+oKDXVhgDwQHSaH05y2I75yayC/ZgaRY7DljbmEo8?=
 =?us-ascii?Q?zCn9coUssYLzMvzpWM3v/9lGRHVSFZsmjfggEF7jelHO+jyxGSLfNBr6Wc2Z?=
 =?us-ascii?Q?8dwJnh7NNImy3WikbT0/d6kPLqp5rQLbGpqa1GALYYz14auddmBwkvyfYs+b?=
 =?us-ascii?Q?tv6ZGdPQj4KO66Ch6JXTaQZMLWZxc5FRGp6XPlZZ7TLEsr4lQfWEM3S/aK3R?=
 =?us-ascii?Q?F5/Yb3Ks5Il7ndsn0Us/OCGFaTrOpk9ko/Ue/Uc+AZSjDdG29Gt33G6fljrO?=
 =?us-ascii?Q?7yrhyVe/sSkyAFZhR1abzt0+/VET9+HDnMu21k6F45Q7u7OiAIamf7GdqbwQ?=
 =?us-ascii?Q?q5NXmSqTC+af+X6HLTP2kfStB+PKSMaRQoMr7U4m58SH1nya0wvfNrc+yF5W?=
 =?us-ascii?Q?SV1AUU46OPW3+n0K6Kkg2AAiM0Uua6l1EKxlzQIsqxllno0VzeC/QWAd+Jio?=
 =?us-ascii?Q?MJVdvrfl7jI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fg7cfuIM579ZUrnezJcggQvizwV5FeTclSHolFfL4OzObaDHVIvxkxzKC/nx?=
 =?us-ascii?Q?7JCKOG96UJlwHqhrTiBECt2oU44RqA/J4VBGaDz5sUe3ko3K5MBLDT3AdW8C?=
 =?us-ascii?Q?J/pxMx1oC/FLjIHIruvedKu651RzXOKi8ntihcM6M34dzVpxec8hHimUYCby?=
 =?us-ascii?Q?x4i/AORK4jkCYWcz8Cyd8b1pi4xtOjnBk/F8JWY32ndpuEv+/Z/7sYhhGK5L?=
 =?us-ascii?Q?ha2cfc52M6RtFMHl9fkcyWMUNMi+us7DO/Lg2ru2HqvtDlzDqZqOIndt7QeS?=
 =?us-ascii?Q?v6QYZNQQ0O/W6aQ0TsNA1bOsb/Xb9wjNwk+xty7NJZdZMmMzSCwHG615aD2Z?=
 =?us-ascii?Q?a/uk1bi8VT4TEGCDy2qtslQE17P2GhKLsZujAGlVHHuy9xqi3dqAIU8SoF/1?=
 =?us-ascii?Q?eKVVOV5fGiFpzZ+l804apIMXXYxmlcz5CodnVqY9VJufyouG0Y6PeZkBXJnO?=
 =?us-ascii?Q?h78FO8wH3hJMKqIYCPCRtPZa+XbqHA0Lr9Cm3N0Hq2OEdw4FBlPVfsdSoC4I?=
 =?us-ascii?Q?lTy+EkpScluaSt6SAMfskFvSbAOHeOX+OqqMiNn6PCgo2H2mh6vKUjAkpmdh?=
 =?us-ascii?Q?L3FHFBuLtB4OVS3+eEBCm1IRrfj1KkVXJziCha+A0v/4LMHnI43A72/SMMaI?=
 =?us-ascii?Q?bkrTfHNTDOqpXG+BnAbnffAEk0/kt7y9tGs12aNEOvU1zFLkcwRG/HEPS+X5?=
 =?us-ascii?Q?O+ls8gR/fMBvhX9/tqDg9O5ZIuSEgE6juFPU9/U+UoFPdAvWEAGaRzE5x0/D?=
 =?us-ascii?Q?imrVanVw5tgBZPYFSyG6aPYrff8XgJqUl9o3MW9IFNyj7+e8CVdcALIk06ME?=
 =?us-ascii?Q?hB1XZwpguTZXeBAhaE7e9SDW/BvtSCTaaCA8Xii5vNwhKzIrquY3dmawn1I8?=
 =?us-ascii?Q?U+yd9YBDnIPB3WcMNGRpLPZODsNivfKk8B8aSvfYqyyUj+NdwEjgqSSZ7w+9?=
 =?us-ascii?Q?88IvHGYUM5yVCHZ2yNkq9Tnuf/KOkTiWbhl8XVH+BTltsENvbP2QGxsLGqPQ?=
 =?us-ascii?Q?zhc3TEERiMuwOsHi+ew7xOUVw9g2ooxBgaOiPeDfTxLTDAZcv6Q/ZxDzxP9A?=
 =?us-ascii?Q?vtqpfIoYeLkjos7hqa7WlVGLrBmTGLErs0I/Stbv1XiZFKRBzpLU/G2Twp4z?=
 =?us-ascii?Q?L5eVVFSNXl8KZsiywZKHK4oeGLASsKiC3iPYjoUsOH7nm92OA4r4qFFJAlbe?=
 =?us-ascii?Q?nn8IbdQZ7dvQfe9JSyZ/v414nXvdyTU6CA+1mQSTgvJm1JSHjcIqqdaUWDGs?=
 =?us-ascii?Q?yFRzuOQitxA5Yyg3WTchHNM+1dYRsVlNDVzUxoYKm4Ea9tAamCxD1PtBTp3F?=
 =?us-ascii?Q?qaRL+TYUmG23GJ23buPUQnwJxu0fOp2Zq4U6OoW/0TNpdmDXryBBnPDy0DrV?=
 =?us-ascii?Q?YwmyqSLj7YquAsyUpRWrd+EWgk4sEmGtjV3Z2M+gEu29Ik8hLXhfZ3I+K2Pv?=
 =?us-ascii?Q?Cd1OD6/x6yOlQPnrRB1+P4SpuZc9+L4BOfUUIJy7XOQB+6e/QaAh4nUgZ2Z+?=
 =?us-ascii?Q?PDFwBwm2Xu2pIWeXXFXLS76GBjU1JSePz45xFUxD4NligrgwID+UeUc+DEil?=
 =?us-ascii?Q?ASN+SZA0StY2D/8dBpvJ2blwb79rYLe44mtqXF0s?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U6+Kp6d4WUtUFMpSlW+2Jf8EXphP39+sTnopG/1K+59blUUz+K4WPCiEvdujVulBC7s5dMgOx6kGT3uguDTgy0PDTrl9r4uJXuXKAoqaGtXc7o/AWs2imjK3beq7zvscbwpwodmhvNKuTPAdvS1tjjvrX0MKTa/USS/Tfg3OP/zJ/lg32rYHOwCpq5UQzjHIv4OXBi4uRRFuZunNoiHwRtqg8SwUtMQhBqano9UdiGIIgDPRBUIlN6RIXv+5MIYHXx3yB/7L57o9KRSswf50NgQWcQNdO5pIpBdzEMHt5QbtkpvsdJJQbI/Ej6DA6KjUFpadYhy4gTHfraRssSHGiRRpev2lb4xq1+3Xe7tghdObRWEwSBcWFNkmd3e2mGX0uGO27gfJNyiTBw9NXrN/+JwfacEU0APYpIgarj3Kx0XYNzbcCltNPk06JN3JQJH62NvE/uCwA9y/Fdyu2vtunQCZoMqe8xPqo4uL0w/8o7QBpYegwVE7aXNn89AYZglAzawB1/nZj5J3zy6M4RBv4G/VTautj18cx9fx7ESTG1gEaupjvbzHyR4FmuBq7HyiM2kxRiXzr+MCHphPx9zdxKOmUZM+Wc/4da/k8ipnTqs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3eab50-56ff-49ef-7918-08dd917fee91
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 18:08:00.9546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7OEzz7gCLGdnP5Yoy8+G89dvlOSouSI+quL/w/qI6YnhhFhiffBNOFiFBOAH4y7Rph9VTTXFYsJ3xCCTqOA66A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8199
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505120186
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE4NiBTYWx0ZWRfX+no2VQOyrIDG eOoOO18Gr46KxijGHmP0Yk3YkqeV1FF/UcCo0caIJaczDxmGcj5D6uFvnC5AuoHF541ZpKQrabx nBxYgXapGRtsgQ2q3eCkkH4yjosaRdhUFVmLkhW1pLD8WGzycjJhhPa/xiNthWvFE3RSMC0Sigr
 GAYNgsNhDCjvlwPl+o6I1EUpZ5sXyyECDVZttuQc4nzR8cB7C0+zNMuSG/zFTmq6TpGyAmtIwL2 5xYv5WYu1JNHz5Xx+jbgDcx9OGP2lGQsXqLhorNQg940NgG1UcbtwI5TLEu2qPKu4iSXz2+xNhq WbcTvOcIYaJCe6gHCjma1lKtp5maMK/8BoUnwkrah6Iyfn/4nXRmsGy6MY/E3SIKdA+H+d3rg9F
 EhY+tMfTP2XofCQN2MwMi7S3GBnMhNPz3q19vlioeB3p9rIvczpjKY8+a2yCCxowOjhqgiNa
X-Proofpoint-GUID: 1iY9EhcsNG1qREPel1S4Cy_7U1PbK6Uf
X-Proofpoint-ORIG-GUID: 1iY9EhcsNG1qREPel1S4Cy_7U1PbK6Uf
X-Authority-Analysis: v=2.4 cv=M6hNKzws c=1 sm=1 tr=0 ts=68223903 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=r3DxsCx48UUfYcQ2vO0A:9

Refactor the chunk allocation path to use list_head for managing
btrfs_device_info, replacing the previous kcalloc()d array and sort()
approach. Provides better code consistency and prepares for adding more
sort choices in following patches.

Device info structs are now allocated individually via kzalloc(), added to
a list, and sorted using list_sort(). Associated functions are updated to
take struct list_head * as arg. Cleanup iterates the list for kfree().

Finally, calculates smallest_space during gather_device_info() and stores
it in alloc_chunk_ctl to simplify decide_stripe_size_*() logic, avoiding
lookups in the sorted list.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 101 ++++++++++++++++++++++++++++-----------------
 fs/btrfs/volumes.h |   1 +
 2 files changed, 65 insertions(+), 37 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 704ef78999e0..2ae6ead3fb43 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5071,10 +5071,14 @@ static int btrfs_add_system_chunk(struct btrfs_fs_info *fs_info,
 /*
  * sort the devices in descending order by max_avail, total_avail
  */
-static int btrfs_cmp_device_info(const void *a, const void *b)
+static int btrfs_cmp_device_space(void *priv, const struct list_head *a,
+				  const struct list_head *b)
 {
-	const struct btrfs_device_info *di_a = a;
-	const struct btrfs_device_info *di_b = b;
+	const struct btrfs_device_info *di_a;
+	const struct btrfs_device_info *di_b;
+
+	di_a = list_entry(a, struct btrfs_device_info, list);
+	di_b = list_entry(b, struct btrfs_device_info, list);
 
 	if (di_a->max_avail > di_b->max_avail)
 		return -1;
@@ -5131,6 +5135,8 @@ struct alloc_chunk_ctl {
 	u64 dev_extent_min;
 	u64 stripe_size;
 	u64 chunk_size;
+	/* Smallest free space of all available devices */
+	u64 smallest_avail;
 	int ndevs;
 	/* Space_info the block group is going to belong. */
 	struct btrfs_space_info *space_info;
@@ -5205,6 +5211,7 @@ static void init_alloc_chunk_ctl(struct btrfs_fs_devices *fs_devices,
 	ctl->ncopies = btrfs_raid_array[index].ncopies;
 	ctl->nparity = btrfs_raid_array[index].nparity;
 	ctl->ndevs = 0;
+	ctl->smallest_avail = 0;
 
 	switch (fs_devices->chunk_alloc_policy) {
 	default:
@@ -5221,9 +5228,10 @@ static void init_alloc_chunk_ctl(struct btrfs_fs_devices *fs_devices,
 
 static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 			      struct alloc_chunk_ctl *ctl,
-			      struct btrfs_device_info *devices_info)
+			      struct list_head *devices_info)
 {
 	struct btrfs_fs_info *info = fs_devices->fs_info;
+	struct btrfs_device_info *device_info;
 	struct btrfs_device *device;
 	u64 total_avail;
 	u64 dev_extent_want = ctl->max_stripe_size * ctl->dev_stripes;
@@ -5233,7 +5241,7 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 	u64 dev_offset;
 
 	/*
-	 * in the first pass through the devices list, we gather information
+	 * In the first pass through the devices list, we gather information
 	 * about the available holes on each device.
 	 */
 	list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list) {
@@ -5274,16 +5282,26 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 			continue;
 		}
 
+		if (ctl->smallest_avail == 0 || ctl->smallest_avail > max_avail)
+			ctl->smallest_avail = max_avail;
+
 		if (ndevs == fs_devices->rw_devices) {
 			WARN(1, "%s: found more than %llu devices\n",
 			     __func__, fs_devices->rw_devices);
 			break;
 		}
-		devices_info[ndevs].dev_offset = dev_offset;
-		devices_info[ndevs].max_avail = max_avail;
-		devices_info[ndevs].total_avail = total_avail;
-		devices_info[ndevs].dev = device;
+
+		device_info = kzalloc(sizeof(*device_info), GFP_KERNEL);
+		if (!device_info)
+			return -ENOMEM;
+
+		list_add_tail(&device_info->list, devices_info);
 		++ndevs;
+
+		device_info->dev_offset = dev_offset;
+		device_info->max_avail = max_avail;
+		device_info->total_avail = total_avail;
+		device_info->dev = device;
 	}
 	ctl->ndevs = ndevs;
 
@@ -5298,16 +5316,14 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 	default:
 		fallthrough;
 	case BTRFS_DEV_ALLOC_BY_SPACE:
-		sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
-		     btrfs_cmp_device_info, NULL);
+		list_sort(NULL, devices_info, btrfs_cmp_device_space);
 		break;
 	}
 
 	return 0;
 }
 
-static int decide_stripe_size_regular(struct alloc_chunk_ctl *ctl,
-				      struct btrfs_device_info *devices_info)
+static int decide_stripe_size_regular(struct alloc_chunk_ctl *ctl)
 {
 	/* Number of stripes that count for block group size */
 	int data_stripes;
@@ -5319,8 +5335,7 @@ static int decide_stripe_size_regular(struct alloc_chunk_ctl *ctl,
 	 * The DUP profile stores more than one stripe per device, the
 	 * max_avail is the total size so we have to adjust.
 	 */
-	ctl->stripe_size = div_u64(devices_info[ctl->ndevs - 1].max_avail,
-				   ctl->dev_stripes);
+	ctl->stripe_size = div_u64(ctl->smallest_avail, ctl->dev_stripes);
 	ctl->num_stripes = ctl->ndevs * ctl->dev_stripes;
 
 	/* This will have to be fixed for RAID1 and RAID10 over more drives */
@@ -5354,19 +5369,23 @@ static int decide_stripe_size_regular(struct alloc_chunk_ctl *ctl,
 }
 
 static int decide_stripe_size_zoned(struct alloc_chunk_ctl *ctl,
-				    struct btrfs_device_info *devices_info)
+				    struct list_head *devices_info)
 {
-	u64 zone_size = devices_info[0].dev->zone_info->zone_size;
+	struct btrfs_device_info *device_info;
+	u64 zone_size;
 	/* Number of stripes that count for block group size */
 	int data_stripes;
 
+	device_info = list_first_entry(devices_info,
+				       struct btrfs_device_info, list);
+	zone_size = device_info->dev->zone_info->zone_size;
 	/*
 	 * It should hold because:
 	 *    dev_extent_min == dev_extent_want == zone_size * dev_stripes
 	 */
-	ASSERT(devices_info[ctl->ndevs - 1].max_avail == ctl->dev_extent_min,
+	ASSERT(ctl->smallest_avail == ctl->dev_extent_min,
 	       "ndevs=%d max_avail=%llu dev_extent_min=%llu", ctl->ndevs,
-	       devices_info[ctl->ndevs - 1].max_avail, ctl->dev_extent_min);
+	       ctl->smallest_avail, ctl->dev_extent_min);
 
 	ctl->stripe_size = zone_size;
 	ctl->num_stripes = ctl->ndevs * ctl->dev_stripes;
@@ -5391,7 +5410,7 @@ static int decide_stripe_size_zoned(struct alloc_chunk_ctl *ctl,
 
 static int decide_stripe_size(struct btrfs_fs_devices *fs_devices,
 			      struct alloc_chunk_ctl *ctl,
-			      struct btrfs_device_info *devices_info)
+			      struct list_head *devices_info)
 {
 	struct btrfs_fs_info *info = fs_devices->fs_info;
 
@@ -5418,7 +5437,7 @@ static int decide_stripe_size(struct btrfs_fs_devices *fs_devices,
 		btrfs_warn_unknown_chunk_allocation(fs_devices->chunk_alloc_policy);
 		fallthrough;
 	case BTRFS_CHUNK_ALLOC_REGULAR:
-		return decide_stripe_size_regular(ctl, devices_info);
+		return decide_stripe_size_regular(ctl);
 	case BTRFS_CHUNK_ALLOC_ZONED:
 		return decide_stripe_size_zoned(ctl, devices_info);
 	}
@@ -5511,15 +5530,17 @@ struct btrfs_chunk_map *btrfs_alloc_chunk_map(int num_stripes, gfp_t gfp)
 }
 
 static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
-			struct alloc_chunk_ctl *ctl,
-			struct btrfs_device_info *devices_info)
+					      struct alloc_chunk_ctl *ctl,
+					      struct list_head *devices_info)
 {
 	struct btrfs_fs_info *info = trans->fs_info;
 	struct btrfs_chunk_map *map;
 	struct btrfs_block_group *block_group;
+	struct btrfs_device_info *device_info;
 	u64 start = ctl->start;
 	u64 type = ctl->type;
 	int ret;
+	int dev_cnt = 0;
 
 	map = btrfs_alloc_chunk_map(ctl->num_stripes, GFP_NOFS);
 	if (!map)
@@ -5534,13 +5555,17 @@ static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
 	map->sub_stripes = ctl->sub_stripes;
 	map->num_stripes = ctl->num_stripes;
 
-	for (int i = 0; i < ctl->ndevs; i++) {
+	list_for_each_entry(device_info, devices_info, list) {
+		if (dev_cnt >= ctl->ndevs)
+			break;
 		for (int j = 0; j < ctl->dev_stripes; j++) {
-			int s = i * ctl->dev_stripes + j;
-			map->stripes[s].dev = devices_info[i].dev;
-			map->stripes[s].physical = devices_info[i].dev_offset +
+			int s = dev_cnt * ctl->dev_stripes + j;
+
+			map->stripes[s].dev = device_info->dev;
+			map->stripes[s].physical = device_info->dev_offset +
 						   j * ctl->stripe_size;
 		}
+		dev_cnt++;
 	}
 
 	trace_btrfs_chunk_alloc(info, map, start, ctl->chunk_size);
@@ -5583,7 +5608,7 @@ struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *info = trans->fs_info;
 	struct btrfs_fs_devices *fs_devices = info->fs_devices;
-	struct btrfs_device_info *devices_info = NULL;
+	LIST_HEAD(devices_info);
 	struct alloc_chunk_ctl ctl;
 	struct btrfs_block_group *block_group;
 	int ret;
@@ -5612,27 +5637,29 @@ struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
 	ctl.space_info = space_info;
 	init_alloc_chunk_ctl(fs_devices, &ctl);
 
-	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
-			       GFP_NOFS);
-	if (!devices_info)
-		return ERR_PTR(-ENOMEM);
-
-	ret = gather_device_info(fs_devices, &ctl, devices_info);
+	ret = gather_device_info(fs_devices, &ctl, &devices_info);
 	if (ret < 0) {
 		block_group = ERR_PTR(ret);
 		goto out;
 	}
 
-	ret = decide_stripe_size(fs_devices, &ctl, devices_info);
+	ret = decide_stripe_size(fs_devices, &ctl, &devices_info);
 	if (ret < 0) {
 		block_group = ERR_PTR(ret);
 		goto out;
 	}
 
-	block_group = create_chunk(trans, &ctl, devices_info);
+	block_group = create_chunk(trans, &ctl, &devices_info);
 
 out:
-	kfree(devices_info);
+	while (!list_empty(&devices_info)) {
+		struct btrfs_device_info *device_info;
+
+		device_info = list_first_entry(&devices_info,
+					       struct btrfs_device_info, list);
+		list_del(&device_info->list);
+		kfree(device_info);
+	}
 	return block_group;
 }
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 0cc799629ccf..dea6265a2dc8 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -594,6 +594,7 @@ struct btrfs_io_context {
 };
 
 struct btrfs_device_info {
+	struct list_head list;
 	struct btrfs_device *dev;
 	u64 dev_offset;
 	u64 max_avail;
-- 
2.49.0


