Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63D5878CFC
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2019 15:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfG2Ni7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Jul 2019 09:38:59 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44871 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfG2Ni7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Jul 2019 09:38:59 -0400
Received: by mail-qt1-f195.google.com with SMTP id 44so28628111qtg.11
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2019 06:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4ExJgCH3jkTtRb0859IcYKAiEfRaIpIYK5KxDMMhMmI=;
        b=jRXrximwieG6CEtYNexJ/z6H19fUKp8hqRHcaNhXTRfhdS9Qzf4uX9cD3YcJu/cMk/
         /vJq+vD3DednzduBANIEnQ8y12T4Lf1b1dBsDKBb5tJ/PU2Fhq+aEv2CUFypI3AsNnI1
         txI7NJr1S/zpDJSjtIjD6eNHzsjVDaXFMqesYdUVY9IoSkM7etPCSSi4ocATUwp+UYDT
         i5VVuZDjokMuk4w+XeUOLOPqV1Rn79Nc6TPGWv1zAN2i+DywdH9/7JD8lHC2tXWFdv5y
         ExeJDLf9ExQ1GI+KuYBGwHu+BsKJVGoMzgQYmCx0QJP7fd7RrrE7qs6TUlWSPapnOsQH
         JeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4ExJgCH3jkTtRb0859IcYKAiEfRaIpIYK5KxDMMhMmI=;
        b=C7nglgpUZP2NvaPpJ73DmEo8c+ilAS3aZ7ODl+iDel/j/CizJyN1MjaU2DTFXDM4id
         XT/1qlNNxrpNCpPSQX3xo5RWf9WjmFcW0sxj98jVnPGxHKc5xsvX2ItsT7YL0UfuMBjZ
         4DURl85mpBPRTRqGkmaO4FNQ4dNh1Tw3gVJvxLQhgQ8J+eLF85a4ld8iJAm2yv5OGi9s
         pgF6P7xVlXrFwtLUNa02izDxO3BJI8BGGuWe7/qYsFh4dfhPbfBl77pQ8KROt84Dox5M
         zFT2EIxx2OUdiodZ+BboNay7cH8E324meDGYg30zi9cMvyElC0ykorVJMU4BlWTLHuL6
         hVDQ==
X-Gm-Message-State: APjAAAX3uflAv6seTHPw5n9k74euA/5sJ3jcHfgA2jHz7ojvPl9sRpc4
        xS7+2JhvcFhKlR0SP8OEZz/bMB2dpH8=
X-Google-Smtp-Source: APXvYqzEyIUbJW1ynFk4PtH8yZlYJSlfAcVB4PZDXEV8eRhq3U0Nrte4KPR1L3lZV+qrGaRDNHx6xg==
X-Received: by 2002:aed:355d:: with SMTP id b29mr77725720qte.12.1564407537735;
        Mon, 29 Jul 2019 06:38:57 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::a861])
        by smtp.gmail.com with ESMTPSA id h4sm27231132qkk.39.2019.07.29.06.38.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 06:38:57 -0700 (PDT)
Date:   Mon, 29 Jul 2019 09:38:55 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: fix race leading to fs corruption after
 transaction abortion
