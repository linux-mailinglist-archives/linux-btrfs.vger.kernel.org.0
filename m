Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387D43F6D06
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Aug 2021 03:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhHYBUZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Aug 2021 21:20:25 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:61566 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229969AbhHYBUY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Aug 2021 21:20:24 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17OKuwUQ021207;
        Wed, 25 Aug 2021 01:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WgKF1FSj7SQgyVC67fYzKIKIDVTfrVCDvaKTIz1NHWA=;
 b=ofiyFPRSd6Op+h2j+3AyyCQqHAFgD01X4uW5eh3Nte7R1P9nk580AYrS/ulO22nNygKB
 4IXaSftJerp6ZzaV52QWZd2lY/jSsYt4Jd0NTJVQBQpgjR5yTvzxwrIbrcKuiPSfbhQc
 WnBwBpWw0WV9muFtS7rhLKaxHliSjKOp8D6Qj8ukN4yT2035goe51nEzUN+g+b/rm3Xx
 2XMnT2eIVn4WH4AS3WQ0kaS1EzMRXfGU4ghbDnrAIGW7ypGqmhgL6g6YVWhoWK0TWjla
 H72v3JNE6+inCnfT1xJsMArO7TLHWcr3Se5hO0rRfE7/Z4R2lFx7LUnGlFO8wFpFn45Y DA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=WgKF1FSj7SQgyVC67fYzKIKIDVTfrVCDvaKTIz1NHWA=;
 b=BJCpMXe2XEZWgAMCWCtPGZcEVdh2uUnsZpuNqrZOwhfITr44zq6zbDIU1P/H8GtQPDuG
 D76gu3adSCAA0c0EwjJ8wajUYD65dXIgFGU52421Ky4iWo6nYfO9wGI+8N/WggC2+MOw
 MOHbWdXm2zY0sNKSjDdvBcKOOIU04E0f7kES3DJcs/W5DEaGlBSR8hb/OKh4YGisPFMc
 riGz3XB/oP711+2ziS9gSOPipRTxy+0csvjG8StWRjWntK9pwBiulG4mf/8TC+qir23Z
 1ybU12C703t+7yyBMEn6/qvGL/+JEh3407RLcXW6LvvqCBwdRBH+tdrsE+c0uHoGKbkV HA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3amwmva5t8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 01:19:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17P1FZRr044059;
        Wed, 25 Aug 2021 01:19:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by userp3030.oracle.com with ESMTP id 3ajpkybehm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 01:19:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fntCUZxGuBbxGAdo02eyqDQiAyHRR8/KMKl5zZ7smGQ87/lVm4xA0/rr8G3GlrkcsKS29wh/0iC7eC3JO6TIz+9XUPHUmGpmu85Gd0Oy8b+VW01Y6ZjG4K9LIASAtscxOhclOE0ZWweqlpjRHlcB5x4lxy00uLOmOKYONUeE4ArbJuMy9QA9wGY1NDi7ca4m/m1TqkoIDZAlig7JljqrN7R5I9P7vzcT6bsCjgQaS/VlQZ5M+wAyD8Gu1GOYeGjqpdqRbIT50F/Epaaj2Fx9EFpw89d1CxBPY5FZysVzVTH+d4TItl8sOLskesvcfaO52nfgP0Z+l46UY0TeWNkxEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgKF1FSj7SQgyVC67fYzKIKIDVTfrVCDvaKTIz1NHWA=;
 b=dDOR2rmHMuqbrYdIlfdhLisxwq7bsKhn59qM4VkysYCA6SrW/HqQMBO0Iy/Yn4rSHJ0yHSYc/Xp4epeOpGeGXbsLLdh3G8W6ErQrprvt8IHSi55eVJX0CYtUO/fpnUy0O3pW8ETUtobWzQlpqa4kLuwlBqZK9UcY89YpAbQYN1SSKA/0ZkYjKshNyCWkfxfbA9jZuokjD3wxWbXcIo/43dXo8buToD+DuY+Ex2csCXmZRtbqt1pM2oVB5r6rRrpChcs7KfLrG/h+54fqlrrnmkMwJQQL5AHxV+Cu7hwS5vid8WHCvyAGzvskRlz0bQlGrK/hAODNdyCga09Gn3OAPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgKF1FSj7SQgyVC67fYzKIKIDVTfrVCDvaKTIz1NHWA=;
 b=SGnrq/pbSc1z40NiaB59HHFmX9GrkewFBL5DLF+840gXsyjA5s1crmoowsrjNXzxe0Lm48tCCEau/naJ/+8w3Nzm7uYOnEVuSFWRbE8TGmLiZyeJXmt2/GvmDqQ3FroxVNdvHGDxZdfM0BU0Otij/u/WejxS/It+J6GT9q1PdhQ=
