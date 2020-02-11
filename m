Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB2A1598F6
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 19:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbgBKSpQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 13:45:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:42440 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729554AbgBKSpP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 13:45:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AA19FADE8;
        Tue, 11 Feb 2020 18:45:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C95F9DA86A; Tue, 11 Feb 2020 19:22:01 +0100 (CET)
Date:   Tue, 11 Feb 2020 19:21:59 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     ethanwu <ethanwu@synology.com>, dsterba@suse.cz,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/4] btrfs: backref, only collect file extent items
 matching backref offset
Message-ID: <20200211182159.GD2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        ethanwu <ethanwu@synology.com>, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org
References: <20200207093818.23710-1-ethanwu@synology.com>
 <20200207093818.23710-2-ethanwu@synology.com>
 <0badf0be-d481-10fb-c23d-1b69b985e145@toxicpanda.com>
 <c0453c3eb7c9b4e56bd66dbe647c5f0a@synology.com>
 <20200210162927.GK2654@twin.jikos.cz>
 <5901b2be7358137e691b319cbad43111@synology.com>
 <aeb36a34-bc9c-8500-9f36-554729a078fc@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeb36a34-bc9c-8500-9f36-554729a078fc@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 11, 2020 at 12:33:48PM +0800, Qu Wenruo wrote:
> >> 39862272 have 30949376
> >> [ 5949.328136] repair_io_failure: 22 callbacks suppressed
> >> [ 5949.328139] BTRFS info (device vdb): read error corrected: ino 0
> >> off 39862272 (dev /dev/vdd sector 19488)
> >> [ 5949.333447] BTRFS info (device vdb): read error corrected: ino 0
> >> off 39866368 (dev /dev/vdd sector 19496)
> >> [ 5949.336875] BTRFS info (device vdb): read error corrected: ino 0
> >> off 39870464 (dev /dev/vdd sector 19504)
> >> [ 5949.340325] BTRFS info (device vdb): read error corrected: ino 0
> >> off 39874560 (dev /dev/vdd sector 19512)
> >> [ 5949.409934] BTRFS warning (device vdb): csum failed root -9 ino 257
> >> off 2228224 csum
> 
> This looks like an existing bug, IIRC Zygo reported it before.
> 
> Btrfs balance just randomly failed at data reloc tree.
> 
> Thus I don't believe it's related to Ethan's patches.

Ok, than the patches make it more likely to happen, which could mean
that faster backref processing hits some race window. As there could be
more we should first fix the bug you say Zygo reported.
