Return-Path: <linux-btrfs+bounces-5036-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDF28C7500
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 13:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F260C285B88
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 11:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF3D14534F;
	Thu, 16 May 2024 11:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C/d184AG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bvunsOdO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8CC143747
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 11:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715857964; cv=fail; b=ti2ihWHDY7NCJ/gOKzyzPg6Hvi4muRu0UFBFOBG8O7Df6yrN5qVCMfRA7HJpP9IyvXbxxnU9aOYn04pXmSwjwpJ7YELmGJ0Ve4iLk9pvICLzZiXAEhPp2Dh+FXHCijlKd5ltQUjgtv8ta0VzEkDshvLqRhtxXm8eGyZmD/JoGII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715857964; c=relaxed/simple;
	bh=6m31t9Z9s3eSBqKxp+ctwneUuLXjf5op5znRZoA2EmY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SO0jpl9uiBVWPXqW/ZO/iycoSBzqV53rPNq0MkNX4B/vZnuH+eyr/oYZbiR4XqHxYjIxlSxGjBagROv9fRSiK56rTemqNbP/f4/STyihazkE/M8FCUDbxxijlD3tQvq6E5JcmpBWHPgOXEMgwGLMPx73Ng1pDLwZk4y0Fe1kGko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C/d184AG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bvunsOdO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44GAnHBd028714
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 11:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=M9hhB4iNQ8ZAWVpSwOjPf1/ZVR9W0cGZpHOsERdDtV0=;
 b=C/d184AGQn6HOduMJkBogSX8W+BiBPqNtit8beS+ry/RWXEF8tajGIJQyD/AJfMN35hc
 GQ3JiuvHIJNgyYI1f+3jOc0NkCQDI3s4OKdUJDTHEUYQBRm/RObLn5p84rkH5KJNSxhE
 r80vMPiWfDre3dYDcn2JDxMHKRU1C12cjx4wJdharKTj8+F6c6L6K4VAdB3DRrf3ZOr/
 D5KVuW/0qQO0GnCYVe3kbo32Br9DVUGVpCf5lBzprJpIiNe6yhkWdpejcV5ZvH3Z40mL
 vGWCL8XlG3xnt339tM2VCznjNAwWWQK1FQd26jiLjjGFBc3NuQbwuYyyG7Agt/y6XRDY qg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3tx36y2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 11:12:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44G9vFgd018061
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 11:12:39 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y1y4g9syb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 11:12:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIzcERDmKHbVZD/Pm2IrLAUxMxnErvSUihdNQEvZ+fXyuL54b09/ucbiH+FUxeQgoNZ1+NY2iVb27PQPC/17BBhkHPILFD/bdBKX9eTeKNl6biJpNwd8x8L+b1UeUQOmu1P3PuxJxZtp7ZMFYutlEMUy87KBKbsizsf+8Sw5QUYh3KUNKIoczjZQKZQ6AL6e83fCquPwNuvgb/GWnA0XR34o3dbDq7g6Zy8FUr5GlUPOqW4GcwkkdKReLXfdAXDJN9jBWJLRjAe6a5u9H0daEpID1shOCBATdk1x6Cn9GbrHs+wUtMgXZemvIXILZaXAa8EkK/zI11O3s4AP9VzHHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9hhB4iNQ8ZAWVpSwOjPf1/ZVR9W0cGZpHOsERdDtV0=;
 b=bmrbDOJnZ4eJwt5L1PdgQgAIPQ8sSoIFHwarRHRr+yNOTMBCKullbt4tO1WAfAFvPt5BO6FJwxv8HwYBmN2tPqubmMMGwnaO8/wnTztKeuwzrxjES7HwrygVweEa9ZIcthj1mEftVMR5I50jgrom23WepQVxUGOFMdsx4nKg65RVFDYcKBquROSzwEEo8WWhlHAJ/5HlDb+SfSlga3cL9K0QXt2NTfeza7d6EJYIzuK2vcssa0MVpPMFgS+865Clmp+XJ6DkmF92j/VVbEH5doIxRlPkWiMAht/Y1J6gWOYTMS45fUw0po30rFg3oSR4N//CoSXzhz2Ku67XEwPrAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9hhB4iNQ8ZAWVpSwOjPf1/ZVR9W0cGZpHOsERdDtV0=;
 b=bvunsOdODZpGPxPd9vh2Z/XmvtjfFP6IyIXzFNYdNDzlayWoXWlMqkqEHkdddOUNt6CSkxmBIsBPbyHXC8w4fbMp/BZW9VyajkL5AKeG+vzeTiaxldR6BFSL56GwSLzYWYeN3q2CA1ryFTFnu8kUYJuAeKc79lkX5Z7Xo1zmBPc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB4345.namprd10.prod.outlook.com (2603:10b6:5:21a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 11:12:37 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 11:12:37 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v3 0/6] part3 trivial adjustments for return variable coding style
