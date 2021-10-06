Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C874246EA
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Oct 2021 21:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239615AbhJFTkx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Oct 2021 15:40:53 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35366 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239474AbhJFTkk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Oct 2021 15:40:40 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 512F41FF00;
        Wed,  6 Oct 2021 19:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633549127;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5bNg4XaJdxzYEAdHhRIJcgivQE1VfpRN1nf9YUK22no=;
        b=e+IvrcqfcXQAcZESPqax5XS09IXQkaOnMtISZUYHLfUeOgSE5KNZyc80+jUk3ZDK2W5qQ2
        Z6KiotaYzv/x6xUOGdEOcVM01ShSCPqgcRjC2U4wCxdYSDZQOuOKzKh7v0vH3P074gj/yt
        dOg7ADyIE1M4G+HXIixeW9l5+5B9qlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633549127;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5bNg4XaJdxzYEAdHhRIJcgivQE1VfpRN1nf9YUK22no=;
        b=9xqp3ezaklvrPo2b0gErTuFqY6im15HcjniHsuEcf2aQAOVMp3O/3bEYMM7X//3QAeL2kd
        5hleVk0riE8k6NCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 4358AA3B95;
        Wed,  6 Oct 2021 19:38:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E38FCDA7F3; Wed,  6 Oct 2021 21:38:26 +0200 (CEST)
Date:   Wed, 6 Oct 2021 21:38:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] btrfs: refactor how we handle btrfs_io_context
 and slightly reduce memory usage for both btrfs_bio and btrfs_io_context
Message-ID: <20211006193826.GX9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210922082706.55650-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922082706.55650-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 22, 2021 at 04:27:03PM +0800, Qu Wenruo wrote:
> Currently btrfs_io_context is utilized as both bio->bi_private for
> mirrored stripes, and stripes mapping for RAID56.
> 
> This makes some members like btrfs_io_context::private to be there.
> 
> But in fact, since almost all bios in btrfs have btrfs_bio structure
> appended, we don't really need to reuse bio::bi_private for mirrored
> profiles.
> 
> So this patchset will:
> 
> - Introduce btrfs_bio::bioc member
>   So that btrfs_io_context don't need to hold @private.
>   This modification is still a net increase for memory usage, just
>   a trade-off between btrfs_io_context and btrfs_bio.
> 
> - Replace btrfs_bio::device with btrfs_bio::stripe_num
>   This reclaim the memory usage increase for btrfs_bio.
> 
>   But unfortunately, due to the short life time of btrfs_io_context,
>   we don't have as good device status accounting as the old code.
> 
>   Now for csum error, we can no longer distinguish source and target
>   device of dev-replace.
> 
>   This is the biggest blockage, and that's why it's RFC.
> 
> The result of the patchset is:
> 
> btrfs_bio:		size: 240 -> 240
> btrfs_io_context:	size: 88 -> 80
> 
> Although to really reduce btrfs_bio, the main target should be
> csum_inline.
> 
> Qu Wenruo (3):
>   btrfs: add btrfs_bio::bioc pointer for further modification
>   btrfs: remove redundant parameters for submit_stripe_bio()
>   btrfs: replace btrfs_bio::device member with stripe_num

Can you please refresh the patchset on top current misc-next?
