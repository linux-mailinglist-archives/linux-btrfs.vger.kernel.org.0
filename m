Return-Path: <linux-btrfs+bounces-14131-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87910ABD1EB
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 May 2025 10:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ECC61BA1BD7
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 May 2025 08:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A6425DB1D;
	Tue, 20 May 2025 08:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rULXHi5n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IYSlRcwt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193D51BD01D;
	Tue, 20 May 2025 08:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747729742; cv=fail; b=mu98gQFtVgydOrEC1eP1i6121igcyZHos1U6e5yHbwqvTtiV+f13nmpDcY8N53FD2pv3XnP8kQC1MruNXSkqY2vl46FpGk14FdsrH6rWz6eSHLdUSO9XY/itCPa4ghKAiDxV7nv9dY8D9OS5wPyY6AEh1zZJeao470MOs5auXxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747729742; c=relaxed/simple;
	bh=FwNxaRdm1HjJYigezVbROLGu9kihlvM2zj5WYYNBsds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oHBSom/37kGtjngw/Oxs0xvL0wdds2MMVCMI1eQAqmENwA/8jBwrivOHXK7NNyQ9wOsS6wyukw43qI/v+w9KnEch2l3CpDjDJ4lYwgQrNKTOpyneK3ZHgd4hlFJLiQ6hoSGMFdvXuZSYJkg5JxI2rYgRkKRIsraf3j9SdKt8LHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rULXHi5n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IYSlRcwt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K7Fj3M013412;
	Tue, 20 May 2025 08:29:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=UcANn3bm4ylM66ni90/iIOMP+eB+rYDGQ08F1wCZRKI=; b=
	rULXHi5nHi4W8SrSLT44KDi+4EHe5rdNzO9i0RVFBpnLeS/2WYfXy6KBezHw73+N
	JU0jgJQ4rWoWqHS0SzD7GskH8DgxuYFK22qviLRpQJzl05b+JSq2cZEZNOp4GurS
	YWMmwLA9DE+jrdrIC87GrcFASiJ9T+QUwC9jM0E/chiapSID4fHBX3lZH/xYZ/rK
	wjFy8enV+2NAttLHmlNWKor2w7mF3AhcpHcl9spjEZnBwM+67708bGczqIG6mmSJ
	nM+98wFLSfzlhyXBS7Ozlvp5qwP3MojfBO5MyjzZ8+8iyYlOOK2PJ+qGOlXiqBJA
	nJqhnJRyAewpjlHLvd6hpg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46rdew8rvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 08:28:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54K7iDuv015663;
	Tue, 20 May 2025 08:28:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw7f9ay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 08:28:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRDkT7alyCFd76Pim+rjm+9VCcLqDmcalVFIAGykVLEQoKWmgDHPGinlZ2+gZX/WR3y+1PJKNjls6A3dZetzMOxTAP5qF8ziuosxrdirvI9RRZIz8ZQJOKn5bUD5xuj2bh6zGpRiaBOLQfluIgsOnW5sPBtccxL6GPrVOIjuIOozpg+oBO24txa0kUUwOjXkvbQv0I7uEKgNFPwhBHT7tyJCeED5cU+8Hxt+w9E20vC2rADNrJMa+VU5Q8/VqbXeVSKqxiUg4PIRv9Yo7GxmBYMiot9IfCG68LDgNI0jjvN1zrbVuqkHvmkgxaVBizzOgxxJnJsXX+YMrivFXGZ97g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcANn3bm4ylM66ni90/iIOMP+eB+rYDGQ08F1wCZRKI=;
 b=wowp3RQFEa/5TOxBYT1j6MzJHfn5Q43Dx75De3L821ScP/tlS2u+1VDqvq109/Drfgzn9rXVkUZoZZB1GXz40bbxtia+HknRUEJqmsLMNu0NdM7X9D6Boc5rh/kJ13Rmg1qyjZFQx2yNIn9ZsW6UF8utHGedVYRmg1BCUtQs2wwMx/F6d35E8KITJ4yKH2uPY7HigpEs6bdvUIyCwfbbI1bg338dBI+4JpkbzOXihwFo6Db0aZIIjmzeFfM6iw2EVrODDfZrwc5lzNtzItwseO9j0mPOEf2rwVcQAGjhZr3FJp8JcVfWj60dgsjEsb8E2r+cub+Gp5sb7m6okyIVVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcANn3bm4ylM66ni90/iIOMP+eB+rYDGQ08F1wCZRKI=;
 b=IYSlRcwtxExfHoEWSsJowwOO2YgGF8KC1tbwpa8wY39LrJKGEOOT8iW7VrTp06U4gGKlD6iXcvlrjKUaqvw9A5uPurpOyoWVO6Km2eV+FnBnp0aWkP4ZRDGqj2u12bzc/1qkTrovZhtLDjn08hFPMhAgnDeTyhlDZG/KHhgpWC4=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by PH8PR10MB6600.namprd10.prod.outlook.com (2603:10b6:510:223::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 08:28:56 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 08:28:56 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] fstests: btrfs: new test: show_devname() on multi-device volumes
