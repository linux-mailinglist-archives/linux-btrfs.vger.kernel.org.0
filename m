Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A8F2489E7
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Aug 2020 17:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgHRPbs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Aug 2020 11:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgHRPbq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Aug 2020 11:31:46 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252BAC061389
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Aug 2020 08:31:46 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b79so18586103qkg.9
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Aug 2020 08:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=II2pKzN/pvEipNSucOHroMFjXyg9n3sKgsNRwLspmvw=;
        b=nfWCTZjkn8Qd3M4eKYdAAw0b+8rNiHNDNWtEbq4FlxgkfGa65MyI7m1jFZUuxrSRgs
         xghPXdX78AcgjnB2R5qqjW8CcF21wsSJk2EpUh4hAzfq7mx+2vbcoh3sfazGtfOUgOS+
         FCvBW3RN+6jkr5PwwzXszEN5P5VuXjOHMytsKoLIX08eckX9u9Q+flg4iWu/fuf14qQ2
         aB6xYJU9Qbhs58JhKJG52Jt3Gg1K9QlYnS71dcO8fqNzzyk1bigcuFM/N0YmF9GMd7r5
         20h7MF1HdcUAAb7ktTUj/mvxLxNYSMuD1aRigXte3yCjD/eYsb2g5FXc4Dte8kJfxSLy
         OAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=II2pKzN/pvEipNSucOHroMFjXyg9n3sKgsNRwLspmvw=;
        b=fIA+YWpPmsfgW1NPYaE8A6tU53rUvOd8k/pjuFF/3J/gaTEQcA480IZcs1abeurW9x
         YYa1kfjC7X/alIwoDjHR+i19XFzHUrk7e+OpGKcxksr1gxFTMjuIUZLe6eQzE4SbN2Mf
         qtbudg6ac+uP7tw1nkAZrZO7RRui5VhjB2FquchuJ+JJ0xTnmL/MU4PIaH6/h5YUvYmM
         Qv57M9pBhxN/M25z7AUokt3FcoX/COANT8AcTCHymjQvMMncJtVdSPR8xNXRIDLDkkru
         BXzb+oH7p3JmWInCzqZjrKhqfVrqnQbs3vhNYVR6DRcZC/2RX4dWSzizhwkm5j03VoSS
         y84g==
X-Gm-Message-State: AOAM533nH1uV///qfpihSQOIZdD7ZMKCss/3C9YioOGXdAi/EJ9FdrNc
        4klSvR1ajjM4hK+DUV11oxJGUNpzCZsp9i5W
X-Google-Smtp-Source: ABdhPJyB58cEv+Q+hk8C2Td82+eG7RZSWtI1qfqCdIYGtCCMPqmroh9qd8Oqe1M2eZeWc00PcW9BDQ==
X-Received: by 2002:a37:a0d1:: with SMTP id j200mr17940495qke.212.1597764704906;
        Tue, 18 Aug 2020 08:31:44 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::1055? ([2620:10d:c091:480::1:66f8])
        by smtp.gmail.com with ESMTPSA id x23sm19886139qkj.4.2020.08.18.08.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 08:31:44 -0700 (PDT)
Subject: Re: [PATCH] btrfs: fix put of uninitialized kobject after seed device
 delete
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <20200815171514.14105-1-anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b5e35458-00f9-2c6b-3db1-38f55ef2b738@toxicpanda.com>
Date:   Tue, 18 Aug 2020 11:31:43 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200815171514.14105-1-anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/15/20 1:15 PM, Anand Jain wrote:
> The following test case leads to null kobject-being-freed error.
> 
>   mount seed /mnt
>   add sprout to /mnt
>   umount /mnt
>   mount sprout to /mnt
>   delete seed
> 
>   kobject: '(null)' (00000000dd2b87e4): is not initialized, yet kobject_put() is being called.
>   WARNING: CPU: 1 PID: 15784 at lib/kobject.c:736 kobject_put+0x80/0x350
>   RIP: 0010:kobject_put+0x80/0x350
>   ::
>   Call Trace:
>   btrfs_sysfs_remove_devices_dir+0x6e/0x160 [btrfs]
>   btrfs_rm_device.cold+0xa8/0x298 [btrfs]
>   btrfs_ioctl+0x206c/0x22a0 [btrfs]
>   ksys_ioctl+0xe2/0x140
>   __x64_sys_ioctl+0x1e/0x29
>   do_syscall_64+0x96/0x150
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>   RIP: 0033:0x7f4047c6288b
>   ::
> 
> This is because, at the end of the seed device-delete, we try to remove
> the seed's devid sysfs entry. But for the seed devices under the sprout
> fs, we don't initialize the devid kobject yet. So add a kobject state
> check, which takes care of the Warning.

Huh, why don't we do that?  Seems like we should be init'ing all the devices 
sysfs entries upon a successful mount right?  Thanks,

Josef
