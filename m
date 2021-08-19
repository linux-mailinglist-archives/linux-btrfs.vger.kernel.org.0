Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2443F19A4
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 14:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbhHSMqy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 08:46:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58054 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhHSMqy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 08:46:54 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 454851FD93;
        Thu, 19 Aug 2021 12:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629377177;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=syOl1wIF4ZRY3cqg0SvvmfTwAKHTCFbmf8FgoKp4JWY=;
        b=m2ULwAxjchaxpBfpKIddLf45X89ozMvfudBnaJf7+5ucVRFA2hRNfnwbTCM77S07LtK1Fz
        kLtGC7m7xwlr3lathDw4MbKZUJzweAXTxjjJ+A/WjSfcwpwMoRUMz23iWn8AwVciOXhcHS
        GCR7cbmiwutIGTI81EngPqgxw7SPO5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629377177;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=syOl1wIF4ZRY3cqg0SvvmfTwAKHTCFbmf8FgoKp4JWY=;
        b=FUEOS+NnXJhq2g+9or8IcaxbjCqrc+EsRHulbJetEGWroZcQPIvwYGCdsX2vkrFWri5xaK
        Swkb6HVt5ldjb9BQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id AD75BA3B8D;
        Thu, 19 Aug 2021 12:45:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0645BDA72C; Thu, 19 Aug 2021 14:43:19 +0200 (CEST)
Date:   Thu, 19 Aug 2021 14:43:19 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: drop ret in ioctl_quota_rescan_status
Message-ID: <20210819124319.GH5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <c37927ff2082701c940d0aaad2301e4774159d74.1627452869.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c37927ff2082701c940d0aaad2301e4774159d74.1627452869.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 28, 2021 at 02:20:41PM +0800, Anand Jain wrote:
> There is no need for the variable ret after the patch [1]. Drop it.
>  btrfs: Allocate btrfs_ioctl_quota_rescan_args on stack
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Added to misc-next, thanks.

> ---
> David,
> 
>  You may choose to roll this patch into the following patch,
>   [PATCH 5/7] btrfs: Allocate btrfs_ioctl_quota_rescan_args on stack

Too late and it's an separate change anyway.
