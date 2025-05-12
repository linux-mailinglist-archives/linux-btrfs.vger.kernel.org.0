Return-Path: <linux-btrfs+bounces-13925-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E54AB42B5
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 741731B610B0
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79251298C3A;
	Mon, 12 May 2025 18:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WI5+QR0J";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ArGi6y0/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3DE2989BE
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073291; cv=fail; b=ZygY/za/jFG6mQf/yycXvZCNixsJXPqJZ/w668wRQbiTVtxhETRz+u1nIBEsN8ayMKBry0+sYMC4ffpBHKptALYibB1cPlH+p0BTKS8iBmiqaradeIdh00MK7AlzlyX8GTZEc9UURBtiG4i3HW0haCM8ukGBVNT94TY4lqcxr6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073291; c=relaxed/simple;
	bh=FUIBxp4oFJhIyL5xIMVM4fA+cDHhbUFgMAylobY9OXc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p8LfnKsQFLYdRq/5US/RFoP5dvlpqq3ItWJ62PBZ55XHdFkx60l/KPFoB6JYkV6Kphfhi89TVdcQ6APCc5dUBFoexh87U5i0MTS0Os9ju2oj7VBlQcgU37uWey4yQIAnlEH3YuNNkiL2qFsqa/mWYuQYFln5rfhMo58OAXVzw48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WI5+QR0J; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ArGi6y0/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CH0wdf026945
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:08:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ZlLSaYM38ZZFOGffblGjWeHgwUQ1xupEhNgqVkWXgoM=; b=
	WI5+QR0JA9tbPSQps/6rOpSFsxJ/ItMWY/ZxB+gkHTTiRai2dqP3orC4gwVpfTyG
	fGrg7g6rN7BjjUbuKdfgJBOk5cqGY2ieVHszwCm8FQdu/Yfqw9ZlXlZx2d1toa5M
	4WAwXrYaQ1Cbd2dLQfWYX9g2tA9ljmAXXmH+OwJNgj8hUsnr0hS2SMm+Frn7BuOC
	ar1OXyy+rjowo39PNynC1KGEkm/BGGWbX0qI6G1ruEF+y1Xp9P51MibphgCXSjoT
	nILFNdcNUL4urCUYwjLElJBxk9k9Sk+Y6E/yHjJCN3wLagdq+er+j0GHlf1FmQOx
	MFn3C1IjxPstbSfDfc+G1g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j16637rk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:08:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54CGdTGN002040
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:08:07 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010004.outbound.protection.outlook.com [40.93.6.4])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46hw8e76cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:08:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhJPItw4xyu7i6SmSwT162EtLmXZss7a9j0YYu/MNZ7a1afSdaVBSyPDKZvTW/P21JNM8Gi6ssY+MuP+ZcNsng3dsm75mtuLyU7MQ9XO6DH4homOHLL4ZStxQmlJ4JkLbGz/LsnsCln2PmU7FBymyA+MWl9mbg5bYuxtroCPY92wuuoPHKMaK7Mzwg3EhJaHhKNcW84bp5TcaGAXAmzAqIc6WnawchqWsn6tvCkwfez9QVKuZAUIh9YIjolkS0l5NHK7TEWZbbAAz/euQnIAReYmqnox0PvLGEbz3bRsfjK3EXb6u/f3GQ71jmioH/SBXi1iYDCQINA+WeegS4vLfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlLSaYM38ZZFOGffblGjWeHgwUQ1xupEhNgqVkWXgoM=;
 b=OmgMlNxralwFhn269rS2GgbEqdKdozyNVQUQcXYdxnthOjZpt7zZnlIjpPGWed4V0S72TJHs89A3CxMEzBtGDWz2wafnwtsYHkOvACVG3UMWj+tbG+x/EOkIdpQqdqrTnH1otF3ITORB0lYdeFo1VcI8XbhYdEl7uPi8L2TN/VCbEpgeQxwQLOMyPmNcIcPNkV2ZXbK0ZMxIyx3fowMRpkaDXbGynGu2vI7SRL1rFP2ZvqaPyAbGH7DbQ/i7hG5/aOnoQ6ZGzMth2dL3S+qn/dbDX1nUUc1Pl4MRy/wQGHWFHaHa8XLFuW98E/Ws6auxbsCjv/i5kR6NPLCzErgN7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlLSaYM38ZZFOGffblGjWeHgwUQ1xupEhNgqVkWXgoM=;
 b=ArGi6y0/tHxvN3YPBMkRuLk4tUEyFMKIaBsc2YKzCLVZwe7kQ3b9H8vKdP7zOfgGKeitIC0WCRkFFNak9yMN7rl8wG8pFIRk7mNFVg/0n3V1ei1vyt/wBoypbFaJeBLtBiN72pf1nCtgGZLMlnfQBanB0B4O9psgTBs+C2JKcrs=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by DS0PR10MB8199.namprd10.prod.outlook.com (2603:10b6:8:1fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Mon, 12 May
 2025 18:08:05 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 18:08:05 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 08/10] btrfs: introduce explicit device roles for block groups
