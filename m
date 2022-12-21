Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90E165309C
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Dec 2022 13:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiLUMNE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Dec 2022 07:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiLUMND (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Dec 2022 07:13:03 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0672628
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Dec 2022 04:13:01 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1ML9yc-1pOwqo48cE-00IDzs; Wed, 21
 Dec 2022 13:12:49 +0100
Message-ID: <c74ac3f3-7fab-31ef-f122-fc36e2ddcbbd@gmx.com>
Date:   Wed, 21 Dec 2022 20:12:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] btrfs: fix compat_ro checks against remount
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Chung-Chiang Cheng <shepjeng@gmail.com>,
        Anand Jain <anand.jain@oracle.com>
References: <82e9c6f8afe4a58e3df60cf601530e14d42264a6.1671613891.git.wqu@suse.com>
 <CAL3q7H6Kg90MA_m1M60kTFd7GUZCx8qfr8kRiPh+66VgQAGuSA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAL3q7H6Kg90MA_m1M60kTFd7GUZCx8qfr8kRiPh+66VgQAGuSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:PONGiX+oge9czVXjiQx0ayHfw7U+3qG99xtDhlb2d8J5iXagL+X
 zyD5NcO2r7IFD0awKglV0LzJfSVBS925Mlzx2bVGohh/ORmlTg8D3S+55ggwhbquOOsFvYT
 D8EwJtVT5WlhMoWLl0TWZvaH1VTq6oc1idoVGbygWGiKA6iuhehafeAZbf3hPf6tlQSNa54
 ZM736IUDuQVyluYLZEgGw==
UI-OutboundReport: notjunk:1;M01:P0:Q7lrMK9OwuA=;EgEUlcf0M0HkI0VBCT7SSNVhFY7
 iFW9QRFCAWzUP06VPIOX/spaX+c5hgxTVFpaRdt50txOXqCJaUdMZ3Qa9g+2UZqBPSOh3pln7
 Jxt/oP9lkQvW8jk5o0mBICM5gvYLzCIYcKGOChd4UmBWyyQz6fPD/jGnl3PAMWnS//FLBJfgA
 waiSDgYe5fOnH0RdFElaUHY5BSg9uWdrn6mTtNIERnly/sUuL9zAYN6yrJfmyb/Y2ARcAvdeb
 7pTeIfpa/UVJErMWlN/yvBsJNK+icWGI6uCStpxslmz4t98XC4tR+yqrpFNhvDH1Y6USI4Rar
 bY119RgMzeH8sXN2bFksUNK+6BtCByRH7bfAVWHosBmVui9EcHCJD9YXNmZXkNY4YcvGFLn+S
 iuGL0ptXoubpbKMB23GZzlzQy8spQ+3fYGzjWiFQJiEgzzc9DLbEPvWZaej8zLiwUTnfmx0Yj
 K7wQEutznIzF+YbZZS8D5SAkyVe5oXmi7zeYLhvbL4PbF9uMBuDf31Gi8RLJ6HLc2nTPlbqLu
 L4uTw91WWrfN2Wr3JzcZ0KNa8QHRciGWJ50OjEcMXkJgjbrZd4OGDdaHtYrxLOHGkax8iwdjz
 j87ERHYCjBPSVPr/M3u2Cw2spGovBVSDMg2vR3idS11U3QvdPMr7bqCWRwGSkBe1DN5c8p1lu
 k2lB5Wri/MVzWi5Kky6uus8CizyM0qyV1AjF8F45CtqNE0k0PgWnkhsN9vBB7oiXv7PyLn8tX
 dj7T4QpOBoYazwe0PLFhNeIlhcj5JthWcCvxkjGNFr/jmsgtqvmNjTB9NaVeock/OvedRYn8K
 5hwMw3qqg72pbIUseeDQRyaPL+GOSvuns9VgcGezBWRNJC7RVFvFeDJShhb0KsUWj17G7vveV
 w+ydGEU4p/QJZ0/jZrVqZhqBuzeVlr/p9LvRE7SuWaFGGzt6kTbmQNfZD4wN2ft+Xk085GC1t
 7H4Rh1hXS8UpeYf2Bx7nd7W94H8=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/21 19:57, Filipe Manana wrote:
