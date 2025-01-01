Return-Path: <linux-btrfs+bounces-10671-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A959FF4BC
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jan 2025 19:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C82D188239F
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jan 2025 18:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A131E25EB;
	Wed,  1 Jan 2025 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oAaeuX3m";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uf2lIMX0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6335333EC
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Jan 2025 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735755038; cv=fail; b=MdSyLzNmNS6pJTFkoObuTzrdUe/hBO1wol3FORVsBNwN0vfW1QtCtld+LO7/wjqYnlA+IPPfmAPaOtvbdkjVNOT5Rk9bUqwC4RVKPnjTqHpeZEtgzzNZt5AZewdSbyr1/xxgLadA0zbQeoCsjIXimH2t63OD/YjO4wA512VGP8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735755038; c=relaxed/simple;
	bh=+WLN2EurTPdUKeA08rhkk0C/a9+UrKm1aw8a5tXQLmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s8xblBjPcIWafdUOi3XZf3kLU/dVE9Df/6YQ5+tpQ3DGt1Ir4DwhZa8ruy5/DAl9c6fuLdeOwZKqftBYorARIq6BUacCIles0T1UUqDtkEyBjlE6qap8ScgjTm1zwucs1mKA4qoBRLniSPdPBCFiNnFsHeXkw0BpuvZmgyulJv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oAaeuX3m; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uf2lIMX0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 501FlEsd024279;
	Wed, 1 Jan 2025 18:10:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=o2Z1qSNycH0fho0gM8U9mm0PRk1/xx3Q4lMbwVju/5c=; b=
	oAaeuX3m8Q6yVbQe/mzB1KzkuXkFOYly/aJxiJq/El/++JFcboZeywdo+u1FjnTg
	Fqp2bqEo1K+cSQ1tH/Q3f6o/SE8NSS7VAT50PLDSu4IOYp8ogGUiDBBthSJWXWHS
	ZjRKaLR3NJHrq4WZxZaxj3aiqvU2EjvAVekrFsT/LQEE/9kaILz80pFwaFGkAsOj
	QMsUjjoZUEpMR29dv6KCK34XN8JBz+UtL04LFo8uhrrWDRpllrm9O9WC6WZJJVCT
	pNgFiOOth2/E/7exHOBblQqnesLJF/ump4YpO9VXCVAUnHp3TlR+Fb8wmd1fAmL/
	BADh4eblmN2nIZNLSrIATQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t7rbvgey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Jan 2025 18:10:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 501I3lhD009156;
	Wed, 1 Jan 2025 18:10:25 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s861tp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Jan 2025 18:10:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8M3aBxQQ1CNxQ10JpBlG+E0t3oq/M2GqSmajolJ1wYEOcMQgb4jKm1tFeuTC+wHKRfoGMWnQIqs8kIgwCCN2n+O3IzL0dVAKicyTSzYutX7VGbvWBPQo5gzQJl30u2KlZpcVP1sDH+MDzb7M1VtBjpIDd3eSVDVrOuvpePRP6ruweuxvZyBKdGJPbeIcx2dVk8b9y93Oo4P+IdjPZBCqK/+MNDjK7ji2mI9+VC9c1d+GFTd0U1Tvmk9E2BvJxP9LEJWu/ad1AEBmTS8CCHd+DimL1rH4GDMS6XL6OnG7mbyD8hoKgPURAMIQAjEoqe4hh0CWnAog9Jkpl/sdH8jxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2Z1qSNycH0fho0gM8U9mm0PRk1/xx3Q4lMbwVju/5c=;
 b=CgYzQTKgvJ4LlvdwnQztLtD1T7jYkHhHX3GaSC9v5W6deHQFaml+p2jLjeUSLYLxfXWpOSdy7afur3bOCBZqWfdRIzQRTmpxxuGf7YOXGHIpqJNiVNcQe/UwGKBcgga84Q6ieLasyrmJ8GrRRFDx5uz1V+zP7zBE4L3xiS5OnJ3EVQLk+cwdNLwNhMbfT661W1HsEnHk0+KwfSiWDSYsTFFAglYcM4YHOVqJIpkrhLCdYRNkRNLzbvtlBUw3Ge0iluxeZ30yx7h8bvjpP4Kgg2vpplop7Z08w67/V8Jd+EMLXJtyeq/Qf6EOMaRpS2tgNvtt8ZwMh0DGPsFcM+HRcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2Z1qSNycH0fho0gM8U9mm0PRk1/xx3Q4lMbwVju/5c=;
 b=uf2lIMX0fiHzUtkU3qVGfKXeG07zFg7/rYe6CgtsczCykS8tmbYmj7mARRGxVJJ1I1/6BLWsw6Q/xYbH4aAArgxIaFLF+gB8vhlSeSfrcbotTYRDvDYZ6/fwIfSb+HanPNSnLF5b5LPAmoU353P0fnNTOQfvdittbun/EUrdUhI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB5549.namprd10.prod.outlook.com (2603:10b6:a03:3d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Wed, 1 Jan
 2025 18:10:19 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8293.000; Wed, 1 Jan 2025
 18:10:19 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, Naohiro.Aota@wdc.com, wqu@suse.com, hrx@bupt.moe,
        waxhead@dirtcellar.net
Subject: [PATCH v5 09/10] btrfs: enable RAID1 balancing configuration via modprobe parameter
Date: Thu,  2 Jan 2025 02:06:38 +0800
Message-ID: <0878345c55203627eb5dcf0e29d5101c29f49c6b.1735748715.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1735748715.git.anand.jain@oracle.com>
References: <cover.1735748715.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXPR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::30) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB5549:EE_
X-MS-Office365-Filtering-Correlation-Id: ec0d01d2-1bb8-4175-3e36-08dd2a8f8ce9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cBzT6R03m9HpqxkldNOzJlWcepjnDMQZQYcSKcqcoToQZv7zolIVmUsdR5Wh?=
 =?us-ascii?Q?hClFAE30nnSIzBTYrC1kij+DrrxWFzWuHMEKb9fo3AScTQtHJ1/fiF8Eun9L?=
 =?us-ascii?Q?Wv+0YbPHpp60fB7X/7On493IGnW00puJtY8S/gdguJin3+a08Pe8G56OewTf?=
 =?us-ascii?Q?fMW4amjnJL5ALHl+y7JDDjXH6yxD14lUFi7ywZubDAAO2qp/jVOHcMF9+Yov?=
 =?us-ascii?Q?0e4VKG+bLTZMKIhkNItCHqCBFNJY5F85dvVpO8/qEtHDX12V5fRQ/b1aRnrg?=
 =?us-ascii?Q?11v9i/GKvC0KgHcDUnQFJL9pPaYeffHDB+UB5YYLhsLXy0P75Ba9F4wkg7JH?=
 =?us-ascii?Q?Ju7hIxwtL6qNgXX/JQkm3IJAY3doJWHQ6CqFBcI7zZBNtEkiR6/On4XuA2Xn?=
 =?us-ascii?Q?UwfBf2RE6IezcdDrYVWrfcgkSsigVTNb/SXLd85aMIgTkBG05SGZk3UhRblH?=
 =?us-ascii?Q?JxIXIWSc+yAXUqkSo1dOVBDvKKMFQjFUSyrQZeOlAGdadVXvZ/T3YJiCS/UJ?=
 =?us-ascii?Q?Mdnb1P+fpDwB5YDd7+rqvfjiLymyMLdLKffFLzpa56i1e9RsQhKqAIH33+UH?=
 =?us-ascii?Q?cRxskgrtxEY5iOXJG/+MBGehSDDn1BcUeo3wxA8VwwLlrvUuAnJpwOEtLSen?=
 =?us-ascii?Q?luOv7KDVS/+rD3pfpmW4bkgYtGJR+ZC+LfLDLMsoOj8BL62Id2hpwSASQ+M6?=
 =?us-ascii?Q?eEgIyh4mFdBtiAgpi3BX6kvyuPRcd4HhhfClGu0BDFFPZdiCqyMlmbsaeYmU?=
 =?us-ascii?Q?bM5Y3nWkLEnrx8cotwIFYv+FwI27yXTsjYqj5Mb6B9e0C3+2qTv8nMo3jn8U?=
 =?us-ascii?Q?/IuM8TsD8U/n89dlyL5rzblMF4/Zh96KMpDO3QLH3okw+hHa7/4RWP4GBme1?=
 =?us-ascii?Q?i6NJW5fPq2h9DFlnVwefJFkC8EYguka5q5HQCa7K2z7Sn49w3XvhnMhS0tOv?=
 =?us-ascii?Q?EJW8Wea/Jmycw107mmBdoL+SYy76ZEwFnAWzNDFtcX5plmEZqsFPuIJhjQVQ?=
 =?us-ascii?Q?EWBE/6RxoLsNXvesfDeG2fDlEU7SvmtXrJkK2I4ocKv8/L+I2voYSziAlLuN?=
 =?us-ascii?Q?PGTTnQGSG1dj3PCuSrjgsHipl8SVKrepirx6wGtZYt8lzEwmdUoiQpCKal4O?=
 =?us-ascii?Q?LXuSCpXCuew/s/3vNGf8Qstvh1OKuTcncVidoz4FFXATvlIujnOds6fvNscQ?=
 =?us-ascii?Q?JPqF+Dl0x+6PyrhbCXxEJYoFPRG8ovbAdSnlhr9XQW/RIqCL/SanScw1k7p8?=
 =?us-ascii?Q?r7XUA+rdNG1bmS0BWj7DWw0l+hL+WuYvZl7uvpgKSTNVqXMZafAEqA43bUgJ?=
 =?us-ascii?Q?SFYMJNHO370BJw3tNSjKDpBCAOvLuxLpp321bDyQcO2m6sRCrvl+XbC5NJCV?=
 =?us-ascii?Q?7KtPfny4Lx46ZVg7vYzMwDgRo8Jp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VjlIMiwbZKqYR7BpkvMnNU1pbeLnm2aMMZ01say8KfO/KCFjAgeSkZ+2cazQ?=
 =?us-ascii?Q?0mI+0QRY4TazlBdnall6ditJzbRfYh3bLwgL8G3mpEK7i+Rvq+Rw79s5PA7K?=
 =?us-ascii?Q?psxBKGBXxBJZRxMXs+1bg5ZDP97MPXmNKi7fv94GOMHFRj+RO1m7Au/M/3+R?=
 =?us-ascii?Q?hOe5J/ip5Tfh4PG0YS/NXJzNY4tXdQr+FI1Eu4atkZnE0jOEAUCUJDmXlyZT?=
 =?us-ascii?Q?G2/S44pz8Yx78GCmTR5u0j70KzFyuCWPHvn52odaMSRczW7AcDS89XzeLopN?=
 =?us-ascii?Q?7poMr+NSuzyEMiyutzkfa5/5hLbRgWYU2XXHTqEVuowqWIUK5mXvV1Vn7E2f?=
 =?us-ascii?Q?mcN46V0w0dQcieYzJek2qWkeRr1keudITNJTaA65NB5SsZJjPq8Hham/LxW9?=
 =?us-ascii?Q?4Fv4FeykZ6Bd9AHH8co8o8nMpeLSxDFPMMj06qhVAnpAN19Yt5VOAINL6N7h?=
 =?us-ascii?Q?GJo4hzrwfXnASrpb61nMQPp2EXesNGqWp9GD/EOaCBAI70U9sk7e6ioSIJj+?=
 =?us-ascii?Q?J21yI1bT9X4I+x0GdCvpQ5ukruWnf3AeGxgYz7Jd0J/ER2nJSAW6tscB5BmS?=
 =?us-ascii?Q?ySrwbD4gpPK7+Z26ONH7iACQa5y+eFrzOyqroe+ECBei9/0WalOY386BgWAm?=
 =?us-ascii?Q?zln5q3/3RH8XocnMcsm8Vf6FfGYLW8luHmZOFaP1DyZteAd4d/pNTWKkfCDE?=
 =?us-ascii?Q?1w0PSqhH8M8F8SHhP4ncsQXDV4dg+JCUCR97qfP3mWDfFUcCP7Du6pPgYd+m?=
 =?us-ascii?Q?cH5+jTEqN6ozc4eeLLvdNgaJuXE/vUMHaLeNoFyb35oRpI9zxgu9+p44Z9Tt?=
 =?us-ascii?Q?P8DsCWaH95GyPoCPmZTcSSNIXpQAyZ2x37PCjNXx/ziRhozEFK97REIma5IP?=
 =?us-ascii?Q?o+0oNGdsm4nG6J+rCzbzv32SHi2m8NTddgQQGJFPXhL+NwtZEez5UcgbFnv1?=
 =?us-ascii?Q?TBqryUm8snK3X/spqglOMLTiDQ35ok4jqpwBmxLAnvOEb8yO5yH+jj8Kyl4z?=
 =?us-ascii?Q?ZGPeJhr5FI2sakuv5VtSatBqRcw19H6gzWND+7lOMWKysZ3PRCpj6fY47hFg?=
 =?us-ascii?Q?Y5LuaK2e+aazwcOmAW+fYycaKnqf1nWG2zJxr9TSoHQ7UfYjb7Ys1GZ0D67n?=
 =?us-ascii?Q?HUIrTyTwtbY1NA4yW5VRYZI4W/tHhCFlprUPD2Mze/oy6qno3fCdpOXYzS7j?=
 =?us-ascii?Q?q4vwDnRrvPiqfPRvj7fBErZuY9/iggq8hex04VEJ2xc7kXx+fH7gO8ovzbbA?=
 =?us-ascii?Q?/EvJECjGSP86zLKTUOsJkrtTlF+/CT+pVLdcKLkMwTY0LopimDoDr3QD8i4q?=
 =?us-ascii?Q?KdAr2ZcaIrBhdt3MQ9iLsM+iituAl627U8qlnKIYa2Iq62J3SZMQlPIDwXRH?=
 =?us-ascii?Q?l+PimjudQTzTvkYn+VE8+Nh3KhC5kwY8kAki6tRlByl2XjxrTct9SPTqkiDF?=
 =?us-ascii?Q?jyYRFZs+TqdlxS55VFNdzVYSNlxGHbL/YC61LRP6hD/O2sFQ9Idf0z7ghAnh?=
 =?us-ascii?Q?naFLthOr13wG2oDoHl20HA2aqRtVYZocRIsZqjynGA4WAVDDECvCudRDsfqb?=
 =?us-ascii?Q?7UgdkXSBOQesq6wz+4gxPJpPl948K26NmmmWTYgf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kCuLRUeCOY55Ep7pKdX11d2PYN3IzaKlQa7u35lqxWk0nLsaD+xP73Ac9Y1lv0eu9RdCT1KaYZsQGM+Be6Gyt8KE1F9lTqmR39GFOlrxp/b3VIqdYZIJ4eewzgs1BVYq3qV7fmQ9JfXzablvF+yPzcm8/E6qSM/XSyZBw8NSVdbUkGoAg9wJpIsZ21pk1I/8cLinopFpxYX2r3vpg7GPepOZ1KkBFeIIql6aKRJ3IQmzmVamUIiJBPU/YRhDt85rOJpZuXffwYiB/Zpsne2+HNNdXUSegqCQAc/YWT27hhIK6YskQ7wqZYA3Oqr/aqoHhr7i0JmAWL3JIcsSx+SFxutphBTX2bG1y4HyM0BtY8tGPOcWVIdM3moS1zRJFuLmL3F+axPky7wdw1008w6tN9NTxFpcAeBk3HA7qwa8Mu6gxvY2BlTVmrBEmH9XwdaYddpns9yIoKAHC3nffzGSOiCRRZYmQWtmV5uuUmcyJ+g5MrSzwNcN0YgudsHwG9L7gB2behal3xEwxqBYr1E5mA/EkpEbHu8ug1N87UglWiqdMD9FAdybBushr4qxWg6YlA7yHopyL8N78TxnFdLtkOldp9LWkB9VHQPJLqYJ6h4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0d01d2-1bb8-4175-3e36-08dd2a8f8ce9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2025 18:10:19.2626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GusQmpEZam3GmVkgsHYVV9L6zrKWZOcaciT+zCSmDm4rDvBY3wpA81a+p/nfcyZtKf0JebNesb2JFmb4MtMing==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5549
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-01_08,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501010159
X-Proofpoint-ORIG-GUID: B--op74axe7ZWr92wpedpej5BlXclL0A
X-Proofpoint-GUID: B--op74axe7ZWr92wpedpej5BlXclL0A

