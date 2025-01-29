Return-Path: <linux-btrfs+bounces-11148-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 973BFA22018
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 16:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E41937A3AC9
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 15:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D484F1DE2B9;
	Wed, 29 Jan 2025 15:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LeQiVYKp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q8HhINS9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E3B1CB9EA;
	Wed, 29 Jan 2025 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738164033; cv=fail; b=tJMxTHxO4WVvg0MWBvPV7KdZZA3HJ0oBy3/ANaOev7ASM5AaL6JGcZjKFZSJDC+AAvQySXPfv+3B4rT0+VbAerPcTMAf6IyZEXJAO4DH3YpNN+kQCmA9EiHxU5d/t8+L8nidBcd0sssYjPy+tt0BovbqChKg4WtPlslQXyY7+tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738164033; c=relaxed/simple;
	bh=LEfD6NKdqirmRLK06cZwqwcGIEtSmEptL44H8wG98bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gEDp2fpOigaKXLZippQbk/YPlFHru4kujvaM2x3IijlFLk+w0A/JDSXI8C3kn/UiyEFE+yMFwtV3M2IpPOMan0a5YOP8DTGkyXSjpP3NaGjeyunDBGwtdbuFhoVOGVuduXfZoeNNpsaZJ6vxjOnybw2HI5qG2R2NLOa/OJof8BY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LeQiVYKp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q8HhINS9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TFGwZE010852;
	Wed, 29 Jan 2025 15:20:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=QoEfWFCEZ74ziEnj5XuKx7A8AYffzCEXe01937ioCrQ=; b=
	LeQiVYKpLAE1dVj9RMb0hWshp1RA7bv75blJHxJjjBE0/6381jsYqFyEdhEaa4UG
	aOkZdOjj6CUf/SSviKsXkTPrW7+GPzGCqZ26zeg93KHek5iTyhwj6n6dprY9C6HV
	pGTXoi/yA+l3smmIEuD4sABa7spKe3KRL6WHcEShdtvGINbfXFxHqX2b0KX9rHb0
	DDbJrj85vjp/2AmXemCuWUwN2VSyeW+JGt7CqAJ4fj6jOWkoRtCm0OTSNp57vCLp
	upBdS2pPaQ/PVajMGg2paC2vRLLudiHPG8OLpTIA13N9LcOS+fZzf4IVHBCHP2AX
	IhnPOqF4X5uioN2PGyai3A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44fmut89q4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 15:20:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50TFHNnE034609;
	Wed, 29 Jan 2025 15:20:29 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44cpdfw2w4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 15:20:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZA9syadOJ2fZKHKUfa+KlYp3Cif5j/MjuKOB/T60jRPYSg6M9+TpZdBpJGXKaMXEUfF6cvEg2hQHm5U1MCY8U2bBy84Uqft8Wd2w39TCJ0r1d+tVjHM9gpVjiUz8CNs6DevEZ1NntMlkzM4uW2imtOMGKq8M8e7Ghp/K4VDSzu3Rjev8cmA3ylomYVezEtmmxhGEZ36vRv7L/dxAjR4Ay1L5ukx7C4JsD0KZzHxJlvNFYZ3FWBW6WVJPPIGpDjPX0fNMi+837dHMRFLqPHr1gu/6N3PDDYH+4Ql10Sygp0xy1WRtzGGKLDCIST/K8l0aI4XF0+eQT2b4dd59SJcww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoEfWFCEZ74ziEnj5XuKx7A8AYffzCEXe01937ioCrQ=;
 b=ayrNQZAI6ASWyAn/aC9JKBgOT4b9a1QCTfXNY0pCzLAXZUg37qL7Eo6uqEZ0YjwJatVdf9ZjdDNl4Oznu/EEOjbNFnsgkVzdfeogMSkokaNzw5FMcYL7m792MHBdiNtDvoaJxwsqSVWFpRWE6wd/tR7056zykKx0LJB2TOZylw0iqMa+zM06vP0tNvs5OsNnjUrdTu5XC9J31MxFLyOQYiQYHQEqjgAdR0YZQ3cweDtBeEu+ZsP2rLAFubLts7mnEvgEjM5I/f6li95T8nE/9Q9BJP+V1SBEYMYMHo8OlkyN5A1SGFYrHdgB20ZOV1Fr99SlUwUQa4YqECAklsglGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoEfWFCEZ74ziEnj5XuKx7A8AYffzCEXe01937ioCrQ=;
 b=Q8HhINS97C/xoSwtd7OJtLTR/fo2fy1cM9hlDVM7C62L5LIH9Y3C+ke4CcLM0Y27tx7IUiv8Cw1XKjxOh7K7Vn8Oz2m+XuE1SvjmRvymMj1NBhKa8o874jdWpwDwagFdUqSdbOdhTbn8ZzpgerdxTCEBLvaNTDKRl/Gz/Sm4C/o=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB4959.namprd10.prod.outlook.com (2603:10b6:5:3a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Wed, 29 Jan
 2025 15:20:27 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%3]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 15:20:27 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] fstests: btrfs: testcase for sysfs policy syntax verification
