Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F983547342
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jun 2022 11:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiFKJar (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Jun 2022 05:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbiFKJao (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Jun 2022 05:30:44 -0400
Received: from rin.romanrm.net (rin.romanrm.net [IPv6:2001:bc8:2dd2:1000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF96E3152C
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Jun 2022 02:30:38 -0700 (PDT)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by rin.romanrm.net (Postfix) with SMTP id AFF7C46;
        Sat, 11 Jun 2022 09:30:34 +0000 (UTC)
Date:   Sat, 11 Jun 2022 14:30:33 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Marc MERLIN <marc@merlins.org>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Suggestions for building new 44TB Raid5 array
Message-ID: <20220611143033.56ffa6af@nvm>
In-Reply-To: <20220611045120.GN22722@merlins.org>
References: <20220611045120.GN22722@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 10 Jun 2022 21:51:20 -0700
Marc MERLIN <marc@merlins.org> wrote:

> Kernel will be 5.16. Filesystem will be 24TB and contain mostly bigger
> files (100MB to 10GB).

> 2) echo 0fb96f02-d8da-45ce-aba7-070a1a8420e3 >  /sys/block/bcache64/bcache/attach 
>    gargamel:/dev# cat /sys/block/md7/bcache/cache_mode
>    [writethrough] writeback writearound none

Maybe try LVM Cache this time?

> 3) cryptsetup luksFormat --align-payload=2048 -s 256 -c aes-xts-plain64  /dev/bcache64
> 4) cryptsetup luksOpen /dev/bcache64 dshelf1

What's the threat scenario for LUKS on the array?

A major one for me would be not to be having to RMA a disk with all my data
still on the platters. But with RAID5, a single disk by itself would not
contain easily discernible or usable data. Or if you're protecting against
unauthorized access to the entire array, then never mind.

> 5) mkfs.btrfs -m dup -L dshelf1 /dev/mapper/dshelf1

Personally I have switched from Btrfs on MD to individual disks and MergerFS.

The rationale for no RAID is the simplicity and resilience of the individual
single-disk filesystems, and that anything important or not easily
re-obtainable is backed up anyways; so the protection from single disk
failures is not as important, compared to the introduced complexity and the
chance of losing the entire huge FS (like you had).

-- 
With respect,
Roman
