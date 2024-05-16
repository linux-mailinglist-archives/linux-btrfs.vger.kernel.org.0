Return-Path: <linux-btrfs+bounces-5042-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C68948C7506
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 13:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 507BB1F243F3
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 11:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D2A14535E;
	Thu, 16 May 2024 11:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NAzKlsO2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X1MNuXRK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413FB14534F
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 11:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715858000; cv=fail; b=d7nGplhTDVxV49Srat2H99kyP+T4mbi7p/aCEPZZcUYvBCLZYfh0pKU6Toh5TqD9UDGusUcdRMJHRYtbu+bixoulhBVbQY5Nt+KAKLhlPDpIto4zODhIYgiGr4VNU/sQ5g4B0s93znrGvHa4MoCY5YwaIAIIhDe/szhnijAUAKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715858000; c=relaxed/simple;
	bh=LyA79a7QPRdSNA9/t8eW4S6K6J5jzKGyXlMLNgsmxFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b8eCaVIF/5Kc5OKDViU9TE7+JLEw3p0SPMf7RIwij8q5qGCzTrXaI0GV6zR2thxnBvbO8GL78blxzbssulwiGSuFwNGXuvNPYzK3vWh8sXW76f/oh8ulmyXF1BiqNq4JWb7CSR2PSNkerJ7E4hJn4MB87p0cEv76eBTqe5yfd7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NAzKlsO2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=X1MNuXRK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44G9mf46001501
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 11:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=miSj5111mFR1+BnYbMZ+zfwuteooPL/1JsjHDM8KdeA=;
 b=NAzKlsO2F7gJjnoYhaks/uxnFNg2D6Fvt/SWUPHR4pbM/PjmKU0yB+1bMUvXG7wHOUtN
 f0dykyOd7S4hSEqThzKqLuxpgfcitdW2dWB5owurrztvaw4goy6cZKgjH1r2LkZ7hN5r
 6FYKin97+p7DlJy5dxMjqywOHGBA6vXfj2TrZbFVE8XVZlRbnwSB4zkD3WUTAPEiu/Wo
 geBZiLEzRgzGiGh25Bbyw+HLMjAhgvV/Boztnh50BCP3mpmXA6SvIapt7Bo6dDNX5xSM
 yAIdad/MYOhjlWRNHfryDatLSkuU2qG3H7wY50luB2FGBGAG5CZyz07WeinVAfr2DBzG Sw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3srrwaf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 11:13:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44GBBYG0019247
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 11:13:16 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y3r87m0x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2024 11:13:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUPojnMpLL7gPk0eH7ntwg/dtFS0x+cI4Rum9zrHi/SFQZvReCntfM9TddowH2isI2Ft53t/tOlsXQKjxx+hX20I1XEfLgc9Gz4D4Onf7Yy2x60/8fwehmGCLuOLVzWY+o5G14BATCOrGVOGP75ZCM8TM2pgHqRV6WumObv5DQyR3DycCbXav5ij+JP4PkNlAw8y3eMzhGZO3ZTRhgqTzNoW0+CfLQ6w/S0UJfNEm+dTVIar/iemDpuSM7PE0d2Mb10TQte2epR6Gjsqzjf6vQXG/zus4htLeJrGc7pfe02DybGGJoqCH2V3WjyVXbONKFVD6bO20sFaiSoJVZ4Sqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miSj5111mFR1+BnYbMZ+zfwuteooPL/1JsjHDM8KdeA=;
 b=bseLRHvJRo30wEIpWT2Xah0Ximw5JPMVDj6RugVk65/6H796HW/K2iMQJmIntynpchYXnloaI+vJDZ9mbywXfFwgD1X6FHRwbe7eKbhLO0WIiESgVBHH6qLRyTZguwfEiYr5f42srMKU11p9jczCkPxGXKzUYaRZnRgbHL136vmgeWSknRoB4yYBAJh9y9Vwo7dbW6/obFpjVdKi3Grp8l2l40QWyK6nnL9WPajAfNllI7Qn9VyXrGBLn7t+iXkFO29DeBr9GA5DaPpLhYCFMaX/vKiopMgaFU9O1ffK2Oh/TtIVLcm+21VEh1da+FpoaIjp3LFDWAAJCTWx8BviyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miSj5111mFR1+BnYbMZ+zfwuteooPL/1JsjHDM8KdeA=;
 b=X1MNuXRKzF63H4Kz5tEuKTykyisAeKvNJl5vh5DDb1JVoThB7tRcaksFogJxt04RamLQ8RFTj2Gcr8GzRjo+d1O9nQBdiwFL+qhRlxbAYriCIHByghh2QuZUHCqubhMqBg00ZWrxPaiaYCzxpBMwDc7tkHzNZzguXRqiKE/NDlM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB4345.namprd10.prod.outlook.com (2603:10b6:5:21a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 11:13:15 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 11:13:15 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v3 6/6] btrfs: rename and optimize return variable in btrfs_find_orphan_roots
