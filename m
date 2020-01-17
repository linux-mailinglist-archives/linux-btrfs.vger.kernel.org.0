Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 612B9140B62
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgAQNsH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:48:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:53108 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgAQNsH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:48:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 78AD0ABB1;
        Fri, 17 Jan 2020 13:48:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3D450DA871; Fri, 17 Jan 2020 14:47:51 +0100 (CET)
Date:   Fri, 17 Jan 2020 14:47:51 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Michael Ruiz <michael@mruiz.dev>
Cc:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Subject: Re: Linux swap file not activating after reboot
Message-ID: <20200117134751.GC3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Michael Ruiz <michael@mruiz.dev>,
        Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
References: <5318295.DvuYhMxLoT@archlinux>
 <20200116185539.GZ3929@twin.jikos.cz>
 <20200116204329.GA269122@vader>
 <5561753.lOV4Wx5bFT@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5561753.lOV4Wx5bFT@archlinux>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 16, 2020 at 04:44:18PM -0800, Michael Ruiz wrote:
> My solution was to boot into an arch live usb, unlock my dmcrypt partition and 
> mount the btrfs partition to /mnt. After that I created a subvolume on the @ 
> directory (top level 5) instead of a subvolume of my root (/) partition. 
> So now my subvolume layout is like this:
> 
> ID 256 gen 45343 top level 5 path @
> ID 257 gen 45346 top level 5 path @home
> ID 258 gen 45346 top level 5 path @log
> ID 259 gen 44303 top level 5 path @srv
> ID 260 gen 44650 top level 5 path @pkg
> ID 261 gen 45346 top level 5 path @tmp
> ID 1607 gen 43963 top level 5 path @swap
> 
> The strange thing to me is that I didn't ask for snapshots of this subvolume, 
> although I do keep snapshots of my / directory, I was under the impression 
> that snapshots would not be recursive and go into the /swap subvolume.

No, snapshots are not recursive.

> I can 
> also confirm I had the +C attribute while getting this error. So now I am able 
> to mount this subvolume with it's own options, whereas before I guess it 
> inherited options from the root dir which has CoW enabled. The problem is now 
> resolved by doing this. Thanks for the responses.

The file attribute has precedence over the mount options, so it should
not matter if you had nodatacow or not when creating the file (assuming
you set the +C flag manually).
