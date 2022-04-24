Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C8350D5EF
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 01:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239872AbiDXXRu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Apr 2022 19:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiDXXRt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Apr 2022 19:17:49 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAA253B50
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Apr 2022 16:14:47 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nilRG-0005Aq-Lm by authid <merlin>; Sun, 24 Apr 2022 16:14:46 -0700
Date:   Sun, 24 Apr 2022 16:14:46 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220424231446.GF29107@merlins.org>
References: <20220424203133.GA29107@merlins.org>
 <CAEzrpqemyJ8PS5-eF3iSKugy6u3UAzkwwM=o+bHPOh2_7aPHFA@mail.gmail.com>
 <20220424205454.GB29107@merlins.org>
 <CAEzrpqeVQQ+42Lnn9+3gevnRgrU=vsBEwczF41gmTukn=a2ycw@mail.gmail.com>
 <20220424210732.GC29107@merlins.org>
 <CAEzrpqcMV+paWShgAnF8d9WaSQ1Fd5R_DZPRQp-+VNsJGDoASg@mail.gmail.com>
 <20220424212058.GD29107@merlins.org>
 <CAEzrpqcBvh0MC6WeXQ+-80igZhg6t68OcgZnKi6xu+r=njifeA@mail.gmail.com>
 <20220424223819.GE29107@merlins.org>
 <CAEzrpqdBWMcai2uMe=kPxYshUe8wV0YX3Ge1pZW8aG_BSO-i-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdBWMcai2uMe=kPxYshUe8wV0YX3Ge1pZW8aG_BSO-i-w@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Apr 24, 2022 at 06:56:01PM -0400, Josef Bacik wrote:
> I feel like this thing is purposefully changing itself between each
> run so I can't get a grasp on wtf is going on.  I pushed some stuff,
> lets see how that goes.  Thanks,

After all the tests we did, is it possible that some damaged the FS
further?

Either way:
Starting program: /var/local/src/btrfs-progs-josefbacik/btrfs rescue
init-extent-tree /dev/mapper/dshelf1
[Thread debugging using libthread_db enabled]
Using host libthread_db library
"/lib/x86_64-linux-gnu/libthread_db.so.1".
FS_INFO IS 0x55555564cbc0
JOSEF: root 9
checksum verify failed on 15645878108160 wanted 0x1beaa67b found 0x27edb2c4
block 15645878108160 had to be read from a different mirror, ret 0
Couldn't find the last root for 8
checksum verify failed on 58720256 wanted 0x39dcdd2a found 0x79b62995
block 58720256 had to be read from a different mirror, ret 0
checksum verify failed on 58720256 wanted 0x39dcdd2a found 0x79b62995
checksum verify failed on 58720256 wanted 0x39dcdd2a found 0x79b62995
block 58720256 had to be read from a different mirror, ret 0
checksum verify failed on 58720256 wanted 0x39dcdd2a found 0x79b62995
block 58720256 had to be read from a different mirror, ret 0
checksum verify failed on 58720256 wanted 0x39dcdd2a found 0x79b62995
block 58720256 had to be read from a different mirror, ret 0
(...)
FS_INFO AFTER IS 0x55555564cbc0
Walking all our trees and pinning down the currently accessible blocks
block 11651824091136 had to be read from a different mirror, ret 0
block 606126080 had to be read from a different mirror, ret 0
block 15645807640576 had to be read from a different mirror, ret 0
block 364863324160 had to be read from a different mirror, ret 0
block 364970688512 had to be read from a different mirror, ret 0
block 15645178052608 had to be read from a different mirror, ret 0
(...)
inserting block group 352753549312
inserting block group 353827291136
Ignoring transid failure
Ignoring transid failure
ERROR: Error adding block group -17
ERROR: commit_root already set when starting transaction
WARNING: reserved space leaked, flag=0x4 bytes_reserved=81920
extent buffer leak: start 67469312 len 16384
extent buffer leak: start 29540352 len 16384
WARNING: dirty eb leak (aborted trans): start 29540352 len 16384
extent buffer leak: start 29589504 len 16384
WARNING: dirty eb leak (aborted trans): start 29589504 len 16384
extent buffer leak: start 29655040 len 16384
WARNING: dirty eb leak (aborted trans): start 29655040 len 16384
Init extent tree failed
[Inferior 1 (process 1264) exited with code 0357]
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
