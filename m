Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94542133C4E
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2020 08:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgAHH2R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jan 2020 02:28:17 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42040 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgAHH2R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jan 2020 02:28:17 -0500
Received: by mail-wr1-f65.google.com with SMTP id q6so2177668wro.9
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jan 2020 23:28:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=pUAywDoj/SG2NU35pcjYNdAoiVcj7SXVHagTPrM0cPY=;
        b=XXhjQsSs58b8qSLLX0TRADGwuvSeDT3OmI6bw4/RQVMtalIuN2hEBnb02p9BkGtVDH
         +ZPZIiKztuV9Ny55ZxX8Npt0YUkrg6DVtMRiSW6hHkFquOWctz5laKCQICNG7HGBecuz
         JRuG0KIXNGzYz14BF99AE4wStraWWhojnw41Mb7dPYl7odwf/GwIgqZEBqTaH1/s5Bxy
         odWfVllPK1WpQ5ODluTpHCleWMAOqax7VLHHUIUJtGNpZJoqZ+w9p/PMnuGFh9kmsOas
         vU1rOz91ElHLUS1amOnlJB+eQr2wAvuVcvi+JUH4UMmQstDlkxCV0wL+8TC6t4e4hsdf
         r1bA==
X-Gm-Message-State: APjAAAXcaNkd+T01TGoeJi1xOPSxFtnWKmrZheUfsvDmm8D3gxaaVR3w
        o3vs78ge98NMdRb705Vy6JkbwW86+wI=
X-Google-Smtp-Source: APXvYqzBjDg1/q6HH0sgimFXcmqIoGLJZ+7kwduCLSdG8iAqpfIjxAeBrzRMhHsUvnJfhX6uzUVMKw==
X-Received: by 2002:a5d:4a91:: with SMTP id o17mr3002326wrq.232.1578468495212;
        Tue, 07 Jan 2020 23:28:15 -0800 (PST)
Received: from Johanness-MBP.fritz.box (ppp-46-244-195-226.dynamic.mnet-online.de. [46.244.195.226])
        by smtp.gmail.com with ESMTPSA id h17sm3166562wrs.18.2020.01.07.23.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 23:28:14 -0800 (PST)
Subject: Re: memleaks in btrfs-devel/misc-next
To:     Dennis Zhou <dennis@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <b3cfdb33-11d6-b237-c00f-60e1e51f1848@kernel.org>
 <20200108003104.GA41934@dennisz-mbp.dhcp.thefacebook.com>
From:   Johannes Thumshirn <jth@kernel.org>
Message-ID: <a1834955-9d1e-2f7b-13e9-7be02bd368fe@kernel.org>
Date:   Wed, 8 Jan 2020 08:28:12 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200108003104.GA41934@dennisz-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am 08.01.20 um 01:31 schrieb Dennis Zhou:
[...]
> I believe it's because I forgot to put a reference in the relocation
> path. The below seems to fix it in my tests, but would you mind
> verifying?


Thanks for the quick turn around.
Tested-by: Johannes Thumshirn <jth@kernel.org>

@David can you fold this into
63c3d72cf65e ("btrfs: add the beginning of async discard, discard
workqueue")

> --
> From: Dennis Zhou <dennis@kernel.org>
> Date: Tue, 7 Jan 2020 14:14:04 -0800
> Subject: [PATCH] btrfs: put lookup reference in btrfs_relocate_chunk()
>
> Async discard requires looking up the block_group in the relocation path
> to cancel any work items against it. However, I forgot to put the
> reference from btrfs_lookup_block_group().
>
> Reported-by: Johannes Thumshirn <jth@kernel.org>
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> ---
>  fs/btrfs/volumes.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 65e78e59d5c4..eb55df0d4038 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2898,6 +2898,7 @@ static int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
>  	if (!block_group)
>  		return -ENOENT;
>  	btrfs_discard_cancel_work(&fs_info->discard_ctl, block_group);
> +	btrfs_put_block_group(block_group);
>  
>  	trans = btrfs_start_trans_remove_block_group(root->fs_info,
>  						     chunk_offset);

