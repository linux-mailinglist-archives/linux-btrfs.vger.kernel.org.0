Return-Path: <linux-btrfs+bounces-14038-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47135AB891B
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 16:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A55574E08E3
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 14:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B261F3FDC;
	Thu, 15 May 2025 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V7mZAmnS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pR/lvebT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246F01F0E47
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747318637; cv=fail; b=b+o0//ox1o+X+I5AKaA53ME3Iy/V7HtjBjc8kTZBUSZnH25Fr1YweQcoWWvBlCJDArnWuJl233mZ1sX2TPTpeqW/XSgXmnlsLNyVIOVVORaGBcLf4IO1uSEjt3lWdrz5lFeG2/0orkivEDWxMoUEyqeAmnEmARiu19gESuJnCk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747318637; c=relaxed/simple;
	bh=g+lJHFCkQW3UBi9jHEB1FMpmZmntxklH3emu6dZZzio=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=t+i4IB9CYH6E1JHS/+UHGt2Tuqnz1AbBLakVcmATUg1jGNSqQLg2eWiMBtvd+B+I1BDFBorAACUSKyPpdroySA9VUg1jBrCIt62KqPuGkMKIqZNz3NPi5fpjbsWGroGr9NZyh4AsQFP7BjpBSVlCOEWqL48LFF8bKZ0ukcUv3bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V7mZAmnS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pR/lvebT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F7Bkjo031824
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 14:17:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=7wG0LeGzLbN2SGKT
	2T65CJCkgQ41KanA8Et/xzhNYzM=; b=V7mZAmnSqDUIUWILGQMAMRefNEy/fKzX
	k2dLIiaOEqoehVq9eid1RrTS90vGvCBP7+jLEQmHCJo2Hsb2PUHgd3pUbS7UfZCz
	bsD7VqEyvByDXlb4zHE2x2/Ovkr9kd+1koz7fm1srSIoV7jJ+9AA1BqmxtTaK0mc
	GRV1fFiWt3ZvWWCePkgn3NNQmSf4ySFnHgdXDM6UXtBeAQPQoYVGI4J1fvZYkPwO
	um2wh/5uiq4fldjSH+ncOv2I+2PEsBoV9GLaXN9M9BPQJ/K0W/ABIrgrBvc+AKYi
	oxLD5x6bMacEruXgc1Q2uWJDVL0/Nx+1EpMF6GsPZ0cPjUvRGQVhwA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbccv9xv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 14:17:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54FDbkn8027134
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 14:17:11 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazlp17012013.outbound.protection.outlook.com [40.93.14.13])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mbt9cw7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 14:17:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLjRp/Lv2aeanPdmF0fHiSEGiXNIAl+kgoLBa08Pju6u+yOFh3i5azRDVqQxRrawy8y6X3iE7k3CPK4+Hfa0dM6+MoRt03lKL6icC0Z/AN2YcxeuZQDiqBymtmfoxpdHw/Nr1Ao1l7cKsq6icjm87a/k/iFLes3zfdABlFi0VMhmEUOp1hjSXzliNCq2TAUWwRW/CBqDroCVVcsK0UQfxak4d9j7JYinD0nlRDuJwwfhNyGLUYW9c8RFryxd9hYEq1sEjI1aAWKsoVjSCa3S+OBwTwUtytCFXmUGszHfsrVPhomY9VSO6ZVYx77DwiuWBkGXSH1rOIjMDp7JIZuxPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wG0LeGzLbN2SGKT2T65CJCkgQ41KanA8Et/xzhNYzM=;
 b=n62Dz2HxUdDNf++u0r6SjM+9cDCGecuurrX6DNZ0J6Jb0GygSdKTypIcsf65tSDmToL4A/jldUrPremb8tZNpKHVbhmIJCpu5xm3N4QRylWtxxHzTan0gq4B1ohT9nkqdxfaaN774TB9HLYAkH3hbmHMTWL1EZ5jf+66SOR4NXeixTxD2z8os9jW1WWD8C/8d9OIv/qkBjevi9myPf37FBgMCK3WRgKF1v5hpa9Msu/pyOPKVQjDhiUoxUZf1/1reWvXaTT/JvLxf3U3WNlmxd/4Mg+1TyX5VL6K3JHyzEZX3BKBWE8iWwnZB+Mj/g9zuK93DRDuTyzCugEN7HNWeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wG0LeGzLbN2SGKT2T65CJCkgQ41KanA8Et/xzhNYzM=;
 b=pR/lvebTnD3JqYCSlQPx4noeRvwN3C+utxDK/n5T/gsm26WLgf9364N3OBAniNaOxAR/DN32Wkq7qVKI411RiKOSQXs4i+dwfm6+z6l8kb7CQ/0VNO2eoM0mXAt6NyM3Fg2JJ1SyP+nYiqQB2l98MpiCds8ZjV4j0EuG571M/Rk=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by DM3PPF59D9BB966.namprd10.prod.outlook.com (2603:10b6:f:fc00::c29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 14:17:03 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 14:17:03 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: mkfs: use path_canonicalize for input device
Date: Thu, 15 May 2025 22:16:49 +0800
Message-ID: <0d9762cf51f6e0e92ac56f02f44836d98af957d5.1747318570.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0135.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::15) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|DM3PPF59D9BB966:EE_
X-MS-Office365-Filtering-Correlation-Id: f671e1de-ab87-46ab-33de-08dd93bb2a57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G4QYga1Iw4A4N0X+QYF5g7dBSyEZDEYAccadOqWRnnaHBp7cmrpAkwyMefGw?=
 =?us-ascii?Q?KqZM170577Oc2tgTRQkV9AY519edpxMvmrAQLmiwBgCFxBzuKPgeka4vG9gQ?=
 =?us-ascii?Q?+7ZcWks/CzGKJxzWLfMW0qbZaMY4QoTwGR4XD5VumVv4Qg+cTDFejeFW6QkX?=
 =?us-ascii?Q?yWQCH9d4a2mHyMhAkBukdza3pHjgkhTTMreHs84FjCai57xhN+CPRc+61f+O?=
 =?us-ascii?Q?qv4tEMgkKPCnF6U9/lcldbP2u3ZtkIMU9nW7nDlgMEB+AT4AYSCN2jo4Dujr?=
 =?us-ascii?Q?jbZNg9/D175ZaJXY+ZH1Ye6xpy2xKtiDJOP+Vhs6yIM6OLyaHlATv8tzHfQ/?=
 =?us-ascii?Q?8g82HA9/GMQIcsdhbLQu03WlAa/NIQ3uuv3BwvyZQK8Xkubq0QIKfNVzXC51?=
 =?us-ascii?Q?7lA6WHxtHG+fjwNwY4SCbEHvoIyOcNURIlxooaYZg6wne4EQZweNAcgfO6uH?=
 =?us-ascii?Q?e1Go9vEaWtVfcp1OonAkvc9EOy8eAzCsxH0Lfhuuic5q5bclD42tXVTcXZzG?=
 =?us-ascii?Q?7FN5ZWgODP2oklpNu2vTGTNqm8ii2MIWwgrAzlO4RNNhKpMQ3QlVmrkDfX0E?=
 =?us-ascii?Q?hNJ90orwTSrZrafLfvxza4YPwKSgBVVISVoONeCsMwjh7HZbb9QfkOE43r61?=
 =?us-ascii?Q?L79YoP2DnFfzMo0dfcqsOI0GvA944GumcksxsX/o1M7VPUD1O/VSUksq6sWB?=
 =?us-ascii?Q?K25vc6K4ut+WiTyfBI5fMQBYytp9P4Ny6rK9NtZggpMXerJyRaXtb0tCErr9?=
 =?us-ascii?Q?phyI95CB7fwQDl4oHOKLEhEy5NUy2Lc3PGf54CgG+3ELj5HGYuLRG8lO/9oV?=
 =?us-ascii?Q?oNvBphDnfnQLBXp7TQKg0mHvMcRefX5gMIiUotGCpbScsTTw4zmn3ez7dJdr?=
 =?us-ascii?Q?2Oq8qG/gYhBQs9hf6ZKKkPNglFaJkY+iBMc8AUCaWahaUkQ+VTq5aGjSmPEz?=
 =?us-ascii?Q?y7Y8TDgjshV9JkkTpu3K4GxCbfAW6Iw60s+X97lAJv5rnBPtKvPqOJws36mx?=
 =?us-ascii?Q?qoUSEeUzCR8i/sGbFT45ujsCyLVZmc+GNxzVk1gVqJpn8eZwPQbn2tHrcAAg?=
 =?us-ascii?Q?1uF9nzohpAFwBOvvh3JKpIkKUOR+UXOJWRSoJQll5dkKjGxzukDmcqKb4iI2?=
 =?us-ascii?Q?vFeqQzgmz/FEDLVUEnj8Dn71RJIlgvtdzTzMxuXEeGfXM89Zt+aT8b0R9muZ?=
 =?us-ascii?Q?8YDqR+1JXm8ZUYVMZepbrWDJxyI+c4iQj4vcjGA+kfbno49YDpGurSL0zRR9?=
 =?us-ascii?Q?ELrYllLaaXnzycV1s4U8GT0JveoKl1sNp5T0grgN3PsDORwa7ZMZhhcxUzGm?=
 =?us-ascii?Q?ez71u1d3u53tbAgxTPYyaWUA/Y+P89Q+YI8zReVI5AtG+WVT5N61Gf5eG5WA?=
 =?us-ascii?Q?9SSNsftzHG2nPQfWZpvU/82ts1sTz3B5Yfruc7bOexiaJXOHLQvcgJxE5Vmg?=
 =?us-ascii?Q?aRShwf+ZAsU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c6oxjkgqrOOiaaL0T0DBGLRQ6ngbcPFrRzQeRGG25j2kdsXKnOAuripMj0lR?=
 =?us-ascii?Q?5goatxYKo2dOkqkDtaDAFdGVcQoRwQxVIApgSwaaYuNYL6QHnNn3Mu3rV30f?=
 =?us-ascii?Q?1AsQo/LOo7KduUEz8IdmflVP2fC9aUdgwoGK9xdsBQaM4qq/65U5p2QtLAxx?=
 =?us-ascii?Q?LFeV2eqX7wl2l8qmT6OwipC147N8zl15etmXHoPrUu8TfGWqE8Bwov+SMorb?=
 =?us-ascii?Q?VBe6bTHXJB144fELBEZmx8oP0hDnrWgwYdspfIHsfh4A/bqDKYUZzl+hcOxa?=
 =?us-ascii?Q?88QmMIhlUv3Cbj2DaJPQT3oPVvrt7WN3EJRSjw1Xiu2/rkJdXOER2VhRtpzp?=
 =?us-ascii?Q?2jG8Lx4gH+FXJPLnyJnqcae2sWS9HDMBZXyokQUwgLO1qb3KswdC3bxL8Y0u?=
 =?us-ascii?Q?XvJjVftXRkSyjuOA8Z4WF3oKu1xNz5/eMCQOFMCTC7n0bfkeXh7ykBIcxneC?=
 =?us-ascii?Q?+DBRtiku+8HZgUQlAc3lPR/Cr9DgBbwL+6vbjkMJRTzb0pVyxsC4nUmpXy6A?=
 =?us-ascii?Q?EsT1FybK18KwTQaIxtRCpDTbOPzwVDjlZu+kxGkDjmWNsemSGtx96/tOteVV?=
 =?us-ascii?Q?FhteHlhZavO1wro4UkQ9v7vHci4A9W/6fdKzJEv2GevqEd2KunUId4kZZMIl?=
 =?us-ascii?Q?Uv6Hm6EO8keHzXlmPnxiYLSBcgKBmy3F6k/pqp4vznoP3vfKZ2mDzllRElJ8?=
 =?us-ascii?Q?qFMNTr3D7scGxIm+Y0a7SrnbyHDnh3IryXnqfoyDsyaehsyL0WoB9Gfg7hoM?=
 =?us-ascii?Q?jsiQ36tOQdXO9pinjIH81Kwc6/Om0Zguh8HxbUqurB4bZ8ekM7K1Y00aSCgU?=
 =?us-ascii?Q?70wU6BqAxT/rULYB3sxmU5Z1sv41EP8lYjBQiPHbBM0wv1EEVFsqjHDFKFJQ?=
 =?us-ascii?Q?OzWQt1jeIHcIQUamIDyLks12vlF8/a9Mp+Ra1NV/2jRdrc7uUHmYCIPLq8i7?=
 =?us-ascii?Q?ZiVgF35s/1BsjMiQGpcYGu7CpVnv5nVWtdrCuIifGAQCvwBIXegW6esR9uiF?=
 =?us-ascii?Q?oU4JL/sLeb57rqjvBX2lgPY7gtM7B8imEpEugCiaeC3HQvAwFnEToH9in+wT?=
 =?us-ascii?Q?jZWQYzyC8wydQvy/btKByYjMY/nIp4FEqLHjUUIy/jma6+Odoqz3bAcrYU75?=
 =?us-ascii?Q?v1GvNF92AViMOIf24VRIw3RQRNBEk+8SL1PFdmaMTcr+T3esIty97NB0sXAV?=
 =?us-ascii?Q?pJOKCTcs33LgsuS0Jxu4Q4lp/Xj5CIrbYAmdqsvyboL/kiANzjJSp3dhgs01?=
 =?us-ascii?Q?0eiJyp3nXq/Q8FCUVKddPhBxfaKyps1ckN9CTyVjEF3W2MGq0j4GRJpwQefq?=
 =?us-ascii?Q?vCOFadQ2P3KvTNR7YIH1dim/bdAAp39xvOeTHSTcxgdtGpa1NlFOXup/yLUI?=
 =?us-ascii?Q?CJ+xdiwAFy9TVEMSzdzBHE0Kqzk903oaeMVj79U409rf3yDUBGMyCOxxaiR5?=
 =?us-ascii?Q?V3lZBJXt4tKZRlBL0NbsT1dkEUv6HA0WH7Hnqi8H+pJ2MG4his33bhdEz4Ye?=
 =?us-ascii?Q?If5JwPl0fBvM7MfjKX2AhQsH81oUix6bz3zUQYP5MuJOj0qnAxMj9lE1TuoD?=
 =?us-ascii?Q?NbzM74P+V5No3sX+ycA4BUUPrh03beu0wCENivpV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	k3s1ld80mtC+mE9getnD3mBMH1coUkh25pFI8IeJuDPbeaIRlo7LBMqAD8YLmMdQ/rhkCtC3kaCGPk2hSILqcfObq/5PRAmPAlEG1HIGkT+6fqciXi7sceszqHIGq4xDGgLytCMrhP3fP/EIS8ymkicXR1XYty75GzbfaOLfyKi1d5qmjLytWVCd55OrufWRn0uJfrtYxJvYdHnLdmLwgUj/c0VdJcueyHgDr/1T4JhFLPOLGotT9Fi7olFm7Y8YGtfn35nonzrnOoNK/Xcv3VBM5fM5HX909LJdJV5ucYK3n4gGQFmhhSpWJBXZBckqkLRDs4p5aX2WQWrVtlArNRr+2AxFaxPJOEbrYTRcTjbDCone2zWVBAyn1sQCTRLCFn3XeRuSR/F/kSdiTJrVrjKxBKXurYzTAYoWwtJSKQZngfS3d8C+FfPPrH2WietZQ92UUMkcl4WTgbpCYwl5htdJ1SqeZKUpjxqpYqgLgQjfy7cmSKjxsK5p4O+1UUiPjOe1ygWGk0OE87OX/pxslsDDNrNpHW5f3ghrqyv/aGBkqgZ4cpqIc7erxon+pgUOM2V99lH+oJV3oMxyu7tVQ3jnQWNkp2yXIsFCOCsPUd0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f671e1de-ab87-46ab-33de-08dd93bb2a57
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 14:17:03.6990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IMo/5cri8TOMo7cTZYqjGnH5fL9So9LzA/BqVi79v6Gw5fnHXSfBKHTbmcoGv026rvDbszymcntAsRaDZfL+ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF59D9BB966
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-14_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505150140
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE0MSBTYWx0ZWRfX7UMneoyXM2Kq BI8X/6tr1y5V9z2eUkrcj8ZQkBXQD26/92ypF1d7hBMJ/fv6HkTgDNCMKIPwZD8WMZc0JuQn+9v /wBWMo4pMvC4ESwtjbRPfoDKeHbXethSqVAZS1gwRSpp1l+dP7VjXecNdvp+w8JtAWNR31GFNGE
 KkQfQLa/B6cMYAO85JHuvao2Iysvy9omjc4RAw7vmobr+ILJczm6p01O4Z1rWq7R21xY9Vy+TD9 pPudNuyrGeFQbqdNXaQFdhKu44SKx7qHhPxqD7f+yMUe2fIXlaQ/bbPwZaG8xGPiKEUDLGGNDPt KiTBNsPLOXOa0CR/XTDeyVCom+mnu8dr6x3efKMpmG7/WmOhB5W6Qr870Ra7lAyrZE/JwIwUtv/
 sfscpyEU6t0fBgnU1g2DPeBL8+njGafLgulV9EJcH+2uO8UpfFg2VVyBkQuUdpR57Xn235K2
