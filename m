Return-Path: <linux-btrfs+bounces-4713-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EEB8BA977
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 11:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92EF01F22F0D
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 09:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303C714F113;
	Fri,  3 May 2024 09:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LVNYPyM2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xcI5/cd8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A3B1367
	for <linux-btrfs@vger.kernel.org>; Fri,  3 May 2024 09:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727373; cv=fail; b=l4XwmxwHgED9VsU+Vh4BNJGqAgzJZnFFqJVqVth/879LXHzrxdrLSlFysCJqjMxRBEISNDlQ6be/YEVm2+QP/2c9tuVicrfP9OS804ZSJVVHqQcyJIkwEBMcy63CvusJwM/eIr0HSNgbJbYvIiTV3W4SBeyqwKoM/dMAj1bU5x8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727373; c=relaxed/simple;
	bh=Krs3jhmQz7NuUXFJsdHbG5zTfzVQmZQ3kEA6m6ru9PM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VtMv5A74HhtsCkJWyQuS0NYhq/Hb6Wu5/SenPMbtj1vf9dNHbpr6ITUJ1tnCRAv6aPkO1cdS0yzV5KhyZwJDNWO7ZF/3lut16F4igg1XAM+J+b2ak4ArTpt9axvQs/0KYNANjuhEOeBlGNKewaGCyWnvwvnx8+YG1D0Hp4tsdP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LVNYPyM2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xcI5/cd8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4436hweS026009
	for <linux-btrfs@vger.kernel.org>; Fri, 3 May 2024 09:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-11-20;
 bh=kV3N5z1KDNpRfp76uxvthtVHAfsy+jaKZRPmlyCFv8Q=;
 b=LVNYPyM2flJ8hKLWDEYy7Z0YgBZpIvDGoVlH7k8Upiwc6kgPasBcyLYL1URTk2yvMym6
 VWXlYYqdtGbAw6gYMyXiW4usXo9qiVzS8Bw4YotUts44HBdjMAWAJeSReaG/r5dcmYUT
 L+cFqIWJd/arOK+EExE/4W4kgXL8KY6BmqPZbEVcD2rgmR6Tnr9SKZHghj50AkmtihX7
 TBfrwh3XQQgXIjbnd8kkR1rE9l1RHmXAfy/ortkUZwcwQ1Iob1s9V5IOjLbjMYg6WEPa
 XpAuXXhkACTEaGCvPbqddkCI7P0Xv67h4iRaMsq6/GeY/Efs+KJIE6zelK3S3PNeNq5h TQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrryvgcdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Fri, 03 May 2024 09:09:30 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4438UYJo034694
	for <linux-btrfs@vger.kernel.org>; Fri, 3 May 2024 09:09:29 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtbuuj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Fri, 03 May 2024 09:09:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jghjj33Njy2v31Glve1LdHR2uNe6ZlX3NOfvCULlHKNA0cFRmrYzu85nDte7dWYtjeC+rhNK1an8TJCX4mOOox0yyawFPcepf9Qv0mP4Zy3mz/z8wVBURxQcmXn0yDlqyOglJZJSLy0IGq9NYCwkj5JIZomCY7GWhI8Ra7cL8/9znSXS7h8lpr6YV4ZePCDtiLLg4xYaaCxoJ0z2XwukDqkr2moInsaymRJ2Tclq4UbPqPeefJ8rxGbDQlweb8aji0Cv71EKaVnQNlO9+AxvXGvcyxjjw9VhmaescpzYx/ZXaI8I+ykiWCsu7zbKaUyo03lKk8mu3QfbXk7kmgZtqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kV3N5z1KDNpRfp76uxvthtVHAfsy+jaKZRPmlyCFv8Q=;
 b=UVY9mZ3TEvyweRlZGxe3hAzB+KZGieT/5R6TweQRUaqxQqoaS7XA1bhfaEUSAUiF/XQEGiSwg9V8VGFws0cZ3ONo2DPMMD1oiw7WIVv5UUSsyGbXWD8jfhZs1/KpcYdY0Fn1BrM7qOL22WZPs8+CR5CxoM4ba1rWA1DKGg1oAxRakSq1TCdGwNmI9KP31XUgzKC23Q5VBeWpquIpAu2nR+7eWvFAvUnNRxsbUi7ZvUhEygpmynLz9vXkRDEd6s/QD5/n6NFRcSK+9WfaVAXtDWSOYN326m2CWt9J3gCPC1rYJMVBDVgY76L4OgDo0AHY09wk3e2HbjoXHk7CArB9bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kV3N5z1KDNpRfp76uxvthtVHAfsy+jaKZRPmlyCFv8Q=;
 b=xcI5/cd8ZJcke+JgMCaL0GmKQXZUsgTXWbwGkOXsuKigQ8waUPMuxE9qS4DU9+lGwCxnYpP0nmxjNotNyOY7I3Xlc+pxwguAaMw4J4CP+VNI5Ke9N0h/+tHFueWisf+lO6x0T2yYNqNrNznWJSvaJz6AnNtsfm2JFkNkeDnwuEk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by LV8PR10MB7752.namprd10.prod.outlook.com (2603:10b6:408:1e7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 09:09:28 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.7544.023; Fri, 3 May 2024
 09:09:28 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs-progs: convert: refactor ext2_create_file_extents add argument ext2_inode
Date: Fri,  3 May 2024 17:08:52 +0800
Message-ID: <b67c6afce34767618d4bf8c84a87c2a40661b7f8.1714722726.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1714722726.git.anand.jain@oracle.com>
References: <cover.1714722726.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0178.apcprd04.prod.outlook.com
 (2603:1096:4:14::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|LV8PR10MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: 411f0c6c-1077-490a-7db8-08dc6b50bc41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?c9kczHBCBxdP3dg4GTs8/9qC6lyMnwlFfVL63t4CCPuqt6zxRF7+cnMfQ1Cf?=
 =?us-ascii?Q?HcmWVnLV11q7oVsqi8yagh1PvXKClBWNreHHuvONnN2x1jnxNBRKjSEEM1Df?=
 =?us-ascii?Q?Ba7uvYAIZjUO+mMc2xlVT2EAdR+aI1426/JonV80Z01WE6ZzUeDQahbkOMRr?=
 =?us-ascii?Q?2xfSGUJFXHNQ6PhCo+PaaRIQ4x1JbS9Tmiu5Wcf/7cnMmtoYtEVn5eJhM5KM?=
 =?us-ascii?Q?bh3DWsDmlLQ4HIaKqL+uIadn3coVEH1r0VlYmGkAksg/Qi9oaSO8qUhApNLT?=
 =?us-ascii?Q?hck3eboF1JKjv7wPL57dkpgLDcjhkREe4qLcwUalwkrFvpXQ6PWG3tijph6u?=
 =?us-ascii?Q?yEKMe+QRXEZ3h+ixIXh0DLo77y/DlOKTOPVIZtFR5YqYFfaxbyGjl+r80jY5?=
 =?us-ascii?Q?FPVcuUVGizSU4LcrY3QN4HfAA1YM24o8NE3835RqRFUBJG7rmvtH3zIUuoU+?=
 =?us-ascii?Q?37FWNK2v8fwO9RL7/qCjl+5gnipSAntS4QC9cYiR5MMH2wI8YYdMAyfbArOA?=
 =?us-ascii?Q?UYKWhZXqlBQIaG9VdoK7ibJ71vPWb573fApru4YTNg4c+pRy+lGetPL6TuV0?=
 =?us-ascii?Q?6y3dB4JBQQ2r8DQiEurezrzOHZPGCLsnxX1AdoOKoPXO7GtRGQQsvzkF5LfH?=
 =?us-ascii?Q?G9j1ru+yl8JOlnwM7yoPGSphCG+rQ7hkF4G5RMXmBjGerVbW//nHzUH7OuTA?=
 =?us-ascii?Q?5YMCPCpx6v2PwPYt9yJoeFqKdKDa33mltp5eHqvG8Z6eTLJ3LFahP6WnLPxs?=
 =?us-ascii?Q?IFXN6hwzUrfPW8anUqOE1E3KmjTHYdmZBqKNxklad14kiiYGEARXvxSAN4cZ?=
 =?us-ascii?Q?erZOB/e/wzqNkOtKqMKi/9co9hXSSh4rgXXnEBBSeRfph0fiGbtluLv2h3mp?=
 =?us-ascii?Q?Q1cR8br84Jscmu8w9tVDusuRepgycl52bQIZQRVyKBsObUTDjTCgKKwJ6RqI?=
 =?us-ascii?Q?plpR10VDSRtE5S4k5Ay3UPFBBA2CELAroK8OtqmiJfnfStEqfu26npOXeMtd?=
 =?us-ascii?Q?QV7Kvu/Bo3wj3KtNcXKjCfU0yPxjenoYZr4SNVJ/AfdC3sz73gBf5bJulYVM?=
 =?us-ascii?Q?yXQzPPEAelyxAUFcS0QTsM/VF0jrT1pJ7kUXQHfy7L1xA8/DcteB/damjgtX?=
 =?us-ascii?Q?uuX1kHtfFsYBALTgpPujby1yo1QETZ7HeywwxhZEu4LNVYy9h5s3H/54Y3G9?=
 =?us-ascii?Q?OEBb6jeqbGpR7mNOVLpn2r/Yo9jaWmLwi1t7OK2wNnJ37m/RRfynCreBNrAL?=
 =?us-ascii?Q?h/omAv41KNksmUu3GQQT+MYHfXSGclKkplZkp7G4nw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?acUJxAGKH4PlngY/9H3gwM4EW9nf7eb5/oz22pr0sqnlRUhu719EYXlaJgXp?=
 =?us-ascii?Q?DW5NDqJzN2U8qFl7El19LbP4pEjacNfbkhfhegy9MM8QqHjLeYIuq8C7yg+t?=
 =?us-ascii?Q?KNCqnn7u/oWWGvNHUcqGEFbiRwur0j2jTnrVa1JaaR6Q3HE+KwqNVtgSRW6o?=
 =?us-ascii?Q?4YRBeJe3FUrz6+fkRnT8FLTITR7ZSd9dCt/5dqZ9xWpQCCWcF+p22owPEmrY?=
 =?us-ascii?Q?ue6/YR1KxyUyhBU+/yrB8uL2Hevq8+gs3XJf9T6+1vZxZG4fNN07NXGmJwtH?=
 =?us-ascii?Q?SFapK+WNx3Ax6p+lpQv+w64CTdXgwUTbDqnexidwBgMeXZSYgAs1xfm+7ZLJ?=
 =?us-ascii?Q?PnS4T97fY3C+wUzfJQtxrjN+bRDOe3Iyci78JNF7qnP8r1XwM0P27NKVzEz+?=
 =?us-ascii?Q?JcyCVnPTqGXLICkVesvwe9PwIQtcL84dQoACfXTeXDpZCrHZDetGVKzt3LPp?=
 =?us-ascii?Q?C9M6XewkJpQWpl2tBnvolr9knacwQlqS9cqvZwtyRxkzr42yl44MrVfgetMT?=
 =?us-ascii?Q?wi5IOKiebYSWWV8eRO934xBVHB1PZ6fgcYTmmujuvkYTyDf2jkKn54p3r9ly?=
 =?us-ascii?Q?2JjTt90Aqzsf+ZATdDd5FAnRszq40A+kI0gyMGuGcsSjFL20OJEdMpAdJS1M?=
 =?us-ascii?Q?zpBgb849O415zfTMLU+czCFqWIsOsvZyrmFQvJSCCJOAfEXEjvkpcIETFH02?=
 =?us-ascii?Q?7jA2PqxBAaPOHhhMmeVrRtx3V0VDmUwoWHUnvRJnoNDZu/yfmshzUqTBSg9E?=
 =?us-ascii?Q?IA01ixw8QzAJV0fk8A1FB2TB8GdZSyCh3mS5dpd8gb0ykJa9v9VhT0bmEQOI?=
 =?us-ascii?Q?YvCq6CA6Ixgn4RF9L95fkwLfpn5DCDIML/VDRN47C3qno7O+7k6L0Uf0CZGb?=
 =?us-ascii?Q?BE5W3pYyy2ZaBrYvSg2E8OIhh5K7RE2NoB04uCYdsT7C2N7xtSKLuIwRna1u?=
 =?us-ascii?Q?PJ5f3DFfPJdsH1Nw2hZ7gPuNNnhA7dlUzYnwGyA3/6Km8BgQSbKShksuKBAb?=
 =?us-ascii?Q?DsmtL9B3jB05tBNae0g5kIf+x3RCmjJHsL2ZI6137K1dgm8Q7N+uzJ9EcVAH?=
 =?us-ascii?Q?VlhkNhXTEzyPy3A/cf7E9aQvkzyZYYu7OjTJYaC5O6rlAV0B8jG/MhdtHcaI?=
 =?us-ascii?Q?k7M7Yeil56Z3MhZqWrkJZ3IJgoIa6hjK3T0SGov8LOqIPQkejc6oZZm3E04U?=
 =?us-ascii?Q?VfcwVcrcFTPESRITo9pNFT0CJekY5fJScG77NRhQ13kwh1VYUVb7pfrjhyhN?=
 =?us-ascii?Q?Mud5G/8PHCBk8GadyqInTsbIP2MT4BWH9ml3knV1hy2tkPuVgZzTiC9P/4pm?=
 =?us-ascii?Q?XBygKeuhq9bdZNwZDBgPHyq/eygDV+u2/gkT4kQjH/SwGUwM/c/ZszK8vfkR?=
 =?us-ascii?Q?k3nswPCiStt7XufKkPAQQMWDlx6LitDb+f4+WDlzbwwnm/1MYkrgZB5a6Zvv?=
 =?us-ascii?Q?TN0uXdhEWbizGYJ8j06apwu/roMNoakEpteUeX6nx/swo0NFWhGG9qXkrZ2N?=
 =?us-ascii?Q?+27Kqwcb6rjYMFvdbE1fC3yVZSKmM9BVSETPFGebLN6/Bnk/MN55ZaTplTdS?=
 =?us-ascii?Q?BCF5E9CRGq7GhovRs5hu0+0R3ZfBUvWB8DCxVExZCR/pnbe5ePU2CSGsrFPb?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mxXAyyIc83H6W2sApraGa9YE/Yamh3TDfOJPZR9PMNXN54NwEIGH0zUgwZZbU57B6mKOJsooQT2KAF64vutwHCn5mZuTjtzmKuR3xf0uMxtfMvJjODOPuLcP7E3W6/3E5FzNRI3b4vY+awB1ZTuC36RmA0WOikNmkFb6wDdYgwmSpEth+E+PSsXz0Bh1hXf3spT+tDLOpURGCnXyDKqotkK/fmaoPtjq4/mDgKwSTfUBljDRe7ZdQq3NUXpoxCNumet9i2sq4kyH1uf1LxB2qLY8QkdMJ8q9KfHB5c77gN9CLSKRxUqNM8Mds0fUmLR8vMsVpc2ySe24Vlrv4DpTWpntGHm59zYxNIIkXifUzthT1XiYK8/Hat72NePKkBxhU2fSzESBujQzyIIO5OTK1QgZpV9OixjOydQP/xXFVV3aH+dy5VAAdbfu3eDEjcNuA3I5m7qzHJFFE4g+xOECkuiK1C2S0PyJySVSQZoezAsT4ZE5D2A+6BS3zWa4JDSLW+f7eQf+GDMnPj3VgJSpAsA5dumtDoNfxxPtQPN4OkR3ph2bIp+WG2+Ooer6eNj6b9lLN6EiVDgbb1rPuaAMLF34pYuq8Hy2K1XvRLexHXc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 411f0c6c-1077-490a-7db8-08dc6b50bc41
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 09:09:28.2374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jC8ZDOFWTE0zW15L0NtSbkTgRiBh24/DikEzdQKcTcgHEhfYaEZ2PioKzvwppKYeAH/mHs03mXjDESnNiYTPAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7752
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_05,2024-05-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405030065
X-Proofpoint-GUID: gOjTS0PsLQYkCcKj9ifJ79rfuhs7EZjq
X-Proofpoint-ORIG-GUID: gOjTS0PsLQYkCcKj9ifJ79rfuhs7EZjq

This is a preparatory patch adds an argument '%ext2_inode' for the
function __btrfs_record_file_extent(); to be used in the following patches.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 convert/source-ext2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/convert/source-ext2.c b/convert/source-ext2.c
index 2186b2526e38..a3f61bb01171 100644
--- a/convert/source-ext2.c
+++ b/convert/source-ext2.c
@@ -310,6 +310,7 @@ static int ext2_create_file_extents(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root, u64 objectid,
 			       struct btrfs_inode_item *btrfs_inode,
 			       ext2_filsys ext2_fs, ext2_ino_t ext2_ino,
+			       struct ext2_inode *ext2_inode,
 			       u32 convert_flags)
 {
 	int ret;
@@ -384,6 +385,7 @@ static int ext2_create_symlink(struct btrfs_trans_handle *trans,
 		btrfs_set_stack_inode_size(btrfs_inode, inode_size + 1);
 		ret = ext2_create_file_extents(trans, root, objectid,
 				btrfs_inode, ext2_fs, ext2_ino,
+				ext2_inode,
 				CONVERT_FLAG_DATACSUM |
 				CONVERT_FLAG_INLINE_DATA);
 		btrfs_set_stack_inode_size(btrfs_inode, inode_size);
@@ -903,7 +905,7 @@ static int ext2_copy_single_inode(struct btrfs_trans_handle *trans,
 	switch (ext2_inode->i_mode & S_IFMT) {
 	case S_IFREG:
 		ret = ext2_create_file_extents(trans, root, objectid,
-			&btrfs_inode, ext2_fs, ext2_ino, convert_flags);
+			&btrfs_inode, ext2_fs, ext2_ino, ext2_inode, convert_flags);
 		break;
 	case S_IFDIR:
 		ret = ext2_create_dir_entries(trans, root, objectid,
-- 
2.39.3