Date: Thu, 16 May 2024 19:12:15 +0800
Message-ID: <7b9f87e3ca3368648e9df1d124161a6d4b8e1e9a.1715783315.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1715783315.git.anand.jain@oracle.com>
References: <cover.1715783315.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0015.APCP153.PROD.OUTLOOK.COM (2603:1096::25) To
 PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM6PR10MB4345:EE_
X-MS-Office365-Filtering-Correlation-Id: 97a4c2ab-fdaa-4287-4f19-08dc75992e64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?fN0e25SPeNTlCe45AvWmBRjD6dsFEbDJ0R1+2h/nBwEvOf4+6CCR+CP8M5fO?=
 =?us-ascii?Q?iJDZgT959uNvSNeIk4Kn4E72EZjuUWDA1VwtklTP4qmRvJFYCHHTD5UPaxi1?=
 =?us-ascii?Q?jPFzcFGtDyFS9CYtc0fcuZzzPp9D96FJYvW7LBbdvqisn88WTUUHRtoEx8xW?=
 =?us-ascii?Q?Hj4YdJbzo2VqPyVvc+mp1ySqDx9EdZK4Q6sP8qxkSC42yA3fsgQpaHTwWEi7?=
 =?us-ascii?Q?AYL1csIPjFfeyOi3a6SOD74vM5jrbdKbA+MWMRu2VZivirdof19dRHzhzYcC?=
 =?us-ascii?Q?Rs5lUYAeOcYSnomgG74/qELP44rPjT3KHR/E4oJoimNvVZuTnso09zoLlUSI?=
 =?us-ascii?Q?c2A8DBlJ4ciOXP2iNyerWC7VMASEiUkbTPQGR9w9bj4x8Y77O6A4V2oJWeNd?=
 =?us-ascii?Q?WGIYr5Ii1QzKZhpTFf6HYOpX/Ywxpd5mr6JlDI/Jw72UAAhTaX6qJRHDI/zV?=
 =?us-ascii?Q?ShF8YhhFKL+rZxtiO+JBPxsnbKwH7f5xNQtkmAWjHV6qQT+7PcdR4Bqz1kCB?=
 =?us-ascii?Q?K5Xa2uhN87mkNYOBxmMLU5MRyn2y6tM6lFnAZ4o7fTHXx2FdvXD08Xlb7TH6?=
 =?us-ascii?Q?5Q0Husq8B5sWEM11PZ8r3FFOXke1BI0JYZ/TYQjRzCjoSIGO9J2eaZ602T7H?=
 =?us-ascii?Q?+Bgpq1w4ogmYLQnGU6mJFRywTTRtrwuav7yKr/b66LUUyu/v15TcT+G90F1B?=
 =?us-ascii?Q?iO/MkGNmfuhV7VqXalg4QVgwzL0UB3jfh/cvnQtrGHFCr8r6uFv/eizVITwx?=
 =?us-ascii?Q?YGqIZmLOq3kDAg7VIMZgjKMYAtnfKtlzF9TsViZDuH5sqF2laA+6LNlshnVY?=
 =?us-ascii?Q?CPVCA9sHGf/GLi/3MKt61N80TZY/3BmZprGNh2QCjDLaf9r6+RtvVPqEoO3Z?=
 =?us-ascii?Q?rBJoxi15UwunqCZprTKGiYoHancXgc2pigD3ApPtaYyl8omSmrFqFSGwflQz?=
 =?us-ascii?Q?HFjQiuIJNWi4psL7SBgs38LxeloaZwwQlmAYU+uEPdb8xf0j1czw69SlnBD2?=
 =?us-ascii?Q?v6GJ8N3ytOQJu9adH3YkKkSLmZecxUoFEyiMKmTkcnDUn3kMWIeV6trD1Rbx?=
 =?us-ascii?Q?f2b4eWYLvaEZ9+XJfmf/Cj4FXsVRWgc++ZV1VYvwNVhDrQ9ADeNQ2VBir7Ct?=
 =?us-ascii?Q?nvNtItIovLJC26tXo+p9aC9uKSa4bRWhjoqgLW62FLwSb2qS+Cb+TYCLykiD?=
 =?us-ascii?Q?DIElhdU7ySw0M6fz+d4ltdUYipXQ4lHSa3aRUHNN1knj9c4fh0XOvTd2fGeP?=
 =?us-ascii?Q?kIJURzkeuvuuTlA8ROYpCIstnUu0SjZkQFfFPpb9Vw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Alyrpxzh0RVXUgTTWgqgxQWwdNFVMveFLduQiNhOyDnTSB7iaPKZ+wuNFwpD?=
 =?us-ascii?Q?nBscnjQZak/QtnUJOvKToWaJGZxSbC5whmVOZb/j3teKpWlKNzcp1hxsFW5R?=
 =?us-ascii?Q?lrmzMHhDJucDuf1FBatF16wxaZglbn0kbUlidiiCbhQ7LFvPHfAayUdFe2tk?=
 =?us-ascii?Q?sLXhtjWean82D0wR/qd+Y0eH0tF3f3TLYkHAEAJkTktiMYUPb8wktct0AQRn?=
 =?us-ascii?Q?8ZVe8/roLlFzaw0avBJ7IpzpGWu6XcziUiymN1vzvh4Mz0C6oqPcaWYNX13z?=
 =?us-ascii?Q?HWPUx3joe1SjFE8X+ZTFh/agbq274+ViD0xjWjbeynxG7mXStM+fk1TnD9Bf?=
 =?us-ascii?Q?/ATgjjbYuzUf3vv8h+UdvWxRZHrtEn58rn0FE+z4zF+2eB4PCC3ek9AaNuUp?=
 =?us-ascii?Q?QNUdnm26pnjPP50ePD31s94Hv4vzMI/CwMGOhTN0ReeyybkYwnNzTzFItjta?=
 =?us-ascii?Q?E8/4mctTCv22r9GACUz38ySWyzpaRuCX5xSL6F3vJ+Dhit4RrFZELu9bSWCt?=
 =?us-ascii?Q?Kp9h/uUy7fJu4cTkjIrtJeGJRuaLPC/IZ+N2VG+LpHFBEAgEc8aG0Mdtylyx?=
 =?us-ascii?Q?0zvmjYQfr5gDjf6qjZDGJ47Np/tt6Eymc3aeMDungTSbiSEs9MbvRZT4dZft?=
 =?us-ascii?Q?yMH5ysa230+mwv6patGoRsOf2/FFmeLpfGMX0dj2fUu559MLt266ZUef349X?=
 =?us-ascii?Q?UrHrdGbWqpXw/W1p8AI3DTl6js90M6z93gBqzNtBdMsehwcrAyd6Sg3cdfTV?=
 =?us-ascii?Q?cILJXR4308MXBVmAqCu/Fyr/eoCkJR6BUqhZsSbH9kfaJXm1/6Vaugwtx8tE?=
 =?us-ascii?Q?PxHEWfNsUof21uINhSTPjErFHLky1w47UKjPBZP/tKnm9fGlXhc92AhQRFjb?=
 =?us-ascii?Q?whwfqb/KV5rfGwu2QB0G+hMLFmlPjxDsb61ZdiWeUfsYDXZlwdDOnK4rvnGH?=
 =?us-ascii?Q?tVMPBKIB0yJhe8ZLPgD/AMAPZHLFK1Pxps4rVOyUv9RSOAmaOeTrpdW/HwbN?=
 =?us-ascii?Q?DceBCg0MrUSdVcoceX5YORPVoTekcHxCpfB9NI5uEAnnsapB8kPUTRkOmwt8?=
 =?us-ascii?Q?QMMgltTzo1+gerOpLLyl8Sh/yEP/QBOhWSt7mWlhDA0DRYI7Kc7G+K4AUtLN?=
 =?us-ascii?Q?I8PGv4EjstxS8XtK6fJ6pI4r2RxiI1JDm7sDlQOQIw7Xi+2G+gX9lm2Vt6C9?=
 =?us-ascii?Q?qa43hHXzSb/nTfnEQRFKUvU7O/pWrusF5JXvnxB9mtO1DWKKMw5yDaKLvlJz?=
 =?us-ascii?Q?N/JNSG7bTJa1j7Bbz+G6xrw4blq/fVg+TUOfhS9GieJrW4J1wPTtpabM9Dag?=
 =?us-ascii?Q?PY/l2S0/UqgvRIHV9npWQkqG1ypSGvDIYrUGbgDCtWkDrW/gDWTbwPGTiHzW?=
 =?us-ascii?Q?CZ96TzCYwGWjMaEEDCctv4I0W0mzDol05ys3m85ESG1PZGZSmgQaaE5XB8QF?=
 =?us-ascii?Q?Jj/ibNL/APRdK+N4jRE0/wsCAzUQ+ajE9yOAJRCW6vuGFhmUnpIuRLDqBAX1?=
 =?us-ascii?Q?Dnm3zpCLdaHoifDiLbIJ6LM8sIXMcb/fGQGGHLmg/foguD6tuZ3wKe78SDRz?=
 =?us-ascii?Q?VIsCXFrKTAKIJBiEXI8qA/NqenT5TDF3SQVxpa3Q4rEL9LU8QB3kq92H+th7?=
 =?us-ascii?Q?eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lE+psyABcCKYujCt2bHLpm//iDqslMC/SNkOhqzpCNw6jmejRyQinYo2fQTZLNcFs1UhkRuz2Azo3yaiV8iT0bGl8SnppgBwaIhMmzAUDbp1EYbxuS7zroa0VwyvEsfVOmA1RzK8i7+/6Ek+ewrn+B6IWokEgUpLi1f/B3A4bFp6qbKdL1IjxImF5ZYHyyNPg0GO5VB7XZnNov5qhnoAvImjAlE3yigLSn7LPi1bqqRRzr3kHvzjO5j109+4SzjXsmGlMQLdoqHMFmL7qgFsnQM5aX0MO1NtVu2XWjB/KY0wqbsXp4J2YzPEVlZQseR0QC5JHZeNSmO0NkE3CjgoymtKeRsds1gJGZV3XzDTfeqnr97rJeoz3FX0ydLEMGD+MD4Az53RlMl26Rxswr+dMeIjLI56zPAZpjSr+t5S6GI+oSMxm9lC0vnYDtUxEzuR26XdSENr0wMQH+Dly0TkGz/puPAr9re3b2bVwFrKrJLF75t+kQoeBmO0Dw3+fC+RDaGsXTd/pCHwfxSrRvXgUWORNT7e9gIEAygiLGU8qJu4wQL2dy/7XylPK18lAhX+jVoSM7jcH270HcIODX1MP6zus/kI5zLrFIgnYZ0NpVY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a4c2ab-fdaa-4287-4f19-08dc75992e64
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 11:13:14.9762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nmL4+WcJs6K5M3OVdV/kZ1kNvlhUbj8PLk2gzKhzC/TEVr6+7wrGEvfjqpIgDUHk/F4JO6keMr0VEyfI+QgzNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4345
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_05,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405160080
X-Proofpoint-ORIG-GUID: XpK2VSGM2XmsV3unH5nIv3XC2AxpkArm
X-Proofpoint-GUID: XpK2VSGM2XmsV3unH5nIv3XC2AxpkArm

