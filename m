Return-Path: <linux-btrfs+bounces-13934-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A358AB4335
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 395623AD40C
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C9C29AAEC;
	Mon, 12 May 2025 18:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q74RkKrf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IYb7Ed9X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8507129AAE7
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073446; cv=fail; b=cifYXLEOXQOi7uQ9Kt4wVDUgg9E+b5fTEaU2Q3ypQ0Tu4aPqY7pJWU8GqxSlPlTz5ln9h1G6sptoJwIR1jQr6ok0BhPdGjFlEC8G1h5+pnCbtyXo2Uvcm1nA95LNhJaVGKfxGDFmIR49dFqlbUkAuPn6YfyWvz9X9M7lV+1lMeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073446; c=relaxed/simple;
	bh=sviF9V2rZsxwYuwkd21wRc+AusGlkPptu85Wy+rWjDk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MAeo528BU83K9Pb8MrxIkzVv2LFsNJsfyNtfIGlbjbFXTJVV5MeHe/To0tGDY4oheL8Ra+54kSH2jF4WetppluDa/5a6lvrVcF++0QwsRNeoBDzXbywn2+9uaDhzBc4czYtIJMppdrlHR3NsZanERmlxghgJhvIRPt0GnhGGDU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q74RkKrf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IYb7Ed9X; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CH0ve3026917
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mVG460JILjTyiXr3g4jlJJx/skSbRfVUuw8nzx79OOo=; b=
	Q74RkKrf4wQHZJVstOefMfrseK3CU2idfgRk+CijFt3POEmKnbddxg5F6sX0P4+U
	0ZpFTlV3OMopjtRuQxnZNMzKMTmi4tX52LvDKPoJ2YNlutRQWScQp5gqxiIvdmr6
	M34emrA4O9h/MVE3LGVB37EaS4Y5Jy8z4uVhZ4F5rmfC7GIlE5HPbu++RP8+18u/
	P3EmrGV12v2Tns9oVAnG5TGSPQ4Fg8czYJ42m4Haxi9nR1Q9lVoqGlasdpX6PIHD
	sUE3ETe/qUsnQftOyNO1OoK/Gku/Egje5AljaMt+wjVlXAJYkanzch81pp5SWpqR
	x38ZYLi9Y0Jw39zfHOxn5w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j16637xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54CHctAe002445
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:42 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010002.outbound.protection.outlook.com [40.93.6.2])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46jwx3bx6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENdkOGLFtkqzRrlU+8C0E6ls4IN4la3BjkCxSdyGJLU6iO//y1LmKm7gangz7TUe6W96/A75btBamXryLT4aJr5aI+/8Omn3I6LEXj1XNszzQesd4KAcA03ohh77POqjMLq8YhNFlMd/qkrV0gZ8cK/Dng38LeW9XvLqAThA2l8qsijM4xgB0hbycBX5eNgLFDCEx+FynGE3JDlTehcgHL9sky0HBeg8K2Ica5jK6WBWA2Ghc6mejZE09o7qqS4BgVYL/K8a/W3gp4k5vwHLH9zRRBMFcMHG4Wcf1R+ZT4C17ZuHFal3bzcEQalXr8KpVVMpOrwyIiLGt3fDeIaNhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVG460JILjTyiXr3g4jlJJx/skSbRfVUuw8nzx79OOo=;
 b=vCezfpDU7NAh0QNeeuV3wGumiIlHfi6B1tCO+RCYiGYVi+uHD0621nE75q3Ts4c9j0kz3eMHSCIBLO7QSrbjH8bd4ZheK/IdZmI6CsL8/V6ko6FBUwJhZvuE3unalbB6PSjlNkscrjgnFiY1vFnUmNKnB6LATTU1Mg+0WzIKElmuwVCVU8XegbiwBN+RMmAJWmI8RqiHkhKoKs2rUKKUi7eWchUvV81XRvS8WSNSvfesSkBjsHT9Ru0TTR0OtWmheaBlnKK6d3tO/Kt1OW6j6/jLhwEnec/HEJ0+PejXIx6qPQNkH8lSO5QvBoeLuUFXZ1Dz8GMd1Q0CiLmcyWumpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVG460JILjTyiXr3g4jlJJx/skSbRfVUuw8nzx79OOo=;
 b=IYb7Ed9X+qHcgw0A7idfbTgqaVEw2U5gIIjHQOe1f7EozmhaREjp7U+6lgNO8msVcXh6FlYwtrV3iGm2DkiRhTwQht+tQR2Y/BvVSXH1YQ7pOMHesEREXbPyM4+rkbmHdTeTLV8yRe0vp0imohBbyTtch5IrngQwMSZmrqk1a8U=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by DS4PPFC7C4B0ED5.namprd10.prod.outlook.com (2603:10b6:f:fc00::d48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Mon, 12 May
 2025 18:10:40 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 18:10:40 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 06/14] btrfs-progs: mkfs: refactor test_num_disk_vs_raid - split data and metadata
