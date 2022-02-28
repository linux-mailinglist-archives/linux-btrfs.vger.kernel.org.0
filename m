Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA8F4C609A
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 02:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbiB1BUN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Feb 2022 20:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbiB1BUM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Feb 2022 20:20:12 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92475C66B
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Feb 2022 17:19:34 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id z16so9635678pfh.3
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Feb 2022 17:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g9/qin8e2pM58ey3ozzpDGJDuIN8fDOL5pmiodXiEaY=;
        b=qrpxE5C11dM6Oz1J+d7MaQ7Eq1xyuwuJZzdqfcyIVNGoOYsSFRuxG55ShXclqdVgCz
         IucHg9yTXXqvp1Sdm3RTpr+yjLTNNXHEukw9APwZ3+LR1edYMQ9H30u5roykfMOQRONp
         5e3bovb9qxm1C/CVWsVd3XL2KWvzM5jDLLA6isi9qNOaWbhAZc9lH504WqRehTYHxOkv
         GDu3JMR98AltI7dl12v06Mgu2hXLjZSREr6ZEDUd9CiiGMO9wN8pRRDbjtrJuM+dXK9F
         gNQLm/ujfMKv6AxiRv4oa9aKoFx0k2AVvoWqT7D9dKFNeIbPl9umx6zNjCE8cMe3twhs
         Jdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g9/qin8e2pM58ey3ozzpDGJDuIN8fDOL5pmiodXiEaY=;
        b=S0SWGc6TLPenUPcckZ8P2Y9jtT472qNqmSYePsVK4mBasUc+ykIKioS0ikC0QoCd8N
         Gn//T6kuJFLrTJqg66p5b38mWld2rIuswHRmwO2l2WfgWS0YZPk7fVw2Wx8QvPvXYMoJ
         WXzcFdogHpWU9Ip/1R2pUFtSX1Ju9Qa3vLASJCsqah2Euejkt9K1Z2T4uRgDEVW9mF0Q
         zqje+A6lu1GNnrjEwjlF3HEXMGeKJMvXkzp/l69ZzWaNvmss8uaS0Pp+rNcTUsNsGDJV
         3AhM5PELq4nmIWCl2pzqSMnPs/CaPLKR25TBWI/J1AOoR7+Tobch1BNfbXPS/2Z2birT
         UlYw==
X-Gm-Message-State: AOAM532SWbVv1zXX4JLaVB7CnXarbg4Qvxps3cqoxjRgd2UGhgZRZ+uB
        BcUDnwe+6HC4XnR0rEo4qWI=
X-Google-Smtp-Source: ABdhPJyanEq80ANurIkml0atZYr2KodBDL/eiGxVcAdmGPotcL46UUMBs6zZ+n/X3QkqoSvUIb5s4w==
X-Received: by 2002:a05:6a00:181c:b0:4e1:a270:df4d with SMTP id y28-20020a056a00181c00b004e1a270df4dmr18887237pfa.71.1646011174152;
        Sun, 27 Feb 2022 17:19:34 -0800 (PST)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id 203-20020a6306d4000000b00364d1cd0888sm8515005pgg.3.2022.02.27.17.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 17:19:33 -0800 (PST)
Date:   Mon, 28 Feb 2022 01:19:25 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Filipe Manana <fdmanana@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v3] btrfs: qgroup: fix deadlock between rescan worker and
 remove qgroup
Message-ID: <20220228011925.GA21082@realwakka>
References: <20220226160330.19122-1-realwakka@gmail.com>
 <20220228005545.j657d2jkrtsope45@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228005545.j657d2jkrtsope45@shindev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 28, 2022 at 12:55:47AM +0000, Shinichiro Kawasaki wrote:

Hi, Shinichiro.
Thanks for detailed review!