Message-ID: <20190729133854.lkaiv7fvw4lf3cun@macbook-pro-91.dhcp.thefacebook.com>
References: <20190725102704.11404-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725102704.11404-1-fdmanana@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 25, 2019 at 11:27:04AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When one transaction is finishing its commit, it is possible for another
> transaction to start and enter its initial commit phase as well. If the
> first ends up getting aborted, we have a small time window where the second
> transaction commit does not notice that the previous transaction aborted
> and ends up committing, writing a superblock that points to btrees that
> reference extent buffers (nodes and leafs) that were not persisted to disk.
> The consequence is that after mounting the filesystem again, we will be
> unable to load some btree nodes/leafs, either because the content on disk
> is either garbage (or just zeroes) or corresponds to the old content of a
> previouly COWed or deleted node/leaf, resulting in the well known error
> messages "parent transid verify failed on ...".
> The following sequence diagram illustrates how this can happen.
> 
>         CPU 1                                           CPU 2
> 
>  <at transaction N>
> 
>  btrfs_commit_transaction()
>    (...)
>    --> sets transaction state to
>        TRANS_STATE_UNBLOCKED
>    --> sets fs_info->running_transaction
>        to NULL
> 
>                                                     (...)
>                                                     btrfs_start_transaction()
>                                                       start_transaction()
>                                                         wait_current_trans()
>                                                           --> returns immediately
>                                                               because
>                                                               fs_info->running_transaction
>                                                               is NULL
>                                                         join_transaction()
>                                                           --> creates transaction N + 1
>                                                           --> sets
>                                                               fs_info->running_transaction
>                                                               to transaction N + 1
>                                                           --> adds transaction N + 1 to
>                                                               the fs_info->trans_list list
>                                                         --> returns transaction handle
>                                                             pointing to the new
>                                                             transaction N + 1
>                                                     (...)
> 
>                                                     btrfs_sync_file()
>                                                       btrfs_start_transaction()
>                                                         --> returns handle to
>                                                             transaction N + 1
>                                                       (...)
> 
>    btrfs_write_and_wait_transaction()
>      --> writeback of some extent
>          buffer fails, returns an
> 	 error
>    btrfs_handle_fs_error()
>      --> sets BTRFS_FS_STATE_ERROR in
>          fs_info->fs_state
>    --> jumps to label "scrub_continue"
>    cleanup_transaction()
>      btrfs_abort_transaction(N)
>        --> sets BTRFS_FS_STATE_TRANS_ABORTED
>            flag in fs_info->fs_state
>        --> sets aborted field in the
>            transaction and transaction
> 	   handle structures, for
>            transaction N only
>      --> removes transaction from the
>          list fs_info->trans_list
>                                                       btrfs_commit_transaction(N + 1)
>                                                         --> transaction N + 1 was not
> 							    aborted, so it proceeds
>                                                         (...)
>                                                         --> sets the transaction's state
>                                                             to TRANS_STATE_COMMIT_START
>                                                         --> does not find the previous
>                                                             transaction (N) in the
>                                                             fs_info->trans_list, so it
>                                                             doesn't know that transaction
>                                                             was aborted, and the commit
>                                                             of transaction N + 1 proceeds
>                                                         (...)
>                                                         --> sets transaction N + 1 state
>                                                             to TRANS_STATE_UNBLOCKED
>                                                         btrfs_write_and_wait_transaction()
>                                                           --> succeeds writing all extent
>                                                               buffers created in the
>                                                               transaction N + 1
>                                                         write_all_supers()
>                                                            --> succeeds
>                                                            --> we now have a superblock on
>                                                                disk that points to trees
>                                                                that refer to at least one
>                                                                extent buffer that was
>                                                                never persisted
> 
> So fix this by updating the transaction commit path to check if the flag
> BTRFS_FS_STATE_TRANS_ABORTED is set on fs_info->fs_state if after setting
> the transaction to the TRANS_STATE_COMMIT_START we do not find any previous
> transaction in the fs_info->trans_list. If the flag is set, just fail the
> transaction commit with -EROFS, as we do in other places. The exact error
> code for the previous transaction abort was already logged and reported.
> 
> Fixes: 49b25e0540904b ("btrfs: enhance transaction abort infrastructure")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/transaction.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 3f6811cdf803..7b8bd9046229 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -2019,6 +2019,17 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>  		}
>  	} else {
>  		spin_unlock(&fs_info->trans_lock);
> +		/*
> +		 * The previous transaction was aborted and was already removed
> +		 * from the list of transactions at fs_info->trans_list. So we
> +		 * abort to prevent writing a new superblock that reflects a
> +		 * corrupt state (pointing to trees with unwritten nodes/leafs).
> +		 */
> +		if (test_bit(BTRFS_FS_STATE_TRANS_ABORTED,
> +			     &fs_info->fs_state)) {
> +			ret = -EROFS;
> +			goto cleanup_transaction;
> +		}
>  	}
>  
>  	extwriter_counter_dec(cur_trans, trans->type);

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
