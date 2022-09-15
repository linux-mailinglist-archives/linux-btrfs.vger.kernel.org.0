Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB285B970C
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 11:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiIOJKY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 05:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiIOJKW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 05:10:22 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8191429817
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 02:10:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFeYBy/xqauaVydb83U8/nJkgr0EONh0rIiffWXFN2gl3hW8SSp+9q4Pug+BsDkLh+8+sonmsLz2pojsaaJ/lhtWAJoVLPpriYWBpUoXLa1FNhkr9LU5xBzmPUTmodLlzKSJ86JmAcOD0Nls16/AjOjLM39HK/7SmC2xNicEysHQozSJwf9Yv5m3Tbh6hBCYw+/MReknGLvCV7hIu8dz+Dr7VRsahdKBXgeDWXZDfTkVSfhfjpbZhpD7jjYlnl6NKBb2WSnAL8EO3aLYyuiEnslY7ApGjgJTgeptG7ktgvi4ZOXuukT/ZJrXwo/I7BeTszyw5W55KPb9hgrPRpSWug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQcErBSimO8jA28kXRRlV/S0zqfODY7PbpyD9DNw0Qo=;
 b=Eus5VUwh/HBrjNvGvRDRtIIOWHaYU8gSPJ+3I89V6iq/R1pIQJZmuNh5MYSk3byV/J7JJ647iX53RL3aX2I+J8EKE+8w19CNNMv66cMwQzdvncn1rUaJaYWZW7AH0EcwphkTGx9NKaXn7urUIJFdeA/UHFECgyC7SVkXyyCfBandtfkCoLZYjfi/cZFcdclLEdkmH0lifjYeJ6OCmgnb1DSx7PFydBrd6NBVA3AAyShi/gftZ8dhvEnwJFXAtPNr788FR+b7+kRmC1XKA5K5jrHn4l87uBM7XXyctSh5YVzPYffGLhKmdxc/2Uw8MS4ED89nXxIvqMviOLQ7FgjSDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQcErBSimO8jA28kXRRlV/S0zqfODY7PbpyD9DNw0Qo=;
 b=bLy6A+giicK/Ux/c296tNH9ChIKlYjvuSSzOzGGbZWI65Z0szEfQQxN1nmoqqdoOVUCtgW5noXkgNAYKkFtuLH+8TbFjXftrMwwFn3COrvRII8rkzePYAERK+pRIvUJfeZwYwHcB5bGJnC0jYoBUFLU6o+BAjmhzwpjqSf+IztSLtCZz3KmtCvRRGQA2VJUDERV8uZr1KnA1jVy8YPjRc1vYRYKe8Xy+n+7KvEA78ycH1h0MNqN6siI6IS8tkZDXJjYPE+SQyY5VfzoT+SkseZFpPZJvWNOo8gsQuhEnZlR8wC7sJf0A599JEJv/FHjYZgItLAdLU5kNNybNgREc3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DBAPR04MB7271.eurprd04.prod.outlook.com (2603:10a6:10:1a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 09:10:15 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9%5]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 09:10:15 +0000
