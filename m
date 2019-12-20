Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1C0127E57
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Dec 2019 15:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfLTOo0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Dec 2019 09:44:26 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34395 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfLTOo0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Dec 2019 09:44:26 -0500
Received: by mail-qk1-f196.google.com with SMTP id j9so8175108qkk.1
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Dec 2019 06:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=skXpUWNuPkoiGutNPNqpcNYixtNA24kiYpR6k3BM+cQ=;
        b=pga/CJF3dOFSDTrPetj8GpS098I4TRSsidToAsNi4ULSURzaKDjhVLPDLAJ+Z0KOg5
         9C1DPtoz9qGRfGypuUEIG4ehyBZE4rmll+NJPJgPc0jg34YKspH6gJHRuYZwJXLMaIWa
         /5seXA05yvu21eqRSBkSQMpmdyq8wjMKoJAeX1wgATqhFKlcb92MLmAvLGHZ62B3uv66
         E92Mi1rwkV8CdWkjXn0gfssdZ2zpQGeeBYJg9tXcP/tkyMkoaNn01z62sYAqVBz71lCW
         gmgo6OB8ZegBI/U/s5Nj50PhiW5IPRSfhWaoKkv/IRnPO7yzALT7Heq8AMxRZj5+U3m8
         i6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=skXpUWNuPkoiGutNPNqpcNYixtNA24kiYpR6k3BM+cQ=;
        b=VqLd43qURQjb4gREOtIq16VFkf5o0mml7AGWY7gEkovcWpvvx/gf8Q4C+x+NkN9UfT
         bB9ryOwnCCb3H8BEspx19AHFmMDKaEtawfPWDXzg3TKOnOeWZoRBz3RjRa/U/0ksPXZF
         qrPy4sOj7YhhXHiJxMf8i/GE5zHwEBd6CVydNnFVofY4Jz4gCCLg76yA725g5PeBVIWd
         hf+Oay8eGlTl0AKYbHLJ4OVkgxmc/4NMJ+MbELJIDIfpk+M2bPmmFfzZ0UV3p49l/dis
         M16bvc9+VzmQsUH3dK+e03kJHtkdQmAG6Jn1906eVVr6WHmIuVSGzYkE4seyaA0tDyIk
         6omg==
X-Gm-Message-State: APjAAAVVE3C9CP6RHGUHoj+MFKD43Uywk4d0xxJ24NYAFqjV9Tv0tylG
        vO6P2mHIuPHTLiQfTLdZj/Qf+74unKpaOg==
X-Google-Smtp-Source: APXvYqzQuJI9JE0CUL7fU3z30lHLUt4CsIwAY3yvBovqe39bb6t9ba0hvnqkjrHlp4RL7QN8WaNIXw==
X-Received: by 2002:ae9:ef50:: with SMTP id d77mr13348216qkg.71.1576853064951;
        Fri, 20 Dec 2019 06:44:24 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 11sm2844242qko.76.2019.12.20.06.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2019 06:44:24 -0800 (PST)
Subject: Re: [PATCH 1/3] btrfs: add readmirror type framework
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <1576818365-20286-1-git-send-email-anand.jain@oracle.com>
 <1576818365-20286-2-git-send-email-anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <697fabec-d060-b7eb-8f56-25fb8db052a6@toxicpanda.com>
Date:   Fri, 20 Dec 2019 09:44:22 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1576818365-20286-2-git-send-email-anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/20/19 12:06 AM, Anand Jain wrote:
> As of now we use %pid method to read stripped mirrored data. So
> application's process id determines the stripe id to be read. This type
> of routing typically helps in a system with many small independent
> applications tying to read random data. On the other hand the %pid
> based read IO distribution policy is inefficient if there is a single
> application trying to read large data and the overall disk bandwidth
> remains under utilized.
> 
> So this patch introduces a framework where we could add more readmirror
> policies, such as routing the IO based on device's waitqueue or manual
> when we have a read-preferred device or a policy based on the target
> storage caching.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>   fs/btrfs/volumes.c | 16 +++++++++++++++-
>   fs/btrfs/volumes.h |  8 ++++++++
>   2 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index c95e47aa84f8..0c6caae29248 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1162,6 +1162,8 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
>   	fs_devices->opened = 1;
>   	fs_devices->latest_bdev = latest_dev->bdev;
>   	fs_devices->total_rw_bytes = 0;
> +	/* Set the default readmirror policy */
> +	atomic_set(&fs_devices->readmirror, BTRFS_READMIRROR_DEFAULT);
There's no reason for this to be atomic, it's just a behavior change, if you 
really want to be super safe use READ_ONCE/WRITE_ONCE and have readmirror be 
your enum.  Thanks,

Josef
