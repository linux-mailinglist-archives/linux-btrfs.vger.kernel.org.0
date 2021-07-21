Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7AC3D1529
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 19:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhGUQzH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 12:55:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52890 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhGUQzH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 12:55:07 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BE4A822497;
        Wed, 21 Jul 2021 17:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626888942;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vdM34uScEulloRuDsYtcl7lmcehRhE8UOvArhjA3Upg=;
        b=gzaoXlcsMvleQAQMf9yUd4jAHyNd0bE/yQCmxHu5Sgi3mtV/+wTrJv0xVumTrL6ANTTCqc
        hBkcAh74AS+c7tgmVBIElb3j9MMdzLm+nDc4xdqJFVVGTpBa57T5yu0Vp7XwNKyfI1yOHg
        V14qTq4JtwJsPQj9dVLVadICbFUze6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626888942;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vdM34uScEulloRuDsYtcl7lmcehRhE8UOvArhjA3Upg=;
        b=+Usa1kH2kvsR0qGq18Vp7vH+cSJ5r09IfcWw5WcWKfHA6cUYVIgJEHYCKukN8N42jeCbPe
        Ci1KGdPMAetxGKBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B61FFA3B83;
        Wed, 21 Jul 2021 17:35:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 86913DA704; Wed, 21 Jul 2021 19:33:01 +0200 (CEST)
Date:   Wed, 21 Jul 2021 19:33:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Zhenyu Wu <wuzy001@gmail.com>
Subject: Re: [PATCH v4] btrfs: rescue: allow ibadroots to skip bad extent
 tree when reading block group items
Message-ID: <20210721173301.GM19710@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Zhenyu Wu <wuzy001@gmail.com>
References: <20210719054304.181509-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719054304.181509-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 19, 2021 at 01:43:04PM +0800, Qu Wenruo wrote:
> When extent tree gets corrupted, normally it's not extent tree root, but
> one toasted tree leaf/node.
> 
> In that case, rescue=ibadroots mount option won't help as it can only
> handle the extent tree root corruption.
> 
> This patch will enhance the behavior by:
> 
> - Allow fill_dummy_bgs() to ignore -EEXIST error
> 
>   This means we may have some block group items read from disk, but
>   then hit some error halfway.
> 
> - Fallback to fill_dummy_bgs() if any error gets hit in
>   btrfs_read_block_groups()
> 
>   Of course, this still needs rescue=ibadroots mount option.
> 
> With that, rescue=ibadroots can handle extent tree corruption more
> gracefully and allow a better recover chance.
> 
> Reported-by: Zhenyu Wu <wuzy001@gmail.com>
> Link: https://www.spinics.net/lists/linux-btrfs/msg114424.html
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Don't try to fill with dummy block groups when we hit ENOMEM
> v3:
> - Remove a dead condition
>   The empty fs_info->extent_root case has already been handled.
> v4:
> - Skip to next block group if we hit EEXIST when inserting the block
>   group cache

Added to misc-next, thanks.
