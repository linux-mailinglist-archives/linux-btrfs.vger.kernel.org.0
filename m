Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7099A3F53D6
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 01:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbhHWXw5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 19:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbhHWXwz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 19:52:55 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5A2C061575
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 16:52:11 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id om1-20020a17090b3a8100b0017941c44ce4so567781pjb.3
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 16:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=W4ssqRQDcvGYyotlGQXJ7FPsnctHnDcWnfipF58GxTU=;
        b=jC2eZ2lp/L2QHzEG7+6He0zLQnouTP6MM2HdVm+Vb4C+v81HmhkOFAliogd2DAPQy6
         hZx2r8ASRv/Rjccwawu+D86IsjUpYKWirhdGxrgVqQ2xOsiG/TAQUIcyalUGpv5AwqrH
         GNvcWZ5E6l3zbCmZIuLsdwpUr0OQknL/SQEzQaJArOgdly7uYLebXhxkXflquyuk+r5a
         uUar8NcnY/hAYXu8OOA6FKA0NLj9xMbN4YOcEHPUz20NR8/cDwdAWldcM8QgfIBBM2Nt
         hXAgwuRnvaIK0LEgPnvAufj7panncLoWXGzRzor8cRq+wwyBYTsXBEhTIXB0OvI5R562
         Qjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=W4ssqRQDcvGYyotlGQXJ7FPsnctHnDcWnfipF58GxTU=;
        b=ZiojcxfWd4b5acE3UcCDnikVXwRlFBH+vJhv7H3DUpASPO3SJDThxcIHm85swOipdp
         JzVTRzJ8W01CfdXFEUtyT6M6F9Ox+axK5V8gtkC+CZbeHvea1dMxRGDjwzdU7DNNLHLq
         nsRAbDgKndElAdYw9hppAojdOBlpo7ESkGPZ4fpskfxguHq2k6KF2waux4dJBiFK7GJ7
         aXLbjV+LeVcsE6OsYcPEwLlj2MTzAQaZSD+4Fg7AkG0xzg61HmXb6AEvVM4NguybkTqJ
         f9F0WtDw0U2iZJWKqlxFoko1bfS47RYDFIdWU7Qtzdl6I6y3q0CgMPp7LKGu8oZIgp7e
         aclQ==
X-Gm-Message-State: AOAM5300DXrwJcNlvKTOe/Ct6WpI1Y+iDE8rNikxTw7wXEgD8ETuXFHa
        rew+sTiQ5xH4GCBZcgZ76oE=
X-Google-Smtp-Source: ABdhPJxTlUjeh8r12IOAA+ViktFDRyEySb2usQYLm+AAFJRTSO5F8/j9cAEmN++WFsyNcVObVZrTXA==
X-Received: by 2002:a17:902:fe81:b0:133:851e:5923 with SMTP id x1-20020a170902fe8100b00133851e5923mr8995892plm.25.1629762731293;
        Mon, 23 Aug 2021 16:52:11 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id z4sm302277pjl.53.2021.08.23.16.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 16:52:11 -0700 (PDT)
Date:   Mon, 23 Aug 2021 23:51:34 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.cz>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v2] btrfs: reflink: Initialize return value in
 btrfs_extent_same()
Message-ID: <20210823235134.GA45534@realwakka>
References: <20210820004100.35823-1-realwakka@gmail.com>
 <CAL3q7H5UvRXk7TLQOt-bnkN4Tca-v7c6JBW6vz90KEaYJuMp1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H5UvRXk7TLQOt-bnkN4Tca-v7c6JBW6vz90KEaYJuMp1g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 23, 2021 at 10:44:08AM +0100, Filipe Manana wrote:
> On Fri, Aug 20, 2021 at 1:42 AM Sidong Yang <realwakka@gmail.com> wrote:
> >
> > btrfs_extent_same() cannot be called with zero length. This patch add
> > code that initialize ret as -EINVAL to make it safe.
> 
> I suppose the motivation of the patch is to fix a warning from smatch,
> or other similar tools, about 'ret' not being initialized when olen is
> 0.

Yes, Actually I used smatch you said.

> Initializing 'ret' to some value surely makes the warning go away,
> even though it's not possible for olen to be 0 at btrfs_extent_same(),
> as that
> is filtered up in the call chain.
> 
> However setting to -EINVAL by default is confusing and counter
> intuitive because dedupe operations are supposed to return 0 (success)
> for a 0 length range.

Yeah, I think it depends on btrfs_extent_same()'s concept. It does
nothing when 0 length. It's okay if we consider it's normal operation
and it seems natural.

>
> So 'ret' should be initialized to 0 to avoid any confusion.

Agree. I want to know other people's thoughts.

Thanks,
Sidong
 
> Thanks.
> 
> >
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > ---
> > v2:
> >  - Removed assert and added initializing ret
> > ---
> >  fs/btrfs/reflink.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> > index 9b0814318e72..864f42198c5c 100644
> > --- a/fs/btrfs/reflink.c
> > +++ b/fs/btrfs/reflink.c
> > @@ -653,6 +653,7 @@ static int btrfs_extent_same(struct inode *src, u64 loff, u64 olen,
> >         u64 i, tail_len, chunk_count;
> >         struct btrfs_root *root_dst = BTRFS_I(dst)->root;
> >
> > +       ret = -EINVAL;
> >         spin_lock(&root_dst->root_item_lock);
> >         if (root_dst->send_in_progress) {
> >                 btrfs_warn_rl(root_dst->fs_info,
> > --
> > 2.25.1
> >
> 
> 
> -- 
> Filipe David Manana,
> 
> “Whether you think you can, or you think you can't — you're right.”
