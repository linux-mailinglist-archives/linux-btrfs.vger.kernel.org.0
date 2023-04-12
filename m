Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614CE6DE959
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Apr 2023 04:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjDLCM6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Apr 2023 22:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDLCM5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Apr 2023 22:12:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E817E35B5
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Apr 2023 19:12:55 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1McH5Q-1qMrih4C68-00cixk; Wed, 12
 Apr 2023 04:12:44 +0200
Message-ID: <14112e53-926d-b021-82c6-fae9f2dbb3f2@gmx.com>
Date:   Wed, 12 Apr 2023 10:12:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] btrfs-progs: move block-group-tree out of
 experimental features
Content-Language: en-US
To:     Neal Gompa <neal@gompa.dev>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1681180159.git.wqu@suse.com>
 <4cc5819796bd2af6de78b7a1919b4f8ed02b985f.1681180159.git.wqu@suse.com>
 <CAEg-Je9T4MHtshrfpiTuEHZmbwaRWtJP9RUF_CKyQQOwQftxuA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAEg-Je9T4MHtshrfpiTuEHZmbwaRWtJP9RUF_CKyQQOwQftxuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:T2yYfx4btNjYmNCYHLj5ylCcWkOvg3nUq+PMRjKXzBa0DURq/Nd
 I/x5n7b6GUcRvgJn1SqgmoTWXtVEoTp289eVsu793epwTr7nwlsGe89ICdYPeC34Pbr/Mns
 ncT7N1Wid1w8Nxy5BXsC7Tm8PQNWo5GtzGxXqNoKDWqUl9ff3XO+/mNeWdNpaBhvc3jhiBZ
 nPLrXQQXrp+BF4xbUGCvA==
