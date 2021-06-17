Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC453AB9E7
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Jun 2021 18:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhFQQwB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Jun 2021 12:52:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39172 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhFQQwB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Jun 2021 12:52:01 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DBAE221AB0;
        Thu, 17 Jun 2021 16:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623948592;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uGYkU//QvVmQnvySnjx7DvJsjI5AZu9WZykDQvGwkmA=;
        b=GxZ+dEDrLqr3b/h/oUsh4GXyDzCZGb/9f6/K20LgjtNPrPBy0QuHBy+XHY2lejpUTGhdNI
        Cr3Bq6hTYi4z1avZGqz7RHKImvpUnEWVJyMpEN6gbZUlrGSIHVFcHddkRvDVGA8SW/EPHZ
        QsnNMK6Re/j6132s/qu9QcpvyXe832A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623948592;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uGYkU//QvVmQnvySnjx7DvJsjI5AZu9WZykDQvGwkmA=;
        b=DxOPFAS0zH/7fSaF13MRpTKM/5RmsJPz80b5mU5tg+mAwkTceJn8PtIpyGrLwbwTbxobNe
        K/KZPaEPZPTXK1BA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D4DB0A3BBB;
        Thu, 17 Jun 2021 16:49:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 473A8DAF4C; Thu, 17 Jun 2021 18:47:03 +0200 (CEST)
Date:   Thu, 17 Jun 2021 18:47:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 0/9] btrfs: compression: refactor and enhancement
 preparing for subpage compression support
Message-ID: <20210617164703.GW28158@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210617051450.206704-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617051450.206704-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 17, 2021 at 01:14:41PM +0800, Qu Wenruo wrote:
> There are quite some problems in compression code:
> 
> - Weird compressed_bio::pending_bios dance
>   If we just don't want compressed_bio being freed halfway, we have more
>   sane methods, just like btrfs_subpage::readers.
> 
>   So here we fix it by introducing compressed_bio::io_sectors to do the
>   job.
> 
> - BUG_ON()s inside btrfs_submit_compressed_*()
>   Even they are just ENOMEM, we should handle them.
>   With io_sectors introduced, we have a way to finish compressed_bio
>   all by ourselves, as long as we haven't submitted last bio.
> 
>   If we have last bio submitted, then endio will handle it well.
> 
> - Duplicated code for compressed bio allocation and submission
>   Just small refactor can handle it
> 
> - Stripe boundary is checked every time one page is added
>   This is overkilled.
>   Just learn from extent_io.c refactor which use bio_ctrl to do the
>   boundary check only once for each bio.
> 
>   Although in compression context, we don't need extra checks in
>   extent_io.c, thus we don't need bio_ctrl structure, but
>   can afford to do it locally.
> 
> - Dead code removal
>   One dead comment and a new zombie function,
>   btrfs_bio_fits_in_stripe(), can be removed now.

I went through it several times, the changes are scary, but the overall
direction is IMHO the right one, not to say it's fixing the difficult
BUG_ONs.

I'll put it to for-next once it passes a few rounds of fstests. Taking
it to 5.14 could be risky if we don't have enough review and testing,
time is almost up before the code freeze.
