Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552E3391042
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 May 2021 08:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbhEZGDi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 May 2021 02:03:38 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:55460 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbhEZGDh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 May 2021 02:03:37 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14Q5wiF6115388;
        Wed, 26 May 2021 06:02:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=8E70LSE42njETqu6oJO4/sJFNCokU40nXb4Xbk41kW0=;
 b=BFRxa+fei1kiTsYWOMNZUtyt2ogbecXJ0hyQpG4JFLu7ucozGx6AVuxcxwpHe2wWHdef
 RL6EDfVOhPjzoWUYUdh/aW3Aj155GNl5xRXVbYavkRjz5mXFmM0+iqd83qPXR/IKPaue
 8rcDA3WrCZxjPZVaNB8IQcroXQidRbXmHIczv/E6ahVNJ67wUjPpbUbeZODZVjVwl1G8
 DkLaFIr7CGBwVMSlSdqkjUaLB6fu8Y0Ff0a/zLXQR5N2Samc8L5Yx4HKn3GF49q3yWhz
 7p2JMFL9E/S6ejinJF6Ag9CadsQXaphpuhaOTmPemRT6IbvaKHPKG+FtM5xoMtMgfFdp Iw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 38pqfcfxv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 06:02:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14Q60Eur015941;
        Wed, 26 May 2021 06:02:02 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
        by userp3020.oracle.com with ESMTP id 38qbqsxqds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 06:02:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JE9sv8Fmuy7BtVJ/sS8z5Ll6B6UjHf+u/q/jL4FaaIFj3kcKkkoD/ygp6DmMiVpIEJLTd77OTzvmTuW+Mr7y6a6YscNSAuLpG7YNPOVZlirZR21TozmqySDzJwriCJtT58oVvFAg1H8/oUiDFOz0D5vTevlkH07TtIkao/KpdytKmaZdhwpcunc2DRifKAHFYjiMpMvaF2ixhfnfoIxOmeqVIhqOniaY+cjH85zTndxv1cN1ZIZVUYzubcZY1gL3LmV1kqvlF4Efo22f4WGCR2Ks86V4+xICCzwwEBKmTR7TvCep87oRLmeIWTzfjwK58pALGADGqF3Tn8tRdxUlsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8E70LSE42njETqu6oJO4/sJFNCokU40nXb4Xbk41kW0=;
 b=WP5R2hj7IxTJ7WlOfjmepMtqW1aGvQeSMs6dVEQKREjJoboFDC8YiXokoQdMFNU9Khnid3G9yVrx6oLmtzMDEkOumhtI9mX5hGbM6NfMfDGT2sbo2lesdniP04S31tB79S63koEAXi5tCtktmB1UPo2X3MNtjInUdP3nAuvGYUIkj7S4Y5bYR+EVdNKh1eC1PhBhKWixXEZpp/ifdocLu3FqdIVoIEzcUwhN9hXB3NpY3ygEyuSAgdpGFwkSLLnG8aXIMaCX64R9bwkHcupeIq/e/AyWpWyfZ50LpbYVgJXrm/9G65fHvBw/MCpbvGbn+ihuuzRXxigrEAK9GDYcBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8E70LSE42njETqu6oJO4/sJFNCokU40nXb4Xbk41kW0=;
 b=ep71cFhsRZ5r918Cybwy8RMFNhWVp5WXaKXEk0q/zERJm+ek1x2nFKxTi01PO3FtasVZopmpKt7549+pzQkqlLgAbD+YAow5Rw5N/upSaoPcqswAcJ2e4joPfAtf2o5P4XzI7HKrkDiwXLrSUNjC4hPkLWYQYbbAL8vdPx12WYk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3967.namprd10.prod.outlook.com (2603:10b6:208:1bf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Wed, 26 May
 2021 06:01:59 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8%8]) with mapi id 15.20.4173.021; Wed, 26 May 2021
 06:01:59 +0000
Subject: Re: [PATCH 1/9] btrfs: sysfs: fix format string for some discard
 stats
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1621961965.git.dsterba@suse.com>
 <aabd2d30ceb25be5dd6ba2812f85b92fea0544d1.1621961965.git.dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <aee1a7d0-4215-4f40-6eb5-86b92ac6f3fa@oracle.com>
