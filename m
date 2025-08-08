Return-Path: <linux-btrfs+bounces-15924-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D52CFB1E362
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 09:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9F8A17169B
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 07:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D59B24166F;
	Fri,  8 Aug 2025 07:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ApYJ09fP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UyepfPr2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C845421CFFD
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Aug 2025 07:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754637821; cv=fail; b=EvyAZq5mQENIir5EkpPEvZ6pntiOBHHeKx5oPbmoXuAutyfNJFO8FLUQJd9au+dVh+DmHWlgYTy+HGl7MD7cfUDzlF9yB7MRYgW2I2MJVf2P4TTQtHIU7Ex/kRQ8qllozzKrn7omCdL8AAXI7SHQWwtSSgdqAHMzOZHrOQX1zQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754637821; c=relaxed/simple;
	bh=2iVafwBpewqujaBRFXQ1SkPhRzY6yVza8RsqUuTjFx0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GZHeE2Vc0tUGfSXAdLJmoAqr3uSDLVz5SUyw5e5zd8pHLqD1Ad4CCEcG/qlnTKqkysPvwpA0ROhEGrOH/AKs+uMTevFAewyw51wnC84g0l/9JWf3bzLW9prOIU2YHu8ctRGyDUf09v/ytuSzjEWyEglI0SjybwO3FdORBhFEVLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ApYJ09fP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UyepfPr2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5786YMna027871;
	Fri, 8 Aug 2025 07:23:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=WITypLybhQwJkjWiXVextokaC2d+Sq9bwHZ4DTKLkaQ=; b=
	ApYJ09fPwKnSl52VWmttTlHwbuzn9fcGn7j0FNWnJcaNkGYsVb1TQ1ptUeX23BiI
	T2OjUzGSY4Ukr6C4B02D5t+fM3lXnWRHq0Vej98Xc9ylcLprqatQAav926aXwXR3
	qr3qHYYce50qIncgHVIQcfXfi3+VYUbZi2Q7limA5sUgPc4uETeztBiqDn7xNxhT
	wWbn5w0Kqi70QXmYVu2cNP41W8Kt8Ff21TGmtbzqQMUfdKLW/YxEfcU+qazF8RP6
	s0Msqopiw3X2q/ROzeiwp4A/uKNKIIMljVnogT7hzbyfJO2x8gYKVF7EZJaLQqlz
	lKUC9hn65yByBQexmRW+5A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvgwmpx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 07:23:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5786jD9S005682;
	Fri, 8 Aug 2025 07:23:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpx0f0dd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 07:23:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wzQCx85g3QJmlTcQgE4gRYS9BBWDVC3rUzntXQyMNH11lNSDBAP3Fkhy3Sc5RlwIKZ8sAqUImvVYYJSiuTZgPQO0R+H1uTNsjSHY1w8XdXxNBZ7hmPTBxtXYeOclE+tg9GDureW7a06pcZ1H6xxrh6MdbfVQDB5t7ILhDDsBEXl4YczmS+3jWnbDsJuj2GhzAr4seVGkbD5Qk81JawC9P2xk0dQX7yekK7vNbCnP7OCXpOW/NDMUCap9NM1O5tjZs5r3mEqY2Ooauxa4/oAWVQ9Rb9WRNZe6CkLbvlyDhEiqQ35BBJyqTPjgTbRXbsUMTqMCqN3z6ADShtDy9zAV1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WITypLybhQwJkjWiXVextokaC2d+Sq9bwHZ4DTKLkaQ=;
 b=Hh5PybW5gZUYlcgHVShuJMc2NCWB5CKmpQCpnvKO6yMCAu9ZuEggWMY2ExRq58x4C/dsf1mwJjr6tSgyv2iwDWA73nUJQmd038NH1c8nov2bPx7bXd9zmxd4Mu8g22hoCZQLHqApw1BnXcnrxhmqzRpIaP1A1q4xANiRLJTdqudx1yGmHT1oKJr7aQEjSGWq7fflWORD7H+b7Xtq5/a32HDCPYJOnlV3oUH6zYhQCZhB+p5NffqAsbZSOCp84OiXFvcGqsDfqPvpWUHCJLFpmBA+jtM/o8h7CuuBmjWBBl6q2qsAmJEP3ICwen1anMNCp9JdCN5ejWukm/qiZ9jjXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WITypLybhQwJkjWiXVextokaC2d+Sq9bwHZ4DTKLkaQ=;
 b=UyepfPr2pMLyjokk89jF5+wblqOSXWDRUfz0IK9eoDd9kAjU98IPf2K7iXvyDDufvQqyL2owaAjI6Nb9hCcVhISBjXK6gWOZPNXfHN2nDe+foJ1OJ9rrLe8WxCfFqZe9H6Ek9iI6RFdeDRZwBzy/EyxevhM15BXhgxvYwKbqjqc=
