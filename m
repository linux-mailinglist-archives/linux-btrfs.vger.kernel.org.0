Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E0F33D479
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Mar 2021 13:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbhCPM6k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Mar 2021 08:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbhCPM6O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Mar 2021 08:58:14 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE11C06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Mar 2021 05:58:13 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id a22-20020a17090aa516b02900c1215e9b33so1306291pjq.5
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Mar 2021 05:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=J9wYsJvVkzTAZDnWOuDGhpmoH7MxMbtkPKqG0yOHSK8=;
        b=J86eGQr7d0hW7vIUt71aQxK5dTpibAlKG5gXRgdiRPEvS/mkK56PP8t8b/XpsL9SKD
         rlAxt3KCyK6psq8BXD6VoYq5hSCYNJtj0VTYfd3iR9VB4kuHHiWg9XfE/PoYs3+9/QRj
         rHuvKFNjajdHaM8aA18Yz6tYAv2MmF0ICoOWygddRAo3UR00n3ixqFHqevmmWLdqlBS7
         XOenQ4yb9Cfq9DGZmbn6l9jQQsjtSPrzuOMLVIWSZ40VUQjbm8oAhG727vI321Kuhn75
         Xy3/x9YenqvdUNwbPasgInsZC5JrVm6Awu7ZC5d8V08Lm/inMIF60e0Z+RGLJp+e199d
         Z5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=J9wYsJvVkzTAZDnWOuDGhpmoH7MxMbtkPKqG0yOHSK8=;
        b=DfEpNWAZvQ4IpeoqO8rPAnXLsBtPeKspYH4MwHZ2siVK/w0YlNtgL2q9rNVJxohXIN
         qsT/UrOS8j4OPfOXPBxvn3BG75t66prCGu+IDtdodzsGI4AOp8Ma3yxkxASfhexB9Vm/
         5OyTGPdLvEhYHG33VQTtD45vi7QCEotjeO2oTAxIuF69KnlREM4vM7v+lXOSuUl6Oihr
         zcQ5bB1uuM4fMdBgSczGUJXMj8H2leqaGtQ7fd4YP4jIg5BD26yGDJFkoEPR2TvTcngb
         bkZHC1iz4yQESddNJ1g7lcQpvRjVnhXcZpIj6I098STkw2OfliAxpEFwkqIjoVTga5vw
         QPRA==
X-Gm-Message-State: AOAM532f26W9oW5VScB8ZLnTYy4Kxp8nHFkdYlxQBoidL3pvBwCRW8Kd
        NNgQIor41FJTkWOOcZLKJ/U=
X-Google-Smtp-Source: ABdhPJw3fKsjkjXYwDzYhbUMIawLYU5zPLDFsqp4hbg54abe2p/58i9qCJE6fQ6xp2LEihyTXcms4A==
X-Received: by 2002:a17:902:a58a:b029:e4:6db1:656 with SMTP id az10-20020a170902a58ab02900e46db10656mr16335626plb.84.1615899493495;
        Tue, 16 Mar 2021 05:58:13 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id 38sm7505119pgk.30.2021.03.16.05.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 05:58:13 -0700 (PDT)
Date:   Tue, 16 Mar 2021 12:58:05 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Subject: Re: [PATCH] btrfs-progs: common: make sure that qgroup id is in range
Message-ID: <20210316125805.GA19669@realwakka>
References: <20210315155638.18861-1-realwakka@gmail.com>
 <2c58bf6a-d13c-2628-bfa5-c122b7ad73a6@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c58bf6a-d13c-2628-bfa5-c122b7ad73a6@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 16, 2021 at 01:44:33PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/3/15 下午11:56, Sidong Yang wrote:
> > When user assign qgroup with qgroup id that is too big to exceeds
> > range and invade level value, and it works without any error. but
> > this action would be make undefined error. this code make sure that
> > qgroup id doesn't exceed range(0 ~ 2^48-1).
> > 
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> 
> Shouldn't the check also happen inside the ioctl?

Yes, I checked the ioctl code in kernel. but there is only the code that
check if it is zero like !sa->qgroupid. and it just assign to
key.offset. Also it should be checked in ioctl?

> 
> Thanks,
> Qu
> > ---
> >   common/utils.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> > 
> > diff --git a/common/utils.c b/common/utils.c
> > index 57e41432..a2f72550 100644
> > --- a/common/utils.c
> > +++ b/common/utils.c
> > @@ -727,6 +727,8 @@ u64 parse_qgroupid(const char *p)
> >   		id = strtoull(p, &ptr_parse_end, 10);
> >   		if (ptr_parse_end != ptr_src_end)
> >   			goto path;
> > +		if (id >> BTRFS_QGROUP_LEVEL_SHIFT)
> > +			goto err;
> >   		return id;
> >   	}
> >   	level = strtoull(p, &ptr_parse_end, 10);
> > @@ -734,6 +736,9 @@ u64 parse_qgroupid(const char *p)
> >   		goto path;
> > 
> >   	id = strtoull(s + 1, &ptr_parse_end, 10);
> > +	if (id >> BTRFS_QGROUP_LEVEL_SHIFT)
> > +		goto err;
> > +
> >   	if (ptr_parse_end != ptr_src_end)
> >   		goto  path;
> > 
> > 
