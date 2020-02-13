Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50C9B15CBB9
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 21:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgBMUK5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 15:10:57 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37251 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbgBMUK4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 15:10:56 -0500
Received: by mail-pf1-f195.google.com with SMTP id p14so3620050pfn.4
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2020 12:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vKdz9p9aeT1RfJ/ErEQ/qCGPWuJY5NRzE84bqpwhh1g=;
        b=dEYyam2Yd7MjKrKAKfKq+CRDmYOcJIaw9gmN9p5HChhp8rdHe2us2gZBnO1pG2+egz
         19GWE/mofrBra6hK2w5M/VHQ2UmtxJN/mg5ZCTQle+zzozvLjPPymc5zf5LKgTWH6dro
         xGzCIRq3gBmoLFvi9yCFLsQ1s8eExq/qC2Y9JYqi9mYUN+BYJkCuZDbPxZnzBPpd3XNR
         QMKMZDCkqPXZiC2D/5cMCQrCrt5SYO0CYMoBF38bCPUm1QE+M0VaCaISDdYJXnU8clph
         dlGRPI+eRJxA5NLePfk1rwwn9+YGo0eFHS2RPRRa9dyayxRHQSRjCCgX10qWK9u1u4jx
         +LYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vKdz9p9aeT1RfJ/ErEQ/qCGPWuJY5NRzE84bqpwhh1g=;
        b=Ngyt+4iJUMwh/uXrh55LHtpBZO5yUdOrZ7HPPKhv2nMMRuqLsCyJ+KQR2UKrRm17V5
         oVTSW7ge/ptd91AvPK4PsJ0QMtMVe9S26VaWXjyNNVGIDHbGTZD7aMqhQoYnsjDoBLIj
         Dlc2Z4qNMrckdNjUHU/k6+l/nz2IJLMn4zzUJOGhIIebWdCP6Wh/wRVd/WCZ7QPhCDma
         ta2/xAZgRa166lq1ZQm88jl+ZX6Bibdxwl94GLVlsbKzyQTjIUrnBLyjOvf62SbOo8Cn
         mx0yLP8kgjGGO43fQo88PnaXMgidimtAGF1oYYG30kJQw58JN/GvdqZ8EAP4iOEpMrtE
         yi3Q==
X-Gm-Message-State: APjAAAUSP0IleBN0Q9lfCB+F4TJCFuvr/tRbwX3nxipTfzx4Y4fwMVIz
        aUIDqORK6o/BXT/fca5bDpNfC/qjHOk=
X-Google-Smtp-Source: APXvYqyO+B7QXt0K3He8ZmkljAzksAoH2+Et3fDzkPgvYCzJk4FQUP0WnVzKZ2sfvsyCUxvywO1IIQ==
X-Received: by 2002:a63:1e06:: with SMTP id e6mr20381124pge.134.1581624655817;
        Thu, 13 Feb 2020 12:10:55 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21cf::1150? ([2620:10d:c090:400::5:249c])
        by smtp.gmail.com with ESMTPSA id e6sm4023780pfh.32.2020.02.13.12.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 12:10:55 -0800 (PST)
Subject: Re: [PATCH 0/5] Fix memory leak on failed cache-writes
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>
Cc:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
References: <20200211151023.16060-1-johannes.thumshirn@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3e87325d-ca05-d2ee-8eef-dbaa9c694c84@toxicpanda.com>
Date:   Thu, 13 Feb 2020 15:10:53 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200211151023.16060-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/11/20 10:10 AM, Johannes Thumshirn wrote:
> Fstests' test case generic/475 reliably leaks the btrfs_io_ctl::pages
> allocated in __btrfs_write_out_cache().
> 
> The first four patches are small things I noticed while hunting down the
> problem and are independant of the last patch in this series freeing the pages
> when we throw away a dirty block group.
> 
> Johannes Thumshirn (5):
>    btrfs: use inode from io_ctl in io_ctl_prepare_pages
>    btrfs: make the uptodate argument of io_ctl_add_pages() boolean.
>    btrfs: use standard debug config option to enable free-space-cache
>      debug prints
>    btrfs: simplify error handling in __btrfs_write_out_cache()
>    btrfs: free allocated pages jon failed cache write-out
> 
>   fs/btrfs/disk-io.c          |  6 ++++++
>   fs/btrfs/free-space-cache.c | 44 ++++++++++++++++++++++++--------------------
>   fs/btrfs/free-space-cache.h |  1 +
>   3 files changed, 31 insertions(+), 20 deletions(-)
> 

Weird, I swear I reviewed these yesterday, but I don't see any replies from me. 
You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the whole series.  Thanks,

Josef
