Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB3A423A11
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Oct 2021 10:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237812AbhJFI5V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Oct 2021 04:57:21 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:36224 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237744AbhJFI5T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 Oct 2021 04:57:19 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1968eCuE002189;
        Wed, 6 Oct 2021 08:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=u8yWZRiYQ2xXio47HetXs9RazatlMwToL9R+2jEs4Bk=;
 b=I+6PQ3JEv1fnQqt0OIKhRMYKlbGjrCkM0C+tt4RHN+0kHw5zxR2C+jAb9eDjVIYPd/HG
 3LLjpaEkXZQWHkx30tvQE9Y2bGqHf5/zPZmNH7vXPYBlF31+8DhieolIml9zDZZpJYlg
 Gwtv5IVNAjrpUWg9ZFkm2kncA8rc6KMbcYg6HhWNXqpQ2ocWKAtEnlJeUfTpnLPov9O5
 CQh65KHnpWm8hNAl8p/+AMecAX5ttGu6dW9ZCjiORNmqOGwHMSW/AH5sufjcqkBAHMTL
 4hV+9fDagsQ7zE2hBzQD6+OpX2G2Ob0e4wdvqmOr2suZEWJpSIxbb+RWg2Tcxw0WW9O8 Ww== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bh3yn1f1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Oct 2021 08:55:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1968oNaD056949;
        Wed, 6 Oct 2021 08:55:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by aserp3020.oracle.com with ESMTP id 3bev8y1cgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Oct 2021 08:55:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fk+lNihzghy0KAF8HCW8zUzdZAawq7L0EHTP4XjfA/0tE9UDJVf7FPty/AOlQrizYWr0/fBIo/T6mPDTGlwUoAh4QUzlzFGist5Y38dEN3FApYWLs64Ez0g/hcgT0IdgJT2i5gtIfahl5eeXy3npnlxemoh48nefOIVU3qapYjGJ4L8kZ9x4z15NoA6e2sMLj8gqeiL7b+1C48kX5Lv4sfFKCt4vrMIhMxQCP5x0Mg4fAVq/eQlTPdTi6LUKH/vfKZ/M1PnpUxnOz4HQ/dC50fIfz6qCELXmFbjU51Ygkxq10qQ32oCxE+6rovfkHFpxhKiAz4KJYWSQ5WR9WXhDww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8yWZRiYQ2xXio47HetXs9RazatlMwToL9R+2jEs4Bk=;
 b=KaUY+LZF+GkRwU/eAkCQzkI3LOPX53TTFdpPPsjVUOzVjkUqRRvAf/sgegOtwJmGAC4mSPFDzMGJbyX7IW+eBvHIqpVYpoGr2+ISGBtjHKoOTAyUd10/+lxUuflmByN2rXkT5Ee3yS1X0nd3I8JgbgPc3g9UKL5uyzt+hBv+1USBSfr6gBaKwZy1bSal2e/E3eHoslc+fv+O4kLfL58IG3NMUMoBDNC2WUXPqvkxbkSdyHNgpAR+d6VRWsiGDz0+DLINoY4ng603QC0v/45KfgZs1XYnASEUv5Ha2Tv1MGF3IuTcFBUxS/tbObsZy0MNkOz8pVWNN9NI3P8tYhnvMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8yWZRiYQ2xXio47HetXs9RazatlMwToL9R+2jEs4Bk=;
 b=nG0DDzjQlABvErJQwtFso+xASIv+Os+4zkYSke9My6CCIctoYPsa6y3DZQiPJ34UFi6gupAa9Zwd7UpmKnwQ2h+wEauX3g0WAiGM0pS+ZTW+JqYlekyCOyFuvNHwEiuYCF6fUXfak+KJG7ouOZdowromoxO33aRh0eiZww5WfcM=
Authentication-Results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2913.namprd10.prod.outlook.com (2603:10b6:208:31::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17; Wed, 6 Oct
 2021 08:55:22 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%8]) with mapi id 15.20.4566.022; Wed, 6 Oct 2021
 08:55:22 +0000
Subject: Re: [PATCH v4 3/6] btrfs: do not call close_fs_devices in
 btrfs_rm_device
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1633464631.git.josef@toxicpanda.com>
 <326bb4ecde587f0f3f4884b65d17951661a0ca77.1633464631.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <a8d70ec1-cb6f-ff6f-0393-5ba3142f3f58@oracle.com>