Date: Tue, 13 May 2025 02:07:14 +0800
Message-ID: <1c9fadc2550ef86d5e46534cd9c163d177cc7b3c.1747070147.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747070147.git.anand.jain@oracle.com>
References: <cover.1747070147.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::36)
 To IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|DS0PR10MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: 19241185-5e2a-4dce-7877-08dd917ff152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TgtOjFfn15/KYmZQvgJZvxMZFJFH72sj9RdKnPY0pClzXDahkNnE70yGgPmt?=
 =?us-ascii?Q?9P+rI6UAyYStKZMJxPEdqw0oLeWiA/Y4k3c6IGeLrVklafrWTnJhcCdpVYRe?=
 =?us-ascii?Q?knl5YXI7e3BvYQqWA8h19F3ta5C+1SJEb1ht/lLdNEvnjkwjuyEuJWIEN8BI?=
 =?us-ascii?Q?pU+jFhSh/wCOhvDWj61l+qGSs1WFkllFl6F5dYhY4RhcE52xep6NgAYNEpLX?=
 =?us-ascii?Q?98eOMCSXz7tiK58fejEVbs5AfMRGREakOT1pc5hXZFlLl/bVhykdy9aaUma8?=
 =?us-ascii?Q?W6y183YGDNnrGukYSXPlQnunFxHnP+E9fhphmnuBTilS5IQOPYKEKUxaCI+P?=
 =?us-ascii?Q?P3SGDsxRmyGDTGLi30/LNcLGefhxsOXP6wqPhW5L4KTvtYy5TTyqDkVVdLio?=
 =?us-ascii?Q?HpO3OAQxSQI5Gd4bI7cptJWRrfRq8ybIFaJ3urOyJQ5lB7JyvricYbjMieCa?=
 =?us-ascii?Q?uGp/55RoEOkuKM8qvXI4S28B+yBkyVDZOTdv3mSYaXHJjlA76z/jVXwGFwOM?=
 =?us-ascii?Q?1hmItkQimWagP4GINPTw92kQVaDR4o0kgNlUgTP5Z/Eymg7yP9Xv/xgxdHCN?=
 =?us-ascii?Q?mIZvaTuNTksjFzi4La3He2hmVUGyQAFoJCVCPRz3D0HDV8o/sQmTgKOkqH+p?=
 =?us-ascii?Q?gYkeyuJ9wEDxBG/zMjmqNTsAYqppQmxZi0ObEL3qqPr9jG8sLKm7mjIg2nYY?=
 =?us-ascii?Q?kMR5K/X5SD7e/EITdllnsSrP9Zn7lZpknY61N7NtarMVzFspOLcY+3DlNhOs?=
 =?us-ascii?Q?3cU1MfMlyOGSwLXjPMtpZ2E90I2mpApV7NQf6U1fiwaVrzPZHpZ+Lk9zga7j?=
 =?us-ascii?Q?bH2jw1X+QNzZ/8YS132D7KYneelEhNvgKkcjGHmAAjaHsIuJe33ywexXmIkO?=
 =?us-ascii?Q?v7g1EJsXKcTAAu/EKF6HWYhzFuz7kEOcmoMyYjzIIdrXbNQpQhADSntPs8Bw?=
 =?us-ascii?Q?NW+n0uhTYfw88CHzL3SL9FBsVmVBt8F9tiInWB+8lnYKrdMYnOvv9JigI3na?=
 =?us-ascii?Q?AsWVVRhXTo8IeMeaTTyRYEImaX5/rgwauRXbLmKwqkf9is/Ki4j6wK6D3DbB?=
 =?us-ascii?Q?kkQuwzukSL0MBxWpEvBhrbhr138+yS6vJnmKuL5OYd0JNVKh/d7zs5gZRBGQ?=
 =?us-ascii?Q?UHW+a9pZfey17Cs6hynrX7Ibp0JQUscY4rp7MTH/yuPbyhc7KdAEGZ3VEc2C?=
 =?us-ascii?Q?/jDGVfl1rODYypnCBKkILQHHxZmkT8hYlCz2sTrbqpjsMn99Dx6p4MXG2el3?=
 =?us-ascii?Q?LkH1JRp8eQrFy0+bopgjrnybMBcveHu4Kw+75Wd0Sx0rfoihrunkr05zhXFe?=
 =?us-ascii?Q?rd5+GYtrPQVUSzUCLo5gC0XM43iBlEb7kXqgaGKymcbq16ANu4RjZDhaW53d?=
 =?us-ascii?Q?7smpusMYrjEFT694wy/2cJ+TL62lBeKQIOFeByVWcDgknHLF/Hdy/oFSfLn3?=
 =?us-ascii?Q?utboPi1JHw4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oXm6hxBMpuv0/ksF1CCbTnpE+9FRKX2On3lbEGgKGHG0Ou2tqwbhBqNttczS?=
 =?us-ascii?Q?WNeE2uhMLSBGzS5vPBDBLZUcyY1i9vD1P8vI/uAdal/1J2jAwPjMCWDpSrsn?=
 =?us-ascii?Q?U3aTKoiW1K+DA7LtZxa4HZrO8Y6GhvwRXqvnRlnFylU1MTNaaIUyjFIZPQaR?=
 =?us-ascii?Q?nE/003WmMEovOH2k8v9hXUeq2PT5RyUe/8V0pytQFfOUABO/TVTvOqfc5vCB?=
 =?us-ascii?Q?QuNYKDcNnGsx2QvfuOJi26ZolCciw15roSmHROpll0EM0KhzYBCjSI8vek81?=
 =?us-ascii?Q?YqGnz+KxlNdNXLQdWdh75qtMyEogShhaYSFz1LBRlPArwHzEhiUFQqUw+QCA?=
 =?us-ascii?Q?tuwJHu8YXMwbPC8PLVMwWiXV+2vrxES5rYz16XzsGI3kbynkQLlL0DExGxJo?=
 =?us-ascii?Q?hX4fMPyFZhF1ieibtPl+qdfzpeqrN5xH1nGSgMn7V1xARM7JnK3IqtPZjXSd?=
 =?us-ascii?Q?eqxzIufTQ7QX3VYbVWXIHf9NrxWG1Se9ZOSNBVyg9FS7yzP6AK/Cud4EiDfa?=
 =?us-ascii?Q?MupkGcgD+x00ecqvG1IcgSX9213Kz2IxTP3YAIcrWUJ5TdZvD7HBjwZyOY6N?=
 =?us-ascii?Q?QPXPhudpEoEzymI6GOFSEXynAk2BMh5TR05maxBGrj4qPf2Z8OCqa5GxUiYv?=
 =?us-ascii?Q?KzsHWfPhV0jyVsNISASGwAThr+xc79xhHc+TJFV1Vwe94mgDdHLVHgbjBQ37?=
 =?us-ascii?Q?HqEX+iNKl62KtDk6qdffjAODYfbDQFU+z4CO2GqHoD686Cqw6Ddg6qJyWYhB?=
 =?us-ascii?Q?ywMLI5eZlY8g29DZ9UCDhJZ8rLjqIQXzkksJ8SAPAsulc5fsxALZwx6Y4BpI?=
 =?us-ascii?Q?WqETou1S3aRt6kAgI/oVIBuxE6StNX0UY8PJEbO2kZeI4w9ivTCnyuvuhXkl?=
 =?us-ascii?Q?O0DCf+6dCLE8wTZJYMGuBjZzUQXhfe5T6qdDy3FM3VdrliInjCn8QiTyq63m?=
 =?us-ascii?Q?Ua/syKluHIpHsRa9rtAef54lkcM1piGIq5mj7o2Fy0Xs+hrxWAtK9hf+7jAI?=
 =?us-ascii?Q?yp6Dr71hNz93Oso5Zx9CDIgdyv84vDLBZyanrMer43ClFBLah42rRR0uEMx8?=
 =?us-ascii?Q?7gvgxUiXWDi4nSdV7cf0nKYMUfmhtUxa5bCPu+NtU449+D60y1QC/6V2m/Hv?=
 =?us-ascii?Q?lm+F/UxsIq3+bGd8TMNYBJTg5PIpc3fAqMxsPKAsh0Vdocv70ZzwujgxAtEx?=
 =?us-ascii?Q?dkPSraW09qWXM7vZ2rDlqkfza4yvHDLtxVA/9ZIR5/zIIk2f95RpnX9WEDXC?=
 =?us-ascii?Q?cOWJW7gVSeCB+duFaEnUWTyMhVLZyJMqSOQFY/Bmh6tCJO+/ZT4GBVYyKK09?=
 =?us-ascii?Q?gsZcH7FxDEV0iiPDWhj2T7QF44c3aByp28tZpMUMA/mX4756Ef1vCQmppdgb?=
 =?us-ascii?Q?vp7S/OeRjAww1+r81lz2k3ezS6MpSFieI1LFPk4p2kXksyNrRW18YOuKltnC?=
 =?us-ascii?Q?Jr7H6umRtOCKuUfeWe3MJCDJ6FR2MJ2zr7hVqsxvsfVrWhPoMUxEp8Q0/hIF?=
 =?us-ascii?Q?Lqu9SdvNXdD8GnukLNZWSSbw+T1BuRId6D2WOUsBRbYiIcEwsYZGDqH4N99/?=
 =?us-ascii?Q?75J+e0p150GU1wRmOPSFMvSZVzdEuyKnM2xa0bFw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rU51kxhXgcBI1ie+BvjTeiuDjnC0tuavyAeg0QP/gUosKb5L4v3ePrdEX4B5DVaMhU0IZ/waqCqVGsWY1ASZETWCp2zlIswMjZ3UgoWuH0TtT4fnimgcHQsbdROrZPFa8jhDdQON4MzCcmZ7+BMb8FifY4Xab+hbCIHKUHBzjvAlzjOAJssHqsEQSr20BIkMlB4SKkvTV1Xjvs0a9xyPFZEcfufaXkmVg3uirJpN7yMhtNedyXKNHap2GHIc6A+xnsxdsJ3L4hpS+yesdIJR48XGuBbXVo4B+r2nLTQGAFk+qhNdabZzOezyC+txRqj9PH7rtBSMAirqJzBdSAYwxpj7sNe/hgPLEc/GeUjmPkXjy2/5pLA1kV1DQ62QhMvwBDPbSJ+f5aT2KdRBDcfVLvDTtc2BR3mmHS1rBaTfMDLQ0hTN+1tRXn3b67ivqZeYgMRfLDdI5LBYVvRxI+Q9+TGhJAA0UKn+pqy50kBI/yCtZXEg5UYFtxy/nosQ3EZDxFpXvAHrWsnWTTHwF9SoHm3EwHzWIy2UdbLiRUYJC1Hs34Z4BxC4F8WzbpbA6eo0rTY5Qo+J5WYepcZuyUmNETkiogIadZDFtpuc5PJQ+AU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19241185-5e2a-4dce-7877-08dd917ff152
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 18:08:05.3554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7cns+UPpcPTe1WAgcMyV3RmJvSlU6Fq43qV3+gTZPHjTadIRocF0XoYGLWKfn+oyRzAHh7qCYTc9A6CJNEA2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8199
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505120186
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE4NiBTYWx0ZWRfX/VL3rpjN1A6r FX+sU/pdcQUE3KBCSSB2fo6DAVq+Huh5inbLz/ZilyBtDetr4TCE4hOvUNrqVBxERgBObh2uRsz h9iq6omAi4+SUuoVG0Jjonq3+7x5zZXByICo7a12jFlz5e1If6iWy3gqdZqaEe7NDGCcGDnmdX+
 /iuSj6csUBvdjR2JpkxT4uMz6NKrmlNWI2QJgpsFX8GucFp4IS3d2ndqOjUlxUh5FSHQ5evhXgl zW/sbi0UwtVjev9sOTtIikqa8+yiIeOUPPyxo2PnCebM3fzT5pWG/U241580skTQer9hzJyyw2l 4/vxePIRLFffSddUX3HPrf/qzxAoq/MJF6so7CpviQkKKCFpnaV9HTm61vfcx5SeIqS/f5V/Jms
 4AOdK607NeKQ318IwjmZD84MwP+YYTJn30Pe8ijj3Rk0WXxnn4DzhCKo7gqYyR5TTaOlFFgs