Date: Wed, 29 Jan 2025 23:19:54 +0800
Message-ID: <3aecf19197d07ff18ed1c0dda9e63fcaa49b69d1.1738161075.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1738161075.git.anand.jain@oracle.com>
References: <cover.1738161075.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB4959:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b1901fb-666a-460f-ec31-08dd407875b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IwV2QAhY9CUzOLDvKvLWbvqXhgqXjr+DLla1Kj1rZkWX9zQfSr0k1r7Uz7wi?=
 =?us-ascii?Q?OjvjgdOI+kbcOfVXfLoVpbByH12Gb7y6Uc124nSWd/nVThXKlafR6FRTAoLk?=
 =?us-ascii?Q?/LW3RMPSfj7cI56ysJfgPurw9t6UTDRrTPLvCWJk2dVkYrpdLY/bMlgRp1po?=
 =?us-ascii?Q?2v7ynQnEnJqUokVcItNvADnWjWeA1RI+ZzEYfKoUMBVeTiy83fI0UHAfe2PQ?=
 =?us-ascii?Q?UElhSotT/rCKj/jyKABmyHLBHEcLT2m1xrKnCTwqi0Saeq4+s0VvuHkvxtrK?=
 =?us-ascii?Q?Dxu1mxKnTKp+91wRG5/psjLM4kCBC2NEP9qQuUOOvEyo0XHsGIBEL1Zq7ucP?=
 =?us-ascii?Q?T2ZCEirBreWIF4RzzAhaGYNbhcyZefFWiwCR6KNONkj5Sehmqg7P6Ykz+QeN?=
 =?us-ascii?Q?B5Gb+imh9Jip0nKkO2m69Q3c6/xbjckgv1G+I0fs464E8cKczKlNFyABsmIZ?=
 =?us-ascii?Q?q36kL3F2qfWqjTtoV2GxqtP2u3GzZG4vTeEHsmY2l7lh7kAOVK0+bQ3DDH7J?=
 =?us-ascii?Q?BwuNxAelN2M9kocSNo6AN4he6RE6HvrHyMngSyYt7kJAO0kYDzePB8QTi1uf?=
 =?us-ascii?Q?s6ndoZjoFYNjyGYZZbVL7lYjFI6OeVR6qkp7nyFuqeEgWtw0mo9dKAOkNgSw?=
 =?us-ascii?Q?Kyv3Tm8MxJqLJUhql1xaHjqsBBwBO0pZTuL03whiILH3Szoz1Yep4Qyze9/C?=
 =?us-ascii?Q?9LrY94Mw8VTn4HbIDtpHYm2haMx/+Q0axqmzAxiNNijXWlH8Zhzfuj/+YzXk?=
 =?us-ascii?Q?Bpb2kR8X5KZy7D37x0rLAkcoKqF8BZS4NQBAafs2QU6JuJgbEoL4slmczrgy?=
 =?us-ascii?Q?qGxigrXzAqFJ+ttkBqAj/GOBB/ZVSkH8aNp8wNaKpBHXWU+gDQgKcqATFP/6?=
 =?us-ascii?Q?yoNhNWl9xQSV0a2uQw2/EkCKKgNljXxS0k30f8bMreARlhwWsEXcawMNguyx?=
 =?us-ascii?Q?6vDqwUf6vnWiHeNG+WaQ13Sd08MF+nU+VR/EnJpYkR0gYLzNAXw5winFQe/C?=
 =?us-ascii?Q?THc5AzNb7KzrnQDAzUW3ZVFrlqEkS5HEjK9M+sghgPBu7osrktUXXR6dajMB?=
 =?us-ascii?Q?BImCRfY7ZjvfXtXS6yQGVHp0j8BQRlzgfF+w91mIVfOWLcZy4E4+0kC/HIAd?=
 =?us-ascii?Q?n6+iFAC2BdR19XQVP+HhDa/EPUL4Xqvu3J+tCvLRwdqWTD9lugvDUC527GYq?=
 =?us-ascii?Q?qxuDIU/P4FK2PgbdOwn5ZDds6aRg1XsWX6dOrRURNUSpP1TnT+icqxFq0uQX?=
 =?us-ascii?Q?o4/KKc8/sN462JcsRJ0eKEz2AzINmpi97kSVLKVa01eEwDII9ps6QvQHJVS8?=
 =?us-ascii?Q?1oCx1UOrQXjI/29rfJA3yxb2PC7WlGGJVEFLYtzQiOpOnBXx94mbxUBBvu6M?=
 =?us-ascii?Q?5eKEw987ZSrvsZrUfruOoGuje5ok?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WPsnZv1Veh8XI/vm/dw8G9USG6qsCorT8xfilJlzz1s68/aK6mV5cHyrCqbA?=
 =?us-ascii?Q?XpIzhm1MsAPleJVOHISc1J61dobckLzWhnlQZ28MVWQVbYIKHXUJPysDYDcc?=
 =?us-ascii?Q?E3Ns34y+M8Kle2IY1BwvT14H8vcwMWX7OHVxoWjdH49itg84Lu46G7oRvQkH?=
 =?us-ascii?Q?XqOmok/MMKRhMPkEeMTpOfYdVw8OlNpQHXHTBuF4Jo6RhWAPisEtvRhQN0l4?=
 =?us-ascii?Q?x1sm0/5f6vQ5LhyW5TUalR+wCysq14Igf17Jtt2WzS+J6NTNx+S6WA8D602T?=
 =?us-ascii?Q?Ba20EkAiouR9b3VV7aHkc4IvGWxTVtzBlkW0+uy0Lkn6Sfg3du2+K8Hi4Ljl?=
 =?us-ascii?Q?gUxTElzr+22sdhLun1RHYd4fFoAPX/pa9iXLjm4zrq/GYV9TiJneZsaPzboO?=
 =?us-ascii?Q?JkOpbV56FTe9HFmM4gGBDMByR34r0yLo9GaxkWsMD/lbDeXHFyIDbZFQxdwV?=
 =?us-ascii?Q?yytbPW0OLis+Lh8qFRyfET8sqe1RVEqyFg5+BHUs04ArI7Kagy9pNyLfpas6?=
 =?us-ascii?Q?+93N0LZ4xGmcH3xYhVu6nvdZDO1cqU+PdvhVGP+8Aq3SO805SlfBa0iijEZJ?=
 =?us-ascii?Q?j0gqyxLYtY2HmMKpZ8av2Z+jWt5ZGqegV5TqQLU1Oqvd6yscnfXxn1dPPvqc?=
 =?us-ascii?Q?N3pefTF9rIZ+4Ee9pRabgnqyWJE87PLXmzCjjC+1lukqgTjOIAeLzyNL43CF?=
 =?us-ascii?Q?YOattW7HXwjBlIeLxvNXEBZIt+LEoTrfbQJG8D2X+6WzjMUvpx6sfsBPC5ON?=
 =?us-ascii?Q?6Z/8U7XZfppa6ZW7JDoMQ6oFknENqL96TidB7TEzumMjaYaGEPQ9jOUtssjf?=
 =?us-ascii?Q?9oqhB9RDufqcUO0cc8ox3ZOzqlEhuC0dPoCCL/QemKM5XtEq0nc+Uf0VBELJ?=
 =?us-ascii?Q?TC+TMGff8FOiH2xMuWkEntRG7qLBC12G3HaZSQJXyw9RdpuMCaFPxrNj4hy5?=
 =?us-ascii?Q?bf4uEo+3gGMVGuE4+F7UUeTqXk3JkQI43nB28QWwWHBluM3hdzPqA+F38e9n?=
 =?us-ascii?Q?GlUlJEKYOKfcjhlevQ9dT4XuTsksMf+jlnjAHkDANjeUkRN6cj3neruo81CV?=
 =?us-ascii?Q?VmZZ0g3Qhtxg9jnLOo1lad/NE0s0e9IIGiaBVe9djhQG372XoowRCKaPAkze?=
 =?us-ascii?Q?MYRlsBPtyJm/U3WG8lBTRbV3bkBgXOX7uw9KTvY+sOkfZuETYn2rvhyDPVNk?=
 =?us-ascii?Q?Q+wpRhG7IF+VxXlACKSbAMtHqeEkekkfbJWNAX7mOkiSD1GGCoj8dOa4mD2Q?=
 =?us-ascii?Q?v0XWZg91kP4uGIhWRNYb4b2vvtwvWSnUFWZ7gaPndVrU1mHft/87khakGsph?=
 =?us-ascii?Q?4p1qNx879siX8eg8Ym6YNMNf1jFBZmzq3Ojb6FywI9hebTUieMkXbJf0X8FC?=
 =?us-ascii?Q?Zdtty6AK11Phlk54KvRNhOJt49C69F2K47lJslDHE7heFRyRzgCeRC7EMQnz?=
 =?us-ascii?Q?O+lz3gV+bn2foKrtu+N+wYqH8VKrDe6Pz02GZy0j2pXlMjQCMHQ2HtBISG1Z?=
 =?us-ascii?Q?cNT8weqtzTSmfQyPl5x4Gc2Cgr6a3q1GsldbvuE61FzG3x6oXVZEMKc7zIK0?=
 =?us-ascii?Q?mxKuzZJhkguDo2sXE5DZTwZ7OV8Yd4wdvUH1XsKL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8BPwsf6CIh5+hUdxxd55c6y4Um91c1cXr6iicKi0ce05wnlb5wVH9VmbFkwKb9POmvXknhzEqhOx5OBrWbYoXNgXJ2QfVqXVL99VNqcSfJAJzmSCVpMdwgdRxJYqvC4jZiY36ql+bA/EmQuAJWarTyK1HiWUz1h4qXQb0OTszw6xiH8eXaTMEULbH3BxLsWzKvSIkoAXc6EYjDILvph5vyGiEzLHkWoL4GPBSTqJTHI2nZwj/36WSoN7zS/AH0nRMeD9oSr5+PvuYpW2pgPxsGpTSEpdhr55ZfpryHMil1AMu+yG/wvw7FBYtSFWPijt5OQ5eV28Hng5Qz/SqfPv4UTIeYOy3HkELymRDPls6DxbsmrPP1cQq4CbkDusbfaUlOZV5/zRtKv7PiRJbhX4MYgTQQWOtuDY1K9CdrpGDp6+oi61c0vGFFS1B8vr5eDRj/bkIHquawfLLi0xmalz7MPqa8tcaw8UucERdcJencrbc6oaMy8J5zSwFbnx/cbP4pYn8k3W5jOLmjt+Kyg408a8Am81Ccz/pL0Z7pulRGXj6b7sDxCNqVV4TTwjHaMt/kyo/fPOV8Ab1MZbh/5kMUc6ys60/AjW+pkC3G5BPr4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b1901fb-666a-460f-ec31-08dd407875b1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 15:20:27.4286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VlnE08GfHA25fXMQ3li+BJhUb29YBgwli5i7x8DCfYxkO3gJF/5JIVKVZET6s9jrd4MuSzK7562O5uaGLiA+zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4959
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_02,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501290123
X-Proofpoint-GUID: rTbKwhOJwcF9equ-sJJHSCha_6oyi7Of
X-Proofpoint-ORIG-GUID: rTbKwhOJwcF9equ-sJJHSCha_6oyi7Of

