Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F03419F18
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 21:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbhI0T2P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 15:28:15 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36278 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbhI0T2O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 15:28:14 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out2.suse.de (Postfix) with ESMTP id BF9B31FF70;
        Mon, 27 Sep 2021 19:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632770795;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X7tJAlMOltgLYFO9ljBjewotozXZLEfuXLRh0kVD3Yc=;
        b=JQTmeIoe6/AbcDQfsXm2PpDbDyH5KYaElINWn2HxYoyRAgiR0O1Tm5ltWSWR5vwU0dwHd8
        KKqQZUCkLtz47LmjPjDmZ+WBnlw2dZprWyIMX/YNf1/Ma+eE1ikSuouxZuKPcfp13Uyyc8
        v09rVQTT3zaAd5GbRQJtEkRwcMk8iis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632770795;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X7tJAlMOltgLYFO9ljBjewotozXZLEfuXLRh0kVD3Yc=;
        b=2WDuBAt4uYbVtGkufeKEwx00RL2WZBcFtGWOjDUx2N5QQ41WCLVZANai8tg4PVs9nkFn+9
        /xhWooc+qLwURbDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay1.suse.de (Postfix) with ESMTP id 90A9625D3E;
        Mon, 27 Sep 2021 19:26:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B2D85DA799; Mon, 27 Sep 2021 21:26:19 +0200 (CEST)
Date:   Mon, 27 Sep 2021 21:26:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 0/5] btrfs-progs: use direct-IO for zoned device
Message-ID: <20210927192618.GF9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <20210927041554.325884-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927041554.325884-1-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 27, 2021 at 01:15:49PM +0900, Naohiro Aota wrote:
> As discussed in the Zoned Storage page [1],  the kernel page cache does not
> guarantee that cached dirty pages will be flushed to a block device in
> sequential sector order. Thus, we must use O_DIRECT for writing to a zoned
> device to ensure the write ordering.
> 
> [1] https://zonedstorage.io/linux/overview/#zbd-support-restrictions
> 
> As a writng buffer is embedded in some other struct (e.g., "char data[]" in
> struct extent_buffer), it is difficult to allocate the struct so that the
> writng buffer is aligned.
> 
> This series introduces btrfs_{pread,pwrite} to wrap around pread/pwrite,
> which allocates an aligned bounce buffer, copy the buffer contents, and
> proceeds the IO. And, it now opens a zoned device with O_DIRECT.
> 
> Since the allocation and copying are costly, it is better to do them only
> when necessary. But, it is cumbersome to call fcntl(F_GETFL) to determine
> the file is opened with O_DIRECT or not every time doing an IO.

This should be in the changelog somewhere too, the last patch looks like
a good place so I'll copy it there.

> As zoned device forces to use zoned btrfs, I decided to use the zoned flag
> to determine if it is direct-IO or not. This can cause a false-positive (to
> use the bounce buffer when a file is *not* opened with O_DIRECT) in case of
> emulated zoned mode on a non-zoned device or a regular file. Considering
> the emulated zoned mode is mostly for debugging or testing, I believe this
> is acceptable.

Agreed.

All patches added to devel. Would be good to add some tests for the
emulated mode, ie. that we can test at least something regularly without
special devices.
