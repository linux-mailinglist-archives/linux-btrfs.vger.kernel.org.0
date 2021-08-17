Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD0F3EED8B
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Aug 2021 15:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237483AbhHQNgS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Aug 2021 09:36:18 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33504 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239821AbhHQNgO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Aug 2021 09:36:14 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C094220020;
        Tue, 17 Aug 2021 13:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629207340;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u0itKm+Q7EH0D8UH+HL8uqP+Miw0841rYeSaIpU7rxU=;
        b=HMevSrYnyHIhJsIUTJlEdsHcmVH821mKKB7tUPsi83nHstGjax0qsa9/gJDGxxGCTe9Ap7
        D7PA8X3dQLFEha43GNkk2PqPalGoUpAFDILr/jCVCX0pgpty57+y840WrGyElsEwSkqC5F
        vGUBP7ShkFp8fuzyPBbIiNOxMADAgxw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629207340;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u0itKm+Q7EH0D8UH+HL8uqP+Miw0841rYeSaIpU7rxU=;
        b=t5aoPrjTZU9NE/HMN0nQcNRXLY0c2fxu4VjNE0i/22hnGN8Quxq8cmYf/iK8y2mPJtO10X
        z1sG1vS7xptm8wAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B949DA3B93;
        Tue, 17 Aug 2021 13:35:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8AE4FDA72C; Tue, 17 Aug 2021 15:32:44 +0200 (CEST)
Date:   Tue, 17 Aug 2021 15:32:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: cmds/subvolume: try to delete subvolume by
 id when its path can't be reoslved
Message-ID: <20210817133244.GN5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210628102628.354173-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628102628.354173-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 28, 2021 at 06:26:28PM +0800, Qu Wenruo wrote:
> There is a recent report of ghost subvolumes where such subvolumes has
> no ROOT_REF/BACKREF, and 0 root ref.
> But without an orphan item, thus kernel won't queue them for cleanup.
> 
> Such ghost subvolumes are just here to take up space, and no way to
> delete them except by btrfs check, which will try to fix the problem by
> adding orphan item.
> 
> There is a kernel patch submitted to allow btrfs to detect such ghost
> subvolumes and queue them for cleanup.
> 
> But btrfs-progs will not continue to call the ioctl if it can't find the
> full subvolume path.
> 
> Thus this patch will loose the restriction by allowing btrfs-progs to
> continue to call the ioctl even if it can't grab the subvolume path.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks. Please send a test case.
