Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF4F3D879A
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 08:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbhG1GAE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 02:00:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:38024 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230118AbhG1GAD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 02:00:03 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16S5qCdc018821;
        Wed, 28 Jul 2021 05:59:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=4iMTYz0BjbHMXwZ45PfKKoPZb2wAfscqDryh4IVRq/Q=;
 b=VL5SxLqThWkn5/meNnYfI3py3O5wHL7+jSjIgy2c8JyRrfjCRuYqhWEB0JYmLhjo6xAq
 m/ig0qrVXOmr9YzTwY9dtMoMfhlkUKl4uOC0rPDalpFnTvPJMAUClNtmu93wK0/yOK0l
 r2NguSAJ1vgN6BKNUZogC72KXDu6P4OqMwcG8fZ4hvy4VcoOClfmXTWBLDKrobJQ7bba
 /eJ5+oq2IEygTrSx7oNwy9XyQgmPZJBADXlnzQ+1+vZHaISjHFmQpWQ9RlZimSXMHEEL
 Ga0FLY3pR1jpB57N31UmQ0dloTqOSplFJAvgyLqZOHF/Spi/63X6F1nri0qlX+S1Tb7x bg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=4iMTYz0BjbHMXwZ45PfKKoPZb2wAfscqDryh4IVRq/Q=;
 b=ab2plzfdlP7kM3uHvz5yqQeyFJZvcqHFd3OnJ+BeatGa5XxkzLXQn6BUn1qb/VEiIerl
 efFHKLHp444A74FomxtOYz7K5Ljks/yHd0uoeV0Jh2CXw+XhMPiwzoQ6I6qOkjTFt3ww
 VbpBefOcUwSwZfQ6Wi+JNouTy45Wsuyuyxx/DmhxnL9hDEEYjoANTkqMhKOn25Kq2Sh7
 Z1P88ei/QChekxKjwhrIuBP7JMAEtop31yDHcYU4VVAv0XAz7s1RY3Uk1UT115KcITm0
 WF1x/+4W5CJRreQaD2kREMpBWPgl5aFDQVWjMG76fFQuCZIG51iQgVpEGNqMDzYse+o2 Jw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a2358bh3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 05:59:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16S5ousj121535;
        Wed, 28 Jul 2021 05:59:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by userp3030.oracle.com with ESMTP id 3a2354fffk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 05:59:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WchzEvpgmZI0lysLeQX/BBDD7FHc3XQEDXPMEwVdgkWO0imteRMe2HF/H6GkZNKm+GyCkmrTbomgyjKF74pFuqxXFFe9vpmlCxsbl701+zReUjTxt0A9ftqYnEtJyr0ea68KW3d11J+puxv9h1S1C7z6H2jMyBIwzeLwi2wI65i9I4eCLBZcyzXkQZPEbsarkILGP9yWFToXI+0nXo5ZKfsOTXgn/s+1DS7k2R1dSvR9kfUDeQ2SRbXLmUX5BEi1WT9ScB1FYUFoXkZLWrWARiiS1+UIY4elzZDUFkrciQyXBQNvWNbqWHq4ehoiZsJG6FSx38ZRZR1guqv7w4eWgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iMTYz0BjbHMXwZ45PfKKoPZb2wAfscqDryh4IVRq/Q=;
 b=d2VYKjX1BQLJhouqGJfkE/qY8+Md57zprNGhPJumyvX4SEObnNBt1QALT0msUY0Hv3WmI9jtCRDNa91kQdh87LD/X1acKWfkS2zYCbUM46v0FClia7XsgMpGM7CRpRpvfaUa63WR3XOrPQtg/KFS2T15zXKf9m54NIbdUsLgHLR/myE+iYeGvqxq47H1f3MrfijN6hDbkAinpFhZRMj482RrzKJf2a5Q7LQwyHxFV6xQYfdvmfmAjUVahVsJrXOTii0w5LFO8CVVNiwh8EFvmX70HdI9J2Ln7cI+UI0UkN7qJvjCTzITYldzioiCoft8fQgBgAoBFBQppS+kXyiJZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iMTYz0BjbHMXwZ45PfKKoPZb2wAfscqDryh4IVRq/Q=;
 b=mbdj3Fk9fkhJYMAR//lIS7sfz9mZSdqm1ri9K6PP2RAw5LPmt06/XbJJrtBC1LmyXwk4B0N5JSXxxyMairWsjIwlH+TdJUzQw1AARicyYeHe+RtUeQUnSY/YVXXnrTCLBOUIu8sKdRKvbbLe0IXqUO0iQzDRGJsn1RXai5RAWVA=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4191.namprd10.prod.outlook.com (2603:10b6:208:1d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Wed, 28 Jul
 2021 05:59:50 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%4]) with mapi id 15.20.4373.019; Wed, 28 Jul 2021
 05:59:50 +0000
