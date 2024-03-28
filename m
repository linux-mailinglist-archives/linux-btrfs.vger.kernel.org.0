Return-Path: <linux-btrfs+bounces-3701-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5251B88FA14
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 09:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 088522954EC
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 08:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12785380F;
	Thu, 28 Mar 2024 08:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PQwe85Ic";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qXwi1Ciy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF3351C43;
	Thu, 28 Mar 2024 08:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711615281; cv=fail; b=oHfPlBcvSOO8l0nUU2nPm5VHqaxLxmzeBF1fx7zuxyFJZs5dRota6FYAZnb+YJvOTn9MF2nNfKaXYMQiHSSJdqYPaUhNrUVYqFrSSqd4ZBpKhWvFXPjWemsrQNFiWpn7o8eBNRs0NUcNCq5Br9B9wLSP3EDwrDAOyjV7yNT47gI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711615281; c=relaxed/simple;
	bh=T/PmX7VkuyuoHp3km6thOJnZLamJ+Cb8DG01zYfqPE4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D1Fry1QLDPWShk7gte9WTmGv1a4DWfpgHchKlMGt47xBdFEDSYOAFeg3/7TYBoLnhXmZT70oPDXF0OWXxBtsh+BpnCN9HgV//LFH7buDjPqWocVWja4u0ocBUdVGS1xH2m7vkjsnUGZmIehQSqjYfm/yISjC3SluQmYPydvJHtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PQwe85Ic; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qXwi1Ciy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42S7BXxO020333;
	Thu, 28 Mar 2024 08:41:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Pkhguf6tO9Nn7kU0E2ipw4MsTznfOiUONRn4lHlqd5Q=;
 b=PQwe85IcmyvcPx6NbL2mvedJRQqbOLSt0PjxzqXMxpGjZ8QPSiEmUBmL2pXkri5OUXq2
 y30tSsdhN+pxSHsipVaKtOWVXFF4OBxO5zS5kud+YfhetH44WaWYErc+uOuB4y9542dB
 WqJKaWOa1tSOM1yw0xM+x2Ocwq2N/VFOtXPg37z0fKyRDA2GCUHZEsxp7fr3KYewl61s
 n8HUaGtmyeZHVz4ZCvGHSmLPLHn18ElfXsFPw+fUos/b7C99YqiscKObcdppcdayXBcL
 9Emw92Dt5IWjZXX0tc9bCHu1tU3GqfqmaAg1FU6JxzuhYdxo8Vha0/3PM7PnJ9yQqidT 9A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x28ct8hmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 08:41:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42S6hMAc015060;
	Thu, 28 Mar 2024 08:41:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nhfxrya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 08:41:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6C+lK8AKAWYbb/YtrJo7T2HTT9GXBhGhP8MDDbMJMbWO6rriKVnFAZbn6YqqS8gpn815hSlOUm8IM3I4Nbt8s/FWHjkD2RwEMmEzW7tVYCVq4R3RvkAo+g6PUcWepeBEn5/IhB2IUCyXjKyE8YvnkCZarHccMSpGx0ODfsG38iSIeh5pfEZYEgIWkpEgxhssKZqjBgpFOkVCnUt2RED7ndkvMKnhOKLJ+Oy1cBhX/Z2Rp5ma+G4Lg/QXb39QmImP2tPNJw6gl91ltrjGBSDBysgo5rs73kH8V2AcUDFFK69Q0quMKu0EzSBv1cShvH0bralHA+pZPG5/ZMz/u+YHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pkhguf6tO9Nn7kU0E2ipw4MsTznfOiUONRn4lHlqd5Q=;
 b=dlM5x+8aDcDi+eBZkvCoiojl2ae2JXAvKgHpeWw1qaAzltvhfIwfcsYxwb4hRg4oL1yFJVYW8om6+HJ/mFP9zcjRnk/iB6yb9jgHjhz4qOUeU7LKQI2BR5s+kEEHtnFNsa4phLiGo9HGbOgf26mgG/c6Qc9zb4Yxf+8rWGlrtutC6qy625c2gJKpnREPKhSxup2hJBFiB6WkX13TdYg6GJZK84GopxuhHDbEDvVbXaVZ4nGNEdVXJZp9IJZtu10R+ZwQtoymTbJLsKigOW9/KKpG9a+sln4XRMAO2qVBSankuLO/XYYQqYX+VAI+tAZd88hIgQRAIpTp/6x97HXWeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pkhguf6tO9Nn7kU0E2ipw4MsTznfOiUONRn4lHlqd5Q=;
 b=qXwi1CiyxSTxAiR8JSKCFXgpgvuHVxgb/WV8qKN25esYAHO4EB1rKs5KYuh0AMt/nzY3mb2Y6tIr/d7DbfJseC3BhbTMCdFZ6YnwYFQVMY9fsW30JMGzh6aOdIY1ACfxIUJLHULr9iKbHzr0KSOTnPh/Ks5njkChjqAsgDu9e8Q=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6084.namprd10.prod.outlook.com (2603:10b6:510:1f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 08:41:10 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 08:41:10 +0000
Message-ID: <82afe79c-3408-47da-b0ff-346371263689@oracle.com>
Date: Thu, 28 Mar 2024 16:41:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] btrfs: add helper to kill background process
 running _btrfs_stress_scrub
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1711558345.git.fdmanana@suse.com>
 <091a8f4e0211299e21c3a3231584d0e8dac49ed1.1711558345.git.fdmanana@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <091a8f4e0211299e21c3a3231584d0e8dac49ed1.1711558345.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0143.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: eadc86fc-c1b7-49b4-7e09-08dc4f02d17b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0PO1hDK8pklDA+UWlV51xw1COfzySCinUtdMBeOBJ8kY2faJ6tNxp+QNrTfIadUMPtrykwfl5WTNPYkovBSH7tujff7bdjsow4yQs/f+TBrZjxhyG7eAVaMmk0Pw1ec9UL3xkcUFL8C0oLUSc/sO4z0TFiBdrnt691OxxleU9n+eKERBtWEjZhYlbrB5oTogYnlI+esYp8tUlywZIP0ua8QxOij93shnVRfDJ9Y+O5Dy4LHjI1WlLO/d+pTmZFEvMLLN/1h2xtGiSVqnTiCHJcLbiotUDGc215fv/z88PG9Zg8m86Wda2Ccfg9IrXBYrGyneDp2OBka8+eH+N7va2o7qbrz6t0lx55Av9J15YKHCpGIltiKYRXMCOOESraqw9urDSBXLD4S1iwJ5l1caHwg50Txu5psDpEFeOFaXSj2/6Zw9udx5RCYhQKFykCFMhK9FjHp40+c3inKQyLotUv3tZlDef9gjWiJjdu6x1l3J/Tj8Ipnyjoc9DMMsKcKvdtQKnBNSvfV6cDrRTdzUvVP6MOzU/N8UTsMbd24Zyf4dHq/y4wcedLmCKsmdY5pIFA5KWUxpz05xGUk535KxWpAgFdBzr3UAWIqXthXj0Th4Tx6h1ytS90FHgLdU0eAumqvvaR1eZJSNqwmvEZmjtgAIv5wsTQH3vn/uET6FTHg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NW9Xb05ZY21hVmZLUUlyTzRNQStuWFk3ZkRVMHlXR0IyU3dkTUFjYi8yODJ2?=
 =?utf-8?B?Vmsyd0xGY3JzOWRvRjVrZW1Tc3lVRDZlQlJPc1ZUNTR3L0xXcHJTbUY3Slht?=
 =?utf-8?B?Sm9pUzFyZGFhVE1uNExWNXMwNUxsc3VUWUNVK2Nib1pUWW5wZTZQbzN4bWgz?=
 =?utf-8?B?VlBPa2pKWVlzRGM5cE1maVpiVHRFdGs2OFBXMTNLQmErZE9WQUtsRTlOL0pj?=
 =?utf-8?B?MGQxRVp1Tkt3REJjMU9iVGxJSnozYVBUajkzbm5uckNOaThJNG5JNkhOQk1T?=
 =?utf-8?B?OHhzVEFqc0s3b3dqRkRsTGp3aW9SUlBTL3dNOXI5WjNVRmFUdzFubk1PcG1F?=
 =?utf-8?B?RlFuckkwVTFleUhhY1QyWXNQUHhLQjlDV29KRktVbS84K2E4OUFsMllxZytV?=
 =?utf-8?B?SW9mbnFFMUpKNFBGVWpSdTNPVVJUVFdkaFFxWnNpM1FXbndMTEQyNXhwZXpu?=
 =?utf-8?B?ZkE4ejJNVWZtK1h5MThnSmxEZ1FoVm1Sb1lvaS9VMGVYd0RwaCtQeVVDOWUx?=
 =?utf-8?B?STdGWjJYTWJPd2lldm9yWUdKclZxdVBxZ0c0UUJwM3gxRkhEWVhlVFBjY1I3?=
 =?utf-8?B?WG1WcTl4cHduTTRqZXp1NWx2Y043eHgyVFhBRHN5b3E4T3htdGJwN2pidGg2?=
 =?utf-8?B?U1FUZmtVNURIeHgvRnVXZE9IQTZCajhGSGp5SnJkZDNZS3NibncrVDJkejhQ?=
 =?utf-8?B?YlBoRit0bG8wVU5zWXhlNWttSHhOSkowaGE0ZHd6Y2VHamw3R24rWHRIWW1p?=
 =?utf-8?B?ZXR0ZGhnaVdoZ1puaVFCR2lsZ2lOaDhGTnpXd1JNMU5ZNGR0S0lSdnJIQlJj?=
 =?utf-8?B?eTB6MkFJcnE1ZzdtOEI4S25nK0ZZYkltalVnUW05ekxyS0g4RVhqa214QUpo?=
 =?utf-8?B?S2JrL0lXRndSNjVGOUtyVDh3N2laRW9IYzBnNFo3QUhZck9mUGpkUXUxVXdk?=
 =?utf-8?B?NTc3L200bW5jelB4L3B5RWhnUDI4eTdVUDByZC9ycDRYK2lkNmY5S3NvckdH?=
 =?utf-8?B?TGF2Vm56WXJmQ3FVOXVMZ2FrZ1pTNVc5dU5WczBUbFlYSFdhcFZYeGd2Q1d1?=
 =?utf-8?B?a0NRN2VZc2xnRHdJbk9uMnAzU3BpZVJoS1d1Q2V0QjdGN3RKTis0RGFRY01M?=
 =?utf-8?B?eFVGYjFYWUErM2s3RUdIZjVCR3lMUDM2bmhRRWFVZFpUakRvVXVrU0hEeWR0?=
 =?utf-8?B?NTJGVGEwSkJaREFVYmhST3YzMFUvNzZxUC9kSXNHd0thclJkbTN1OFkycmNq?=
 =?utf-8?B?aXhQdTBqR3p6Y0s4SS91VVBmNys4L2tUYldKaUhLSVEwSjJaWk9JYys3R3ZI?=
 =?utf-8?B?R1dYS1BzcU1wWTFUbGhGZzRmZUVFMm9KaVpyaXN5MUFxZjQyN0pmb0pzOU92?=
 =?utf-8?B?YnBtV1hQWmJJV0dwSGNyWW94Vy9teGppa05sTUJ2dkN4M1FvUmNvdjdJTlJ6?=
 =?utf-8?B?ckRKQ05CQkU2akZFVGRPVEI4NlNzRWhoS2gwL1NqbzlWWW13bnBrekhDL2Nx?=
 =?utf-8?B?ZmoxeHR6dHBiVno0Mm5YNFUxNVM2aTg2YjdYbTl5K2kwTXVqM0gxTUd6cDg2?=
 =?utf-8?B?cjQ5NGVyYURuZndvdWk0T1ozaERhSVBuTVdiVDNsakNiaHpoRFJyY1BmRWJZ?=
 =?utf-8?B?aU9vWjVvT294SmJwWWtGUStiakdiV1FGVnFsKzRnbXFFUUUrQlhWaFBPUTZj?=
 =?utf-8?B?ZUNoczhwOGh0ajF1bnNiSTBEZ2RSSFBqQ3BxbVUxWFBxbVhTNS9Nd1lpcTY4?=
 =?utf-8?B?clhkUjdTQVBsWTY4blI0djNEWnJiN0JkSHM0Q2luUVA3Vjk3RDIvazZOUlZ5?=
 =?utf-8?B?S2gyWFpQL0l4aHVmSVFsdWZ2VFZTdkxUakJZZmlFR3ZESFhvcmdqdzBEc21q?=
 =?utf-8?B?c3JSeGdvdWtlUGFtQ0poL29OZnhJS25FQVgrZDMrWUdEY2tVQTV4L3p1V3Zv?=
 =?utf-8?B?aE5FL2N5TkdxdGxhbFErZUFVbjVNbXlKbExheERCc2UrcHZJbXh0MHpvL3Mv?=
 =?utf-8?B?andFMDFjL1RJdUpZSzNXU0RMUmhZUkNLbEpwVFpsWjNqNDdGbDNDeDE1aDll?=
 =?utf-8?B?TjFreXJvWDdjdWdHbmFvMGRHT2svQjl0b2F6S1NaVDBYdnFhR0dmWjlBS0Zj?=
 =?utf-8?B?Tm9FWmhqbFNPWC9tZnhYT250MCs1S2ZxcmovNVBhUVh0NjF0bWJ5dkdXZW1L?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fPaHMTeGaxfHm2rjQfDKgO4ROp//O67syzlDZLElKs47y1rPYefQHkL0SSfX4VAYlBJY4UjKs2OTBpvf4CJfr1i64Wz8mvwB47M7D1VlPfSHsq8sLgOoCUMPU2BygzCSEm0I3DDAwCZB8+3ZUwDBrkgQ6qUmh3V9ZT6cpSdb2WX8CTmiNw5LdZEPD54v9+QRF7xL1v2533F6OnWUYnTBONJV40D7lD2uBFSE4xHXJw1q2QOoP1kA9LjyOaqyVoW7R7NZCPlNG0p6MLzYjrcXXax+3k5+z67PojB5bkCyOdPwj8Th2l2Ct+hreUOCRc4rMGHrvPxm/qrxvOebeKacymix5c5CWUlfhWqNACflAiqmMhgDJDbGrUHa5x5HwesJlx1MY2QaYt9fd1S+W5g1ZUvDOpU+7FF4HLi5BomNul3+ZDTDcog0Rna59ypJD/1oe8J5ipC8Up3VnpUBxQjSqnZ4G5IYQ4ZzjqGNrPTftDwCyu85B14+2y2ce8LoReleV5zRVRnPQCTMriBxAX+3Zdy3FZzzsAwV18JKpJjlX/p3OIoquwks+heVlGzQpesUYLaiZsU8uOF5pqcAeovgxUnFh9eAtVvdhjYpjNTYGrY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eadc86fc-c1b7-49b4-7e09-08dc4f02d17b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 08:41:10.6195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9HHRa/zcVYZLlKo44oHfmC3LbJucR0aukMn5hOqckCkt0/kOmQJ0ocgPhpvSunt5xHiIiZQzSrPXbpJj8WFt3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6084
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_07,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403280057
X-Proofpoint-GUID: rzPMZGMTbJqZHuyDDM_nnJ3fznPhqc2F
X-Proofpoint-ORIG-GUID: rzPMZGMTbJqZHuyDDM_nnJ3fznPhqc2F