Date: Thu, 16 May 2024 19:12:09 +0800
Message-ID: <cover.1715783315.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0124.apcprd03.prod.outlook.com
 (2603:1096:4:91::28) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM6PR10MB4345:EE_
X-MS-Office365-Filtering-Correlation-Id: f9e57648-0eaf-46ae-921d-08dc759917ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?yE0E7Qj+bQlwllg8icTWjVcHfZiBJmWUO7MS8DF13xZZq3yJnGGtAm8iPrgg?=
 =?us-ascii?Q?KHc2TN+kH4rBdr6qt7gFVMFwvIkhZedhKABthuhYrukiAucNVJfvTL4ZFwD5?=
 =?us-ascii?Q?X08h0Rn7+ORdKYaucrO+w7If1eo0TIIPipHLHlTC7AHPqYtzl+IjxkwzqFXx?=
 =?us-ascii?Q?LsPze0i9Iwy97HX8l4XwPtujyerMYE+FknoNcoONpllugsDWhtmyL6MYXGf5?=
 =?us-ascii?Q?9cH0mlMEfSQFeWpeQ1q5Ry/rxhnvixDPXlc7VYIdAj1V+8N0ogqoraoCv74C?=
 =?us-ascii?Q?5iCB6v5Cn4+uCi+FJU1uwv1HNCPPHiGIoAuG1c7JGfFE/ESQt/fF5e1rdglu?=
 =?us-ascii?Q?H6jQgrzdZmMYyNY5VE9F5kbL58xv0fKxFgm1bTh6EpdZymhkbriVa7yE0H+T?=
 =?us-ascii?Q?tikL+lDSChcJpzXTVXv2SPE6Nx1Wx0Cehd2N0z5kuZHw9Ta1y32N+mif3J63?=
 =?us-ascii?Q?GN8gHfg59G4ZIXhBhQ+VtJAwf/cx+ubxyCMNPQMAIq2vqCysaj83lk4TAq/q?=
 =?us-ascii?Q?4PObOqAmmyiEicng2umWPepTZKD+m559tfCSLRTZHi2//v3tIJHwVjo0vboP?=
 =?us-ascii?Q?bO+AVNiqHgyD4k2MMI6PHrJcypdQfLm3l7JdvzrIXet+pzmnzfMnNGzO3fV6?=
 =?us-ascii?Q?rtoSLCfGIPBVAZVdBMy5T88Kdv4LDf8P9SY5NWfDTyxejMRBIOPzQBXR44zu?=
 =?us-ascii?Q?H1RstxIixQO1UPFpKAUP32XqUhtvVL9ln9yUgG4Vzsc51RIclsZ3DkjK96HB?=
 =?us-ascii?Q?ohfRYP7yuDePsOKyfh+0PetJxrD2Apotd4aar+6EI3EmZDctjyZUSrpotTJi?=
 =?us-ascii?Q?OxEDPOnXMPa0hBClMijmlpRTR0zTjGU7qA/rnVNugXRR3zbWjQTMIMg96rwo?=
 =?us-ascii?Q?MvCovsiEsZ9+83IoYbV5zJ8CUikLw6xEo0F/D60jmNKkQCJrKMytDLnhYt/Y?=
 =?us-ascii?Q?55kmEyQL/TJcZjb+GIMrTcE2o8ZvWxHi9QhrKxBETB6UW+kMsRokR0uhG+0T?=
 =?us-ascii?Q?dn2MS2tiDevR/n0dDbKN5/jyoEol313a2L5pSZo6fDc2KMcLLgdG1M4UB7ao?=
 =?us-ascii?Q?r1hqqH8qSl7TRUoTiObq22KmJsKVfPrLhuvmZYkX/BbGwbXLJ0D6avFXFfIW?=
 =?us-ascii?Q?S9HyLiFTG8xwAYYcSeczbPx0ZVu/eaTlZxBXjmNH5emZH44hJQEuz7MNQ0Ss?=
 =?us-ascii?Q?HDWH3O3ZLY4WaFE5eTnhBwLHP+8MvFy5lpWMMznIKoOUKAS2ZTemQ2zgGCk?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CxYzVDr2qEfYZuU+E1NTTXM10MlEDN3jJa2FUo0HD3n0H27jYsBBsWbSf1hE?=
 =?us-ascii?Q?KW7OdBJHVPNABXtJFeFXp1fL6MwKtXwzImPrhrQ5W05NSh+8Vm15QSq/u2OC?=
 =?us-ascii?Q?vTg1/z5XBBeFooOR/yT388QsA+0L+qxpmYdmqP4ufccGyTDu7eyhBXyaUQsU?=
 =?us-ascii?Q?xRd1mzCkrKWvySXMfdsI5GF8TPG+YWCc5TjgMRwmwwn8Xw9BfxmKWQj8sxd2?=
 =?us-ascii?Q?AIM5NEq+H2Qcc4vjNsfR4nQJLeDlPI8TCSA3bHgaZLjqGPkgMXj1lM8nJU+R?=
 =?us-ascii?Q?bUrcoinrZvH6MJxj7hYTOq/fc7vD664/QkLRGUenmQw/+Yb3Pc320ppMxEgw?=
 =?us-ascii?Q?cmJ7gz+oOUMOHD9gkL/6u/uTnLyZKJzO55AjXyxwH7JGcLp4lxRSfGRvKWac?=
 =?us-ascii?Q?8+jbIdIH4RjR5T7vPMrOhz2rPm1SvHuJCt9UK0ClPhAFenRmw0adb0qzR5E7?=
 =?us-ascii?Q?Z71+89VnmpWrEBEWN47If2+yu1y3gDO5IFXfr6dAt10WXoibleTcTKUY1naM?=
 =?us-ascii?Q?QwyWYLNzpp1q9ej6f6NTYWfyd6AXEVgLZOKHbTm9i25J00c+4wACzTFincjc?=
 =?us-ascii?Q?vigc2+OKf1BCNua7BtKZc8KQDu/NwAwToz3BQaf2UI26FQ80cz136G3kQ0ol?=
 =?us-ascii?Q?CrKPInt8alOGYbFfAQyQ4XBioBm9PYWD6z2nMPwgORzfXViNcdoOlLMFndws?=
 =?us-ascii?Q?gUdI94DfOcomygfl05ZcZJf+v5CZlZb9LP4yrsw5jPbnPYvOb70bMi9Em2xY?=
 =?us-ascii?Q?n6rgBkH59Hq313w1Q+6jkFRRQWfvsQx9nE7nDJJLbXo3ZtelV9AIOenrHFAz?=
 =?us-ascii?Q?vndf35hJ4Mh5czuksnO1SkN4exlb2OPFL6tvUEEdQ5Sqy7opPniPV7Ryozyt?=
 =?us-ascii?Q?slCJ/vMl6HB+ZkXAA4Qng5hJSNpjX19tBFdKmAAcmPPSIOhT25DeiYpOni/X?=
 =?us-ascii?Q?Y4+FJZaD0EHgpK32bISHS5Z+OSpCNQq5rbybHniUUgQIEaRMQN8A/MBIrygm?=
 =?us-ascii?Q?LyBOaxIUUuJS34FfQEavWbCG+QDMitJlI9kjtQCz9yRuoqbCACQuu/58NZPD?=
 =?us-ascii?Q?KbMHPsZ9n48vTxwXTEN1XG4ZRFDabuyRZEPGp2b42faKPTxIhM9o32jjoMfa?=
 =?us-ascii?Q?asanZUkbgRtJdv2UQifOsoNYYpQzlGWxa2BcL3Dbm4AvRG29M0c1/Au9WrqT?=
 =?us-ascii?Q?kqh+GtNVi6bKNupW+d8gpFOnKNyatr4UFuHKuVSNO8GlgbKjWQScz7WT6VyA?=
 =?us-ascii?Q?ChIodTUz9b0xLwd+UiOf/wJ9subEKsIOANU44kO1wQD4gXxtxPUt5SZhqvLY?=
 =?us-ascii?Q?olxV4Z2RGEgQtY4qszh2zc3unQ5GNOjKVXsqy6G7O5FVIC56kwnIzAMRGAAA?=
 =?us-ascii?Q?jjVpD5QqBzSKTAbizlq+5/nMfe/7xfL1uN2tt25t3ZJFm51GDdssO1oU3B4N?=
 =?us-ascii?Q?6gNV1/AqQB0Y5e5qldm7wb/7CRJvLLDL0k6maYr8tH5SFsINoMwqOlvzpPah?=
 =?us-ascii?Q?9ktsxVVWtmOXlt8rGYHeYRNMtIpVSPOwOVHD0QElNVfhYhqPgMeR2rR44hqM?=
 =?us-ascii?Q?te6gQ4lwtor8GRaHdaFT6a3VzlYHwG/MAqbDzjf47x4YRFaByJTtZFBbYneV?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5WN/QZVCcu4d/yQGaDPndmm/IRSulA9KXisQw5KCMlu/iSiVTLyvhKDL6UPBJXjTm5UajEbhZkc4AEeBz0mH1IcTDrLEr0I6gLc5yWp7OQoYUn0lnUUAg29fYNPZX7Us9ae8DjY0KzVuVztPiwV2PLdvXJfiSKdqLZbMz2iA/aGMZL+7+dlo8w2xlTYZdgGsGEfVlMwPSxTaRSuxb2Inan09PYDESM4jx1AutjguLgdqonLARHleZIgLqUFzicYN7uibc/nnWyxnQ74dodyzPBsB2sOY+e2XSKhyfepXrm8aytBDSxpo3sBHavKcjFVtbCseGH8x5DR38ZwGMDTP2g6sB2LJMhgvjbztLawFCLs0Eb+wKHMnBKWTz313YitwdAzNaX79Hr9+OHXUEhCg/GgxAzeVL8OfCvzD8aAcALJI/rLvbxOEI/VR2TbVP8qUwdYtJVvE24zLjjLymyTF8htG1r9Df7WM1UI2oX/Po9oWhhqXR/8n2/JEnZ+ijiMingDswoqGO527gN3NAjoSVInTKhUKWRDN0sQ8e0CTYL+92bK0XfT8y39yO554/dT1h1puyXxYnyZiJrn9W16iNAoriVH8efAia8Nb2QJhdiY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e57648-0eaf-46ae-921d-08dc759917ee
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 11:12:37.2655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9CxKVg6iG6mtpXSYui3DZkSegfObWH3XpALSg7CVGoE4icHnDUbT/ekpHlggaw8tB3efbRkBiEFHJkpDodbAzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4345
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_05,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405160080
X-Proofpoint-GUID: iCeDuoGp1-6_SmE0d39M9pcZIsnDez0t
X-Proofpoint-ORIG-GUID: iCeDuoGp1-6_SmE0d39M9pcZIsnDez0t

