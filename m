Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA805FBA1
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2019 18:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfGDQTM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Jul 2019 12:19:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:37144 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725882AbfGDQTM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Jul 2019 12:19:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6F057AF89;
        Thu,  4 Jul 2019 16:19:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 10402DA89D; Thu,  4 Jul 2019 18:19:50 +0200 (CEST)
Date:   Thu, 4 Jul 2019 18:19:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        jthumshirn@suse.de, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Fix build error while LIBCRC32C is module
Message-ID: <20190704161949.GZ20977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, YueHaibing <yuehaibing@huawei.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        jthumshirn@suse.de, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20190702143903.49264-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702143903.49264-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 02, 2019 at 10:39:03PM +0800, YueHaibing wrote:
> If CONFIG_BTRFS_FS is y and CONFIG_LIBCRC32C is m,
> building fails:
> 
> fs/btrfs/super.o: In function `btrfs_mount_root':
> super.c:(.text+0xb7f9): undefined reference to `crc32c_impl'
> fs/btrfs/super.o: In function `init_btrfs_fs':
> super.c:(.init.text+0x3465): undefined reference to `crc32c_impl'
> fs/btrfs/extent-tree.o: In function `hash_extent_data_ref':
> extent-tree.c:(.text+0xe60): undefined reference to `crc32c'
> extent-tree.c:(.text+0xe78): undefined reference to `crc32c'
> extent-tree.c:(.text+0xe8b): undefined reference to `crc32c'
> fs/btrfs/dir-item.o: In function `btrfs_insert_xattr_item':
> dir-item.c:(.text+0x291): undefined reference to `crc32c'
> fs/btrfs/dir-item.o: In function `btrfs_insert_dir_item':
> dir-item.c:(.text+0x429): undefined reference to `crc32c'
> 
> Select LIBCRC32C to fix it.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: d5178578bcd4 ("btrfs: directly call into crypto framework for checksumming")

Thanks, queued for 5.3.  I hoped we could reduce the config dependencies
a bit, oh well.
