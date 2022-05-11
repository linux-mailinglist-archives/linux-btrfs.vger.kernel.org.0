Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CD55236A2
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 May 2022 17:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbiEKPDj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 May 2022 11:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243415AbiEKPD0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 May 2022 11:03:26 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F87737BD8
        for <linux-btrfs@vger.kernel.org>; Wed, 11 May 2022 08:03:20 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nonrz-0000jW-LT by authid <merlin>; Wed, 11 May 2022 08:03:19 -0700
Date:   Wed, 11 May 2022 08:03:19 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220511150319.GM29107@merlins.org>
References: <CAEzrpqf7As9tL28+Rb1kVqeO4G=MqBPQw0fKF6Mwa=_4fzsjSQ@mail.gmail.com>
 <20220510160600.GG12542@merlins.org>
 <CAEzrpqfYJDPdxxrw9TMFdF9GacYKMwc8=yFB6wt3=TMDt6Bung@mail.gmail.com>
 <20220510164448.GI12542@merlins.org>
 <20220510211507.GJ12542@merlins.org>
 <CAEzrpqe41JYFKE2tZFjgZ4V_YqO+K8m4nzF=R3Sti6hgv5snuQ@mail.gmail.com>
 <20220511000815.GK12542@merlins.org>
 <CAEzrpqcPdf8kNjywtGY-OKDAm-87o+1QDh0qX+0mOSV3D4WEqQ@mail.gmail.com>
 <20220511014827.GL12542@merlins.org>
 <CAEzrpqfzXn0sZNVDud4UfysxvF4mgbq_a_ToJioDFz2wE-d3Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqfzXn0sZNVDud4UfysxvF4mgbq_a_ToJioDFz2wE-d3Rw@mail.gmail.com>
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

On Wed, May 11, 2022 at 07:43:29AM -0400, Josef Bacik wrote:
> OMG we're almost done, that's awesome.  So no extent errors, just the
> csum things and the fs things I expected.  Now we do
 
Yeah!

> btrfs check --init-csum-tree <dev>

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs check --init-csum-tree /dev/mapper/dshelf1
Creating a new CRC tree
WARNING:

        Do not use --repair unless you are advised to do so by a developer
        or an experienced user, and then only after having accepted that no
        fsck can successfully repair all types of filesystem corruption. Eg.
        some software or hardware bugs can fatally damage a volume.
        The operation will start in 10 seconds.
        Use Ctrl-C to stop it.
10 9 8 7 6 5 4 3 2 1
Starting repair.
Opening filesystem to check...
FS_INFO IS 0x55a89d2dbfd0
JOSEF: root 9
Couldn't find the last root for 8
FS_INFO AFTER IS 0x55a89d2dbfd0
Checking filesystem on /dev/mapper/dshelf1
UUID: 96539b8c-ccc9-47bf-9e6c-29305890941e
Reinitialize checksum tree
checksum verify failed on 42565632 wanted 0x53c18aa1 found 0xcd4368c2
checksum verify failed on 42582016 wanted 0xc42fc10c found 0xd63d1182
checksum verify failed on 42647552 wanted 0x10aefde4 found 0x5c5bedba
checksum verify failed on 42680320 wanted 0x9cfe6b48 found 0xed48fcc5
checksum verify failed on 42696704 wanted 0x005c4793 found 0x0d9de33c
checksum verify failed on 42811392 wanted 0x2b08fbc0 found 0xf25092bb
checksum verify failed on 42827776 wanted 0x6277c597 found 0x70d260d3
checksum verify failed on 42844160 wanted 0xceecf694 found 0x15ab7b7c
checksum verify failed on 42860544 wanted 0xbc48b372 found 0x99719113
checksum verify failed on 60915712 wanted 0xb9ea7152 found 0x75dbb3c0
checksum verify failed on 63438848 wanted 0x4cfafe67 found 0xf97194d0
checksum verify failed on 63422464 wanted 0xcae61e1f found 0xafc5d21c
checksum verify failed on 63946752 wanted 0xe545e347 found 0x5c2ca453
checksum verify failed on 63881216 wanted 0x4dbaba12 found 0x843eeecc
checksum verify failed on 63930368 wanted 0x03a5dd54 found 0x049161ac
checksum verify failed on 76709888 wanted 0x52911556 found 0x1fbf8f99
checksum verify failed on 76660736 wanted 0xcf5d93fa found 0x08ef5ce9
checksum verify failed on 76677120 wanted 0xf56b664d found 0x9d0df1da
checksum verify failed on 76726272 wanted 0x759a69db found 0xc4d2e554
checksum verify failed on 76742656 wanted 0xe5a5401d found 0xd40609cc
checksum verify failed on 100302848 wanted 0xb1829326 found 0xbd08c95e
checksum verify failed on 105742336 wanted 0x26ef0666 found 0x2fa5587b
checksum verify failed on 129449984 wanted 0x915d087e found 0x26b36e0f
ERROR: checksum tree refilling failed: -2

easy one to fix?

> btrfs check --repair <dev>
> 
> and then you should be good.  Thanks,
> 
> Josef
> 

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
