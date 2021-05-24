Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E1438E497
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 May 2021 12:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbhEXKvr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 May 2021 06:51:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:48510 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232563AbhEXKvp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 May 2021 06:51:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621853416;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kT8sq50tNc4u1BVjDzrf4QSZZI79VOuO3Ufy2VwWLek=;
        b=HlceTBsiVxyF+AUCPMZL/XqSZLlSh+t+gIkPSJGUulvGoDnjidBPK2iggpGBdX2WBQ5hvH
        Wrz0cCwEQ/7S5/ftRGEe1iIAfLzC6e1BW4DSScEktHysf3mMEugpL1nN+uDUEFSVeStkEI
        WPP6GrJy06i43ufjHa0shPYyxf55/CY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621853416;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kT8sq50tNc4u1BVjDzrf4QSZZI79VOuO3Ufy2VwWLek=;
        b=JTxUcNxTKwCOe0pK6zIClNucViKEakNBxdXkFvX35Pp9qJtFbaXzc9Hbos10i/R3684m0M
        3A9H0pWQwBzu/5BQ==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7D3ADACF2;
        Mon, 24 May 2021 10:50:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7A77FDA701; Mon, 24 May 2021 12:47:40 +0200 (CEST)
Date:   Mon, 24 May 2021 12:47:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix typos in comments
Message-ID: <20210524104740.GR7604@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Wang Yugui <wangyugui@e16-tech.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20210521201402.23136-1-dsterba@suse.com>
 <20210523203231.64AF.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210523203231.64AF.409509F4@e16-tech.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, May 23, 2021 at 08:32:32PM +0800, Wang Yugui wrote:
> Hi,
> 
> the 'codespell' result again the current misc-next.
> 
> fs/btrfs/discard.c:627: sychronous ==> synchronous
> fs/btrfs/disk-io.c:3463: traget ==> target
> fs/btrfs/inode.c:8478: extented ==> extended
> include/uapi/linux/btrfs.h:157: occurences ==> occurrences
> include/uapi/linux/btrfs.h:177: occurences ==> occurrences
> include/uapi/linux/btrfs_tree.h:62: orhpan ==> orphan
> include/uapi/linux/btrfs_tree.h:278: Persistantly ==> Persistently

Maybe I'll do the codespell pass once there's not that high churn, I got
conflicts just rebasing some other patchset.
