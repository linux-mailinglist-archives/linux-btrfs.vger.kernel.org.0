Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D3A4F6B73
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 22:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiDFUdu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 16:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234591AbiDFUcT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 16:32:19 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D9421A0D7
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Apr 2022 11:54:32 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1ncAnX-0007On-Bd by authid <merlin>; Wed, 06 Apr 2022 11:54:31 -0700
Date:   Wed, 6 Apr 2022 11:54:31 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220406185431.GB14804@merlins.org>
References: <20220405214309.GI28707@merlins.org>
 <CAEzrpqeDZxjbis5kPWH3khiOALyFqUoTuh5eojFtWHPcwj-Ygw@mail.gmail.com>
 <20220405225808.GJ28707@merlins.org>
 <CAEzrpqdtvY7vu50-xSFpdJoySutMWF3JYsqORjMBHNzmTZ52UQ@mail.gmail.com>
 <20220406003521.GM28707@merlins.org>
 <CAEzrpqesUdkDXhdJXHewPZuFGPVu_qyGfH07i5Lxw=NDs=LASQ@mail.gmail.com>
 <CAEzrpqfV9MgU_XbVxpnv05gKnKXQRnHy_BrSYddDfNLZFqi2+g@mail.gmail.com>
 <20220406031255.GO28707@merlins.org>
 <20220406033404.GQ28707@merlins.org>
 <CAEzrpqfnGCvE36-r-0OkN7yoA7j9XPCNqQVOnLrgA+cQZNoR3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqfnGCvE36-r-0OkN7yoA7j9XPCNqQVOnLrgA+cQZNoR3A@mail.gmail.com>
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

On Wed, Apr 06, 2022 at 11:20:13AM -0400, Josef Bacik wrote:
> On Tue, Apr 5, 2022 at 11:34 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Tue, Apr 05, 2022 at 08:12:55PM -0700, Marc MERLIN wrote:
> > > On Tue, Apr 05, 2022 at 09:08:32PM -0400, Josef Bacik wrote:
> > > > Also keep in mind this isn't the final fix, this is the pre-repair so
> > > > hopefully fsck can put the rest of it back together.  Thanks,
> > >
> > > Done, so now I can run
> > > btrfs check --repair /dev/mapper/dshelf1a ?
> >
> > Here is regular check:
> > gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs check /dev/mapper/dshelf1a
> 
> Woo ok we're almost there, that's great.  Can you re-run the
> btrfs-find-root and see what it spits out this time?  It should run
> faster now that it fixed everything, I'm wondering what it wasn't able
> to fix and if I should run the same check on all the roots.  Thanks,

took a few hours to run, but it's done now. Looks like it fixed things a 2nd time?

Should I run 
gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs check --repair /dev/mapper/dshelf1a
now?

output:
gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-find-root -o 1 /dev/mapper/dshelf1a 2>&1 |tee /tmp/outm
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
FS_INFO IS 0x55cf0ce435f0
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
Couldn't find the last root for 8
parent transid verify failed on 15645251010560 wanted 1602089 found 1602297
FS_INFO AFTER IS 0x55cf0ce435f0
fixed slot 0
fixed slot 2
fixed slot 5
fixed slot 7
fixed slot 12
fixed slot 27
fixed slot 28
fixed slot 32
fixed slot 34
fixed slot 35
fixed slot 36
fixed slot 45
fixed slot 48
fixed slot 49
fixed slot 50
fixed slot 52
fixed slot 53
fixed slot 54
fixed slot 55
fixed slot 56
fixed slot 60
fixed slot 61
fixed slot 63
fixed slot 76
fixed slot 77
fixed slot 85
fixed slot 86
fixed slot 89
fixed slot 93
fixed slot 98
fixed slot 99
fixed slot 100
fixed slot 103
fixed slot 104
fixed slot 106
fixed slot 107
fixed slot 108
fixed slot 109
fixed slot 110
fixed slot 111
fixed slot 112
fixed slot 114
fixed slot 120
fixed slot 135
fixed slot 140
fixed slot 141
fixed slot 142
fixed slot 146
fixed slot 155
fixed slot 156
fixed slot 158
fixed slot 159
fixed slot 160
fixed slot 161
fixed slot 165
fixed slot 166
fixed slot 171
fixed slot 173
fixed slot 174
fixed slot 180
fixed slot 181
fixed slot 182
fixed slot 183
fixed slot 184
fixed slot 185
fixed slot 186
fixed slot 212
fixed slot 213
fixed slot 221
fixed slot 222
fixed slot 224
fixed slot 226
fixed slot 227
fixed slot 228
fixed slot 229
fixed slot 231
fixed slot 232
fixed slot 233
fixed slot 234
fixed slot 240
fixed slot 244
fixed slot 245
fixed slot 248
fixed slot 252
fixed slot 259
fixed slot 260
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
gargamel:/var/local/src/btrfs-progs-josefbacik#
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