> Thanks for this v3 patch. I found some more points to improve in the commit
> message.
> 
> On Feb 26, 2022 / 16:03, Sidong Yang wrote:
> > The commit e804861bd4e6 ("btrfs: fix deadlock between quota disable and
> > qgroup rescan worker") by Kawasaki resolves deadlock between quota
> > disable and qgroup rescan worker. but also there is a deadlock case like
> 
> nit: s/but also/But also/

Thanks.
> 
> > it. It's about enabling or disabling quota and creating or removing
> > qgroup. It can be reproduced in simple script below.
> > 
> > for i in {1..100}
> > do
> >     btrfs quota enable /mnt &
> >     btrfs qgroup create 1/0 /mnt &
> >     btrfs qgroup destroy 1/0 /mnt &
> >     btrfs quota disable /mnt &
> > done
> > 
> > Here's why the deadlock happens:
> > 
> > 1) The quota rescan task is running.
> > 
> > 2) Task A calls btrfs_quota_disable(), locks the qgroup_ioctl_lock
> >    mutex, and then calls btrfs_qgroup_wait_for_completion(), to wait for
> >    the quota rescan task to complete.
> > 
> > 3) Task B calls btrfs_remove_qgroup() and it blocks when trying to lock
> >    the qgroup_ioctl_lock mutex, because it's being held by task A. At that
> >    To  resolve this issue, The thread disabling quota should unlock
> >    int task B is holding a transaction handle for the current transaction.
> 
> I think you made a mistake in the two lines above, when you copied the text that
> Filipe suggested.

Oops. It's my mistake.
> 
> > 
> > 4) The quota rescan task calls btrfs_commit_transaction(). This results
> >    in it waiting for all other tasks to release their handles on the
> >    transaction, but task B is blocked on the qgroup_ioctl_lock mutex
> >    while holding a handle on the transaction, and that mutex is being held
> >    by task A, which is waiting for the quota rescan task to complete,
> >    resulting in a deadlock between these 3 tasks.
> > 
> > To resolve this issue, The thread disabling quota should unlock
> 
> nit: s/The thread/the thread/
> 
> > qgroup_ioctl_lock before waiting rescan completion. This patch moves
> > btrfs_qgroup_wait_for_completion() after qgroup_ioctl_lock().
> 
> Do you mean 'unlock of qgroup_ioctl_lock' instead of 'qgroup_ioclt_lock()?

Yeah, It should be unlock of qgroup_ioctl_lock. qgroup_ioctl_lock is not
a function but value. 

> 
> Also, according to Documentation/process/submitting-patches.rst, imperative
> mood is recommended for commit messages. Then the sentence above can be:
> 
>   Move btrfs_qgroup_wait_for_completion() after unlock of qgroup_ioctl_lock.

Thanks, What I wrote is exact bad example for this. I need to read the
guide carefully.

Thanks,
Sidong
> 
> -- 
> Best Regards,
> Shin'ichiro Kawasaki
> 
> > 
> > Fixes: e804861bd4e6 ("btrfs: fix deadlock between quota disable and
> > qgroup rescan worker")
> > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > ---
> > v3: fix comments, typos, changelog.
> > v2: add comments, move locking before clear_bit.
> > ---
> >  fs/btrfs/qgroup.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> > index 2c0dd6b8a80c..1866b1f0da01 100644
> > --- a/fs/btrfs/qgroup.c
> > +++ b/fs/btrfs/qgroup.c
> > @@ -1213,6 +1213,14 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
> >  	if (!fs_info->quota_root)
> >  		goto out;
> >  
> > +	/*
> > +	 * Unlock the qgroup_ioctl_lock mutex before waiting for the rescan worker to
> > +	 * complete. Otherwise we can deadlock because btrfs_remove_qgroup() needs
> > +	 * to lock that mutex while holding a transaction handle and the rescan
> > +	 * worker needs to commit a transaction.
> > +	 */
> > +	mutex_unlock(&fs_info->qgroup_ioctl_lock);
> > +
> >  	/*
> >  	 * Request qgroup rescan worker to complete and wait for it. This wait
> >  	 * must be done before transaction start for quota disable since it may
> > @@ -1220,7 +1228,6 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
> >  	 */
> >  	clear_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
> >  	btrfs_qgroup_wait_for_completion(fs_info, false);
> > -	mutex_unlock(&fs_info->qgroup_ioctl_lock);
> >  
> >  	/*
> >  	 * 1 For the root item
> > -- 
> > 2.25.1
> > 
