Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44863296A60
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Oct 2020 09:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374394AbgJWHiM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Oct 2020 03:38:12 -0400
Received: from out20-27.mail.aliyun.com ([115.124.20.27]:56453 "EHLO
        out20-27.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374392AbgJWHiM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Oct 2020 03:38:12 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1592565|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00885363-0.00125495-0.989891;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047209;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.InKuMg7_1603438690;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.InKuMg7_1603438690)
          by smtp.aliyun-inc.com(10.147.41.120);
          Fri, 23 Oct 2020 15:38:10 +0800
Date:   Fri, 23 Oct 2020 15:38:15 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     louis@waffle.tech
Subject: Re: [PATCH] btrfs: balance RAID1/RAID10 mirror selection
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <8541d6d7a63e470b9f4c22ba95cd64fc@waffle.tech>
References: <8541d6d7a63e470b9f4c22ba95cd64fc@waffle.tech>
Message-Id: <20201023153814.643F.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.01 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, Louis Jencka

Can we move 'atomic_t rr_counter' into 'struct btrfs_fs_info' to
support multiple mounted btrfs filesystem?

Although 'readmirror feature (read_policy sysfs)'  is talked about, 
round-robin is a replacement for BTRFS_READ_POLICY_PID in most case, 
we no longer need BTRFS_READ_POLICY_PID ?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2020/10/23

> Balance RAID1/RAID10 mirror selection via plain round-robin scheduling. This should roughly double throughput for large reads.
> 
> Signed-off-by: Louis Jencka <louis@waffle.tech>
> ---
>  fs/btrfs/volumes.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 58b9c419a..45c581d46 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -333,6 +333,9 @@ struct list_head * __attribute_const__ btrfs_get_fs_uuids(void)
>  	return &fs_uuids;
>  }
>  
> +/* Used for round-robin balancing RAID1/RAID10 reads. */
> +atomic_t rr_counter = ATOMIC_INIT(0);
> +
>  /*
>   * alloc_fs_devices - allocate struct btrfs_fs_devices
>   * @fsid:		if not NULL, copy the UUID to fs_devices::fsid
> @@ -5482,7 +5485,8 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
>  	else
>  		num_stripes = map->num_stripes;
>  
> -	preferred_mirror = first + current->pid % num_stripes;
> +	preferred_mirror = first +
> +	    (unsigned)atomic_inc_return(&rr_counter) % num_stripes;
>  
>  	if (dev_replace_is_ongoing &&
>  	    fs_info->dev_replace.cont_reading_from_srcdev_mode ==


