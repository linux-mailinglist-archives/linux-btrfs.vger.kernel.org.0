Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4403ED8B9
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Aug 2021 16:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhHPOM3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Aug 2021 10:12:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56368 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhHPOM3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Aug 2021 10:12:29 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 185EA1FE70;
        Mon, 16 Aug 2021 14:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629123117;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+P2ICjP07Ozu8JGzsZyg2uYtqEVI3nHnPRO82jJ6Nlo=;
        b=qxnEFSAJY21Xq3+g5bkGMci0AZTdS3Y+A9hx+t8gVyxocDAMrYA+pZz0To6lMkpyNXbBR7
        zWg6C6X0pkk600G8dnTpuhypbCxjfvS0WM5qh5sFeOvauX+qDGwoYlU84bfJ/Mk0Mg+qwG
        ntZgDIvTv0VFf9FP494DWcPvfThidr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629123117;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+P2ICjP07Ozu8JGzsZyg2uYtqEVI3nHnPRO82jJ6Nlo=;
        b=mGLNlVIDMa2eEVDriawVaOd5TdMAEuZz9LPo/5L6gBl5a6o5ZxPhNLnmunfM/hF2J49UFB
        +I6EG6FzaylIeFCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DB490A3B87;
        Mon, 16 Aug 2021 14:11:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3E36DDA72C; Mon, 16 Aug 2021 16:09:01 +0200 (CEST)
Date:   Mon, 16 Aug 2021 16:09:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] btrfs: zoned: fix ordered extent boundary calculation
Message-ID: <20210816140901.GC5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Qu Wenruo <wqu@suse.com>
References: <20210811063708.2520540-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811063708.2520540-1-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 11, 2021 at 03:37:08PM +0900, Naohiro Aota wrote:
> btrfs_lookup_ordered_extent() should be queried with the offset in a file
> instead of the logical address. Pass the file offset from
> submit_extent_page() to calc_bio_boundaries().
> 
> Also, calc_bio_boundaries() relies on the bio's operation flag, so move the
> call site after setting it.
> 
> Fixes: 390ed29b817e ("btrfs: refactor submit_extent_page() to make bio and its flag tracing easier")
> Cc: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Added to misc-next, thanks.
