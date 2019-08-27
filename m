Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF7589EC5A
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 17:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbfH0PWs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 11:22:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:39218 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727064AbfH0PWr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 11:22:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6279BAEBF
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 15:22:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D2399DA809; Tue, 27 Aug 2019 17:23:09 +0200 (CEST)
Date:   Tue, 27 Aug 2019 17:23:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Jeff Mahoney <jeffm@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/5] btrfs-progs: btrfs_add_to_fsid: check if adding
 device would overflow
Message-ID: <20190827152309.GL2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Jeff Mahoney <jeffm@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190814010402.22546-1-jeffm@suse.com>
 <20190814010402.22546-2-jeffm@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814010402.22546-2-jeffm@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 13, 2019 at 09:03:59PM -0400, Jeff Mahoney wrote:
> It's theoretically possible to add multiple devices with sizes that add up
> to or exceed 16EiB.  A file system will be created successfully but will
> have a superblock with incorrect values for total_bytes and other fields.
> 
> Kernels up to v5.0 will crash when they encounter this scenario.
> 
> We need to check for overflow and reject the device if it would overflow.
> I've copied include/linux/overflow.h from the kernel to reuse that code.
> 
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1099147
> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
> ---
>  common/device-scan.c                              |  15 +-
>  kernel-lib/overflow.h                             | 270 ++++++++++++++++++++++
>  tests/mkfs-tests/018-multidevice-overflow/test.sh |  22 ++

I've split that to 3 patches as each does something else.
