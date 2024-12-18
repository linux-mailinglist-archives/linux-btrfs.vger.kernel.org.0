Return-Path: <linux-btrfs+bounces-10524-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BEC9F5E5E
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 06:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4214616C210
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 05:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98D415530B;
	Wed, 18 Dec 2024 05:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OkRhh1l6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TKekpyu9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF1A15383E
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 05:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734500948; cv=fail; b=amOAvPI7zsPGI46zg20whM6+1ss6HoF0u5vvLR1HQ22KkpIP/IUV2959BrS8OUGvNaGvEiexu4ou+4duCFZfZoZiRjVl2sTZEtwzuzsaN56h71Wh81leG9idgLuitl3/VRnwW/44pQ9X4sMds0N6P52ZTZXY6/ulmi1fMif0jF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734500948; c=relaxed/simple;
	bh=K/nBhucalU5c5ljWz8PLlPcvKZsn6ZTCTMrZRaQjhWw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CW7pU4jWANv/9fP0TZ4tbnNqe7i1ZGzz0WWWCzZLr/KBVYMJkbrYcIb69gK8+6UgfpY9JK4xQp6M0RINeSefjgLG5d4sS2DbxQACOMsVZ1cJIkDkwOIxlHxdQzE2myeRhHbyh6MFPsPoy9qT90gwyX1uLYwCSndaULTqMXscRrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OkRhh1l6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TKekpyu9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI4u6Z6004318;
	Wed, 18 Dec 2024 05:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=FV8zyvhjRkwjZdOhruxVTqksRAJU2YMObgYDVoHRKd0=; b=
	OkRhh1l6hfZ/SVPJo6FIVv9E0J/ngiSB79oWSxGMhqwnYh6tSa8Z02yaY/bxzk/R
	6HgNX0qkSdCrb/J4P8qleSt55ZGFiFvSKZEY82+tPRd7zWAAPm43cSKkJnRlaWaI
	CLIIsjxFP+Xf1ijuHpSM6/aNIh9vztYVJgIs3YRB1W6zID4aMBIVxv/9MgPC9O1t
	oAyYPrC9QsllkIcml7PDEODXFEx1wqveDICgqTheVrv99P6h5OaeTuguvllPhbMI
	I4m1YVTHchbKX2b/7LySx4YnwccjNsJf336sY0j+fIZRuQmIrWiBoao8RKP43Nxq
	4XyHKU7LTGuUFmaHmLy3iA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0t2fra9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 05:48:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI33Cck035463;
	Wed, 18 Dec 2024 05:48:49 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f9cs3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 05:48:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cab9Y8KNZ1atP20vPvOb+2diC8BJRa3tw8tMYbu93+boOafm4Q0CdUTTaWS+QGyKE5Yt6pN0LUbq8Xsa5qvIaN1zkgydtuKxyGS0L91wNS3zNdort8OmR4TtYbgnnpFu4juots1uSSLHoCCYtgdPaRy9L5Q7rT9RaiPSYQyyLRnEqT/iFq7+gsV9x6BEW2Fwy9umh93iysr/hXrqJ57o4YgjTK1z7MEWNpRIuBB9SKKhFGytGu8MaWKEc1O6UgLtOU0SkGZGU4sGiKawvReJclzDgBZjoMVKYVYVA5+mv09Ud41WsUI+W2pAahTiE38YwVJBzZdBvx8uRIZOn6gt2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FV8zyvhjRkwjZdOhruxVTqksRAJU2YMObgYDVoHRKd0=;
 b=UOuN8vZ0ssfPXSzOr/4h6C3Q4OrKUMS96YNIxvljfgbTU8NwsZfCOYBesbrspjFRI2rrufZ5uyDwjXt15Nisfhhc03qsfU/JeRddzF8xLMjxdBT1nvEtZhCGuSGT1IRc7OaMKWoTReksJ4oY6w80fvJE4O52XtutbklwP/ybjw9s3yW6byPnvsnz4MR1P+KeSX+rf183aWdaiI0QQtabyRkEZb5f9DdNF7M+O97pDdr3WQWw/kWfwSZ/LdG6DKHqjSy1DUc34jaSKWtq14unsB3h4qQjku9hjQjhjRIpriqEnUSf9CpnCqKBY5tDu3+Ksy9EZDPolo5pgnRQbrUerw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FV8zyvhjRkwjZdOhruxVTqksRAJU2YMObgYDVoHRKd0=;
 b=TKekpyu9o3sYpCmSJCTtrWWMYIarWuEApL1ixbDrRHB22dNh0lZv/91mvssex1f71ZXu2V9cAaWGMTn0gYVLzMauGYtjf/bR4z6ygKYbm/YExG2UMyLZESDAZjv46WmUWO4+vqgn7/4dbWZdmwycPrOmS10DBOtVQ+yLHHf5HtU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6027.namprd10.prod.outlook.com (2603:10b6:208:389::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Wed, 18 Dec
 2024 05:48:47 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 05:48:47 +0000
Message-ID: <bee14a7b-1ecd-4dd4-9bc5-2c71a1e314e9@oracle.com>
Date: Wed, 18 Dec 2024 11:18:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] btrfs: add btrfs_read_policy_to_enum helper and
 refactor read policy store
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>, WenRuo Qu <wqu@suse.com>,
        "hrx@bupt.moe" <hrx@bupt.moe>,
        "waxhead@dirtcellar.net" <waxhead@dirtcellar.net>
