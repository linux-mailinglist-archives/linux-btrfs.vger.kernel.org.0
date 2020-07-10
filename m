Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27EEA21AC79
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jul 2020 03:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgGJBXV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jul 2020 21:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbgGJBXU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jul 2020 21:23:20 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65F8C08C5DC
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Jul 2020 18:23:20 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id x62so3269705qtd.3
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Jul 2020 18:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=acA/igAo30a/uCl3cBz3U/y5y8AevyEKVy7UxGUUYxc=;
        b=dsH+4T8BdhSWefYHYWFQ/u1HiVUNOYQ+O//Un1N+lVHzfeFNnFH767VXY0rcfFs/Y5
         xVbfaksx9r/gHe9XO0ZRNkwjH2D1yjQVguFR15valzovyT2ZcH5THOE9pw+DKW1+Uk+/
         dCUJQ6+DkeSEKNdjpRnitubWIfLqPTfeSXUYQczqYgxmkmXaz8apdKEh/pOqdsubJoun
         VN6AaVX9OVVz7a7it4/WpPR/SpkarCbW6Q0skMZQAxf/iYzgwKx1kFdxc6qSOmX0QauV
         yDN91ApmSSvug9uGn/w2xX9fSpSzxBksAkH8Lmlqr8k4YkyD8YfRCACjEe5bPKZjN5zx
         /IZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=acA/igAo30a/uCl3cBz3U/y5y8AevyEKVy7UxGUUYxc=;
        b=GR9ga2i+oYVORRPujU2/yhC+EzuFDQtbsOlrwGro9D4i2Sl4P/H1CvO/VJqXNmsZlb
         bQwkHX+IqwfQgPfQl37uA8OwYvga2ZVWfNPxoOB90Zpjtf6ql6sGLnkUTHtSmqL5tKP6
         vkm/pp6IKun27/R57mvBmKkw65NFObZds7zUC3V2FYaJdoaa54CwPY2EHRHV9yOH6TNF
         fcJz9vRcRrV7ewFPh79TW2DhbyrAmxxISn4cYpLrO00DuJAWBJzM0d/sfnOowlmGXIuP
         hm9D6AzSQO2+/li9DK5P5KNI6aOqY0R1aBh+VPhX3eOOn8eM5oraj30oUVkmaHIMEg2p
         4lJg==
X-Gm-Message-State: AOAM533kwnUQ2XAqtqvKSGlj6oFAWs7LPzBypq+U/jefoXNwGZhUh2Ea
        PKhpQg5GTPYXLA/A3hAusx2KlA==
X-Google-Smtp-Source: ABdhPJzyBx+Q8CjazSRtYPQ6mgsBu8OB3HQQqNudAi5K/TmkVJJblFNOnB941nSlHFDCnPP68N7ojg==
X-Received: by 2002:ac8:178b:: with SMTP id o11mr33358453qtj.320.1594344199613;
        Thu, 09 Jul 2020 18:23:19 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j24sm5379680qkl.79.2020.07.09.18.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 18:23:18 -0700 (PDT)
Subject: Re: [PATCH] btrfs: fix mount failure caused by race with umount
To:     Boris Burkov <boris@bur.io>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
References: <20200710004408.1246282-1-boris@bur.io>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e2857658-230e-48e6-d6cf-587be4a8a0bc@toxicpanda.com>
Date:   Thu, 9 Jul 2020 21:23:17 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710004408.1246282-1-boris@bur.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/9/20 8:44 PM, Boris Burkov wrote:
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
> ---
>   fs/btrfs/volumes.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index c7a3d4d730a3..1d9bd1bbf893 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6633,9 +6633,6 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
>   			}
>   			btrfs_report_missing_device(fs_info, devid, uuid, false);
>   		}
> -		set_bit(BTRFS_DEV_STATE_IN_FS_METADATA,
> -				&(map->stripes[i].dev->dev_state));
> -
>   	}
>   
>   	write_lock(&map_tree->lock);
> @@ -6815,6 +6812,15 @@ static int read_one_dev(struct extent_buffer *leaf,
>   			return -EINVAL;
>   	}
>   
> +	/*
> +	 * It is possible for mount and umount to race in such a way that
> +	 * we execute this code path, but the device is still in metadata.
> +	 * If so, we don't need to call fill_device_from_item again and we
> +	 * especially don't want to spuriously increment total_rw_bytes.
> +	 */
> +	if (test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state)) {
> +		return 0;
> +	}

Lets kill the set_bit below, and changes this to

if (test_and_set_bit())

also you don't need {} for single line if statements.  Thanks,

Josef
