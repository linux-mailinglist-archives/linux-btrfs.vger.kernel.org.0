Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA361FBEDF
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jun 2020 21:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbgFPTVj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 15:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730585AbgFPTVi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 15:21:38 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A254C061573
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jun 2020 12:21:38 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id w90so16441446qtd.8
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jun 2020 12:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g9D3Z7RJxpilal1nOosk34XAlFwP3N2mqaocQMtpXRc=;
        b=HeQoMhUQEvNqgT+i/QaXv5yffuHDFYDvPmCzLRZBCWvGG93RHq2FfH6EMgorkYvDYI
         UA7jILhcz8eAusAV/vUgdWNcFDZww1AOrkgK/pWL09y6Ljqg8WxQoC8cmPMnK/H3IBO4
         +pWBvo7BjQFIQZ8+W+YnBKfjkt33+gGZnMA62IvgFMhkatLWQJaS26rf/lkjbqPtqtgc
         b3c3Z89ZGjt0jLSOoCA8WhUhGGfmyAEUrt338vi/iv1IFg7sBMEb8qw3m8PAO6sL7Rsb
         q0y2TYBb/FiAgEfXX117mDLTIyJii76KdHt41WMWQdPmGJMWXufrPyYjT3UdU1YoZdB0
         1OqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g9D3Z7RJxpilal1nOosk34XAlFwP3N2mqaocQMtpXRc=;
        b=PMQXc9+2R8YxmeNDqBYjHf1d35bBGt0dFCljTZebTXT8xztrzIMyRfSqq1xi/V5DNS
         c4dNxLplIBxxKtAT5iWENovXkemd1G3TjbUrzEsP15aIOJqC6kL23LwI4W11NhfM0CWR
         0AHJtxOBpH/JZrSRA0yJNdX7dkmD2ZQa2i8sTOL+SG3N9Px/0fKjikcxcNQWQ1y4LqkX
         GO+ceFrQ/6Ja+5ocqi/RLjLIJlsaIAZPFe26Eumtvo5/vrHjI137wrx8xcHKsiNgI0Xk
         3ISz+coVOnYyKpJuEzToW+uZhVJaDjOYcshiruQaAfFkvDJK1z3Zb2pKNt5eCeP8aDqB
         Ap6A==
X-Gm-Message-State: AOAM533YZY+rwDrrJNGo4Qt5uQpadMiAfLuJab3EwCOUs1LnOByB+td6
        dRk0nmLokY7lGq0ORv8mfORE9A==
X-Google-Smtp-Source: ABdhPJyQbGQwxlUVO8h48OFskPGVZtI/oTS7odvL3v9Ra7qLdUntP4v1VGrkVBuChqXx9GVxzOQ9vw==
X-Received: by 2002:ac8:6f55:: with SMTP id n21mr22633036qtv.175.1592335297517;
        Tue, 16 Jun 2020 12:21:37 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k20sm16254320qtu.16.2020.06.16.12.21.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 12:21:36 -0700 (PDT)
Subject: Re: [PATCH 1/4] btrfs: disk-io: don't allocate anonymous block device
 for user invisible roots
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Greed Rong <greedrong@gmail.com>
References: <20200616021737.44617-1-wqu@suse.com>
 <20200616021737.44617-2-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <945eb526-8dbb-e5ce-9933-27ac20f6db91@toxicpanda.com>
Date:   Tue, 16 Jun 2020 15:21:35 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200616021737.44617-2-wqu@suse.com>
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
> Since it's not possible to completely solve the problem, we can only
> workaround it.
> 
> Firstly, we can reduce the user of anon_dev. Data reloc tree is not visible
> to users, thus it doesn't need anon_dev at all.
> 
> This patch will do extra check on root objectid, to rule out roots who
> don't need anon_dev.
> Although currently it's only data reloc tree and orphan roots.
> 
> Reported-by: Greed Rong <greedrong@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/CA+UqX+NTrZ6boGnWHhSeZmEY5J76CTqmYjO2S+=tHJX7nb9DPw@mail.gmail.com/
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
