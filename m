Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1155786FA
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 18:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbiGRQHi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 12:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235327AbiGRQHi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 12:07:38 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39DA2A433
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 09:07:36 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id l11so9084421qvu.13
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 09:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2pVUk+Hzj9/FYAwDpv8NXa1WAMpUc2fJJbzO0WFNlBQ=;
        b=rUyE/dW+sWkcRi0ES1DeKuAEJJfnanEA/3U0WyLXa5QnVz2ucPYatG6+wwRHPcdSpy
         0nm9NvCTGvOSfy+A/Y0L5eUQ93RWCkHJ7wsWI/wC2cNDcWwnfo9RiPb/BNdUl8ZoAZyd
         ASYW8fF3Fsw6isgNv2S6ben0GLXsePGAgg/nwV2dyOBv3Rkrmnd1XFDuxOuj+o5ZSsri
         6GNujZAyn3f/LttRrxzLxIGJ8G162raKr0YmhGpGLZfJa8IJHzXa44w36ZdJCaG5Kuil
         mONTaqsN/IPbZ5WD2aiA0Z+s1gtCq+7nmgSkIsEHXsvGhuq5t3v4Wn+kwOK8EdCWtL2z
         Vxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2pVUk+Hzj9/FYAwDpv8NXa1WAMpUc2fJJbzO0WFNlBQ=;
        b=r98BcgWJm4nJOQcpEXJUR3a+GtctYOu0AL6ItWt1NmecqA5rHkCQnTfCEnlyTlhE6Q
         r8Ef7tEfrNWNbQdkg4J/NKT66/sCqbDFo+9j6kIP+rv2yJUBqrflE9HYidudJnZEmgVX
         MapUKjYfIYoP8tWO794G9wonAUyFva2yzNaW1oKVsVYDMlbVjoiQ5v9s4m/rsC4u4EOg
         xfJ6/Jr2/RZ+AnoGFDIjB/0uO/WqZDDgJpgfmQTohW3ww1UJ6FynUgrxAjqci5pFH41X
         Nwo6b1zM+wdU6kK9LaLnJG18pakAlDSJ9ucIJY0ckaDBOz/Pc1cyT8dKgV1rUBh+Gp6f
         adBg==
X-Gm-Message-State: AJIora+ZWAXl2aI3PAdOXwHdHb/L3VdIKXSLvvq5ZX+6Tk6v+KUPc9aQ
        ZORiChGN3US2LWG6W1iNAe1RvVnPwzQeJg==
X-Google-Smtp-Source: AGRyM1v7aUnIHdPYL7iDfEAUq3opqcWJzYY7CVjoOL1SklQqDfsN8FAFRDFZ8g7fQb2T7Qsk5lfImg==
X-Received: by 2002:a05:6214:dca:b0:473:bde:8495 with SMTP id 10-20020a0562140dca00b004730bde8495mr21599108qvt.40.1658160455750;
        Mon, 18 Jul 2022 09:07:35 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n18-20020a05620a295200b006b5e45ff82csm4647695qkp.93.2022.07.18.09.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 09:07:35 -0700 (PDT)
Date:   Mon, 18 Jul 2022 12:07:34 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: join running log transaction when logging new name
Message-ID: <YtWFRrgOJ7QaFsJs@localhost.localdomain>
References: <502f1d2cc23000b8585ad87122b7f6c0a8c2c6ab.1658091704.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <502f1d2cc23000b8585ad87122b7f6c0a8c2c6ab.1658091704.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 17, 2022 at 10:05:05PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When logging a new name, in case of a rename, we pin the log before
> changing it. We then either delete a directory entry from the log or
> insert a key range item to mark the old name for deletion on log replay.
> 
> However when doing one of those log changes we may have another task that
> started writing out the log (at btrfs_sync_log()) and it started before
> we pinned the log root. So we may end up changing a log tree while its
> writeback is being started by another task syncing the log. This can lead
> to inconsistencies in a log tree and other unexpected results during log
> replay, because we can get some committed node pointing to a node/leaf
> that ends up not getting written to disk before the next log commit.
> 
> The problem, conceptually, started to happen in commit 88d2beec7e53fc
> ("btrfs: avoid logging all directory changes during renames"), because
> there we started to update the log without joining its current transaction
> first.
> 
> However the problem only became visible with commit 259c4b96d78dda
> ("btrfs: stop doing unnecessary log updates during a rename"), and that is
> because we used to pin the log at btrfs_rename() and then before entering
> btrfs_log_new_name(), when unlinking the old dentry, we ended up at
> btrfs_del_inode_ref_in_log() and btrfs_del_dir_entries_in_log(). Both
> of them join the current log transaction, effectively waiting for any log
> transaction writeout (due to acquiring the root's log_mutex). This made it
> safe even after leaving the current log transaction, because we remained
> with the log pinned when we called btrfs_log_new_name().
> 
> Then in commit 259c4b96d78dda ("btrfs: stop doing unnecessary log updates
> during a rename"), we removed the log pinning from btrfs_rename() and
> stopped calling btrfs_del_inode_ref_in_log() and
> btrfs_del_dir_entries_in_log() during the rename, and started to do all
> the needed work at btrfs_log_new_name(), but without joining the current
> log transaction, only pinning the log, which is racy because another task
> may have started writeout of the log tree right before we pinned the log.
> 
> Both commits landed in kernel 5.18, so it doesn't make any practical
> difference which should be blamed, but I'm blaming the second commit only
> because with the first one, by chance, the problem did not happen due to
> the fact we joined the log transaction after pinning the log and unpinned
> it only after calling btrfs_log_new_name().
> 
> So make btrfs_log_new_name() join the current log transaction instead of
> pinning it, so that we never do log updates if it's writeout is starting.
> 
> Fixes: 259c4b96d78dda ("btrfs: stop doing unnecessary log updates during a rename")
> CC: stable@vger.kernel.org # 5.18+
> Reported-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
> Tested-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
