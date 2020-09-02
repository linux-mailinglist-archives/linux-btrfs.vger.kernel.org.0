Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7568025A982
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 12:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgIBKdu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 06:33:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:37766 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgIBKdt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Sep 2020 06:33:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 65412AC98;
        Wed,  2 Sep 2020 10:33:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4B8DDDA7CF; Wed,  2 Sep 2020 12:32:34 +0200 (CEST)
Date:   Wed, 2 Sep 2020 12:32:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/4] btrfs: kill the rcu protection for
 fs_info->space_info
Message-ID: <20200902103234.GI28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1598996236.git.josef@toxicpanda.com>
 <a88fca8411a0b1f5bc25926a4489b07af0f65ffa.1598996236.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a88fca8411a0b1f5bc25926a4489b07af0f65ffa.1598996236.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 01, 2020 at 05:40:37PM -0400, Josef Bacik wrote:
> We have this thing wrapped in an rcu lock, but it's really not needed.
> We create all the space_info's on mount, and we destroy them on unmount.
> The list never changes and we're protected from messing with it by the
> normal mount/umount path, so kill the RCU stuff around it.

What happens when balance filter converts one profile to a new one?
That's neither mount nor umount and it modifies the space infos, so
the RCU is there to keep the consistent view in case statfs/ioctl
happens, no?
