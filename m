Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23C28D764C
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 14:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfJOMRp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 08:17:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:36142 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725812AbfJOMRo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 08:17:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 43904B37A;
        Tue, 15 Oct 2019 12:17:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 51F55DA7E3; Tue, 15 Oct 2019 14:17:55 +0200 (CEST)
Date:   Tue, 15 Oct 2019 14:17:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/19] btrfs: keep track of which extents have been
 discarded
Message-ID: <20191015121755.GU2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dennis Zhou <dennis@kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <cover.1570479299.git.dennis@kernel.org>
 <5875088b5f4ada0ef73f097b238935dd583d5b3e.1570479299.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5875088b5f4ada0ef73f097b238935dd583d5b3e.1570479299.git.dennis@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 07, 2019 at 04:17:34PM -0400, Dennis Zhou wrote:
> @@ -2165,6 +2173,7 @@ static bool try_merge_free_space(struct btrfs_free_space_ctl *ctl,
>  	bool merged = false;
>  	u64 offset = info->offset;
>  	u64 bytes = info->bytes;
> +	bool is_trimmed = btrfs_free_space_trimmed(info);

Please add a const in such cases. I've been doing that in other patches
but as more iterations are expected, let's have it there from the
beginning.

> --- a/fs/btrfs/free-space-cache.h
> +++ b/fs/btrfs/free-space-cache.h
> @@ -6,6 +6,8 @@
>  #ifndef BTRFS_FREE_SPACE_CACHE_H
>  #define BTRFS_FREE_SPACE_CACHE_H
>  
> +#define BTRFS_FSC_TRIMMED		(1UL << 0)

Please add a comment
