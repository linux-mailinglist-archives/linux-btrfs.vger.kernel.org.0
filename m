Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE7299E80A
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 14:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbfH0Mey (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 08:34:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:58046 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726125AbfH0Mey (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 08:34:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E84B8AF23;
        Tue, 27 Aug 2019 12:34:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 61945DA809; Tue, 27 Aug 2019 14:35:14 +0200 (CEST)
Date:   Tue, 27 Aug 2019 14:35:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/5] Btrfs: treat RWF_{,D}SYNC writes as sync for CRCs
Message-ID: <20190827123512.GF2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1565900769.git.osandov@fb.com>
 <ba7aa871e255c0e264a782b863513b9afd499f91.1565900769.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba7aa871e255c0e264a782b863513b9afd499f91.1565900769.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 15, 2019 at 02:04:03PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> In btrfs_file_write_iter(), we treat a write as synchrononous if the
> file is marked as synchronous. However, with pwritev2(), a write with
> RWF_SYNC or RWF_DSYNC is also synchronous even if the file isn't by
> default. Make sure we bump the sync_writers counter in that case, too,
> so that we'll do the CRCs synchronously.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  fs/btrfs/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 4393b6b24e02..27223753da7b 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1882,7 +1882,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
>  	u64 start_pos;
>  	u64 end_pos;
>  	ssize_t num_written = 0;
> -	bool sync = (file->f_flags & O_DSYNC) || IS_SYNC(file->f_mapping->host);
> +	bool sync = iocb->ki_flags & IOCB_DSYNC;

I'd like to merge the patches 1-3, but have hard time matching the
changelog to the change here. It's from one set of sync flags to
another, mentioning pwritev2 but that's a syscall and the function
itself does not use the sync flags at all. That's probably somewhere
deep in the vfs calls but that's what I'd appreciate stated explicitly
in the changelog as I was not able to find it out in a reasonable time.
