Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA681F9EC9
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jun 2020 19:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731179AbgFORs2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jun 2020 13:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbgFORs1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jun 2020 13:48:27 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2471BC061A0E
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Jun 2020 10:48:27 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id i16so13291945qtr.7
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Jun 2020 10:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=5KHmQsv3zDmH39i0VO7YIFhQPhyJHthazBK7jjNhY4Y=;
        b=ZmztMO/qYGR8fm4VV+ZE8RrOSe14ChImzAIO/Pq07MIqA927tg/yZBp5tBpc+6lGFm
         DEnQWPZsjZ/VMKXx7AEstRkpdxBsc2mZKOtImyPf1/ZwO5lN6iNxFTbRacQYuvIe/e7e
         9Scb5pVNmihxVCBvgVKJa4gg4KxwtDgjTfEpmTW9vbLECl+9MyGruD+JBJ2/vjoOOs71
         5hJa0kLRlOujrSxFGs0gmb9/TCbbYO7rjR3Hv69CjbKsRuh7xu9G0vCGLgcnjgwQwW97
         qLMaeDFkgFgf5IW3EvTS/eMh3JuDki0ytINbUZ+sS0HUvIKW76yUI9sLW8CyeP9oockj
         hMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5KHmQsv3zDmH39i0VO7YIFhQPhyJHthazBK7jjNhY4Y=;
        b=jB4X2GEQuswn0Q5UJTOhIfIMrtP7BFkRe2+ufUvsPP/avACFtkNi8iwa3Y9RxJhzMA
         9GCj46DCn/EGk4X5Ucvl6mr5pdXkpZtobUuLmJbUelrNsHqqFMsRRcuiZRFJ3YF8QNRn
         fPEqPguvhntOoQlzI23MSJYxPYbR1JjyfRWZg9P9CG0W7t/9irN7elZYeW9sgb5Rq7Wu
         y2WPSSG+ssk9xCDWrFubCqHfYoPu/Os8I/+nuZyTrxCsnYB6y4S/75J5hihfwbc8szgn
         5O8OJx4ayyQCQDkAzUzPm+5R5KbZVaMjRYD2Qrd8nLzsRXz0CaNuVHYUCrI9z6Qa63Lv
         8TIw==
X-Gm-Message-State: AOAM530fdrvcXMR78FBAmfGWk3RwrUPp4RnD6JKpxMszXBiL6gvdEhDJ
        dQ4aoOvYAK80t/CITpGTFHY2qRt1UhlkEg==
X-Google-Smtp-Source: ABdhPJxTAjZ8hAZ4yPXP4dFLATtVLfXmY0aJzm83Q5XFMu8wFTlDslSOG7+bSbweq+cyU5Pg+4zdiQ==
X-Received: by 2002:ac8:1844:: with SMTP id n4mr16715829qtk.142.1592243305776;
        Mon, 15 Jun 2020 10:48:25 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 5sm11445543qko.14.2020.06.15.10.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 10:48:24 -0700 (PDT)
Subject: Re: [PATCH] Btrfs: check if a log root exists before locking the
 log_mutex on unlink
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200615093844.287269-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <97473222-1833-2447-10a4-ba06d616dc70@toxicpanda.com>
Date:   Mon, 15 Jun 2020 13:48:23 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200615093844.287269-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/15/20 5:38 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This brings back an optimization that commit e678934cbe5f02 ("btrfs:
> Remove unnecessary check from join_running_log_trans") removed, but in
> a different form. So it's almost equivalent to a revert.
> 
> That commit removed an optimization where we avoid locking a root's
> log_mutex when there is no log tree created in the current transaction.
> The affected code path is triggered through unlink operations.
> 
> That commit was based on the assumption that the optimization was not
> necessary because we used to have the following checks when the patch
> was authored:
> 
>    int btrfs_del_dir_entries_in_log(...)
>    {
>          (...)
>          if (dir->logged_trans < trans->transid)
>              return 0;
> 
>          ret = join_running_log_trans(root);
>          (...)
>     }
> 
>     int btrfs_del_inode_ref_in_log(...)
>     {
>          (...)
>          if (inode->logged_trans < trans->transid)
>              return 0;
> 
>          ret = join_running_log_trans(root);
>          (...)
>     }
> 
> However before that patch was merged, another patch was merged first which
> replaced those checks because they were buggy.
> 
> That other patch corresponds to commit 803f0f64d17769 ("Btrfs: fix fsync
> not persisting dentry deletions due to inode evictions"). The assumption
> that if the logged_trans field of an inode had a smaller value then the
> current transaction's generation (transid) meant that the inode was not
> logged in the current transaction was only correct if the inode was not
> evicted and reloaded in the current transaction. So the corresponding bug
> fix changed those checks and replaced them with the following helper
> function:
> 
>    static bool inode_logged(struct btrfs_trans_handle *trans,
>                             struct btrfs_inode *inode)
>    {
>          if (inode->logged_trans == trans->transid)
>                  return true;
> 
>          if (inode->last_trans == trans->transid &&
>              test_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &inode->runtime_flags) &&
>              !test_bit(BTRFS_FS_LOG_RECOVERING, &trans->fs_info->flags))
>                  return true;
> 
>          return false;
>    }
> 
> So if we have a subvolume without a log tree in the current transaction
> (because we had no fsyncs), every time we unlink an inode we can end up
> trying to lock the log_mutex of the root through join_running_log_trans()
> twice, once for the inode being unlinked (by btrfs_del_inode_ref_in_log())
> and once for the parent directory (with btrfs_del_dir_entries_in_log()).
> 
> This means if we have several unlink operations happening in parallel for
> inodes in the same subvolume, and the those inodes and/or their parent
> inode were changed in the current transaction, we end up having a lot of
> contention on the log_mutex.
> 
> The test robots from intel reported a -30.7% performance regression for
> a REAIM test after commit e678934cbe5f02 ("btrfs: Remove unnecessary check
> from join_running_log_trans").
> 
> So just bring back the optimization to join_running_log_trans() where we
> check first if a log root exists before trying to lock the log_mutex. This
> is done by checking for a bit that is set on the root when a log tree is
> created and removed when a log tree is freed (at transaction commit time).
> 
> Commit e678934cbe5f02 ("btrfs: Remove unnecessary check from
> join_running_log_trans") was merged in the 5.4 merge window while commit
> 803f0f64d17769 ("Btrfs: fix fsync not persisting dentry deletions due to
> inode evictions") was merged in the 5.3 merge window. But the first
> commit was actually authored before the second commit (May 23 2019 vs
> June 19 2019).
> 
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Link: https://lore.kernel.org/lkml/20200611090233.GL12456@shao2-debian/
> Fixes: e678934cbe5f02 ("btrfs: Remove unnecessary check from join_running_log_trans")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