X-Authority-Analysis: v=2.4 cv=VMDdn8PX c=1 sm=1 tr=0 ts=68223909 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=GkyKHyEqgEX5SKnQKroA:9 cc=ntf awl=host:13185
X-Proofpoint-ORIG-GUID: WGaYQylEB_orZt7Fge696rdeFoRrTbzi
X-Proofpoint-GUID: WGaYQylEB_orZt7Fge696rdeFoRrTbzi

This commit introduces device roles to manage the intended usage of
devices for metadata and data block groups. Four distinct roles are
defined in the `enum btrfs_device_roles`:

  enum btrfs_device_roles {
	BTRFS_DEVICE_ROLE_METADATA_ONLY = 20,
	BTRFS_DEVICE_ROLE_METADATA      = 40,
	BTRFS_DEVICE_ROLE_NONE          = 80,
	BTRFS_DEVICE_ROLE_DATA          = 100,
	BTRFS_DEVICE_ROLE_DATA_ONLY     = 120,
  };

Devices marked with the `_ONLY` suffix are dedicated exclusively to the
specified block group type (metadata or data). In contrast, devices
without the `_ONLY` suffix indicate a preference for the designated
block group. While these devices will primarily be used for their
preferred type, they can also accommodate other block group types if a
critical out-of-space condition arises, allowing for allocation to
succeed.

