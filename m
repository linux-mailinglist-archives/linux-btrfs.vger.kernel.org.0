Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75EE493ED8
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jan 2022 18:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356336AbiASRLw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jan 2022 12:11:52 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:38172 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243695AbiASRLt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jan 2022 12:11:49 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C648421129;
        Wed, 19 Jan 2022 17:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642612308;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iscklb6rToumph0dHpa9uhJ9CeXnPHoeLu887l7F4/w=;
        b=RKeh4xLroqGtyoKD9ZU2tVC1kwZIg1SgfVWKgwp9CMFoD1naievPGqlIBc/TrEMz5rUMib
        2HDpejaQz2p2lCdFN1zjXOJJ6miZzErZN1kwAgAwlYHIm42wLwE0e7VCFSpiFzgJXSWlkc
        /HUiJl33rn/9ooy1T8U5EHdUpq8oGPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642612308;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iscklb6rToumph0dHpa9uhJ9CeXnPHoeLu887l7F4/w=;
        b=6yPf4ACNL3muVH8LLkdJQZVVmoAOgPNUorHBj61J+Meantu6GDQQ/qOrNgE8frY1fJFf4L
        HbdxItiaTLestjCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BBFA4A3B89;
        Wed, 19 Jan 2022 17:11:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8F28EDA7A3; Wed, 19 Jan 2022 18:11:11 +0100 (CET)
Date:   Wed, 19 Jan 2022 18:11:11 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: allow defrag to be interruptible
Message-ID: <20220119171111.GP14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <0b7b9259d4e0a874aedbabe74d3719a4aaace586.1642437610.git.fdmanana@suse.com>
 <9a755aa9a3528e385c6dee47e536cd2fe539ab59.1642513202.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a755aa9a3528e385c6dee47e536cd2fe539ab59.1642513202.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 18, 2022 at 01:43:31PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> During defrag, at btrfs_defrag_file(), we have this loop that iterates
> over a file range in steps no larger than 256K subranges. If the range
> is too long, there's no way to interrupt it. So make the loop check in
> each iteration if there's signal pending, and if there is, break and
> return -AGAIN to userspace.
> 
> Before kernel 5.16, we used to allow defrag to be cancelled through a
> signal, but that was lost with commit 7b508037d4cac3 ("btrfs: defrag:
> use defrag_one_cluster() to implement btrfs_defrag_file()").
> 
> This change adds back the possibility to cancel a defrag with a signal
> and keeps the same semantics, returning -EAGAIN to user space (and not
> the usually more expected -EINTR).
> 
> This is also motivated by a recent bug on 5.16 where defragging a 1 byte
> file resulted in iterating from file range 0 to (u64)-1, as hitting the
> bug triggered a too long loop, basically requiring one to reboot the
> machine, as it was not possible to cancel defrag.
> 
> Fixes: 7b508037d4cac3 ("btrfs: defrag: use defrag_one_cluster() to implement btrfs_defrag_file()")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> v2: Add Fixes tag, as it's actually a regression introduced in 5.16.
>     Use the helper btrfs_defrag_cancelled() instead of fatal_signal_pending()
>     and return -EAGAIN instead of -EINTR to userspace, as that is what used
>     to be returned before 5.16.

Added to misc-next, thanks.
