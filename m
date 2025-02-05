Return-Path: <linux-btrfs+bounces-11275-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2FEA281D4
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 03:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3CE188789B
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 02:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E598B211491;
	Wed,  5 Feb 2025 02:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WOQauKKj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XFwJoZLx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AED620E316;
	Wed,  5 Feb 2025 02:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738722740; cv=fail; b=Q02gxS+Z7Mqx/t3oBeikchVSPvVJojs1+xm8hIKnyPCr3+OOBEfFOY4RsxBbY6dFNgQ3QtpLLpmreEfcSzXk8CnRZn/5NwOIs0sUOnpkF4+hydeV2h75RULDfJUVwzWZRtgVDSnet0AlvCw/CqZZP2U9gfghYRNOxJpN5lwwOrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738722740; c=relaxed/simple;
	bh=bD7c0/NP3y0Eg6yzFVGZzYWLggqqe2LCPL3ADuMDMY4=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=LljLLacaCQ+KQPIxl+qypcd6fGQ3TBa9CIXMZIdbbiOXPIbVeyNusPH+BgAuTv8z4MtpWg6Fa0qe7mzPDDPzAAWBnVAXK2LcUynC3Npfai7TeekYvPQuur35EkIKaM9HY7bcTNP2Z9+BBFhpGCNWZkMki5hAOzogRL48b0WsKQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WOQauKKj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XFwJoZLx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514NC2jn003449;
	Wed, 5 Feb 2025 02:31:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=mf9AJuJb2cZmQGN2oC
	2jhCBouidNZkTQGramiWczAQI=; b=WOQauKKju3Jmh6a/PQ26jxNI/E+VtQAbIo
	qKAOlXPKJka0F6+UVO0uJacwIquu/PttIQtdh9p89jLh2ZFQTOlmjWeNB9C1m8Ae
	nQaY1QMOwGYyGam+JCBFh/YD9Eh89Ioz7X8e292zyIJLxmuB3HDYiC1K+q6RiQKh
	eFGBK04veF0bztqP0ytOT3GM9o7YutUl1A3MjKaQraD3rn8ieiYhLE8JnBuKC5Kn
	jCClA/tMsSCxOo0RLbmfrNJ48sHVmjK1YLRNAydZuy/xzEy4E2BYPOiGykUfGy11
	xOsHgfZ41CEZr809BxMt1lb0CdQqaXNzfXRS1difNNX31DAONs9w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44kku4sc2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 02:31:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 514NJepX030645;
	Wed, 5 Feb 2025 02:31:56 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8dn30sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 02:31:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbo/SlaRB0WCEHtyrQb19sSsH2iKHRiJVbtiqERck0W1IAHJLz0nDixFnJ3KR2Qhe3lhNnj/rd+xSIdFZSQGmVTdnOE8dsyFLwxnHR3LFrCyFUOr8nyEMxVcPW0IS7n1ne6Pdw5x9F5vPqp2npTSYSrlb+pkKaZ0IjtUT/GgZ4b+4m9Zuwiy/JJOPpyY4eKuCJIz7FcRzvWv3e+m8OFvCfryxe5LQe31MtcS4VVetcn3mcV7kGGsWw6y5MckiZgkSyGgoKcmHnDz9prF45k8JSOku2khcqRwTkhmiIT+LhGawz4EcWJCfMjVsdp7FY/X5OEGYj4GBqeWbfui43mCsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mf9AJuJb2cZmQGN2oC2jhCBouidNZkTQGramiWczAQI=;
 b=AhnN3ZUJ+fEcOuvg2XQStUYlugmkn5/tZ7spqeaAvllBfzje5z4dfF0ZRTB756FITnDZDPj5UK/lwi4DddrXwVMXmMQUfqlYDV5cPLWV6BYQ4tGY46TFPpHE9w6PXvvmUryjJ8SOBvSkn65iJmTCIj1IIjltxpqp4HkCjqzXP4LWGhi2JDTDdh/eOCqjg9bdVEXzH3TVITm5V0T2/T7IubrGsZklCpK4jpkGucWaSgKXJjLzRLRhAzFwXlvzgdKvybvU2ODF834DNKdBsxuNOCzZQwcTBqr1+r+OPc8/JJQxXDzlSBmAX9reBjHoXCSklsTjlhQy81nZ73hGUHAqmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mf9AJuJb2cZmQGN2oC2jhCBouidNZkTQGramiWczAQI=;
 b=XFwJoZLx92UBXUST5jDGhfjmy8IvuVOIMlySRc1U3i6E5rcT396d5cfa93BFX+XGdzGvnAYF1Zfxx0czs939FW/YIPJVq+EXsYeGXhZPMcso1qJJnWWZ13teiTpxtiV/A5Sm2hUwGUlLZ4BHufu3l+dLRIzRRCdDJPbSYz0FjbA=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by DS7PR10MB5023.namprd10.prod.outlook.com (2603:10b6:5:38d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Wed, 5 Feb
 2025 02:31:54 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%4]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 02:31:54 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kanchan Joshi
 <joshi.k@samsung.com>, <josef@toxicpanda.com>,
        <dsterba@suse.com>, <clm@fb.com>, <axboe@kernel.dk>,
        <kbusch@kernel.org>, <linux-btrfs@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <gost.dev@samsung.com>
