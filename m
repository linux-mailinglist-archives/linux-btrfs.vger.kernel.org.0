Return-Path: <linux-btrfs+bounces-11271-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0236EA27287
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2025 14:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76AC0188536B
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2025 13:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BA2215044;
	Tue,  4 Feb 2025 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XlrxOPj3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qRi7tBuv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852234644E;
	Tue,  4 Feb 2025 12:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738673655; cv=fail; b=SJozUrqv6Rb/NRibQ6Sh8lbbEj+xn5wpaDynoVUlTAQ5wV1ObpEw1Va3j1mYiIll6ZepYn2DEG4BhGcGzhDOTXO4OkAuGYSXh6hqV+megqV/CC8tVv4lMdyV6vY8/dmnQuAfdstyoEtzu/1mPkAkY9c9aT/es4B8D/vMYBXK3Z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738673655; c=relaxed/simple;
	bh=Jv4hT3Ejpyu1bdD3cI6FbRmTLwZN/UCVuw4H0y6U9fc=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=KnhKyFjM9fiGtzA82r+hq/o2daolM5LkmmXsHpeDd4wFyMd+8Phl76HiLzfTR4kNn6lMzld+Huk7bcAKqEvUxl1E2u9murGV7T9EY+9alXs0BzXMKtP4RH4Duzpewnz9qWVUPbwYyq7pST5TMxzCOY9IuB8l+0SkmEfP5L/oM8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XlrxOPj3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qRi7tBuv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514BfqQb014453;
	Tue, 4 Feb 2025 12:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=OWvWWypQxJX0cnMHWV
	LcrbSiGjXF/QwiEoVG4rdpMls=; b=XlrxOPj3k2pIf0+rovFQCfVPMsIze9on6J
	5g5f2drPDmMFG0Y4BNbBBQs4j+GTNezeO6L9/CI6eKxE7cHnIvH8xMgZu2TvMi+o
	Ii+9vcX9ArSzoGzHNMctsqqvEGZiAopGgXClGD2WIEw8C/y/6A5IkOK35PzVq7Q9
	O5VTw2QcujR6cp6+odq0SEwpbQ0ah3vop2lnobEkerGclN1w0iPsbEOIxfUrWsAc
	TSzjfh3GUzZyPYNHtKnX3bg3CUH+x5gBVSYfCklus5ZQaThUkSD3b7tULpMhJd8A
	nrTTvTjB9s4187NDPFLlIGkJD/UMPN0Nv21yvo8RmNhlAugreqag==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhsv4s7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 12:52:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 514C8tp5004885;
	Tue, 4 Feb 2025 12:52:42 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8fnxv6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 12:52:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UbRgCohC9fSch9RUmpHt9csteWPevEr7FSxCpBUbNYQj4M1+8m+rJDlCY+l+8+BFTK/0KNc0OfXkDTHJbZvZzbazbG9zoPtNkV2x4EqFToXWNfSgo+pUieGBUmInFEPOZxTyct3YHkmPcR6qy1dALxE3z4hXe5ySZ8iOB1KuCbMj+1Rd8edB7baaNgi1xMfGGPqs29RDQLc0ogaJBHOu7TEnW/ChM+JN7usvAI3Gnwj4RlgDsTKALH8Avz2cc+hR24tCyUjeCLlHNxSgIS0mA8rFxO/ee3fhG84QrRKtfc9yKfZfBsYyv12ulMfRQMjHr0Fc1SNnbscR0bQuisJ9XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWvWWypQxJX0cnMHWVLcrbSiGjXF/QwiEoVG4rdpMls=;
 b=xELIFtLXK4R1sMuVbwVlFtRFkYqtS9M9WnWHa+Mb6+iRk1UToxUSDb4k9oOl6ekWT0DTcdd/2FwsfkgHNpqbRR0kAqk8KfpglXOOvtAKAJQ9X/yNYSe2JSz9aRNz7XiEnoF3xUS3MIhzAfdIZ4M2tM/5kWTyoSnGXPvfHd10tEAEH8mThqhfzJdpbdJQe8Om1QwiOfwER6EDUBsHaloIRQI3VotJ+JaZc7xg4uP8wiBztyCr067mAjZ1LNhV8GVRf3KG/Uw8OpgSatcLIB88APjRDW+/yyVBQ63vaEqNBO05BEQ9XNf/Z8V0maWjZBbhwYZocw8lS/Wsd590siFE5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWvWWypQxJX0cnMHWVLcrbSiGjXF/QwiEoVG4rdpMls=;
 b=qRi7tBuvd056J/mwhF3Mgg7MnaBqMOU4mXkMN8XNMFEKEfUxSZv/a/zWQdddqdIO6jIX+kTXikWP4hSHVoSa7cDMS2MRg08dbmhICEQNC8LA7ANk6496667tVrU5Z/0/Lij+UY+rgaBwYk1VA0KxZ3/JhOyIhbGOsFAAQI9h2Ok=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by SJ2PR10MB7016.namprd10.prod.outlook.com (2603:10b6:a03:4cf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 12:52:39 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%4]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 12:52:39 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kanchan Joshi
 <joshi.k@samsung.com>, josef@toxicpanda.com,
        dsterba@suse.com, clm@fb.com, axboe@kernel.dk, kbusch@kernel.org,
        linux-btrfs@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [RFC 0/3] Btrfs checksum offload
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250204051208.GG28103@lst.de> (Christoph Hellwig's message of
	"Tue, 4 Feb 2025 06:12:08 +0100")
