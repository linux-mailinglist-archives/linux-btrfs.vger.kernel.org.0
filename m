Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F24A51A4A6D
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Apr 2020 21:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgDJT3c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Apr 2020 15:29:32 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40569 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgDJT3c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Apr 2020 15:29:32 -0400
Received: by mail-qk1-f196.google.com with SMTP id z15so3218408qki.7
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Apr 2020 12:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Y5B+NZ+MuOHmlbcuqOqLD+e0n2RE9zU/1lLpQI00D7c=;
        b=PVWRo/sSciWKDWqE5g9vq95qfVMh4ndw/+dDaVR+qtWHllBX/DGgCekmAcGb3igcSM
         yazW6aowouAwDzNQ18r0gULNap9tq3+lSgruOCMu4h7+INiJ6fks69KYKSm6nihlltjt
         D/CXGe4EYmiJeyjcGPg8HXaoFxNfr8BHoU0Zr7Vl8yCbgDMJ600Mx5FlubCB4td8RoQQ
         yUtBBIIIouS8do6a+/0IUWadoiYHrsn5VwqSWxGLNBG3KZYC+9QyxU9aTIYBsFDazgej
         qSY5GGCsUsTJ4GVia8rajZftX1vR2zO9eWvCAEOsxFbu+HGsETnT3iQa8DmWWJYsctXb
         hEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y5B+NZ+MuOHmlbcuqOqLD+e0n2RE9zU/1lLpQI00D7c=;
        b=fGfm3NH/oj+QwSajPGOnttb8Sq50RvGEkk2In/1NDiRTF3SVybCLYTg3Dsga4+G3NC
         NHHn5tOXBGOHMowqGg05xL2wg49qZDT3/AlF3Z2inbGxiykZacAuBG1wcL/LgbJ/P7Mb
         RkoM0pqsGYcapbfyV184QeN0xCIztqW7/zY20u36y+6tq26T3KsMk7zPtY84YiotVPG5
         aNuRsluMzx1NAy+Ec6RJoz0kgoZgL70U6ljCKtiHGELnsyFYNS8+BpBdQrrXGmu2CC8v
         NhGwo6wv0YjvzvPF/IVpSNqugfG9v0OVmvgiQLkCtqi24m9QiHmoc0WYPRKPopev5R8w
         cAVg==
X-Gm-Message-State: AGi0PubW6eE19B5YFjqSqZK+tTAB4v84uuvy9YffST4R//lCSQ8GyBu+
        ZmcaxI3/YbcqDDzx0M8bMlcdTut5MnuJ1w==
X-Google-Smtp-Source: APiQypI8JDYcPlCjSMD7BRrhIkX8N3Qv0ayy+Co7zdRyN/IlNDLclEwcFQ8AtUEoGSJJCqA8vUPUcA==
X-Received: by 2002:a37:9a8b:: with SMTP id c133mr5449444qke.273.1586546971599;
        Fri, 10 Apr 2020 12:29:31 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id m11sm2205808qkg.130.2020.04.10.12.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 12:29:31 -0700 (PDT)
Subject: Re: [RESEND PATCH 1/2] btrfs: Read stripe len directly in
 btrfs_rmap_block
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200403134035.8875-1-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <f9492306-0d43-a79b-3e67-51e8508d2d32@toxicpanda.com>
Date:   Fri, 10 Apr 2020 15:29:30 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200403134035.8875-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/3/20 9:40 AM, Nikolay Borisov wrote:
> extent_map::orig_block_len contains the size of a physical stripe when
> it's used to describe block groups (calculated in read_one_chunk via
> calc_stripe_length or calculated in decide_stripe_size and then assigned to
> extent_map::orig_block_len in create_chunk). Exploit this fact to get the
> size directly rather than opencoding the calculations. No functional changes.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
> 
> Hello David,
> 
> You had some reservations for this patch but now I've expanded the changelog to
> explain why it's safe to do so.
> 
> 
>   fs/btrfs/block-group.c | 13 +++----------
>   1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 786849fcc319..d0dbaa470b88 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1628,19 +1628,12 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
>   		return -EIO;
> 
>   	map = em->map_lookup;
> -	data_stripe_length = em->len;
> +	data_stripe_length = em->orig_block_len;
>   	io_stripe_size = map->stripe_len;
> 
> -	if (map->type & BTRFS_BLOCK_GROUP_RAID10)
> -		data_stripe_length = div_u64(data_stripe_length,
> -					     map->num_stripes / map->sub_stripes);
> -	else if (map->type & BTRFS_BLOCK_GROUP_RAID0)
> -		data_stripe_length = div_u64(data_stripe_length, map->num_stripes);
> -	else if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
> -		data_stripe_length = div_u64(data_stripe_length,
> -					     nr_data_stripes(map));
> +	/* For raid5/6 adjust to a full IO stripe length */
> +	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
>   		io_stripe_size = map->stripe_len * nr_data_stripes(map);
> -	}
> 

So now data_stripe_length is different in the RAID1 case and the RAID1C* case, 
right?  Is that ok?  I *think* it is, but I'm a little drunk and can't really 
reason it out well.  Thanks,

Josef