References: <cover.1734370092.git.anand.jain@oracle.com>
 <9fcc9f01bdab846db231b427f98fbb3e9df7c7a5.1734370092.git.anand.jain@oracle.com>
 <n4wm5d2p4ghpmxs2okidq3iz6obrtrke4ia42zws3dk6j3suvq@gbit366pij6s>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <n4wm5d2p4ghpmxs2okidq3iz6obrtrke4ia42zws3dk6j3suvq@gbit366pij6s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0140.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: 735c46e1-c361-47e3-8bdb-08dd1f27a3c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VU1NTStWQlhWZlllUTJVQzRRb1Q5c3M4R3NWakRub1lnaTloazY5VjBOSytl?=
 =?utf-8?B?UmpJWTMreHBtWXpnZVZob2dZQkg2Y3FrOU9ZRG5rKzBJMDJFdXVkTzYxeEIz?=
 =?utf-8?B?UDlaNHptV25mQnhzTlhqWTd0WGZ2K3Vjb2d2SktiTFltMmtGTGZaMDcwWWxP?=
 =?utf-8?B?Y2dmMWFBajUzeVQ4TDFiK0o1YlpYMGlRLytQcUxjL0EyNS9TS1BjYzJPR2ZS?=
 =?utf-8?B?YmZSRk56ZGxXQzNtVlRWWUg0SGlVcXhGMFIzTGdGcklGNXF3NmlNOE1yMUZZ?=
 =?utf-8?B?aVJOcW5RTEprRTlnYnVrNUd2a2p3anMrTVdwN3dqaGN3NGpmcmRaZ3BoZ0x6?=
 =?utf-8?B?RnB1bE01WndNSmFVVVBqRm5LVEhBckJ2U2c3b3lCMSs4ZEFjaDlvMkV5VXhh?=
 =?utf-8?B?NkZaTHhVRXNkSkRidEhoT1dXZStZK042OUZjZGlIZFZ5RmZDMG9hN2I3YW9G?=
 =?utf-8?B?ZHFrU1FrYWErbjIySzd6UHpFRFpQQ29QRjk3T1V5RXN3V3lvZ3VjZjM4MldG?=
 =?utf-8?B?eExHUFhUODlSTjYxUm01M2huYXo3T3hJaDZZNG8vSHdhWEpydWQ0VjJNRCtK?=
 =?utf-8?B?VjFmejY1cjhuTlNQMndHb3RGSVpzdjVMVG05Q1ZENGFNU3M0WENuVStwemVW?=
 =?utf-8?B?eDFGKzdhTTRYSy81Um04NWxoU0NCQ0VySXpPSnl4cnJzUkZITkF1bzViTlZa?=
 =?utf-8?B?ajJYK2FCOGxWYlB5VzJRN2s2bkxSc3Q3amJuRWpHZERFdHlueFhJc0xhMXli?=
 =?utf-8?B?ZXNwQ0dkeFMwbkhxdnVBUm83MFdPM1ZiZjNhcHZrK3NUL1M5Ymc5UlF1ekth?=
 =?utf-8?B?WGp3YnNrbG5IZ05nVFVmYWtJQUxOTE9tSmhncVBtb25GdmxMUjk5UXh2cm1P?=
 =?utf-8?B?azRIUkk5Y2xHZytvTFo0L0srSmgxWXU5VXpYdzd5MXR1bzREK2Y1U2p2RnZs?=
 =?utf-8?B?ak9IZVc3UUJSRWE1aHRLKzFqUlF0VkdIK0FMMERWREZJQlNSRFV5RGVHNDVG?=
 =?utf-8?B?UksrWGk4R1BlcGo1ZytEeHkvNjFudnlueTlxemVnR2xIZlY5TmJ0ZnkvVVY3?=
 =?utf-8?B?eVJxdHhaYjQ2K01qVnNpcCsrU2JuNzVMZDlldFBET3FhMiszUEt4TlNzMTBI?=
 =?utf-8?B?TERKVjA3YVVCdUE0bWQ4SENaRkVwclZodERzYXhZSlFra1g4Lzl1U21wYXAx?=
 =?utf-8?B?NndNeVQ1Uk5yaGFQQWtyQk9id1hoLzBSZW8rM1o4SUltaWdPSzlSSGRRMVVH?=
 =?utf-8?B?NGFrTTArbTJBUG9vVXFVTTZXSFVIdTFQdjVpOVBSOGRjYTlSeUw0amY1QVpB?=
 =?utf-8?B?WXZkcUIwYk5jYkxnTnYrS1k3WUI0RGhCZmt1bVBCSzJuRWlibGFTK3IxUEdD?=
 =?utf-8?B?MWFrWXhDejRRd0djU1lnQXY5aitmcGg1b01zUXhrNGsyRXVONkNwb3A4RzZi?=
 =?utf-8?B?cmxrUFBVSk1jaHRzMytYdFdrZ2d5N0ljTHAxeVRGUjBlcFhhY244c0FOOUhW?=
 =?utf-8?B?dkR1alp2ZFhjMGpjZWtCNHB4cWNyYjJUUXRXV0xhWFNBd0ZsRzhQVTlnb0Zl?=
 =?utf-8?B?dHZ6NnB5eXNqVEkxT1pIZ2FwaHo2UjlDUGJNMkMyREV2WkJaeFNwVHNGcHBm?=
 =?utf-8?B?YmpyVDQzMHpkZXJlZFgyc3gvWFRnUTNCT2plc1JZUG9EUldtRGlPTXBzK05a?=
 =?utf-8?B?SDN1ZEZGaDMwUy83T3F0L3F2TTBzbTk0VGRFZmttQWp5YklvQW9QWFRKTjh4?=
 =?utf-8?B?SnBQOFJDby85SHJQMldPY0Ywd21mSDE1OC9mM0hhamwxRktSRWxpbTc3blhO?=
 =?utf-8?B?OEVzbzIzM3laTEFnTFMyWWhhNktLU29rWGZXZzZMa2FBdTFISnRVZkNheXRY?=
 =?utf-8?Q?bvC1mLtcDhC3w?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3ZvdGlTSXg3ZkYxT3hXaUEwbFdidGttME9nMlpER2lMSHlwbmZ4QnppUUwy?=
 =?utf-8?B?a1V4RkNuSmc1bHlmaUZRS2hsbUxybUFUWGJqUmp6NEpsN3dxZzRzNWhjSzdk?=
 =?utf-8?B?dGVQU3Evd3dYWDdZUkl0VlBYbDBmY2J2VlFRcGdnYjZmY2NXUzdLMFJuaCtS?=
 =?utf-8?B?bUdhL2I0aVZTdnNZeXFXL1hsR0s0NFM1Q2psVTRjNHppaStMeDErQ2NUL3Mw?=
 =?utf-8?B?YlB4TU9UUTlyOWV4M1ZMNjBORmNkOUNGS0FRYlhXY2VwcU1icVlLc0pYM3pj?=
 =?utf-8?B?VWIvWTJWeTZpQ2U3eVV2MzdaRlVrNnJTMlN5NlpzK2VPNTh2Zk1IL1RjVGZx?=
 =?utf-8?B?VFJsTUdYRE5keGl1TDFiNUViVHR1Qy9xY1VJYUM1NVlKeElVNXpwa0lpWHB4?=
 =?utf-8?B?YnExWVFoYjc5cXVGN0N3dmNhMmJQUytzREZZdFJFa1F3SmEzRnR4N08vV3NV?=
 =?utf-8?B?YUs5UjFIM2oyVUtwV2ZmSE4wVjB4bjlaMzN5NDhkV2ZHZUdyZ1JZYkxoNDBq?=
 =?utf-8?B?Zk9qTXJJcDVFcEEvMVNRY1JXMDJPMENoS0h0ektDeHRIQ0pFVkdHMGdKZ2Ju?=
 =?utf-8?B?OE9DZWR1cXhHV0t6ay9RcGdqQTNHUEF6TlcxeFc2c3BEOXE2d3Bxd1hJUTE3?=
 =?utf-8?B?SUhqRmJJS29YSzVwWUtYYXZkcklzUXVDSTFFemd5WmpzTm0zOTd2YVlwME83?=
 =?utf-8?B?MmhieFdaaWpIcy9HUTN4ekhjVzNFbkw0czJTdy9JQURDVThGeUUrSzZTaDNK?=
 =?utf-8?B?aXFmd2dwdGNlQlVQbmhQSFBPSkJuSi9QUDNjNUV2RGROcE5lanR3cEVzTXJo?=
 =?utf-8?B?cnU4TmFTanFYalVoQkN4cVFZRHFoVTl4KzZiRmlYbDNwbk9EckduUTgxQjNh?=
 =?utf-8?B?S1JJZU40SFRTVFVNdlREanlqVDZOb21uQzZITFc3SFZjaTRrV051YjkrMUZW?=
 =?utf-8?B?T0VwTFZJOHdHNnRjMTZHZllMcnJTeEhlR1E4NTJFYXk0S3FEOGxuZVlBWHBm?=
 =?utf-8?B?SVZib0dTdW5MTXZUQkd6aW5SbzI1UjJuMnFCaTZNVUhCeTZYMTVRb2N5RTRC?=
 =?utf-8?B?T0dlZ0RpbCtOTXZlNGFkazJCMWUydkV5MnBobVZYZ3l3MVVGMzBJRjJaRzlK?=
 =?utf-8?B?dW1peE1uMVlwd2VTeW1tVDJ1T0dTditWUW1RRkRyWTVIYXl5ZE9hWmErZ0Ri?=
 =?utf-8?B?TExkMGFWTHJycGxvVUFrWVFBMnRQMW4rdm0yNGJodzZ3czY2cjltWS84TzRx?=
 =?utf-8?B?OUFBODhUL1FVRlUwelN2NEN3cHdLU0hVMXBzVnp4N0hzQjBraUY5cFVON2sx?=
 =?utf-8?B?VUJFQi9EQkd5ZWRMM1ZFaW9yMi80THJqRDVJeGFyeDJMTUlVK3U4clQ2QlpP?=
 =?utf-8?B?S2FLZzluOXN3clhNYkg1VUtoUE5zL05ISmc5TUR6R0p1RVB4RGM2WlVYckpR?=
 =?utf-8?B?U1RFclF5Z0tIaWNDc2NwY3F3MkwzZldkbEZiUVlyM1UyMlFZd3pOYnRrMkI5?=
 =?utf-8?B?V2RjdUNtemtnK1lFS242ZEdDeEo4cFdlcC9YbTZOWVgxMTdla24yYmxDZXF1?=
 =?utf-8?B?S21zWEJkSGRMR0N3ZGFyM040OUNXQlNBWXkramcrZjRjNmQybFJreThjcldJ?=
 =?utf-8?B?S1FuMUJRZk45WWtreEtvYzRNYXdzdzcyVUJ4RCtBNGVSTkZlWm1LeDFyS21T?=
 =?utf-8?B?YVNkNFFoV1N1WStqa2g2NFQ1UEtrWnovUytoOG9qc1dmWk4wTDcyVFp6bW13?=
 =?utf-8?B?Y2VRRWl4SnoxcW80Zy8xakZScHZCa2FXbkM0UHdZcTZQMkRHclhlVHAzOHk2?=
 =?utf-8?B?MGx1Uzh0eXNndGIraUF6dTJ0bUNqVVBOVjFzb0pSVDRaczArc245dFo1QnE3?=
 =?utf-8?B?dktDK0lxTXlhQXRRb1l0cTNhdEhhdVBzQUgrNUZFWTA1d3kva1NWZVVMR20v?=
 =?utf-8?B?ckU2aStWUWZPNzFrK0ZaTDFZQU5pLzVLeDdXenZ2WXJ1dEhkMkFDd2FIeEpu?=
 =?utf-8?B?bld6Uk5HTU5IVGFNZVZ0QnJ3dkdGd3hXdEZzMEZwUUdkSWozWW83YXNva3BQ?=
 =?utf-8?B?VFAvQ2kvdzQ4TzJYNDdDczRSd1phN0tXdEdtcU52RW1mZVV3WDRiK1JRYXhL?=
 =?utf-8?B?cjNWTlJhZ0U1SW1zb0JnQW4rRkdQTk1oRmhWQ2ZsVDlIeEJJK1BnYXU1bzBR?=
 =?utf-8?Q?Tx/BGR6kTcSgG5X8KEJGL9o3isnbvMNawLvJObdJj59T?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ld61BKJhzufvJPmhiZ5+AWxWK0fiTcGrXdsfJHzIiEMtQixaizBQoegERaWxV8EsDuuWXXdOVBA83o8yPJG2Ydb0cLKO61DBEDIOXw95Lo0fjI157RtCLoicXRnU5VYT5Kus0GO31J6DSyfoK3V/ZFaF1YNtFmd4ij9ZFH53cZO+EcFs/HOyYl7PSDl3daddfECsGLF24puCvkCSExFQDKIEFZfU39wLFvEs+15p2GFJ1ix9RCbYTPTnodEeMNpOGQnJc9M0uDh0FXkBJDpeWPZzJvSs5H4LHsZsF2G3NDrkjp6mLrMgpeVhVYBfwj78AGY2NSQXcl3IteOTCzM3hiH5MOTrQIzxIwK0wtVEyT58zGa6ekQOuq7sNGyENLjbgmg3GqEKPMXNnDWUjWfsYIzpcsafCr7mp5gaRHoNxJ6J9O0y6ljJU+spJH/dvUYbQjGbTLJwWCkiseXhyO8zilaJP8rCKFC1McUBA5/d5CHQgzl7K0Z2sb3VMd71SHZxcoM02slfxixze0UZzP3lRM6NWzePF+Xb7Qb+Ndk60/aAxwtBU4cf6pi9nm4EqcVfp8SKDQavlXXS+TwMKjz2b8K1B1D0I3oA+rd659KTzEo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 735c46e1-c361-47e3-8bdb-08dd1f27a3c5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 05:48:47.2336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m9qdkSunN/O+lcWoYvopqJXJN6yRkehNLrFf3fpQfYpSdubOnvnswuKltiyKuABcFbK4lr+4lx+1e51t9Uukig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6027
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-18_02,2024-12-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412180045
X-Proofpoint-ORIG-GUID: oYWApyAlBMACjYVKbI43c8xTbCoDdspP
X-Proofpoint-GUID: oYWApyAlBMACjYVKbI43c8xTbCoDdspP



