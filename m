Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726421F605F
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jun 2020 05:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgFKDOP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 10 Jun 2020 23:14:15 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:43386 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgFKDOP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jun 2020 23:14:15 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 3D02770CBA5; Wed, 10 Jun 2020 23:14:14 -0400 (EDT)
Date:   Wed, 10 Jun 2020 23:14:13 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     "Ellis H. Wilson III" <ellisw@panasas.com>
Cc:     Hans van Kranenburg <hans@knorrie.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: BTRFS File Delete Speed Scales With File Size?
Message-ID: <20200611031408.GJ10769@hungrycats.org>
References: <8ab42255-8a67-e40e-29ea-5e79de55d6f5@panasas.com>
 <db40ba19-8160-05fd-5d25-65dea81b36fa@knorrie.org>
 <11bf6ebc-27e9-cc89-30f1-529f4caf11a5@panasas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <11bf6ebc-27e9-cc89-30f1-529f4caf11a5@panasas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 10, 2020 at 09:56:11PM -0400, Ellis H. Wilson III wrote:
> On 6/9/20 7:09 PM, Hans van Kranenburg wrote:
> > * (not recommended) If your mount options do not show 'ssd' in them and
> > your kernel does not have this patch:
> > https://www.spinics.net/lists/linux-btrfs/msg64203.html  then you can try
> > the mount -o ssd_spread,nossd (read the story in the link above).
> > Anyway, you're better off moving to something recent instead of trying
> > all these obsolete workarounds...
> 
> I forgot to respond to this in my last email.  The version of BTRFS running
> in my openSuSE 15.0 kernel does indeed have that patch.
> 
> Nevertheless, I tried with just ssd_spread for kicks, and it showed no major
> improvement, and had the same growth pathology as past runs had:
> 
> 0f70583cd12cac:/pandata/0 # time (for i in {1..10}; do time (rm test$i;
> sync); done)
> real    0m0.636s
> real    0m0.649s
> real    0m0.417s
> real    0m0.562s
> real    0m0.381s
> real    0m0.949s
> real    0m2.014s
> real    0m2.129s
> real    0m2.074s
> real    0m5.114s
> 
> Total:
> real    0m14.939s
> 
> Even more curiously, when I repeat this experiment using ext4 (lazy init was
> disabled) on the exact same disks, I see a nearly identical slowdown
> pathology:
> 
> real    0m0.122s
> real    0m0.048s
> real    0m0.075s
> real    0m0.076s
> real    0m0.100s
> real    0m0.499s
> real    0m1.658s
> real    0m1.709s
> real    0m1.716s
> real    0m6.599s
> 
> Total:
> real    0m12.614s
> 
> Very wonky.  Maybe this has something to do with the mdraid we use
> underneath both, or maybe it's something architectural I'm not immediately
> grasping that impacts all extent-based filesystems.  Will report back when I
> have blktraces.

Not just extent-based.  ext2 and ext3 had O(n) deletes too, and they
used block lists.

> Best,
> 
> ellis
