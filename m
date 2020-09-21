Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8A1272122
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 12:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgIUKae convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 21 Sep 2020 06:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgIUKae (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 06:30:34 -0400
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7DAC061755
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Sep 2020 03:30:34 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id DC84E1549C7;
        Mon, 21 Sep 2020 12:30:30 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: external harddisk: bogus corrupt leaf error?
Date:   Mon, 21 Sep 2020 12:30:29 +0200
Message-ID: <4131924.Vjtf9Mc2VK@merkaba>
In-Reply-To: <111a2551-98c1-61f4-8981-3f7de4b9084a@gmx.com>
References: <1978673.BsW9qxMyvF@merkaba> <111a2551-98c1-61f4-8981-3f7de4b9084a@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu Wenruo - 21.09.20, 12:09:01 CEST:
> On 2020/9/21 下午5:29, Martin Steigerwald wrote:
> > Hi!
> > 
> > I have an external 500 GB harddisk with BTRFS. On mounting it the
> > kernel (5.9-rc5, vanilla, self compiled) reports:
> > 
> > [282409.344208] BTRFS info (device sdc1): enabling auto defrag
> > [282409.344222] BTRFS info (device sdc1): use zstd compression,
> > level 3 [282409.344225] BTRFS info (device sdc1): disk space
> > caching is enabled [282409.465837] BTRFS critical (device sdc1):
> > corrupt leaf: root=1 block=906756096 slot=204, invalid root item
> > size, have 239 expect 439
> This one can only be detected by kernel, not btrfs check yet.
> 
> Recently kernel has much more strict checks than btrfs-check,
> sometimes it can be too strict, as some error is not really going to
> cause problems, but just against on-disk format.
> 
> And this is the case.
> 
> In theory, you can mount the fs with older kernel, any kernel older
> than commit 259ee7754b67 ("btrfs: tree-checker: Add ROOT_ITEM check")
> should still be able to mount the fs.

Oh, I can still mount the filesystem just fine, so no problem there.

> For workaround, you can dump the tree block 906756096, locate the slot
> 204, see what tree root it is.

While mounted, as the scrub is still running:

btrfs-progs v5.7 
leaf 906756096 items 205 free space 2555 generation 12080 owner ROOT_TREE
leaf 906756096 flags 0x1(WRITTEN) backref revision 1
fs uuid […]

[…]

        item 204 key (DATA_RELOC_TREE ROOT_ITEM 0) itemoff 7680 itemsize 239
                generation 4 root_dirid 256 bytenr 29442048 level 0 refs 1
                lastsnap 0 byte_limit 0 bytes_used 16384 flags 0x0(none)
                drop key (0 UNKNOWN.0 0) level 0

Now what does that tell me?

> If it's a subvolume/snapshot, deleting it should solve the problem,
> even for the latest kernel.

The device has just one subvolume except root subvolume:

% btrfs subvol list /mnt/amazon 
ID 258 gen 12560 top level 5 path daten

> For the root cause, it should be some older kernel creating the wrong
> root item size.
> I can't find the commit but it should be pretty old, as after v5.4 we
> have mandatory write time tree checks, which will reject such write
> directly.

So eventually I would have to backup the disk and create FS from scratch
to get rid of the error? Or can I, even if its no subvolume involved, find the
item affected, copy it somewhere else and then write it to the disk again?

> Thanks,
> Qu

Somehow I am reminded of mister Q in Star Trek… :)

Thank you!
Martin
 
> > Note: It has used LZO compression before, but I switched mount
> > option to zstd meanwhile.
> > 
> > However, btrfs-progds 5.7 gives:
> > 
> > % btrfs check /dev/sdc1
> > Opening filesystem to check...
> > Checking filesystem on /dev/sdc1
> > UUID: […]
> > [1/7] checking root items
> > [2/7] checking extents
> > [3/7] checking free space cache
> > [4/7] checking fs roots
> > [5/7] checking only csums items (without verifying data)
> > [6/7] checking root refs
> > [7/7] checking quota groups skipped (not enabled on this FS)
> > found 249031409664 bytes used, no error found
> > total csum bytes: 242738928
> > total tree bytes: 352387072
> > total fs tree bytes: 67747840
> > total extent tree bytes: 14565376
> > btree space waste bytes: 37691414
> > file data blocks allocated: 1067158315008
> > 
> >  referenced 247077785600
> > 
> > Is this kernel message in error? Or does 'btrfs check' not check for
> > this error yet?
> > 
> > Here some more information:
[…]
-- 
Martin


