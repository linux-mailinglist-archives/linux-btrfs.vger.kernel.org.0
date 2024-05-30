Return-Path: <linux-btrfs+bounces-5363-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 996C28D49FA
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2024 13:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51A77282239
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2024 11:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE0B16EC02;
	Thu, 30 May 2024 11:00:52 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5CE6F2F9
	for <linux-btrfs@vger.kernel.org>; Thu, 30 May 2024 11:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717066851; cv=fail; b=UVoN6DDXm3f7SOX3sVPtiofCxanl4aXwDuEKSLNIepxeJCNlyonZT+wGbpSRtQ4DOIUz55JBmkCwt0Dj/bVg3r0SRASPzGJTGFTwkOtW2Ok23PysoSt4gHhz/633F35jP6BJC06gUJz0CPbrnkG2b1Yx7V5u76XIpDmV8yrIqcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717066851; c=relaxed/simple;
	bh=FTXLqZx7SRs1M2hJN4rXUfQkgt1zUPm4iun16zO3z64=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gQxTNG11rjyObnOo6MYzjI8mfQOtiK5NT3va1+S/DftDYPMOUqpzLP+3HXKDVWCOmOfTumL04MH+HxUTYJD+TnCLhjRkVu/y6ds8C+FVZgUszpM1yxFyFN9ctavSWKuCbgOalofgTfGqwyVu9bXiTPJDbWsrz0gXC/E1pPEbyoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44U7nVVG003356;
	Thu, 30 May 2024 11:00:44 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DaPoSQ1A1dfdSyLeI/ySRp0UcbdxtSbEVu9HLom7QJPY=3D;_b?=
 =?UTF-8?Q?=3DaK5qL+u5tFGjUXT9gUixWFZuid20kdDPbCo8CPFzaaltd/oSt3cxvzfVd+AG?=
 =?UTF-8?Q?FYq96qji_F4bZY3JnvMUwz89xgSgGrhZikn78OHBnt/+RgaD77o6FaL2IIFpgBT?=
 =?UTF-8?Q?aSYoHmS0QeJAk+_uXOiRSjyKwx/WBLOY9YX2ZB/Cch6XGQsHEuII8c4d50oXWS5?=
 =?UTF-8?Q?30znxKCltHdRBMrYLDZZ_6AkaxfWODW2UXu97YeyhJQnZUbaLITNCgCAx/yGpzE?=
 =?UTF-8?Q?a5b/DImg2p6G+fLAh9Uly4bCsg_756thsW5VPejkms2lUDZay9BgDyyUy6XzOnd?=
 =?UTF-8?Q?5clMRwwx3GRzkPtD34F7YDVJBIUNRHnK_6w=3D=3D_?=
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8hu8r6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 11:00:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44U9V6S9024354;
	Thu, 30 May 2024 11:00:42 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc52dq0t2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 11:00:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwUctzkbbIWVyjKHlakChilKqRl2h6XAYR1iJZ0QMN1vFhde30C9AknO9j07542uX9zdYWlA2qbqSJDVTtPMPMmDW26I/FnXF1ezufNSIwBaiMeFfA/tdyTSkxD23kjX7Dx04oJSU9Y0MlY9tSSIuDSUiDJ8SWeV6bxp0IlRcGrM7NjLZ5efQl1cvQwtR5ujzinATN0d+6GSFcryc6oA9URWP9FC8w/EmQXXIDt4UStHZMTnA3ZR/i0pVNuW2Rl/X658OW8KYz741UEXiJ6fOubqKtqzlo33jA4E1nlmpUrL44wUCopob3CQzuy676ycbQl6NX2MJjmhb9v5J2AFjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPoSQ1A1dfdSyLeI/ySRp0UcbdxtSbEVu9HLom7QJPY=;
 b=QhbqLRN4Q0hqxTGoMZU5qPrXRqCbYOFNCUT3O4sfSdOxIwpJxa2hp4NQnc5RMVfMpAJH8Fv5ETqeqeqyI8gY19lGzK6khP5uSLb0dJoI12EX5bZK9RUlGxiEHBB8t+mvpO6mffsZ3MgwfX09KQeWjW0W7NHZTece5qG4dcVhtf0C05riPzVwfzgwPoQA1MrbjknA+XgTHPmqD0d2jYfM/iEzCWgnL6k0A5V+2Ym54hBa/SU+gnEiapZ4ETPY1uU2CeV28gCNOZgK3PnZ4aHB8D4t6NfuKxN0brx55BciOtUy15XFEChyqcxPiG6rvslqvCzeF7R7d/mI6Ll9LvvLFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPoSQ1A1dfdSyLeI/ySRp0UcbdxtSbEVu9HLom7QJPY=;
 b=nEmK0QWKBPzk17XNkoqV545JsusJoSf7cSBaneLTPVnHkVeOQNcO8x+IDVDHm1LeQ/ieiPKcTIBn7i3iLbD7xCf70K19/g+vjF/Y6SXXGv9hKP/HPurG7zWWxZtYhGpM3tGgBFy+CXC63XR3dtl2v/YfRmr3LnDjXtcIamefQ64=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW6PR10MB7658.namprd10.prod.outlook.com (2603:10b6:303:244::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Thu, 30 May
 2024 11:00:40 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7633.021; Thu, 30 May 2024
 11:00:40 +0000
Message-ID: <d09a35c0-001d-472c-939d-2cebee21192e@oracle.com>
Date: Thu, 30 May 2024 19:00:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] btrfs-progs: convert: Add 64 bit block numbers
 support