This update allows configuring the `raid1-balancing` methods using a
modprobe parameter when experimental mode CONFIG_BTRFS_EXPERIMENTAL
is enabled.

Examples:

- Set the RAID1 balancing method to round-robin with a custom
`min_contiguous_read` of 4k:
  $ modprobe btrfs raid1-balancing=round-robin:4096

- Set the round-robin balancing method with the default
`min_contiguous_read`:
  $ modprobe btrfs raid1-balancing=round-robin

- Set the `devid` balancing method, defaulting to the latest
device:
  $ modprobe btrfs raid1-balancing=devid

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/super.c   |  5 +++++
 fs/btrfs/sysfs.c   | 30 +++++++++++++++++++++++++++++-
 fs/btrfs/sysfs.h   |  5 +++++
 fs/btrfs/volumes.c | 14 +++++++++++++-
 4 files changed, 52 insertions(+), 2 deletions(-)

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
index eb23f29995e4..ac1a32af2442 100644
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
+"Global read policy; pid (default), round-robin[:min_contiguous_read], devid[[:devid]|[:latest-gen]|[:oldest-gen]]");
+#endif
+
+int btrfs_read_policy_to_enum(const char *str, s64 *value)
 {
 	char param[32] = {'\0'};
 	char *__maybe_unused value_str;
@@ -1336,6 +1350,20 @@ static int btrfs_read_policy_to_enum(const char *str, s64 *value)
 	return sysfs_match_string(btrfs_read_policy_name, param);
 }
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+int __init btrfs_raid1_balancing_init(void)
+{
+	s64 value;
+
+	if (btrfs_read_policy_to_enum(raid1_balancing, &value) == -EINVAL) {
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
index e8cccfad6ad3..e5e9b33837b8 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1299,6 +1299,7 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 	struct btrfs_device *device;
 	struct btrfs_device *latest_dev = NULL;
 	struct btrfs_device *tmp_device;
+	s64 __maybe_unused value = 0;
 	int ret = 0;
 
 	/* Initialize the in-memory record of filesystem read count */
@@ -1333,10 +1334,21 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 	fs_devices->latest_dev = latest_dev;
 	fs_devices->total_rw_bytes = 0;
 	fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_REGULAR;
-	fs_devices->read_policy = BTRFS_READ_POLICY_PID;
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
 	fs_devices->rr_min_contiguous_read = BTRFS_DEFAULT_RR_MIN_CONTIGUOUS_READ;
 	fs_devices->read_devid = latest_dev->devid;
+	fs_devices->read_policy =
+		btrfs_read_policy_to_enum(btrfs_get_raid1_balancing(), &value);
+	if (fs_devices->read_policy == BTRFS_READ_POLICY_RR)
+		fs_devices->fs_stats = true;
+	if (value) {
+		if (fs_devices->read_policy == BTRFS_READ_POLICY_RR)
+			fs_devices->rr_min_contiguous_read = value;
+		if (fs_devices->read_policy == BTRFS_READ_POLICY_DEVID)
+			fs_devices->read_devid = value;
+	}
+#else
+	fs_devices->read_policy = BTRFS_READ_POLICY_PID;
 #endif
 
 	return 0;
-- 
2.47.0


