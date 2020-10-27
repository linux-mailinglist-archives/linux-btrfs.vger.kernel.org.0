Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E7A29AA6A
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 12:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897629AbgJ0LSH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Oct 2020 07:18:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:42110 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2508741AbgJ0LSH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Oct 2020 07:18:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1679AB2E5;
        Tue, 27 Oct 2020 11:18:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 32A57DA6E2; Tue, 27 Oct 2020 12:16:32 +0100 (CET)
Date:   Tue, 27 Oct 2020 12:16:32 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 18/68] btrfs: extent_io: calculate inline extent
 buffer page size based on page size
Message-ID: <20201027111632.GB6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201021062554.68132-1-wqu@suse.com>
 <20201021062554.68132-19-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021062554.68132-19-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 21, 2020 at 02:25:04PM +0800, Qu Wenruo wrote:
> -#define INLINE_EXTENT_BUFFER_PAGES 16
> -#define MAX_INLINE_EXTENT_BUFFER_SIZE (INLINE_EXTENT_BUFFER_PAGES * PAGE_SIZE)
> +/*
> + * The SZ_64K is BTRFS_MAX_METADATA_BLOCKSIZE, here just to avoid circle
> + * including "ctree.h".

This should be moved to features.h instead of the duplicate definition.

> + */
> +#define INLINE_EXTENT_BUFFER_PAGES (SZ_64K / PAGE_SIZE)

