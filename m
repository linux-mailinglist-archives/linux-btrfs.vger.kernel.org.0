Return-Path: <linux-btrfs+bounces-5040-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CC78C7504
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 13:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8117B1F245D6
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 11:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7153E1459E0;
	Thu, 16 May 2024 11:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eCYymtlA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IXK036BG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD20C145354
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 11:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715857989; cv=fail; b=t7ckGikV/24zhNOQMjd2xoQ5NSYqVJ66tEQxyTPFReSrB1r2fK45WxYw4n6C7jhcqOeWEHxmUAr3hP468YOaCV6Nq7EM2Su+8TLjDc3IDoUiL3bWHTe6LZW7wHRQVeiG3yLtUR7mbQdkdFPJY3m/ROOgJz2IfhcvL56Prh+OBAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715857989; c=relaxed/simple;
	bh=UOIJIBx7VGiJ4cMSmUCrTKHbbyF6Y5WKiuTeXPYBEcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YzpuArfPHLcb+VLL+BpM4awrHuT1gcDYzpQlgiOhbXEnjPpbpe72t5ZQwCmiDrspvvoYLYgKdQN3sGEAVy2UiqueXo5yGMtwCfMuy7iM+oZ11C5bGj16xDw/1ukKFLIfgRhsb01fZbt8f/yO4skRlaTlMY/ut4CdCgSB79k2ojg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eCYymtlA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IXK036BG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44G9NTN1006682
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 11:13:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=Gsu+Z2KD/wEoh/56A1O8vQ42XeScXWBHJH+jkhzDhVQ=;
 b=eCYymtlAV6SrXvVwmCCikMMsPtbxF0cJ04u57xQDjoWC8GXqCN5aKGDU96pzkgXEbA2U
 SVGC7rb5zUFVCYI3zbwVaoonLRCyOMDunXhH8etfqlWOGQiyG0zWVjWixQR45tN3czD+
 N6Fw+r6oMYjTRIuGdcWQBU7ndlKB557TA36n6+xLViCCCnbyQOwnTuR4Ue+1/eTrDKjM
 iDdyjEUiuIaA9zaUQkA4FNcaNhPMUY7GPgutz8jPZOHaOqzKwbamQkMXmgJQCFUfqS19
 ikmMBY5RQZWJoSG9Hd08Ra+AFgUpG7RC1dHFK38j1tY86HiSJydgT/hsOeulgX5Y3i1l Iw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3rh7fbj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 11:13:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44GB2MUC000624
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 11:13:05 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y4fstd0p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 11:13:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsrSmymiO67MxrGhZmUeziEay2B9KUq/+7YO0zN38gUA9j7r7GloMayOHbVvojTfhJ23KXP09HKWoqBojZTWl/fdNZQGqB7oJCNp1vhWVbzF1OGlFp8p9BVw8U1u4Foy0eKwH9RnZOCA1sqIKB96F35l0wXq+vdLj6ny+CAc4be7iVKl8xj23VgMS6wKHx7xsGJ638jDQbBckgZcbB6/vss8zhnJbk7L2iKD1UKqbsBmImskTwoQvTyAZANXf16NsrTwTpaJ7O6GSYd+xjRR4P3UDJ6S65hVAwU9cEM4Pw8ME3B1FRDOGoiDkk5HyfyuoS+iLw288FLxny9pcB3wnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gsu+Z2KD/wEoh/56A1O8vQ42XeScXWBHJH+jkhzDhVQ=;
 b=bRVoxSeF67k03BeiZuF2jcp34PSqp7O/sR+HJFonUeWSFsNBnKPlXx+pUluNEtkVrUHR9WeD4/jBdbjgtDQD4FU2kStxQj568QDEUdgrLN8LnOahztujoWa0ZZH7t3qH3WMwoz4dMd2fr0Pim2QNPJBbycHwKquLaTvmDVT4O1hzB958wQIiObcliQ9HElhwKaIRDuBB5L22yCLX8EHMw7lhbSWRKwpLpMmMEoGzy+PFyMx6Kac+poXyZJtzTQKD1hr84HUV0RtgBDfqtXuhW0e7H2gLxCxqsCcySgUWvwm1uKYylMCeAAC6WK47vAF0UZL9sN96DnwdCe837pFsgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gsu+Z2KD/wEoh/56A1O8vQ42XeScXWBHJH+jkhzDhVQ=;
 b=IXK036BGz6/fpb/Vihkycbbqnzs6Q5dcDPJf/jdYgSgBCJMZMozBEE6RPUajyvm9a+Xvbp1J8uHMgGXyOmC4eYAZnsfNogInSThTPU+PnifBXn2V6TTwJovRGd+17EVWiuZnbBx/lv6cIeJ0FaS6Ya1zpiCt38qpAiUQWCu/M4k=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB4345.namprd10.prod.outlook.com (2603:10b6:5:21a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 11:13:03 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 11:13:03 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v3 4/6] btrfs: rename err in btrfs_recover_relocation
