Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FAB53725D
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 May 2022 21:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbiE2Tmk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 May 2022 15:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiE2Tmj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 May 2022 15:42:39 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC5884A13
        for <linux-btrfs@vger.kernel.org>; Sun, 29 May 2022 12:42:36 -0700 (PDT)
Received: from [76.132.34.178] (port=59058 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nvO5k-0005Fe-Mw by authid <merlins.org> with srv_auth_plain; Sun, 29 May 2022 12:42:35 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nvOo7-004gPY-OD; Sun, 29 May 2022 12:42:35 -0700
Date:   Sun, 29 May 2022 12:42:35 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220529194235.GH24951@merlins.org>
References: <CAEzrpqeJyupr02nUJkBBVCah46FN+znVczm-RtfBFauvJW9O6w@mail.gmail.com>
 <CAEzrpqfAYRUYttOAMmdth4mfi4e7MTM++s5WOQ+KAzg2Kv0Nsw@mail.gmail.com>
 <20220528225601.GD24951@merlins.org>
 <CAEzrpqcG+9evRPKixVwGnAS_k2tb7o16jQgORtm1cw7hW_KsAw@mail.gmail.com>
 <20220529035139.GE24951@merlins.org>
 <CAEzrpqcKeVNkXa3txx0nyDnKUCp06msmd97d1fBedTzbmR5KcA@mail.gmail.com>
 <20220529153312.GF24951@merlins.org>
 <CAEzrpqdEk-j2bMfBLEdkhHcq1hWLmHv_Nx-0mj1vh0yJgZuCZQ@mail.gmail.com>
 <20220529180510.GG24951@merlins.org>
 <CAEzrpqfqD8jkznVQR1SL-YpF0ALx7Pbg+ptz7dVgRecOXeDtPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqfqD8jkznVQR1SL-YpF0ALx7Pbg+ptz7dVgRecOXeDtPg@mail.gmail.com>
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

On Sun, May 29, 2022 at 02:58:11PM -0400, Josef Bacik wrote:
> > gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
> > WARNING: cannot read chunk root, continue anyway
> > none of our backups was sufficient, scanning for a root
> > ERROR: Couldn't find a valid root block for 3, we're going to clear it and hope for the best
> > Tree recover failed
> 
> Well if anything tree-recover will be rock solid by the end of this.
> Try again please.  Thanks,

Sorry :(

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
WARNING: cannot read chunk root, continue anyway
none of our backups was sufficient, scanning for a root
ERROR: Couldn't find a valid root block for 3, we're going to clear it and hope for the best
Tree recover failed
gargamel:/var/local/src/btrfs-progs-josefbacik# git pull
Already up-to-date.
gargamel:/var/local/src/btrfs-progs-josefbacik#


-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
