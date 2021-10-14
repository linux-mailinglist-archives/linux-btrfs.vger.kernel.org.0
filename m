Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B2042DE25
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Oct 2021 17:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbhJNPaU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Oct 2021 11:30:20 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50268 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhJNPaT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Oct 2021 11:30:19 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0DB692199E;
        Thu, 14 Oct 2021 15:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634225294;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IF9swOCAhei6Kczs0AxISOtEOF+6pq9SnzW7+tSd1aA=;
        b=s0EU9Bo87U44Qtpvr9fwQW3WopX+F6cpyzzxnlPly20STrwMkYHxYzE3Rf7VsjuLSv/Ohu
        9J/CWSxXYwG5phv+G+Ue1Hg2JnS+MjKbmZSreb7I8BMUNdyrOpYAafC+cc6nAWaCne7JbO
        RlPxTajoULke/JNlrv57PDUWvhxB/B4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634225294;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IF9swOCAhei6Kczs0AxISOtEOF+6pq9SnzW7+tSd1aA=;
        b=oPhhdXqoQu9AOHn3Sne0WRHgwrKpsm/tneu0iXqmjkGlhNPLHvuOsVMWpPKhrLFBSkS+8h
        UOkDKRGhHTX009BQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0451BA3B84;
        Thu, 14 Oct 2021 15:28:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2BE2CDA7A3; Thu, 14 Oct 2021 17:27:49 +0200 (CEST)
Date:   Thu, 14 Oct 2021 17:27:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] btrfs: update device path inode time instead of bd_inode
Message-ID: <20211014152749.GC19582@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Christoph Hellwig <hch@lst.de>
References: <00b8cf32502e30403b9849a73e62f4ad5175fded.1634224611.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00b8cf32502e30403b9849a73e62f4ad5175fded.1634224611.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 14, 2021 at 11:17:08AM -0400, Josef Bacik wrote:
> Christoph pointed out that I'm updating bdev->bd_inode for the device
> time when we remove block devices from a btrfs file system, however this
> isn't actually exposed to anything.  The inode we want to update is the
> one that's associated with the path to the device, usually on devtmpfs,
> so that blkid notices the difference.
> 
> We still don't want to do the blkdev_open, so use kern_path() to get the
> path to the given device and do the update time on that inode.
> 
> Fixes: 8f96a5bfa150 ("btrfs: update the bdev time directly when closing")
> Reported-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.
