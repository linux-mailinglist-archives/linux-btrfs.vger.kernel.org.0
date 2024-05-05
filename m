Return-Path: <linux-btrfs+bounces-4745-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0958BBEF5
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 May 2024 02:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06228B2125F
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 May 2024 00:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A14FEBE;
	Sun,  5 May 2024 00:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ctYg60cB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zH8jqCOu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3627EF
	for <linux-btrfs@vger.kernel.org>; Sun,  5 May 2024 00:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714870603; cv=fail; b=Y4LlrqYPKH2OjIDu42HPAsbGp9OePO2mtDGQgL8zmws8J1gwiuYulTE+aEIvXYp2Son0leIK14C2BGVJlLwsZeF62ktdu6o1X1Cwjhdmtx/r3bJE/lbNhXaMtgEfoXOcmNh9Geh99ZF41g++2TYAzr5yc2ZHJ+8GrU30Gs9Kymw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714870603; c=relaxed/simple;
	bh=q0dvFHgSdiKRVVmH3s9n4sUU8CphPLV4SBtHS+ce59M=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QvmDV7UFlTryWwHISimuHJT/+yLO51742OX57r3/toSK3hqPuCptzF6Y90r8cjnIAMCE55IoKK5Wo3uw+t/UoXS5wiPBFrWjjUqA000zcNhzuXC2GRTB/8yZyBOb+aKPjp5T+Feg5AMoy2X6tmsZwNZvsLeZS3hJAtCPUv6mcFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ctYg60cB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zH8jqCOu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 444MTX7F025284;
	Sun, 5 May 2024 00:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=eCrUpOGmvnfYGQQpqnR+XfO75DBV2xZ/CHbUA8QQrTs=;
 b=ctYg60cBkpIVir1XttjlsqCK03sCLw8DazZAPfgEF943fGmMPkjMb5e2jCp7KFzGPpAt
 UjR349c3e/QwIpY1yhZrpLD+wSBMd+IXUaBF3dGrOQ444VQT0kk40HEzX43In9ktgb2y
 zwn7TQyY5iqVi411h1ORoJ+aFd9FiOTSIwweUuFcTFxvyzIl2hPRNpdi1iCVcyW8sA4K
 2ATR5tL5+BSlxoAzaPbPksaEkWjEEVc6CpaTVhEy4TN8ofWjcEUtEdOv6wSAoURyY3nZ
 diO5feCxUEomUwWpE4TqLm8EeCbSEkx0hsQ9SZhd31w8r0OUA8agijD8OgJhAVBo9qMf Dg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbeerr3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 05 May 2024 00:56:33 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 444Md4J8006924;
	Sun, 5 May 2024 00:56:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf5bktg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 05 May 2024 00:56:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYYTUKSqneFT9SOsOCTl7YclLHX6i0hr2Im29y7MXSUKaCWkVK1cwaU7bvAYixphthvHJkSsFu6hpuOUGuvR8FU47sbz8Ity6GqqkZZlrv7a6Deu6CTzYOY1xTCvuiSKToQSetWwYiqzFPopyQhXOucfCx1vtbkhaiIOMBfUKxX/vnm3/QpYflyVqo2ktAv1YMB2pQ42hpqxTbhXpZxqKz9iqfY+fI1f5W2zPIF3r46WkGlJvrQJu51WYh63EGhO5e76q4bikgvx+8ItsiLfL+T/Yi/PJh4ZIFDL5RjH4OlY+txpYR9kNpdJ3fYDDGr9LvqfksICDnUwLqwb2z7ZZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCrUpOGmvnfYGQQpqnR+XfO75DBV2xZ/CHbUA8QQrTs=;
 b=MBQAJe2xdcju6NbbfgAdWOynEDsjh2/j4vcd5O7heSeo0VydQmzpy5n3y0i3Sssa94v4ohRwOujhTqEM8ulOKvqhM6JYo7IM/cbOO+ymxCcMUI/cydd20T+cObqiSLxuZsfX34O0S40C6fUI/b4QxIK55c1/rUrwhkjdRpm1HUHfHaR+cepeBj+h3thGPiaxlJwkEf6OV1Oi5uQkg8hGPY8ufIY526f9ucTWx7IugNkeq7HMhdkTqnlOGLu9MtUUQp6BLr+oMMbwD9lO1Nbq/nn2KIaTQCy9uLC592RdRkWPj5zu8brOTXZ+cQ8lMo78ezUmEJa+Zd+NEt16Qk1JGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCrUpOGmvnfYGQQpqnR+XfO75DBV2xZ/CHbUA8QQrTs=;
 b=zH8jqCOusin7Yn9QXUXo8sIBKhQNEyIGQRGgxLnvM4yUB/i+F0nnB3UvLuJB5JTrpGiVyb+C9z9E7g5bzQZEXe5+SiSSfMvZlHDfNzHGjh+iSAxTxCJcQawAFPH90n6ByKg9Mb3j5JX8CXMAITITPdNh1q/EC/hQ5rtd7hVrovg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB6737.namprd10.prod.outlook.com (2603:10b6:610:146::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Sun, 5 May
 2024 00:56:30 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.7544.036; Sun, 5 May 2024
 00:56:29 +0000
Message-ID: <0fbad9f2-6f26-4fcb-ac8e-a1fa4ebc80db@oracle.com>
Date: Sun, 5 May 2024 08:56:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs-convert on 24Gb image corrupts files.
To: jordan.j@mail.bg, linux-btrfs@vger.kernel.org
References: <d34c7d77a7f00c93bea6a4d6e83c7caf.mailbg@mail.bg>
Content-Language: en-GB
From: Anand Jain <anand.jain@oracle.com>
Autocrypt: addr=anand.jain@oracle.com; keydata=
 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
 y4F0QrzFk5Hg4pvnpDur6Cbp
In-Reply-To: <d34c7d77a7f00c93bea6a4d6e83c7caf.mailbg@mail.bg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0191.apcprd06.prod.outlook.com (2603:1096:4:1::23)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB6737:EE_
X-MS-Office365-Filtering-Correlation-Id: c9cfc6a3-a5c6-409c-1c90-08dc6c9e3311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WDNJRXVrY1ZJODBmM1owMUVyb25IUG5ITllqL1IwR1VJQVZGSDBJL2FNbmdR?=
 =?utf-8?B?TkRTU2NiV2lPR2h6bDB0N082Mjc0ZFBZK2RnQmYydmxWSGhPaGdjT05BNU8w?=
 =?utf-8?B?WmZObXJCTFZuWjIzMUJTUXRUb3RXSVp2MWRrakpPNDNDUVhvQ1I5WXFrRkZY?=
 =?utf-8?B?dHFIbkxkSS93YjROeEd2ZTlvMkM1UVAxc1ZjVzczdmNoS0RROXhkMVpIeldM?=
 =?utf-8?B?aWFVZGFEeWNpYTBjVzVZWTdTYmZTaVBJbm43RStrR3ErcmwzSTFkN3FPU3Yy?=
 =?utf-8?B?WkYvRmk5dmE1OHlGeVM5QjBqYUxXUU1zKzBVWU14WWVGemdXdllvU25zUmM4?=
 =?utf-8?B?bzlNN0cycEJDbVFueHdyY29vK0xhL1o2QnBXb2diRUNRUHdEU2VUVTcwcmNj?=
 =?utf-8?B?UkprditaWkRCNSswV0VGLzZCR253TkFrY2xWM1hCT3V3S2JGREJYdEtKeVB4?=
 =?utf-8?B?dHdnQk9XRVI2c2JSWXplVFlLOEJMaEF0bDYrUlNxMUc4YmU1VlhTejg1YkIw?=
 =?utf-8?B?N2d0N1lHb1c2eGl0REdaRWJONm5wWFM5eHNreUlhVklmWGVWMS9uTUFMMFNE?=
 =?utf-8?B?d3NTTmswQlBUWkY5blpSaTcxd00rTlhsV094YU9kMnEvQlhNbTZLMXBTVzRG?=
 =?utf-8?B?REZMZDZoOG0wVTBhSTlLQWRkbzgyTmpHR1FIWDAyT1JHRzVvQWFKK244ejBD?=
 =?utf-8?B?ZFhDOThyRUNZOWVTNFlwR1F2NVNlYkwycGd2dFk4YkJTVldtMlc4MmJzMW1m?=
 =?utf-8?B?MUVrdXQxeVRITXR3eDdrcXhuNWV0RXdPZmtUenAzLzJHbkViVUFuak5mbnBX?=
 =?utf-8?B?T1h5VzJYb0NuTTYyRGliVmdidis3b0RlZW02Q0c2QWZNanYreDdKZGE1QUZt?=
 =?utf-8?B?bFk1MWlWb2dILzZVdTdXMk42Y0NGblZPK0tNYlVjMGxKSjFvN1gxUVd6UmZi?=
 =?utf-8?B?dU8zbU40ZVFhNmtBVW9rMi84Z0drQ2QrSms5UmpDQTNNdEpMYnRqYTZ5RWc3?=
 =?utf-8?B?RDJWcmpnQ09xOVF5NXZLYUoxcFAwTmtHVkV3NFFDNHV6bDZ1aEZtaElXVEVa?=
 =?utf-8?B?NEVpKzRvUCtVMUhpWUlDTW1LelB5MC9TeFYzS2IybDBJWmN1UXV4Slp0WU1a?=
 =?utf-8?B?VVMrdU11SWxUVkFzVGpFdlhYWjVtVld1ajIzTjAvUE1mZGNsQmVmZVR3R0g0?=
 =?utf-8?B?MjVpcWVYQUluMEE4RXA0aVZIMkZqQmlQVGNWT0tvQktvU1l5L0grUklPSk41?=
 =?utf-8?B?c3Z1RlB5SUVuWUdicFNNdU1FRVI3SWNYcmdQOVlOVFp5RS9FU3k5NDdWRVZX?=
 =?utf-8?B?cjluUW94dVlkejM1bUExTy9qcVRIUkdFNUMrdW03QUlRYVhpV0ZMWGRsWVVS?=
 =?utf-8?B?MEw0VHM3THpIUllRSHBieUY1TVZhcmlsdG9vRzhiMDkwWEY2NW1RUGlSZmdL?=
 =?utf-8?B?dWlQVW9FbnczaUZMbVl3YTNBNlhjY1Y3ejg3b3dHZ2RBeVNMNXdURmNsWG1C?=
 =?utf-8?B?eE9CaTJMOWRINTZHeWhFS2wyM3d6VW5hUTFKVjVFVlVXZ1gzSEdScTY4WWxo?=
 =?utf-8?B?YXUySEhJZVJUNzVCVWgyQjk4RGV2WnpaSGV5UTJ3QS83bEhHK1Z3YnN0aGFX?=
 =?utf-8?B?UExIZGlEYnBSYUVmdU9vbzhGdWN2Rk5sbVFMN1hOZUxrVStuL3RxbnNQSEw4?=
 =?utf-8?B?eFhGWmY2UEw4Qm9JZEYrRGdmNU1PWXd1YkVLQmphUmtvMDYxN1FzOVpnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NlU1UGRHa0JaZnI3d0VMWlIxNXlQendUMGpHbGpXRlducHBuWDVXUzVjeXNH?=
 =?utf-8?B?SXlQbStuejdPRXEyRUk4aGhvM1N6YTljU3RQUng5dUhZQVhXNTBqT2lQNlVQ?=
 =?utf-8?B?NnJVUkpFMTFFUDJhMmdNcS9MdHNmUncrSnlrUHlzTGYvSm51M1VDSGpNREtV?=
 =?utf-8?B?RzQrNmplbGxudUszemhob09mOVh4VnhLaUtKaVdtcHdLN2VFOW1Qb2Z3a1Vv?=
 =?utf-8?B?ajg1MHlYTXd6YlZYWVdPQWdad3pwOWpNWFF6UHlZZE8vTEltMHNqMnBLQkhM?=
 =?utf-8?B?bUFqeERvdUtBVDFrTmNKY0hqUjc2Z2IxdWRLd1hUQncwODdSQk03RVV6SEty?=
 =?utf-8?B?TzhYSlRqZThkZld6dnBXZ0o5dU44MHlGS3YweTM0T0ZFZzc4Z2xRY0ZrOUxa?=
 =?utf-8?B?M3c5aEhXQklmQzF3ajZOMlFRQkpvUWFtcmVxL2k0VWJ6QVNmbVV1QWJ4b2NI?=
 =?utf-8?B?YUlYOFh5bUE1Rmt3cksxZDBpa1VSVTdtMEtuSW45OWtnOHNRWGlmYk1weGs4?=
 =?utf-8?B?bnZHMUVDamZlVVI4eDlCSGg5ZmxDdlJBdkhPMkpMMktKVEp6dU1YZ29CNlBL?=
 =?utf-8?B?L0hwbkx4c3FBbFRpVmpEZXpoN1ZrbzJtT3FrTEtKNCtuUyt2Nmc5Wm5RRnZs?=
 =?utf-8?B?VmkwR1lZd2Y2Q29QRnJjazZRd25Qa1QrWDEwbVg0cFZUK0dhc1pLMVo0VFRD?=
 =?utf-8?B?anpuTkNmUXM5MzlFVER4V3RJZ0FwSEpUSHRqZkpSQURVMnNMMkttcDNyZmdm?=
 =?utf-8?B?QlNvTmxtdjJNUEcwZWl1eTg0OURqN21rSUtGZ2RLRjVqLzBjVEwzQlVxU1pa?=
 =?utf-8?B?cEF0ZE9tZnVsQk1mUHVnTFQybDliU0RJSlNnQ0RpaDEvbHo2a2dCbUhiUGIw?=
 =?utf-8?B?aUg3YnpkeUJSVkwzY3IvS2t1UUlqbnB4ekxtaHo3TUQyN3B2a0lpeWQ1d3hU?=
 =?utf-8?B?blkxVHBmUms1WmtXSE1xMUpoYVVZbUgrREZZalNKREZSdlRQTDFiSGVUWDdC?=
 =?utf-8?B?LzdUZkFPUGhPYlBLekJzMjJ3S3YwR2RPNmNtSklELy9jTDFJQkE1MndZelN4?=
 =?utf-8?B?TkR3cUV4SEYvdEd2T1hIREJZSk5DYTZ4V0RPT0JkZG9zNUNIZ09RMUh5Rnhs?=
 =?utf-8?B?b0JscFExazRrZkFITUc0aW80cWpvTHdHWE5Jc055NUdPbkFadGVBVE40ZTFM?=
 =?utf-8?B?ZS9LelBWVmFiLzVlMU1ObWFLMjZEM0x4bkNxUml1MmNFQ2tOZGV5R05iR3ll?=
 =?utf-8?B?L2kzay9oRGFPVHVKaEVwZzRqQjR0MDI4dFhFZ3djckxwVnpEbVRZRG4yWWZi?=
 =?utf-8?B?QWtPSVB4NnAzeWVzc1NsRjJ6SWp1eUdZSXBGRnJoREdNQ0xNSUFRSTBoZUZQ?=
 =?utf-8?B?Wk1VdWczM0tIMEZjS1o0amNUcll6OTBZVFQzVnVrV09LYnJUZzNIN0pjMW1V?=
 =?utf-8?B?R1hmUjFsWnhmUE44SDBWMlpodGNpQnRBN3VZeGJmeWhUekxHMGU4NjhNWjR2?=
 =?utf-8?B?YWNENWRudmNub1F1RjZ2M1hNa1plNmRXNG9wdmJrblB0aUxpVE5BcnVXeDQ4?=
 =?utf-8?B?UWdxemdyKzI3N01hSFZRaE1HNml6NnJON3IxaytGQVAzMlJHSkNWUEZxZTdJ?=
 =?utf-8?B?QVhGWnBPOXlzR0ZINlJ0NDRaOEhCQzdjU2JxV2ZEWjQ4bUk2R3N0d3o3THl4?=
 =?utf-8?B?UXFTSllCYnY4dU9qOXlJNnRPM1FLVlpNYThESitCOHZ1Snp2WkVaeWpoRjBh?=
 =?utf-8?B?NDNPZ1cwaXFVSThkcy9uTGVOY241dmhoUUNxbTJkbFY1bHBXMEpsMVU5Q1Rv?=
 =?utf-8?B?MUlCbFZCMDVRdEltRDczT1NCOHlNTUtrRGJ3WEd5U0xRdHhIWDVibDQ5eWtU?=
 =?utf-8?B?bWhrZUxnUEdWM3kweDh2dkFldEM1YTZaZzgxWkcrQmdNckNzaWpLZm5ZbWQ2?=
 =?utf-8?B?cnE0a3lwQ0hYOE84RWw1YW9kM29hTGlSaXpXVjl0UDBmNjRGbXNXMm5DTVlI?=
 =?utf-8?B?eGpQRFlibG1BT2lLRVI4ZWcvWmxyU0VzQ3VRNWZDaU9PdERMcHBWWDVnOVl0?=
 =?utf-8?B?c1ROUnFreWt3MDcxbEdLc2hWZ2taSE94ck1OWllXd2FPRlVyMXdQTkF5NWdi?=
 =?utf-8?Q?elLdCLjfnY9WCE519IzrlzAQS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UDvVlDzOgIT8ycWcinURhZLAOkyNb9fFKz7/bFk7BAplmedgEexxxds2DnllqydoszPeKlzvcRVLk+JCLOWckztOKWPfiXGp4Q9BphcquhOS4GUnp46w8PL9wacd9nQSPg1fAmH7uIOMirqCc1d5UNmYyXBWkYL6uQmnHdp82YoNkjBEmTXdr3Z4zT1t1Bw28JELORpMxEnGqoaLs6fDtR/vBtOkiXxgLouWK7hwue5AyMKmA4GovypxZn+VqNavjKZhbGtMh8mKtvfoHumE5TL7mUPiRrp33PM4WSIRIvMgAao73sw8rkuSk8cyTbP+bP/ggalSpXruPn0UXLChIhkOLJnIdlzq/B6P1ruUej0RzklBOsjqFmc/TsnTDJTa8Rjn525nOOq+utcTgB6jgt4DEDa8uExpjeG5gCL+u+/pfv/v9W9byh1z6bt72rzhf1HdWMOWlx9DtazmEJVNzJZty8Yx7uPu4qkyIshdN3Axj4fLFWzsrrGYCtqMhtA0MjGmiKLMRASzIFPGvO7Px+tA4jm3kNr7m0IyMskiDkB7kwSBonFcp7Wz7g86GzzE08EtfjS9VqGVTn9to/J3eTxz3PEN7PmuriEBQ8vPy1s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9cfc6a3-a5c6-409c-1c90-08dc6c9e3311
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 00:56:29.8493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: edRiLS+mdc4gxEgW2tsYzXykE3YDjExDnreJd9NBbHcUPhHE90MtSKWz9nlCHxOadFnQliFFPId148cqAeEkrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6737
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-04_18,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405050002
X-Proofpoint-GUID: XPPXejO-pOASstWv589z8CBC8Mu2w-Lh
X-Proofpoint-ORIG-GUID: XPPXejO-pOASstWv589z8CBC8Mu2w-Lh


> on ext4:
> 
> ilefrag -v 
> m/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/3561288849sdhlie.sqlite
> Filesystem type is: ef53
> File size of 
> m/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/3561288849sdhlie.sqlite is 49152 (12 blocks of 4096 bytes)
>   ext:     logical_offset:        physical_offset: length:   expected: 
> flags:
>     0:        0..       1:    2217003..   2217004:      2:
>     1:        2..      10:    2217019..   2217027:      9:    2217005:
>     2:       11..      11:    2217028..   2217028:      1:             
> last,unwritten,eof
> m/root/.mozilla/firefox/s554srh9.default-release/storage/permanent/chrome/idb/3561288849sdhlie.sqlite: 2 extents found
> 


btrfs-convert doesn't support ext4's "unwritten" extents. V2 of the fix 
is in progress.

   [PATCH 0/4] btrfs-progs: add support ext4 unwritten file extent


Thanks, Anand

