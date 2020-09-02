Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCEB25B522
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 22:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgIBUMO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 16:12:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:51296 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgIBUMO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Sep 2020 16:12:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DD63AACCC
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Sep 2020 20:12:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 62143DA7CF; Wed,  2 Sep 2020 22:11:00 +0200 (CEST)
Date:   Wed, 2 Sep 2020 22:11:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/2] btrfs: Enumerate and export exclusive operations
Message-ID: <20200902201100.GM28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org
References: <20200825150233.30294-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825150233.30294-1-rgoldwyn@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 25, 2020 at 10:02:31AM -0500, Goldwyn Rodrigues wrote:
> This patch series enumerates the exlcusive operation currently being
> perfomed by the current filesystem and exports it in the sys filesytem
> at /sys/fs/btrfs/<fsid>/exclusive_operation.
> 
> This would enable our tools to specify precisely which operation is
> running on why starting an exclusive operation failed. The series also
> adds a sysfs_notify() to alert userspace when the state changes, so
> userspace can perform select() on it to get notified of the change.
> This would enable us to enqueue a command which will wait for current
> exclusive operation to complete before issuing the next exclusive
> operation. This has been done synchronously as opposed to a background
> process, or else error collection (if any) will become a nightmare.
> 
> For backward compatibility, the tools continue working as before if the
> sys file is not present.
> 
> Changes since v1:
>  - Corrected call for btrfs_start_exop() in btrfs_ioctl_dev_replace()
>  - Use fsid_str[] instead of fsid[] to save on uuid_parse()
> 
> Changes since v2:
>  - Dropped patch to add additional balance information
>  - modified (simplified) progs patches accordingly

I've switched exclusive_operation to long and used cmpxchg, plus some
fixup to comments still mentioning the old EXCL_OP bit, some other minor
style fixups.  The patches will be in for-next for a day or two and then
moved to misc-next.
