Return-Path: <linux-btrfs+bounces-5175-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E348CB2A0
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 19:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 482F91C21A27
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 17:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EED1482E7;
	Tue, 21 May 2024 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G/Ql/LJe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AeJjE8SY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A604F22F11
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716311570; cv=fail; b=pL8Ptb9otcU5/mARhofgSxche74D+89/hhpIrrRFtIz3t/lG8+r9z42UNX8eHyCYrX2dmelJWRCI7QivV/ihaijzByuT+RV/RZPMQOOUQSMS2QvzSPXLOPaAZDYQ9nCbHARFbut7JnSCIo4uReOZirI3Di6T1waNmEgTK0LXIe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716311570; c=relaxed/simple;
	bh=gkA8reKBsblPxRAWzG7WGqG8brlJoUrKFCwGpKpvwnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W9yEilnWFuL9032mxmYV2oTcrQMgqtOvAE1D8O+ShNiklAtUCI0Xj5co+LAFDLyxuesHFcWg+kctyZJnKu4ly5pfRwPU+I5CDd49VitNx4ZpPFnEHzz8VayUW28/XDyDk6kzQyKrkixOGnbEvNVX7tzU+xRw3nJSG3HEfRI8v/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G/Ql/LJe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AeJjE8SY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44LGwpEF006725
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=BlKB1IMcFGN90ZpZWinv+UCnhvl9Pa6V3Fc7lPpNtcQ=;
 b=G/Ql/LJebiza2LvgaePvp61dVFc6/m7GDbEVU+PQYoJONKi5jbrDLEz3UtPS96tMhcU9
 t24j9ofiYKO3tmk4ZzWrKtOIM0H9TsQMrt/3xRZjrLFAyMUnFX0CJVbOUQyr2M6C/Xum
 clRSUUJcEB5bU7VDjiZhPhNl6Vj2g7k8zq7FSIbGGpskCXkuovUJg4pT4Jn3pAViFP5f
 M5eNzMtGNbi2o+1HlWMfwwhwpeIZcQItd5fUjaVHImiEAo0SCNPuQDjdQviq1SIneq7P
 SGHwHpZHLp0NU7RMTVUOWkg3U7iEMk6qdwUaHrbhdACt0cSfU1hC6gkT24MP/e+FqLR/ Fg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6jrenuum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:12:47 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44LGWU66013677
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:12:46 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js7gsva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:12:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3j9IhkZlQBRZLpz5HW3Xtez1J1vWq5Snq0U8qqXoS+OhktvWB3qceFuZ5+bEcNGFLktpEgZB9Jxv85gqWTwsdFrGzBL4Wp/Paob/OjxwCGds8fZyBgsABqNyCPF6K0Lo5PqyttmZNvW/RBFXfiWvnythBN+MGep0o/ZAZVGHaseRYinkaYJRKiAVd8eK/q027vzYriGAmgsoz5UBkIyJdZjCnOrC3KKdEVwLmoYoRRYbs/VCM5tRIAiEa5K5REqUY/IueZq3+csz2KYvIdhS4gzajjli+XOC5HgmQgput59R0BHmDsiS3LJQ8oVGe4GPscINFdS3x8bLfOmyBD9Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlKB1IMcFGN90ZpZWinv+UCnhvl9Pa6V3Fc7lPpNtcQ=;
 b=aVwj4KppybmL93vD2t6Yhc+qD5BIFW63p9pyRNWh+CSpnRvR9xMfc3oohhm1rHfUqbmZ93xmaXYyifZkiUZ/Cgc0wrXezu/M3Wq8Ga+pVIrrR7nzmpbq3rpKYkfcwKSPxP2TTVYYMNwNxy2vHiDo/TqavxuAwmE0yjzgrxTb4RApAJoiCc1XgmxSAIPgqB0XANRYTZHL3l4zJ82PEmYXivQKGn37NzsxZNiAjivy1qrvW3W8hZbjWk3/hpWIawltCz/thlXMQJ9mfancQD8SxZWlFzfMKqPmfmsNalTHsyxhh4L8yZ+iHGH9yfomXW/XSupgeT6+EYRwZNlju4CHGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlKB1IMcFGN90ZpZWinv+UCnhvl9Pa6V3Fc7lPpNtcQ=;
 b=AeJjE8SYcBV0YeMuR1KHlp8ZL9TfBrki9n/YKtwplNOdqdsE0e3l4083rS+orx0qk88nKLliVl9zxSbIbJdeepMFgAmbhH4kCrHoSLHp8SZeZ3XI0AC9dgMNWu0+G6EdoFHab1zfmJoBcbuN9fxpNWoJG3JNeYQMujujDZvBU7s=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN6PR10MB7520.namprd10.prod.outlook.com (2603:10b6:208:478::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 17:12:44 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7587.028; Tue, 21 May 2024
 17:12:44 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v4 3/6] btrfs: rename ret to ret2 in btrfs_recover_relocation()
