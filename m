Return-Path: <linux-btrfs+bounces-10446-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5009F4159
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 04:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C422B168900
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 03:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16700142E9F;
	Tue, 17 Dec 2024 03:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OGuZn/au";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BYBa+IOW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2A783CC1
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 03:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734407769; cv=fail; b=qVhz8V4SIOrHfVRhw+tVG6ynOD8Mk0abXmK1qZylNNOK4TxuYllw0bB0jrwXaBMWBQdm/NeAoQRCgtzj2W9umpOHT+kKLxSeEr8nKPTb3g7z5nXBxIkQKv50Tbv5oxual+lTF05kQjrOk2WeLbOh+64jzupob/GD8esxuNeKny0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734407769; c=relaxed/simple;
	bh=jz2UTMH/afIyDwMXRrk9rWTTuxSHM4xNIlaPrBrWPgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V42Mz9xawjbPg5V1gwYfv08Gs5qQBZSvXbI4ff71XzKRHlnHFgoiTmN37cwlrn+/X5WN0FZGn7FUvhMPp0ktn0SsgpiZzU010Swd9VR0x7VAW9Cn+z0Y2yg900e3ze3P6YM6EBMkhwzwtZsrsAeAv+zzEZXRMEoHaUg/wheajZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OGuZn/au; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BYBa+IOW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH1uJgN015362;
	Tue, 17 Dec 2024 03:55:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Z2NHl1ETW44Lkg0vyp6BkvGiw86UPCLuYJPjaa0ZDVE=; b=
	OGuZn/auUW7/hCK0nskVHDyWxMoGZtusdzXt+yqjQGs7f1AmB+miMuF8rHlCs5v3
	+H2quU4hoknLUnBwUxVfg3mq7AiMg42snD2GBZD3/V7mBiktzQLkrGaLD4v3Ds9M
	YqsPQoQAseLNsfWmsEM2r2XhIl8Nz/uoUE4YgRRdYihEJfCxyBTzyVTZYqwhoUq2
	llmBaDm0+WP8flye/wp94pKTPl9kD3lYPfAQYQxBeknsrJ6ZI6l/7LtoLmK+M/zA
	vCO+z+qPOAgHKKzi5Fb510n20cU+MmhShJ2y1VjQoQg7GCoyuk61dXGxb7sOWgS5
	HXJ5XjXWz9x7Q0wwbJXHCw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h22cn1vw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 03:55:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH2Ufes032717;
	Tue, 17 Dec 2024 03:55:50 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0fe53ug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 03:55:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XqQ63tZZCih7CzUTG7es34CoASd3F76I7MKhD4ZcqmqF3irYrfaw1cchfV5JRe5I6jyfrCFATSS5aP7OtcNAYkEblCijVia5pbWi6Pc/8osvjKds24thkZFdINsBPyV2H6CafuTDL4uU3rM8E00l2qdUhh4wpFmB9hjtmavVdzxYzXIlbnb/pWHJQfgCkesVNBWqpq/vcUnClnKgmSdAGJk6r6LFQ6wmwasRg7jng1ny2HnBcFZ+vWico6v53FfX0kvjZN/ZnApWmNUOYQcM6SB8B0qvg3f6cU/A0BSEQ/ClkNvtgovdMbf22PXCqlO/RlpAoUSGmuPTk4tYoeUReA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2NHl1ETW44Lkg0vyp6BkvGiw86UPCLuYJPjaa0ZDVE=;
 b=By8Mkd8S1AP2Kg952Tt/x7/xC8CwktECm8PfdVI/8eI0dGQ/5AjYTTp3oO6bDhTCg5PAdBFqOdR//63ov24lGPiNG1RQ6X/MtehsBUo22meppDEX9lB6CbwgU1hCEbOlv/i2WanM+Dzvd6EcRHGHJ4dp6A1Rq3b8BKclOC46cxZ5tFUkqXt2sRGEo3CVyxU9i8e4MWYV3rc64wLVvU+qFnFARUGbUeCesGq9GduOoaUP2UKUNyagS+opf0gP5ZcAHFmNpy/+x4mp5/brBaHQyVfBY30RlZerqiA4qgnDHLvj4yTYFQqbzhLith8RQkjj07pW7CiUXb0TMpQETZz5CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2NHl1ETW44Lkg0vyp6BkvGiw86UPCLuYJPjaa0ZDVE=;
 b=BYBa+IOW5RfVqB2/Byci1/BKswNE3CsluRBn8EcBeNl4k2lZiaIvXCv5OffCnwkWwKPCTc85PNfk/5q/d8gZlM2h8zOmEowfmJNZfjO1LnGHaQ1G6yOoEKm5DdshU41nndM1EqnUkKdJSsDH0FJsrqj2euW08jcHOnm8bdR5Xkg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN6PR10MB8045.namprd10.prod.outlook.com (2603:10b6:208:4fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 03:55:48 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 03:55:47 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] btrfs: fix smatch warning inconsistent indenting
