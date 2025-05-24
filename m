Return-Path: <linux-btrfs+bounces-14213-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DB7AC2D46
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 05:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 098E99E2C61
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 03:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54E51A4F1F;
	Sat, 24 May 2025 03:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h+vEO4Dn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yY1dvp06"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B6A7E1;
	Sat, 24 May 2025 03:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748059059; cv=fail; b=u56VTblCS1kA68G/Aaabpr99+91vFkNimquj9uGvKg4i68mIxCJzjhKXBrDbxxMztyx4SyAh3Xm23eVTb6E7gblpW+WTaom9HEMY6paebomr+oaK28WN69JywlJdBffMfdPsMMN14j0V4YDffkC3wUHzTAR3X7IeQ1sI85lsTaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748059059; c=relaxed/simple;
	bh=j4aPGFjKvSOd5BJYNxMjGmfySXKVWkN0H1YYeP/KVaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j+pobrKm/6B/bN0jRdVAHrTlFcUN2YqOZlB47AN5GBwQyhBQiG01w5iYFQd00UERLoIrd2/7vqErEDq9rgGYvd9udstVa9RS3WEKnrH4O4ggRfYcC5mWBk0Z3KSEhJE1b8UhvDEAqOqscci+Cz8NmaMshFe9TmsZRthPYq3pPYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h+vEO4Dn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yY1dvp06; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54O3YjA0014137;
	Sat, 24 May 2025 03:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=HUF3oT80BvqEuIGQCZmpjEw4FsHwCCcGAVwiEivHTXs=; b=
	h+vEO4Dn1huL2bmVyOkanVBwLGKZIg7/JuP7OLRhxuUNdCIANU3kl56EElx5lsA0
	Wdb1QBNDpgdVPxrKHjZvZDfEb7NcRZWIn57R0czzRrGDt9jApOkgi2okvqfYQhIF
	bn6KVtQtt4tHzzyT5FCYd31LU5DVmc0ssKDoz6yUqJUXMa31zFHX62yHWanmilQh
	S+WuYJdCX9jxG55wfPeSEog9lJOJmEmxRAa1VAqXnyFyQEJi118cJ4kuiliXl5dV
	4+qR8Xb/n0M6K7IOUBReU5zdmSmF1rANhJZFqZ0L8qkK9UWMTRExFYBuW127MPH+
	sjMyg/+N1HVo0vokEGSq4g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46u65d00j9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 May 2025 03:57:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54O1XfWv027873;
	Sat, 24 May 2025 03:57:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4j62gw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 May 2025 03:57:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYgerLQdxsm+Q76v+oAdY0dGvW+1E6Cd8HcQGOgrkXnorxjLa+mSfvdJtq8Nvx3wJzmstz4x/nhrczgypPvAkk0VGdYl8PQqxbzGsELvIoW43k2qxk6QeyqnXiel35zzUt7iJ82zYWkEIUpIgMoBvhi4sIcsZwXPUTONlFSmdlp7QRyQ/oCbZT4JS5AkBA7CIFCfT/LwbYFkOAALOrgzpEk8AC5xdzPOI/+tE3vaZJ16ELyx47ZSoDl1cG7jiCM4xlymI3ZQbvPvbpQoSpBeNYiXfxbjkIQv/81H0S/OKKhX1+9rSUCOW0JO3QtyRfXqBPjbLN7PIWCxQ60Wsl++/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUF3oT80BvqEuIGQCZmpjEw4FsHwCCcGAVwiEivHTXs=;
 b=VWfhapXmDL14f8S/XdEyHmvl2vE35X0x7Hbhqih9YKqrSNnYoN828JkJ+Rv3xkL1ZNtSEc3/O1HBusA6mYoTFXHxAgZKSM3nTCrFYp5J5muDgXy6XPGScYjOlJ/kRKuETju80awU3AEfK2AHOfP4OAIO5CjQ7CJGjFQeEflEChBz/PJsKlULDkY8lWtq7uXrcH5z+kuGB+253+pvuwS5H9HhCqSkwCZX0FBLkh7mknTL5WJ4k5rbsV8mGgOOl7WKXExmdhmTzi/Im9drxagpKvfS6oiqQdapfSmxnia+cgfiLw8PlQ1oMlDDlXfO3/PWskLAeGgWWmHLcXVNRn0twA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUF3oT80BvqEuIGQCZmpjEw4FsHwCCcGAVwiEivHTXs=;
 b=yY1dvp06RyFcMWfYYQ6sx42m+hzbYjLbgx/Z8xrHQiH99fKepwCm6PFL9i/LQTl8GBjufTkN693Gf/at5jJpO0AxGDHuC2n2kuml22175rO4Tukc7NpCSs98YdTCD8fN9srjuXB4Y2AgBUf6FgRLJsQ8a1KLUqP+h+M1CxPFBNk=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by CH3PR10MB7679.namprd10.prod.outlook.com (2603:10b6:610:169::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Sat, 24 May
 2025 03:57:28 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8746.030; Sat, 24 May 2025
 03:57:28 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, zlang@redhat.com, djwong@kernel.org
Subject: [PATCH 2/2] fstests: check: fix unset seqres in run_section()
Date: Sat, 24 May 2025 11:57:14 +0800
Message-ID: <8d691171e1bb1b0be98a0ca79e50f9839073d2ac.1748058175.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1748058175.git.anand.jain@oracle.com>
References: <cover.1748058175.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0086.apcprd03.prod.outlook.com
 (2603:1096:4:7c::14) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|CH3PR10MB7679:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f8e311a-409d-42e6-3d15-08dd9a7719e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PvSilmeQmejmi9R1MNzF2HvxT08gdBp8vGN92flDmo+2t/F2k55+Hz0wI8g0?=
 =?us-ascii?Q?CETD7ymgDITm3s+xF9hkQz3a9sBpXmpE5DH8Oh7nurwAcC+8dwvczl5GD/9q?=
 =?us-ascii?Q?HaOGCOGzRXHKL8JAceyTzQaNVwA14uaWVdYZrVnEH9iWq5ItG+o8ohT4/jV8?=
 =?us-ascii?Q?0ZIL1GeVW5wS7QPizV43YIHiCPkSBoCw+G4YO5Kk9BMM/P+Hp80QTp4dfXo8?=
 =?us-ascii?Q?UzWP0AdaA2FZ1bmOt+PXUo5YfIzzDUmNXWZ3o8ILnYTJC8mCPYwNlv+N6fIH?=
 =?us-ascii?Q?S+dBZ21rYWEc2TcB6HeDLimss8j4tk4uHJHiWo/42QlpG3ddMUtnlBlnZFJp?=
 =?us-ascii?Q?dGTq924uslVfUucF+Kcp/hgPXxi0ak22eFT54DtMmg6LbWNUIHMpnGH8EN6F?=
 =?us-ascii?Q?oGspVkPNw53FitIVsBDeQat3MJaa/Yhvds4MosS2I6Ydnc4gmNMG/OWyjOpb?=
 =?us-ascii?Q?YciRBrdIMgTLNGiuHD/eVuoKR+uXHg3XIFiu2F++q9szro+WE2Y5HuQhoa3E?=
 =?us-ascii?Q?o6JKPMU4YcYe13FPATHfq0FKxNDQVD8SWfneeFurX+pTWM2+8IcFAXZUDXoR?=
 =?us-ascii?Q?GyPdTqov9Ixg4ygAR6rK4CJfXU0sOwSGqD2W2lf4OhlMhtUsM4ccUmMfVBY/?=
 =?us-ascii?Q?762rVcy+//oC8Wntdq8tUNzs406iu0ARxZssx3rE+ZA643D9/e3J/dfD+QQA?=
 =?us-ascii?Q?zvQoWYXA1QWirueG0EzdcuYmY9+8uhWTE0HdsEJ0lPfPeisUaf5I5Ai2EkgS?=
 =?us-ascii?Q?qHT31SCkPOy9NGcFErwPAQ1UIk5lThcZ59z5XBMhfDCAuVxpykTsuWuO92B7?=
 =?us-ascii?Q?l+CIOAywqY2dKbaGFeebzFCtUVrg13oG/wg5isoUndyH2DcaharI1YAlylWg?=
 =?us-ascii?Q?cG0TAvs1FiT8v4actccMV+vQGGMGWioW6ryhtk+Ao+6tpRDyzFuUFRYmdMyP?=
 =?us-ascii?Q?8i34/IOB6AZlrQf+Mz/yW/zAjoobs4uJZVejA8cRFNEOGBzVEWcCW68heXoE?=
 =?us-ascii?Q?Gkvhy9MFqo1U+2u6Ps+emopjTSI/Vln89FNjMMqc+3PCyrJAgycY22gfLavl?=
 =?us-ascii?Q?YUgnjDETQ0eXknKNZaJeay+UTkIcEkLY3sE4hWQMOBg1Qp5IrtjW/RSmxzZJ?=
 =?us-ascii?Q?Dp1vNLTfIikoL3a67t/Q2DkE3WZY/LxARUV111IWox6ao1azlxyRHaOYGSrs?=
 =?us-ascii?Q?GmQDHaqRyvPgKfb0hZH6zp/ZtwjGphj73oLtg93EcCRysfS/NT0lTl7iJiuu?=
 =?us-ascii?Q?rFXletAwlri786tVtX9Hju7d3PytMvRJL16htNXk0dIMlfRfhXYhYe7b4BO+?=
 =?us-ascii?Q?v6r9EmhgRkfbIm6Ft9yD2TR9dXLJzphrbcpTVDp/QX+f6YvmgF7iimtijfuq?=
 =?us-ascii?Q?Ft8OLN8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XYGyKVKKrPEtuCdnThDe8ggyJJux2NyeRyj8A5pIOukuz7ADVw83rXD2Rbbe?=
 =?us-ascii?Q?ydnybwoJMnijADj+otAaScEJui0oWZG/oW2LWy0aQ091jXuRTMNfZ5fkFW57?=
 =?us-ascii?Q?fQpbNe2PgyLIqZODkp378CZNckPe10VmO5CuLqLJNwtaUGw1N0JRAEFQFDVQ?=
 =?us-ascii?Q?GFMV3cLuGV3FJX13HrrcTdJT2t92/H1IoMD/rB4Zt64zZ1IEHlHMiIRaEw+j?=
 =?us-ascii?Q?AGOP26tFv/r6+P/nwVAHVSpqf9cxAc9x+9JqJBv5D3MZ3KfHh3mHJLlIhG2U?=
 =?us-ascii?Q?+GcSfZMemXGKcXbz2waOly2peJWt/D2zNynyoXu36ubxxLLt8yf2yAOQ2TUN?=
 =?us-ascii?Q?pZ4i3b5fOyzB3MpouDfDTWgl3RV5n3jGCKG8ZFxgqJ4q+9TlisLuRV8YaZKa?=
 =?us-ascii?Q?7FmB+aIuVpcZBfe9lPVTjvPlT34rnhm2CkDg+ru0rO7Cj57DkeYoGtgkpvFU?=
 =?us-ascii?Q?PfXPPM/FBrNjs+J/GYFfC8FdNinyxhxmd227zfIi7FGXQ9u5LiuqnRh5ttoi?=
 =?us-ascii?Q?lZJBVRFe/FTfaKF6N009lPs9O+ImngGCXx6PDsWYMxmXjwzU8dTdwchISsx0?=
 =?us-ascii?Q?bcqiBmtylw4wNRVihxagjuxZQwvJpdDETMVIxVw7tnLM50KiVitreKoP/2oH?=
 =?us-ascii?Q?mifJkYefMaZGZxuB/QeefPAdrWXHXQ1975Hih5UJesExo4Cg58e+dcOu9coD?=
 =?us-ascii?Q?i1IVf6A0TWBnFB6fNZpti+dKzGWl1taky+sKNBSK+NDzdble39oe/haLmZQ4?=
 =?us-ascii?Q?L24CZtYZOkSEHc+2fBJd19t2Ri6zw6RAvqOTjCTSSJk7s1rYp/HgsIjvImaX?=
 =?us-ascii?Q?fitQUnERJZJM/j4grvxNqfP2YQnwYrK9j8CJiDOGYRuXML8BbRqWGNx4LZ92?=
 =?us-ascii?Q?Wn3Td/FdTtvVdEebOulbw4sNlu+vnXIFlsGNkE07RGkH5D0nyknZZOcZyCAH?=
 =?us-ascii?Q?x8kjTukGfCNnNbzmhF3yErg6BmKnIczMrpHw9paAX3zDwxOupYsEWTBTPxDD?=
 =?us-ascii?Q?h0fGzHD3DNw6c+01j9t/hV/PSlIoJOvN6Yn+qZZDa1qEmvG43/QeLsH+K00Y?=
 =?us-ascii?Q?Yw4JCkNsHhYWczOySf2T26d2DKCES8hudAa5vAZMqVsdxbkz6vRv1XUxbu+g?=
 =?us-ascii?Q?IUrHlV5LIBmTK/dZHyyHusWPy52Y23KxuN5Sio7epjjz/p5EZcX6RMmG1/61?=
 =?us-ascii?Q?NTjDDK7aALc6kO1g5liKxPyidTVI1O4IMyNYHe1y/M7NB+VxE/2Ye7ye8YAC?=
 =?us-ascii?Q?+6jzJWr5wpu2iGoa6owSxia++BBob7fz1VaiYi3n62xenXJqB//RSx11R8wR?=
 =?us-ascii?Q?DKsCa3NPbBdXbraqPSMLZ3CjfbOP7TL8sEi4OFYP3lxvdD0Y7kCLSzuGHAm7?=
 =?us-ascii?Q?h/RqVaIH+niXRgWyS4e43JbAOBemKc87gxNg/p7uJTgNlMuYSaK6U6r1mt5K?=
 =?us-ascii?Q?PxVS9nexL2EWBpkhYI93RSIiIf48RBzYPpPn9snjp6w+tdsAIh198OhUuNKt?=
 =?us-ascii?Q?glaDTUlNjhyK0KeECgJN3jCA6j1/zIZ/0saNkUz1X6Ds4yeIyfKoTQzcF5NB?=
 =?us-ascii?Q?keKnhwJVLQi9VFUTCP7hs8rtDFX1MkwlBOO51UXg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bFyqkjiy3Sf4ooyRMMYYqJGi+/lRS7Sh44O7CU0vFuREd+bZePqj6EHSZAUbW5tv7k9APTa5E859lJrRvGwBRjoa3YfGmGjhPa8oxmBjvrnR4ISuMLexdUoD6TmhKQ/MIM5dk8jqSNEV8lEhxRrh6HW2yiY7VN4BRaU4fs6YzT4aL2mzNbs+Ek8UVfb7w8kgeIvJzJK/IThi1nH+cc9wvhnv7h+wDi6P8H1N72XAS3FzAnq+BP47RMloE1x0Ckx+1G2+nxVqvAXO/1ZsK7kpnNkQ/daMDjlnDsts5EWYe7OboDzRnfsaztJkt16V3UhQ+/y5NWdBMXlKV7RLpaxgQSD5aAr8SMGMGJO30r3J0he6dZKY8qM1PRmD2Agt+ykG2lAeDWpK27cQNYpxbeVULjRNpFBQuDTrqXIJ8I0vknWAnS/PRNlS8qQv+7pEASqlpnfvEsziiRTw3sXEjQ7829UH96ksjYf6B8vKNPMWZD68G6xeyTPnBvRSh6iQHOAeqibfQr6rKqSpqIMxEd16MjGDSb/c7xxBZCe0FmyRb53ydL738i5IyqvYRumVMEjNMK+mwq3xGDMula+SUx9x2pMD+V01LqqCDlUIAbzz620=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8e311a-409d-42e6-3d15-08dd9a7719e8
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2025 03:57:28.6304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xr5mlYsZnPKYfqzwCXMsdreY5UoeVIvZcmdM1PgOUY/dhEuHR9TOIQCR1Q1kc74B+GERW3mt4g8dYI31qMwobQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7679
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-24_02,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505240034
X-Proofpoint-GUID: 6GPq73boDIzn1E4mk3TqglY1iNfVRsI5
X-Proofpoint-ORIG-GUID: 6GPq73boDIzn1E4mk3TqglY1iNfVRsI5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI0MDAzNCBTYWx0ZWRfX9pd71wqrlsBO wkKT1OFRZGXwpzP6lLNkp2oHqPv7p9GxgX/XDsISjnh4hegulhNx4utTFjqq3Owb+vMot7TDDDQ f6HhQDaLkWkR4EmxQ/hLso7worgFyDUscyK9vDRTEGTHltm+Kl5e8SYr+oEtvMrkgCBoAr67ewN
 8qZIK9GObAtZOjh23uGgG/xiAITmIaMnSqB2pI8lm6f6KJWEbKvj4c9BhjVnxIqLK+jfgY12h7t k3MmL1Vx59lcXlQwEohlbJZYqpRintiYsxeIjoJgz5slrMIuo3UYDfXXYRsCy80xtD7UflefsuT iTfkmu4fZ3ARJrpRMyliU36Mo+gLw000OYo7oXLPREbwAmXdj02daLqHRUB7mun29EikuurOVFV
 tkKShVqawbeCP9bjGICauMBMqhmHbvnkjxUy7mnMaLtaEOlE8jBT+Pxfo1Ij8lQdhtIjoObH
X-Authority-Analysis: v=2.4 cv=NeHm13D4 c=1 sm=1 tr=0 ts=683143ac cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=iftfF9e6Teb4beOD988A:9

While testing, I saw that ".full" is created by _scratch_unmount(), called here:

 725 function run_section()
 ::
 815         if [ ! -z "$SCRATCH_DEV" ]; then
 816           _scratch_unmount 2> /dev/null
 817           # call the overridden mkfs - make sure the FS is built

Ensure seqres is set early in run_section() as a fix.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
This patch was sent earlier; it now addresses review comments and includes
an updated git commit log, no code changes.
  https://patchwork.kernel.org/project/linux-btrfs/patch/12a741fc7606f1b1e13524b9ee745456feade656.1744183008.git.anand.jain@oracle.com/

 check | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check b/check
index ede54f6987bc..93d8a6cd3237 100755
--- a/check
+++ b/check
@@ -794,6 +794,7 @@ function run_section()
 
 	seq="check.$$"
 	check="$RESULT_BASE/check"
+	seqres="$check"
 
 	# don't leave old full output behind on a clean run
 	rm -f $check.full
@@ -835,7 +836,6 @@ function run_section()
 	  fi
 	fi
 
-	seqres="$check"
 	_check_test_fs
 
 	loop_status=()	# track rerun-on-failure state
-- 
2.49.0


