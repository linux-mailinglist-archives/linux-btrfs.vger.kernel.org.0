Return-Path: <linux-btrfs+bounces-10666-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EAE9FF4B7
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jan 2025 19:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91EC618823DE
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jan 2025 18:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30241E2852;
	Wed,  1 Jan 2025 18:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YWPeqdDF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kZDkANH3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4671E22E9
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Jan 2025 18:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735755010; cv=fail; b=aU2i2bRqXnAR2EmM+2qJ0HYd9C38eIPfCL/XyC/KjRZEBDOtXE+xBJJfrBNHa+kAC2eVNHQBxjUu1oNjeRMNtSxHMG1ie3hX7CRxY5+m7oV6PvVxeggGnEXfyOSN8dzljHhiXmiidzl2Gp0HzG/ff2ynk06ICJ++EZcLnBTHs6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735755010; c=relaxed/simple;
	bh=sgx9FCTgYUCNiS2mxBqetvI7WQrlGaYR6ddwxzWYR1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E6BvfNg0LAWpKgPU3srD9JuTPYIu34UQL5X1b7SDYVL5b7KIAWHuwiLY2e6t8f8eG0KS/PNA7JKUPl5/i6OvQ84XE18eq+7Hb/zQMh5hvEYvFVVMY6OXO/Wz2B7civh7G/6+JlysJJF5qtuloRd8wl33p+/08g+0iiNH9J6DmfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YWPeqdDF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kZDkANH3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 501Fl6US013168;
	Wed, 1 Jan 2025 18:09:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=mtH+kHj25iJURDTetmMUln2QzgW+K7iGiglDsQ0ZVpQ=; b=
	YWPeqdDFpO+bVWxkktN4XhKexEjVLTmxHDGaIzFrF9Nb8mXTBCRLh2D4cazSyX4g
	4y/7zMkXwxZFPV+/8+nbqe5tX393lchlQ6rqHLKhDpf92p6B7urcrQzhKqH2qOO/
	awmDUoEbYExZTNtdcIguuqnH/lUg0PQF0nl2xQ9fSpnsvewtQP+jlw7zU209QQRG
	hmi6y2V7l+5e0Lk7O41YfXs6ZE4Rbvk8GX66oUgld2guDMmd9xxJjVeDQXPFBUh3
	+XDKRx105+XYWtYH0CsyQea4psXuWZG9DF554/vVzLU80SzZr0Px/smhkmR8ecy6
	WD/BGneBAUHQ5Lsu63JAKw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t88a4g6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Jan 2025 18:09:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 501EGYf6009070;
	Wed, 1 Jan 2025 18:09:57 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s861h1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Jan 2025 18:09:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxJfpZj586lUGA2ifpKTm3VjcrYx4jTeWIwRDc3i9VfEmwksuaot0aBy/VJ+14VaxZqSQSdfhm2LCFl6kxjbXksF8jhnDsYIldVcJPY7ivkBT28GOGv5xOf2jDK2NMfBPsLI7bLgEuRmamPjmBFmGtTx10sNx/2GCKfYp1AZPgoWuVtMx4LjMM4FODkukF04MzA91nUVjjBLNPD4OCyIzcPb3yTSxXJdCTYo1pxciA1PU2j0nLrYniuy+0Dux+LiPrxbhtcCfoPJrK1ynuHCE7aocBk7AdDznluTZZkmmhx2PEEx1arMN+IKefrcgPllu+dJ8C+FmtcIdyU43EcqCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtH+kHj25iJURDTetmMUln2QzgW+K7iGiglDsQ0ZVpQ=;
 b=qzwvKn9H9+RsD6zOEvRxIoMi+ZV9jTsfjA9nRncWuHolf0EigW/HkBM0CKAYpVCtnJTSNh7BdI7+psIViZhWZqlL9CbxcsY8SSt2ZT2SgqTgYSv8f8L5p4tgQylf0aRHV6qkLWciqNXh8qmuENm18fpJ+Qwh+T9WFtVgKLkMu5+xFpM582FLqeYODjv1FLalSzl2xE/KPomcICBWBejq1DT6QJVV0wmUdruFHeCcFo1myyH7u/Ryds2vrT3V90vb0iNBcyuIJhcEIznqr/QETj0834GKpt+0ugr7aZFs0L37tC3Iz7iI6DZyHHbuJb7hdtYKI2yXhucQlB2DYDxShw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtH+kHj25iJURDTetmMUln2QzgW+K7iGiglDsQ0ZVpQ=;
 b=kZDkANH36okcNT995ibe1nT66s/heemM3A/kpg5gVgzzhhRPIjIC3aqN7jxBZGNVhigYY7lm1HB/RUASZSDV3UHE3obQAEOEd80BvyyF7b1VDc7Zqlb04MIEPuAi5pwfUdZz026jwSTwIIJYL4SlDDJ9wz3TpkXRq4m9SXQLEKM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB5549.namprd10.prod.outlook.com (2603:10b6:a03:3d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Wed, 1 Jan
 2025 18:09:52 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8293.000; Wed, 1 Jan 2025
 18:09:52 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, Naohiro.Aota@wdc.com, wqu@suse.com, hrx@bupt.moe,
        waxhead@dirtcellar.net
Subject: [PATCH v5 05/10] btrfs: add read count tracking for filesystem stats
Date: Thu,  2 Jan 2025 02:06:34 +0800
Message-ID: <c4010cee5398e35a695def3ad97d4de6f136ae2c.1735748715.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1735748715.git.anand.jain@oracle.com>
References: <cover.1735748715.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB5549:EE_
X-MS-Office365-Filtering-Correlation-Id: b6a1ebcd-d3bb-41f6-375d-08dd2a8f7cb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?atimC+KnCJ25oBxJEjjH+L547zP0I/kSZc0lOhS8xAyeVDBG45/DnKa5fouf?=
 =?us-ascii?Q?lIvepCXWuTYyidU/Q7RGDzjLYVqJ46kPzmdDW+a0g416o494/q/WHFwpQbw/?=
 =?us-ascii?Q?tDtFd75m1KOAxyeMXNAIFucKvTV0uue9FBWv6qGJaLrEKRkZ8ww3NjzVHn6y?=
 =?us-ascii?Q?ANgzomNHnTnGh00fyIxBWKseyO6h3HYCBOY5e2oBBCCzaXYj3MLhmmiTEzJH?=
 =?us-ascii?Q?Gpz+mtrLPA9A+7+6b6KBMXXpODUNoVTJeIBEZH/Kd2v9+3t+0VS1wEJne/OE?=
 =?us-ascii?Q?0jFT8jQqE26TwuXbWsRFp3veT1gs6sME6dwWHx+J24JYgYqCf+uTzv2uHVhP?=
 =?us-ascii?Q?MpvELHWJEzl6p0ZNfdWA+tdKF2QGdfTFuiWJ6ZcvDleFAxwwT5/K1+MSk4Fo?=
 =?us-ascii?Q?4FUwZFxuG0iB0CLCcJBiyVLMKBxlTalrsXmK98Lm04e6Ipjq1eo0Houu+lAY?=
 =?us-ascii?Q?4liruPf/7e50tnqqVpfD0uMdnwwLUMZr6G/L9lnJgs9ZISyCRoNqRYUsNObf?=
 =?us-ascii?Q?E/bDe04EjVJ1+oY08HsSUMV2bkGo7Ii42SSiNhM2p70JAHRVUjEMgbNVCMtE?=
 =?us-ascii?Q?GkmQWbsqY7sYPBBB2GXd/vNQt5JWcCOJBeZCq3QhjZIamFPnQHrudeLTMiyi?=
 =?us-ascii?Q?v9pCPbDTaDdW0RwFCnO9Wd7EWSOituQK2K0ZaKuLwZqX0cacg5EqtaTN3oT/?=
 =?us-ascii?Q?t01EgBsOYfA5oZf01lF9ibGi01FmeUUx3KhTYCcL2D2MVL3Sh/WdCUPal91w?=
 =?us-ascii?Q?Yt7vNtOuIoKQS9t+3SgmhCnHW1xGhnuJq9hlZocID3rRZToy2/Mcj9RKdWBC?=
 =?us-ascii?Q?EHmCEFXW5MWuKF+mYGSfrtasAZuPSgiDAxcaG+ZS1MWhZha0t8FM9I942db/?=
 =?us-ascii?Q?JTRXLo+OkLqt9zZvZFrsJLsM7tMsv6C0aCF4ayQk7DWZ6zd+j0kdlyI1CeGe?=
 =?us-ascii?Q?Sh7z5My6JISDaUiMrY45z4EIasJ1A2j9kzJykZymWPmRkPmM+vkCk3dKGIxZ?=
 =?us-ascii?Q?s5KW2MAWtAC66SpaVV2jDOx5X+DLLKawfROhLC8tWfpzakBw1w0VINUCyNMO?=
 =?us-ascii?Q?nswMR/gJjgHswoiYC6oa7Wx6mBqWBiZoxt+CM/l6qVtkxBpxerieKBnzSLqP?=
 =?us-ascii?Q?92RG3eX2y9jTdYCuquHJPoFTUCfxOvEQJyWsSD5Fht14PcDAxeffYbabjdkZ?=
 =?us-ascii?Q?BLv2RIxVbDDWofIRjZVcqSacgOXxKd1hlA4TTQn/2IoLQSQCmjft175N57hC?=
 =?us-ascii?Q?JarK6YviwOFRsRO4h/LeFi+QOKyLvwKnubt0orD1Tox/so6+ln9E4jmDdo+T?=
 =?us-ascii?Q?fYR94xX6m525tBV2IYGMHJXco9wlQj+PuA8l++u1Veop1giorA9hFQDT1Wba?=
 =?us-ascii?Q?FRp35MR6dwze6NW1bUHdB/lPudFl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ng4I7qrn3/MSllA7Qt0TwdQcpFcClAAp+cCKDf6evc/gqXZQgAe3wByvzHy/?=
 =?us-ascii?Q?V0dVeP/5ApZ1GauRYW60Sz2xr/VmWk9S8g+PYLkkUYzmWRygP/vbmbjlLuF+?=
 =?us-ascii?Q?dcHFqYer9+g9buc7rqPhqxqDtHE6YteKogdowJ673JpceL2baiDj1bqFDn8N?=
 =?us-ascii?Q?+PRVGI3WLAJqA6eulpsuFmUFPb7cq4Gtn17mhabA2JAnkYJjN1rvA2SEO2fC?=
 =?us-ascii?Q?QEPsPkRv2bk4OfLxsGvxp0eE2X/trRS4DswczMzgagVEt/S2KbEvtsNS3xnZ?=
 =?us-ascii?Q?0Bkx7UQ+NHJzcdDQV75F6seIhdTDqrqU6wXUz8OiFnUpvOoYDYidVagBW4PN?=
 =?us-ascii?Q?6XOLHQXOo/h8ly+VfK71w7LKO2cDPcSQCLO068+HD6/PmhD1Smu0YAGkkTbh?=
 =?us-ascii?Q?NgrmryD7jm1qgKT0Xfcc0mYtRH7UF2lMCuy8DkiiTG1IMSDz4xFmZ7lwBrSX?=
 =?us-ascii?Q?dGIYOrxdXt+thoLWjuqhGcMXHXKqxdDSa4ktvbJTdSUIEuRyDCyo3j19N+FH?=
 =?us-ascii?Q?+EVMB2cs6kh2x1CHasPRWK/+bzRLUbl56B1S2TwYNA85I2ZbKwP5YT5jro3F?=
 =?us-ascii?Q?d4AirwsYby+zudPBm5Kam26IxfP0BrlV5CMUqyA+kV8ftTlfyKtNozcpu8A9?=
 =?us-ascii?Q?0Mvr+BVfsVW4J2Ecyc+ID9sFHJVWwyWByGRB5CMNmnViIgT1jE9f8IZxuzDx?=
 =?us-ascii?Q?F65ABxkQMrr1BPVzdd5qmQklnPOHT11UkKfabovHPrnP7hfjYuNNhpcMXKti?=
 =?us-ascii?Q?/0wjePjm7oCTJi3W1cAnduTWBhF3aKObpSH42JSU6XLutQ8ig8+Y8J46b99E?=
 =?us-ascii?Q?h1EOefS+93PIXHAIsjDCB2RcaAb/WSkWIu32+g6yzNLi0aYMRlkxPgsieFnN?=
 =?us-ascii?Q?gMm848Jbo+5iKJExKt38sWCmoP4SQTXOjClldlGkmti1MBfOqsGRorZzn9oo?=
 =?us-ascii?Q?z2RApA+8zIGGDC+Vl4xc7uQOyiUs7my8q4bGCwDG6WYAiQUHMTjf4ZZVuVmm?=
 =?us-ascii?Q?dBqtlKpNpS4yAwxqUghE0mnpS/A2WpK8Xd8i6awQOIoobQxAod9bgi/FvxoN?=
 =?us-ascii?Q?kx9aUGWEjphIonR4/Bk4UiVTg2AM2XJL0ub1hXm7+kt2Gqv+AqfVGqWMU7Sl?=
 =?us-ascii?Q?GmrJ0SZrJG/MlxQ29qGQlp9Do0Nu0YLfZg6/zv9MX1+nCdrT5M3ELdCStNzG?=
 =?us-ascii?Q?/N5L4uus1NaTgsKxLdFTqXtVRof1jHBx0DzpyCdpd8aOgHUJKh/mnrYkAfv1?=
 =?us-ascii?Q?x9g/Xo6bGGYHRAhfy8iVJ2Rvno9qqqJQV2vuG+IRfq+xD55bvlz75EIWs0Iw?=
 =?us-ascii?Q?U6OrywIukwif0gkpsOpeyMhvefDjyKcGXCLk9BMPvRA8AYUR04U9oehb0FyS?=
 =?us-ascii?Q?qOBb7YSJIhsQYOJNVXyfZMs1WTOrEWdGCvUnzXpsdJyQuglh5cWp/ShnqlPQ?=
 =?us-ascii?Q?uhDZxtfy0T5t3nscoC5VAsnVppmd5omiGfnV18BmLs0RWQ+KxCSufMawEyS6?=
 =?us-ascii?Q?JKOjHtdFl4/Wc4Cke2CfDmnHlJzAWaiMtjRRmzeA1LrAbthgC91CLtvsZ04o?=
 =?us-ascii?Q?E+VfLONXehEBoCIA+OWDe1hjRnsX2/rsmL2nSmXn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rqEai6QLPsIuNnQWCGMwapNR0HGcvvfJ07kLAxD7uLp3A4LuJyT3N75DnEh5mZcN5VW9HPMZhol2aHM++iuegW8bJIt0KAdKrAYsnLrqjfoQpYIVVb8SvOKx+EeEjDUgY95eM8zuAwFaLj7RCtY0r7QPycerWgrBKR02n6p9mk8n7QUXDIFjVjfHKsSgVnT6dm2bA3MHWx9lItqfB6OdydPXEl+1oul0SlOJFoiCs0qBJ/xzUPIU7Iaudz0XtPHogcjr2jcmFEuFvFEjj8p15WSj///qoW8lizyEl/Boewl9lScoYsvEKu7WS81RhmmKiskO/f4TnTr2o+htWK0sk+INi9BPtGmkRXBSoS9U3OC+PfuhOoePDD5sRUNuhCT3tkp2BjygIr1Ep4uqoLjcADS2XpVG2+s5W6gdKRSRjvhxpvafTvgir3tGLXyWzDShuIpJrkYkTTmYxCSZnEdmosp4TVyIzup65oXE5j+yXh86DUYe0YoZ2pSBChVvc3G39yMNZOlD0xUsHzAkn4iuHH1cdmh6MWmDu9uvOiDqlRQYpU4d/98hd1DepmYBwRlz9tl8/+D0rD8PeTanKSQfn24ypYqYMNC1Xx+xtm9oE7I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a1ebcd-d3bb-41f6-375d-08dd2a8f7cb7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2025 18:09:52.0632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UU2/JnpNfKjaWl98veRMNgdCN/4ROBV9xLVVyGCh21PZSGwi8cQkuRex7xRd+F/JM0vz6K2eg+iGN2WqGwXffg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5549
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-01_08,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501010159
X-Proofpoint-GUID: Suo5mVogahIxJ9okqg5aqRPvGx6LpcCa
X-Proofpoint-ORIG-GUID: Suo5mVogahIxJ9okqg5aqRPvGx6LpcCa

Add fs_devices::read_cnt_blocks to track read blocks, initialize it in
open_fs_devices() and clean it up in close_fs_devices().
btrfs_submit_dev_bio() increments it for reads when stats tracking is
enabled. Stats tracking is disabled by default and is enabled through
fs_devices::fs_stats when required.

The code is not under the EXPERIMENTAL define, as stats can be expanded
to include write counts and other performance counters, with the user
interface independent of its internal use.

This is an in-memory-only feature, different to the dev error stats.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/bio.c     | 8 ++++++++
 fs/btrfs/disk-io.c | 3 +++
 fs/btrfs/volumes.c | 8 +++++++-
 fs/btrfs/volumes.h | 7 ++++++-
 4 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 1f216d07eff6..faefb18010fc 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -450,6 +450,14 @@ static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *bio)
 		(unsigned long)dev->bdev->bd_dev, btrfs_dev_name(dev),
 		dev->devid, bio->bi_iter.bi_size);
 
