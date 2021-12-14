Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A7F4742D1
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Dec 2021 13:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbhLNMmM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Dec 2021 07:42:12 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35364 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhLNMmM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Dec 2021 07:42:12 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 40D09212B5;
        Tue, 14 Dec 2021 12:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639485731;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RGf20RQydftTMmwDZI2SFMWRdnA+78oBxJI3z0911T8=;
        b=nM5WJeIRBuSBHnFugSLiBsn8OkoTkLvmzww672ssj4y87nRWJ6bZeTaPwL5mMX/Lm0U6M+
        sr1YU0OVb4wncy8o0NSnJTeSWWx9sKKPApOIxDKXQLJTEzD+3DiQbopfi+jMlrAoswhnhd
        v60twDaWQO/yJHJe9KB9g5ynxuiBVLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639485731;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RGf20RQydftTMmwDZI2SFMWRdnA+78oBxJI3z0911T8=;
        b=ITalW+iLats5nMzrPY8cjkbHByz+jmhcO96ip2+2Wz5Tx5N8DmvE1Ohlp0KLHwFVIN7SnQ
        YqEylfN0Zu3HzxDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 3A556A3B81;
        Tue, 14 Dec 2021 12:42:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E843BDA781; Tue, 14 Dec 2021 13:41:52 +0100 (CET)
Date:   Tue, 14 Dec 2021 13:41:52 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: use btrfs_path::reada to replace the
Message-ID: <20211214124152.GQ28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211213131054.102526-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213131054.102526-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 13, 2021 at 09:10:51PM +0800, Qu Wenruo wrote:
> [PROBLEMS]
> The metadata readahead code is introduced in 2011 (surprisingly, the
> commit message even contains changelog), but now there is only one user
> for it, and even for the only one user, the readahead mechanism can't
> provide all it needs:
> 
> - No support for commit tree readahead
>   Only support readahead on current tree.
> 
> - Bad layer separation
>   To manage on-fly bios, btrfs_reada_add() mechanism internally manages
>   a kinda complex zone system, and it's bind to per-device.
> 
>   This is against the common layer separation, as metadata should all be
>   in btrfs logical address space, should not be bound to device physical
>   layer.
> 
>   In fact, this is the cause of all recent reada related bugs.
> 
> - No caller for asynchronous metadata readahead
>   Even btrfs_reada_add() is designed to be fully asynchronous, scrub
>   only calls it in a synchronous way (call btrfs_reada_add() and
>   immediately call btrfs_reada_wait()).
>   Thus rendering a lot of code unnecessary.

I agree with removing the reada.c code, it's overengineered perhaps with
intentions to use it in more places but this hasn't happened and nobody
is interested doing the work. We have the path readahead so it's not
we'd lose readahead capabilities at all.

Thanks for benchmarking it, the drop is acceptable and we know people
are more interested in limiting the load anyway.

> [BENCHMARK]
> The conclusion looks like this:
> 
> For the worst case (no dirty metadata, slow HDD), there will be around 5%
> performance drop for scrub.
> For other cases (even SATA SSD), there is no distinguishable performance
> difference.
> 
> The number is reported scrub speed, in MiB/s.
> The resolution is limited by the reported duration, which only has a
> resolution of 1 second.
> 
> 	Old		New		Diff
> SSD	455.3		466.332		+2.42%
> HDD	103.927 	98.012		-5.69%

I'll copy this information to the last patch changelog.
