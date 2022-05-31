Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EDC538975
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 May 2022 03:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239853AbiEaBMb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 May 2022 21:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243067AbiEaBMb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 May 2022 21:12:31 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FFB27CFA
        for <linux-btrfs@vger.kernel.org>; Mon, 30 May 2022 18:12:27 -0700 (PDT)
Received: from [76.132.34.178] (port=59098 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nvpiT-0007di-M7 by authid <merlins.org> with srv_auth_plain; Mon, 30 May 2022 18:12:24 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nvqQq-007K8B-Mh; Mon, 30 May 2022 18:12:24 -0700
Date:   Mon, 30 May 2022 18:12:24 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220531011224.GA1745079@merlins.org>
References: <20220529180510.GG24951@merlins.org>
 <CAEzrpqfqD8jkznVQR1SL-YpF0ALx7Pbg+ptz7dVgRecOXeDtPg@mail.gmail.com>
 <20220529194235.GH24951@merlins.org>
 <CAEzrpqfd2jPWxUayfqyYRDN25-etc4_jgzcHmZ3LhGkb4e7Tsw@mail.gmail.com>
 <20220529200415.GI24951@merlins.org>
 <CAEzrpqdpvnbzaH1gxWnvWLMWEKtOAdYsH25mBWhkF-urf7Zw3g@mail.gmail.com>
 <20220530003701.GJ24951@merlins.org>
 <CAEzrpqcPirk3AOi1vy+N_V3VY49mvUCiwYL4A_0XoT_jxjgOrg@mail.gmail.com>
 <20220530191834.GK24951@merlins.org>
 <CAEzrpqdRV8nYFshj85Cahj4VMQ+F0n6WOQ6Y8g7=Kq7X_1xMgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdRV8nYFshj85Cahj4VMQ+F0n6WOQ6Y8g7=Kq7X_1xMgw@mail.gmail.com>
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

On Mon, May 30, 2022 at 04:53:13PM -0400, Josef Bacik wrote:
> On Mon, May 30, 2022 at 3:18 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Sun, May 29, 2022 at 09:14:23PM -0400, Josef Bacik wrote:
> > > Ah ok that makes sense, fixed it, sorry about that.  Thanks,
> >
> > Same?
> 
> Bah my bad, we fail earlier than I realized, should work now.  Thanks,

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
WARNING: cannot read chunk root, continue anyway
none of our backups was sufficient, scanning for a root
scanning, best has 0 found 1 bad
ret is 0 offset 20971520 len 8388608
ret is -2 offset 20971520 len 8388608
checking block 22495232 generation 1572124 fs info generation 2582703
trying bytenr 22495232 got 1 blocks 0 bad
checking block 22462464 generation 1479229 fs info generation 2582703
trying bytenr 22462464 got 1 blocks 0 bad
checking block 22528000 generation 1572115 fs info generation 2582703
trying bytenr 22528000 got 1 blocks 0 bad
checking block 22446080 generation 1571791 fs info generation 2582703
trying bytenr 22446080 got 1 blocks 0 bad
checking block 22544384 generation 1556078 fs info generation 2582703
trying bytenr 22544384 got 1 blocks 0 bad
checking block 22511616 generation 1555799 fs info generation 2582703
trying bytenr 22511616 got 1 blocks 0 bad
checking block 22577152 generation 1586277 fs info generation 2582703
trying bytenr 22577152 got 1 blocks 0 bad
checking block 22478848 generation 1561557 fs info generation 2582703
trying bytenr 22478848 got 1 blocks 0 bad
checking block 22593536 generation 1590219 fs info generation 2582703
trying bytenr 22593536 got 1 blocks 0 bad
checking block 22609920 generation 1551635 fs info generation 2582703
trying bytenr 22609920 got 1 blocks 0 bad
checking block 22560768 generation 1590217 fs info generation 2582703
trying bytenr 22560768 got 1 blocks 0 bad
No mapping for 15645202989056-15645203005440
Couldn't map the block 15645202989056
Couldn't map the block 15645202989056
No mapping for 15645202907136-15645202923520
Couldn't map the block 15645202907136
Couldn't map the block 15645202907136
No mapping for 15645202989056-15645203005440
Couldn't map the block 15645202989056
Couldn't map the block 15645202989056
No mapping for 15645202989056-15645203005440
Couldn't map the block 15645202989056
Couldn't map the block 15645202989056
No mapping for 15645202907136-15645202923520
Couldn't map the block 15645202907136
Couldn't map the block 15645202907136
none of our backups was sufficient, scanning for a root
scanning, best has 0 found 1 bad
ERROR: Couldn't find a valid root block for 1, we're going to clear it and hope for the best
Tree recover failed

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
