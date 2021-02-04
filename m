Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D2F30EDAF
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Feb 2021 08:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbhBDHsm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Feb 2021 02:48:42 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:58416 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbhBDHsk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Feb 2021 02:48:40 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1147dcE2108818;
        Thu, 4 Feb 2021 07:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=3NtOn0U2b17mInrYj1qtNnmY+BPfl5C3GPZBG/l+9ck=;
 b=R4O3W/oQOwlmIiMe1V79tN5q3tI2kdXwiAcwTIYSdV58+zXq8RX5N3+doCjMwmRtVzHM
 jEOz6AjWnRlMusBwCFh2gYOB7WxsNMzWBeJXqHoeK5Me2l7RmXFYy3+tikYkWhR7CYix
 k1Yc8TtyoyYKFjH6kMrZZYhIQnNhFvreiEmJ3JVG/fG+5xC2M2E8swAgF6lW7ia9h5Rf
 hzHfiGvOzHv28DXQiv+rTyXfgqWKZDmu2Yi0oX0rJQI/Y38uWseUketziu+zzHBFmgAA
 pSeYoUAhdUoH6DEJzYpkjEFsvLfTIyw6VV72Hl2UUv54AeHHhsCgM89/x2vApOwhOel9 SQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36cvyb41c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 07:47:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1147j5on053401;
        Thu, 4 Feb 2021 07:47:57 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2054.outbound.protection.outlook.com [104.47.36.54])
        by aserp3020.oracle.com with ESMTP id 36dhc2apwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 07:47:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkaCK81lOErSwGGit6+H6LJxLGeOBKreEq+lIWhut1SGdGyAWE566iHPQyDfmcLlCIv6f957uNoiepfwC5v4MdxU7EOvKHmARQ7RgijVjNPpxhNWNZA3DSABkOy4GDvDgG0lItBHBViD12Tcm+cwkdDZpYk0KwG/oZbhk4QxO9B5sIkH+sHCn8uwpT4OjEJ+q/3NV5gczT0efc6OYRcxEcZm1jE65dAj9HYe6s2oDYwWq8agFRD74vZMNME2jO1S5hjUd+wf3RSd2ZokO4CY7OlBwYe6VBdVeXaTYwyJ05TwK0gsqpRPbwP8p/KMWJ0WiLMMgnRjtl02WfUxrs+cPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NtOn0U2b17mInrYj1qtNnmY+BPfl5C3GPZBG/l+9ck=;
 b=FRenw/fqwatypRnbcylpjXrsWwCTIjs5l3wxOtoJZcyK+GtNSHgemTaL8UcPnBloJsA1onHXafQLhCH0woFULYCYVUmEWR9gHJHA4KF+cX1QzimJzrlFQSVaZqBU32tCVZ7QTwNV1vJpsyPjJnOaZ+sM1pd3b+Fs7WhUtvECQt2R959t77q+v0gVXgMEQekI21mZU7qURvniGpUUdfYVcbgd2+eiu0XYpykZfrXQSpjNK0p97dfRAce3F9U8uivMinP0+tDialzgUBC5WKUC8lOihcL6kz6RxDkBxMPj6iBgXB1+K12G3567pp6oe7coWTRloL44xeHOEAGU73R9pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NtOn0U2b17mInrYj1qtNnmY+BPfl5C3GPZBG/l+9ck=;
 b=0VNwEo61SZm41jrJByVknO7mtFpaWnuY4GQJFxEwxr85aFTFT7r16ks/F1rlNyBAmGF8b/THkl1gV6MTjQnWfnCMFYPQq16lgJrdsRBXRZsr+GOE14P9i4BADf3RDfvrWLTrUPYThhH7JQBaeGCe+J5RlwYoO3sQMf+ISkfwjdA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
 by BN0PR10MB5223.namprd10.prod.outlook.com (2603:10b6:408:12a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Thu, 4 Feb
 2021 07:47:55 +0000
Received: from BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a]) by BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a%3]) with mapi id 15.20.3805.028; Thu, 4 Feb 2021
 07:47:55 +0000
Subject: Re: [PATCH 1/4] btrfs: avoid checking for RO block group twice during
 nocow writeback
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1612350698.git.fdmanana@suse.com>
 <9d42ab56ffa6b454998453764dbb1c899d10bc40.1612350698.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <8a8fad5a-26db-a082-3a21-68852054b29e@oracle.com>
