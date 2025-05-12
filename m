Return-Path: <linux-btrfs+bounces-13940-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE3BAB4301
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9FB71694B6
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C1B29AB06;
	Mon, 12 May 2025 18:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dvgZSz97";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lpdy+USR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5A329AB11
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073472; cv=fail; b=VVGf3D6Jiip4ixoT3YBZ5lHFSxB2YBYgb6FnEJJD8LpOrB+4C4HKbtzM2IEz7VfTRWtNiied2fkhQW4mgb7+bDlybuEmNzEPF7QPnijelF+apy+oBeRwxUwycrpNWXp1wS/u7elGul4FyfxxoqqsyCQ1okE/Qo4P673/pD9NeLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073472; c=relaxed/simple;
	bh=MiW4da2jLokJi4tE/ytqcSaEajl3AY5C3X5jqyHc9UY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cCVxpAzQ0fPwsAeCrptjrRyeoc5CYWsuXist1uAJovDNJyEeVcLGbtpVXa+gVhgIeuRpkjyh6nvx3m68tj8/Gje1W2aYHDsKDvjllYtxmxRVV5xVCkiNaZMdm1OFFEyywCoQdJqlr+Vvl1PpoOmj4sQrsEG6nHG4M4/Z4/mkz8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dvgZSz97; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lpdy+USR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CH0utl007089
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Ab0JIM0zhUApR2gGZQC7hbx8RnnTnY0xvOWT/HuTkpQ=; b=
	dvgZSz97UFAA9paXjsPwjUpnVu7vNBQaWFhWp3/E6sUGhxvngEaf6t5v2tqwXCi/
	c7v2KeUvmCGDA4UH2Fyca/aQU4HNR3PdXZtO0U9TyL0gFKc6yD93s7W43KTtRMCV
	D3/45y87B4m22CfXetlYaAmsFmiQvjzjdOCVPiJrNTfbdn4XDEQRnaKwM8jrYrGN
	BeW9YoLMSkMsDVESajyqyK/7CzbmPCwwd7Gjz47pkvO2NpuzWi6L3m9Nhn7f6GdJ
	dw+qciHXgjshD0VfPQUBTvmZkr1pA3VngzkzHs3txHWoum+TqtldhwIcXV9xqskk
	M0mB67bKOlN/mn5ejdp5tA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j11c33u0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:11:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54CGuLAU022411
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:11:08 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010001.outbound.protection.outlook.com [40.93.6.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46hw88qagy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:11:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtWOqyDvcoBjDXXPWtcjKNEEa66RN2Aki0NNYOsJz/Ohhwd0OJioQIESmdYeOHmgjhZ2KXfsW5Aj+yQkSyBFhqVl+678Upxt1PO2WxyOGoIw0D0WKW35zsHEodHN+YKzc8o+okSMIXImMvk2pVEYs8Z9Bh14wuH7wGIKgLrcHmtr7zSHlx3u1WCeoXC6z968IBy5ti0FJCb1avcR/+E4JrzWQVFfutNcn6B6A9hLn50WXY0DNh1xs7kZEwz2bHL0ingzcGmAcoQQ430LG1FV8HnQybXaU9ZATgLBNah7/WDOhnhq0drrNiyLEgq5HvBOlbnSs+EDytOIv7RVvC1QJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ab0JIM0zhUApR2gGZQC7hbx8RnnTnY0xvOWT/HuTkpQ=;
 b=ZMSIJh7LQTbjhIbSjvn53SrljGl23QiLwbQnwuVePR+YOPlQJpUvXRAhvRgLBx4d/toq0r+cYATm3EjLBym5dF5ulZlUlCIv2ybxkCUqIIWbrC/6zkEgays/v5DrEZoVMUJORDnOrGi0SBNTom2xCwGWF5Ym1Dh8UChEmcw+mVK7pJtZ1UqojzXi6xo3n3yN6Y+lzKEZsM4PQK6NXB9TQO40vAGtzgSq3BIysGjHPns+Le+kXBnc6MA/d6hDdSDrIouX+2qmlsLSTHYzJaiAlO3tLxAgUBtcX/ebJNQOlVqxZQBN76kj9lZMzeKYg5ig0G2avNcn/Nc0AG6PUs7wcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ab0JIM0zhUApR2gGZQC7hbx8RnnTnY0xvOWT/HuTkpQ=;
 b=lpdy+USRhDD+17LaPxd9NrlDyQS62truv4r9uT+iZKkkA9kPnz7l0i4LmrgDxRaR6xuOag8UfnEfd8kh4uK91pgDq9klCSleOhBF6XDRrfvylAEHKzRDxCAaqD0KJdPSEDZ4wm01dLhX5lPKfEjOWYe5TwHBK+7FRH4zdmd2MwY=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by DS4PPFC7C4B0ED5.namprd10.prod.outlook.com (2603:10b6:f:fc00::d48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Mon, 12 May
 2025 18:11:06 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 18:11:06 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 12/14] btrfs-progs: mkfs: persist device roles to dev_item::type
Date: Tue, 13 May 2025 02:09:29 +0800
Message-ID: <f4c88f0889eb9effec0f15a6684f1595c988b536.1747070450.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747070450.git.anand.jain@oracle.com>
References: <cover.1747070450.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0200.apcprd04.prod.outlook.com
 (2603:1096:4:187::15) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|DS4PPFC7C4B0ED5:EE_
X-MS-Office365-Filtering-Correlation-Id: a650197f-e526-4f3d-e97c-08dd91805d3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n5ZBmT7sEwDt7TB/VizDfRyuSVNbt7tpauDZLAIPUq8uNp4KPCmQsEbcOAVv?=
 =?us-ascii?Q?yhesE/NWpBkDJ7J9RK7BKkqRpu8YmxSqKivTuJrA8XjWEK/hOKgvNm/4iQyQ?=
 =?us-ascii?Q?SaCLZMMaXGGzZXS+MEZR22m1uM57LJUub7gOrnfQC0Dn6OGcPhApw9VrVgoW?=
 =?us-ascii?Q?uJdYuEJuFOllNfy30UJ0iZBdB3PCAYHxmCR3jo9uWvpPI0ZYdl9s8cP/C725?=
 =?us-ascii?Q?5N+dGuxv4mHc9PmV1n9KBMtdorwopDSjtT1JI/Ta8oG7W3xkM7ROASMr3Su1?=
 =?us-ascii?Q?zzdrlnJpwO/luBw/LFb5UYCRY6kI+pFBcCAaXwAXsnYGp/N5XO5ymZf6KD3G?=
 =?us-ascii?Q?nvaqjK0K/3/Yg/62Mlp3CDkCi8I8rPOC6qoiioQ8ks1IagouqI1c6r4Kz6w5?=
 =?us-ascii?Q?LwarHw+4rXAIxtKLuwE5/01E3xJkt5nPJ9QmwsNEBiSzZBn1Nu8WHV5hUOfl?=
 =?us-ascii?Q?bWR2IYNXTj7dOf+5oybQxwcU/PSqWkcOFXlKAXXRVUVp7cH4BYRggr7dOaEJ?=
 =?us-ascii?Q?htN9R6dUQHOC0Y0l6DetVCjodwTshagmHz/SQFJyRwxB9y9VMkCHD2pKXAJc?=
 =?us-ascii?Q?Ne+LY+ge+U+3zROKeGPMMgFsaEuQp3cyB5mxQdW1qA3iRayvPSVysnOfV16O?=
 =?us-ascii?Q?QbGDaSIPb77m1Cd8s1OyoZQAMQcyoqR6lwarvKM/BuHl1VYsoA68YdP/CPoe?=
 =?us-ascii?Q?3EoqOzuxRw9OokGa/mGOw7GwJ7t/U4Yow6QMEWW3Wrkd3YcK4F62XQwWrr6J?=
 =?us-ascii?Q?ywZeyz+YBZCWUvzCGRcfgZ/dZt+gSmm5QbyaX3rik9HN/ROo9ORq9utbEm8h?=
 =?us-ascii?Q?3mfUhUfKFZCYmquaVmUeQu2ZuW+b1ZksNKJyyutrl8a8YszwWCJyPkNnwUrE?=
 =?us-ascii?Q?vYXtjHp/zuszWpJEmBSCKRFfJo39Q1xcaKCFJzRF+kbyczHS06p7u2W1/DoQ?=
 =?us-ascii?Q?+b/P10+5UvxFQT5No8R5a2WmwQVxcGBz92zjheHfeXABfTU7LVkvFZguaaop?=
 =?us-ascii?Q?5kzr070U9UDu+KwNkmufoSskJLwtvf45MztM9wlL0gvlf3ws0YVar0L/fH3i?=
 =?us-ascii?Q?Or14me6hmFhB2JWQjncCJJ9zDDVVwf/3s/TI2x9C+yw2m0sW76k0FqKp0ENM?=
 =?us-ascii?Q?1YElZv2rDUEhU7jJtXWkY2rzDPlHlbNDToVgsERHsR7bSSyzjr6eqqH8XNtg?=
 =?us-ascii?Q?Sh5/FzVJ9oUQfrpDaJW6yA2pZdJ0jEuF7NFlz5u0EFZGjvZkxKW8cWgTZUeq?=
 =?us-ascii?Q?hMV9kFJsi6qsW81d4m4RrztAe1KJCANjiTdG3qKXRfOcSWEMVJSSdAfNyXod?=
 =?us-ascii?Q?Ylpz1nH86uHVyZoIBn8M8CTv6IwLJvDvvuZafPloLyMIeEK6yNSP5/BZEH/i?=
 =?us-ascii?Q?WsDh+5+xWM5hwq7tCQZ8qErxDyNzv6T06XgyG+cxEFUn7CW+GEaUzE9wLhwv?=
 =?us-ascii?Q?MZW9l27fq0U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OM9X4EiBUNrFT2zrbs088bK+u3WbMeJxuKktaNhB+oHlpPUbJwbSl8jZnuBT?=
 =?us-ascii?Q?9qISwHuk0hNxD8GOinuy3Bt4+iOyQoedqZydCZ6kp7JmQ97WEwF2s7tsf+Xd?=
 =?us-ascii?Q?nzuFPrESsPqeHixV8tS8nGy4n1BKwyjYny6hIEXWF7n88lk1MjqpS2bMAwsy?=
 =?us-ascii?Q?KoBhItmj0Bb0VzviHG+ApIbWMY5RT4TozgVV0A8QjKUhb+wvjYB+BlCrqIZ3?=
 =?us-ascii?Q?siCVhVfGlKl7dYLSX0XwsQiKgjD72GfOA0hiGp4H25APLbwbxW8uNFtzRytI?=
 =?us-ascii?Q?otGs+RddfPsgmgBY353Q1zAmQhi3FLqw00fciPKrd+OwACyV38wh0QGpFIWd?=
 =?us-ascii?Q?+bCu7EYrMgTD8yJZESlGV/mEhPtqPkde05H6lCUdt226GhB+bbzfe1PxvwM6?=
 =?us-ascii?Q?9vcMteHe73C/OvDrMHCrnGu56T9D6sIq7fuzSv+wYmSpKKqa6KFPzZKt0r9W?=
 =?us-ascii?Q?IkQB1Yy4fzSgInSMNY0QH/ZOVcPLPZ1XbU+qboiWDkMV6O3HDKQDDQHT3b3p?=
 =?us-ascii?Q?FJlcv5QXC2NOnfhGMyOFzgVTGBv9T58csKos6FWLmfJpYiZNxKIC9JI8lRPC?=
 =?us-ascii?Q?360MmgPD7KnS1QYlslBq+3FwQsKFJF3qjePni4rDvmOulSBbSvupISy2FokN?=
 =?us-ascii?Q?aurpL1oi/aQXIDCgMlqHtwpEJ/FhEXMksOPqZsmEQ3ngC8GnwOyauvbVGxhD?=
 =?us-ascii?Q?2b/5KVQ63l7Fwd5jkngOy/LnRZSXUwaVgeKfXSZm2NazThaPSTmMfPHyNt53?=
 =?us-ascii?Q?859vh36hydJ113qRm4p3jCC7dUCScDMgMd/xK27d9lu6G3lS3+4vcFOst/a+?=
 =?us-ascii?Q?Zhst0oOctFAy5Flyac+UQ+VLbMHhzB5RwRL2DMpjY/7DhjSZWGetAVyzGQ53?=
 =?us-ascii?Q?s5VpkXVDzqFCy80/+/Zv1ypU5jv5wIgPKxoeTgMyh2yUdDkLrdgK7P2pqRde?=
 =?us-ascii?Q?Uwf2oOtdDFwIwsmcl46UnnnFMhhPbyMhHzaLUllecxKaxAxIVZJvaPqTR/c/?=
 =?us-ascii?Q?Q1meFQc3YNHBHH27IvvbLzAbSmbzNrD1K/ESY5/4kjJEuckuz6i4IEfe0sa7?=
 =?us-ascii?Q?yPjZGNXfxOaUCJlXNDWZMLruwq05/Wr9XyndifL0nt0+N7sgY+sJEwZ/ETl7?=
 =?us-ascii?Q?oHoUlPSJrABzSZWn1EJNULcmpb42UDpRGWgfuhKbYYEdODZ9Mr/kEr+CNx28?=
 =?us-ascii?Q?QGEiNi5o/wRkWtQdrURH+GKsKmbDnqhHWfsb8W7qJhS/8HQqfNYokWmEjyXJ?=
 =?us-ascii?Q?C0NLnRr6EHJ+Y/zZvJwkLU1EVHqBvQGUIUjDK44G0JufcWAdFx9e4xCIM82D?=
 =?us-ascii?Q?Dhy+xDSBG+w7mzqOVbFdYqST69Qlor3W5oaHfrh3bAgIHu6XJzx0Th7jocY1?=
 =?us-ascii?Q?A2DSMqL5C2HUnHmExY9VjTmt0qSaeJ4LteOJkq/iMfqR0Mp1PLD69Do7n8z6?=
 =?us-ascii?Q?1Dk2iAPpwivDZSpYjUeaZpgL3m6AncWw7fEvo6Ohn01kZ2hl++KnjbBNA7KT?=
 =?us-ascii?Q?FHny2BtNwrvTrRdqoTZL+5cVxiUo8e0ts9vcMlkESpJpb9aJdn9lScp/nXd9?=
 =?us-ascii?Q?hBdZLFKmeCzWTRhHGmEocRi0qT5o2mPD/YNnUYkf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dePNaZxdAEU3cggxYkqxvO66kPvUTOPL83TtK643qVylWd2bUnCi/BPNNMsg8ayDsVOBxerZqSmEjXqSjtclUaOc2jnozPpDDIXmIeBzUuRvTZ3yYcnXzJTk76oWZpIOoWpQV9Qcr1AGDcjeOYvhE6vrY0Z2fRufZhEhpfA8CC4ZUyCnJrjeOwR6Elq52N4dn3+kb71/sgpvYQAzEooa31q3huf7rWVR+4STgEiSiQZaTw12YWH8tuk45f5xh+MPan16HlBt/UYjg3wDEbhjmQuUoI2dvSZjkj8pFiSBG7kPzbTELhGjRH+3UDhehX4z3Zgf/eALOYOc+zpgzI+nyhd9T37UsmPsLXiNl8wq6YiAAnz0h2Bw+hXHY8MvsyShu9iUb9mie59cVtlO/0naC1gVfHH29De8dg+Wz98+Fks/KoYHQBS0QiF85QeGhUbOvYIKnDReTgXLWtD3KQXkGCCYJYjLxsJU+IfO4r5Hjxd1DvVR8/Y8F1HCW8YrcwBwOxL4eCmVdt1sFJPL7RB4il3BYvaDexjU/dJ8AebvPMe0SxJ40cw8C42rI9Z7Rf8+eg7WfZvDOiZkQDXnjI5zR5edW0CD4nXZV6WkIJeKsJY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a650197f-e526-4f3d-e97c-08dd91805d3a
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 18:11:06.3803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vcy1WnKx6txeGBMtLIDn3WsoCNVbMK0CIiXGVjTQ4lQgswQENo7vCkFUjszVPHMJ8B6YQRjOu1rTU8gscvWEgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFC7C4B0ED5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505120187
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE4NiBTYWx0ZWRfX+l7zbrjfmnio pKTa4oUDjjhf95eIg+SEObYBhB1QY4kK5K9EPl+WfAlTrIwXcNOz6PfVHmU0Iya8XEhYDyEjgV9 hk1NI8bcqxhOMBN/+z8X0EmPAGMWAs479A6OR3V7Etyc5KV7kMWEoAAbupYsD6UXcMeBRN3J9hI
 oMBA96t1q0o58apGsr7k7c7MqO8DOMXkNkGVCS94EwdAiGF+x9qIKlaVcaJZlLxDjAfsJdzsqYK I6tZ6Il+5kkP2qCWom2WYR/9z1RxePZALkOIOPGpPK936P+uXC78pjIKzlkMXNfK2TL+O+J5pWi FbA2QFAIQ1WMLx2/U37AgpnO0QH8uiTMx1oURx+c+C/YjEcSxBcUT5BLEEjHChcOHGUHji6T0um
 ktbBuemeLPtPM67cXm8xPflEYMH9bt0F7IoBe8Wo4nW6/5xvhk7MVNMH4xBo1vTwP13Nd0ZA
X-Authority-Analysis: v=2.4 cv=YJ2fyQGx c=1 sm=1 tr=0 ts=682239bd cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=QVkDTVo6qXoP0VR_oSIA:9
X-Proofpoint-GUID: 0mG7tloM6eZYKDNEC2Tps4bpIDy7zMdo
X-Proofpoint-ORIG-GUID: 0mG7tloM6eZYKDNEC2Tps4bpIDy7zMdo

The dev_item::type field, currently unused, will now store the newly
introduced device roles. This commit propagates the specified device roles
during filesystem creation, writing them to the lower 4 bits of the
dev_item::type structure on disk. This ensures the roles are recorded.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/device-scan.c |  4 ++--
 common/device-scan.h |  2 +-
 mkfs/common.c        |  2 +-
 mkfs/common.h        |  3 +++
 mkfs/main.c          | 12 +++++++++---
 5 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/common/device-scan.c b/common/device-scan.c
index 7d7d67fb5b71..b1f1475303d8 100644
--- a/common/device-scan.c
+++ b/common/device-scan.c
@@ -129,7 +129,7 @@ int test_uuid_unique(const char *uuid_str)
 int btrfs_add_to_fsid(struct btrfs_trans_handle *trans,
 		      struct btrfs_root *root, int fd, const char *path,
 		      u64 device_total_bytes, u32 io_width, u32 io_align,
-		      u32 sectorsize)
+		      u32 sectorsize, u64 type)
 {
 	struct btrfs_super_block *disk_super;
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -160,7 +160,7 @@ int btrfs_add_to_fsid(struct btrfs_trans_handle *trans,
 	uuid_generate(device->uuid);
 	device->fs_info = fs_info;
 	device->devid = 0;
-	device->type = 0;
+	device->type = type;
 	device->io_width = io_width;
 	device->io_align = io_align;
 	device->sector_size = sectorsize;
diff --git a/common/device-scan.h b/common/device-scan.h
index b154e8c860b2..d8326d7353ba 100644
--- a/common/device-scan.h
+++ b/common/device-scan.h
@@ -52,7 +52,7 @@ int btrfs_register_all_devices(void);
 int btrfs_add_to_fsid(struct btrfs_trans_handle *trans,
 		      struct btrfs_root *root, int fd, const char *path,
 		      u64 device_total_bytes, u32 io_width, u32 io_align,
-		      u32 sectorsize);
+		      u32 sectorsize, u64 type);
 int btrfs_device_already_in_root(struct btrfs_root *root, int fd,
 				 int super_offset);
 int is_seen_fsid(u8 *fsid, struct seen_fsid *seen_fsid_hash[]);
diff --git a/mkfs/common.c b/mkfs/common.c
index bb5a2ad46f4f..05e4eb4e1c4e 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -604,7 +604,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_device_io_align(buf, dev_item, cfg->sectorsize);
 	btrfs_set_device_io_width(buf, dev_item, cfg->sectorsize);
 	btrfs_set_device_sector_size(buf, dev_item, cfg->sectorsize);
-	btrfs_set_device_type(buf, dev_item, 0);
+	btrfs_set_device_type(buf, dev_item, cfg->dev_bg_type);
 
 	write_extent_buffer(buf, super.dev_item.uuid,
 			    (unsigned long)btrfs_device_uuid(dev_item),
diff --git a/mkfs/common.h b/mkfs/common.h
index de0e413774a4..ba1c78d9ea03 100644
--- a/mkfs/common.h
+++ b/mkfs/common.h
@@ -100,6 +100,9 @@ struct btrfs_mkfs_config {
 
 	/* Superblock offset after make_btrfs */
 	u64 super_bytenr;
+
+	/* dev_item::type value */
+	u64 dev_bg_type;
 };
 
 int make_btrfs(int fd, struct btrfs_mkfs_config *cfg);
diff --git a/mkfs/main.c b/mkfs/main.c
index 8248d8c4a287..e069d69e3304 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -82,6 +82,7 @@ struct prepare_device_progress {
 	u64 dev_byte_count;
 	u64 byte_count;
 	int ret;
+	struct device_arg *device_arg;
 };
 
 static int create_metadata_block_groups(struct btrfs_root *root, bool mixed,
@@ -1098,7 +1099,8 @@ static int btrfs_device_update_role(struct btrfs_fs_info *fs_info,
 		list_for_each_entry(arg_device, devices, list) {
 			if (strncmp(arg_device->path, device->name,
 				    strlen(device->name)) == 0) {
-				device->bg_type = arg_device->bg_type;
+				if (set_device_role(device, arg_device->role))
+					return -EINVAL;
 				found = true;
 				break;
 			}
@@ -1332,6 +1334,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	struct device_arg *arg_device;
 	LIST_HEAD(arg_devices);
 	u64 bg_metadata;
+	const int mkfs_dev_index = 0;
 
 	cpu_detect_flags();
 	hash_init_accel();
@@ -1987,6 +1990,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		prepare_ctx[i].file = arg_device->path;
 		prepare_ctx[i].byte_count = byte_count;
 		prepare_ctx[i].dev_byte_count = byte_count;
+		prepare_ctx[i].device_arg = arg_device;
 		ret = pthread_create(&t_prepare[i], NULL, prepare_one_device,
 				     &prepare_ctx[i]);
 		if (ret) {
@@ -2044,7 +2048,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	else
 		mkfs_cfg.zone_size = 0;
 
-	ret = make_btrfs(prepare_ctx[0].fd, &mkfs_cfg);
+	mkfs_cfg.dev_bg_type = prepare_ctx[mkfs_dev_index].device_arg->role;
+	ret = make_btrfs(prepare_ctx[mkfs_dev_index].fd, &mkfs_cfg);
 	if (ret) {
 		errno = -ret;
 		error("error during mkfs: %m");
@@ -2147,7 +2152,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 
 		ret = btrfs_add_to_fsid(trans, root, prepare_ctx[i].fd,
 					prepare_ctx[i].file, dev_byte_count,
-					sectorsize, sectorsize, sectorsize);
+					sectorsize, sectorsize, sectorsize,
+					prepare_ctx[i].device_arg->role);
 		if (ret) {
 			errno = -ret;
 			error("unable to add %s to filesystem: %m",
-- 
2.49.0