Subject: Re: [RFC 0/3] Btrfs checksum offload
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250204134901.GA11902@lst.de> (Christoph Hellwig's message of
	"Tue, 4 Feb 2025 14:49:01 +0100")
Organization: Oracle Corporation
Message-ID: <yq1o6zhdtc2.fsf@ca-mkp.ca.oracle.com>
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com>
	<20250129140207.22718-1-joshi.k@samsung.com>
	<yq134h0p1m5.fsf@ca-mkp.ca.oracle.com> <20250131074424.GA16182@lst.de>
	<yq17c66kfxs.fsf@ca-mkp.ca.oracle.com> <20250204051208.GG28103@lst.de>
	<yq15xlpg9tj.fsf@ca-mkp.ca.oracle.com> <20250204134901.GA11902@lst.de>
Date: Tue, 04 Feb 2025 21:31:50 -0500
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0249.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::14) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|DS7PR10MB5023:EE_
X-MS-Office365-Filtering-Correlation-Id: 7879e791-c4a5-431e-ca3c-08dd458d4110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H3kviAss8wWhfuU8Ez0kJgmc9Jp22Hs+S2jHAX6QHMkNcnvh4B+I/G8F0xVf?=
 =?us-ascii?Q?VddeswgYlAAosksQop4yqc+L0hllJGRYqgzaK4yI4Ku7tURV3cSIJOeMzINq?=
 =?us-ascii?Q?mwx3xwTeP25gDGinGBFHse4c3RmwO1IpbzANXTg2we89ut2/ks+sQ8osXW7X?=
 =?us-ascii?Q?NQgRrMKvCrVbY6wWtD4IMF3tJS3AZVa49jy6ms1RAQiM4/MvvOUa3kG0aMjE?=
 =?us-ascii?Q?ppXx8rum/TzYpbwKcFerKsmMAqsu0smcuLA7+6yr4ZKg/h6VgIzJa2Qke5CD?=
 =?us-ascii?Q?v1rq9vdHy5u5MTxjaW/e0maLnGPjBhZoPS15z4FvaK76uLCxAoi0UFO4iMWH?=
 =?us-ascii?Q?rWPJfN6Ugk8EVY0tjg8s/w8+EgdKMQmEAmzpFkammVO2f3aEW4YDCXj+GQ2A?=
 =?us-ascii?Q?FlN62AXeS0+BIHKj6PaXFWTgx/M9bx1c8KcLWPsdaL12dY7v/rdpeFLMuILu?=
 =?us-ascii?Q?Bqt1Uoe50xtqf55YrdZjUHS8zoJFCWkkIkKoa26Tt4Lt6vPOFzK8LUQnmWiE?=
 =?us-ascii?Q?iqjyC8Wo/5PvB6k2jdC66oQisORb+WAZGus3WTd10B4B6lztqtrsIMvTKeRa?=
 =?us-ascii?Q?Zsj9vTZLfsZb2RY/GV7JJT1+0hRuSzNQEFESQXA13tE/KIt5N+fxL9/lo8SI?=
 =?us-ascii?Q?T5sJoVG+Hm8pscJ6VKqjQ/o3xm4P2hn9EfNBJEO1DJu9MfMW9kEeOiWlAy+t?=
 =?us-ascii?Q?O85YShEo1tA6vdh4WoSgMvYsnlZQenR5yy0x2glU10VYUSmLF0b+Y0nKrShw?=
 =?us-ascii?Q?0kbBZ+wR5Y5CckuZMfx75OWdyn1hNrHdZoHAEmder5XcG+5rnmYgpB9E4374?=
 =?us-ascii?Q?lfEjIK8m/Psqj0BKVHsLypPdm0WXK1+5psDOjho6pzJaFUCOGPZjTejBfe6d?=
 =?us-ascii?Q?Ovjw4bL+Y8uv1GUILl6BQaBpit9c+d830hzzJr54AJTm2eJPzTsbiJ74t/NV?=
 =?us-ascii?Q?EHh4NjFgWsFhSk/VfWrKjGpbEa7+5rCS8I3pjt+iJx5GkJIgA+E0YqQzJ/6/?=
 =?us-ascii?Q?MyrhhcN56PXXP/lsb0YRK8rj0hdLp3tNK0A+nE+CLTlq6k/T/2DQK9THXnFF?=
 =?us-ascii?Q?6xKU420dffEATdLzUAQzVj9z+UZLr1Wz/X+o9ZHF+lRNXKoSb27tkBq7/X2T?=
 =?us-ascii?Q?6Dh772EUGxUZu939C7ir0DDMKI+Zd+OhZQ0UJbZcFWW7AefzLGPxtCoB//tE?=
 =?us-ascii?Q?o66r+YuUkkou92myF1EYVpxQiXFId8Trj5ZYXCN5l8dVOFF/3mmLzyranDIp?=
 =?us-ascii?Q?FqXCCgkgxoKNDkyoN99ZLKkAIKI1bFFltRUKEenFYVlF7Qbj1uSv/F+qVuxm?=
 =?us-ascii?Q?JFCV/zF3+r5KCzHQgHiHLUAEdavHUz/b34GddqejzkSDffmZis1g6TsOdbVd?=
 =?us-ascii?Q?sk3NiFP9kqdkxpXNd55cxsGHQepH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8gJ3f+TgZzK6pDd0jsMUxNmLzg8snWkXskafA0evNEEoO99CaTQdIq7n3Glk?=
 =?us-ascii?Q?KzAfSheKGR4gWLQ9rdTq1xKqGsy56b2JJV9BCdfPQ10mUJipo+Lgt2sNns2Z?=
 =?us-ascii?Q?OH9q59fT8EZSqF+3EmxULtZoBfbuEJm0wi9SqodXLqSlLMc7E60TXsq6CVKx?=
 =?us-ascii?Q?8yvFRqQtmbJD2TUavaGeNPbGb7R/m5BLfL2K2EJlELxiJreXzSYgyrDnvgLO?=
 =?us-ascii?Q?jjw4A86UfnJbwvCsDMWiKoHlwB9IIogSbyilsNvrWExqShoTLN7OPmD1cFxk?=
 =?us-ascii?Q?Y+3Wkmj3XiZDAaGwIoK1p32aNOAdL3zmAnYXG3IYtnafEsxkV2CUbNWzCAhM?=
 =?us-ascii?Q?Ok0ouo2gcnADllJcT6lzd7t8DFCQFVwGNk2Iukz+9B/xrAZ3ba6TYKeJJoOD?=
 =?us-ascii?Q?s128sXpkLpmxz83FnfhciIw+fGSrF7MI2LCKWnGt6w7S8RXolLS4CqRdFBn0?=
 =?us-ascii?Q?xlOUvhO9uYra4gcrugIn3/lxvQrgpcEW7Q6CUtvQ8yjBldnCId5L0zDp3lpj?=
 =?us-ascii?Q?6Wc56tLpg8pJTVu1Du9yOM8/g0uQjaAhOsmSEgPQ5vKJ/eFJWYtlIwiJdom5?=
 =?us-ascii?Q?DTwmcZknU+OjobCAB3Gv5uz3E2+7Tp6/lWzWM7bNXe/uTovuD5m4urmn1BMR?=
 =?us-ascii?Q?kYPv5AeB3S34fQX/TYpez3eA81+Nm+yZ+DXlEGwSTv9Z/0KrHhihes7TViG5?=
 =?us-ascii?Q?VMeLf7+8IztaTgaGW9SOXSmddFJ68GJGULn6uTvYDBYh22Yt3yJ4ZME/DMG/?=
 =?us-ascii?Q?R/ia1B5iFH61XaT/y2ejC9J3XBhD/S83rDn647OQhaffIHgkduTYDohy9HXa?=
 =?us-ascii?Q?2X3ifl1ibSaNWd+Q/MmI1L38qeHf7ctlLdwKjM2vT5QOQklxLmxhdwhZgSIb?=
 =?us-ascii?Q?be2PFj0iWVEXeAPpD1nQ7nCqfX84hBPMUZ33f6v0tiDNdYxTVrmsDc/20Mfo?=
 =?us-ascii?Q?2YbYQaDkVs8jKAxjO3RkkciIgo5fX5iPhPcYawFKAhJis6tNseOG374QASqN?=
 =?us-ascii?Q?BF0+f4DpSQp0L5mAFLksbSOY8l67XEEMjqbygNyTUwwCGr7SuuEyfBEhJHNo?=
 =?us-ascii?Q?VSrgUFex9qK/CA80DAd8YlM59IdE97aeitzEZl/gWGeCMgV9yghtPof04jg0?=
 =?us-ascii?Q?gsN597QgKL2kiJ1YOzgqIDO61qaEz2jvNGCW/437x5779hNaElN84f3DbAvk?=
 =?us-ascii?Q?AIK3igwg8DsvsDOftm7d6ulvVxl70jyrDMdj7ZqO+aJ6SGOBuumRY66z7O1M?=
 =?us-ascii?Q?xyzlKjtA863z/0aFEeM64FHKojonxQjpnFmkFhxJ1Pc5XKehcPpEo38kWRg1?=
 =?us-ascii?Q?cHiqAa/9NNdJ+yAOirqpXhTRMh6tScsNnit/3epBA+yaFNpBpgk2VQEgTT+Q?=
 =?us-ascii?Q?2xNmuh2DDZAw2c9yi0eo2F+rjMj7WqmKhSFx4oail/0BGkgsELhpvFvzJ02y?=
 =?us-ascii?Q?UlsCDlaWNzhUJersR/F9FVuDlZ6KdnnoQ1guGyZremPW28XPa1xsRRjdZwH+?=
 =?us-ascii?Q?9wcW5AcEguFAko28kLTyv3iJCt3TsgiDUDXr9d1rKdOUkrgXJITOTGXDcwIq?=
 =?us-ascii?Q?Dk3pvmHH23rxwIYiju14XrerCJfU/0CWmN8DdLzM4zf5LsYLy0xOAfhN9NT/?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	igdr3NWAi/3tR60PbPoWsRoGtCli0q3lKzuuqd7emJYIB3QQnC/GlDVCJ9KHb22pAT5k1NktPHaUfVHwWjEzHSJ2rDGAJq2zkzUhwGkBl59x8FPGD5fNCEEUeTS/BidcwukIW4K5Mwh3wSfzVI3zlItPDC1mkneT4bDgRFRQMMuHyemiiDx7auKk93cYP2OZO4jnV78Oh3eWDD5wqIBlBsdchYu3foiqah/t2LkebBidSIevkL47Wu7nm6zT0r9TVONjfjq1xDAzQdKFPl5+p5VsP/N1wMIQPaLxgviI9pJRyIVoqId3P9lRdRc8Lt4+HE+jIaajcGUxEI4EFGWDXESRId83/5ZHCUVtwrJ/EnB2ohABzjqbkB6ZRvzre7u7e7vbvzsb8VZ8VvU5bA/vCSeckrWrYOtogZQ8R2ljJWGoN5jV2fdk6IAmXBjtgXPRvHNuOQImugYq+X0pc93xVcfa3y4H14/xp2FlptEQMnXETGa5pYN54Ro4DQp8pAqSs36p2x/VZJn4wDBuxI/I0JKiuyc0ahAWKhcTTtSPV94weF9Rz2/yNR1vceRy+WE9qGn3nOg/iLmyQnyTaYMM5Y2h9t4uOIoEJIf/bNM7ESA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7879e791-c4a5-431e-ca3c-08dd458d4110
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 02:31:54.2248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HxQFcSix2AnnqsgkaJgHh8R0ZzCR1QBHC8Ono/5m2tteS7aAejTAja/mD9lLMwhCVq9pkP7HbobpiFGcXXIyac/3/Yhgl4dl2iCXVY+XwjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5023
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_10,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxlogscore=734 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050014
X-Proofpoint-GUID: 5-vMRcTio3qUmfFvTlEAknhBoKm75eiY
X-Proofpoint-ORIG-GUID: 5-vMRcTio3qUmfFvTlEAknhBoKm75eiY


Christoph,

> Hmm, why would you disable PI for parity blocks?

Some devices calculate P and Q on the data portion of the block only and
store valid PI. Others calculate P and Q for the entire block, including
metadata.

-- 
Martin K. Petersen	Oracle Linux Engineering

