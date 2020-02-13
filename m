Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C52E15CC18
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 21:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgBMUUt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 15:20:49 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39028 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727893AbgBMUUs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 15:20:48 -0500
Received: by mail-pj1-f66.google.com with SMTP id e9so2903843pjr.4
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2020 12:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wKSZ0MmXqrsMa+VbxqsGH/0A1pKZxblr5hseH/oOSF4=;
        b=aWtjVhakb9JEmHiRgBPH1glzBNOANYyE+mPN7C2Du5NK+tDvLupQeSU4vBIr1J7BGz
         OQgl6kc3jOnwh7YmaFAOjKRTmjtLPlievL51M4J7Ub0aexcYQX0szw91O35lkAjYig9C
         jpjREAYclC8ZJG464VkH4vigXFVM5Dnxx7c/zxWhPqWK+gvi9xwzFok4+kx50zFgDRKM
         LHf7mhHDEvBZo6KvvZ7UFgp7dgdnkW07aQHdrZoBb8m2SvGqzsm2TAe6zTj75ursYhqI
         igVpkPbNPC4xE4TtCyqL5S4fuptmhKBjs8gHsI1wfN1HjAivc47nOEq0lz9dJg2Ye6K5
         dnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wKSZ0MmXqrsMa+VbxqsGH/0A1pKZxblr5hseH/oOSF4=;
        b=G7/EGwC/QVVRfQPpBCs38zHETQXrEfxHuG8NnjyUCqCnONiXb3+pGk59gXz4DA+aHO
         KMkH/y154CnwpjNO0HgvDCYiyjS0gZNlg68Zy7uoxkFJFjiWbIw8DsOC1tlxwa0dbOXW
         IoeVeH0HE2f96kHTsQAz4iJ+SSLza1TSVMnQ6qe4/Cpag9ZzqhOGUiJqC0l7IVTgaIWS
         /af8tBKxzCv/zpTUWbA58pVn1Y+f45IfJchNuUiA/gAa8MP4ysZyNmG9iCiTEB/DjsOI
         HkcKhPa2OeGqB1+wUhf+7j6ig1IkxEhlSa9NiWJlibtOn9Rj1PcbGolA9dDgvVxAmA4f
         29pQ==
X-Gm-Message-State: APjAAAUS2y4CzRpm4s4m5pgyerOaf4NhU1rq4vPQYL0jDuRuw33rPp8g
        97JYN+PeaT+Mkn38OPdrmQx1AQ==
X-Google-Smtp-Source: APXvYqxHhzesgz6b8nvrSvk/Tgkmz8F7nwGQ7/VShHl+56CNBbYNSQy/lFgWnU7EDCsP/hjL7rWFLw==
X-Received: by 2002:a17:90a:da04:: with SMTP id e4mr6670105pjv.26.1581625247121;
        Thu, 13 Feb 2020 12:20:47 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21cf::1150? ([2620:10d:c090:400::5:249c])
        by smtp.gmail.com with ESMTPSA id t65sm3990442pfd.178.2020.02.13.12.20.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 12:20:46 -0800 (PST)
Subject: Re: [PATCH] btrfs: Don't free tree_root when exiting
 btrfs_ioctl_get_subvol_info()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.de>
References: <20200213130157.39230-1-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <2bca9e56-f5ce-6bf7-9e6f-8897f5c03d22@toxicpanda.com>
Date:   Thu, 13 Feb 2020 15:20:44 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200213130157.39230-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/13/20 8:01 AM, Qu Wenruo wrote:
> [BUG]
> When calling BTRF_IOC_GET_SUBVOL_INFO ioctl, we can easily hit the
> following backtrace:
>    BUG: kernel NULL pointer dereference, address: 0000000000000024
>    #PF: supervisor read access in kernel mode
>    #PF: error_code(0x0000) - not-present page
>    PGD 0 P4D 0
>    Oops: 0000 [#1] SMP PTI
>    CPU: 0 PID: 27421 Comm: python3 Not tainted 5.6.0-rc1+ #539
>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
>    RIP: 0010:btrfs_root_node+0x7/0x30 [btrfs]
>    Call Trace:
>     btrfs_read_lock_root_node+0x1f/0x40 [btrfs]
>     btrfs_search_slot+0x60f/0xa40 [btrfs]
>     btrfs_ioctl+0x11f7/0x30b0 [btrfs]
>     ksys_ioctl+0x82/0xc0
>     __x64_sys_ioctl+0x11/0x20
>     do_syscall_64+0x43/0x130
>     entry_SYSCALL_64_after_hwframe+0x44/0xa9
>    RIP: 0033:0x7fcb78d43387
>    ---[ end trace 1c21a7c6c0523b8c ]---
> 
> [CAUSE]
> We're abusing local @root, it's originally a subvolume root, but in
> root backref search, it's re-assigned to tree_root.
> 
> Then we call "btrfs_put_root(root);" when exiting.
> If that @root is reassgined to tree-root, we freed the most important
> tree, and cause use-after-free.
> 
> [FIX]
> Don't re-assgiend @root, use fs_info->tree_root directly.
> 
> Reported-by: Marcos Paulo de Souza <mpdesouza@suse.de>
> Fixes: 8c319b625e0a ("btrfs: hold a ref on the root in btrfs_ioctl_get_subvol_info")
> [To David: please fold the fix into that commit]
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Ooops

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
