Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 638BA4E638
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2019 12:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfFUKgt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jun 2019 06:36:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33572 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfFUKgt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jun 2019 06:36:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id x15so3409042pfq.0;
        Fri, 21 Jun 2019 03:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/5VYSI7PbYCjBi9TSlXJsD1j4OXGpwqZDmTsL0d5Qtk=;
        b=e7nJYLXi6ms7MMjlLycuKxZ0QuPoY6wIZXSwf1Wjr1TLAvCl/SHjLP8hhiMJsUF0vu
         wQ4aF9Fvj45ShG/cBzrZkBdP1cvR6vTQka6KeipTrvjLvie/DoRo6H8TksvnL4s0qCyV
         mr8NCWMzEldlvzfQTR8f+4L+/j0a5xb2lT46ZwIwiXX4+BA32UCBSOPxZYNc/53Pub3y
         dY0JpW2Mx2SbnIobbOqOHO7FvZUiE8W9u8AJmhj422fa/dFtF9x7vSVVB4KITAzKOCux
         xpz13sKsBT3a16mBQLEhvtxIzJAjSN4XUszXlZNc0BKgfSdq2I5jdjtvJxzggtQg6HeD
         lclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/5VYSI7PbYCjBi9TSlXJsD1j4OXGpwqZDmTsL0d5Qtk=;
        b=ib7LfDVa8d/HRvIaeOMthAHvraAbwdQG6H1VfGuK9xy+mam9jhsi39wNiGZMfEVt6S
         189RuFZ7skIGrPYsndsUpAXBmjXg4TlNLSYdsMRg6OWLWipi1Oi0/k5JBFZIGfnpSEg4
         nZAFtNMxpsIMy6WMi4uPES1bptv/CIXU9C/x2pCLh2DD6R8HGbPFYbVVUZwNJkrnv+RO
         tUhsM1CXH9l22XT7N+HTcHjtUy5KAgO8NgnMRtWBwYc86Xy3ydYePCow6X4vB3wbDLUh
         JqK0T26AyN53zxwHYQBuw42b+JSLTO7tf/bBS1XOtvVpPbq+haLAg7rwhJCVEweq6Oi8
         K6uA==
X-Gm-Message-State: APjAAAXv4p21a5wI8rhebx1ensXqi1+qdKr+BJFspd1JlH9ul83ohHtr
        F06V93wIG3fFnLB/NeonbHrneBeVW84=
X-Google-Smtp-Source: APXvYqwT9KVmJ1Nn4LOQJmqItnlO3UynP13ERfHr0I/OQfe7SSPTy176NnES+sKrqwVuF7ecQR48xg==
X-Received: by 2002:a63:4419:: with SMTP id r25mr18338367pga.247.1561113408189;
        Fri, 21 Jun 2019 03:36:48 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id s66sm2762566pgs.87.2019.06.21.03.36.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 03:36:47 -0700 (PDT)
Date:   Fri, 21 Jun 2019 18:36:42 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 2/2] generic/059: also test that the file's mtime and
 ctime are updated
Message-ID: <20190621103642.GK15846@desktop>
References: <20190619120624.9922-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619120624.9922-1-fdmanana@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 19, 2019 at 01:06:24PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test as well that hole punch operations that affect a single file block
> also update the file's mtime and ctime.
> 
> This is motivated by a bug a found in btrfs which is fixed by the
> following patch for the linux kernel:
> 
>  "Btrfs: add missing inode version, ctime and mtime updates when
>   punching hole"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/generic/059 | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/tests/generic/059 b/tests/generic/059
> index e8cb93d8..fd44b2ea 100755
> --- a/tests/generic/059
> +++ b/tests/generic/059
> @@ -18,6 +18,9 @@
>  #
>  #  Btrfs: add missing inode update when punching hole
>  #
> +# Also test the mtime and ctime properties of the file change after punching
> +# holes with ranges that operate only on a single block of the file.
> +#
>  seq=`basename $0`
>  seqres=$RESULT_DIR/$seq
>  echo "QA output created by $seq"
> @@ -68,6 +71,13 @@ $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foo
>  # fsync log.
>  sync
>  
> +# Sleep for 1 second, because we want to check that the next punch operations we
> +# do update the file's mtime and ctime.
> +sleep 1

Is this supposed to be after recording the initial c/mtime? i.e. moving
it after c/mtime_before?

Thanks,
Eryu

> +
> +mtime_before=$(stat -c %Y $SCRATCH_MNT/foo)
> +ctime_before=$(stat -c %Z $SCRATCH_MNT/foo)
> +
>  # Punch a hole in our file. This small range affects only 1 page.
>  # This made the btrfs hole punching implementation write only some zeroes in
>  # one page, but it did not update the btrfs inode fields used to determine if
> @@ -94,5 +104,13 @@ _flakey_drop_and_remount
>  echo "File content after:"
>  od -t x1 $SCRATCH_MNT/foo
>  
> +mtime_after=$(stat -c %Y $SCRATCH_MNT/foo)
> +ctime_after=$(stat -c %Z $SCRATCH_MNT/foo)
> +
> +[ $mtime_after -gt $mtime_before ] || \
> +	echo "mtime did not increase (before: $mtime_before after: $mtime_after"
> +[ $ctime_after -gt $ctime_before ] || \
> +	echo "ctime did not increase (before: $ctime_before after: $mtime_after"
> +
>  status=0
>  exit
> -- 
> 2.11.0
> 
