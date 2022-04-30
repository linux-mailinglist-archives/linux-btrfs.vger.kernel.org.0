Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4845160EB
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 May 2022 01:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236427AbiD3XOq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Apr 2022 19:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235666AbiD3XOp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Apr 2022 19:14:45 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F652CE25
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Apr 2022 16:11:21 -0700 (PDT)
Received: from [172.58.37.231] (port=36402 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nkwFB-00070f-37 by authid <merlins.org> with srv_auth_plain; Sat, 30 Apr 2022 16:11:17 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nkwF9-00Cz52-3r; Sat, 30 Apr 2022 16:11:15 -0700
Date:   Sat, 30 Apr 2022 16:11:15 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220430231115.GJ12542@merlins.org>
References: <20220429151653.GF12542@merlins.org>
 <CAEzrpqfjzzQ4KcHPJmwnaGLNO8-gYp_bcO8HtpGdPC7SctacrA@mail.gmail.com>
 <20220429171619.GG12542@merlins.org>
 <CAEzrpqdTzbpUZR-+UV1_fx9p_pq188cQbGOqraHP=2Vpdi89Mw@mail.gmail.com>
 <20220429185839.GZ29107@merlins.org>
 <CAEzrpqdpTXvDCmo-7H6QU1BKXM+fcG6ZdfHzQj0+=+7kcgkuOw@mail.gmail.com>
 <20220430022406.GH12542@merlins.org>
 <CAEzrpqdiYrbG4FDyoR1=HFZ-d12kD6mF-szxE-e+M-9ahKWd8A@mail.gmail.com>
 <20220430130752.GI12542@merlins.org>
 <CAEzrpqc3jBA4gRiLuYWFgs8zu_XrNDZ_JS+d2J_TN2a-sivO=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqc3jBA4gRiLuYWFgs8zu_XrNDZ_JS+d2J_TN2a-sivO=w@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 172.58.37.231
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 30, 2022 at 12:40:46PM -0400, Josef Bacik wrote:
> On Sat, Apr 30, 2022 at 9:07 AM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Fri, Apr 29, 2022 at 11:13:08PM -0400, Josef Bacik wrote:
> > > Hooray we're at the data reloc root.  It should have been cleared tho,
> > > so I've fixed it up to see if it's doing the right thing, it should
> > > clear it this time, if it doesn't let me know.  Thanks,
> >
> > Great
> >
> 
> Ok this is easier, the transaction commit stuff doesn't work quite
> right in progs, I've fixed the code and it should succeed this time.
> Thanks,


ainserting block group 15837217947648
inserting block group 15838291689472
inserting block group 15839365431296
inserting block group 15840439173120
inserting block group 15842586656768
processed 1556480 of 0 possible bytes
processed 1474560 of 0 possible bytes
Recording extents for root 4
processed 1032192 of 1064960 possible bytes
Recording extents for root 5
processed 10960896 of 10977280 possible bytes
Recording extents for root 7
processed 16384 of 16545742848 possible bytes
Recording extents for root 9
processed 16384 of 16384 possible bytes
Recording extents for root 11221
processed 16384 of 255983616 possible bytes
Recording extents for root 11222
processed 49479680 of 49479680 possible bytes
Recording extents for root 11223
processed 1635319808 of 1635549184 possible bytes
Recording extents for root 11224
processed 75792384 of 75792384 possible bytes
Recording extents for root 159785
processed 108855296 of 108855296 possible bytes
Recording extents for root 159787
processed 49152 of 49479680 possible bytes
Recording extents for root 160494
processed 1179648 of 109035520 possible bytes
Recording extents for root 160496
processed 49152 of 49479680 possible bytes
Recording extents for root 161197
processed 147456 of 109019136 possible bytes
Recording extents for root 161199
processed 49152 of 49479680 possible bytes
Recording extents for root 162628
processed 49152 of 49479680 possible bytes
Recording extents for root 162632
processed 2129920 of 109314048 possible bytes
Recording extents for root 162645
processed 49152 of 75792384 possible bytes
Recording extents for root 163298
processed 49152 of 49479680 possible bytes
Recording extents for root 163302
processed 147456 of 109314048 possible bytes
Recording extents for root 163303
processed 81920 of 75792384 possible bytes
Recording extents for root 163316
processed 49152 of 109314048 possible bytes
Recording extents for root 163318
processed 16384 of 49479680 possible bytes
Recording extents for root 163916
processed 49152 of 49479680 possible bytes
Recording extents for root 163920
processed 81920 of 109314048 possible bytes
Recording extents for root 163921
processed 49152 of 75792384 possible bytes
Recording extents for root 164620
processed 49152 of 49479680 possible bytes
Recording extents for root 164624
processed 491520 of 109445120 possible bytes
Recording extents for root 164633
processed 49152 of 75792384 possible bytes
Recording extents for root 165098
processed 212992 of 109445120 possible bytes
Recording extents for root 165100
processed 16384 of 49479680 possible bytes
Recording extents for root 165198
processed 49152 of 109445120 possible bytes
Recording extents for root 165200
processed 16384 of 49479680 possible bytes
Recording extents for root 165294
processed 16384 of 49479680 possible bytes
Recording extents for root 165298
processed 81920 of 109445120 possible bytes
Recording extents for root 165299
processed 16384 of 75792384 possible bytes
Recording extents for root 18446744073709551607
processed 16384 of 16384 possible bytes
ERROR: commit_root already set when starting transaction
extent buffer leak: start 13576823832576 len 16384
Init extent tree failed
[Inferior 1 (process 28313) exited with code 0377]

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
