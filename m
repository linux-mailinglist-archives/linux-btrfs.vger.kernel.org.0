Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678DC6318A1
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Nov 2022 03:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiKUCbN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Nov 2022 21:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiKUCbL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Nov 2022 21:31:11 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620542A961
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Nov 2022 18:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668997870; x=1700533870;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9mICDhxohfYlqyMgrUVmOxR3SsfBS1sVB4XAKhvrQbo=;
  b=Nxksbuq9+7pcZfdXmYhdfeiLewZp4n2feXhQ5WkBEGDZoQqwFRZz3Cdk
   M9MllXGclNs815U4MCjqztuavTf/e6FxRYPMdjKc+ptWP6sX8tjwiWRZT
   VsMG4ofeMS+gT0JFeh/Mitn4D2VkFBcVj58tGrfhm2etiiSTAaPtpNgas
   BOk2v8cz25a262kXI7igdRgQs8OK6jbqukYMs/vcAxUjpqHMB0PWPenkY
   PTWkkgbd8DJi8oRn9yin8z0lfNVVC09xzxjc0fMF7aBGeHbiI0xb3Vm6T
   MhlKXM4r60Tm3TbmJcsHYpBhvuAIcN/NrpouKl44S9yeHSsAGdguF5El5
   g==;
X-IronPort-AV: E=Sophos;i="5.96,180,1665417600"; 
   d="scan'208";a="217058923"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Nov 2022 10:31:09 +0800
IronPort-SDR: X4/wW1tdVbzKekGTEr6+56wDYhf7M4RD+tVNwE5fjXc8709N8YSYPDz3R0kZQI4ti9fCe0cBNL
 MiusS5ITKEMZj6H39ONkC4hggyHGNcSzd0YA89Ob1peFDSIRpiMtOGlwGzc0E3BCo/ZusTwaMh
 n0PRCA6LL4xTOQupTRiKCF9Z7O8vKiYOzHP80ZG7BpvuTCfqKjT1bX4uyZsqAACy6LlJpnlhVD
 3yUFi6b3xfSCzZUNoKyKTWMaafCfuIjCGQ99ydLy9CSV166l0lqe2BsYDuenfNR9lnT4yEedVX
 N0g=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2022 17:44:15 -0800
IronPort-SDR: coFdlO7/JlYlHhSE6Q8qzxtJ7I26ptvrTeY2OaxhiLWPOZkGLRmtT1YZYBDifb8aW1/ieiBxYX
 gAMsR4K7J+X1l2ascik0OkjaJhRFgvgIA17X3B6nzd99DeLi/xVmNujJ55HdKWR9k2EYWpmWg4
 fwSqCvUbwC8KxE0CFtSjueqZcjER4bnMEwzzPqkx6EhPEWEgq5BL1bjakfUhOUXSvafE03ADtO
 w7DW77jEzKf0I5gFdS3XLt3/QQNzHTvHcGOxivgjFp1T/HFdrBr/qvBu0/jJ00F58619gVRwaK
 /9w=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2022 18:31:09 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NFrwr6RRBz1Rwt8
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Nov 2022 18:31:08 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668997864; x=1671589865; bh=9mICDhxohfYlqyMgrUVmOxR3SsfBS1sVB4X
        AKhvrQbo=; b=ZhRepVfUpeUJh58aBkKOLarvKSx4HqFyz+/wF/amE1kgRP+v0r1
        aT7B394psu7qDm7Kysv9Kw5HMzmUFFXdCUA1LXNBIEOW79VkJYaU2xl83OEvINGS
        51eC2WxQ7c5iyQgZteB1KdO/BZvfLhIapmbkuPdqZKJMC5mkADtk9J5KjTpaK3rA
        3vxb7jooajiv1NtmkLlOaTSY9Vhd3f6t5VqOxunwDggln3APZt7mDiwQHMdv+Lsa
        XckxNh0yG0jmxE8QJm2EiGU3k/VHV1TvUs9Msfg+G9faGw5qJWSsS7qCZ0G9Eono
        InyZlK2LQaOixh2um0I9GLc1eANQUz72qUw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Uhc2eMB1hoap for <linux-btrfs@vger.kernel.org>;
        Sun, 20 Nov 2022 18:31:04 -0800 (PST)
