Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58FE9248A09
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Aug 2020 17:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgHRPir (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Aug 2020 11:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbgHRPij (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Aug 2020 11:38:39 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B377C061389
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Aug 2020 08:38:39 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 62so18622402qkj.7
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Aug 2020 08:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=wbrRUyE7z/AwDcyicLzzDG7bF8rz7nVbWoKB+6EMrmM=;
        b=Z6yhvq08IgutaSVtXZRPnKST5h/zgZQXvTNL/OtnDlPobtTEIoFAZEOJtUBP46gO3J
         8zlpJCk8ABeHx7cM1se61unpwT1neBkzFDMC7rxZTtlU5vODzykpMTfXykxFLSG89ohM
         wPqBIgUMUpNLmjTSjDRDaWGofBo9hnvpIIPoKVk1n3O/noE08syFjhFSXnUTxNw2ejhm
         ldRc/CRxYHvAqcmh5qUD+fklddgjqT7qWxo7A2ACjvPudtEbuJHizfGroABEAJJrHkpP
         /oeKCQ7yq8GLhM265oGE2T0RQgE1+V/AsHQq/bgC9XLRLcffTbCGFu1OeDIxj80kGAxi
         WU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wbrRUyE7z/AwDcyicLzzDG7bF8rz7nVbWoKB+6EMrmM=;
        b=rfLJ8MA2Wwxkr5vyaT46kE2Pa6LJCEADGOPuO4y+qDCYlYYIIhjKTacCUDlb9p3Zkm
         637TicPf2q2WHhTfUZ1kVveUyLlvglv3LIw4Uxpc/uOKtc2LMXTqtVKapubBVMQd8Ehh
         IWSRTY2ktZMoMGfUVTVNavhIMffgfxgnczh4wdCEYW7NwF0CkQkpr6CQU4dDuqXQ748C
         xrsoyCGLdy2oitIS6iK5zUojFiWnE6q/symm+Gp9IslRHq+Xiv2D/H5zmzPNrTJAy4vN
         9ZxFHFjNqrxOxRnuSJL/osEVGALELKqoG2zvXimTONe+MnVIbQgmQxDeJgyezHK8tUVK
         Jk4A==
X-Gm-Message-State: AOAM533Pbbl00JHhe0AIksXjztcQ7HMRTYjBwmVIze19nj8SZqumt1aS
        GVDRAkILvUV/HC6f6+o+gAfKkIDBMlAUJFHQ
X-Google-Smtp-Source: ABdhPJyx8dGI6nPeGOoVfkQundU7t+8MnQVbJJgkrKgRuBY0N5368sRWtmGNXtAJanppk1Hr/w4k8g==
X-Received: by 2002:a05:620a:1257:: with SMTP id a23mr17475689qkl.207.1597765117957;
        Tue, 18 Aug 2020 08:38:37 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::1055? ([2620:10d:c091:480::1:66f8])
        by smtp.gmail.com with ESMTPSA id p202sm20595979qke.97.2020.08.18.08.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 08:38:37 -0700 (PDT)
Subject: Re: [PATCH 0/5] Misc warning fixes
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1597666167.git.dsterba@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1f4f3a04-fb83-ed2e-5b7b-ed8b3cc24880@toxicpanda.com>
Date:   Tue, 18 Aug 2020 11:38:36 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <cover.1597666167.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/17/20 8:11 AM, David Sterba wrote:
> Compiling with W=1 or W=2 gives warnings that seem to be worth fixing.
> 
> David Sterba (5):
>    btrfs: remove const from btrfs_feature_set_name
>    btrfs: compression: move declarations to header
>    btrfs: remove unnecessarily shadowed variables
>    btrfs: scrub: rename ratelimit state varaible to avoid shadowing
>    btrfs: send: remove indirect callback parameter for changed_cb
> 
>   fs/btrfs/backref.c     |  1 -
>   fs/btrfs/compression.c | 35 -----------------------------------
>   fs/btrfs/compression.h | 35 +++++++++++++++++++++++++++++++++++
>   fs/btrfs/inode.c       |  1 -
>   fs/btrfs/scrub.c       |  8 ++++----
>   fs/btrfs/send.c        | 11 ++---------
>   fs/btrfs/sysfs.c       |  2 +-
>   fs/btrfs/sysfs.h       |  2 +-
>   8 files changed, 43 insertions(+), 52 deletions(-)
> 

The whole series can have

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
