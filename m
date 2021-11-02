Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66393442ED7
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 14:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhKBNLh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 09:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhKBNL1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Nov 2021 09:11:27 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2AAC061714
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Nov 2021 06:08:52 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id j1so11520944qtq.11
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Nov 2021 06:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/v/kQZM94TSf7IbYilCFMcURmicXeVaVnrStPot5IQU=;
        b=EQUg/RXokIZc+dfStxfplDrwN4Be88CVrnQcj/SHKw7Zf0jUrxHh78dvX0FRE1TDiF
         vhVYXyJv8Mnk9f0hfoc9buPdLXhxBUKZEhk8kC4NkTuFv6GHQvoFfQvCEKrDmTl1ngX0
         ooxGIlzfbn99Np2wrulJgkVbKeiLUcEdFI+COgNAOZza39n5SkWJcpynBxylmOkJ41qP
         xyyV1x44/qi65hGOXzrf/KderskpZYaqH1v5YJypUGtD7xgHGYHN6p6fQboAYGVHOSl1
         /L9PgledWjstzqvj67o1GDP3lD7GBf9gVKkIJP/yyVmyhj28DJMdcM9vAg9yDUZUKv9K
         3J6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/v/kQZM94TSf7IbYilCFMcURmicXeVaVnrStPot5IQU=;
        b=wc1e2BIAyvZ5ZYSySzZ7seuYmwl2BHp+i2DIw/9KkkYA07qkyzmDNA+S1Ydv+LZ1Cb
         SsWCIUtpIQqp7jFnCCmvtK5cWn0nwyJ05SaILoQv3yto8nkhxAfPuOrcMAUX4muAA/Fw
         TgmZUUsINLp6GlsQ6+L33T05zTPV7WU/9inCaF2lzWN/a6fO9qTsmupEpS+Fur1dS0j1
         ihkWm1rGbYytxD/uVknl0L5q3d/9RBVHayC+MmHNXQIPYPF1YsS73WHia++KmVuDGks5
         NJnGp8SO3IS9dqAVQ0Zn6CaqokgKdWmZfbWHtk8KpR1zKb0Kb6aQQzkM0pTItEgSm0SH
         cuSw==
X-Gm-Message-State: AOAM531EQfXbqNEIj0ZxwSFOy1hhhuC6mnrfkHq2VPjVCWNu2NSZhBjv
        Zcbu24FPaHadjh923/zL6tVFwA==
X-Google-Smtp-Source: ABdhPJyvCZtyMkwJOGgwpG9Cng2fGN5lTSnpKyir3ImSheeGawvSdUZbYq3IvYC6I8fl2EseNuPHDw==
X-Received: by 2002:a05:622a:2ce:: with SMTP id a14mr12164708qtx.72.1635858531503;
        Tue, 02 Nov 2021 06:08:51 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f1sm1985943qkj.84.2021.11.02.06.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 06:08:50 -0700 (PDT)
Date:   Tue, 2 Nov 2021 09:08:49 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Wang Yugui <wangyugui@e16-tech.com>
Subject: Re: [PATCH] btrfs: clear free space cache when nospace_cache mount
 option is specified
Message-ID: <YYE4Ybw4lZH6jJqw@localhost.localdomain>
References: <20211102084242.30581-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102084242.30581-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 02, 2021 at 04:42:42PM +0800, Qu Wenruo wrote:
> [BUG]
> With latest btrfs-progs v5.15.x testing branch, fstests/btrfs/215 will
> fail like the following:
> 
>   MKFS_OPTIONS  -- /dev/mapper/test-scratch1
>   MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch
> 
>   btrfs/215 0s ... [failed, exit status 1]- output mismatch (see ~/xfstests-dev/results//btrfs/215.out.bad)
>       --- tests/btrfs/215.out	2020-11-03 15:05:07.920000001 +0800
>       +++ ~/xfstests-dev/results//btrfs/215.out.bad	2021-11-02 16:31:17.626666667 +0800
>       @@ -1,2 +1,4 @@
>        QA output created by 215
>       -Silence is golden
>       +mount: /mnt/scratch: wrong fs type, bad option, bad superblock on /dev/mapper/test-scratch1, missing codepage or helper program, or other error.
>       +mount -o nospace_cache /dev/mapper/test-scratch1 /mnt/scratch failed
>       +(see ~/xfstests-dev/results//btrfs/215.full for details)
>       ...
>       (Run 'diff -u ~/xfstests-dev/tests/btrfs/215.out ~/xfstests-dev/results//btrfs/215.out.bad'  to see the entire diff)
>   Ran: btrfs/215
> 
> [CAUSE]
> Currently btrfs doesn't allow mounting with nospace_cache when there is
> already a v2 cache.
> 
> The logic looks like this, in btrfs_parse_options():
> 
> 		case Opt_no_space_cache:
> 			if (btrfs_test_opt(info, FREE_SPACE_TREE)) {
> 				btrfs_set_opt(info->mount_opt, CLEAR_CACHE);
> 				btrfs_clear_and_info(info, FREE_SPACE_TREE,
> 				"disabling and clearing free space tree");
> 			}
> 			break;
> 
> Then at the end of the same function:
> 
> 	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE) &&
> 	    !btrfs_test_opt(info, FREE_SPACE_TREE) &&
> 	    !btrfs_test_opt(info, CLEAR_CACHE)) {
> 		btrfs_err(info, "cannot disable free space tree");
> 		ret = -EINVAL;
> 	}
> 
> Thus causing above mount failure.
> 
> [FIX]
> I'm not sure why we don't allow nospace_cache with v2 cache, my
> assumption is we don't have generation check for v2 cache, thus if we
> make v2 space cache get out of sync with the on-disk data, it can
> corrupt the fs.
> 
> That needs to be properly addressed, but for now, to allow nospace_cache
> with v2 cache, we can simply force to clear v2 cache when nospace_cache
> mount option is specified.
> 
> Since we're here, also remove a unnecessary new line the v2 cache check
> at the end btrfs_parse_options().
> 
> Reported-by: Wang Yugui <wangyugui@e16-tech.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

I'd rather we just not allow nospace_cache with the free space tree.  It was an
option meant for the original space cache, not for the free space tree.  I don't
want to surprise clear the free space tree for an unrelated mount option.
Thanks,

Josef
