Return-Path: <linux-btrfs+bounces-15785-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4751AB1740E
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Jul 2025 17:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71248584CA5
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Jul 2025 15:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383B21C5D5A;
	Thu, 31 Jul 2025 15:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lxHRUGbA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ctecXsl8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EF2D515
	for <linux-btrfs@vger.kernel.org>; Thu, 31 Jul 2025 15:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753976573; cv=fail; b=Zp1ZTGf/KEcTEjYqb8DHQngDK76OU1RFsHL8Jniv/Tyx9qIy196EEzXmlcD4FKqR8FhGBSCJ2tog0braTuMaKw+1aGs975nBjKT9KrjeT2wVNBbyzWu+oyKXtaC112UmVwciUxa0dNkI6kK1suDnn05aLMjpxkfUXmdQl0DXuL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753976573; c=relaxed/simple;
	bh=QjTrZkZF8PWVTO5U8cy1faQoKmyQ+DhmK6D1ZbOqXtE=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=Nf3kMyZ7/P9GKFZrta1dUPbBJAfoAiQhckUCrh3DGuav0uRhnFBwMUH8yGnNAe5nzqUz3F4opHt6GvDBy1EaLkkBynn31Y8tOBotX0ZTh09OQHg+4xw4oVbT7tcWIDfMvEv9aGsYUOwNXaJwHFor4zqDuyozoP209BH4Fy5D5qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lxHRUGbA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ctecXsl8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VEuObf005296;
	Thu, 31 Jul 2025 15:42:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=52mknyLHDm17Fw1JJL
	0pjAl5+3hQ8GVsS+HllXo2ig8=; b=lxHRUGbAeoz/Dcbe7JyzPD3ydYOfXsEaA3
	NVcRgkX3HUElrySuqfYWdZxOPHTowa+5M1qEaEwoHXdShnsArzzTMj6FQFPy5sp6
	Zcr/ldw7RLmLtX+8FciySOU5cYEW9txufHb88uloGQSpGFZn10HJHVqjsGXah3yd
	UoeuX3yTrKjxEDs2/k7iW9IVlRVfiZN3ZONXkZNel8AgOP59nVyO+agm9I8Czu3+
	phIdVTTE6bBTcANoypHiXVzoolHTZD+1NoJ9Z0T12hsDrOOAsQIeFx0J9YqD3kki
	z5w1xEEYtOjP8w3pE3TjO7DcWZxytRjTTC0yRcEKLFxm9MRiZQQA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q5x48nq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 15:42:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56VEVIJG011035;
	Thu, 31 Jul 2025 15:42:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfcg8e7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 15:42:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gfERZqEul0kuRNo1CiHCcojmnuoCnHGq966EHJSGDu4c9k4u3ssPnKLE8n1Lyw2XqBlUzPW3EuUq/D2iUAzMYRKNcxHmvBz++RyW1pzO/9mDDTnmnSoBFx8GiYqh4F4flzcvENbUG7r80GGS3qXYru5FB4y/01fi8CBxQaAnSztJAvrAdZVsduyex3Q6znRpKbQIXUsrn793LWAYPw4lu3BRZVSCMbU1vOCGH6ndSNyJssWoPdFxIU/vja47xWnJBhawZw+CnqU5uw4rETWJksNbnMWjX8ocf+1HykF680q0JGbQ1Xa9E3bqtvdzwO6IUjYVEfCwV8pJ+WKcFU/sSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52mknyLHDm17Fw1JJL0pjAl5+3hQ8GVsS+HllXo2ig8=;
 b=ey/O0RqjvvZ3I2zxeJuhxMHDdR9FjnEXnk43ggbmRzkxaIayjEHOJdTqN7pquMKLJKHrhdjtYB5DQ6iAIY9XFTNBZ0P+sPWXzBy05EGfkDwzRYIU9rO8audCZWYRXLZlxv5Fa7et4wEqoKwgOcV9BhyjfcQ+7nLNQu58UKDMAgD+ZUk4iTPWpwSpblbpxoaIr7MQCenD7+7X+/9Pk5ax1pj+I49VLe5YQSzcKxfAWi9JOA6NHZTKXb7nYchwbPRlsZMbvWFd2KY821VjnMdW7x5x13rAO9s7v4czz/tABjhhItzzye8nBaP4neTysCdCDLL1yelcMNdSmYq0K6PXBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52mknyLHDm17Fw1JJL0pjAl5+3hQ8GVsS+HllXo2ig8=;
 b=ctecXsl8lsyUVuJeihRmicPDGf//31Q0uVePpTsjjznm8/2/WN8T+NwkqvMl9mDgEXW6O8rsx4A+OMVBOTasMHE/8LCj7IGVgNKB4Vae054SBTt+9WSu9ZSh8iZk1RSBsHQTh9JazOt6K9MAP4bKdEAAJHtbsuT/zXGYBbbNFjM=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by SN4PR10MB5559.namprd10.prod.outlook.com (2603:10b6:806:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 31 Jul
 2025 15:42:44 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.8989.013; Thu, 31 Jul 2025
 15:42:44 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Anand Jain
 <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: use zero-range ioctl to verify discard
 support
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <aIt8zGdVPXTnFS2s@infradead.org> (Christoph Hellwig's message of
	"Thu, 31 Jul 2025 07:25:16 -0700")