Date: Tue, 20 May 2025 16:28:35 +0800
Message-ID: <5e535ac153d5bef61616e06955f29d0233e35d2c.1747729098.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747729098.git.anand.jain@oracle.com>
References: <cover.1747729098.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0107.apcprd03.prod.outlook.com
 (2603:1096:4:7c::35) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|PH8PR10MB6600:EE_
X-MS-Office365-Filtering-Correlation-Id: f6e38243-9b1a-4533-4fc2-08dd97785cd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D76GuKtsfR47ZdkqgGRZTspB5+3Lgru3Y9EufKHafrX/9hiTbSf3jjb8xwW0?=
 =?us-ascii?Q?lPlUdvxLPqHw/lwkTfmvcNY+wMbJ1cFePDcTqxW7+ikC8ACn7l2b1HIazx5O?=
 =?us-ascii?Q?ysfm6GhjAem0knEC/i7M0q4HiU3Pu9TKOsGIcJen2/8Mqw4ZvXfH7f6BVXL9?=
 =?us-ascii?Q?G/HooFnL6XLbxZlhinqW0u/C+/6VZ/+pSnurmEdEpnKlcDjijqtEU5gcPCQw?=
 =?us-ascii?Q?vFlCRRuPukDtwbWysGtSU6HpQeVm4cv8zDXINu6GrXM8B3UW+01EYNAaLWyb?=
 =?us-ascii?Q?pQtI/zLS+BknBV3j6muG1Hmm7YK6pY4qTZixlM6LKf9+s37MFGuGVpkhGXVM?=
 =?us-ascii?Q?1oNllLzbXQMAfpPIzic6mqjkgo/FBTVlPkdK88PGCJam11R1nPpSYjCnYzak?=
 =?us-ascii?Q?0AdLgzhu8nb5qEK6ETiAeXvQjBfO6qGzO9st9pTeSixNTet7UjZsj52U47MB?=
 =?us-ascii?Q?MB33C7bVZtDuO0CtjnsGo61PSHUnwNiVuPFbAwReJ/6x/ZNqIMoq9445PxB5?=
 =?us-ascii?Q?7lm1lFH7WsVzfsr1GxiczBWxey6ou6msgbxwc7qBKmpmsBgYtCbojZjBrJAa?=
 =?us-ascii?Q?XYhpqy88g5iVczr/B+VVMTelcktPHvph2K4DyScuHhkexkqZiWyT7qfKz8Hh?=
 =?us-ascii?Q?64yRCSQNiLo8UdvKP3gvbF/fADRigMefTd7AGso5pxMrEAv1AYgyLEHBbywI?=
 =?us-ascii?Q?O8A7rQzZauFaICYF1x+Ovq2Vih4lNKKZsdn+lrhn9tpRQ2AgxZOG5p65xAGf?=
 =?us-ascii?Q?4hRYIcTN85cCkrhW2DJIMRgV3zDTiy25YuazDOwsZXYmXL9NKPOtmjXu8Fzn?=
 =?us-ascii?Q?32oq+V9LKZanVUvo29nYs4cPx76RxZO8biiYvigNpG1ky8gbw0CKgRWzI9VP?=
 =?us-ascii?Q?aH5H85ZA7Iv0fZ1TkKpWwGLY7t+PazWuOjMb1PUY1BsEPOmmJ1uBmcMynTj9?=
 =?us-ascii?Q?8fZCvygILaPSYYvvR6XRFZmT90WBPVnurASek3hnuo59+BCSQowd7d7PjD2Y?=
 =?us-ascii?Q?CQ2N/qF7NrnEVNanja5tYUKgwmu7FHe6J1oWFXE8FjmZh2i6qJ+z753z6aob?=
 =?us-ascii?Q?SsOxWBHV7bPPazzs5IY7RF4ikiHGVQeTMe6/k6i1qJjTHr/mvyE59Vlmcmzp?=
 =?us-ascii?Q?sviWcTxXtjO3RlhPkWrMUb+MoDiUNMwYkZ8c4JEy5UykAm+Ob4o3fxthurdb?=
 =?us-ascii?Q?2jS9zoWsTmK4T/H4BzPzeDVPMsEpaC+H8Rq2QCwTVST5qoN79MQ/v6+TMmRY?=
 =?us-ascii?Q?TDscc48IlG20gbWyM8hIqi5gHtyLv3CJopLCVwNHF/tU5SuTv6wB5KKG6sxM?=
 =?us-ascii?Q?kQgTv5+tJHjGaKE36EOGIZS6CJCgtcB8wogpPMF/o2vbwWdiuoOjHfw+chXi?=
 =?us-ascii?Q?WOnG7sTF8UvPI9cCp2s5gVB8SzudKTt5t9ZbFZS79Gsl6KrzbtNzN4p62clJ?=
 =?us-ascii?Q?9ZmsgRp0zn4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W9pM2Ezuofs7of2nEZEY4cWrEBwxN71LNzIa4YpDHedjomV2P3yKIHvQf34r?=
 =?us-ascii?Q?3eJLib/4fZuY1q9UZMgx2I8Y7kf3jEb5G7rR44M73Pj9ZJ8/jL1Un6l6kuzT?=
 =?us-ascii?Q?MKvu9wUY8vfBnLRzMt8sl4JS5/9WS6hahYxP/U89Ayp8PfwsWxaFN9lzL7Q6?=
 =?us-ascii?Q?2RPyDfctAYOBgcqQ5usmcQ9JeSXqWN0HGCX8+V9+5tIkmRt3OLHjJ+taanm6?=
 =?us-ascii?Q?3I1NihFmdqDr3FH9Ah3Exo+GEVqjPaMN/wew56gk22Nk5GE6ArEt+KIK9e1m?=
 =?us-ascii?Q?DNzolyNIShGQQWXnQETbZNHXjdmvEQ3HkQaQWY5XAye/L/+jeXHOQbhMXkq0?=
 =?us-ascii?Q?0vFjNhrdceR6TH6Cf3VLO6JO42/JjKEWEFif6/lr76hyH8KDiH3G+N47H/nN?=
 =?us-ascii?Q?ShG4Rl61tsQhmoE7zDmZISJzwf+ayDNI0fF7LJUEMX6gl+maPKx2jyyhyaxf?=
 =?us-ascii?Q?96lqYWUyK0rVdLvm06xRqcHfw1Xzy7bOKSLZFDQBHTgdDypzOjqxB5HuvNos?=
 =?us-ascii?Q?XmRYUkct5kg+HR8i1rZ/c6MraSA1/xMPKUOyjzFOwqYqoeqIG1J1/tSTi80v?=
 =?us-ascii?Q?D1iqYqhRTZ8BAURM3QK0uZ+lCzDOp4mWcwtffIiqD+sxokhiMOgIjRVUxemI?=
 =?us-ascii?Q?8Q53PWQDvYgkXif7rXjr7iIvsYVybcBQDlibw6mrCBpU5AEjJX+fwcrPiX8g?=
 =?us-ascii?Q?hsg5pY1Ffr6dIjRJqK5VTnBEWA5p0NHHrcbE+mTWpPyVIXyWuxaDCguhMC6/?=
 =?us-ascii?Q?b9Or5Bf+F21126cIugOlwjUEGnnVpdJe4EBf33ccIgQ0ihVDqY6oVa2hRR2Q?=
 =?us-ascii?Q?VUS1LnLg9or7EOSsbnqsY1xrPqSjE3MsGw2CAKwJrj/ydQvwzJE4g+smTGPJ?=
 =?us-ascii?Q?afn6eyzVdwk5g59QQnY9eXKhPpx1c5nnFsOMFyITrXlJSc62q9eCmgBjUL64?=
 =?us-ascii?Q?TbpKVxF1p0dkPcatL/F6mM/Wopr+g0ARlj6epwWxcvri3fzccImFd+02bcoj?=
 =?us-ascii?Q?V/W3jonkRf0d1gmTbGTc2DHXThedk8R5fgzroESLAUFr9UCtTvcOrLlrBt+5?=
 =?us-ascii?Q?r1USEJSOEZfaEYqZf87TAyd7Z13WCqQA/BjjmpR72nR6DRyRo5LFh+DWYfuP?=
 =?us-ascii?Q?IoB895sl7I/y+XNG3eJ+B0HiOCUuLmRIKDfmIjSMmKL65VsQV1ePYRFUKkBX?=
 =?us-ascii?Q?zq5iICDkxUdDNoMQgzGHr/bd8yBTacfpjGK/yxlQjL2sjC21R3QMMLy5ucq5?=
 =?us-ascii?Q?W+1LbngUaUawWT9vvx8VNF9OFkx5Mflm70VPS32ElZPiDPJBOins4oFZalco?=
 =?us-ascii?Q?4WVj0Kx0Nt6rwuVPS1vdkp9PuP+j4Rgt5tIxNry9RJOGi4IjyOfKrkAsYkYp?=
 =?us-ascii?Q?PivA69TeL+ZO5Zl3jvsxIljwedgbgJfRgJhdHRmskeBCnMJkGU9ztLIsn/4F?=
 =?us-ascii?Q?bbp+BAZyLeIxbtFM832SzO0LW5QlISNcPixciNzxPAbQI8ydv3PAwrSPnecq?=
 =?us-ascii?Q?ZOZj6Uq/Ru4NlgPZpZYsnB4lRYdDA1jtAJfl1rWlP0j5bSWsXeo7mfHHWfL2?=
 =?us-ascii?Q?uYLe76GuQ4qpkvBfrJeafc+NHSn6v0IXoD+WUezC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3sSp1bRt3/zvov2MiniiBb/QGymy+gUhjR2yOpIqkgJMn6FsrYY8knSeStPc7x/Sfh77A72rUP4SV+NukXE8XbwEh9pIk/FOs0tYtjW3nDWjh0Kgolr3zQ220w2qV4mkR2F6+FyfFkUhr6YG/T84hRDY4Nn98CpWWzSXXSlAo3I32MWIwNDQBltZsPh/K+7C8oNGcV+Mi28lycMYpThcIPOcRB8zqYgesvbiAPjc09UZDsi4TqCnxssJMo9dHxaenu86uvd52SCjvRzDiv4xagVwrmzfRo5Vzh3sf5pkwB15n4eiaX2CXUxY9Fn9C9L1b6iI/Xi0dCNxmxZLre1dBqAYNmpmt2EgEsktAPd6GoG/PLznUHVkkbrUT4vDcGe50wFo2xpuiT+gXNdPwMHcZgwYiJTNWHejLPzmRDE2Tiwp8ufLLfeRhxuWaGbIbiOif9HO13t/ANM/PJiuQ+epX7uAYyXehATGb8z1nNwmOKBq/Pw1FonzaVboJqqtE1p8sEYVTv/ZqlgPFOGz7t/DjN+8eg1AL/SA85aVHNDmjcucIzv1v2wrE9ggWKLnzmwJO84AXG0BbLBl9Kd70VqoNdagSXbw0Oslb2gJxnw2N3o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e38243-9b1a-4533-4fc2-08dd97785cd5
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 08:28:56.7353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XbX9rpjVuPet/9MRbQlHm6zf4rHcHerQkAn7TMiv5mfRBja4iGu57fls5ReClzV85WUUG+DcOEvd4SJrh50GDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6600
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_03,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505200069
X-Authority-Analysis: v=2.4 cv=Rb6QC0tv c=1 sm=1 tr=0 ts=682c3d4b cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=0GwuTpiLc-0FOILAXtMA:9 a=0oiSH7vPicMLxG-J:21
X-Proofpoint-GUID: 8StGhQc34J5WmqYXGzonvEhryk0xGfRL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA2OSBTYWx0ZWRfX2Yj22qKbLcMz skynDlRPb/4b8J0X+ygOOl/xaUqoBVZdQgdTNh6Z6UWOp6tFwKvVIwRzdUeb7YblHKPv/F34CSU sfnB8ujHFv9LXvsRP0lNPCIxEe4sRngt0+md6rapQRgl3ZTI598N4Ws/4CRyPL6OoXpz6g3+02X
 rvuKTLXpRRj67JRTRIMCVU01Wt0I/K99Aq0S2X55+c+DvxqRDIgXk7zYjXQYCc9dUeNYnhb85Fn uz6PdDELRbBHmzQVnyfEZ7jOJvSmpnQGU5b2Ri5qlB/lRdc7qPteWrfoQuMn/APvlY/ExwDO7cL iLI2yvRLtQGc+2nFOSSfNqSV2OXlZWnllJCjFylsDIglS371cmtWZeOgyN2iUFPYpyRWymzBW+N
 bArVOpedfxcRFB71+xdPktzrYfQnG/aeD11gJSTRyHBTVVeE8I9fMeRw3gYwoXYlug1lOTpR
