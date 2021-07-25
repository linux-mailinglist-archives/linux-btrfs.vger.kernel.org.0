Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6AFB3D4C8A
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jul 2021 09:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhGYGtl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Jul 2021 02:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhGYGtk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Jul 2021 02:49:40 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EDEC061757
        for <linux-btrfs@vger.kernel.org>; Sun, 25 Jul 2021 00:30:08 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j8-20020a17090aeb08b0290173bac8b9c9so15168626pjz.3
        for <linux-btrfs@vger.kernel.org>; Sun, 25 Jul 2021 00:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Wqg6TQ2guURmWL28i5463nh8EOnkrBig//WjZ49b9uI=;
        b=egFwaDkInnmPgeCbGoi89xJ1MzM7aM8iAwGABW50Qa3vjMFqEpoOGppGply8kkSVmN
         ZlLnTwsLIVZyBFjfkHcakLhLmmc7NPsADZzKv00/JYk8cGpGr4sjelz7TSBnYpa1ACzg
         4HI+8d32qQGwLUqrc5iNJFJjTvct2tRCtoziZmI5dwjrLW0vApG+4b2qKWb5/juvATMU
         +GzTulcoTdtZj2TBWVXhVvhUTBKL/P3oI1pEyZdBEaWajQ+SFYPegFQMTzuEmuK+YEgp
         srkljlkn4suzit8FqkR4es/BYiFRSIJGrY9KBeB2/ydRKCWDKZEH6O84p2/XFy+SYlyZ
         jEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Wqg6TQ2guURmWL28i5463nh8EOnkrBig//WjZ49b9uI=;
        b=ApoH082HpGix0rMsSTfv7TxzBnc6rmS3gBsBVBo6McinvGWRvzjs95n1qCByUZ/4zI
         KbpqnrOJZll7Cyn+Ctz1Y0VBpxTNZxSqlt3LqNikz5ZUm9feYWZALJZu9gZzyZKbxzhg
         GDq492WILiustQpgRmGJF+vmwFwGEuSLi51RhbHICGEVWg03jwjYz+8kkAjZpYTMKyos
         7Qp03GjSz8YZdUs3OeJ44c6NBUn/RFOn/YrjTPIyHlFuq8h1o4bTsH0gYX4oswgqEIwB
         7QvJqB4SRFgHB0816XEY8X2DxB1RYRkHZL1ikIjTQxwaMsVDLQ0OEyhMjwrfN4/W2lDS
         C0ww==
X-Gm-Message-State: AOAM531rr0vrqpiUPf6g3ZcmRkAU+lD5jHpfJf6CIU6DCsNgPJbV01Go
        VN/2dwH9afXaeftQ5chyVw8=
X-Google-Smtp-Source: ABdhPJwpnvihdwMJ6O3qxQVROxu9iReTLv6hfBSXpEot2pAUy6WQCoAMGzapnY3CI4ZKWvEufXN8UQ==
X-Received: by 2002:a17:903:32d1:b029:12b:7e4d:9dcb with SMTP id i17-20020a17090332d1b029012b7e4d9dcbmr10296821plr.23.1627198208181;
        Sun, 25 Jul 2021 00:30:08 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id a16sm37751162pfo.66.2021.07.25.00.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 00:30:07 -0700 (PDT)
Date:   Sun, 25 Jul 2021 07:29:53 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Su Yue <l@damenly.su>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: cmds: Fix build for using NAME_MAX
Message-ID: <20210725072953.GA69923@realwakka>
References: <20210724074642.68771-1-realwakka@gmail.com>
 <2305182b-1e12-df9c-320c-7a7eedba860d@gmx.com>
 <20210724082356.GA68829@realwakka>
 <czr7w180.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <czr7w180.fsf@damenly.su>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 25, 2021 at 10:54:05AM +0800, Su Yue wrote:
> 
> On Sat 24 Jul 2021 at 16:23, Sidong Yang <realwakka@gmail.com> wrote:
> 
> > On Sat, Jul 24, 2021 at 03:50:25PM +0800, Qu Wenruo wrote:
> > > 
> > > 
> > > On 2021/7/24 下午3:46, Sidong Yang wrote:
> > > > There is some code that using NAME_MAX but it doesn't include >
> > > header
> > > > that is defined. This patch adds a line that includes >
> > > linux/limits.h
> > > > which defines NAME_MAX.
> > > 
> > > I guess it's related to this issue?
> > > 
> > > https://github.com/kdave/btrfs-progs/issues/386
> > 
> > Yeah, It seems that there is no patch for this yet. So I sent this
> > patch. Is this too minor patch?
> > 
> Good fix. But there is one PR before the issue creation:
> https://github.com/kdave/btrfs-progs/pull/385

Thanks, I didn't know about this. I don't care which patch will be
committed.

Thanks,
Sidong
> 
> --
> Su
> 
> > Thanks,
> > Sidong
> > 
> > > 
> > > Thanks,
> > > Qu
> > > 
> > > >
> > > > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > > > ---
> > > >   cmds/filesystem-usage.c | 1 +
> > > >   1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/cmds/filesystem-usage.c > b/cmds/filesystem-usage.c
> > > > index 50d8995e..2a76e29c 100644
> > > > --- a/cmds/filesystem-usage.c
> > > > +++ b/cmds/filesystem-usage.c
> > > > @@ -24,6 +24,7 @@
> > > >   #include <stdarg.h>
> > > >   #include <getopt.h>
> > > >   #include <fcntl.h>
> > > > +#include <linux/limits.h>
> > > >
> > > >   #include "common/utils.h"
> > > >   #include "kerncompat.h"
> > > >