Received: from IA1PR10MB6075.namprd10.prod.outlook.com (2603:10b6:208:3ad::18)
 by SA2PR10MB4683.namprd10.prod.outlook.com (2603:10b6:806:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 07:23:32 +0000
Received: from IA1PR10MB6075.namprd10.prod.outlook.com
 ([fe80::565:8dcf:2d10:bedf]) by IA1PR10MB6075.namprd10.prod.outlook.com
 ([fe80::565:8dcf:2d10:bedf%6]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 07:23:30 +0000
Message-ID: <4c815239-7b65-4460-a27f-4b48b7244c71@oracle.com>
Date: Fri, 8 Aug 2025 12:53:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] btrfs-progs: add error handling for
 device_get_partition_size()
Content-Language: en-GB
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1754455239.git.wqu@suse.com>
 <aaefe04f784bc601f355d13b3b0ecbde1aa44dee.1754455239.git.wqu@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <aaefe04f784bc601f355d13b3b0ecbde1aa44dee.1754455239.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::18) To IA1PR10MB6075.namprd10.prod.outlook.com
 (2603:10b6:208:3ad::18)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB6075:EE_|SA2PR10MB4683:EE_
X-MS-Office365-Filtering-Correlation-Id: d17a23ae-6fba-4e5d-b48c-08ddd64c79c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHhoaGhOSzdPVmxJUUtKMTBQeUl1Y1FRTUh5cjlhSnJTMURzOHEzRWdDUUFT?=
 =?utf-8?B?UGZ4blVhLzNwZ2Mra0trK0VxdkljbWNRUUdoWjN5U2lyMUJ6L010SXVkU3hX?=
 =?utf-8?B?eGplL3R4NGxTVVN3Yk4wYlRndUJ6ODIrWER6a0FLd0k5YzNvelJ2Ni9PbDgv?=
 =?utf-8?B?K0h4YUNHOXFEOFRNcnVESHJoSEhpNHB5OVkya0dmS29wREZRclB6MklRQWxR?=
 =?utf-8?B?dUVYZ2lvRHFwY1dNRDc4Tk00RzlBdEduMFN2WXd6RE81M1RFM3dZTlRXVzdE?=
 =?utf-8?B?ak1POXB0V0czSzZaS2w5bkQwMkJIUURWWEdIckZZSFBWdDRKZ2JhalQrcnRS?=
 =?utf-8?B?VWsvS2FjKzI1OGNxRUpqSFlyR3FEY05FWUx2NjhnUDNNZlBwSEh0NFBSbHNY?=
 =?utf-8?B?d0ZNL050enhyeEdtNkFoZHdkblVRQkVBYXg5NWwvUXZxTXBTc1BHR0YyMmpk?=
 =?utf-8?B?anFmU1pDWUhSWWlSK3lidzExNUNuZDBuTlorTzlmOXp0WlQ5WlVwVEtqNUJK?=
 =?utf-8?B?NUhSdTdZaTJQNDBHd2tCZkVZSjRMdzBTRWVGcDBvVHg1TmRoTUROaWoyM3FN?=
 =?utf-8?B?eFc1WGVTNEJpT3VETm1kcjVOQmRaY3F3aGFMT3VQNWhVbzJNbEdVNGZVY1cw?=
 =?utf-8?B?M3lKQnMwS1o1V0E3c0tBSHMxS1pvMGo0SFpyeWdxR1R6SG9kcVlKdE5WV0Vl?=
 =?utf-8?B?YjYvdkRGazBlZU1CNndVY3dsSm5yb2Z2dGcwR0ZoWG9jT1RZdS94eUphZWlh?=
 =?utf-8?B?QUpsMlVUdGNtdEMrQmpGbW9qeXcvaU9rb3dNY1lvdFh0K201ZVN0T0xrNnZD?=
 =?utf-8?B?c2JlYlVwR0dKTVF0RGg1cXBKRW9DbHlzMXQ1ajh1b09DQkNzdFdtckNNTDZJ?=
 =?utf-8?B?YloyR3U4ZWZ6UFFMOEVHRWdRVnFWNHpLRkRTb1dRQWU5Wk96cS9UeW1xOUV1?=
 =?utf-8?B?NlVFSXJPMjVLT1l5bzdSOEFkTDZEUWk5SG9qQ3NMZGtzVDI2dmtmZkQ5VVhL?=
 =?utf-8?B?SjY2Y0Rhd3JpU0djaTFKUE1YRE5sSzhSZU1hSGlnUG9RU2I4eXZYc05UeStx?=
 =?utf-8?B?VHEyVnBobDk5RExZZTJjM2czamYySTRlKzFCRkJ0dy9lNFlJRVJoNFcyUWJi?=
 =?utf-8?B?dmhYOTVlclRyOVZFandsUjVoTzJzWXVOL0Q0Zk81UjN3NVNXTTZwNVpWd3Z6?=
 =?utf-8?B?dE5XOGtnR2w1cHIzSVhiWE5mM0JDNVpBQVBWWWNIdWs3U2dTaVFjMTlKemJn?=
 =?utf-8?B?TDlKTko3U01Oa3N6YUVicWtzN0diMG5xWU9vcEpra0NtWWRNZE9IWldDZUsy?=
 =?utf-8?B?dUtndFE5RkRzNGRYU2Z3d3J4NmkzTmlIQkpOVHJhRG8rRzhYTmkyS1lXSjVR?=
 =?utf-8?B?Y0hBbjVxOWhYOHhsa016ZVIyMHMzZ3k4Vkw0TDJuUVR4ZjRmNVNFbFVCbVRZ?=
 =?utf-8?B?VGdCaGEwcWxVVWY2cC9JR044ZS9vS2F0WDJIYjVvTktXY0J1cGRaTFJUSkFv?=
 =?utf-8?B?bER0OVNLNWJoVWIzdS9CT0FtcE5GVndZVlpWM1RjSjNiQ0k5K3dkeU1Mc241?=
 =?utf-8?B?bnd4VHM0cDlxY2J6V0ZkbjVvRU83L2NNcFBYVExWa2NNcnRSdklZbmtFSDJa?=
 =?utf-8?B?Tit6QlV3RE5uQUtlTTZvTTRaZ3o3ejVRZ3FkRjFSZGZTNnRpVExaMXpjc1o1?=
 =?utf-8?B?RWRXUU1BMlk5U3l0Y21WNzI2Zm9kWHZiQ0puL0Y4U0RKc3pCN3dmTkswcnBu?=
 =?utf-8?B?bnd0R2dPWGRUblB2YzFLbkxodk5jczQ2T0dTblFrUVJQT3lWZnpmVFp4UWNL?=
 =?utf-8?B?NjBjWXlVNG1Jd0o5NjdNc0psYlAvb0NOU2tYbGtoUzRrQVBUREpTS1dIemlh?=
 =?utf-8?B?QWVUc21LbGdVdWVvaVI2NFFEZ1ZXeXdoQ2w5UTFFdUUxVTJ0ZHFhM1JRazlF?=
 =?utf-8?Q?pafVG0uEWfg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB6075.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUNzRWk2OGQydlRjUWZHQncwSHdCVmVZT0dhUmFmM3lvLzIvTjJEQmFOWmkw?=
 =?utf-8?B?YWplazRkT0RpSDdqQ3Z6YUR6S0lqdmd5L3dxT1dpWkFieXFkSmlIZ0h3dWtI?=
 =?utf-8?B?NngxUFlJUnl1d2JjcVMyMmI0dkN2dEVYa1plTkszS3BaaFlsTzJRSTkwZUkw?=
 =?utf-8?B?Rm81WGIrR0dNcFErT0lLdlAwd1V4dUN2Z0tsbHMrSllyU25RNXBCUU1kOVY1?=
 =?utf-8?B?WHRZQ2xuZDJUNVFURzhPUjJBRWs3a0tVaGlhUnJlWkcvRW1UK1JSSjhFV2s1?=
 =?utf-8?B?TkFHMWJkd2JTVjJVMzVqcVk3QVRzbDFVN01la3k1MUJnbGZJSTFtSjBtNXhT?=
 =?utf-8?B?SzFtUDV4ZjNxWjB3WHlrSUhwajI0NXlPVUJQZnZyRlIwaFE1TEZWak9uKzlK?=
 =?utf-8?B?bjFRenpsamJROU5CM2hkUGpZNWhya3NtMXowQXRCcE1iazdkRjlIQUgwZGhT?=
 =?utf-8?B?ZWVBWDJDb3IzZVBoWXNxSGlMbDlOMERzRjc0S05oWmlwUndZQ3BBbnpYNnpy?=
 =?utf-8?B?aTZ6OTRhT2tvNWEvK0pVTW16Z2F3T1MvTzlJZ2ZHUDNlS2VEd1E1QXM5Y2Vn?=
 =?utf-8?B?VTBuS1RKUkptd2VndzUyZ21UaXR6YWR0eTdtSGEyL0tUeGxET005QzlMcnk5?=
 =?utf-8?B?dlVUUEZjWndOekNMYmM0Y292dzF0aEtHeDlQaHBoYUNiTHVXUDc0c2p1T3RD?=
 =?utf-8?B?dCtXVndsY2V6TWVJcDlPdlFXZHlOSkVWcVU5YlFsZDBhRTBwZ2FjNjJXQTVS?=
 =?utf-8?B?S3NqdXlnTVFXdnozQ00rdTIwTjZHNUE1dmtYeFNNWWZSL0FHMFUyb0VwN1g4?=
 =?utf-8?B?VzY5TkFmYVVlN1hPdllZbklaWFA0ZUF4SHBaUjZQbkQ4YlR3Lzd2OUZEYWhB?=
 =?utf-8?B?SGNHU1pMa2VQV2ZKRmIya21yT3U3b2NBQW9wTjZ5OUF2dEtsSHJqbCt5cEJy?=
 =?utf-8?B?RGlwODJTVllHeWt3SUlhVjlxTnhqcjBISHQvc0d3T2FpdWtTRjVRelRWbTd5?=
 =?utf-8?B?YmpvNVNKV1lIb1BwOHlZTUJwTXVneG5RQ1FFY2FZeDMzZTM4QUg4QWoxS0tZ?=
 =?utf-8?B?SmllL2lIRHJvTTVieWEzZzFGc1dJc3haaGwxVmJPQUR0UzlacVVJdkJybG1P?=
 =?utf-8?B?RXE2MmpBdExuS3hYWTh1eHVseTFqVDFURlJ4eHhRaXlWMmg5bjB6MXE0NHZM?=
 =?utf-8?B?d0VhcEd2cXRWMXoyMjhVUUhWbVEzeThnL0twLzlrMStIUkttS0lXN0FOM0t1?=
 =?utf-8?B?Sk5yd0l5ZTIwVlVxYVUreThnQkhSdC9RQ2xxbCt5OXQzVzJTZFU3N1JDQSsz?=
 =?utf-8?B?VU5ZaWlnaS9UcFJrSzNLUEN5QlY4dzJlSWFyUjhhQlIyTEdjZ0FzS25KTGF0?=
 =?utf-8?B?aVFNckloTEhOeDI5bkZzVlhuNG0wWEgrUDA5aFBHMlAwc1lZbTdSUE5zUThU?=
 =?utf-8?B?M1d2MlNGU3o2K3NLdUl0a3FDRk5oc0RkNTY3Q1BWS3hCTlh3NXY4UENEYkxH?=
 =?utf-8?B?MHYxenl3bTd0OWVmMXNyc2tONUdOYXZTWHBSTmoyZmdJc2sva3hvS2RFL05l?=
 =?utf-8?B?WnJ4dWVxU0h3RFZydzA5eGwrSFpBd0k1YnFRdHRmbkl6cUlMQlRObmhadVVQ?=
 =?utf-8?B?enhYTTRKWForNmFTbW4xeStwOEZ1WElNWFlRbExCK1REbDNwRGpMMlgrZHpS?=
 =?utf-8?B?cHlvM0JjeTR6cmJTb3NhSkpKbkJ1eU5PNW9uVXU5SUpXaEhuKzQxbEk5bG5T?=
 =?utf-8?B?VHZKV3B1cDlSbGhWY2RvalJrd3JKQUcwQ1RRYkpYd3dybXRBSmFqUVFEaWNB?=
 =?utf-8?B?blIyTHdkVWxRY3ZGZ09CR1E5MTV3c29UdEtWNzkzeWRJWEZyYUJscjVOeGc4?=
 =?utf-8?B?d0RKQUZnSVdRSDg3NHYrVngvYXllUUhVcnNZS08yYXZzT2RibXhTdjVBaWpi?=
 =?utf-8?B?Nkg4enQ2Y0NKM2x2Q1dEZFQzTWJSVnY1Qm9iTlNtbTQ3TjAvdjczaXh2bHJr?=
 =?utf-8?B?Q2RpS2drQlpLQlVTRDdRc2VFd0ZDZTR6bWVCbVRKeS9DV251NHlmZXJUaXpV?=
 =?utf-8?B?ZHN1M1VRdHpLMTFjQ0VMY1pxcVptMTcrcXU0bEVUaDh3UGVtQVk1TDBiTE1H?=
 =?utf-8?B?eFZvZFJlSytJeEQzNTFtaHY5cEdJSDZoU3dLbWMxK2hzRVVici9SNGdTQ3ha?=
 =?utf-8?Q?NpXNAmfyN5MbyrcmqKHGXoe+ybIb6Plxq2r9rryL4Ofi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0cttbNRVCB4P1zvnfUzD48dYNG0egtemKew43ZK3xTpvLl7Fkisq6yfYg0h6njSDLqIi9kmoyVh534Ub5SWVhgEJqBXn40mZKgazhLhuH42pMUPPoxQRPxbDohjMN9Rx5paYRHX2kr+oJRSR5J/IwAa2q0id2+a068oelXj2zypMvfuMWe45zpfgrH1MNBMjhTnAm0/uT6t1mPfGpMw2zvllCr7gUv7EpvI4bb9YthVkcCWgqTstE+A8eLV+v8nbDUhoZ4UXBNuAYJyI1CDNFuLrCI0uuHnsZ0BGNsOEn7heKbAEEDRUGVK8bWZzZ+7BUY5IL+IAHwo5CupJ+JmBQXUpnMxewBLQDxJ3CSt41f85OKIOk5AQKE3G3dI0NOzuOAQUat409gt0FoXA6A20QiYN7LOGwM3W2ozjTv99cwYYKfIp9/LiKV2RcMRjA3e+W/yR5IUVw9uBn1sRzYAFcxPkqTKsYnTIOSpKHU3UgoaxOR7Q25gBfshwEOfK3sFZCRhl1KjR9wo5ByZ24XAiy4HiI3KrsmSZEdV1VvyzbVQL2kMaeqz5EoCF9/kZRwwDvaGIrx3/zB33pDbQpTKjYionaMmwHwe7/mC4Ld+O3WU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d17a23ae-6fba-4e5d-b48c-08ddd64c79c5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB6075.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 07:23:30.6933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3jcj5ul3OGGza1GJNZaLrXt84bXJ+cW9Da6A97o+RFyU94rzdfDm01guQH8EjfAMr9J71zj3BS+Kbm6GM1JuRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4683
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508080060
X-Authority-Analysis: v=2.4 cv=WMp/XmsR c=1 sm=1 tr=0 ts=6895a5f8 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=iox4zFpeAAAA:8 a=juPDNM__xKMhu4EsSY8A:9
 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22 cc=ntf awl=host:12069