> On Wed, Dec 21, 2022 at 9:26 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> Even with commit 81d5d61454c3 ("btrfs: enhance unsupported compat RO
>> flags handling"), btrfs can still mount a fs with unsupported compat_ro
>> flags read-only, then remount it RW:
>>
>>    # btrfs ins dump-super /dev/loop0 | grep compat_ro_flags -A 3
>>    compat_ro_flags               0x403
>>                          ( FREE_SPACE_TREE |
>>                            FREE_SPACE_TREE_VALID |
>>                            unknown flag: 0x400 )
>>
>>    # mount /dev/loop0 /mnt/btrfs
>>    mount: /mnt/btrfs: wrong fs type, bad option, bad superblock on /dev/loop0, missing codepage or helper program, or other error.
>>           dmesg(1) may have more information after failed mount system call.
>>    ^^^ RW mount failed as expected ^^^
>>
>>    # dmesg -t | tail -n5
>>    loop0: detected capacity change from 0 to 1048576
>>    BTRFS: device fsid cb5b82f5-0fdd-4d81-9b4b-78533c324afa devid 1 transid 7 /dev/loop0 scanned by mount (1146)
>>    BTRFS info (device loop0): using crc32c (crc32c-intel) checksum algorithm
>>    BTRFS info (device loop0): using free space tree
>>    BTRFS error (device loop0): cannot mount read-write because of unknown compat_ro features (0x403)
>>    BTRFS error (device loop0): open_ctree failed
>>
>>    # mount /dev/loop0 -o ro /mnt/btrfs
>>    # mount -o remount,rw /mnt/btrfs
>>    ^^^ RW remount succeeded unexpectedly ^^^
>>
>> [CAUSE]
>> Currently we use btrfs_check_features() to check compat_ro flags against
>> our current moount flags.
>>
>> That function get reused between open_ctree() and btrfs_remount().
>>
>> But for btrfs_remount(), the super block we passed in still has the old
>> mount flags, thus btrfs_check_features() still believes we're mounting
>> read-only.
>>
>> [FIX]
>> Introduce a new argument, *new_flags, to indicate the new mount flags.
>> That argument can be NULL for the open_ctree() call site.
>>
>> With that new argument, call site at btrfs_remount() can properly pass
>> the new super flags, and we can reject the RW remount correctly.
>>
>> Reported-by: Chung-Chiang Cheng <shepjeng@gmail.com>
>> Fixes: 81d5d61454c3 ("btrfs: enhance unsupported compat RO flags handling")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> Reviewed-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> Changelog:
>> v2:
>> - Add a comment on why @rw_mount is calculated this way
>>    This will cover RW->RW and RW->RO remount cases, but since the
>>    fs is already RW, we should not has any unsupported compat_ro flags
>>    anyway.
>> ---
>>   fs/btrfs/disk-io.c | 16 +++++++++++++---
>>   fs/btrfs/disk-io.h |  3 ++-
>>   fs/btrfs/super.c   |  2 +-
>>   3 files changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 0888d484df80..973c2e41e132 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -3391,12 +3391,22 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
>>    * (space cache related) can modify on-disk format like free space tree and
>>    * screw up certain feature dependencies.
>>    */
>> -int btrfs_check_features(struct btrfs_fs_info *fs_info, struct super_block *sb)
>> +int btrfs_check_features(struct btrfs_fs_info *fs_info, struct super_block *sb,
>> +                        int *new_flags)
> 
> Can we please pass new_flags by value instead?
> It does not make any sense to pass by pointer - we don't want to
> change its value...
> 
>>   {
>>          struct btrfs_super_block *disk_super = fs_info->super_copy;
>>          u64 incompat = btrfs_super_incompat_flags(disk_super);
>>          const u64 compat_ro = btrfs_super_compat_ro_flags(disk_super);
>>          const u64 compat_ro_unsupp = (compat_ro & ~BTRFS_FEATURE_COMPAT_RO_SUPP);
>> +       /*
>> +        * For RW mount or remount to RW, we shouldn't allow any unsupported
>> +        * compat_ro flags. Here we just check if any of our sb or new flag
>> +        * is RW.
>> +        * This will cover cases like RW->RW and RW->RO, but since it's
>> +        * already RW, we shouldn't have any unsupported compat_ro flags anyway.
>> +        */
>> +       bool rw_mount = (!sb_rdonly(sb) ||
>> +                        (new_flags && !(*new_flags & SB_RDONLY)));
> 
> It also would make this expression shorter and easier to read...
> 
>>
>>          if (incompat & ~BTRFS_FEATURE_INCOMPAT_SUPP) {
>>                  btrfs_err(fs_info,
>> @@ -3430,7 +3440,7 @@ int btrfs_check_features(struct btrfs_fs_info *fs_info, struct super_block *sb)
>>          if (btrfs_super_nodesize(disk_super) > PAGE_SIZE)
>>                  incompat |= BTRFS_FEATURE_INCOMPAT_BIG_METADATA;
>>
>> -       if (compat_ro_unsupp && !sb_rdonly(sb)) {
>> +       if (compat_ro_unsupp && rw_mount) {
>>                  btrfs_err(fs_info,
>>          "cannot mount read-write because of unknown compat_ro features (0x%llx)",
>>                         compat_ro);
>> @@ -3633,7 +3643,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>>                  goto fail_alloc;
>>          }
>>
>> -       ret = btrfs_check_features(fs_info, sb);
>> +       ret = btrfs_check_features(fs_info, sb, NULL);
> 
> Here just pass 0 for flags.

Initially I avoided this because I'm not sure if it's bit flags.
But it turned out that super_block->s_flags is indeed bit flags.

So in that case, 0 is completely fine, and I believe we can also go 
s_flags directly instead of passing sb.
This would also solve the type mismatch problem mentioned by David.

I'll update it in the next version.

Thanks,
Qu
> 
>>          if (ret < 0) {
>>                  err = ret;
>>                  goto fail_alloc;
>> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
>> index 363935cfc084..e83453c7c429 100644
>> --- a/fs/btrfs/disk-io.h
>> +++ b/fs/btrfs/disk-io.h
>> @@ -50,7 +50,8 @@ int __cold open_ctree(struct super_block *sb,
>>   void __cold close_ctree(struct btrfs_fs_info *fs_info);
>>   int btrfs_validate_super(struct btrfs_fs_info *fs_info,
>>                           struct btrfs_super_block *sb, int mirror_num);
>> -int btrfs_check_features(struct btrfs_fs_info *fs_info, struct super_block *sb);
>> +int btrfs_check_features(struct btrfs_fs_info *fs_info, struct super_block *sb,
>> +                        int *new_flags);
>>   int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors);
>>   struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev);
>>   struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>> index d5de18d6517e..bc2094aa9a40 100644
>> --- a/fs/btrfs/super.c
>> +++ b/fs/btrfs/super.c
>> @@ -1705,7 +1705,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
>>          if (ret)
>>                  goto restore;
>>
>> -       ret = btrfs_check_features(fs_info, sb);
>> +       ret = btrfs_check_features(fs_info, sb, flags);
> 
> And here pass *flags.
> 
> Thanks.
> 
>>          if (ret < 0)
>>                  goto restore;
>>
>> --
>> 2.39.0
>>
