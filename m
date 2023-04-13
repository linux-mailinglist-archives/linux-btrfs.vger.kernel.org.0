Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E836E17C0
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Apr 2023 00:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjDMWyX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Apr 2023 18:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjDMWyU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Apr 2023 18:54:20 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3841F4C05
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Apr 2023 15:54:02 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1My32F-1qZAB115Bf-00zXvv; Fri, 14
 Apr 2023 00:53:56 +0200
Message-ID: <586e377f-8ee3-2c50-648b-a5336b8a99dd@gmx.com>
Date:   Fri, 14 Apr 2023 06:53:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] btrfs-progs: move block-group-tree out of
 experimental features
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1681180159.git.wqu@suse.com>
 <4cc5819796bd2af6de78b7a1919b4f8ed02b985f.1681180159.git.wqu@suse.com>
 <054ae0c1-3a1a-eed5-5ac9-c4d7773c8ab9@oracle.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <054ae0c1-3a1a-eed5-5ac9-c4d7773c8ab9@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bXxl5jSFZ1iXjlu5SDfdmhF94oy7WU+Tpomnp/B2POugix8A3Ne
 gyC85F0J8N2V6aLRyRt7OA/7leQIWjw6zU1S8iYftuWPhsbuU7f5SXj8G8kOR9FuigF+cxp
 di4KuaNTpZxzh3TgVLURJRZjDyKZz4fh5kyVykuwj+3qAbEKG4TaqeRrAcR/TOmGwzaowUp
 u4rBXwVAK00+2Iwbltr+Q==
UI-OutboundReport: notjunk:1;M01:P0:7zDvNSYRKWI=;brlSCGHBNzXqkB9gQ5t8CfE8dKH
 TgjecOdgnjizYzY3qA+sCwM3cP+ZoUOZFlmOLgTJXZ+KAkmuMqn6YYhYlzO4isF6g9wHy9356
 szjz4nb/2MHKP1ibDDFn1L5SPZiMtQJSny68xYoYWMUM8BJ2ro8NpfbrXcAofUfBoRhfPKdHI
 wqF65XqiCRLvEa0J0Jomy++FO3VjfurD+mQMxd04sUtZ0AtLBgPuC+Mq7ZEr8ZLBWktjTnOcH
 BXGnbcTiSdhGvQV/v0x5V8r0pbqyJfLtHFf/ILqp9KneXVeKhHRWUFNZKhDVWN45cKoAnKrRP
 9pINhM4ICK7QAmI3tTXyOu1aM3Ur3F1T+JC7/DrgqQg3xeh3tS4y6Nmz/gdP1oYFDJIQ3IyS9
 EHJuVOvzrGI0mYMKU+1xhdMRb73hJ+ywxHafAgzTC1JeRSuqEAhL7wTP5wz8gzMOSHgzjpKJ1
 ykBWHZIs+RJo1T5dus9L35kqMUUeFKIaNcTZFp8UhjG3G/uQnYGMzidOdcY2IkKjFb7XY6X0F
 cIen83pZ5Xmkd2iJiDz9yIVTKxSZSBRM0Q1mOp8wL3vwcMUXykiyTdKyuRkWbXXe6hkevT4eJ
 Ad/Zm2RC77xlfBw9DKenB0np1qWn/NtWMS14U8Xm7wsokTHo+i1B/BNNfIQdV3cHg2J55lMFI
 f/WJepsh6Oi+sJwje46R2yTCt+JeaFA26QIx6KYJl+LS1yYcy7E7AbG7xOhwu7LCPoEhoD80r
 h3fHkIHDP52surt9/yWFGRIoYQW6oxHVV3JrVB5DmHUJ6K1DwWVjEFssylcjFMRkJSetQpTWO
 SG69IcwSU5/On32iFqxHDU+XKVDPqdTwvYHZ9BTdB81d3vR2lKhAKQUkQjB/XPCC+eZ7XOxUH
 x+GEo65qJYcaOqxw1c45q2eUQxE8901vqQ1GVtUJPg+TG0sMboc2vOLMSXHLDiMSRJNvwEqN+
 W3F5tb6NPSoiLO6pOURF2FFPRTQ=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/13 20:24, Anand Jain wrote:
