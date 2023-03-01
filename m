Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462DF6A641D
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Mar 2023 01:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjCAASN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Feb 2023 19:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCAASM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Feb 2023 19:18:12 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECB844BF
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Feb 2023 16:18:05 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M26vB-1pVEDz34Cf-002TSs; Wed, 01
 Mar 2023 01:18:03 +0100
Message-ID: <7c04f236-a81c-8198-8e9e-d280d4b4127d@gmx.com>
Date:   Wed, 1 Mar 2023 08:17:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
To:     =?UTF-8?Q?Tomasz_K=c5=82oczko?= <kloczko.tomasz@gmail.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230228192335.12451-1-dsterba@suse.com>
 <CABB28Cw_=EaExPGWRX7k1dB0+j_PoHWPti3bmYvEEURQscKKHA@mail.gmail.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Btrfs progs release 6.2
In-Reply-To: <CABB28Cw_=EaExPGWRX7k1dB0+j_PoHWPti3bmYvEEURQscKKHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4Dv2kyuR+pBovR9IC2pYaSSynAicANJ9rK+me50wpO5dXQfyKNQ
 fEwu8yp2/QCs9HPA0/RTyUW3T9z27V84tRUeuPkvHAlqfZZLR4sgnZKyn1OsIUZjiYkbUno
 FTRfol+SnOjzep0m0KXh8Nv3vIHJnJkoWAuqr4SRj6awNrpebVpTLM7Ul5uMeIlDDatXg1f
 o/7zdolGklNZtR4DrklOw==
