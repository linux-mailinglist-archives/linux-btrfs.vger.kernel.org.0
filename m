Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFEE2771C6
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2019 21:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388090AbfGZTAw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jul 2019 15:00:52 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:44197 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387743AbfGZTAw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jul 2019 15:00:52 -0400
Received: by mail-wr1-f44.google.com with SMTP id p17so55419097wrf.11
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2019 12:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3HDmYL7LYF43unjnNLaEU7YBVIeeox6ELqg5o0ga+48=;
        b=ILavBodILNDl42PjnOsvWI8hBKWVGvACxV6wkMPYIBetmfMsWY3gj134exYvrSQUZl
         /jTQsw1ttvJoD88PIC1DSHRSN1q1CrZOXqh2S769T3tT8tLLMSlAAypXTimqWHrGcFl0
         l3EWRMfz4o1HQeXNJNwBDFQ5s3e1gWmo65I3pUdW0e+UJ7H2xDcNQOeOyFrddiPjQS3O
         KoK/Ft7y/l+qYR6vebY/r9F5VXn6l0vjPAEIbs3YWbBqb7XKwkl5NFTfjCYNj7zmdGyC
         ZhCoAa3ikTCNbZjr1RRXB7jEI9phF8Dwo3CIACig1nzdwfxaLZ4QbSw2//sd0FNQW/4S
         lJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3HDmYL7LYF43unjnNLaEU7YBVIeeox6ELqg5o0ga+48=;
        b=NcGS1I7IKAfWIRmSLRxrykQDKWdvKeZhKOT6Y2gTX6jMQxO6S/Nfu0/muKTeF9rPDg
         pu/M4WJUBII7KcPebjyh1pktjKt7bVE8p7HFTXUJRI89dM9MSnLwNVCsbkpBhN0Fl+nE
         2GHQ1hfpAN848oIxRvaU+JfrjPcsSgKcB41TvHRDgWd7lkstxVsiGeAXkI7ilkLtF75C
         Tl3joGc5pP9TgBKKafn4uPYOzosUKbW3eq4bKxgojJV9eo392Sly2oBpTXYVLSbGMXto
         sUVgylfjzfY0s+HE69GxKv9KHZDFxiWZyl2a5zEbNdgvncucDkOZVawsFdWIVA4eKV94
         FrsA==
X-Gm-Message-State: APjAAAWUup3Bbi5pX68f4WF8XrHIbGXn9wuPVOon3go4w0B4m6TV6mkG
        neG4aZcDPQtSfrLgb6vOTidtDXs7ydeKkbEfunHWncZBsis=
X-Google-Smtp-Source: APXvYqy9vW1Hi2enYKPMll4pe0i/Y/RfEAaE03ydCOQ09GK6c1FgzEDLDIPhqchbnRhygwAJHIUL3XTVpHeomrbXwKE=
X-Received: by 2002:adf:f851:: with SMTP id d17mr103818370wrq.77.1564167650527;
 Fri, 26 Jul 2019 12:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtRGNrKDBBFOZ3=Say=STMBAGMNKBwe4xsdJZL7mCRw98g@mail.gmail.com>
In-Reply-To: <CAJCQCtRGNrKDBBFOZ3=Say=STMBAGMNKBwe4xsdJZL7mCRw98g@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 26 Jul 2019 13:00:39 -0600
Message-ID: <CAJCQCtSFNVTNNAEP9hSY3cbWike5VkdH8EZnaojjgZZ3tf-SfQ@mail.gmail.com>
Subject: Re: 5.3.0-0.rc1 various tasks blocked for more than 120 seconds
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 26, 2019 at 12:43 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> Seeing this with Fedora kernel 5.3.0-0.rc1.git3.1.fc31.x86_64 which
> translates to git bed38c3e2dca
>
> It's causing automated OS installations to hang indefinitely, only on
> Btrfs. This is an excerpt of the first of many call traces:
>
> 15:52:20,316 ERR kernel:INFO: task kworker/u4:0:7 blocked for more
> than 122 seconds.
> 15:52:20,316 ERR kernel:      Not tainted 5.3.0-0.rc1.git3.1.fc31.x86_64 #1
> 15:52:20,316 ERR kernel:"echo 0 >
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> 15:52:20,316 INFO kernel:kworker/u4:0    D12192     7      2 0x80004000
> 15:52:20,317 INFO kernel:Workqueue: btrfs-endio-write
> btrfs_endio_write_helper [btrfs]
> 15:52:20,317 WARNING kernel:Call Trace:
> 15:52:20,317 WARNING kernel: ? __schedule+0x352/0x900
> 15:52:20,317 WARNING kernel: schedule+0x3a/0xb0
> 15:52:20,317 WARNING kernel: btrfs_tree_read_lock+0xa3/0x260 [btrfs]
> 15:52:20,317 WARNING kernel: ? finish_wait+0x90/0x90
> 15:52:20,317 WARNING kernel: btrfs_read_lock_root_node+0x2f/0x40 [btrfs]
> 15:52:20,317 WARNING kernel: btrfs_search_slot+0x601/0x9d0 [btrfs]
> 15:52:20,317 WARNING kernel: btrfs_lookup_file_extent+0x4c/0x70 [btrfs]
> 15:52:20,317 WARNING kernel: __btrfs_drop_extents+0x16e/0xe00 [btrfs]
> 15:52:20,317 WARNING kernel: ? __set_extent_bit+0x55f/0x6a0 [btrfs]
> 15:52:20,317 WARNING kernel: ? kmem_cache_free+0x368/0x420
> 15:52:20,318 WARNING kernel:
> insert_reserved_file_extent.constprop.0+0x93/0x2e0 [btrfs]
> 15:52:20,318 WARNING kernel: ? start_transaction+0x95/0x4e0 [btrfs]
> 15:52:20,318 WARNING kernel: btrfs_finish_ordered_io+0x3da/0x840 [btrfs]
> 15:52:20,318 WARNING kernel: normal_work_helper+0xd7/0x500 [btrfs]
> 15:52:20,318 WARNING kernel: process_one_work+0x272/0x5a0
> 15:52:20,318 WARNING kernel: worker_thread+0x50/0x3b0
> 15:52:20,318 WARNING kernel: kthread+0x108/0x140
> 15:52:20,318 WARNING kernel: ? process_one_work+0x5a0/0x5a0
> 15:52:20,318 WARNING kernel: ? kthread_park+0x80/0x80
> 15:52:20,318 WARNING kernel: ret_from_fork+0x3a/0x50
> 15:52:20,318 ERR kernel:INFO: task kworker/u4:1:31 blocked for more
> than 122 seconds.

Is it related to this and maybe already fixed? Or is it a different problem?
https://lore.kernel.org/linux-btrfs/20190725082729.14109-3-nborisov@suse.com/


-- 
Chris Murphy