X-Proofpoint-GUID: u_MZ0JZfJyrYJH5KOBHsaBq7cXqvSfFL
X-Proofpoint-ORIG-GUID: u_MZ0JZfJyrYJH5KOBHsaBq7cXqvSfFL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA1OSBTYWx0ZWRfX1EtqQVd/BGTV
 HrqwZv2cEAixowAz56fa7RcOFe8xcZrf/JfWOAbwXtRolAoFVmrbIjfl0VuxYXS2LWjo61lwjGr
 NGMlBTff5FgoSiJCl0cJVpV4dnlbI/a2kKv2QWqoMzc2UpkIsjJWi51GLWDEY2ZaZAl3rdV/anA
 pDc0ipPX0crqLvrG506DbSL9lNqda+J9J2uQwEv/yWFyo0bPil69C2eteudwsz9VvAfsffOqakP
 clNuUa+4iM/sh/ZRixUYwvE+z/xlaOzle8Z+39KqHwekBGi3yUKdGi6BeaJvTdrx01xQ+3LGYfN
 /xA1uC5ogbe44UAy3FOJN+7zPL30USgSP+iO7n/hWlQBJaGiSvWSJsXX8arYeyV4O3Ai4QfAGX3
 POwuXF8MykjCsjF6YMARLEkSgR7zeWxMxD/goiuObFq5/EcJdJEzVmOXkEVBqwMR+3c13o4k

