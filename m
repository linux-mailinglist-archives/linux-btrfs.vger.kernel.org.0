Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB9D4836D3
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jan 2022 19:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbiACS1i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jan 2022 13:27:38 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57934 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbiACS1h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jan 2022 13:27:37 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 59717210F7;
        Mon,  3 Jan 2022 18:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641234456;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N0VRBtg6V9GDoGo9gDzncefKbk0iCyX0aKCwEEj7EXU=;
        b=fzbwzY8up9uniFQjhRkvQKMag+Xg6Oe1noteTvBzcM2EpbP/o4Yj3Ckhwg1h4hBfm+GPlF
        IKjBjwIpWwekudMmtwlUqkzgg600V4OTRcWr/CAY7s5gHtgxHrIliacJV0H3Een/3pnUKt
        uY/jldhAMf/QA+kUEexhwCf/d6We/SM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641234456;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N0VRBtg6V9GDoGo9gDzncefKbk0iCyX0aKCwEEj7EXU=;
        b=R7Pe65DCh/fwlebIpH2uAz2PIjYlGIuBrGyePS9pcx63+95rYCT24NBon5KhViWm5d9Qt1
        9l8AR4wEipSIR5DQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2C5A5A3B81;
        Mon,  3 Jan 2022 18:27:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6DF30DA729; Mon,  3 Jan 2022 19:27:07 +0100 (CET)
Date:   Mon, 3 Jan 2022 19:27:07 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     dsterba@suse.cz, clm@fb.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] btrfs: Fix argument list that the kdoc format and
 script verified.
Message-ID: <20220103182707.GO28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Yang Li <yang.lee@linux.alibaba.com>,
        clm@fb.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20211220072306.42133-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220072306.42133-1-yang.lee@linux.alibaba.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 20, 2021 at 03:23:06PM +0800, Yang Li wrote:
> The warnings were found by running scripts/kernel-doc, which is
> caused by using 'make W=1'.
> 
> fs/btrfs/extent_io.c:3210: warning: Function parameter or member
> 'bio_ctrl' not described in 'btrfs_bio_add_page'
> fs/btrfs/extent_io.c:3210: warning: Excess function parameter 'bio'
> description in 'btrfs_bio_add_page'
> fs/btrfs/extent_io.c:3210: warning: Excess function parameter
> 'prev_bio_flags' description in 'btrfs_bio_add_page'
> fs/btrfs/space-info.c:1602: warning: Excess function parameter 'root'
> description in 'btrfs_reserve_metadata_bytes'
> fs/btrfs/space-info.c:1602: warning: Function parameter or member
> 'fs_info' not described in 'btrfs_reserve_metadata_bytes'
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Added to misc-next, thanks. I've added a note why it's fixing only the
parameter warnings.
