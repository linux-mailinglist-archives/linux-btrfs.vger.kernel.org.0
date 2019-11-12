Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06F6EF8FEB
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2019 13:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfKLMth (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Nov 2019 07:49:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:47450 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725847AbfKLMth (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Nov 2019 07:49:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 369A2B23B;
        Tue, 12 Nov 2019 12:49:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AE3FCDA7AF; Tue, 12 Nov 2019 13:49:39 +0100 (CET)
Date:   Tue, 12 Nov 2019 13:49:39 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/5] remove BUG_ON()s in btrfs_close_one_device()
Message-ID: <20191112124939.GW3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20191112122416.30672-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112122416.30672-1-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 12, 2019 at 01:24:11PM +0100, Johannes Thumshirn wrote:
> This series attempts to remove the BUG_ON()s in btrfs_close_one_device().
> Therefore some reorganization of btrfs_close_one_device() and
> close_fs_devices() was needed.
> 
> Forthermore a new BUG_ON() had to be temporarily introduced but is removed
> again in the last patch of theis series.

Yeah, that's fine.

> Although it is generally legal to return -ENOMEM on umount(2), the error
> handling up until close_ctree() as neither close_ctree() nor btrfs_put_super()
> would be able to handle the error.
> 
> This series has passed fstests without any deviation from the baseline and
> also the new error handling was tested via error injection using this snippet:

This BUG_ON is one of the syzbot reports so once this patchset is
reviewed, we can ask for a retest.

I have a WIP fix that tries to avoid ENOMEM completely as it's not
strictly necessary. The empty device is like a placeholder in the list
while the real device is RCU-removed. The fix is to mark the device as
"being deleted" so it can be skipped but this is more intrusive and more
error prone than handling the error.

As this is not a frequent error at all, syzbot artifically limits the
amount of memory, otherwise we haven't seen the ENOMEM in practice. So
the fix is IMO sufficient for now.
