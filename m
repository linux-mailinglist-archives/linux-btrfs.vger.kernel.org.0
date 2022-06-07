Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822BB541418
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 22:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359406AbiFGUM7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 16:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359566AbiFGUMO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 16:12:14 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1993BA5F
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 11:27:40 -0700 (PDT)
Received: from [76.132.34.178] (port=59228 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nydD8-0001r4-Db by authid <merlins.org> with srv_auth_plain; Tue, 07 Jun 2022 11:27:37 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nydvV-001Xqm-FN; Tue, 07 Jun 2022 11:27:37 -0700
Date:   Tue, 7 Jun 2022 11:27:37 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220607182737.GU1745079@merlins.org>
References: <20220606221755.GO22722@merlins.org>
 <CAEzrpqcr08tHCesiwS9ysxrRQaadAeHyjSTg3Qp+CorvGz6psQ@mail.gmail.com>
 <20220607023740.GQ22722@merlins.org>
 <CAEzrpqcStzdJt-17404FhAZKww2Y1o7tu6QOgtVGziroGE0pCw@mail.gmail.com>
 <20220607032240.GS22722@merlins.org>
 <CAEzrpqc8f3HzxUG0Ty1NQoQKAEEAW_3-+3ackv1fDk68qfyf6w@mail.gmail.com>
 <20220607151829.GQ1745079@merlins.org>
 <CAEzrpqftCCPw1J-jA-MTgoBDG6fNVJ-bJoXCh7NAbCeDptiwag@mail.gmail.com>
 <20220607153257.GR1745079@merlins.org>
 <CAEzrpqd9RJ8xoOQFWh_xLBdqeMYA+t=otXT4W5YcPkJqsPvG0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqd9RJ8xoOQFWh_xLBdqeMYA+t=otXT4W5YcPkJqsPvG0A@mail.gmail.com>
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

On Tue, Jun 07, 2022 at 01:56:38PM -0400, Josef Bacik wrote:
> On Tue, Jun 7, 2022 at 11:32 AM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Tue, Jun 07, 2022 at 11:21:57AM -0400, Josef Bacik wrote:
> > > Can you capture all of these lines and paste them?  We found a bunch
> > > of old block groups but we may not have found everything.  I might
> > > want to try manually going and looking for those chunks just so we can
> > > avoid mass deleting things.  Thanks,
> >
> > https://pastebin.com/dPzJgVU9
> 
> Ok re-run it, it'll crash right as it tries to delete something, I
> need the bytenr it's complaining about.  Thanks,

inserting block group 15929559744512
inserting block group 15930633486336
inserting block group 15931707228160
inserting block group 15932780969984
inserting block group 15933854711808
ERROR: Error reading data reloc tree -2

ERROR: failed to reinit the data reloc root
searching 1 for bad extents
processed 999424 of 0 possible bytes, 0%
searching 4 for bad extents
processed 163840 of 1064960 possible bytes, 15%
searching 5 for bad extents
processed 65536 of 10960896 possible bytes, 0%
searching 7 for bad extents
processed 16384 of 16570974208 possible bytes, 0%
searching 9 for bad extents
processed 16384 of 16384 possible bytes, 100%
searching 161197 for bad extents
processed 131072 of 108986368 possible bytes, 0%
searching 161199 for bad extents
processed 196608 of 49479680 possible bytes, 0%
searching 161200 for bad extents
processed 180224 of 254214144 possible bytes, 0%
searching 161889 for bad extents
processed 229376 of 49446912 possible bytes, 0%
searching 162628 for bad extents
processed 49152 of 49463296 possible bytes, 0%
searching 162632 for bad extents
processed 147456 of 94633984 possible bytes, 0%
searching 163298 for bad extents
processed 49152 of 49463296 possible bytes, 0%
searching 163302 for bad extents
processed 147456 of 94633984 possible bytes, 0%
searching 163303 for bad extents
processed 131072 of 76333056 possible bytes, 0%
searching 163316 for bad extents
processed 147456 of 108544000 possible bytes, 0%
searching 163920 for bad extents
processed 16384 of 108691456 possible bytes, 0%
searching 164620 for bad extents
processed 49152 of 49463296 possible bytes, 0%
searching 164623 for bad extents
processed 311296 of 63193088 possible bytes, 0%
searching 164624 for bad extents
processed 49152 of 109264896 possible bytes, 0%
Found an extent we don't have a block group for in the file 1258276585472
cmds/rescue-init-extent-tree.c:246: process_leaf_item: BUG_ON `bytenr` triggered, value 1258276585472
./btrfs(+0x8cef8)[0x5596c34b4ef8]
./btrfs(+0x8d685)[0x5596c34b5685]
./btrfs(+0x8d47c)[0x5596c34b547c]
./btrfs(+0x8da64)[0x5596c34b5a64]
./btrfs(+0x8d28c)[0x5596c34b528c]
./btrfs(btrfs_init_extent_tree+0xc83)[0x5596c34b6ffc]
./btrfs(+0x8467e)[0x5596c34ac67e]
./btrfs(handle_command_group+0x49)[0x5596c344017b]
./btrfs(main+0x94)[0x5596c3440275]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xcd)[0x7f4ff8fc97fd]
./btrfs(_start+0x2a)[0x5596c343fe1a]
Aborted

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
