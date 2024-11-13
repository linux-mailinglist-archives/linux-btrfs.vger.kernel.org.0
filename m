Return-Path: <linux-btrfs+bounces-9582-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB5B9C6C0F
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 10:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D75288B7A
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 09:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE611F8EFB;
	Wed, 13 Nov 2024 09:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lMCRN6Gr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gusHtxEd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B496A1F81BE;
	Wed, 13 Nov 2024 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491482; cv=fail; b=OlCGNKmrMM+YZHvCcw/mBP3q4Ry5GXMi2a1ZOHvVJbjjkUyunjBC5y9G8nU76PiqfLyex7E9ausVnEYmIOrJ/03OtGYf1EVy/7wYAxRkVbW455npkV/mt7sqgI9Z2ff0f8qQBaJNE9tH0afFRj9C5/obyE8Q/L1oSpSpf3FzE7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491482; c=relaxed/simple;
	bh=Y61PPPDV2xLa3r6ChZ59qH6DC0+BHtJozfIFXdAPpVw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cOVTbEXLjEejYlWb/lO1PxOlLd5BbYn1Hp/70y6ugHer3UacP0x3LHD1yHYwsan1+tZsW26pPJ4rPsbmGMJaGIzaHU4DKtHMpN0z84d7Y2NawASYCuJ/Kz7xHGBh6LVPKJ26gaWb9Scg6N59q/bhmZJd2pGOrpJcVG5gxSJNf64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lMCRN6Gr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gusHtxEd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AD8c4Cg015248;
	Wed, 13 Nov 2024 09:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=hEhH22RnYknJNhPYVJTcHAa7r4bZzYK8VyzfsJZhWAw=; b=
	lMCRN6Grm5I0u+RPMcaC9P+uo75sWJLpaS6sQBA+5Z1c2qEyUviQU9oo263Yl559
	QGUiGZclAd1fk6HJnzlstqnJ31j1OCD2VgE8rlHxPM9feN6cyXKsgky7mftkdcAF
	kXbKzZ9VLi2zYaVD7RBlW9x2JplVzaXnbsE8WCJQ/EfoLG35agAPPFnJnC0dfhvz
	XX5ptzLnaZ/WPGAKeUdWvdn8n1Gxiz7IaNBmDutdmR7rJjDELdXM0ufDVpzxmjXf
	GPIq1HWfGU6EQf87IZL2x0ng9HUsNR5KJhRa2tG4X36SwPGy8AUOuIieoKjqpuBR
	UnZAAHJjwo1uDE2mrfPd5w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0mbeg4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 09:51:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AD7YuXG035969;
	Wed, 13 Nov 2024 09:51:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx693thp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 09:51:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsj6cpqXtw4K3T7EyA3TTjYicmKIaMtiOsYJVDHbWohLFrGCB1/3T8x4clih7hw4NPISJmQ3NPB0Ftz3q7+3mv+EQMqqunoBEV47Pg5xXrIIgg0EGAlr95aXfJ7wAOUJKySl1vXRhbbhIE1XGEcAr10KeU2JlEgCKoZZn3EqFYX68KXfgoVfuT2oIl5GSEJCv2vLPqIy4SMxCK8zq0wZyVbIhODm5aBRxR3KxWc9kMf831SYHsI56T4JfzkJJGPvCWRekIR7HKT+3fmED444JijMZP6lYmIHJHuCclftjM1rR6xq3mqmghEDgxT58Vwjlv/715MaXOCPe8bgHViTyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEhH22RnYknJNhPYVJTcHAa7r4bZzYK8VyzfsJZhWAw=;
 b=Wf6Wbg+PyamG9e7YFHaL24C2S2NVeNf07fa8wwOVTGeagFaHNw18LmHcqgWGog3APp2aN+bTb0NrTPhCyJ4MJ5BGZK1amm+nxVAeFaxVO/e15J8mhSOnKhJDgcbEr43m8FLnaw2cTaxjyNC8UjDim+CWCOROidLW1TmSteiALFH4yQ+T5y2kNfPx5ODhoXw/zF1TOFUfdKOaeKXDSJ2GVHYYFpkt0gni8vzfoeLJa1m9tiPaH06hQ6fmB20/+jjxgMrwbp88nzFb4kLbbDLYElyPyTkLoXXdSjC8TGzcTAs+cILVLWyRgG4L+NfhoYaR7YwDRstdEWqya75YaE/Jdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEhH22RnYknJNhPYVJTcHAa7r4bZzYK8VyzfsJZhWAw=;
 b=gusHtxEd4fJ3arzRMnklFQ5J39egcDWA/hrfSJ8VrORCMynsSm4x9FcP4QhGc49pwZEzm0jtqUzgEDCEtajTeVEj3ba64B0TnjfGvnUtDsBrZ5VQwGAsQfGFqeOOgUVhOuJilIBAqK1fpVDKtoW7EZRlZrIZLUu9eNpFH1yD2QQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB6374.namprd10.prod.outlook.com (2603:10b6:a03:47f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 09:51:09 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8158.017; Wed, 13 Nov 2024
 09:51:09 +0000
Message-ID: <9eec1ccb-6e56-4701-83bf-3397d1bc5197@oracle.com>
Date: Wed, 13 Nov 2024 09:51:06 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] btrfs: handle bio_split() error
To: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc: linux-block@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20241104121318.16784-1-jth@kernel.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241104121318.16784-1-jth@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0001.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d0d6bb6-9cbd-4165-2599-08dd03c8b319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTEzeVR0SmRjZ0c0U2ZkL0dmY3lBUVBxeE03Y3orTW1RRTJDK1hVQWVYcnVz?=
 =?utf-8?B?b1JmTTJjMW9tTm5JdzVkZnpVaFpwTXZOUFZRTHdVZ05tWmVKSUZPQnlKdmRV?=
 =?utf-8?B?MVY4LzY0bDErVFNrY2tzNHZrSEpTSzBSb09wSmszVW1FWExNRXFERm9TSjNS?=
 =?utf-8?B?MEp3UDJ4cFc5S09Ec1o1REVFMjNRUHM1N1Rvb2NmQmFhb1R6WThMdmxWSWpD?=
 =?utf-8?B?TG5qVHg3KytJVjl2SkpXTk43U1BMcHN3aUdwQ2IyRDR5Q3ZzWElhMFduWHZP?=
 =?utf-8?B?VmpUZFNxRnBxMUREYnNUTFo5RmxMMkIvZmZML1p6aUM4N25lQmVIVmVMWFVs?=
 =?utf-8?B?TTNNc0ppMXoxeFg0WXVVWmgxYW5MdmVzdXd5YXVXZ0toT2t5S2tEUkFaczZ1?=
 =?utf-8?B?di9SUXE4R3RZaXZzellwaXVjNFVneU1WcnkyblYzbTA1M0VMaUJEbkhtSlJx?=
 =?utf-8?B?OFg4QzFnck5maVFzN2xraUhxdmdjQUxmbzdUTEcrTmNRK0FhdXZFcVpsUzFu?=
 =?utf-8?B?RVVTbEo1OG1XcnFRbVVLR054dXhKMml2YW5Hc0pJUVl3aXp0azNhTVlJTytK?=
 =?utf-8?B?OGMvUC9hVnJxS29IeTBCSVU2RWpyWFU0UnFCUWlvOE5KdlFaRWtyTkVKZys1?=
 =?utf-8?B?WU5TcHFhcDh0azNqWGNvQnVWQndNUzN4cG80dXdqRDJLcVQ4YlBMbVlRNnMr?=
 =?utf-8?B?cUtOTWhzaEpJekd6YW8vdkhNSG5oUVU1M0lpcjJUN3NzbzB2K3RwUzVRMXRP?=
 =?utf-8?B?NG9JUzkvTStEbWlpSng1cG1iK29RZDFuZ21lL0lFVUsrdHhyRC83T1ZxMW1x?=
 =?utf-8?B?aFBxb2laTGtZUjV6d3ZGcExyUHgyODNGUzV2cEZFWlJ1Tzg3SkI3OTZJQXZx?=
 =?utf-8?B?a3duUGJPdVp2RjU4QzFWUjROR09HblVubUJ1VW9EYUxoYXNLZmpPK05veldT?=
 =?utf-8?B?S1kyYVRvZ0xSQnRhenZkU2w1TThacmU5ZjAybHFlRldicUVjOTFlVGdlczll?=
 =?utf-8?B?c2tBRU9vcXBoanpkTnAybHpmRUw5Y1VqaVp2ckJkWUJPY01TdENRTGpJNzFj?=
 =?utf-8?B?QmgvWURWNlJiN21SUG5ZWFRWdEs2NkRHanhOMkxJYmlrd2xhUzR2ZFVYSUdx?=
 =?utf-8?B?S0o1S3h6NVgxTUMxWmUzamk5NUlYRTVFazVCbW93VHNqMzNuQ1JVcUdTV1Yr?=
 =?utf-8?B?ZDRxSUlLakNZZXhJOGZIc0RZTzVLeU1aTnVSWUZnQTF3Z3JwTkRtdWxvaUla?=
 =?utf-8?B?bXlob3ltVmZMbnZXbmN4MzRacHJoSTMyWWozdVJsOWk5SmlCdXkwRVNYNkNM?=
 =?utf-8?B?NHcyelBIWGFqdm0wMGdBb3g2NjBKdS9oZnFXRWVBOERVU0JYT2t6QzNxVTZa?=
 =?utf-8?B?NDNCeUhJWkVUTW12eHEyK3dYWmxNejVJL1QxYWRuU3VZV0tUT1hxVU8wUEh5?=
 =?utf-8?B?bnJLSjNVc1FmbVR3TTJjeCsvVEMxS3lXU2NXdnVTRnFQcmVTSkRWb01SQmMw?=
 =?utf-8?B?NWNuMWJaU2Exek5XZzh5Uy9FZmJITXNsSjFGaXRJRUY0VHZ2aWUyNzlrZDNW?=
 =?utf-8?B?QmdXSlg1L1V6SUtLSXdBUlJ5dTBLNDlzaTU1UG9jc2F3WUM5NkF3emtJdnFN?=
 =?utf-8?B?UnJQLzZuT2tKWmt3RGtKanhOS091NlZHMWVvTSthWThkUUNXcHNYT1NBMWhD?=
 =?utf-8?B?dGFuRndCSUw3SU1UTnM0ZDc5L09hVmJIazlIUDZucys5bjRJa2w5L3VJUHJ0?=
 =?utf-8?Q?tBXHAO0aW9Fy2Bd1vk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3YxZ2ljU2puOC9mVkhYYzFWZHhSbzZldU5RWnBCUTRuUlpjMlc5UU1FcFl0?=
 =?utf-8?B?SXZKT2dYbzE0enZ1RWRtcHpITW14UWMrZUIwaFdtMGFvbXFYOS9ZMkttbVFD?=
 =?utf-8?B?UWpkM0M4NTl2RHVtRFZneDhRWlJiRVIxWjByOXpjU29aclZvSGdJUk0reGpy?=
 =?utf-8?B?WXJqVlBadmkzcHBQWERrYkNhYi8zcmJuTVlWdEphRG16aGtldzE5cnNUU3VJ?=
 =?utf-8?B?ZzhHVC9yRy9iOTAvNkg2a2pGVnZoeDg2dVhYYzV3ZGQ3WkNxY0VzWUttYy85?=
 =?utf-8?B?ZmpuaHJrTmJIblNCMFloMElvUTluOEcxY3N5SmJ2cXgvVktka1hYMkhPMUFm?=
 =?utf-8?B?bXFRZjNTcXlXeVNsTkpuMFVGNDR3azAwZ1A5SWtBTWttc0hTd09EdHBHdklK?=
 =?utf-8?B?U0k0djZadHNpblNrb2FMQU90UnlxMC92MGcwdWVOM2toR25ZMzVsMU5RVWpx?=
 =?utf-8?B?RExGQ0ZEOVRZSmhxTDdiOXd4SDE4T0xXQ0FlOXhxOUwxeXg1VUdLc2pJTWNJ?=
 =?utf-8?B?bXN4OE43amNnc0NkVWpQcjA4ODJoMnV1T0Nzb1dWdVo4WjV4Z0l0N2J1bVdZ?=
 =?utf-8?B?MXk4eHZpSWVFbTBOSlZEYkdSeFBvVXNDMDdjMEVKOXR2YmNqM1dBUTZkMjdp?=
 =?utf-8?B?dC93MXBsR0hLL2xha2IxNjhnc21Lc3JSd2V0WjVab0djWldoUXZEY1BLQ09X?=
 =?utf-8?B?bHFWUmZMTDFwZXZVL0I0R3lqQ1l5ZGFNd0dMREFlRHRKZTRHVEVkU3h1VGJZ?=
 =?utf-8?B?QS9IK2pEbURSMWxXc2c0TnZrTjZ5WEFRaFJXSU9wM0lGNXptTFlTdi9ocEpE?=
 =?utf-8?B?TmU0NWs0L0R1dlFGWmdOZkZRSUs4TWZVSnN5OW5IdS9QOEhveVZwNjRuK0tE?=
 =?utf-8?B?QkI1M3B2ZnZIYlFPak9sS01MZjlJdWJYaFBKdkFETkFOTGJudHJpYUlWdnBn?=
 =?utf-8?B?QlBvYWl3TWlUemRWMVU1VTJzSElBYmkwZkk4bXVESmkrWEIva3ppMWRWL3dh?=
 =?utf-8?B?c0RjRWpKODE3YVljTDRkZVh1dC9JSlNrTVFiNE1iV2NkTytuQldqaHMyK3J6?=
 =?utf-8?B?cXlFVnM3TlRkOUc0WnJlL3FyOGszT2hnT3pETm1TdzRpd2hId1l0NzlROGp5?=
 =?utf-8?B?Y1ZTazNudC9ldTdZd3BYdWpxbjE1Zi9xVG1MTFpjRG41V1dGQzVuNk9WODZU?=
 =?utf-8?B?cFFPdVJMTHkzb2JYbDZVdU5XZmlTYldZNmhUbUlOdzVUNk1PK3dVNWN1VHdI?=
 =?utf-8?B?SnFRZDczUDZuVkM2Uk8rS2dwa1REUXd3QU02UzhTek9VQXZiS2l2QjVwODZW?=
 =?utf-8?B?VG44NTBFVXhoVnJnTVdSazB2VXVQa2RnWGZ1Y3c3a091MVdjSk5aSGRJeTNq?=
 =?utf-8?B?ei8wb3dXRzZvdzJvUmtYaDU1RkxGRGJsQnM3cHBMNDdVcUYxa3hSVkxPVmd4?=
 =?utf-8?B?ZHY2OUhFQU1oWUxpblNMUEk4Wm1WdVJaZXJWOUxYaDVHWmNkVmE4WS9YTTRW?=
 =?utf-8?B?TElOODVQaENHZUdoTU5Ebk8xS1JtUVlHYVZVWmtsQXdOK0pmc1FycEJFUm1p?=
 =?utf-8?B?S0VuV1BYclVjVEczdzEwZ0d5K3Z0NSs2SVl2blM1M0ovb2ZvdlpJaTYxUEJq?=
 =?utf-8?B?SUZCK1VheG02RE8zd01TSytDcHB0SGYrZzZYbTYrd0s2SFMzaG9wT0xNeXJK?=
 =?utf-8?B?N29FRHh6ZFllU3RaTGlUL0N0bGVhU2NWamJ6QkIrTVhhQ1RhWit2T3ZPUlJJ?=
 =?utf-8?B?SVpQZDRHaUpIVk0xSGNZZENJK0JWVVd3RlYvUFIyVmErYjZWZEJEOGdnNVJP?=
 =?utf-8?B?ZHZTMVVDbEl0U2E4MnRvbEhBekh3Z09iQ0ZQNVRLRWtDMmhKZ0pXaXp3akhP?=
 =?utf-8?B?UTRYZ2lWd1ZLUEY4eC9GazhZRGFwWUtiaUxwdmx6UHNQVW9KMm5tQ21kNVRL?=
 =?utf-8?B?N0tSWHBLNGFuR3pZM1owVjlYbVF4ZDNvMjNxOThSS3FDbTQ1Y0IzeHNRYVc1?=
 =?utf-8?B?OHZveVpMbG5DT3FYSWw5aDlmWGczdGZ3YnpjNmpCZnUrRjUxWnBzcTltYnlM?=
 =?utf-8?B?Ui83ZCtxVmEyM3U2ZmEwL25MQzNpRXNGM0dMcUZWS0k2TXlnbW5JWXl4bGE3?=
 =?utf-8?B?RzhwS3lOdnVGVkl4UVF3RTZIYTVJVmRVUmp2QVh6RFlFa3pCQ1Z0SExjbzFJ?=
 =?utf-8?B?L1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eV9Tu9qn3zzgkqUWmbKrOdNIZ68geE42+5gSUh4K1nGn15bi7VTummp9hQkfSrcoWnHI92w6jQL3OE0pku+fzDCTRNvfGmZ9r/VYlNghxbu/Bp7EMDXOPDPCyzseLdJ2ElNH1e+fp0qczRTPXYU8kThPmAWJZH7trDdqo8OW21G1xCkmltV4zUDz6WCuFJXdsilqJZGEuXS+6xz/WtddnAM79nKLYFAk+dEW38coexRy4ZxkinSaVvMLItGf+8V16LsrfRaOQVcn+EanWGwLcJ4idtfq9Yu+CpEpBNEaBfZ4nZeGZknPK4ypf5BRiI2+2AHSjlIwVyLzpWcWGKYjyzlDOdUT+DpqLehP48wIRj7qkZe4JDetXafBWRdC4VfUjhc0KVLZHsQzEB7vbK0GE5QUCXCwjiD/QY1ztQjlDFncopK+5SH0vUzOXVvbTHPDQpN/Ws+yHdvE646wYQYVZtTsg21WdkEtE+jV/TxovV24a1IQftvlQWm4LoJec043oA0H56svPI/ug98oQ4odhQbZsiZNbwT2QTbQBXGD3EkN7KhnVbdHjzzZ/LygeHKkNesaxn1o2dST44IlgEOuQMETq08YEa1fSUO24xcMqQg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0d6bb6-9cbd-4165-2599-08dd03c8b319
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 09:51:09.2396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKWXbyGz3sqbR8xSxc4L3JvjYs4dBiYtssjpkEAGCl6+p86k9ga0XY8v55i991F8ksxUB2TCFCeZ+w+X25of8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6374
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_09,2024-11-12_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411130086
X-Proofpoint-GUID: 7hkaQgOSSZWNZiI7_ejPTPiL3aki57R-
X-Proofpoint-ORIG-GUID: 7hkaQgOSSZWNZiI7_ejPTPiL3aki57R-

