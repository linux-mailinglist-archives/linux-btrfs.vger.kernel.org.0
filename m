Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50A2710FE61
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 14:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfLCNGX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Dec 2019 08:06:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:36904 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725954AbfLCNGX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Dec 2019 08:06:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B06A3AC9F;
        Tue,  3 Dec 2019 13:06:21 +0000 (UTC)
Date:   Tue, 3 Dec 2019 14:06:19 +0100
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 5/9] btrfs: remove trivial goto label in
 __extent_writepage()
Message-ID: <20191203130619.GG21721@Johanness-MacBook-Pro.local>
References: <cover.1575336815.git.osandov@fb.com>
 <81ea4a6b327f26506041e2e43adc9dfccc7a86fe.1575336816.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81ea4a6b327f26506041e2e43adc9dfccc7a86fe.1575336816.git.osandov@fb.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 02, 2019 at 05:34:21PM -0800, Omar Sandoval wrote:
[...]
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index dad6b06d0a8e..8622282db31e 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3596,7 +3596,7 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
>  	if (!epd->extent_locked) {
>  		ret = writepage_delalloc(inode, page, wbc, start, &nr_written);
>  		if (ret == 1)
> -			goto done_unlocked;
> +			return 0;
>  		if (ret)
>  			goto done;

Unrelated side note, wouldn't it be more obvious if we do
		if (ret == 1)
			return 0;
		if (ret < 0)
			goto done;
as writepage_delalloc() returns 1, 0, and < 1


Anyways this is not really related to this patch,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
