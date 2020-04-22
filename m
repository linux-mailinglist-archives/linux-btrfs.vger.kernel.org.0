Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37071B3984
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 09:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgDVH7Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 03:59:25 -0400
Received: from lists.nic.cz ([217.31.204.67]:47994 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbgDVH7Y (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 03:59:24 -0400
Received: from localhost (unknown [172.20.6.135])
        by mail.nic.cz (Postfix) with ESMTPSA id 2D59D13FFC7;
        Wed, 22 Apr 2020 09:59:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1587542362; bh=IZUa4kM/mEQaN2UJ4l9HAa4DgGRPlcFtI0wKXk/n1Ik=;
        h=Date:From:To;
        b=DkMiaoZGXFV9BMdpy+nNU8JaThYgFWhwWn449g1tPMgy5OaRzyQKGPURY0bsPsNCr
         zO1Oh/B54OpCn4/iptkE7salw5OsHF9ksyNST3Mh6NWzLEziaROAJmvaM0RHPAWpDB
         nKVvHFFM+F0dCH/ea/7/IZcKX8IbcQN6x7xBMuKU=
Date:   Wed, 22 Apr 2020 09:59:21 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        u-boot@lists.denx.de
Subject: Re: [PATCH U-BOOT 00/26] fs: btrfs: Re-implement btrfs support
 using the more widely used extent buffer base code
Message-ID: <20200422095921.126fbe69@nic.cz>
In-Reply-To: <20200422065009.69392-1-wqu@suse.com>
References: <20200422065009.69392-1-wqu@suse.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-100.0 required=5.9 tests=SHORTCIRCUIT,
        USER_IN_WHITELIST shortcircuit=ham autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Virus-Scanned: clamav-milter 0.101.4 at mail
X-Virus-Status: Clean
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Also there are some warnings when compiling for Mox and Omnia:




fs/btrfs/inode.c: In function =E2=80=98btrfs_lookup_path=E2=80=99:
fs/btrfs/inode.c:141:16: warning: =E2=80=98parent_root=E2=80=99 may be used=
 uninitialized in this function [-Wmaybe-uninitialized]
  141 |   key.objectid =3D parent_root;
      |   ~~~~~~~~~~~~~^~~~~~~~~~~~~
fs/btrfs/inode.c:127:7: note: =E2=80=98parent_root=E2=80=99 was declared he=
re
  127 |   u64 parent_root;
      |       ^~~~~~~~~~~
  CC      cmd/nvedit.o
In file included from fs/btrfs/ctree.h:19,
                 from fs/btrfs/disk-io.h:7,
                 from fs/btrfs/disk-io.c:8:
fs/btrfs/disk-io.c: In function =E2=80=98btrfs_scan_fs_devices=E2=80=99:
fs/btrfs/disk-io.c:881:9: warning: format =E2=80=98%llu=E2=80=99 expects ar=
gument of type =E2=80=98long long unsigned int=E2=80=99, but argument 3 has=
 type =E2=80=98lbaint_t=E2=80=99 {aka =E2=80=98long unsigned int=E2=80=99} =
[-Wformat=3D]
  881 |   error("superblock end %u is larger than device size %llu",
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  882 |     BTRFS_SUPER_INFO_SIZE + BTRFS_SUPER_INFO_OFFSET,
  883 |     part->size << desc->log2blksz);
      |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                |
      |                lbaint_t {aka long unsigned int}
fs/btrfs/compat.h:13:29: note: in definition of macro =E2=80=98error=E2=80=
=99
   13 | #define error(...) { printf(__VA_ARGS__); printf("\n"); }
      |                             ^~~~~~~~~~~
fs/btrfs/disk-io.c:881:58: note: format string is defined here
  881 |   error("superblock end %u is larger than device size %llu",
      |                                                       ~~~^
      |                                                          |
      |                                                          long long =
unsigned int
      |                                                       %lu






In file included from fs/btrfs/ctree.h:19,
                 from fs/btrfs/volumes.c:5:
fs/btrfs/volumes.c: In function =E2=80=98btrfs_check_chunk_valid=E2=80=99:
fs/btrfs/volumes.c:404:9: warning: format =E2=80=98%lu=E2=80=99 expects arg=
ument of type =E2=80=98long unsigned int=E2=80=99, but argument 4 has type =
=E2=80=98u32=E2=80=99 {aka =E2=80=98unsigned int=E2=80=99} [-Wformat=3D]
  404 |   error("invalid chunk item size, have %u expect [%zu, %lu)",
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fs/btrfs/compat.h:13:29: note: in definition of macro =E2=80=98error=E2=80=
=99
   13 | #define error(...) { printf(__VA_ARGS__); printf("\n"); }
      |                             ^~~~~~~~~~~
fs/btrfs/volumes.c:404:58: note: format string is defined here
  404 |   error("invalid chunk item size, have %u expect [%zu, %lu)",
      |                                                        ~~^
      |                                                          |
      |                                                          long unsig=
ned int
      |                                                        %u
