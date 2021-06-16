Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C573A9D4A
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jun 2021 16:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbhFPOR0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Jun 2021 10:17:26 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59702 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbhFPOR0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Jun 2021 10:17:26 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0DD671FD47;
        Wed, 16 Jun 2021 14:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623852919;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Awk3J93sSieYJ9LaYGewPF/SAMY1a7sNU5LeVnwiQoI=;
        b=MVShZUgJQuhEMq1Fhw1S54xij3t5N81yHOtkwm24qzd1vaX3rqV15DmNkkTWnTJjVDLrb1
        woSBdfjeH0HQ8cA1wIzHUNbjoIcp0ts5UbJmIjEK+DC5ZWmy4sLInkjbIV/cYNnWaH4Dlk
        oBxcOQot0rwS8LAKSI3MUclY8BBVQ9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623852919;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Awk3J93sSieYJ9LaYGewPF/SAMY1a7sNU5LeVnwiQoI=;
        b=qVd4g6d0h17241TxBk0G9ReeUYgDWdynjxkUgCriYGz7zwXAD+E78CaO4CSjj9F3gFCIju
        DBJrzgFtI5TzAWCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 07DBDA3B88;
        Wed, 16 Jun 2021 14:15:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1A72ADAF29; Wed, 16 Jun 2021 16:12:30 +0200 (CEST)
Date:   Wed, 16 Jun 2021 16:12:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 8/9] btrfs: make btrfs_submit_compressed_write() to
 determine stripe boundary at bio allocation time
Message-ID: <20210616141230.GP28158@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210615121836.365105-1-wqu@suse.com>
 <20210615121836.365105-9-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615121836.365105-9-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 15, 2021 at 08:18:35PM +0800, Qu Wenruo wrote:
> -		page->mapping = NULL;
> -		if (submit || len < PAGE_SIZE) {
> +		if (use_append)
> +			added = bio_add_zone_append_page(bio, page, real_size,
> +					offset_in_page(offset));
> +		else
> +			added = bio_add_page(bio, page, real_size,
> +					offset_in_page(offset));
> +		/* bio_add_zone_append_page() may fail */
> +		ASSERT(added == 0 || added == real_size);
> +		if (added == 0)
> +			submit = true;

What's the point of the assert that also gets checked by a regular 'if'?
Either 'added == 0' is completely invalid (ie programmer error) or it's
an condition that must be handled anyway, either as an error as a
strange but valid case.

> +
> +		cur_disk_bytenr += added;
> +		if (cur_disk_bytenr == next_stripe_start)
> +			submit = true;
> +
> +		if (submit) {
>  			if (!skip_sum) {
>  				ret = btrfs_csum_one_bio(inode, bio, start, 1);
>  				if (ret)
