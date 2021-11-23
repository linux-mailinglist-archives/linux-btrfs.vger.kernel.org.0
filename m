Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7740E45AE81
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Nov 2021 22:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbhKWVim (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Nov 2021 16:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhKWVil (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Nov 2021 16:38:41 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3BFC061574
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Nov 2021 13:35:33 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id 193so589651qkh.10
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Nov 2021 13:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=feAgbVjYkULnOJMngXhdYQZGpLmW5dvynAmK3KCwEn4=;
        b=XL3qFY07JqsI1iL5aiO/26ypaMHRw6eeDE/NJmqA9f5UUZ6qm3mECKN+xWg4TeExkn
         sEjRZn9pL3RCfZPeRN5iL+tUWUrsh9rdlD7GzNgF16V6t40YWgdKBOUGJ8ip7DJWp+Zd
         wWbaXMPDzDJ6p/8yMgawRHRUqvzJkIi2S5RMYRAkXNDdxU+U7WhnRsAIaoMzzHlYIQ7B
         i/Hs4JRB9uVYaKj8glAKgfFhkZT32hM3V+mWWArlz1K2l7bK7EEObqzCxCZpMiJ2m/xg
         vAGqMlp+xhRwj+1GhVsdo8efdxnzkggfP9rH2xWv4kXYRt8lUGpWIly+I55Zxwg4E2li
         yzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=feAgbVjYkULnOJMngXhdYQZGpLmW5dvynAmK3KCwEn4=;
        b=7662wzAwKA4aPrG+sQ3/jyw7honFR/foubpFOSk2esks+HtkJ1MNCWUaq1NozHm1pn
         EsvdI83kDi8VJEh2vKx465DPK91gtgqYHWIchsLp6cMQ03GsnUqhTMdfve5Tu5h8jWsA
         jumcU4HV8+cWPnO/Qquqb76G6yMoQMUzvwkDRdW+Fu74iPf6ragE8BGPXTmRbh7Gi11S
         hOMAXLNdsVFHoIenezNqdZEzkeUpcingQdBArqlGMXpIxn081yCS12lY6Hv67zuSzNEN
         6NVrwqd2whH0AMwS//XsBeYEbmw9++IjMXk3JvQYKoeexIYlnKkqE8HQd/ZxvqvGIavL
         xP2g==
X-Gm-Message-State: AOAM530g6Iy96nzTsk1CxMX6As/XoaTvFWAru0x3F7Tf2YqnbEHKk4rK
        XJJkAIzQEVbSgqbTMlXUsCEZim0EETAc6Q==
X-Google-Smtp-Source: ABdhPJw3E/SMJEA+IPwcBNe+2Pmr7i+Hu7hmPc+WVMbXTXqQF/OZ+k+woc4LOg5y957WQ4r7QUXtQg==
X-Received: by 2002:a05:620a:407:: with SMTP id 7mr565216qkp.506.1637703332429;
        Tue, 23 Nov 2021 13:35:32 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d6sm6404908qtq.15.2021.11.23.13.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 13:35:31 -0800 (PST)
Date:   Tue, 23 Nov 2021 16:35:30 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 08/25] btrfs: remove BUG_ON() in find_parent_nodes()
Message-ID: <YZ1eouKhavsSz1p6@localhost.localdomain>
References: <cover.1636144971.git.josef@toxicpanda.com>
 <be1a91360aa5e5eaae56cb09a90333f7da07b3a6.1636144971.git.josef@toxicpanda.com>
 <adf7aeac-5e5c-f58b-b377-ebb6af808677@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adf7aeac-5e5c-f58b-b377-ebb6af808677@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 23, 2021 at 10:53:07PM +0200, Nikolay Borisov wrote:
> 
> 
> On 5.11.21 г. 22:45, Josef Bacik wrote:
> > We search for an extent entry with .offset = -1, which shouldn't be a
> > thing, but corruption happens.  Add an ASSERT() for the developers,
> > return -EUCLEAN for mortals.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/btrfs/backref.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> > index 12276ff08dd4..7d942f5d6443 100644
> > --- a/fs/btrfs/backref.c
> > +++ b/fs/btrfs/backref.c
> > @@ -1210,7 +1210,12 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
> >  	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
> >  	if (ret < 0)
> >  		goto out;
> > -	BUG_ON(ret == 0);
> > +	if (ret == 0) {
> > +		/* This shouldn't happen, indicates a bug or fs corruption. */
> > +		ASSERT(ret != 0);
> 
> This can never trigger in this branch, because ret is guaranteed to be 0
> o_O?
> 

It'll always trigger right?  ASSERT(false) == BUG_ON(true), and in this case ret
== 0, so we'll BUG_ON() in this case because it's wrong.  Thanks,

Jsoef