The `parse_device_role()` function helps conversion of string ("metadata",
"data", "metadata-only", "data-only", and their abbreviations "m", "d",
"monly", "donly") into the corresponding `enum btrfs_device_roles` value.
This will be used to configure device roles.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 21 +++++++++++++++++++++
 fs/btrfs/volumes.h | 20 ++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2ae6ead3fb43..a44749103410 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2687,6 +2687,27 @@ static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
 	return ret;
 }
 
+int parse_device_role(char *str, enum btrfs_device_roles *role)
+{
+	if (strncmp(str, "m", strlen(str)) == 0 ||
+	    strncmp(str, "metadata", strlen(str)) == 0) {
+		*role = BTRFS_DEVICE_ROLE_METADATA;
+	} else if (strncmp(str, "d", strlen(str)) == 0 ||
+	    strncmp(str, "data", strlen(str)) == 0) {
+		*role = BTRFS_DEVICE_ROLE_DATA;
+	} else if (strncmp(str, "monly", strlen(str)) == 0 ||
+	    strncmp(str, "metadata-only", strlen(str)) == 0) {
+		*role = BTRFS_DEVICE_ROLE_METADATA_ONLY;
+	} else if (strncmp(str, "donly", strlen(str)) == 0 ||
+	    strncmp(str, "data-only", strlen(str)) == 0) {
+		*role = BTRFS_DEVICE_ROLE_DATA_ONLY;
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path)
 {
 	struct btrfs_root *root = fs_info->dev_root;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index dea6265a2dc8..7dbdfe502481 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -82,6 +82,25 @@ enum btrfs_raid_types {
 	BTRFS_NR_RAID_TYPES
 };
 
+#define BTRFS_DEVICE_ROLE_MASK	0xff
+/*
+ * device_role value and how it will be used.
+ * 	      0: Unused
+ *	   1-20: Metadata only
+ *	  21-40: Metadata preferred
+ *	  41-80: Anything|None
+ *	 81-100: Data preferred
+ *	101-128: Data only
+ * Declare some predefined easy to use device_bg_type values
+ */
+enum btrfs_device_roles {
+	BTRFS_DEVICE_ROLE_METADATA_ONLY = 20,
+	BTRFS_DEVICE_ROLE_METADATA      = 40,
+	BTRFS_DEVICE_ROLE_NONE          = 80,
+	BTRFS_DEVICE_ROLE_DATA          = 100,
+	BTRFS_DEVICE_ROLE_DATA_ONLY     = 120,
+};
+
 /*
  * Use sequence counter to get consistent device stat data on
  * 32-bit processors.
@@ -756,6 +775,7 @@ int btrfs_grow_device(struct btrfs_trans_handle *trans,
 struct btrfs_device *btrfs_find_device(const struct btrfs_fs_devices *fs_devices,
 				       const struct btrfs_dev_lookup_args *args);
 int btrfs_shrink_device(struct btrfs_device *device, u64 new_size);
+int parse_device_role(char *str, enum btrfs_device_roles *role);
 int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *path);
 int btrfs_balance(struct btrfs_fs_info *fs_info,
 		  struct btrfs_balance_control *bctl,
-- 
2.49.0


