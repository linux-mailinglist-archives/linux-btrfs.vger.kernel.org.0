Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D1D458A94
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Nov 2021 09:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238890AbhKVIfx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Nov 2021 03:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238898AbhKVIfw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Nov 2021 03:35:52 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E78DC061574
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Nov 2021 00:32:46 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id q12so14687621pgh.5
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Nov 2021 00:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wsMXYjGRYeGPPIMI5R0YXnfBqKL9/vhmQAyEW5atv2E=;
        b=VUuEqPv+Ehxnk1EBcuqhyVMWtjcu0JoEMGbBf7lksNXeENtIdu5Fc/RGV1WGaw3IPu
         3/Eis5Q6YZHFhqZ4YNuKwoh+P/iUUyMbzAJNP7a9G/hTLmasYqi1hGMuoh9s5gCHh+qg
         /+DLAxGaXYL6+Skr2rXHYd8J9MiImJWS4Q6sBZp2aFryiRL8hZOv//jVcCshl2Webv9L
         ZOVNg0Ly3wQ47Hg+JjDdUd/2YRWyx9yhdgir8QsJnHOi7WBn3mwvpfYtyblOUi/UjWzN
         hmgMy+TIIL7iM+N+8MuFJkKJgnZaC8BdiGzXNUx0DRq1Ss0OuIChB+aPJMprLltVMVKs
         3HZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wsMXYjGRYeGPPIMI5R0YXnfBqKL9/vhmQAyEW5atv2E=;
        b=s61MLZVIHMNYc9tbA7tC3Kepo3Nd5voBqIsgDUs7ozMK+90Y/GqpGbLZIIcb/4O1FS
         Ppz5jYwbnLwt+admzvFataOZ7IMd4MECYJPtDOR4uWEPb/oHFKJTXOuZOx7UVotcQgvZ
         ykgLrzvOGvIfSh1kXUvxNN6thSMR9DwhQW1R5XcurpQa/uzLuKDrUk5KMC4bYHG9nVjJ
         OrfzIerUkJjUmK0hrWnuukBM0+84jRkY8NpWowhE9d5ENCd+J01ihncK8Hvc5SlFeFkZ
         AA5ZpGu9sFRKbg7imd1wFOVyJZjW3QdWYxes/wAPKwiE/wIcgHGhgcMUt56rPyOLxrnA
         BjmQ==
X-Gm-Message-State: AOAM533JD2jT1BLzgQH+7KpNkYjX8vpvm3+YfPAkYxypNFRNhtttX6nm
        6oOGWBngvuYGGDjjoULY+6O1S0q3HiXnBw==
X-Google-Smtp-Source: ABdhPJyGjtgwdC0/HS0p6Ip7BYqClBNiWqx3joSV8kelD8wUGdGnNFj6osTRh99RR+cKBUmCf4AGyw==
X-Received: by 2002:a65:6455:: with SMTP id s21mr5294799pgv.14.1637569965522;
        Mon, 22 Nov 2021 00:32:45 -0800 (PST)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id k12sm5606014pgi.23.2021.11.22.00.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 00:32:44 -0800 (PST)
Date:   Mon, 22 Nov 2021 08:32:40 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v2] btrfs-progs: filesystem: du: skip file that
 permission denied
Message-ID: <20211122083240.GB8836@realwakka>
References: <20211121151556.8874-1-realwakka@gmail.com>
 <09d229c6-ae30-4453-c9d4-39109f032b99@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09d229c6-ae30-4453-c9d4-39109f032b99@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 22, 2021 at 09:20:00AM +0200, Nikolay Borisov wrote:
> 
> 
> On 21.11.21 г. 17:15, Sidong Yang wrote:
> > This patch handles issue #421. Filesystem du command fails and exit
> > when it access file that has permission denied. But it can continue the
> > command except the files. This patch recovers ret value when permission
> > denied.
> > 
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> 
> 
> The code itself is fine so :
> 
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> 
> 
> OTOH when I looked at the code rather than just the patch I can't help
> but wonder shouldn't we actually structure this the way you initially
> proposed but also add a debug output along the lines of "skipping
> file/dir XXXX due to permission denied", otherwise users might not be
> able to account for some space and they can possibly wonder that
> something is wrong with btrfs fi du command.

You mean that it would be better that print some debug message than
skipping silently. I agree. So I would add this code in condition.

fprintf(stderr, "skipping file/dir: %s : %m\n", entry->d_name);

I think it's okay that it prints when ENOTTY occurs. Is this code what
you meant?
> 
> 
> > ---
> >  cmds/filesystem-du.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/cmds/filesystem-du.c b/cmds/filesystem-du.c
> > index 5865335d..fb7753ca 100644
> > --- a/cmds/filesystem-du.c
> > +++ b/cmds/filesystem-du.c
> > @@ -403,7 +403,7 @@ static int du_walk_dir(struct du_dir_ctxt *ctxt, struct rb_root *shared_extents)
> >  						  dirfd(dirstream),
> >  						  shared_extents, &tot, &shr,
> >  						  0);
> > -				if (ret == -ENOTTY) {
> > +				if (ret == -ENOTTY || ret == -EACCES) {
> >  					ret = 0;
> >  					continue;
> >  				} else if (ret) {
> > 