Date: Tue, 17 Dec 2024 11:53:09 +0800
Message-ID: <6f864e83bae41e8d7fa9aad379ab6a68a15d7b26.1734407232.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <c7a0deccadcc474bc85ec3393fcb4d5908b4986e.1734370093.git.anand.jain@oracle.com>
References: <c7a0deccadcc474bc85ec3393fcb4d5908b4986e.1734370093.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN6PR10MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: 97781b8f-ac73-4380-ee83-08dd1e4eb08c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aeNkodQFqHISpfQxBJC9Hb522fc/3j4JEAv1heIjdu4j/rzAVAjjANzir9ML?=
 =?us-ascii?Q?uXJ0EmEd2+fX9Q5Re13tzWTrtS+JSS49AxhPd+ZR9WdDeCdz4PJhoCJpTHcC?=
 =?us-ascii?Q?Ryeqmji2dAWg7BkB4WbpZ/IDiDByFR6AbUzYE+4WPVx8c9yYq7GQ7m+v5A9z?=
 =?us-ascii?Q?H/FycuTtQme8ZljbP6GDuXJt4Q412MpMbRMjbHTb4HwZvvyn4AiKn89QAKMT?=
 =?us-ascii?Q?DlgtuwEgSk1P2NO4jOz7hq914i+xtg00TF78RcZRyEAM8UVfRDekSe1nUSi2?=
 =?us-ascii?Q?ZVKfN03Y2EsXiyfKslCMiJp8pNcpw+GwHTclLk2xyeaFAhWLr0EKeocVli/d?=
 =?us-ascii?Q?0WzbK3jZBjnCn12A8NGIovLQIWbLeNwUaigKjJtI1KGs4PVBgfK0fAQ5Oag0?=
 =?us-ascii?Q?bz3DVzmpo6l/Fgzu7lha6F+K9eokuBCrb3Qx990Un0Y4o4q5NBClV7r9z2Pl?=
 =?us-ascii?Q?X17cJR7Cwmvnj2ro8bmVNVSHYz8jzUAtcDV0NJXZJ5aem7zcIbZfZbwwqeHt?=
 =?us-ascii?Q?uW6fy5w2BEOSrbjp28WKd93kgj2BAYC1gD90l59QxKErX3cXKKo0C2FtmjGE?=
 =?us-ascii?Q?/JILF+TU6Ez9Hr+LqQ0a7+Fd3ZHi4XE/eKHY038uSWLvp20yd50hFfNJbE8A?=
 =?us-ascii?Q?YbY+eKE4PS9+MoF7aeA5C+vsotJzwNSXkAmPsDnIzrGuA4bZXpn7a0UI9MIY?=
 =?us-ascii?Q?4ILIbEiqU9eFhtKaaSZtDj/XOx5kTVZI+kzrdGA0zmouE0MQRKQWbIuE/UbH?=
 =?us-ascii?Q?k6EG1L+fo57O48yOpOvmdaldOYbRnexF4f4JgRAjx4bCek8dPIa2RrHXZHoC?=
 =?us-ascii?Q?iLRbqcssfBEEhRCejB+0idkbvLo215xzyjtFMVWR0DGpbcrBsT7tFN1aMwn1?=
 =?us-ascii?Q?QUF7KSSkHTasZ+Tca8f2Qw4o41nDHG1U6p9/7PYDRRLwNc4VJtXw2lj8iaYd?=
 =?us-ascii?Q?uRICdfiiE9Y/Yl80e0OcuTiyBuZrrKP6ZFdFSA6ntQ6yDhamv2XE7JOXTNrB?=
 =?us-ascii?Q?GiiVa+Fk9QZU5bQKkJbbDYYcpOz3EQ5Wy6OhVyHstX8tn+ouCS4GQLrslBDR?=
 =?us-ascii?Q?G131DOu9mujz1JTjjSFk6x1EcvXJV3nXLjHSQv2EZH+dbDwzSCM5K1P9DcMW?=
 =?us-ascii?Q?MQ+DfLpq+K85mbMwQe/GR2ie/8GabBQiQi+KCZAnFljaQ/CIzh+WSWvpnSkP?=
 =?us-ascii?Q?6SHuVOLOwuY9Hl3lsV0y8laCcIsQKIxnv7VLhSDTG6GFedjn4JPeFR1SHBFC?=
 =?us-ascii?Q?YdSnYWOLy4iUFK9E4F8T3kqsiw43MR7XNMcC2l1E22XbwXpgUtWyu4TSg5hu?=
 =?us-ascii?Q?nnk0xzBr8KPIYKaUUocGuejRR6rT4UIn3FDgNypdkcEdXarLshutq0J0Rkn8?=
 =?us-ascii?Q?O3EeJ4ylUnIxk1OChfz95V4dAQu9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UEnbsi5GB9fDYndrliYOtz3K/6SedJXE1IbzmuIBgFthld1Tt36SbNgYcsnG?=
 =?us-ascii?Q?nknEDXORxgBPDETCv1V3VcqjdRmNpu7/61bjPf5VDdLL19x5tEW4qYculqad?=
 =?us-ascii?Q?sMaphO/QuB8SvEXVOWOSfoSpjHQLRizrEvvFk+EjECayU32QORTWrskjJdsm?=
 =?us-ascii?Q?pKF2xOJCOySDmEuSBJHtR9Bu8DTdzP5Mh20LhMEnpacItwyTMcSzAGWnMnSu?=
 =?us-ascii?Q?xbyh65OWYWWg2bc6htGG6pSRDEpL+brXaD4bcJJZHEe/EJ2mKJhZVRPNTanw?=
 =?us-ascii?Q?wCFqOyJxPp5gwv5dlN7Sd/C3jj5yDmG39qWcaQqPj38tXe+lXW4bGONL+unc?=
 =?us-ascii?Q?4gv2/V0bxZYvHLNokrNYO6Q+PpRrMXK7Mn4bWuWjqCq1LZwGhGn6tWB5C2fU?=
 =?us-ascii?Q?sDjcw+BAnCGQB7Q8JVIpT666AiKrKXE3YxZcdBsFfVxM8I0VIal25b6H6RJM?=
 =?us-ascii?Q?ZALjpxirpswNx6kzoDuSP8dZqZS4DZfdBQV2LR3QVdZQua6gL1lIyvN8ksmQ?=
 =?us-ascii?Q?DU9MfmdzEZMiAmdKkBziCTG6kMCH+b/713UkCwpnb0/PirCos3Th7PygLpya?=
 =?us-ascii?Q?WqP2bmRBKH8/2lFlp2r3KAObS+XoTFe8NNDXOJ6IEQf6ZXfQBxYHUBU/cRzI?=
 =?us-ascii?Q?yIs1e0IGEiyseqbEIDzqUH9QYNZN8FkOn3zODOsIhTJzlGDUHYfPTTfmbNW2?=
 =?us-ascii?Q?Z7get85ht2qB4DbnY4W80yp0cz8GAypISqb0LSRL/lcFTaQ/LMgGIt4yExP4?=
 =?us-ascii?Q?v4yRvArOBm5yDMEZ3KB/gDk8Ya7UBceWFEM/6pdX6Ha3RSAcFmFOYIXwA80v?=
 =?us-ascii?Q?VdIJtOeBkzS5+RClEuN9Va1u5ohTRyRkHsob/fqV5sY+h3sHVjaroyRfq21N?=
 =?us-ascii?Q?gtyTJKtSBXlNrs+FSjYnBH15XaLmuvnD9boccUgC08y5ie8fJX/O9CJnkp3L?=
 =?us-ascii?Q?isZREi5YigPWwSRpA+GiP038YgG7Cxr0T8/u0t/G3kLzfvmVhKgDVP5pUyM0?=
 =?us-ascii?Q?SIfAzSXBcfxmR/+emqv1SfoFGsFzPnUz5EPRwRd91vqEn7xNruxLGi/8NbV0?=
 =?us-ascii?Q?UziO2yrTr/6tNRcP2qv42sjqFYg8iqsVx2/vSyJR9eLk0EcyD3MOx6ZeWEiP?=
 =?us-ascii?Q?DO2cqsCXAOxrpgti9K5J1iJdw+ijcZczZPmi3WrF0tZVUXz6q8i09fD3B6Ha?=
 =?us-ascii?Q?N+A5E6wavYA3pkR6RyxJ377pro8qmV4jmG11c5KP0ZICVjHGhjXUoltrS7/e?=
 =?us-ascii?Q?qFXUv8eM+lRlQdtMWi2PGdkC2H8nGTCZ6Ek8QwdvIIhC/6drZNM/uJrvdWVj?=
 =?us-ascii?Q?P4zudClyVIEYYIvJWacYI+aGtoiA8cQTNKZrXJOrVCKekFMCm9sfEGq8ZrE4?=
 =?us-ascii?Q?pRkSLb4sHchZ4iF0Q5G1Fjxiy2jiSbhI3FNrg3pq+VQc7wEdlc6jqecJlEBI?=
 =?us-ascii?Q?fY6VosWb6Y0OfCJ3kxehfP0YyCo1Qt8YsoAefQQ7zZ7gv97wPBo00VVlTN5C?=
 =?us-ascii?Q?wChAW4eZ0YE5ev5C2KdGYuJ/3Si4+WzVLfMD545jhtqDmNS51mBkIdCHkaC6?=
 =?us-ascii?Q?jy+uB+neC9rbNbzuEZKSX3RTrAdA8C53b8HtHoGp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mCUcdWYWVvgkJaOhHTfRYLiCK/aSnQASYxmMwZ7pkYEwxBv2QR+a/K7WBmDFrK0DKmEc0AG0tD0FNV1cnIBYRpCuDq0UVev4SbD6oozC4SbHll8fuAZRuP4VJ4ic1HPcIDaPhBzxZGRzIk1J5jaR/5GVhCjtX0NDG6AeaooYiAWjz2NvKeFKPwpKCFeJboHPF1FYB+wy3Smt5z+cE4KZNhPyOrcngW06TgiqpMVJlqRB5/xKB20BBT+mmnASI6urOEX2I9pkSJtp457AmHSS9PSFv97dHBHi/D6iMexIvdt8EQu94ztyjwHFcDILVIHGWFIBRjTS73CY7hnCqsDqbRG6BR3VJPWxEo6oWVG+sB7aXnPFLIblDkA+iCzyM/iuGPnW22LniPLF5Br7pFXXiSragkINOUt47E7IG8Yj4bWGvrLt6bCdtSDYLsWJ3FVRizfBkaElxFaV4ey3o8Q7/JUpjfKktbLRu5SwKyPASlgTvPks2k9VC8iJeh6Uz2oKGeqatpKwSi8EJ0y3rdEqaX9Tejgv4GOxlDyHplXa+YM7BtJV9jca7mvkCSn045WO/2eD+OZprQRNE+GdaCToXhol6bxXJbUye1OI6RSDk2I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97781b8f-ac73-4380-ee83-08dd1e4eb08c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 03:55:47.5846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYBqwlm+FITUp27bGxbRQWjQyAjn5x84L5NG7EwprkWp1ii1lGBL9qDmR5yXJz4RJGCo63E3Ui1Vb82Tv2n0ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8045
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_10,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412170030
X-Proofpoint-GUID: lur_ERoah-qts1zfmfJ5fYi0W3t3a3oZ
X-Proofpoint-ORIG-GUID: lur_ERoah-qts1zfmfJ5fYi0W3t3a3oZ

Corrects indentation warning reported by smatch.
Fixes:
   [PATCH v4 9/9] btrfs: modload to print RAID1 balancing status
in the ML, for the fixup in it.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202412170215.uLhijGQD-lkp@intel.com/
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
This patch should be rolled into the mentioned patch.

 fs/btrfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 573e8e1a2b24..236eec7c19cf 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2488,7 +2488,7 @@ static int __init btrfs_print_mod_info(void)
 		pr_info("Btrfs loaded%s, raid1_balancing=%s\n",
 			 options, btrfs_get_raid1_balancing());
 #else
-		pr_info("Btrfs loaded%s\n", options);
+	pr_info("Btrfs loaded%s\n", options);
 #endif
 
 	return 0;
-- 
2.47.0


