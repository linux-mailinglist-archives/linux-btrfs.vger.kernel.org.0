Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879DA6DE95D
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Apr 2023 04:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjDLCQB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Apr 2023 22:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDLCQA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Apr 2023 22:16:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57BCC0
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Apr 2023 19:15:58 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MiacR-1qFxg13L9j-00fmnQ; Wed, 12
 Apr 2023 04:15:51 +0200
Message-ID: <c89e07c4-146e-db7c-ac0b-ea3b0bf610f7@gmx.com>
Date:   Wed, 12 Apr 2023 10:15:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] btrfs-progs: mkfs: make -R|--runtime-features option
 deprecated
Content-Language: en-US
To:     Neal Gompa <neal@gompa.dev>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1681180159.git.wqu@suse.com>
 <1ca85433fb63d9c9cf66da72e407381c0146b76c.1681180159.git.wqu@suse.com>
 <CAEg-Je_V7TNj1U5_7ODu4GuAEgUqy_3V_2ipdHu=hh8FsRvs9A@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAEg-Je_V7TNj1U5_7ODu4GuAEgUqy_3V_2ipdHu=hh8FsRvs9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6rDTduGBwb/8MvEi3YrXCnetHU1Sfm7PonXC/twTbBm4Lpy1eqR
 WxxGArak3F7e7TuTr//zop1JMvyPIunHMzH8t0u4MpIZNnVoHThbc8vMFMaH4zzMig9MRME
 O5Y3gczvWz3LJPEqjw4QjePJd4+tN1XCf5KTRlOiFO9CPHRWzBLVqox3z73E8uB0fvfUSeQ
 SXBACAvl1dVAxDMw2j9wQ==
