Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895C140280C
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Sep 2021 13:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244805AbhIGLxW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 07:53:22 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56566 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241698AbhIGLxS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Sep 2021 07:53:18 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F090C1FF73;
        Tue,  7 Sep 2021 11:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631015531;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V6r1m1VOU+XT0s23ae8QR0CnUMs8dUtyVnZbsMI923E=;
        b=zw+lNB9zrIhBRszwRdyydZxIaYi5T+rgYUJAp/0Fl6C+kMsOuTF+H5/HM1zELvIKgugJmx
        2ER0GNstvZvXvZaY1SnU6W0gnhu1lE1xuVUDacq69wxSStlNDNc3DNuKYjOlLlf4x8LqEU
        sBszi44r+0Qi10DSPYLCQmVgkh6lV5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631015531;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V6r1m1VOU+XT0s23ae8QR0CnUMs8dUtyVnZbsMI923E=;
        b=CTVIhM/PqOJQqgMVB6lvHo4MG2CIHhb2HvDQ81ax/y77x5Jb/gqF4JHq2JaggNV2F2deOi
        Fq5PJQJddZinoqCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C0404A3B89;
        Tue,  7 Sep 2021 11:52:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CB9B6DA799; Tue,  7 Sep 2021 13:52:07 +0200 (CEST)
Date:   Tue, 7 Sep 2021 13:52:07 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH 2/6] btrfs: zoned: add a dedicated data relocation block
 group
Message-ID: <20210907115207.GL3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
References: <cover.1630679569.git.johannes.thumshirn@wdc.com>
 <ac2e5fc11c47dfc3626999460f606b980b0f5523.1630679569.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac2e5fc11c47dfc3626999460f606b980b0f5523.1630679569.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 03, 2021 at 11:44:43PM +0900, Johannes Thumshirn wrote:
> index 8cc0b29e24ee..344ba70315d8 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1017,6 +1017,8 @@ struct btrfs_fs_info {
>  	struct mutex zoned_meta_io_lock;
>  	spinlock_t treelog_bg_lock;
>  	u64 treelog_bg;
> +	spinlock_t relocation_bg_lock;
> +	u64 data_reloc_bg;

Please add some comments for the new members.

> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -347,4 +347,13 @@ static inline void btrfs_clear_treelog_bg(struct btrfs_block_group *bg)
>  	spin_unlock(&fs_info->treelog_bg_lock);
>  }
>  
> +static inline void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg)
> +{
> +	struct btrfs_fs_info *fs_info = bg->fs_info;
> +
> +	spin_lock(&fs_info->relocation_bg_lock);
> +	if (fs_info->data_reloc_bg == bg->start)
> +		fs_info->data_reloc_bg = 0;
> +	spin_unlock(&fs_info->relocation_bg_lock);
> +}

This does not look like it's important enough to be static inline.
