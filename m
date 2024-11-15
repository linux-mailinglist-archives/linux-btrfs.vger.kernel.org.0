Return-Path: <linux-btrfs+bounces-9695-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1CB9CE443
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 15:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF8D71F23865
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 14:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847AA1D45F2;
	Fri, 15 Nov 2024 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ItdMVy61";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vcPEr1wT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0740B1CEACD
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731682509; cv=fail; b=nGnlgSfQEAPOOCE9Hxj3qG+Hn1WHoixqtEeSMVMhELJd32JcKiCEcgd30XNIMolSEU0gKXICUDSFaRkJdBi0tuLDNOvZs5DXPmoe0xwawf940S0/SZhiWjt5KalbZLDu6l9nWzJDPC0YMH2iMMU4rMmW25ykdIN6qsMfro6PEX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731682509; c=relaxed/simple;
	bh=NQCAt/iom+THmMZuhxtgCHAryCm986N9TaxQrxIAlug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SS5vpeDG5PkbE45rFbyyRlhp0qj/R6JCy9XpH7elDyFEbLWiRnj7syCBMYc2fItnzWQJXxNOwIf98NglvX7i2gBHM2gXsR5Ggy4zhdQ+m//T3vhiTkvTulj6x1gDgs2TmVXkOexZBM+yVXgwTPvuO0fy5LKRqrNVtv21jaCPzlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ItdMVy61; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vcPEr1wT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFDCRBU030500;
	Fri, 15 Nov 2024 14:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=wRiQmEAymNPmtxWn2oCcGkdf+EbA5flL5go852YL9hU=; b=
	ItdMVy61J3dHm/FW+igv8ta8kvXR+QoW2zgSGmcNtE8PmY/7dWlMnTDp6BgW+AqM
	lAI1H6kOGoGkl3gvfhUN8MT3e17Mr22rUzsexcpAPKQAGdIDgYEhpQoYCy8HYNV5
	BBbWGKirdWAoHIBOi728tPAqdC8lqaE2nsy7MWIzzL0PfFEYcKXtzv4Ax3A30mDz
	S6JHsiImtNiF9ih4oaHt7g/or0kZK7sxWTI2Hn4d2/uB7ZA/cgwYicyFu7iiccnY
	G+1jMeFqLULFdDq/UhF0+8/p/ZsdOekSL9uRKYMZ/tw5A372y74dieSTgsG3rhW5
	RjzSYt+z4nSVqQh9Hc7yDg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0heue4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 14:54:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFDk43S036004;
	Fri, 15 Nov 2024 14:54:57 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6c9ef7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 14:54:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mev301EfJIQbjd7FSTH0poAra/e7/RDCwpt249pjhLmKpCDOgQCOZ3Ar7TLgmT0ZseXLaYKR13W0O7W5KgvMd9k9jyxppeY2C1ObbteaBMglKLsHkhFtgLhomTyXGoXIfANWy1qpO+bHLekisQ2KTSXgI5/duAnMVPZ+/Ydrh4EGufvETwErDHgldGt4G1nWKWfyCiZI848ZnDwd2PyhXdB0uR5DC0smIH5QL5Mw0WAEw+eNXtbPYgYpfs0q3DR8VM33OPn7s/um/Uoh77elqGJ60kKdyJarRyae1zwHYX9mZ9IS2nc+L2p16hkSl8IXQbtsx+x2o5cAhiGcvTJvYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRiQmEAymNPmtxWn2oCcGkdf+EbA5flL5go852YL9hU=;
 b=wgU7XYVpY/PDJ/dEcKdJ2rEMSs1w2j5ZU4wdjzB6wonsbn+b/j+ZbAa5HcpSV9uh+zL7sAQqMhDmNK7zkfug6CdSLO3Ee5Em12Wgw2beK/yn0dhRYUisjIPk69DEYL2dDDrETLLTIs03bfSl7ey/xcfz79TJP+ErOCsFqwj9/twsOEIu3e67BMrZpnys9iZHBRSpfNx1GwMI54pcsHPOawiSrU/bSjxYM5PhmJnssdgtf7D03q+Mjcx8j6izFLfuicH7K9Xsb/p55/SXMISYCY4uiKAvVtl+8IuR4XtOOkoLwd6PrpntZKaAvx6BcQAzCXNED6/PiUanP6FR2Chb2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRiQmEAymNPmtxWn2oCcGkdf+EbA5flL5go852YL9hU=;
 b=vcPEr1wTkvpTEbQaiUdUh5QsHtV9DUy0xzzb75vr4sLH/kmQItv4IiX+TOjfP4n+QO/iOoUGuo/wfGPivSI5hUKn74vn0vfI/SrIFq98qIi9HuG4gEghElJS7YFIqUmGd19gJ74DwYHrViVnHG++OFunIIHyW9Gqsdcmp9PRVLo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN6PR10MB8167.namprd10.prod.outlook.com (2603:10b6:208:4f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 14:54:54 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 14:54:54 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net
Subject: [PATCH v3 04/10] btrfs: handle value associated with raid1 balancing parameter
Date: Fri, 15 Nov 2024 22:54:04 +0800
Message-ID: <aab2735202ac9624d32d637f097df874fa217ebc.1731076425.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1731076425.git.anand.jain@oracle.com>
References: <cover.1731076425.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0195.apcprd06.prod.outlook.com (2603:1096:4:1::27)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN6PR10MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: c93e48f6-54e2-4dc0-0fd5-08dd058576c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LZX+y8nF6oucbLrnorcztMqus/NxIm6HpN+yevbT1yaMa4QVVd+PwEF9Fjog?=
 =?us-ascii?Q?KLPh9c2on3UVXJf0SmUraRBAn5/JdaGiQDFrIv/j05ztxc4q1ycxPvivvhkE?=
 =?us-ascii?Q?6ezoS3x8Yca9NeXRZIm3p2ncYoidxJptHXMuMYNSaqtD/5eVKHEfTBN9n6RP?=
 =?us-ascii?Q?z7FToF+DYEQTebrz2PoYyQeO0PUcrqXRDEMYC+RHpAkv1fjgf/LzeKKZ1sYi?=
 =?us-ascii?Q?H11v04cxNZDX46mudelqTyVlKYRrtGbj2OUAd5qos6rP1Fj7w+iPPn8Typdi?=
 =?us-ascii?Q?orXGcju2moSWjBafSCOTbZJN6/FyHqeEPihY0kGF8S+W3B1QQM0Js9MvEgPA?=
 =?us-ascii?Q?HC9L0BEtRd05BJztsplPhcMmkC5dVdKqqLZ0WE2AM6YQwtKYaLDV+lB0E4Ns?=
 =?us-ascii?Q?Ly3uXjEFO3zOve2uW1op8S8GgG3xxb7A9iey5DM21cL7NIlXtMBHGpz4o+/W?=
 =?us-ascii?Q?42EaJDFrLNiAliE/pDoDgY4TX4eztW0Bja69zcaszre0D8+ANqxfvlxWscjV?=
 =?us-ascii?Q?7J/hVhFFAB1wl/yjg+7x5aSBVUQgCxUWwCajbzGcZBFPVqE3tVvzs89MgVyV?=
 =?us-ascii?Q?vmqjXohIjqSyDxm5qGgzxTK1WjNTDrUttteqK0K/LQHVrFhSIp7eEY8V6lI1?=
 =?us-ascii?Q?iySFx011uQ25ZiiQAphW1UVifWFiKhfKpbeN7NKaHVd0po3w7Vc1oxK9cZhY?=
 =?us-ascii?Q?G/dxsYWWIHMQZaFH/AsMKDUbfDeVhFUk+3ioMGnLlKOwrJ9LgOH5NtFVbgbI?=
 =?us-ascii?Q?b51EUmGc0oQqwK2thMD1LOFR3u500G8eYAtfqLGWvrW0Fj9Osp2mMVMreAFX?=
 =?us-ascii?Q?GDapQvsUJZIUwG7fv7KltjEYm8bcwMws8uOJBByZojIJgoLvAm9bg9/gaM8D?=
 =?us-ascii?Q?67Th51bErJDsHUolaHstZqu16tmfHTTpKM+CVA2wYSWDJFxH49o/8gl2Mr5o?=
 =?us-ascii?Q?GkOfd2peYyAkqd8YX7LGI3tS6oB0pxJmoEpysqZ9CHAGvtT5AyMFGmdz4qL6?=
 =?us-ascii?Q?I1MPw1GM0l6AU07yshu2Gywgs68EUpU/HWiigMj7S35tqCj8UZd6IW0zeDX7?=
 =?us-ascii?Q?g3QSeyXhGYLaOmuS8UCWnJkdPYNBfIdx6gaHxlIsz6o6dctI4rKGWj52Id2k?=
 =?us-ascii?Q?rns4zogKnmgLymaPpKYg6PKJ0DYpJnn1iLgInfdlv6TkfjtE8OBfPrYTdEtO?=
 =?us-ascii?Q?sLdkr7V31w4FFeZ5iYfLUXC7xyvl33Ls+BEFXtIzE/SQ0mXtil59aQ2NZtkx?=
 =?us-ascii?Q?C4U5XSkgk2SKGjQdZIInSfKKtsFhqrV5FweM+afsFfWWxodT5l2C60m0JAkJ?=
 =?us-ascii?Q?v5zn9QbShkY5GeYK6CbckBHA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WIosGDjypfijrgAA7JeabK2HxLdAum+KYTYLV5hlr46Bw+Dm1MBU6EI0LG9c?=
 =?us-ascii?Q?6sDQlXH4KEj2ys7H1CXLTMNLFtvGPnYsMNpq61L4BvuRn1IGLtFwabE1ZD3y?=
 =?us-ascii?Q?tsoqJMc/GkwVrcMxB+7WTI9vz8ZGQ1hqa6NRO/VeF0caiVZxpKwOyVDc/4xt?=
 =?us-ascii?Q?aYql2bQ3JZao22YzFT6PgnxM46/3Db2I3yi8Fgzdx5jKP9ZvHmx+f3/0hYAM?=
 =?us-ascii?Q?MqEiXU+a5FATHl8k6s8jeQFHXEjO0slcqFwJOsogK2nEYjybZubKBGpCEoA+?=
 =?us-ascii?Q?bUxilSmrTChVJJLwddPiFDP3xs5a0Fc6u73aLmRg5K3BZjiZ91AEnB2vc8Ia?=
 =?us-ascii?Q?xFwobpL/Sf9rpWn3+SpB4hEnn1+ho1Jh0DuMXKissooCO8iQoCa+E9L3wgIM?=
 =?us-ascii?Q?K4FnoHOWS8JAOFSk0mfgmrKQH8vpc1KHIamsQKDYMLE+L2nTE+DkcQ4UW76M?=
 =?us-ascii?Q?LMcjBH6MCwuYS4Bgd1V0Rx5GvGuz5WFxITMNTiDE5MVkjCCg0AynaYefjdYF?=
 =?us-ascii?Q?qyxThQ3F6qahhKTgC97cNlNYZcwVI4FWLJweeq2GlG+m45ZZuJGgb916xmiW?=
 =?us-ascii?Q?0QTUzFLDxBMoH4c6cBh21I/DS0R8/Avgi7cuTNJJp4kiaEGmbj3Gwvk5ALFX?=
 =?us-ascii?Q?VGqeNMQopXMhO8349Bq8xM3x2WWbpKjyqWkVGff00JIRWC0Icvazk9fnOWzz?=
 =?us-ascii?Q?AVIGDuUUxrNdMPVRpeGG1G1ggg4Wumuy1i1smEJrQUv/a7yNvIJm2adJ9BAl?=
 =?us-ascii?Q?J+mKUIU0eARhOgoj3HGvLdZbesE6/e1L2rWNV0usBll0WUbRZ7I3fpOthJ3U?=
 =?us-ascii?Q?9FRwbVK/pzkNnjV5UNDzTChjBnt0GjJSNkAzGvtYJ8IH/aMEF2YcohlXL/L0?=
 =?us-ascii?Q?MXLI8PDHb0IY3ZqTUtfl/4OdZhFagC7A0WwUZrtscrWboNmvOvjvbSlhIVyE?=
 =?us-ascii?Q?Gn+UzJnhCtDGOsOIu92ZJtSIjnYCzAqkElr7SsC43C/C2ugwBwfRLbyogtJJ?=
 =?us-ascii?Q?/XpUz3LKOsY2oN+Ixr0zsU1noaVPBogI7+D9Lz66b2up9JK7JTOKw3WXIAN0?=
 =?us-ascii?Q?BxdSZgymJvosI4BABfGQ1OnxqdIQ5cm1DX29Wuft16jsUVMvR94odt3bfg+V?=
 =?us-ascii?Q?Q01ZVk6TwTMpThRodvCH6PsA9/o8r/ivDndPLjibMYQSN1lQy5wT9bcmlXgU?=
 =?us-ascii?Q?uoV/tzl69G2mEuUkN/5DFafN94xD/CWqml15m+e1rEm/gpgm552YtEoMYNcC?=
 =?us-ascii?Q?Ak3jdPu+gQpD4GQE6NM4JopFjzpYoU+KeDz5VPlfcXqugg4Ng0381XZhtkxx?=
 =?us-ascii?Q?96yMKfcH9Tw5RrSsur6Fl2445dzOMCw+0m5gW3OxK2YnUwjlqjfmuGaXUCoo?=
 =?us-ascii?Q?ECgCMHVSixP02WTqyYNqw+B0pRDAJyqlypyFayZbSYjETKoIhUL8xqjywgRT?=
 =?us-ascii?Q?GMXbS2y9zFcvBHU1QXcfv1Y19vZJ/iwJKjzg91g3/E1j663SrwllpxW74m9G?=
 =?us-ascii?Q?XEOgRanuYV/8Q1csXw9PIGW14O4gnwTtKvMfQAnkMbExExZfKCVkb+n2BJHM?=
 =?us-ascii?Q?gKvie+X8AoEybnFNU0tf5gpg21+7Wwv3KTZmT6rG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jVd6zZb1tyBsciEkTJicf/d14d2BjyTNuFS7f8SThXgZWuJ+sIGS2Ii/4UVRl7YfHpbijfwM54zy/zeO/Y/Bdu4qBwUEreWlH0VCPDf6M4nimVD+r6CGS/Iw7XtAnNKFRJlrq3/lU8sT7ELVGDEuTXfoTNJH46ThvKayuByBDEBd0JscSVjAt3LOsraAR/PtzzHZTxCc5UG8YTwm0HLySb3sWLaJY4RlnpZZxjtt0xq50q4l8DinhJVAq2i+ZT1iQch4cOgAQvCsQFhcSsSvBdwjtsAlhOD978cBNvqAMhVguHzXwggOMZes9r3cy0WvfM6tSigy66omgzmOSlFpZasc9p6Uzyg2nYSlzEarWu0S3YSblwowYolTN/5zAmTEvaJO1n9YSCx9Lrim7pGHud909ffkUaYheG/J04+qWPHudr9UBddjgwqU6RImOd40clihW81UPzQRklecTyV4lvs5SxHXYich+HR87hfJ3Oia1hpKqSJGvZfAJRxsZtclbfAnGw2yAkuk3XpTw9Kw5EHmdmx6RZNvAvGhkbeUgVPiV6N+sJfEFWuB4y2iTswoQP0/witvgQEiEK7JWg57UFvImeknXl7F6OEargJtEQI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c93e48f6-54e2-4dc0-0fd5-08dd058576c0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 14:54:54.0323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VYUV999gsGl3fMHEVKU+py733dvEtl+M9iXcbl/Km7imj6OGS3FVa7Xl+geIbqPnL9PJKTH5DeaqZoV/nlXCxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8167
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150127
X-Proofpoint-ORIG-GUID: 8IOkR6CaCQevc_oRvkzA5NTzYqfe1nWe
X-Proofpoint-GUID: 8IOkR6CaCQevc_oRvkzA5NTzYqfe1nWe

This change enables specifying additional configuration values alongside
the raid1 balancing / read policy in a single input string.

Updated btrfs_read_policy_to_enum() to parse and handle a value associated
with the policy in the format `policy:value`, the value part if present is
converted 64-bit integer. Update btrfs_read_policy_store() to accommodate
the new parameter.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 7506818ec45f..7907507b8ced 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1307,8 +1307,11 @@ BTRFS_ATTR(, temp_fsid, btrfs_temp_fsid_show);
 
 static const char * const btrfs_read_policy_name[] = { "pid" };
 
-static enum btrfs_read_policy btrfs_read_policy_to_enum(const char *str)
+static enum btrfs_read_policy btrfs_read_policy_to_enum(const char *str, s64 *value)
 {
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	char *value_str;
+#endif
 	bool found = false;
 	enum btrfs_read_policy index;
 	char *param;
@@ -1320,6 +1323,18 @@ static enum btrfs_read_policy btrfs_read_policy_to_enum(const char *str)
 	if (!param)
 		return -ENOMEM;
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	/* Separate value from input in policy:value format. */
+	if ((value_str = strchr(param, ':'))) {
+		*value_str = '\0';
+		value_str++;
+		if (value && kstrtou64(value_str, 10, value) != 0) {
+			kfree(param);
+			return -EINVAL;
+		}
+	}
+#endif
+
 	for (index = 0; index < BTRFS_NR_READ_POLICY; index++) {
 		if (sysfs_streq(param, btrfs_read_policy_name[index])) {
 			found = true;
@@ -1367,8 +1382,9 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
 {
 	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
 	enum btrfs_read_policy index;
+	s64 value = -1;
 
-	index = btrfs_read_policy_to_enum(buf);
+	index = btrfs_read_policy_to_enum(buf, &value);
 	if (index == -EINVAL)
 		return -EINVAL;
 
-- 
2.46.1


