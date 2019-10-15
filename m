Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37985D766F
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 14:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbfJOMXf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 08:23:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:37984 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727304AbfJOMXe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 08:23:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3A88DB3DC;
        Tue, 15 Oct 2019 12:23:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4C3B0DA7E3; Tue, 15 Oct 2019 14:23:45 +0200 (CEST)
Date:   Tue, 15 Oct 2019 14:23:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 04/19] btrfs: keep track of cleanliness of the bitmap
Message-ID: <20191015122345.GV2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dennis Zhou <dennis@kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <cover.1570479299.git.dennis@kernel.org>
 <4cdbe31836b701c2c134c8484bb3531f7024031d.1570479299.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cdbe31836b701c2c134c8484bb3531f7024031d.1570479299.git.dennis@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 07, 2019 at 04:17:35PM -0400, Dennis Zhou wrote:
> --- a/fs/btrfs/free-space-cache.h
> +++ b/fs/btrfs/free-space-cache.h
> @@ -7,6 +7,7 @@
>  #define BTRFS_FREE_SPACE_CACHE_H
>  
>  #define BTRFS_FSC_TRIMMED		(1UL << 0)
> +#define BTRFS_FSC_TRIMMING_BITMAP	(1UL << 1)
>  
>  struct btrfs_free_space {
>  	struct rb_node offset_index;
> @@ -23,6 +24,12 @@ static inline bool btrfs_free_space_trimmed(struct btrfs_free_space *info)
>  	return (info->flags & BTRFS_FSC_TRIMMED);
>  }
>  
> +static inline
> +bool btrfs_free_space_trimming_bitmap(struct btrfs_free_space *info)

Please keep the specifiers and type on the same line as the function,

static inline bool btrfs_free_space_trimming_bitmap(struct btrfs_free_space *info)

Short 80 column overflow of ( or { is ok (though chekpatch would report
that). I've seen split type/name in several other patches and will not
point out every occurence, so please fix it up as you find them.
