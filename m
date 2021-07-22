Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E523D25D1
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 16:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbhGVNuv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 09:50:51 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58390 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbhGVNtI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 09:49:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 64064203CC;
        Thu, 22 Jul 2021 14:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626964182;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eCe2gH6jto4Zsy4WkvmIathKvwbuE4/ewnVPb5D9qKY=;
        b=oEsNDpjnkdYa4wFyNPWFex2TAjor4gX/ki+jtlSph9gRbWuQWHWZU+0JJ3n9qD8KvgdELu
        alIzj2Ntd2Ad5TaGtLqqfQtffnRJY7MHvoWnrc/aKoW8eqM49vwyvAKuo/Nr9VzQuHaYx8
        ApBGBGWsgpH0QZUqR5QA9MMljCeByQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626964182;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eCe2gH6jto4Zsy4WkvmIathKvwbuE4/ewnVPb5D9qKY=;
        b=ecxm7rOw9zRISYnK0zuwpdLUIgcgrKYcWzcDgSB3AksZBrSvgm9y8c/9Vi0SkTmS1H7PvS
        vHKoND3RxPAakaBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5D198A5045;
        Thu, 22 Jul 2021 14:29:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B59CDDAF95; Thu, 22 Jul 2021 16:27:00 +0200 (CEST)
Date:   Thu, 22 Jul 2021 16:27:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Joshua <joshua@mailmag.net>
Subject: Re: [PATCH] btrfs-progs: check: speed up v1 space cache clearing by
 batching more space cache inode deletion in one trans
Message-ID: <20210722142700.GY19710@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Joshua <joshua@mailmag.net>
References: <20210719020402.98081-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719020402.98081-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 19, 2021 at 10:04:02AM +0800, Qu Wenruo wrote:
> Currently v1 space cache clearing will delete one cache inode just in
> one transaction, and then start a new transaction to delete the next
> inode.
> 
> This is far from efficient and can make the already slow v1 space cache
> deleting even slower, as large fs has tons of cache inodes to delete.
> 
> This patch will speed up the process by batching up to 16 inode deletion
> into one transaction.
> 
> A quick benchmark of deleting 702 v1 space cache inodes would look like
> this:
> 
> Unpatched:		4.898s
> Patched:		0.087s
> 
> Which is obviously a big win.
> 
> Reported-by: Joshua <joshua@mailmag.net>
> Link: https://lore.kernel.org/linux-btrfs/0b4cf70fc883e28c97d893a3b2f81b11@mailmag.net/
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Nice, added to devel, thanks.