Date:   Thu, 4 Feb 2021 15:47:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <9d42ab56ffa6b454998453764dbb1c899d10bc40.1612350698.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:d057:c9b6:8962:237a]
X-ClientProxiedBy: SG2PR06CA0191.apcprd06.prod.outlook.com (2603:1096:4:1::23)
 To BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:d057:c9b6:8962:237a] (2406:3003:2006:2288:d057:c9b6:8962:237a) by SG2PR06CA0191.apcprd06.prod.outlook.com (2603:1096:4:1::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Thu, 4 Feb 2021 07:47:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b19520a-0667-4691-cce5-08d8c8e12eb0
X-MS-TrafficTypeDiagnostic: BN0PR10MB5223:
X-Microsoft-Antispam-PRVS: <BN0PR10MB52234D4B100DF22ABCEC2AB4E5B39@BN0PR10MB5223.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Ftd4Tnc+tayFjF3rASxbZix3qiolHlH8d6/Ud+jrZjFjWfvxOJaV/Fc9nPexI4Lgmukv45d8T045Gu7etTBTFOWkkYZX1WVMONY5mk5XLQbSsp/CPLJxMPbM4cRF5ibNr6k/WLVe1x/78LjZLFNThYTXbKRXTiOdCnp30CvYtz2dsgvXdxHCk3ivVPDvZuLbnIj21mWxNFWJZ0n6JvJqKHAR6WqWjzWqUuUryw1MBbZXGiXQjAUdPYMP/8r2oIRqMinsqSZofM1z76I0HZ6vc8oGm0xMuV3f/IHfvtCpinHZNVJkuYDPUfOprfT7nlnoWF/sA3NQ4FGikFebH6XIDUP3k7ppng5mI2TSkvg9mm848YCN/YfYmhuBb3ehpslVUKhTlHp6YlpnqP2FosoUbjcCeDYLCRs7gxpbrYyiX+fJMulwaJERRmJ9F0BLhLMrfcuxVXHC8PS1KTXilxoX3lwSlTqQGpxbfrDX2tKCfVvtfvdMolZ50rtg9FbFasJ/tIjwYIi9Ec9UxwY7wXYqNYdy/gq+vLMSpO73AVFdkdNnZF6jggeHaysZ6ve5MAOJX9QU3ns5wE696bZZBqMHU40mxWTXyvGj7lcFYPN4f4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR10MB1683.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(366004)(136003)(396003)(36756003)(6486002)(186003)(2906002)(53546011)(6666004)(16526019)(31686004)(83380400001)(86362001)(316002)(5660300002)(478600001)(8676002)(8936002)(44832011)(66946007)(66476007)(66556008)(2616005)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MUx5eTJuS0dtNlB0cW9aWGg2TWdtZEx4NlduazNCdEdQNE9IUXY2eUdkYVRZ?=
 =?utf-8?B?aFpWZGEvV1JWM0xmeTN1bVF1b21idlJHN1NsSDkrcDE5VEd5NkRkMDFQK1B6?=
 =?utf-8?B?bUhTSHB6emI2TW4wM0lnT204akJxSHFlUlRsRU15bmdMalJtOEI1U291M1V4?=
 =?utf-8?B?QmZtMkoxTmcxVUwreXY2Q3Z5czNZWFBlZk9QcUVNSk1URHdTMzZHT3kwNVBM?=
 =?utf-8?B?a1RsdWhDbkZLOWZlYndxSkJXcXNWYUJ5RE1Yb1BPM0hxVWpJalBXcWM2NTJF?=
 =?utf-8?B?d3l1TVJDMk1nU2ZoRWlXckFaTDB0MlJ1ZWh6bnpyeUJPK1lmRkIrWWlVZ0oz?=
 =?utf-8?B?bVdXV3NrdEZDelI1WXZ4dVpMNXFHWWpTdFR1RXJnQVJNOUNxY00waU4yWmti?=
 =?utf-8?B?amZ5emp6aExWajI3TVhxMVpua0VjaE1CZUs0ZXdMQVMydlJVNFRvZ0NCMzda?=
 =?utf-8?B?ZDluWENYZnNqaHpXakFxZlhGYTNUQmV3ZDQ1NWhwOTlHUU91Y3RFSHByWklm?=
 =?utf-8?B?MTBYaXNYdG1MMkQyZnVDeDNaWTMxZURBZnJLMXlTSlpOQk5SS1Z3S1F1dEdF?=
 =?utf-8?B?YkZnMUF3NFl2SDJVR0dueG9Mck5vVEdUZGxmdjkvcTdlb3lVMGR4aWtFSXRD?=
 =?utf-8?B?c1V5dk93cCtZbDJUTXB1dFJWNUdnaVdiV29OTTVkeTVyL3IvejhzdTMxdm16?=
 =?utf-8?B?aDJEVW1uZkN1Umd2My9kU05JTWpCWFdHWDAzK0w1OVNMSmtPeHAwc2tERWNV?=
 =?utf-8?B?eUZiYU1ySDBTOHF0SStSRXVJMnlTMk5UWlRPS1pWOVlETU1ZdUtma0dRWldG?=
 =?utf-8?B?b3JSbHNvQ3JaR2hEeVVDMVpHN3cyZVJ0RnRiRWpXaS8rZnZmd2RrUWZsMFVM?=
 =?utf-8?B?dy9TNVVvWEZRSWZ3bUN3bFRRTHZYeWc4d2NWUXlKbTd0VlNGQXp1aXNWT0h5?=
 =?utf-8?B?SFpnbkJOSGVSZC9MSUNOMjIvVU9KS21pdmVpbG5GK2tkT1NGTmw3V3pyK1Zj?=
 =?utf-8?B?MFJiUzVQSDh3MTNIT21OMU5iQjFNRUd0TFhKVDdrZ1FTVVJxMU0wS3BLY04w?=
 =?utf-8?B?M2RKb2E3djJ6RTZzMUVkWHlUV0F4eVBFM0JrY3EwdmgxdExUMGZod0E4WVE3?=
 =?utf-8?B?Z1FtL0VMMFVFRzdsRmR0ZkZUMHRtV3BwVStHQlNLR0Rnd1F5Ui9KdXpWc1dW?=
 =?utf-8?B?Z0hlMU9BVUN3NlRCdGJDTHJ3QkdRVEEvNk9jaHB2UXRZaXhvSGtpU1Y3OVE1?=
 =?utf-8?B?SnBEMHd5ZkV0WnFkZ0dUT1lBbmVoWW0wSDFNUjZSSlZSOG5MaWttYmlNT1ho?=
 =?utf-8?B?VE1jUnJnRGZBdCtkdHFZZXJERzNzNmNWeEVEOWt5K0tjdW40UUhteEdqUStq?=
 =?utf-8?B?M1Buck9Rd2hzMGt0WDlVUGVFZGN3R1JETlhsUHY5SjROclFWU1NwWnVFeGhR?=
 =?utf-8?B?cG1LYVpCTzFFdWJYYlVPYkd5T2dtRTBPSzQ1MDB4RWQ2bnFxOUtCYWJYcnNr?=
 =?utf-8?B?VkVyTVRhRFB3SHUyUG5EdlhiWnY3VCs0TjZzQzJQN1RFOTVqUFppYkNxU3Jm?=
 =?utf-8?B?aHAyQjZFcjhHQ0pYZzR0NWZ6TmY0V3N1U2xxU1ZrN3lyQlo2Zlo3MklOemk3?=
 =?utf-8?B?cmhTNHZvWHZrNStWS1V1S3hwVlhJdm9STFJCR0tKRWxreDJYUlB0ejEramhw?=
 =?utf-8?B?ZHp3RkdMdXFDNzJTc0pzYkZudWVvQmtQYkRsTTZhUlN2OC9iWStNWS9aUHAz?=
 =?utf-8?B?c1FoYjVGQUw5OVlpMEkzUWcvTzkwdnkxeVNGV2xqODFDUlhkd3FxYVEyMXN0?=
 =?utf-8?B?ODJnNTkyVUV5T2dzZEFDbVJENms4WEpGSVpFb3k4SjNOdFlwaUJYZkRyTnhD?=
 =?utf-8?Q?RaeIVr2Ndrh12?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b19520a-0667-4691-cce5-08d8c8e12eb0
X-MS-Exchange-CrossTenant-AuthSource: BN6PR10MB1683.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 07:47:55.5558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ym1/lKEhYr6phX7FihvYvUIsLqEmhM2woolwhkVadePK/4HxHbB/WGJtEOr7BeTVNU3bPeU2umGIl1OR+UmyRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5223
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102040046
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040045
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/3/2021 7:17 PM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> During the nocow writeback path, we currently iterate the rbtree of block
> groups twice: once for checking if the target block group is RO with the
> call to btrfs_extent_readonly()), and once again for getting a nocow
> reference on the block group with a call to btrfs_inc_nocow_writers().
> 
> Since btrfs_inc_nocow_writers() already returns false when the target
> block group is RO, remove the call to btrfs_extent_readonly(). Not only
> we avoid searching the blocks group rbtree twice, it also helps reduce
> contention on the lock that protects it (specially since it is a spin
> lock and not a read-write lock). That may make a noticeable difference
> on very large filesystems, with thousands of allocated block groups.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Thanks.

> ---
>   fs/btrfs/inode.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 589030cefd90..b10fc42f9e9a 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1657,9 +1657,6 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>   			 */
>   			btrfs_release_path(path);
>   
> -			/* If extent is RO, we must COW it */
> -			if (btrfs_extent_readonly(fs_info, disk_bytenr))
> -				goto out_check;
>   			ret = btrfs_cross_ref_exist(root, ino,
>   						    found_key.offset -
>   						    extent_offset, disk_bytenr, false);
> @@ -1706,6 +1703,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>   				WARN_ON_ONCE(freespace_inode);
>   				goto out_check;
>   			}
> +			/* If the extent's block group is RO, we must COW. */
>   			if (!btrfs_inc_nocow_writers(fs_info, disk_bytenr))
>   				goto out_check;
>   			nocow = true;
> 