On 18/12/24 08:47, Naohiro Aota wrote:
> On Tue, Dec 17, 2024 at 02:13:11AM +0800, Anand Jain wrote:
>> Introduce the `btrfs_read_policy_to_enum` helper function to simplify the
>> conversion of a string read policy to its corresponding enum value. This
>> reduces duplication and improves code clarity in `btrfs_read_policy_store`.
>> The `btrfs_read_policy_store` function has been refactored to use the new
>> helper.
>>
>> The parameter is copied locally to allow modification, enabling the
>> separation of the method and its value. This prepares for the addition of
>> more functionality in subsequent patches.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/sysfs.c | 46 ++++++++++++++++++++++++++++++++++------------
>>   1 file changed, 34 insertions(+), 12 deletions(-)
>>
>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>> index fd3c49c6c3c5..34903e5bf8d0 100644
>> --- a/fs/btrfs/sysfs.c
>> +++ b/fs/btrfs/sysfs.c
>> @@ -1307,6 +1307,30 @@ BTRFS_ATTR(, temp_fsid, btrfs_temp_fsid_show);
>>   
>>   static const char * const btrfs_read_policy_name[] = { "pid" };
>>   
>> +static int btrfs_read_policy_to_enum(const char *str)
>> +{
>> +	char param[32] = {'\0'};
>> +	int index;
>> +	bool found = false;
>> +
>> +	if (!str || strlen(str) == 0)
>> +		return 0;
>> +
>> +	strcpy(param, str);
> 
> I think "str" is originated from user input. So, using strcpy can cause a
> buffer overflow.

  Oh no. I missed that to check later. Made local changed and updated 
sysfs input validity test-script.


diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 165371a9702c..8faa014c475a 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1337,7 +1337,7 @@ int btrfs_read_policy_to_enum(const char *str, s64 
*value)
         if (!str || strlen(str) == 0)
                 return 0;

-       strcpy(param, str);
+       strncpy(param, str, 31);

  #ifdef CONFIG_BTRFS_EXPERIMENTAL
         /* Separate value from input in policy:value format. */


Thanks!!, Anand

> 
>> +
>> +	for (index = 0; index < BTRFS_NR_READ_POLICY; index++) {
>> +		if (sysfs_streq(param, btrfs_read_policy_name[index])) {
>> +			found = true;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (found)
>> +		return index;
>> +
>> +	return -EINVAL;
> 
> We can replace the logic with sysfs_match_string().
> 
>> +}
>> +
>>   static ssize_t btrfs_read_policy_show(struct kobject *kobj,
>>   				      struct kobj_attribute *a, char *buf)
>>   {
>> @@ -1338,21 +1362,19 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
>>   				       const char *buf, size_t len)
>>   {
>>   	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
>> -	int i;
>> +	int index;
>>   
>> -	for (i = 0; i < BTRFS_NR_READ_POLICY; i++) {
>> -		if (sysfs_streq(buf, btrfs_read_policy_name[i])) {
>> -			if (i != READ_ONCE(fs_devices->read_policy)) {
>> -				WRITE_ONCE(fs_devices->read_policy, i);
>> -				btrfs_info(fs_devices->fs_info,
>> -					   "read policy set to '%s'",
>> -					   btrfs_read_policy_name[i]);
>> -			}
>> -			return len;
>> -		}
>> +	index = btrfs_read_policy_to_enum(buf);
>> +	if (index == -EINVAL)
>> +		return -EINVAL;
>> +
>> +	if (index != READ_ONCE(fs_devices->read_policy)) {
>> +		WRITE_ONCE(fs_devices->read_policy, index);
>> +		btrfs_info(fs_devices->fs_info, "read policy set to '%s'",
>> +			   btrfs_read_policy_name[index]);
>>   	}
>>   
>> -	return -EINVAL;
>> +	return len;
>>   }
>>   BTRFS_ATTR_RW(, read_policy, btrfs_read_policy_show, btrfs_read_policy_store);
>>   
>> -- 
>> 2.47.0


