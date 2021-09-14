Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8EF40B490
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 18:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhINQ1V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 12:27:21 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52998 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhINQ1U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 12:27:20 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 35F1022108;
        Tue, 14 Sep 2021 16:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631636762;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GNMA0Wb7ATZ5CV08SuI8sVfSlToW9Ccfldwu65GosG4=;
        b=G0JKQVxJNZ3GRWNXmjeLwvnvzvDCLu8/OlWSVbfwRvRyNpN3k6d9pnhMhLaTx+IgiXL+Gy
        Wgl15PZjEyr8XmB7iKoMoeiJo/O/DJ9YSDErNBxEiGZHO0rTrSnjIC1C6WX1E7pwdIQ3fK
        mIT4hkZ3gCbpZQXnXeOlHw1uFJiMaPs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631636762;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GNMA0Wb7ATZ5CV08SuI8sVfSlToW9Ccfldwu65GosG4=;
        b=81tfk9rw9Win5NG4pSNiugbg8KryUO7q+5gufF2I1FaztHQaRNVhhreDQdju8CNDTluLt7
        bbOWV2tTehA1M7BQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2FCC6A3B91;
        Tue, 14 Sep 2021 16:26:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 35541DA781; Tue, 14 Sep 2021 18:25:54 +0200 (CEST)
Date:   Tue, 14 Sep 2021 18:25:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] btrfs: btrfs_bio and btrfs_io_bio rename
Message-ID: <20210914162553.GE9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210914012543.12746-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914012543.12746-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 14, 2021 at 09:25:40AM +0800, Qu Wenruo wrote:
> The branch can be fetched from github, and is the preferred way to grab
> the code, as this patchset changed quite a lot of code.
> https://github.com/adam900710/linux/tree/chunk_refactor
> 
> There are two structure, btrfs_io_bio and btrfs_bio, which have very
> similar names but completely different meanings.
> 
> Btrfs_io_bio mostly works at logical bytenr layer (its
> bio->bi_iter.bi_sector points to btrfs logical bytenr), and just
> contains extra info like csum and mirror_num.
> 
> And btrfs_io_bio is in fact the most utilized bio, as all data/metadata
> IO is using btrfs_io_bio.
> 
> While btrfs_bio is completely a helper structure for stripe IO
> submission (RAID56 doesn't utilize it for IO submission).
> 
> Such naming is completely anti-human.
> 
> So this patchset will do the following renaming:
> 
> - btrfs_bio -> btrfs_io_context
>   Since it's not really used by all bios (only mirrored profiles utilize
>   it), and it contains extra info for RAID56, it's not proper to name it
>   with _bio suffix.
> 
>   Later we can integrate btrfs_io_context pointer into the new
>   btrfs_bio.
> 
> - btrfs_io_bio -> btrfs_bio
>   I originally plan to rename it to btrfs_logical_bio, but it's a little
>   too long for a lot of functions.

This sounds all good. The only dangerous thing is that btrfs_bio now
means something else, so that can become problem with backports or
requiring to do a mental switch when reading before/after the version it
appears.
