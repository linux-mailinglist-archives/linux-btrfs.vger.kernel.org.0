Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04AF6A63AD
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Mar 2023 00:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjB1XJB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Feb 2023 18:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjB1XJA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Feb 2023 18:09:00 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4048A279
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Feb 2023 15:08:56 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 55F1D21A81;
        Tue, 28 Feb 2023 23:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677625735;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/MyhtfNP+YQSAkyYyByyOp8hpuTC81CAVkHfEH8DjOA=;
        b=vbbIrwJOQ2lUGWMaADcfusG/vodeYry0tNzsHsquhvqF5traZe6HdkkLG6uILf6bZt/CHY
        7oBKtiUEa3bjHCLwU8moR/7NBZhHeixvcorrwWM/PI05FyAucqF3ao24toChGnF6ZOgkmH
        LubL5fB90k/OKLjyWISOYsvJXzrHw4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677625735;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/MyhtfNP+YQSAkyYyByyOp8hpuTC81CAVkHfEH8DjOA=;
        b=VvIkyBZZkuDj1fV0L17vGoX+XLw+ICWdgnQYI1EbYR78hW54hG5GkAXxRhOSelH3Ezay2Y
        MRRGeBBXWISpOvCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2683813440;
        Tue, 28 Feb 2023 23:08:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id W1k+CIeJ/mOTMQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 28 Feb 2023 23:08:55 +0000
Date:   Wed, 1 Mar 2023 00:02:55 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: Btrfs progs release 6.2
Message-ID: <20230228230255.GR10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230228192335.12451-1-dsterba@suse.com>
 <CAEg-Je8FNefaKjYFeqw2Gh-TXSjVWbgczYtL3qpgJWQj3pJjCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAEg-Je8FNefaKjYFeqw2Gh-TXSjVWbgczYtL3qpgJWQj3pJjCw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 28, 2023 at 05:46:10PM -0500, Neal Gompa wrote:
> On Tue, Feb 28, 2023 at 3:07=E2=80=AFPM David Sterba <dsterba@suse.com> w=
rote:
> >
> > Hi,
> >
> > btrfs-progs version 6.2 have been released.
> >
> > Changelog:
> >    * receive: fix a corruption when decompressing zstd extents
> >    * subvol sync: print total number and deletion progress
> >    * accelerated hash algorithm implementations in fallback mode on x86=
_64
> >    * fi mkswapfile: new option --uuid
> >    * new global option --log=3Dlevel to set the verbosity level directly
> >    * other:
> >       * experimental: update checksum conversion (not usable yet)
> >       * build actually requires -std=3Dgnu11
> >       * refactor help option formatting, auto wrap long lines
> >
> > Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-pr=
ogs/
> > Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
>=20
> This release does not compile on Fedora Rawhide.
>=20
> With the current btrfs-progs spec file in Fedora bumped to 6.2, I get
> this error:
>=20
> >     [LD]     btrfstune
> > gcc -o btrfstune tune/main.o tune/seeding.o tune/change-uuid.o tune/cha=
nge-metadata-uuid.o tune/convert-bgt.o tune/change-csum.o kernel-lib/list_s=
ort.o kernel-lib/raid56.o kernel-lib/rbtree.o kernel-lib/tables.o kernel-sh=
ared/backref.o kernel-shared/ctree.o kernel-shared/delayed-ref.o kernel-sha=
red/dir-item.o kernel-shared/disk-io.o kernel-shared/extent-tree.o kernel-s=
hared/extent_io.o kernel-shared/file-item.o kernel-shared/file.o kernel-sha=
red/free-space-cache.o kernel-shared/free-space-tree.o kernel-shared/inode-=
item.o kernel-shared/inode.o kernel-shared/print-tree.o kernel-shared/root-=
tree.o kernel-shared/transaction.o kernel-shared/ulist.o kernel-shared/uuid=
-tree.o kernel-shared/volumes.o kernel-shared/zoned.o common/cpu-utils.o co=
mmon/device-scan.o common/device-utils.o common/extent-cache.o common/files=
ystem-utils.o common/format-output.o common/fsfeatures.o common/help.o comm=
on/messages.o common/open-utils.o common/parse-utils.o common/path-utils.o =
common/rbtree-utils.o common/send-stream.o common/send-utils.o common/strin=
g-table.o common/string-utils.o common/task-utils.o common/units.o common/u=
tils.o check/qgroup-verify.o check/repair.o cmds/receive-dump.o crypto/crc3=
2c.o crypto/hash.o crypto/xxhash.o libbtrfsutil/stubs.o libbtrfsutil/subvol=
ume.o libbtrfsutil.a -Wl,-z,relro -Wl,--as-needed  -Wl,-z,now -specs=3D/usr=
/lib/rpm/redhat/redhat-hardened-ld -specs=3D/usr/lib/rpm/redhat/redhat-anno=
bin-cc1  -Wl,--build-id=3Dsha1 -specs=3D/usr/lib/rpm/redhat/redhat-package-=
notes  -rdynamic -L.   -luuid -lblkid -ludev -L. -pthread -lgcrypt
> > /usr/bin/ld: /tmp/ccPRdR5s.ltrans5.ltrans.o: in function `hash_init_acc=
el':
> > /builddir/build/BUILD/btrfs-progs-v6.2/crypto/hash.c:26: undefined refe=
rence to `blake2_init_accel'
> > /usr/bin/ld: /builddir/build/BUILD/btrfs-progs-v6.2/crypto/hash.c:27: u=
ndefined reference to `sha256_init_accel'
> > /usr/bin/ld: /tmp/ccPRdR5s.ltrans5.ltrans.o: in function `hash_init_bla=
ke2':
> > /builddir/build/BUILD/btrfs-progs-v6.2/crypto/hash.c:37: undefined refe=
rence to `blake2_init_accel'
> > /usr/bin/ld: /tmp/ccPRdR5s.ltrans5.ltrans.o: in function `hash_init_sha=
256':
> > /builddir/build/BUILD/btrfs-progs-v6.2/crypto/hash.c:42: undefined refe=
rence to `sha256_init_accel'
> > collect2: error: ld returned 1 exit status
> > make: *** [Makefile:673: btrfstune] Error 1

I've been chasing this error on various build target and compiler
combinations. What's the gcc version and architecture?
