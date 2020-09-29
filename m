Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D29027D944
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Sep 2020 22:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbgI2Uwl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 16:52:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:44134 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgI2Uwl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 16:52:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7AFCDAC4D;
        Tue, 29 Sep 2020 20:52:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1BB66DA701; Tue, 29 Sep 2020 22:51:21 +0200 (CEST)
Date:   Tue, 29 Sep 2020 22:51:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org, wqu@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        Neal Gompa <ngompa13@gmail.com>
Subject: Re: [PATCH v2] btrfs-progs: convert: Show more info when
 reserve_space fails
Message-ID: <20200929205120.GJ6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <marcos@mpdesouza.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, wqu@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        Neal Gompa <ngompa13@gmail.com>
References: <20200924135502.19560-1-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924135502.19560-1-marcos@mpdesouza.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 24, 2020 at 10:55:02AM -0300, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> btrfs-convert currently can't handle more fragmented block groups when
> converting ext4 because the minimum size of a data chunk is 32Mb.
> 
> When converting an ext4 fs with more fragmented block group with the disk
> almost full, we can end up hitting a ENOSPC problem [1] since smaller
> block groups (10Mb for example) end up being extended to 32Mb, leaving
> the free space tree smaller when converting it to btrfs.
> 
> This patch adds error messages telling which needed bytes couldn't be
> allocated from the free space tree and shows the largest portion available:
> 
> create btrfs filesystem:
>         blocksize: 4096
>         nodesize:  16384
>         features:  extref, skinny-metadata (default)
>         checksum:  crc32c
> free space report:
>         total:     1073741824
>         free:      39124992 (3.64%)
> ERROR: failed to reserve 33554432 bytes for metadata chunk, largest available: 33488896 bytes
> ERROR: unable to create initial ctree: No space left on device
> 
> Link: https://github.com/kdave/btrfs-progs/issues/251
> 
> Reviewed-by: Neal Gompa <ngompa13@gmail.com>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  Changes from v1:
>  * Added reviewed-by tag from Neal and Qu
>  * Add largest free space portion available to the error message (Qu)

Thanks, added to devel.
