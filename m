Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B669B229CD4
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 18:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgGVQLy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jul 2020 12:11:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:40998 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728059AbgGVQLy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jul 2020 12:11:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 480A6B018;
        Wed, 22 Jul 2020 16:12:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AEE95DA70B; Wed, 22 Jul 2020 18:11:26 +0200 (CEST)
Date:   Wed, 22 Jul 2020 18:11:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: open-code remount flag setting in btrfs_remount
Message-ID: <20200722161126.GC3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <20200722151804.33590-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722151804.33590-1-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 23, 2020 at 12:18:04AM +0900, Johannes Thumshirn wrote:
> When we're (re)mounting a btrfs filesystem we set the
> BTRFS_FS_STATE_REMOUNTING state in fs_info to serialize against async
> reclaim or defrags.
> 
> This flag is set in btrfs_remount_prepare() called by btrfs_remount(). As
> btrfs_remount_prepare() does nothing but setting this flag and doesn't
> have a second caller, we can just open-code the flag setting in
> btrfs_remount().
> 
> Similarly do for so clearing of the flag by moving it out of
> btrfs_remount_cleanup() into btrfs_remount() to be symmetrical.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
> Changes to v1:
> - Move clearing of the flag as well (David)

Added to misc-next, thanks.
