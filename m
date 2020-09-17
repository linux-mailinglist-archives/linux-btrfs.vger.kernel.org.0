Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4815726DFBE
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Sep 2020 17:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgIQPde (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Sep 2020 11:33:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:43508 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728053AbgIQPdT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Sep 2020 11:33:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 11F98AC8C;
        Thu, 17 Sep 2020 15:33:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B1945DA7C7; Thu, 17 Sep 2020 17:31:51 +0200 (CEST)
Date:   Thu, 17 Sep 2020 17:31:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: init device stats for seed devices
Message-ID: <20200917153151.GA6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200803192308.17977-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803192308.17977-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 03, 2020 at 03:23:08PM -0400, Josef Bacik wrote:
> We recently started recording device stats across the fleet, and noticed
> a large increase in messages such as this
> 
> BTRFS warning (device dm-0): get dev_stats failed, not yet valid
> 
> on our tiers that use seed devices for their root devices.  This is
> because we do not initialize the device stats for any seed devices if we
> have a sprout device and mount using that sprout device.  The basic
> steps for reproducing are
> 
> mkfs seed device
> mount seed device
> fill seed device
> umount seed device
> btrfstune -S 1 seed device
> mount seed device
> btrfs device add -f sprout device /mnt/wherever
> umount /mnt/wherever
> mount sprout device /mnt/wherever
> btrfs device stats /mnt/wherever
> 
> This will fail with the above message in dmesg.
> 
> Fix this by iterating over the fs_devices->seed if they exist in
> btrfs_init_dev_stats.  This fixed the problem and properly reports the
> stats for both devices.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Please update the patch after the device list api changes, thanks.