Organization: Oracle Corporation
Message-ID: <yq1tt2sfluq.fsf@ca-mkp.ca.oracle.com>
References: <2f9687740a9f9d60bdea8d24f215c6c0e2a9657b.1753713395.git.anand.jain@oracle.com>
	<yq1ldo5i0jn.fsf@ca-mkp.ca.oracle.com>
	<aIt8zGdVPXTnFS2s@infradead.org>
Date: Thu, 31 Jul 2025 11:42:41 -0400
Content-Type: text/plain
X-ClientProxiedBy: PH3PEPF000040A6.namprd05.prod.outlook.com
 (2603:10b6:518:1::55) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|SN4PR10MB5559:EE_
X-MS-Office365-Filtering-Correlation-Id: 3692a9e5-fab8-4fca-8050-08ddd048e429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dke4F+t8tSrGIRM8Ko5ZfqMgCLl6eBuDxXC17Tm/G0BxybParc5Zxo8GR9A3?=
 =?us-ascii?Q?Bm6ykCP/eVuLKkUbcsmyS013yi4B4OY/zwzguPaJgeukrIZdrtV4+OFY2VNh?=
 =?us-ascii?Q?KwAueCo2rs8I4fSHRlmjl53/XBYTCdEJZoCoRqR3PrhqA94o3gSxZhO0alXs?=
 =?us-ascii?Q?K2vq5lMk09B4FzJcD/FyHcy/z3uK0E3+vmpuzUFUQhPO+PpsBsc7OlFT1xJa?=
 =?us-ascii?Q?wZMp6Gj9Ks63i3zZSVc+K/z5HFR+XXV8Oup8NEU2h88YdQzRzZZmrhblaeB3?=
 =?us-ascii?Q?HMlfQms/k/jyBq1Fktlrxzm5No50xR9Nehu8nIHczDO/s1UZ/kNMuAMA3liR?=
 =?us-ascii?Q?167ji2zpRXxyQa7rWA4DjSmIzTHqxBQHQwy8P3agMlS3ZmxLrlJSZpREQ1+t?=
 =?us-ascii?Q?KzLmJzYtUzKE5XXZqIM1odrgUZLrTlq+0itK3Eoa5KZpqFi0e3w+cxZRlifh?=
 =?us-ascii?Q?AxDSuqwYZbu7HRUIWl8Rn5HdPvnIDGmh9nS4qEzrnK2AfaHq3uV51EDhfSt6?=
 =?us-ascii?Q?cR9EZu7MTiwbQhVvnzDsQCNaQolFzuUErPpqL/de5y05zqRHFgCuo12T83zC?=
 =?us-ascii?Q?2qYFRJv/7Y6N5a1m4clSG3h9gdQ3JbBhqC9YrY7PY8a5LB3cD0CE3Grb4n9r?=
 =?us-ascii?Q?bRpBWWBJgVZAKX2AIRYvAA7P+Y5TBvJ4nQZS9KJYTNYpbO1464AUtZigtAue?=
 =?us-ascii?Q?fcYZX1LM6HLP5xk6suh90sSuWV2+YLGGE2YY4yJWRKHg+8hf4ROhE2baWVap?=
 =?us-ascii?Q?ehzP+Epwt3JVeaHdvcuM5vXwiS+C3fELo2QjfAn+yB5hZida9yEXRl9ofyUB?=
 =?us-ascii?Q?Ax6aRTF7AZxyjNrbocDCQgxf3MrgQyGnu3wGqAKj81E1dkMGteqztBzVSA7g?=
 =?us-ascii?Q?e3YGwSeqD5Fvqobss8ArBGHRSoQl3qc7E9iHp2pJ0Ir+x3FpQtmfzar2zWYB?=
 =?us-ascii?Q?r3rA08oagqHSNZrhtLKrL7Y63bcTvLnujOh4pbBZRu9RxaZXD2cpd7hw7fjD?=
 =?us-ascii?Q?nAUhI6b+++qWFleVu/r+EJXXL62/GKOdcLOKqHwavUGSRxynmmwB75z+OSVs?=
 =?us-ascii?Q?aNshS7kzzQxyGTEoowWD0YF3bUIuD2Bj9zsL1jX08r3S5maDIxPpN5btL6Wg?=
 =?us-ascii?Q?9Ud/MeIMwPSyoYzURsFFjElyAkJ7sAMrBZijyGjzgiEjI2CEoHCEUKXs1DLh?=
 =?us-ascii?Q?igkNMMIAlA4rh3NPzQSGcZt1PBuouWg/kY+CwYSQy9LjXebwz/92zVzkT6hC?=
 =?us-ascii?Q?RzLsIKBniHkGZDMXSBJ0q/jJ2NNo1SJCBkZMYnCNL3t51+bBDICr7VFu51sF?=
 =?us-ascii?Q?l0ty2nV3+TyyoADyohnn/csl0Ar+X0a19fWscRHXhrJYoEBHn6FYAtp/SjSL?=
 =?us-ascii?Q?3sY/0hViKVNX3eRhalcYVSKSseJEKUsDGcuwHtYDkZ6Ska2yPEIW34O1xlTA?=
 =?us-ascii?Q?pJ1cl5RwUWg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?80D1tRxQAPYLwdCgRyB9gCFTlDhqUPgYO/dVO1dSja7YOHmuGb+cD2RSX4h4?=
 =?us-ascii?Q?qzOhGIux+cDMNFHrVDfTqaqNpaeDwOS4WMHS9RNEFW90qNDcjKgtDFFl+s68?=
 =?us-ascii?Q?ST7QZJUxzStSeMgTurBiuimFUUO5Vpgiie23dHM46iNGLpiGxOQ/p/U5vz83?=
 =?us-ascii?Q?Sqx4M8FBHAKXyIVBbdgtJZQjnhYCd8K1Hv0y7ihWq2fkv2RxEiIwgJrbFOV9?=
 =?us-ascii?Q?HzVtB8eWnIY/dBjU5qqtlG7SnzgkdXwfKfshRuFnjvt9ZfrOCUnRLe6I19nL?=
 =?us-ascii?Q?lWuDoL5b3+wevUEU1uuH5Z0wMiBW6CmAhlsP1jVDbzOGOfo/8GbOPf2fDJ49?=
 =?us-ascii?Q?V4tBjVFd3B1okQ5+FRvFHlhgfBlOHE5HPdiZQCyDPph9zRUAopCr2cNnDLaQ?=
 =?us-ascii?Q?0voyoZE5zRaLLDMHXXWeDXFYa+05CJUY5qK1k0jOwhVooVS7Ovvqvzar7CgD?=
 =?us-ascii?Q?1pMgdC6CnkCp0z1yA3WYG43aVYWCeW1pj8yNgE408A1ckUBKLjRa1HyoiHvf?=
 =?us-ascii?Q?JSqJwh3evrPSckSZ/XbObLHWA4ow++zQ6Sa3lIHdfLzC80SGD7XPjdRQrCoF?=
 =?us-ascii?Q?sIu3bl8RmFr6iRvZH/eHxRClyhERpRcQPHa1X9GYzc75gqbFAMPzJ+jByG8n?=
 =?us-ascii?Q?5YfPz27o5J2hdOPTZWLs0gzMISSbPRPwZ6615cbnP3j8Y/AyopTCp4vE6XZ8?=
 =?us-ascii?Q?pHg+s4bX1uGVi2l2hzrN0uz8Wd4HLpQMcy2lzwXXeIt/zAoYAukL6BMtmqsZ?=
 =?us-ascii?Q?6X3TFJP3EFZWd97A6HVDoLk/Z/AseiRaEm5RI5OkgEqOvfEBp4Q9A//BImB0?=
 =?us-ascii?Q?S86uIV0uza8ycgv9N5+300a/u4Mxx2V/M1ZpAKTrzf+1m2CEvYTD80dCNP2+?=
 =?us-ascii?Q?w57gdPH7M0sl/K2IaHsMVCSftc/PGz1cNIZ8luGe6iHjiVpGAMlVTQn9f2Ia?=
 =?us-ascii?Q?/QWF6SQ5JOdRnJt6LgaJ9xYiN/xUi4fvp9m4oKJVtucA7mt4f8vIjKF3CwZQ?=
 =?us-ascii?Q?cwWhg+kGKBOAqRR6C1GUrbynEtVVixfHOjfTFWVLvDD7zZoTTlXrvdnISV3X?=
 =?us-ascii?Q?RnYhF4RgVj+iteFhMGX8VVxILX/Z0YC/AR9aVzWMQKCt/1uMOHGyuLBwGzox?=
 =?us-ascii?Q?HSfGlE21lm4gAO60Zn+TzC2z4INBRVB8IdaV6gf67CjQQZqVrK5POrJuQk0y?=
 =?us-ascii?Q?boo2AL4vyVLy/Xdtz526xkGJY+VMIL5GCVjH1xjmFuRQCmS1SaWkaKUI8FsX?=
 =?us-ascii?Q?4tuR+uYww1CAuzRcPmJkQtPlQDDzJBYoMK7r8W67npMZL5pVaXEAmIN3oN1S?=
 =?us-ascii?Q?vTRpH9IpEAAadr4T/O5xjKv3XCuosANmlzHH6Lvkt7wa3mFha1qOlA2Tpcdu?=
 =?us-ascii?Q?2LfNPg7FZQO/FamfsE66P0I/1ve4UMwOt1QsLM7PHaUjC5XwQSWSqe/Yt/ZT?=
 =?us-ascii?Q?HCJA4e7YOOR0OFgo78wRJNs2wrgpIAxyb62HI67k5bBQbGYanOmKrUUEGyK4?=
 =?us-ascii?Q?jOyzmFPc7EmdXRiPONn5BNbLL5lqGm3HF9yn0MeXJbs+97xdhFWWeD4RjUfE?=
 =?us-ascii?Q?PapgsdpIU+/V8WHfVB4SGac/mrRRt1QvzmEjTnNd7ZZC5KBoSyBpvYp+VAij?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vSiQwz+PtbrJM76ZjlK4RY82Ova10S+JHzZONWwDqXz/9zL7jg0Y8jaVnWz3WLHpLYJNrd8gBjNfIfCuid+sCeuLsHVXTQx8c9xQuq5t5pt7ymONymJepc4ixbTI73X+1LxYmqPDU4bXoekIA90EANHDyRNgJXWZvDmjeO/2yug4AW8nQRwsDDpr6pY+PePDj7EImdV0600G9c9LxphLZkg40XcPMnyf/4OsoEjFPSXjd/K0VThogCWQ8U4pKx4AmC9mCM7+Zc8UMvajJ1l+p9FiZEC4wxhdOXijP3rsts/sQqH6nE88GMPuhvoa9YOfrPJEkL4+EBPkVZ0q/XXBbt37+iyzILH4e/wAupEUxtKIrDdnjyyi4NrMw2HkZck+v2PQKlknejoVc0Mu0e5kiAzoMd3R6x3EBQ4x5csKCJidJkZCb/y8MCYUeXGhInMz8vJhzuQK1gJuwcxDDidpvYGCpGqnZNiv5aacXTw337LHhOPTsxvlEVZT/f1mlGLir4ekMY+Vo+3P7wARWj3wM2DqiS+Rob7i3aJOx1Y49RpP+wSprZ+SykkqxvJgNytJNUkv6ipn97/kWT1lWpvHgfeqNFjhsKkzZ5u4W1xHt5E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3692a9e5-fab8-4fca-8050-08ddd048e429
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 15:42:44.2293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BhdnWevYDPk1NsnjVKrEK+/Ocoikc1YkxlijjQjo2MTiWswMYhnAH+5He6Y5wMTKbVikl4fNFm1pKeU4XVA+O2meHkMObAvBzkJDGJECSiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5559
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_03,2025-07-31_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=888
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507310107
X-Authority-Analysis: v=2.4 cv=X+lSKHTe c=1 sm=1 tr=0 ts=688b8ef9 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=GoEa3M9JfhUA:10 a=US-sc9mBspCPj1Dv4S8A:9 cc=ntf awl=host:13604
X-Proofpoint-GUID: Z0tmYgXWt4XxmkhvHJUdBrzsxSdH1rsE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDEwNyBTYWx0ZWRfX/OXmXs50Y80l
 OkLpDIsaKgWiMXulkt5yjdLdp//1THNO6CqpV3WTFQwqW8r6V4UkoykYnXFGe4O0Nm6UyJdw8/W
 /oAkgmPRAl1WmoG+IyAMeu85YeEFK6iXCxd9ISo+H71P3NwftHY5Xcx7MseoNWU48sjgR0zQgRu
 1be74kX15NSKuewnH4hbj5Oj3CtNJbvQ6cTs4rEee5IPWkVCWYV61vM8/v9pnlC0O4gLkYcfwh2
 QudnUM+oLI8DIhGLWYrhTyHnM9gmEYAWDwMHT/7NAN9ABylm6f3C0oKpaqFWBz8lLPa5kc5qjfr
 Ny8NFikjEjJOScu4CZ56qQP5AN1SE8eVGI8tuCTPlivvpvq7I6xujagSjZyPv+4znPzPtgDNlbA
 IWpO12zKGL/bnsK6idnbUroq0X0jlF1Hon+NjEs9NzRdGYG0o0xpt4Dpx388FOoYcYT/uEfj
X-Proofpoint-ORIG-GUID: Z0tmYgXWt4XxmkhvHJUdBrzsxSdH1rsE


Hi Christoph!

> Next time you see a change that breaks interfaces, a timely bug report
> would be really helpful.

I wasn't the one that tripped over this. Anand's patch just made me
remember that somebody else had identified the same change in behavior a
while back. I'm thinking maybe it was in the context of the loop driver
or maybe nbd or drbd. My recollection is that it was in that general
area but I'm not sure. Since this wasn't caused by anything I did, I
didn't pay too much attention at the time. I just remember seeing the
discussion fly by...

-- 
Martin K. Petersen

