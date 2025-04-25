Return-Path: <linux-btrfs+bounces-13430-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B05A9CD96
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 17:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE76C1BA029B
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 15:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA7228DF19;
	Fri, 25 Apr 2025 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lTFXz+KO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zPOX0qT8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8741F2586FE;
	Fri, 25 Apr 2025 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745596343; cv=fail; b=AFsQt5PBKhXVGd8BSzLlAKezj+EmAeGccgLsT+r91vO8IizE0h0vmO3BNxoH1+QMs/8x1/6kDoHIUSiewUyewEy5Hhgyyajviz6d/BlgcsyfPNGPgNVWzOYXHb4yhUYVe3F59DQIROZFJZLGwor/qFLyS9sWTvroTinoHLVzc2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745596343; c=relaxed/simple;
	bh=pf7o1Uh3Mmu3iHS5VulBibG1IHa37uYG1vhrajDXVcY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HUwWB4i9qHFx3wTjyVSbPijqqycRBOFFTO4L9Swgqv3TK1q8O8GnVcOxapR6mBRo54dg+IXkGlC9xUCP5+eqXPlHG/8x1dlLGQwYE69n4lagkOEN0cqPu7QC7jyOOFbAZip5plgR9fLpZgNLfd5bE0vWdjePB0bNdWvIyybqmZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lTFXz+KO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zPOX0qT8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PEtroS000830;
	Fri, 25 Apr 2025 15:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=5FCXJCVjqWOvFZpz
	mL2wp65jfe/5/PBYPKi8TKEegsM=; b=lTFXz+KOf8hoGnttU7CGxArip2JrhoX7
	Brxb6Gm9XWMsq03FdXEum1uNlQJuPmkk5ccuOY0f3VNNio8RjsQ5saHxPPpvswLN
	xFCd+iLXnO+uEtvTGRwhI7RT2+LXAv/L9v+n/LkHKWq7ZKi7qBo///EWVuelzKab
	/yqpPAAxiNc0IzLyP6dxV0+qBRQ0bf4mEy6tKsw3AjhK4uglCJjTu69syYgv1h83
	DpQnMnNSn1C5Ij8kItBoIOeGRGkNn/s/0nmtgcVYoJPYBG7ztgSwnzdFvAXhCxW3
	+JzM95JzmQjmbspchll22/I2lZbTzFYR5GDzz4Y4axhye3mFrFbZtw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 468cf4g8qc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 15:52:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PFFRte032382;
	Fri, 25 Apr 2025 15:52:13 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 467gfswsry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 15:52:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7WQC1E8irBzfPwUtxVw+qy/FUcTzy4wgG8Mui89ULixP0mxPDTIyAzPZpQNZAyhQCnLbwYqW6eFrWSJC3M+6tUx1cQuOt6J8aX0wLL3cD75mpzt+BFsic0+nRkzMGcaRMXlSYdU1A0aUDUbKaQVigHS9qXbISd2lsXlQW7W/CHgvbXJoe+Qj1EBYx9JP7Ylqr4OVrX5Mk+BoJFRHbr/X8QOBjJfrsG3CU+QorICoixpNrZRhzBEwpTUEvk11i9Q96uqVWdvuHo+zuCsq+OHE0SBaO8S9m8tYwFKMVa35jNJzHbX/8RGokJcWr6FrUYfbzjvbsr5qz7GxP9D23vuAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FCXJCVjqWOvFZpzmL2wp65jfe/5/PBYPKi8TKEegsM=;
 b=w/Ia9CPpyOO9Z1/vKLiYkyRILxegmrkD9fWSRJG909khzVvMUrNdil068tuvaPL89bamnM5OYa6GY8u7ybAz9yNYCZ236+82x0Z459ZF1foawl1rQ9FvtscFmaTeTDXP5/fDj3vid1vcDK1jr0xl9XWtEH9/w7pkxmW19WFTX3apL4ZIds6VUvvhA7S8wrxZ6t0LmOnkkdhJ5XnFYHh/r3mk2eSjGq54UwYSOZnXR7BNwLiC9isIC9dYhfxRNQiyZ3LVr6ltUO4dz3xG++lNl9BP51cw9YE0uCFTqCE1A3fYmeQ4xCsFGToQlSBg8uWcAc7Zu2f4erBgylUlelfGIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FCXJCVjqWOvFZpzmL2wp65jfe/5/PBYPKi8TKEegsM=;
 b=zPOX0qT820Lwd9ON53ILC4FVPBtFBvCt56R9gCFwEaHil/GZ9gX6c4T6DK/0ZnlohFww+j09SXSsM6MSheRFDlvDmNQnovXWVTJN0iqKQHPH7Lh/RAZeWjECDvMU/l3oHZU4LB/5L5dCYykhbKOG2wbil5XYw8/YPBSNS/o0LC8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB7453.namprd10.prod.outlook.com (2603:10b6:8:159::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 15:52:11 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 15:52:11 +0000
From: Anand Jain <anand.jain@oracle.com>
To: zlang@redhat.com
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [GIT PULL] fstests: btrfs changes for for-next staged-20250425
Date: Fri, 25 Apr 2025 23:51:53 +0800
Message-ID: <20250425155201.42659-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: 072022cd-7a51-4baa-c3e9-08dd841123ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QygJTLPXf9vOFmIOTru1mi6yp0aXCqkt7VhcDGyI4qnhjWz77Rx1zLSWqZYq?=
 =?us-ascii?Q?/heC0a6BElW536WliEIbqk6mY2uriFtSH68/tSjAnSVjGSzcrQjvEjsQA517?=
 =?us-ascii?Q?5frHMQKryTSlLS8F3BLPbVXHkj+3QVfqCJ6G/XwWTz5BXNm0cGQS0vi4nU27?=
 =?us-ascii?Q?JGTIqhXE4eTGPlUTdS2hAVPPS8qmcXzrTWJKzXM6tpNcrhuGCEKdmaJoxMR5?=
 =?us-ascii?Q?Lfgsrj0BDLG74orpqPC1W9LGQLDY1UgeMqloSpBcXNNqjBZS5cZT/uGIlFsR?=
 =?us-ascii?Q?RPRtezJvx8xfuSRqaEfJRzBj1ChAicfzg+0Khj26g21asajEtBzFNImo4Yxi?=
 =?us-ascii?Q?mp9Evn21tbbKRXRcUGcrhjp1bD5eQqQU5ZFEdYSGREhqmtCwuQlb4TNPjFHC?=
 =?us-ascii?Q?KMno5anBt+zmbkqOSwcgdWJBeQ2qTHKS88vtf+wcMraqSUPcIpPKzfb3Unq/?=
 =?us-ascii?Q?MDWafyriNY9PIkbE6Jw1W5LtKJFha3UhnfME+UGST4vV0pI0G2nqK7prSXIi?=
 =?us-ascii?Q?ll2qqfYlHVGALg886rjyEYks6HGUFBTi3RX5BE5rlJuCxVG61JeuwILqLlkl?=
 =?us-ascii?Q?flWNU+1IKkL9O/XOxwysPM//4GDgir6jf2MdbVxEa0Yk5QUaSYk9RqbbJ27h?=
 =?us-ascii?Q?Gm8G2hz3tHR0cttbuD+Jl1C6AMNrDNq9PzuuLjWgaCXCnopm5HYzfRSfnc7A?=
 =?us-ascii?Q?5uZfh9uPdpwbwQwg8z6HeL77yoGCCOhmb0gxFSPlSaBsY9IcEWkz3tbStBzL?=
 =?us-ascii?Q?78Yg1ooT7eC6VN42+XDkPOm4IWaufLn39NlS1Ig5DDJxWOHukaK3uKQwGY3f?=
 =?us-ascii?Q?5ZSrVry9U+UuRlu/N10s6VbP5WwlrS4O9YedutbN2yBIuq0SIkCXM0ylPpox?=
 =?us-ascii?Q?5fQcchGF3CvfOVXO4YT9ah41uqyKYfdvzXgz2ms6w1WW6DdE36Xi0mzmSkgf?=
 =?us-ascii?Q?E+x0/8cweTQT/J8/WjZVZQNTZVgBFp7LSulptK3RnM5wlCOp1D/zrioEHol2?=
 =?us-ascii?Q?6+QVX6ySYeBF6apozYWTr/msNlqhVL4rVofmB+C50UgsXAjB98QoqyGah78X?=
 =?us-ascii?Q?NtV7Pb7i2yJxZbHFisB+Q6/YfwBhCzjTxm5D1KhQgYbdPo+DjNIZspzg02nQ?=
 =?us-ascii?Q?uQQXu6Ji3FBEFV1JJKd669m2b36HXi17Y2cp0X0eaREknfiiPN6RjtAOlw2G?=
 =?us-ascii?Q?nJVbGkyyyMh1ctiwo6r4yKY1c/moFMxL0emL2CKVnTghne27KKYPYvMMqUSH?=
 =?us-ascii?Q?VnaeOP9N3dfc9X4Nt3cr7jvekFpzEKoocmILjHzRWMGPudAQ5o5nPAdDkjyT?=
 =?us-ascii?Q?ikZrI5jpI8Kw9Cexb+qXeZATB2lLx315CCDmLYW5uByRA92HwLyWhGtD33v0?=
 =?us-ascii?Q?ZdWpBMc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xq97+t33liaqW4sbP6AR3FfQFlq1Sj16VtlgeqeACTn0M0INhfTLNMC40rFH?=
 =?us-ascii?Q?VoupbcQ88LCgNhoXUDkOQJ3UEbh2Br0VwDaRavZER/mxh2iIHeBoQEHUq5Nu?=
 =?us-ascii?Q?WIVgf6L1dT1OIbl0+qE7GOHKyeChG8wOjYNJaWzPC9a6yr59BJROysIxAToJ?=
 =?us-ascii?Q?4CxI6xg2tpCGD2H8FSz/ck8lbeWNZM0YWbNFhsiTdpjPOl8ThFFmj5sophHI?=
 =?us-ascii?Q?NpJU++L7F4O6IXOzrucbgVy+jFLfPMs/5EhD1f2+QtDOT4kKhsY93YbOw1eX?=
 =?us-ascii?Q?2Sffk7AqxhL6tdY1oqXJJRBAm9YiCiIys3jWMLZhvI0sCf6tLitt1Dqvx1KF?=
 =?us-ascii?Q?32oCRB5L/PuBMo64grl8t9iRvwRwwRKV1FN3aVKbz+oeljMx9XHyWQkGU+Sy?=
 =?us-ascii?Q?7CBgHDuX5GAjS2wViaBGATQ5wAB6R/gZ3GkI6tzIRHTtR7AJMSKtAFfeDG0S?=
 =?us-ascii?Q?exego2VReiJnlMbrW1erbdiuWRQKSYVqK4mxGGjabcs5ulTP6lhaoqIkF57/?=
 =?us-ascii?Q?T+ZjX2OGwAeOmHY+geS0S/cRs/3KthFEnhifKHU/IieDSo3D2PCmY6qYzGmq?=
 =?us-ascii?Q?dpWRB5ufbpRteLxSn7wMYjakD+cnjmCkV5+zwl8N+x3YJsDBSt4zxbdpGQ9x?=
 =?us-ascii?Q?YhSJt0iyrixUxGWlgm2NAIWICSwMLid/OMA9ACwwj9eoHXhK8B81Ux4g1QOx?=
 =?us-ascii?Q?/a7//38XkXKpo1ArPhOVevDvhVUnMUNZ0HwjoZAIc9aZoDnz/7tGzgsmJDpS?=
 =?us-ascii?Q?Pveg7VbV8lVSgz/x2HNTlN81U7+C/IW4oiyaZE8IuisL7ITUIasKZMDkc069?=
 =?us-ascii?Q?kpRNIj09TxxeuLwBu0/iWbkvlRrG5xNFccYwm4x35ILC82mLeE2QzKWhGYSC?=
 =?us-ascii?Q?X3oOhz6pyKtIYpATGqBjtxKbhuvChwKK3p5cAOn3Hcp8zISO7sKswlmxsR+s?=
 =?us-ascii?Q?XxOMGUgNF8Pf6TkQU2GMfQ7lZ+YagWuvWUfhI3ARxsy+ojnaIpXAyqxAciEC?=
 =?us-ascii?Q?QingYGGMRcCSNAXnXKHBSkKVa2vOkhNyQloBQX8rEN/Wss+OSZTef2YcAWBn?=
 =?us-ascii?Q?av6/If7QksZvzrhNGP6b6DZfIQ2uLGfFkUuQvknHGlvcNeVaO5it9Cx6qbNC?=
 =?us-ascii?Q?8OL0/dzheuxbpzVRTSsdSJkvBh92sBdcbbhe0h2BXUHss8cUQ1a8mAUdcvac?=
 =?us-ascii?Q?8ECdsZzrBP+dTOvOHVCrShNdEwYo5xYv0nWJL7VNqiPW08z4pIzvyDEVVFz/?=
 =?us-ascii?Q?f4OUN2oP1BHar8mAoAHxCefgK105tLKXZnwn6Bh3v273D0h5JdgSMBvJXQss?=
 =?us-ascii?Q?yIa4Elwj1wcoUrnmKS4ZvIwCrSvBjTV/4xdZCqsChgWi/YBXsf3pEe00C1it?=
 =?us-ascii?Q?pOncdjNNjQPDEmh7XKu3i5uLDUGMc9timfFWjteOFx1Kp1/0THagU29Ic6t/?=
 =?us-ascii?Q?jfmmvJfOhuBWLYscpfwDVZzP0qOkT8xHDfwrCAwDW6O13jzkHfbfWR/pWDKb?=
 =?us-ascii?Q?QPmRHsnv+BR7AwFRXmQFxt3B7utipAwdwrNFn3PQdWCksqMFq+BG5T1/PSOK?=
 =?us-ascii?Q?2mQJtNPtXm7jpG28CN5xhz8OLT4leg/YVUZtvEcr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9FDJTo/ZOikbacnI/lHS2JVLVMQXeB2yPtRH/4L/4zkaorQGQifmQnxdc36fNClMKtD0Zf+9Xbl7MWqbDaKzk9RWKwXVqoQ7rw/yAJoPTVwoTOfh1N2dd7IR4NmGeE/4M/j8jGSGi68vuTTjSNJX7HPutHBVzCXqFbXL9R94+Pt0HTD5APBXvVvcvuC1gIgpolEwI1JaKy2karq2FwbEjHUSE2StHENEDXrU2zGDn4R/ggt6ZC5GCx4QXcOWTzqhgIbd7jpYCfTv8oAAme6c6YGX3TaprDHImElISCzGc/HXco8uKVHrfH5UtNTozA1+pJdT+q9Q6gmAgDx8PdfTqhLlNAlI7h0ZV3xzjv96vJ1vFSqP1A7IORgQuTdpAmQLrCbx3rkaqUtxVSnPpvugHjQe6DcCRRcOE7UY8G8mK0Y2efN2UKG/qWtrNPjeaLAk/9ovW7UsTQGBJDXGaPsCBcEc85zN+Dr5DpMweg8vPSD0YF6SR3cpUrJEjREs7h2qal6u+xEpHByecl1QgHhrJESw/tJjp4K71SxNYkd1ViKpTlAGqDVo1EcWCHyVSp2qYxCDjJQEunlT/3/XIPfVE1Njt3Qdwt5GRT9Rowsw4ts=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 072022cd-7a51-4baa-c3e9-08dd841123ef
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 15:52:11.0809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iK52NaF1lAF/DghzhFYCbd+OIFCMYKJQNOvSnQ0QabTYsk97QiQIF0FfpyVOy4MiYEdfAKeMlaUdkPAZlcRh/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7453
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504250112
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDExMiBTYWx0ZWRfX1Q9Dek4lHYB2 QkgSRk13DuMVvfjVraF4HZ73zk2U8ttgkiVlg+Q8X9paIDypIiHcwcpVS3aNzmS9gGxPH2oGNjK zM9IArJsomeTUgJQUGXu5ovyrRx4qUL0YzPTPgaDH6jmCYMr6FL7dj+BasGuBe01bNnc+DEKWqq
 Qmcb7+Yd53wPSRZU62f6yAZNCUDu9zbvhQlzIjh4JC10DlmFlp76RdJL5PdvyiGvzTmh6zGUaia OCkc9t8MJzDgHP9gEwTS/mFgiiCeYsKyiIo1RHXeH0doQA8V3OccD1RtBsqOHEE67kBrTaPQOIG 69t9A5h3/qfuQPTNj0Q2ekfh35pgv12K3wC77+Zkz2Ddn+BjMzC6WHpHT2JhP24ZCT2JofHIWP/ RmcFFgu2
X-Proofpoint-ORIG-GUID: m7PPVzP8Wu0rwTlHiy1_hfWRVhnhmaR5
X-Proofpoint-GUID: m7PPVzP8Wu0rwTlHiy1_hfWRVhnhmaR5

Zorro,

Please pull this branch containing the misc fixes for btrfs test cases.

Thank you.

The following changes since commit 2cc8c822f864e272251460e05b0cba5bada0f9ee:

  fstests: btrfs: testcase for sysfs chunk_size attribute validation (2025-04-11 12:25:08 +0800)

are available in the Git repository at:

  https://github.com/asj/fstests.git staged-20250425

for you to fetch changes up to d6fa73abdd7dcbfd3d820ace74bff6075645314a:

  fstests: common/btrfs: add _ prefix to temp fsid helper functions (2025-04-25 23:21:36 +0800)

----------------------------------------------------------------
Anand Jain (1):
      fstests: common/btrfs: add _ prefix to temp fsid helper functions

Qu Wenruo (3):
      fstests: btrfs/271: specify "-m raid1" to avoid false alerts
      fstests: btrfs/253: fix false alert due to _set_fs_sysfs_attr changes
      fstests: btrfs/315: fix golden output mismatch caused by newer util-linux

 common/btrfs        |  6 +++---
 tests/btrfs/253     |  3 ++-
 tests/btrfs/253.out |  1 +
 tests/btrfs/271     |  2 +-
 tests/btrfs/311     |  4 ++--
 tests/btrfs/313     |  6 +++---
 tests/btrfs/314     |  2 +-
 tests/btrfs/315     | 27 ++++-----------------------
 tests/btrfs/315.out |  2 +-
 9 files changed, 18 insertions(+), 35 deletions(-)

