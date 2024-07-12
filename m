Return-Path: <linux-btrfs+bounces-6422-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C7A92FEB5
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 18:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F5031F220BA
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 16:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2A4176251;
	Fri, 12 Jul 2024 16:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EN7Zg9CZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OEP2kMr+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEC61DFD2;
	Fri, 12 Jul 2024 16:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720802511; cv=fail; b=KM8qAtjoyHS8IXLxZeNehjU2iDiCKKzehiQg6UPlGzaxe0EPb9gH0/LiKxbZlXy0hasPKdVNWxbwndl+2o2XrAHtEyZiNhg9IFdhSlsaTj24A05l05vG3QNI1WMLZ+MdMnklfg2op00DAP8ax8IhjdqPVT+VyYjLwx8XGdQGoG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720802511; c=relaxed/simple;
	bh=7AGeG2QYBnzBiaohRSiswkF4qKtFc+FRMtJVcNGbyNU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UjI9JqDqrebiVz8lKnOGn7b5yjQTPL/9omd/BlTr4hmZ5cTBwR5g+nK4IItOTr+8udqqwbTK9EZmMijL0koHTBdKb04k3kxqIyylE/OPPEjVWFRJESOuJZdIT6zpq2sz3DS06d41VbLqhf5Wsfbj+87u89WjXGG1NKO46Bj4Gss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EN7Zg9CZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OEP2kMr+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CDIS3q023196;
	Fri, 12 Jul 2024 16:41:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=Xpqh+HwJ7+QX82
	YQl6f9eDCOh3psQ/y29c81iq30sIo=; b=EN7Zg9CZanwBHHoQtVrLZGUSmAXo/g
	sPV0VfijoyB9vZy1BCfoI2bhsounKKlzOe2uxpuKgMbP4u6nSfVopZ5S9stfu21s
	I/QFmnT8WpcUdZFLkXEgbrlTUcJMimduAlz+wcIRTsip0MSn2pzBi/TRz9z5nn68
	H33KQUJTE5Dd9gQ5Qy7IMz9i/5USVhgXGhnZGy79pwKTgroBU2dAPOc0FmfWjfmF
	jWZu9847uheKImZjc5EI18qemZHwQRvLg0YEBjHv+m3Pe4JxrC1DE3dg0MQ+BEGv
	QQw8TeMBLUYKFxRJ+bd2/gQ+iU3ck/JPnPB9KlB54NqTnHmW6su4nVuw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wgq4d53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 16:41:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46CFOuVs030104;
	Fri, 12 Jul 2024 16:41:45 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vvctcuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 16:41:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrLak82QvJh6Rwf5brp5r8nIbQTaICkbNXmLs69a/eG4mp1RTcMOXjd7Tc7XTY5xZNx265M6mtYV5EljUBk7HwFjJLlIIzgCnDbdFJGgHT6JaA+DDFPobxK0L7splKbCgL3SAv7Q/Y1EarvEUeItNmb46HsdJPc2j2uw6AliEiD4L9037IsFj0yXx0NMbk3FWgKG605MARkT7sek7l33LtOkFhcy94Owr90lQzdMt/GOq5m1j7ph5WUNu8sm2xZWsBrzdstIOibqqGv87AnJ3KZY4Z02rPkO2sj46NYQjDwXEisYQXTbQvmu/x4sE5zZQhBBVLhJmNWUy/3LV5UHfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xpqh+HwJ7+QX82YQl6f9eDCOh3psQ/y29c81iq30sIo=;
 b=aQ30qR96hLrVDD3OyaIdMb7tdn9T34qkzpwWE6iN0rBoMxVzZp/+N/yW/3ERU9yAo2dvZySm9QcKOObTdKdURaDC6laJon8zh1wHiDw8LqlsAe6YMk38ZOONoRpaS/K/t6tJpjd+Av+F+JZFl+u/GzgNvfXlcMPov8xlkx5a4YIv3LIXQtDtDpmgBwD9dYmjtgdgrtmlfsYUKDed2IMuxociyrfg6CnNNKZT8QTndJ3+vKpkRsM8wBnzMBUMfY/YLrGWLKF5tqhRwSFks/lynEYJo3Avj/tOb2/dXZTmKYa5XmhVGF2mcwpO1ao6nGd7A04cqZd6UEQecloG2LguKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xpqh+HwJ7+QX82YQl6f9eDCOh3psQ/y29c81iq30sIo=;
 b=OEP2kMr+q0RmML9XCoqd9wusiI6pTjnquviD1WPf8dHP6TOMcnOUV8cEIp1TPQfxC57dPsatM61tLS7DPLpQB1qpH3hxAwv7yrBEYKtV1hI+vM5ozbrM4mHOhgd6HA4vZXejZx4J5GAO2qS9JLsjYgydMaBdBu2FNdqyEX2KUv0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4533.namprd10.prod.outlook.com (2603:10b6:510:39::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Fri, 12 Jul
 2024 16:41:43 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 16:41:43 +0000
From: Anand Jain <anand.jain@oracle.com>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [GIT PULL] fstests: btrfs changes for for-next v2024.07.13
Date: Fri, 12 Jul 2024 22:11:32 +0530
Message-Id: <20240712164132.46225-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0053.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::22)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4533:EE_
X-MS-Office365-Filtering-Correlation-Id: 27ea0f24-b75e-4b2f-6f11-08dca29182f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?zbyN6xvXbDWzovIyRJDS/B2iFVzOlcA6BPMZJUF+st6o0LysP9orWWDBjgp5?=
 =?us-ascii?Q?vdLKNwy7STy2wyMu3tw4dDFL9iWGmzsdis4pzOeuB9pAyVvJ7ccQNcLJ/NLq?=
 =?us-ascii?Q?bPXakIxG3bxisGGl+WwaD6VNnS4B1qfkkMPohajSFWwC8zspMMqoO4kCvjpH?=
 =?us-ascii?Q?DZWn1UJmcqjzKE6puLKr9qMFQPIVs8BD/2HlkPI50oeUtJezmLsIdt3al1ja?=
 =?us-ascii?Q?NUOiL4mxqzRDqGqBO1B2DCDfJkGQS6aqPlGI2l7YXtPbuj6D7mD+PB8f43Wc?=
 =?us-ascii?Q?dzxexKfLKSJJSOVK+FiBMjBHm0F2C890vL9XkKqUpS7Guyc2hYDAU5J8mO2P?=
 =?us-ascii?Q?DdF4EXptl91KZRqEMTnsRwEJu3OXD5icYXZAp2/7F8Vz0dUPSCAUfD7oqCiL?=
 =?us-ascii?Q?kmDtZ8Yq3mnwJ9ILPhd8V5TVS9+sWWZ6y5IwObKA+z6ZpBFc0DZnG0A2M1PH?=
 =?us-ascii?Q?zmFaLB2g2ADbXq316FA6PgL0NEWsEWaBHkR4Ws0vX7mFOoEJcZzCyVsLw9gu?=
 =?us-ascii?Q?qtIJtXqzs2N5LBgL5M9uWeSOlcYd6ku2q+FFgDnO+QRP9Ts/QxwwkEX8Vx2N?=
 =?us-ascii?Q?UqTsQgZydDFnRBL4XxCpYc5zqt4eQy79NNj7udvNBkCdWig96noKU4wYe0TG?=
 =?us-ascii?Q?DHnP6IkWZlwMk52w3rfEeNuwJkjOW+bN8A7NrtERBx3MJerLLgbYH0beYh3k?=
 =?us-ascii?Q?ulRi1Dn9XaWAKLm8Rb3AkVg7cvvHUj3tPWJ4/v0s8+w7IzFNsfaQXILF2Txj?=
 =?us-ascii?Q?9ykA5KRDhU/9PO99TCpQFZ6BxY5PaflIQotcbD3xqtgxYZp9w4VdyOhXbA+0?=
 =?us-ascii?Q?oKRic8I+YtuNN7ojmRi4utuqEc4XFtLCYlSWrLwi+8ipdNt3h5kUT+v/d5tG?=
 =?us-ascii?Q?RJgZ7G94CD3Q1wtYPtP/EdW4+4EVlAUEyf470N9wruHY4bqpkeyj9PYJ6/qS?=
 =?us-ascii?Q?JQ7rPWR+4VfSgpKO2QE0Vz/jItApTGpD9kBlRU6A9A1G0tiY+NebcF4qNdRs?=
 =?us-ascii?Q?UsvAcKg3GE9FVWvE81E6crRI3V4rr2nq7ZJGKH11rtnsynCvSOhFx59gxP1q?=
 =?us-ascii?Q?YBXZU/eGv6YjHTdywtXsvXgg2GXekCKdPSKRz/j70hgZlfXvVlE/YCw6evhs?=
 =?us-ascii?Q?833Uy/jfV3yEkIhesWJ79QPLMnygTHAj2UXUYHzv3ydwDuWaj3S2OTy21QXQ?=
 =?us-ascii?Q?+wg+VOWLpoVa+gmzHJEEAnkkokb412D28NMasALeKvvcWrjUGIe+LJripPHi?=
 =?us-ascii?Q?nZZZYfc0vGgL2WTOH2cGWypQa71HLTb5z1ClhPZj5k9L6ZLhrqNHzmoyjXwm?=
 =?us-ascii?Q?VN0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uQEcmZ5cAeaPXDaFHy7z3B1jT5Y4j9IuMYwR+W/CLgn4xOKaraFb0S9oB6c/?=
 =?us-ascii?Q?442Yby9OEABXgUkVo4cwgP+Re8SHaU58bLGjDsKPuAQQuBuDsLO9jsC9MQGp?=
 =?us-ascii?Q?RhcsctYC18rLgfDd/J0H99NiUO4ha/KO9DUDeoa0lk7mxRfY04kZ8aBtzJl3?=
 =?us-ascii?Q?3fql94d7XhJuFdGn11wV22CKckCSNKRUmrsmbojbZKPAl1wm/kaL6bt68IDQ?=
 =?us-ascii?Q?g4kYfyajDXTkfSHQffImwmyrkfB0MA91aGMNscWEbRiqKe5OVF1kQIEN5eRN?=
 =?us-ascii?Q?wt4WsyaRg0kmoXhfX+QeTcoXbJ/HjdEGh8z4CjAYTxaKGzgGlq0Q1U4elH4R?=
 =?us-ascii?Q?0a6FjBgS1pi+pkbYZQUT3EPPktQ+J5ItGNP25oMrH521ZwvXIPtJO4M4LDsB?=
 =?us-ascii?Q?w2zAiKpvkx0Ii8RuRiLeyREnQJUb8p6pYv7nBCE2nFy6RMBFaXOND0d6yMh7?=
 =?us-ascii?Q?GwcSyUxlB7fJxVhXSig0FWOvHplW6LWcQEruQ3LBnPV0L1/FSASTw26pg1Ch?=
 =?us-ascii?Q?sWZu8a++GOsLDnfbKcUpEc022mfNiXt7leGVnKXSYKx6cqexxshnUR7AN8dA?=
 =?us-ascii?Q?cQh2jZ2Owo+tLHit02RAI59ovXb8Lg4CL6sb0yZyRTzmmwn2MuVyccFILzcf?=
 =?us-ascii?Q?1YfVB7oA2mR3AzWhgqRHfc+7eEggruj5HJj2by8RvHuAFu46ha/B6Fu1NTWK?=
 =?us-ascii?Q?SA4DdtsLPzi4KYVKtH9DOxAr4TJhI+J0VXVOobATwEefkMYzY2JSe1K4iFlq?=
 =?us-ascii?Q?TZdSyUuOKtMJE9ZQoJH2AbF3wOsb0wJPULv8RZfTWc7OCzHFid0e5ANik6ru?=
 =?us-ascii?Q?+cOHbVI/Lc6PavhRpu8psSMoTO8yrHEdrVHgt2ge/jM1H8Xkz1mJA+IlM1Si?=
 =?us-ascii?Q?vE3O8r9+vZTlvTfVRFnk5fANjXmdMOM2E+6Dn522AGXDz6lPCyjMPegQ4ADM?=
 =?us-ascii?Q?K47Dsw4dolkEebk4SEoOb23pw2b0wGsiQTAgc1y8nKbm+ufg/THA9Nx1C6gd?=
 =?us-ascii?Q?mFmpIiYXf/Dh+4unGC+CLpy7cLbWD3FDBLML6SFxj03yRVQB3WvdK+MngNFo?=
 =?us-ascii?Q?dr/j8Nwb8VCY3vIms68c5q9bG1fbWv8RNmidm7OfuvDPTT+0sn5SooRQWK7g?=
 =?us-ascii?Q?MKszX1JFUHHE5exYJnpH56p3AZlWVOWxBpgIsTi2MkjBJkWKt04DOnpYBhro?=
 =?us-ascii?Q?+xVMCQfMyMbwZo0+1JnxNsWFXI8AUSvjRyHv3oIRsraopmTAZObn6bQNcY/W?=
 =?us-ascii?Q?K0KffW8XzdGIcOvisuvStz6m5HDlWzdF6p7H9zfTBJywxFFfNUneZ0umjTLo?=
 =?us-ascii?Q?4YxtBjp2SVvpwb5gYBUu2BqpuLF3jrsjprEc8R+99VJ3XXQYfpn/ms0aaCYD?=
 =?us-ascii?Q?CQpm0aubq76gwItY4N6ka3vLTCsSdWBx7YB7fCp3PIT3LS64nudMqpo5MEG1?=
 =?us-ascii?Q?NxyTq+4SoqonX3XlSeCsYIoZMpirjffiqwoPdb1YU8DTHa/PfK+KayB9IGHo?=
 =?us-ascii?Q?BAeusEUXUxdFflmtTXRJkpwJaoooVzlREWnenNgceFjfmzuFrKU+EDFT/+bP?=
 =?us-ascii?Q?jsLBK6iso+9+rdYvaKO9OTwcgWHJB5f04UPnRHsO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	E8j/uhxnynd4QcVpR76SBnQFN8xepVSE9ycBwevWDw88f7qBw7gdpTxrLPpsCTusIZcg+cl2sogIkEzl3DilTxVmY/Kz+D4rljLx2r9BG4ppuYcJei4r7abN5cAT8/d4h+mNU41tLx+jdF2bnjoFdINDJrzu7iLCXu9HhNCwybh1PDcfWOgNy6gPCLTVypOYwy6StMrxxIKKdnyz6nWycNQzrnaMF3r1hg+FIKvZECb50By2ro01V772M6YxV1dUP3kxL+nkfjDu1CyRg+Uv3N/NSS3DNoZZJKR2Re6MXRU0aNdlLhpcpV2E6Q2UiRUVwaU06ZRfgDk/wlXvE5ir834ekCgwK7T4n0q2h7tKkNP3UNWldvjOTQjgOii1sMNsESlZ2L5dR5B+Ksq/IVAQPrljzRtEiaADjNrhpJXfvmemLfMX/OUwR+C4v4d4OewV3vtApgJKTDCwYIZliyFZjqraVAk3Vhmvk7s0ptmBCEwCsHFaZxgEjx8mkR09qltQuIVGZJLYnu5b/hQbPA1VyR/wz3eejCPq7wV2+/1JnT5DgjXIe6yc9eBeiLrxd81KvZpzWNvtKBfhzCxeNQapyilcr3XBOl53xSnjptC/Ox0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ea0f24-b75e-4b2f-6f11-08dca29182f7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 16:41:43.3409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bj1gspvvWacs+VP8RlHGsX39RPpfFwQ6I3ms+WRnbrmY3sCUcWRwIcG5idy8Pc+AcjVtOE4cUjLghBPWDLENrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4533
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_13,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407120114
X-Proofpoint-ORIG-GUID: WWRhq5z9DjAD7MU_ESs2rDfEFJi_AwBu
X-Proofpoint-GUID: WWRhq5z9DjAD7MU_ESs2rDfEFJi_AwBu

