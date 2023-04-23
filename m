Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B1A6EBC69
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Apr 2023 04:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjDWC1i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 Apr 2023 22:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjDWC1h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 Apr 2023 22:27:37 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64ACC1717;
        Sat, 22 Apr 2023 19:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1682216855;
        bh=TfWcaPmoDuhSCE6hW+wduHuwMC5aJ3DDU6N4QD3d+Pw=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To;
        b=CSFV+zOZPUR4emS5UgsShLmELXOC47132AYTrq5Vpi8NL5qUJ+Ev1Q6o5iNwwnnBp
         MjK2M6mgd59iO5XcPIJo+P4Ay5baO2e0X3bgcW877mGyVyVw+kzam+cvtdx1vlRU4y
         NDrn9onMJTPrXXFYAX7I6r5Soqa47Y3xTwP1dsKntc383sLUkGUgqJYCGUF2rjw9li
         GCagKursDN62VGDh5f+Sm3LYWAtW18eXMfKBy4q5W4Dx1clfbC9us2lD2jVzp0a6wO
         BsEyTdHN/LUsRLTKTJ36UXIwL03CKPo57hh9NWpRP+Ei9p5hqe5zC5s/B4Owh3Gx1S
         W9km3qZcp6vMg==
Received: from [192.168.238.80] (unknown [182.2.68.80])
        by gnuweeb.org (Postfix) with ESMTPSA id 4280B2457F9;
        Sun, 23 Apr 2023 09:27:33 +0700 (WIB)
Message-ID: <4b35f3a4-9972-b7f0-287f-165a817c0f73@gnuweeb.org>
Date:   Sun, 23 Apr 2023 09:27:30 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, Josef Bacik <josef@toxicpanda.com>,
        Memet <zxce3@gnuweeb.org>,
        Linux Btrfs Mailing List <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
References: <cover.1676908729.git.dsterba@suse.com>
 <CAHk-=wh6-qpZ=yzseD_CQn8Gc+nGDLrufFxSFvVO2qK6+8fGUw@mail.gmail.com>
Content-Language: en-US
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [GIT PULL] Btrfs updates for 6.3
In-Reply-To: <CAHk-=wh6-qpZ=yzseD_CQn8Gc+nGDLrufFxSFvVO2qK6+8fGUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/21/23 4:02 AM, Linus Torvalds wrote:
> On Mon, Feb 20, 2023 at 11:26 AM David Sterba <dsterba@suse.com> wrote:
>> Other:
>>
>> - locally enable -Wmaybe-uninitialized after fixing all warnings
> 
> I've pulled this, but I strongly suspect this change will get reverted.
> 
> I bet neither you nor linux-next is testing even _remotely_ a big
> chunk of the different compiler versions that are out there, and the
> reason flags like '-Wmaybe-uninitialized' get undone is because some
> random compiler version on some random config and target archiecture
> gives completely nonsensical warnings for odd reasons.
> 
> But hey, maybe the btrfs code is special.

Maybe it's too late for 6.3. So please fix this in 6.4 and backport it to
6.3 stable. If someone fixes it, kindly add:

Reported-by: Memet <zxce3@gnuweeb.org>

Compiling with GCC 9.4:

gcc (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
Copyright (C) 2019 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

Linux version 6.3-rc7:

   CC [M]  fs/btrfs/volumes.o
fs/btrfs/volumes.c: In function ‘btrfs_init_new_device’:
fs/btrfs/volumes.c:2524:2: error: ‘seed_devices’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
  2524 |  list_add(&seed_devices->seed_list, &fs_devices->seed_list);
       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fs/btrfs/volumes.c:2621:27: note: ‘seed_devices’ was declared here
  2621 |  struct btrfs_fs_devices *seed_devices;
       |                           ^~~~~~~~~~~~
cc1: all warnings being treated as errors
make[7]: *** [scripts/Makefile.build:252: fs/btrfs/volumes.o] Error 1
make[6]: *** [scripts/Makefile.build:494: fs/btrfs] Error 2
make[5]: *** [scripts/Makefile.build:494: fs] Error 2
make[4]: *** [Makefile:2025: .] Error 2
make[3]: *** [Makefile:357: __build_one_by_one] Error 2
make[2]: *** [debian/rules:8: build-arch] Error 2
dpkg-buildpackage: error: debian/rules binary subprocess returned exit status 2
make[1]: *** [scripts/Makefile.package:120: bindeb-pkg] Error 2
make: *** [Makefile:1656: bindeb-pkg] Error 2


fs/btrfs/send.c: In function ‘get_cur_inode_state’:
fs/btrfs/send.c:1909:13: error: ‘right_gen’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
  1909 |   } else if (right_gen == gen) {
       |             ^

-- 
Ammar Faizi
