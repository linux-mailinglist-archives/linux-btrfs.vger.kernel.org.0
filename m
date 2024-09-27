Return-Path: <linux-btrfs+bounces-8286-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB6D9881FD
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 11:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74B6DB25B45
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 09:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370A41BB690;
	Fri, 27 Sep 2024 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mGtqbsOj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kRhDlkDu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B602AD31
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 09:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727430959; cv=fail; b=RmfFs18mLXPs2cANK0K8hw21jGXZJhpN8UH+/Dw9bFXu3f0jSAd09IVHBaGVXxbYW+++F5M8OSQQW/gbMuG0qIUw5WURUp8CzCQ2QqiPwpYyjHjGxC/N0I/tHlRsI6fXJn/I6c45Fa/bQnzCvhSZUDhIWHKW7YtTFcGmT1l6EH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727430959; c=relaxed/simple;
	bh=+AaPlWwApIvYb7DKP24BVUWF8jk1AXXhobFnCW4OXWo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gT1lRb2z0mZKDSMudJ8Plk87KL6PCQR9qdYvU0HCuBKEWmbBt/xlnensDaUk7azAzC5pjTizeEFJ8ygke0DYOcw2x6Szi0rgllApESykvSns3hSB/Ac0BGYHAB3yg4EOQMHD7iI+Q3KZq+Uj3xVRtKMwuWMSqb8Y2KpRbaCCZ0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mGtqbsOj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kRhDlkDu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48R5hXJa017229;
	Fri, 27 Sep 2024 09:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=G/s3QunSBG+MkT
	2nYbwjOiYnkg6RjJ2R3n+RpxenkqY=; b=mGtqbsOjME3nKYo4/F3HAKsTXI7ohz
	ysITiYGfIsR/27+5dnK0a7z/xLlDFJP5cPQk8E4F1Bc/VleXYbuxAU+UcoyKkslO
	Yot5X54RXZdxQckfmtpyRiN2fiSXLfGkPuxnXBB2JEO4Wlumu4iI71ub4aE9ZIS6
	BLEu412qlZa0llgqFv20NMjjSgXhah+9oY7WajVHkegd9amXXfZICb4LsisJ782N
	CSeEI0mb1t7c4TSpTtI5baANY/gQm3MUYve7ONBydqsGzs+tge4Vszej6s9uoad4
	8TeIRhP52rG8rj83OEDIdo6naWzsBy/B3IC2F03m3Z7v0YVM/F+9Difg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sp1aq4r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 09:55:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48R9dcAF009685;
	Fri, 27 Sep 2024 09:55:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41smkd0tm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 09:55:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uw4VyA0Gm637DweAzFfybu38diy1NU7lBz7tLtzMGWVZGxrQHTAoV+dd//lFM80B3262LVWth+yMZRuyh2J8JhdR3rb6lQz7E8ZcTdwbnkYgETDnt74ZJyLSD+ySBhTmJvt6LBCTqpTYDwFsBoDEaCoHGpfdaOhYU+3T8PApVnMOLd8agVIaB8QHm5lV9Ku084GEi72j1kZRD6lCBYN+UOEZb+HoD3wzzBdgPysD4urRFQUjUUmIoueVBrHeiMJ/b+chiP3UPuUXmnQobwSvqOihRGaXILLMGRYQtrnJjVOr7APoR+XNNtPq4o4DM9Mp8LWSz2av25BuwJ81jA4+UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/s3QunSBG+MkT2nYbwjOiYnkg6RjJ2R3n+RpxenkqY=;
 b=lgJuXyD28ll/1G3bLmhGollTUJ6BkxWXTXKXTt8QD4YbRFguQNi08OXC0ZWAZCn2dXD+6LSs32II4YxdPERON4qVcNt6F/EApElGTpOIisXTWq+8Vn2AuJ/l+Sj15/YpVIT8Dgy2uZs0KkKvN3gOtN0WRaJlxTrCHFDu4b/zalnpLeTvTjEaLSzFyklKKi0r0zNd63mTlko3oVOqKSGTzDTH3yeEj9JbpHcaFqPNYIRojaLzFVohTdsAEZJJAOOyEZFXkPUhMdYIg7n9NRtEsH9vHtfUcmPvBULRJ+UlWVIIjiAjPgPqaZgRhP2ZtFzPud2NaU4+xlmC9b4jUL6f5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/s3QunSBG+MkT2nYbwjOiYnkg6RjJ2R3n+RpxenkqY=;
 b=kRhDlkDuHjCJgFdxSgsjpKwnY7piQ6afbPNUsJ7FCCQMhsG9wcuImNRs6icKG2yX7nLgcNNhhybe1vdzagRJSldqfBRCWephe+4y8UIztuLsdnUbkf6pdKwZEjDmbhvsETUPzT94uOJuAbXqSh75GSLHGfDyR2ndbSlee2GP2Ec=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6735.namprd10.prod.outlook.com (2603:10b6:208:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.9; Fri, 27 Sep
 2024 09:55:46 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8005.010; Fri, 27 Sep 2024
 09:55:46 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, waxhead@dirtcellar.net
Subject: [PATCH 0/3] raid1 balancing methods
Date: Fri, 27 Sep 2024 17:55:19 +0800
Message-ID: <cover.1727368214.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.46.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PEPF000001B8.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: d6b66d3c-2878-43fd-fcb2-08dcdeda8ef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bXilWHNr5RrdwDVMckU0iWih3kkts/zeP7Y5fjLg2pP2t5iHe8pLzDgaJ3Ul?=
 =?us-ascii?Q?sUF7tOeo+8I1ALglieIx/VOrmG7pjJCShdNrlqOTow+Rtpihwfc6i+PjJxD0?=
 =?us-ascii?Q?PaEAqjTUOQREwmD1dd8iPmqn2mxUX97Tar3OEHGf8TD/VoHcjYFfos2oJqSO?=
 =?us-ascii?Q?Hk4SSvyHTtmMRdVdsOHKc8bhrFfsMOCYDzrwdZPDMDRy5xwW3o1EYhLxnu3W?=
 =?us-ascii?Q?2hqarAi6PzVttp2I2/owpG9c23R0n/GaPDffdrxrFRqZ8OjRgcxEYrQWr4vO?=
 =?us-ascii?Q?6WzsWImgRUSwxbk83THGoCLeQ0xphHrTHm12Dq8fzTddgye2kjt8xs96dOyW?=
 =?us-ascii?Q?lN8AJA85C6Co8NIaYu0F/Hy1K4aNQO3NV6DyOcLvlpJOzwt1KrZVoe2qd+tC?=
 =?us-ascii?Q?krREL7C9sWDx/wCsn1Zxzb8uV3Z6W0HoZ4EtQ7laApZeYqszKEgtG77t2A9t?=
 =?us-ascii?Q?vhxNBEWZF+yxKX4LXq2n1CXf7ddnn4rJrVj14BVFuIDTNGj9cAelKwpXzP7r?=
 =?us-ascii?Q?1qQCN8YlKY/RZWD2JHg75iA8AnwBOafSlN/n6P3gWnSr41D3wvH59oYKfglf?=
 =?us-ascii?Q?adGTcUWrb9kdJnDO0xJvLNQ+zYP/1oJrdSs0E6Spd9DL6qmq7sJ/EFhjBVDp?=
 =?us-ascii?Q?rJjwb1qAcuoqWz2D93+u0I9wxoC3fpsw9ttuIa6T9z53W5MnWHZUANdvtPBR?=
 =?us-ascii?Q?pc+HUTizGHQP/cOv3PXHh7040RxXMYSWkGyXEYDgvxXU/7fP0xeUiY5jW+yo?=
 =?us-ascii?Q?ZUdY3EMYyMFM68F81M/6mWnHPV1iQ6qV5n2+jhOGUUl9rjOio5vJoBAPMIz3?=
 =?us-ascii?Q?wjfRTdbHIAQPOFMfZvLJv0Xm9fLcD04n90OghYC6MNVBf7h4gu9jCJ0+rT7H?=
 =?us-ascii?Q?r8U4bvusKLG9mLAkplpCeMyi5HPeCsNtm9OtrcrC3jJVFKo5rgDq9dqP+ZBP?=
 =?us-ascii?Q?aIsS5eSrWxfpbJC8jl3wBm0xKRDBa7sIC9vBXnaVyz3vLJFJ206VR2hWcJ4z?=
 =?us-ascii?Q?quLqT3aatkuVUxNZSh+xefptDB7tepWp/5Ys2/Rlf8B7OVtTSxLAu8EjLmUo?=
 =?us-ascii?Q?MNjEnPlE+y+ngLsYgX4VF9WxftObX0QLzaaXpznEjajZmUs7jKWHDV55VcXR?=
 =?us-ascii?Q?h76tDARp1XvFwlNHkl/iLUe/LIow0dhkFCbPMq+6AB3y0YLeAZ9EgJwYZs8+?=
 =?us-ascii?Q?MuBNXraT/Ei7vgdojf8K0oLORU2VYVHQkqf3pdJWKACUCO0O6GXeWSZH9I+Z?=
 =?us-ascii?Q?9Jqz7MJNKLjyNgCA1SVlaw2JlSVqQqT/gRqq4cAErQpiWl7wKyOzoyNJ3OuY?=
 =?us-ascii?Q?507mJIwbEQYFQFGBWYA7HTHK5J9xv2yxvNmOjBUYetvotw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rJG+7Bdw+OC+gXLaxetVt2fM0syQ8tCCSbElWEIXaeSYZGntEb9kqtiLujxG?=
 =?us-ascii?Q?AUP7wAimhAHtl7D0cbquSc9ON6WNfEmrkToLrt3KOIFgVIp2cig0o9kCI2L3?=
 =?us-ascii?Q?iyD8LmeQHC5GacQfoylolXAKR7kzNdaj5GBemRs2WtRbLJSUqSMYt7XK1grb?=
 =?us-ascii?Q?dc/rbK+xpxUj8DPJF52iW31Dgn10ZsfXKV5IMaByUD8Z3KgqOjDhSdDi6XuY?=
 =?us-ascii?Q?j99aIjuLahc9UwLgZM4GzQ6yO+rezEZ9AGoNbbyD4cr8WC4cLEZ8s3OsNlm6?=
 =?us-ascii?Q?i0ay50DKsuH08gmdqqiPtMp04CHs5lOIUDutniUuW8ELVi5HhiRgF5FZzcab?=
 =?us-ascii?Q?+0drXxkKb6e1FwrnW6Gq1y8mGuP6zUG63ZpfZ4QoIwk5xjqkFLQdMUdtDaPN?=
 =?us-ascii?Q?f7AEgOmED8BRXsKTUwrRPaCCVFQw6QLIzjK0A3P/ziLr9Y6Y3NCM1mKghRSm?=
 =?us-ascii?Q?9bQchyBTWLApXXiMeLHg0tt9N+mUFv1XkIyMBWP/dIbmq7xFfoX/l+7NdnjX?=
 =?us-ascii?Q?xrU47ZKq+D6njHQkmsVFs6kM8cNdtI1yJHBfw4mfwhHgDxzh1O78S6lh5Z7D?=
 =?us-ascii?Q?mV2mEmTzJRRYm91NKtjElQcKWlgtU/RrVKmZLlllAIONAiyw8zxzwU9mBPx8?=
 =?us-ascii?Q?96P9spljBcs2AUHmaGMEWMaQIwprepev11nqQS7z7COurp7OgdAZkBVR7RXB?=
 =?us-ascii?Q?wAQrLgSATxiedwMLl5zMF9GeSYIEQ2Do7PGbFR6MnYWBVMYGZC5P0O2maBrw?=
 =?us-ascii?Q?cbn5EHYJJA1j3vDtrJk/1J8RDAovCZQaoq8IBgC2bYd+zOhplS48UYwP/7Jq?=
 =?us-ascii?Q?2w31YRtggXsg1Cn8XlrmSl82rr25qmShmt/RRv47se5xQwl/+JCKPEoKbO6q?=
 =?us-ascii?Q?wDAzrenVTzb6nUGYPlikXjMhOcJ7Geg8n5l2GmyORzg3+pSLXu2UgSNzwID7?=
 =?us-ascii?Q?eckyptoYYqLFEp15/PqSw3Rsa+Dru2PGixZVQCul2ArplaeqfN9wEHHK1DHy?=
 =?us-ascii?Q?cSIJiaip+760GmNCeN7ccv2/zvUyQJXfjSHz9TfnqbHnKf1E/n9q4kjqn/PQ?=
 =?us-ascii?Q?nUOc1dZl/rzrf5mpFTDDRIOWEYMqF8b+hz+wxOHWG2qpp0+5KWYE7EZxfv1T?=
 =?us-ascii?Q?fCvYZCqAzDE2mnkKT2YvjZRDXYYF7N6c/55p5cBgVVXZHz6i38AHancXZEAH?=
 =?us-ascii?Q?iXfRf44n1RXgylrNcMH9W4qxPuWNtI63pxXWgezgNuZ745FZtMSBbychnk/n?=
 =?us-ascii?Q?8c8NLRbLXc5/IWPGrqXN01eZJ6Tra5Mfoe+pwLj62aS1cFBWhj4197joIZMj?=
 =?us-ascii?Q?JAdUp7NZ8g2mSj3fozI0s6SfH/pRaC/bldAkmwnFDeJXuHTUWwbbrw8xhAFd?=
 =?us-ascii?Q?jvcP3VUA364TQ/dvJ94yZEa1iGxf4X+DKHg4lvo7V5669CDSrXbWBua87ol4?=
 =?us-ascii?Q?SUbDP9LVylVc3CcYsUljE7CrDjuLnptp+kdKfZmyaNByCuSbJpxzU5/Uo+i6?=
 =?us-ascii?Q?aFDL9jLP1Z4KHgj/N02Cd1YtlC46WNbYqPP4wenApsBRLoIK0o6Jh9Vu/tMR?=
 =?us-ascii?Q?kEwUW04y5vnwq7pAcTNV+DX0XMe3u5rUEHSF3xSQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aYP5EQYxJaDNB4XMGjn60jbQGTQyzGnIEE9DjNY08VeyBp0YODXic/S1kXRn3vwGtOUsE2MYWdlNgT/h2bZPWSf07wxm9iIytLWbhRTgQLy2XaUcsgYEjt4jbGSQB+6rkO+Tmzp7v77gIgDdTlskH5DDQ0/mUw5f8lwhVRoNdrFNcabu/0j1Hp3MKPQH/ieXwKisV7kfLcAbgJILPvn64lewix6xJEn8Dzt1+iniaa9jZn/OYxtbUjFoY6Q9uWY8eP0ndqRH33fN1rIXdz/c8wR7SXjUo/x6SLhyHHWcTpvlVjdEAPjdZoM6yGHAnrivNT71DeyYXe/NR5fwLfOIZGNq1xAi7gUBMwleRS9me+KIML0++u8CpYSHOJVianPTep3zUJln0DTembUDDlbi6QRm41YzFAjPiVRm1qQj2Hu7GwB0QuUfSwzq7qVQhURza1F/0ejDZqJjNeIismL0cOMVduKzBEC2BunNLH40a7lDMazFws9gtSvj5DbSuuK10osoyMDsnhI9RDguvXpHPPmOu1LrUTwYYjy/3O9Au7TjW/HGYYJeKCRJZiGFRekGlAhbzFMwxHCiA0FqDeYRX5KZp9ZV80GmLjS++tq+mCw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b66d3c-2878-43fd-fcb2-08dcdeda8ef6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 09:55:46.6220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UvgvqD/SThAEvY5iXW6t6j65HQhl0Xc7HaGbfodBspCo5LASwxzif/dGsUugfLyydQwZ7ERVcNbkELEBemCZLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6735
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_04,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409270069
X-Proofpoint-ORIG-GUID: Z42EQwil6qFKw0CrjKSiMrXuFSH2dXB-
X-Proofpoint-GUID: Z42EQwil6qFKw0CrjKSiMrXuFSH2dXB-

The RAID1-balancing methods helps distribute read I/O across devices, and
this patch introduces three balancing methods: rotation, latency, and
devid. These methods are enabled under the `CONFIG_BTRFS_DEBUG` config
option and are on top of the previously added
`/sys/fs/btrfs/<UUID>/read_policy` interface to configure the desired
RAID1 read balancing method.

I've tested these patches using fio and filesystem defragmentation
workloads on a two-device RAID1 setup (with both data and metadata
mirrored across identical devices). I tracked device read counts by
extracting stats from `/sys/devices/<..>/stat` for each device. Below is
a summary of the results, with each result the average of three
iterations.

A typical generic random rw workload:

$ fio --filename=/btrfs/foo --size=10Gi --direct=1 --rw=randrw --bs=4k \
  --ioengine=libaio --iodepth=256 --runtime=120 --numjobs=4 --time_based \
  --group_reporting --name=iops-test-job --eta-newline=1

|         |            |            | Read I/O count  |
|         | Read       | Write      | devid1 | devid2 |
|---------|------------|------------|--------|--------|
| pid     | 29.4MiB/s  | 29.5MiB/s  | 456548 | 447975 |
| rotation| 29.3MiB/s  | 29.3MiB/s  | 450105 | 450055 |
| latency | 21.9MiB/s  | 21.9MiB/s  | 672387 | 0      |
| devid:1 | 22.0MiB/s  | 22.0MiB/s  | 674788 | 0      |

Defragmentation with compression workload:

$ xfs_io -f -d -c 'pwrite -S 0xab 0 1G' /btrfs/foo
$ sync
$ echo 3 > /proc/sys/vm/drop_caches
$ btrfs filesystem defrag -f -c /btrfs/foo

|         | Time  | Read I/O Count  |
|         | Real  | devid1 | devid2 |
|---------|-------|--------|--------|
| pid     | 21.61s| 3810   | 0      |
| rotation| 11.55s| 1905   | 1905   |
| latency | 20.99s| 0      | 3810   |
| devid:2 | 21.41s| 0      | 3810   |

. The PID-based balancing method works well for the generic random rw fio
  workload.
. The rotation method is ideal when you want to keep both devices active,
  and it boosts performance in sequential defragmentation scenarios.
. The latency-based method work well when we have mixed device types or
  when one device experiences intermittent I/O failures the latency
  increases and it automatically picks the other device for further Read
  IOs.
. The devid method is a more hands-on approach, useful for diagnosing and
  testing RAID1 mirror synchronizations.

Anand Jain (3):
  btrfs: introduce RAID1 round-robin read balancing
  btrfs: use the path with the lowest latency for RAID1 reads
  btrfs: add RAID1 preferred read device feature

 fs/btrfs/sysfs.c   |  94 ++++++++++++++++++++++++++++++-------
 fs/btrfs/volumes.c | 113 +++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h |  14 ++++++
 3 files changed, 205 insertions(+), 16 deletions(-)

-- 
2.46.0


