Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121A131CA2B
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Feb 2021 12:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhBPLvN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Feb 2021 06:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhBPLtl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Feb 2021 06:49:41 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701BDC061756
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 03:48:50 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id 81so9084001qkf.4
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 03:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=HWWdqoiyebIHEw6LLX/TMZKBxqs0wPo+7AlHjef9Kw4=;
        b=QPPO3s4MqQp7dzuqZxdebdETeCOw0XtMpfNop7Z3wE5H2rB6FUvwjfFZ4MK761A1C0
         H6tBOZQo6vh1Z6wjlkgIxO89uLzjHZxyYYBZ3osYHo58s+JzyBfxU2yd3R8Ti4SUH37E
         uXOwnm4Fa/VDp/NX7U1QH+lS1wBNTOf7BZAPC+jPodYke03NrEOTJOVkmyCrBRuo1NsB
         1l2Q54HyE7thAAw3ZNbtiNW96+2z8rvTGqI34P2XW+fJBtbAtFHq6/bFlpd3qq6WSfDW
         DirrT0HRQyXyKzoPxTtRzHsVWBVeNMnkVOV6qk1mzzt+ibe6bnVDlZPCIWHL5sNXMP8W
         4xKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=HWWdqoiyebIHEw6LLX/TMZKBxqs0wPo+7AlHjef9Kw4=;
        b=WedoczD9ShF6ZHrFIC2PYVqeUTUKH6PguMiunVbtzpYbVHbJgK3hn+BjlS0HMGaYX+
         MazqNsEiDUWgPBda6kDx0ZhAQ0Fm5N6aXNK15wCuzG6YOfPT39rPwP/MO9TI9UYBP2uj
         AT69W66ydny14EAo9dt6lqh1mQehUVyq4axhq4F5aRPsfX/w3LTy647m/kBP4xA5oZK5
         +wwzqiFczVKJ2ZZwsl0cX2xyyRjJdjwfsYBm5Tzpas5qF5n/2QJTEur3AI1HR8FOYg6V
         Ockh+fwC64oKm5vCNdZPu+wQqngCgKEMy6tGlOxk5wr7zdMFBtqzLzYwQiC1NiUUTkQL
         qkXg==
X-Gm-Message-State: AOAM532cnMQlq+iNJDeAu1YG9fNqoa2G8e1BycdRnwOaLz2/pJlP+ijS
        0Iy4C1eYZEOZBlRJ0Boiu7JO3ggbPnrmrApbApA95PlLtlL9rg==
X-Google-Smtp-Source: ABdhPJygo9TrbS8XRs7Wx95LGdOAqyHUpJ/lh5F2eNGpL92tpfiiaxTsnrX0OCi+blPSU8fqEVdlFBPL3m5AJ35Uh/E=
X-Received: by 2002:a37:54b:: with SMTP id 72mr18209737qkf.338.1613476129579;
 Tue, 16 Feb 2021 03:48:49 -0800 (PST)
