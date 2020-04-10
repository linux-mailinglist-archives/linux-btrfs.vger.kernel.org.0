Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A93991A4A46
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Apr 2020 21:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgDJTTa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Apr 2020 15:19:30 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43624 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbgDJTTa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Apr 2020 15:19:30 -0400
Received: by mail-qt1-f194.google.com with SMTP id z90so2248531qtd.10
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Apr 2020 12:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=M7oyMGOYGlezi43iTShb+ImsWteBM2W/k+yv8wa4s3I=;
        b=X+lqKnRmYwZ0s8G7GKOrMA7SKv4a36q0Fu3TgUHEU4QULfyavEogJ2CfaLvb5PUSt8
         k3Z13jPkWUJa6F/fWwcYLKCkcsZKhVE1aeNAK8hLGfc7fjOihagAosCVnmjD51FpiJqU
         pte3H83617q1JFAN139AjWTtdJ3iA/Fv7Jvh0S699lg17EM8J2CIjs78yCJfEwVkozRd
         Mtdrg6Mxhpr3VCTPBy2x6G5EmaHzWiXOL+QAy1oYACaDDqqLB9LEwQ55/vFrKnsT3KHe
         oF6X9f8l4bo3CTfpFINVTZvLBZMaBp76HuCrqKVtX9i2hJqPceEJ18BLB5aiKIpMh/Xj
         VNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M7oyMGOYGlezi43iTShb+ImsWteBM2W/k+yv8wa4s3I=;
        b=GmG6nc/1N5fqb4dmRw239qhDfZ59MMs8ngvnL+mCMuefJFy9SMKYmONGTtVVe9RXjW
         43gbxvw1Ers9hdppbO3kNF/7zOGSKbvvXl896SGJHBNi9Oqcj9IXrZrsgEPw3ZztXVZL
         rbD8eldpCivSiQQFmjYL0rR89Q8GbOLZNais/EsBKhZWU0gSXD1QqP6ZGU6U5uOWvdPX
         pc6b6AhvNO03y15bVqTdckQKXrFtoetPCg3wNsPH/+pxSlO74y/bogQExUw5gLAYGr1b
         3IJjcI9e+0uZoUhXOpQST5npzSY+lQBqUiMHGmGAUE5PUACVSq+GC0k6ZcZUndUA9Ogq
         SJmg==
X-Gm-Message-State: AGi0Pub+Cbd0dOzaTkvMpxD4E4+8gOelHFT7Ic0x9EDyiEFq+5sJHuUm
        zivhrwQElGVXsGv64qJf5pkpGHpyj17obg==
X-Google-Smtp-Source: APiQypI5FqatPCSn6BMtWHJUIdDkHC9VUZrFUUt9Xm1QGMPtLnX7OX7iRyekQenrnX6rj9N4C+8j0Q==
X-Received: by 2002:ac8:2c73:: with SMTP id e48mr682824qta.96.1586546368943;
        Fri, 10 Apr 2020 12:19:28 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id x68sm2314699qka.129.2020.04.10.12.19.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 12:19:28 -0700 (PDT)
Subject: Re: [PATCH] btrfs: qgroup: Mark qgroup inconsistent if we're
 inherting snapshot to a new qgroup
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200402063735.32808-1-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ecc9ec25-e8ca-a288-bc56-aa962c01e02c@toxicpanda.com>
Date:   Fri, 10 Apr 2020 15:19:27 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200402063735.32808-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/2/20 2:37 AM, Qu Wenruo wrote:
> [BUG]
> For the following operation, qgroup is guaranteed to be screwed up due
> to snapshot adding to a new qgroup:
> 
>    # mkfs.btrfs -f $dev
>    # mount $dev $mnt
>    # btrfs qgroup en $mnt
>    # btrfs subv create $mnt/src
>    # xfs_io -f -c "pwrite 0 1m" $mnt/src/file
>    # sync
>    # btrfs qgroup create 1/0 $mnt/src
>    # btrfs subv snapshot -i 1/0 $mnt/src $mnt/snapshot
>    # btrfs qgroup show -prce $mnt/src
>    qgroupid         rfer         excl     max_rfer     max_excl parent  child
>    --------         ----         ----     --------     -------- ------  -----
>    0/5          16.00KiB     16.00KiB         none         none ---     ---
>    0/257         1.02MiB     16.00KiB         none         none ---     ---
>    0/258         1.02MiB     16.00KiB         none         none 1/0     ---
>    1/0             0.00B        0.00B         none         none ---     0/258
> 	        ^^^^^^^^^^^^^^^^^^^^
> 

Can we get an xfstest for this?  When I go through qgroups in a few months I 
want to have as many regression tests as possible to rely on.

> [CAUSE]
> The problem is in btrfs_qgroup_inherit(), we don't have good enough
> check to determine if the new relation ship would break the existing
> accounting.
> 
> Unlike btrfs_add_qgroup_relation(), which has proper check to determine
> if we can do quick update without a rescan, in btrfs_qgroup_inherit() we
> can even assign a snapshot to multiple qgroups.
> 
> [FIX]
> Fix the problem by manually marking qgroup inconsistent for snapshot
> inheritance.
> 
> For subvolume creation, since all its extents are exclusively owned by
> itself, we don't need to rescan.
> 
> In theory, we should call relationship check like quick_update_accounting()
> when doing qgroup inheritance and inform user about qgroup inconsistent.
> 
> But we don't have good enough mechanism to inform user in the snapshot
> creation context, thus we can only silently mark the qgroup
> inconsistent.
> 
> Anyway, user shouldn't use qgroup inheritance during snapshot creation,
> and should add qgroup relationship after snapshot creation by 'btrfs
> qgroup assign', which has a much better UI to inform user about qgroup
> inconsistent and kick in rescan automatically.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
