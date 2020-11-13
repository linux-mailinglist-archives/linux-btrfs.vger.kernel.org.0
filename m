Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826A52B263A
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 22:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgKMVII (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 16:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKMVII (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 16:08:08 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01ECEC0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 13:08:07 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id v143so10267896qkb.2
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 13:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0IzycMYMzBEq7DTUJ7kiIGvXe9M2ov/aerzA28pmsio=;
        b=dgHmHt860p2lwoGADi3AYRiMZ6VqWmVWMv6XxnzVo9R/M1KY50V40/SWXxwimrd+vQ
         mnZ3XV+E9DsuOihNYvyaK8O+1oaJjJh2pZNwi+pOZpwQrzySgLYuF9X8jJkEJs4Yzj7V
         2NaLAs2qNhSeCvzRQaXHG2A8RJmrmVHOnAQMs4nqONyDNqNTJPVkbehyX7M9JvdyRl3k
         iXvD+dtjn0Erc0VGuwZdlTIFqJbaaYPLXxrvnTYQYk5uQUkQ4pxFfQqhR6DXYZYsswDv
         yEC04KlVIQxFoa6uJ8ShEmqHRBCL0xpO6zAXr120UwqAJKRQ0UkB+979kQFmEdFZ0XTm
         dJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0IzycMYMzBEq7DTUJ7kiIGvXe9M2ov/aerzA28pmsio=;
        b=hKDKQdBTMhiZN+dZ15HC8qDx6zkpAgtauZnwXzN/eBdGXP3nfCN1Bgr31N3lnUeagt
         vnnN2MWT4DvWNwiOsbzKm/D8FjyJvgj5SHTg5wSZqSRBX3Yp2zYYbjxdXzfJ+shmEzvJ
         dOfLZEWZ7r9NtdnmWm+ayaWLvguH/cUr+W4l/mCc/rbdyLlZX1FtHDCvJhjU0XtMuVJV
         EMkSgw5RjBIbkoD3mB/mFxDpo4pw9RyTu2r5Dhx2mwYCblB2n5tvr9Ql1mF4pLL6SnlM
         T27YyzdFHPWAUHNfclgZI6bQfe2zMo3Vw2k7Bn6bWiZFcWIvzSn9Vy1y+0bfKsgJPiUi
         /fTA==
X-Gm-Message-State: AOAM532y7qOJQWUXfCudZbqeS38rwAiH64ft2tFDqaKEAFYSBUh17Y0g
        tsY1HAlDiSA5dc/peri7p75pcxaelxzdVg==
X-Google-Smtp-Source: ABdhPJxKOOfPi5GFyggD8tJaUDd1N/NN3GktMTTNExgrgG3dcX9qbFrUkAwtyonlnh5xU5XiXkRn+A==
X-Received: by 2002:a05:620a:62b:: with SMTP id 11mr4126270qkv.229.1605301686142;
        Fri, 13 Nov 2020 13:08:06 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t65sm7594272qkc.52.2020.11.13.13.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 13:08:05 -0800 (PST)
Subject: Re: [PATCH v2] btrfs-progs: restore: Have -l display subvolume name
To:     Daniel Xu <dxu@dxuuu.xyz>, linux-btrfs@vger.kernel.org,
        dsterba@suse.cz
Cc:     kernel-team@fb.com
References: <f4cf625aa2a0e52f722c7e1e92dc04906e1049dc.1604014245.git.dxu@dxuuu.xyz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <7334d0fe-94ce-37db-cbab-e7d677640096@toxicpanda.com>
Date:   Fri, 13 Nov 2020 16:08:04 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <f4cf625aa2a0e52f722c7e1e92dc04906e1049dc.1604014245.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/29/20 7:33 PM, Daniel Xu wrote:
> This commit has `btrfs restore -l ...` display subvolume names if
> applicable. Before, it only listed subvolume IDs which are not very
> helpful for the user. A subvolume name is much more descriptive.
> 
> Before:
> 	$ btrfs restore ~/scratch/btrfs/fs -l
> 	 tree key (EXTENT_TREE ROOT_ITEM 0) 30425088 level 0
> 	 tree key (DEV_TREE ROOT_ITEM 0) 30441472 level 0
> 	 tree key (FS_TREE ROOT_ITEM 0) 30736384 level 0
> 	 tree key (CSUM_TREE ROOT_ITEM 0) 30474240 level 0
> 	 tree key (UUID_TREE ROOT_ITEM 0) 30785536 level 0
> 	 tree key (256 ROOT_ITEM 0) 30818304 level 0
> 	 tree key (257 ROOT_ITEM 0) 30883840 level 0
> 	 tree key (DATA_RELOC_TREE ROOT_ITEM 0) 30490624 level 0
> 
> After:
> 	$ ./btrfs restore ~/scratch/btrfs/fs -l
> 	 tree key (EXTENT_TREE ROOT_ITEM 0) 30425088 level 0
> 	 tree key (DEV_TREE ROOT_ITEM 0) 30441472 level 0
> 	 tree key (FS_TREE ROOT_ITEM 0) 30736384 level 0
> 	 tree key (CSUM_TREE ROOT_ITEM 0) 30474240 level 0
> 	 tree key (UUID_TREE ROOT_ITEM 0) 30785536 level 0
> 	 tree key (256 ROOT_ITEM 0) 30818304 level 0 subvol1
> 	 tree key (257 ROOT_ITEM 0) 30883840 level 0 subvol2
> 	 tree key (DATA_RELOC_TREE ROOT_ITEM 0) 30490624 level 0
> 
> Link: https://github.com/kdave/btrfs-progs/issues/289
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
