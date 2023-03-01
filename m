Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0266A65C4
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Mar 2023 03:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjCACwJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Feb 2023 21:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCACwI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Feb 2023 21:52:08 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C1237720
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Feb 2023 18:52:06 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id cy6so48292412edb.5
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Feb 2023 18:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvvnHCLr3VQAQ4tvHomYHYAsgNSb5nRQ1WjJk4J2FiA=;
        b=DIzntp+ToP+uf1ufrEgy3T0t3AtE1BCcpNrqU1AypWnDnDATDcOPIeg73ouS1dIxZc
         iKaVNLHoURIisdd3RUimHvKCk3iuTt+op30hgq9rPqZpZnDAjU9l8dyq4QHxMBCgBaP+
         GTkktwQdtVAhgM2ZkMfID5HnqqjXe1Pnf2JpOXk5mAGgZrATqQqPE31FvXflnonCjWkO
         kR6KkiyTOw0yB9O8Gc+N78MGfPkcSYpXlW3yin/lMtd8A7LizrDTFj8KtbeEvtCdq60u
         SNtFruBjd/0zTzwGTzWNjNMxnc+D7HqpObR005LdO1qmhfCAJfMzdqZuWQhTaR9RwaSl
         rsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvvnHCLr3VQAQ4tvHomYHYAsgNSb5nRQ1WjJk4J2FiA=;
        b=b/nBil/eUwsBuIHyHeU0aqdQAR7ng77vehtX+7rfblH1GfxfweoZr8TYr/80hAts6u
         kX5IO/1eFoE/5QcUAs85M2sRSgEF8hEAQkDi2HaQU9OPqoLGb116uqGb60fCfzjPdsHH
         v6UTX/1MYwedJlLsyfZAkficoT6moTyHYAFFHv2R2A+erEg6mD/Zv6rTXZ4FwXFtt6BJ
         wk0HP1QSWVusZkNSVN2pgxjydVJM4i4N8uIWa4ETzvpfaQzMhaLmcxkiJqPyXpXZE7j1
         LoWEcGiJzF2WRm2HX7RzqOLKsIfySZUXoNH04ZSEMrFQvt4O+qOc6WxKNkzTX5KTzz2N
         tu6g==
X-Gm-Message-State: AO0yUKV8KZSltGmkf0mHF9KALdFH8gBW2p9rwUKV4N9rIMibbXFS8nNE
        673apj0uwDpEn3ltOW9ZyEqFfTY8MU4TC4/Ntqo=
X-Google-Smtp-Source: AK7set+6xHKcp3+JPSF2pcr5KTFE/6LL+hQRf6P4XbbAkMWz8c4Ya3Y+QadQwQXze/s7Eys5eTeCycAAd5hbnlL02xo=
X-Received: by 2002:a17:906:3d61:b0:8f1:4c6a:e77 with SMTP id
 r1-20020a1709063d6100b008f14c6a0e77mr2438555ejf.12.1677639125014; Tue, 28 Feb
 2023 18:52:05 -0800 (PST)
MIME-Version: 1.0
References: <20230228192335.12451-1-dsterba@suse.com> <CAEg-Je8FNefaKjYFeqw2Gh-TXSjVWbgczYtL3qpgJWQj3pJjCw@mail.gmail.com>
 <20230228230255.GR10580@twin.jikos.cz>
In-Reply-To: <20230228230255.GR10580@twin.jikos.cz>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Tue, 28 Feb 2023 21:51:28 -0500
Message-ID: <CAEg-Je9PjMPChDdW0R3UeN1NUNhPudtM_FnzmUG62mgoX2nWNw@mail.gmail.com>
Subject: Re: Btrfs progs release 6.2
To:     dsterba@suse.cz
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
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

On Tue, Feb 28, 2023 at 6:08=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Tue, Feb 28, 2023 at 05:46:10PM -0500, Neal Gompa wrote:
> > On Tue, Feb 28, 2023 at 3:07=E2=80=AFPM David Sterba <dsterba@suse.com>=
 wrote:
