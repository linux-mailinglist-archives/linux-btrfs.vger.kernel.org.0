Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5C0414FD81
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Feb 2020 15:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgBBOXY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 Feb 2020 09:23:24 -0500
Received: from len.romanrm.net ([91.121.86.59]:57632 "EHLO len.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbgBBOXY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 2 Feb 2020 09:23:24 -0500
X-Greylist: delayed 556 seconds by postgrey-1.27 at vger.kernel.org; Sun, 02 Feb 2020 09:23:23 EST
Received: from natsu (natsu.40.romanrm.net [IPv6:fd39:aa:c499:6515:e99e:8f1b:cfc9:ccb8])
        by len.romanrm.net (Postfix) with SMTP id E57AC40222;
        Sun,  2 Feb 2020 14:14:05 +0000 (UTC)
Date:   Sun, 2 Feb 2020 19:14:05 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Skibbi <skibbi@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: My first attempt to use btrfs failed miserably
Message-ID: <20200202191405.1b1ad9b3@natsu>
In-Reply-To: <CACN+yT_AYiLc29M41U+WrQHtk4t==D-4AkH+wRROKJY=WstGAA@mail.gmail.com>
References: <CACN+yT_AYiLc29M41U+WrQHtk4t==D-4AkH+wRROKJY=WstGAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, 2 Feb 2020 13:45:58 +0100
Skibbi <skibbi@gmail.com> wrote:

> root@rpi4b:~# dmesg |grep btrfs
> [223167.290255] BTRFS: error (device dm-0) in
> btrfs_run_delayed_refs:2935: errno=-5 IO failure
> [223167.389690] BTRFS: error (device dm-0) in
> btrfs_run_delayed_refs:2935: errno=-5 IO failure
> root@rpi4b:~# dmesg |grep BTRFS

Try without that grep, and see if anything else happened to cause these errors.

...
> [203285.469285] BTRFS info (device sda1): read error corrected: ino 0
> off 32759808 (dev /dev/sda1 sector 80368)
> [203285.469515] BTRFS info (device sda1): read error corrected: ino 0
> off 32763904 (dev /dev/sda1 sector 80376)
> [204448.566295] BTRFS: device label NAS devid 1 transid 5 /dev/dm-0

Such as here, doesn't this look like the device may have disconnected and
reappeared (to make btrfs show the "device" message).

-- 
With respect,
Roman
