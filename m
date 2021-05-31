Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21AEC396801
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 May 2021 20:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbhEaSmN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 May 2021 14:42:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:54480 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230523AbhEaSmL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 May 2021 14:42:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622486430;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tQU9LtNUXvJPyRIruxv/H/Q75k7tmGswrb70kM4YDfA=;
        b=ESwsnRMctCE2LrX0oxbPMVSC7tBAYYRMZLkPqMThuaQlqmJp6+DN/mWTLT7WdeDn1nlxsd
        I6ML4Sg8lJR6Lal9hM/XfszdvzZGpV5suQgMzHxdpAj5OPljHLhifsJ8WqBax6UFJ8YYZY
        JOJR/vra6+7F4A8P5VMxyc97M+Q65y4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622486430;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tQU9LtNUXvJPyRIruxv/H/Q75k7tmGswrb70kM4YDfA=;
        b=z7YoVBuGbDMmvcHMkv1xvmYCIpTpzj4NT1IVus/A4jAZmLB03ukGJgNXVU1iIs6RWepR5E
        9DdhkFpvZuzBvmAA==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 80B55B9E9;
        Mon, 31 May 2021 18:40:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F2AABDA70B; Mon, 31 May 2021 20:37:50 +0200 (CEST)
Date:   Mon, 31 May 2021 20:37:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] variables fixes in compression.c
Message-ID: <20210531183750.GC31483@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1622252932.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1622252932.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 29, 2021 at 05:48:32PM +0800, Anand Jain wrote:
> Patch (btrfs: reduce compressed_bio member's types) reduced the
> size to unsigned int as in [1]. Fix its cascading effects here.
> And one stale comment in the patch 4/4.
> 
> [1]
> -       unsigned long len;
> +       unsigned int len;
> 
> -       int compress_type;
> +       u8 compress_type;
> 
> -       unsigned long nr_pages;
> +       unsigned int nr_pages;
> 
> -       unsigned long compressed_len;
> +       unsigned int compressed_len;
> 
> -       int errors;
> +       u8 errors;
> 
> As shown in [2], we set the max compressable block size to 128K. So
> struct async_extent can reduce some of its members to unsigned int as
> well.
> 
> [2]
> static noinline int compress_file_range(struct async_chunk *async_chunk)
> ::
>   617         total_compressed = min_t(unsigned long, total_compressed,
>   618                         BTRFS_MAX_UNCOMPRESSED);
> 
> But changes touches too many places, and my first attempt to fix
> is unsatisfactory to me, so I am just sending the changes limited to the
> file compression.c.

That's fin. As long as a patch does one change (possibly cascading to
more places) it should be doable step by step.

> Anand Jain (4):
>   btrfs: optimize users of members of the struct compressed_bio
>   btrfs: optimize variables size in btrfs_submit_compressed_read
>   btrfs: optimize variables size in btrfs_submit_compressed_write
>   btrfs: fix comment about max_out in btrfs_compress_pages

Added to misc-next, thanks.
