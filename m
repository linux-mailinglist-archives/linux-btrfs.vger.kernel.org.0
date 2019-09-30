Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2863C20E4
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 14:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730993AbfI3Mtr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 08:49:47 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39301 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbfI3Mtr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 08:49:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id e1so1834546pgj.6
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2019 05:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=L1NiVI/KYJ52QkSGxsEbgvzMjvLJqXS2PcZw0gJZowQ=;
        b=becyoLByCMnXo6a3bvOGQEnHf3LlbH+2Kv+iReX5AlZq9gq+/uN80FD/VURX1aIgi/
         O5ZJbisGzXtISwSUJxaKvLH8AHAWTJkb5zN/2M5CblmKhbQZR24SZrHDodfNAnMMVfHL
         CaFWJbXI6hLyIF+x5Jp4ZGx98nB3c2RTzGw7cnxzCFJCU7I/vyYjV01j4IJFtZP2CrKp
         j9EkhqbVBIGBDgFCM/nST4KEtqVbf2CDu3kohnym0nhZknMvql2HhxKYYnN4fwxos+/H
         ZXUpUzuLQlEHvsXOF6pRuhop8lbUquUqCVYCAJXMJ8SuhJoPtJQqVtxJcvbZt9zrCwFh
         AWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=L1NiVI/KYJ52QkSGxsEbgvzMjvLJqXS2PcZw0gJZowQ=;
        b=AJu9n9ELuqjLZIU/7JF2SH4DxPZDun3XIXrOBD1+PKOazFboMrcQdoo3kL8y+rOdQa
         JuIN7k226IWIkhrp2Imdddn8nA+phHVaxY3iAjUbjjvQSfV2H7vNIMCojPsfqn3gMy62
         XqacQget7/zdNAmNFOigDkjtY71jfUbrWiK02CJ6Tpk9YbO/qiFkTjT1MV2D+M952W8T
         shO82L5TBtbjh0/izzgdl0ehBMBm/pCa9FcSeJO99AIw1cbVGSprGrR54Rum4IzwyaG7
         yHMEwH+fJ9wqP315BYAnUyLiJdhHBY2uKRoMHx2dnRRmVvNAOCIRO5abgap8K+a3acK1
         YKpg==
X-Gm-Message-State: APjAAAVKbwEAszig+tGLZQnNrPlPdWCaYPj06iZoUvSR2uKzOnRS1zG6
        5kEf2/TyGvFSzYVKnnXCwFc=
X-Google-Smtp-Source: APXvYqzGThiusNUVuGbYxKDedKK92DCXu8nf22QcbEwIQfWnC9bu4C4sWHAQzQYjD9RXtTNesuKVqQ==
X-Received: by 2002:a63:441b:: with SMTP id r27mr24046624pga.357.1569847786278;
        Mon, 30 Sep 2019 05:49:46 -0700 (PDT)
Received: from aliasgar ([2401:4900:1951:51d2:1ea:5074:6a35:df7d])
        by smtp.gmail.com with ESMTPSA id c64sm13793137pfc.19.2019.09.30.05.49.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 05:49:45 -0700 (PDT)
Date:   Mon, 30 Sep 2019 18:19:30 +0530
From:   Aliasgar Surti <aliasgar.surti500@gmail.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     clm@fb.com, David Sterba <dsterba@suse.com>, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: removed unused return variable
Message-ID: <20190930124930.GA21375@aliasgar>
References: <1569842265-32084-1-git-send-email-aliasgar.surti500@gmail.com>
 <ba5b0d77-5780-f883-f491-52505b2bd8a5@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba5b0d77-5780-f883-f491-52505b2bd8a5@suse.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 30, 2019 at 02:53:12PM +0300, Nikolay Borisov wrote:
> 
> 
> On 30.09.19 г. 14:17 ч., Aliasgar Surti wrote:
> > From: Aliasgar Surti <aliasgar.surti500@gmail.com>
> > 
> > Removed unused return variable and replaced it with returning
> > the value directly
> > 
> > Signed-off-by: Aliasgar Surti <aliasgar.surti500@gmail.com>
> 
> Actually this function should be turned to void and even the declaration
> at the top of disk-io can be removed.

Okay, will send out v2 incorporating this change.

Thanks,
Aliasgar
> 
> > ---
> >  fs/btrfs/disk-io.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index 044981c..c80fa67 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -4255,7 +4255,6 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
> >  	struct rb_node *node;
> >  	struct btrfs_delayed_ref_root *delayed_refs;
> >  	struct btrfs_delayed_ref_node *ref;
> > -	int ret = 0;
> >  
> >  	delayed_refs = &trans->delayed_refs;
> >  
> > @@ -4263,7 +4262,7 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
> >  	if (atomic_read(&delayed_refs->num_entries) == 0) {
> >  		spin_unlock(&delayed_refs->lock);
> >  		btrfs_info(fs_info, "delayed_refs has NO entry");
> > -		return ret;
> > +		return 0;
> >  	}
> >  
> >  	while ((node = rb_first_cached(&delayed_refs->href_root)) != NULL) {
> > @@ -4307,7 +4306,7 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
> >  
> >  	spin_unlock(&delayed_refs->lock);
> >  
> > -	return ret;
> > +	return 0;
> >  }
> >  
> >  static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root)
> > 
