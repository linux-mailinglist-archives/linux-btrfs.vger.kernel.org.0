Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BBF496794
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jan 2022 22:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiAUVvR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jan 2022 16:51:17 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:15834 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231237AbiAUVvQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jan 2022 16:51:16 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20LKSeNs006713;
        Fri, 21 Jan 2022 21:50:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=QTVxEGg8tW4rUIBRPCAhNRYLI7f7+y3vRx7btmTo8Bc=;
 b=e/VjZ+DvWfRjkjJjkthoxOptFCBpN5Bj04UnJIMK8VOwN1xUmLrk5r0Ns8oOVGXZWjfJ
 gfqOmBSisbt/bcBm+5f+M39hoftnhM3dW8EZ6RfSNp7DSmlMRNh9pJwYKXEIDKT8JLBO
 GrR0ZyFIRr8eSGemqJM4swhrQx0mBxucEryDhiFD4nYIQ5W655JS+5jtP04F0quSBmqp
 HO8+97qPatcBdYaRJdkknWRjwgIrYF20gNFcPIBllFZzQpUQ+B9YX4AA/PFuzFRXIohi
 +oGJI7aJ5tyoj3EBqW8M4PEJeTwJoFcReVk51HyGNp68+qmugyn44Lslgx+TyOGeDlps 3w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dqhydtm4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 21:50:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20LLoEW2121828;
        Fri, 21 Jan 2022 21:50:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by userp3020.oracle.com with ESMTP id 3dqj0nn3yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 21:50:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fV/8DtwUsptPsIp0naNtz3SrSUbnByuWCclKSAlCu6tsw7gwhlGKPfgKrSU+wbkDUfwAfsxsuAdpyTcOuHNkBsdUgmEO69CTZQI9tsDugerVELfm1teieqk26k55FjY0B4avCDh4sNwC1JAE15MDDO91WF2hVTU0hTlTHMxN18xkFnHx/Ra239//0e9+HJfoF73Knb9obpT41yuhAi0C2ymInM7pGe2098P4iKhv6F79K1qopJuE90lwFsSqB9O09oSPs+eKY+b9IzWt9oZ9419mQkRt8/jPQcc2C9dSUGs3CBkovKIXOA6IvNGQT4aIYhhv27EVdZ4+X3Ohyzedlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTVxEGg8tW4rUIBRPCAhNRYLI7f7+y3vRx7btmTo8Bc=;
 b=C9egCWBUHQpVJWuAQxZzk0HYPtscIfJ2h2KoxPm4HJfDbBqPGzm2f3HBa8RO5GBlqooBakRQTm2kQ5EGfTVhcgVit5/1c2fmkoK2fjD6GQw/+qIfdxCsuW+CbjsLkSUOuL/7Q/zpgLWeeDdQ9JAWYvKA3cNLp8boVi7cd0j5vs5n5jCqDCjdx4iGsnzDxVkk2wunELURjYhkEbujjceJbuZg6uIxo3McFLancnb/Gvh7km3NxO1zjTMtiz1uaQswny6ts/iGHGTqVGYxYcQjJ2TPEz3MgQK0V//HCbhaV+9RbXEn827jvDIDpcWT7LDYleRLJy8l1frSgLDVb/N99g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTVxEGg8tW4rUIBRPCAhNRYLI7f7+y3vRx7btmTo8Bc=;
 b=RAxnaMxN0nObJckeoVcGZvS3OBV9/acz4Hjj2m977T4TpEpkiFx/oVosKgf9WvmCgyvKcd8NHvyBNy9ShzHaXtAYbNEle/i4w8tTHYim8PMq/sEkcSYxxkPipduT3EeDLKNlLMXx4xk9IBArMPnl4i6/rfiTetrGicJyATno3io=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by DM6PR10MB2443.namprd10.prod.outlook.com (2603:10b6:5:b9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 21 Jan
 2022 21:50:52 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 21:50:52 +0000
Message-ID: <81487bcb-6f48-9a15-2884-fb1441210d2f@oracle.com>
Date:   Sat, 22 Jan 2022 05:50:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] btrfs: initialize variable cancel
Content-Language: en-US
To:     trix@redhat.com, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20220121134522.832207-1-trix@redhat.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220121134522.832207-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0063.apcprd02.prod.outlook.com
 (2603:1096:4:54::27) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab187dd2-7afa-4066-61cb-08d9dd281807
