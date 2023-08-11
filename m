Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCC377915F
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Aug 2023 16:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjHKOGk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Aug 2023 10:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjHKOGj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Aug 2023 10:06:39 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFADE65
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Aug 2023 07:06:39 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-76c4890a220so154726785a.3
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Aug 2023 07:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1691762798; x=1692367598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1LaTqs7ZBDewPUU56wdQ2mZ0WG5gFPridMnasGRU3TE=;
        b=oSK6H2f1VoLGhkFVBFahTNmiaSz+9ddjuI7eviPMvJ23ReEL68H3nocV28Z1XOeaYw
         E73p5yUm11yWzBWpXQ6b4KnJaRAGrmcuc3w0c4ulQ7ajDCuO7ry7m2W0MxIn6umjJ6bA
         umyQzzYTxKp/XHJAzkuzeYwZbvT6dwi5uiJ+4yaRNI4NYJkeJY+aXqkHrUKeF+YN1ou8
         AWC/NjpndTfNBg3L+YFGahuwqzvKVLB0c9+7+4j0WxrHKwKwhbMb81PY8j0+xMqRZuHM
         LQjwHspSoiBllinG6/eikDj+TIYrWBESVX4oxvc3KBX4S809bt0wZhm/6JXT6vikdyIz
         HGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691762798; x=1692367598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1LaTqs7ZBDewPUU56wdQ2mZ0WG5gFPridMnasGRU3TE=;
        b=dQgFGq5pM/h1HRQdUpFrcD3kyoYFCeWzP/Y3vwpyt+r4S56+htx6oDHhdsgpOVN0Ld
         24lNu4GzxmGtsfDfulm1wZWUZPc7Ji/x9xv/jne1J1Y6LuaAtqqPVYoxllSuYFVW8apc
         PGal1vwxHHo+RMWemcW60PJiC6At0WOfUkGcrUMmm8P4l8XdFzl1CxUQk564kUPLQQ8w
         zyfRcN5a93R1T2cNTofLgBHv/ZQAqV1LGYfMZzdGDiQRDt3KOZK2wikTG+Xo/oLjg1qH
         zgrtC74v/s8P9cQy6FK3wBtoYdKSPoSOWO6kTyyVfmaMLoRdOYf/TeyLWZvLAUMrRkeG
         +pUQ==
X-Gm-Message-State: AOJu0YxobrApeFLY/1BlV1gM0Wcz/gbxk++mvfN4luosCW53NOzPdAVF
        xaO3PixcPdnaNykjkMtss9X49g==
X-Google-Smtp-Source: AGHT+IHQZCuZ3R57Hm5e/nQz9l3ao+mbtKSvreuooOPx+q/w0ud5TQ0ygRS57Q8Om4iNn3D4C5VUdQ==
X-Received: by 2002:a05:620a:f13:b0:76a:eee2:cd09 with SMTP id v19-20020a05620a0f1300b0076aeee2cd09mr2216785qkl.9.1691762798225;
        Fri, 11 Aug 2023 07:06:38 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m14-20020ae9e70e000000b0076c7f3dd32csm1205342qka.100.2023.08.11.07.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 07:06:37 -0700 (PDT)
Date:   Fri, 11 Aug 2023 10:06:36 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Denis Efremov <efremov@linux.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Darrick J . Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-s390@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 15/17] block: call into the file system for ioctl
 BLKFLSBUF
Message-ID: <20230811140636.GB2724906@perftesting>
References: <20230811100828.1897174-1-hch@lst.de>
 <20230811100828.1897174-16-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811100828.1897174-16-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 11, 2023 at 12:08:26PM +0200, Christoph Hellwig wrote:
> BLKFLSBUF is a historic ioctl that is called on a file handle to a
> block device and syncs either the file system mounted on that block
> device if there is one, or otherwise the just the data on the block
> device.
> 
> Replace the get_super based syncing with a holder operation to remove
> the last usage of get_super, and to also support syncing the file system
> if the block device is not the main block device stored in s_dev.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bdev.c           | 16 ----------------
>  block/ioctl.c          |  9 ++++++++-
>  fs/super.c             | 13 +++++++++++++
>  include/linux/blkdev.h |  7 +++++--
>  4 files changed, 26 insertions(+), 19 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 658d5dd62cac0a..2a035be7f3ee90 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -206,22 +206,6 @@ int sync_blockdev_range(struct block_device *bdev, loff_t lstart, loff_t lend)
>  }
>  EXPORT_SYMBOL(sync_blockdev_range);
>  
> -/*
> - * Write out and wait upon all dirty data associated with this
> - * device.   Filesystem data as well as the underlying block
> - * device.  Takes the superblock lock.
> - */
> -int fsync_bdev(struct block_device *bdev)
> -{
> -	struct super_block *sb = get_super(bdev);
> -	if (sb) {
> -		int res = sync_filesystem(sb);
> -		drop_super(sb);
> -		return res;
> -	}
> -	return sync_blockdev(bdev);
> -}
> -
>  /**
>   * freeze_bdev - lock a filesystem and force it into a consistent state
>   * @bdev:	blockdevice to lock
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 3be11941fb2ddc..648670ddb164a0 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -364,7 +364,14 @@ static int blkdev_flushbuf(struct block_device *bdev, unsigned cmd,
>  {
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EACCES;
> -	fsync_bdev(bdev);
> +
> +	mutex_lock(&bdev->bd_holder_lock);
> +	if (bdev->bd_holder_ops && bdev->bd_holder_ops->sync)
> +		bdev->bd_holder_ops->sync(bdev);
> +	else
> +		sync_blockdev(bdev);
> +	mutex_unlock(&bdev->bd_holder_lock);
> +
>  	invalidate_bdev(bdev);
>  	return 0;
>  }
> diff --git a/fs/super.c b/fs/super.c
> index 94d41040584f7b..714dbae58b5e8e 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1248,8 +1248,21 @@ static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
>  	up_read(&sb->s_umount);
>  }
>  
> +static void fs_bdev_sync(struct block_device *bdev)
> +{
> +	struct super_block *sb = bdev->bd_holder;
> +
> +	lockdep_assert_held(&bdev->bd_holder_lock);
> +
> +	if (!lock_active_super(sb))
> +		return;
> +	sync_filesystem(sb);
> +	up_read(&sb->s_umount);
> +}
> + 

Whitespace error.  Thanks,

Josef
