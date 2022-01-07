Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E892B487AFD
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jan 2022 18:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240412AbiAGRHH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jan 2022 12:07:07 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:32824 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240371AbiAGRHH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Jan 2022 12:07:07 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 7061B145235; Fri,  7 Jan 2022 12:07:06 -0500 (EST)
Date:   Fri, 7 Jan 2022 12:07:06 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Juan =?iso-8859-1?Q?Sim=F3n?= <decedion@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: 48 seconds to mount a BTRFS hard disk drive seems too long to me
Message-ID: <YdhzOhLar6TqZbbN@hungrycats.org>
References: <CAMQzBqCSzr4UO1VFTjtSDPt+0ukhf6yqK=q+eLA+Tp1hiB_weA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMQzBqCSzr4UO1VFTjtSDPt+0ukhf6yqK=q+eLA+Tp1hiB_weA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 06, 2022 at 04:48:21PM +0100, Juan Simón wrote:
> Hard disk: 16TB SEAGATE IRONWOLF PRO 3.5", 7200 RPM 256MB CACHE
> Arch Linux
> Linux juan-PC 5.15.13-xanmod1-tt-1 #1 SMP Thu, 06 Jan 2022 12:14:06
> +0000 x86_64 GNU/Linux
> btrfs-progs v5.15.1
> 
> $ btrfs fi df /multimedia
> Data, single: total=10.89TiB, used=10.72TiB
> System, DUP: total=8.00MiB, used=1.58MiB
> Metadata, DUP: total=15.00GiB, used=13.19GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
> 
> I have formatted it as BTRFS and the mounting options (fstab) are:
> 
> /multimedia     btrfs
> rw,noatime,autodefrag,compress-force=zstd,nossd,space_cache=v2    0 0
> 
> The disk works fine, I have not detected any problems but every time I
> reboot the system takes a long time due to the mounting of this drive
> 
> $ systemd-analyze blame
> 48.575s multimedia.mount
> ....
> 
> I find it too long to mount a drive, is this normal, is it because of
> one of the mounting options, or because of the size of the hard drive?

Worst-case, you'll need about one second of mounting time for every ~180
block groups on a spinning disk, which works out to about 89 seconds on
that drive when it's full.

It's a known issue, but it will require a disk format change to fix, so
it will likely be rolled into a larger change set like extent tree v2.

> Thanks in advance. Regards.