This is part 3 of the series, containing renaming with optimization of the
return variable.

Some of the patches are new it wasn't part of v1 or v2. The new patches follow
verb-first format for titles. Older patches not renamed for backward reference.

Patchset passed tests -g quick without regressions, sending them first.

Patch 3/6 and 4/6 can be merged; they are separated for easier diff.

v2 part2:
  https://lore.kernel.org/linux-btrfs/cover.1713370756.git.anand.jain@oracle.com/
v1:
  https://lore.kernel.org/linux-btrfs/cover.1710857863.git.anand.jain@oracle.com/

Anand Jain (6):
  btrfs: btrfs_cleanup_fs_roots handle ret variable
  btrfs: simplify ret in btrfs_recover_relocation
  btrfs: rename ret in btrfs_recover_relocation
  btrfs: rename err in btrfs_recover_relocation
  btrfs: btrfs_drop_snapshot optimize return variable
  btrfs: rename and optimize return variable in btrfs_find_orphan_roots

 fs/btrfs/disk-io.c     | 38 ++++++++++++++--------------
 fs/btrfs/extent-tree.c | 48 ++++++++++++++++++------------------
 fs/btrfs/relocation.c  | 56 +++++++++++++++++++-----------------------
 fs/btrfs/root-tree.c   | 32 ++++++++++++------------
 4 files changed, 85 insertions(+), 89 deletions(-)

-- 
2.38.1


