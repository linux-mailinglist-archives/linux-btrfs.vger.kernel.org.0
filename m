Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34D0547C2B
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Jun 2022 23:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235681AbiFLVOV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Jun 2022 17:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236156AbiFLVOT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Jun 2022 17:14:19 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0D2C6F
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Jun 2022 14:14:18 -0700 (PDT)
Received: from [172.58.17.232] (port=38834 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1o0UC9-0006DQ-Dn by authid <merlins.org> with srv_auth_plain; Sun, 12 Jun 2022 14:14:16 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1o0UuU-00AliX-I1; Sun, 12 Jun 2022 14:14:14 -0700
Date:   Sun, 12 Jun 2022 14:14:14 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220612211414.GB1843303@merlins.org>
References: <20220609030128.GJ22722@merlins.org>
 <CAEzrpqfy-sf_xGMohK1EVgtP58tLTso6e7s9iyd3t5XnM3zjCg@mail.gmail.com>
 <20220609211511.GW1745079@merlins.org>
 <CAEzrpqfhUMDjkaJaa4ZugSuKOWpLyTVJ8nLu9nep5n_qzo-PiA@mail.gmail.com>
 <20220610191156.GB1664812@merlins.org>
 <CAEzrpqfEj3c5wodYzibBXg34NxtXmQCB60=MtD+Nic2PN8i5bQ@mail.gmail.com>
 <20220611001404.GM22722@merlins.org>
 <CAEzrpqda3=rDV8eLPsSDHbvmbyTnceecNkQUNA6mfOMmik=xDw@mail.gmail.com>
 <20220612173722.GA1843303@merlins.org>
 <CAEzrpqdiOaoidWBtmbxemttKBiBwC-V6QfMint8us8-=rqpVWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdiOaoidWBtmbxemttKBiBwC-V6QfMint8us8-=rqpVWw@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 172.58.17.232
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 12, 2022 at 04:06:33PM -0400, Josef Bacik wrote:
> > gargamel:/var/local/src/btrfs-progs-josefbacik# ./mkfs.btrfs -m dup -L dshelf1 /dev/mapper/dshelf1n
> > btrfs-progs v5.16.2
> > See http://btrfs.wiki.kernel.org for more information.
> >
> > NOTE: several default settings have changed in version 5.15, please make sure
> >       this does not affect your deployments:
> >       - DUP for metadata (-m dup)
> >       - enabled no-holes (-O no-holes)
> >       - enabled free-space-tree (-R free-space-tree)
> >
> > Label:              dshelf1
> > UUID:               ee91f407-39cb-41ef-bd7b-89eee4504ad5
> > Node size:          16384
> > Sector size:        4096
> > Filesystem size:    43.66TiB
> > Block group profiles:
> >   Data:             single            8.00MiB
> >   Metadata:         DUP               1.00GiB
> >   System:           DUP               8.00MiB
> > SSD detected:       no
> > Zoned device:       no
> > Incompat features:  extref, skinny-metadata, no-holes
> > Runtime features:   free-space-tree
> > Checksum:           crc32c
> > Number of devices:  1
> > Devices:
> >    ID        SIZE  PATH
> >     1    43.66TiB  /dev/mapper/dshelf1n
> >
> > Does this look ok?
> 
> Yup this is everything I want to see right now.  Here's hoping the new
> setup lasts more than a couple of years between catastrophes.  Thanks,

Thanks for confirming that the mkfs options look optimal.

I'm making 3 changes
1) no more bcache
2) raid5 write hole protection in mdadm (didn't have it before)
3) I'll make damn sure write caching is off on all the drives

Between those 3, it should be *much* safer, even if it will be slower
too.
Your work on fixing the FS is not for naught though, getting back a
damaged filesystem in some mountable state will be a great improvement
for btrfs and put it more on par with ext4 on recoverability.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