Date: Thu, 16 May 2024 19:12:13 +0800
Message-ID: <c6c529d0f3848c6e291e33917418e83c28adc4a5.1715783315.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1715783315.git.anand.jain@oracle.com>
References: <cover.1715783315.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0199.apcprd04.prod.outlook.com
 (2603:1096:4:187::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM6PR10MB4345:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d335e1f-6f99-49cd-f604-08dc75992765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ot+T367pyYi+GZ3obx7hICXBVi+/84i19O3/2fOJsKDtc19YUdGgedvuPeTQ?=
 =?us-ascii?Q?higSXErZzj8nzACZhuTeyUTWxhubwgW3srg6Li73JgWq+lUHDl3lP6ns6f+c?=
 =?us-ascii?Q?2j+M7pE1Koxb1s2kMblLxta+xubxFLAyKRlo9RTR+3wYMrGFDZN/RIlTyrFH?=
 =?us-ascii?Q?vCXZyQ/iuS+8Rr7OBeh+Q9NjFwCU56QcRdz+2/CLJJWLEXndTfTdwNUmvhYo?=
 =?us-ascii?Q?JgH3z+WkyoAI5ZYov/CYfft79/zzzv5bpQ54ag6xN9lLclrWXduTMB9HRjJe?=
 =?us-ascii?Q?UQpK+/bFC1a6VsJtnzIQeQGK1ik78pKnZCYh4xe15J14a2y4OToCdqA5WORM?=
 =?us-ascii?Q?xhAmgZNJAWhHpkYCZBE+3yiRLmKe55/ifeVXNijN4qakPdYtyYHcHefcSFcr?=
 =?us-ascii?Q?BpvXLeVyrhMEbIBc7SMtDge2UhBioRTquPJrKgKOxSfLt+DnH5JMNlDvO0Uk?=
 =?us-ascii?Q?w8kx0HDXI4aXmpCfpBWxb5eI2wDR+O6BpvVJeOFBmai5J+CGmIFyG13NC69B?=
 =?us-ascii?Q?hWgexgkQOaEUqKITjUBUs/UaT+IdxKZJtUlQVcL21cwcWoXOgVrYjwHvfcUK?=
 =?us-ascii?Q?vBK9tcETO6WPm1QA8j4flmFib8cpmtBAE3bt8Fo84l2CagiOPe7OKb82t9l6?=
 =?us-ascii?Q?eyWmOLCEvm4iK3Vjs6y+hYyGp0uIcTjBx3RrY7KgkUGpSfa+cvtshke7pRtD?=
 =?us-ascii?Q?P803oNlcus6P7DkqxVG9knAVXG4m+EvsIJhBheRvrgJaMPPvwTmYzQZKGQJh?=
 =?us-ascii?Q?qEA2DKWl9e75E5JyDFeuZm3/JYBPPs0eK8ZR3EA+4+E2Mlue96mIEefq6qW+?=
 =?us-ascii?Q?MYP1rxdbeALgTmGItno+XqJFPaTQkcGmaQH0izy5PO3UiXTCh/et4hGgqCkq?=
 =?us-ascii?Q?0jI7HtUXvjZ0lPRQUKkg8vQInL89SBMttE3OY9BJdzF/AnJ8JOWBQ8oCCKjm?=
 =?us-ascii?Q?reC+Ud5j4cO1CSu14MPlrRrCP+2kBGwGLd2wLwHN2U7hF4pQrf0zAG85GMuw?=
 =?us-ascii?Q?P0PVAeoysfCXrCRdd3NHbLr+FO5456B68aHxMfbkGrh26n8KbjSTsVvA7r5R?=
 =?us-ascii?Q?tTtSWyoMXfoTLGYct+9pqUTDCFSq+oP2rKeZErMp1sNvHFvZ7QWg+JFkVXxy?=
 =?us-ascii?Q?vhL0UELRxZg7w55guJKQvhDgxZR5DDKRn6kwp+M1UjXF5i3kouWhwrZ7dbpn?=
 =?us-ascii?Q?2xCcabojK+3kMa/4oEMc3RjZN5OkR31Jwe7n6H1IYcHmdItf0aeXjsk4nnxz?=
 =?us-ascii?Q?ItkLUlyKZhiansAZ2JA5SRCCiPllertdqR+UwpdnAg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fZpYIJkRDIj/21RKddBd7xxuBr2r5a7AteQlqqgdYsCzIeEuHjmNt+cgJIY3?=
 =?us-ascii?Q?Hv+XbVaTxiSPTlkK85dEvUHOpsAg3WYZwJLIJvUl6+Y8GvgFx+Jx0aSiSGBW?=
 =?us-ascii?Q?b490aECjIOwtlAf3CIEjn3BBc+CQtK9ykEsSnMAbkJn8zezsmusY3rAGqvuW?=
 =?us-ascii?Q?vG9mlRUP5Y0Yok/qNtMjs+WY1+iOi2cFOH0Z6mp5oWZij5rkl2QWHa9k29UE?=
 =?us-ascii?Q?T4kyjSb48THwJq9PEIh9CsyA8bT7pkK4KRePuq/1af16TdpcT7+/SP2H/NOX?=
 =?us-ascii?Q?VugWS99kFpIOVa0w/7imr3hx/bFsGAGqQmKPk8ltoCmQN3TDJAKXdBcHp7wW?=
 =?us-ascii?Q?v+qOyQEP6oiEx1dOLqCMMAmJXMiG92fvlRCVWPUd3GaYzhRH+Rz+OXz1eL2Z?=
 =?us-ascii?Q?pRrVwJbG+yhZObiH80Drvdyi+TKDO4Qum19fH64P48dcThKNjx2kLMIwmhpJ?=
 =?us-ascii?Q?FuEIUU2VJaggmTrcgDPyj7cy/sPFXAbYIhvDWm2DB82DqLGzO5V26OM0GDx9?=
 =?us-ascii?Q?4g6+7yzMd8dH+z+q5NLNR0YN/EdvbNbpwV1mHriOk6+KYkF8cmogMcJvk84l?=
 =?us-ascii?Q?UV85DqtzxhKxtRqR+zv9hBd1AaL3m7diMYpD+uyKN2VNXfDFe2XyVlGNBSEr?=
 =?us-ascii?Q?H1iHejFHEHNjYm3qhdwVIzPuuQZ68o+vRcTSK38JpAa0Kw3p04TI+whk9DTg?=
 =?us-ascii?Q?UgD8OJO1jtTDkWJi1iByWBdV+C6H4lfkasSbegiD0YGoxaD99eJDESTLitRd?=
 =?us-ascii?Q?oUmo5SztfatLfKPj13ZVcT5p1edhCQKzC3FzgoI80amBz2mz1jKbP2UwiCCB?=
 =?us-ascii?Q?QXLdOjbCP2m5DFSn9KBLXW9B078Zs69A2SlkV+EWwL3gohFul7BfuTrKjVgE?=
 =?us-ascii?Q?Orz3+lA7cBvtPsyvJ6sIRhoq28O69hM+J3WpXNxEkC49Fd/unirBDudjxsWO?=
 =?us-ascii?Q?vqTOWuNWBp+CDXjrp4JNAjPqEqm6M2ptYHRh4X+a4epsQ9SpCmQko8x8s+lb?=
 =?us-ascii?Q?ADPEaHRjtTGreNlYlk6E6Ur8gqo3oL79R6aGdAAUsP9fqLHBi3GrTyIuQ8BU?=
 =?us-ascii?Q?M9XQ9MMfejT3utekB2EmuAHuOo4Qz4G+xVeI2ZjmjVmdeWmk6TXdzEQ0woaQ?=
 =?us-ascii?Q?kmQQ/bWFhN7Gnq2DsoGjScZPPTIjPeatqwif8Hk863WYdqMiSnHMe1f1bl9o?=
 =?us-ascii?Q?0uA78YkB6vkirtvcf/o2gCGkcEgdlRVu5pJfm1BxXUhCfw3uSezBzp/MPNFI?=
 =?us-ascii?Q?M/rKt/uUm2aAAXvLBO8wvbkkek94xr1igrjkqAMHemU6Hq1XJ4mF4E0++v85?=
 =?us-ascii?Q?dRmpG5icYguxn/HUAGvhhPyDxrk1WvZoFCwgr6R8Pc6uXRtVDmpvcNBfsmYF?=
 =?us-ascii?Q?qbl5c99F1tX4n6t4mehJoMKmRWUB/fiVCh7MkR8uoI8MmgdpHGHSbz/gA3y4?=
 =?us-ascii?Q?cLK8xDGp8gFaMwV75ek+5XxAaZWczwMGxN2W71ezWynnG6xi+7rMbJl+a6A9?=
 =?us-ascii?Q?1gNULJDw2v8lZWlVGcwZxvPwo2fYVMFH2YB8BGWTDC4JKxCyGP5sQ/g2lh1f?=
 =?us-ascii?Q?mQVHmGeTfV6fB25jHMNMJPaOrcxcg6hSTza0h/pB4F9oITO8fMvIGM5hD8ZB?=
 =?us-ascii?Q?/A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mrfnS1uj0okR24vXxkI1nl1nJZ5kBWkVJKibPC+ZJbOhlgrcZrySpWYME7CaRBw1fUJQDpow9Bg1I6zxyIrlkY41LVoFbCrKrVqCopZtM1DomODB+Mylhd61XaIS/t2ybjQh9eJjxmnbNZPLTpzLkqTtTtFOW6qwC/K0v0QlQNwDdWHgIKNssJx4QT+74jNAASj1pgCvEIBTmwr0oxhewsA3iaaY3aqkqiJMjIPtM09yBR4WIEGtcJpag5ro/G0cQLbn00yzigNwwK6D53w9tYyYQJaJs4m9hIrJ9SQJQ+kAGzcj9+f9VeTE/MB4/Xjzpyk95dKJi0pU4sj79lLjHelnd5lvH2SHuVhp4CsZiSEKgditJjgjno5w/gl9zSiPZMsACTxPUbKXEDvJmkxfIUyV9O6VyeoxoAThy8eC0tUJSXxPYC0AzJzARQJzQbKI6IzSDfSD+FH7jQadZYh8R8WeEjNivgbrTkqijHPOc6a9LC2O4aJCD1juydQmPZYb62Wva7qqhMFSS5KXcqKSawtXatIr2183iapBH34S8bm8Fgjbx/kx2E9DauM2jTijdXmqnthLixGlXgGJ1isKOyfWf9ibtvpDHeATL96A8Rc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d335e1f-6f99-49cd-f604-08dc75992765
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 11:13:03.3707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mR9hUJJlbpjEeLRKaXy8UL7RTwzyzDp3fFSPvmdR1BQVEv7sfmO2tm+V+kEk5Vv6icNCnD3mHEF3Rvf3FMPeYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4345
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_05,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405160080
X-Proofpoint-ORIG-GUID: 4oOY5z7L-s-6-KxnZ3KwUuWaextkFW6W
X-Proofpoint-GUID: 4oOY5z7L-s-6-KxnZ3KwUuWaextkFW6W

Fix coding style: rename the return variable to 'ret' in the function
btrfs_recover_relocation instead of 'err'.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3: new 

 fs/btrfs/relocation.c | 56 +++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index e24deb7f0504..ccaa359648ef 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4222,7 +4222,7 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 	struct reloc_control *rc = NULL;
 	struct btrfs_trans_handle *trans;
 	int ret2;
-	int err = 0;
+	int ret = 0;
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -4234,16 +4234,16 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 	key.offset = (u64)-1;
 
 	while (1) {
-		err = btrfs_search_slot(NULL, fs_info->tree_root, &key,
+		ret = btrfs_search_slot(NULL, fs_info->tree_root, &key,
 					path, 0, 0);
-		if (err < 0)
+		if (ret < 0)
 			goto out;
-		if (err > 0) {
+		if (ret > 0) {
 			if (path->slots[0] == 0)
 				break;
 			path->slots[0]--;
 		}
-		err = 0;
+		ret = 0;
 		leaf = path->nodes[0];
 		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 		btrfs_release_path(path);
@@ -4254,7 +4254,7 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 
 		reloc_root = btrfs_read_tree_root(fs_info->tree_root, &key);
 		if (IS_ERR(reloc_root)) {
-			err = PTR_ERR(reloc_root);
+			ret = PTR_ERR(reloc_root);
 			goto out;
 		}
 
@@ -4265,13 +4265,13 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 			fs_root = btrfs_get_fs_root(fs_info,
 					reloc_root->root_key.offset, false);
 			if (IS_ERR(fs_root)) {
-				err = PTR_ERR(fs_root);
-				if (err != -ENOENT)
+				ret = PTR_ERR(fs_root);
+				if (ret != -ENOENT)
 					goto out;
-				err = mark_garbage_root(reloc_root);
-				if (err < 0)
+				ret = mark_garbage_root(reloc_root);
+				if (ret < 0)
 					goto out;
-				err = 0;
+				ret = 0;
 			} else {
 				btrfs_put_root(fs_root);
 			}
@@ -4289,12 +4289,12 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 
 	rc = alloc_reloc_control(fs_info);
 	if (!rc) {
-		err = -ENOMEM;
+		ret = -ENOMEM;
 		goto out;
 	}
 
-	err = reloc_chunk_start(fs_info);
-	if (err < 0)
+	ret = reloc_chunk_start(fs_info);
+	if (ret < 0)
 		goto out_end;
 
 	rc->extent_root = btrfs_extent_root(fs_info, 0);
@@ -4303,7 +4303,7 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 
 	trans = btrfs_join_transaction(rc->extent_root);
 	if (IS_ERR(trans)) {
-		err = PTR_ERR(trans);
+		ret = PTR_ERR(trans);
 		goto out_unset;
 	}
 
@@ -4323,15 +4323,15 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 		fs_root = btrfs_get_fs_root(fs_info, reloc_root->root_key.offset,
 					    false);
 		if (IS_ERR(fs_root)) {
-			err = PTR_ERR(fs_root);
+			ret = PTR_ERR(fs_root);
 			list_add_tail(&reloc_root->root_list, &reloc_roots);
 			btrfs_end_transaction(trans);
 			goto out_unset;
 		}
 
-		err = __add_reloc_root(reloc_root);
-		ASSERT(err != -EEXIST);
-		if (err) {
+		ret = __add_reloc_root(reloc_root);
+		ASSERT(ret != -EEXIST);
+		if (ret) {
 			list_add_tail(&reloc_root->root_list, &reloc_roots);
 			btrfs_put_root(fs_root);
 			btrfs_end_transaction(trans);
@@ -4341,8 +4341,8 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 		btrfs_put_root(fs_root);
 	}
 
-	err = btrfs_commit_transaction(trans);
-	if (err)
+	ret = btrfs_commit_transaction(trans);
+	if (ret)
 		goto out_unset;
 
 	merge_reloc_roots(rc);
@@ -4351,14 +4351,14 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 
 	trans = btrfs_join_transaction(rc->extent_root);
 	if (IS_ERR(trans)) {
-		err = PTR_ERR(trans);
+		ret = PTR_ERR(trans);
 		goto out_clean;
 	}
-	err = btrfs_commit_transaction(trans);
+	ret = btrfs_commit_transaction(trans);
 out_clean:
 	ret2 = clean_dirty_subvols(rc);
-	if (ret2 < 0 && !err)
-		err = ret2;
+	if (ret2 < 0 && !ret)
+		ret = ret2;
 out_unset:
 	unset_reloc_control(rc);
 out_end:
@@ -4369,14 +4369,14 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 
 	btrfs_free_path(path);
 
-	if (err == 0) {
+	if (ret == 0) {
 		/* cleanup orphan inode in data relocation tree */
 		fs_root = btrfs_grab_root(fs_info->data_reloc_root);
 		ASSERT(fs_root);
-		err = btrfs_orphan_cleanup(fs_root);
+		ret = btrfs_orphan_cleanup(fs_root);
 		btrfs_put_root(fs_root);
 	}
-	return err;
+	return ret;
 }
 
 /*
-- 
2.38.1


