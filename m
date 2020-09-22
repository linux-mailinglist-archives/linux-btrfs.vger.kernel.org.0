Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61D927440F
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 16:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgIVOUP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 10:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgIVOUO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 10:20:14 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F6EC0613CF
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Sep 2020 07:20:14 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id d1so3155250qtr.6
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Sep 2020 07:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uC6IysBO6eYkTM0Edb76q612kH6aCJXdfPK18r8nFlw=;
        b=KRxt/7xJBgfsNAM7oM3hJOTq2jFfZrAylzIaDXiC/5dsHQiWFwE+Gj5DpGuhnWsjEQ
         i7ia24PqUH1LaP+z8xjuq29vAf1BG9qFB+NBJ7zeuqf+1OnAzhEXMZnbZCbiGmRmZmuv
         MEkl02gsXRFzG4Ij498q+PP+W0t4QGsDHm1XCMthYWUlQuYnOQgFWshPaM9O0Pk4eqoY
         l4akyXhI5ZihQPkbVWu2favUPguU4mAm9icpLiIi5w1RrRJMArfCcnhRYkR+rqdzIato
         7iwQABaoY2Re9gJT0Fp0rYSEu5KUxbFDC9j36VkPPSfSwDCKxIQDWjHDvdOHI9xbbAYZ
         9nyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uC6IysBO6eYkTM0Edb76q612kH6aCJXdfPK18r8nFlw=;
        b=Poy8imOWBweqYa1vp8HxjX8pBpPe/1Gcyq5BHanqcdb440TM3MUwcYxC5R+dn/NxI/
         yq7P6DdlNMenqV3er+MdbUIz7qNkpWpi3ktIeRiwfW/jsuh+a26dn9VAaS1Z0mgBX1n5
         uCJnl4hgH0OmG2Thfgdoy9qv6vsG/CygIS9EHyrBKAp8pV3MT6czqpqC3ok8bNgIkaWr
         wPIlAfBPYfSptkv9rJZM4XXdtPGcvTTLWh06aZKKhtercaMZL/Zb3asyXlsdZGn8LaUY
         Ev88PXTiRH6u71hxrmoaMSN1fwKUksJ7DWgpdCtI1u3Lxip8N+PtFWUJRsjb5/H5e0Kb
         w2Qg==
X-Gm-Message-State: AOAM530HByI8keCpFeiCAMudfKVzEW6KmiSFPbOZUArzeuddZpVZNKQX
        lV0WbHqrAGZPnsun18qXrrJeiA==
X-Google-Smtp-Source: ABdhPJx65By5VzFaEda5soVTLuEK7K4FZR95u1wFXB3eP8bTSddXWMB3fXBVXtUEucVCWhP2UFtZUQ==
X-Received: by 2002:ac8:3848:: with SMTP id r8mr4808638qtb.205.1600784413447;
        Tue, 22 Sep 2020 07:20:13 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b34sm12983022qtc.73.2020.09.22.07.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 07:20:12 -0700 (PDT)
Subject: Re: [PATCH 04/15] iomap: Call inode_dio_end() before
 generic_write_sync()
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        johannes.thumshirn@wdc.com, dsterba@suse.com,
        darrick.wong@oracle.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20200921144353.31319-1-rgoldwyn@suse.de>
 <20200921144353.31319-5-rgoldwyn@suse.de>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <20bf949a-7237-8409-4230-cddb430026a9@toxicpanda.com>
Date:   Tue, 22 Sep 2020 10:20:11 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200921144353.31319-5-rgoldwyn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/21/20 10:43 AM, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> iomap complete routine can deadlock with btrfs_fallocate because of the
> call to generic_write_sync().
> 
> P0                      P1
> inode_lock()            fallocate(FALLOC_FL_ZERO_RANGE)
> __iomap_dio_rw()        inode_lock()
>                          <block>
> <submits IO>
> <completes IO>
> inode_unlock()
>                          <gets inode_lock()>
>                          inode_dio_wait()
> iomap_dio_complete()
>    generic_write_sync()
>      btrfs_file_fsync()
>        inode_lock()
>        <deadlock>
> 
> inode_dio_end() is used to notify the end of DIO data in order
> to synchronize with truncate. Call inode_dio_end() before calling
> generic_write_sync(), so filesystems can lock i_rwsem during a sync.
> 
> ---
>   fs/iomap/direct-io.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index d970c6bbbe11..e01f81e7b76f 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -118,6 +118,7 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
>   			dio_warn_stale_pagecache(iocb->ki_filp);
>   	}
>   
> +	inode_dio_end(file_inode(iocb->ki_filp));
>   	/*
>   	 * If this is a DSYNC write, make sure we push it to stable storage now
>   	 * that we've written data.
> @@ -125,7 +126,6 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
>   	if (ret > 0 && (dio->flags & IOMAP_DIO_NEED_SYNC))
>   		ret = generic_write_sync(iocb, ret);
>   
> -	inode_dio_end(file_inode(iocb->ki_filp));
>   	kfree(dio);
>   
>   	return ret;
> 

Did you verify that xfs or ext4 don't rely on the inode_dio_end() happening 
before the generic_write_sync()?  I wouldn't expect that they would, but we've 
already run into problems making those kind of assumptions.  If it's fine you 
can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
