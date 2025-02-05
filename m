Return-Path: <linux-btrfs+bounces-11288-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B32EA288E1
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 12:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F5CA162630
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 11:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE1C22CBE0;
	Wed,  5 Feb 2025 11:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k05FxELI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u3CnJKMj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF0A22ACEE;
	Wed,  5 Feb 2025 11:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738753636; cv=fail; b=RwitPi2AwOFi1UIOFA9TgjhpDS1RMyfaYIXQsQ9a8tp9l/NKMrdJLF3cFo/MwKt3G62RGthQ4aiWNPRi/vOjzNauAllCexLToHhnKLY9js+cKDGQ1aGPmq/y/vOaa94YzJ7C5oil3NqVsMe2X8xQrv4gBCvzryznoqWCu/wRFoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738753636; c=relaxed/simple;
	bh=IutPaEezwKe/x+JTKV/Fw49WgRGN/L7gOV72kfEr+hM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VcJQyFmhPPutKZFF5+dDznzT0iqp+MqmOqe903qgdkeAgcVNQQ5rj8HZ+BB5tzU/MHLkNmOrkorWrUEI5vmWhW7V6J1ozL0SS2VcnBSJ4PyHH+wb71ehXbu0LBAKMlO1yigbg22OlPZaXmv3i3NuY817Z+i1rdlZE/1ByPxqmbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k05FxELI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u3CnJKMj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5158MoJw019801;
	Wed, 5 Feb 2025 11:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=8YKTChGOLpds+qZtOp1UK8uiaYYYUu6ebMS5k99Thz8=; b=
	k05FxELIaBnuv5NLxve3Rxac2CRLAu3bNoX+UPbDz9MHcNv7ntGhM7QkFIy++CRO
	oyA1dT6+vFq6EUCqzlVV/uEktD3Wv5K3pS6m73EaQmQBmrYR0D6biIRkQiwpSYJb
	DK3moLJkQz8VFAQ5tPe2BvQkdxzumM4ZZSMMq1VtfC85TCM2hrwlQFHNw+/RpriP
	Kh7HN7n7u4LGbuC96mtEJgt6zdikwyLoG8uRUosnj979wk79kk9K1wJelT+vJg5W
	i0jeTjju8ZFM1Vd8/LxQGwPCiMiTs8CaYTYhvw7eC0YHEMx6F78H7IlY44XTwjfQ
	3/bzvex9xU/crIqRQ+jUBQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44kku4t3tg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 11:07:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51593jul029413;
	Wed, 5 Feb 2025 11:07:08 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8dnh8s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 11:07:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NqbTPGBMwd+AhKQFDoOSx5QAiIahtIh1QJIqD/TLZaSY+e1iVEPnvRUy9slWaHtirKVcl9LhVgrVMfOWwq9o1hIk8ZaAcamt8QYjuz44Z0ZvMAYqPvsOauBqybXHM4GebBM7ypPtopPGdeNTddyCBh+9TvYrS704vubb9CXxxzuCmsPjbbglA+4hXdwJ0ntz28qNoldaIRCQXaATrE/o8grz7WykUrxsOvp98PKOE1xGQMzod9RWoMvLS8sozoKF8QdkjAgWxssna3878qUpMGpOpGzTAleOea0zT9+MHzwx1/gUUVlxQZBT0PfHO25+hwPzAef1gSX35KexWZvxfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YKTChGOLpds+qZtOp1UK8uiaYYYUu6ebMS5k99Thz8=;
 b=kVSJtbjJ5ZmO9Pz6zUZrZIsfFzHc6hBkQmuc6KzMZpi11dyI+IGeiICix45mfmSdBd5zXhG/xxdWR04EHS4dXq41T3Kb7W+br7/7SmW7VKj4mEtFe2U1EFrg4vyiKA0P3FT2qwPqGNoAPKT22x6LZiIY9GQBsZURW51b479ZRnDyM7XUu/dYRXVefhjeQC+ygle3BwyQzRI3+NZQNwoR0yyvjALHBGnImuBZOOeTuylVpXniVnI9fVkEBNGBHC/OiZiiK8qdY3QDlq9EYdDrvutfMZ/dqKcUwxq097FI20qiHf3nlI0Ph2JNSGlxYLn2Dq++my6RvUSPx2KdnLRj6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YKTChGOLpds+qZtOp1UK8uiaYYYUu6ebMS5k99Thz8=;
 b=u3CnJKMjCEoOKy9EwubEbwPvEC9W1ArBVXARpLUq3Ef0bRwG2cZGeYbrga22Lf7Z66f36ZpLYl7faWUcFJT50FNPOci18MERQD8drpFwM+KBzFsuOmrTcOp8Jl1D9O/J2x1vDJXTla5RK+6pHH2t+R2OsmElsIQZCPHt0ZDFMIA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB6439.namprd10.prod.outlook.com (2603:10b6:303:218::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Wed, 5 Feb
 2025 11:07:06 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%3]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 11:07:06 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, david@fromorbit.com
