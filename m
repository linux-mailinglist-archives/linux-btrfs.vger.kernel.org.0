Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16651FBF02
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jun 2020 21:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbgFPT25 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 15:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730269AbgFPT25 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 15:28:57 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE1DC061573
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jun 2020 12:28:57 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id w90so16462294qtd.8
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jun 2020 12:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=W/6M6CeVslfxh4eastxSrTOI0pdUlFn8kwc0r8dZlAs=;
        b=CUEQBRwXGGYig2AMLFeex8+YWp+QN4pw5PSLj42MX7Js2z+11uOYqB2YMEM3SsDVXZ
         42zNVgEINmXAjvCNZ4sCURHbYENTg9Dg1VCxJFgNJ4mOmM6NbGSPt5WhxfJRZR24JF3U
         6ky+lMVMSIMNdIyvSW2aXPlXqoeYUtbgT3EndrMCJe0l+Mo96oqjzeZ21lF0XcFEXPvB
         WEeTyI5YWn5U6pD6E/LqHjWI24pDiIHC2OS5YR0gmdAOzz1MjI4EQ1uDOj31UKw3bX/J
         GVSwGAsE7mU+XKWWmvJ6DIwg/C+YIsOl0aPD64Drelc7qIQorNhCWgjCXAnqUXwyumj6
         ejQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W/6M6CeVslfxh4eastxSrTOI0pdUlFn8kwc0r8dZlAs=;
        b=IQ7A9D066I6M0wU3qEsobsC84BRfFxj5a5ScAV+zgJceqbSZXDS/EMkQNvdoqRtVOh
         TLzlBSXf3/v0repxxzgIS5w6tKJuZzkWce/ionXAdLiya1cJqJoQ6qoGycXkAogXv5+F
         528VPca3Ie9mNWtW/sY2TAM8GGDOs0k0xI5erBPv1WeJvfG17HlQoR453YLZZ03PYMsn
         wEmxevX8mRE+StFEZ1WdAssk+KtKo5YTg/d6nloxN+NS8V+ESLcTe0H6Pnb5Sw0avgvb
         H3F/xQnTJyuQAFhvHS57kHJSzkkrvDoFi3H2/Y6liFT5nHaPvg2kAxTNRIOrsXbLzSOu
         6Fpg==
X-Gm-Message-State: AOAM532kciCJkLwCEBDEa2rp7VUmSAEa83iPiLXHmCCqAyBFOrPx6a4W
        cOe4WSQuuK76J2/pGX4g/A3+0ykslMhIFg==
X-Google-Smtp-Source: ABdhPJwVqOoTx9mAOiZT2EyTPJrdmML2CJ9pNrQ0F/wDCGc1y3nlPEUZOeAixrgoiHb3ybRlE5RfVA==
X-Received: by 2002:aed:2744:: with SMTP id n62mr22941227qtd.152.1592335736011;
        Tue, 16 Jun 2020 12:28:56 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k6sm15875971qte.52.2020.06.16.12.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 12:28:55 -0700 (PDT)
Subject: Re: [PATCH 3/4] Btrfs: fix RWF_NOWAIT write not failling when we need
 to cow
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200615174913.14943-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <010642fe-cfec-20d8-63ac-dab18957b773@toxicpanda.com>
Date:   Tue, 16 Jun 2020 15:28:54 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200615174913.14943-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/15/20 1:49 PM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we attempt to do a RWF_NOWAIT write against a file range for which we
> can only do NOCOW for a part of it, due to the existence of holes or
> shared extents for example, we proceed with the write as if it were
> possible to NOCOW the whole range.
> 
> Example:
> 
>    $ mkfs.btrfs -f /dev/sdb
>    $ mount /dev/sdb /mnt
> 
>    $ touch /mnt/sdj/bar
>    $ chattr +C /mnt/sdj/bar
> 
>    $ xfs_io -d -c "pwrite -S 0xab -b 256K 0 256K" /mnt/bar
>    wrote 262144/262144 bytes at offset 0
>    256 KiB, 1 ops; 0.0003 sec (694.444 MiB/sec and 2777.7778 ops/sec)
> 
>    $ xfs_io -c "fpunch 64K 64K" /mnt/bar
>    $ sync
> 
>    $ xfs_io -d -c "pwrite -N -V 1 -b 128K -S 0xfe 0 128K" /mnt/bar
>    wrote 131072/131072 bytes at offset 0
>    128 KiB, 1 ops; 0.0007 sec (160.051 MiB/sec and 1280.4097 ops/sec)
> 
> This last write should fail with -EAGAIN since the file range from 64K to
> 128Kb is a hole. On xfs it fails, as expected, but on ext4 it currently
> succeeds because apparently it is expensive to check if there are extents
> allocated for the whole range, but I'll check with the ext4 people.
> 
> Fix the issue by checking if check_can_nocow() returns a number of
> NOCOW'able bytes smaller then the requested number of bytes, and if it
> does return -EAGAIN.
> 
> Fixes: edf064e7c6fec3 ("btrfs: nowait aio support")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
