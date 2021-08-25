Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6DDF3F7E0B
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Aug 2021 00:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbhHYVyr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Aug 2021 17:54:47 -0400
Received: from rin.romanrm.net ([51.158.148.128]:55982 "EHLO rin.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231448AbhHYVyq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Aug 2021 17:54:46 -0400
Received: from natsu (natsu2.home.romanrm.net [IPv6:fd39::e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id 2C9832C6;
        Wed, 25 Aug 2021 21:53:59 +0000 (UTC)
Date:   Thu, 26 Aug 2021 02:53:58 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Evan Zimmerman <wolfblitz98@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: BTRFS - Error After Power Outage
Message-ID: <20210826025358.7cba5c44@natsu>
In-Reply-To: <CA+9Jo8u1RbB=pzPj6bpAYLc5BGaZe2S17s-SxA8t+bm-D=wj-g@mail.gmail.com>
References: <CA+9Jo8u1RbB=pzPj6bpAYLc5BGaZe2S17s-SxA8t+bm-D=wj-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 25 Aug 2021 14:50:18 -0700
Evan Zimmerman <wolfblitz98@gmail.com> wrote:

> Hello!
> 
> I have a multi device btrfs array of 6 devices that is timing out or
> otherwise failing to mount on boot causing me to enter recovery mode,
> though I can manually mount the drives in recovery mode and can still
> see my data.
> 
> I was working in my house the other day, when our power had gone out.
> I turned my Debian server back on and it started up in emergency mode
> saying BTRFS error: open_ctree failed. I also got a "failed to mount
> /mnt/data", which is where I have my data.
> 
> Now, I've had a similar problem before where I believe one of my
> EasyStore drives was taking too long to be read from and causing
> Debian to boot into emergency mode, but after restarting it a few
> times, it would manage to finally boot up. This "fix" is not working
> this time around and I fear something corrupted during that power
> outage.
> 
> I'm hoping to get some advice on this to see what I can do to get
> things up and running again. Now, trying to mount manually actually
> worked in emergency mode. Thank you in advance for any help you all
> can provide!
> 
> # uname -a
> Linux [server_name] 5.9.0-5-amd64 #1 SMP Debian 5.9.15-1 (2020-12-17)
> x86_64 GNU/Linux
> 
> # btrfs --version
> btrfs-progs v5.9
> 
> # btrfs fi show
> Label: 'Media'  uuid: c29b9859-ae32-4be2-ad28-9193c9ebcc87
> Total devices 6 FS bytes used 28.24TiB
> devid    1 size 10.91TiB used 9.80TiB path /dev/sdd
> devid    2 size 2.73TiB used 2.68TiB path /dev/sdc
> devid    3 size 3.64TiB used 3.58TiB path /dev/sdb
> devid    4 size 2.73TiB used 2.67TiB path /dev/sde
> devid    5 size 2.73TiB used 1.61TiB path /dev/sdf
> devid    6 size 9.10TiB used 7.98TiB path /dev/sdg
> 
> # dmesg | grep btrfs

Are you sure it's the actual and complete output of the command?
"grep btrfs" without -i would not have returned any of those lines.
And most importantly it looks as if a few might be missing, better just post
the entire dmesg.

> [   16.106923] BTRFS: device label Media devid 6 transid 3072649
> /dev/sdg scanned by systemd-udevd (301)
> [   16.492767] BTRFS info (device sdd): setting incompat feature flag
> for COMPRESS_ZSTD (0x10)
> [   16.492768] BTRFS info (device sdd): force zstd compression, level 2
> [   16.492768] BTRFS info (device sdd): using free space tree
> [   16.492769] BTRFS info (device sdd): has skinny extents
> [  114.864229] BTRFS error (device sdd): open_ctree failed


-- 
With respect,
Roman
