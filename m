Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798505159CA
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Apr 2022 04:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377085AbiD3C12 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 22:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240220AbiD3C11 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 22:27:27 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAD6D17F7
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 19:24:07 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:58316 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nkcmE-0006zn-Ur by authid <merlins.org> with srv_auth_plain; Fri, 29 Apr 2022 19:24:06 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nkcmE-00BfGx-JO; Fri, 29 Apr 2022 19:24:06 -0700
Date:   Fri, 29 Apr 2022 19:24:06 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220430022406.GH12542@merlins.org>
References: <20220429013409.GD12542@merlins.org>
 <CAEzrpqfF7xfLxSBpJGfu2uP5iUzBhirg=wRfs108rLyuiUSW1Q@mail.gmail.com>
 <20220429040335.GE12542@merlins.org>
 <CAEzrpqewAfxi9hK+vwK+Df3iziXBZZEmXhzgJdJDqTj-JXvFQw@mail.gmail.com>
 <20220429151653.GF12542@merlins.org>
 <CAEzrpqfjzzQ4KcHPJmwnaGLNO8-gYp_bcO8HtpGdPC7SctacrA@mail.gmail.com>
 <20220429171619.GG12542@merlins.org>
 <CAEzrpqdTzbpUZR-+UV1_fx9p_pq188cQbGOqraHP=2Vpdi89Mw@mail.gmail.com>
 <20220429185839.GZ29107@merlins.org>
 <CAEzrpqdpTXvDCmo-7H6QU1BKXM+fcG6ZdfHzQj0+=+7kcgkuOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdpTXvDCmo-7H6QU1BKXM+fcG6ZdfHzQj0+=+7kcgkuOw@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 24.5.124.255
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 29, 2022 at 03:40:53PM -0400, Josef Bacik wrote:
> 
> I'm afraid it'll be longer/less safe for me to work out the kinks than
> to continue manually removing stuff.  If you have to do it say 10 more
> times let me know and I can try and rig up something that can dump
> root ids that you can just feed into btrfs-corrupt-block to clear
> everything out at once.  Thanks,

Took a while:
./btrfs-corrupt-block -d "76300,108,0" -r 163302 /dev/mapper/dshelf1
./btrfs-corrupt-block -d "76300,108,0" -r 163303 /dev/mapper/dshelf1
./btrfs-corrupt-block -d "76300,108,0" -r 163316 /dev/mapper/dshelf1
./btrfs-corrupt-block -d "76300,108,0" -r 163920 /dev/mapper/dshelf1
./btrfs-corrupt-block -d "76300,108,0" -r 164624 /dev/mapper/dshelf1
./btrfs-corrupt-block -d "76300,108,0" -r 165098 /dev/mapper/dshelf1
./btrfs-corrupt-block -d "76300,108,0" -r 165198 /dev/mapper/dshelf1
./btrfs-corrupt-block -d "76300,108,0" -r 165298 /dev/mapper/dshelf1
./btrfs-corrupt-block -d "76300,108,0" -r 16384 /dev/mapper/dshelf1



Now I'm stuck here:

processed 16384 of 75792384 possible bytes
Recording extents for root 18446744073709551607
processed 16384 of 16384 possible bytes
ERROR: commit_root already set when starting transaction
extent buffer leak: start 13576823734272 len 16384
Init extent tree failed
[Inferior 1 (process 31377) exited with code 0377]

./btrfs-corrupt-block -d "76300,108,0" -r 18446744073709551607 /dev/mapper/dshelf1

Recording extents for root 165299
processed 16384 of 75792384 possible bytes
Recording extents for root 18446744073709551607
processed 16384 of 16384 possible bytes
ERROR: commit_root already set when starting transaction
extent buffer leak: start 13576823734272 len 16384
Init extent tree failed

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