To: Srivathsa Dara <srivathsa.d.dara@oracle.com>, linux-btrfs@vger.kernel.org
Cc: rajesh.sivaramasubramaniom@oracle.com, junxiao.bi@oracle.com, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
References: <20240530053754.4115449-1-srivathsa.d.dara@oracle.com>
Content-Language: en-GB
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240530053754.4115449-1-srivathsa.d.dara@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0187.apcprd04.prod.outlook.com
 (2603:1096:4:14::25) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW6PR10MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: 87778fcf-dc8d-43d3-ef95-08dc8097be26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NVJVUFk1cmJSRUM5VlBob09od3F3aTNBZi93c2JuZXpjQVE1UW5IdkE3Vm5O?=
 =?utf-8?B?Z1owam91NHduWGtSVk40VUM2RXVHbnJ4aTZISmQ1elQ2TCt2TEZKeUtrd3dU?=
 =?utf-8?B?QzIrb21PS01VbGhySlpmWUFpSDF0anB1T2VpREpZMW5LeUFxR1VyUG1HODY5?=
 =?utf-8?B?OW8rVHZaOWxNSkNCbFpMbEtoZ0VPNXNGNWFhRnpIeUxhbEIwWUlaNHhOVStD?=
 =?utf-8?B?M2NEY2EvNEE3SWJyVFFQZ2ZLeXQ1L01ON1hXcFlSUUFpYUQ5d0U5NkljSTM1?=
 =?utf-8?B?VVNua0VIeEh4UjVsazFmY2Y1MXEyOHRKLzYyeFRXWWRhNC9nbTcwbW5JY2V6?=
 =?utf-8?B?NHhVa2pnSDREaFpvY2NPSVFnTkw4enpiMkcvS3Y0WjlFODBWL2xGcGp1ZHV5?=
 =?utf-8?B?TXRnSXE2aHRZZlRPRFZQVDBRd1NpeERUTVRDQ1ZlMHB3VzhIaW91eTBiRE9I?=
 =?utf-8?B?NHp5OWtxS20xbUpsck12UGJIcVcwYmthSEVDRy9ZRm9jWEx2TjBYYW5EdEd6?=
 =?utf-8?B?TXQ2ZTBDTHVrYVZuRjFnSXg2MU9CRktGWksxNStaV1EwTEFUOEtra25JQUpV?=
 =?utf-8?B?T1V3M1FQbWU2RUJPTFJBTlRnTU9vUHlHNXpKdngyNjEwS2ZId2JNZm1idEho?=
 =?utf-8?B?d1Uva09sU2VGUTNpUTFCQnkvMnBVWTU0a29TbSt3WEt0L3lvNzA2OW9BUDZP?=
 =?utf-8?B?endPSEZEbTRGQStYa0RqUUNWbDY3VlEySDZxUm9wV2hHVjF5cUZYbVlGREdZ?=
 =?utf-8?B?SldTUDFsY2NGeU1NNjI1QngyT2VDR0Q3R3FnOVUxV2RldVdWMDNjZ0Y0bUp2?=
 =?utf-8?B?NUJtS1Z4NDFTeTVPVFp0SmNPN3BnU0s4T3AwbzNGZENKZXVDd3phMEszeG9n?=
 =?utf-8?B?UTdMWldETElVVFhzOUhxdy8rVlZ5SnVHRURIUkxYSkt5Sld4QXg3Mkg0WnZ3?=
 =?utf-8?B?UUhMS0RHMmJIbmJqTitYTVFZTm1RR21WSEo2eVBWVU9MWW1qaFZXMDNEbzlH?=
 =?utf-8?B?MGhyL1Q1cEN4Rk5SOUo1Tk9Cd0lCRkZUTVJHWVNqdHBPUHBpL3hjRXY4dWND?=
 =?utf-8?B?ZVZ0MGYzdTBrTWNkU2ZRTDZ3U3AyY1NkRU5yWVIxclVaU3BIbGpwUktIT2hH?=
 =?utf-8?B?cDJCaFBmdGJOTURjSGRtVURIczEzSEN6ZGI5RVdqWEhrUGY4bjh3clRGTm5o?=
 =?utf-8?B?RzM5L0JhWlhqZFJFRzI0VTlsM0lmMWVMZzJQTVdMY3c1TFZxR1dCVzFiTjVZ?=
 =?utf-8?B?czRCS3Byc040ajYrVUFuNng2d09NQnBQTWU2ek1BYkRTUUl3Q0pFZmxsMUpR?=
 =?utf-8?B?ZEtnMDlPSjJ0UURILzU0TlNwWWkzcjBid2ZmcHJieUN0WWJMdjQ0TlBrTktx?=
 =?utf-8?B?TWxLN2JlMm1ORFowQnVoRlc5eHZES1NFZlBmWUFwUDA3QnVGZVFZejh0MU4z?=
 =?utf-8?B?Z21HWTJDemhQMi95RkN3YzJtaysrZGgvbkk2MGxOWmlObUI3QXRBZ2VPK2RX?=
 =?utf-8?B?b0doenBmTXRqR0lHRUthUWFTVnExZmRQcEx5WEhZRThuNkZUbFhKUGFOTEs4?=
 =?utf-8?B?OEVlZTI0WUxncGRnL3QxTjV3d0VlbWhsL2VLNHd6S2hWblBHMUN6NTVZQWFu?=
 =?utf-8?B?YmhkUFZTN01jRVZBaXRmSlBUK3ByLzRnSE44Z3FVRjVwUHVDemV4TG5jSjdZ?=
 =?utf-8?B?WGdwUkhxbXEyS2dxbXpOYWZpRFFKWWNvdnk2eTBGK2c1WWpEQ1BIUWN3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bnlOVldWbjBVMGpqMW9wVk9EeWhqVmxJdXlLUzROZ25tb1NMcDg5ZnBDQWZj?=
 =?utf-8?B?eGV0eS9hRVp2TTI1aHozRjZaY0N2MERsS0V3a2k4TW5tb2NNVlNNYW1KdEJp?=
 =?utf-8?B?ZXNyUjlJdzFicEppZ01TRzlLZTFONk83YkVtMmNlaDJicHBJWnIybUhtOVlN?=
 =?utf-8?B?YXR2NGg4eDZ2dEhPL3ZFYjYyWnJQY24xM2QvUWN0WHArcXVIbDFTSkVsL2l4?=
 =?utf-8?B?ZmdHeUhkYldSM2lHRC9EM3IrbjhvR1ppQkdaeElZSnlNL1IxQUdwZlkrTGdC?=
 =?utf-8?B?L3BpdGEvV0FWK2o0b2t6eEtqemI2ZEFsMU9mYWE1NGV1K1c5bUxzUGNFVEFn?=
 =?utf-8?B?TGZvZGVTSWJLZjBFR3RKRG1XQXZQR0pwUVAxTWMzODI4ZEpKMVU5VDBpRHZw?=
 =?utf-8?B?R1RLTlFGU1dUKzN2K0V1WCtDRXVPSDhobTV6cER6aHBRVVNCRkhhVldMSnZ0?=
 =?utf-8?B?NWdoTUlXTk01L2UrM2pRTnRVaXFvR0V0UmRzNTl4REJtNURxazl6VXdOdEtS?=
 =?utf-8?B?dmt0eUFIN1YzczhZSW94TlJjam1XL2JTeGJhK3lEUnk5dFg5UFkyTDN0VlAv?=
 =?utf-8?B?TUxNNStodzFiempQcW1Xc2tGUVFCSnEwaEJyZHVGbWYvQXEyd0hXSXFhb1RX?=
 =?utf-8?B?V0xPa3dldEJUM3JPQm1CV2hvTkVldlhJK3ExVWdMekVlNi9oT3lMcFE1WEFj?=
 =?utf-8?B?bzFPcmdmMWFqdEpsRDl2WEMycDJBVzdSUHNGTW5XZThId1RiS1BwY2NKNUtO?=
 =?utf-8?B?OS9ZTXFUVWk3YXdwSjFUc3NLT3NRMHFzRjRRRDI5Rm5FbUNCOVhSWFZJcUFj?=
 =?utf-8?B?TFZUSElhQUttbFBXN2l4SCtKa1B2ZS9KMFJzMEdJZ25uQ3BlaGNHQTVlNUJI?=
 =?utf-8?B?M28yZ2NKSS9yUGRlTTlUVC8yM0NTS3FRNHhsYW10d1IxemxCTUhiRWlHaStF?=
 =?utf-8?B?c3BsZC81TkdWMmI1N0d4SFF5b1VsdlUwNEgzMVJuUHZqYjQvZjh1YkYweDVs?=
 =?utf-8?B?NlpKZmcxdGxFd1YxeWhxUWxER2szK0Ywb3U1UElSUmNUTGhlMkNVYVlrQWpP?=
 =?utf-8?B?b2NjcWlkd0hiWW9Hc3NlK0dSVUpGOENpUWhZRzRYV0ZoTk5WK3JiYzhwTEM1?=
 =?utf-8?B?NVI3ZDBGanIxTE4zd0dkZVZGaU0wdjEzdCtuMzRDY3Q3Z3ErZEJ3cmZocFRa?=
 =?utf-8?B?T2dXMHBVODhrbnVmUFVOQXdWWHZTZk1OcGNhbGlHNU0rd3M0cmlDWDZDTTBr?=
 =?utf-8?B?SitDbHp0YTRHaVJZWCtkQnBVY0tpaUFJQjVGbGQ5OW9mK2xzbCt6TzBRRjNP?=
 =?utf-8?B?N2p4WUJyeUlOTEdCVU1kMVdpNExhS2VJR0grYmMrWjk5ejRWZHFvalppTVlX?=
 =?utf-8?B?cUJQSDJLelQ5ckU4bTFmNk5GSitGYUpsMGQ4MEJUQ2l1SnZuR0tFRUltVzAy?=
 =?utf-8?B?MERubUo5ZFdBY3E1THpRbHRtUlJ0amNLK3ErOWVJamhGRFJIMWtZN2tRZTVn?=
 =?utf-8?B?NXFuWEhyRTE3NGh5TnMvS1dQems4QU1HRW9OcWhJeDYrWWIzSkZFcFk2UGhG?=
 =?utf-8?B?VnAvWDhHNzd4cmdUSW00aHBoTnNRcGZyVGdLNTZINEVQd0xsaWJGdllNbW5m?=
 =?utf-8?B?TkowQ2RQZjR6TEFhRW91WjRpR1V3dGJydkQ2TjhYeG9pb0ZveGN2SU1iekhI?=
 =?utf-8?B?OTFlTmVuZ3ZiL2c2ZGoyS2Qxd2h4YWpMWTZPRVVHbDd5NVJVR0dYalZ6cDYz?=
 =?utf-8?B?b2hWUU45MnFvZGFtR00rRzcvTzBQNG85UVBtc2lIZ2N6eVRTQkwzU1JhUVpD?=
 =?utf-8?B?elZUem5EazM4RWppNXZqT0V1eE13NWV2RG1sOWhrTXdZeEhkQUs1OG10Y0RC?=
 =?utf-8?B?aHpFL3F1V3JEZWNQbjNvaEE3TlNuVDZhNVhMMFJDcEIvQ0hxTEFzNDhuZThq?=
 =?utf-8?B?WGFkMWFIQ2haZDBVT1Azcy9iak90anlyNU9sWVpBeUZIMnZxamJxZnRYRWoy?=
 =?utf-8?B?aVdTNXZrUmhvbWlsNGdKMnJrdWNwQnREN0RralhCb1FLaVUxNDNENXhpN0t3?=
 =?utf-8?B?dmtGK0tmVDJub2FMVnJYVFdTd3oyYlBWTzhMbFZjUTFxa3JGNXk1Rm1EUlFW?=
 =?utf-8?B?K0xzUjNzaVpyUEZRV3ZOVzVBVHgxL2pNdThmOUdyVHhuLzhTRXYvblFmdTYr?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RYma1RjmaD3k6DltGXgvYbjWtf50WeMeKu+5LYMsTRbN1BoKw8Xym1yshoHaYfNl/dev++BRv6B7jbN6F+Gd5qr5t5J3WU6QjhCyQixHbEB1OnxtvDVvGNkM3fu8wBBtJ7d1OyonSwjluoCpw4ocmmGq6W2wqgwNNzDRFaVRlLaTkHqV3mLLl5rQAIYSgpY5AniLt+YZeA8WzC3Mvdb7sjsRd34cAscclNnQNqfb/IJCR+4uFV7OeASeNc8AWrP4AcD05cF1Z+f7jay1qB9rlu6TifSiFF6nxq42dE4auSR662Q3ltVIc91DNpSRWamw4GkSioXVKEfyFGyv9RdSx6mIzxf37FXokNXP2Jd+r9v4+7y7dIl5VXadGHKzKp4ub//vz6DtQA/UT1i8yfWdXrLoofmfC66QiSg8RsIr+e4h3LSgGYLaiFW59rmNLAdedIm/LWmy80mHDozH5JgA2dTRR59DLgnxfeh9D0SvTH4lEH2NMnhlSnRvIyDCJrc1oVHMy4xULdhLSWpvWP2wI446ObpfPhhUAS/GM418h/RKliRM/s8iHMFqjO9N08jc//tMieGwAeV3f3i6P+Eu1NPQA6BH3yl8yp5YuO1pAqY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87778fcf-dc8d-43d3-ef95-08dc8097be26
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 11:00:40.2607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kEyLKpyb6i3e75BQiHbkk8BybeMRzOzEt7fDBnYFS5aDfYHsz5UDIs9eRalCSx7tNVnlFQ9MyaRA9qIfaBv6LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7658
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_07,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405300083
X-Proofpoint-ORIG-GUID: XDRiNllykavrpDHl9DEwJ4umzwdBg5jh
X-Proofpoint-GUID: XDRiNllykavrpDHl9DEwJ4umzwdBg5jh