Date:   Wed, 6 Oct 2021 16:55:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <326bb4ecde587f0f3f4884b65d17951661a0ca77.1633464631.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:3:17::24) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2PR02CA0012.apcprd02.prod.outlook.com (2603:1096:3:17::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Wed, 6 Oct 2021 08:55:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9dab3e99-995a-4efc-1ef6-08d988a7074f
X-MS-TrafficTypeDiagnostic: BL0PR10MB2913:
X-Microsoft-Antispam-PRVS: <BL0PR10MB29134F0BC2C25E973C04293CE5B09@BL0PR10MB2913.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cymgRDG3YAd9SJ4e09PnHGQIMtVLSsKQ+Veevi7MhLUg7ir2nkeKb7Qe4hnpSPzopcowQ+6OhZs1XMq3qy/FyeEdWOlqfF0I1Q8bxlu35Or98kWEeESTYyZ3ldYWo2dUnKIpFA9qv99p1Mej7cA/yAq2OTIkks0SqbWQi+bzbae5z5oHnxssVlNMZHchAsVX76W2cXBKGQi60vzgHRiAMGlNFQF62RhYMFfrRCL7ir2+kE53hPkeuFCw4FoGzY1+h3Vgrveu5++I6JSMcNaxpKoTBa++3JsUcW0mm1Mp9Sj2VwFoAIt6byLofPK9aVMdqcQwpOlA+S7QwCZEZsIJfE0MadtqsE7aTsdiIyDTXOMhEMsVi0parBgFnFKti45YNACUImJsKM6S9FoB/KfZMkNvHu5Fwp53vPaMb9Fw7IAuOYLWjtYqmUagxuvXyCP0P3vurx75fK/nWwxxZGNJCcZWSoHfQ6d35SCuWQA6DGGO0RwUAsJhYsAD987XvIkJK0v8MhajDQdAqn+Y7+P9BQFHf8omHzdVK65V22uNTlCSTww7Q6qNoUuFq+TvnckFCXj4NIdPT8fUVWTQv7zsxBSizLSz9OW1Esm2jO77iKOTwtpMY0EUr8A22O0D0pP+KS/o8X7xCX0v3YjOZunOBsB6Dt95Wi6Asq9ZXk3oZYe7/RzxdC1CgApVLfnclg7INB+3cIiyJYD3ocFDVlj/ocj05hyyrZngzIWwt+tk+c2JnoUNF1mHbrEX2FclXhC/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(36756003)(44832011)(16576012)(53546011)(186003)(86362001)(66946007)(31686004)(508600001)(38100700002)(2616005)(31696002)(316002)(6666004)(8676002)(5660300002)(83380400001)(26005)(2906002)(956004)(8936002)(66556008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzJaaVJ4d0UweUxzeEViczFjdUF2NnFJQmRIdUFwUWFHQ1MwTjk5Zk0wVkJS?=
 =?utf-8?B?VHpZeG1hNVRqQjh5YWhaY0VNS0ZjTHQ4b2FCMGFhWEoyc28vL1MrNUpzcEU3?=
 =?utf-8?B?VUZsY0R6cGFZQVBPb3g2ZTJPUzExRVdNSVZxMUR5MFN5dURwckdRYzBaODB2?=
 =?utf-8?B?b0ZrZ1lNM2dpUGhwb21SQmFKWXJMTXMyZjd5QTVMT1RQb2RaVWVOVTZJOFAr?=
 =?utf-8?B?bGNLaDJNUWR3SU5KWjIvYzR6K1dFRHBtVkRHRjdNZzd1OFZTTFkxYVNMVDdt?=
 =?utf-8?B?eEpiWW9UU2ptWU9ZK0x2eHJrYnZ5VmZlWVNpSzdYZDhnd1B4S0hBL01DVG9h?=
 =?utf-8?B?SFVzc0ROUE9GdnltRlpHWlN6aWZpd3hYWUxZL0x5U0doa1RYV2dTeU5ENFJn?=
 =?utf-8?B?cFRqdVFZTVVMTVZJM3FPUkxyYjFnQTZtYWlNbTlvQUU3R2M0aWcvTHVwMXZw?=
 =?utf-8?B?TVhrWWs0WnB6dzhWK0NuSTZ5YVVvQ2twZUsrVlBCOWppallWRTFNLzZVOU4x?=
 =?utf-8?B?RGt4MkJPeGdIeDRsa2lBL2lqd0JjUjh4MVQ4OStObmZSWkk1eDNvS3BvNnhJ?=
 =?utf-8?B?akZIRUZvWU42UEx2RUlac2cwMnB2YS9KcHc0TDlFTDYxVDlZUXBycW1BWC84?=
 =?utf-8?B?S0JpR2pVcmVmVnAzY2cxTXpDSUdhMXZoTWFtUTFtNndTMURuN1VLK25RUWg2?=
 =?utf-8?B?WGUwd0M1U0xlMFFiR05DUUdrQitYdEJtWWMxaVhseVB0OFFwR2dBdkF0V3Vk?=
 =?utf-8?B?MndUejBKZFBnWTE0TkZ3QURYWVQwaW5VZmluWnBlQ2pnWmlYUy91VitHQnlX?=
 =?utf-8?B?STAvbE03c0oyZmIzckZCaTNJckJGMGpvNnBZUEZJOUI1c2ZGR3BMTXRJRkN1?=
 =?utf-8?B?SXNiN1J6NUMyNTU0RE9kMHMwdjRaRkhNbDVkNmRINVhQbU5LTlVOdFZESG5Z?=
 =?utf-8?B?TEVETjdrdnQ0OGxESlpBRlprLzRMSFJ0Y0tsWE50WE5OamRKTmFPWUVGd2pW?=
 =?utf-8?B?djNhMi8vckpxVDdrdldqU210N1REQUtSaS8zckVpa0ZyN2tHNG11QWV1Kzh5?=
 =?utf-8?B?UUV5WjdKWGx2azJWa1VYUEhWZFkzb1J0MWZEUjRrQ0E5Wmt0MFptYmhhOFhH?=
 =?utf-8?B?NlNUMlZhRDVKS1lIRktDZ1BtWVU0OG8yWkxJVk1SUDdBdm95V3d6QzRsaVdE?=
 =?utf-8?B?M3ZMN3I5V25TMW9pTFRSUC9vVXhvNmlYTjQrcnNyeGtaVE5zd3FWdE16NXpR?=
 =?utf-8?B?M3FCL2tsSjZCOS9BRmhxSUFMWHVuOG9WWEFLTnBQS1g2cVZvemVuWURyd2c1?=
 =?utf-8?B?TjhrYVZUZnByanVaY0NoRmhRYkFUTWlxOW1OQU1OQ1FSZ2s0SzhmTk8zeEhZ?=
 =?utf-8?B?Z2NCK0c2QUNyVWZPaVhsTCtxbHVZWGVDOGdmUDR3V081SzRJZmNCVUpMVEZv?=
 =?utf-8?B?VXhBS2t4NHB5dGd3SmZ1dnZhYmc4Zis3WE9RTXF2Umg1S1RnY0sxSmpGRThM?=
 =?utf-8?B?MTVxa3VUQ01QZG9CQVZJVHdVWWRpS0hwV09weUVaMzJRZEdzWUV0SXB2anNY?=
 =?utf-8?B?ZG5jYjZZVG1INTNCL1U1c0NwTFA4ei9QaDMzcEVWdGhWSE9SQ00xVDRZbEx2?=
 =?utf-8?B?ck0zb25RS1VCcDE0U25PV1ZmTnhzTFFTRnhvMU8yOHhmcnNzdFFRWHltMXZw?=
 =?utf-8?B?bEFaSzQ3bzJMaXZvWllmd2puMnl2MExXN0duZDhhNDJkdzJrdjdsUW52aVlN?=
 =?utf-8?Q?o69d9f46nlQDTVBH4Bfcv/SNzn+d/dnN3L8jl11?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dab3e99-995a-4efc-1ef6-08d988a7074f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 08:55:22.7225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVd+47cr3I1Z9d+NcyDKWOZH5LjslnIZB+wSHMoKMcL9TjGkm60t6jnidXY0yTr/a8OCcvnG5NEhR4p+lC6CIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2913
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10128 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110060056
X-Proofpoint-ORIG-GUID: ZkfFmC3nJIAFdlhKuJFYpVJxr5X1-Bxl
X-Proofpoint-GUID: ZkfFmC3nJIAFdlhKuJFYpVJxr5X1-Bxl
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 06/10/2021 04:12, Josef Bacik wrote:
> There's a subtle case where if we're removing the seed device from a
> file system we need to free its private copy of the fs_devices.  However
> we do not need to call close_fs_devices(), because at this point there
> are no devices left to close as we've closed the last one.  The only
> thing that close_fs_devices() does is decrement ->opened, which should
> be 1.  We want to avoid calling close_fs_devices() here because it has a
> lockdep_assert_held(&uuid_mutex), and we are going to stop holding the
> uuid_mutex in this path.
> 
> So simply decrement the  ->opened counter like we should, and then clean
> up like normal.  Also add a comment explaining what we're doing here as
> I initially removed this code erroneously.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>


> ---
>   fs/btrfs/volumes.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 0941f61d8071..5f19d0863094 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2211,9 +2211,16 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
>   	synchronize_rcu();
>   	btrfs_free_device(device);
>   
> +	/*
> +	 * This can happen if cur_devices is the private seed devices list.  We
> +	 * cannot call close_fs_devices() here because it expects the uuid_mutex
> +	 * to be held, but in fact we don't need that for the private
> +	 * seed_devices, we can simply decrement cur_devices->opened and then
> +	 * remove it from our list and free the fs_devices.
> +	 */
>   	if (cur_devices->num_devices == 0) {
>   		list_del_init(&cur_devices->seed_list);
> -		close_fs_devices(cur_devices);
> +		cur_devices->opened--;
>   		free_fs_devices(cur_devices);
>   	}
>   
> 

