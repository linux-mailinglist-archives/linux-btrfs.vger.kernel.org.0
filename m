Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E872299E5
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 16:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbgGVOQA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jul 2020 10:16:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:32996 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbgGVOQA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jul 2020 10:16:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 07D58ABCF;
        Wed, 22 Jul 2020 14:16:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8BFEFDA70B; Wed, 22 Jul 2020 16:15:33 +0200 (CEST)
Date:   Wed, 22 Jul 2020 16:15:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: open-code remount flag setting in btrfs_remount
Message-ID: <20200722141533.GW3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <20200722090039.17402-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722090039.17402-1-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 22, 2020 at 06:00:39PM +0900, Johannes Thumshirn wrote:
> When we're (re)mounting a btrfs filesystem we set the
> BTRFS_FS_STATE_REMOUNTING state in fs_info to serialize against async
> reclaim or defrags.
> 
> This flag is set in btrfs_remount_prepare() called by btrfs_remount(). As
> btrfs_remount_prepare() does nothing but setting this flag and doesn't
> have a second caller, we can just open-code the flag setting in
> btrfs_remount().

Agreed, that's too trivial and set_bit of state flags are commonly used.
I'd suggest to also lift the clear_bit counterpart from
btrfs_remount_cleanup and move it right after it in btrfs_remount, so we
have both set/clear in one function.

The original idea was probably to have prepare/cleanup wrapped but I
don't see much value to have the trivial wrapper.
