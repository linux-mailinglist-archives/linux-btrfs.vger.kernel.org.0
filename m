Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5F03755DB
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 May 2021 16:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbhEFOrB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 May 2021 10:47:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:59534 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234759AbhEFOrA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 May 2021 10:47:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D38E0AC6A;
        Thu,  6 May 2021 14:46:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1226FDA81B; Thu,  6 May 2021 16:43:35 +0200 (CEST)
Date:   Thu, 6 May 2021 16:43:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] btrfs-progs: mkfs: only output the warning if the
 sectorsize is not supported
Message-ID: <20210506144334.GT7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210420073036.243715-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420073036.243715-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 20, 2021 at 03:30:36PM +0800, Qu Wenruo wrote:
> Currently mkfs.btrfs will output a warning message if the sectorsize is
> not the same as page size:
>   WARNING: the filesystem may not be mountable, sectorsize 4096 doesn't match page size 65536
> 
> But since btrfs subpage support for 64K page size is comming, this
> output is populating the golden output of fstests, causing tons of false
> alerts.
> 
> This patch will make teach mkfs.btrfs to check
> /sys/fs/btrfs/features/supported_sectorsizes, and compare if the sector
> size is supported.
> 
> Then only output above warning message if the sector size is not
> supported.
> 
> This patch will also introduce a new helper,
> sysfs_open_global_feature_file() to make it more obvious which global
> feature file we're opening.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> changelog:
> v2:
> - Introduce new helper to open global feature file
> - Extra the supported sectorsize check into its own function
> - Do proper token check other than strstr()
> - Fix the bug that we're passing @page_size to check
> v3:
> - Fix the wrong delim for the next runs of strtok_r()
> - Also check the terminal '\0' to handle cases like "4096" and "40960"
>   This is not really needed, as the is_power_of_2() has already ruled
>   out such cases.
>   But just to be extra sure.

V3 replaced in devel, thanks.

> +/*
> + * Open a file in global btrfs features directory and return the file
> + * descriptor or error.
> + */
> +int sysfs_open_global_feature_file(const char *feature_name)

I've switched this to take a path relative to the toplevel directory ie
/sys/fs/btrfs, this is more general and can be used to read other sysfs
files. We'll use that more as not everything is provided via ioctls and
exporting that in sysfs is quite cheap.
