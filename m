Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E9A1AAC1B
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Apr 2020 17:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414834AbgDOPm2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Apr 2020 11:42:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:51792 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1414839AbgDOPmW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Apr 2020 11:42:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1E5EEABCF;
        Wed, 15 Apr 2020 15:42:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0706ADA727; Wed, 15 Apr 2020 17:41:41 +0200 (CEST)
Date:   Wed, 15 Apr 2020 17:41:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Make btrfs_read_disk_super return struct
 btrfs_disk_super
Message-ID: <20200415154141.GF5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200415125346.468-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415125346.468-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 15, 2020 at 03:53:46PM +0300, Nikolay Borisov wrote:
> -	if (btrfs_super_bytenr(*disk_super) != bytenr ||
> -	    btrfs_super_magic(*disk_super) != BTRFS_MAGIC) {
> +	if (btrfs_super_bytenr(disk_super) != bytenr ||
> +	    btrfs_super_magic(disk_super) != BTRFS_MAGIC) {
>  		btrfs_release_disk_super(p);
> -		return 1;
> +		return ERR_PTR(-EUCLEAN);

One more question: what's the reason for -EUCLEAN? The condition fails
if the superblock offset is wrong or there's no magic number. Clearly
not a btrfs superblock, this could be returned to the scanning ioctl, or
is called during mount.

At this point the decision is 'is this potentially a btrfs device?' and
the lightest check we do is the offset and magic number. Only after that
the checksum is verified and all the superblock items and from that
point on it's all EUCLEAN, but before that it's EINVAL.
