Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782952189DA
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 16:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgGHOJc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 10:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbgGHOJc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jul 2020 10:09:32 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4693C061A0B
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jul 2020 07:09:31 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id b25so13131692qto.2
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jul 2020 07:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=qSozo8kPRjmbmZ8QZbROS4PgOsje1IUihwwQMW62UbE=;
        b=Y4QI8SrFJxBVZoF4aX9sKFmja9sGn58fDU6MVEAI57Myn7anJKXW7/kVZAvq22+iO9
         HBgRDN9U3MJU/6zyYlSUhyc4cUG1UfanhFup/Uctzv755p82Gp0AkX71ze7V5yms+wkG
         2L4S5FIsqwDDzq1Z9Wbfb7zy++EH+RF6syDSeGeFP85+9tkS50zFKfjIob3tmPHjjSbO
         pYGeByDu1xSwVdWMNgX567fojrp9wstqo2j6K6lIUIlVQx8nuSnbxSyTq3kEOn9cCKU0
         3CFErn4Jj0eZvM88jYdrHLZCor7rH6MzuWLpsJ+ny2CAU2g5Gj0/I/EEt8X8Vvsm3TyT
         s5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qSozo8kPRjmbmZ8QZbROS4PgOsje1IUihwwQMW62UbE=;
        b=L3QvkyiCFbTKIjqskMduuaqRZclPp4zzxnMrHH7/7NUkM5GMgMeN8M9VsPlQgUXS1e
         Me6cQfrqsEvb1cgdQB1XNIJ35bFC4vuDJuiq4+B0HQZVeXZisJG0PXd9h1OJyBgoZ8pX
         2yxWjQjNsaX4KNzoIJ4QGE+KSfw0QsIC5+vvgx0KNVHREqISwISAfGxnkZ03De/Roiy/
         XPqHa7qBDEnNTaTseRjbk0FaDbmo1ofPAY3bHTDlPuhuxWZchKGYibwW7HuBjd/r+uDX
         yA3m7yy1OJUeyy5xpdWV/KL2tA6h1fO7cIoEPy3LWM9BlsHeSuVyM2/mjuqSnyq2gGfC
         OIvA==
X-Gm-Message-State: AOAM5310i7QuaTlQMK6E+l0AX40BYNUQq/HP27X3j8M4CpupPf3DkD3d
        gzd/1eSAjHQPCC5PFUaCRrr7dtIPke53eg==
X-Google-Smtp-Source: ABdhPJy4lL96uuVaR9Ug2HolXOgVKfXAajvz5avt3M9L4r88AAPY5IRc1brhS8JgX3B1irq78MNxQg==
X-Received: by 2002:ac8:3981:: with SMTP id v1mr59662586qte.134.1594217370593;
        Wed, 08 Jul 2020 07:09:30 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 2sm26263818qka.42.2020.07.08.07.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 07:09:29 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] btrfs: qgroup: allow btrfs_qgroup_reserve_data()
 to revert the range it just set without releasing other existing ranges
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200708062447.81341-1-wqu@suse.com>
 <20200708062447.81341-2-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <9a95772f-8986-294f-abc0-447fc1ef0a06@toxicpanda.com>
Date:   Wed, 8 Jul 2020 10:09:28 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200708062447.81341-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/8/20 2:24 AM, Qu Wenruo wrote:
> [PROBLEM]
> Before this patch, when btrfs_qgroup_reserve_data() fails, we free all
> reserved space of the changeset.
> 
> For example:
> 	ret = btrfs_qgroup_reserve_data(inode, changeset, 0, SZ_1M);
> 	ret = btrfs_qgroup_reserve_data(inode, changeset, SZ_1M, SZ_1M);
> 	ret = btrfs_qgroup_reserve_data(inode, changeset, SZ_2M, SZ_1M);
> 
> If the last btrfs_qgroup_reserve_data() failed, it will release all [0,
> 3M) range.
> 
> This behavior is kinda OK for now, as when we hit -EDQUOT, we normally
> go error handling and need to release all reserved ranges anyway.
> 
> But this also means the following call is not possible:
> 	ret = btrfs_qgroup_reserve_data();
> 	if (ret == -EDQUOT) {
> 		/* Do something to free some qgroup space */
> 		ret = btrfs_qgroup_reserve_data();
> 	}
> 
> As if the first btrfs_qgroup_reserve_data() fails, it will free all
> reserved qgroup space.
> 
> [CAUSE]
> This is because we release all reserved ranges when
> btrfs_qgroup_reserve_data() fails.
> 
> [FIX]
> This patch will implement a new function, qgroup_revert(), to iterate
> through the ulist nodes, to find any nodes in the failure range, and
> remove the EXTENT_QGROUP_RESERVED bits from the io_tree, and decrease
> the extent_changeset::bytes_changed, so that we can revert to previous
> status.
> 
> This allows later patches to retry btrfs_qgroup_reserve_data() if EDQUOT
> happens.
> 
> Suggested-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/qgroup.c | 90 +++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 75 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index ee0ad33b659c..84a452dea3f9 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -3447,6 +3447,71 @@ btrfs_qgroup_rescan_resume(struct btrfs_fs_info *fs_info)
>   	}
>   }
>   
> +static int qgroup_revert(struct btrfs_inode *inode,
> +			struct extent_changeset *reserved, u64 start,
> +			u64 len)
> +{
> +	struct rb_node *n = reserved->range_changed.root.rb_node;
> +	struct ulist_node *entry = NULL;
> +	int ret = 0;
> +
> +	while (n) {
> +		entry = rb_entry(n, struct ulist_node, rb_node);
> +		if (entry->val < start)
> +			n = n->rb_right;
> +		else if (entry)
> +			n = n->rb_left;
> +		else
> +			break;
> +	}
> +	/* Empty changeset */
> +	if (!entry)
> +		goto out;

Don't need the goto out here, just return ret;

> +
> +	if (entry->val > start && rb_prev(&entry->rb_node))
> +		entry = rb_entry(rb_prev(&entry->rb_node), struct ulist_node,
> +				 rb_node);
> +
> +	n = &entry->rb_node;
> +	while (n) {

for (n = &entry->rb_node; n; n = rb_next(n)) {

Thanks,

Josef
