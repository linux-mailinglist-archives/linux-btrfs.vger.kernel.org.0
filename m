Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B5921D943
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jul 2020 16:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbgGMO6c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jul 2020 10:58:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:55358 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729649AbgGMO6b (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jul 2020 10:58:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E669CB5E5;
        Mon, 13 Jul 2020 14:58:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 48DBDDA809; Mon, 13 Jul 2020 16:58:09 +0200 (CEST)
Date:   Mon, 13 Jul 2020 16:58:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 4/4] btrfs: assert sizes of ioctl structures
Message-ID: <20200713145809.GL3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <20200713122901.1773-1-johannes.thumshirn@wdc.com>
 <20200713122901.1773-5-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713122901.1773-5-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 13, 2020 at 09:29:01PM +0900, Johannes Thumshirn wrote:
> When expanding ioctl interfaces we want to make sure we're not changing
> the size of the structures, otherwise it can lead to incorrect transfers
> between kernel and user-space.
> 
> Build time assert the size of each structure so we're not running into any
> incompatibilities.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

The structure size is ABI once it's part of the ioctl defintion, ie. in
any of the _IOWR/_IOR/_IOW macros. I don't see the assert added for
btrfs_ioctl_vol_args_v2 or btrfs_ioctl_quota_rescan_args and I haven't
checked all.

Can you please add the static asserts for all of them? The file ioctl.h
in progs should have that already so you can copy or cross-verify from
there.

I'll merge the patches 1-3 now.