On 6/8/25 12:48, Qu Wenruo wrote:
> The function device_get_partition_size() has all kinds of error paths,
> but it has no way to return error other than returning 0.
> 
> This is not helpful for end users to know what's going wrong.
> 


> Change that function to return s64, as even the kernel won't return a
> block size larger than LLONG_MAX.
> Thus we're safe to use the minus range of s64 to indicate an error.

Returning s64 is almost unused in btrfs-progs; Either PTR_ERR() or
int return + arg parameter * u64; Rest looks good.

Thanks, Anand

> The only exception is load_device_info() which will only give a warning
> and continue.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   cmds/filesystem-usage.c | 13 +++++++++++--
>   cmds/replace.c          | 14 ++++++++++++--
>   common/device-utils.c   | 34 ++++++++++++++++------------------
>   common/device-utils.h   |  2 +-
>   4 files changed, 40 insertions(+), 23 deletions(-)
> 
> diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
> index f812af13482e..755f540ac0bf 100644
> --- a/cmds/filesystem-usage.c
> +++ b/cmds/filesystem-usage.c
> @@ -819,9 +819,18 @@ static int load_device_info(int fd, struct array *devinfos)
>   		if (!dev_info.path[0]) {
>   			strcpy(info->path, "missing");
>   		} else {
> +			s64 dev_size;
> +
>   			strcpy(info->path, (char *)dev_info.path);
> -			info->device_size =
> -				device_get_partition_size((const char *)dev_info.path);
> +			dev_size = device_get_partition_size((const char *)dev_info.path);
> +			if (dev_size < 0) {
> +				errno = -dev_size;
> +				warning("failed to get device size for %s: %m",
> +					dev_info.path);
> +				info->device_size = 0;
> +			} else {
> +				info->device_size = dev_size;
> +			}
>   		}
>   		info->size = dev_info.total_bytes;
>   		ndevs++;
> diff --git a/cmds/replace.c b/cmds/replace.c
> index 887c3251a725..bb8f81979389 100644
> --- a/cmds/replace.c
> +++ b/cmds/replace.c
> @@ -136,8 +136,8 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
>   	bool force_using_targetdev = false;
>   	u64 dstdev_block_count;
>   	bool do_not_background = false;
> -	u64 srcdev_size;
> -	u64 dstdev_size;
> +	s64 srcdev_size;
> +	s64 dstdev_size;
>   	bool enqueue = false;
>   	bool discard = true;
>   
> @@ -270,6 +270,11 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
>   			     BTRFS_DEVICE_PATH_NAME_MAX + 1);
>   		start_args.start.srcdevid = 0;
>   		srcdev_size = device_get_partition_size(srcdev);
> +		if (srcdev_size < 0) {
> +			errno = -srcdev_size;
> +			error("failed to get device size for %s: %m", srcdev);
> +			goto leave_with_error;
> +		}
>   	} else {
>   		error("source device must be a block device or a devid");
>   		goto leave_with_error;
> @@ -280,6 +285,11 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
>   		goto leave_with_error;
>   
>   	dstdev_size = device_get_partition_size(dstdev);
> +	if (dstdev_size < 0) {
> +		errno = -dstdev_size;
> +		error("failed to get device size for %s: %m", dstdev);
> +		goto leave_with_error;
> +	}
>   	if (srcdev_size > dstdev_size) {
>   		error("target device smaller than source device (required %llu bytes)",
>   			srcdev_size);
> diff --git a/common/device-utils.c b/common/device-utils.c
> index b32bd2cec1f1..8b545d171b18 100644
> --- a/common/device-utils.c
> +++ b/common/device-utils.c
> @@ -329,7 +329,7 @@ u64 device_get_partition_size_fd_stat(int fd, const struct stat *st)
>   	return 0;
>   }
>   
> -static u64 device_get_partition_size_sysfs(const char *dev)
> +static s64 device_get_partition_size_sysfs(const char *dev)
>   {
>   	int ret;
>   	char path[PATH_MAX] = {};
> @@ -341,33 +341,30 @@ static u64 device_get_partition_size_sysfs(const char *dev)
>   
>   	name = realpath(dev, path);
>   	if (!name)
> -		return 0;
> +		return -errno;
>   	name = path_basename(path);
>   
>   	ret = path_cat3_out(sysfs, "/sys/class/block", name, "size");
>   	if (ret < 0)
> -		return 0;
> +		return ret;
>   	sysfd = open(sysfs, O_RDONLY);
>   	if (sysfd < 0)
> -		return 0;
> +		return -errno;
>   	ret = sysfs_read_file(sysfd, sizebuf, sizeof(sizebuf));
> -	if (ret < 0) {
> -		close(sysfd);
> -		return 0;
> -	}
> +	close(sysfd);
> +	if (ret < 0)
> +		return ret;
>   	errno = 0;
>   	size = strtoull(sizebuf, NULL, 10);
> -	if (size == ULLONG_MAX && errno == ERANGE) {
> -		close(sysfd);
> -		return 0;
> -	}
> -	close(sysfd);
> -
> -	/* <device>/size value is in sector (512B) unit. */
> +	if (size == ULLONG_MAX && errno == ERANGE)
> +		return -ERANGE;
> +	/* Extra overflow check. */
> +	if (size > LLONG_MAX >> SECTOR_SHIFT)
> +		return -ERANGE;
>   	return size << SECTOR_SHIFT;
>   }
>   
> -u64 device_get_partition_size(const char *dev)
> +s64 device_get_partition_size(const char *dev)
>   {
>   	u64 result;
>   	int fd = open(dev, O_RDONLY);
> @@ -377,10 +374,11 @@ u64 device_get_partition_size(const char *dev)
>   
>   	if (ioctl(fd, BLKGETSIZE64, &result) < 0) {
>   		close(fd);
> -		return 0;
> +		return -errno;
>   	}
>   	close(fd);
> -
> +	if (result > LLONG_MAX)
> +		return -ERANGE;
>   	return result;
>   }
>   
> diff --git a/common/device-utils.h b/common/device-utils.h
> index 82e6ba547585..2ada057adcd3 100644
> --- a/common/device-utils.h
> +++ b/common/device-utils.h
> @@ -42,7 +42,7 @@ enum {
>    */
>   int device_discard_blocks(int fd, u64 start, u64 len);
>   int device_zero_blocks(int fd, off_t start, size_t len, const bool direct);
> -u64 device_get_partition_size(const char *dev);
> +s64 device_get_partition_size(const char *dev);
>   u64 device_get_partition_size_fd_stat(int fd, const struct stat *st);
>   int device_get_queue_param(const char *file, const char *param, char *buf, size_t len);
>   u64 device_get_zone_unusable(int fd, u64 flags);