UI-OutboundReport: notjunk:1;M01:P0:wVpK39PIxl4=;bvBNigb3GEnz9KkLxJ8IKnbER3F
 LfPJ6+isqZolvyb/Z3Z7WBRCUQ3cacZGhejiW+MKzKL8F2t26xp62Vw5f5Q8KZGXjSwZ0fhYP
 EMu4fD4x6Knrb2CyD/jb1y3nyVPusmv6NY1LC7S6U6T/dm64Ss7T0UpynTrGwmNSu7ykQqMYD
 RR2oOukXe0HT04fKAYn2CIayEg0yqpctk8I8qRjS6idzVOUUmVyzg4pbTLg0+DML8wGVEy1pw
 dKyTIJiZeZyzxV+Qn0dsHagXqndWesMYEbVpX6TdnTG/qj+JniO35e6pgNHZxuxUwph2auNNv
 DnwilIa7AeSLqGYWKnwi2Hu1OYDY/768MHxsqki9HTyRY+oemAwhoCbomroJ2MhUE+ObmzvFu
 kDd9/T4CMg6WVXDNJng21PCMpbVSEXwZVLTbRig0FpIay+b8SN/EvCeeCvyKTvLqBNisjz9qE
 nXr4OFvAGUkVONjuDqJSDsPEB5He3p5+ZWzWTn7PackeDZEHABZfNGzS3ofnSa6VBGsoY33VB
 FyT5z0SA3FWBrxBYMxcn3aeEb4Ya1sGGLE2JkVXP7lt0gDHvJdiUf15uTr8oyfnNlq2ak2Rio
 9ovEAfwlgFTequJ5debcv8E8gSiLu2gLrxngtzZbnsReWPF5tMGaZOtAXsLjy8XNs9wm/vCmX
 jYr0CN94AmDiG3vvv1imN5xBX/NVnSd1y6imhw9Jr5jBGKw1kgU4a9FRPceEIkGRSI2D7eo2S
 LgePfzlFSqr0axw0z3snDnZF4+kC0PDuJX/9lw3rjsH/EKG2bEV42Gc4T8HKjSKqtlzl2iLe2
 mxJ4n9/Mml5xkMVP5+HGHRlqQTR1y0ikICh07O/dN5FNs39SWD0su7mbdA2v1TiCJWxX2cSSg
 syiUfukbsddoZHZDP+y5bB/QEk0j6ExIqdLaLBAYa6P8gZXCqFHLo7u6No7OUdO54ui4uhfyE
 /CcNJzaBQekGfL1kIR7HW+KXiwQ=
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/12 09:49, Neal Gompa wrote:
> On Mon, Apr 10, 2023 at 10:37 PM Qu Wenruo <wqu@suse.com> wrote:
>>
>> The feedback from the community on block group tree is very positive,
>> the only complain is, end users need to recompile btrfs-progs with
>> experimental features to enjoy the new feature.
>>
>> So let's move it out of experimental features and let more people enjoy
>> faster mount speed.
>>
>> Also change the option of btrfstune, from `-b` to
>> `--enable-block-group-tree` to avoid short option.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   Documentation/btrfs-man5.rst |  6 ++++++
>>   Documentation/btrfstune.rst  |  4 ++--
>>   Documentation/mkfs.btrfs.rst |  5 +++++
>>   common/fsfeatures.c          |  4 +---
>>   tune/main.c                  | 18 ++++++++----------
>>   5 files changed, 22 insertions(+), 15 deletions(-)
>>
>> diff --git a/Documentation/btrfs-man5.rst b/Documentation/btrfs-man5.rst
>> index b50064fe9931..c625a9585457 100644
>> --- a/Documentation/btrfs-man5.rst
>> +++ b/Documentation/btrfs-man5.rst
>> @@ -66,6 +66,12 @@ big_metadata
>>           the filesystem uses *nodesize* for metadata blocks, this can be bigger than the
>>           page size
>>
>> +block_group_tree
>> +        (since: 6.1)
>> +
>> +        block group item representation using a dedicated b-tree, this can greatly
>> +        reduce mount time for large filesystems.
>> +
>>   compress_lzo
>>           (since: 2.6.38)
>>
>> diff --git a/Documentation/btrfstune.rst b/Documentation/btrfstune.rst
>> index f4400f1f527a..c84c1e7e7092 100644
>> --- a/Documentation/btrfstune.rst
>> +++ b/Documentation/btrfstune.rst
>> @@ -24,8 +24,8 @@ means.  Please refer to the *FILESYSTEM FEATURES* in :doc:`btrfs(5)<btrfs-man5>`
>>   OPTIONS
>>   -------
>>
>> --b
>> -        (since kernel 6.1, needs experimental build of btrfs-progs)
>> +--enable-block-group-tree
>> +        (since kernel 6.1)
>>           Enable block group tree feature (greatly reduce mount time),
>>           enabled by mkfs feature *block-group-tree*.
>>
> 
> I think it would make more sense to declare version 6.3 as the version
> here, since it would effectively be the first version where it's not
> experimental anymore.

Here we're talking about kernel support, which is indeed 6.1.

For progs, it's much simpler, if it's not documented in man page, then 
it's not supported, thus we don't really bother mentioning the prog version.