Message-ID: <9f39fdf2-e504-39d5-d19d-bd8d87450395@suse.com>
Date:   Thu, 15 Sep 2022 17:10:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 05/17] btrfs: move btrfs_get_block_group helper out of
 disk-io.h
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663167823.git.josef@toxicpanda.com>
 <375729b0fb82db1991d42f26b0853f30a3c9086d.1663167823.git.josef@toxicpanda.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <375729b0fb82db1991d42f26b0853f30a3c9086d.1663167823.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0077.namprd03.prod.outlook.com
 (2603:10b6:a03:331::22) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DBAPR04MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aec10b5-e469-4ef1-cec0-08da96fa1a76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mzVu5UtV3RVuCCFSX0XHd5YIv9dkepqXYqUiTaKzg5KNX7jos+cNQxMU02LzVRXGuu46CKjItK/PnXV21QRtYyUV4LvGtAwMZk55dNOHwGrydvFKVZsOg9g37BmU4yWuDwAkVEwfiYRfA+aV8g2LmmJFz/R6GhLQLu9Lg/ESxbBk47K8njtRmFdT1sfj5z1jcqTuNzMNXkq5VduB5vXhS4VHkG6vE1rECX0vhsi1GsoGeOR/EQpM3yFIb6N1VjsEV0lnE47YOt1TrpSZ1zznvhhZW5Gvpafr4xNkz/jHdBYj3j0T3/EDMmc+HQIEMsH3XV836r12IGXzjNeBag0OxStH0Q1LB3XxCzC5BbOy5zVOVN6c1BZsItTi9bkNIdIryLvmxRLNWRLD476M8nu0yH3Beq8SZS4+7Kc/q6Ktrah7AZ5DtEukptqQQEkaH1f/jFVoFc2eRvCEtVKSIZKI6JnjmKPysk0VxoFqQOTUrqxEXfAw/n1x971+OmDuDdDgdKvP8Eqn64PRvTPewUDbDQZ8VCuscj6kNdGSMILK6WqMgfc9hYeK/Mf9Gxd4qeXWiR7ptXtpRJpVhgBXXnRpdT7JOOlqZbX1TbbIT05mAxa8jwSbrZwsQN7z5YCh6xCWt0WLPJdABjnaHUkIVRvk5+gAdV8R2leeAsOuREEb/UZYFTkL3F8WNWCZI/dG6DOHqIBDoQRKQl1OqgRHX9L64sctAg8zZPrQwlsFkbi1QJGLtfKU/pdwcsvRLLNuKi4Uzt8fBB9GnawhpAJxrXPD8kElmjKPeCSphXQUYY6AJU8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199015)(36756003)(6486002)(478600001)(8676002)(41300700001)(6506007)(8936002)(316002)(66556008)(6512007)(38100700002)(66946007)(2906002)(2616005)(83380400001)(5660300002)(86362001)(31696002)(31686004)(186003)(6666004)(53546011)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGlaS1JzU1hNcldmemdVZE1iUTcwTXJHQ0NYSXEzcEhQLzYwU2hyc1Q5LzVE?=
 =?utf-8?B?YXhLOURuK3ZkRUo3RTNtamN3TlVTdWdEbWtXRFBvc2V5Z21LN3VkSXV0SEVo?=
 =?utf-8?B?Z010OThoSEpvbnRZT2w1MVd2aGZubDJ2SDV6UmRWQlNsMVNoNTV4blMyL0pW?=
 =?utf-8?B?aWVTMjBkeVRlZndYeTkxVGM4alF5MUZzZGptMzVvVVJoenBoUTJrOG5FaXhN?=
 =?utf-8?B?N0xiZlpkUTNpMnFXbEpsMzFBVjlMbHpoTlM2Wk8zell2WU0yTCtLR0pBblVJ?=
 =?utf-8?B?NWFHTWFvMmlpMkplYW9LdlFMbitqemZzUmc2MEo0SGduNDZjNW9ZenB5b1Zo?=
 =?utf-8?B?dENhdmdmZ3RCbmZCZ3BtUUF2Z3VETXB4QVpUVUwzaFQ2NXBDKy9KNmROMmNn?=
 =?utf-8?B?eXNOc1pnZmZkTlFXT2JML1Y5dXh3T2xzN25ycmNUVEczKzFvdGdRR05HV3la?=
 =?utf-8?B?WWZOeXl1OUxicGMvV1hCeTZSZ3V2cmxZNGxENmVZc0o4ckZwUWVOVHdVMGZ4?=
 =?utf-8?B?ZTQ2Yi8xOXF6dlpDb0ZEMzcrQUpIRXpraUZPa0NHWWZkM0czWWNLZ2R4eklj?=
 =?utf-8?B?MlhxVlQxQkdiTUxVNndxL3oxM1lxK0R0U3R4Y3lIbndsSXVOYWU0L3NMVEZn?=
 =?utf-8?B?Qzl5UHhjNjVRK21vNlJCZ1cxRUdwaGNXVC96dEsrQnpiMEZGSkZDNi9iYndN?=
 =?utf-8?B?SENGbWJrMjhVOE53NmtDSVJZZTdBMTdqbllsUWFrSU52bnZRamsxTmRFTEZY?=
 =?utf-8?B?V2JvVEY3NXM4YVVYZWdKa21ZMmpRTVdTR2QwblhDNHRINzZMMDFwR1RZTmRa?=
 =?utf-8?B?TGpqaVJOdHBMWjBJeGxlNkNENFVXdEZLTG56bXNXbk9WS3R5azlPL3pJRkhZ?=
 =?utf-8?B?QnNRNWxmTW5icURaWjM5bW1rL3F4dHNRck91VTlrSmc3WS9TR0NpMXl2dGFY?=
 =?utf-8?B?LzY2MGJtUElmU2oxc3BOZHkvTnV2OGpSVi9JZ3RDQVcrUzcycUtyODBYaXk4?=
 =?utf-8?B?c1BzSXlwbEtHQjQrMnVqbVp4NHY4NndzQy9xZC9mT1p0M0s5bHN1Uys4emxJ?=
 =?utf-8?B?Y1poZFNLbFQ2UU5sb1Bsb0tYb1pyRnhsQWRQbW0rRmtVM3pMRHI1SGVLUmJU?=
 =?utf-8?B?OThsNVYyY0dvbmtUR0lEZEF2amZCRSt0MVZGYXhiS0JDeWRxMkZQTHZzSEVa?=
 =?utf-8?B?d0puM2lvTEZLT1hzYkQrMFJKOGY5ZWdsbDNKRlBUY2c2TnVDekZVUk5ZYTZW?=
 =?utf-8?B?d3BvemE2SnlPOSsxZXR2WWlzMW5DMHNJbHAxOUFQRXE2WDdMVkNCOE4xZkJZ?=
 =?utf-8?B?V0wxOVZjem92SXZvMXg2QVJCc2FHNlFib1pGNXgyekczbFNpMmk5K2VpKzI3?=
 =?utf-8?B?emgydlloTEwrczVDYnZXaVhJcEtGL3BJM2hPL1RmK1JJYUN3bHhFbHN1NXBR?=
 =?utf-8?B?WDhzYU5KZ3M0WFpIME9IRFhGcVU2K2tBRER6RXJEQnZucGlZUkpIUTRnQ2RF?=
 =?utf-8?B?QXhudi9oK1JNMXdOV25BQmZORXZhSi85Q2w0MnNjenRSYmZ3RURUVEg5Nmx4?=
 =?utf-8?B?akF6UXNTaWdwWWtDV0N2TkdldHdKOFQrOThWYzFnVHpORUJ0S3pjRkJlVDVn?=
 =?utf-8?B?SnpvVU5SSTFwYTBSUTY1V1EzbFBFajhrRUNXQldkbHJsamFtbGF4QjlPQmlR?=
 =?utf-8?B?bzRDVzhxMkR2eHU1WURVTWMvMENpZXpTNVJ1UzhsNk5MaGNydkFGWDZtejds?=
 =?utf-8?B?Z3lycWRTSEV1Qyt4UDM5R0J4WWVwYVdQbXV0NWNabkVjNkhIZmRXUzB2QWxy?=
 =?utf-8?B?VVJSeExPWkVUN1VWY2pOT29oOG1WTlZEVjFic2JJdTBzUDlyajBpNklRMzVX?=
 =?utf-8?B?Mzc3UEhXdnh0ZzFuWWFSK0JGU0ZqazA3cFpnOEFaK01ad29KcFFMS3lJQ2tL?=
 =?utf-8?B?K3NXQWJHNmRib0RtTHlUVGVkVlNPbEpmQzlwSE13Vit3OGNRa1liUHJzRnJV?=
 =?utf-8?B?VHhRV2x5aWxWci9yVmlEd3U5eHl0M2ZsT043WEVZUG13Z0ZTSDN6WHpoeXNj?=
 =?utf-8?B?ZU9LVHE2NUJZczQ2MWV4blBXZ25UWkJud0JUcVFDc3lKcDBoVEtSWXZwTGJZ?=
 =?utf-8?B?dTJmR0MzTnBSd1poRlJZejRoTjNFSy9TQlVFSFpudEpVV3NxZlVVREFUbzZI?=
 =?utf-8?Q?36qQm7q8bhT04B7nhrgLfqo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aec10b5-e469-4ef1-cec0-08da96fa1a76
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 09:10:15.7905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5Bmb87ywpBDmteA0CYhx8pr2zzRJH54oPC7jsylwBSFJGY0hf4F6QsAzM0Vygu0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7271
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/14 23:06, Josef Bacik wrote:
> This inline helper calls btrfs_fs_compat_ro(), which is defined in
> another header.  To avoid weird header dependency problems move this
> helper into disk-io.c with the rest of the global root helpers.