On 04/11/2024 12:13, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Now that bio_split() can return errors, add error handling for it in
> btrfs_split_bio() and ultimately btrfs_submit_chunk().

I have a couple of comments, below; However, since I am not familiar 
with the code, maybe they are invalid.

> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
> 
> This is based on top of John Garry's series "bio_split() error handling
> rework" explicitly on the patch titled "block: Rework bio_split() return
> value", which are as of now (Tue Oct 29 10:02:16 2024) not yet merged into
> any tree.
> 
> Changes to v2:
> - assign the split bbio to a new variable, so we can keep the old error
>    paths and end the original bbio
> 
> Changes to v1:
> - convert ERR_PTR to blk_status_t
> - correctly fail already split bbios
> ---
>   fs/btrfs/bio.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 1f216d07eff6..7a0998d0abe3 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -81,6 +81,9 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
>   
>   	bio = bio_split(&orig_bbio->bio, map_length >> SECTOR_SHIFT, GFP_NOFS,
>   			&btrfs_clone_bioset);
> +	if (IS_ERR(bio))
> +		return ERR_CAST(bio);
> +
>   	bbio = btrfs_bio(bio);
>   	btrfs_bio_init(bbio, fs_info, NULL, orig_bbio);
>   	bbio->inode = orig_bbio->inode;
> @@ -678,7 +681,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
>   				&bioc, &smap, &mirror_num);
>   	if (error) {
>   		ret = errno_to_blk_status(error);
> -		goto fail;
> +		goto end_bbio;

eh, I am not sure why this has changed (and we now skip the "fail" label 
actions)

>   	}
>   
>   	map_length = min(map_length, length);
> @@ -686,7 +689,14 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
>   		map_length = btrfs_append_map_length(bbio, map_length);
>   
>   	if (map_length < length) {
> -		bbio = btrfs_split_bio(fs_info, bbio, map_length);
> +		struct btrfs_bio *split;
> +
> +		split = btrfs_split_bio(fs_info, bbio, map_length);
> +		if (IS_ERR(split)) {
> +			ret = errno_to_blk_status(PTR_ERR(split));
> +			goto end_bbio;

Do we need to undo the btrfs_bio_counter_inc() (not shown)?

> +		}
> +		bbio = split;
>   		bio = &bbio->bio;
>   	}
>   
> @@ -760,6 +770,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
>   
>   		btrfs_bio_end_io(remaining, ret);
>   	}
> +end_bbio:
>   	btrfs_bio_end_io(bbio, ret);
>   	/* Do not submit another chunk */
>   	return true;