Thanks,
Qu
> 
>> diff --git a/Documentation/mkfs.btrfs.rst b/Documentation/mkfs.btrfs.rst
>> index e80f4c5c83ee..fe52f4406bf2 100644
>> --- a/Documentation/mkfs.btrfs.rst
>> +++ b/Documentation/mkfs.btrfs.rst
>> @@ -283,6 +283,11 @@ free-space-tree
>>           Enable the free space tree (mount option *space_cache=v2*) for persisting the
>>           free space cache.
>>
>> +block-group-tree
>> +        (kernel support since 6.1)
>> +
>> +        Enable the block group tree to greatly reduce mount time for large filesystems.
>> +
> 
> Ditto.
> 
>>   BLOCK GROUPS, CHUNKS, RAID
>>   --------------------------
>>
>> diff --git a/common/fsfeatures.c b/common/fsfeatures.c
>> index 4aca96f6e4fe..50500c652265 100644
>> --- a/common/fsfeatures.c
>> +++ b/common/fsfeatures.c
>> @@ -171,7 +171,6 @@ static const struct btrfs_feature mkfs_features[] = {
>>                  .desc           = "support zoned devices"
>>          },
>>   #endif
>> -#if EXPERIMENTAL
>>          {
>>                  .name           = "block-group-tree",
>>                  .compat_ro_flag = BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE,
>> @@ -181,6 +180,7 @@ static const struct btrfs_feature mkfs_features[] = {
>>                  VERSION_NULL(default),
>>                  .desc           = "block group tree to reduce mount time"
>>          },
>> +#if EXPERIMENTAL
>>          {
>>                  .name           = "extent-tree-v2",
>>                  .incompat_flag  = BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2,
>> @@ -222,7 +222,6 @@ static const struct btrfs_feature runtime_features[] = {
>>                  VERSION_TO_STRING2(default, 5,15),
>>                  .desc           = "free space tree (space_cache=v2)"
>>          },
>> -#if EXPERIMENTAL
>>          {
>>                  .name           = "block-group-tree",
>>                  .compat_ro_flag = BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE,
>> @@ -232,7 +231,6 @@ static const struct btrfs_feature runtime_features[] = {
>>                  VERSION_NULL(default),
>>                  .desc           = "block group tree to reduce mount time"
>>          },
>> -#endif
>>          /* Keep this one last */
>>          {
>>                  .name           = "list-all",
>> diff --git a/tune/main.c b/tune/main.c
>> index c5d2e37aef3d..f5a94cdbdb5f 100644
>> --- a/tune/main.c
>> +++ b/tune/main.c
>> @@ -70,6 +70,7 @@ static const char * const tune_usage[] = {
>>          OPTLINE("-x", "enable skinny metadata extent refs (mkfs: skinny-metadata)"),
>>          OPTLINE("-n", "enable no-holes feature (mkfs: no-holes, more efficient sparse file representation)"),
>>          OPTLINE("-S <0|1>", "set/unset seeding status of a device"),
>> +       OPTLINE("--enable-block-group-tree", "enable block group tree (mkfs: block-group-tree, for less mount time)"),
>>          "",
>>          "UUID changes:",
>>          OPTLINE("-u", "rewrite fsid, use a random one"),
>> @@ -84,7 +85,6 @@ static const char * const tune_usage[] = {
>>          "",
>>          "EXPERIMENTAL FEATURES:",
>>          OPTLINE("--csum CSUM", "switch checksum for data and metadata to CSUM"),
>> -       OPTLINE("-b", "enable block group tree (mkfs: block-group-tree, for less mount time)"),
>>   #endif
>>          NULL
>>   };
>> @@ -113,27 +113,22 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>>          btrfs_config_init();
>>
>>          while(1) {
>> -               enum { GETOPT_VAL_CSUM = GETOPT_VAL_FIRST };
>> +               enum { GETOPT_VAL_CSUM = GETOPT_VAL_FIRST,
>> +                      GETOPT_VAL_ENABLE_BLOCK_GROUP_TREE };
>>                  static const struct option long_options[] = {
>>                          { "help", no_argument, NULL, GETOPT_VAL_HELP},
>> +                       { "enable-block-group-tree", no_argument, NULL,
>> +                               GETOPT_VAL_ENABLE_BLOCK_GROUP_TREE},
>>   #if EXPERIMENTAL
>>                          { "csum", required_argument, NULL, GETOPT_VAL_CSUM },
>>   #endif
>>                          { NULL, 0, NULL, 0 }
>>                  };
>> -#if EXPERIMENTAL
>> -               int c = getopt_long(argc, argv, "S:rxfuU:nmM:b", long_options, NULL);
>> -#else
>>                  int c = getopt_long(argc, argv, "S:rxfuU:nmM:", long_options, NULL);
>> -#endif
>>
>>                  if (c < 0)
>>                          break;
>>                  switch(c) {
>> -               case 'b':
>> -                       btrfs_warn_experimental("Feature: conversion to block-group-tree");
>> -                       to_bg_tree = true;
>> -                       break;
>>                  case 'S':
>>                          seeding_flag = 1;
>>                          seeding_value = arg_strtou64(optarg);
>> @@ -167,6 +162,9 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>>                          ctree_flags |= OPEN_CTREE_IGNORE_FSID_MISMATCH;
>>                          change_metadata_uuid = 1;
>>                          break;
>> +               case GETOPT_VAL_ENABLE_BLOCK_GROUP_TREE:
>> +                       to_bg_tree = true;
>> +                       break;
>>   #if EXPERIMENTAL
>>                  case GETOPT_VAL_CSUM:
>>                          btrfs_warn_experimental(
>> --
>> 2.39.2
>>
> 
> 
