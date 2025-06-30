Return-Path: <linux-btrfs+bounces-15073-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C09AED26E
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 04:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 956E11895079
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 02:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCAC155CB3;
	Mon, 30 Jun 2025 02:30:30 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out28-78.mail.aliyun.com (out28-78.mail.aliyun.com [115.124.28.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBCD2905
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 02:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751250630; cv=none; b=usJDDorbDjRHvUmYqqNyPkwVA6X+WLj68as0Uzr6/7C8dMLRJ/EbX/TAMYN1YqylFeoSBvBDEA6IR5ekiZcSwVRzXVIOA98ceWUQgvjt3YrWlWCzJ+O04xzjMUH3tijfqCML0LZpVqM9dB0N+ftRPWxwaxn2Z+sfzR12lyVcIPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751250630; c=relaxed/simple;
	bh=gpZMtx5WzTfULyPwLxFdfKssz13hiJty7b6LygVThe8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=gUdKpeKaPaWyoG9EkD3I4FDwLwI+vk3csGIYWts0NpyMLyRlPWDt3VkPOJhaAe0vR0VJkQF9owWHaNprDL512nEhG3qToppGwCIJ4VRczGINJ6R87N7BhcEV+GmpOaljaKLMC/d+nDh27BUvY4MtgoiiMx41VvCekjh9ssYgyWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=115.124.28.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.dZj0.-0_1751250296 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 30 Jun 2025 10:24:57 +0800
Date: Mon, 30 Jun 2025 10:24:57 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v2 1/2] btrfs: open code RCU for device name
Cc: linux-btrfs@vger.kernel.org
In-Reply-To: <1e539dfd73debc86ddc7c1b1716f86ace14d51aa.1750858539.git.dsterba@suse.com>
References: <cover.1750858539.git.dsterba@suse.com> <1e539dfd73debc86ddc7c1b1716f86ace14d51aa.1750858539.git.dsterba@suse.com>
Message-Id: <20250630102457.BFB9.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.08 [en]

Hi,

> The RCU protected string is only used for a device name, and RCU is used
> so we can print the name and eventually synchronize against the rare
> device rename in device_list_add().
> 
> We don't need the whole API just for that. Open code all the helpers and
> access to the string itself.
> 
> Notable change is in device_list_add() when the device name is changed,
> which is the only place that can actually happen at the same time as
> message prints using the device name under RCU read lock.
> 
> Previously there was kfree_rcu() which used the embedded rcu_head to
> delay freeing the object depending on the RCU mechanism. Now there's
> kfree_rcu_mightsleep() which does not need the rcu_head and waits for
> the grace period.
> 
> Sleeping is safe in this context and as this is a rare event it won't
> interfere with the rest as it's holding the device_list_mutex.
> 
> Straightforward changes:
> 
> - rcu_string_strdup -> kstrdup
> - rcu_str_deref -> rcu_dereference
> - drop ->str from safe contexts
> 
> Historical notes:
> 
> Introduced in 606686eeac45 ("Btrfs: use rcu to protect device->name")
> with a vague reference of the potential problem described in
> https://lore.kernel.org/all/20120531155304.GF11775@ZenIV.linux.org.uk/ .
> 
> The RCU protection looks like the easiest and most lightweight way of
> protecting the rare event of device rename racing device_list_add()
> with a random printk() that uses the device name.
> 
> Alternatives: a spin lock would require to protect the printk
> anyway, a fixed buffer for the name would be eventually wrong in case
> the new name is overwritten when being printed, an array switching
> pointers and cleaning them up eventually resembles RCU too much.
> 
> The cleanups up to this patch should hide special case of RCU to the
> minimum that only the name needs rcu_dereference(), which can be further
> cleaned up to use btrfs_dev_name().
> 

There is still rcu warning when 'make  W=1 C=1'

/usr/hpc-bio/linux-6.12.35/fs/btrfs/volumes.c:405:21: warning: incorrect type in argument 1 (different address spaces)
/usr/hpc-bio/linux-6.12.35/fs/btrfs/volumes.c:405:21:    expected void const *objp
/usr/hpc-bio/linux-6.12.35/fs/btrfs/volumes.c:405:21:    got char const [noderef] __rcu *name

static void btrfs_free_device(struct btrfs_device *device)
{
    WARN_ON(!list_empty(&device->post_commit_list));
    /* No need to call kfree_rcu(), nothing is reading the device name. */
L405:    kfree(device->name);

do we need rcu_dereference here?
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -402,7 +402,7 @@ static void btrfs_free_device(struct btrfs_device *device)
 {
        WARN_ON(!list_empty(&device->post_commit_list));
        /* No need to call kfree_rcu(), nothing is reading the device name. */
-       kfree(device->name);
+       kfree(rcu_dereference(device->name));

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2025/06/30


