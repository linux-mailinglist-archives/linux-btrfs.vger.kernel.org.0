Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6241D19246A
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Mar 2020 10:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgCYJnI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Mar 2020 05:43:08 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:33052 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbgCYJnI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Mar 2020 05:43:08 -0400
Received: by mail-il1-f196.google.com with SMTP id k29so1245861ilg.0
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Mar 2020 02:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WJC80u+Ifj4HCTJaBhCcmeQxlknM9aDMikhj5e78Hk4=;
        b=DMyiJnazMqjl2qfzafo7tIFEtefoZjrSvPvqu5sHfAPRBEZ/A1uRJU7icYztbxoEQB
         g5CF3/s4HPa6oNzbsswDGOeOH6b8cPtSAM9SODfnMoawOYaqGUMD64MMEV4CyYGxaNCK
         u3cNVaqIoy9X6Y4p8jTdkYJcnnoetQuPBsAYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WJC80u+Ifj4HCTJaBhCcmeQxlknM9aDMikhj5e78Hk4=;
        b=M++BSQIQJfXyRvyg5HwGVUCB6N7gp3divChEBUb2dHViJP0AijvhMw/hV29iGr/YBh
         I8jy7P3dQzfRWmuGiW9JpQKOH51AwUQuPk0+0NXM1/J/b2D3IKJHtRclhUghzgX5WcGN
         Fc28xoTF/lzl5ZzlqbjLKBaAlZkKBxQKxm8y30groNA7YO4zqckhgHTuu0BWBxWpSdKJ
         z6zvDLrtWXfHXuSkj0e/Sl6gyMVHTH1SMIhGsO7X+G0kbBoaVheADbsW4BYdxnn51nMJ
         RTzzEUr7hrJirhR7nQ1LZRZvDumRjUPUXXUP8BtAdfkkztb95Y9iKb4kyZljxwqmjv8k
         rR1A==
X-Gm-Message-State: ANhLgQ3UPxVar4cEhaXq6dt8KzTZhmPS5GDwBhValAvcoohk5D62l9zO
        WgZfaq9x8zYQ9eiD+hYf612qJaxmpwaaZErYz7pFAA==
X-Google-Smtp-Source: ADFU+vsgfIWqTVfFvZZGiDAww03tclKMezpcFsmTHkThxRNJbwZiwKmblFARFxQj+PxAwoovscn7WyTAXThKOCyBwVE=
X-Received: by 2002:a92:9fd0:: with SMTP id z77mr2593848ilk.257.1585129387289;
 Wed, 25 Mar 2020 02:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200323202259.13363-1-willy@infradead.org> <20200323202259.13363-25-willy@infradead.org>
In-Reply-To: <20200323202259.13363-25-willy@infradead.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 25 Mar 2020 10:42:56 +0100
Message-ID: <CAJfpegu7EFcWrg3bP+-2BX_kb52RrzBCo_U3QKYzUkZfe4EjDA@mail.gmail.com>
Subject: Re: [PATCH v10 24/25] fuse: Convert from readpages to readahead
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        William Kucharski <william.kucharski@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 23, 2020 at 9:23 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>
> Use the new readahead operation in fuse.  Switching away from the
> read_cache_pages() helper gets rid of an implicit call to put_page(),
> so we can get rid of the get_page() call in fuse_readpages_fill().
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> ---
>  fs/fuse/file.c | 46 +++++++++++++++++++---------------------------
>  1 file changed, 19 insertions(+), 27 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 9d67b830fb7a..5749505bcff6 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -923,9 +923,8 @@ struct fuse_fill_data {
>         unsigned int max_pages;
>  };
>
> -static int fuse_readpages_fill(void *_data, struct page *page)
> +static int fuse_readpages_fill(struct fuse_fill_data *data, struct page *page)
>  {
> -       struct fuse_fill_data *data = _data;
>         struct fuse_io_args *ia = data->ia;
>         struct fuse_args_pages *ap = &ia->ap;
>         struct inode *inode = data->inode;
> @@ -941,10 +940,8 @@ static int fuse_readpages_fill(void *_data, struct page *page)
>                                         fc->max_pages);
>                 fuse_send_readpages(ia, data->file);
>                 data->ia = ia = fuse_io_alloc(NULL, data->max_pages);
> -               if (!ia) {
> -                       unlock_page(page);
> +               if (!ia)
>                         return -ENOMEM;
> -               }
>                 ap = &ia->ap;
>         }
>
> @@ -954,7 +951,6 @@ static int fuse_readpages_fill(void *_data, struct page *page)
>                 return -EIO;
>         }
>
> -       get_page(page);
>         ap->pages[ap->num_pages] = page;
>         ap->descs[ap->num_pages].length = PAGE_SIZE;
>         ap->num_pages++;
> @@ -962,37 +958,33 @@ static int fuse_readpages_fill(void *_data, struct page *page)
>         return 0;
>  }
>
> -static int fuse_readpages(struct file *file, struct address_space *mapping,
> -                         struct list_head *pages, unsigned nr_pages)
> +static void fuse_readahead(struct readahead_control *rac)
>  {
> -       struct inode *inode = mapping->host;
> +       struct inode *inode = rac->mapping->host;
>         struct fuse_conn *fc = get_fuse_conn(inode);
>         struct fuse_fill_data data;
> -       int err;
> +       struct page *page;
>
> -       err = -EIO;
>         if (is_bad_inode(inode))
> -               goto out;
> +               return;
>
> -       data.file = file;
> +       data.file = rac->file;
>         data.inode = inode;
> -       data.nr_pages = nr_pages;
> -       data.max_pages = min_t(unsigned int, nr_pages, fc->max_pages);
> -;
> +       data.nr_pages = readahead_count(rac);
> +       data.max_pages = min_t(unsigned int, data.nr_pages, fc->max_pages);
>         data.ia = fuse_io_alloc(NULL, data.max_pages);
> -       err = -ENOMEM;
>         if (!data.ia)
> -               goto out;
> +               return;
>
> -       err = read_cache_pages(mapping, pages, fuse_readpages_fill, &data);
> -       if (!err) {
> -               if (data.ia->ap.num_pages)
> -                       fuse_send_readpages(data.ia, file);
> -               else
> -                       fuse_io_free(data.ia);
> +       while ((page = readahead_page(rac))) {
> +               if (fuse_readpages_fill(&data, page) != 0)

Shouldn't this unlock + put page on error?

Otherwise looks good.

Thanks,
Miklos
