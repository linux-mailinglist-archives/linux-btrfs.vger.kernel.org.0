Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18718536F3D
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 May 2022 05:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiE2Dvt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 May 2022 23:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiE2Dvr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 May 2022 23:51:47 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149B912606
        for <linux-btrfs@vger.kernel.org>; Sat, 28 May 2022 20:51:42 -0700 (PDT)
Received: from [76.132.34.178] (port=59036 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nv9FV-00018j-5p by authid <merlins.org> with srv_auth_plain; Sat, 28 May 2022 20:51:40 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nv9xr-003d1a-B7; Sat, 28 May 2022 20:51:39 -0700
Date:   Sat, 28 May 2022 20:51:39 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220529035139.GE24951@merlins.org>
References: <20220526191512.GE28329@merlins.org>
 <CAEzrpqetTskf-UtyfXHBajpJBci4vxdSaBXwDTm5cRs2QtNRkw@mail.gmail.com>
 <20220526213924.GB2414966@merlins.org>
 <20220527011622.GA24951@merlins.org>
 <CAEzrpqdbuQGwwuCfYyVdiDtGDsPb=3FWmKrTEA5Xukk1ex514g@mail.gmail.com>
 <20220527232604.GA22722@merlins.org>
 <CAEzrpqeJyupr02nUJkBBVCah46FN+znVczm-RtfBFauvJW9O6w@mail.gmail.com>
 <CAEzrpqfAYRUYttOAMmdth4mfi4e7MTM++s5WOQ+KAzg2Kv0Nsw@mail.gmail.com>
 <20220528225601.GD24951@merlins.org>
 <CAEzrpqcG+9evRPKixVwGnAS_k2tb7o16jQgORtm1cw7hW_KsAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqcG+9evRPKixVwGnAS_k2tb7o16jQgORtm1cw7hW_KsAw@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-Broken-Reverse-DNS: no host name for IP address 76.132.34.178
X-SA-Exim-Connect-IP: 76.132.34.178
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 28, 2022 at 09:00:00PM -0400, Josef Bacik wrote:
> On Sat, May 28, 2022 at 6:56 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Sat, May 28, 2022 at 04:08:25PM -0400, Josef Bacik wrote:
> > > Sorry my ability to think isn't doing so great right now.  I've wired
> > > up the detection stuff, but it won't actually fix anything yet.  I
> > > want to make sure I've got detection part right before I go messing
> > > with the file system.  If you can pull and build and then run
> > >
> > > btrfs rescue recover-chunks <device>
> > >
> > > and capture the output that would be great.  Hopefully this shows the
> > > missing block groups and I can just copy them into place.  Thanks,
> >
> > gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue recover-chunks /dev/mapper/dshelf1
> > checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
> > checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
> > checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
> > Csum didn't match
> > ERROR: cannot read chunk root
> > WTF???
> > ERROR: open ctree failed, try btrfs rescue tree-recover
> > Recover chunks tree failed
> > gargamel:/var/local/src/btrfs-progs-josefbacik#
> >
> > So, should I do what it says?
> 
> Oh yeah duh sorry, I was adding it to tree-recover but decided it was
> a bad place for it.  Go ahead and run tree-recover and then do the
> recover-chunks.  Thanks,

:(

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
ERROR: cannot read chunk root
WTF???
ERROR: open ctree failed
Tree recover failed

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue recover-chunks /dev/mapper/dshelf1
checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
Csum didn't match
ERROR: cannot read chunk root
WTF???
ERROR: open ctree failed, try btrfs rescue tree-recover
Recover chunks tree failed
gargamel:/var/local/src/btrfs-progs-josefbacik# 

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
