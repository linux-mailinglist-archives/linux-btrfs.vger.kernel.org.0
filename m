Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3654515D3D
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Apr 2022 15:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbiD3NLU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Apr 2022 09:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiD3NLT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Apr 2022 09:11:19 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2588756208
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Apr 2022 06:07:54 -0700 (PDT)
Received: from [172.58.39.153] (port=26839 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nkmpF-0007Hj-FZ by authid <merlins.org> with srv_auth_plain; Sat, 30 Apr 2022 06:07:53 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nkmpE-00CgaD-UL; Sat, 30 Apr 2022 06:07:52 -0700
Date:   Sat, 30 Apr 2022 06:07:52 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220430130752.GI12542@merlins.org>
References: <20220429040335.GE12542@merlins.org>
 <CAEzrpqewAfxi9hK+vwK+Df3iziXBZZEmXhzgJdJDqTj-JXvFQw@mail.gmail.com>
 <20220429151653.GF12542@merlins.org>
 <CAEzrpqfjzzQ4KcHPJmwnaGLNO8-gYp_bcO8HtpGdPC7SctacrA@mail.gmail.com>
 <20220429171619.GG12542@merlins.org>
 <CAEzrpqdTzbpUZR-+UV1_fx9p_pq188cQbGOqraHP=2Vpdi89Mw@mail.gmail.com>
 <20220429185839.GZ29107@merlins.org>
 <CAEzrpqdpTXvDCmo-7H6QU1BKXM+fcG6ZdfHzQj0+=+7kcgkuOw@mail.gmail.com>
 <20220430022406.GH12542@merlins.org>
 <CAEzrpqdiYrbG4FDyoR1=HFZ-d12kD6mF-szxE-e+M-9ahKWd8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEzrpqdiYrbG4FDyoR1=HFZ-d12kD6mF-szxE-e+M-9ahKWd8A@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-Broken-Reverse-DNS: no host name for IP address 172.58.39.153
X-SA-Exim-Connect-IP: 172.58.39.153
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 29, 2022 at 11:13:08PM -0400, Josef Bacik wrote:
> Hooray we're at the data reloc root.  It should have been cleared tho,
> so I've fixed it up to see if it's doing the right thing, it should
> clear it this time, if it doesn't let me know.  Thanks,

Great

FYI:
cmds/rescue-init-extent-tree.c:417:64: warning: passing argument 1 of ‘PTR_ERR’ makes pointer from integer without a cast [-Wint-conversion]
  417 |   fprintf(stderr, "Error reading data reloc tree %d\n",PTR_ERR(ret));
      |                                                                ^~~
      |                                                                |
      |                                                                int
In file included from cmds/rescue-init-extent-tree.c:3:
./kerncompat.h:270:40: note: expected ‘const void *’ but argument is of type ‘int’
  270 | static inline long PTR_ERR(const void *ptr)
      |                            ~~~~~~~~~~~~^~~
cmds/rescue-init-extent-tree.c:417:51: warning: format ‘%d’ expects argument of type ‘int’, but argument 3 has type ‘long int’ [-Wformat=]
  417 |   fprintf(stderr, "Error reading data reloc tree %d\n",PTR_ERR(ret));
      |                                                  ~^    ~~~~~~~~~~~~
      |                                                   |    |
      |                                                   int  long int
      |                                                  %ld

(..)
inserting block group 15836144205824
inserting block group 15837217947648
inserting block group 15838291689472
inserting block group 15839365431296
inserting block group 15840439173120
inserting block group 15842586656768
DID THE DATA RELOC TREE INIT?!
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
extent buffer leak: start 13576823652352 len 16384
Init extent tree failed
[Inferior 1 (process 9144) exited with code 0377]
(gdb) 

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
