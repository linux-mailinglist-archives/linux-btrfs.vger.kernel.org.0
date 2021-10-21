Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B3D436632
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 17:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbhJUP15 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 11:27:57 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50944 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbhJUP1h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 11:27:37 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C48A72198C;
        Thu, 21 Oct 2021 15:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634829919;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kKIH+gH7NdjKqlzvhaW5rl06RBoj/DN0/vysVoGWrH8=;
        b=o7Onh5ywkplHGJQQNCoouqRZY4tOpfof1uZ0P7Ok0is4skG1eAXO/V+a/4gKCdM0Xr/Qjd
        YPec07cu1ZbvaF+EVgDuO+r7ZsNWrTSKTSAl1E91m6KMc2BmEHmeypkuFA+8QjV1km3AG9
        DVr99y7XQVoh2o1Hr7jjySngKyJbq9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634829919;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kKIH+gH7NdjKqlzvhaW5rl06RBoj/DN0/vysVoGWrH8=;
        b=jOW6ffDqUgZqfXHsCqVetUa6/l9PMxKwfmT2RpdMuONpWeyhART7r7hb6IGRxg0M9FY9Pp
        iaqfakI8EwNTVdBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BE3DDA3B84;
        Thu, 21 Oct 2021 15:25:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 15FCADA7A3; Thu, 21 Oct 2021 17:24:50 +0200 (CEST)
Date:   Thu, 21 Oct 2021 17:24:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: make sizeof(struct btrfs_super_block) to match
 BTRFS_SUPER_INFO_SIZE
Message-ID: <20211021152450.GA20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211020234447.5578-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020234447.5578-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 21, 2021 at 07:44:47AM +0800, Qu Wenruo wrote:
> It's a common practice to avoid use sizeof(struct btrfs_super_block)
> (3531), but to use BTRFS_SUPER_INFO_SIZE (4096).
> 
> The problem is that, sizeof(struct btrfs_super_block) doesn't match
> BTRFS_SUPER_INFO_SIZE from the very beginning.
> 
> Furthermore, for all call sites except selftest, we always allocate
> BTRFS_SUPER_INFO_SIZE space for btrfs super block, there isn't any real
> reason to use the smaller value, and it doesn't really save any space.
> 
> So let's get rid of such confusing behavior, and unify those two values.
> 
> This modification also adds a new static_assert() to verify the size,
> and moves the BTRFS_SUPER_INFO_* macros to the definition of
> btrfs_super_block for the static_assert().
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
