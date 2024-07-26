Return-Path: <linux-btrfs+bounces-6710-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DB693CF1F
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 09:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E675B2286D
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 07:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204D3176ABB;
	Fri, 26 Jul 2024 07:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jPumGwHV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VVouPLAq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CE12F50A;
	Fri, 26 Jul 2024 07:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721980565; cv=fail; b=C4l0j2ZjkWE+eDrbAii8yw8U37UvQqNCynb9Fu+QNWB4jJExgX1DRxRVn7xednUK6AsMr4ml/f0oxQfqjd2SYJN+DBTruFIuOQYPb7uMDE/XJ8Byggl7X1Kdb3GngzbZm5/9BGDZisPQacJj/1JLaBPEQVUvrcb1yCRDOOX1KUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721980565; c=relaxed/simple;
	bh=sUZi0RGU5XixQFzVuF9bIba/RtPImh81xrXZEyYGH+k=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=W5mUc+tjc5RVFbGKNesH88SDQWVBzgWq11aezVBf9gfkUeP5DEZa66zxcarD9ek6D5kvBzENByCAtlokZGu8k6r9k3v6i+p8zgSj53gohCFwVKt5/QoDVSpZU9tcZwid3e+ZRA3DKakkgPcEXA/qdoGQW75+eTIwrTINxZEfXeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jPumGwHV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VVouPLAq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46PLhYnG007958;
	Fri, 26 Jul 2024 07:56:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=Uw7AJFFPT5PnHy
	2Ylil52sVrQ1Kw/jf5JAW6m8rPZ4Y=; b=jPumGwHVWu3dGUc3thx+02Yx90FQ/7
	PFtYvFetQb3fAL32onOoPUgN3jkG3Iso9e0ortwVp4udqxlWUikXQUzCjfitaGtD
	L74woSKwcinXA6atE7z2qrytWdfI86CO5nMH8v2f4R5rlJiG4+9+o1S+U6+vOHVG
	IoZ/ndtXg8OYtxT5HY8sh4wFvgfVVffMVJK+QZUgBWQlxYSwTYDvOXyt/KsvUiFj
	h2xrzdEFXlthuqgGXmwGmzWqm2UWUnXg+1ykDrjj6qH8syMdOutYesrKzhnaANrr
	Sxl6VMwqOQYt+QTpBuGCrI/j+A1/WHdrX7UG4YWoRYR14ZBUrVH9VgAg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hfxpn8uj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jul 2024 07:56:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46Q7HmZs010695;
	Fri, 26 Jul 2024 07:55:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40h283gg1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jul 2024 07:55:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgGNQs2ULDnt1mtb0o+ID/nmuZeX3Ror7fba0DUuD/DTSCb0gresUzC6E0+iqwgrmSEj9R9Nrd6nPxwHgxblsVCs7BW9JLcYgy+4aGZS4QJ1zTJpVMTCQdANzA1eyF5OoZuBU+XyIPmPPVhYR5PhclFfg5HMGPuiJtPqk/a7j5wHngvlViWNgmdnYboc4EZTAXz7dioKIexeLxYaJcifRGMoaYvP/FQ9Yvknsgi4WQj/iJTlI9gSKKOhCQ6dw+1rvKabrojMYfL41rSEOKVDFVmzmdi4k6X94gBYQMLBdxXcPsfCKXA/hdkGCYOQVAQOLMbXzQDKPVl0w75jXwzLPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uw7AJFFPT5PnHy2Ylil52sVrQ1Kw/jf5JAW6m8rPZ4Y=;
 b=bVNlzWo89ROhHZ51wzcUiKjcQ0tKBEYx+oJJrI6VpIpmFpY8GDLcZYlcADxPVEu11SJznoN2w4cUJXNBp242TL2x75JOpdyYaxbx0TrSoa3ihC/2x90kdiBm55HOmxs8Qx4PdcYEk+hqnH3sfNg0DI2cAr2FfW3LEclOeYzq4c1HokXZVAfz8K/CJHY8pedDxnkNy+gW1qsZq24H2HQctRIZ53LZB1l7mAXxDoR51N4VGGTQyD9IPhNhg1XTmM10edTc23IOQODOkCzQj4KsOK954j1uBLLYpgEkJTqI3zEK1aw7yPOVksjulqbZL3TB8CLry2tFg+BDpqFp7Pa9AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uw7AJFFPT5PnHy2Ylil52sVrQ1Kw/jf5JAW6m8rPZ4Y=;
 b=VVouPLAqAhzXpq65Bdynx9OoAN3ld0kMo5uKPlRgh+egbQ8Z8LW8iEYOI23MLqK+ICMStOASRJ3s0OKnSYqVxA0phwFy9PzEXAcrdyZ6CpJeVIfCEK8n8JxUyeAd0uYeGMgYGQNOcwJustLngCxnPag+VwUO6rqFV7hIz2gYkp4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB5647.namprd10.prod.outlook.com (2603:10b6:a03:3da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Fri, 26 Jul
 2024 07:55:57 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.7784.017; Fri, 26 Jul 2024
 07:55:57 +0000
From: Anand Jain <anand.jain@oracle.com>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [GIT PULL] fstests: btrfs changes for for-next staged-25072024
Date: Fri, 26 Jul 2024 15:54:25 +0800
Message-ID: <20240726075503.24386-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB5647:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e0d372d-5fa4-4765-e696-08dcad4861de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0bFELvJ9uG9Gjxb1nZgRKy7+8M270Bj87h8khiNc6/a6yKOx1+BWXWgsjWE6?=
 =?us-ascii?Q?dy+nbxYDvRd2lFikoi+6GZMNmMqZ9+85yjev4FnKR/ObuNg/SA/3xedhlORg?=
 =?us-ascii?Q?IN13IFLCgQqWX1+DgTX3HfAXg61e5ZoKW1rgYHQusK7ZX+bI5gvXve+YO44M?=
 =?us-ascii?Q?qfzjBHxnBxq99wp9vDooz4SaDrqe7IbP8BRk6YaxfJ0twwzmPglv3FYuWUDs?=
 =?us-ascii?Q?QvtnLYoxFTbSBpC0Vr7H4ob4XTTBmD0VmuRIG4Pr64JTFciACb8B3+GX/Byf?=
 =?us-ascii?Q?q55NwIVER/v7i/zbLhxfGaCjUte3pRaWRi3ChM2MjRRdRhlk16HbInDWkotp?=
 =?us-ascii?Q?x7Ouc6k7guBdT1SBKuqSE3JwUVznupJJ4Foy7NmuJYxaOQkmxhr/fywJhOmK?=
 =?us-ascii?Q?9xhEC1yPWwaabgLVmKmgdrrHGJXbGpjmFy4e1wc/xx7Axsjjmb5evcOzHoLF?=
 =?us-ascii?Q?Ve+5PKhS4fNFhuqUgju5c6bsSPS05m8KVHQgMIwACBMOt7fUyh8PtImAas+F?=
 =?us-ascii?Q?n1ok0Lfmhb99v7n6766RClrj3dF9tsndKBY6sleGk+FW+sr6hbZDtqsBhXbB?=
 =?us-ascii?Q?SXb9qa3og4u4OuUya9IQqKUfvDO89RO+5nFdBOaqNa1+X584Kjj0GvbB0Q/A?=
 =?us-ascii?Q?9GxJ7rnml/LyIvXyY1Y3xYHhuXd8jp75qvN1l/LZ5a5mJj1jqbNoAu687eDl?=
 =?us-ascii?Q?KntuMpPBTWK5y49PPwZScLz+MhIc+hQQyrnWz/5Pl6vkku7QFR7ly2YTEXpC?=
 =?us-ascii?Q?y7azcx5PIsJdZc0nJLJtP/Mk79quXO5LRRnydDFdHst2+3Oqsv+x4WT/lQx0?=
 =?us-ascii?Q?klpRxcFlREmlsqzP7dikd9cY4aWt8Z/CGkEAF9SMLze2do4pDEauIpzfJiGL?=
 =?us-ascii?Q?UZKD1SnXEsgsVtU8TPaGIqAIKyceGbZ+EQEUsaXqc/3R8T7BvFdvGf79pwDX?=
 =?us-ascii?Q?/OQhNFNzOApzJP3r1gh0+PZacp+IL2WUPjZckra7rFFM0pna2ktIomi/W1++?=
 =?us-ascii?Q?XkIcwBQl7SzcMQYxWj9vfR4g+82M+fKhsApMqNk812fSwhe0EywxgCrURh9Z?=
 =?us-ascii?Q?6uug0D3syOhqmP/reoX2sH8V9CJC4Hq1gLY9vC/fPUI0kENktKkGaSOybjIj?=
 =?us-ascii?Q?HvpXK73c6iH4KiSIh8qPgKIiTiZY53luxp+eHgARcfxDlomPJxZDmzpxNwQE?=
 =?us-ascii?Q?h2v+aw9lqp/TVoMnjhI12qrJZ7q6GbKEtPFCKFQezuI16T5CHOGYpSoSWs1S?=
 =?us-ascii?Q?4OQ8s47rMOVpIwS+IsHaNNCyTLidzk5r8Ic70WH1RA9bis0n/WGbMf54K78i?=
 =?us-ascii?Q?7XA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EN7Ig2p8feI3+nBFx5ezW/GGD3FtVD6B8Y26eqjGS26q8ut6/l2rKg/i1xaX?=
 =?us-ascii?Q?nYgfMh7Z2sAiON9mIISsEp4bynV+zpxQmitp4pK04B13uob3WxR9NaFmj19F?=
 =?us-ascii?Q?fa14HS0zK4zFr79FmVX6Ke+fIJHBRBKnv3jVYQlGNAUib5A3iTzalVU42yVz?=
 =?us-ascii?Q?Ped2OcI3hW301FIalw0X76W+/mh6NRBVWpVVd0PtoEYDsR8baGiWuGYjFCcg?=
 =?us-ascii?Q?xjPFC8EB1V1K4/RqjQrI82Peyv8CggoN2TNp1W79yB4zUQYuxSp2IzEY23FF?=
 =?us-ascii?Q?Z2pMNqJBBCpehGfMGY5KeYRg2NgLj5Gche8Ac5Cg6DLNQenAJfml5GJhMzKl?=
 =?us-ascii?Q?f4pBjiH8V0aEso6Dc/Ms9nlodIDMSiRVaMvnWVYWuQsmI+m5Xk/lg714Rmhu?=
 =?us-ascii?Q?iN0Hb2H/3lUOJXtYSvXBGvBHRj1czA8AFxVg2wytSa4CH6L3iJuS/xzQ59ZI?=
 =?us-ascii?Q?5BmVXcpXk2+99vdox8O04ngvK+r0c3GDA2JXz3/mgFFLlJ+KCeJzKLDoxpNZ?=
 =?us-ascii?Q?0HJ68B3uHZlRdBgWgrFN0Dg01xbQU6GqZOFJtiKUj54pMoXbWyRBhhUz8Aem?=
 =?us-ascii?Q?LD1SdwPgSsQAtL8R9NLF0BusgKEZhvjEOOkasbrsdvN9jv12muyNWfQrKAY5?=
 =?us-ascii?Q?BcKYnHxoTeMS8h9pZ2EeOCaTbNZJ0XuD/cu8Vxj0VKWI7ZU/+vD17K7F13s7?=
 =?us-ascii?Q?DM5Dck8uxdntUk6AekTaVGGKPSeA6vflmlMqispQwBYfWV1eTN+RF/V2aGa7?=
 =?us-ascii?Q?MEXdkOQHwtq6iayjxefOvS9Hrs7RXxhEUS6Hdg32xIPa7kLXGhgFVY4ZOBDb?=
 =?us-ascii?Q?bP2n+/4fklVCuK1dn7dpUOLxRNnHyOZeJdSnKrC5buYMF/VUwFLEgW27jCfB?=
 =?us-ascii?Q?cv9o03SuoPn1xcTx/fSZcDtuMdL2pXnw8HIr1GA8KQD155iD77gIpdr1oTda?=
 =?us-ascii?Q?x2SejRvjtse07FuKA40QubqQroJ93QQcS/OXlFifn5FhtoVtjrol5jgEdTrx?=
 =?us-ascii?Q?6dDmV6ElHWCbxkWGnQdgdlwAK69zsewb7RQPPl7MPV3/Rh3s+jUnWOFvjgF8?=
 =?us-ascii?Q?dmXx/X1WT+j72BVyrRut9c8nMU+y+E4VXMgbAgmag79+vZdGIdUoqDT7cLW4?=
 =?us-ascii?Q?d8kHLMEhNcfaI/VrVLuYNkBWnEmz6EZXj3L0VckNwdlykjxLCoaO9vcsi5xS?=
 =?us-ascii?Q?OMesJ4UAvtla03E2wCeXHxqNOyVxcgKhTdy8sF9gIgVhVK4eVvmjIpeEkWw2?=
 =?us-ascii?Q?AHgCP4OXL+S/zoul6iY2gOgB6No3sGRNuAx/uj7YezVV6HL74+lvP32ctqr6?=
 =?us-ascii?Q?MkXp1rAp1eeelA+62hu33eBXJ9hzSHFUtSUbt1uhilC7xog5EMnaDA+P0IVO?=
 =?us-ascii?Q?dBr84D0QzeIk9NZY5NeKgGUYzOmfpFa414UF+ygEzrzXvNlshu033gIEnFBs?=
 =?us-ascii?Q?nJAxZxvS3IhxlvCQwQea7gjgzxVWjyalma9SUCj94t6fmD4KmljWRo/JIa8a?=
 =?us-ascii?Q?uyCU7fYxIbZtd5yPysJuR5euczh0kqBibiAyBb8+a+s2M7lpzuBScK0Bdc35?=
 =?us-ascii?Q?rPOCafHW1Tzvoi8ll650jd9+BXy9QVGcKIDgHxto?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JX8AtkbTSQ+vLmKZU+bfS9/v+VNzHH1SRkHIU3O0WmGJcomKECyTNGtAmnsiHeztRwV76OIqh3fe0URhDC2BdT/KwSuh2+cyBVHFVg0KvCJXkTbqwyi18os2kS0ZF9M8A5Ueyw86BFiGW0OC6B7Q6nuxepchftS4yY803aIY+rW4uf4ZQ5meDI7Y/WDdk5fcNeO52H6PCa4xD+565mgVxP0n08ztKvby+jXGnGK4MkMui1NgHK+QX7pnCbRgCNuExofBIPlOpwjeJMwfRME6Ll/GPMiFsikgRNYzdqZ+CcoEyH8X/MlRmQpg91slFQtly3sUwQCQB7AmOgm0xh5xXgMGnC7TSp6qphjwZXSyTWzGmWm9Ql4KsLWb5ptfzv/SmUTBZaJP/K9AhxyT4UmC1Dl8JrhKHnmcjlLOfDKsrNzKQSk3QPPVO+mO0f1VeUqitaCcfahDVuXU4dBT1TbBTtf0ziDY/aIF67eDkLGr4k1bi3qOlkjXc8tipSMmPyT1RBpqBiWzOl5StxLVbjgChveg3pV5V9ZjDw5sxMoHEakp+Fco664Ac0X9t96v4OHfU7Ul7soLTrIXrmU8s3lQUTRJb2rTKmKmvA4tqFj5fXg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0d372d-5fa4-4765-e696-08dcad4861de
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 07:55:57.4213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Pe8Rgs5vLGvrzsbJUqQvEhXmYjoaYIFNcN77dMDia3VfPEAQwFhdjR+fvMt9PRlfjHlLd1UFjO8fY6mp3l6hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_05,2024-07-25_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407260052
X-Proofpoint-GUID: aapDG37I9oYB8qkmUYaRz68Y8i1Pa9dp
X-Proofpoint-ORIG-GUID: aapDG37I9oYB8qkmUYaRz68Y8i1Pa9dp

Zorro,

Please pull this branch containing a new test case, btrfs/312 (compress
send testcase), and a few other miscellaneous fixes for btrfs test cases.

Thank you.

The following changes since commit b3b323777a54b6883d3254c06cf0a840e80e2465:

  btrfs/081: wait for reader process to exit before cycle mounting (2024-07-13 03:05:35 +0800)

are available in the Git repository at:

  https://github.com/asj/fstests.git staged-25072024

for you to fetch changes up to 02a689b7aa074a80427e11d4a0cab90e6e8e5985:

  btrfs: properly shutdown subvolume stress worker to avoid umount failures (2024-07-25 19:09:33 +0800)

----------------------------------------------------------------
David Sterba (1):
      btrfs/220: remove integrity checker bits

Filipe Manana (2):
      btrfs: test a compressed send stream scenario that triggered a read corruption
      btrfs: properly shutdown subvolume stress worker to avoid umount failures

Qu Wenruo (1):
      fstests: btrfs/012: fix a false alert due to socket/pipe files

 common/btrfs        |   2 +
 tests/btrfs/012     |  29 +++++++------
 tests/btrfs/012.out |   6 +++
 tests/btrfs/060     |   9 ++--
 tests/btrfs/065     |   9 ++--
 tests/btrfs/066     |   9 ++--
 tests/btrfs/067     |   9 ++--
 tests/btrfs/068     |   9 ++--
 tests/btrfs/220     |   5 ---
 tests/btrfs/312     | 115 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/312.out |   7 ++++
 11 files changed, 172 insertions(+), 37 deletions(-)
 create mode 100755 tests/btrfs/312
 create mode 100644 tests/btrfs/312.out