UI-OutboundReport: notjunk:1;M01:P0:0d+W0qUG9Kk=;nD4HPf5gfXGPMRnfOeGRzIz4tLN
 uM+/xFAq4vB+/5nYzK83dr3T+b/piUGLvxZ8HVz0JujRX2YBzCNkH9mOlddytzjiFhhKXzfFd
 mc+Ub0yk54SbKLLXt33xUcE7V9LgMruGNUHnO5FWo7l0t4p6ff9qS/C3iTzeAmvaHtSjrTmfC
 M0gRZyGr1W8QR8uLuF4N+H7py8yPOms/WwjlwlgBH1pZDCZgXbzAoXYJEU4gwvYSzGNqk26W9
 CY0yZklKassZN+GJBubJK9czcPYMuCrd8Q//ePBkdiXzjm9SGw95oFauulJamJB4b77WCiu3X
 BDcohZ3vEUtoqbLbjhiZLhS/HVKjfbgkw7BoL8A44o2vO5qXbwYNcR4VXd+4CyQ9hPBGemRcs
 Rukwy8ehovid3lj538AArMdb77zkiDYaPYu6KyU3mZOZXc23/+tYePZpGjfLsILWPHZfzJVB0
 xsTAZeIQKtveftrHOzysctsWU3N6w/CxlzARRZFSlSb+CDdR+Vkts9nR5FdiivNYHfUB9VknR
 RBy/nJfQHRkLeNAuvhG8g4K0rUtNZrrMIlo6iuNsaIVlHfL0HY0d5NcXPMxEzYehUMEP+vFJ6
 96laO0MdaCJReDFLMQ9jwtzq43eoAkxbPtP5RMe9RGCciftWpOAbcvTmIUTZgNFKbCh0+EkqC
 UHU9NoeZj18SIAu6k0zT0y9dhwBDYPSG1FekiE/Wa3+wA2jYCpxvfHPqOtyrFIkV5aGXguwEw
 WuIG4qB+AcU68LJK7adH2rGJ28y77+alR0YKer/+gaKgtaC6JTjYUu4VsOyUCxLTbQ7SJ2db4
 J+UIYp8iVNLMUKkOfQci2gi5vyoUs629Pzm+z43YcwSt8rm5lGYI5RgZU0p92Yvzy4N0mRf03
 R6SbhctnrU4s5THdeCnT/cjxG4GT7dipJ7R7Ynn7Ejbr5IlXyt6VA3phq9G2qe6bypYdRT5gE
 LA5OzHApspUM6QG5G1vcSF5CfDQ=
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/12 09:51, Neal Gompa wrote:
> On Mon, Apr 10, 2023 at 10:42 PM Qu Wenruo <wqu@suse.com> wrote:
>>
>> The option -R|--runtime-features is introduced to support features that
>> doesn't result a full incompat flag change, thus things like
>> free-space-tree and quota features are put here.
>>
>> But to end users, such separation of features is not helpful and can be
>> sometimes confusing.
>>
>> Thus we're already migrating those runtime features into -O|--features
>> option under experimental builds.
>>
>> I believe this is the proper time to move those runtime features into
>> -O|--features option, and mark the -R|--runtime-features option
>> deprecated.
>>
>> For now we still keep the old option as for compatibility purposes.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   Documentation/mkfs.btrfs.rst | 25 ++++---------------------
>>   common/fsfeatures.c          |  6 ------
>>   mkfs/main.c                  |  3 ++-
>>   3 files changed, 6 insertions(+), 28 deletions(-)
>>
>> diff --git a/Documentation/mkfs.btrfs.rst b/Documentation/mkfs.btrfs.rst
>> index ba7227b31f72..e80f4c5c83ee 100644
>> --- a/Documentation/mkfs.btrfs.rst
>> +++ b/Documentation/mkfs.btrfs.rst
>> @@ -161,18 +161,6 @@ OPTIONS
>>
>>                   $ mkfs.btrfs -O list-all
>>
>> --R|--runtime-features <feature1>[,<feature2>...]
>> -        A list of features that be can enabled at mkfs time, otherwise would have
>> -        to be turned on on a mounted filesystem.
>> -        To disable a feature, prefix it with *^*.
>> -
>> -        See section *RUNTIME FEATURES* for more details.  To see all available
>> -        runtime features that **mkfs.btrfs** supports run:
>> -
>> -        .. code-block:: bash
>> -
>> -                $ mkfs.btrfs -R list-all
>> -
>>   -f|--force
>>           Forcibly overwrite the block devices when an existing filesystem is detected.
>>           By default, **mkfs.btrfs** will utilize *libblkid* to check for any known
>> @@ -199,6 +187,10 @@ OPTIONS
>>   -l|--leafsize <size>
>>           Removed in 6.0, used to be alias for *--nodesize*.
>>
>> +-R|--runtime-features <feature1>[,<feature2>...]
>> +        Removed in 6.4, used to specify features not affecting on-disk format.
>> +        Now all such features are merged into `-O|--features` option.
>> +
>>   SIZE UNITS
>>   ----------
>>
>> @@ -279,15 +271,6 @@ zoned
>>           see *ZONED MODE* in :doc:`btrfs(5)<btrfs-man5>`, the mode is automatically selected when
>>           a zoned device is detected
>>
>> -
>> -RUNTIME FEATURES
>> -----------------
>> -
>> -Features that are typically enabled on a mounted filesystem, e.g. by a mount
>> -option or by an ioctl. Some of them can be enabled early, at mkfs time.  This
>> -applies to features that need to be enabled once and then the status is
>> -permanent, this does not replace mount options.
>> -
>>   quota
>>           (kernel support since 3.4)
>>
>> diff --git a/common/fsfeatures.c b/common/fsfeatures.c
>> index 169e47e92582..4aca96f6e4fe 100644
>> --- a/common/fsfeatures.c
>> +++ b/common/fsfeatures.c
>> @@ -99,7 +99,6 @@ static const struct btrfs_feature mkfs_features[] = {
>>                  VERSION_NULL(default),
>>                  .desc           = "mixed data and metadata block groups"
>>          },
>> -#if EXPERIMENTAL
>>          {
>>                  .name           = "quota",
>>                  .runtime_flag   = BTRFS_FEATURE_RUNTIME_QUOTA,
>> @@ -109,7 +108,6 @@ static const struct btrfs_feature mkfs_features[] = {
>>                  VERSION_NULL(default),
>>                  .desc           = "quota support (qgroups)"
>>          },
>> -#endif
>>          {
>>                  .name           = "extref",
>>                  .incompat_flag  = BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF,
>> @@ -143,7 +141,6 @@ static const struct btrfs_feature mkfs_features[] = {
>>                  VERSION_TO_STRING2(default, 5,15),
>>                  .desc           = "no explicit hole extents for files"
>>          },
>> -#if EXPERIMENTAL
>>          {
>>                  .name           = "free-space-tree",
>>                  .compat_ro_flag = BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |
>> @@ -154,7 +151,6 @@ static const struct btrfs_feature mkfs_features[] = {
>>                  VERSION_TO_STRING2(default, 5,15),
>>                  .desc           = "free space tree (space_cache=v2)"
>>          },
>> -#endif
>>          {
>>                  .name           = "raid1c34",
>>                  .incompat_flag  = BTRFS_FEATURE_INCOMPAT_RAID1C34,
>> @@ -185,8 +181,6 @@ static const struct btrfs_feature mkfs_features[] = {
>>                  VERSION_NULL(default),
>>                  .desc           = "block group tree to reduce mount time"
>>          },
>> -#endif
>> -#if EXPERIMENTAL
>>          {
>>                  .name           = "extent-tree-v2",
>>                  .incompat_flag  = BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2,
> 
> Shouldn't the removal of the EXPERIMENTAL tags be a separate commit?
> It seems unrelated and the commit message doesn't say anything about
> this.

Nope, this is just how the diff tool determine where the changes are.

The end result of that patch still keeps the extent-tree-v2 feature 
under experimental, it's covered by the same EXPERIMENTAL ifdef of 
block-group-tree.

Thus sometimes it's better to use difftool to review patches, as we can 
hit cases like this from time to time.

Thanks,
Qu
> 
>> diff --git a/mkfs/main.c b/mkfs/main.c
>> index f5e34cbda612..78cc2b598b25 100644
>> --- a/mkfs/main.c
>> +++ b/mkfs/main.c
>> @@ -424,7 +424,6 @@ static const char * const mkfs_usage[] = {
>>          OPTLINE("-n|--nodesize SIZE", "size of btree nodes"),
>>          OPTLINE("-s|--sectorsize SIZE", "data block size (may not be mountable by current kernel)"),
>>          OPTLINE("-O|--features LIST", "comma separated list of filesystem features (use '-O list-all' to list features)"),
>> -       OPTLINE("-R|--runtime-features LIST", "comma separated list of runtime features (use '-R list-all' to list runtime features)"),
>>          OPTLINE("-L|--label LABEL", "set the filesystem label"),
>>          OPTLINE("-U|--uuid UUID", "specify the filesystem UUID (must be unique)"),
>>          "Creation:",
>> @@ -440,6 +439,7 @@ static const char * const mkfs_usage[] = {
>>          OPTLINE("--help", "print this help and exit"),
>>          "Deprecated:",
>>          OPTLINE("-l|--leafsize SIZE", "removed in 6.0, use --nodesize"),
>> +       OPTLINE("-R|--runtime-features LIST", "removed in 6.4, use -O|--features"),
>>          NULL
>>   };
>>
>> @@ -1140,6 +1140,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>>                                  char *orig = strdup(optarg);
>>                                  char *tmp = orig;
>>
>> +                               warning("runtime features are deprecated, use -O|--features instead.");
>>                                  tmp = btrfs_parse_runtime_features(tmp,
>>                                                  &features);
>>                                  if (tmp) {
>> --
>> 2.39.2
>>
> 
> 