Date: Tue, 13 May 2025 02:09:23 +0800
Message-ID: <351d8d8179a9d7c64b3b1ab305ac4468d58ad96a.1747070450.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747070450.git.anand.jain@oracle.com>
References: <cover.1747070450.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0091.apcprd02.prod.outlook.com
 (2603:1096:4:90::31) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|DS4PPFC7C4B0ED5:EE_
X-MS-Office365-Filtering-Correlation-Id: 94b9651e-f99d-4862-341f-08dd91804df6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ozwx1NlmzYLfBr7X64ml4M4cRk+1082BQIx110xFXQq/3IELkFq365oZ6GSL?=
 =?us-ascii?Q?hnKxp/6gYy41m5ZR8O3YAuB/o8WJ/gY1DEUm5KoNijekjqtIZ4Hj4Syrg6SW?=
 =?us-ascii?Q?u1TTpnaCS2CFeRWvE5KoX3ipd/5l3IgF4gza5UuaLbx0i/ziR/0vKc/wnyXG?=
 =?us-ascii?Q?AJ6lpGxSRq58bJoaVYEIeZqeOR46MEC4cl2MPq7Pc46hvTHmj6GLmtlCvZVk?=
 =?us-ascii?Q?rhhIhtKz3vyFuoUApizOZ1IJr6a910F8lKIPfIkieTNS+m3o/ACoeTGGVPHi?=
 =?us-ascii?Q?r2foWOcVVWaDBrQrjxv1eGqaawuKCBXEwOwNVoS8XaLPITW5cP5NJf0VxUWB?=
 =?us-ascii?Q?lT88EP8F6ItE/cOz6PGoch+rA+4YrqlgLpTV5eVYIti7eEJeZGeRUwzXYytb?=
 =?us-ascii?Q?Uyjo/2jEYuC+vMB0njQcHVG4kSfF5V6k+TALpXCHj12yx/o+oC3g0A4wbqxi?=
 =?us-ascii?Q?S3ol3N7XBbwUva44OvCJx5jG704OQ//bVOlboKgXZ+a+5oeABxeLaflSbNib?=
 =?us-ascii?Q?7U9iz4troxn8HoDT2xKQj8Ed3NuPwie0Mc3n07GoUu/+GEx2+VTF6TEluLDm?=
 =?us-ascii?Q?eUiVGispEWdeJGxZBTnN3gfYiyEVU+oCMY2sRKwJohswSHROtZqMf93/22N1?=
 =?us-ascii?Q?jOcTibDqcnEzRczUgtk5ir7eH7CXQ+ZPTrZldJqQwikBtdqS5/r2oPMvyBYp?=
 =?us-ascii?Q?56eOpFe1CdnDRrda+I7LWsHyg/Yko5dwrJ8IKv/W322biRLL2wWhVjRU/tpA?=
 =?us-ascii?Q?5ajv8iyFzasMYNk9ATbRr4xNtcxzc/oSY5nfPMLHSsgUaU1svElsWbBvT8pI?=
 =?us-ascii?Q?OlrDnzD3i/rF4TTScfYZiQX5JGMXuFh1vyZRzGwSrUBkL5vyha8ZXGZ7KCbe?=
 =?us-ascii?Q?9HFA3zCb4nFTAf6uITJf0FMemJe2XJJK9PQ4iWOpL7lvkdzCLf6IhdZuA4Om?=
 =?us-ascii?Q?WlPYkIRGzXPXs86oD01D9j9G94zUgaz2LaUMQ6aBXn9ep97pNq3+PIuKDdf4?=
 =?us-ascii?Q?ru7Gpw+mBgyEGnZAW3V1jhGy18sVeAY34Wmeh+g5aqM8/HR9/hEbglXPn6Um?=
 =?us-ascii?Q?L37Zm4h0MsBbXndyJnnFxvfQ1jiyW2lGr/oZEVxp1vLw+8L61s1xQLRwSJHU?=
 =?us-ascii?Q?4BTnDxl3s+y0waqN58bx+ivf8ZvgACyDE+ZJXeSeDyDRiXqdjiM1hjMB8Ael?=
 =?us-ascii?Q?ZJwIveZYc6PwWOSWz779ddHtCFWJsDeXVVjaaRYWutCaf5uxzb8FVHSL6d95?=
 =?us-ascii?Q?4yZeQIEX0Zg0qBqLY5Y8XqowqMfI5A15kC61XQzpVEUtYuQgCnQeu57Hva4r?=
 =?us-ascii?Q?sCkP04D4O3lwCYkgPYYJncwsnLXu4a6W04zUrxM21TtVw2BN7r5AVozXCaHG?=
 =?us-ascii?Q?kKcMrHAIr/FgLK9eNHZdt7V9VOpCL0cJC/fue0Oywp9n1Oy9Tl1aSzEOi5f/?=
 =?us-ascii?Q?9o997DPasZM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KJoMpPZFHQ6AAH2nxTrQNSUam6n08yKccAtwEOHjjRxQRuie/qm8hFa0tAYI?=
 =?us-ascii?Q?uMsO++lCNkmK+Y4tSfFBDXPUzedxcNL+lAQ8SuPRGuMvZ+THCZXpW14S+pLs?=
 =?us-ascii?Q?9oQKm5dfVBuPkHoirxhy/fHa1eCBZjcxCNwNQ99s4UpsHmzTbkt+IxwEn1Zl?=
 =?us-ascii?Q?x9EbIM4C4kRmxP0BGo+zB5zVVHjBDrH8Q5mJM020nUmKpjY2nk4UoW4h9u28?=
 =?us-ascii?Q?0J+lMSEfPfbZ57+voCE+v9ufd8sWv5D18j9ijmpVkBwuBlqUjr0fPBs5PEQn?=
 =?us-ascii?Q?7hj7PQrx+ZJB9TdxZgqcMgjMiD4SMqkeUtSvxtR4oPfnRIACh6PLJqAbJ2n9?=
 =?us-ascii?Q?FttdWq61/zH32GCm77CuDLn1lwOr05UmPAQmwbkhvueKGWkHQ4Yir5DHE5rF?=
 =?us-ascii?Q?dzHmRQ8sA2KnnrCg7zmPnSjEE2Z8QwQJlczzc3F7RYwWg0mv/lXlxV8YNIEx?=
 =?us-ascii?Q?9ba/yZrPLiKQ4S4K4n0cgnk8Bdl7md7zPy7NXGywhhedUB0Ob2t02PrlBPR1?=
 =?us-ascii?Q?eqe3CB/WN640vfvqWLLLunNTTsPYVLeWCaOK3KbaZkMA6+0+XkghqfvvtvHY?=
 =?us-ascii?Q?FP/pJjaya2y5/ecRvKeWBN4VIhmdb35ZmyESXai8FY9fli81sfFberlCyn7P?=
 =?us-ascii?Q?Hdd8i6GGZWX7AdPNJqMNngvMRdgyqFD3cxmmiU5kIwON5QqR5dCe59TjO3ZW?=
 =?us-ascii?Q?3LM/vHRLD37lClyoJHhh0ostJ3pLcFwM4Ohy/CZasmJBcySAfICQB2kgvYEC?=
 =?us-ascii?Q?kl1wfN0ZOc9H4hN1Jzx0JwztSh9UGA71zSutf8ZfgnhdtjgU1LUCD9fFypUI?=
 =?us-ascii?Q?4a/2OnfiMzevQXveswE8F/9IZH921YeV24OEEJRPX0oB28L27fWij+JliXm6?=
 =?us-ascii?Q?bwmSSs8naJ1m31Gm1M+/NGB5v6SiwGv955NmQwDkrtlKDkrIlRR5T0m0ZFmU?=
 =?us-ascii?Q?nzqKTfhd6bebVisfR8Cl6jgN7qQV15JkpGTKekoz27YJdv7KaUI9MEjaHiWT?=
 =?us-ascii?Q?9Tr4SqkTvttZFfd7ZGo42vxw+AbmXy6eBqHhZoYfEVDdNsWWnoUEN/RACyXr?=
 =?us-ascii?Q?ZCtZN2YWGIYdMLeNm1Ila21ZKaI+VVZ8lcArPdU+ZtOZ4RzqLADhge0umdJi?=
 =?us-ascii?Q?ECbEGlhF3sVXGyu3XxPOwwhHWsy8A0q8UvGyrGY7ohFXDRSzuPIDvvT5xyBb?=
 =?us-ascii?Q?oK559o8wZStfYMBIYr104ztcSIKXHIhoya9Be3QYia5t8rzHxdl3OO/AmE1D?=
 =?us-ascii?Q?LGqUPPgoLWY31zoKQPcyKui/EmRjcLYFdSJAOdVdAs92fgMZ7B6RnjNOpG47?=
 =?us-ascii?Q?gAIhtKYncCehE4+9B+6kigFkUDAeK+WsNXLFVtLraMjShWj3Opy9/N0TeuCT?=
 =?us-ascii?Q?oePlJdtxZi5zqMcevWFfOxH4YQk4A2wwf5EecuIIIcqH7MZVWjHVzc397Jfv?=
 =?us-ascii?Q?1VHjipcNkkTmYZ+rj5PAknVHiRzOOhRhzQx8a/34OvKVgWGgeQqwWPWWJuJQ?=
 =?us-ascii?Q?3KohXkQFELIGEoN7AZfoo0tYwyXP9WX1A1hvkmpPrNebxd1OwzSg/1uaQ5jP?=
 =?us-ascii?Q?WgsiAvBN7h/X9yztPrIl7+Q8vNJk+6rzqBy2PH4G?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rFe8Xot4ZdAZwSJ+MBVE/Mr8U0wJTi3HQmeGyXcff6Gx3TrD+rqHjTWmabqTjnsBcLDrWc4AWnJfr9T8ufU/G+GiVbQACNWfOxhQM6APJFm6zutKolSn/JWtZ/QKPD67zaWOR5O6zDyC5Y/q6hFoqTmyrTy51I9tIkqgcXFNT/N90VQVP0og6QZFx10EUA5Nt22sves5L8na1Kd02mBSgbsMQQEYR5mFJepVnPUhs/4LWgC3TAGv9XaG9rua1Tn4TyrWJLplru4SErLgccxBUD95yQiS4F0m62C2zDa33VHy9O5sxLL/a2YEhsakJmhVUW3cCaE0/5xnvg8nwPaGVkVO7ayHklskxvXOmukVMPx+pNHrMheqIdYMKcHFITwnmHoNtqxTD1fYcSR59ZTBjonRoyYXyzmxz2eCV3bPZWlgT8+du39zUxpt7mN+Oug/+PRr/4hUsYyHmo6bZmOPKmcQhYGhBsAqHCn2wEBFQkLZIfG4Yqpj2PKuS2UkvczlDEuQfAuRJZCV3Z4Rjeu7HM9Bj4ans8izWGgBpRWUKMr0wKydjtQFP2PumQrxx1zAyMQjXqvmqykTw1ShBSpRawojJa3I7bhRkU/g9ZPyW+w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b9651e-f99d-4862-341f-08dd91804df6
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 18:10:40.7765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ix2xlmKxTyX4n8X/tDubqf+wniOlKft6Zvxz3jbjigQvKJnpezB6fGhZ3Ca7j9aMCZzmUisONsptwr4JtwPkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFC7C4B0ED5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505120187
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE4NiBTYWx0ZWRfX9inrdyNc/pvP Cz75O+UTx+gYjGXGWOexPVSNGRpC9h71jEd24+03q0hpmGOT781ZkAKlHAEniDo3LotJTor7/5/ fDNs86llsomla80CkfpYeqCa/FoOiokg87kDO0P8UdQherrYE7WstwgVZrYGZY6wd5d7ZZd3im+
 vdea0TkqDGZ9nBu+nSEDRgLoU8ga0wHd9HsE4yOZwVY2zAX2S+ntYY7rBNB/Ew7U7h7kGrp2Ofp aRTxKg5g1MEjHuXqrSzHuuHE2X+UB8l2FrtYn8Ce4E+t2egi6v4qjVWzQTFL844q/4MDStld0OK dHZbl+qVrUdJOnyPAZEsQKrRMXDJ3DlAU6r+bA71tGi6HzDq4OigHnRjtxU1fyVN8sjgvhxx5yF
 gjerulLcARWaNFgRxUtObKjClMYg8sa281pwQrWn09J5YQVnqhEzXU+B0ereU6Hab2SlmPLm
