Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5E0C0367
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2019 12:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfI0K2z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Sep 2019 06:28:55 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:33552 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfI0K2y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Sep 2019 06:28:54 -0400
Received: by mail-ua1-f68.google.com with SMTP id u31so1777520uah.0
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2019 03:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=JwCxWVUGPy2o120CpNdo2n/2B5XiiRN1mrDWQK0T9LU=;
        b=EalTjjHjX71Smng0vcGiED1LueKsWQ/FOGGzSDPK0Zl935tZtC6PYzImwlqA3Xzkfj
         CyHAJW6hnVTPq9EEYIN4cQI8vZ6JilJ9292jYNlB1yj2sCGEMMqo/yr4Sfp4hx0VkrIL
         ij8CCP7cIYT5IToTv9CTK2SELK0hjglrGYgsBWsvCpWqM/qBUZ7HyLXcnS/4oItqhere
         H6mwuPHmOWHJKILtRE1HCpFYSOpZLiNVIF5ldeylsExckY+Kth2QDUMYkJLYk9KxDGjm
         9UimRB6Y9Xqf+bizaI6D8Nh0EDNBF8851d4rV+qdJmOPnTxyu90znlN3/ch9rGtV70WO
         OOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=JwCxWVUGPy2o120CpNdo2n/2B5XiiRN1mrDWQK0T9LU=;
        b=t0IcQo8WQuAJerJWtyguYj5KV9NlEfzB/kyzmOGxgAXZbLB6f+P3ykE8yxSeSZYQ2V
         Tr8XBNO3maZ7U6dqjFG+VdhIa3QAtjUZ71EmGn9H0t73O/POwgALA1oMlSSe8YVM1fJG
         6WrLTAlHhJVa2sH5ATzA4TxKM0jRbbbvnC3aeR/ZWMDAR7JF0+aJFJeLw6ov8/V0Rfqp
         atIIK0zvpO3vj/CIrBguTQfZ/0y/Hi27oPrHFgeBRJElMVAbshLTrBfmUWIHrZh2UC5q
         BhY28EN9gc2EG/+lfXd5rOJ7opmwicczVLhCMLgEKjb6V9b+12unlGFY31R/mONT1cX6
         tU1A==
X-Gm-Message-State: APjAAAVW+enijP/Ux+O49cFKBZA1RG9gBxMMHlt0TvyDNznLT82TOOIW
        Mn8aZqsA0XutEjT3Cf5+r5DBgUFk75wLnAXrtuU=
X-Google-Smtp-Source: APXvYqxSBOBvGizRB28AKBD/pYL8OOtEw3KgSY3K0IktFpQMGcQyJ5RJzJTkmUCf/zyy4URb2uJrR9cyy4+F0Y6ZW6k=
X-Received: by 2002:ab0:7002:: with SMTP id k2mr4085215ual.135.1569580133379;
 Fri, 27 Sep 2019 03:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190924205044.31830-1-josef@toxicpanda.com>
In-Reply-To: <20190924205044.31830-1-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 27 Sep 2019 11:28:42 +0100
Message-ID: <CAL3q7H4af9aJr3bsLQO=4F9N6LCoNxBc4PL5FV-RJNZc7QjP9A@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: check page->mapping when loading free space cache
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 26, 2019 at 11:53 AM Josef Bacik <josef@toxicpanda.com> wrote:
>
> While testing 5.2 we ran into the following panic
>
> [52238.017028] BUG: kernel NULL pointer dereference, address: 00000000000=
00001
> [52238.105608] RIP: 0010:drop_buffers+0x3d/0x150
> [52238.304051] Call Trace:
> [52238.308958]  try_to_free_buffers+0x15b/0x1b0
> [52238.317503]  shrink_page_list+0x1164/0x1780
> [52238.325877]  shrink_inactive_list+0x18f/0x3b0
> [52238.334596]  shrink_node_memcg+0x23e/0x7d0
> [52238.342790]  ? do_shrink_slab+0x4f/0x290
> [52238.350648]  shrink_node+0xce/0x4a0
> [52238.357628]  balance_pgdat+0x2c7/0x510
> [52238.365135]  kswapd+0x216/0x3e0
> [52238.371425]  ? wait_woken+0x80/0x80
> [52238.378412]  ? balance_pgdat+0x510/0x510
> [52238.386265]  kthread+0x111/0x130
> [52238.392727]  ? kthread_create_on_node+0x60/0x60
> [52238.401782]  ret_from_fork+0x1f/0x30
>
> The page we were trying to drop had a page->private, but had no
> page->mapping and so called drop_buffers, assuming that we had a
> buffer_head on the page, and then panic'ed trying to deref 1, which is
> our page->private for data pages.
>
> This is happening because we're truncating the free space cache while
> we're trying to load the free space cache.  This isn't supposed to
> happen, and I'll fix that in a followup patch.  However we still
> shouldn't allow those sort of mistakes to result in messing with pages
> that do not belong to us.  So add the page->mapping check to verify that
> we still own this page after dropping and re-acquiring the page lock.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.


> ---
>  fs/btrfs/free-space-cache.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index d54dcd0ab230..d86ada9c3c54 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -385,6 +385,12 @@ static int io_ctl_prepare_pages(struct btrfs_io_ctl =
*io_ctl, struct inode *inode
>                 if (uptodate && !PageUptodate(page)) {
>                         btrfs_readpage(NULL, page);
>                         lock_page(page);
> +                       if (page->mapping !=3D inode->i_mapping) {
> +                               btrfs_err(BTRFS_I(inode)->root->fs_info,
> +                                         "free space cache page truncate=
d");
> +                               io_ctl_drop_pages(io_ctl);
> +                               return -EIO;
> +                       }
>                         if (!PageUptodate(page)) {
>                                 btrfs_err(BTRFS_I(inode)->root->fs_info,
>                                            "error reading free space cach=
e");
> --
> 2.21.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
