Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB0B21BC97
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jul 2020 19:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgGJRvw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jul 2020 13:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgGJRvv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jul 2020 13:51:51 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF33C08C5DC
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jul 2020 10:51:51 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id j80so6124968qke.0
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jul 2020 10:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PLeSLC5lF48ou/SHzymPiDHug7S8wFv0/C/FOo/KCjU=;
        b=SfU8iUlWXM6P+1F55HmutdEgPRmk2ZXZcMQqQPqB/joI0jgdxRKmGWLDC83LCHDa17
         ClYSmj2LRKq8qqp9Q7ajS+wiYg/LCHDNjUpKjf9IyykW46lidhIdJ3tJEH6E5OkcyUvA
         23985wn0PhlP+tLXDlS6gM4Hu8OxDn/uYb7GTQGTq2wnjLwONvhBsZ05RLAbPegDN2QB
         asAKRhXefE0MgDqy2GIVCu/CTip0LjupWBIFSYJTQhgo3QTyWaDHTUc55Vu4X6//X255
         AbTzW6RT5H0klLa0kZslxKDIEECczFR2JqqNXvrZFv/5LZFpDlz7Q3i9J0yVDLHlBpMW
         diDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PLeSLC5lF48ou/SHzymPiDHug7S8wFv0/C/FOo/KCjU=;
        b=k66POyd7Ky65MV/SZS8qrQ1Tu0yPWBzW4d22TEk/+bON3wczpxRVDeLrwaP1k/s05Z
         SsBH8lh6Tbm1ht6COxsmcwaRKlX5acgTpXp5fokDc+T+2zLFY/mdPpPCN4zhivqTg2b2
         aUZ4IFdjbcILS7v6ITbaqAuSTBxuqcjZMJ32myjvhx0dOcbcw99bjptM19/gNGDwZCZx
         znXV45njLHzVAO/bcnWvNImfqxrIjk+jxCXD127vIRXJm6V2qnEnn0kQdLNYboNnwy7N
         2JpcjUbcNCrFMudz4F139h9/R6lPYBy6RzdbgmWg54fnBAKNXxz1N3THq2PuxfWHIITK
         mzjQ==
X-Gm-Message-State: AOAM530HZF+RDX+HRZHurkLIuuyfa/8LF+0/drxbeQ+K05+BTzB5rKNg
        5YA8Anv1AN5UGsnFL2lTBJGU+g==
X-Google-Smtp-Source: ABdhPJwbP9ICaqvfJzzrUSNJ47aH8yFkf1QUs4XTfN5nSutTm2hVsWy3hjkGLUz2X2kBBGaXe3JwBg==
X-Received: by 2002:a05:620a:1519:: with SMTP id i25mr61700767qkk.91.1594403510890;
        Fri, 10 Jul 2020 10:51:50 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m7sm8544941qti.6.2020.07.10.10.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 10:51:49 -0700 (PDT)
Subject: Re: [PATCH v2] btrfs: fix mount failure caused by race with umount
To:     Boris Burkov <boris@bur.io>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
References: <e2857658-230e-48e6-d6cf-587be4a8a0bc@toxicpanda.com>
 <20200710172304.139763-1-boris@bur.io>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <39efafd7-3acf-1ffb-8421-438a95de2a41@toxicpanda.com>
Date:   Fri, 10 Jul 2020 13:51:48 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710172304.139763-1-boris@bur.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/10/20 1:23 PM, Boris Burkov wrote:
> It is possible to cause a btrfs mount to fail by racing it with a slow
> umount. The crux of the sequence is generic_shutdown_super not yet
> calling sop->put_super before btrfs_mount_root calls btrfs_open_devices.
> If that occurs, btrfs_open_devices will decide the opened counter is
> non-zero, increment it, and skip resetting fs_devices->total_rw_bytes to
> 0. From here, mount will call sget which will result in grab_super
> trying to take the super block umount semaphore. That semaphore will be
> held by the slow umount, so mount will block. Before up-ing the
> semaphore, umount will delete the super block, resulting in mount's sget
> reliably allocating a new one, which causes the mount path to dutifully
> fill it out, and increment total_rw_bytes a second time, which causes
> the mount to fail, as we see double the expected bytes.
> 
> Here is the sequence laid out in greater detail:
> 
> CPU0                                                    CPU1
> down_write sb->s_umount
> btrfs_kill_super
>    kill_anon_super(sb)
>      generic_shutdown_super(sb);
>        shrink_dcache_for_umount(sb);
>        sync_filesystem(sb);
>        evict_inodes(sb); // SLOW
> 
>                                                btrfs_mount_root
>                                                  btrfs_scan_one_device
>                                                  fs_devices = device->fs_devices
>                                                  fs_info->fs_devices = fs_devices
>                                                  // fs_devices-opened makes this a no-op
>                                                  btrfs_open_devices(fs_devices, mode, fs_type)
>                                                  s = sget(fs_type, test, set, flags, fs_info);
>                                                    find sb in s_instances
>                                                    grab_super(sb);
>                                                      down_write(&s->s_umount); // blocks
> 
>        sop->put_super(sb)
>          // sb->fs_devices->opened == 2; no-op
>        spin_lock(&sb_lock);
>        hlist_del_init(&sb->s_instances);
>        spin_unlock(&sb_lock);
>        up_write(&sb->s_umount);
>                                                      return 0;
>                                                    retry lookup
>                                                    don't find sb in s_instances (deleted by CPU0)
>                                                    s = alloc_super
>                                                    return s;
>                                                  btrfs_fill_super(s, fs_devices, data)
>                                                    open_ctree // fs_devices total_rw_bytes improperly set!
>                                                      btrfs_read_chunk_tree
>                                                        read_one_dev // increment total_rw_bytes again!!
>                                                        super_total_bytes < fs_devices->total_rw_bytes // ERROR!!!
> 
> To fix this, we observe that if we have already filled the device, the
> state bit BTRFS_DEV_STATE_IN_FS_METADATA will be set on it, and we can
> use that to avoid filling it a second time for no reason and,
> critically, avoid double counting in total_rw_bytes. One gotcha is that
> read_one_chunk also sets this bit, which happens before read_one_dev (in
> read_sys_array), so we must remove that setting of the bit as well, for
> the state bit to truly correspond to the device struct being filled from
> disk.
> 
> To reproduce, it is sufficient to dirty a decent number of inodes, then
> quickly umount and mount.
> 
> for i in $(seq 0 500)
> do
>    dd if=/dev/zero of="/mnt/foo/$i" bs=1M count=1
> done
> umount /mnt/foo&
> mount /mnt/foo
> 
> does the trick for me.
> 
> A final note is that this fix actually breaks the fstest btrfs/163, but
> having investigated it, I believe that is due to a subtle flaw in how
> btrfs replace works when used on a seed device. The replace target device
> never gets a correct dev_item with the sprout fsid written out. This
> causes several problems, but for the sake of btrfs/163, read_one_chunk
> marking the device with IN_FS_METADATA was wallpapering over it, which
> this patch breaks. I will be sending a subsequent fix for the seed replace
> issue which will also fix btrfs/163.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
