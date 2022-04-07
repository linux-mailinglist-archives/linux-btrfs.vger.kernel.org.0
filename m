Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B834F74DB
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Apr 2022 06:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236606AbiDGEj1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Apr 2022 00:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiDGEjW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Apr 2022 00:39:22 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4CE112
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Apr 2022 21:37:18 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1ncJtV-0001xN-7v by authid <merlin>; Wed, 06 Apr 2022 21:37:17 -0700
Date:   Wed, 6 Apr 2022 21:37:17 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220407043717.GA25669@merlins.org>
References: <20220406185431.GB14804@merlins.org>
 <CAEzrpqd0Pjx7qXz1nXEXubTfN3rmR++idOL8z6fx3tZtyaj2TQ@mail.gmail.com>
 <20220406191636.GD14804@merlins.org>
 <CAEzrpqf0Vz=6nn-iMeyFsB0qLX+X48zO26Ero-3R6FLCqnzivg@mail.gmail.com>
 <20220406203445.GE14804@merlins.org>
 <CAEzrpqdW-Kf7agSfTy_EK6UYUt2Wkf53j-WTzKjSPXWYgEUNkw@mail.gmail.com>
 <20220406205621.GF3307770@merlins.org>
 <CAEzrpqekB7GZ7wytx-Q2D7AnidBwVK2P5sc-NcBww0J666M5oA@mail.gmail.com>
 <20220407010819.GG14804@merlins.org>
 <CAEzrpqcFRaq9vrfLi_VcxWi9ZQGj+LgpXr5xwzw-2vWYHM6vJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqcFRaq9vrfLi_VcxWi9ZQGj+LgpXr5xwzw-2vWYHM6vJg@mail.gmail.com>
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