> > >
> > > Hi,
> > >
> > > btrfs-progs version 6.2 have been released.
> > >
> > > Changelog:
> > >    * receive: fix a corruption when decompressing zstd extents
> > >    * subvol sync: print total number and deletion progress
> > >    * accelerated hash algorithm implementations in fallback mode on x=
86_64
> > >    * fi mkswapfile: new option --uuid
> > >    * new global option --log=3Dlevel to set the verbosity level direc=
tly
> > >    * other:
> > >       * experimental: update checksum conversion (not usable yet)
> > >       * build actually requires -std=3Dgnu11
> > >       * refactor help option formatting, auto wrap long lines
> > >
> > > Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-=
progs/
> > > Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.=
git
> >
> > This release does not compile on Fedora Rawhide.
> >
> > With the current btrfs-progs spec file in Fedora bumped to 6.2, I get
> > this error:
> >
> > >     [LD]     btrfstune
> > > gcc -o btrfstune tune/main.o tune/seeding.o tune/change-uuid.o tune/c=
hange-metadata-uuid.o tune/convert-bgt.o tune/change-csum.o kernel-lib/list=
_sort.o kernel-lib/raid56.o kernel-lib/rbtree.o kernel-lib/tables.o kernel-=
shared/backref.o kernel-shared/ctree.o kernel-shared/delayed-ref.o kernel-s=
hared/dir-item.o kernel-shared/disk-io.o kernel-shared/extent-tree.o kernel=
-shared/extent_io.o kernel-shared/file-item.o kernel-shared/file.o kernel-s=
hared/free-space-cache.o kernel-shared/free-space-tree.o kernel-shared/inod=
e-item.o kernel-shared/inode.o kernel-shared/print-tree.o kernel-shared/roo=
t-tree.o kernel-shared/transaction.o kernel-shared/ulist.o kernel-shared/uu=
id-tree.o kernel-shared/volumes.o kernel-shared/zoned.o common/cpu-utils.o =
common/device-scan.o common/device-utils.o common/extent-cache.o common/fil=
esystem-utils.o common/format-output.o common/fsfeatures.o common/help.o co=
mmon/messages.o common/open-utils.o common/parse-utils.o common/path-utils.=
o common/rbtree-utils.o common/send-stream.o common/send-utils.o common/str=
ing-table.o common/string-utils.o common/task-utils.o common/units.o common=
/utils.o check/qgroup-verify.o check/repair.o cmds/receive-dump.o crypto/cr=
c32c.o crypto/hash.o crypto/xxhash.o libbtrfsutil/stubs.o libbtrfsutil/subv=
olume.o libbtrfsutil.a -Wl,-z,relro -Wl,--as-needed  -Wl,-z,now -specs=3D/u=
sr/lib/rpm/redhat/redhat-hardened-ld -specs=3D/usr/lib/rpm/redhat/redhat-an=
nobin-cc1  -Wl,--build-id=3Dsha1 -specs=3D/usr/lib/rpm/redhat/redhat-packag=
e-notes  -rdynamic -L.   -luuid -lblkid -ludev -L. -pthread -lgcrypt
> > > /usr/bin/ld: /tmp/ccPRdR5s.ltrans5.ltrans.o: in function `hash_init_a=
ccel':
> > > /builddir/build/BUILD/btrfs-progs-v6.2/crypto/hash.c:26: undefined re=
ference to `blake2_init_accel'
> > > /usr/bin/ld: /builddir/build/BUILD/btrfs-progs-v6.2/crypto/hash.c:27:=
 undefined reference to `sha256_init_accel'
> > > /usr/bin/ld: /tmp/ccPRdR5s.ltrans5.ltrans.o: in function `hash_init_b=
lake2':
> > > /builddir/build/BUILD/btrfs-progs-v6.2/crypto/hash.c:37: undefined re=
ference to `blake2_init_accel'
> > > /usr/bin/ld: /tmp/ccPRdR5s.ltrans5.ltrans.o: in function `hash_init_s=
ha256':
> > > /builddir/build/BUILD/btrfs-progs-v6.2/crypto/hash.c:42: undefined re=
ference to `sha256_init_accel'
> > > collect2: error: ld returned 1 exit status
> > > make: *** [Makefile:673: btrfstune] Error 1
>
> I've been chasing this error on various build target and compiler
> combinations. What's the gcc version and architecture?

GCC 13.0.1 on x86_64. I didn't bother trying other architectures yet.



--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
