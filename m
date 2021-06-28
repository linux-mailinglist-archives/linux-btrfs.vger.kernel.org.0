Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723C63B5CD5
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 12:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbhF1LBs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 07:01:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:49122 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232745AbhF1LBr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 07:01:47 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15SAoqGe016457;
        Mon, 28 Jun 2021 10:59:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=bO46emdHPFhc6bAMkrEsB/RavL6cKd05nRY+SgCMUtk=;
 b=jqXQkOZBkB553KGh/PSoCepasg0/J9X6yX2Uc9w7zPE1gWABilt36PrGxjgbxIk6KM0c
 DNSeYZHtzGlsLWM4AsBttCcNrOrlTrsb6FObwuwUR/mE/knfPJasglCdW426jqisy+eA
 oB41tgg+uuqJRc3cOrJMcqxC95MwHyhnaPgc0+kYXfD/F32E9w8us3z8ObsO9fWyj0Gz
 mJdfsp+VnSxY26XRCemd+Fx8wktAA8sMDvtQljg4DfhHu2G6NCbpVC60hKPlh4aLRNdD
 BYiBhxDVmevio7ybt6QKKAHkTCzzj2/wMnoBBcyYXJdDTDPqU6RqvFq511Nxu0CLE/gn bA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39f6y3gr9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 10:59:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15SAo1RW169380;
        Mon, 28 Jun 2021 10:59:18 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by aserp3030.oracle.com with ESMTP id 39dt9cjvcb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 10:59:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQPxLLjGby+mcHyr4JoZppOsAPCzYmOjdsUr5M9EnVSmrovFPIUzob2TrfSaJf2dcshT32S6Jy21D6FAAEnuh0UwnM6QdEFV+6ZQUfpLEtkZ1RWnVRwhzStbMopYdm04h12KQzGLMOIi9Vri1bp7BNeqItsN+h+RRfkkQNgkZe2tUlwDWG6elTlC5aY6wbez+fVnjVCK+C3OZUWf+WTbUrQEip60G6Fd1D5qyRIVstKxmANQcbrBCso1d8cQ0nzQ35mWet6uRVeuIzfOlOmGVPklIBQkPtdhpuzSBzpGAgHTHDUOc7sbt27k63faZe1Ofn18Jn7OA6Tozq9pGtaClQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bO46emdHPFhc6bAMkrEsB/RavL6cKd05nRY+SgCMUtk=;
 b=AGGjpnZrFfbbz2rdRYuxdCHjU9OeivaQKvDDgK6mz/0p+CNNfU4rjX7i8EPrdKsUJFDEWIWDq6NdnVdBFUjvYMEX16vH1oHdNpx20vepzQSDIxS62imm4pyvdeD5LfOMHmU72Whj1mik4He6SC8+CjZ/zJ4zYghv1QMQwoGXVWj0L+lmqGkq6qZ35L/sh27FWKvYigu19vB3Ec1u4h2n+DJcrbZElki1x+EeQTI/3uEz88J2ORi3t39k22K5+ZBwf8Hi6uIoAYEOhaQk/dwEMRPp3XtJiU43mv+EdGFSF2CbLaJs4SE7w4U0nzrdOOLltpUOpdmMBQNqykx5su1k4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bO46emdHPFhc6bAMkrEsB/RavL6cKd05nRY+SgCMUtk=;
 b=bc/ePlJ/4cI972iUR8OJkW3Gcne65fqVwMCNArMdErwq1Go6vozTJOeOn9lKcHc+xfIzvDiQ5zfA+1IjTA1Kr0LMwedpQ3uE9s9ZnQUEEu3oOuY87RCGlWf2gH/mWGGc7fSuqMghCkdWSsxBRQEWbSOYHqIiUq92+xKAB5tiipY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3904.namprd10.prod.outlook.com (2603:10b6:208:1bb::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Mon, 28 Jun
 2021 10:59:16 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%3]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 10:59:16 +0000
Subject: Re: [PATCH 1/3] btrfs: return -EINVAL if some user wants to remove
 uuid/data_reloc tree
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210628101637.349718-1-wqu@suse.com>
 <20210628101637.349718-2-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <86641e71-1e93-993c-4463-e73328725740@oracle.com>
