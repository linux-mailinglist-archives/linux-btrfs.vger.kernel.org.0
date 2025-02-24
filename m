Return-Path: <linux-btrfs+bounces-11742-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 277FDA41EC0
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 13:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 968163B5E40
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 12:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D350E248870;
	Mon, 24 Feb 2025 12:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RAObqEH/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YfLr5Qlp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12CA23373C;
	Mon, 24 Feb 2025 12:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740399342; cv=fail; b=QO6k1ySqSEMtrBsiZYWnr2xjYX5CuWbK2evz31M52c8T3YIdtsIE3+bnDFVSbldvBI2hDBqkZWBZ9DIVCF2nuir1bY9ybhjgOFDk+BzIu0v6U9Xxq1+zUFhiy0z4IvYsKh4tb31WUyjbtSgXECJprH6kepqE/zUIh1PwT+BE0mA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740399342; c=relaxed/simple;
	bh=kFg6YZ6jq4J9DBPEEGmu0kdcUKCP4mvMRumBx3ywsog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hq3KFEpfBEaE+D8TTjSSlsxH2Li1P4ARoJIRF7pgCfo2W76cFu5n3PDbUOWFqaZQIcJmz++DiPjfGZmuvGKIkQmmDm3qgle82n6RZIcCPvThdQ9DEILKV/rkp6NfJ3vlptR0nwB1PT09d5gvFnFIW7IL6JwMi3Mg+1/wfoUZvIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RAObqEH/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YfLr5Qlp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OBMbdc019932;
	Mon, 24 Feb 2025 12:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=lBKlddT58XI/Q93qh1DOudyKCn0Thatw2+05Sjm9ck4=; b=
	RAObqEH/MRDSIBQE2+Iv8j+zoy+3Xw7IiF2sxwb6c3hG2wNnq8+wpGfdLTSGJx3g
	NWohbSwx88qBKr5fNW3REfxB1aR4ladNNB4azOg7ggG4OqJsflsyhOZPtN6ZWog5
	akbFxsl0JZLc5GI2gfTscePgaBugZJCRFnL091dDmiHHFtFV49aFpZ84RiV+RDA0
	ag1gITH2h17I081bLTRR4pKLNV/pmoPkirc4LexRqQWxY3jrJ4skf6vYQZdfX7+e
	WPf1A5/F7a7OiKWJcEf0bsaifHks7I54q3GKgNTpJ91D0Aw5izNxL3qt3RhIVv9s
	L68Flai53ob1GCZYrN3vIQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5c2afbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 12:15:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51OA8pMh012598;
	Mon, 24 Feb 2025 12:15:35 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y518u00e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 12:15:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjjW4ggV7EYcg3obZJbwL2x0Y7t3tBmY6G3kzyzDJNDFjWb5IFdWfzEKqotX3xx4HvzMAHBrNeSx35HHZ+x5V/JamXirttpP8N6tqkpDzdpvbxgcRuKAvc245g2EKWwJ/Lh10uEr4PfodbvPrrSMssOTsArrMlJcYd2+jiqg8LI5712yOAwB7YprcXIUsv2HwnHJ5joeXAmeiom+wNp0hv6trLwtjkmHh35u3b9BCwYgFS3Zg/ZYGUvWOx4COeiI63qqzcAPYJtuchU1uLce9moyHmA+yiXuQBGOTToEJsf6ti+xPC66scW2vgVhdiE1mJATkWRkOqfPdW8yvo+dbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBKlddT58XI/Q93qh1DOudyKCn0Thatw2+05Sjm9ck4=;
 b=RQEenpCL97Tu3d3B/OqZeb1gWrm+3qh8TmIZqQ7OUqK+w++eoUKVJ2zMhRtETPBADQp7KKnXD2vA2PDaRRjqAC81wp+6xbWqTk1mmFH7zruU/emqc+9CGttG+Te0jKQ0OQjB81/WFQsmUGKmeT5qojfmDD2vvldZKjmVTRqhokUYx3UYHQ5IH2Kg9DsTCkxH2pW0HRbkCSaZpdzpkgc72MvzWquQ1Beq+BlbTVi3At52iROB6W3T//6nXN7YWOrcECWxtrjNPxTaHqMlsc8GXrvjVhVK8sJpRZbWqFdLTSlB1b7MheEEspIu3jXjYW9wRyEAgz5XH5bvxC+xUZw+KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBKlddT58XI/Q93qh1DOudyKCn0Thatw2+05Sjm9ck4=;
 b=YfLr5Qlp0fwpr3524EVdSwGKjTTeCAcnVWgHS4dVCKubxiMq8/FO3/vz+7Z5sGbaD6W0Zay1cnv1NEyDE5sc6yVeI12o/FaD5C21n5HsFqfZgBdFHeK7DXfkbdk0XbzbcBwwicdQAweCIZjZkIT44hMM51TWY7WiTl0tDMyD4Uo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB7202.namprd10.prod.outlook.com (2603:10b6:8:de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 12:15:30 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 12:15:30 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, david@fromorbit.com
Subject: [PATCH v3 3/5] fstests: common/rc: add sysfs argument verification helpers
Date: Mon, 24 Feb 2025 20:15:06 +0800
Message-ID: <145b86dcc04321880647b4f5821db64f45b82740.1740395948.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1740395948.git.anand.jain@oracle.com>
References: <cover.1740395948.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0198.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB7202:EE_
X-MS-Office365-Filtering-Correlation-Id: 14ab472a-8da4-4eb3-33cb-08dd54ccee55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i78D8Nqia6TxEcHF/EbIoAgru+Aw0OkGUsJpWRblr12p7SME5vGvDFyW3UwX?=
 =?us-ascii?Q?GAaP981CftJL0NHJETKgXRtSvHytCSelNaM7lWD7hhT+PzxVTIig1oYUHGq6?=
 =?us-ascii?Q?uh44I/Or+p500NCK7Lil0AQ/8PVruYX3cWolShoEyii+FRqFDIWBfUz3nmmG?=
 =?us-ascii?Q?bYL3k6NfjJOo42kMlkXS6Sm8HCX8HPrKjEMwXTTHlRxkwyuavWLt9jRhf/2j?=
 =?us-ascii?Q?f8zfP7WuyAUHsUg25nT6eEscijdjMBkCTsZKVoJzpzEOXA+qoTblVHPep0k+?=
 =?us-ascii?Q?4KG41H2FNL7KarSIWxtI5arlD9GvAruXcjo8tFvRNrosiydFJckJX177rE1g?=
 =?us-ascii?Q?78w5ILQo8KKNtXSBWOrhcxTDCJ1gC0gVQdu+9CVOBJdd2ZslvTGZwrac/kf1?=
 =?us-ascii?Q?6D35eXMNeSRqHDrWfs1cOQmg6nwcm0ERidijSP1Lz/7p/tSZkHBwvVFi3XEo?=
 =?us-ascii?Q?OGki7Z1IfffX8DPqhImkgL19AYG/4I10joc6Sa0p7V9CiBfEQHa3lajU/Yu0?=
 =?us-ascii?Q?3mnz6uti1MURXUZvE44GQOuisyAkVpNSC/2o/jOL8prQjxLMF+9C7n0MsrMH?=
 =?us-ascii?Q?0s3d46kGlB39Npv0Y+azeMPE4nF6pGJ6bzQxtIPPSVDHLIJCiJSBOSqXg64Q?=
 =?us-ascii?Q?TqCoEPjXRsXquGonmG5jOxCyGfVRmId9VsqeH3FV+F7smzCwo0cY7h2Fh8uX?=
 =?us-ascii?Q?1xLYoCpxJCKfkliC+hbyBZ9G5ep9NS7zO8df40d1MwYavnRDMHu3pIDxwvtW?=
 =?us-ascii?Q?5oTFpuzd68Ql380F/lpg4MO8lw67nMlFt22dmZjcWgKDubHVftmr3B7Df4EX?=
 =?us-ascii?Q?eb2FdnjxHH0OHHAOoJ7cSkSE0hmVSqsH6d7hXBBP7Bw2m9yTum2HaB81lBI2?=
 =?us-ascii?Q?XZOi0MgB83rVqYnu71pEUzREiaEWEufHSmhyGN3KYhOj3PbYHLlQLpHDQi/B?=
 =?us-ascii?Q?/yNAprJePkv0zTYSSvptUhkRd55s0hFpZrC2K5Wfdwjt8yi+Xubz4Jiltlan?=
 =?us-ascii?Q?usc/PBTtFaIZuTcBhZaa1e0XF4BM/8/+1rAcuUntTCEf2yNCU7t/q0zKNJxa?=
 =?us-ascii?Q?6XK08pDSHjxfT86YQOgkM0ZrDMQktKvajEbEX4Dxb9e/go5HeUcfCcfgxG1T?=
 =?us-ascii?Q?XfznLUGiCGRAC44vSmN6Mhk6VwZrYK7dyGR8Ng+Z5EqNxGih6f68BGfxUxS3?=
 =?us-ascii?Q?AG6LqcjyETuc0hyGuyGJZDuIxECc4yC4cC/VtFBB7Wm3wwDLMKjI8EeVSVFQ?=
 =?us-ascii?Q?XcgIOYeySYEBMrRdKy3Jbcns0f0FVFJlMc70qVfXwja2o8EbyBHn8PMC+cLr?=
 =?us-ascii?Q?WqXH8bDc3Q4MOZwfjo8rxECFOdvO5fd6uLaUskHiByInvO7Xzj0pE+LtpBXi?=
 =?us-ascii?Q?/FGsMu/wQPn/Nd2AQh+vh7SGmH1p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WfpEWfBPai+1oTnzOIUeUT8vjiEDJCRWnSnxp9rUzO+7CEkPhyPsp8MgCHsk?=
 =?us-ascii?Q?1rmDprP1iCr1V5E+rpXY/1/kpV25Z6g77nGPOH4SHW0S1IoCXL1slfbNp34B?=
 =?us-ascii?Q?C9XpNzgRYR4DshWpz1I/82WWZwhowaj7I9lsc0ZceJsr6NccGLb/a1IcxWlT?=
 =?us-ascii?Q?pPzCv4LEz09qnuTyyx6rcT/in/MI/evzTqxE5G5RJSNSGv8BcX36uuUybmQz?=
 =?us-ascii?Q?ksymM8xXOat2eP326k0iClXz9w+d2kmR521EzjBOibCmTxdILCza+Ovo3PEv?=
 =?us-ascii?Q?13Xf+LAvr+JxrpkvOq+BrySNJUqiPXxo9SsakJDP05AlIOQKnVPKBPtoumBG?=
 =?us-ascii?Q?Frd/0BN/V3FvGF7FeiSpt/vvXzQk/cv30FSHft5fXZE7oKAqpvXs6vXq+Oye?=
 =?us-ascii?Q?X/KCg7pKy4QzsbWeQQB4OfynemneGeYyyP4sJL7ixrW5JT7CV5KlVrjBemtm?=
 =?us-ascii?Q?7/RPLFYxn9nqLx8DcW6SK209qj3SR2I8hrcV3NRBYJr0BQ9l2eoMuR/bbspp?=
 =?us-ascii?Q?M0mIvkw2ZRv4TQ+AARl7v7a4Re+GZe+Pu4vcz5eEEh49KFHUkzeHYKV25Gp8?=
 =?us-ascii?Q?mQqayUBybn3WuKMASwl2bZfXK9RKZPKTTZ3l51mVvMHFnRl7dUAPGtBBkjPj?=
 =?us-ascii?Q?IGoejXZhj4WlcKBki2+Tpa42HDXDDybiJx9MBakr3X3pcOQ45p8FMHgS3DRj?=
 =?us-ascii?Q?Cn2PPz7w4oYcaygDV8EKGyS4yvP4scXVWYyI/4q13eCpj3hVjbB2PML7RsO1?=
 =?us-ascii?Q?URPs0JO6N8jf5MLAvVCP4sc+TOYHL6v/J5HPCchZZq8RX4uGdlv9oF6w4pEJ?=
 =?us-ascii?Q?vBIBTHiLbZXlJ9F3l+Ql7rBmhXrhWt1m9R7aLXxylQZkpBVbxMwJUFU5E/5M?=
 =?us-ascii?Q?k51pGd2oUMnt5O/rl6AyuCAy2aTN98mn5T14Xs7TiEiUkE4GgRaAsFk7tqwX?=
 =?us-ascii?Q?QUewgSvDYkd/hunmqEDhjBfKOcFFoWReTE/fkijI5Xm5ltqnSUMWmMPG7dhu?=
 =?us-ascii?Q?dfD3b5TMYxCLq6XzXYL6ym0vk+fmwf2T5tgPCpMDA6bWcqAVA2CrZkdMrZSM?=
 =?us-ascii?Q?hcSa5ySPp9FJwaf/oaEmze0St6ZTgx3tkgGWHDbsGuTft0wT6dyaQEo3Szfu?=
 =?us-ascii?Q?ETP+1iQV5rhJXOMOG7FfEjBpeHPP7Ac7JcpLpxnZfhwXU7GJN6rN2EYTfM73?=
 =?us-ascii?Q?0Y76Kv5JOJbJykWU3zMKDPLRhVJIwDT3HfIFYcECpqvw1fPJx7XuXb2pkGwX?=
 =?us-ascii?Q?E9nWtqRShkltDxp6hcgIo1mjIudihK7WepYz1xdDC0+6KJyfS8KXAiiUIyiI?=
 =?us-ascii?Q?AhenwITIraOzFEJD9W/TjS9RIPPSbpAeWRtYm3v4IQYnazCpo0XUjKOlkNlZ?=
 =?us-ascii?Q?y4mF2U3fmG0s1wZF9+SKVLF8WKp/+xfFcnLj2/v00jHtF1sGmYJkPQVMXVXN?=
 =?us-ascii?Q?MhPKEIc2WHjBnOkYYaWbnx2rQPSFzI8KCaZ+wzESH2xIxYtcaj9EPJ0etJBQ?=
 =?us-ascii?Q?ATTBBTek54AYL2bonM6Oof5jIxI6QwuSc++QUhycvb/3mN9y+vrk7UVdfFj+?=
 =?us-ascii?Q?666UrrXZWIwWF7gC48pPPJUnfe4bo+x31HJ772Fw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OwqLlAyyEMKWt4FWbJhKW0LPiPlm5wI5b57TvoPCbXzszMsE7oiWR5oDWg1hc9tMW1FhLGJaVT9XoxaKe9zBZsGXldb0lQqNT9kBNckkWo26YKVeOMroW4r03DfpM8vxpkZzYNURtYH+CPjdX9PCZmSkxko515RhwlB755J45o/W+z3FNuyVp4CdxngexQei6pQD5kNsdP3sZiIU5S+w+cqEnC9xNl8p0tFUVznKcYM6weQzvc1OU4niq1CSb2z/AVzQS+7yZiWuEWzMg/O1dKeYmiNAVuxHuuyr/O3mKUAYguDa5+Ny04Bb7k4HrCNODUrx5MKzTTKbDxaWPz/NvS06543h04KhyYvPwhOShXTz29nfMfFV3KKJN3nwomYUa+wvQUnhsmg8qwalZXwxqt7caa8nLCxMl/qB5yJ6e254+mXnjouBqJl4R5Pswi9Yf7owI4plQHfPVt5LKt3lKYegHI230UdxeFmTqXn/4wZR6GoRaG81HS+1HiP/x9H7y3CRdN0GVjCvbocvS6YKyWMajC2umQRs/zbP54cSR79AeQWYbLoU9fLiHbzgo8/KAD1evRwzLPpRCDZpNG8+Nhyw0nFP+T9ztsaPtYghSk4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ab472a-8da4-4eb3-33cb-08dd54ccee55
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 12:15:30.8129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +EbMuT6/EqcPM2AxOiIEhlR9nRMkbFqXxRhjghsU304/mQTJLB0AI2WiGMAvTeNw91qoXViVQB+uyi9iIO3U5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7202
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_05,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502240089
X-Proofpoint-ORIG-GUID: JJwjVRS2p9cmr5hr9RsuC5u-gBCtENJJ
X-Proofpoint-GUID: JJwjVRS2p9cmr5hr9RsuC5u-gBCtENJJ

Introduce `verify_sysfs_syntax()` and `_require_fs_sysfs_attr_policy()` to verify
whether a sysfs attribute rejects invalid input arguments during writes.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/sysfs | 142 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 common/sysfs

diff --git a/common/sysfs b/common/sysfs
new file mode 100644
index 000000000000..1362a1261dfc
--- /dev/null
+++ b/common/sysfs
@@ -0,0 +1,142 @@
+##/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2025 Oracle.  All Rights Reserved.
+#
+# Common/sysfs file for the sysfs related helper functions.
+
+# Test for the existence of a policy at /sys/fs/$FSTYP/$DEV/$ATTR
+#
+# All arguments are necessary, and in this order:
+#  - dev: device name, e.g. $SCRATCH_DEV
+#  - attr: path name under /sys/fs/$FSTYP/$dev
+#  - policy: policy within /sys/fs/$FSTYP/$dev
+#
+# Usage example:
+#   _has_fs_sysfs_attr_policy /dev/mapper/scratch-dev read_policy round-robin
+_has_fs_sysfs_attr_policy()
+{
+	local dev=$1
+	local attr=$2
+	local policy=$3
+
+	if [ ! -b "$dev" -o -z "$attr" -o -z "$policy" ]; then
+		_fail \
+	     "Usage: _has_fs_sysfs_attr_policy <mounted_device> <attr> <policy>"
+	fi
+
+	local dname=$(_fs_sysfs_dname $dev)
+	test -e /sys/fs/${FSTYP}/${dname}/${attr}
+
+	cat /sys/fs/${FSTYP}/${dname}/${attr} | grep -q ${policy}
+}
+
+# Require the existence of a sysfs entry at /sys/fs/$FSTYP/$DEV/$ATTR
+# and value in it contains $policy
+# All arguments are necessary, and in this order:
+#  - dev: device name, e.g. $SCRATCH_DEV
+#  - attr: path name under /sys/fs/$FSTYP/$dev
+#  - policy: mentioned in /sys/fs/$FSTYP/$dev/$attr
+#
+# Usage example:
+#   _require_fs_sysfs_attr_policy /dev/mapper/scratch-dev read_policy round-robin
+_require_fs_sysfs_attr_policy()
+{
+	_has_fs_sysfs_attr_policy "$@" && return
+
+	local dev=$1
+	local attr=$2
+	local policy=$3
+	local dname=$(_fs_sysfs_dname $dev)
+
+	_notrun "This test requires /sys/fs/${FSTYP}/${dname}/${attr} ${policy}"
+}
+
+set_sysfs_policy()
+{
+	local dev=$1
+	local attr=$2
+	shift
+	shift
+	local policy=$@
+
+	_set_fs_sysfs_attr $dev $attr ${policy}
+
+	case "$FSTYP" in
+	btrfs)
+		_get_fs_sysfs_attr $dev $attr | grep -q "[${policy}]"
+		if [[ $? != 0 ]]; then
+			echo "Setting sysfs $attr $policy failed"
+		fi
+		;;
+	*)
+		_fail \
+"sysfs syntax verification for '${attr}' '${policy}' for '${FSTYP}' is not implemented"
+		;;
+	esac
+}
+
+set_sysfs_policy_must_fail()
+{
+	local dev=$1
+	local attr=$2
+	shift
+	shift
+	local policy=$@
+
+	_set_fs_sysfs_attr $dev $attr ${policy} | _filter_sysfs_error \
+							   | tee -a $seqres.full
+}
+
+# Verify sysfs attribute rejects invalid input.
+# Usage syntax:
+#   verify_sysfs_syntax <$dev> <$attr> <$policy> [$value]
+# Examples:
+#   verify_sysfs_syntax $TEST_DEV read_policy pid
+#   verify_sysfs_syntax $TEST_DEV read_policy round-robin 4k
+# Note:
+#  Process must call . ./common/filter
+verify_sysfs_syntax()
+{
+	local dev=$1
+	local attr=$2
+	local policy=$3
+	local value=$4
+
+	# Do this in the test case so that we know its prerequisites.
+	# '_require_fs_sysfs_attr_policy $TEST_DEV $attr $policy'
+
+	# Test policy specified wrongly. Must fail.
+	set_sysfs_policy_must_fail $dev $attr "'$policy $policy'"
+	set_sysfs_policy_must_fail $dev $attr "'$policy t'"
+	set_sysfs_policy_must_fail $dev $attr "' '"
+	set_sysfs_policy_must_fail $dev $attr "'${policy} n'"
+	set_sysfs_policy_must_fail $dev $attr "'n ${policy}'"
+	set_sysfs_policy_must_fail $dev $attr "' ${policy}'"
+	set_sysfs_policy_must_fail $dev $attr "' ${policy} '"
+	set_sysfs_policy_must_fail $dev $attr "'${policy} '"
+	set_sysfs_policy_must_fail $dev $attr _${policy}
+	set_sysfs_policy_must_fail $dev $attr ${policy}_
+	set_sysfs_policy_must_fail $dev $attr _${policy}_
+	set_sysfs_policy_must_fail $dev $attr ${policy}:
+	# Test policy longer than 32 chars fails stable.
+	set_sysfs_policy_must_fail $dev $attr 'jfdkkkkjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjffjfjfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'
+
+	# Test policy specified correctly. Must pass.
+	set_sysfs_policy $dev $attr $policy
+
+	# If the policy has no value return
+	if [[ -z $value ]]; then
+		return
+	fi
+
+	# Test value specified wrongly. Must fail.
+	set_sysfs_policy_must_fail $dev $attr "'$policy: $value'"
+	set_sysfs_policy_must_fail $dev $attr "'$policy:$value '"
+	set_sysfs_policy_must_fail $dev $attr "'$policy:$value typo'"
+	set_sysfs_policy_must_fail $dev $attr "'$policy:${value}typo'"
+	set_sysfs_policy_must_fail $dev $attr "'$policy :$value'"
+
+	# Test policy and value all specified correctly. Must pass.
+	set_sysfs_policy $dev $attr $policy:$value
+}
+
-- 
2.43.5


