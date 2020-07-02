Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C14212407
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgGBNBm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728697AbgGBNBl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 09:01:41 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0563C08C5C1
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jul 2020 06:01:41 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id a14so12585707qvq.6
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jul 2020 06:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=RpAPBBuP2S33yMGEA6woHRAlJlVTRbTNV2jocETBp/M=;
        b=QdgaU5q4L27QrELwMf1JfdmamS7sqWBahtCLisDOi1vfDNPA9Tn9JZeoiViTu4+YTA
         0G1UtcC5Fwr6gtGPDsnctAjHNHO8dki7Mlkm/Fo7c2lsbHGUUAlRGAJYULvrWrdbeADN
         VuxBp4XorhTbOapnWwablU60WN7l0hFgZsoSdQ423rrULVeZTB7/8wNn7miVIdyOFMSm
         Wwt2WqTpstOkR3WbhD0JCFEDSZ1a+JBE2pKb9EYXFCJqrFNWPxVUnFaZIBeFWe2w4teQ
         n/WsTltf8FCM7tiMKQaDIJEA1koVheT0r6aPEKOHsPPpyw4qSZ7X1FZ/ll4aAz+Q9d/1
         6jJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RpAPBBuP2S33yMGEA6woHRAlJlVTRbTNV2jocETBp/M=;
        b=r8sJ4nARBGyxocAQdNXnvJptIlfHXCrhn4LD6TqpaBq9jY87tkQtRVYLGAaELGk2Kn
         idvjY/HRaHHAS/HEzJ3CVl51WGXgdpyOhYNQEDwUexIeQodHmzMVIzRQkAS9WOo1khhp
         OlXOuk2d85BJIeMtGeMx/5KwTHHOayGug3/T+ZTi7C1wh4CDs5yc7GMkjEaVhkhwnEaw
         j2Us/oskflwmQdEDZ1GK33I754atEqtATUgt5bmhOo1cm/Rqr3Tx40FDQ3vIf/t38qyo
         8Y4GvbNEikt0OxmW9f206GEtSzFO/INTQNn8gHgMTdcOYGEkTMIufGMdHGrlBQ/3w6tP
         nrpA==
X-Gm-Message-State: AOAM530GIgJkvHofBznhMgEHkEYwN5qrktmFu5eU+QL0zazBiOGPEf2d
        6YSgXsAwEKbymoOFmbN+584x8Z2fED0VSQ==
X-Google-Smtp-Source: ABdhPJyIfpgrhGWl2hm2EiNK3AZ1XUxs1P4LG4kftPENE9xpZfZs77/3OceEYKHDlMpvdNkcpENZMw==
X-Received: by 2002:a0c:f486:: with SMTP id i6mr29210499qvm.229.1593694900165;
        Thu, 02 Jul 2020 06:01:40 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c27sm7473790qkl.125.2020.07.02.06.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 06:01:39 -0700 (PDT)
Subject: Re: [PATCH 2/4] btrfs: only commit delayed items at fsync if we are
 logging a directory
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200702113220.163855-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <9fec8d31-b0b3-7f89-e9af-09f86a31bb56@toxicpanda.com>
Date:   Thu, 2 Jul 2020 09:01:38 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702113220.163855-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/2/20 7:32 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When logging an inode we are committing its delayed items if either the
> inode is a directory or if it is a new inode, created in the current
> transaction.
> 
> We need to do it for directories, since new directory indexes are stored
> as delayed items of the inode and when logging a directory we need to be
> able to access all indexes from the fs/subvolume tree in order to figure
> out which index ranges need to be logged.
> 
> However for new inodes that are not directories, we do not need to do it
> because the only type of delayed item they can have is the inode item, and
> we are guaranteed to always log an up to date version of the inode item:
> 
> *) for a full fsync we do it by committing the delayed inode and then
>     copying the item from the fs/subvolume tree with
>     copy_inode_items_to_log();
> 
> *) for a fast fsync we always log the inode item based on the contents of
>     the in-memory struct btrfs_inode. We guarantee this is always done since
>     commit e4545de5b035c7 ("Btrfs: fix fsync data loss after append write").
> 
> So stop running delayed items for a new inodes that are not directories,
> since that forces committing the delayed inode into the fs/subvolume tree,
> wasting time and adding contention to the tree when a full fsync is not
> required. We will only do it in case a fast fsync is needed.
> 
> This patch is part of a series that has the following patches:
> 
> 1/4 btrfs: only commit the delayed inode when doing a full fsync
> 2/4 btrfs: only commit delayed items at fsync if we are logging a directory
> 3/4 btrfs: stop incremening log_batch for the log root tree when syncing log
> 4/4 btrfs: remove no longer needed use of log_writers for the log root tree
> 
> After the entire patchset applied I saw about 12% decrease on max latency
> reported by dbench. The test was done on a qemu vm, with 8 cores, 16Gb of
> ram, using kvm and using a raw NVMe device directly (no intermediary fs on
> the host). The test was invoked like the following:
> 
>    mkfs.btrfs -f /dev/sdk
>    mount -o ssd -o nospace_cache /dev/sdk /mnt/sdk
>    dbench -D /mnt/sdk -t 300 8
>    umount /mnt/dsk
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
