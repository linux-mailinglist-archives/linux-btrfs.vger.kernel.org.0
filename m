Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE806A62C5
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Feb 2023 23:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjB1Wqu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Feb 2023 17:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjB1Wqu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Feb 2023 17:46:50 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97B732504
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Feb 2023 14:46:48 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id cy6so46547712edb.5
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Feb 2023 14:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3Np4Uxy82q5UtmpmAKLbFHeePlKVGu4IaEYZ4J/4B8=;
        b=Ta6sBXt4gwt/FjTA6dX+pVeg03foOWKw5XnyK/ETmP6YsBSgw7pD+mFSK0iPgKBzts
         2olYEzwAXjpXFdw7//CQeDrOogzcvvIIPr5YvJVRRI7ZSxDI4qjuLFpfL5bR0cmcLG8P
         3AwusmZHm8ZNo9upAewix1sgmgp5WJeTZ+VyWWDqpv64CWusb0lvhMzu9kTCItiFO5wj
         btqlFSgO2ZLmI12td43CEy8s6RAUvVfXkGVl19yPhIUhBDB7QOAXcL/vKNRVQ6KBJ/od
         pBBLH8QWODF18KWioxuu1cLrhpiWuL/2f16INT0ecsWq4hto7FVlnEyItqtJorLqT+4W
         YANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3Np4Uxy82q5UtmpmAKLbFHeePlKVGu4IaEYZ4J/4B8=;
        b=pUTMAy652WMYMcEEr2/KjQBmkGJ3/YrwJaROUun7gSbywjOjJZzG0tlMraLnceyjJ7
         h49zryJ11w2cqhIHuY5dqmgua4LuF2DvJduyeoXzbc37bi7Uzw5/QnnS5b1pBEoJBDPL
         JGeeZ4sKiWVx1H7ENi7aWPbtVoeVq/kmoD5V4FvjMqLPjti7a1i6eXnmWTp0v5gClf0I
         MG8xOtRpq5PWj6MxwASP1cKer72brpLcd5vkXS9fIBpJ64TOC8omuadzkfIpMhhp3ANA
         qHLdx7LP7zX7FD5V9q8x6Xz7ZiohwAyNbxSWGvEXQe2jmrDSEamUbMDSq+LNzNg95But
         3crQ==
X-Gm-Message-State: AO0yUKWFZGm06/aK8gR5IJ6Ur0H5ZjZAeJibZqr0Y+2shPOeWMgdr7nw
        ty7oUg5SfWV+4DXn/+yThOGeFJEoNhJ5Io+r45Of3HoXwVGiUifO
X-Google-Smtp-Source: AK7set+Lib9ZaOIQ9YVFtrcz6VUm2x5vgGCgUw8Eva/tji/o2T65cCWH6J6s9sTOQkflgzcoNzq+Es8ZrDYgEk3evME=
X-Received: by 2002:a17:906:3d61:b0:8f1:4c6a:e77 with SMTP id
 r1-20020a1709063d6100b008f14c6a0e77mr2155846ejf.12.1677624407049; Tue, 28 Feb
 2023 14:46:47 -0800 (PST)
MIME-Version: 1.0
References: <20230228192335.12451-1-dsterba@suse.com>
In-Reply-To: <20230228192335.12451-1-dsterba@suse.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Tue, 28 Feb 2023 17:46:10 -0500
Message-ID: <CAEg-Je8FNefaKjYFeqw2Gh-TXSjVWbgczYtL3qpgJWQj3pJjCw@mail.gmail.com>
Subject: Re: Btrfs progs release 6.2
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 28, 2023 at 3:07=E2=80=AFPM David Sterba <dsterba@suse.com> wro=
te:
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
>
> Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-prog=
s/
> Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git

This release does not compile on Fedora Rawhide.

With the current btrfs-progs spec file in Fedora bumped to 6.2, I get
this error:

>     [LD]     btrfstune
> gcc -o btrfstune tune/main.o tune/seeding.o tune/change-uuid.o tune/chang=
e-metadata-uuid.o tune/convert-bgt.o tune/change-csum.o kernel-lib/list_sor=
t.o kernel-lib/raid56.o kernel-lib/rbtree.o kernel-lib/tables.o kernel-shar=
ed/backref.o kernel-shared/ctree.o kernel-shared/delayed-ref.o kernel-share=
d/dir-item.o kernel-shared/disk-io.o kernel-shared/extent-tree.o kernel-sha=
red/extent_io.o kernel-shared/file-item.o kernel-shared/file.o kernel-share=
d/free-space-cache.o kernel-shared/free-space-tree.o kernel-shared/inode-it=
em.o kernel-shared/inode.o kernel-shared/print-tree.o kernel-shared/root-tr=
ee.o kernel-shared/transaction.o kernel-shared/ulist.o kernel-shared/uuid-t=
ree.o kernel-shared/volumes.o kernel-shared/zoned.o common/cpu-utils.o comm=
on/device-scan.o common/device-utils.o common/extent-cache.o common/filesys=
tem-utils.o common/format-output.o common/fsfeatures.o common/help.o common=
/messages.o common/open-utils.o common/parse-utils.o common/path-utils.o co=
mmon/rbtree-utils.o common/send-stream.o common/send-utils.o common/string-=
table.o common/string-utils.o common/task-utils.o common/units.o common/uti=
ls.o check/qgroup-verify.o check/repair.o cmds/receive-dump.o crypto/crc32c=
.o crypto/hash.o crypto/xxhash.o libbtrfsutil/stubs.o libbtrfsutil/subvolum=
e.o libbtrfsutil.a -Wl,-z,relro -Wl,--as-needed  -Wl,-z,now -specs=3D/usr/l=
ib/rpm/redhat/redhat-hardened-ld -specs=3D/usr/lib/rpm/redhat/redhat-annobi=
n-cc1  -Wl,--build-id=3Dsha1 -specs=3D/usr/lib/rpm/redhat/redhat-package-no=
tes  -rdynamic -L.   -luuid -lblkid -ludev -L. -pthread -lgcrypt
> /usr/bin/ld: /tmp/ccPRdR5s.ltrans5.ltrans.o: in function `hash_init_accel=
':
> /builddir/build/BUILD/btrfs-progs-v6.2/crypto/hash.c:26: undefined refere=
nce to `blake2_init_accel'
> /usr/bin/ld: /builddir/build/BUILD/btrfs-progs-v6.2/crypto/hash.c:27: und=
efined reference to `sha256_init_accel'
> /usr/bin/ld: /tmp/ccPRdR5s.ltrans5.ltrans.o: in function `hash_init_blake=
2':
> /builddir/build/BUILD/btrfs-progs-v6.2/crypto/hash.c:37: undefined refere=
nce to `blake2_init_accel'
> /usr/bin/ld: /tmp/ccPRdR5s.ltrans5.ltrans.o: in function `hash_init_sha25=
6':
> /builddir/build/BUILD/btrfs-progs-v6.2/crypto/hash.c:42: undefined refere=
nce to `sha256_init_accel'
> collect2: error: ld returned 1 exit status
> make: *** [Makefile:673: btrfstune] Error 1


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