Authentication-Results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2961.namprd10.prod.outlook.com (2603:10b6:208:33::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.24; Wed, 25 Aug
 2021 01:19:35 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 01:19:35 +0000
Subject: Re: [PATCH v2 6/7] btrfs: unify common code for the v1 and v2
 versions of device remove
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1627419595.git.josef@toxicpanda.com>
 <2107b5db383aa3dfb54a30e5b0de015be1ff6d1f.1627419595.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <f18a49bb-46db-bff5-d88e-3f5e95e899d6@oracle.com>
Date:   Wed, 25 Aug 2021 09:19:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <2107b5db383aa3dfb54a30e5b0de015be1ff6d1f.1627419595.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0168.apcprd03.prod.outlook.com
 (2603:1096:4:c9::23) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR03CA0168.apcprd03.prod.outlook.com (2603:1096:4:c9::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.9 via Frontend Transport; Wed, 25 Aug 2021 01:19:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2971907c-46d2-437c-3ce1-08d967666619
X-MS-TrafficTypeDiagnostic: BL0PR10MB2961:
X-Microsoft-Antispam-PRVS: <BL0PR10MB296156E6432A397F957364E0E5C69@BL0PR10MB2961.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:110;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 08xiWwD0gKdrxG49kL4xQiuY4A5FgoCWKjY8VzNx8bEw71pVwb0Ids3BYX44ZQ+TyTEg2gQmvfQpwBWoCyeXCUpXY//7UWXRqBmUHkrXDwpbhsDmkaLWG8hM1z+pAzNAVOw1tSjLR57Ot/pZCktrVY+xeMXID4eAxXYDBFw9RXeSbzz1erb13cr8sihijeOQWGPUpQOe3s0Oo4rDZZfvsRkoN0PjsHpaEBgB/NvAx6f/6CoXpBthbaJ7pqTol2UbKghBBdqYLWmejj1g7KbesWcDJKh3q3CFsHtfrg2Oku2M1VwO8gBYCgjnIaCpxvSFJJyDQonOz8p9WoLzgTVw7OYpDfzNJ6OjVM3uey4TKqvtw9CjlHUWwa5dAWIepnRczRxwtRv3+EJRJxb5OGayCjjfXIVrvWAuB5F119YA0TVjjLRzV+PWfVfrrWVEbaCFc9DvCFeVWYKNXta1ZWhhumJZOgDbquJs6LmJuYyobd7mt7VxRItQqzjhhnnYcjI+EHliB47SwJ3yF9EAlwL9/D6GxIWScuiim/duJ5A8pXYomclXzIaliRLT85Ra8xlmtFHwD/bjDYzhnn8BwQlBMHBfkvVADO4WNJlw6rEUDjLC1tZMguamKfDfn6KHDYZgYRE2l7TJ1499VaT2QX/Ky5A8QVztwj6RUXvBWfCsKG8xHoF3ySskPLb+nRyXNvEIa856IFj0L4KWllRFLGKPYMLTO3oGkwoLOynU8hJf3lI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(366004)(396003)(376002)(136003)(2616005)(956004)(2906002)(86362001)(44832011)(26005)(53546011)(66556008)(6486002)(36756003)(5660300002)(83380400001)(316002)(31686004)(6666004)(8936002)(16576012)(186003)(31696002)(8676002)(38100700002)(66476007)(478600001)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RW9IRUtRaGwwczkwdkF3V2ZXWlR5Sk41MXBpcFljLzdBTkRRWER2KzB4d0FF?=
 =?utf-8?B?VHZhV2FsRUZiNEx6aHJzd28xMCsycUExcXBxcURFVWVkaU1sV2RnOHgwdlVI?=
 =?utf-8?B?OTVHb0V1QTJuWDluaG5MSGtkcTl4R1owRzhaNVA0d1BYNGNjZ2pFSGd3Y2ww?=
 =?utf-8?B?L3hyL0J0emJ1SkRYcExvUGNmZ0xVRkZSQkhPZENTOVc1MmY3cDF0OHJnZ1M0?=
 =?utf-8?B?OE1sQWF0b2h5YzVHSmkzOCt3bUJScGFPbWVKcVMrOEk4SExMcDFYRU9LcW9k?=
 =?utf-8?B?Y0dEQWRxVDl6eGY2dTVnQ1RvWHgxcEEydDdlYmhnbTJiaGg1K3pGaGp3UVN3?=
 =?utf-8?B?b25uUElVejRQeWhPcExzaXgvMXBmZTdhZWRISnRJL0ZtZW5lSUtmS2lzYUFY?=
 =?utf-8?B?ZGF3YjNIZy9JamNmYTNsMnRPTm1nK3RkVWU2cTdiRXV5d0ZVck0rVWhkcmEx?=
 =?utf-8?B?MXd0a2Irc3J5R0ZhUjJUc0lLTG54U0VnM1JYU1hXeUYxZCtPZ21QQkNUQmVZ?=
 =?utf-8?B?YUNJZ1B6ZGdYUDFJTVdDZFR2V0g0ZWFDOEpvRzcvOVVMVC9iQ1h0TGNzU0Y1?=
 =?utf-8?B?SDlTY25GTUR2Rm5lYmJjN1hWby84elNCUWJaZDhXU1p3Q0wwNHJUZC85ZWFU?=
 =?utf-8?B?ODUyTDZTNFpTRzJ6TjA2akM3dlJ0ZTRyei95U3hVdjNXKzFUb0J5QWZuVi9y?=
 =?utf-8?B?RTVNTS9WQTNWR2ZPSjQrUS9YSVR1bmkvQ2xhZnd4cTd4UEp4dVV2U0lrMDBq?=
 =?utf-8?B?eTBqVUFvZjY4dTB4NWw1TU9mVDE5cGo1Y2ZydUsxaC8ycnkwUk5EaFgxQ3ZZ?=
 =?utf-8?B?bFJkSEdGbFBmTStEOG9qck5MdlQza09VaGU1U3Q5Y3FRa2poTTZYSTJBT0Y2?=
 =?utf-8?B?cU04NXNuZk1nNnlQSkRPRWJpWGFVZmJzd0M5NmlQRENvYjNIMEVESlliN0wx?=
 =?utf-8?B?WTZsaTVUT3VDbmNoVHFPZEs1YkQ3V05FQVc1VWIrNmQvU2xkb3RidDZEbE1X?=
 =?utf-8?B?S1ZRTjFwNU9Vb1JxWC9vb0lvSWN0ejZWZ3FCSUpxMEZkL2MxWDRJZUVvNWV6?=
 =?utf-8?B?aEM3dEIxUE1DTDZCTjhEMFIxY2JSTFRQMTVsVFB0MVNWRW9WTGZTRGZnNk1a?=
 =?utf-8?B?dDV2UVNMTm5yQ2ZqbmwrVFNDWWVjYllzd2gxU1dWajdNUW1yT21KcjA4bU1V?=
 =?utf-8?B?YWZtbWxRcUg4MlhQRC94V2oxS0ZUNnp4dHdGV09nQVVhbFgrSjhuOEUwcGM2?=
 =?utf-8?B?Q00rODJqQXJCQ1hMMmJzYkJhYjViN3VnTUJYa2FNTkVKY001b3h3N0N0MnFj?=
 =?utf-8?B?V2tNVFo0dlUrOVlXc3VFTEo4dGlHSEp2YnV6QlRMcE9OVHBNMTlKSEFqNUR5?=
 =?utf-8?B?eUdYb25ON2RVR1lsQmU1VExIbFZ4ZWI1bUo5Qzl0TDFIY1h3bzd1RDM3TDV5?=
 =?utf-8?B?NVlISEJnVDgwL1VXcVl3dXlRMWV1enFyUktGbHhqRXlzUVpiZ09VdW5iNzJj?=
 =?utf-8?B?cXozM0ZzWGFtdXVOdGVSaUFQWEVWT0Q3NHQ0cncvVE9kaEp2ekN6MDZ5VkZ1?=
 =?utf-8?B?dmtvRm1WeDIvS1hVSFJSK1E3d3VwQnNnbWx5UWo4ZHJYcWQyNFUxV2pRNk04?=
 =?utf-8?B?RkFMb1JiSXBPd0htSURDaCs4eEZ4T3F4Q01jcTl1d2E1d3lpbSsxWStkbVE4?=
 =?utf-8?B?eVRrT0V5QmZ1aXV3TWN1TEZQN2Nqc20wbDFYejMzQVpQbFluZ002U3FqQVd5?=
 =?utf-8?Q?hWB5ve/VMcTcKRW7iCuZc0jJAZufMPqD1O0dZ+f?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2971907c-46d2-437c-3ce1-08d967666619
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 01:19:34.9907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lCOTkW3QZLejfrbxodeEjTjzgqSgvYzun3D+yfUR3Fn5ZpNZVHuSVSshm0fwaKne9yFg7Y+N7KuKSwlOahQYPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2961
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10086 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108250006
X-Proofpoint-GUID: C7qQCOYkHoMauvpi7TENGJKn3q79vS0F
X-Proofpoint-ORIG-GUID: C7qQCOYkHoMauvpi7TENGJKn3q79vS0F
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/07/2021 05:01, Josef Bacik wrote:
> These things share a lot of common code, v2 simply allows you to specify
> devid.  Abstract out this common code and use the helper by both the v1
> and v2 interfaces to save us some lines of code.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/ioctl.c | 99 +++++++++++++++++++-----------------------------
>   1 file changed, 38 insertions(+), 61 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index fabbfdfa56f5..e3a7e8544609 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -3200,15 +3200,14 @@ static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __user *arg)
>   	return ret;
>   }
>   
> -static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
> +static long btrfs_do_device_removal(struct file *file, const char *path,
> +				    u64 devid, bool cancel)
>   {
>   	struct inode *inode = file_inode(file);
>   	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> -	struct btrfs_ioctl_vol_args_v2 *vol_args;
>   	struct block_device *bdev = NULL;
>   	fmode_t mode;
>   	int ret;
> -	bool cancel = false;
>   
>   	if (!capable(CAP_SYS_ADMIN))
>   		return -EPERM;
> @@ -3217,11 +3216,37 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
>   	if (ret)
>   		return ret;
>   
> -	vol_args = memdup_user(arg, sizeof(*vol_args));
> -	if (IS_ERR(vol_args)) {
> -		ret = PTR_ERR(vol_args);
> -		goto err_drop;
> +	ret = exclop_start_or_cancel_reloc(fs_info, BTRFS_EXCLOP_DEV_REMOVE,
> +					   cancel);
> +	if (ret)
> +		goto out;
> +
> +	/* Exclusive operation is now claimed */
> +	ret = btrfs_rm_device(fs_info, path, devid, &bdev, &mode);
> +	btrfs_exclop_finish(fs_info);
> +
> +	if (!ret) {
> +		if (path)
> +			btrfs_info(fs_info, "device deleted: %s", path);
> +		else
> +			btrfs_info(fs_info, "device deleted: id %llu", devid);
>   	}
> +out:
> +	mnt_drop_write_file(file);
> +	if (bdev)
> +		blkdev_put(bdev, mode);
> +	return ret;
> +}
> +
> +static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
> +{
> +	struct btrfs_ioctl_vol_args_v2 *vol_args;
> +	int ret = 0;
> +	bool cancel = false;
> +
> +	vol_args = memdup_user(arg, sizeof(*vol_args));
> +	if (IS_ERR(vol_args))
> +		return PTR_ERR(vol_args);
>   
>   	if (vol_args->flags & ~BTRFS_DEVICE_REMOVE_ARGS_MASK) {
>   		ret = -EOPNOTSUPP;
> @@ -3232,79 +3257,31 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
>   	    strcmp("cancel", vol_args->name) == 0)
>   		cancel = true;
>   
> -	ret = exclop_start_or_cancel_reloc(fs_info, BTRFS_EXCLOP_DEV_REMOVE,
> -					   cancel);
> -	if (ret)
> -		goto out;
> -	/* Exclusive operation is now claimed */
> -
>   	if (vol_args->flags & BTRFS_DEVICE_SPEC_BY_ID)
> -		ret = btrfs_rm_device(fs_info, NULL, vol_args->devid, &bdev,
> -				      &mode);
> +		ret = btrfs_do_device_removal(file, NULL, vol_args->devid,
> +					      cancel);
>   	else
> -		ret = btrfs_rm_device(fs_info, vol_args->name, 0, &bdev,
> -				      &mode);
> -
> -	btrfs_exclop_finish(fs_info);
> -
> -	if (!ret) {
> -		if (vol_args->flags & BTRFS_DEVICE_SPEC_BY_ID)
> -			btrfs_info(fs_info, "device deleted: id %llu",
> -					vol_args->devid);
> -		else
> -			btrfs_info(fs_info, "device deleted: %s",
> -					vol_args->name);
> -	}
> +		ret = btrfs_do_device_removal(file, vol_args->name, 0, cancel);
>   out:
>   	kfree(vol_args);
> -err_drop:
> -	mnt_drop_write_file(file);
> -	if (bdev)
> -		blkdev_put(bdev, mode);
>   	return ret;
>   }
>   
>   static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
>   {
> -	struct inode *inode = file_inode(file);
> -	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>   	struct btrfs_ioctl_vol_args *vol_args;
> -	struct block_device *bdev = NULL;
> -	fmode_t mode;
>   	int ret;
>   	bool cancel;
>   
> -	if (!capable(CAP_SYS_ADMIN))
> -		return -EPERM;
> -
> -	ret = mnt_want_write_file(file);
> -	if (ret)
> -		return ret;
> -
>   	vol_args = memdup_user(arg, sizeof(*vol_args));
> -	if (IS_ERR(vol_args)) {
> -		ret = PTR_ERR(vol_args);
> -		goto out_drop_write;
> -	}
> +	if (IS_ERR(vol_args))
> +		return PTR_ERR(vol_args);
>   	vol_args->name[BTRFS_PATH_NAME_MAX] = '\0';
>   	cancel = (strcmp("cancel", vol_args->name) == 0);
>   
> -	ret = exclop_start_or_cancel_reloc(fs_info, BTRFS_EXCLOP_DEV_REMOVE,
> -					   cancel);
> -	if (ret == 0) {
> -		ret = btrfs_rm_device(fs_info, vol_args->name, 0, &bdev,
> -				      &mode);
> -		if (!ret)
> -			btrfs_info(fs_info, "disk deleted %s", vol_args->name);
> -		btrfs_exclop_finish(fs_info);
> -	}
> +	ret = btrfs_do_device_removal(file, vol_args->name, 0, cancel);
>   
>   	kfree(vol_args);
> -out_drop_write:
> -	mnt_drop_write_file(file);
> -
> -	if (bdev)
> -		blkdev_put(bdev, mode);
>   	return ret;
>   }
>   
> 


Looks much better now.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks.
