Return-Path: <linux-btrfs+bounces-10799-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4E0A066C7
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 22:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C41F167DB8
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 21:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C71204088;
	Wed,  8 Jan 2025 21:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dkpT37G2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y9vuujfV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6964A1AA1EE
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Jan 2025 21:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736370128; cv=fail; b=FZFbUmX+FLO/7Mp5wDoVsAb5skLQSUyEvob2OkYIU1RmfujZ8JYT+GdWlv8n72Sje7Ygu8rPWJf9kKGaWtRebKx91gX6n4weEzYNWOvTVKF5wbOiZWz4vX0LuCtcjWDqnRA9+AIchPURtkBJ/ZiH+LFJHuoOPtOlbvv7ZhkecSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736370128; c=relaxed/simple;
	bh=V0vzns1PWj+awoiTh2xa7+1knOUk3ZYolKoaACz2B60=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UcZD6qGYUuMOjXFm84UUJVAkMSrz4jQPF/Ty1v/cNV7gxQ9ls9wce0Ki1EhUjKB03b4JzIf1r9CYNFmBE+usNH8i2eWZtfCLeqcjzvTdXWsds2kHLONJBg7mfoQ/klQCb/lnNetESoNhKXw/xCJKVdRdd/Gy0CW9I80mHfqAvBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dkpT37G2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y9vuujfV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508IMrs4015048;
	Wed, 8 Jan 2025 21:02:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ZsVUV2hahfYQ4vRhh2bNjDFUCN+74sGIYirXSVB4QOY=; b=
	dkpT37G2Qaq7bLyOdBgNpv/WlaYEB68rVhthYFvMwA/A+mQJDCtqSekQjRNKECc/
	cpDBbJaTncrEojF6kQ8EipmSByPbydNG24wUyxT/1n5vfuf0o1tp8cYc2eWwOMKo
	RvgYVYZkRjLLKzkO8R8MasG83vFly45TzSOMmtoGRzbK3hHli2B7nk4/R/+Yd2+d
	3SDpvsTf6VdH3e+GYKzRiO3xKWGLs9Za7QzmhA4YEt+bGiFa93p/8mcFV6j60Fuu
	ttsZrXrz4JwyU7YfgT+RUj+VaN8e8u+j1c5/bD6yzQSdCub/Oicn4r1GOhuKj1ZJ
	NlyvPSudPw1frPLXy2x9/Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xus2fsnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 21:02:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 508KIFcG010284;
	Wed, 8 Jan 2025 21:02:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xuea37fv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 21:02:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3d9wuGM1uPC6EexX+Zb5oSLltMTZBhNV9hwlyVpt313ObaN1iC3Lpw/TwNs3TS8nA2RhTwH8w3bx9D/WMb5xLUSE4iJ4SkIalDQISkLYV39dAho/BbDpax4/swbWee6k50+mbkAiIbovL7rlHI3hRWQ8ufERdAmNEgS8rUA6BVGscDi5T9tvRTiZ77A1MVK5rgn8bWEhcCbec+vxnXXia7SfQoDuwTHQrkjlTJApKSHEum2QqpXn6VFliSLs95rJtkHvgnkIWwIJ4RqymDaSSWcvhK+4bY/RwqmZJuLjJsHaHgqPsBG2FYhvMqbDT7//8u7ijG82DqpVMRfY7CmJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsVUV2hahfYQ4vRhh2bNjDFUCN+74sGIYirXSVB4QOY=;
 b=CBtO3XLWpkCqZXfq9B8Ur0UD7AVdvoDJSFJJIo52c2ldgk9s1G7AMg8YEzCWUvekD4CLEsn8NeEdeO0G3UO9h4SghzRKQf+ZwjBkudpq+8keXiAMDHxzg+9jmwmf1UI6McA026wzq96S6ObN602Jqyw7eGLJZ3uLiYaWOrC9NY9TbOGtRP+BR+pL/ydGUTWWBBL5BxRgx94C22XnN3f81580emO0BiNcxIgMmWy3fTBhhna+VZte2MSmuUivrfpje3QAvZmO/yYkwN69EoCNlegK48xC8gitfzOpEs+fsdCA3wmRV9Tj1c6sr+ZynYVt/za2mGi3qp3j2qmddBECfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsVUV2hahfYQ4vRhh2bNjDFUCN+74sGIYirXSVB4QOY=;
 b=y9vuujfVtJbw5P0JxLyuifLWxgT/qKEcdJz0+VsjyAtkd5BGJNJmY/Nf8eXzXTCx3nQEceZL3kjaxF82MwDUAd/HQHAtpU4W4NDB0pPTKd0KKrcFe6a3BWLwbNpt2bGrcKzhsy0xpqbTzgUBVZIrtFruZhYK2JgbBn0llFXwQ30=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BY5PR10MB4131.namprd10.prod.outlook.com (2603:10b6:a03:206::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 21:02:01 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 21:02:01 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: [PATCH 1/2] fixup: btrfs: add tracking of read blocks for read policy
Date: Thu,  9 Jan 2025 05:01:35 +0800
Message-ID: <1a227a5a8c9ef60ee1fa55aba8f9a55317b80d23.1736369474.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1736369474.git.anand.jain@oracle.com>
References: <cover.1736369474.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXP287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::24) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BY5PR10MB4131:EE_
X-MS-Office365-Filtering-Correlation-Id: cb702828-ed22-406d-8a66-08dd3027b25d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/Biz36hvVrg6GeS/z9Ez18OSLxYV5Q6hG90IO+ht5ucFKi4qC7qmskVCRd8s?=
 =?us-ascii?Q?pcLGDIpsvFuQW/euirN+cz+2WkC5MdB24juL2eoytZk1yoY7zTRXsS4pK1SM?=
 =?us-ascii?Q?OgrJxGxKBMSkuJkttON0uBzJuo01vW/u9Yg7cDhunqEY/42Xp3A+hqgqiQS3?=
 =?us-ascii?Q?RzZN1g0edC9iUNmoIVtXOTkoBs8xleUG/t4tEaiYq6rvw4SFhDoFxCRh3kax?=
 =?us-ascii?Q?Hlm0rNiRsWsS+Kwug7M3h04DxEULyWPOIpw9GBz1DWhQCYd5uT9AiYwcog4Q?=
 =?us-ascii?Q?Dg5JwKm8Kf5ZuzHzkSmt/fgQqDLILLH0aywUXLFt9PSbJPLaMPE6CnxnXiU8?=
 =?us-ascii?Q?hC+7SV0T08E4r9ks9cBohh1M7JZ/sUR385kdyp6lciZYN5rw2YFK4CePuGmg?=
 =?us-ascii?Q?5QDZ4kM3xc5JHKxb/I7hanfkxwRd1ZvLeTRs8rFSbFRX5BiR67Wob58+pAgE?=
 =?us-ascii?Q?B3PphrXqHOb13ad9pjxxpa9HEXDs9ECaTjQPY9dY0WPUcLUoqHvXmb5IRJQZ?=
 =?us-ascii?Q?a8e0F8tKXZP4168mnjiiF6a6bFXbgg9iAZU5sA2a74vPS27UQWfbcg9Beu02?=
 =?us-ascii?Q?YuugLZi8WtRZNVeSFZH0s4wvZqPYoQU8YQcQdZ94KLuqcwl5wjxz7ymqTz/S?=
 =?us-ascii?Q?EXCf/6CCA9wM72O1UvwKtYTtPcIWXnBPFv14BWQ4uGs3C4r7jGbsgnsFbpGx?=
 =?us-ascii?Q?iCKcC5gmc3yGwYyJsLGifZ4PRyJ0xsoScmyVyeLvtiGju9f6bbbDfhMbeJ2k?=
 =?us-ascii?Q?cTkttv41JmWv4goeGKWWLDKgUYjns5JLxsLwObx3+D1jR8cf8NoAoX7/hts3?=
 =?us-ascii?Q?NMDJlwvT2Ianvf50AZv7XdE9v199ceywCW+xRHhN3N65+oLGW3lh4+sqjmeB?=
 =?us-ascii?Q?LK19UHL/6CDc+NndIm8ymk3tzAj5Rh4mvwRE/Bz9bK8DFYsLFAPfF9C2h6GT?=
 =?us-ascii?Q?ga/Qm3V9p2sjvEE4Xlgw6+g8J0XCrDmD3bfmkQE1P6S7PKxuHHMdOYALRj89?=
 =?us-ascii?Q?7zJ+rWJX7RQ/IGF/eroooOOqacLXOYUx+L9tkFmmIp/0i0/GzFf4QhYZVsY+?=
 =?us-ascii?Q?/6FjTVgORSS4tEnVWU7n34Z/gxNZyxX0sS3ut3y3wXmQMGct6tKUShA0mLz8?=
 =?us-ascii?Q?er8WfJU64Oa//8jNU+yK6nLQVmm3HiCCM6XjpcMO9B0gsN3z2FKUP/Ltq9aV?=
 =?us-ascii?Q?XvJrZrkxybQJ0dBN7J3y9Y8lNjte4Q3zF4y5yDBRyOoAOYt0OCxd7/Gza231?=
 =?us-ascii?Q?dkWYb+iSXp0vK9lhIlsZa6bx6QNWiQN0yDs1DMK4/PXLm0qxS+zliqcPA38d?=
 =?us-ascii?Q?I3ogaEoYXRn5fMJUPrUcjNiBbYjxd9zWcf/eSKmJe/q8bA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TW5vTiI6zMLxUERCUlhT7jqrFTMTnAY0f+cVeIRDw//KwP3jzwxSf9PnknD2?=
 =?us-ascii?Q?WoU9eI1aqeiXYZr/2ghx+cpL53VZ8B3X9j24eOnOpOOHYI643vNuidD3Vw8+?=
 =?us-ascii?Q?b2IGZkWuKP55EORWLYUKLy16h0ocIkewrWULBVYByLzp51r1Jth1Bw+ItTjN?=
 =?us-ascii?Q?PrkxeY73lJkAUaoFtNSzOvOlIUPaPpSCQZ0l0VaEdWh+4rCvVEko88FEPsdZ?=
 =?us-ascii?Q?P7c/nHgUMN/AKbYd6rRFdxIbMdv8qLGeMPLMPNshfkywqW3aZ6U6LPI751Zs?=
 =?us-ascii?Q?ad3ksV8osegu7jga5Q1EX8EEad2Z2hiRianT8hnYPCDvWlwPZYeXnJab6WzR?=
 =?us-ascii?Q?+0FA0u/jG+Kq0jCgSfDa4lLE+WbHdGekICoWv4oG2z1jCOmYMC56pJon4/8J?=
 =?us-ascii?Q?FUorwWADhvQ/ErFIl4F1m2C8ZEc2QHUpHukSWJL+bX/eKgqtF/bE8NsY52f9?=
 =?us-ascii?Q?1/FMaugIel4lE2PfivNnOXaya71/Oz6dbuB8TfUDQPCMS0HspDTHw7FWP8y3?=
 =?us-ascii?Q?eCHEykoG7AMRcFAcCNTTbfKQRPDGX5zj+mUQbw88T7Nc8TNn9RGOIrisUhEC?=
 =?us-ascii?Q?VyC3z7PAIhr1p1CPGhTxm9mCga/IqlZD+Ju/0ak+n8Iio/DyAhuvTCKrIGDm?=
 =?us-ascii?Q?0/aplmGviY2vwsps8RkL9kcIQ7mI+AhhzEAIGEU3mjtgynE9sahDUFp7h8o3?=
 =?us-ascii?Q?JIu56WFW3oQNrG114omyvZJpBnOeU0CW8AgHhyNgc7Ep/1bIHhPamcxpKhGc?=
 =?us-ascii?Q?/pgkMiQTHcXBfV4G5QnuaBwkr2mZNbLMDuwk+EbIUWqWEKJujqSXt0B97V3z?=
 =?us-ascii?Q?/GcxcP61mtgiTIgLwe3lFke28iLklpNRRLbdmxdsym2RDf1zagzuYMjGdQzW?=
 =?us-ascii?Q?KSnPUq9+7MWsMp1sQVc6WRtKHzSIirmpmpCDbcEh79tZe0mG44HdTz/HV1zR?=
 =?us-ascii?Q?Kig3JjCdKPbfhPorxviUWVpbiexN13fJCE7RnFvAyOPDDfBLPeNKPgUPQ1LM?=
 =?us-ascii?Q?6rRy6V26Du/jV+B/2mDICOkGHorxqtN8TyGSdhJ4Zb3cslBcxAL1CiE1Acs3?=
 =?us-ascii?Q?I+fKegDQmTamWOSb6QYKNBGkmR4cnYfSxqJzDYXOJsuqxeHXKOzeiQgy5Pg5?=
 =?us-ascii?Q?FZ6O+JQkfrQuVM0B/rH9TLdxihkQ8GfpJhOu9yxrifrBsn2QO81ZtA8E3r5i?=
 =?us-ascii?Q?UE5+3UITyoFJ8HrqIOy2b4ts5CyKJ5+f8rN6NHudzck4xzkDGtxIKtIhWRFe?=
 =?us-ascii?Q?LBjGZ1BoeYXNH3nGFmZnU+lIh5oCX7t/Sy3VneC+4WUyW9ktM06EqRid6GIU?=
 =?us-ascii?Q?/WkCmGisSBWms2iXBxeMGaeCBIPUKcQdrsnE+AAimaThWDap5XcQ55rfVKYi?=
 =?us-ascii?Q?eycIyPHKKgG2MmO+iJ4+0Fy7GvKQVea+WV6x6Y502mD+17H4mcq3Jldplsr3?=
 =?us-ascii?Q?xefu99cu5+WQsZgMnXEsFkOLoLWRsPnhiDTJIj2nT5cJAdb141VMB4Bj6i8M?=
 =?us-ascii?Q?ZIdZW0Gctq9BOXnqgsHk6/K/cGXraGPgnQyOLqz4lOkm4R/ksG2Kb81Chmce?=
 =?us-ascii?Q?dzh9B/ZDlkWjCl/G2Uy4Q9jPGp1gFUtfQhhqHroE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	58Oq+E0LwFS/aSBhINzBw7Sn4UHJb/r06EM57rNirBARtBeQ/KpET9vsvkTOvbt8fge8Mt7sC7AmxWCAMFqe3eN6P2E9u6i/5RXnozkXEc+Xj2Fol4PtnKqgKYCgGk0rt7ZW+UBHL5Ows1icHU8Xefat7D+ucNOK30/DY3dPAhUBEGNvYZ47f+9IbYovaEHAfJU4oIG/0pqw2qJlUp1PyH3zYghth6T6bqGMcsYq7CmTvRxV6stsVLpO7gZOZWQzlpf2sWGQK8FRlF+SeXHSUsuFv2qBoNClBZupgG8EDTw3FUx1dRArla0iVwvU4wB7JAPC3ZuCON36+tb+IbQDquQmqJ8hqXyZOBLPE+Ozg6u3vgFu8J441CqVIs5zIhq8EmwjKWWlW8xPyLVDbFUxivAVdd9UHzgwUUM/VKzFsUEltrPBBe4UAkom/eYC3ixyvSLigwqNBTCBff9Gae8voYErz5sxZjDDB/JWXRuAXsTfyAd6kpOyxyEkWXcf4GBlyWQn+SXDunkqt5Pl4CMC/P02SCbEyOC9S5nxWqdrrHVumTRnLGEBRxEaU+r2e5xOYuaGH5DMx7KgYExeUzphvczmh0aqo+WJraTXMY0hHd8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb702828-ed22-406d-8a66-08dd3027b25d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 21:02:01.4172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Z3rwB0LR1YdPw6TDzwdMAenq8fxJrYAv/kJn0tg04QICY97+uA7pzTTRc+jZoBcgb0NOOmg1+m8nbHMwuNsRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4131
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_05,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501080171
X-Proofpoint-ORIG-GUID: H-kATZN3YWKo0gCbrLdX-BezW5wvy1z4
X-Proofpoint-GUID: H-kATZN3YWKo0gCbrLdX-BezW5wvy1z4