On 30/05/2024 13:37, Srivathsa Dara wrote:
> In ext4, number of blocks can be greater than 2^32. Therefore, if
> btrfs-convert is used on filesystems greater than or equal to 16TiB
> (Staring from 16TiB, number of blocks overflow 32 bits), it fails to
> convert.
> 
> Example:
> 
> Here, /dev/sdc1 is 16TiB partition intitialized with an ext4 filesystem.
> 
> [root@rasivara-arm2 opc]# btrfs-convert -d -p /dev/sdc1
> btrfs-convert from btrfs-progs v5.15.1
> 
> convert/main.c:1164: do_convert: Assertion `cctx.total_bytes != 0` failed, value 0
> btrfs-convert(+0xfd04)[0xaaaaba44fd04]
> btrfs-convert(main+0x258)[0xaaaaba44d278]
> /lib64/libc.so.6(__libc_start_main+0xdc)[0xffffb962777c]
> btrfs-convert(+0xd4fc)[0xaaaaba44d4fc]
> Aborted (core dumped)
> 
> Fix it by considering 64 bit block numbers.
> 
> Signed-off-by: Srivathsa Dara <srivathsa.d.dara@oracle.com>
> ---
>   convert/source-ext2.c | 6 +++---
>   convert/source-ext2.h | 2 +-
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/convert/source-ext2.c b/convert/source-ext2.c
> index 2186b252..afa48606 100644
> --- a/convert/source-ext2.c
> +++ b/convert/source-ext2.c
> @@ -288,8 +288,8 @@ error:
>   	return -1;
>   }
>   
> -static int ext2_block_iterate_proc(ext2_filsys fs, blk_t *blocknr,
> -			        e2_blkcnt_t blockcnt, blk_t ref_block,
> +static int ext2_block_iterate_proc(ext2_filsys fs, blk64_t *blocknr,
> +			        e2_blkcnt_t blockcnt, blk64_t ref_block,
>   			        int ref_offset, void *priv_data)
>   {
>   	int ret;
> @@ -323,7 +323,7 @@ static int ext2_create_file_extents(struct btrfs_trans_handle *trans,
>   	init_blk_iterate_data(&data, trans, root, btrfs_inode, objectid,
>   			convert_flags & CONVERT_FLAG_DATACSUM);
>   
> -	err = ext2fs_block_iterate2(ext2_fs, ext2_ino, BLOCK_FLAG_DATA_ONLY,
> +	err = ext2fs_block_iterate3(ext2_fs, ext2_ino, BLOCK_FLAG_DATA_ONLY,


  Are there any ext2progs library version dependencies when using
  ext2fs_block_iterate3()?

Thanks, Anand

>   				    NULL, ext2_block_iterate_proc, &data);
>   	if (err)
>   		goto error;
> diff --git a/convert/source-ext2.h b/convert/source-ext2.h
> index d204aac5..73c39e23 100644
> --- a/convert/source-ext2.h
> +++ b/convert/source-ext2.h
> @@ -46,7 +46,7 @@ struct btrfs_trans_handle;
>   #define ext2fs_get_block_bitmap_range2 ext2fs_get_block_bitmap_range
>   #define ext2fs_inode_data_blocks2 ext2fs_inode_data_blocks
>   #define ext2fs_read_ext_attr2 ext2fs_read_ext_attr
> -#define ext2fs_blocks_count(s)		((s)->s_blocks_count)
> +#define ext2fs_blocks_count(s)		((s)->s_blocks_count_hi << 32) | (s)->s_blocks_count
>   #define EXT2FS_CLUSTER_RATIO(fs)	(1)
>   #define EXT2_CLUSTERS_PER_GROUP(s)	(EXT2_BLOCKS_PER_GROUP(s))
>   #define EXT2FS_B2C(fs, blk)		(blk)