The variable err is the actual return value of this function, and the
variable ret is a helper variable for err, which actually is not
needed and can be handled just by err, which is renamed to ret.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3: drop ret2 as there is no need for it.
v2: n/a
 fs/btrfs/root-tree.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 33962671a96c..c11b0bccf513 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -220,8 +220,7 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 	struct btrfs_path *path;
 	struct btrfs_key key;
 	struct btrfs_root *root;
-	int err = 0;
-	int ret;
+	int ret = 0;
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -235,18 +234,19 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 		u64 root_objectid;
 
 		ret = btrfs_search_slot(NULL, tree_root, &key, path, 0, 0);
-		if (ret < 0) {
-			err = ret;
+		if (ret < 0)
 			break;
-		}
+		ret = 0;
 
 		leaf = path->nodes[0];
 		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
 			ret = btrfs_next_leaf(tree_root, path);
 			if (ret < 0)
-				err = ret;
-			if (ret != 0)
 				break;
+			if (ret > 0) {
+				ret = 0;
+				break;
+			}
 			leaf = path->nodes[0];
 		}
 
@@ -261,26 +261,26 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 		key.offset++;
 
 		root = btrfs_get_fs_root(fs_info, root_objectid, false);
-		err = PTR_ERR_OR_ZERO(root);
-		if (err && err != -ENOENT) {
+		ret = PTR_ERR_OR_ZERO(root);
+		if (ret && ret != -ENOENT) {
 			break;
-		} else if (err == -ENOENT) {
+		} else if (ret == -ENOENT) {
 			struct btrfs_trans_handle *trans;
 
 			btrfs_release_path(path);
 
 			trans = btrfs_join_transaction(tree_root);
 			if (IS_ERR(trans)) {
-				err = PTR_ERR(trans);
-				btrfs_handle_fs_error(fs_info, err,
+				ret = PTR_ERR(trans);
+				btrfs_handle_fs_error(fs_info, ret,
 					    "Failed to start trans to delete orphan item");
 				break;
 			}
-			err = btrfs_del_orphan_item(trans, tree_root,
+			ret = btrfs_del_orphan_item(trans, tree_root,
 						    root_objectid);
 			btrfs_end_transaction(trans);
-			if (err) {
-				btrfs_handle_fs_error(fs_info, err,
+			if (ret) {
+				btrfs_handle_fs_error(fs_info, ret,
 					    "Failed to delete root orphan item");
 				break;
 			}
@@ -311,7 +311,7 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 	}
 
 	btrfs_free_path(path);
-	return err;
+	return ret;
 }
 
 /* drop the root item for 'key' from the tree root */
-- 
2.38.1