X-Authority-Analysis: v=2.4 cv=Y+b4sgeN c=1 sm=1 tr=0 ts=6825f768 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=G6PXBjtspgRVGVxGeRcA:9 cc=ntf awl=host:14694
X-Proofpoint-GUID: S3pfQcEPDICLNEs400tPaHdhicsL3QLU
X-Proofpoint-ORIG-GUID: S3pfQcEPDICLNEs400tPaHdhicsL3QLU

Canonicalize the input device's path before using it.
So that we show the device path that matches with the /proc/fs/

Before:
  $ mkfs.btrfs -fq /dev/vg_fstests/lv1 /dev/sdb > /dev/null

  $ blkid --uuid c3bf2107-292d-4c7f-a288-0fa922ebd71a
  /dev/mapper/vg_fstests-lv1

  $ mount --verbose /dev/vg_fstests/lv1 /mnt/scratch
  mount: /dev/mapper/vg_fstests-lv1 mounted on /mnt/scratch.

  $ cat /proc/self/mounts | grep scratch
  /dev/vg_fstests/lv1 /mnt/scratch btrfs rw,relatime,space_cache=v2,subvolid=5,subvol=/ 0 0

After:
  $ mkfs.btrfs -fq /dev/vg_fstests/lv1 /dev/sdb > /dev/null

  $ blkid --uuid c774b4a6-3ad2-4b15-834a-894dfc898aa9
  /dev/mapper/vg_fstests-lv1

  $ mount --verbose /dev/vg_fstests/lv1 /mnt/scratch
  mount: /dev/mapper/vg_fstests-lv1 mounted on /mnt/scratch.

  $ cat /proc/self/mounts | grep scratch
  /dev/mapper/vg_fstests-lv1 /mnt/scratch btrfs rw,relatime,space_cache=v2,subvolid=5,subvol=/ 0 0

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Link: https://lore.kernel.org/linux-btrfs/5f401c48-29f5-403e-8c39-50188028ad00@oracle.com/
---
 mkfs/main.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 4c2ce98c784c..e6466d88313a 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1537,7 +1537,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	}
 
 	for (i = 0; i < device_count; i++) {
-		file = argv[optind++];
+		file = path_canonicalize(argv[optind++]);
 
 		if (source_dir && path_exists(file) == 0)
 			ret = 0;
@@ -1553,7 +1553,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	optind = saved_optind;
 	device_count = argc - optind;
 
-	file = argv[optind++];
+	file = path_canonicalize(argv[optind++]);
 	ssd = device_get_rotational(file);
 	if (opt_zoned) {
 		if (!zone_size(file)) {
@@ -1752,7 +1752,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	for (i = saved_optind; i < saved_optind + device_count; i++) {
 		char *path;
 
-		path = argv[i];
+		path = path_canonicalize(argv[i]);
 		ret = test_minimum_size(path, min_dev_size);
 		if (ret < 0) {
 			error("failed to check size for %s: %m", path);
@@ -1816,7 +1816,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	opt_oflags = O_RDWR;
 	for (i = 0; i < device_count; i++) {
 		if (opt_zoned &&
-		    zoned_model(argv[optind + i - 1]) == ZONED_HOST_MANAGED) {
+		    zoned_model(path_canonicalize(argv[optind + i - 1])) ==
+							ZONED_HOST_MANAGED) {
 			opt_oflags |= O_DIRECT;
 			break;
 		}
@@ -1824,7 +1825,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 
 	/* Start threads */
 	for (i = 0; i < device_count; i++) {
-		prepare_ctx[i].file = argv[optind + i - 1];
+		prepare_ctx[i].file = path_canonicalize(argv[optind + i - 1]);
 		prepare_ctx[i].byte_count = byte_count;
 		prepare_ctx[i].dev_byte_count = byte_count;
 		ret = pthread_create(&t_prepare[i], NULL, prepare_one_device,
@@ -2198,7 +2199,7 @@ out:
 		optind = saved_optind;
 		device_count = argc - optind;
 		while (device_count-- > 0) {
-			file = argv[optind++];
+			file = path_canonicalize(argv[optind++]);
 			if (path_is_block_device(file) == 1)
 				btrfs_register_one_device(file);
 		}
-- 
2.49.0