Move stats_read_blocks from btrfs_fs_devices to btrfs_fs_info and its
init and destroy.

This is based on the `for-next` branch in the repo github.com/btrfs/linux.git.

Fixes: 49136a74162e btrfs: add tracking of read blocks for read policy
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/bio.c     | 2 +-
 fs/btrfs/disk-io.c | 5 +++++
 fs/btrfs/fs.h      | 3 +++
 fs/btrfs/volumes.c | 6 ------
 fs/btrfs/volumes.h | 3 ---
 5 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index afff205ef671..bc2555c44a12 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -458,7 +458,7 @@ static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *bio)
 	 * filesystem is fully initialized.
 	 */
 	if (dev->fs_devices->collect_fs_stats && bio_op(bio) == REQ_OP_READ && dev->fs_info)
-		percpu_counter_add(&dev->fs_devices->stats_read_blocks,
+		percpu_counter_add(&dev->fs_info->stats_read_blocks,
 				   bio->bi_iter.bi_size >> dev->fs_info->sectorsize_bits);
 
 	if (bio->bi_opf & REQ_BTRFS_CGROUP_PUNT)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 4928bf2cd07f..ef3121b55c50 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1258,6 +1258,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 {
 	struct percpu_counter *em_counter = &fs_info->evictable_extent_maps;
 
+	percpu_counter_destroy(&fs_info->stats_read_blocks);
 	percpu_counter_destroy(&fs_info->dirty_metadata_bytes);
 	percpu_counter_destroy(&fs_info->delalloc_bytes);
 	percpu_counter_destroy(&fs_info->ordered_bytes);
@@ -2923,6 +2924,10 @@ static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block
 	if (ret)
 		return ret;
 
+	ret = percpu_counter_init(&fs_info->stats_read_blocks, 0, GFP_KERNEL);
+	if (ret)
+		return ret;
+
 	fs_info->dirty_metadata_batch = PAGE_SIZE *
 					(1 + ilog2(nr_cpu_ids));
 
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index be8c32d1a7bb..b572d6b9730b 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -627,6 +627,9 @@ struct btrfs_fs_info {
 	struct kobject *qgroups_kobj;
 	struct kobject *discard_kobj;
 
+	/* Track the number of blocks (sectors) read by the filesystem. */
+	struct percpu_counter stats_read_blocks;
+
 	/* Used to keep from writing metadata until there is a nice batch */
 	struct percpu_counter dirty_metadata_bytes;
 	struct percpu_counter delalloc_bytes;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c02d551b73a7..e0c64246f8f6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1255,7 +1255,6 @@ static void close_fs_devices(struct btrfs_fs_devices *fs_devices)
 	list_for_each_entry_safe(device, tmp, &fs_devices->devices, dev_list)
 		btrfs_close_one_device(device);
 
-	percpu_counter_destroy(&fs_devices->stats_read_blocks);
 	WARN_ON(fs_devices->open_devices);
 	WARN_ON(fs_devices->rw_devices);
 	fs_devices->opened = 0;
@@ -1303,11 +1302,6 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 	s64 __maybe_unused value = 0;
 	int ret = 0;
 
-	/* Initialize the in-memory record of filesystem read count. */
-	ret = percpu_counter_init(&fs_devices->stats_read_blocks, 0, GFP_KERNEL);
-	if (ret)
-		return ret;
-
 	list_for_each_entry_safe(device, tmp_device, &fs_devices->devices,
 				 dev_list) {
 		int ret2;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index f197e152f318..120f65e21eeb 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -438,9 +438,6 @@ struct btrfs_fs_devices {
 
 	enum btrfs_chunk_allocation_policy chunk_alloc_policy;
 
-	/* Track the number of blocks (sectors) read by the filesystem. */
-	struct percpu_counter stats_read_blocks;
-
 	/* Policy used to read the mirrored stripes. */
 	enum btrfs_read_policy read_policy;
 
-- 
2.47.0


