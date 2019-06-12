Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB5FE42808
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2019 15:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436928AbfFLNwT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jun 2019 09:52:19 -0400
Received: from mail-ua1-f46.google.com ([209.85.222.46]:46920 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436759AbfFLNwT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jun 2019 09:52:19 -0400
Received: by mail-ua1-f46.google.com with SMTP id o19so5915145uap.13
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jun 2019 06:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wILGoF5ogfM68yim2OOpOLchdbcUZ9BLdPQNEhYUHkQ=;
        b=c2vU+qwTtD5leGO97du7WehZosv/JRWeNHnkVuxyg0mRYnOOKQ5fi6c7rnM5eumqgo
         J3LMMCPJw9DZbOsu8ijTEJAJWTjdgndveRaxJGGa4u/85gSSj81n1SxSV2I1UhwKPmyA
         HGGHdXnxqThzhnPYJiFH4/33R27SvOaI0yMk82fcJIBi4e3HLF5OKu0VwVgNSU5LkMsc
         ZxlQl2qcRr/dn7Z0rb6SWPUxgprbI6Vnsl+4VEI3exsk+9qn1PM/udnEKTACQ8xs5KAY
         sWdkRFXuo8l+2Qbotykj8wqSs1Sye3DrUMUboWnWqqEPdxuLH48kSnJavZbuUG4yk639
         eg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wILGoF5ogfM68yim2OOpOLchdbcUZ9BLdPQNEhYUHkQ=;
        b=ltYNSxIDty0RdOYdinyWx6UhqZJ7/VgYpwlNKtKYRG5JizQ+M5+uQjq9U4yZ0Roufh
         YX5bsbAa10pCFyy9QHjkBdWlMourmghq81ZR4BWheYth2mXabXQsVQS0lgBiJNpJHiKX
         PpqUIXw/9nD0dPp7VHhCcivafiUNqOUNvXvDeQ9bvC+6jklo1Qs5c93FrjtkD/hUdqLg
         k1o5MrlDlYMSEY6iW7CXIX2WY4x8Fs4cJ9SlCQHWxwhG/I/FTnlPEwmkWbTNaxcoFtyz
         tJCwCyFYy0KkwXucFd9AWq4egYsGuoKDYkxXbtivKVpyeu3P4vD7ajjGNw8mz6IUqPNw
         9Qsw==
X-Gm-Message-State: APjAAAWd6wc4B+aih1KSMj1Xox75mZ55H6r+qZyv2HMQLdBcnmXbxpjk
        qwH10t8V93ZrKiN2yApkvkCwsGuW1y/KYydkGvSRRu7jGZA=
X-Google-Smtp-Source: APXvYqysbdgjaNfTXP0491o6c7q435mS+RGEUGyqPboeajhTRjBoKcsLHrgsrkmOk0Bbp0/ye/RHr3Dv4Kw3VXwoyEQ=
X-Received: by 2002:a9f:366b:: with SMTP id s40mr16432829uad.121.1560347538584;
 Wed, 12 Jun 2019 06:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190611164740.14472-1-dsterba@suse.com>
In-Reply-To: <20190611164740.14472-1-dsterba@suse.com>
From:   =?UTF-8?Q?Tomasz_K=C5=82oczko?= <kloczko.tomasz@gmail.com>
Date:   Wed, 12 Jun 2019 14:51:52 +0100
Message-ID: <CABB28Cx7UdEmOBOquBd8rHcCnJR4ff4AWP2P1gXnME7G0dLs4w@mail.gmail.com>
Subject: Re: Btrfs progs release 5.1.1
To:     David Sterba <dsterba@suse.com>
Cc:     Linux fs Btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 11 Jun 2019 at 20:02, David Sterba <dsterba@suse.com> wrote:
> btrfs-progs version 5.1.1 have been released.

Still test suite is failing for me.

+ /usr/bin/make test
    [TEST]   fsck-tests.sh
    [TEST/fsck]   001-bad-file-extent-bytenr
    [TEST/fsck]   002-bad-transid
    [TEST/fsck]   003-shift-offsets
    [TEST/fsck]   004-no-dir-index
    [TEST/fsck]   005-bad-item-offset
    [TEST/fsck]   006-bad-root-items
    [TEST/fsck]   007-bad-offset-snapshots
    [TEST/fsck]   008-bad-dir-index-name
    [TEST/fsck]   009-no-dir-item-or-index
    [TEST/fsck]   010-no-rootdir-inode-item
    [TEST/fsck]   011-no-inode-item
    [TEST/fsck]   012-leaf-corruption
    [TEST/fsck]   013-extent-tree-rebuild
    [TEST/fsck]   014-no-extent-info
    [TEST/fsck]   016-wrong-inode-nbytes
    [TEST/fsck]   017-missing-all-file-extent
    [TEST/fsck]   018-leaf-crossing-stripes
    [TEST/fsck]   019-non-skinny-false-alert
    [TEST/fsck]   020-extent-ref-cases
    [TEST/fsck]   021-partially-dropped-snapshot-case
    [TEST/fsck]   022-qgroup-rescan-halfway
    [TEST/fsck]   023-qgroup-stack-overflow
    [TEST/fsck]   024-clear-space-cache
    [TEST/fsck]   025-file-extents
    [TEST/fsck]   026-bad-dir-item-name
    [TEST/fsck]   027-bad-extent-inline-ref-type
    [TEST/fsck]   028-unaligned-super-dev-sizes
    [TEST/fsck]   029-valid-orphan-item
    [TEST/fsck]   030-reflinked-prealloc-extents
    [TEST/fsck]   031-metadatadump-check-data-csum
    [TEST/fsck]   032-corrupted-qgroup
    [TEST/fsck]   033-lowmem-collission-dir-items
    [TEST/fsck]   034-bad-inode-flags
    [TEST/fsck]   035-inline-bad-ram-bytes
    [TEST/fsck]   036-bad-dev-extents
    [TEST/fsck]   036-rescan-not-kicked-in
    [TEST/fsck]   037-freespacetree-repair
failed: root_helper umount
/home/tkloczko/rpmbuild/BUILD/btrfs-progs-v5.1.1/tests//test.img
test failed for case 037-freespacetree-repair
make: *** [Makefile:352: test-fsck] Error 1
error: Bad exit status from /var/tmp/rpm-tmp.3DQ01g (%check)

In log line I found:

=3D=3D=3D=3D=3D=3D RUN CHECK root_helper mount -t btrfs -o loop
/home/tkloczko/rpmbuild/BUILD/btrfs-progs-v5.1.1/tests//test.img
/home/tkloczko/rpmbuild/BUILD/btrfs-progs-v5.1.1/tests//mnt
=3D=3D=3D=3D=3D=3D RUN CHECK root_helper fallocate -l 50m
/home/tkloczko/rpmbuild/BUILD/btrfs-progs-v5.1.1/tests//mnt/file
=3D=3D=3D=3D=3D=3D RUN CHECK root_helper umount
/home/tkloczko/rpmbuild/BUILD/btrfs-progs-v5.1.1/tests//test.img
umount: /home/tkloczko/rpmbuild/BUILD/btrfs-progs-v5.1.1/tests/mnt:
target is busy.
failed: root_helper umount
/home/tkloczko/rpmbuild/BUILD/btrfs-progs-v5.1.1/tests//test.img

After test suite fails I'm able to umount it manually.

[tkloczko@domek tests]$ sudo umount
/home/tkloczko/rpmbuild/BUILD/btrfs-progs-v5.1.1/tests//test.img
[tkloczko@domek tests]$

So looks like during umount still something is holding umount.

kloczek
--=20
Tomasz K=C5=82oczko | LinkedIn: http://lnkd.in/FXPWxH
