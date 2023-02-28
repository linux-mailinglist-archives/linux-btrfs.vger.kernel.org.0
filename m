Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A756B6A63AA
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Mar 2023 00:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjB1XI1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Feb 2023 18:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjB1XI0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Feb 2023 18:08:26 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A677393FA
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Feb 2023 15:08:24 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id m7so15323242lfj.8
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Feb 2023 15:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+b2w3vbgOtkj/cjBASnZ1l7UWPjJw/LnPNqVV1J3EXY=;
        b=GEj+RI16rS8riXozYOAKXYKdxln+Q5z7gytHMc0MqoC2JEQMS3MwLFnslKEf7Us5S9
         zT6W2SubeZDTiqk9kfLhCI6bdw4s+Z+nv/936hJxmWiHZOb36h12xGJwY1ILk8dmDvFj
         AVAXulDyHn5FAi/vKz6nMWdd//2c4Eq5s1vRrP9UBo50Ci8a0uae0YMLJJVqp4C6qbVe
         THU8J6pUTmBuEW0orW0GHcNxWSTtv9LD1e4oB+XFoVMRf2agfKsBtUv7+6/qXMvA3ZOl
         j5TswETtYxdJi6p34uRsS9acxoO1FIm2j3SRNJnwsdxFFTll4pENsok0YlQ9ncdLKUFT
         UrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+b2w3vbgOtkj/cjBASnZ1l7UWPjJw/LnPNqVV1J3EXY=;
        b=6bHJg9Af7QikgFOoN8JQmcoMYwF99y+wZTCquYW3qP1n8W+5Ew4wW1sL/LYbm1Z7Jp
         RHTutTDiSzmA8pkW8n+yo6oPU65hLU7DB4qxDwoGxf9EuteuTKRjggDRRDegNR7kIBe5
         HKl61cRzI8cgc6U3GMkhqb4B7ruULv15hK1VMxFaFvLEB+iqBhMYSCWT8e9cBLCRoZuk
         tA1oKl2akZ/sJu6cNFgP/kmVYS0rqNcSAwOFGxOJexL1i7zsyYnqUFYl3Bw0xVcNDZt8
         h+gXpPhOvHqPz7ZJ+Zuqw/nu1v54xcQWjz0BkTjUEJigKaevlr7cTICGlAqaSn0X6NJc
         WtvQ==
X-Gm-Message-State: AO0yUKV8lPXX8v7tYqgwFBxx9jFWuFwbsSNcX8h8912bNasJRN/sJe3R
        eem/djp1GuW6zofgZNTVCyrUpxFI7IExIuKiqid7/DokeYs=
X-Google-Smtp-Source: AK7set8oi81Kk4XDpZwRj583SpkzoYXaPJGMct2cLA18V3poP4o3KT66oU+i3LtZHdpvgcIeor/+UfSJ/wcOVXg7JiE=
X-Received: by 2002:ac2:538e:0:b0:4db:3353:c891 with SMTP id
 g14-20020ac2538e000000b004db3353c891mr1237500lfh.3.1677625702710; Tue, 28 Feb
 2023 15:08:22 -0800 (PST)
MIME-Version: 1.0
References: <20230228192335.12451-1-dsterba@suse.com>
In-Reply-To: <20230228192335.12451-1-dsterba@suse.com>
From:   =?UTF-8?Q?Tomasz_K=C5=82oczko?= <kloczko.tomasz@gmail.com>
Date:   Tue, 28 Feb 2023 23:07:56 +0000
Message-ID: <CABB28Cw_=EaExPGWRX7k1dB0+j_PoHWPti3bmYvEEURQscKKHA@mail.gmail.com>
Subject: Re: Btrfs progs release 6.2
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 28 Feb 2023 at 20:07, David Sterba <dsterba@suse.com> wrote:
>
> Hi,
>
> btrfs-progs version 6.2 have been released.
>
> Changelog:
>    * receive: fix a corruption when decompressing zstd extents
>    * subvol sync: print total number and deletion progress
>    * accelerated hash algorithm implementations in fallback mode on x86_6=
4
>    * fi mkswapfile: new option --uuid
>    * new global option --log=3Dlevel to set the verbosity level directly
>    * other:
>       * experimental: update checksum conversion (not usable yet)
>       * build actually requires -std=3Dgnu11
>       * refactor help option formatting, auto wrap long lines

