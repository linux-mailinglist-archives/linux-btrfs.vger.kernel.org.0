Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA12475B6C
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 16:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243657AbhLOPId (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 10:08:33 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:50272 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243550AbhLOPIc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 10:08:32 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 733B5210ED;
        Wed, 15 Dec 2021 15:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639580911;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VkgvDlJFmNpu5YKvLBG8E1lrbGnCHTfUZcpHBWDm+SA=;
        b=VLpmqy5PyRhDJPERHj+SNTApgdbuQt6uYMJJRpoz0yL4brcFtatYlWQ70zh5OCMmI6PwdK
        zHMQv7cbdsMp/cCJGFbo/m1ya8yiB7uf6NeUuzq43Hc49eHKh1zzB0tZ8lPE4HcxAacjrR
        xMR0iNgXO5PAGjDLP891Ql92LIAFr9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639580911;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VkgvDlJFmNpu5YKvLBG8E1lrbGnCHTfUZcpHBWDm+SA=;
        b=tkCh70v0x27sXzVh49/urM4mJzdu+uKr43gZ6KhmMUa+ZiyKQOqlVx+ICWvcVzz2Rs7e0z
        jrTlWnf6b0eX2DAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 3B8D4A3B85;
        Wed, 15 Dec 2021 15:08:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 50D67DA781; Wed, 15 Dec 2021 16:08:12 +0100 (CET)
Date:   Wed, 15 Dec 2021 16:08:12 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH] btrfs: Fix missing blkdev_put() call in
 btrfs_scan_one_device()
Message-ID: <20211215150812.GY28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20211215103843.331630-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215103843.331630-1-shinichiro.kawasaki@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 15, 2021 at 07:38:43PM +0900, Shin'ichiro Kawasaki wrote:
> The function btrfs_scan_one_device() calls blkdev_get_by_path() and
> blkdev_put() to get and release its target block device. However, when
> btrfs_sb_log_location_bdev() fails, blkdev_put() is not called and the
> block device is left without clean up. This triggered failure of fstests
> generic/085. Fix the failure path of btrfs_sb_log_location_bdev() to
> call blkdev_put().
> 
> Fixes: 12659251ca5df ("btrfs: implement log-structured superblock for ZONED mode")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Cc: stable@vger.kernel.org # 5.15+

Added to misc-next, thanks.