Subject: Re: [PATCH 3/7] btrfs: Allocate btrfs_ioctl_get_subvol_info_args on
 stack
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <cover.1627418762.git.rgoldwyn@suse.com>
 <2200f9340973d627ee304ac4470f5921061266f9.1627418762.git.rgoldwyn@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <65c2e16a-70a2-c29e-b5b6-70a8118f7665@oracle.com>
Date:   Wed, 28 Jul 2021 13:59:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <2200f9340973d627ee304ac4470f5921061266f9.1627418762.git.rgoldwyn@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0019.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::6)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2P153CA0019.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.4 via Frontend Transport; Wed, 28 Jul 2021 05:59:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4ac4fa7-85aa-465b-7b90-08d9518ce97f
X-MS-TrafficTypeDiagnostic: MN2PR10MB4191:
X-Microsoft-Antispam-PRVS: <MN2PR10MB41913A6B048AD790B14BE4DCE5EA9@MN2PR10MB4191.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZfzuAD+RBf12wLk+/TD+mbPPh80eHt0gV2ORioo8St0DuDx1UjW8sZszz99QPvZegKV0AvAbJat0PTC0tqd8jIAe5KQVEHsDPmZ2oHg2wYGSQKXMPb+KI5DVUzZh9CSkZS96Xah+NVtldN3Q/hUcfOvwz6IlnbbSX/NVs5R7sGbxqc7RmQN8AAOZkPpbOROhvnQN9y6+RCMRpjWSF6TLbeQp1xOddMVeDpQ7w0jMGXR2nbufEq+/II1yKW80TCcd7Kx+HU7EZlKwGXbjaZYKw8iJcvmiAiVJNoohc+G4lOZhpuj9DDNyamPnvZgiKFomwZTlybY9oTGe2/87+bOYG8w803FSn+ZZ6BkKr5khaypvPbCts3aUIEU/symJ54cqLgNGA4n1FC7t6TSgHQaBSRBQfTOd2CEaTSibZi4QSoOioQdkyy0yrANQJ6U2S5UWxvIiUGex5Z6w60bSIgwT6qe818zHqtqwikzKbcHlEKvdKJqC4YZyg9KnPDAJKXEnUm4MQJMlRUjTaLBQh2LHksGAWKGM1NlBn0OnVM1wCMplvfYFZPnEyx/xcHcKAU8IF4082kLLVqQb4CNPzNqH7OPyi4p/bMIDhcvQIXJ+408DBOqhw+xdBajr6vQSskbPflEuxzcqs09ixzR0Fs9koj/M8l2GIggxwXXeZaz+ok3oNSFp4l8JyDn6Lwg0FiHQV5upIXodIOiiv6tGDYNq7ml+jR/TeqqO4kD7w90YzLY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(346002)(366004)(136003)(376002)(6666004)(2616005)(86362001)(5660300002)(53546011)(38100700002)(31696002)(36756003)(4326008)(66556008)(6486002)(8676002)(16576012)(44832011)(66476007)(26005)(186003)(83380400001)(8936002)(31686004)(2906002)(478600001)(66946007)(956004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3ZtSGlHLzZqVlJOYUpTc3l5NXdvdkZveVYzMitVM0xHZEVXM0g4SUkrZVB0?=
 =?utf-8?B?Y2hmcE8wZXRKdVNySzNGa2dMdnRLYm1tblVLL2ZlVm1ZUzBVUWdaT01Tb0dB?=
 =?utf-8?B?dDR3V1dWeEwvOWRzTTBMa0N4ZW1SM1Q5ckV4S25aekVDMHlFa2w2NUM2ZTVW?=
 =?utf-8?B?T254ZXRoZTFsQ2xBWWlzM1JpNFVIN3ZNZEkwLzhXZmRqL0Nia1hSaThoeTUy?=
 =?utf-8?B?T1ZEQ0xJemI4T0k0ajV6T3VhZnB1cm90R0JIcUZXMVVXL0NHRWQ3Z2g5Wkpp?=
 =?utf-8?B?Wng5T29oSWVBcFR3emc2cThFTUpGWkkvNGZYQXVBVVVscEVSYWlqU2gwSEdn?=
 =?utf-8?B?cFc3bCtubkJ6d2NOeHF1QjBmZ1MrK1A4QUVWY2lWNGlyNTg3OWtPcG1xS3Jt?=
 =?utf-8?B?SFFJMS83akM2S0I4eEpjR3ZaQ1FPN3o5ZG1pemwyYmtrOHdFY3FRWi9mMnFX?=
 =?utf-8?B?ZEpVU1JHTm83YkFxTVlzVjZNNDhOM1Z3NWNlRWRQMDRHTXY4Qmo3NUdyZE4z?=
 =?utf-8?B?aWVRd3FhbFZoeUQ0S1RYUXE1OGFBSjVWSnFoUFVQZTQvYUtLUjdrVkxkVktj?=
 =?utf-8?B?cDVMa3NWNkZoN0ZVZDJQZFlWdHpVaTlSc3B2b1ViSmhid3haazJpQmd3Z3Rh?=
 =?utf-8?B?aG5CeEZQU0tpbUpqdzREK1l1cXJyVGdXc2lCMEt5T1JXN09obFVXRzcrVnh6?=
 =?utf-8?B?WDZFQmFveXdLKzY3c3kvcWptd2FGNUlqNndDeDlPN09xNHBqTy9Bb1hzRlBO?=
 =?utf-8?B?dThpOVFnT3NLbkNBZ2JFZXh6ZnJwU1dmZ2RwSG1iRmMyaFVzSzlXQ3NGbm53?=
 =?utf-8?B?OGdza2hNV3lPYklQRXFwRDdoMkdjV29HSCt4Z1BGdkNWWHp1WHh4a0s2djU1?=
 =?utf-8?B?Tk5RSFowejZweDVuMVdIbmxKaCtybGt3TjhjSUJhakQydDI4QytSSW5PcmZJ?=
 =?utf-8?B?SGdZR3QrWjBOYVBhV2JRZ1p0dzRWMWNydmhDM043eGJmZE00dTJheGdBK2pR?=
 =?utf-8?B?QmMxUmxKWnY2emIyVWozQ3VWNkh0bExWa3VJRTdyOHVXUUdFS0hXV0ZCQjR1?=
 =?utf-8?B?YmpFTXN0ZEdSV04wbzFCQ2dpUWtCTEpKTCtobWxRNGJuaDdZeUI3MDAyVlFp?=
 =?utf-8?B?NzV3ZDRPYzZaYjBXbnNSdm90dkpuTm5NTS9vWnM5TzdOOVZwOEszbVhBZm1T?=
 =?utf-8?B?TEkwa0ZoVjNvNkFTTzlqWHZHeGNjcFY5QmYwTENoN1c3OWFzM3RUWlNZRVlu?=
 =?utf-8?B?TlFoY0RGZzA5L0tiNVF2ZWk4Qm1EMGs4L3hHVGJ1d0ZnTzc1L1dwK1h5Rnk1?=
 =?utf-8?B?UWhHVnY1dHNtczg4OXhjTFN1eVFqRVNGYUVwMkJCNGRZTks4OG5pZml0NzlO?=
 =?utf-8?B?ZnBYNWtva1RFRFZ0SWtPWDRZdGpRd241L2NDcnM0U2tmTjRqeDRlMGFxbml2?=
 =?utf-8?B?eVl4SEJVSWtpUjFKVE1ZQlZGWkVxYlI3N0czNUlQMnliQlRLRzNjNUUzTEZM?=
 =?utf-8?B?ZVJ6QWdkSWhFS3pMdGwyNkhNM0hWRXNoNGNJNkhId2dIOXREQTNsd3NwcExD?=
 =?utf-8?B?eWFWVU5pajNPK1d2Wk40ZFZ3UFpWNko5ZVJJVDVnRGwwaXhJaU9JOGJJcXZC?=
 =?utf-8?B?OW15Q1RHR1NWZE5iWVVnRE1MeUc4a0k2ZnRpcHFPQ0tGRmU3TE5meERFMWRy?=
 =?utf-8?B?SDN1Nisxei9wS0dLUktQa2owNjgzaWJIeWJmMlA3VG4vMXdteWxnYW9kN2pU?=
 =?utf-8?Q?pP1rZQp9YFX2Bl5Jn94cjwQabVlY9INtFp+rreZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ac4fa7-85aa-465b-7b90-08d9518ce97f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 05:59:50.7300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V6xV6RtZZ/Z/wgw8LBXzrEagEaDgZcGf02siHfSCTnCye56/9o+hyS20+lggPupy1RDrB75P5N4GstNpmR/7GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4191
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10058 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107280033
X-Proofpoint-GUID: U8OxQfbJ2jWNr2DboHYZ1SGznw7EFvrr
X-Proofpoint-ORIG-GUID: U8OxQfbJ2jWNr2DboHYZ1SGznw7EFvrr
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/07/2021 05:17, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Instead of using kmalloc() to allocate btrfs_ioctl_get_subvol_info_args,
> allocate btrfs_ioctl_get_subvol_info_args on stack.
> 
> sizeof(btrfs_ioctl_get_subvol_info_args) = 504
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>


Looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>


> ---
>   fs/btrfs/ioctl.c | 55 +++++++++++++++++++++---------------------------
>   1 file changed, 24 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 0ba98e08a029..90b134b5a653 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2681,7 +2681,7 @@ static int btrfs_ioctl_ino_lookup_user(struct file *file, void __user *argp)
>   /* Get the subvolume information in BTRFS_ROOT_ITEM and BTRFS_ROOT_BACKREF */
>   static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
>   {
> -	struct btrfs_ioctl_get_subvol_info_args *subvol_info;
> +	struct btrfs_ioctl_get_subvol_info_args subvol_info = {0};
>   	struct btrfs_fs_info *fs_info;
>   	struct btrfs_root *root;
>   	struct btrfs_path *path;
> @@ -2699,12 +2699,6 @@ static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
>   	if (!path)
>   		return -ENOMEM;
>   
> -	subvol_info = kzalloc(sizeof(*subvol_info), GFP_KERNEL);
> -	if (!subvol_info) {
> -		btrfs_free_path(path);
> -		return -ENOMEM;
> -	}
> -
>   	inode = file_inode(file);
>   	fs_info = BTRFS_I(inode)->root->fs_info;
>   
> @@ -2717,32 +2711,32 @@ static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
>   	}
>   	root_item = &root->root_item;
>   
> -	subvol_info->treeid = key.objectid;
> +	subvol_info.treeid = key.objectid;
>   
> -	subvol_info->generation = btrfs_root_generation(root_item);
> -	subvol_info->flags = btrfs_root_flags(root_item);
> +	subvol_info.generation = btrfs_root_generation(root_item);
> +	subvol_info.flags = btrfs_root_flags(root_item);
>   
> -	memcpy(subvol_info->uuid, root_item->uuid, BTRFS_UUID_SIZE);
> -	memcpy(subvol_info->parent_uuid, root_item->parent_uuid,
> +	memcpy(subvol_info.uuid, root_item->uuid, BTRFS_UUID_SIZE);
> +	memcpy(subvol_info.parent_uuid, root_item->parent_uuid,
>   						    BTRFS_UUID_SIZE);
> -	memcpy(subvol_info->received_uuid, root_item->received_uuid,
> +	memcpy(subvol_info.received_uuid, root_item->received_uuid,
>   						    BTRFS_UUID_SIZE);
>   
> -	subvol_info->ctransid = btrfs_root_ctransid(root_item);
> -	subvol_info->ctime.sec = btrfs_stack_timespec_sec(&root_item->ctime);
> -	subvol_info->ctime.nsec = btrfs_stack_timespec_nsec(&root_item->ctime);
> +	subvol_info.ctransid = btrfs_root_ctransid(root_item);
> +	subvol_info.ctime.sec = btrfs_stack_timespec_sec(&root_item->ctime);
> +	subvol_info.ctime.nsec = btrfs_stack_timespec_nsec(&root_item->ctime);
>   
> -	subvol_info->otransid = btrfs_root_otransid(root_item);
> -	subvol_info->otime.sec = btrfs_stack_timespec_sec(&root_item->otime);
> -	subvol_info->otime.nsec = btrfs_stack_timespec_nsec(&root_item->otime);
> +	subvol_info.otransid = btrfs_root_otransid(root_item);
> +	subvol_info.otime.sec = btrfs_stack_timespec_sec(&root_item->otime);
> +	subvol_info.otime.nsec = btrfs_stack_timespec_nsec(&root_item->otime);
>   
> -	subvol_info->stransid = btrfs_root_stransid(root_item);
> -	subvol_info->stime.sec = btrfs_stack_timespec_sec(&root_item->stime);
> -	subvol_info->stime.nsec = btrfs_stack_timespec_nsec(&root_item->stime);
> +	subvol_info.stransid = btrfs_root_stransid(root_item);
> +	subvol_info.stime.sec = btrfs_stack_timespec_sec(&root_item->stime);
> +	subvol_info.stime.nsec = btrfs_stack_timespec_nsec(&root_item->stime);
>   
> -	subvol_info->rtransid = btrfs_root_rtransid(root_item);
> -	subvol_info->rtime.sec = btrfs_stack_timespec_sec(&root_item->rtime);
> -	subvol_info->rtime.nsec = btrfs_stack_timespec_nsec(&root_item->rtime);
> +	subvol_info.rtransid = btrfs_root_rtransid(root_item);
> +	subvol_info.rtime.sec = btrfs_stack_timespec_sec(&root_item->rtime);
> +	subvol_info.rtime.nsec = btrfs_stack_timespec_nsec(&root_item->rtime);
>   
>   	if (key.objectid != BTRFS_FS_TREE_OBJECTID) {
>   		/* Search root tree for ROOT_BACKREF of this subvolume */
> @@ -2765,18 +2759,18 @@ static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
>   		leaf = path->nodes[0];
>   		slot = path->slots[0];
>   		btrfs_item_key_to_cpu(leaf, &key, slot);
> -		if (key.objectid == subvol_info->treeid &&
> +		if (key.objectid == subvol_info.treeid &&
>   		    key.type == BTRFS_ROOT_BACKREF_KEY) {
> -			subvol_info->parent_id = key.offset;
> +			subvol_info.parent_id = key.offset;
>   
>   			rref = btrfs_item_ptr(leaf, slot, struct btrfs_root_ref);
> -			subvol_info->dirid = btrfs_root_ref_dirid(leaf, rref);
> +			subvol_info.dirid = btrfs_root_ref_dirid(leaf, rref);
>   
>   			item_off = btrfs_item_ptr_offset(leaf, slot)
>   					+ sizeof(struct btrfs_root_ref);
>   			item_len = btrfs_item_size_nr(leaf, slot)
>   					- sizeof(struct btrfs_root_ref);
> -			read_extent_buffer(leaf, subvol_info->name,
> +			read_extent_buffer(leaf, subvol_info.name,
>   					   item_off, item_len);
>   		} else {
>   			ret = -ENOENT;
> @@ -2784,14 +2778,13 @@ static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
>   		}
>   	}
>   
> -	if (copy_to_user(argp, subvol_info, sizeof(*subvol_info)))
> +	if (copy_to_user(argp, &subvol_info, sizeof(subvol_info)))
>   		ret = -EFAULT;
>   
>   out:
>   	btrfs_put_root(root);
>   out_free:
>   	btrfs_free_path(path);
> -	kfree(subvol_info);
>   	return ret;
>   }
>   
> 