X-MS-TrafficTypeDiagnostic: DM6PR10MB2443:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB244352087D58F3B4C6CA6FEFE55B9@DM6PR10MB2443.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ELOfNOh3lRecxe6EtpFvWe5XFoaguoXr0qsygWa5ibJ1f93kkUk33077VuKBr7FfzPJ05byZyQaivQjuYfwoWq2lyu5E29CgvatR9SKzORug1l1ad67kb0BEHKt0LHj0ijZh5UG+NlrT2amqIqS/lH2SOralQhy3FUBKTvUsx//hMvjkH5ovb8Y43/Ee+y1vKguoNM9IHphKPgNVdcCIhdllv8eH6iw+c4YrKuaQmr9ze9I1IQ8uzqpmBdcfH7RRz/5hqdbQ/b0Iz5LqXeNz9TMrH+55Kk0SE5MhceDOQZlGZ6XF4mq2Gw3V02X9oKe7TW/Qn3NB0wmgbpZQQTngvZWfQ+uwC01xpiHkBe9JUgkWDcCDLUbXAzVxUb1b+bO72iok1d1MvOFI4bnpDbOGqQgdEn4TokjmIrtRt0EmqHwdnoosUT6x5PDLCpNi2GA6FGkOeQFpUIBMgBbRh7pIcHd92dCNLZNmpnsmLQ51tSc1fuwlwMmg/00iRULsEYLFhX8H1zNVzm5f7kmwkWPNHeOj3r3p12Vay8rNWQXGcU6I8b0AvaCl75xPaB0qVCMf3BQUoONAJey2dq2zHNnIavUsgOPtrBkS17McaKzamlztOr57WeM2iOogxodYQ+n2UJ2y5la9pAU7SeLAPQCgGPOArzsQANXEoAt5DSVxWjfDWwjzj6AZH561Qd2vVBvaz1ADiResHiJztIuA1ZrJrvfdbEaIHvydL6W1825DSPg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(44832011)(66946007)(86362001)(83380400001)(66556008)(66476007)(2906002)(8676002)(4326008)(508600001)(6486002)(6666004)(8936002)(26005)(6506007)(36756003)(2616005)(53546011)(186003)(31696002)(6512007)(316002)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0dnS1UrUDlDcGt3T3NFZ215ajVwVk90NVBiV2RkY2orTDlIUEVPZmV5eWht?=
 =?utf-8?B?MkNaK0xkMm51YzNidGR2R0U0SUJ4YlhFMGNnRjlZTDV2V3B3MG96MG56alRW?=
 =?utf-8?B?cEQzeVBqT21UMy9obHJpU3ZSZWk2djlTUjNzbnVYNkFIeklYOVFxQThkSUJZ?=
 =?utf-8?B?ZmxCNldvZy9ucWhUTUhrMWR4allZMVNEK2NkU3ZLYXk4aE5mbjNSdGE2K0k5?=
 =?utf-8?B?N1RjanNPRDZaQlVYU0dQQVlTaHJuTVhEV2pKR0J4bTR5clJpRXVHYkJJMDl2?=
 =?utf-8?B?STM5NW43Z1JQby9ic1d5QUg0QkRpSlNIb1NHWGovV3gvZ2ExMGk4NlJLclFq?=
 =?utf-8?B?aENXbklicjRYZ3J6dmFrZnQ5MHVuOWFpRW1uS3VKSjlVWnNFWlIvNVZDc09k?=
 =?utf-8?B?bTdiQjNrc09YY1h5aklIeVNTT1J3anN1bHdwRkh6allNWFlndittSG9wbjh6?=
 =?utf-8?B?aFBRYTd0eXlzVkd6eUZkczAxWDV6eDh6OXcvcWtaL1JiQmhCUFlxVk1TLzlF?=
 =?utf-8?B?U2VteE1IS0RTNy93VGVIR1dKYVl5SW1BWGxrYlZmd3Z2aU5Iem1La1czQVRu?=
 =?utf-8?B?ZjB5SzV2TGVBRE5MczR5U1JFUmIxcHFlam1PSXhBVnhmR0ZYN1ZpOGlqSmtm?=
 =?utf-8?B?WVJOQkN2WXBaQzk1UkhxMU5kQ050Vzl0TWtmVEVzOGVtbVVnb1p6V3FBN3l3?=
 =?utf-8?B?UVdpam9VK2ZKaFVwalVNQTgzbnZmSWNPYnBlK1ZEYU15YVkydFRDTys3djN2?=
 =?utf-8?B?ZHdUK0RXV0dQYWFIVW91NDJIRGdZU0c0UjdzNGhTTTNrNklZejVUVjJSVU5E?=
 =?utf-8?B?aktXdmdqc3ZhcFBhZ3pIUW5KZ2NvQVBGMTlQR0Y2TFV3elJGdnVMaFF4M3FK?=
 =?utf-8?B?OUcwTG9nRWg4dmxRcGZqc3FEd1I2VUgzVmpKTnJaSEUwbDZ3elhrcERHZFhh?=
 =?utf-8?B?NFFNOXo5WnB0QzB0ekk4NDJhRkxIZG9kb1RiYzdwZ09CdzV4UDBKSnFBSXkr?=
 =?utf-8?B?K0VCbk9TM3ppRzF6R0dSVjlYcXhFVXBnbURIYUxnTURodElBUUJEZ2RNK0FK?=
 =?utf-8?B?SWJZRkVDQlBYSHdqOUtINVYwT0NOaDB2cURsVHBWaVpQLzR0SUZFckcwM0Yx?=
 =?utf-8?B?Mm54Vlh2TVRsR3Brc01qSkNmYzZOWjdId3VpaWRXcENOVFU1N1M5SnV1Z3FC?=
 =?utf-8?B?bklFSWpkRjhIR0FMM29hUm9JVmloU2YwZndxeU9LMFBKY3FDbE84TXB3aUhW?=
 =?utf-8?B?RVEzSmZCZms0WEszOFd0Tkk3UCtGemovZ3J4eWN1V1JJdHp5UjBqNzQ3c1lK?=
 =?utf-8?B?L040RU1sMDVvbVcrbEFkZUcrL3llbitDSEUyOUY1a0QyTzh0Yit0WkQ5SW1U?=
 =?utf-8?B?VTdkNjFFRHU1bzkwdUZ5b1E3YkVGMTdleGg1MWFLUkI1dXFtUlBHTjZNRHlX?=
 =?utf-8?B?UWd0OS94K1JYRHZ3VmQxQ0ZDdkRTSzlwcERZckZoN2t1OVBXbHluL1IzV29i?=
 =?utf-8?B?ZW1ud0dBbDE1Wnl0OE1wM1JwOTRVYlJna3ZCbHp5TStPcW53ckJiWjJ4RXk5?=
 =?utf-8?B?NCtzSzlhdHo5NnNEZklVNzJVSldMc2pqZllUcndITUR1LzVZOHRTeEZ1c0dk?=
 =?utf-8?B?M1ZnRnlHUkdPVElwVkUrVlN5emZNMWxocnNvajduNmM5MmpmRmdYZnBsZjhY?=
 =?utf-8?B?RTRRVjF1MUcyUE1xUlJOUnZScHpzTXBmMklta0FUZVBqazRxMFN5UkZ0M2lD?=
 =?utf-8?B?MGtQS1cvWEpUcyt4bWhWMmtpTi95TXJ2V0JpQ3pPY2lVc1NYUUVWQTJUT2ZS?=
 =?utf-8?B?Umk3OU51MWZRRTNuUWlLUCtPUmJITWxOV2VOSmZpdW5TTysrVEpUczFWV0xB?=
 =?utf-8?B?NVl5cEloQzNiSGVsQ2c1RmwwVFRMN0ZjaVloSnkrYzRkSjZSTmQ3aldqem1u?=
 =?utf-8?B?b05sMDFQUTJIYk9GcHRKcEJ2ME8rRHpuNWl5SVk1MzBFY1VCdzZ1TVRFa2lF?=
 =?utf-8?B?MGlsS1Y0MXJvK0U2MElsYktlZUR6aDJDUEFGVk9HMUZBdjhJUXphSUg2cXlK?=
 =?utf-8?B?K0VJZTJ6UGd3TmdZcnc0U2pHN2poVFZpNzZlanIxOGxmd21zQVU3OHV4eE9j?=
 =?utf-8?B?V3lWU1NuOHI4QmRvdDZxeU5RSnMrNlh0NThKVkJDcnljVDlUZFFCMFo5VENI?=
 =?utf-8?Q?iwAMQQeCa+1tk6F1gVh3R+g=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab187dd2-7afa-4066-61cb-08d9dd281807
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 21:50:52.4796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HNNEZLa7kPaYWgRzdSJtaWPAHYG2J3VN2UtWeSrllLcavBUG47L0/E9Zd/DUlqVCM3377dtb0i7Tnb8xJElXsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2443
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10234 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201210138
X-Proofpoint-GUID: C8UiohaTkxLqRWcAJ33EbF1KRPw8VZ_7
X-Proofpoint-ORIG-GUID: C8UiohaTkxLqRWcAJ33EbF1KRPw8VZ_7
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 21/01/2022 21:45, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Clang static analysis reports this problem
> ioctl.c:3333:8: warning: 3rd function call argument is an
>    uninitialized value
>      ret = exclop_start_or_cancel_reloc(fs_info,
> 
> cancel is only set in one branch of an if-check and is
> always used.  So initialize to false.
> 
> Fixes: 1a15eb724aae ("btrfs: use btrfs_get_dev_args_from_path in dev removal ioctls")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>   fs/btrfs/ioctl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 190ad8af4f45a..26e82379747f8 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -3308,7 +3308,7 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
>   	struct block_device *bdev = NULL;
>   	fmode_t mode;
>   	int ret;
> -	bool cancel;
> +	bool cancel = false;


  Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks,
Anand

>   
>   	if (!capable(CAP_SYS_ADMIN))
>   		return -EPERM;