X-Authority-Analysis: v=2.4 cv=VMDdn8PX c=1 sm=1 tr=0 ts=682239a3 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=e8B0qkHrPjBVWL0rj3cA:9
X-Proofpoint-ORIG-GUID: AgeUK1WX7W9DS9_xXqrd5EAC4RaDkI5b
X-Proofpoint-GUID: AgeUK1WX7W9DS9_xXqrd5EAC4RaDkI5b

This patch reuses test_num_disk_vs_raid() for varying data and metadata device
counts, calling it twice instead of adding separate arguments. This is
in preparation to support device roles.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/utils.c | 30 ++++++++++++------------------
 mkfs/common.h  |  3 +--
 mkfs/main.c    |  7 +++++--
 3 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/common/utils.c b/common/utils.c
index 9515abd47af8..ebf419224162 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -366,39 +366,33 @@ int get_fsid(const char *path, u8 *fsid, int silent)
 	return ret;
 }
 
-int test_num_disk_vs_raid(u64 metadata_profile, u64 data_profile,
-	u64 dev_cnt, int mixed, int ssd)
+int test_num_disk_vs_raid(u64 bg_profile, u64 dev_cnt, int mixed, int ssd)
 {
 	u64 allowed;
-	u64 profile = metadata_profile | data_profile;
 
 	allowed = btrfs_bg_flags_for_device_num(dev_cnt);
 
-	if (dev_cnt > 1 && profile & BTRFS_BLOCK_GROUP_DUP) {
+	if (dev_cnt > 1 && (bg_profile & BTRFS_BLOCK_GROUP_DUP)) {
 		warning("DUP is not recommended on filesystem with multiple devices");
 	}
-	if (metadata_profile & ~allowed) {
-		error("unable to create FS with metadata profile %s "
-			"(have %llu devices but %d devices are required)",
-			btrfs_group_profile_str(metadata_profile), dev_cnt,
-			btrfs_bg_type_to_devs_min(metadata_profile));
-		return 1;
-	}
-	if (data_profile & ~allowed) {
-		error("ERROR: unable to create FS with data profile %s "
+
+	if (bg_profile & ~allowed) {
+		error("unable to create FS with %s profile %s "
 			"(have %llu devices but %d devices are required)",
-			btrfs_group_profile_str(data_profile), dev_cnt,
-			btrfs_bg_type_to_devs_min(data_profile));
+			btrfs_group_type_str(bg_profile),
+			btrfs_group_profile_str(bg_profile), dev_cnt,
+			btrfs_bg_type_to_devs_min(bg_profile));
 		return 1;
 	}
 
-	if (dev_cnt == 3 && profile & BTRFS_BLOCK_GROUP_RAID6) {
+	if (dev_cnt == 3 && (bg_profile & BTRFS_BLOCK_GROUP_RAID6)) {
 		warning("RAID6 is not recommended on filesystem with 3 devices only");
 	}
-	if (dev_cnt == 2 && profile & BTRFS_BLOCK_GROUP_RAID5) {
+	if (dev_cnt == 2 && (bg_profile & BTRFS_BLOCK_GROUP_RAID5)) {
 		warning("RAID5 is not recommended on filesystem with 2 devices only");
 	}
-	warning_on(!mixed && (data_profile & BTRFS_BLOCK_GROUP_DUP) && ssd,
+	warning_on(!mixed && (bg_profile & BTRFS_BLOCK_GROUP_DUP) && ssd &&
+		   (bg_profile & BTRFS_BLOCK_GROUP_DATA),
 		   "DUP may not actually lead to 2 copies on the device, see manual page");
 
 	return 0;
diff --git a/mkfs/common.h b/mkfs/common.h
index c600c16622fa..de0e413774a4 100644
--- a/mkfs/common.h
+++ b/mkfs/common.h
@@ -107,8 +107,7 @@ u64 btrfs_min_dev_size(u32 nodesize, bool mixed, u64 zone_size, u64 meta_profile
 		       u64 data_profile);
 int test_minimum_size(const char *file, u64 min_dev_size);
 int is_vol_small(const char *file);
-int test_num_disk_vs_raid(u64 metadata_profile, u64 data_profile,
-	u64 dev_cnt, int mixed, int ssd);
+int test_num_disk_vs_raid(u64 bg_profile, u64 dev_cnt, int mixed, int ssd);
 bool test_status_for_mkfs(const char *file, bool force_overwrite);
 bool test_dev_for_mkfs(const char *file, int force_overwrite);
 
diff --git a/mkfs/main.c b/mkfs/main.c
index f80b18c7ad23..0823d378779d 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1742,8 +1742,11 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			goto error;
 		}
 	}
-	ret = test_num_disk_vs_raid(metadata_profile, data_profile,
-			device_count, mixed, ssd);
+	ret = test_num_disk_vs_raid(metadata_profile, device_count, mixed, ssd);
+	if (ret)
+		goto error;
+
+	ret = test_num_disk_vs_raid(data_profile, device_count, mixed, ssd);
 	if (ret)
 		goto error;
 
-- 
2.49.0