Just tested new dist tar ball and looks like something is wrong
because linking fails on:

    [LD]     btrfs
/usr/bin/gcc -o btrfs btrfs.o kernel-lib/list_sort.o
kernel-lib/raid56.o kernel-lib/rbtree.o kernel-lib/tables.o
kernel-shared/backref.o kernel-shared/ctree.o
kernel-shared/delayed-ref.o kernel-shared/dir-item.o
kernel-shared/disk-io.o kernel-shared/extent-tree.o
kernel-shared/extent_io.o kernel-shared/file-item.o
kernel-shared/file.o kernel-shared/free-space-cache.o
kernel-shared/free-space-tree.o kernel-shared/inode-item.o
kernel-shared/inode.o kernel-shared/print-tree.o
kernel-shared/root-tree.o kernel-shared/transaction.o
kernel-shared/ulist.o kernel-shared/uuid-tree.o
kernel-shared/volumes.o kernel-shared/zoned.o common/cpu-utils.o
common/device-scan.o common/device-utils.o common/extent-cache.o
common/filesystem-utils.o common/format-output.o common/fsfeatures.o
common/help.o common/messages.o common/open-utils.o
common/parse-utils.o common/path-utils.o common/rbtree-utils.o
common/send-stream.o common/send-utils.o common/string-table.o
common/string-utils.o common/task-utils.o common/units.o
common/utils.o check/qgroup-verify.o check/repair.o
cmds/receive-dump.o crypto/crc32c.o crypto/hash.o crypto/xxhash.o
libbtrfsutil/stubs.o libbtrfsutil/subvolume.o cmds/subvolume.o
cmds/subvolume-list.o cmds/filesystem.o cmds/device.o cmds/scrub.o
cmds/inspect.o cmds/balance.o cmds/send.o cmds/receive.o cmds/quota.o
cmds/qgroup.o cmds/replace.o check/main.o cmds/restore.o cmds/rescue.o
cmds/rescue-chunk-recover.o cmds/rescue-super-recover.o
cmds/property.o cmds/filesystem-usage.o cmds/inspect-dump-tree.o
cmds/inspect-dump-super.o cmds/inspect-tree-stats.o
cmds/filesystem-du.o cmds/reflink.o mkfs/common.o check/mode-common.o
check/mode-lowmem.o check/clear-cache.o libbtrfsutil.a -Wl,--as-needed
-Wl,--gc-sections -Wl,-z,now
-specs=3D/usr/lib/rpm/redhat/redhat-hardened-ld -flto=3Dauto
-flto-partition=3Dnone -fuse-linker-plugin -Wl,--build-id=3Dsha1 -rdynamic
-L.   -luuid -lblkid -ludev -L. -pthread -lkcapi -lz -llzo2 -lzstd
/usr/bin/ld: /tmp/ccTTIULh.lto.o: in function `hash_init_accel':
/home/tkloczko/rpmbuild/BUILD/btrfs-progs-v6.2/crypto/hash.c:26:
undefined reference to `blake2_init_accel'
/usr/bin/ld: /home/tkloczko/rpmbuild/BUILD/btrfs-progs-v6.2/crypto/hash.c:2=
7:
undefined reference to `sha256_init_accel'
/usr/bin/ld: /tmp/ccTTIULh.lto.o: in function `hash_init_blake2':
/home/tkloczko/rpmbuild/BUILD/btrfs-progs-v6.2/crypto/hash.c:37:
undefined reference to `blake2_init_accel'
/usr/bin/ld: /tmp/ccTTIULh.lto.o: in function `hash_init_sha256':
/home/tkloczko/rpmbuild/BUILD/btrfs-progs-v6.2/crypto/hash.c:42:
undefined reference to `sha256_init_accel'
collect2: error: ld returned 1 exit status
make: *** [Makefile:629: btrfs] Error 1

kloczek
--
Tomasz K=C5=82oczko | LinkedIn: http://lnkd.in/FXPWxH
