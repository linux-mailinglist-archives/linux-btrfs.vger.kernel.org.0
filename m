Return-Path: <linux-btrfs+bounces-5173-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B20D8CB29E
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 19:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1FB1C21A22
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 17:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851F11482F3;
	Tue, 21 May 2024 17:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ac3OecG9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="N5qBqp7E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE89147C94
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716311557; cv=fail; b=OsrKjjeH1b5aTYgazPL9XvEhMXKcROPej6lWrcdgKLUSuWPQBu+AXymP0V9lEl07VLb45Bxo9rhQEy4UCBJl1UIE6jqXTKyw31tSYh/zZ33Tp+rL6un3Hrr/vPOCmBNS2M0vslB6yQEu3ZZCpGGh0XJ8A4ByLREAd+Zp4m9T0MY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716311557; c=relaxed/simple;
	bh=FuTZ4U3hwEiJeVXW+XIwgSqtsMCxu5k2v8eGoblYDX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mH8ZPDOmg5aOktAqSOS7bkrZbqPi3KyZmF5gMBBdTXyvRc4U776DfiVl/VZlnYTnXQ82HA6vk6ezMcRzNkRDkf547sDlycf+gwW8+obpFsJvvmVvDf51dENODCoa19khTyzbfm8LH1SyGI9uJ3ERdZJ9m+0ow8FobgMSDF0N7ZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ac3OecG9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=N5qBqp7E; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44LGwlGc032747
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=c5txp9LDqqzxLmjyy2vkMK5Qa0XUF1EfKoacBx6IxZI=;
 b=Ac3OecG9Axxvxie4ymQWJJS1iFIZtgxslW4JbFtbBZBg5TPbMMJx/EAR4L7H3Btt83Aa
 z3si6pG5klTOdNZHe38f55QbsQ9TedvH2+N3FuaTmrHb17XeP6WUL6fbMRTA55Z3+8l0
 CnmVVeFqgmP3McfS+LWOrY9QIrvbviD4yWWD0q2iGXw3I11TYTHD09WgDdGRNzLOxpJo
 /rLu18gre+kjWbgeKb1/J+5cgr2LNc803NRzCKL9Ud9RrD9pjJV7NHZG56GrOzBKDBX8
 FU/i293/tQ5QC+oxvQZBj4HaMl1R1fIeTsSlvKSBgE/kxgmkMVaPVKwIn5vt1Vf3rGZ7 ig== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6k465y7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:12:34 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44LHBB7C005160
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:12:33 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js88sbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:12:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOPCNIWLCGv6NivBAgsHRREKXVtvoFBIFNd9OVXrxy6k5iqJicGP3nkhnDUkkd0JuOoOrk5tfF/qIvwqyW28lECNsVcdPhyqGybM00k3uMv8EQ/5eJwZ8J0ARjZizzWCtnCJb59cVSJ724AQgNVxMd/bHWSXHNIptqpF/W0irGnI5oSnz2KYLSSSQSMAVuaHVh8ptVaf276WQhBDLyPUKhn3YPz0Or3XtSegGBQ8Q/CyP+zUFSTHG6H2d+ka1AjQQWbJVOmhNLG8A26o09Lgiewg2jTsRzJtuFeet7ac/TgmbQdDZ8tNq1PVvK/2qAAtZOjPnE4ZcWlsAG1mFmnBSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5txp9LDqqzxLmjyy2vkMK5Qa0XUF1EfKoacBx6IxZI=;
 b=ZOPCAnteltkNMusD9Xw//p+Phqmuw5YvXdas0562qxDDr/ZM6sCvFR/5D+LT6f/GlJQVKO2aky91XhGPJyaRkWBmBOsjGnY6+QsOY3uoYa59V0q4zG5H0mJJjw1og7tjMCv0R8zbB4p0cuuvQGOkw8iTTdiufTWamJNyCMbKZycY/8gmqdKai6fKfSalXF6R4xWW6LKdnyJoLs66HC7+LQHBl8UUmZX7elYqrINuONdqNjbJYC6mrGP8JBCivbJwhZDTSsm5MDkEl4NMpnEDn5aSwcpJnKQFkbpHW1KL5qRkt9zgFus3XJf5Ip8qhp8ZM3u1byBvK/Z53/1guNDuWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5txp9LDqqzxLmjyy2vkMK5Qa0XUF1EfKoacBx6IxZI=;
 b=N5qBqp7ESKzoBFXlE68qILOpFzWv92eERuEYg489YIGydC2aPAv80Qs55WIHpmTeKXE3K1havOCj5WCfjskFlAPoS0TufMbXhd2Tbb5ldH7mlghjTtI4tCsJEqUCf7JPYe0bkzkUjQ7snp8qTiSGJ3phFUxzHnU5/dBv6SC3wcQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN6PR10MB7520.namprd10.prod.outlook.com (2603:10b6:208:478::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 17:12:31 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7587.028; Tue, 21 May 2024
 17:12:31 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v4 1/6] btrfs: rename err to ret in btrfs_cleanup_fs_roots()
