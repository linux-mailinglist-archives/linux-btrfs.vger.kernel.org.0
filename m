Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1951B190B
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Apr 2020 00:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgDTWKr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Apr 2020 18:10:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:41062 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgDTWKr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Apr 2020 18:10:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2150FABC2;
        Mon, 20 Apr 2020 22:10:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C8FD0DA72D; Tue, 21 Apr 2020 00:10:03 +0200 (CEST)
Date:   Tue, 21 Apr 2020 00:10:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        Jeff Mahoney <jeffm@suse.com>, wqu@suse.com
Subject: Re: [PATCH] btrfs: move enum btrfs_compression_type to the UAPI
 header
Message-ID: <20200420221003.GG18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Eugene Syromiatnikov <esyr@redhat.com>,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
        Chris Mason <clm@fb.com>, Jeff Mahoney <jeffm@suse.com>,
        wqu@suse.com
References: <20200419101432.GA32249@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419101432.GA32249@asgard.redhat.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Apr 19, 2020 at 12:14:32PM +0200, Eugene Syromiatnikov wrote:
> It is passed in struct btrfs_ioctl_defrag_range_args.compress_type
> to BTRFS_IOC_DEFRAG_RANGE, so it has to be a part of UAPI.
> Also, rely on enum definition rules to get BTRFS_NR_COMPRESS_TYPES
> value and mark it as non-ABI.

Adding the compression types makes sense for the UAPI, Qu has sent patch
to move more code to the exported headers ("btrfs: move on-disk
structure definitions to btrfs_tree.h"), including the compression type
definition.

I'd prefer to move the code in a bigger chunk than one by one, unless
it's breaking compilation.
