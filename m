Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C872C1FBEFC
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jun 2020 21:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730594AbgFPT1u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 15:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730269AbgFPT1u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 15:27:50 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41949C061573
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jun 2020 12:27:50 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id j32so16434878qte.10
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jun 2020 12:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=JU2eCYt2GHCKa9ju0xsZimkNFVK4IEdmyY3vOC6XE+0=;
        b=2HrG23fkVAlLOe4y5fq8SmujULWzSMKPZ/1gmKVVwuqPEGsKM39eUziRiKd6Bg4h1H
         GLCkSPkRUKc9j0zuy/zkjLeDi5njkQ/j+xLEWOcJ8hwEIJ/1zwDxnTVEoBBM69wUxE1w
         AnMLtHMqCj4XQKCH+k1m71W5xWhU5gHRab9DdTblqAnZrh5qheVss4pHNxXc0aN3LPCR
         DU8EZhZDmS+Pm7g4L+JYginV7sF6r0bD+1Eu3o3twbForo86ZpJSLfCXJ3Aq12RvU7ZD
         Gs2JvpDm4Eqdh0D3ARUnJpIGqgIoGVAOJQaGEJKPCLdVI+qVPE07QJZwlU5+NuAXpsgP
         06BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JU2eCYt2GHCKa9ju0xsZimkNFVK4IEdmyY3vOC6XE+0=;
        b=QRUtPgprRuaMwRM4bd+mjnbCuxDWiknTy5l3274xfyDpSKI9mKtiWuKm1xVjdnhMdu
         ZI6Fuo+tp1vKTdVmdF5KqNF/18xUUw6g2WDEUw3DPrDM+2c2F1faNjbfn54cXK0JEPzl
         0szdiTlx1fLR+lbeDUqYkmr9hSrbokBMVAngLuXc0rcxP+dCx3+Iiwl353NAyBpC7CL6
         ViV2fugIzVlCX8D54TpEpfKDRhIxhSoDdYyGAfuNTHcSKYe62O/VQww8Jk+zqVh6USpJ
         BO7SsdbBRYtHMo2TtSILAF2tXOVz+QL+yk8gg7BEE6b/3KVH8M3JI8oR1RoR6yULj/aD
         GotQ==
X-Gm-Message-State: AOAM533R/Js8W3+CrQMMTJhY9wpFwBy3R0jZGOQTlAEU6Gsf2Q7PgkYf
        9R7xInm7lVNf3sN0/dYWjIsRnI8eKeoIjg==
X-Google-Smtp-Source: ABdhPJymByHGk2LiktpT3+ElSEoiEvIx2HpWqi9qGmuZsU8vd6fkjlPlV9FqE3+eTcuzJxv5igvgKA==
X-Received: by 2002:aed:2423:: with SMTP id r32mr23111727qtc.14.1592335669147;
        Tue, 16 Jun 2020 12:27:49 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 5sm15428960qkr.9.2020.06.16.12.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 12:27:48 -0700 (PDT)
Subject: Re: [PATCH 2/4] Btrfs: fix failure of RWF_NOWAIT write into prealloc
 extent beyond eof
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200615174858.14888-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <10357106-5999-0940-de1f-3144911299a6@toxicpanda.com>
Date:   Tue, 16 Jun 2020 15:27:47 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200615174858.14888-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/15/20 1:48 PM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we attempt to write to prealloc extent located after eof using a
> RWF_NOWAIT write, we always fail with -EAGAIN.
> 
> We do actually check if we have an allocated extent for the write at
> the start of btrfs_file_write_iter() through a call to check_can_nocow(),
> but later when we go into the actual direct IO write path we simply
> return -EAGAIN if the write starts at or beyond EOF.
> 
> Trivial to reproduce:
> 
>    $ mkfs.btrfs -f /dev/sdb
>    $ mount /dev/sdb /mnt
> 
>    $ touch /mnt/foo
>    $ chattr +C /mnt/foo
> 
>    $ xfs_io -d -c "pwrite -S 0xab 0 64K" /mnt/foo
>    wrote 65536/65536 bytes at offset 0
>    64 KiB, 16 ops; 0.0004 sec (135.575 MiB/sec and 34707.1584 ops/sec)
> 
>    $ xfs_io -c "falloc -k 64K 1M" /mnt/foo
> 
>    $ xfs_io -d -c "pwrite -N -V 1 -S 0xfe -b 64K 64K 64K" /mnt/foo
>    pwrite: Resource temporarily unavailable
> 
> On xfs and ext4 the write succeeds, as expected.
> 
> Fix this by removing the wrong check at btrfs_direct_IO().
> 
> Fixes: edf064e7c6fec3 ("btrfs: nowait aio support")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
