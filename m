Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25DA2A5147
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 21:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbgKCUjE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 15:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730038AbgKCUjD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Nov 2020 15:39:03 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C72C0613D1
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Nov 2020 12:39:03 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id da2so6392867qvb.0
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Nov 2020 12:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A4phJpajKYqyaoE/DdNq0vi9xJMK32pI9PlcGh4+QMg=;
        b=TvL1jbEvEVU2N+tFnV8KGEFEsKk2ZrXiSV7TdCRiSSGMUaBCqALeRixZnfYl89YQbI
         QwruM5i4NEc9oanQwtuErmWXl8I8iD5+V8Hx+Z5Sd65pdIbCdFs3uvvtwl4EmMdOhsZU
         nlNpXJjSmogi7XCIk1vh92n7W3HGLOy4AT1zARz/4MZ6RXI51rN0VDsF5cr3pjIe0L61
         +r2BAHy8TVVjzgeLGzy4vJQFM1/gM7ePuuTipEDnFsfdXH2VNKX0d92+u36JlKkhAbMw
         ytUcZjgIkf0Ujjf5qc0w/7IQN0P/bChG5W/nNdWtSeaXjwk1L5mKT0l5IgkusfnsAcBG
         PwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A4phJpajKYqyaoE/DdNq0vi9xJMK32pI9PlcGh4+QMg=;
        b=tiwK940leEZCSk1jlWHZ53q9pC3cvaTrIc0TpECJpqQru+H8X5eLFL0ouBPwrmXXLB
         yZQNbY6o2JpEv6/39YoiFfPSPNxzKbSAB1w5AOYvEky4FckoyF/dy+apt1fMhnK4+uJv
         ARcUSDYSZQOOeNSfs8g4zYDaISJJOpIix5w4oqABZ767L1UMkMQOi6freqj6+6jLBYUu
         7MJygFz7w+Ny4ns1nFtkbKqCJ91XiPGVhfRRwr1vnkICLcVgo/HPKuEGDpDoLRpk0ni+
         C0uHcY0Xx2CohtN2z0q1RxueSghcgQMSkLIzlvrqdslURFbgri2wmVmOLTm41Dp+6Pn9
         /XTg==
X-Gm-Message-State: AOAM532gkG9mJw0wIIGYU7Z/lXhjUgIpUqmvL2/yQY0NtqGNimKCaZ+4
        GudhVmvLso8b/UOmdFeHYa7CMQ==
X-Google-Smtp-Source: ABdhPJyY2x69rq6WsXhzUCL2U2f+3cT69RbiGqN1bVdrmh+65fJSfSmzLl+/hEdBH+SC8jafT5BEVw==
X-Received: by 2002:a0c:9e0e:: with SMTP id p14mr27923458qve.25.1604435942134;
        Tue, 03 Nov 2020 12:39:02 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v204sm11925442qka.4.2020.11.03.12.39.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 12:39:01 -0800 (PST)
Subject: Re: [PATCH v9 35/41] btrfs: enable relocation in ZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <669d00d499b702413a51364b405280798df9c6c3.1604065695.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <165834f6-6814-6f7b-19bf-6a42bb4a5745@toxicpanda.com>
Date:   Tue, 3 Nov 2020 15:39:00 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <669d00d499b702413a51364b405280798df9c6c3.1604065695.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/30/20 9:51 AM, Naohiro Aota wrote:
> To serialize allocation and submit_bio, we introduced mutex around them. As
> a result, preallocation must be completely disabled to avoid a deadlock.
> 
> Since current relocation process relies on preallocation to move file data
> extents, it must be handled in another way. In ZONED mode, we just truncate
> the inode to the size that we wanted to pre-allocate. Then, we flush dirty
> pages on the file before finishing relocation process.
> run_delalloc_zoned() will handle all the allocation and submit IOs to the
> underlying layers.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/relocation.c | 35 +++++++++++++++++++++++++++++++++--
>   1 file changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 3602806d71bd..44b697b881b6 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2603,6 +2603,32 @@ static noinline_for_stack int prealloc_file_extent_cluster(
>   	if (ret)
>   		return ret;
>   
> +	/*
> +	 * In ZONED mode, we cannot preallocate the file region. Instead, we
> +	 * dirty and fiemap_write the region.
> +	 */
> +
> +	if (btrfs_is_zoned(inode->root->fs_info)) {
> +		struct btrfs_root *root = inode->root;
> +		struct btrfs_trans_handle *trans;
> +
> +		end = cluster->end - offset + 1;
> +		trans = btrfs_start_transaction(root, 1);
> +		if (IS_ERR(trans))
> +			return PTR_ERR(trans);
> +
> +		inode->vfs_inode.i_ctime = current_time(&inode->vfs_inode);
> +		i_size_write(&inode->vfs_inode, end);
> +		ret = btrfs_update_inode(trans, root, &inode->vfs_inode);
> +		if (ret) {
> +			btrfs_abort_transaction(trans, ret);
> +			btrfs_end_transaction(trans);
> +			return ret;
> +		}
> +
> +		return btrfs_end_transaction(trans);
> +	}

The reason we pre-allocate is because we need the extents to be exactly how long 
they are on disk.  If we have a 123mib extent, we need the extent it goes into 
to be exactly 123mib, otherwise we cannot simply relocate out its location. 
This doesn't do anything for us.  I'm not even sure we can do relocation for 
zoned since we have to maintain the original extent size, but if you can then 
it's going to be more complicated than just this.  You'll have to either forgo 
WRITE_APPEND for this case, or make sure you can actually write the whole 
ordered extent in one go.  Thanks,

Josef