UI-OutboundReport: notjunk:1;M01:P0:mkRZzPkIJJA=;1WDK3uSunX7dOGbBmK0BR6tl8zZ
 l6q0MgSVe9HoZJ7yGtnDBrlOjjtYW6Hoy0LpmQidXbPaBGCOVqcegLlMZGZXw31LVBm3fn/QG
 oi5VdfzvPA5DPZwtyz4agSoCbO/+Q/UR5MskxEkEg2QTuoorffgPp6yHJsRbXnjMulcMNF7Vd
 hAbnpd/lEckQhGLZEaZiygNf2NHhnsZDRsCxdOFaGFtTw/nYYyUoo48et+Gvu+tw7fBPKPM6a
 1ujJHKeWLiSonne0YrQllARzPupJB+WsQ/SKb7xRm4hs6KJbdGN3k7F39GQ4sVsRUPmnzTcHO
 96Wp/LROtB6L8QNm71WQjukHZTE0vgRPOK92FmTXFxD5h+ROghq5v+vBrhp0oF2P0HoEeb5ej
 T38ZsQ1Y08q5CnfWvGuXluGzqWkcqm0CtJQGHv/SIZQeDGiNJ7SIkicpAgf85QKcxtBR9WDv5
 bTzYVADNIPErmDWEY/Gji6qVcQssA00QUJVov4A4+LAnwf2zBCX0GJlba5Knuj58iqnfnsUmC
 5O9vR3PLUsYdRyCOeDUKjIww0YZ2Vsib2UrP+nH2Z6GS6t2I/IjEsg3PzIKRhBaLgt5zz5Fve
 7Pbo/x77bVpLgvMxW9YdgULNtDRA5/INB0kFgXBrXVa1h73jAjNOBOsYgvcfnnpNc+6+A8BpW
 eL1q6F+GLoMURVHuMgjeWijbdtiIRev1T8rASkrdhMEmjLbIZ1orewRd35jkUlKxyFWvtpMsQ
 xjEWLvZ8Ds0SSA+WGNDswNBPeWAYlakYFRE5GCCAVXIiLC0cav+dTA4i24CVqKx5H1foCteb1
 H15gwG0HWoYE32DP0dpk128bn63LzMEvLg9X7LDAhcF05BBd/UL5BqggivWVAOEH+SQuHSEVD
 Y3TvBaE8mfsWPsldHiBgIaMSv29Kwh7sHoZSahTc1wvN5X+TojVMARhVp2ffcwuIAYNNaaUfm
 fJF2RhvYmvDBHM+9NwtHPF/jkGIE/CuF5TRLSK6uuyooXswxvxzdW7CBTz+z8K50oDITSg==
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/1 07:07, Tomasz Kłoczko wrote:
> On Tue, 28 Feb 2023 at 20:07, David Sterba <dsterba@suse.com> wrote:
>>
>> Hi,
>>
>> btrfs-progs version 6.2 have been released.
>>
>> Changelog:
>>     * receive: fix a corruption when decompressing zstd extents
>>     * subvol sync: print total number and deletion progress
>>     * accelerated hash algorithm implementations in fallback mode on x86_64
>>     * fi mkswapfile: new option --uuid
>>     * new global option --log=level to set the verbosity level directly
>>     * other:
>>        * experimental: update checksum conversion (not usable yet)
>>        * build actually requires -std=gnu11
>>        * refactor help option formatting, auto wrap long lines
> 
> Just tested new dist tar ball and looks like something is wrong
> because linking fails on:
> 
>      [LD]     btrfs
> /usr/bin/gcc -o btrfs btrfs.o kernel-lib/list_sort.o
> kernel-lib/raid56.o kernel-lib/rbtree.o kernel-lib/tables.o
> kernel-shared/backref.o kernel-shared/ctree.o
> kernel-shared/delayed-ref.o kernel-shared/dir-item.o
> kernel-shared/disk-io.o kernel-shared/extent-tree.o
> kernel-shared/extent_io.o kernel-shared/file-item.o
> kernel-shared/file.o kernel-shared/free-space-cache.o
> kernel-shared/free-space-tree.o kernel-shared/inode-item.o
> kernel-shared/inode.o kernel-shared/print-tree.o
> kernel-shared/root-tree.o kernel-shared/transaction.o
> kernel-shared/ulist.o kernel-shared/uuid-tree.o
> kernel-shared/volumes.o kernel-shared/zoned.o common/cpu-utils.o
> common/device-scan.o common/device-utils.o common/extent-cache.o
> common/filesystem-utils.o common/format-output.o common/fsfeatures.o
> common/help.o common/messages.o common/open-utils.o
> common/parse-utils.o common/path-utils.o common/rbtree-utils.o
> common/send-stream.o common/send-utils.o common/string-table.o
> common/string-utils.o common/task-utils.o common/units.o
> common/utils.o check/qgroup-verify.o check/repair.o
> cmds/receive-dump.o crypto/crc32c.o crypto/hash.o crypto/xxhash.o
> libbtrfsutil/stubs.o libbtrfsutil/subvolume.o cmds/subvolume.o
> cmds/subvolume-list.o cmds/filesystem.o cmds/device.o cmds/scrub.o
> cmds/inspect.o cmds/balance.o cmds/send.o cmds/receive.o cmds/quota.o
> cmds/qgroup.o cmds/replace.o check/main.o cmds/restore.o cmds/rescue.o
> cmds/rescue-chunk-recover.o cmds/rescue-super-recover.o
> cmds/property.o cmds/filesystem-usage.o cmds/inspect-dump-tree.o
> cmds/inspect-dump-super.o cmds/inspect-tree-stats.o
> cmds/filesystem-du.o cmds/reflink.o mkfs/common.o check/mode-common.o
> check/mode-lowmem.o check/clear-cache.o libbtrfsutil.a -Wl,--as-needed
> -Wl,--gc-sections -Wl,-z,now
> -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -flto=auto
> -flto-partition=none -fuse-linker-plugin -Wl,--build-id=sha1 -rdynamic
> -L.   -luuid -lblkid -ludev -L. -pthread -lkcapi -lz -llzo2 -lzstd
> /usr/bin/ld: /tmp/ccTTIULh.lto.o: in function `hash_init_accel':
> /home/tkloczko/rpmbuild/BUILD/btrfs-progs-v6.2/crypto/hash.c:26:
> undefined reference to `blake2_init_accel'
> /usr/bin/ld: /home/tkloczko/rpmbuild/BUILD/btrfs-progs-v6.2/crypto/hash.c:27:
> undefined reference to `sha256_init_accel'
> /usr/bin/ld: /tmp/ccTTIULh.lto.o: in function `hash_init_blake2':
> /home/tkloczko/rpmbuild/BUILD/btrfs-progs-v6.2/crypto/hash.c:37:
> undefined reference to `blake2_init_accel'
> /usr/bin/ld: /tmp/ccTTIULh.lto.o: in function `hash_init_sha256':
> /home/tkloczko/rpmbuild/BUILD/btrfs-progs-v6.2/crypto/hash.c:42:
> undefined reference to `sha256_init_accel'
> collect2: error: ld returned 1 exit status
> make: *** [Makefile:629: btrfs] Error 1

Compared to my passing build (Archlinux, thus most of things should be 
pretty close to rawhide), it looks like Fedora is missing the blake2 and 
sha256 object files:

     [LD]     btrfs
gcc -o btrfs btrfs.o kernel-lib/list_sort.o kernel-lib/raid56.o 
kernel-lib/rbtree.o kernel-lib/tables.o kernel-shared/backref.o 
kernel-shared/ctree.o kernel-shared/delayed-ref.o 
kernel-shared/dir-item.o kernel-shared/disk-io.o 
kernel-shared/extent-tree.o kernel-shared/extent_io.o 
kernel-shared/file-item.o kernel-shared/file.o 
kernel-shared/free-space-cache.o kernel-shared/free-space-tree.o 
kernel-shared/inode-item.o kernel-shared/inode.o 
kernel-shared/print-tree.o kernel-shared/root-tree.o 
kernel-shared/transaction.o kernel-shared/ulist.o 
kernel-shared/uuid-tree.o kernel-shared/volumes.o kernel-shared/zoned.o 
common/cpu-utils.o common/device-scan.o common/device-utils.o 
common/extent-cache.o common/filesystem-utils.o common/format-output.o 
common/fsfeatures.o common/help.o common/messages.o common/open-utils.o 
common/parse-utils.o common/path-utils.o common/rbtree-utils.o 
common/send-stream.o common/send-utils.o common/string-table.o 
common/string-utils.o common/task-utils.o common/units.o common/utils.o 
check/qgroup-verify.o check/repair.o cmds/receive-dump.o crypto/crc32c.o 
crypto/hash.o crypto/xxhash.o crypto/sha224-256.o crypto/blake2b-ref.o 
crypto/blake2b-sse2.o crypto/blake2b-sse41.o crypto/blake2b-avx2.o 
crypto/sha256-x86.o libbtrfsutil/stubs.o libbtrfsutil/subvolume.o 
cmds/subvolume.o cmds/subvolume-list.o cmds/filesystem.o cmds/device.o 
cmds/scrub.o cmds/inspect.o cmds/balance.o cmds/send.o cmds/receive.o 
cmds/quota.o cmds/qgroup.o cmds/replace.o check/main.o cmds/restore.o 
cmds/rescue.o cmds/rescue-chunk-recover.o cmds/rescue-super-recover.o 
cmds/property.o cmds/filesystem-usage.o cmds/inspect-dump-tree.o 
cmds/inspect-dump-super.o cmds/inspect-tree-stats.o cmds/filesystem-du.o 
cmds/reflink.o mkfs/common.o check/mode-common.o check/mode-lowmem.o 
check/clear-cache.o libbtrfsutil.a  -rdynamic -L.   -luuid  -lblkid 
-ludev  -L. -pthread  -lz  -llzo2 -lzstd

According to the Makefile, it looks like Fedora build is not using the 
built-in crypto code.

If using libsodium, I got the same error, as libsodium goes a different 
name for its blake2b_init (crypto_generichash_blake2b_init).

We need more work to support external crypto libraries.

For now, please use builtin crypto to pass the build.

Thanks,
Qu

> 
> kloczek
> --
> Tomasz Kłoczko | LinkedIn: http://lnkd.in/FXPWxH
