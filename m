Return-Path: <linux-btrfs+bounces-10430-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 530EB9F389B
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 19:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 637127A51DF
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 18:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEF5207675;
	Mon, 16 Dec 2024 18:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TBti3Du2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rS86iyU3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138901119A
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734372886; cv=fail; b=ExDQChpbnvq5kCIB8I6cymublFhdz/mP71iDSwuRx+PxagmLiDkvhhdyPT5zvsmobk4++QFSo1H/5DbNYMUd6f1GHdjkINFhIVb9SMjFf9yx9DbtnzDQ+MtsmL+q5azNAP0SfTGLtZ123AUdaBEX+rb7UCD8DOWuKef8feR8zvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734372886; c=relaxed/simple;
	bh=jixQ6eXGbbBrL5gTjEggyrqR1arsvmannpBZNiZg0ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pgLACMKKaawVUi7gP0x5vr7VB9qCV1RFAzmDDFZZcD5Z6f3LwLcFr1fVjkzr8M/79p4H9V2PWXXryx7zFbOOF7/BPZMQH2yCDMkh77e9pUD4WEtpOROdE6fuRaPnvAxcR5bEaijG17bFb9DLsbKpn+uNtsufcaq/2jQlfYB+tik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TBti3Du2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rS86iyU3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGHQtYD015434;
	Mon, 16 Dec 2024 18:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=RsqfTHbA2pzjYDDhHJnCvvSZhZitlR0humcKeNXm8PI=; b=
	TBti3Du2qLtqJukTpsZ4ilUJk0+uFvLFT4j84OwHn2IYv138QObhbrp2ZVOKbV8k
	/MxIPYkZWQtDZ2X2U9wtZKc1KuxYT9CqNv+4UO6OTwXwzjsdVcRfxweoF/EFexgT
	GsacoyoO5MwyxsneNarvhm3lkPYHEnKVBQ0PDcV5bCIOONBxA0xDi+TKBirZc5+g
	vsepaF1s2j0XFN2SxURfDlZ71bgYL4NOkRGy054WyNG1ED0B+Mcn+rHWrkUNOQG4
	y/gsyqgYfQAyclTUYX41iulIv4Oc+sreNk4bh+9dRTWxx++7YtyZt4dx6RlGDQuL
	ACyCm4FfWUjMljM8Q03iXg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h1w9bxd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 18:14:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGGsuuX032823;
	Mon, 16 Dec 2024 18:14:33 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0fdmwr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 18:14:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gu9Wqu0ls8aifwsLNt8bbeZJLONHDo0jOvU8GxATeV+lLjpwA9j0lznOp/Fr0bGAYg6l5l8BDZDH3v8hlBnLedEG3KBZAGc7PXAxP+1bPJhc2OYM7hY47bAspl4FUq9emsrnQTSZfCsafggxKXHRER5qzJLPceDF7vOK+Xx5BXvtau4NHRZ113LegfIYWan5P8hCj4w2hK82OdlwhJw+yQOl3JyayecKIspZvZUYcHzuJEQhZKoEuo71rxjB+f4waGMnMaAZixt7TGm+MH07xnkUMC+GjXBy5QGnTxWF7GheSCT9naDm5Ptn+i8FpTuc3twWTZsHwIelEkAN412OoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsqfTHbA2pzjYDDhHJnCvvSZhZitlR0humcKeNXm8PI=;
 b=NAcA+N0LSWlu11wB95egzXrxa5Jzs34npvRS6nBcQeGpFt9JYqCC3Nr19HIHWwG0iAtobUi01s0qBXhXLi81emJMq2CgvychU3+ydYNS5ntNOF9rFaOmliJzslvaohDboJ2HxP+5Sg9CMrug2ctxw/4shZLNtYEn4+kJUgFnCxZkqgw38zgeM5p8IaF/HbIIQwmC25PpShvh1BfZfHSMekhCdlcsG+eV4RZTIElPBh6Ffqz8FElEzNwhtt7KljAhr1q4rDtuyVqDXCCMvYmNqKJpdks2lr0GV5gYz8nLxFxd0EUcw45ik4xlMdp3jNSW/J6wpKgGuus9wYDgmHblgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsqfTHbA2pzjYDDhHJnCvvSZhZitlR0humcKeNXm8PI=;
 b=rS86iyU3YvqVlEORGPyU2h77rBqFUAbcE7WG9mNWEi7hEgzg2IAQ6O2P2NQQIBk5tyU8Rfg2RnOpbRZ8fvIeB27TMX6ZyvVK0GAHP+pmUbj3FmgAMBGIlkA4UJjfFdbtwsCA7fHOyqhDWxdkoo1OLtw3GYSwa/CjdH0H7ZPWd1c=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB8220.namprd10.prod.outlook.com (2603:10b6:8:1cc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Mon, 16 Dec
 2024 18:14:32 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 18:14:32 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net
Subject: [PATCH v4 8/9] btrfs: enable RAID1 balancing configuration via modprobe parameter
Date: Tue, 17 Dec 2024 02:13:16 +0800
Message-ID: <160fc9158a79d972f0a0b6bab0c417c6728c7f98.1734370093.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1734370092.git.anand.jain@oracle.com>
References: <cover.1734370092.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: d7d9bad1-af77-44bc-745c-08dd1dfd7d1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R3GukB32/6sbHsefST3Ot94Z+fC7R95GMdPw5UyMI6hi5aJIBIK68EYtFV3C?=
 =?us-ascii?Q?Jry4qhLPDM95tN3dYJplZ5upEjKGw5DZoXVxjS+aY3urx2EbtrcycZdN/afr?=
 =?us-ascii?Q?qaVEro6mdxau3QM/OvkB5sx3EaRbxW0yArAd8Zrgqtc3MPSM6PlhlnVi6V0m?=
 =?us-ascii?Q?cePgicxv7ox7caZf1AUT97QuPLAYbTdKuCMOzMPa4zfVPV07r+20XgOT79Y2?=
 =?us-ascii?Q?OCcA71AOCuT0ytiyKrVVdqSfb5v9/mCaLKQBYK0WHBGeoh60TVc31Y1oh7QW?=
 =?us-ascii?Q?5MUXg1mkTCfsQIhDSpvx2nDvxe8FN29L0c3EJbh0EcbX8huWKLxI2NbRkdmx?=
 =?us-ascii?Q?ibvutuepzNjLeLnxrO1ol9dAeJG/RzfWI9JU0rfz2obqnWxRSpFfsN1RtiDX?=
 =?us-ascii?Q?pBrpai+OPokpkG7eN7AD1JsuCE13vb1owxEWyDk/I4MU8xA7uaO2s04Q0Dtk?=
 =?us-ascii?Q?F0i9zo9Wx4E/t+2Gdr9BjtcG8CLLVIchmGNYXOnG2JYRkhSura4qTo85RGyv?=
 =?us-ascii?Q?9Ci3vc9JxQY2CxH48w1l73ih1VUsmWJfyRX7q5Bd/W5FRopDepTEm9wWWHLm?=
 =?us-ascii?Q?QKVDovWNvp4hO/7cQbLSBq2zzR7O0/+A0uqIiXNEyPKs9nGjfuNRz1pPXzLb?=
 =?us-ascii?Q?+WQla4cS9LkXvl+KZfhhb4ih4s0Iqpg86gHsg2vHLTRhWGMcCGS2SPZNl71c?=
 =?us-ascii?Q?7jgXdQMeSEGGFM6T8ljU5GvPfffqdVUsi6EDvTXGOmGQltOlq2ZZwJ3vH6Nc?=
 =?us-ascii?Q?MdoRvyhuXAP3wfaj0d02YQkm3la4E0AwkfCOhFXy5YGvJLYBe6Rl0a2JMvEg?=
 =?us-ascii?Q?WgcGy45VVN/3BLe2MoXPzZe6C0SOC3dSu2ei05V+8FuSu+0/K6XwT45dV7CL?=
 =?us-ascii?Q?KM1gyGdtBOLsTXiuGmNuXJ8VASXH4Fd4bjry6SnLzRzqZlIY75Dp0fKYcead?=
 =?us-ascii?Q?jm6o4xow8t1CX9yN4b3AOMK6N8oOrh+BCcSVDAvveeg20SINYPmnxO+m0nx5?=
 =?us-ascii?Q?KYDCOywtOY61qQ6YP8bHc/DBVmNGyGhS9ZPH3wToXfTKP3aG9v8f0k1rXCvT?=
 =?us-ascii?Q?aU/mvwZ0+h9PgZnluL05MJfo9ncuBhi4h9mzXKR9Q4FpdNyNGOARVALYJGX+?=
 =?us-ascii?Q?3W+Q91ZfL/RbWz/ZZD4FLvOgZKT9kSZo8c3pRTFu5rgccHrX0NjDKyK1GwTw?=
 =?us-ascii?Q?QdYDumnYTK/b5PL9HdJUZqLeSwP13WOo2cZXH0kNmlXT+Gkz9whJfigO7bgV?=
 =?us-ascii?Q?jpQprWCF4oT0veDrkXr8zjxQuP923S9t6O2E/6k097iu+3TDEz7cIDxxZ1lT?=
 =?us-ascii?Q?Spj55V1LvAB93/LL15BIdjKPXIfJ1VyRfxqYL4KOYvSF0N9B+VEgJ6gZVMp5?=
 =?us-ascii?Q?UdHO8EA+q31+lxJMiJnXCCyprZ26?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AJLeeokrksMTJhe1bOc39YeDgXdukjkZm0tgPuW+lgJvSv4Z8GbYWWwrJB4V?=
 =?us-ascii?Q?aovKY/S7tgbxj85hysL2ptiCe6HFkEMirrHqBRgjkKUhRKxy0EhOjYdUS7hz?=
 =?us-ascii?Q?yolqb329bTqPUdGel4qKB69tDxSXj9x4UDqWs4fLPJl7N7WTIZe8pzCCdr2s?=
 =?us-ascii?Q?sKWnOvA1h9SdtSuSIDLysYG0b60/1rx+uR3ERswuvYegoCUVMsD4ucnRSn1q?=
 =?us-ascii?Q?eaarR5FdR7Gk73Zif4RlB8en1h9AiPxBJwUiKpZWvtl9qiGVqYj9RJwQrj9z?=
 =?us-ascii?Q?/Wefcj/Jecri5MMKGTXqwVmh06Brx7sIT+jlnAtlZRp8EE22oawOqc/biLNI?=
 =?us-ascii?Q?TV5XsHFuMj6edR3m0bC1v3HQgj9x/J7kMY9Saxe7qlgSNQglAEgm8deR57Pr?=
 =?us-ascii?Q?xXcaOlVAU0D7rKB4xMxKgG9G4gU8UOEt/YKmxFMKOExwgsW2IRTz/kw12SMV?=
 =?us-ascii?Q?8RNPz1Q3R7BD/7Ah7335Ih12M+fk3Wo8L2HgNFS8XdHNYqctVKmvcP0uU1v4?=
 =?us-ascii?Q?AXMvmpaFZhhXelZJbv7MHBKm3H0e40ZydIMT1DBpxHQwaeh+kym7HnMpdhZ9?=
 =?us-ascii?Q?LdPYKd4BIxRQQOyxuMsXdTOK77orOIjlCYfjtIu7nyt7OHuHg3T4TOVi82Zk?=
 =?us-ascii?Q?lITe7vzIxL0DZ9vX9rQ227ZbR3AA+QXwbgCB6J/zw9lrKIwUk7XFzmpClxCM?=
 =?us-ascii?Q?cJBqqnUfLtvaDspDIEbfg2eia2qwNj4gOx9EfUaa47F8wQrog+UTfFzE9AQS?=
 =?us-ascii?Q?Da5HPDyOJUMAjhJiO5Qgf1gFl9qJ3wP+cGvm+spPlGVf2yP48LyOk4gPthht?=
 =?us-ascii?Q?a+L6cGlZxBbXOFGlWypyWzicu8OWRbxp+pzT1/Jd7HLJOKd46lDWzdnFju19?=
 =?us-ascii?Q?wZ/fdy7a2HfPL76uo+Wa2eAGzwMJByblo/DKLFuWu/yVtjWYanXxWjUZ+f/u?=
 =?us-ascii?Q?3zWrPzZ5A9j4HiUUi9KFksLT/bMspobwXiEUBIcgbli32CLAYv/jGOD+Y51b?=
 =?us-ascii?Q?aoSp6CcUIYgFofK4ukz6/DvPGVrg8VFx6eDiSXlXAui//MLakUdMFFQeLOXn?=
 =?us-ascii?Q?2JZRqyZznwIEQivcXSsKaas+2HIBAm/n4O7uogzjtOuFmTzIGjXHL4XG56fU?=
 =?us-ascii?Q?zyaEAJxl7qm+0lCeIarvb5RJURDlgiyUS97cm4OnK87FpBhy7UbTDVqIQjVv?=
 =?us-ascii?Q?RTZoLmhBScEL4A1eqvqhtUh7pTLLPdSdc+3M+8akHiYU8pUNRdsibhL5GiZD?=
 =?us-ascii?Q?kDqYo+lUw4PRXqpIWb7R0paD2mkJ+wcaLtxRmw7stEKRXb/Qca2XJCSip5ov?=
 =?us-ascii?Q?D9+59wk26X3cwnfMFs9HQbhhZYikWToOI9wC8D542E2NTeVPbtMKZfqcMoYQ?=
 =?us-ascii?Q?QXMUpinzI112Jw44evN4TRvEBkdaD6kqBJI6ikXdGscmejwGJjDltb653Jb+?=
 =?us-ascii?Q?vqJTEaWklRo1EOBL7WZArEBbpddRxR/pukt9sQEnKFmtH302ceeZaqEiuBjV?=
 =?us-ascii?Q?bykp9rAgQRWxqdyzE7sDtappZPsP6eeKAlDLggbRDJVgBlZRZyFkki/BPL6r?=
 =?us-ascii?Q?qHaYb6Ojvn76bCNSA5FjFZ47e4EvGQeHWTyLXKnC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3s/qqW0Xmb2var8LuQEYiU8CjI7Na/nfxVSzUFrSRzBsc0i4rH/JK9LPgJeJElEikOsUssnMlMfd436gewq4RGyKUW8PQQdNJ6TLKQMjwh5NOIhL/Rw1QkSeXeIfcrY2LRoA/qWiTh0Xj2yxtPd9ckjSxVb53MxnQG2ZdBrYdsvyJDRQB/VakG1R7ETpd3WQBEXoBWuN2a4mJVtBCziHOrqF41ge1G1ocTjHi5sZStM4hVdTNe3MLf2jvN5yvO4B1THIZONr80wPJBhx5Sp9T6F1vA7Sh7N2nWhm+LTpMlj4L027lulv3bXsHwyr7jbuH38p8i27X0PJ5LGtStYqi19rzBd6KiZJt5PEAnNukBrxOp8P22MgqfHw1QHuQaa3LXDuKCc3x7qfnlombYvGm7Ik4JeC/87gUpnzq6E4ATDhN9h7Khqslo+w1UBvVYONgaBP04SvOTzaj/noOvo7tZOyyILoTDmel8eqy5njFKhrrSs4pTkFF5mXw9J11Z5WWitgMrPzEd+O/8jv131nQw2Yj+aOuv6akMbvZr0fZflCxDCynAtAkaGjQ1tzhD+xjqsOLDyymGQooeO8xHoE2lNHk+EUwH9/Yl7oS7fmc2s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d9bad1-af77-44bc-745c-08dd1dfd7d1d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 18:14:32.2575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ep1WFsU7rMFHnKvEJmi70RiYlTwiHhldajETTlcfY4I+SeDig2qo5nMwSYI8kP8ZfdmW78dzFaUOz/LpZ6MbDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB8220
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_08,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412160152
X-Proofpoint-GUID: Gntp_Y2UedGIkTLLNcUxpHoSF1r364gq
X-Proofpoint-ORIG-GUID: Gntp_Y2UedGIkTLLNcUxpHoSF1r364gq

This update allows configuring the `raid1-balancing` methods using a
modprobe parameter when experimental mode CONFIG_BTRFS_EXPERIMENTAL
is enabled.

Examples:

- Set the RAID1 balancing method to round-robin with a custom
`min_contiguous_read` of 192k:
  $ modprobe btrfs raid1-balancing=round-robin:196608

- Set the round-robin balancing method with the default
`min_contiguous_read` of 256k:
  $ modprobe btrfs raid1-balancing=round-robin

- Set the `devid` balancing method, defaulting to the latest
device:
  $ modprobe btrfs raid1-balancing=devid

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/super.c   |  5 +++++
 fs/btrfs/sysfs.c   | 28 +++++++++++++++++++++++++++-
 fs/btrfs/sysfs.h   |  5 +++++
 fs/btrfs/volumes.c |  5 ++++-
 4 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index fb6a009c72ae..58190989a29d 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2538,6 +2538,11 @@ static const struct init_sequence mod_init_seq[] = {
 	}, {
 		.init_func = extent_map_init,
 		.exit_func = extent_map_exit,
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	}, {
+		.init_func = btrfs_raid1_balancing_init,
+		.exit_func = NULL,
+#endif
 	}, {
 		.init_func = ordered_data_init,
 		.exit_func = ordered_data_exit,
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index b4b24a16a50c..dc10908556f8 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1313,7 +1313,21 @@ static const char *btrfs_read_policy_name[] = {
 #endif
 };
 
-static int btrfs_read_policy_to_enum(const char *str, s64 *value)
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+/* Global module configuration parameters */
+static char *raid1_balancing;
+char *btrfs_get_raid1_balancing(void)
+{
+	return raid1_balancing;
+}
+
+/* Set perm 0, disable sys/module/btrfs/parameter/raid1_balancing interface */
+module_param(raid1_balancing, charp, 0);
+MODULE_PARM_DESC(raid1_balancing,
+"Global read policy; pid (default), round-robin:[min_contiguous_read], devid:[[devid]|[latest-gen]|[oldest-gen]]");
+#endif
+
+int btrfs_read_policy_to_enum(const char *str, s64 *value)
 {
 	char param[32] = {'\0'};
 	char *__maybe_unused value_str;
@@ -1348,6 +1362,18 @@ static int btrfs_read_policy_to_enum(const char *str, s64 *value)
 	return -EINVAL;
 }
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+int __init btrfs_raid1_balancing_init(void)
+{
+	if (btrfs_read_policy_to_enum(raid1_balancing, NULL) == -EINVAL) {
+		btrfs_err(NULL, "Invalid raid1_balancing %s", raid1_balancing);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+#endif
+
 static ssize_t btrfs_read_policy_show(struct kobject *kobj,
 				      struct kobj_attribute *a, char *buf)
 {
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index e6a284c59809..e97d383b9ffc 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -47,5 +47,10 @@ void btrfs_sysfs_del_qgroups(struct btrfs_fs_info *fs_info);
 int btrfs_sysfs_add_qgroups(struct btrfs_fs_info *fs_info);
 void btrfs_sysfs_del_one_qgroup(struct btrfs_fs_info *fs_info,
 				struct btrfs_qgroup *qgroup);
+int btrfs_read_policy_to_enum(const char *str, s64 *value);
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+int __init btrfs_raid1_balancing_init(void);
+char *btrfs_get_raid1_balancing(void);
+#endif
 
 #endif
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ee2dd7e461b3..3cf4fc06d261 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1327,10 +1327,13 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 	fs_devices->latest_dev = latest_dev;
 	fs_devices->total_rw_bytes = 0;
 	fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_REGULAR;
-	fs_devices->read_policy = BTRFS_READ_POLICY_PID;
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
 	fs_devices->rr_min_contiguous_read = BTRFS_DEFAULT_RR_MIN_CONTIGUOUS_READ;
 	fs_devices->read_devid = latest_dev->devid;
+	fs_devices->read_policy =
+		btrfs_read_policy_to_enum(btrfs_get_raid1_balancing(), NULL);
+#else
+	fs_devices->read_policy = BTRFS_READ_POLICY_PID;
 #endif
 
 	return 0;
-- 
2.47.0


