Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7483C21AF
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 11:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbhGIJjV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jul 2021 05:39:21 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:30734 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231494AbhGIJjV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 9 Jul 2021 05:39:21 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1699WUDo009706;
        Fri, 9 Jul 2021 09:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=/iSCT58NjQT3ejlvv55/ir3D8o9p71An+JE8fqIKtfo=;
 b=wlgHVqEyA7mSplvgKHY/nAYE1jJ+/lokyNLYnbkhUYzLIj4SRT9uSLhwQUhCFdCRry57
 FnDDh252/C6hP/wpsutLvAxYdCBZRU7fk4MMZknIH66/Q5fqEn+6fRdXkRfjTB41kpC3
 sr5oaWqJQ+jpr8l/BDQDCWZ42gcGqDolMjZg13T1dccyPC44u2KJumy5vr2o7WDiWxnI
 nariheWOdvk92vGHC+MQXHLPbpXFZNUFC05TzkW37pgP+ZfsLmdtjIJirzY5R5YmDc5E
 aJ/hyNW+i4fsWKu3SIHlN6vJbuMsdYWuHq61tvVimjx3ADY5jIjH+ZKttYBfXNOOHQmj hA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39nphgk5s6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jul 2021 09:36:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1699UipB004063;
        Fri, 9 Jul 2021 09:36:33 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by userp3020.oracle.com with ESMTP id 39k1p3mxxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jul 2021 09:36:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNRXVOoXlwLpB1XC+XAWiWkdXMe6Y3PIFkJUJxPfnFS/pfBI5LRK3QZ224gSvBGz/dklGQ59k+hk/fuqktws1qIGdnw0Z2pZyeWqrDRNaKlgb6/io63n1it5T3f8b44L02McBxb2MaA/UTV6/5sc1LbmLEfdmEbpveaf3FdUBqzCuJCMq7cbtbStF5hsjRZXCC5tBBPnQjxqjeWuNOWG4qnU6g6fgoEzbRiJouGF1GaUcOum1kKemrkTtmEw2mweKk2tJCzprQHhC4I0QkP4PFxZ6ZTKpyO1m96n2BRseUafoxqM0Jeo51VEiE77IWi02Ut9m6LgzPEe9awfTiQkAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/iSCT58NjQT3ejlvv55/ir3D8o9p71An+JE8fqIKtfo=;
 b=dGJBp7rcBqwzp8aKQb/oYUb52En8eOvVTeUTVwcLohixDJOdVt+Vd3+gNgiZcKZpCxuy1iNWOH8LgVWoHoI07/NostIP31RN3e2sGHpPQmVMnOeRvzQ4VDtuKobGf3c/h8Mdq8rBkOWQJaTJnCd3cB2rIPrQv12ktOgPLm2raDRpJELDElaFTIsq3r6RU7NuJAUOvfK01X+xPzrWrrcH606poHwef6aFdF47OExRziMKGl74jryunyy2x2hxLpA2SU//bjRq5peidtBXRiiTwdF5r2UZo6/8SXmi0TpVX5IWuya3Q5wyYwe47A0LEtnonMduV0o3IaX4UIv513ZbAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/iSCT58NjQT3ejlvv55/ir3D8o9p71An+JE8fqIKtfo=;
 b=aH8syN9YK8HwmGw+a5CDClEC1pudVd9ikyAgjempBy6c/GRJZOpUu7cClTvHeTpUeIfFNa1IkwQ7EDYRjnlifMeaW/1DboEM8WgYV9zw6ZYxATj/BSAbBQ1rgb9lyUU7wlE0KvDpxDYJDBKCg40vpUlShZxvvFiMS1EVydy5hfI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4929.namprd10.prod.outlook.com (2603:10b6:208:324::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Fri, 9 Jul
 2021 09:36:31 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%3]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 09:36:31 +0000
Subject: Re: [PATCH v6 10/15] btrfs: reject raid5/6 fs for subpage
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210705020110.89358-1-wqu@suse.com>
 <20210705020110.89358-11-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <67de8d93-6add-6094-05c6-ae200461ed79@oracle.com>
