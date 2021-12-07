Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19A246C33C
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 19:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240792AbhLGTDW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 14:03:22 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:32956 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbhLGTDW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Dec 2021 14:03:22 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 181481FE00;
        Tue,  7 Dec 2021 18:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638903591;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AS0+4b/dqYGewkg2o39h1vB1JMvQvacuYnTfUu8rQ3Q=;
        b=GQQxj6cAHbBzTgK6y/0ZGDheWQlDT8p9re2Lhixh2tyCKS6p95h2V3MwkPEHSMbALOcBdv
        /NrQ19i3fArvXQbcMCzz7poumQaRZj5Xpcm4sC1f3UhM5qQnBZZD4slESuQToojU6tYeNf
        oYeo4uRHV/C9xEvDT0BOndI+VQxxuLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638903591;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AS0+4b/dqYGewkg2o39h1vB1JMvQvacuYnTfUu8rQ3Q=;
        b=CjI8+N7l0+pf/h3ycguwOaWA00GS8wczU+kyzCPWF2Ux29fiF+m7o5wfOSh7zrq5Jn0ShR
        TS249/gAzy3OArAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1115FA3B8B;
        Tue,  7 Dec 2021 18:59:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6959CDA799; Tue,  7 Dec 2021 19:59:36 +0100 (CET)
Date:   Tue, 7 Dec 2021 19:59:36 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 0/2] Free space tree space reservation fixes
Message-ID: <20211207185936.GB28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1638477127.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1638477127.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 02, 2021 at 03:34:30PM -0500, Josef Bacik wrote:
> v1->v2:
> - Updated the changelog for "btrfs: reserve extra space for free space tree" to
>   make it clear why we're doubling the space reservation per Nikolay's request.
> 
> --- Original email ---
> Hello,
> 
> Filipe reported a problem where he was getting an ENOSPC abort when running
> delayed refs for generic/619.  This is because of two reasons, first generic/619
> creates a very small file system, and our global block rsv calculation doesn't
> take into account the size of the free space tree.  Thus we could get into a
> situation where the global block rsv was not enough to handle the overflow.
> 
> The second is because we simply do not reserve space for the free space tree
> modifications.  Fix this by making sure any free space tree root has their block
> rsv set to the delayed refs rsv, and then make sure if we have the free space
> tree enabled we're reserving extra space for those operations.
> 
> With these patches the problem Filipe was hitting went away.  Thanks,
> 
> Josef
> 
> Josef Bacik (2):
>   btrfs: include the free space tree in the global rsv minimum
>     calculation
>   btrfs: reserve extra space for the free space tree

Added to misc-next, thanks. Filipe had a question in patch 2 which I
believe has been answered, but if there's anything to add/update please
let me know.
