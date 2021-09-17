Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83BF40F609
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Sep 2021 12:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243423AbhIQKih (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Sep 2021 06:38:37 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51918 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243060AbhIQKie (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Sep 2021 06:38:34 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 377821FDBD;
        Fri, 17 Sep 2021 10:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631875032;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DW643zk/tRIL2iWQYjZJweN/YE4S1kW4zWneCrbsO1A=;
        b=0mXHGc6bcz/pitS7ypBotVcZh9G0zpbq5Z8N7VGeuF+groYnZUI0L95EiEftxBDeEFint2
        QmHnWTOxDsVyIs4OXtdXLsKLOCnAfZ7QyHn1SNjL9S1RL+npk0neDSUc5gubxI1eklp2x5
        SFupPA96PQNUcHSC2Ouye4efvuYxeXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631875032;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DW643zk/tRIL2iWQYjZJweN/YE4S1kW4zWneCrbsO1A=;
        b=dK1Jzeg4qw2P8GfbzZYmG5caZ+mAWAZdTKslQ8AH44XvHA1GaOuucrp1sQpsPlbVZbB94p
        Efst3ji6Ku+IjqCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 30E7DA3B8A;
        Fri, 17 Sep 2021 10:37:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A3662DA781; Fri, 17 Sep 2021 12:37:02 +0200 (CEST)
Date:   Fri, 17 Sep 2021 12:37:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Eli V <eliventer@gmail.com>
Subject: Re: [PATCH] btrfs: prevent __btrfs_dump_space_info() to underflow
 its free space
Message-ID: <20210917103702.GJ9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Eli V <eliventer@gmail.com>
References: <20210916124329.65141-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916124329.65141-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 16, 2021 at 08:43:29PM +0800, Qu Wenruo wrote:
> It's not uncommon where __btrfs_dump_space_info() get called
> under over-commit situations.
> 
> In that case free space would underflow as total allocated space is not
> enough to handle all the over-committed space.
> 
> Such underflow values can sometimes cause confusion for users enabled
> enospc_debug mount option, and takes some seconds for developers to
> convert the underflow value to signed result.
> 
> Just output the free space as s64 to avoid such problem.
> 
> Reported-by: Eli V <eliventer@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/CAJtFHUSy4zgyhf-4d9T+KdJp9w=UgzC2A0V=VtmaeEpcGgm1-Q@mail.gmail.com/
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
