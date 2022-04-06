Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA8F4F5D79
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 14:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiDFMQx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 08:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbiDFMPP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 08:15:15 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F7A22EB04
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 20:12:57 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nbw6J-0004Sd-FM by authid <merlin>; Tue, 05 Apr 2022 20:12:55 -0700
Date:   Tue, 5 Apr 2022 20:12:55 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220406031255.GO28707@merlins.org>
References: <CAEzrpqeZoUF3+Pgyaup1DGFENs6zDKtRqHiJQ6sx_CoXE2HOOA@mail.gmail.com>
 <20220405212655.GH28707@merlins.org>
 <CAEzrpqc0Ss+J6oTqNPfTgWOwyhPAF2uHnRELmc6AO6je6Ht88w@mail.gmail.com>
 <20220405214309.GI28707@merlins.org>
 <CAEzrpqeDZxjbis5kPWH3khiOALyFqUoTuh5eojFtWHPcwj-Ygw@mail.gmail.com>
 <20220405225808.GJ28707@merlins.org>
 <CAEzrpqdtvY7vu50-xSFpdJoySutMWF3JYsqORjMBHNzmTZ52UQ@mail.gmail.com>
 <20220406003521.GM28707@merlins.org>
 <CAEzrpqesUdkDXhdJXHewPZuFGPVu_qyGfH07i5Lxw=NDs=LASQ@mail.gmail.com>
 <CAEzrpqfV9MgU_XbVxpnv05gKnKXQRnHy_BrSYddDfNLZFqi2+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqfV9MgU_XbVxpnv05gKnKXQRnHy_BrSYddDfNLZFqi2+g@mail.gmail.com>
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

On Tue, Apr 05, 2022 at 09:08:32PM -0400, Josef Bacik wrote:
> Also keep in mind this isn't the final fix, this is the pre-repair so
> hopefully fsck can put the rest of it back together.  Thanks,

Done, so now I can run 
btrfs check --repair /dev/mapper/dshelf1a ?

with or without mode=lowmem?

Do I need to reset the ctree too, or repair will do it?
[642321.755553] BTRFS warning (device dm-17): 'recovery' is deprecated, use 'rescue=usebackuproot' instead
[642321.755566] BTRFS info (device dm-17): trying to use backup root at mount time
[642321.755568] BTRFS info (device dm-17): disk space caching is enabled
[642321.755569] BTRFS info (device dm-17): has skinny extents
[642322.242161] BTRFS error (device dm-17): parent transid verify failed on 22216704 wanted 1600938 found 1602177
[642322.282393] BTRFS error (device dm-17): parent transid verify failed on 22216704 wanted 1600938 found 1602177
[642322.313951] BTRFS error (device dm-17): failed to read chunk tree: -5
[642322.339490] BTRFS error (device dm-17): open_ctree failed


gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-find-root -o 1 /dev/mapper/dshelf1a 2>&1 |tee /tmp/outn
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
FS_INFO IS 0x557e9cc375f0
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
Couldn't find the last root for 4
Couldn't setup device tree
FS_INFO AFTER IS 0x557e9cc375f0
fixed slot 0
fixed slot 2
fixed slot 5
fixed slot 7
(...)
Couldn't find a replacement block for slot 261
fixed slot 263
fixed slot 264
fixed slot 265
fixed slot 267
fixed slot 269
fixed slot 271
fixed slot 273
fixed slot 274
fixed slot 276
fixed slot 277
fixed slot 278
fixed slot 279
fixed slot 282
fixed slot 283
fixed slot 285
fixed slot 286
fixed slot 287
fixed slot 288
fixed slot 289
fixed slot 291
fixed slot 293
fixed slot 294
fixed slot 296
fixed slot 297
fixed slot 298
fixed slot 300
fixed slot 301
fixed slot 302
fixed slot 303
fixed slot 304
fixed slot 305
fixed slot 306
fixed slot 307
fixed slot 308
fixed slot 309
fixed slot 311
fixed slot 312
fixed slot 313
fixed slot 314
fixed slot 315
fixed slot 316
fixed slot 317
fixed slot 318
fixed slot 319
fixed slot 320
fixed slot 321


Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
