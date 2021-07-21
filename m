Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51FF3D1763
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 22:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240370AbhGUTKM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 15:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240344AbhGUTKL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 15:10:11 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F479C061757
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jul 2021 12:50:47 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id n10so3182867qke.12
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jul 2021 12:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=2sgwkbwA2WSiIVHue+sfNYuYuqRexhFEsyiJ0LGhOT0=;
        b=Hz/AYpeiKDvMIzv7BFA7wU0uN7ha91WuriUmz/oE7kcHLGE2MpHoeReNTmHF0g5K26
         gyLCEUfdBoAqRzo4lTK5CzUUnFUt36daxzeDjI1qVDjwk6aa3xN6DH1M4hoi1WZ4NK9t
         8e6ZTUTC8z7UUGgOCRq9EcxoYL/y5nfvtzs9gbV30Dhu5Pm6i5Bins0og841IiOtYjcb
         uQtmGCTY1i6Cy/QZuljT/r33g6TeOEw880WFKCRBwdRyBFKXiA9CbDIwRI/FA0yMBIw1
         yebW1W5QMh1Y7e7I5nId4IbPa+qRMe9lZmQBKs0twiYiaDefG7+UTDKLqqhT43rg9tNB
         8t3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2sgwkbwA2WSiIVHue+sfNYuYuqRexhFEsyiJ0LGhOT0=;
        b=SC+epsqW5e1AZ3KfPvvomEhuMSE8BmXyUGpVwxxp5nvECL2TkuzsByxf3n2NN9IUzj
         6kDkvqn0cKRCdJOIPjwCNwWH61zZOkTeyVTRQlA8zfmDIaGK4vbDHCnBe2kksNZOKAF2
         NDRMyT/r0UD1EyyK70g+raCdOd14Pa3vWucIG9Yo49QPGJUZFqDvZv2HMBr3qsRbQlub
         Gz/HbftiXnjxmTNbQOxXbckp+xgFoXELffs7s6Xmwvn0Ez6lvVOdpCoYieK7Bl31Bulr
         VJPYI26PuFHyFGr4YvA+a1U8uk61ZvJIvBrh3MwzQXnifuMGBqsl6Tu5bFVAjmo0iely
         sKlQ==
X-Gm-Message-State: AOAM5305edmuzLpfAPXNkI6hnYVhdao4OveG0O0xbfdSCm2EJJ1D7Qap
        uOMQ/B0K3dEmVTNPxEyWahqnPQr+gCNBVkD+
X-Google-Smtp-Source: ABdhPJyTUOTigLP8uutcwSCs1La57247VSnSjx14AsmRvEahwsJVmXiNLXhNXa/WMOxjBf6Osn24dw==
X-Received: by 2002:a37:e02:: with SMTP id 2mr20801923qko.10.1626897045581;
        Wed, 21 Jul 2021 12:50:45 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11e8::1223? ([2620:10d:c091:480::1:9441])
        by smtp.gmail.com with ESMTPSA id 197sm11999701qkn.64.2021.07.21.12.50.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 12:50:45 -0700 (PDT)
Subject: Re: [PATCH 0/4] btrfs: a few fsync related minor improvements and a
 cleanup
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1626791500.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <4d80c909-97d2-00c7-d5c2-290c48d85558@toxicpanda.com>
Date:   Wed, 21 Jul 2021 15:50:43 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <cover.1626791500.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/20/21 11:03 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The following patches remove some unnecessary code and bring a couple minor
> performance improvements in the fsync path. They are independent of each other,
> but are grouped in the same pathset just because they relate around the same
> code. The last patch has some performance results in its changelog.
> 
> Filipe Manana (4):
>    btrfs: remove racy and unnecessary inode transaction update when using
>      no-holes
>    btrfs: avoid unnecessary log mutex contention when syncing log
>    btrfs: remove unnecessary list head initialization when syncing log
>    btrfs: avoid unnecessary lock and leaf splits when updating inode in
>      the log
> 
>   fs/btrfs/inode.c    | 12 ++++------
>   fs/btrfs/tree-log.c | 56 ++++++++++++++++++++++++++++++++++++---------
>   2 files changed, 50 insertions(+), 18 deletions(-)
> 

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to this series, thanks,

Josef