Date:   Wed, 26 May 2021 14:01:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <aabd2d30ceb25be5dd6ba2812f85b92fea0544d1.1621961965.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:c97e:3e12:797:83c8]
X-ClientProxiedBy: SG2PR02CA0083.apcprd02.prod.outlook.com
 (2603:1096:4:90::23) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:c97e:3e12:797:83c8] (2406:3003:2006:2288:c97e:3e12:797:83c8) by SG2PR02CA0083.apcprd02.prod.outlook.com (2603:1096:4:90::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Wed, 26 May 2021 06:01:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81739a74-5474-4fa3-0ca8-08d9200bc5f8
X-MS-TrafficTypeDiagnostic: MN2PR10MB3967:
X-Microsoft-Antispam-PRVS: <MN2PR10MB3967D1F4E84C0F4E8F8D8692E5249@MN2PR10MB3967.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cntik3670w9+dnJnF5SaZSKabPONfFO9zbZOgY+qt9Ubmhv1gpt8zPY77h5ZtRT8WhqTdP7nWucQRNzaExmGiYvaGlm+gfafpZ2DDbHVxtCGqfZg1RpslB9Kofnuir/gNQa8K/jlQXjMKttjD2p1MRJYVNsqLrDW/gdG/ek8TfZXO6rAe6DsCfsdFNh1FCIoIXGzwTkhdGUtrwH8DK2T/vkWVgOwMj6VMOQ+5VQDC8zRFrlRiOreZzsFBod5UMi24ARywzW86O4ViHtYeoFseMnV4aULKve1tWL/MQAIAo2ZggBkJ63e2bMoxh6H8IXrSrhbpnTvD+6vfrUUFcuh6+/+ccroot64v0aVBcw1X4BjLR6TJ/N2U4qbt6N7YTLpbbMVa+PIF8YzDFFslXOwKxLoUO7e04klpxCkSh10ITCXEx3ItzB9uHpMgQsMcCDCkRdfJpyJP3oDs+M6A2zCejQ9RWIB7YUi8unOkgtJ/3v9XwRnMr4gyOmNdWHey3AZm/Uc8tKoC6es4g+0N9e/EizmGlZG8eZ8ah9koo0AnXwwYkccay5LSfu8ay9O4zRM7LesSHx86aTUwvxqOb5mwuLxAPHehHubUFeb4+ednlojhvxd81uNGNu6Vz73uZ6Xfmiyrb91/YQhBslEhrSSqoJIfAAOqIKmVLuHYOzS3r0Hn/JCaYL8te0K9bvsfruQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(366004)(376002)(346002)(136003)(53546011)(186003)(6666004)(44832011)(38100700002)(6486002)(8936002)(36756003)(2906002)(66946007)(16526019)(86362001)(478600001)(66556008)(31696002)(83380400001)(66476007)(31686004)(8676002)(316002)(2616005)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VEptakJOVWE4Y25Gd2kvZk51QzFZdFVWYmxaSGFZSjdrL08rd2ZFc01VUjBE?=
 =?utf-8?B?RmQrZjQwblpzVFF0MWF4QTNpVmlQN3h1K2ZKUm5iOTh6N3ZnSUk5WTZscnAr?=
 =?utf-8?B?c3pQVkpnR2QwbTJqd1h0WWppemVuamdpR3dudm1takVzSnJFd3NEVjZHTk0y?=
 =?utf-8?B?WHN4NlUyNVJRNVVQOTVBdkJVaVpQWm4vdlhudzF4RG5xQ1JZckxjZWgwOE9I?=
 =?utf-8?B?amtyNEh0d0tTdkZBem53aWQ3aGtQQkFLM1h3cmVRT3FSZHJQemsyMENEVG9W?=
 =?utf-8?B?eW1wK2UzRmJwQ1hSMUVYbnF0NmhDRjRuZU93VThsNUo4ZmJqMDU3dGpoSTVU?=
 =?utf-8?B?ZDgxdVN4eHZvUE5oT1hHUHJEWkE5SUxObVBndk9yb3NFUFpqQ2FId0JpTjJQ?=
 =?utf-8?B?NEM1NERWbTlmMGkralhsckw4SCtSbUIrVXVrYURuQmt6VGwxUXZFcmdwakp3?=
 =?utf-8?B?bTdIa0hnZkFZWXBXbW55SWc3SElnb0ZaV05XRENVVGRFVmRqVmpCeXlQaWxz?=
 =?utf-8?B?RVJwUFVobXJjSW5acFpOQ1lyNFFUZjRXYUJiWlg1cG9SL2l1d281LzNBSExh?=
 =?utf-8?B?aFJ0T3hnTjJlcWl2Tm8rN2ZJT1k1Qnk4WklaY09OREM4YURkZVJGQ3VXajFT?=
 =?utf-8?B?ajdlOWdHT0hzeVJkQ2ZIUlprSG9velducHZjakN2MzFZcmprRnp4a1VYa1hE?=
 =?utf-8?B?S2xEWi9sZGZuQWI0dGUrZE9YZWtTOUlDcmROdHhFekNJQXR0Zlo5bjBIWTZD?=
 =?utf-8?B?S0d0QmFONFcrTGVQYUoxdHdWSU90Q0lzVFNzOW96ZWxLN3NuRjYyZk9EMVZm?=
 =?utf-8?B?UHFxdzE0WWxCemozZmcwSE4yTldUeWp2UHBoUGsxcURaTE5sbHRTV1BiNm9M?=
 =?utf-8?B?T1NnQ2dzMVVIV3BhVXpvMzFWamk2ZkxydmxNcDc0M0srVTZnL1R1OVFxOTJ6?=
 =?utf-8?B?MXlMMmNxc1N1K2I3cjJhNEpiTjZVRlZPa0pqK1N2M3k5SU5wNW9DczBlcGF4?=
 =?utf-8?B?b0grK0xRbW1uYnFiZFkwN3pTRjBwRDd2U0lnOUxUTytCWWZ6T0h6SVhMTU40?=
 =?utf-8?B?bnhJQ1lGRElWN2ZwUzcyZTBmRXAzYlR3V2tZSFRpMzQxQ0ZIR2hUQUxHUmpS?=
 =?utf-8?B?YndndXdHN0pvMk9kcW51V2VnQUF5R3lvVVQ2RWtXTzk0alRUNHN5NlVHV3JD?=
 =?utf-8?B?bGc4Ky9SMFhsa1JaWXIvWHVIVXd1dm5WVFBtOTdzRXJTcjd3UC93UmlCbTdW?=
 =?utf-8?B?RU9wM2VBcHE0M05aMzA0aGx0eWlyaGIzM3dCeW5oYkJrRDFicXRyRW9aMXhW?=
 =?utf-8?B?V2NvRW9sL3IrZExmT3ZoU0ZFVUZuUGplaFZDd3FmQzg4UktTeWo0RUo4aEpr?=
 =?utf-8?B?enlkZmlWVHJhVFVIM3lRWEsva294OHdsL0RFL2MxL0twNEhUbm1IdVpiYWow?=
 =?utf-8?B?YWdDMFh4ek1EMkNHNnpIRUExVXNBckRzMGtlOTREU09MamlsVU54dklXNVhO?=
 =?utf-8?B?ajQ1RmdMNHhZb2NGSm4ydDEwUXZkL3B6SU8ySDZDTzd6TWl3K3FZOTNlbDQr?=
 =?utf-8?B?eVBQQXVGdVlubGxsbmkxSUNyN2Q2ZDhWcElOcWJBZVN4OUdYS2NQWG01d3E3?=
 =?utf-8?B?REpDRmpWaXRnTVpsUERuSUYvMlpyUXcyZGdYakdnVS9QaFJlcElUQlVZYmY3?=
 =?utf-8?B?MWJ0MGpZdU5UVzVpcTRmR01qY210azVETytRMHZuZmwwb1ErV05USktMYm45?=
 =?utf-8?B?QkdUVFV2bXhFZS8vOWxRcDdKVmRtUTFndTcxMDMxbUk2QzB5VTI4UmVlT25D?=
 =?utf-8?B?Z2hNWVVUeUl2c01VTXc2eE8vTUd3Q1BhQzBRTXlYbDRZVkdnZUNmMk1YeTFa?=
 =?utf-8?Q?zeh6Rb0isqHxS?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81739a74-5474-4fa3-0ca8-08d9200bc5f8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 06:01:59.2133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUXtAysKSDPFAHQgMCsjx4tqihqP7Zcom3/uKJjeXxfO0KqOoLj9HAscxOTgWGmPp+/an6l1Az++m1FDKjiYGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3967
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105260039
X-Proofpoint-ORIG-GUID: PmHyRPjAQ3Hedl4QD5einKyt7Or2U2UB
X-Proofpoint-GUID: PmHyRPjAQ3Hedl4QD5einKyt7Or2U2UB
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105260039
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 26/05/2021 01:08, David Sterba wrote:
> The type of discard_bitmap_bytes and discard_extent_bytes is u64 so the
> format should be %llu, though the actual values would hardly ever
> overflow to negative values.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>


> ---
>   fs/btrfs/sysfs.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index c45d9b6dfdb5..4b508938e728 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -429,7 +429,7 @@ static ssize_t btrfs_discard_bitmap_bytes_show(struct kobject *kobj,
>   {
>   	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
>   
> -	return scnprintf(buf, PAGE_SIZE, "%lld\n",
> +	return scnprintf(buf, PAGE_SIZE, "%llu\n",
>   			fs_info->discard_ctl.discard_bitmap_bytes);
>   }
>   BTRFS_ATTR(discard, discard_bitmap_bytes, btrfs_discard_bitmap_bytes_show);
> @@ -451,7 +451,7 @@ static ssize_t btrfs_discard_extent_bytes_show(struct kobject *kobj,
>   {
>   	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
>   
> -	return scnprintf(buf, PAGE_SIZE, "%lld\n",
> +	return scnprintf(buf, PAGE_SIZE, "%llu\n",
>   			fs_info->discard_ctl.discard_extent_bytes);
>   }
>   BTRFS_ATTR(discard, discard_extent_bytes, btrfs_discard_extent_bytes_show);
> 

