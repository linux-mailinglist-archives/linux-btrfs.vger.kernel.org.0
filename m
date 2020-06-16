Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209E71FBEF8
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jun 2020 21:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbgFPT1C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 15:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730423AbgFPT1B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 15:27:01 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7B4C061573
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jun 2020 12:27:01 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id cv17so10058991qvb.13
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jun 2020 12:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=2WEQ2I29bYGyqxWS98Z7IgWM+DlSWdqjJS9r0BAepc4=;
        b=Leb8MglGIrJAkn3ilxonYwYZjMhPTmb21gC9UwWYU7c2cio2+zYDi3KtGMXXQnbQiE
         M105fWXZ+vIm0syo+2Dv3SmqsKOIp8ZMuOuyMkM3MZPbdUPaQyPEMiX9qIO1dWzXXtyV
         f4F9XmH2y1kFUXAvtDjVb3DCkXYmu68FHU2u7M4H6tySNCnlaHLhjjfCh17bV5Z/dnLb
         8Ev4rz7sh6deYY9Npuk7kJv55aMzsl4Ncc2YILGP3jZvpCjoMKS1OhWXLTH/6rh5CdgN
         FAwDV1fPr2fUjEUkZ0wlwRHQs88uCnHHpxD3SACj4aRwLVkqT6lzN412pPOp0obDUvEf
         nXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2WEQ2I29bYGyqxWS98Z7IgWM+DlSWdqjJS9r0BAepc4=;
        b=pdGjuM3AtXQ0x35HySJ3U2UsEmBySzsYmbhkK9DSbAscchHOx4UWO54efUPHFEBO95
         7jbnjkbwG3II3tM/k7GPPe87xnY5uwiFwHQdlJDMH735AjC2OFnZ8bOoSMvC9c6Q6aXJ
         u8bPQ5DNVdglfCA9eT8es6mBMRQ7vGT4yeEt5TUs7uqGynkyiFQtgdr7NkKptWoAUBRI
         TWWPfztPAscPYutaW8vKUlW608FUtdaF2WSKc3WAYxtkiaHT4DPKcxFtAGiLST2doLxH
         nyi6hEy0Re9JnXD9/gUULKoXF0XM7pBtHkAjAqw1WsXxNsWt3RFM0hXBQBkyxd7jB/AF
         mNog==
X-Gm-Message-State: AOAM532h68gEy48+KVjLSMQdXn+w3fsf2dOkoyogbxt3tACJ48YMFn6j
        pbKBrKA61wvt0tQ5y+30Pr7tbm/QWKYMPQ==
X-Google-Smtp-Source: ABdhPJzTmRnAF+88IxYM/QAnchy6pBsa6Gm76hMWLNvQYBpMsbmfX6a0U01WarFNd5+g0Fm3P4DLqQ==
X-Received: by 2002:ad4:5608:: with SMTP id ca8mr3905235qvb.221.1592335620156;
        Tue, 16 Jun 2020 12:27:00 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z9sm14711971qkj.129.2020.06.16.12.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 12:26:59 -0700 (PDT)
Subject: Re: [PATCH 1/4] Btrfs: fix hang on snapshot creation after RWF_NOWAIT
 write
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200615174601.14559-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3f274820-48b3-4453-02c1-4188ea9f8c35@toxicpanda.com>
Date:   Tue, 16 Jun 2020 15:26:58 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200615174601.14559-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/15/20 1:46 PM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we do a successful RWF_NOWAIT write we end up locking the snapshot lock
> of the inode, through a call to check_can_nocow(), but we never unlock it.
> 
> This means the next attempt to create a snapshot on the subvolume will
> hang forever.
> 
> Trivial reproducer:
> 
>    $ mkfs.btrfs -f /dev/sdb
>    $ mount /dev/sdb /mnt
> 
>    $ touch /mnt/foobar
>    $ chattr +C /mnt/foobar
>    $ xfs_io -d -c "pwrite -S 0xab 0 64K" /mnt/foobar
>    $ xfs_io -d -c "pwrite -N -V 1 -S 0xfe 0 64K" /mnt/foobar
> 
>    $ btrfs subvolume snapshot -r /mnt /mnt/snap
>      --> hangs
> 
> Fix this by unlocking the snapshot lock if check_can_nocow() returned
> success.
> 
> Fixes: edf064e7c6fec3 ("btrfs: nowait aio support")
> CC: stable@vger.kernel.org # 4.13+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