> On 4/11/23 08:01, Qu Wenruo wrote:
>> The feedback from the community on block group tree is very positive,
>> the only complain is, end users need to recompile btrfs-progs with
>> experimental features to enjoy the new feature.
>>
>> So let's move it out of experimental features and let more people enjoy
>> faster mount speed.
>>
> 
> 
>> Also change the option of btrfstune, from `-b` to
>> `--enable-block-group-tree` to avoid short option.
> 
> What is the tradeoff for the desktop use case (lets say 1TB disksize)
> if the block-group-tree is made the default option? And add btrfstune
> --disable-bg instead.

No tradeoff except compatibility I can tell.

For --disable-bg, as far as I know everyone going bg tree is happy, thus 
never considered going back.

Furthermore, since it's compat_ro, older kernel can still mount with 
rescue=all to read out the data.

Thanks,
Qu

> 
> Thanks, Anand
> 
> 
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   Documentation/btrfs-man5.rst |  6 ++++++
>>   Documentation/btrfstune.rst  |  4 ++--
>>   Documentation/mkfs.btrfs.rst |  5 +++++
>>   common/fsfeatures.c          |  4 +---
>>   tune/main.c                  | 18 ++++++++----------
>>   5 files changed, 22 insertions(+), 15 deletions(-)
>>
>> diff --git a/Documentation/btrfs-man5.rst b/Documentation/btrfs-man5.rst
>> index b50064fe9931..c625a9585457 100644
>> --- a/Documentation/btrfs-man5.rst
>> +++ b/Documentation/btrfs-man5.rst
>> @@ -66,6 +66,12 @@ big_metadata
>>           the filesystem uses *nodesize* for metadata blocks, this can 
>> be bigger than the
>>           page size
>> +block_group_tree
>> +        (since: 6.1)
>> +
>> +        block group item representation using a dedicated b-tree, 
>> this can greatly
>> +        reduce mount time for large filesystems.
>> +
>>   compress_lzo
>>           (since: 2.6.38)
>> diff --git a/Documentation/btrfstune.rst b/Documentation/btrfstune.rst
>> index f4400f1f527a..c84c1e7e7092 100644
>> --- a/Documentation/btrfstune.rst
>> +++ b/Documentation/btrfstune.rst
>> @@ -24,8 +24,8 @@ means.  Please refer to the *FILESYSTEM FEATURES* in 
>> :doc:`btrfs(5)<btrfs-man5>`
>>   OPTIONS
>>   -------
>> --b
>> -        (since kernel 6.1, needs experimental build of btrfs-progs)
>> +--enable-block-group-tree
>> +        (since kernel 6.1)
>>           Enable block group tree feature (greatly reduce mount time),
>>           enabled by mkfs feature *block-group-tree*.
>> diff --git a/Documentation/mkfs.btrfs.rst b/Documentation/mkfs.btrfs.rst
>> index e80f4c5c83ee..fe52f4406bf2 100644
>> --- a/Documentation/mkfs.btrfs.rst
>> +++ b/Documentation/mkfs.btrfs.rst
>> @@ -283,6 +283,11 @@ free-space-tree
>>           Enable the free space tree (mount option *space_cache=v2*) 
>> for persisting the
>>           free space cache.
>> +block-group-tree
>> +        (kernel support since 6.1)
>> +
>> +        Enable the block group tree to greatly reduce mount time for 
>> large filesystems.
>> +
>>   BLOCK GROUPS, CHUNKS, RAID
>>   --------------------------
>> diff --git a/common/fsfeatures.c b/common/fsfeatures.c
>> index 4aca96f6e4fe..50500c652265 100644
>> --- a/common/fsfeatures.c
>> +++ b/common/fsfeatures.c
>> @@ -171,7 +171,6 @@ static const struct btrfs_feature mkfs_features[] = {
>>           .desc        = "support zoned devices"
>>       },
>>   #endif
>> -#if EXPERIMENTAL
>>       {
>>           .name        = "block-group-tree",
>>           .compat_ro_flag    = BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE,
>> @@ -181,6 +180,7 @@ static const struct btrfs_feature mkfs_features[] = {
>>           VERSION_NULL(default),
>>           .desc        = "block group tree to reduce mount time"
>>       },
>> +#if EXPERIMENTAL
>>       {
>>           .name        = "extent-tree-v2",
>>           .incompat_flag    = BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2,
>> @@ -222,7 +222,6 @@ static const struct btrfs_feature 
>> runtime_features[] = {
>>           VERSION_TO_STRING2(default, 5,15),
>>           .desc        = "free space tree (space_cache=v2)"
>>       },
>> -#if EXPERIMENTAL
>>       {
>>           .name        = "block-group-tree",
>>           .compat_ro_flag    = BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE,
>> @@ -232,7 +231,6 @@ static const struct btrfs_feature 
>> runtime_features[] = {
>>           VERSION_NULL(default),
>>           .desc        = "block group tree to reduce mount time"
>>       },
>> -#endif
>>       /* Keep this one last */
>>       {
>>           .name        = "list-all",
>> diff --git a/tune/main.c b/tune/main.c
>> index c5d2e37aef3d..f5a94cdbdb5f 100644
>> --- a/tune/main.c
>> +++ b/tune/main.c
>> @@ -70,6 +70,7 @@ static const char * const tune_usage[] = {
>>       OPTLINE("-x", "enable skinny metadata extent refs (mkfs: 
>> skinny-metadata)"),
>>       OPTLINE("-n", "enable no-holes feature (mkfs: no-holes, more 
>> efficient sparse file representation)"),
>>       OPTLINE("-S <0|1>", "set/unset seeding status of a device"),
>> +    OPTLINE("--enable-block-group-tree", "enable block group tree 
>> (mkfs: block-group-tree, for less mount time)"),
>>       "",
>>       "UUID changes:",
>>       OPTLINE("-u", "rewrite fsid, use a random one"),
>> @@ -84,7 +85,6 @@ static const char * const tune_usage[] = {
>>       "",
>>       "EXPERIMENTAL FEATURES:",
>>       OPTLINE("--csum CSUM", "switch checksum for data and metadata to 
>> CSUM"),
>> -    OPTLINE("-b", "enable block group tree (mkfs: block-group-tree, 
>> for less mount time)"),
>>   #endif
>>       NULL
>>   };
>> @@ -113,27 +113,22 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>>       btrfs_config_init();
>>       while(1) {
>> -        enum { GETOPT_VAL_CSUM = GETOPT_VAL_FIRST };
>> +        enum { GETOPT_VAL_CSUM = GETOPT_VAL_FIRST,
>> +               GETOPT_VAL_ENABLE_BLOCK_GROUP_TREE };
>>           static const struct option long_options[] = {
>>               { "help", no_argument, NULL, GETOPT_VAL_HELP},
>> +            { "enable-block-group-tree", no_argument, NULL,
>> +                GETOPT_VAL_ENABLE_BLOCK_GROUP_TREE},
>>   #if EXPERIMENTAL
>>               { "csum", required_argument, NULL, GETOPT_VAL_CSUM },
>>   #endif
>>               { NULL, 0, NULL, 0 }
>>           };
>> -#if EXPERIMENTAL
>> -        int c = getopt_long(argc, argv, "S:rxfuU:nmM:b", 
>> long_options, NULL);
>> -#else
>>           int c = getopt_long(argc, argv, "S:rxfuU:nmM:", 
>> long_options, NULL);
>> -#endif
>>           if (c < 0)
>>               break;
>>           switch(c) {
>> -        case 'b':
>> -            btrfs_warn_experimental("Feature: conversion to 
>> block-group-tree");
>> -            to_bg_tree = true;
>> -            break;
>>           case 'S':
>>               seeding_flag = 1;
>>               seeding_value = arg_strtou64(optarg);
>> @@ -167,6 +162,9 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>>               ctree_flags |= OPEN_CTREE_IGNORE_FSID_MISMATCH;
>>               change_metadata_uuid = 1;
>>               break;
>> +        case GETOPT_VAL_ENABLE_BLOCK_GROUP_TREE:
>> +            to_bg_tree = true;
>> +            break;
>>   #if EXPERIMENTAL
>>           case GETOPT_VAL_CSUM:
>>               btrfs_warn_experimental(
> 