Checks if the sysfs attribute sanitizes arguments and verifies
input syntax.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/329     | 92 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/329.out |  2 +
 2 files changed, 94 insertions(+)
 create mode 100755 tests/btrfs/329
 create mode 100644 tests/btrfs/329.out

diff --git a/tests/btrfs/329 b/tests/btrfs/329
new file mode 100755
index 000000000000..9f63ab951eac
--- /dev/null
+++ b/tests/btrfs/329
@@ -0,0 +1,92 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Oracle.  All Rights Reserved.
+#
+# FS QA Test 329
+#
+# Verify sysfs knob input syntax.
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+. ./common/filter
+
+# Modify as appropriate.
+_require_scratch
+_require_fs_sysfs read_policy
+
+_scratch_mkfs > /dev/null 2>&1 || _fail "mkfs failed"
+_scratch_mount
+
+set_sysfs_policy()
+{
+	local attr=$1
+	shift
+	local policy=$@
+
+	_set_fs_sysfs_attr $SCRATCH_DEV $attr ${policy}
+	_get_fs_sysfs_attr $SCRATCH_DEV $attr | grep -q "[${policy}]"
+	if [[ $? != 0 ]]; then
+		echo "Setting sysfs $attr $policy failed"
+	fi
+}
+
+set_sysfs_policy_must_fail()
+{
+	local attr=$1
+	shift
+	local policy=$@
+
+	_set_fs_sysfs_attr $SCRATCH_DEV $attr ${policy} | _filter_sysfs_error \
+			| _expect_error_invalid_argument | tee -a $seqres.full
+}
+
+verify_sysfs_syntax()
+{
+	local attr=$1
+	local policy=$2
+	local value=$3
+
+	# Test policy specified wrongly. Must fail.
+	set_sysfs_policy_must_fail $attr "'$policy $policy'"
+	set_sysfs_policy_must_fail $attr "'$policy t'"
+	set_sysfs_policy_must_fail $attr "' '"
+	set_sysfs_policy_must_fail $attr "'${policy} n'"
+	set_sysfs_policy_must_fail $attr "'n ${policy}'"
+	set_sysfs_policy_must_fail $attr "' ${policy}'"
+	set_sysfs_policy_must_fail $attr "' ${policy} '"
+	set_sysfs_policy_must_fail $attr "'${policy} '"
+	set_sysfs_policy_must_fail $attr _${policy}
+	set_sysfs_policy_must_fail $attr ${policy}_
+	set_sysfs_policy_must_fail $attr _${policy}_
+	set_sysfs_policy_must_fail $attr ${policy}:
+	# Test policy longer than 32 chars fails stable.
+	set_sysfs_policy_must_fail $attr 'jfdkkkkjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjffjfjfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'
+
+	# Test policy specified correctly. Must pass.
+	set_sysfs_policy $attr $policy
+
+	# If the policy has no value return
+	if [[ -z $value ]]; then
+		return
+	fi
+
+	# Test value specified wrongly. Must fail.
+	set_sysfs_policy_must_fail $attr "'$policy: $value'"
+	set_sysfs_policy_must_fail $attr "'$policy:$value '"
+	set_sysfs_policy_must_fail $attr "'$policy:$value '"
+	set_sysfs_policy_must_fail $attr "'$policy: $value'"
+	set_sysfs_policy_must_fail $attr "'$policy :$value'"
+
+	# Test policy and value all specified correctly. Must pass.
+	set_sysfs_policy $attr $policy:$value
+}
+
+verify_sysfs_syntax read_policy			pid
+verify_sysfs_syntax read_policy			round-robin 4k
+verify_sysfs_syntax allocation/data/chunk_size	10g
+
+echo Silence is golden
+
+status=0
+exit
diff --git a/tests/btrfs/329.out b/tests/btrfs/329.out
new file mode 100644
index 000000000000..9794dc15960d
--- /dev/null
+++ b/tests/btrfs/329.out
@@ -0,0 +1,2 @@
+QA output created by 329
+Silence is golden
-- 
2.47.0


