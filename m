Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4625429AA77
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 12:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438698AbgJ0LWU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Oct 2020 07:22:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:46280 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438691AbgJ0LWU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Oct 2020 07:22:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D7F8EB1EC;
        Tue, 27 Oct 2020 11:22:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 11D7CDA6E2; Tue, 27 Oct 2020 12:20:44 +0100 (CET)
Date:   Tue, 27 Oct 2020 12:20:43 +0100
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 18/68] btrfs: extent_io: calculate inline extent
 buffer page size based on page size
Message-ID: <20201027112043.GC6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201021062554.68132-1-wqu@suse.com>
 <20201021062554.68132-19-wqu@suse.com>
 <20201027111632.GB6756@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027111632.GB6756@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 27, 2020 at 12:16:32PM +0100, David Sterba wrote:
> On Wed, Oct 21, 2020 at 02:25:04PM +0800, Qu Wenruo wrote:
> > -#define INLINE_EXTENT_BUFFER_PAGES 16
> > -#define MAX_INLINE_EXTENT_BUFFER_SIZE (INLINE_EXTENT_BUFFER_PAGES * PAGE_SIZE)
> > +/*
> > + * The SZ_64K is BTRFS_MAX_METADATA_BLOCKSIZE, here just to avoid circle
> > + * including "ctree.h".
> 
> This should be moved to features.h instead of the duplicate definition.

So features.h was some leftover in my tree, we don't have that file yet,
this will need a cleanup first. I'll keep the patch in series so we can
test it but it won't be in the final version I hope.