On 3/28/24 01:11, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Killing a background process running _btrfs_stress_scrub() is not as
> simple as sending a signal to the process and waiting for it to die.
> Therefore we have the following logic to terminate such process:
> 
>     kill $pid
>     wait $pid
>     while ps aux | grep "scrub start" | grep -qv grep; do
>         sleep 1
>     done
> 
> Since this is repeated in several test cases, move this logic to a common
> helper and use it in all affected test cases. This will help to avoid
> repeating the same code again several times in upcoming changes.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   common/btrfs    | 14 ++++++++++++++
>   tests/btrfs/061 |  7 +------
>   tests/btrfs/066 |  8 ++------
>   tests/btrfs/069 | 11 +++++------
>   tests/btrfs/072 | 11 +++++------
>   tests/btrfs/073 | 11 +++++------
>   6 files changed, 32 insertions(+), 30 deletions(-)
> 
> diff --git a/common/btrfs b/common/btrfs
> index e95cff7f..d0adeea1 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -349,6 +349,20 @@ _btrfs_stress_scrub()
>   	done
>   }
>   
> +# Kill a background process running _btrfs_stress_scrub()
> +_btrfs_kill_stress_scrub_pid()
> +{
> +       local scrub_pid=$1
> +
> +       # Ignore if process already died.
> +       kill $scrub_pid &> /dev/null
> +       wait $scrub_pid &> /dev/null
> +       # Wait for the scrub operation to finish.


> +       while ps aux | grep "scrub start" | grep -qv grep; do

This can be replaced by pgrep. I'll make the change if there are
no objections.

       while pgrep -f "btrfs scrub start" > /dev/null; do

Thanks, Anand

> +               sleep 1
> +       done
> +}
> +
>   # stress btrfs by defragmenting every file/dir in a loop and compress file
>   # contents while defragmenting if second argument is not "nocompress"
>   _btrfs_stress_defrag()
> diff --git a/tests/btrfs/061 b/tests/btrfs/061
> index d0b55e48..b8b2706c 100755
> --- a/tests/btrfs/061
> +++ b/tests/btrfs/061
> @@ -52,12 +52,7 @@ run_test()
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
>   	_btrfs_kill_stress_balance_pid $balance_pid
> -	kill $scrub_pid
> -	wait $scrub_pid
> -	# wait for the crub operation to finish
> -	while ps aux | grep "scrub start" | grep -qv grep; do
> -		sleep 1
> -	done
> +	_btrfs_kill_stress_scrub_pid $scrub_pid
>   
>   	echo "Scrub the filesystem" >>$seqres.full
>   	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> diff --git a/tests/btrfs/066 b/tests/btrfs/066
> index a29034bb..29821fdd 100755
> --- a/tests/btrfs/066
> +++ b/tests/btrfs/066
> @@ -57,12 +57,8 @@ run_test()
>   	wait $fsstress_pid
>   
>   	touch $stop_file
> -	kill $scrub_pid
> -	wait
> -	# wait for the scrub operation to finish
> -	while ps aux | grep "scrub start" | grep -qv grep; do
> -		sleep 1
> -	done
> +	wait $subvol_pid
> +	_btrfs_kill_stress_scrub_pid $scrub_pid
>   
>   	echo "Scrub the filesystem" >>$seqres.full
>   	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
> diff --git a/tests/btrfs/069 b/tests/btrfs/069
> index 139dde48..20f44b39 100755
> --- a/tests/btrfs/069
> +++ b/tests/btrfs/069
> @@ -59,17 +59,16 @@ run_test()
>   
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
> -	kill $replace_pid $scrub_pid
> -	wait
> +	kill $replace_pid
> +	wait $replace_pid
>   
> -	# wait for the scrub and replace operations to finish
> -	while ps aux | grep "scrub start" | grep -qv grep; do
> -		sleep 1
> -	done
> +	# wait for the replace operation to finish
>   	while ps aux | grep "replace start" | grep -qv grep; do
>   		sleep 1
>   	done
>   
> +	_btrfs_kill_stress_scrub_pid $scrub_pid
> +
>   	echo "Scrub the filesystem" >>$seqres.full
>   	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
>   	if [ $? -ne 0 ]; then
> diff --git a/tests/btrfs/072 b/tests/btrfs/072
> index 4b6b6fb5..6c15b51f 100755
> --- a/tests/btrfs/072
> +++ b/tests/btrfs/072
> @@ -52,16 +52,15 @@ run_test()
>   
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
> -	kill $scrub_pid $defrag_pid
> -	wait
> -	# wait for the scrub and defrag operations to finish
> -	while ps aux | grep "scrub start" | grep -qv grep; do
> -		sleep 1
> -	done
> +	kill $defrag_pid
> +	wait $defrag_pid
> +	# wait for the defrag operation to finish
>   	while ps aux | grep "btrfs filesystem defrag" | grep -qv grep; do
>   		sleep 1
>   	done
>   
> +	_btrfs_kill_stress_scrub_pid $scrub_pid
> +
>   	echo "Scrub the filesystem" >>$seqres.full
>   	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
>   	if [ $? -ne 0 ]; then
> diff --git a/tests/btrfs/073 b/tests/btrfs/073
> index b1604f94..49a4abd1 100755
> --- a/tests/btrfs/073
> +++ b/tests/btrfs/073
> @@ -51,16 +51,15 @@ run_test()
>   
>   	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
>   	wait $fsstress_pid
> -	kill $scrub_pid $remount_pid
> -	wait
> -	# wait for the scrub and remount operations to finish
> -	while ps aux | grep "scrub start" | grep -qv grep; do
> -		sleep 1
> -	done
> +	kill $remount_pid
> +	wait $remount_pid
> +	# wait for the remount operation to finish
>   	while ps aux | grep "mount.*$SCRATCH_MNT" | grep -qv grep; do
>   		sleep 1
>   	done
>   
> +	_btrfs_kill_stress_scrub_pid $scrub_pid
> +
>   	echo "Scrub the filesystem" >>$seqres.full
>   	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
>   	if [ $? -ne 0 ]; then