Zorro,

Please pull this branch, which contains a small set of fixes and a new squota testcase.

Thank you.

The following changes since commit 98611b1acce44dca91c4654fcb339b6f95c2c82a:

  generic: test creating and removing symlink xattrs (2024-06-23 23:04:36 +0800)

are available in the Git repository at:

  https://github.com/asj/fstests.git staged-20240713

for you to fetch changes up to 8e0a68f2cbe9cc2698110ac85765a0c4681b290f:

  btrfs: fix _require_btrfs_send_version to detect btrfs-progs support (2024-07-12 21:59:22 +0530)

----------------------------------------------------------------
Boris Burkov (1):
      btrfs: add test for subvolid reuse with squota

Filipe Manana (1):
      btrfs: fix _require_btrfs_send_version to detect btrfs-progs support

Johannes Thumshirn (1):
      btrfs: update golden output of RST test cases

 common/btrfs        | 20 ++++++++++++++++----
 tests/btrfs/304.out |  9 +++------
 tests/btrfs/305.out | 24 ++++++++----------------
 tests/btrfs/306.out | 18 ++++++------------
 tests/btrfs/307.out | 15 +++++----------
 tests/btrfs/308.out | 39 +++++++++++++--------------------------
 tests/btrfs/331     | 45 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/331.out |  2 ++
 8 files changed, 98 insertions(+), 74 deletions(-)
 create mode 100755 tests/btrfs/331
 create mode 100644 tests/btrfs/331.out