Date: Wed, 22 May 2024 01:11:07 +0800
Message-ID: <4bf4e740ff9197b8bdfefbf30ba2eb26c45dbcb0.1716310365.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1716310365.git.anand.jain@oracle.com>
References: <cover.1716310365.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0141.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN6PR10MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: efeacbe6-0cf4-42fa-e3de-08dc79b93328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?6pEf90l8MEbFXLdv2WWv9HEhGNoZlwG4paO8C2sYa3d8cm0/i4S9x6D+4NBz?=
 =?us-ascii?Q?TmcBEZTzHbEm+3td9u/mKg2N1UAfJRgW3Bd3Nbli8drba7LPKnEQTvx6qG4m?=
 =?us-ascii?Q?2WMQy/sPHpjxqHimCrZv+TCmgaMt/9iCZXvAvFZ7aI8+XKK+0rqC0lwaROI/?=
 =?us-ascii?Q?rLF/2Phv+pg1/Qp7nTo3Min1imtWOS0LlQYNDKoBUaeb4K1RGpYMStwIh/Ga?=
 =?us-ascii?Q?+SC7BFZRSY5QUhW9qRTZNU2whLsLCsn1LEa/eOKG3XrNlsCQVqNJqwUJx/ki?=
 =?us-ascii?Q?WXXkqemPvEcyJVG/9UHecZrS7Rq/RyEEIcQdwrROGTCgLjfmXWRPn5YQoXRF?=
 =?us-ascii?Q?DdaI3o/2csKkdum2wjDgIQbl0CcGlxev44abl8GKXZQzeVdUdFJnntfRnV0d?=
 =?us-ascii?Q?yPuSXRyXIX0WjJ64qjAw85RIs02lq19tNHyTr/aHeCyElM4XkxM4RpkkVE4F?=
 =?us-ascii?Q?0IoxM6KJu730eDzsGzqO4xuHnDUz2iRTS3ZKwYGR6JL+wpEeP7K5lb7JFzzf?=
 =?us-ascii?Q?CfCNhMo+PWKeIx7alOfthUcnE8Bnjo4+g4yiRv6Y8SOu9gmuEffC4ZIYysOQ?=
 =?us-ascii?Q?AtFkIygAYxXB0r7rrPE0VmiW52Vknw6ybsSlcTtBjYC/AtXMIj5BQo3DGPPg?=
 =?us-ascii?Q?j3FCzxPxVLeqGrRnkqBnfww8A+KC5OpfI0x+/XHvd4fUxD0Hgq35q+gdiMAF?=
 =?us-ascii?Q?GB1T4wnK9myun2aRCS3vmQDR+fgHIIQjRX/UBk+HnhD8MkdC9RKrhDW+eMdg?=
 =?us-ascii?Q?SOe3YWFAi6P4t78V7lNggdMUPSG6wzEM3GNwBoCtDvJphaBm3ZL0PrYIhu79?=
 =?us-ascii?Q?8ghhxQhm6kyNnwWbIBqTK/RhDCHVWc2G2HrdcHNSxeOlwG1B4lJfZcYL7gr/?=
 =?us-ascii?Q?ZrXP9N51V/TEy+U2YmkGRY4WKP5FyKH935n0VsrWtuq3lJBKymu3Cf5p47fM?=
 =?us-ascii?Q?xWiEOHgTJKfYFTyVKRKdFdvWoTPgi1DQU7wWw8RwFrR5BVMfqIU2g+v65rsV?=
 =?us-ascii?Q?3JITB0Lw/xTJ6iHc41RVZtIjWYD10AeXprwenYyyp/xvZGBry6I5Aqa1FglD?=
 =?us-ascii?Q?/PPRau2lYvrFfTyrdfur2rAqY7wkOj1CYDGs039vbqaU64PFiex7vlHufNbi?=
 =?us-ascii?Q?uHZoB6o9Eynon8zaYoBvOSLrmk+wBOmrhTIhgnOOgJdnewLxFSE30+977eBb?=
 =?us-ascii?Q?g1fPggOu1Vw1qsIg0F9FXQ7tReJ89cFzp9r8N4aXZxDG5tx+xMOjHEMPqiWs?=
 =?us-ascii?Q?Hu09beIrZeZSbCdV2S2iM3XoNon0db9rwEPhtSMFHA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9/LvJu1xwkaSMoHHj3lEnUhQKhkQ7A+Tpo6JKj4gbN7n3FDlNZspNg8ef75k?=
 =?us-ascii?Q?s65+2QVEoDBuT8gDFqh1X8XZ6hQBcnk1f3oIPWOFs/4HLSrf78wyzhiZdYWN?=
 =?us-ascii?Q?Va0MKgi7M/PMKRCo8X7/xi3aD+DByXDp9o+aFWSSNqITX3+FhkuvUBOPtYcq?=
 =?us-ascii?Q?nW1s8NxKyfI0Z8+hGhlIkqgwpn/AMeXWDLVXXvjbrW1k42bMwh2J+Y12oYPg?=
 =?us-ascii?Q?0JvzPWCeFRG/+YibkeznH8+2405OH3RZv3I986oOIUK8zvC9OG6KLLqLXK6i?=
 =?us-ascii?Q?e/sdO3XWYHflFmJ5tz7jZQhTPM/xCHNqtmpp+PC/HAmxkhAmD1AYNgd8sg4S?=
 =?us-ascii?Q?+HsWp17G0hwX7ms7CrSfLYWU1Q9JOZXqGz0C8EbuPRvJkT3irNqHKtyL47ku?=
 =?us-ascii?Q?bvKTdNj872wh5qvvEbxP8pU5FHsA0FotBfyDXuwZxrxFW2/kcI/N/XrYYDnG?=
 =?us-ascii?Q?x4T7uDh4bTgcTDaPodhOXZwjLBXMy7d1Uv2fHs9CnsyFFGGUql8tlGFfEXA/?=
 =?us-ascii?Q?n66mjldKJ2G8zo9zIMOCef/7XxcUVdfxfp759P7U7+rpv7PRCO1Ti9Jm9ASz?=
 =?us-ascii?Q?tTKs+/9tqQ75mIyu81GUJp/aUjNviI/bbFdKrzoQudcD/3itPwza6ceLbJBs?=
 =?us-ascii?Q?zChEdpAzjVb4ZuM9cgHxkcF2HG9o2aOjAV8i37iDOgyW2GWrSzhCHXv2MWdb?=
 =?us-ascii?Q?atK5dxeeeApUCyx9hRWLQZaEhmV1QAuThPIGL56CDs1oqCi7ogP9TyJeE/zD?=
 =?us-ascii?Q?g1+MxJjZgBzokmTPYQykm+lMOeLv21Xkz6GyFs+enC/DZW+/lFhToWiPyzAz?=
 =?us-ascii?Q?RbKsaVOXKfQGZvwIoPeLq5Qncq9kHbGvyiJcYeLQAWgSnydj9LFwQnTArLPl?=
 =?us-ascii?Q?ItXtPJ/F8rbHQQSEYGfBDLuKwlA9uU72oSZxnYU+bK7F686PAuhs3Wr6ErGs?=
 =?us-ascii?Q?6Tk3YXYNhvzVvyJew1vfD2MvbHOUub1fogvon8qp/lirn+OIP+B2Zh2fYJfK?=
 =?us-ascii?Q?1hr31LsPTTokUH/BAezP665WuxworSsaAn/NKUQhMfoN4iE8CkRZQLEC09mg?=
 =?us-ascii?Q?MzZKCWLUVICoz+ZPO0UtA34qh5L4vwWLgm+uqFfCk0HZ3vD2kzHJaYHegjwb?=
 =?us-ascii?Q?1piCaJR16MRjGKDL2/Mr5ChPH1qdI2XKQacmCLaypWoOABEcRce/1DKjpcYT?=
 =?us-ascii?Q?a57c/u+6SZCufweOVROyQq2T8PDvTTLn7Zl5vnoUqwQDVNzGXD3BWpmmAsCB?=
 =?us-ascii?Q?rlJB3B1bTX1R4pwi7FUrQpijEO1NpWDxOkN+xsVoNTIpa05XfaTtHhptpxMx?=
 =?us-ascii?Q?WLRLrbxlCKpI3rR4YD58jyuj4RuHWsdKfkGvaSw6I1hte8+F8vjOl5T6SM82?=
 =?us-ascii?Q?r+5N5WPHsN7CId6TDNGQ3bEFaBF7qIYITj4JchxsNeyB1QlCHDw64FPtvAZa?=
 =?us-ascii?Q?CGJnsjM3ICgA9mgL1g/uX/mwNQBk8wK7X/qx3DNQFsktLVz2zaBfRllAqqIk?=
 =?us-ascii?Q?3AZVVgTIgab0qVhMXrzKLOVzmn8JFbCE21qldCi6bPkJrLVn0zeKdKUa+eGN?=
 =?us-ascii?Q?8mDs6L6Lz924k6vn3EeDmNfu/WIpO8NwhHehMprerOodpto6PsDvuIzt1NU6?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dBcpyK11I1RXvZdO9OHRxVrSzijsJ12nchxlUaDZR109xOKvtsLQ51iQTdFwA0NY+RNe+53nmxAq1tjZDrIrf1NN0zd1TR+tjO+pnK5V8uLRjbZpJ3V0aSfwmUF9/X2xMnqtyQH2fYyvb+1uvpFQLwZhaXlmb51REPvxf0cRVZBBSj1Xs0hBfhTWe4D1LF/6o8qvoWxYhaDQmAvUt1P1S5cP2Rz4vyYxLxmZMRxBwz1ouOcJld44G1lU06ijATwa9Uh+7jI5yY+XUR+JiZnrsPvh7F/103kJd3rSfrBPrDWEjrlEW4lLdR5nqpU0ZrL74PIGAhDDdPQVQO/8mTwaRqN7L9PlCS5/X+Yw8jN8IPQdiBQr8grCHMCgXDPVDqypaZddBZ4UvsMG+Mt3b1awKBzWi04YxGz8fvI+5UD9mIquY2aP5JuAVzvgx8axaOa9v5LyKae7nZS0P49RR9av+EEbJXQU6Lc4gXCcFoTmil+8LRDezBT5nNGxJlzlR3Nh9iyhbVghf0rXrZgaVd5atNwSlqLQSA4yv+vzJxUC8kylfPv3Taooq7FqaWpKvJnH+0xQfy/t5lyhxSMlPWhgJ2c01TtgsUYVlmA3fpO8nFc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efeacbe6-0cf4-42fa-e3de-08dc79b93328
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 17:12:31.5012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QFeDxYNQFyWeZmsImlQ6f/hU54vmOiZAMKt4i+GNnNqDJHVOYa7IctuO8PttM/re5TH3AQcw9eZ2ZM/6gVaRqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7520
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_10,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405210130
X-Proofpoint-ORIG-GUID: p85qEztRTkbBHMrZWMyuFQaWQ3t0LLs6
X-Proofpoint-GUID: p85qEztRTkbBHMrZWMyuFQaWQ3t0LLs6

