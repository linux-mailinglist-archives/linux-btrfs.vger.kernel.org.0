Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6F2535744
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 03:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbiE0BQ2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 May 2022 21:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbiE0BQ1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 May 2022 21:16:27 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A472BF3
        for <linux-btrfs@vger.kernel.org>; Thu, 26 May 2022 18:16:24 -0700 (PDT)
Received: from [76.132.34.178] (port=58988 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nuNs7-0001Aw-Ka by authid <merlins.org> with srv_auth_plain; Thu, 26 May 2022 18:16:22 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nuOaU-0006Wp-LS; Thu, 26 May 2022 18:16:22 -0700
Date:   Thu, 26 May 2022 18:16:22 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220527011622.GA24951@merlins.org>
References: <CAEzrpqdTpkvguQq+MGxYBb12-RF97dgW7cccz7o2HoSkrWt8gQ@mail.gmail.com>
 <20220526171046.GB1751747@merlins.org>
 <CAEzrpqd_B13rDPCZLm9h0ji8f1oS7mCw=2d1-iiW=M26FfEcCw@mail.gmail.com>
 <20220526173119.GC1751747@merlins.org>
 <CAEzrpqemPU_=VTxGEQS2WtGiaGbHy+ssnj5MKyh=8JC36uyZ6Q@mail.gmail.com>
 <20220526181246.GA28329@merlins.org>
 <CAEzrpqfEmm0qGZkkdTgFYNjVvSn6SZwbdDUYLO2E3jV4DYELFQ@mail.gmail.com>
 <20220526191512.GE28329@merlins.org>
 <CAEzrpqetTskf-UtyfXHBajpJBci4vxdSaBXwDTm5cRs2QtNRkw@mail.gmail.com>
 <20220526213924.GB2414966@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526213924.GB2414966@merlins.org>
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

On Thu, May 26, 2022 at 02:39:24PM -0700, Marc MERLIN wrote:
> I thought we were getting so close, but it seems we'e made a few steps
> back :-/
> 
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-find-root -o 3 /dev/mapper/dshelf1
> checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
> checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
> checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
> Csum didn't match
> ERROR: cannot read chunk root
> WTF???
> ERROR: open ctree failed
> 
> At some point, if the FS is starting to look like it was trashed to
> start with, or kind of trashed now after some of the recovery attempts,
> let me know and I'll wipe and restore.
> That said, if there is still data useful to improving your tools, I'm
> game for a bit more, although if we hit the 2 months mark since it went
> down, I'll have to eventuallly recover :)

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-find-root -o 3 /dev/mapper/dshelf1
checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
Csum didn't match
WARNING: cannot read chunk root, continue anyway
Superblock thinks the generation is 1739781
Superblock thinks the level is 1
Well block 22593536(gen: 1590219 level: 0) seems good, AND HAS NO BAD ITEMS but generation/level doesn't match, want gen: 1739781 level: 1
Well block 22560768(gen: 1590217 level: 0) seems good, AND HAS NO BAD ITEMS but generation/level doesn't match, want gen: 1739781 level: 1
Well block 22577152(gen: 1586277 level: 0) seems good, AND HAS NO BAD ITEMS but generation/level doesn't match, want gen: 1739781 level: 1
Well block 22495232(gen: 1572124 level: 0) seems good, AND HAS NO BAD ITEMS but generation/level doesn't match, want gen: 1739781 level: 1
Well block 22528000(gen: 1572115 level: 0) seems good, AND HAS NO BAD ITEMS but generation/level doesn't match, want gen: 1739781 level: 1
Well block 22446080(gen: 1571791 level: 0) seems good, AND HAS NO BAD ITEMS but generation/level doesn't match, want gen: 1739781 level: 1
Well block 22478848(gen: 1561557 level: 0) seems good, AND HAS NO BAD ITEMS but generation/level doesn't match, want gen: 1739781 level: 1
Well block 22544384(gen: 1556078 level: 0) seems good, AND HAS NO BAD ITEMS but generation/level doesn't match, want gen: 1739781 level: 1
Well block 22511616(gen: 1555799 level: 0) seems good, AND HAS NO BAD ITEMS but generation/level doesn't match, want gen: 1739781 level: 1
Well block 22609920(gen: 1551635 level: 0) seems good, AND HAS NO BAD ITEMS but generation/level doesn't match, want gen: 1739781 level: 1
Well block 22462464(gen: 1479229 level: 0) seems good, AND HAS NO BAD ITEMS but generation/level doesn't match, want gen: 1739781 level: 1
gargamel:/var/local/src/btrfs-progs-josefbacik# 

Is that good?
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
