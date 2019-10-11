Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3963D4788
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2019 20:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbfJKS0a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Oct 2019 14:26:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:56592 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728514AbfJKS0a (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Oct 2019 14:26:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D9E87B0C6;
        Fri, 11 Oct 2019 18:26:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 84CE7DA808; Fri, 11 Oct 2019 20:26:42 +0200 (CEST)
Date:   Fri, 11 Oct 2019 20:26:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/5] btrfs: get bdev from latest_dev for dio bh_result
Message-ID: <20191011182642.GH2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1570474492.git.dsterba@suse.com>
 <2ae45bba23d97e0d60d9949d9c65dbab9961cb34.1570474492.git.dsterba@suse.com>
 <a5312091-5ded-01af-19e5-f87d21de165f@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5312091-5ded-01af-19e5-f87d21de165f@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 09, 2019 at 01:42:00PM +0300, Nikolay Borisov wrote:
> 
> 
> On 7.10.19 г. 22:37 ч., David Sterba wrote:
> > To remove use of extent_map::bdev we need to find a replacement, and the
> > latest_bdev is the only one we can use here, because inode::i_bdev and
> > superblock::s_bdev are NULL.
> > 
> > The only thing that DIO code uses from the bdev is the blocksize to
> > perform alignment checks in do_blockdev_direct_IO, but we do them in
> > btrfs code before any call to DIO. We can't pass NULL because there are
> 
> nit: This is not entirely correct. In fact map_bh in
> do_blockdev_direct_IO gets filled in :
> 
> do_direct_IO
>   get_more_blocks
>    sdio->get_block() <-- this is btrfs_get_blocks_direct
> 
> Subsequently the map_bh->b_dev member is used in
> clean_bdev_aliases and dio_new_bio to set the bio's bdev to that of the
> buffer_head. However, because we have provided a submit function
> dio_bio_submit calls our submission function and ignores the bdev.

You're right, and actually I got crashes in clean_bdev_aliases when I
supplied a NULL bdev, so I'll add it to the changelog. Thanks.