I kinda like this small function to be inlined.
As the function call cost is not that small compared to the tiny 
function body.

Mind to give some example of the problem you hit?
Maybe we can find some other solution.

Thanks,
Qu

> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/disk-io.c | 7 +++++++
>   fs/btrfs/disk-io.h | 8 +-------
>   2 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index a887fe67a2a0..d32aa67f962b 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1169,6 +1169,13 @@ struct btrfs_root *btrfs_extent_root(struct btrfs_fs_info *fs_info, u64 bytenr)
>   	return btrfs_global_root(fs_info, &key);
>   }
>   
> +struct btrfs_root *btrfs_block_group_root(struct btrfs_fs_info *fs_info)
> +{
> +	if (btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE))
> +		return fs_info->block_group_root;
> +	return btrfs_extent_root(fs_info, 0);
> +}
> +
>   struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
>   				     u64 objectid)
>   {
> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
> index 7e545ec09a10..084fbe5768e1 100644
> --- a/fs/btrfs/disk-io.h
> +++ b/fs/btrfs/disk-io.h
> @@ -72,6 +72,7 @@ struct btrfs_root *btrfs_global_root(struct btrfs_fs_info *fs_info,
>   				     struct btrfs_key *key);
>   struct btrfs_root *btrfs_csum_root(struct btrfs_fs_info *fs_info, u64 bytenr);
>   struct btrfs_root *btrfs_extent_root(struct btrfs_fs_info *fs_info, u64 bytenr);
> +struct btrfs_root *btrfs_block_group_root(struct btrfs_fs_info *fs_info);
>   
>   void btrfs_free_fs_info(struct btrfs_fs_info *fs_info);
>   int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info);
> @@ -103,13 +104,6 @@ static inline struct btrfs_root *btrfs_grab_root(struct btrfs_root *root)
>   	return NULL;
>   }
>   
> -static inline struct btrfs_root *btrfs_block_group_root(struct btrfs_fs_info *fs_info)
> -{
> -	if (btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE))
> -		return fs_info->block_group_root;
> -	return btrfs_extent_root(fs_info, 0);
> -}
> -
>   void btrfs_put_root(struct btrfs_root *root);
>   void btrfs_mark_buffer_dirty(struct extent_buffer *buf);
>   int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid,
