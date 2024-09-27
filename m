Return-Path: <linux-btrfs+bounces-8288-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C109881FF
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 11:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D573028275F
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 09:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34441BB686;
	Fri, 27 Sep 2024 09:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bb1GMI90";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uP2Va1rz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5337B15F3FB
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 09:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727430970; cv=fail; b=eb+hGBK/2vWxB+l2noVQlNFbL9t1fsxpeeXcElKtL+lVIBhE8A4DYbUWB/zP0vmqQgfrQFEsOt7yGJvzmYh13739ihePibzWq8nHX48YR7hTJVh1OXN5WuDykxAqk89wOFNeijQHfuOVOnY9kR+MV15ONnCnO0UW95r/sb2Zoh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727430970; c=relaxed/simple;
	bh=DGXGzKRmV9OkakR2hl8Maa5Vd1BbfUrHMW6fVXr5/l0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SRYucTYgfvf1dqhXdvmNdoaL7U0e88q5L2gbPqR048T+OLky/ZouIE4rOHmM8u3wlPl3QDbme0QNqEx5Ox9+LZikwdqVCeaD8DAxNeN75w711jxb2p3d9EVXqAjBgZ3In0glMcHhPFU/jgXgXvqxwkUsu4sfuaR0NNtBYhuMMvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Bb1GMI90; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uP2Va1rz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48R5gpDB016237;
	Fri, 27 Sep 2024 09:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=I2nWAhPnDAzFXZ38kUp+mbGwP85xmEyhxf67nD1Lbqk=; b=
	Bb1GMI90XxCYoON0wxqC+eMNzQ7iZQiXZFyXOHNmB4WqB23GqpcAAa7gafp+ylpS
	rHyBCOaK/9voNZf5sFnTfOzhH7w1fSP3Kf1sMjjAN//CAo2LvRl4uhLF8YtbLCk1
	Ixcrot6BCxQNQ1G3jfzFLWS5SlgVg1KWxYsciqjry/PLVL3T0m6Z+TxWVNczOMqR
	MbcLKWrpJvRWiNdyINrHWtK/df9PHENw9SMts/4fIKUhtbao3y6BfuPeF/KQHIqT
	IvzJMXEFdc7gqfW5Lp6KFsMFdy+QmJsau371zg0K24LV1RBNYXGpukTnfZagw9IR
	Iy/SO2iTGK4Vo4cjP0bJJg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sp1aq4rh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 09:56:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48R9V3BG032943;
	Fri, 27 Sep 2024 09:56:00 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smkkmste-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 09:56:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=opHNVQte/LEWHgElPs9IFZ8b+oW6JHsxjF9N6eFXrHJ6EH+WGtKM46dQQHLSl2zQwcsRho4+wXFidDGqhgLod9qUL5ntozW5jGNIMkmo1ivnMu5+KhAZgSgHLua9nar0gBEIhdDKoxv+cxEhs+/ZM1ga+DVth8y0cNQ0SvSiCAJaI/ubh27Q+jWVDyzVx4EJzhW8PdYL6DbermabnOmyvHdnSd5gaX3asACIHaXGthun8tXmN8TIu5GcYSGME8SeJW+XdLvhRHbSQQwE+3gQWMuSsBqfGhF+EJRsAC86iSM+U9QoJA5Svs/4Ae67fywmmFYBnYaNKmgkvmw+E4ab+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2nWAhPnDAzFXZ38kUp+mbGwP85xmEyhxf67nD1Lbqk=;
 b=l5pZk9mm1FuZxVzcL967TwBTPVgy3vz0+SaJr92Bg2pESu+F7I3iSIwANFIBIhTo4tKSgrXGw2iC37NHCodsX5LCrlItVn8or27TyZWQUONgdPar6AJgQzdQScAJj7t7KhYayEmeSNFpLnkwQvXxsTCpRGVFB6WTg9/tDKb/XYzKiSrAcJXIj0W0w+1soCvdbXLCOIVnD4dIIcco66Ix6ArZgdwHYuSZqI3p8G3iiknkugboEjE1LjN4A7ZMf+KH6OZQqkk248A+OV7RGvXirs4Ozo7d9LezTxkGjtC0IWxYwDJ4HhHH33A2oMgF4g2X54DajwboOsvWJxl9+fmPUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2nWAhPnDAzFXZ38kUp+mbGwP85xmEyhxf67nD1Lbqk=;
 b=uP2Va1rzaubEmWQWjLhTdRd/wE0n1CDw7N7sALwZZ4Q1UAVQKYsjTEiwkSg3mVjKdOQik1PDGQWKR/2oiVDKW+kDFd49S+gtR1gW7YLw6rIn8fjg15/a9oKsSx3hC6DifPN8g6MOo/duvaq0vRa30F4zOrLcMNSVdqfwP3/XGiM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6735.namprd10.prod.outlook.com (2603:10b6:208:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.9; Fri, 27 Sep
 2024 09:55:57 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8005.010; Fri, 27 Sep 2024
 09:55:57 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, waxhead@dirtcellar.net
Subject: [PATCH 2/3] btrfs: use the path with the lowest latency for RAID1 reads
Date: Fri, 27 Sep 2024 17:55:21 +0800
Message-ID: <f284d932a61c293ac1c350ac11730b11b651300c.1727368214.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1727368214.git.anand.jain@oracle.com>
References: <cover.1727368214.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0191.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: 90c2ae5b-db0a-423d-9083-08dcdeda9596
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cywEeAGLBN4IbH3F6UBl+sYuodnpEp9/bLsIygIamCsD7QCItNKGN3TMi/92?=
 =?us-ascii?Q?4wqArsfx8UMVUt+/XKNQMD0ThTgvSobtJMsZkAShV7EaLUrbrABUAFU33C0x?=
 =?us-ascii?Q?+O9k0VK1LV9Iqjr+80cS27rzHPGmElJWNhaUI1xviefjq308/aBPmejqVpMw?=
 =?us-ascii?Q?SSXK2NIfww553Bz5posPE8QXe3LWx1QdF/aZdXvq8BRALBbnM0T6emODdNOK?=
 =?us-ascii?Q?3UcFG/U71jppe//7DigGEDc0TCq5EnJa5uGtPTIpPQbVhvPfsMM9xrcUgMnQ?=
 =?us-ascii?Q?jzuUHxZwe8OV0zQjxKX/gpn7TXIb9LPSCL3+PCB9Bnq4S8FOvP7SvkXLPkA7?=
 =?us-ascii?Q?nCHSxgVQVXcp760+It6IPYOc2sf0NP7U0uYq3juc4iKS+AwnNcAaxlK/lqxt?=
 =?us-ascii?Q?dwFHrmORU+rmoiorXAOQzT6xaSeOalbAtTIsNKkbn04puTa7XtWlimCOsH0D?=
 =?us-ascii?Q?2v85vyx8/yqgkzyiNFHIHa+NIvKzIya6vfN94wOJJ0hLofMYgrAQZ405mCAB?=
 =?us-ascii?Q?LO8wEl9EDeSRiRKYPVvRdrWXC0jg/veBDJ+QyF08u7vM7dcMTDnjakw93Anh?=
 =?us-ascii?Q?L4TmdXxGNrZ/MMR5K0xNPcJiaLtdGnWK75eyIhHLgc+a9YzOMUTv66FZPdEv?=
 =?us-ascii?Q?InEou0i949nkFK4uBiyJ1m+tAXupIjtkDghHZlCIh0Zf+olfJTSJE/DKFe3u?=
 =?us-ascii?Q?w6tU/rp52pvFyDJ9ZH/r1isna8aJPSc9Z8mgu3WPiQPTuy7bBFgJmv4VndJ1?=
 =?us-ascii?Q?VR9QxrEiaoKFBbSZVGtrTGzMgVEjzxBrp9iYqwvZdzsiI1XN2wRQJo4vhQRl?=
 =?us-ascii?Q?qjHYr2Mo2os6avY07pZeNKuYU8DnYHG/kDE43RZAYJQnYJliffCm/L/NXf/e?=
 =?us-ascii?Q?zT/Rtmf+97ydxbDIX8GM5LetoT3h7tkHCaX59tFJQClKUKnWgrmCAnxvULQk?=
 =?us-ascii?Q?4N4fnGw86Ga+3YIkFjNLCUKSndXt4E9/+bilz2XauYYNW62y/EtsF02sOgwM?=
 =?us-ascii?Q?YYoqx1zXxpUC1jFkeecKrCTkLQ5jbRf0VBhYbleliOQqTNgHSjOeVd3Jowjk?=
 =?us-ascii?Q?QtHbUI6XK1/AzCkgaJow7rkb7NNnTURbk6VXqeM61cc3QyTxY+CMqs25gmg2?=
 =?us-ascii?Q?yMxQEw44vmNhBOIg2T/TsHr7PFmJROO3PrU7OtPvoWNL8np0+b2j+SmwV8X1?=
 =?us-ascii?Q?TsvLRyLhWzc/1j0pRmGNv0+Z7OxAnUhcRenoA6SlgNybHxnjNUHpeE1Y3qDT?=
 =?us-ascii?Q?la+EDIlPgghzkubpNCIzIhKEEUYfub/dEvQUuqyGq9C7EBONDwgp3YbuZhB3?=
 =?us-ascii?Q?AH0qgYqzXyoFleLF4GH3Skui2Ojd7Gm/94deB9NEhiDi7Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PLwlDXxaOlrwPyOHOTr1naCgQ3Hb51Nmm3Z58+2fWaTNRG/13jCN11zKlMm7?=
 =?us-ascii?Q?E2ryen2XdrOAZIJGvtdrNbM/6CrCWzW/915T4pWhD1Ofpy860MijcFi803dC?=
 =?us-ascii?Q?kgK/kzMq1YTqN+xWcENjdkaeJBUVrR+Y0aozDmv2yVk9ZGOSHhD+Nrh9KHNe?=
 =?us-ascii?Q?s8qcjVnWeuWTLcTkXEr627QNDbZ3+vOFC46RevpIatv5gJE55WxAHWoA2RCs?=
 =?us-ascii?Q?VGxdgU+XdNC145UUxeApBnxCjQJ0qsfIOC9jCcz29uVV2Zt4QE2GRmsgmjzi?=
 =?us-ascii?Q?gFocbz1Jlj0Zq1/69ryiijy0VglkpcfoTRbA2tPNpb//QznChoMtdw0dv/Ds?=
 =?us-ascii?Q?lAadyssRnGGvy8/zNUapn41QBdTEuVVVZs6qq56kDdUUk6a9TzUgTGDPRIfB?=
 =?us-ascii?Q?XviXSJFnBbmwUySdIfkfE22UfN0A9Mhw6NGXus/+CPQ2fbuRIQ9VMs0+xvUR?=
 =?us-ascii?Q?if/+amTAjE7JOx8oTquT3IArC1mdspC0b9Aqv+joNaGR1D/xrLSWY4XPk99u?=
 =?us-ascii?Q?ooRim9C2eChZrm+AT5qTMceklKGhItqchVhkQwnPd3MqEs8CT9qsBhjvEQod?=
 =?us-ascii?Q?/pSxoDiWSkWz+xMzOhSdv6hDy8LAuvYU+Tr3iXa7cFhH7ddIboSEDNVRsw3/?=
 =?us-ascii?Q?HTAkivvRp/Ac7q97PC6eu60pBBCzgi2omRKrTD6jA5ot+my3ZTBakZH9Uhbx?=
 =?us-ascii?Q?2q8BBZD39DgmOiB83ydCqk6bIekgcF34j0i/WUAzrA3ysPBerFVQehLa8bEg?=
 =?us-ascii?Q?RoUHgCY6ELNJlOpemZtUmVWtAXKeLtt0bp9w6unPjf4FZIDynXJtK7QN21GK?=
 =?us-ascii?Q?9T9dNKpPVC6x3U4X4H2eOsCUS8/YsWEuBPXn+3NYR9oqBDPdwu3+wWNKnVLN?=
 =?us-ascii?Q?hTaWX61ZJrpWNBEQjtRMX8dMtw61Qos7HJ2FvJ1Y1naIpkfvCrp31Z3yLi2q?=
 =?us-ascii?Q?19sHjYkvEIOz1krCzPRcQGvbk22SDssphsYdGnbne9wOl93hvNNeN5qUa3AZ?=
 =?us-ascii?Q?7ZHvalBe5yqnw9017L/UrHAimxR3uPxzELop3VaJ6c6ZCDWxiIg2yvVEVRMN?=
 =?us-ascii?Q?lHU/XMDe3n2ckhsZtU0jDZuNQ+ULoKPkgW5JmfhHK3XJBCv8OficrCtApv9t?=
 =?us-ascii?Q?3aM2e80HC/CuL3v72ZwHPx0Zk0h6m7P/QEUoa5R244VoiL1ny6MpcfO0IEgJ?=
 =?us-ascii?Q?i73Tz9zkB5dcX2F/jVg31V9bKF20cQafsYL9PqF8IweZRLdHvi5ae6EvYXAF?=
 =?us-ascii?Q?H2Y7GLDNYb2wc+XaW9aAUHa3PgZtpaZkPW2mZU57JJH6kxJHRInlBHMetRvW?=
 =?us-ascii?Q?2BhcxiQBpfTcHVOu2qq8iiUdq3ARqnLGMLeO4OBAsJvzW1xsV2GtdHTlB3wH?=
 =?us-ascii?Q?6k14yhD0aeZKD+NflHRahTZbUFMVp3Nsgbsu6pMLd+rCDEit2Ffylm32oEv/?=
 =?us-ascii?Q?xTuIDTl4EdrZxN8Cb50EReLoFl21Tehy+H8rmGrvbn2oJLVuQbKr4v69vGni?=
 =?us-ascii?Q?rdeKYK2jX1AW12P/YDN4gzU2dUFL9eNojG7+Kt9NMdhijZvO9XJK7oYPuwxW?=
 =?us-ascii?Q?fmxNfXM9qN57F8oOoPdE+aPJ8MnZMcOZT70T8CsW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WA7K+GaHrIhQs0RK3ejsjSU1sYKKTtDuEYcsI2kvL18jMgbZYyjm081g1s1a5hFH7B0qR7y3PoA70H+ttkGAPDLx6oJrnewsQuimr1A4JCf3xWCXMucagPpOtx16dDphFXxYKk+q+GKRoqyB3fKkjFyJT4OENgQEBoRuKI6PCwRmE8VqgNpiDlmQ5Z3rHp+myjNO7DaMKoxbNGp15v1f9+D/1ObugXb8FhpXOd2sXsr+i9kAX94lrP1m7p1QaiKQd9uIiSyvEu5KyvGrUjSNY4sxGp3QwLb/ezrYq7MpauvSa+buPm7YwKNDOfJRfcT+8LX8cxoBmHpWvRRpKWsvrWAPBIGxfcEZdsnsnOhvBqFpsxw6B4278mFjaGUf+xBHH8THXT9NjtK5iuiEjufK0EHSD1BEEvsIQsvqLFMSPEm0ObqPcD/fZiHj3bdqTd2YWqUA4k3sC2u2pRE0qKxgBgpNglCGqeXDdgeyL+nPQj0pfCqfMkE04HYLLREPBo2DDeaemjaKu+lIKuhvDimlX4VfJj2h/wxAmoJUd+t5ahXAS2c+V6eWr/eFYsO49jzutYCUm8FMeEby5UI6wFvoyB+Ncss4IhSXnQ7BYiJz1Lg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c2ae5b-db0a-423d-9083-08dcdeda9596
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 09:55:57.6871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1tTW+i2vRoEP3dCgzWgVm8Fj2l7ZcxFzFgmTTgAyPS1mZ9BHeJKWMMrc7WCd+uiCrt4onVox8CjaTRXE58Xqbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6735
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_04,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409270069
X-Proofpoint-ORIG-GUID: DiJItAlQg1L9zlBhOw2acenGFrkfpQkU
X-Proofpoint-GUID: DiJItAlQg1L9zlBhOw2acenGFrkfpQkU

This feature aims to direct the read I/O to the device with the lowest
known latency for reading RAID1 blocks.

echo "latency" > /sys/fs/btrfs/<UUID>/read_policy

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c   |  2 +-
 fs/btrfs/volumes.c | 40 ++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h |  2 ++
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 18fb35a887c6..15abf931726c 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1306,7 +1306,7 @@ static ssize_t btrfs_temp_fsid_show(struct kobject *kobj,
 BTRFS_ATTR(, temp_fsid, btrfs_temp_fsid_show);
 
 #ifdef CONFIG_BTRFS_DEBUG
-static const char * const btrfs_read_policy_name[] = { "pid", "rotation" };
+static const char * const btrfs_read_policy_name[] = { "pid", "rotation", "latency" };
 #else
 static const char * const btrfs_read_policy_name[] = { "pid" };
 #endif
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c130a27386a7..20bc62d85b3b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -12,6 +12,9 @@
 #include <linux/uuid.h>
 #include <linux/list_sort.h>
 #include <linux/namei.h>
+#ifdef CONFIG_BTRFS_DEBUG
+#include <linux/part_stat.h>
+#endif
 #include "misc.h"
 #include "ctree.h"
 #include "disk-io.h"
@@ -5860,6 +5863,39 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 }
 
 #ifdef CONFIG_BTRFS_DEBUG
+static int btrfs_best_stripe(struct btrfs_fs_info *fs_info,
+			     struct btrfs_chunk_map *map, int first,
+			     int num_stripe)
+{
+	u64 est_wait = 0;
+	int best_stripe = 0;
+	int index;
+
+	for (index = first; index < first + num_stripe; index++) {
+		u64 read_wait;
+		u64 avg_wait = 0;
+		unsigned long read_ios;
+		struct btrfs_device *device = map->stripes[index].dev;
+
+		read_wait = part_stat_read(device->bdev, nsecs[READ]);
+		read_ios = part_stat_read(device->bdev, ios[READ]);
+
+		if (read_wait && read_ios && read_wait >= read_ios)
+			avg_wait = div_u64(read_wait, read_ios);
+		else
+			btrfs_debug_rl(fs_info,
+			"devid: %llu avg_wait ZERO read_wait %llu read_ios %lu",
+				       device->devid, read_wait, read_ios);
+
+		if (est_wait == 0 || est_wait > avg_wait) {
+			est_wait = avg_wait;
+			best_stripe = index;
+		}
+	}
+
+	return best_stripe;
+}
+
 struct stripe_mirror {
 	u64 devid;
 	int map;
@@ -5940,6 +5976,10 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 	case BTRFS_READ_POLICY_ROTATION:
 		preferred_mirror = btrfs_read_rotation(map, first, num_stripes);
 		break;
+	case BTRFS_READ_POLICY_LATENCY:
+		preferred_mirror = btrfs_best_stripe(fs_info, map, first,
+								num_stripes);
+		break;
 #endif
 	}
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 81701217dbb9..09920ef76a9b 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -306,6 +306,8 @@ enum btrfs_read_policy {
 #ifdef CONFIG_BTRFS_DEBUG
 	/* Balancing raid1 reads across all striped devices */
 	BTRFS_READ_POLICY_ROTATION,
+	/* Use the lowest-latency device dynamically */
+	BTRFS_READ_POLICY_LATENCY,
 #endif
 	BTRFS_NR_READ_POLICY,
 };
-- 
2.46.0


