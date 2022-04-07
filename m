Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532054F6F6F
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Apr 2022 03:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbiDGBKT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 21:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbiDGBKS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 21:10:18 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2542817FD13
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Apr 2022 18:08:20 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1ncGdH-0003Fn-L1 by authid <merlin>; Wed, 06 Apr 2022 18:08:19 -0700
Date:   Wed, 6 Apr 2022 18:08:19 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220407010819.GG14804@merlins.org>
References: <20220406033404.GQ28707@merlins.org>
 <CAEzrpqfnGCvE36-r-0OkN7yoA7j9XPCNqQVOnLrgA+cQZNoR3A@mail.gmail.com>
 <20220406185431.GB14804@merlins.org>
 <CAEzrpqd0Pjx7qXz1nXEXubTfN3rmR++idOL8z6fx3tZtyaj2TQ@mail.gmail.com>
 <20220406191636.GD14804@merlins.org>
 <CAEzrpqf0Vz=6nn-iMeyFsB0qLX+X48zO26Ero-3R6FLCqnzivg@mail.gmail.com>
 <20220406203445.GE14804@merlins.org>
 <CAEzrpqdW-Kf7agSfTy_EK6UYUt2Wkf53j-WTzKjSPXWYgEUNkw@mail.gmail.com>
 <20220406205621.GF3307770@merlins.org>
 <CAEzrpqekB7GZ7wytx-Q2D7AnidBwVK2P5sc-NcBww0J666M5oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqekB7GZ7wytx-Q2D7AnidBwVK2P5sc-NcBww0J666M5oA@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 06, 2022 at 05:05:25PM -0400, Josef Bacik wrote:
> Yup that's what I needed, the csum tree is screwed, and actually the
> reinit stuff won't ignore the csum root if we're also init'ing the
> csum root which is kind of annoying.  I updated the btrfs-find-root
> tool to do the tree repair thing for the csum root, you can run
> ./btrfs-find-root /dev/whatever so it'll fixup that tree, and then you
> can re-try the btrfs check.  Thanks,

Different output going back and forth, expected?

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-find-root -o 1 /dev/mapper/dshelf1a 2>&1 |tee /tmp/outo
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
FS_INFO IS 0x55ba30af45f0
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
FS_INFO AFTER IS 0x55ba30af45f0
Couldn't find a replacement block for slot 178
Couldn't find a replacement block for slot 206
Couldn't find a replacement block for slot 62
fixed slot 88
fixed slot 235
fixed slot 237
Couldn't find a replacement block for slot 238
Couldn't find a replacement block for slot 243
fixed slot 33
fixed slot 35
fixed slot 32
fixed slot 133
fixed slot 136
fixed slot 207
Couldn't find a replacement block for slot 221
Couldn't find a replacement block for slot 484
Couldn't find a replacement block for slot 76
fixed slot 229
fixed slot 172
fixed slot 174
fixed slot 36
Couldn't find a replacement block for slot 20
fixed slot 24
Couldn't find a replacement block for slot 28
fixed slot 115
fixed slot 148
fixed slot 9
Couldn't find a replacement block for slot 318
fixed slot 245
fixed slot 1
Couldn't find a replacement block for slot 153
Couldn't find a replacement block for slot 121
Couldn't find a replacement block for slot 134
fixed slot 159
fixed slot 170
fixed slot 204
fixed slot 149
fixed slot 185
fixed slot 257
fixed slot 46
fixed slot 60
fixed slot 91
fixed slot 92
fixed slot 95
fixed slot 247
fixed slot 105
Couldn't find a replacement block for slot 109
fixed slot 124
fixed slot 191
fixed slot 244
fixed slot 9
fixed slot 57
Couldn't find a replacement block for slot 166
fixed slot 163
fixed slot 78
fixed slot 179
Couldn't find a replacement block for slot 50
Couldn't find a replacement block for slot 218
fixed slot 26
fixed slot 75
Couldn't find a replacement block for slot 68
fixed slot 56
fixed slot 60
Couldn't find a replacement block for slot 231
fixed slot 141
fixed slot 151
fixed slot 156
fixed slot 159
fixed slot 163
fixed slot 171
fixed slot 200
fixed slot 5
Couldn't find a replacement block for slot 157
fixed slot 224
fixed slot 44
fixed slot 217
fixed slot 122
fixed slot 59
Couldn't find a replacement block for slot 120
fixed slot 181
fixed slot 187
Couldn't find a replacement block for slot 46
Couldn't find a replacement block for slot 33
Couldn't find a replacement block for slot 220
fixed slot 60
Couldn't find a replacement block for slot 160
Couldn't find a replacement block for slot 237
Couldn't find a replacement block for slot 192
fixed slot 9
fixed slot 7
Couldn't find a replacement block for slot 226
fixed slot 24
fixed slot 49
fixed slot 22
Couldn't find a replacement block for slot 186
fixed slot 149
fixed slot 150
Couldn't find a replacement block for slot 42
fixed slot 218
fixed slot 223
fixed slot 228
fixed slot 230
fixed slot 233
fixed slot 234
fixed slot 240
fixed slot 155
fixed slot 24
fixed slot 30
fixed slot 376
fixed slot 94
fixed slot 104
fixed slot 197
Couldn't find a replacement block for slot 91
Couldn't find a replacement block for slot 191
fixed slot 139
fixed slot 128
Couldn't find a replacement block for slot 143
fixed slot 16
fixed slot 17
fixed slot 114
fixed slot 28
Couldn't find a replacement block for slot 86
Couldn't find a replacement block for slot 83
fixed slot 86
fixed slot 92
fixed slot 149
fixed slot 117
Couldn't find a replacement block for slot 31
fixed slot 188
Couldn't find a replacement block for slot 102
Couldn't find a replacement block for slot 23
Couldn't find a replacement block for slot 203
Couldn't find a replacement block for slot 79
Couldn't find a replacement block for slot 180
Couldn't find a replacement block for slot 21
Couldn't find a replacement block for slot 167
Couldn't find a replacement block for slot 276
Couldn't find a replacement block for slot 282
Couldn't find a replacement block for slot 283
Couldn't find a replacement block for slot 284
Couldn't find a replacement block for slot 285
Couldn't find a replacement block for slot 286
Couldn't find a replacement block for slot 287
Couldn't find a replacement block for slot 289
Couldn't find a replacement block for slot 290
Couldn't find a replacement block for slot 291
Couldn't find a replacement block for slot 69
Couldn't find a replacement block for slot 231
fixed slot 208
Couldn't find a replacement block for slot 171
Couldn't find a replacement block for slot 116

(still running)
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
