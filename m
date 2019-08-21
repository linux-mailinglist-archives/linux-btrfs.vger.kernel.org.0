Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 832899857B
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 22:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfHUUV3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Aug 2019 16:21:29 -0400
Received: from rin.romanrm.net ([91.121.75.85]:34136 "EHLO rin.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727959AbfHUUV3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Aug 2019 16:21:29 -0400
X-Greylist: delayed 547 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Aug 2019 16:21:28 EDT
Received: from natsu (natsu.40.romanrm.net [IPv6:fd39:aa:c499:6515:e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id 51AE920294;
        Wed, 21 Aug 2019 20:12:20 +0000 (UTC)
Date:   Thu, 22 Aug 2019 01:12:19 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Btrfs on LUKS on loopback mounted image on Btrfs
Message-ID: <20190822011219.77d2d8bf@natsu>
In-Reply-To: <CAJCQCtRYFtPGn2drNxrcuYFTTvmvRD7iuDNG=i1cDvSu=zcF6A@mail.gmail.com>
References: <CAJCQCtRYFtPGn2drNxrcuYFTTvmvRD7iuDNG=i1cDvSu=zcF6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 21 Aug 2019 13:42:53 -0600
Chris Murphy <lists@colorremedies.com> wrote:

> Why do this? a) compression for home, b) encryption for home, c) home
> is portable because it's a file, d) I still get btrfs snapshots
> anywhere (I tend to snapshot subvolumes inside of cryptohome; but

Storing Btrfs on Btrfs really feels suboptimal, good that at least you are
using NOCOW; of course it still will be CoW'ed in case of snapshots. Also you
are likely to run into the space wasting issue as discussed in
https://www.spinics.net/lists/linux-btrfs/msg90352.html

I'd strongly suggest that you look into deploying LVM Thin instead. There you
can specify an arbitrary CoW chunk size, and a value such as 1MB or more will
reduce management overhead and fragmentation dramatically.

Or if the partition size in question is just 4GB, with today's SSD sizes, just
store it as a regular LV and save on quite a bit of complexity and brittleness.

> I could "snapshot" outside of it by reflink copying the backing file.

Pretty sure "cp -a is not atomic, so beware, you cannot safely do this while
the /home is open and mounted. On the other hand if you keep this file inside
a subvolume and then snapshot it, then it is safe(r).

> sysroot mkfs options: -dsingle -msingle

This is asking for trouble, even if you said you power-cut it constantly,
there is little reason to run with "single" metadata, not even on SSDs where
some insinuate that "DUP" is always magically 100% deduped internally by the
SSD during writes at speeds of 600-2500 MB/sec; even though we can't see the
internals and SSD firmware is proprietary to reliably confirm or deny, this
seems very unlikely, and more importantly there are other places where one
(and in your case the only) copy of metadata might get corrupted: RAM, storage
controller, cabling. Even a sudden poweroff has more chances to finally do its
thing when there's no possible "other copy of metadata" to refer to, and the
broken one is all you get.

-- 
With respect,
Roman