Organization: Oracle Corporation
Message-ID: <yq15xlpg9tj.fsf@ca-mkp.ca.oracle.com>
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com>
	<20250129140207.22718-1-joshi.k@samsung.com>
	<yq134h0p1m5.fsf@ca-mkp.ca.oracle.com> <20250131074424.GA16182@lst.de>
	<yq17c66kfxs.fsf@ca-mkp.ca.oracle.com> <20250204051208.GG28103@lst.de>
Date: Tue, 04 Feb 2025 07:52:38 -0500
Content-Type: text/plain
X-ClientProxiedBy: BN7PR06CA0064.namprd06.prod.outlook.com
 (2603:10b6:408:34::41) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|SJ2PR10MB7016:EE_
X-MS-Office365-Filtering-Correlation-Id: 42d499ae-531f-4b9e-783f-08dd451ace9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ri+NL7e7CLRwnKTOKKeSPFtw4KfaiQMAPZj6+fAnJgwmUyVdqtis2xTza99R?=
 =?us-ascii?Q?inNdtw+tO7xEbGw0HQ6VbHR0S3el0/s7rjvIS007bTSJjdCLaJzcgfL/MBTg?=
 =?us-ascii?Q?fHTkCf7AuMUqqxh9TIXhvJJuQTeB577FqdXPZvIrz4vnkGHqrAY4tHXLoGvx?=
 =?us-ascii?Q?2ClAQiLFit9JihUKTp5EVMSJyE14X6n9KGMFZdjNhWXDjxeJQwgA+6JW2mZw?=
 =?us-ascii?Q?gPmwgag+k+eaxFzG/hyk3N8CaJ4vlrzOTQtGeSTJCX3BHF0rA+GNAS4SIVKk?=
 =?us-ascii?Q?qZKu9CHTF37rIqj8PYwf2p1Nc8mUSNos6nfCgYJZw9owDDQFTRKq+gyJUn7+?=
 =?us-ascii?Q?jzw+yzwDcmNOShvTdMf833wSUHPwT12MxQDUCt9ca+BvHpM2FQ5Dlc3/lzzp?=
 =?us-ascii?Q?ue9FJ5Gc2T0LV5EBSKA1KEe//8j1/Rufh9NAAYCXJ8EnJM/C26GmxFE1XvLL?=
 =?us-ascii?Q?y5Jh6NrxsxWcSl9z7veIfhjBxCZqSFABmLwQuF2HfI1YuvZeD5mzWdmYQp5b?=
 =?us-ascii?Q?9k2h0vj0VCgSWlW7Yv5YfwzBCno+XjDnqMa+GDoJnuoJQUjUyLQeG7AnSNMM?=
 =?us-ascii?Q?E2xwX/ZLuuqUrkbMC4soLkA8f9sVhA7Us8nwgTFHHW83UAFtt8DIrKTeYP89?=
 =?us-ascii?Q?Rfdw3HfWrpStEjqFsENrbRkxNBk0NvUBbRYltNGDNfGTg+RP0QtDmVFpdDw+?=
 =?us-ascii?Q?R0DuNLegdAwJrISHTBzfW/4v04qWtcAW2nQcY7yuBv1z0ZmAmvjY9RRx0/Lr?=
 =?us-ascii?Q?Yw5/6NRdzFK51fFlCJo4pj5mgKUGj3J3w1P25E84oCrrDDlxnRVOwL3AM9EA?=
 =?us-ascii?Q?sNLnTh8HfezFbUcb8iGq1XDOn1EmsPjXzpspVkaqw/OFozlQ1EjT7tdJ3qOx?=
 =?us-ascii?Q?/2TSkhBF5afnjD4SucdLZAXe1sCocDrrTYtHylhsnYLv3UUm/LGlnYNsccSe?=
 =?us-ascii?Q?mpcc6gou6ouZHt4smBWiElcAm+X7Qmukr084juT4vqpGG53uAmzGCQ56j+tL?=
 =?us-ascii?Q?L556U+l7FDlSFd0WzxKwBZAIiJao+gNo1ts/D78KW3GCsxs5ydu5zyQTZB+A?=
 =?us-ascii?Q?8MQjPjpI1M92/D9xC+moO8HO7u+Ic80oUQq9ToaIy+s3jv+Q+vsqebG0wegU?=
 =?us-ascii?Q?ViViSnjANX48zS9wgn9RTPwgfuITFPutxORLUMmGCSIoERFpzzaWD5WQqG1D?=
 =?us-ascii?Q?l6CLBZqFj9wBnKtiCZa2Nw9HtAUHhi/gbyq7eegcTZJ+8kDsSsiYvcv08NS0?=
 =?us-ascii?Q?pqhoufV8UzIdWGy3qJfpHA/UwKS4E5WdgrUqtnguIg+z+IXU7X2li/Pgnb7T?=
 =?us-ascii?Q?nThjL6DB6qeAEhkDkV69msAEnlvmytv9rwAiB8+Tdu5ueCxtlbRGnqfHa4rh?=
 =?us-ascii?Q?tjkCskkdyzpk769g125TMdpJpujf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vwiYHL3KDzT2ctzE6K1PXepUGkYNLr49PQqKJRqAcFfkyJCp6/qurfrCJIpg?=
 =?us-ascii?Q?EZ1b6M+m7s8x4Gb1Z1XdfeO/6rwxjZSzMDu0ZiP6z7gx1lHveBvqokb56Uhs?=
 =?us-ascii?Q?mDTMw3tw5m1vUGhaVl/6vURpn0eCXWklER6eaL/IE8Qh2VixDgRHUPdXFzUV?=
 =?us-ascii?Q?MOrrH878Aewil4Rgsd8pHVopg33xJ6NY73UTYhKqO9mgfvBA+tmpUps6U291?=
 =?us-ascii?Q?gpvyIKmcUGAzjMlPDm6TbYXS3uIDrsSVO80dYGCzVqjfZWdmyoOWkmDuiGzN?=
 =?us-ascii?Q?RsbYkCHmoqCBXQpx7PhGaN4rg5HQ26odkmCktoKNF3r3Hc7Z3MR6UB0Ku9iP?=
 =?us-ascii?Q?gmUpuTlxXhC+06xCkaK9XY5TA35rPthZeI5KiovhitlLAQD0akUBprbZZbu7?=
 =?us-ascii?Q?+XP1irmZ4/MDUrT9oeHbfjPASoheH+0gNgxlXNjC6nZFCkt1YDWse2O2vOsa?=
 =?us-ascii?Q?01uhk2RdmGMW8v+nHnShLxhv5BmtRGLKaJ/bO6N6/ISSDegAjSEaK/OHAQUi?=
 =?us-ascii?Q?xzaKHhRKv1eQtOLiJlJPvPOgLJq1+J8HTDRzv1JjWuxUA0hsh7ZdLWup5BQ9?=
 =?us-ascii?Q?IHCayEvdnEmguH7zJvQJ8COkxardKc7Ckty6wUGZvz+1PgL1W0Yb9in6n4oG?=
 =?us-ascii?Q?JcK1belRCmG0/L2fdr5jPNvQWXEdqlUu5YC9F/ERtbkf63klpWz0VDA5pMjl?=
 =?us-ascii?Q?GPrpMjD51OM0gH1YaQHh4Rp5+QbREFP86JaBjAx8hDvzquBBpuLP9guVMVGI?=
 =?us-ascii?Q?luVi4NfPvhOCleCqqe9HeFG1YJjp00/sIBbkNK78Rte8khEiQbDfJsjWlY8s?=
 =?us-ascii?Q?MCTFqdKwTQuT9gtyLaEGWqai4H/+VVGMcGJEbThEUwJwsL9Fi2ShrsTTRwqC?=
 =?us-ascii?Q?DKMdvKSNtaQUpK+BhQD0H3T4zTS/komhHcufW49AgL4NEwcUjTxqqjv0XLH1?=
 =?us-ascii?Q?36yZMQJ7uH2zV2pmZMd3r+0z89p53A/vFO69qGZn9d3nMqJhVD/s9p0ybKGD?=
 =?us-ascii?Q?/n5lHDQ0YeOQqHpR7omWRVQ2Prmppf0xInn+yoOEZC4u1CXGU9NFKSBHov6m?=
 =?us-ascii?Q?ZbZsmszizkpssxWgqTgMhCcgM5eNjolbn9bd4cCmCQjO4TFamszceggWPNsU?=
 =?us-ascii?Q?Nj64g3vmpd8ycyMsS8TRND+rMo+uHtm8hNUAdDZA3iGly/f0XE3a5jOduWKQ?=
 =?us-ascii?Q?nt+ApwFZUd6OSPjgtS0vpvuWyRDkyTmM2+V8vA1CSCf/nVHL1oUbXeAA+eFf?=
 =?us-ascii?Q?tjchGpscVzfoEUtSYXor6wifAziBpvR9baAnbtlKEbRbOrmJ4sPVuEUkDFXJ?=
 =?us-ascii?Q?+9uqZ+0zEAvNc0uPdh/8ZAAiZBQoLHWGWnwyUTotEN+/oDrEV+HHdiyITKAm?=
 =?us-ascii?Q?vd10ExCyOnXPqUoHIG1yNeBP/6tTKBjENleg19G2F7Sm5llwKxaP4dDlPK2s?=
 =?us-ascii?Q?9Mi9fgguzthcnyhc1EkLkZZy/kd/nhUXBT9x0juTl/OtFqCBCWRtLtnBd2dc?=
 =?us-ascii?Q?tVrj/Dok64BerLYHe3O8RywfS+v6afSyw0VKeRBAw+B8r829mgBZgNhIbvdo?=
 =?us-ascii?Q?rfyZzA0+Cd8p11Z9F8fcJBe0bF9NQij4DHHFYBhyGVV2yWhaIG1RilzE6eVS?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fG7ABYxWrVug+2T75rWhAj9uchjqcGfrOEYxmU5dzPWdjn6BSsQigrLLz5PfM0/sZccq4+pqDmX667a0LLj2TUHvPmcS6uygScPKhHvQBAJq1cWNBn1BkPAYM5WBHrZRk7aHtoXZKvDcZmtJY9uQPNiXSRo6x/EqqVg3TDsACEkXzXLv04vmhYBcBPvb19k6Fsy5VNuXoOQOGzK5oX+fOIRYDcaGKOY0XVlqVGwLudATXywzkvIgGhBCcv/G7ZnZPS6UwLDTVRew8hwAYaZBUtdCJWusTGJePI4dgPv9Ifa3j4BZoK0YInLoPA/qJaJMQ2VudC9GOTWm/3NxT6AbQ1X9nPz8RjekCSuLAeC2MHUYlIhctPoNh2xJr3aY+y9uULAUEhIj1htWrBPSDwGmfdAP43RFhGL3ysFLsB0Xm1OhYZ28vEs0+7YHVrBOg5RaomE7BCVZrLXboiVAppJHMQdHM9VTj7VoDXAj0o7UKHiPgX3tAuBMxOOqP38D//FtUsLnBa4om3zHyNe7u+7PJQnwQE2H5+cPmmjzK56kG1XOHaUJiIOZgEbKHxnEqZf9Tg5Ji4+DfczKx0LxSrTgYoleg2oQf4BGQg39NV327qY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d499ae-531f-4b9e-783f-08dd451ace9e
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 12:52:39.6356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UzKTi0Umud4aVgPtnRpS+7E4ew9UXtwox3/9Txrl+J9yizzZJRmj0WI74HnlC39fDDYxuPs0z7lMfBA68CuHrMPA37fLDOgAYh0E97FSxaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7016
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_06,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502040102
X-Proofpoint-GUID: TiZP5IhKtYa6MqlbRsTYZZVv5qbw1fXi
X-Proofpoint-ORIG-GUID: TiZP5IhKtYa6MqlbRsTYZZVv5qbw1fXi


Christoph,

> Well, what do we actually need the app tag escape for except for
> historical precedence?  In NVMe the app tag escape is an option for
> deallocated blocks, but it's only one of the options, there other beeing
> a synthetic guard/ref tag with the expected value.

I have been told that some arrays use it to disable PI when writing the
RAID parity blocks. I guess that makes sense if the array firmware is
mixing data and parity blocks in a single write operation. For my test
tool I just use WRPROTECT=3 to disable checking when writing "bad" PI.

And obviously the original reason for the initialization pattern escape
made sense on a disk drive that had no FTL to track whether a block was
in a written state or not. But I really don't think any of this is
useful in a modern SSD or even array context.

>> In general I think 4096+16 is a reasonable format going forward. With
>> either CRC32C or CRC64 plus full LBA as ref tag.
>
> That would also work fine.  NVMe supports 4byte crc32c + 2 byte app tag +
> 12 byte guard tag / storage tag and 8-byte crc64 + 2 byte app tag + 6
> byte guard / storage tag, although Linux only supports the latter so far.

Yep, the CRC32C variant should be easy to wire up. I've thought about
the storage tag but haven't really come up with a good use case. It's
essentially the same situation as with the app tag.

-- 
Martin K. Petersen	Oracle Linux Engineering

