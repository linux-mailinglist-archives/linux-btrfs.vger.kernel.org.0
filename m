Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208EE52ACB4
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 22:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352924AbiEQU2E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 16:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351263AbiEQU2C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 16:28:02 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9855253D
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 13:27:58 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nr3nQ-0001eZ-Qq by authid <merlin>; Tue, 17 May 2022 13:27:56 -0700
Date:   Tue, 17 May 2022 13:27:56 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220517202756.GK8056@merlins.org>
References: <20220515212951.GC13006@merlins.org>
 <20220515230147.GD13006@merlins.org>
 <CAEzrpqdbjeTYEy16KbzJ39bBkd8rkNTHA2n53UXHG-CdeUo6xw@mail.gmail.com>
 <20220516005759.GE13006@merlins.org>
 <CAEzrpqfMbB-sGLZUjGHjxHt1Gga+uULGkoZTqjXHwKnzsjP5aA@mail.gmail.com>
 <20220516151653.GF13006@merlins.org>
 <20220516153651.GG13006@merlins.org>
 <20220516165327.GD8056@merlins.org>
 <CAEzrpqfShQhaCVv1GY=JTTCO_T44ggidHFtbSABrcPCSNzY9hA@mail.gmail.com>
 <CAEzrpqdsi63zgudjzbSa3QyMLuE5nD3+t9nOuzXEdWZGCbTcNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdsi63zgudjzbSa3QyMLuE5nD3+t9nOuzXEdWZGCbTcNA@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 17, 2022 at 03:49:50PM -0400, Josef Bacik wrote:
> Sorry, kids coming down with COVID.  I've pushed a fix for check to

Oh no, sorry to hear. Hopefully they'll be ok.

> delete these things, you can run btrfs check --repair and it should do
> the right thing.  Thanks,

Thanks for not giving up. I'm really surprised by the amount of damage that this filesystem
endured in less than 60 seconds, especially when I'm pretty sure I wasn't even writing to it.
Although I understand that some extra damage may have been done during the repair attempts.


(...)
checksum verify failed on 11160662736896 wanted 0xc46d6447 found 0x9e6e915e
checksum verify failed on 11651750428672 wanted 0x1a5d3be2 found 0xb0ee91ed
checksum verify failed on 11652259332096 wanted 0x779cd76b found 0xa10261c1
Invalid key type(ROOT_ITEM) found in root(11223)
ignoring invalid key
Invalid key type(ROOT_ITEM) found in root(11223)
ignoring invalid key
Invalid key type(ROOT_ITEM) found in root(11223)
ignoring invalid key
Invalid key type(ROOT_ITEM) found in root(11223)
ignoring invalid key
Invalid key type(ROOT_ITEM) found in root(11223)
ignoring invalid key
checksum verify failed on 15645125918720 wanted 0xa2327e31 found 0xe27a2894
checksum verify failed on 15645131276288 wanted 0x578d8fc7 found 0xc159231d
checksum verify failed on 15645146775552 wanted 0x57d7eafa found 0xac917df2
(...)
Chunk[256, 228, 15357255352320] stripe[1, 14776872730624] is not found in dev extent
Chunk[256, 228, 15358329094144] stripe[1, 14777946472448] is not found in dev extent
Chunk[256, 228, 15359402835968] stripe[1, 14779020214272] is not found in dev extent
Chunk[256, 228, 15360476577792] stripe[1, 14780093956096] is not found in dev extent
Chunk[256, 228, 15361550319616] stripe[1, 14781167697920] is not found in dev extent
Chunk[256, 228, 15362624061440] stripe[1, 14782241439744] is not found in dev extent
Chunk[256, 228, 15363697803264] stripe[1, 14783315181568] is not found in dev extent
Chunk[256, 228, 15364771545088] stripe[1, 14784388923392] is not found in dev extent
Chunk[256, 228, 15365845286912] stripe[1, 14785462665216] is not found in dev extent
Chunk[256, 228, 15366919028736] stripe[1, 14786536407040] is not found in dev extent
Device extent[1, 11503033909248, 1073741824] didn't find the relative chunk.
ERROR: couldn't delete chunk record
incorrect local backref count on 2952871936 parent 13576823652352 owner 0 offset 0 found 0 wanted 1 back 0x55aca7a699d0
backref disk bytenr does not match extent record, bytenr=2952871936, ref bytenr=0
data backref 2952871936 root 11223 owner 258 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 2952871936 root 11223 owner 258 offset 0 found 1 wanted 0 back 0x55acc87dc040
backpointer mismatch on [2952871936 262144]
ERROR: attempt to start transaction over already running one
failed to repair damaged filesystem, aborting

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
