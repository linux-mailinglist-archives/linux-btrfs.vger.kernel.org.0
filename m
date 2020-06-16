Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62AA41FBEE2
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jun 2020 21:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbgFPTXH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 15:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbgFPTXG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 15:23:06 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E485C061573
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jun 2020 12:23:06 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id y9so10067086qvs.4
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jun 2020 12:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GloZIzdRwMOk/waJkh0ke5BHZ4BwRtOlhVBY9tLGFgE=;
        b=u64xdh4WqsqPSB6V1tCAwPZydxwdje/40qQURbK/3/bLhQ9Vo5305qhhZS7xRFUeRg
         tbsFsVTOyT0pDcl1/fNAUaIlaF+tHYuq5HM1GL8XKm66PKOpTo1fhlaZz6HR4gDUSPwK
         SwlnEBJxyDE2JKn/vr8qtJwlQLCmapxNlamkxcc2vzbtjdAjUqhTMRfc4Zr0UvL9aEZ5
         9ohzJqtxvrKjWm26smMHrLq/DY1ThNFoREJS0es0itN+R5M5pRkbOCydWvTvYmtu8nSA
         CU0JsEPoxQC4LFK/xs7t6Xq47PzuUuMIFjb+aMmoNEQ06KNdZZIpekEizSBcGJDOhtLR
         Pqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GloZIzdRwMOk/waJkh0ke5BHZ4BwRtOlhVBY9tLGFgE=;
        b=qI1Cuh0HzzDRR6AGYeLfwUEQMTtZ9lX1A+U8DRMCK8gkokvPdt1escweG82i+KZsAU
         0K6UyeMaprltDEK9ZscloR6rgbe+uny212Un6bjgjhTz+yqABLp0ITyo2Npzuo+t7vSq
         7mNSDZbTWICM3UJU5Ncb7vgPdficwUrpAESqtfxvVhIubWyH9PwODNpyaWNmTtiEY2p2
         6Dzq60gTntBhedPNFtTfbgawfKQcrUB8H+34Knna1YhSTEgZAp3N9IlzSFcc9HKLqm5Z
         qc0E1j/ACu9H56y05EdM5Uig7GqWtJzOY1eH/kn8nZU7FBC9XejdEm7SHnUrPDfTjjRA
         Ov6A==
X-Gm-Message-State: AOAM531MT2Me/L7YjbeE598ow68SxzPGdfWqtqeoJPv3N4q1NKX+EPUP
        K687b+uhm6IQGCGPiTcJqG6C2g==
X-Google-Smtp-Source: ABdhPJz0+8eEAnlirDSePn+CctEFFSRnXqI8l5IeJc25qgW6pVook80rHNLVncmzvJpiDN4JU5vABw==
X-Received: by 2002:a0c:ecc6:: with SMTP id o6mr3895653qvq.243.1592335385712;
        Tue, 16 Jun 2020 12:23:05 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d193sm15074564qke.124.2020.06.16.12.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 12:23:04 -0700 (PDT)
Subject: Re: [PATCH 4/4] btrfs: free anon_dev earlier to prevent exhausting
 anonymous block device pool
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Greed Rong <greedrong@gmail.com>
References: <20200616021737.44617-1-wqu@suse.com>
 <20200616021737.44617-5-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <605ee3c8-0afa-5c00-9c66-fa385c20ce99@toxicpanda.com>
Date:   Tue, 16 Jun 2020 15:23:03 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200616021737.44617-5-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/15/20 10:17 PM, Qu Wenruo wrote:
> [BUG]
> When a lot of subvolumes are created, there is a user report about
> transaction aborted:
> 
>    ------------[ cut here ]------------
>    BTRFS: Transaction aborted (error -24)
>    WARNING: CPU: 17 PID: 17041 at fs/btrfs/transaction.c:1576 create_pending_snapshot+0xbc4/0xd10 [btrfs]
>    RIP: 0010:create_pending_snapshot+0xbc4/0xd10 [btrfs]
>    Call Trace:
>     create_pending_snapshots+0x82/0xa0 [btrfs]
>     btrfs_commit_transaction+0x275/0x8c0 [btrfs]
>     btrfs_mksubvol+0x4b9/0x500 [btrfs]
>     btrfs_ioctl_snap_create_transid+0x174/0x180 [btrfs]
>     btrfs_ioctl_snap_create_v2+0x11c/0x180 [btrfs]
>     btrfs_ioctl+0x11a4/0x2da0 [btrfs]
>     do_vfs_ioctl+0xa9/0x640
>     ksys_ioctl+0x67/0x90
>     __x64_sys_ioctl+0x1a/0x20
>     do_syscall_64+0x5a/0x110
>     entry_SYSCALL_64_after_hwframe+0x44/0xa9
>    ---[ end trace 33f2f83f3d5250e9 ]---
>    BTRFS: error (device sda1) in create_pending_snapshot:1576: errno=-24 unknown
>    BTRFS info (device sda1): forced readonly
>    BTRFS warning (device sda1): Skipping commit of aborted transaction.
>    BTRFS: error (device sda1) in cleanup_transaction:1831: errno=-24 unknown
> 
> [CAUSE]
> The root cause is we don't have unlimited resource for anonymous block
> device number.
> The anonymous block device pool only contains 1<<20 devices, and is
> shared across a several fses, like ceph and overlayfs.
> 
> While btrfs has support for 1<<48 subvolumes, so it's just a problem of
> time to hit such limit.
> 
> [WORKAROUND]
> Here we can free btrfs_root::anon_dev as long as the subvolume is no
> longer visible to users.
> 
> By freeing it earlier we reclaim the anon_dev quicker, hopefully to
> reduce the chance of exhausting the pool.
> 

Why isn't this happening as part of the root teardown once all the references to 
it are gone?  Thanks,

Josef
