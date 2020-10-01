Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED1B280142
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Oct 2020 16:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732368AbgJAO3m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Oct 2020 10:29:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:57886 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732099AbgJAO3l (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Oct 2020 10:29:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2E89BAF8F;
        Thu,  1 Oct 2020 14:29:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 08AC9DA781; Thu,  1 Oct 2020 16:28:19 +0200 (CEST)
Date:   Thu, 1 Oct 2020 16:28:19 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Rename BTRFS_INODE_ORDERED_DATA_CLOSE flag
Message-ID: <20201001142819.GW6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201001064039.3231-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001064039.3231-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 01, 2020 at 09:40:39AM +0300, Nikolay Borisov wrote:
> Commit 8d875f95da43 ("btrfs: disable strict file flushes for
> renames and truncates") eliminated the notion of ordered operations and
> instead BTRFS_INODE_ORDERED_DATA_CLOSE only remained as a flag
> indicating that a file's content should be synced to disk in case a
> file is truncated and any writes happen to it concurrently. In fact
> this intendend behavior was broken until it was fixed in
> f6dc45c7a93a ("Btrfs: fix filemap_flush call in btrfs_file_release").
> 
> All things considered let's give the flag a more descriptive name. Also
> slightly reword comments.

Added to misc-next, thanks.
