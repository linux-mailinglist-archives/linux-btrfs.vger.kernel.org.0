Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866494E59BA
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 21:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240569AbiCWUS7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 16:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239619AbiCWUS5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 16:18:57 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AD18BF15
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 13:17:26 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id t7so2190545qta.10
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 13:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ARMW266FOX5vdi1XPB905/KPUMdzUmknXV1o2Hltu1c=;
        b=2/vwLVSMSkvZ+54Y/Sm7BPlbHGmP+CTgTghD/lTB9LYW1zpvi0SGzY+YavwoVh+iD8
         YDgw6pA0I7Q95AGZDeImqPdfVH7yx9wd8RecDSX1WpHI4XNK4nzXEG2j+CI3S6Y/txXi
         ZpgCwmGppfkrJozzofGV8jztZANlwNS3HWawH5KOLQ8+6ac5WeQZvjHftz0w/okjWnIo
         3ScylVYr9i6vEgeYsFYxCgyKCvy1pT9Sd/eYR6H/TgJWhOIMs1OZFXf/tgLz/bl9/lrp
         VsdJig8DknCt5yAGNQxpM/cNrYgT2YIt/LCwoGrf6vy33UhU7zuey1XtGnfJRKHY0TXw
         pT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ARMW266FOX5vdi1XPB905/KPUMdzUmknXV1o2Hltu1c=;
        b=mxm52hqqBTAQiAI4+Ifcnrca25hyBK3pclL7jt0ZjL+NhVotL6DXFvsBKnYEwSSAit
         AFxKNPXJ3Q71dkCqyX6MBAfJN75dBJ5QKWdFieHonP6Vb84bMX+PCHy72T5RzxZWw5f2
         iydYKR7BOy9cyjlEdAY6WNqq68Xc4AcqujHYdmloI4Saj4zWr/k2yek/Ix0yGS392doE
         5oe40SBdXF/4xeIRIDh2XJznDM+idA1/a7HpDG+XTplCZ+fLSnJ1arCKE720KqFV7dZ9
         +jrTdZtJjhG4zbFJ8PcyJNF57R2l8xzCJrCNeTzWLfOgJUGz48xC62quIoLP7GBD4u9N
         CCzw==
X-Gm-Message-State: AOAM530yytVUlHhoQAUACfLC8i9BhrSWhUlfNEUa9siUwVSTefY3lB6E
        FWJmcwpl0+VO9gi/u0UT/sEEJcTZyt6Ruw==
X-Google-Smtp-Source: ABdhPJzPwRQyFpoVR4GZZGGs5UaonPZL1A+hXdQyXya/zUqDmoDYL55uh2UABcxGQnrRj7j/nGgLyw==
X-Received: by 2002:a05:622a:1b89:b0:2e2:1ed2:310d with SMTP id bp9-20020a05622a1b8900b002e21ed2310dmr1445459qtb.421.1648066645973;
        Wed, 23 Mar 2022 13:17:25 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b17-20020a05622a021100b002e1f86db385sm667748qtx.68.2022.03.23.13.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:17:25 -0700 (PDT)
Date:   Wed, 23 Mar 2022 16:17:24 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] btrfs: do not clear read-only when adding sprout device
Message-ID: <YjuAVJ6PwxXjwWOZ@localhost.localdomain>
References: <16c05d39566858bb8bc1e03bd19947cf2b601b98.1647906815.git.boris@bur.io>
 <b4ff2316-fca8-2f04-bf0a-d7747118b768@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4ff2316-fca8-2f04-bf0a-d7747118b768@oracle.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 23, 2022 at 06:44:42PM +0800, Anand Jain wrote:
> On 22/03/2022 07:56, Boris Burkov wrote:
> > If you follow the seed/sprout wiki, it suggests the following workflow:
> > 
> > btrfstune -S 1 seed_dev
> > mount seed_dev mnt
> > btrfs device add sprout_dev
> 
> > mount -o remount,rw mnt
> or
>  umount mnt
>  mount sprout mnt
> 
> > The first mount mounts the FS readonly, which results in not setting
> > BTRFS_FS_OPEN, and setting the readonly bit on the sb.
> 
>  Why not set the BTRFS_FS_OPEN?
> 
> @@ -3904,8 +3904,11 @@ int __cold open_ctree(struct super_block *sb, struct
> btrfs_fs_devices *fs_device
>                 goto fail_qgroup;
>         }
> 
> -       if (sb_rdonly(sb))
> +       if (sb_rdonly(sb)) {
> +               btrfs_set_sb_rdonly(sb);
> +               set_bit(BTRFS_FS_OPEN, &fs_info->flags);
>                 goto clear_oneshot;
> +       }
> 
>         ret = btrfs_start_pre_rw_mount(fs_info);
>         if (ret) {
> 
> > The device add
> > somewhat surprisingly clears the readonly bit on the sb (though the
> > mount is still practically readonly, from the users perspective...).
> > Finally, the remount checks the readonly bit on the sb against the flag
> > and sees no change, so it does not run the code intended to run on
> > ro->rw transitions, leaving BTRFS_FS_OPEN unset.
> 
>  Originally, the step 'btrfs device add sprout_dev' provided seed
>  fs writeable without a remount.
> 
>  I think the btrfs_clear_sb_rdonly(sb) in btrfs_init_new_device()
>  was part of it.
> 

Yeah this was a bad idea, I don't want to randomly flip a mount from ro->rw
without the user telling us to.  Thanks,

Josef
