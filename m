Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1209E32D44C
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Mar 2021 14:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241065AbhCDNi7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Mar 2021 08:38:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:34328 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241372AbhCDNix (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Mar 2021 08:38:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 76462ADDB;
        Thu,  4 Mar 2021 13:38:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5B037DA81D; Thu,  4 Mar 2021 14:36:16 +0100 (CET)
Date:   Thu, 4 Mar 2021 14:36:16 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Johannes.Thumshirn@wdc.com,
        dsterba@suse.cz
Subject: Re: [PATCH] btrfs: fix nocow sequence in btrfs_run_delalloc_range()
Message-ID: <20210304133616.GM7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org, Johannes.Thumshirn@wdc.com
References: <20210303125440.lub5c4qymhxo7mgh@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303125440.lub5c4qymhxo7mgh@fiona>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 03, 2021 at 06:54:40AM -0600, Goldwyn Rodrigues wrote:
> need_force_cow will evaluate to false if both BTRFS_INODE_NODATACOW and
> BTRFS_INODE_PREALLOC are not set. Change the function to should_cow()
> instead and correct the conditions so should_nocow() returns true if
> either BTRFS_INODE_NODATACOW or BTRFS_INODE_PREALLOC, but it is not a
> defrag extent.
> 
> Fixes: 7e33213f8ccc btrfs: remove force argument from run_delalloc_nocow()

It would be better to send v2 of that patch, a cleanup with a fix should
be just one patch.