On Wed, Apr 06, 2022 at 09:18:17PM -0400, Josef Bacik wrote:
> On Wed, Apr 6, 2022 at 9:08 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Wed, Apr 06, 2022 at 05:05:25PM -0400, Josef Bacik wrote:
> > > Yup that's what I needed, the csum tree is screwed, and actually the
> > > reinit stuff won't ignore the csum root if we're also init'ing the
> > > csum root which is kind of annoying.  I updated the btrfs-find-root
> > > tool to do the tree repair thing for the csum root, you can run
> > > ./btrfs-find-root /dev/whatever so it'll fixup that tree, and then you
> > > can re-try the btrfs check.  Thanks,
> >
> > Different output going back and forth, expected?
> >
> 
> Yup it's iterating over all the blocks, so it's going to find
> different slots in different blocks that are fucked.
> 
> You are having a lot of ones we can't find good matches for, depending
> on what those look like I may need to adjust the code to simply delete
> slots we don't find a good match for, which will be fine since we're
> going to clear this tree anyway.  But let it finish and we'll see how
> the repair goes and I can do that if we need to.  Thanks,
> 
It took a lot longer, until it mostly hosed my machine by taking all the memory (32GB)

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
Couldn't find a replacement block for slot 74
Couldn't find a replacement block for slot 217
Couldn't find a replacement block for slot 208
Couldn't find a replacement block for slot 89
Couldn't find a replacement block for slot 243
Couldn't find a replacement block for slot 199
Couldn't find a replacement block for slot 130
fixed slot 138
fixed slot 33
Couldn't find a replacement block for slot 179
fixed slot 154
Couldn't find a replacement block for slot 256
Couldn't find a replacement block for slot 214
Couldn't find a replacement block for slot 190
Couldn't find a replacement block for slot 129
fixed slot 111
Couldn't find a replacement block for slot 103
Couldn't find a replacement block for slot 192
fixed slot 12
Couldn't find a replacement block for slot 205
fixed slot 24
fixed slot 28
fixed slot 31
fixed slot 38
fixed slot 47
fixed slot 62
fixed slot 75
fixed slot 86
fixed slot 89
fixed slot 93
fixed slot 108
Couldn't find a replacement block for slot 115
fixed slot 146
fixed slot 218
fixed slot 288
fixed slot 33
Couldn't find a replacement block for slot 106
Couldn't find a replacement block for slot 176
fixed slot 240
Couldn't find a replacement block for slot 241
fixed slot 34
fixed slot 35
Couldn't find a replacement block for slot 71
Couldn't find a replacement block for slot 140
fixed slot 213
Couldn't find a replacement block for slot 155
fixed slot 210
fixed slot 111
fixed slot 147
fixed slot 150
Couldn't find a replacement block for slot 234
Couldn't find a replacement block for slot 236
fixed slot 240
fixed slot 250
Couldn't find a replacement block for slot 259
fixed slot 269
fixed slot 283
Couldn't find a replacement block for slot 43
Couldn't find a replacement block for slot 48
fixed slot 135
fixed slot 192
fixed slot 206
fixed slot 43
fixed slot 111
Couldn't find a replacement block for slot 172
Couldn't find a replacement block for slot 45
fixed slot 47
fixed slot 212
fixed slot 49
fixed slot 190
fixed slot 4
fixed slot 40
fixed slot 110
fixed slot 227
fixed slot 290
fixed slot 296
fixed slot 297
fixed slot 302
fixed slot 349
fixed slot 357
Couldn't find a replacement block for slot 53
fixed slot 304
Couldn't find a replacement block for slot 328
fixed slot 376
fixed slot 54
fixed slot 125
fixed slot 195
Couldn't find a replacement block for slot 89
fixed slot 177
fixed slot 197
Couldn't find a replacement block for slot 219
fixed slot 233
fixed slot 36
fixed slot 52
fixed slot 61
fixed slot 71
fixed slot 113
fixed slot 119
fixed slot 138
Couldn't find a replacement block for slot 153
Couldn't find a replacement block for slot 200
fixed slot 215
Couldn't find a replacement block for slot 173
fixed slot 315
fixed slot 320
fixed slot 326
fixed slot 328
fixed slot 335
fixed slot 65
fixed slot 32
Couldn't find a replacement block for slot 33
Couldn't find a replacement block for slot 34
Couldn't find a replacement block for slot 37
fixed slot 40
Couldn't find a replacement block for slot 179
fixed slot 75
fixed slot 198
fixed slot 79
fixed slot 16
fixed slot 89
fixed slot 111
fixed slot 152
fixed slot 219
fixed slot 220
fixed slot 43
fixed slot 70
fixed slot 85
fixed slot 102
fixed slot 130
fixed slot 145
fixed slot 146
fixed slot 161
fixed slot 188
fixed slot 202
Couldn't find a replacement block for slot 9
fixed slot 62
fixed slot 122
fixed slot 128
fixed slot 137
fixed slot 142
fixed slot 216
Couldn't find a replacement block for slot 26
fixed slot 143
fixed slot 152
fixed slot 174
fixed slot 185
fixed slot 76
fixed slot 87
fixed slot 26
fixed slot 28
fixed slot 31
fixed slot 33
fixed slot 35
fixed slot 43
fixed slot 46
fixed slot 47
fixed slot 56
fixed slot 62
fixed slot 69
fixed slot 73
fixed slot 76
fixed slot 78
fixed slot 81
fixed slot 83
fixed slot 90
fixed slot 92
fixed slot 93
fixed slot 94
fixed slot 98
fixed slot 110
fixed slot 113
fixed slot 114
fixed slot 115
fixed slot 117
fixed slot 118
fixed slot 119
fixed slot 120
fixed slot 121
fixed slot 122
fixed slot 125
fixed slot 142
fixed slot 146
fixed slot 147
fixed slot 148
fixed slot 179
fixed slot 182
fixed slot 185
fixed slot 101
Couldn't find a replacement block for slo^[[2~Timeout, server gargamel not responding.