Since err represents the function return value, rename it as ret,
and rename the original ret, which serves as a helper return value,
to found. Also, optimize the code to continue call btrfs_put_root()
for the rest of the root if even after btrfs_orphan_cleanup() returns
error.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v4: localize variable i in the for()
v3: Add a code comment.
v2: Rename to 'found' instead of 'ret2' (Josef).
    Call btrfs_put_root() in the while-loop, avoids use of the variable
        'found' outside of the while loop (Qu).
    Use 'unsigned int i' instead of 'int' (Goffredo).

 fs/btrfs/disk-io.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 94b95836f61f..1f744bd6b785 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2914,22 +2914,22 @@ static int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
 {
 	u64 root_objectid = 0;
 	struct btrfs_root *gang[8];
-	int i = 0;
-	int err = 0;
-	unsigned int ret = 0;
+	int ret = 0;
 
 	while (1) {
+		unsigned int found;
+
 		spin_lock(&fs_info->fs_roots_radix_lock);
-		ret = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
+		found = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
 					     (void **)gang, root_objectid,
 					     ARRAY_SIZE(gang));
-		if (!ret) {
+		if (!found) {
 			spin_unlock(&fs_info->fs_roots_radix_lock);
 			break;
 		}
-		root_objectid = btrfs_root_id(gang[ret - 1]) + 1;
+		root_objectid = btrfs_root_id(gang[found - 1]) + 1;
 
-		for (i = 0; i < ret; i++) {
+		for (int i = 0; i < found; i++) {
 			/* Avoid to grab roots in dead_roots. */
 			if (btrfs_root_refs(&gang[i]->root_item) == 0) {
 				gang[i] = NULL;
@@ -2940,24 +2940,25 @@ static int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
 		}
 		spin_unlock(&fs_info->fs_roots_radix_lock);
 
-		for (i = 0; i < ret; i++) {
+		for (int i = 0; i < found; i++) {
 			if (!gang[i])
 				continue;
 			root_objectid = btrfs_root_id(gang[i]);
-			err = btrfs_orphan_cleanup(gang[i]);
-			if (err)
-				goto out;
+			/*
+			 * Continue to release the remaining roots after the first
+			 * error without cleanup and preserve the first error
+			 * for the return.
+			 */
+			if (!ret)
+				ret = btrfs_orphan_cleanup(gang[i]);
 			btrfs_put_root(gang[i]);
 		}
+		if (ret)
+			break;
+
 		root_objectid++;
 	}
-out:
-	/* Release the uncleaned roots due to error. */
-	for (; i < ret; i++) {
-		if (gang[i])
-			btrfs_put_root(gang[i]);
-	}
-	return err;
+	return ret;
 }
 
 /*
-- 
2.41.0