Subject: [PATCH v2 3/5] fstests: common/rc: add sysfs argument verification helpers
Date: Wed,  5 Feb 2025 19:06:38 +0800
Message-ID: <f11ddafa2622d364b099b68ffbe4aaf4100e6042.1738752716.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1738752716.git.anand.jain@oracle.com>
References: <cover.1738752716.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b71eb0-90ae-48bc-e53e-08dd45d53a03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UXSULAAvFCiOcGrWAFHu3BegMsFZ+tbbORiVJD84M/BqKwHWb56HkmF3jBTC?=
 =?us-ascii?Q?y+0rqsy8RxQSspNeTD+/JmRlk8MVQFWQcy+qIW1ssf0SvEnmwIXufloPpkUD?=
 =?us-ascii?Q?riaGgAgmE4mnZx951IzpOxb+dtH8g4kJ9mlPMHE/m9agjYHY8amaRtK5yEix?=
 =?us-ascii?Q?Xg6SX4G9G8/TPTyMaoCjaGULauAIcQZjmmp2j2ySgfN38PH353D7x3uHBBEf?=
 =?us-ascii?Q?PJ7vi7qKXBXmVSOl+Tj1Jaf7ryUBnDwQuyceyQJUSRxzFM7hmzxKDLM48MIB?=
 =?us-ascii?Q?/0pCL+FhBgrBODPwOnfR9tCLZ8tr4I8ySRAGUSImZdqdLGDGrOdoFeoEoUEB?=
 =?us-ascii?Q?ozDfm+WCQqmhrCCGnS6M+mNzbzsEo4Ih2HIZla8mX5lYoYKh7N+/BmVjbTOz?=
 =?us-ascii?Q?S7oiDzZFpNaLfgAVclYWUqczwZxXZt0yPEYpzIMV/NTCB2ogDah9hLuWVSJU?=
 =?us-ascii?Q?hM75P+SQ/niVFQ4wn9YkTt048FOd0xJ4FYLk0DhGDdvQW4JIfdt4DCP8sVK7?=
 =?us-ascii?Q?8d5lS66pA0GybdXscI7/1bMwhe8llRqOTdebz0vkEqzdb6kgAsYDj1ambbaO?=
 =?us-ascii?Q?xelIHvcsKbh7D7wPIOYAkPYUKhxMyGYXB6YDl79BhRGjiVs/ABgEuxh6HHLM?=
 =?us-ascii?Q?cMKfDk5KYuTrcT7CogCpuET0Z5mToUajvUWpATEuomC8XBGOgimgRLXUCH0Z?=
 =?us-ascii?Q?bVG0b6YWl2iAyDI6TagCpFJd/0ojmELaWCFTskz4aDN3V4Ao27mFQ4nWrxr7?=
 =?us-ascii?Q?ux6h/dhNgbEXBi1VcJV1XH9OanEoBYskJggXHCO2BVqL1pCFIXjgC2pmz1l/?=
 =?us-ascii?Q?zNYqVoU+2Iqo3lfgMoTMXJXYL08ZsjH0Lzzsm3aC8HhBf1XFVcow0tEp7Uvv?=
 =?us-ascii?Q?VpxwnjxKrEmH68lVPp/yy2Be1zY9Ibp7EzDdHFZyEpLOTigYE+U0dmVMF84l?=
 =?us-ascii?Q?+MWvyloeU+z6QNL/OW/Wwv09LxE8uMxmOYjB5OqHMwakiT5/7dyI5pO/ylHh?=
 =?us-ascii?Q?V3CWrBDlwsTYPIsRuTVVj5hlbjsVvRmZG1gJtiJLlsGiGYnuhajKvkRvFH2B?=
 =?us-ascii?Q?2toMU00C1Z3Cy1GDZNvoVcg7GJItLoNvfnidtVrgRF3cRbzdyybzCD94Ct1y?=
 =?us-ascii?Q?f7vEu1/+wAusDGcCwWwxFiOfYCHJwqsMTLu2yUFjiglVWvA/wx1FjEAeLT06?=
 =?us-ascii?Q?rXlROOOIXAwOiCOiGN6448r23VYXpsQunNfMgRJ60xMWWuaA4fUyNOBBfM4j?=
 =?us-ascii?Q?yctwvccOiZSA9guLJyrosYouc915vIa4xmWWajxUCsqFIB6P516IjeONVujH?=
 =?us-ascii?Q?tQKidGC/jbnF6e99H7RggQyHNu9xLkhcGaFlTKvdw5ZafEJRPqjQA1yIZ6JB?=
 =?us-ascii?Q?aI768jbPXhzGFzeXl1ckJpM0ai3i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YJ0xkYQANNEEgziyXP1ZUlrueLv5uaQSyJflBbxbdt8UykH6py5LdIpYxROj?=
 =?us-ascii?Q?1JoDavsrBWIElh+KRyAFF1ogtsEkPB2NI3bm3S2URE7qF/mJCwNmDm5VAFYq?=
 =?us-ascii?Q?HGV1ryeRDZX6bLr7Qj7WHI2zpdUAjb7+GdJ1FM6zyNPdABqe5aM/WqqrMKI5?=
 =?us-ascii?Q?WqGxaA1E47Xhe96VFTODy00RYSmHgPkGJuTrKMBs6eaxI91v1+3fwxBqxARA?=
 =?us-ascii?Q?TwvEEmnTC44YfExpKL1Gbu2aXa8BhmemdkO4goey8kqhBIE+p6dAF3w682hI?=
 =?us-ascii?Q?wDRQG4mKHnf/nlGZnyxtVqDBQvLzDfeb+H1WgtQG/lXo5MatQc7sT6f8K6s6?=
 =?us-ascii?Q?W2U5XAVFqYBYXBkMcvpT6knKZXmvRL/TgbTnveRnLFc6IGYAafAzqESlL0PG?=
 =?us-ascii?Q?LMGtD3b/7N8pqcyKWM0QztOdD7PqHCKWdhSnRpm1AjLh/JjUUbHY+C5xVuY7?=
 =?us-ascii?Q?OEmSfaNpCVpF0Z8HKXwEMcWZ5HDtUzGCK1oa55GGepc50V9DxU6FgAKjJlsa?=
 =?us-ascii?Q?8+nas4G0VAy2LfmNelVnWnrmP5QpKIKH6qC0iU/CJ77lyK3goDyFxe5yKDbU?=
 =?us-ascii?Q?CHwM10+M8RBcM3al/t0ODgoi6lqrxgPTcKHCnBY/cKdlfSLlSqw4Nr5IxJ+i?=
 =?us-ascii?Q?+9Zim8t3wscsbJupj2VEXUlOEHAjsCzHjwLyf/rv9koPwWA+ilSO9BbfNto5?=
 =?us-ascii?Q?6RN8KjKLyC/EYH5jJ9LIbi6skm8LBzBB3AUzqPMI6XSo0QnrnAkLMIm2apPS?=
 =?us-ascii?Q?6DoYFMViVkpNRvuWYnQp2UHE/3cAPl10NpF20Wo7sdlvWW1obyBaLY9TX12B?=
 =?us-ascii?Q?96sHS9MCHhOJmQuCdaNGNtz1TmPFyL1iSNfktCMC+NoaEtm/RSVQmRqGbFUG?=
 =?us-ascii?Q?hVmPdWgg89/vuNs7ULyKGcA551huokMR3NwoORYfEPWucmyz++t43UeK86s8?=
 =?us-ascii?Q?HCg1FP0MYgjxnFyARnrqx01P+RHv2D3WiVDHbD4D7YoV7nzLcUMSCpnFm2FX?=
 =?us-ascii?Q?giZf5XjybH+G5JKZul06TVCb+Rge4vcGaCjCsbDvqMx62ShdMX4KB0YNx3OX?=
 =?us-ascii?Q?Gbrk0OzWXYmbQctGdcNuydofBJhXwwRQfFgm2xgTDpxeK7bF/sbjgvfszL5h?=
 =?us-ascii?Q?6vmPK/hBP2ue4FRzXRyi2Fip0cVzA7pnPLPmPjEwaD4UQW/44gHtGc4Tkuuo?=
 =?us-ascii?Q?CI1lWOGPn2VhB+6VUxBvgP5ZcZlTVgribbQF4dRgaGlBF3haqVH16a5gTKRO?=
 =?us-ascii?Q?hCwFy2lETRhm8KeZC8DpOZnfoB/q1azGMkQO3J7BaAuvde6G+e1ZllrgX6hp?=
 =?us-ascii?Q?URPCGDorbBzwIY0I0qMZGs65ATGA8olQgfmepLNx8539lUFO3sSX+s80laqE?=
 =?us-ascii?Q?vhev0JRx2nANA9U3ykkbO1D0yZCDcbW0bMw34eoyQRk1hRoeFnfC895Z9HZU?=
 =?us-ascii?Q?4sWCfUqQiZabpCZ7j0nSBPcekXIddNrKhbwoylf/sDRiey/PW3NppDs+aoYK?=
 =?us-ascii?Q?fKBba8+g8vxQ+CQMkyGd2FUFC2cVfEBz6q9xfg6BRclwh2SktfP6Cx2r+wNl?=
 =?us-ascii?Q?yArjcCLRiR9ukGmV9+kyLmDbmj0oOlBM4Dy0ytJA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QgK2glcogT+7DjFKGKejWx7qwd02+qaq+/aL/XTuCmnu2Ub8vkesug2haAKM2KqIDVDwekhRm3PwW0z4b8ZANrtQl5/UtmkRh4dsAqyc29Ifga6mcEeBF7zLga0tz5tU+pe2/XtBtkvEnNYdBRbI4LcgpCrtOSQIu5NtAMW93M3rS2zNK5qP3OaHz7SSTkA5IS2Pw7OiZ6odS/kwkCLTqsJXA1akfe3/JOe6WmgVBlJZvOEIh3dmKlz8jg32tdob/KXRABUpPdN8BexNl3wVd2KXaBZoXKDF7utYYP2Vig/rXC4cd/v5DNoLfPNQvLs6DFvhNfDA/nSrbYGfNPCWACg/Ni2oCnHIA7pdEb3wdO1bC1UcM8zYKi88MVnk/YD3uccCkNXBB4UbdK1aIKie99ehFELdX3XPdrvMdwR8jepQapG0o7GMm9bWND2+yPXauvKB9VW+pswizMcBoDC/BL3/ZBhOM9zqCsx+fznOHlMuPUrvKo7JgNlhIPlVdc0Nf3uBI5rhdxXspm7I89O7oKmSxdmKGzUh+p771xDrfQKEzrwB5RjWYlnj1k1qpbZiKUIAGo73T/chwvNkG+vDuWBiw0sgbIZg4l9L4sB9PV4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b71eb0-90ae-48bc-e53e-08dd45d53a03
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 11:07:06.1442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9WAbEEBZ6dtqP02sWq80MAqQEaNF5vbj298q6oeUWoRVhqHJ6BgZxnx/DPqTh6yAIjyoWT0sI0uvm1yHcI+nmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6439
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_05,2025-02-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050089
X-Proofpoint-GUID: iw2c8NennN-_en6Q5dozbGo4Ytd7IuDu
X-Proofpoint-ORIG-GUID: iw2c8NennN-_en6Q5dozbGo4Ytd7IuDu

Introduce `verify_sysfs_syntax()` and `_require_fs_sysfs_attr_policy()` to verify
whether a sysfs attribute rejects invalid input arguments during writes.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/rc | 136 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/common/rc b/common/rc
index def55ac68771..cc5680581608 100644
--- a/common/rc
+++ b/common/rc
@@ -5147,6 +5147,142 @@ _require_fs_sysfs_attr()
 	_notrun "This test requires /sys/fs/${FSTYP}/${dname}/${attr}"
 }
 
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
 # Test for the existence of a sysfs entry at /sys/fs/$FSTYP/DEV/$ATTR
 #
 # Only one argument is needed:
-- 
2.47.0


