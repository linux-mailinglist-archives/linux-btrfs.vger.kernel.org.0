Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2855B23A0
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2019 17:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388050AbfIMPqW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Sep 2019 11:46:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387971AbfIMPqW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Sep 2019 11:46:22 -0400
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A0932081B
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Sep 2019 15:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568389581;
        bh=8YSugib4m1RYqKqc2sc+NLf3cqag7NZTz5luU1dFKNs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VZxYvJsfT/Hg5eP7l8jPMK7THFumXVgpMLWGKQa229wlNZ5yEgivZQDQSDbnB6iLC
         MF0IRSQV3CTUd04RHAp9cQNNZJ+m1ICaiFgYtnVR9ZWyCMZq0nomOU8EsCb3XSY4+c
         KBWXtWQaG0vNxB95QpRMnTI6eGNVB/KLV7x9KauU=
Received: by mail-vs1-f44.google.com with SMTP id g14so13384096vsp.1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Sep 2019 08:46:21 -0700 (PDT)
X-Gm-Message-State: APjAAAWEtCPqg3NutH82wm4tn6UxDHh4ia4RSl7gv8+QAXFSKRhdw1A4
        Auq8ZwIiP5PkEbBS3sbpWAUvGH5eRqJprL8HE4o=
X-Google-Smtp-Source: APXvYqxc3Bkge03cSgOAL7m1sQHQX3O3OjSqJ+zuar/caJaYIQZzEWlv9YRBM8ogZVxqhcUMozLWZhsKVszOAf4z3MA=
X-Received: by 2002:a67:fd08:: with SMTP id f8mr26037399vsr.90.1568389580484;
 Fri, 13 Sep 2019 08:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190913135407.99353-1-dennis@kernel.org>
In-Reply-To: <20190913135407.99353-1-dennis@kernel.org>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 13 Sep 2019 16:46:09 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5GzhL9CG-zTPK_iVFvp4qThmQS82HaaX7KrOwP12YJHQ@mail.gmail.com>
Message-ID: <CAL3q7H5GzhL9CG-zTPK_iVFvp4qThmQS82HaaX7KrOwP12YJHQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: extent_io read eb to dirty_metadata_bytes on ioerr
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, kernel-team@fb.com,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 13, 2019 at 2:54 PM Dennis Zhou <dennis@kernel.org> wrote:
>
> Before, if a eb failed to write out, we would end up triggering a
> BUG_ON(). As of f4340622e0226 ("btrfs: extent_io: Move the BUG_ON() in
> flush_write_bio() one level up"), we no longer BUG_ON(), so we should
> make life consistent and add back the unwritten bytes to
> dirty_metadata_bytes.
>
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> Cc: Filipe Manana <fdmanana@kernel.org>

Looks good.
However I find the subject very confusing and misleading.

"extent_io read eb to dirty_metadata_bytes on ioerr"

That gives the idea of reading the eb (like from disk? or its content,
reading from its pages?), and the "to dirty_metadata_bytes" also find
it confusing.
Something like:

 "btrfs: adjust dirty_metadata_bytes after writeback failure of extent buffer"

would make it clear and not confusing IMHO.
Perhaps it's something David can change when he picks the patch
(either to that or some other more clear subject).

Anyway, for the change itself,

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks!

> ---
>  fs/btrfs/extent_io.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 1ff438fd5bc2..b67133a23652 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3728,11 +3728,21 @@ static void end_extent_buffer_writeback(struct extent_buffer *eb)
>  static void set_btree_ioerr(struct page *page)
>  {
>         struct extent_buffer *eb = (struct extent_buffer *)page->private;
> +       struct btrfs_fs_info *fs_info;
>
>         SetPageError(page);
>         if (test_and_set_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags))
>                 return;
>
> +       /*
> +        * If we error out, we should add back the dirty_metadata_bytes
> +        * to make it consistent.
> +        */
> +       fs_info = eb->fs_info;
> +       percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
> +                                eb->len,
> +                                fs_info->dirty_metadata_batch);
> +
>         /*
>          * If writeback for a btree extent that doesn't belong to a log tree
>          * failed, increment the counter transaction->eb_write_errors.
> --
> 2.17.1
>
