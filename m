Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 121FE162AE8
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2020 17:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgBRQol (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Feb 2020 11:44:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:54102 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbgBRQok (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Feb 2020 11:44:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 34F82B32B;
        Tue, 18 Feb 2020 16:44:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D8BDEDA7BA; Tue, 18 Feb 2020 17:44:21 +0100 (CET)
Date:   Tue, 18 Feb 2020 17:44:20 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH] progs: misc-test: 034: Call "udevmadm settle" before
 mount
Message-ID: <20200218164420.GR2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <marcos@mpdesouza.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200216211221.31471-1-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200216211221.31471-1-marcos@mpdesouza.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Feb 16, 2020 at 06:12:21PM -0300, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> As seem in this issue[1], this test can fail from time to time. The
> issue happens when a mount is issued before the new device is processed
> by systemd-udevd, as we can see by the og bellow:
> 
> [ 2346.028809] BTRFS: device fsid 593e23af-a7e6-4360-b16a-229f415de697 devid 1 transid 6 /dev/loop10 scanned by systemd-udevd (3418)
> [ 2346.265401] BTRFS info (device loop10): found metadata UUID change in progress flag, clearing
> [ 2346.272474] BTRFS info (device loop10): disk space caching is enabled
> [ 2346.277472] BTRFS info (device loop10): has skinny extents
> [ 2346.281840] BTRFS info (device loop10): flagging fs with big metadata feature
> [ 2346.308428] BTRFS error (device loop10): devid 2 uuid cde07de6-db7e-4b34-909e-d3db6e7c0b06 is missing
> [ 2346.315363] BTRFS error (device loop10): failed to read the system array: -2
> [ 2346.329887] BTRFS error (device loop10): open_ctree failed
> failed: mount /dev/loop10 /home/marcos/git/suse/btrfs-progs/tests//mnt
> test failed for case 034-metadata-uuid
> make: *** [Makefile:401: test-misc] Error 1
> [ 2346.666865] BTRFS: device fsid 593e23af-a7e6-4360-b16a-229f415de697 devid 2 transid 5 /dev/loop11 scanned by systemd-udevd (3422)
> [ 2346.853233] BTRFS: device fsid 1c2debeb-e829-4d6b-84df-aa7c5d246fd5 devid 1 transid 7 /dev/loop6 scanned by systemd-udevd (3418)
> 
> A few moments after the test failed systemd-udevd processed the new
> device (registered the new device under btrfs). This can be
> tested by executing a mount after the test failed, resulting in a
> successful mount:
> 
> mount /dev/loop10 /mnt
> [ 2398.955254] BTRFS info (device loop10): found metadata UUID change in progress flag, clearing
> [ 2398.959416] BTRFS info (device loop10): disk space caching is enabled
> [ 2398.962483] BTRFS info (device loop10): has skinny extents
> [ 2398.965070] BTRFS info (device loop10): flagging fs with big metadata feature
> [ 2399.012617] BTRFS info (device loop10): enabling ssd optimizations
> [ 2399.022375] BTRFS info (device loop10): checking UUID tree
> 
> This problem can be avoided is we execute "udevadm settle" before the
> mount is executed.
> 
> [1]: https://github.com/kdave/btrfs-progs/issues/192
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Applied, thanks.