MIME-Version: 1.0
References: <20210118222021.11603-1-dsterba@suse.com>
In-Reply-To: <20210118222021.11603-1-dsterba@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 16 Feb 2021 11:48:38 +0000
Message-ID: <CAL3q7H5_bsBUL+OZg+tNbN4Tx6bT7Gwqmh1L2N-7nhn_c++vLQ@mail.gmail.com>
Subject: Re: Btrfs progs release 5.10
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Marcos Paulo de Souza <marcos@mpdesouza.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 19, 2021 at 5:26 AM David Sterba <dsterba@suse.com> wrote:
>
> Hi,
>
> btrfs-progs version 5.10 have been released.
>
> Only minor changes snice -rc1: CI on gitlab disabled, some docs added.
>
> Changelog:
>
>   * scrub status:
>     * print percentage of progress
>     * add size unit options
>   * fi usage: also print free space from statfs
>   * convert: copy full 64 bit timestamp from ext4 if avaialble
>   * check:
>     * add ability to repair extent item generation
>     * new option to remove leftovers from inode number cache (-o inode_ca=
che)
>   * check for already running exclusive operation (balance, device add/..=
.)
>     when starting one
>   * preliminary json output support for 'device stats'
>   * fixes:
>     * subvolume set-default: id 0 correctly falls back to tolpevel
>     * receive: align internal buffer to allow fast CRC calculation
>     * logical-resolve: distinguish -o subvol and bind mounts
>   * build: new dependency libmount
>   * other
>     * doc fixes and updates
>     * new tests
>     * ci on gitlab temporarily disabled
>     * debugging output enhancements
>
> Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-prog=
s/
> Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
>
> Shortlog:
>
> Adam Borowski (1):
>       btrfs-progs: a bunch of typo fixes
>
> Daniel Xu (1):
>       btrfs-progs: sort main help menu entries
>
> David Sterba (22):
>       btrfs-progs: scrub status: print percents of scrubbed bytes
>       btrfs-progs: scrub status: add unit mode options
>       btrfs-progs: docs: add missing option to scrub status
>       btrfs-progs: move path_cat_out helpers to path-utils
>       btrfs-progs: docs: fix mknod arguments of the control device
>       btrfs-progs: add helpers for parsing filesystem exclusive operation
>       btrfs-progs: add helper to check or wait for exclusive operation
>       btrfs-progs: add enqueue parameter for exclusive ops
>       btrfs-progs: docs: document fs exclusive operations
>       btrfs-progs: subvol show: fix required arguments in help texts
>       btrfs-progs: fix short/long unit size options
>       btrfs-progs: tests: add Makefile for testsuite
>       btrfs-progs: initialize formatter context properly
>       btrfs-progs: tests: add json formatter test coverage
>       btrfs-progs: build: add missing gitignore and clean binaries
>       btrfs-progs: tests: test full 64bit timestamp conversion on ext4
>       btrfs-progs: subvol set-default: change id to 5 if specified as 0
>       btrfs-progs: tests: set toplevel subvolume as default when specifie=
d as 0
>       btrfs-progs: ci: temporarily disable gitlab CI
>       btrfs-progs: docs: document command line conventions
>       btrfs-progs: update CHANGES for 5.10
>       Btrfs progs v5.10
>
> Eric Semeniuc (1):
>       btrfs-progs: docs: grammar and typo fix for btrfs check
>
> Goldwyn Rodrigues (3):
>       btrfs-progs: add get_fsid_fd() for getting fsid using fd
>       btrfs-progs: add sysfs file reading helpers
>       btrfs-progs: check for exclusive operation before issuing another
>
> Jiachen YANG (1):
>       btrfs-progs: convert: copy extra timespec on ext4
>
> Josef Bacik (4):
>       btrfs-progs: only print the parent or ref root for ref mismatches
>       btrfs-progs: print the eb flags for nodes as well
>       btrfs-progs: image: fix invalid size check for extent items
>       btrfs-progs: check: properly exclude leaves for lowmem mode
>
> Marcos Paulo de Souza (4):
>       btrfs-progs: build: add libmount dependency
>       btrfs-progs: utils: introduce find_mount_fsroot

I can't find the thread for that patch on the mailing list, so I'll
report the issue here.

This change, "btrfs-progs: utils: introduce find_mount_fsroot", makes
at least one test case from fstests fail:

$ ./check btrfs/184
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 debian8 5.11.0-rc6-btrfs-next-80 #1 SMP
PREEMPT Wed Feb 3 11:28:05 WET 2021
MKFS_OPTIONS  -- /dev/sdc
MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

btrfs/184 1s ... [failed, exit status 1]- output mismatch (see
/home/fdmanana/git/hub/xfstests/results//btrfs/184.out.bad)
    --- tests/btrfs/184.out 2020-06-10 19:29:03.822519250 +0100
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/184.out.bad
2021-02-16 11:42:40.755587041 +0000
    @@ -1,2 +1,3 @@
     QA output created by 184
    -Silence is golden
    +Deleted dev superblocks not scratched
    +(see /home/fdmanana/git/hub/xfstests/results//btrfs/184.full for detai=
ls)
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/184.out
/home/fdmanana/git/hub/xfstests/results//btrfs/184.out.bad'  to see
the entire diff)
Ran: btrfs/184
Failures: btrfs/184
Failed 1 of 1 tests

Any plans to fix this?

Thanks.

>       btrfs-progs: inspect: use find_mount_fsroot in logical-resolve
>       btrfs-progs: tests: test logical-resolve in various scenarios
>
> Nikolay Borisov (2):
>       btrfs-progs: check: add option to remove ino cache
>       btrfs-progs: tests: test check --clear-ino-cache
>
> Omar Sandoval (1):
>       btrfs-progs: send: fix crash on unknown option
>
> Qu Wenruo (6):
>       btrfs-progs: mkfs: refactor how we handle sectorsize override
>       btrfs-progs: check/lowmem: add ability to repair extent item genera=
tion
>       btrfs-progs: check/original: don't reset extent generation for chec=
k_block
>       btrfs-progs: check/original: add ability to repair extent item gene=
ration
>       btrfs-progs: tests: enhance invalid extent item generation test cas=
es
>       btrfs-progs: check: only warn if clearing v1 cache and v2 found
>
> Sheng Mao (1):
>       btrfs-progs: align receive buffer to enable fast CRC
>
> Sidong Yang (3):
>       btrfs-progs: fi usage: add avail info from statfs()
>       btrfs-progs: extend fmt_print_start_group to handle unnamed group
>       btrfs-progs: device stats: add json output format
>
> Su Yue (2):
>       btrfs-progs: subvol show: reset subvol_path to NULL after free
>       btrfs-progs: print bytenr of child eb if mismatched level found in =
read_node_slot
>
> Tomasz Torcz (1):
>       btrfs-progs: docs: add info about "single" profile requirements for=
 swapfile
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
