Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCBA219C9
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2019 16:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbfEQO1r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 May 2019 10:27:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:57888 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728879AbfEQO1r (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 May 2019 10:27:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 160D8AD0A
        for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2019 14:27:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8411EDA8A7; Fri, 17 May 2019 16:28:45 +0200 (CEST)
Date:   Fri, 17 May 2019 16:28:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: Ensure replaced device doesn't have pending
 chunk allocation
Message-ID: <20190517142845.GC3138@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190515165207.GU3138@twin.jikos.cz>
 <20190517074425.30072-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517074425.30072-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 17, 2019 at 10:44:25AM +0300, Nikolay Borisov wrote:
> Recent FITRIM work, namely bbbf7243d62d ("btrfs: combine device update
> operations during transaction commit") combined the way certain
> operations are recoded in a transaction. As a result an ASSERT was
> added in dev_replace_finish to ensure the new code works correctly.
> Unfortunately I got reports that it's possible to trigger the assert,
> meaning that during a device replace it's possible to have an unfinished
> chunk allocation on the source device.
> 
> This is supposed to be prevented by the fact that a transaction is
> committed before finishing the replace oepration and alter acquiring
> the chunk mutex. This is not sufficient since by the time the
> transaction is committed and the chunk mutex acquired it's possible to
> allocate a chunk depending on the workload being executed on the
> replaced device. This bug has been present ever since device replace was
> introduced but there was never code which checks for it.
> 
> The correct way to fix is to ensure that there is no pending device
> modification operation when the chunk mutex is acquire and if there is
> repeat transaction commit. Unfortunately it's not possible to just
> exclude the source device from btrfs_fs_devices::dev_alloc_list since
> this causes ENOSPC to be hit in transaction commit.
> 
> Fixes: 391cd9df81ac ("Btrfs: fix unprotected alloc list insertion during the finishing procedure of replace")
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to misc-next, thanks.