Received: from [10.225.163.53] (unknown [10.225.163.53])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NFrwl1Ys9z1RvLy;
        Sun, 20 Nov 2022 18:31:02 -0800 (PST)
Message-ID: <22167fd3-6a97-8cab-c6b8-a3415da89b3f@opensource.wdc.com>
Date:   Mon, 21 Nov 2022 11:31:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] btrfs: use kvcalloc in btrfs_get_dev_zone_info
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
References: <20221120124303.17918-1-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221120124303.17918-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/20/22 21:43, Christoph Hellwig wrote:
> Otherwise the kernel memory allocator seems to be unhappy about failing
> order 6 allocations for the zones array, that cause 100% reproducible
> mount failures in my qemu setup:
> 
> [   26.078981] mount: page allocation failure: order:6, mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), nodemask=(null)
> [   26.079741] CPU: 0 PID: 2965 Comm: mount Not tainted 6.1.0-rc5+ #185
> [   26.080181] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [   26.080950] Call Trace:
> [   26.081132]  <TASK>
> [   26.081291]  dump_stack_lvl+0x56/0x6f
> [   26.081554]  warn_alloc+0x117/0x140
> [   26.081808]  ? __alloc_pages_direct_compact+0x1b5/0x300
> [   26.082174]  __alloc_pages_slowpath.constprop.0+0xd0e/0xde0
> [   26.082569]  __alloc_pages+0x32a/0x340
> [   26.082836]  __kmalloc_large_node+0x4d/0xa0
> [   26.083133]  ? trace_kmalloc+0x29/0xd0
> [   26.083399]  kmalloc_large+0x14/0x60
> [   26.083654]  btrfs_get_dev_zone_info+0x1b9/0xc00
> [   26.083980]  ? _raw_spin_unlock_irqrestore+0x28/0x50
> [   26.084328]  btrfs_get_dev_zone_info_all_devices+0x54/0x80
> [   26.084708]  open_ctree+0xed4/0x1654
> [   26.084974]  btrfs_mount_root.cold+0x12/0xde
> [   26.085288]  ? lock_is_held_type+0xe2/0x140
> [   26.085603]  legacy_get_tree+0x28/0x50
> [   26.085876]  vfs_get_tree+0x1d/0xb0
> [   26.086139]  vfs_kern_mount.part.0+0x6c/0xb0
> [   26.086456]  btrfs_mount+0x118/0x3a0
> [   26.086728]  ? lock_is_held_type+0xe2/0x140
> [   26.087043]  legacy_get_tree+0x28/0x50
> [   26.087323]  vfs_get_tree+0x1d/0xb0
> [   26.087587]  path_mount+0x2ba/0xbe0
> [   26.087850]  ? _raw_spin_unlock_irqrestore+0x38/0x50
> [   26.088217]  __x64_sys_mount+0xfe/0x140
> [   26.088506]  do_syscall_64+0x35/0x80
> [   26.088776]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.
This likely needs a fixes tag though.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  fs/btrfs/zoned.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 2218b33dac568..a759668477bb2 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -468,7 +468,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
>  		goto out;
>  	}
>  
> -	zones = kcalloc(BTRFS_REPORT_NR_ZONES, sizeof(struct blk_zone), GFP_KERNEL);
> +	zones = kvcalloc(BTRFS_REPORT_NR_ZONES, sizeof(struct blk_zone), GFP_KERNEL);
>  	if (!zones) {
>  		ret = -ENOMEM;
>  		goto out;
> @@ -587,7 +587,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
>  	}
>  
>  
> -	kfree(zones);
> +	kvfree(zones);
>  
>  	switch (bdev_zoned_model(bdev)) {
>  	case BLK_ZONED_HM:
> @@ -619,7 +619,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
>  	return 0;
>  
>  out:
> -	kfree(zones);
> +	kvfree(zones);
>  out_free_zone_info:
>  	btrfs_destroy_dev_zone_info(device);
>  

-- 
Damien Le Moal
Western Digital Research

