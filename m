Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C724F479D
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 01:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350308AbiDEVOY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Apr 2022 17:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573655AbiDETdy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 15:33:54 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5EB245BD
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 12:31:55 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nbou9-0001nV-M1 by authid <merlin>; Tue, 05 Apr 2022 12:31:53 -0700
Date:   Tue, 5 Apr 2022 12:31:53 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220405193153.GB28707@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqc=h2A42nnHzeo_DwHik8Lu0xfkuNm2mhd=Ygams6aj=w@mail.gmail.com>
 <YkyMw/7zjzctH0X/@hungrycats.org>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,FAKE_REPLY_C,
        HEXHASH_WORD,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 05, 2022 at 02:38:59PM -0400, Zygo Blaxell wrote:
> First superblock is at 64K, and the first 1M of every device is unused.
> A 30K write at the beginning will overwrite nothing important to btrfs.

I figured something like that was the case, thanks for confirming.

On Tue, Apr 05, 2022 at 02:36:29PM -0400, Josef Bacik wrote:
> > gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-find-root -o 1
> > /dev/mapper/dshelf1a
> > Couldn't read chunk tree
> > WTF???
> > ERROR: open ctree failed
> 
> That's new, the chunk tree wasn't failing before right?  Anyway I
> pushed a change, it should work now, thanks,

works better now
gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-find-root -o 1 /dev/mapper/dshelf1a
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
Ignoring transid failure
FS_INFO IS 0x55d38ce312a0
parent transid verify failed on 13577821667328 wanted 1602089 found
1602242
parent transid verify failed on 13577821667328 wanted 1602089 found
1602242
parent transid verify failed on 13577821667328 wanted 1602089 found
1602242
Ignoring transid failure
parent transid verify failed on 13577821667328 wanted 1602089 found
1602242
Ignoring transid failure
parent transid verify failed on 13577821667328 wanted 1602089 found
1602242
Ignoring transid failure
parent transid verify failed on 13577821667328 wanted 1602089 found
1602242
Ignoring transid failure
Couldn't find the last root for 4
Couldn't setup device tree
FS_INFO AFTER IS 0x55d38ce312a0
Superblock thinks the generation is 1602089
Superblock thinks the level is 1
Ignoring transid failure
Ignoring transid failure
(...)
many similar lines, now it's running for a while, I'll update when it's
done.

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