[729314.382500] systemd-udevd[25274]: dm-13: Process 'socket:/org/freedesktop/hal/udev_event' failed with exit code 1.
[729314.490868] systemd-udevd[25258]: dm-12: Process 'socket:/org/freedesktop/hal/udev_event' failed with exit code 1.
[729351.745188] systemd-udevd[2257]: sda: Worker [25268] processing SEQNUM=101206 is taking a long time
[729352.745164] systemd-udevd[2257]: sdc: Worker [25273] processing SEQNUM=101228 is taking a long time
[729352.774312] systemd-udevd[2257]: wakeup25: Worker [25247] processing SEQNUM=101312 is taking a long time
[729354.745172] systemd-udevd[2257]: memory229: Worker [25275] processing SEQNUM=101499 is taking a long time
[729354.745174] systemd-udevd[25306]: memory230: Spawned process 'socket:/org/freedesktop/hal/udev_event' [26406] is taking longer than 59s to complete
[729354.745175] systemd-udevd[25275]: memory229: Spawned process 'socket:/org/freedesktop/hal/udev_event' [26401] is taking longer than 59s to complete
[729354.859212] systemd-udevd[2257]: memory238: Worker [25257] processing SEQNUM=101509 is taking a long time
[729354.889966] systemd-udevd[2257]: memory236: Worker [25246] processing SEQNUM=101507 is taking a long time
[729354.920686] systemd-udevd[2257]: memory234: Worker [25262] processing SEQNUM=101505 is taking a long time
[729354.951365] systemd-udevd[2257]: memory230: Worker [25306] processing SEQNUM=101501 is taking a long time
[729357.745162] systemd-udevd[2257]: md12: Worker [25269] processing SEQNUM=101854 is taking a long time
[729357.774644] systemd-udevd[2257]: sde: Worker [25263] processing SEQNUM=101860 is taking a long time
[729357.803818] systemd-udevd[2257]: md13: Worker [25340] processing SEQNUM=101855 is taking a long time
[729471.745176] systemd-udevd[2257]: sda: Worker [25268] processing SEQNUM=101206 killed
[729472.745177] systemd-udevd[2257]: sdc: Worker [25273] processing SEQNUM=101228 killed
[729472.769590] systemd-udevd[2257]: wakeup25: Worker [25247] processing SEQNUM=101312 killed
[729474.745171] systemd-udevd[25306]: memory230: Spawned process 'socket:/org/freedesktop/hal/udev_event' [26406] timed out after 2min 59s, killing
[729474.745175] systemd-udevd[2257]: memory229: Worker [25275] processing SEQNUM=101499 killed
[729474.812102] systemd-udevd[2257]: memory238: Worker [25257] processing SEQNUM=101509 killed
[729474.838576] systemd-udevd[2257]: memory230: Worker [25306] processing SEQNUM=101501 killed
[729474.864496] systemd-udevd[2257]: memory236: Worker [25246] processing SEQNUM=101507 killed
[729474.890429] systemd-udevd[2257]: memory234: Worker [25262] processing SEQNUM=101505 killed
[729474.916324] systemd-udevd[2257]: Worker [25275] terminated by signal 9 (KILL)
[729477.442170] systemd-udevd[25244]: sdd4: Process 'socket:/org/freedesktop/hal/udev_event' failed with exit code 1.
[729477.465202] systemd-udevd[25248]: sdd1: Process 'socket:/org/freedesktop/hal/udev_event' failed with exit code 1.
[729477.475194] systemd-udevd[2257]: sde: Worker [25263] processing SEQNUM=101860 killed
[729477.531960] systemd-udevd[2257]: md12: Worker [25269] processing SEQNUM=101854 killed
[729477.556548] systemd-udevd[2257]: md13: Worker [25340] processing SEQNUM=101855 killed
[729494.433414] systemd-udevd[25271]: sdd2: Process 'socket:/org/freedesktop/hal/udev_event' failed with exit code 1.
[729512.577884] systemd-udevd[25265]: sdd3: Process 'socket:/org/freedesktop/hal/udev_event' failed with exit code 1.
[729572.745171] systemd-udevd[2257]: sdd: Worker [25248] processing SEQNUM=101875 is taking a long time
[729692.745172] systemd-udevd[2257]: sdd: Worker [25248] processing SEQNUM=101875 killed
[729828.852640] systemd-udevd[25271]: LNXSYSTM:00: Process 'socket:/org/freedesktop/hal/udev_event' failed with exit code 1.
[729828.880567] systemd-udevd[25294]: cstate_core: Process 'socket:/org/freedesktop/hal/udev_event' failed with exit code 1.
[729828.882126] systemd-udevd[25265]: breakpoint: Process 'socket:/org/freedesktop/hal/udev_event' failed with exit code 1.
[729828.885879] systemd-udevd[25244]: cpu: Process 'socket:/org/freedesktop/hal/udev_event' failed with exit code 1.
[729828.885886] systemd-udevd[25339]: kprobe: Process 'socket:/org/freedesktop/hal/udev_event' failed with exit code 1.
[729828.886061] systemd-udevd[25252]: parport0: Process 'socket:/org/freedesktop/hal/udev_event' failed with exit code 1.
[729828.886527] systemd-udevd[25258]: cstate_pkg: Process 'socket:/org/freedesktop/hal/udev_event' failed with exit code 1.
[729828.888578] systemd-udevd[25255]: 0000:00:00.0: Process 'socket:/org/freedesktop/hal/udev_event' failed with exit code 1.
[729828.888587] systemd-udevd[25274]: i915: Process 'socket:/org/freedesktop/hal/udev_event' failed with exit code 1.
[729828.905903] systemd-udevd[25264]: msr: Process 'socket:/org/freedesktop/hal/udev_event' failed with exit code 1.
[729829.377862] elogind-daemon[9054]: Watching system buttons on /dev/input/event0 (Power Button)
[729829.469868] elogind-daemon[9054]: Watching system buttons on /dev/input/event1 (Power Button)
[729829.833865] elogind-daemon[9054]: Watching system buttons on /dev/input/event2 (AT Translated Set 2 keyboard)
[729830.359362] BTRFS info (device dm-12): devid 1 device path /dev/mapper/vgds2-1Appliances changed to /dev/dm-12 scanned by systemd-udevd (25274)
[729889.745171] systemd-udevd[2257]: 4-1.6.3: Worker [25264] processing SEQNUM=102334 is taking a long time
[730009.745168] systemd-udevd[2257]: 4-1.6.3: Worker [25264] processing SEQNUM=102334 killed
[730009.770590] systemd-udevd[2257]: Worker [25264] terminated by signal 9 (KILL)
[730009.793062] systemd-udevd[2257]: 4-1.6.3: Worker [25264] failed
[730009.813461] systemd-udevd[29139]: 4-1.6.3:1.0: Process 'socket:/org/freedesktop/hal/udev_event' failed with exit code 1.
[732952.473804] BUG: workqueue lockup - pool cpus=6 node=0 flags=0x1 nice=0 stuck for 35s!
[732952.498625] Showing busy workqueues and worker pools:
[732952.514833] workqueue events: flags=0x0
[732952.527430]   pwq 12: cpus=6 node=0 flags=0x1 nice=0 active=1/256 refcnt=2
[732952.527442]     pending: cache_reap
[732952.527447]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[732952.527449]     pending: drm_fb_helper_damage_work [drm_kms_helper]
[732952.527472] workqueue writeback: flags=0x4a
[732952.615583]   pwq 16: cpus=0-7 flags=0x5 nice=0 active=2/256 refcnt=4
[732952.615587]     in-flight: 8793:wb_workfn, 8613:wb_workfn
[732952.615608] workqueue btrfs-delalloc: flags=0xe
[732952.667841]   pwq 16: cpus=0-7 flags=0x5 nice=0 active=2/8 refcnt=4
[732952.667843]     in-flight: 8795:btrfs_work_helper, 29765:btrfs_work_helper
[732952.667859] workqueue btrfs-worker: flags=0xe
[732952.723431]   pwq 16: cpus=0-7 flags=0x5 nice=0 active=1/8 refcnt=3
[732952.723433]     in-flight: 25134:btrfs_work_helper
[732952.723436] workqueue btrfs-endio-write: flags=0xe
[732952.774041]   pwq 16: cpus=0-7 flags=0x5 nice=0 active=2/8 refcnt=4
[732952.774043]     in-flight: 6405:btrfs_work_helper, 25135:btrfs_work_helper
[732952.774047] workqueue btrfs-delalloc: flags=0xe
[732952.830056]   pwq 16: cpus=0-7 flags=0x5 nice=0 active=1/8 refcnt=3
[732952.830058]     in-flight: 25030:btrfs_work_helper
[732952.830070] workqueue cifsiod: flags=0xc
[732952.878011]   pwq 12: cpus=6 node=0 flags=0x1 nice=0 active=1/256 refcnt=2
[732952.878013]     in-flight: 9189:cifs_echo_request [cifs]
[732952.878056] pool 12: cpus=6 node=0 flags=0x1 nice=0 hung=36s workers=2 manager: 17834
[732952.878059] pool 16: cpus=0-7 flags=0x5 nice=0 hung=0s workers=11 manager: 6295 idle: 2903 30021
[732983.193804] BUG: workqueue lockup - pool cpus=6 node=0 flags=0x1 nice=0 stuck for 66s!
[732983.218550] Showing busy workqueues and worker pools:
[732983.234716] workqueue events: flags=0x0
[732983.247202]   pwq 12: cpus=6 node=0 flags=0x1 nice=0 active=1/256 refcnt=2
[732983.247205]     pending: cache_reap
[732983.247209]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[732983.247211]     pending: drm_fb_helper_damage_work [drm_kms_helper]
[732983.247233] workqueue writeback: flags=0x4a
[732983.334945]   pwq 16: cpus=0-7 flags=0x5 nice=0 active=2/256 refcnt=4
[732983.334948]     in-flight: 8793:wb_workfn, 8613:wb_workfn
[732983.334971] workqueue btrfs-delalloc: flags=0xe
[732983.386983]   pwq 16: cpus=0-7 flags=0x5 nice=0 active=2/8 refcnt=4
[732983.386985]     in-flight: 8795:btrfs_work_helper, 29765:btrfs_work_helper
[732983.387000] workqueue btrfs-worker: flags=0xe
[732983.442412]   pwq 16: cpus=0-7 flags=0x5 nice=0 active=1/8 refcnt=3
[732983.442415]     in-flight: 25134:btrfs_work_helper
[732983.442417] workqueue btrfs-endio-write: flags=0xe
[732983.492919]   pwq 16: cpus=0-7 flags=0x5 nice=0 active=2/8 refcnt=4
[732983.492921]     in-flight: 6405:btrfs_work_helper, 25135:btrfs_work_helper
[732983.492925] workqueue btrfs-delalloc: flags=0xe
[732983.548832]   pwq 16: cpus=0-7 flags=0x5 nice=0 active=1/8 refcnt=3
[732983.548843]     in-flight: 25030:btrfs_work_helper
[732983.548854] workqueue cifsiod: flags=0xc
[732983.596634]   pwq 12: cpus=6 node=0 flags=0x1 nice=0 active=1/256 refcnt=2
[732983.596637]     in-flight: 9189:cifs_echo_request [cifs]
[732983.596680] pool 12: cpus=6 node=0 flags=0x1 nice=0 hung=66s workers=2 manager: 17834
[732983.596683] pool 16: cpus=0-7 flags=0x5 nice=0 hung=0s workers=11 manager: 6295 idle: 2903
[733013.909809] BUG: workqueue lockup - pool cpus=6 node=0 flags=0x1 nice=0 stuck for 97s!

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
