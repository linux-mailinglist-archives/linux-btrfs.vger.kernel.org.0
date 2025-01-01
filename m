Return-Path: <linux-btrfs+bounces-10667-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B7D9FF4B8
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jan 2025 19:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38B583A284B
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jan 2025 18:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC2A1E32BE;
	Wed,  1 Jan 2025 18:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ripqu1M7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H53kvFyK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975D91E2821
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Jan 2025 18:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735755012; cv=fail; b=Kz57lgm+qhoVN47lmsY5Be5ubW4fSM9AfChcHjerqVwogJ2/ituf24Q6sBB9f7XFOFhkZNTz3Qe3CdVvYexwP93+bk8RPEhwLfNMULat4t88BwDyTTpL/Oobct94TB4WwchLx9w9OALWddWYQYe6RFV8v3qlPbGBBNlwEe1psu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735755012; c=relaxed/simple;
	bh=CfZd6CztyGx9gXaLyG+79rQrgrflvzMspjCut+yvhK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EPh/ccBX2+PR9qn7CwBIZBM+Hb2c7dyisRj9b0MD1z/Q2hTX2M9AUNPoxltyrAS7R0v7sHYr8bdK23mCZ5ITAZG7/QVL3d7BKtbD5T4ZBPdXhsBfDy+QXS8RveF5TbvPk9YtQfu8IFGhL3PwJQa43YRJ4LpyylB1+lCJA78Mwhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ripqu1M7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H53kvFyK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 501Fl8Ka013333;
	Wed, 1 Jan 2025 18:09:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=+7VsbehualOxc+Bs2p/CrkcUQNgs4owdWqmmECda9q8=; b=
	Ripqu1M71XBvhwXan0Qvi9IFZ/RqeYjI0vQWLOuCFDURAK/wzS6tydz7fLe6D6ms
	lQbSILFO5BozMVssR/dSWiqCGuMinkKGTwOHfM7f5duwftQtBG3s4u7uf2XAyIJb
	TUMzx37k16/lZVZ/k1Sl9ZdSky70JcBowkBJ9/+eSn2zMHUwJjCzKOjn0nmJddKW
	WvZp0TYxeYx47yFRmWnbg0lWsY4i1Yui8U44kWyOPdswtsrIhmgsQ/1qic3YEv0P
	dDORT9ZKKSK2W8X4iHXptroPkIjghFFYWkhAt7iHX/7NGmrfHJNx2LU6vnIOggDB
	v44fiEV/SM5t2JOaL1XqMQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t88a4g6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Jan 2025 18:09:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 501D46Rx027662;
	Wed, 1 Jan 2025 18:09:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43vry0ygsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Jan 2025 18:09:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4jTJrRKui1harIAOd1y6HawCBKY5rmTA+EceFh2PRGwrDSwrDfvgxnKtw5+odBSIcJRORDsKjL2z+Dsr7KoWY+jWJ/m/4S6nkjGQY4ang6fvB1qwD9o+Rcfm5cVpZD5FGEdeW31IAFr5LWMFA0IPPQuMIX2NkCgkq/VgHgMcrEKUQ+awX2p1A7aJqV76sI6bURKcD+oVB88GW64/HJ7gcycgGCa2vFStVwqwZegogUs1XwzIBFkP55arOay//eN47nYt2mR2BOCeIhWyBqFEfSK0n4vQuFuKpgy4h1B6MGsHOAQ3UqxAwmrQZEdHcjSynhk8xwqdyh8XkW3N0ZvHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7VsbehualOxc+Bs2p/CrkcUQNgs4owdWqmmECda9q8=;
 b=L5AGA0LXFrJMZWjFVbD30/VMN0KUp3KeayVJSrP3nXn5JDo6edJdNlqCDayLdgnVWnoVcVpJ1UPNfwsgpjlJA9WfWNkw2QgaPSwgKjscWW9bGqrWNX56HN5BQkXhkgt1jB4lIXc4KwiOIEktWldbUx5IKnNle4EQ1Rj0glgYoCb19CbM8nN6cbe85An3iwMK48aZtT4J9wkRFWJGVCnrWJzQyX9q8ODgbsdW3/HUDOx7Ib9pSXxVGKAyRTUytiS39cqEBFlU65qI6w5A37rLN/UH8MmeROw4Ugo2XaW5Gisc3FOrZYg63cGE7/Vg6Yk6yqYkfRTFKGFCg11eQ1EjGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7VsbehualOxc+Bs2p/CrkcUQNgs4owdWqmmECda9q8=;
 b=H53kvFyKlvA0UF9Fh5jROuenaT6pQGP8XWBeJfoda8IEckn1b69TjPcTFyDKrpnKLmKRZAHpWt/v8TidioCIzSIQ8+z5NlBoAQhy3wj0xcuCydh/CtoRqZVmwKGI3iA1m8VBeX/9a+BJ1xq/9N/IM/CLhBV8lz9h1zdhZj7/Iuo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB5549.namprd10.prod.outlook.com (2603:10b6:a03:3d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Wed, 1 Jan
 2025 18:09:47 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8293.000; Wed, 1 Jan 2025
 18:09:47 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, Naohiro.Aota@wdc.com, wqu@suse.com, hrx@bupt.moe,
        waxhead@dirtcellar.net
Subject: [PATCH v5 04/10] btrfs: handle value associated with raid1 balancing parameter
Date: Thu,  2 Jan 2025 02:06:33 +0800
Message-ID: <6a303a3da8116c3743fa9be605dde540d8a60f1a.1735748715.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1735748715.git.anand.jain@oracle.com>
References: <cover.1735748715.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB5549:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e953f18-588f-444e-3b40-08dd2a8f7a3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MozaHpygR0czhCMtzq4JZh+mqMGiXVQ0StcuCjfBDiJwUuGz0jxnniUJzcX1?=
 =?us-ascii?Q?Un1FBnBiuJUiFLPuafRHYT/n6f3c8Hs4u923NW9fXWtEiEdi5QQVNRVAZkL6?=
 =?us-ascii?Q?8yQz19ny4pEUq527iEgnocUCAy8VisdhzfGRf96f3MBqsHj+2qsFyssixM2T?=
 =?us-ascii?Q?VdLFt9ncD0xlftDVEX1/ka57IvoKZ8Uwr1WSMs1PjG3M2nAWHIbQUdXkdBGf?=
 =?us-ascii?Q?IuacZQ3noPLxfnls2UVV9NY7b538prV1fteuawnIizeSncZ4cP+B5dPdeiqh?=
 =?us-ascii?Q?gFmPRGYXgLcPb+Rm0NIPh1RDhcSgCfn3ipI2OohRtXLfST+yVx47pBBwDUxV?=
 =?us-ascii?Q?7v6iwHvBgCRa9srXzmAsM7BM6uELeUUDZHadj+IwQ9zk7hgoU4EOoB7c0wIa?=
 =?us-ascii?Q?8GJnHETqRV+L1W5WGoMLiOlXhpCEql9wcbhh4hYM/RpJ1NugVuSGoOObE/gz?=
 =?us-ascii?Q?pvoL8bmqkslttbaDmVjf/iSg/+fNFcYIjn4LTMMSoJXPYLNvwbLikS8CSKuO?=
 =?us-ascii?Q?fMNv8QwU40+LQrQkWksQvxZAfBzLr17QBTK+eX4kSM4FMhiTZLK/YSECLHHu?=
 =?us-ascii?Q?Zydbx5LqQLhngesyKZyVisvhWaFohGjng7mFR/WLzcf6ctJhuV0L+t9gzXPs?=
 =?us-ascii?Q?TUZc2r+tMOtAxrori6/TqL0jx0aQuySDT80zFpfVW2AY98RDsmuaqsFTglKM?=
 =?us-ascii?Q?NWKe76xAjuhH0cWNm2BJlyWKpUtuUuk9E8P6TWKqrMlQDs2RkizGnnFJ5aVB?=
 =?us-ascii?Q?VL2U+Sze1GB6dlF0kWq4zIvbjM5PtZCREkzm2en36SkQGocyTvT4DW9oRC+w?=
 =?us-ascii?Q?tUTK21gQXcCNVGkWw45FCx9VwlGKRa6liHy0i25187KDWTWW8oqXDa+eVgp5?=
 =?us-ascii?Q?/tlM4t2teDukVbVRMGHN1lZVocopN9oLlH36HTl07ViGFqJPCCz12LoqI9tJ?=
 =?us-ascii?Q?c1QJhWo7wKmNr/JWbNevr63kBpizvkUNGdHclB+T2T27GICE5TECnikKYNbR?=
 =?us-ascii?Q?eKUjqNIpm1LVXMTaJGS+1cLG8i3GAXOOiZ7ifqjZwiQUdMkMcTavIV416Dll?=
 =?us-ascii?Q?S4A/ZX8xfSFGfG7vJ2zY7+Nzd+1tT27U25yKb7HgMGeJP0yFtysq904YrS9O?=
 =?us-ascii?Q?gt27db0QkClWZXSZhJC1a0VNAsxgw41RlaZNWRQ/PvGt9mi28r8MQdryIJra?=
 =?us-ascii?Q?kXzD7bgZd7hbAKPWLwoCNdlstZkcgdf7Dbyf4hJ8Fu+Dm3/px/yfnMnQePO+?=
 =?us-ascii?Q?8VcDIwJot2ulgNfs0DxLsOLci/Sv/JZRAcV1ChUygnjnReTDGegldjYUjJmp?=
 =?us-ascii?Q?28p+/6Yru4ay3nif6UKGcXDwlj/dYJlXVhwskGELHFkv3qqQp81CFbRtixFJ?=
 =?us-ascii?Q?Xickw9jlqKhaQ68OjiQ21SlRvYuq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O1ICSg6hTsIIIx1JAggzm3npPr046CL363BdY4uhOxYu/3MJXVtC/GksAjtV?=
 =?us-ascii?Q?XEXqDMTIr2jLH3zk1OzCozeAlE6m2VMI/fptfFBxWVotmstcOmyLXUAjSdm6?=
 =?us-ascii?Q?xrWDpbhq7OdPPRkP+2vkcOEn0U1xjgUsd2nU1v2WkiLOfW5d9lhZTWqwNjcJ?=
 =?us-ascii?Q?znvTAM9Ihxnj6o8UWERWxwAMr8HKUTm+HAhXfs8l/hec9hzakmLq0fKftHlZ?=
 =?us-ascii?Q?m3nv4Fpr3wVKNaNEyJLG8tTEidzycIgdpG+8wdOxagOofqkuWRoVNmhQh63j?=
 =?us-ascii?Q?7kciTBYxqA7j4q1D1bqDxYd1EfdBfzzjl/qP09D4TGWQWvni6vi7ZJFU0Ppi?=
 =?us-ascii?Q?+KW+jJ0y4H4QPf5l9P1e7+C+1U5mGaBqm7VRF3NQN7jAtNndZY2yXTZZ/IF4?=
 =?us-ascii?Q?pzNCElcpIbUGrAFlRc+PjBwuNhEcbBfI8cGCCYhu1vMwIC7fYcfAQh27SyVw?=
 =?us-ascii?Q?+qc9VMKBGZi4x8oXrr1hvO/eBdVqmwkt06ptXl6pqpUHcHwBe/sMpqs421vZ?=
 =?us-ascii?Q?XZx+eVqY0N49p9AwzRA+lFNaLZfLoF2AKkfiyI13knCyncCphUfBPpCMCe9l?=
 =?us-ascii?Q?7E42t65d9fWkbI3xGOJklkBRL0pAmwYCOODJEMQvRFO3N0AxBpmd7JgObUMm?=
 =?us-ascii?Q?5qZ7AgbLFvN3oNz+GgFqSfGuLkfVb0wmpXqAgAHRUopMSmRFn0QdP8VbjX/S?=
 =?us-ascii?Q?TUnvPvDzwksZtZkH5M9lh4IzhwuBmZS92fcqRkrRi6x1g3+lAQrst14VjF14?=
 =?us-ascii?Q?9YlPXueshv4GvF0+fLFMTTfekxjUHqYyIIqIJ1s5T5igjnx4tHISaHZJI66/?=
 =?us-ascii?Q?WvHgfLO/x5NbNBWeVhzzdBvqcmaZaoLK2HRrNjRbIGCXXUvycQ3LISwAWvLJ?=
 =?us-ascii?Q?MQwEJMwqxxr3zlaYEDQhN9W+6jdPE7E0jbog5C38UWwvGhqBT3VzpTlc3D07?=
 =?us-ascii?Q?N71Zu8YoLYwETJfG4B8oG+aFswDYNCRqLVDWeQ0826wSugiicLz57wXFwW91?=
 =?us-ascii?Q?ZZ4r3LF8cpGSiCMCzjGmjBpF9VVVMHlkhwM4e7m0pPx8NIvezebHzYcPHRwV?=
 =?us-ascii?Q?QGambC9cCWV0nMumragTIWmwMVFzuR5d7+wFP3xcj0zmXrNpmDsmPoVHUKH/?=
 =?us-ascii?Q?PTa9Sk/uOpw8jXEVCDdA4u5K0i+ARM4PlwZmkFcUzB/id15/6wE2RXLko+ri?=
 =?us-ascii?Q?LxvHVlaH8gGaoMMgwuOvGy1UjKcQxmt2Tk3ILU0TqgTSh6xkP3LbxAj0yweN?=
 =?us-ascii?Q?Pg1KvCJM4iAxrqigKryLvsiyQ9YKrIxR8WIGGE8QT2jHBdhg+sPhUkQo1dha?=
 =?us-ascii?Q?U/pHuVhllubLrPjo6nvaMjTAPev+2yIvDXfz8FK4UImlhsecsHOnmx3up1rX?=
 =?us-ascii?Q?3TWmOzfDtzwkMPjPJjd5scPXfzsmFCRqiKB189uuoPuZxX+aZjCE7DSRK81j?=
 =?us-ascii?Q?p2TonTyRhZqudGgf2emRG3pC6mnj5QfNo1HZcKQ6RxltlNYyDEuIyhUEyPso?=
 =?us-ascii?Q?lmwmHem7523xal5MczLe3EmRx0j5XmQafA+yOYvSJdx/MDjyCmze0FY38U0q?=
 =?us-ascii?Q?YJtP2JDvL2qmW4HRz88r9ZttqsvoUkJWFnT7CpDv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qjBdD2p8hOznFldzZnN/O1QOCI4pdW/aX/tOiEZ0hKfVrgU0LDhCQtWlcrAaTJ8KmCnFd3yY2QT9cnBi9jt7Ul+khacd7FJfqGS20IyVzxtSqzcWC7hfz5ywQJ7Jsr4rg9Nq++5kd6OfmbA9GjrP2oChj2HD/8rLKSoddZ4tztt1JD7v2fZOGDMzYpf2VZL5KIlXchHp0I2HgjDb7aWEBIrZbOTDeYhhQ/EbgzoiogBX7r+HO+GfdnHoZF+pnWh2mWvyI2vPir8nnkAAr1i4bbWcAJCg5G+tyT5CrWjZ7n6MtONvUupT1G8woI4D4LYhVBq8mNWT4VklQsodgleB3FnVEQ+96764am+T1TKonLaNruRHZ+ZBqLstbXCkucfySABxmuX9Z9Pe8+Ehfczxvp+E63+pnyC9WX1LE+oE/jinj0elYuSBsalYcvbbPacOvlHKPxKEjUh3/essqz7Ugmx+EsdQOwkfQL8iZQByHgZZYSW7DGqMSt4euMxp8cZfHJZgMfn05jnIyMiLZTjGLPGtxfcpZnbiVonbNX2xbbXS8NthCx1d6omdVEXG9WlC51rX/QiQe3nIn7MHX/rsddzBWuMKyIUMIvcIGdKN1+k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e953f18-588f-444e-3b40-08dd2a8f7a3e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2025 18:09:47.8979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43rM86QX6m7hEfHWkqNMCYX0wezzpdyZ0bHcZSowKIChyTm3wTea/LBAurJfd8Kz0v5Xa89/a3lpt1eRth+4lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5549
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-01_08,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501010159
X-Proofpoint-GUID: eSj8yX07k5skmi8UHm0rxM4lJfEEz_Uy
X-Proofpoint-ORIG-GUID: eSj8yX07k5skmi8UHm0rxM4lJfEEz_Uy

This change enables specifying additional configuration values alongside
the raid1 balancing / read policy in a single input string.

Updated btrfs_read_policy_to_enum() to parse and handle a value associated
with the policy in the format `policy:value`, the value part if present is
converted 64-bit integer. Update btrfs_read_policy_store() to accommodate
the new parameter.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 3b0325259c02..cf6e5322621f 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1307,15 +1307,26 @@ BTRFS_ATTR(, temp_fsid, btrfs_temp_fsid_show);
 
 static const char * const btrfs_read_policy_name[] = { "pid" };
 
-static int btrfs_read_policy_to_enum(const char *str)
+static int btrfs_read_policy_to_enum(const char *str, s64 *value)
 {
 	char param[32] = {'\0'};
+	char *__maybe_unused value_str;
 
 	if (!str || strlen(str) == 0)
 		return 0;
 
 	strncpy(param, str, sizeof(param) - 1);
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	/* Separate value from input in policy:value format. */
+	if ((value_str = strchr(param, ':'))) {
+		*value_str = '\0';
+		value_str++;
+		if (value && kstrtou64(value_str, 10, value) != 0)
+			return -EINVAL;
+	}
+#endif
+
 	return sysfs_match_string(btrfs_read_policy_name, param);
 }
 
@@ -1351,8 +1362,9 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
 {
 	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
 	int index;
+	s64 value = -1;
 
-	index = btrfs_read_policy_to_enum(buf);
+	index = btrfs_read_policy_to_enum(buf, &value);
 	if (index < 0)
 		return -EINVAL;
 
-- 
2.47.0