Date:   Mon, 28 Jun 2021 18:59:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <20210628101637.349718-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR03CA0140.apcprd03.prod.outlook.com
 (2603:1096:4:c8::13) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR03CA0140.apcprd03.prod.outlook.com (2603:1096:4:c8::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.8 via Frontend Transport; Mon, 28 Jun 2021 10:59:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a7ef348-4268-490c-f173-08d93a23c557
X-MS-TrafficTypeDiagnostic: MN2PR10MB3904:
X-Microsoft-Antispam-PRVS: <MN2PR10MB39043C1508FAF1DF274DAB76E5039@MN2PR10MB3904.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0/QWNSzmeiaSuO3S0NA+3t9p08k6LmD9Zb+2yXHEw8auF2JXSdLucrDX42vRfOeYoMJSdbTjcxEuYp3tGNXyGGi+llBv5UTE4u0fS5L16gjrDh7OwGQez8NJMRM+FFV4LXn0V76+Ef1iyHwtZ0saY9IRsx71Ft1U6Qub+M+Q/B75J3+hw7DmLF7oJCtVEyc3ge8ELwZBbWeHKVxucHBg1abP1UJu1vf7f4q1dVGgwSihSkx5btDDRlfw8CnS3b8G9kVf2ZlGYBSBBNjnt/ig94uErdqz6nrGN/Dz+4X65zGKROycgx7w2VZ8w+FdfBhlB83HyN94bYpPVFgF0IiOfvR2apTtpat/qUERZKkzp6mavWLobYOBSINdMa2LJR+xSlKZTRnM6o5IJGTwCDF4Rb9X/tM/rsqg7x+qOZloM6sQuS/c1pTVcRCTpu06B7YM0kMCCxBDUvDhOD2V3oBpJK4UfqbBWG/zE/ZpcaZ2Y8hre4oXVgvLrGnkUDLSSQtvKavAYbBcY6++0q+MT/2F50IoYDps7IEegxE+4x9ym1cDcuDjYJ24rxM4c2bPHS8d9/+cD6Bu7rSibhVEuRV7NIUhs22dad1hGn3/jYc8o269of41EPgwnjSiH574Ugiia0ZJy4BrDQRQeG9r4GnxVqBg4xoLVgwPftB8KBlC10eTT1gNiTjE6zHYvHTS2NTvyoPVGmmY2KsYQN1oHdjwr3PkSeLBAVnjY5nVetAyFl8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(136003)(366004)(376002)(396003)(956004)(478600001)(8676002)(66556008)(8936002)(6666004)(44832011)(36756003)(316002)(38100700002)(16576012)(2616005)(66476007)(66946007)(26005)(186003)(16526019)(86362001)(5660300002)(53546011)(31686004)(2906002)(83380400001)(6486002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFFEY2JZUzBWdkw3TldWWkVXMTEzT0x0aGU2Tko3ajEybHg2TlgreENaaExp?=
 =?utf-8?B?dmdLOUJQZkdNQ2UyL3RGc0Zrcmt4QWpENk1GU0o1SFVsR2kwQk9pVmI3RHky?=
 =?utf-8?B?NUhuT0llQ3RzSHkxMkNJMjBhdUhoNGFncXRZeXRHMUJkeXh6eWZ2eFZIa3lU?=
 =?utf-8?B?ZUNXSTNNRXFXQS9sRmxOQldzbktLUzVwenU0L2ZjMi95VUdEbHlWYS8ySUtO?=
 =?utf-8?B?b2xWRW82d2pJQlNJSFNKRGd6WFdoamlUZHdETVlkNythamNMV0tGQjFmSXVN?=
 =?utf-8?B?VzltTFlNR21MVENDcWs3c0VQVHRvQ3FIYWREWnNpQVNwMkNUZ1g0OWJ0RlZ1?=
 =?utf-8?B?d2VXQmxsNGp6b2RuYXhUQy9yTWE3WjZYZldTdEF1aURYdUxPTXZraXJxdU5v?=
 =?utf-8?B?R2JmSHlGajVHbDZLSGlHWlladDFkQ01Eamg5WHRMdndzWTA0L0cvY3BZcjFD?=
 =?utf-8?B?R09saDRYK3JDWDQrTUZsQ1kraUtXY3RFYXZuQlBCaWdRaE81K2FYQ0JkOGZ3?=
 =?utf-8?B?dUVIVXZrNzBTOXFoVjB1UDZqcnNqNnVlOS9GS3VycFQ3ZFgxUTUwQnliNHhQ?=
 =?utf-8?B?eTNBclBnT25yOGhIc2ppNzdMbFhUMCtDbWcyemJrQjdENXE0TU5GYUVnYk44?=
 =?utf-8?B?WGtRZmJJQkZuVUczWU01Nyt2V0NJSERvUlUxS281bmFxNkxSd3ZoY3JWbnFl?=
 =?utf-8?B?YUc4ajVsd29hcXFTL2tvU2hVZzQycjIrNHlzdUt2MmF5MFZ5Tmo2emFGNXUz?=
 =?utf-8?B?T3N1bkxzZ0g1ZzRJd2RMUGxQVnpQUGcvK1ZrRVM0b2dXRzNWWU5BNFlxZFRU?=
 =?utf-8?B?ekZua3l6ODFpSEpZTVY0M1RoMHVBc09WY1A3a1d5QXI2UXFCK3RkZnFISTVB?=
 =?utf-8?B?SkdQSEMrckRnOXkvOTlxUFRzOTl4RlVQOWd5cTMrQTZQUmxvYVB4WUg5QWZp?=
 =?utf-8?B?MmpvOTBwYlBEVzRjTXc1K1JUQi8zYXRHejR1SzgzaXlnMTJVd1RMcWVZU3FK?=
 =?utf-8?B?ODgvUGZMRC90MklicWlBSjhmc3lBN0VjRmh5WVFNa2xWQkpjOWlkUndqM2Rr?=
 =?utf-8?B?T2pqbXdFZi9WeWRHNjJlTjcrbWpiR2JWSG96dzJKVVZIbHFIZHEwbkRPeVZo?=
 =?utf-8?B?K2pBdDhuRzREMllkYXpTMWVXa0hFNFpKOE1yWTh2ZkRycElnak4yMVlpMlhO?=
 =?utf-8?B?NkdXSmV1S1VVZlpHbG51QURGR2o1czc4QUdiSzVIN0J0Zkl3WVp6NmxyRU1u?=
 =?utf-8?B?STZPaGEyRzdldHBxamY3aXlrYXI2TndBSU1LSHpRelAvMEFJWEg3QU11MVpk?=
 =?utf-8?B?cVhmRXdxQ0xUdE9Fbyt5Z3luT2MyTEV6YkRyZU0yRnJQTnFpYm8zb2I0Q1Z3?=
 =?utf-8?B?NHBBRXhWZHhsdmNFMVlZR29zd0VwOWpKZHI0cURKV3k4ZTMvNGZDTWNhMDBr?=
 =?utf-8?B?QlVmVWFxR1RaU1l0RjlXMWhOa1dpSlNORjFpLzFUQU9oZEQ0dlRCdFNGYnRS?=
 =?utf-8?B?VWpHemJiQ2R1N1R2VW04WHVFdTlhUW9MRUVGVitmM1RIWnZlRGw1T1ZwMEdV?=
 =?utf-8?B?ZnI5K0pDQVFOa2hFMWhQcHFOM2czTG1lU2MxTFdRLzMzaDBiYjNqbU56Tk5s?=
 =?utf-8?B?MnFzMmtqeEI5ci9HdWNYSDlUbWo1TC9jUGcwRExrYWtRWkFmMkhpUXFvYTlm?=
 =?utf-8?B?dzVPaFIwUEtHSURYRnZxN0FIVVhiYVVxNm1Yd0NBTjhoUW1TSHlnYkZIZkdl?=
 =?utf-8?Q?xIl05rgpKJg8vGZqnAaF23z/fsbTVjN+Ee0PYa/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a7ef348-4268-490c-f173-08d93a23c557
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 10:59:16.2291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2snxoCW/Y3xG62Sh1u6BAQsB5RkEtKAf8ZGEUBgEohPEH7zALhnONxoR+DcDksWSPlH7xzrm0tnK5WGXkJLbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3904
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10028 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106280076
X-Proofpoint-GUID: 6DYg3pSZRi1QPD2Q-BEN-sVyRvkjKmvL
X-Proofpoint-ORIG-GUID: 6DYg3pSZRi1QPD2Q-BEN-sVyRvkjKmvL
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/6/21 6:16 pm, Qu Wenruo wrote:
> Ioctl BTRFS_IOC_SNAP_DESTROY_V2 supports a flag to delete a subvolume
> using root id directly.
> 
> We check the target root id against BTRFS_FIRST_FREE_OBJECTID, but not
> again BTRFS_LAST_FREE_OBJECTID.
> 
> This means if user passes rootid like DATA_RELOC (-9) or TREE_RELOC
> (-8), we can pass the check, then get caught by later dentry check and
> got error number -ENOENT, other than -EINVAL.
> 
> It's not a big deal as we have extra safe nets to prevent those
> trees get removed, it's still better to do the extra check and return
> proper -EINVAL error.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks,
-Anand


> ---
>   fs/btrfs/ioctl.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 0ba98e08a029..889e27c24e3a 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2932,7 +2932,8 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
>   			if (err)
>   				goto out;
>   		} else {
> -			if (vol_args2->subvolid < BTRFS_FIRST_FREE_OBJECTID) {
> +			if (vol_args2->subvolid < BTRFS_FIRST_FREE_OBJECTID ||
> +			    vol_args2->subvolid > BTRFS_LAST_FREE_OBJECTID) {
>   				err = -EINVAL;
>   				goto out;
>   			}
> 