Date: Wed, 22 May 2024 01:11:09 +0800
Message-ID: <63a0893825a6c2bb6db0eedfa66992e80b35e304.1716310365.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1716310365.git.anand.jain@oracle.com>
References: <cover.1716310365.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0203.apcprd06.prod.outlook.com (2603:1096:4:1::35)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN6PR10MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: de2f87ec-e216-42f1-8e4d-08dc79b93adb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?jtl+yQPe1iZYnS536b2NxukR/cjAUc9GIqgpGqD9JBLiIOhRtPJNHqK4tIP2?=
 =?us-ascii?Q?BvdZAo5EHA6nAGAX9k7jvzf5xIUqC//QDpeIQ1q4A/TemVzMwwR4CuS8/f2s?=
 =?us-ascii?Q?QWz8JJW0BKm8S8HFC9SAESEJDn5USh5ro3d0GNfiww38dD9B5KwtAYrdTj4p?=
 =?us-ascii?Q?hIp8KxV/4kG/lG6LNhq+iPiO0aWdQjxeZMJF9zRHaapJ/Vhqus1VITtlNjgj?=
 =?us-ascii?Q?IklYrEVcbKPciT96ZTHiCJcsLVQpxBHlt21lCFSbqXVd6I1eIRj6++ahuYR8?=
 =?us-ascii?Q?QJafwhhs/O3X4UCQuUefbXnzzACsrlLxn0dqbEnVNazqor55+3oLiG6NRMds?=
 =?us-ascii?Q?vYNUXtMyJs1W6hUULbShHdNXTlZzoKX0Idz7hKUHzaaO+UnRngwgf5NYISSi?=
 =?us-ascii?Q?M7lYGGs5HJF1OZA3o0myYNSi1tQLshPvmkdYsqty+DqJYztbhYQUjr2qQJkJ?=
 =?us-ascii?Q?1y4PohzR5kdM0l3c80ysU0Zn2gpDPot4yAm1HdDlDwPs938lJf3OirEX2cXt?=
 =?us-ascii?Q?OP9/rUrEe0DtxyYKquP1PLIltA7LFNbaasj/i0SjvuME31cIP2e5wEYwMMEy?=
 =?us-ascii?Q?tN7c9AG1kxnMawuqZgn+un/1Qq3MvUeF0Z5w8oPomGZSstR6w1wWmyoNtPrz?=
 =?us-ascii?Q?EB2DX2CvBzwZvqVUZApOYz67h7jPIufORNsawMfSnj0kA7a1F1Yejqn4CEFB?=
 =?us-ascii?Q?50mEGkU7y4CYfAgRtaxFDt+AqXcocwFVknxPFwluQwusxGK5zc1IFipFrRXy?=
 =?us-ascii?Q?B+7tfikHmg6KGQAmgrvjFhyxUIITjDq6URhYRp4jlwW0qWo2csNK3ElLYERj?=
 =?us-ascii?Q?nURg4eUZttjoJZV+alKdyJO1BZ7t7chNJIUQgvr0csgPYbCoUIOIaJkURtvg?=
 =?us-ascii?Q?oCPgeqVEakTt24RWJh5oteG7enutJ8VtCjcNjZ0aoiZndqQGLL/R3daTVcZq?=
 =?us-ascii?Q?HGhTR2wk56+9+O/LHcWs+EQiX8j1iJfDppSlDREDDMkaoY9f0/0mVc6Ke5+P?=
 =?us-ascii?Q?J9crz+kLDsEZ0VQf5oGkECEJsp0AR7Kz987pXrdzPYmCPJwXrI9/6rUS1/Dt?=
 =?us-ascii?Q?eKwfUcUzuSMRZ4ixTLvwRZYaRZ4bPIx1VC/uFaTtrmfRlRqYrZXZ3SPZWULs?=
 =?us-ascii?Q?/pIDyNHZjy0byZTMXM2xkFE15hSW/r/vXs7Wqn0NiIrWC/6DsFS04N6MIiMQ?=
 =?us-ascii?Q?Ijz8APoeGcqDLBPPc8hsEY1ELdaAVKmGxgJEjEYqpwcX6ucwT8JXg5RyTacG?=
 =?us-ascii?Q?PfQJdczAgFofWEhpWV7yZbW69ei+Qnni2N26ac4bUg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?EWQja600sx5eNA2D/Ci1ANf69UfDsx7CvNSuFWJ8zBREO4Qv+aInHiqlOkdw?=
 =?us-ascii?Q?Ht0NOoEZ+SoCWv8kR4KAiCWH3aDVtwmF4RAh/jMcLqZJFHjidThS6wZyP3Q7?=
 =?us-ascii?Q?rOyeWYRf39AYeUysR5aaHu9uVqLhGk5B5Dfh/S3si3Skmt5walsG0EtDEJld?=
 =?us-ascii?Q?VfvEfA/jX5iv95NoEu+zALvbcjcE3p/et6Us3OZFG8z7E3kIJumbEggxUP8U?=
 =?us-ascii?Q?BI+TA7s9zkoDDeWZNHmjIohi6hkDNXvzTbAt8moDnyYByDd6+IAzWqLSmukJ?=
 =?us-ascii?Q?sfz7eL/0ezHuWzCjdGoG4PfSL/ou9Aa1w98hgvALu8qr+Y9EvK1kC1S4JwjJ?=
 =?us-ascii?Q?sOVYDtZKaN8BRCk6rEftubF0/QTOStUnvjNPAHlk5CIjFzTuehQOCgKSg7UR?=
 =?us-ascii?Q?rJittHGmMNnekQ+sBSYS/pR3qwHKipIjrRtprcEvATZV0YcfhPF4Uy1JWeO8?=
 =?us-ascii?Q?Qco/l/Ft0AJYMI9jXKSTIyl5CgB8jkv4CNl7jcX2Zairvb8hs6O4A7JPnYcs?=
 =?us-ascii?Q?bAO4dTyvPTjeKki2rLgbhiYvzqah3AHmqpKUtQ219f1yCj9WrxR8ykEhQqEa?=
 =?us-ascii?Q?h6HdekGjeHiwL9fNvCOppLcXIJXT2f/bfU33BRKSZRBOlDucrj4LNm5PoRY6?=
 =?us-ascii?Q?Lc1rGIq/E4T+FWDahMcUbp67gE9z786/cRuDx/vhiqPYj6r+AtmZepEviDQk?=
 =?us-ascii?Q?IjbmTMQZdpc6bjdYPOenperU1Tl3g9YrLqqQnH3M3lb/Ts2PWFQwdNZbk/Mc?=
 =?us-ascii?Q?9myzVOWweweP6JNa9nQaCmCIHzA5FO8SG2zNuEZc3j1xolO3nMEmuNP/QiK2?=
 =?us-ascii?Q?SSvwDc33vfgPXhoiI2APt6xSPCZmvMtLVgQY7hyJKb1e1kSCA7eo/3mFhujJ?=
 =?us-ascii?Q?Y0b5XT7C5jBpmQ6Wgi0nVCpYeYQtgLdMfx0RySKdcgB8Ck1i75ved17hJw3f?=
 =?us-ascii?Q?T0NSwEfUaLWVYnXky4lHZAzQR3FnGWCEuVnd6MAlB0EIP6vHsrChGs4cDC9Z?=
 =?us-ascii?Q?ZFcINPI3eSWu+uiKiy5IHSRKMv7eAZXP9oOZFURDtV0W/nqwKQke3lrc6sPR?=
 =?us-ascii?Q?sIMHS/4M73EuMIhCKDLa7+nVQSfDt4ZUqRaeAH64xA7NkMmaj1tLjCSrcvSi?=
 =?us-ascii?Q?rLbQibDHxSIVoMvht7jTSFxKadr6SPleZeuzNNu5lQaWysJkGLKs2pKosLwb?=
 =?us-ascii?Q?5noWr8MsoXkf0AKtnPggRl7E5j7GH3JlaidZEr2GpWoIVIBvfGAHcM7qwgxY?=
 =?us-ascii?Q?I3UQp77Kdav7YxonVa66N6lHTJ20vAdP+VgWDxYzGasMIDYlk/dGU7Am+qOX?=
 =?us-ascii?Q?ZiALFO9s8z24ilMFTNMqJRZiuxVYSPBhWbjczCMibroFNd718R3Ar4HQkjyX?=
 =?us-ascii?Q?qHQBRLACzwoeFkKubo20pgaQfLBLemgm8HDqockvGrCRp8xfv32nwJGCGSKO?=
 =?us-ascii?Q?fNipnUioVZD+kQ8F+M5sIdaz8JvRBxxD6xKwywScPJp30FXvR6pKAHkj8uJ6?=
 =?us-ascii?Q?fmO5ec8ww84dAgYYYoJuZ3PndLBHMzQioaPV3ELoyedbcg6olXpl37MWQzeN?=
 =?us-ascii?Q?eHPUg3Y7t4rH92YAJn0Fmg9u8V5HqMISt5LYCgDDbKq26oDYOjJwimGlfK/h?=
 =?us-ascii?Q?uQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	4Cb4UFONkPbtxG4KpgGw5TM2KVZG6cljwOFCVTBeu6kUigNsBdd3I13FyMAXvT0/wlamoHx2TTjEPyb03SsOkDGJKMsuLnSnZsJuaP/NWez0Tqq8mrqeVn2ooLL4q4Geu5OJ9ebwHWh/SUl8ijwArHO0VcEuJo6l9I7xTXIPJxtDkXOc4w+nAk4FXFB1h8dDN6SfiEKqqfny0pa3J3gRcijWgHq5M71ylMwXeCmQMT9e0cdRt4l3mmMNalmhmAymIbJPcR1+dRBVSE1TP5aBscw2ZSS0ZBK1ZJ6CIFqDjKD0iILd9P3flBN/D36lo8rNvvjB2R1NYaipc5ZL2V9Y3+j4YL7cOpLwZu5OEhxFrNlvJ1ZSQxqKslc/y0kWsFcLRxay6TSj2ED6P/aRaGGWGoGjwxX69wpcxfyhgaITn9imqTfedSM1HZ5lBvvukdegYZ+mcNTc8aBJEgeG5t/H7k9nr+RFM23aP+S7xXa8g89Ers+UWoo+TTH17sRwDZi40YK36kJwDbpav0qQzaFLsnj+FWVqBxlTCPhOMSGaf7sQr6WmXl8rsFii7qJKgjgpW2HelaNmQUGhiTh+vUxhM7T9yhCqGz9ePCDOE0fadeY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de2f87ec-e216-42f1-8e4d-08dc79b93adb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 17:12:44.4004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WasVkAY0/4TV4cq0oTVw/sJipnwE7+vAkV93SnedMuNX9wlWG1sfAVx2lA+a7W+nVaLs7hqbSSIpNZ9au2jY7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7520
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_10,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405210130
X-Proofpoint-GUID: TcT9bW8rVBbjRuZwX105TtrFHqHfloJF
X-Proofpoint-ORIG-GUID: TcT9bW8rVBbjRuZwX105TtrFHqHfloJF

A preparatory patch to rename 'err' to 'ret', but ret is already used as an
intermediary return value, so first rename 'ret' to 'ret2'.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v4: title changed
v3: new
 fs/btrfs/relocation.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d0352077f0fc..d621fdbf59f3 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4221,7 +4221,7 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 	struct extent_buffer *leaf;
 	struct reloc_control *rc = NULL;
 	struct btrfs_trans_handle *trans;
-	int ret;
+	int ret2;
 	int err = 0;
 
 	path = btrfs_alloc_path();
@@ -4356,9 +4356,9 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 	}
 	err = btrfs_commit_transaction(trans);
 out_clean:
-	ret = clean_dirty_subvols(rc);
-	if (ret < 0 && !err)
-		err = ret;
+	ret2 = clean_dirty_subvols(rc);
+	if (ret2 < 0 && !err)
+		err = ret2;
 out_unset:
 	unset_reloc_control(rc);
 out_end:
-- 
2.41.0


