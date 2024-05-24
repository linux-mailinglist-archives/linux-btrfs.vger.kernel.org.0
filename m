Return-Path: <linux-btrfs+bounces-5272-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B1B8CE063
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2024 06:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29F04283720
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2024 04:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2776B38F83;
	Fri, 24 May 2024 04:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n0+7ECWg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CQIfgVzF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A787F2574B;
	Fri, 24 May 2024 04:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716525538; cv=fail; b=fRofaq5C/S+4dq0BcbTTa45nnpH7DLi9w2fsmVxxs3kWSyDn6BUA5K4MYM8KuGM/Bsl0cYFJcTHK3YPWtwTtt5VX9Hzo6PGFmataYYbdhOIk4yGJTjaaWjd0xg8vysow45WpfM1pUjKY33RnJaxrPJrn5TJa2bOBrfx3YKRQqNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716525538; c=relaxed/simple;
	bh=N6pswBt9BPMMpeeYGyiMTw2nMkivE3JUFiLlMyfHvAk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ezqhzfdyQ/6QHgSVNCT0yMvCT+mDyWLrtiXUEXspkHdBOvc8+hXQbUxRkjEy3k/+s9vwxOzRFjUA0YPT9wyPmcDTc5gG5YVqDCdBXjjLqpvzQ8dR/h3S/bdyTY7Nh/uIx7ITq/S/WjBei+eF6PhzSiL+C2NLxAURBJ5HlSvx91E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n0+7ECWg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CQIfgVzF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44O11TY6032144;
	Fri, 24 May 2024 04:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=YQsctY5HcKvgXWNUw0ZT5wMGn6mKWkGJ+VQxDTaWw90=;
 b=n0+7ECWg/MZ7ufymm6BmYk4S7a1Y9irN4f7FZPg9/FOqiMndgbddTwkQjpZi5Ys+1WDq
 B0mGHbYXbbPa8r5420q5mD6f0m5DaF+3c16q7GSz9m85HrE3cd6l/PFXK5+yQLFCXSZB
 olG+oCAWWrB6bj/3wcOL5UsrI6amaU519oldS8ST067aC5WYwPKzpGLCr43H2LrdRcpL
 OYlnz7LzghSWMOMXzeGnacfSMN2o7qbSzc2t646ep20XjzBKvxBnxVOSa/9KgOrXauvo
 tTX4V05rtK5YjQ7PW3PuyFyfXwakp1j4aB8vjEIuHV5oZUE9BTTtHBYYYEnuvIlMGFB5 ag== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6jx2khh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 May 2024 04:38:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44O10tOb036055;
	Fri, 24 May 2024 04:38:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y6jsbd6nt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 May 2024 04:38:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFfO3tOfN5KVMnSftAq2gZkBRx3SgMMjDdyoOmHeNSblHsXFZoL7UhenHjw+2di7J+HJTdeLOWqG0WBsRi8v/pGUqB0l7E1jfInZv6IAkEKWcNTYFTtgZKYrwBe0+AXTAOd8+eAMYucFsyTSqPWj/mHkfBBFsv54DMXok/ticwFy0iCE6tHUwwF3Vi5Gz0YwR0eFunnmlCT+xDYFB9Jw1KEMhQj5kpc5xw0dxlzUu5w20U0bPazeDbYdTBvfso5NFdPUcN2Qu7Ch0wuFQqegreaY6bhoy30zpPkEFqpyXDWF8H0J8wxyesHnLVtOIJexlLyHI1BR0dHNmNy1LNSkAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQsctY5HcKvgXWNUw0ZT5wMGn6mKWkGJ+VQxDTaWw90=;
 b=VmjXOSN5NR7LoWraCQUjB7o7ZQNAX0B8kpblQMroeIB7YJwfK2POFlgJddqA9jjWUi4vo92RYR/OmrR+34LsYGVonYpCCgXlzmL9+TxxundlfwmaT1KrYRd8kvVJLVGJeqJmmQsMXoZBjViucjjol9iXeF5TCHpnAJnkdV6xE8Jk1WDHIhQtYr0rJxVCQWvl3BKcentLfWBo8rTa5N81HTheHlc66QFFHoSDyF0SloZAyb18YcFW9UCE4c2dtvufdk1Ic06c8bEXD4PBSkPQV5C/S16VkX2Cgmo9i/jKQoZ38KHGNyKoUVStFVxPzxNNhlsZegYLMbJd1tBrMAJD7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQsctY5HcKvgXWNUw0ZT5wMGn6mKWkGJ+VQxDTaWw90=;
 b=CQIfgVzFSOwDeV8VCvITsW25vzjhbwigLhx8yknkF3BYHSP1pAv0ZAAHdsih9AbuEDLyawtb8NR4Lob1+DHNyM093/9TAXon4O/jgCJGALjpJIbZwjc1sqDnKN4PdoElf8+6pWGPFd2kx9gV0K+tZNKHqalATWu5vcTpawIbPbQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN0PR10MB4839.namprd10.prod.outlook.com (2603:10b6:408:126::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 04:38:45 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 04:38:45 +0000
From: Anand Jain <anand.jain@oracle.com>
To: zlang@redhat.com
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [GIT PULL] fstests: btrfs changes for for-next staged-20240524
Date: Fri, 24 May 2024 12:38:14 +0800
Message-ID: <20240524043827.9428-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0161.apcprd04.prod.outlook.com (2603:1096:4::23)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BN0PR10MB4839:EE_
X-MS-Office365-Filtering-Correlation-Id: 183abfa2-cacb-4b21-aa6a-08dc7bab652e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?tUEZTZU1NXg/OxsetMmcaVOOEanOin9SwA74wy1S4v1Ivw8aNyWl/mF03sBG?=
 =?us-ascii?Q?TPS8eXIBhRJNTNUlJ45ZcTMcZhLAG2JJaMczNcjEVQQT1mjgEuJBTb+eybO/?=
 =?us-ascii?Q?XsQPFDzpjmIn7Sx9Cl5883gJt6mXg5/2PjcwbL0CWU//bEQjYUXyeKrNvvyz?=
 =?us-ascii?Q?hmLqq5QxnedcBtOTmbvxl7I1BGpCOQNNLrFN481Oh8tNJtnRJXqMrDxtcwKQ?=
 =?us-ascii?Q?+ahNBHpeyvsgIjK75ftQH6k2Wi3IN+lNXKgFvTuB+/7PlOeRqVrIM+92PI/g?=
 =?us-ascii?Q?DP1N4gVJVDlWhvqzQeu3flHM6IeZwxhjJ9pk0wPTfs+VkVJZczCHIOsSj/rN?=
 =?us-ascii?Q?o/ck0P+A1ZR+XRysMGGjPEjahfj9IhzbLPzsdVxdhf1d+VmWSAT0VzbEh/75?=
 =?us-ascii?Q?EipSBOrazeo/SylmJxYGsznulRjmcFQgNx9aKAuhZJ6GX/sTIWKok+CXfl3b?=
 =?us-ascii?Q?ViTliAXiaMImZ19ImXfnnVdIr3F/DYyKe2BLXupp40AOHy3myf9CG0ADqtOl?=
 =?us-ascii?Q?FAMP/DR8LpvqplKndd1B8Dusa17HwDiStJL86VhvuPpaUQRksYry6Mflo8nh?=
 =?us-ascii?Q?/TP3Gnr3On6yQzOqQuvGRKM4q9QfN6Jk3820CZ6sMyWBh76CtUBynZpq9qga?=
 =?us-ascii?Q?vde2GMfih1x/uLd2kb35K+UPW7p71g9NdWIqChfU9aBdqbAwhEbePOsPf9tz?=
 =?us-ascii?Q?Uw/WWEnxbm+ASAtqSytKMXeOKkVsrnP8B4kO5HFPXHrhY/YK0LWozJnnowOr?=
 =?us-ascii?Q?nuzsYFEkfUjHzguT5PGkiLLwGxDHVFFVmYGLvT99lu6EDeUFhe+/T85VrzGX?=
 =?us-ascii?Q?qLy4TtywqRYJX4udZ5EMGVcHSQtK92LOUOGNPHftZa0tUf3bpn40DubqM2qd?=
 =?us-ascii?Q?aFjBdOF/H0r3ATXASgVLqBHuvy0mbQi+kcfhWpdyLeitKPeDlbT0BCQTpS+T?=
 =?us-ascii?Q?As36lRzSR97h202+BejWq1E1w5l/0fnqlTF+1eShJeW8LLe0vFrtMkTajaIH?=
 =?us-ascii?Q?bMX/jQLKEL/OzySZygMoSLQZe2ZxwfxxFQxN77fIIssaPbhhjhRgwmtBQeYn?=
 =?us-ascii?Q?vuKLnNbgv+8/09GEYHPRdeBrkJCnvqg6+SpNUQyldrRQOFASlb8ONIUft5vW?=
 =?us-ascii?Q?12hxqU6L2/9wVoRXXWOxHPUzvoHfrNUw49eE710gdqu+waO58N9CO3tvk2PP?=
 =?us-ascii?Q?t2sIWIO0ao38kWNO762sBK505YukGr68nkqSVxFGWBZuwP/922Ogm6mvYU8?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?G4FfuT7B/UjWtAI5YNwHj3am70Gu7Dnt/JKjt6A5X37m4XwsIhYPAR4VcRh7?=
 =?us-ascii?Q?7M08a+yjcJZA92FhqQiTSO8VP+OV/7FjW13qmsDbf4b19PyBiWxqK/MSlrp7?=
 =?us-ascii?Q?F1DA+YBwE7HdRdG1TyuN3zvwZbySmpi370QnxzIWrrxk4LGbOKWUafzszT/L?=
 =?us-ascii?Q?fEh63UcHuEucvY8Pb6rQQO9u/EjV/c759c/g2kJs++qlrK1ZEgLWbr7FqYxQ?=
 =?us-ascii?Q?DVh5PCH5u7UkRZ+oTqfaJWDuvexOdE69bE2QZzzSO/wQOk7+ohAFIYeH7vUf?=
 =?us-ascii?Q?IgxYgNZKYDyJ+RUnETpKm1e+SuET3WZjZsbOpOOD4zoxDr9+zXXHWhEw2XP9?=
 =?us-ascii?Q?mkDy0L4qR5vp6RxusZzUasla88DCZM+RfF+aLGmC/SdcgsQgqrUJ5chovWAR?=
 =?us-ascii?Q?KjDh6w3rQla5hd/QM65Q4XdCSQgV2nNRR9ymBYMyMDydx9YCPJbfACUX2fA+?=
 =?us-ascii?Q?16JwHBS0u4NN5VnaIosA2yD/pB6ZZmNWMbrXXGwDqc4WYHFI1Ye1Zp2+roGg?=
 =?us-ascii?Q?NOJMYv1NZfBiY8YFpPHV1x1FSWDCDaDOep5yDjxYdFoLdTq7K1DiZCHbVN9E?=
 =?us-ascii?Q?eRfqXmD1N/BGN561UbfPC3NK5mSmC+XbZqNNY8RG+Wb8S7N0g2Lr3q6TDiVd?=
 =?us-ascii?Q?Zmu08eZClmO8XsAtluHRYQ/sr1z8W8n3oIoBNMds06nzXFbKbnozJ7UQkzBi?=
 =?us-ascii?Q?CiGjQEF8kMAtTIAm9Czzs/Je5SVRpdCIl75NrFe+tNafH1PHjEGxfLJZqtS8?=
 =?us-ascii?Q?NKRYGSxSswBwZtufNoK7E8CG3l3wYL3AdBIquXKfYr4HQ2kgUgclKn5/gJq4?=
 =?us-ascii?Q?yxgLrCM4K2xb8JT63sRWzUPblJWTQ+1GTCPt00N4Z7ua1/ZGiqAvTMPLzHPP?=
 =?us-ascii?Q?0lBa0ELxZhHG0zxLdM51fTFPYgIY1+qIomVbQ4y0ozUkdcomMyfHmRkdi3KQ?=
 =?us-ascii?Q?70/hR2CKCBnpvMiE3/jqDSXDmaHJa/J3VhujIjVNrb9oWEYLHd9lOqGQl5Lu?=
 =?us-ascii?Q?+UHuoWNWjaFa2U6Rvber2IZuP9gT10Q1x2a3TrFg3YTqDWjZzn4EfHZMqcLL?=
 =?us-ascii?Q?Li7BorjRa4nGOue6iye56+SoQfidVlk0rsQn/wMIHx8VA5iHLC/CsprvCjv1?=
 =?us-ascii?Q?8qA4pDsOi9S6O9wWQK1igLkAV06e5BRoJ4gm27weDLGC/3Y2DiaxwZ1oCWuc?=
 =?us-ascii?Q?o4oXbDKyM2Ey4OEuQBUBEzpF0Akn/IM3OAZ9DgB6RnFFnjSPrduFIVuKKF5e?=
 =?us-ascii?Q?rzS5ZfwiN5q+RWhCZYr+d+aTp82iAG3dUJaXTSjkXlERFpeocxehkj0Be46j?=
 =?us-ascii?Q?C8A2ybDPHKfOchvolXqO9jn/tQrOEPIsydhLK+MB/3kkOfmOUmsdWJ7WKuZ1?=
 =?us-ascii?Q?RndQYpmSL0jzFBoQBHufpo+S4BSEnEwBoS9QfjDj2BLDqOi6xKIURo+fJvxc?=
 =?us-ascii?Q?SMQUzOTq3x4ZzGJgbWhmQIySPI/EtkCKz7CQmgaemHXgaz6CJAzgy+EnsP82?=
 =?us-ascii?Q?qT7bpCZpxdhX5kmKUk4sJ8A23XQSLaY/OM24KXh0aAmoOkN+8CnMIuhDywzE?=
 =?us-ascii?Q?o5L6ezavRvOH5AZUvcSbWDy6lvE42YsetV9QeCIZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Xy8a6A293pLIKmgjbAtRvKrPI4NYxM4grxLiBGyTj5QYs+Sifogty0d8OMm6R+0VY/uTpcuG0QaSBf+vNmewF6wgKT8lYtCO4tsfCuxdRKFPWGY5T8oytWL/fjjQlQbqSmuIW7LoGG9x2zB4M+Vs+Zo6kGsROwD/pP95MhYjOicovkcQOmPtEUyLmBTXFh+GdSqoepyd4QUEq09EhKKRcIgB7ahvRhPymg9FhpUqBaUiKrD2ct70n1GRq4hRwA/rSy9UE4SuHVK/GvPz4pPTRK/WaYF9sWTFEDseAN180n2OQaEfs2/Aen/33RqjRBwsDAgyLg+Sax0tu2CzNxTSIrEe9pHONGa2PDU2+NzMQdPcKKAXWRN+RsrogXa82uF82QSVOEwBYfy6sSB9+PeUYukfrRLdZUr1IOybea6TA3vX5gKRo4a3ux0qrlPLKPrvzP0zODPRkk0kDdp+XpgQFQvaGab6TZkQcNk0ZiRUfzwYkYb0TIa3IeYzWta0soCSoy3XLEZdHUTldbKTaCy7B+yvR1MLqEaOg4YUefmBO+BX4mA35RtGIKE3RVwzghERJBfCWHMIEQCikAz+Uxfdq/sKucexCZ2EiUp9WLc1GpQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 183abfa2-cacb-4b21-aa6a-08dc7bab652e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 04:38:44.9662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/94H2yxzxugSuqXornU9r59hvPUew/3Ofbay8zwW7w88m1iO9aCVb02Okm7yiwaqT1BQI+OO1vqAyfnT4D7CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4839
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_15,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 mlxlogscore=918 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405240030
X-Proofpoint-GUID: pKlE3mGNrXgbixSfEhsbaJBwXqFxgNVh
X-Proofpoint-ORIG-GUID: pKlE3mGNrXgbixSfEhsbaJBwXqFxgNVh

Zorro,

Please pull this branch containing btrfs test case fixes, gathered from the ML.

Thank you.

The following changes since commit 9837971383733ad59ead121dcc4b13f89829d389:

  generic: add gc stress test (2024-05-12 20:28:48 +0800)

are available in the Git repository at:

  https://github.com/asj/fstests.git staged-20240524

for you to fetch changes up to a42f8a6be29e0857ad3ba3a2b6952913f56db877:

  fstests: mkfs the scratch device if we have missing profiles (2024-05-24 12:06:43 +0800)

----------------------------------------------------------------
Josef Bacik (5):
      generic/352: require no compression
      generic/027: require no compression
      generic/269: require no compression
      btrfs/{140,141}: verify read-repair test data by md5sum
      fstests: mkfs the scratch device if we have missing profiles

Qu Wenruo (1):
      fstests: btrfs/301: handle auto-removed qgroups

 tests/btrfs/011     |  6 ++++++
 tests/btrfs/140     | 15 ++++++++++++++-
 tests/btrfs/140.out | 34 ----------------------------------
 tests/btrfs/141     | 16 +++++++++++++++-
 tests/btrfs/141.out | 34 ----------------------------------
 tests/btrfs/301     | 14 +++++++++++---
 tests/generic/027   |  4 ++++
 tests/generic/269   |  2 +-
 tests/generic/352   |  4 ++++
 9 files changed, 55 insertions(+), 74 deletions(-)