+	/*
+	 * Track reads if tracking is enabled; ignore I/O operations before
+	 * fully initialized.
+	 */
+	if (dev->fs_devices->fs_stats && bio_op(bio) == REQ_OP_READ && dev->fs_info)
+		percpu_counter_add(&dev->fs_devices->read_cnt_blocks,
+				   bio->bi_iter.bi_size >> dev->fs_info->sectorsize_bits);
+
 	if (bio->bi_opf & REQ_BTRFS_CGROUP_PUNT)
 		blkcg_punt_bio_submit(bio);
 	else
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ab45b02df957..79b859790e8c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3481,6 +3481,9 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_sysfs;
 	}
 
+	/* Disable filesystem stats tracking unless required by a feature. */
+	fs_devices->fs_stats = false;
+
 	ret = btrfs_read_block_groups(fs_info);
 	if (ret) {
 		btrfs_err(fs_info, "failed to read block groups: %d", ret);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index fe5ceea2ba0b..1fa40bf6f708 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1254,6 +1254,7 @@ static void close_fs_devices(struct btrfs_fs_devices *fs_devices)
 	list_for_each_entry_safe(device, tmp, &fs_devices->devices, dev_list)
 		btrfs_close_one_device(device);
 
+	percpu_counter_destroy(&fs_devices->read_cnt_blocks);
 	WARN_ON(fs_devices->open_devices);
 	WARN_ON(fs_devices->rw_devices);
 	fs_devices->opened = 0;
@@ -1300,6 +1301,11 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 	struct btrfs_device *tmp_device;
 	int ret = 0;
 
+	/* Initialize the in-memory record of filesystem read count */
+	ret = percpu_counter_init(&fs_devices->read_cnt_blocks, 0, GFP_KERNEL);
+	if (ret)
+		return ret;
+
 	list_for_each_entry_safe(device, tmp_device, &fs_devices->devices,
 				 dev_list) {
 		int ret2;
@@ -7669,7 +7675,7 @@ int btrfs_init_dev_stats(struct btrfs_fs_info *fs_info)
 	list_for_each_entry(device, &fs_devices->devices, dev_list) {
 		ret = btrfs_device_init_dev_stats(device, path);
 		if (ret)
-			goto out;
+			return ret;
 	}
 	list_for_each_entry(seed_devs, &fs_devices->seed_list, seed_list) {
 		list_for_each_entry(device, &seed_devs->devices, dev_list) {
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 3a416b1bc24c..45d0eb3429c6 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -185,7 +185,7 @@ struct btrfs_device {
 	 * enum btrfs_dev_stat_values in ioctl.h */
 	int dev_stats_valid;
 
-	/* Counter to record the change of device stats */
+	/* Counter to record of the change of device stats */
 	atomic_t dev_stats_ccnt;
 	atomic_t dev_stat_values[BTRFS_DEV_STAT_VALUES_MAX];
 
@@ -417,6 +417,8 @@ struct btrfs_fs_devices {
 	bool seeding;
 	/* The mount needs to use a randomly generated fsid. */
 	bool temp_fsid;
+	/* Enable/disable the filesystem stats tracking */
+	bool fs_stats;
 
 	struct btrfs_fs_info *fs_info;
 	/* sysfs kobjects */
@@ -427,6 +429,9 @@ struct btrfs_fs_devices {
 
 	enum btrfs_chunk_allocation_policy chunk_alloc_policy;
 
+	/* Tracks the number of blocks (sectors) read from the filesystem. */
+	struct percpu_counter read_cnt_blocks;
+
 	/* Policy used to read the mirrored stripes. */
 	enum btrfs_read_policy read_policy;
 
-- 
2.47.0