Date:   Fri, 9 Jul 2021 17:36:22 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <20210705020110.89358-11-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0177.apcprd06.prod.outlook.com
 (2603:1096:1:1e::31) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR06CA0177.apcprd06.prod.outlook.com (2603:1096:1:1e::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Fri, 9 Jul 2021 09:36:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ed78413-4bd2-49e8-6474-08d942bd0898
X-MS-TrafficTypeDiagnostic: BLAPR10MB4929:
X-Microsoft-Antispam-PRVS: <BLAPR10MB4929A35439BCFA46A7FB9BC1E5189@BLAPR10MB4929.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fy8OVPy+TIEkH+81hNoPqVtKTX013+TdnF4sp7XEChwAb2bFIEzRC1Mao3Stuh/TWi9xIMZI95BvZvQaFBTAJ6hZlfWjTLTw/n/Ju6nLyAUQ8CjiFAETwYpk/8erGmEDUBTUOZ2sL8texh1SxF0IBgnZRFwCdb0OEjh6fR9e/mR36Z/BZi1oFV0wwJibRpRr6YKWnxND/WAliAH6JlM9JvmZpsut7/Gh8TO5rRfGItfB/PlgPuUYyAflZEufdp+nmuCbZTO4fPxgMmWkYSHOET1qGSrQFYb15Ilo8P9ZHtdisf2n22IJydGI3LuN8sidRGP+QzccTKQOVgEomCnDN3iVDcvFKJoUl+9tWTPQnXbBbO4YLxTvkABy2873knynyttOPlw6dCeBRWKz6nsI9LwP2EHX8VRIH1ArlO5h2Kc4sEimqHW/lgvSqk0mK9u2AEtwbbjS/dpthBJkS7BaR67K679hctEGGOsvM6ekLEWMNiw0wLXUuZuvTh9Yo//cYSFHcBZ3qB9oLU/dOZtZkERl5JUlepy0eSXqjS6g2OwOa46LKs4uuCiOjXeJCJZu+WM8Ht4zsKIoDFxYRpOD00B3tZijsIET3J/dA6EHXMwxZN5QSrxme/PDSC52gRNcjDOn+yEc3jTm25d/boXpHABpIzfsXxg0KBx6NL3/5UY4aly6eBYrmjAfP4I1Xtwbz/2L6hAbQLTS2qwwOGZ+x4fYxoZ8Yvkn/4naccy88gQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(39860400002)(346002)(396003)(186003)(6486002)(53546011)(86362001)(2906002)(31696002)(316002)(8676002)(16576012)(83380400001)(5660300002)(66946007)(38100700002)(36756003)(66476007)(2616005)(956004)(6666004)(31686004)(26005)(8936002)(478600001)(44832011)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3JSYnRMeXkzZTVzQUNZbEpWSC9RSHdlZVg4bm5YVUJoaTNsNE1Pb296bUdh?=
 =?utf-8?B?UUVLRU1tUVdZS2JocjByZVh4UjhxWnBqd3N5R0VQd3A3b1FqRHkrNUdnL2ly?=
 =?utf-8?B?VkQ3cm4rQlNhNEJtZXpwZ2xiWFNDZkV5OGFqMkl6NlpjMWxkQjA1UW94NmNa?=
 =?utf-8?B?b3g3d2V1QjdJbEJjK0had0w4V2VFajRzZTVFWGhONnMwT05udFRXNU1MdDJZ?=
 =?utf-8?B?MVBKZWNIT0Z5VXZrRlRpcDJYcDMvcTdzeFhuRHRVcUN2VUgyRHNieEdLNmpX?=
 =?utf-8?B?YXQ5d2FteDZibzNPdlRuNC9FZitSUEFpTndBQVQzRGxSc1lzeXcwVVdFMkcy?=
 =?utf-8?B?Mkllb3VobmU2ZTZ5TjB1bFVFNWFoQ1R4WWp2S2JydlducmJ5UE5CS2lLdHVq?=
 =?utf-8?B?VUw1Vzd6YnVYUmNDb09zMTM3Uk8zZy82eTRyTnQxNzRBQ0Y1SEd4VVZMUDI4?=
 =?utf-8?B?eElKT2hRY0pRRWRWMzAva1RzR01rOGRsVVFXb2VoK1cvR0I0aGdIZlJudytu?=
 =?utf-8?B?ZWwzRlF1YVBsWWMrbytYT1N5L3pnS0dEZkRnQ3Zwb3NPaXhYMjF3bzE0UkJO?=
 =?utf-8?B?YmJBTk9UNzdoZ0ZmUHNhUmJkbG1GYThiRDRGQzUyeGFVUFdLb0ZOMWF3OVZF?=
 =?utf-8?B?ZFBwOWp3b053VitDRmR1MVNrUmRJZzN4WGdudEFxQWVmTUZ6UkpESDZJRXQ3?=
 =?utf-8?B?SEdZeS9rQWFrbnlSWWljTXVVREpWZkl1RU4vK2Rpb1R3YnVlVUxvNy9qbzBF?=
 =?utf-8?B?NTZ5aGhTZzBtYmExVnc3dGsyaFREVkF3TmVBaW9TVEVtaHF3RUF3RDJEVW5z?=
 =?utf-8?B?bkRuSFdzZmZKYnBpbXNlVExMVVp2SjdQeTAwQ1ZFdXlWTEx3bkd5VXZKVVZL?=
 =?utf-8?B?dDdKS1F1UW5ZeXhUbmRqVU5IMjRzMTh3dFBsRmpjVlJoeDFUOTZZcm1DK2d4?=
 =?utf-8?B?djhKZFJQNUF2MDNwdlU5SEJXYlQ5ZnlsY2Vabkx0cU9Pbk1Ec0phZmI5MjlL?=
 =?utf-8?B?UXBuNlBadEFkYVNSUnE2TmMyd2p0WmNwZk5zWkx5SEZaZnI5MTBad2tSNWlN?=
 =?utf-8?B?aWd5YjEwdWpGWjRqaXN2TFNKVFZGRVJlSGQ5NUpNd09qb3RPSkdKaWwxNDRn?=
 =?utf-8?B?Q1pVTEcvOTFkZWEyOGh1UHhSSmQ1bGc0VTdHWVRWTFZaem1Ba1VkdG1tM0hV?=
 =?utf-8?B?Y2doTUpHN015NFBhWVNaS0w2UFpXL1kyNDZGVHJnb2tCdDVoTlc5c21ZNTNE?=
 =?utf-8?B?SVNmZ1RBa04xZ1hHMVRBYzcxYW83UlZuN2lZWXQ0YkVPdk9PM3RJVnQxSlph?=
 =?utf-8?B?M2ZJVFo1R1dBUmNySlhSV0ZyRHBwSkhvRTBUdnZGbWJYMy9nalFWaVNSSXkr?=
 =?utf-8?B?c0RCVnhUaFc3QTJXWTFDaFQ1cVVRdWtwNTBZWlFGa25rNlhydXluS0xMdm5o?=
 =?utf-8?B?K3V0UlJGMWd3K0hvOUVaZkxJdm9TWVBNYWdiVi8zNGs1OHdHWHVuVG9yRWhZ?=
 =?utf-8?B?OTNJQVZUeDl6ckxHTi85OUFETTY3RVIvNXV6RUlIMEx0eTlKbUlZcVRGSGlG?=
 =?utf-8?B?enNrQm5xbUExMjdDL3MwdDl5TXh5S1JBLzRJYStlbkRlSlJScG9rTTA0N1dZ?=
 =?utf-8?B?RGkyK1plbUU0ZUpmVzdwRzAyYmNZRytzMXJBdjE3M2xXb1dpbllaNVpybk1P?=
 =?utf-8?B?bkRvREd3MFBieDNDandYUlZFVUQzNHU2eFFvTW84WURpR2sxaHV6cmxaNldL?=
 =?utf-8?Q?z7x5JObHWEzhheRoE3HfjD/R9MI8cejJ3u1/JnC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed78413-4bd2-49e8-6474-08d942bd0898
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2021 09:36:31.2293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qMIkHWv2nf2AKZqGSJQeHWnPEUbQexmux/29NQMzqgCVmfan3wO3fBSK6tqDC0VI5ePDCBlkXM7aa/LoaB0f/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4929
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10039 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107090048
X-Proofpoint-GUID: VQIkikyAuTSytH8iEf6o0Aqx8Gtpugcs
X-Proofpoint-ORIG-GUID: VQIkikyAuTSytH8iEf6o0Aqx8Gtpugcs
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/7/21 10:01 am, Qu Wenruo wrote:
> Raid5/6 is not only unsafe due to its write-hole problem, but also has
> tons of hardcoded PAGE_SIZE.
> 
> So disable it for subpage support for now.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/disk-io.c | 10 ++++++++++
>   fs/btrfs/volumes.c |  8 ++++++++
>   2 files changed, 18 insertions(+)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index b117dd3b8172..3de8e86f3170 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3402,6 +3402,16 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>   			goto fail_alloc;
>   		}
>   	}
> +	if (sectorsize != PAGE_SIZE) {
> +		if (btrfs_super_incompat_flags(fs_info->super_copy) &
> +			BTRFS_FEATURE_INCOMPAT_RAID56) {
> +			btrfs_err(fs_info,
> +	"raid5/6 is not yet supported for sector size %u with page size %lu",
> +				sectorsize, PAGE_SIZE);
> +			err = -EINVAL;
> +			goto fail_alloc;
> +		}
> +	}
>   
>   	ret = btrfs_init_workqueues(fs_info, fs_devices);
>   	if (ret) {
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 782e16795bc4..3cd876c49446 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3937,11 +3937,19 @@ static inline int validate_convert_profile(struct btrfs_fs_info *fs_info,
>   	if (!(bargs->flags & BTRFS_BALANCE_ARGS_CONVERT))
>   		return true;
>   
> +	if (fs_info->sectorsize < PAGE_SIZE &&
> +		bargs->target & BTRFS_BLOCK_GROUP_RAID56_MASK) {
> +		btrfs_err(fs_info,
> +	"RAID5/6 is not supported yet for sectorsize %u with page size %lu",
> +			  fs_info->sectorsize, PAGE_SIZE);
> +		goto invalid;

Just
  return false;
is fine.

The above btrfs_err() will suffice. We don't need additional btrfs_err() 
at the label invalid.


Thanks, Anand

> +	}


>   	/* Profile is valid and does not have bits outside of the allowed set */
>   	if (alloc_profile_is_valid(bargs->target, 1) &&
>   	    (bargs->target & ~allowed) == 0)
>   		return true;
>   
> +invalid:
>   	btrfs_err(fs_info, "balance: invalid convert %s profile %s",
>   			type, btrfs_bg_type_to_raid_name(bargs->target));
>   	return false;
> 

