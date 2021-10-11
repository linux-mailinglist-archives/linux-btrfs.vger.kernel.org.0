Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC214292D3
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 17:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhJKPIS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 11:08:18 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40534 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbhJKPIQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 11:08:16 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D28E31FED2;
        Mon, 11 Oct 2021 15:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633964775;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bXM9DJ5pRf8ErKeYx1orUROwHpZdWv8xNS8XQ/o7UCY=;
        b=MywJN3QYVuKc0mfIiIY3FXVJ3aiB9FF15UFNWh4J17U5+WLx3Xs0hTVksTOI4wPyQe1hLx
        F4ep75oe9oBpi5LchJXRVcdvPLJkWzRh+cGEctbdl2b/unhVUC8BaQq1IEscHFxMLFRrMI
        /JxYLcTpAD787lgM0N/tRHsw84Ih2EY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633964775;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bXM9DJ5pRf8ErKeYx1orUROwHpZdWv8xNS8XQ/o7UCY=;
        b=LWv/SZB9LBYJfuYw+m1vZSekWUFhUyJDD73d8/oXKCQpm5oI3XE5pFiSy4Y3Dt1FQDQQ8O
        IVaOhqL8envjnaBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id CA9F0A3B87;
        Mon, 11 Oct 2021 15:06:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B1B38DA781; Mon, 11 Oct 2021 17:05:52 +0200 (CEST)
Date:   Mon, 11 Oct 2021 17:05:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/5] btrfs: make real_root optional
Message-ID: <20211011150552.GQ9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211011101019.1409855-1-nborisov@suse.com>
 <20211011101019.1409855-6-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011101019.1409855-6-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 11, 2021 at 01:10:19PM +0300, Nikolay Borisov wrote:
> @@ -273,9 +266,10 @@ static inline void btrfs_init_generic_ref(struct btrfs_ref *generic_ref,
>  static inline void btrfs_init_tree_ref(struct btrfs_ref *generic_ref,
>  				int level, u64 root, u64 mod_root, bool skip_qgroup)
>  {
> +#ifdef CONFIG_BTRFS_FS_REF_VERIFY
>  	/* If @real_root not set, use @root as fallback */
> -	if (!generic_ref->real_root)
> -		generic_ref->real_root = root;
> +	generic_ref->real_root = mod_root ? mod_root : root;

	generic_ref->real_root = mod_root ?: root;

Ie. the short form where the true branch only repeats the condition.