X-Proofpoint-ORIG-GUID: 8StGhQc34J5WmqYXGzonvEhryk0xGfRL

If the device path under /proc/self/mounts does not match the path shown
by findmnt --uuid, commands like mount -a may fail to recognize that the
device is already mounted and attempt to mount it again. This test case
verifies that the two paths match.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/329     | 107 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/329.out |  19 ++++++++
 2 files changed, 126 insertions(+)
 create mode 100755 tests/btrfs/329
 create mode 100644 tests/btrfs/329.out

diff --git a/tests/btrfs/329 b/tests/btrfs/329
new file mode 100755
index 000000000000..c73e0175c6a4
--- /dev/null
+++ b/tests/btrfs/329
@@ -0,0 +1,107 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Oracle.  All Rights Reserved.
+#
+# FS QA Test 329
+#
+# Test that show_devname() returns a device path that matches findmnt,
+# ensuring that mount -a works correctly for multi-device Btrfs filesystems.
+
+. ./common/preamble
+_begin_fstest auto volume
+
+node="fstests_${seq}"
+
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.*
+
+	clean_per_iteration
+
+	udevadm control --start-exec-queue
+	_dmsetup_remove $node
+}
+
+. ./common/systemd
+. ./common/filter
+
+_require_scratch_dev_pool 2
+_require_btrfs_forget_or_module_loadable
+_require_block_device $SCRATCH_DEV
+_require_dm_target linear
+
+_fixed_by_kernel_commit XXXXXXXXXXXX \
+	"btrfs: pass device path update from mount thread"
+
+_scratch_dev_pool_get 3
+scratch_devs=($SCRATCH_DEV_POOL)
+#size doesn't matter just create it to the device size
+sectors=$(blockdev --getsz ${scratch_devs[0]})
+table="0 $sectors linear  ${scratch_devs[0]} 0"
+_dmsetup_create $node --table "$table" || _fail "setup dm device failed"
+scratch_mapper_dev=/dev/mapper/$node
+scratch_dm_dev=$(realpath ${scratch_mapper_dev})
+
+clean_per_iteration()
+{
+	_unmount $SCRATCH_MNT > /dev/null 2>&1
+	sed -i "\|[[:space:]]$SCRATCH_MNT[[:space:]]|d" /etc/fstab
+	_systemd_installed && _systemd_reload
+}
+
+filter_mapper()
+{
+	sed -e "s,\B$scratch_mapper_dev,MAPPER_PATH,g" |\
+		sed -e "s,/dev/dm-[^ ]*,DM_PATH,g" |\
+		_filter_scratch_pool
+}
+
+test_dev_path()
+{
+	clean_per_iteration
+	_btrfs_forget_or_module_reload
+
+	echo --- ${devs[@]} ---- | filter_mapper
+	_mkfs_dev "${devs[0]} ${devs[1]}"
+
+	# mount resolves dm path to its mapper path
+	_mount --verbose ${devs[0]} -o device=${devs[1]} $SCRATCH_MNT | \
+								filter_mapper
+
+	fsid=$(findmnt -n -o UUID ${devs[0]})
+	blkid --uuid ${fsid} | filter_mapper
+	findmnt --source UUID=${fsid} --noheadings --output SOURCE | \
+								filter_mapper
+	cat /proc/self/mounts | grep ${SCRATCH_MNT} | \
+				$AWK_PROG '{print $1" "$2}' | filter_mapper
+
+	echo "UUID=${fsid} ${SCRATCH_MNT} $FSTYP defaults 0 0" >> /etc/fstab
+	_systemd_installed && _systemd_reload
+
+	# The error output from `mount -a --verbose` varies.
+        # In libmount 2.37.4, the `mount -a` command will fail with -EBUSY.
+        # In libmount 2.40.2, it will report "Successfully mounted" instead
+        # of "already mounted."
+	_mount --verbose -a | grep $SCRATCH_MNT | _filter_scratch
+}
+
+# Block external triggers such as (64-btrfs-dm.rules) that alter the device path
+# inside the kernel, they are unreliable.
+udevadm control --stop-exec-queue
+secnarios=(
+	"$scratch_dm_dev ${scratch_devs[1]}"
+	"${scratch_devs[2]} ${scratch_devs[1]}"
+	"${scratch_devs[1]} ${scratch_devs[2]}"
+)
+
+devs=()
+for devs_str in "${secnarios[@]}"; do
+	devs=($devs_str)
+	test_dev_path
+done
+udevadm control --start-exec-queue
+
+_scratch_dev_pool_put
+status=0
+exit
diff --git a/tests/btrfs/329.out b/tests/btrfs/329.out
new file mode 100644
index 000000000000..96891dcc68b4
--- /dev/null
+++ b/tests/btrfs/329.out
@@ -0,0 +1,19 @@
+QA output created by 329
+--- DM_PATH SCRATCH_DEV ----
+mount: MAPPER_PATH mounted on /mnt/scratch.
+MAPPER_PATH
+MAPPER_PATH
+MAPPER_PATH /mnt/scratch
+SCRATCH_MNT             : already mounted
+--- SCRATCH_DEV SCRATCH_DEV ----
+mount: SCRATCH_DEV mounted on /mnt/scratch.
+SCRATCH_DEV
+SCRATCH_DEV
+SCRATCH_DEV /mnt/scratch
+SCRATCH_MNT             : already mounted
+--- SCRATCH_DEV SCRATCH_DEV ----
+mount: SCRATCH_DEV mounted on /mnt/scratch.
+SCRATCH_DEV
+SCRATCH_DEV
+SCRATCH_DEV /mnt/scratch
+SCRATCH_MNT             : already mounted
-- 
2.49.0


