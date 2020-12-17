Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDB82DD52F
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 17:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgLQQ1g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 11:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbgLQQ1g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 11:27:36 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C26AC061794
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 08:26:56 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id u16so13539567qvl.7
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 08:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=7Ouulsuqr+1o0tBbq14gy2Ne5hMrRta4Ov98nndyI0g=;
        b=lMgMmUoMK/o3Wiy64njxpYHxX0psYIPxnZOVCgwz43O/A1yhYf5jQnO343IxPDTKY6
         07JeXoVMT1LtV6OjaGdVFlJNvP9kPUZKZGiy/hdAseShwE90KazJPPv9lTMEycAKFgik
         A1lZtqHRHhYcAlwZON2K2/M2oy58kDxZF63QdVJJCtIWu90PYNZSsKzOpyf8HygH4WC4
         GNBUCWlbf9TvuTBrlFc405Wayq7bfLk6ki1jG+KOWdSUliLz+2jMIOWF5T+hvi1qbDKK
         V10KjDToVY6MNF8NVwXo94Ijnqu4CDw96jdf1c3oj1wsdEOT83k9QJmH/GLLza/rtrXb
         64iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Ouulsuqr+1o0tBbq14gy2Ne5hMrRta4Ov98nndyI0g=;
        b=Bk3YSDZpolIJSR+BP2OjzVeZf8rWRjYmEBNii2EQMZDMPGOFbs2YTDL4p0HczmJDTz
         /QZ0PVRoNiTb6zVeKWSWiG6D1UMwJCVwxhxfquQOxuqa2m5Cu6gbj9mq2Ak2o5RBXEn9
         fyy3GEOCL54Kw17tA2YJUcfVCPppTgck8hbGp/rj7+Mx3ioOaqmk0Yva/I4cnq+O/W44
         LzWouvaYfZnf1/Cwowy3IlHzfqwt50ZzF3QY/ndXrjTMDU4lgsbnReH9kfmC/FuK9wn3
         Q1J4WrjZh9/nVOFFcqsygsv1SpjBjGmUX84/3d36p60VhdGGUyc65UIXiryK/LFnZqWv
         Vmdg==
X-Gm-Message-State: AOAM5307C78aS7Be/ELTblY0E+S4whmmxIwxMM23mLvB0TdM2v0LsIPQ
        oPSTgXgyo41qBoy5CJhUREioiwmJzXUTEk8A
X-Google-Smtp-Source: ABdhPJzYF1asC2uGhfaDpik+PRQbv6fzakdESMLv7pZTG2frzyfG865swYyvOuVKcaxhSuQUKhGMEA==
X-Received: by 2002:a0c:9ad8:: with SMTP id k24mr26753qvf.28.1608222414956;
        Thu, 17 Dec 2020 08:26:54 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 198sm3602676qkk.4.2020.12.17.08.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 08:26:54 -0800 (PST)
Subject: Re: [PATCH 0/5] btrfs: fix transaction leaks and crashes during
 unmount
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1607940240.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <5f8ed761-8d15-dcd6-aede-086a892dca13@toxicpanda.com>
Date:   Thu, 17 Dec 2020 11:26:53 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <cover.1607940240.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/14/20 5:10 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There are some cases where we can leak a transaction and crash during unmount
> after remounting the filesystem in RO mode or mounting RO. These issues were
> actually being hit by automated tests from the openQA for openSUSE Tumbleweed
> (bugzilla https://bugzilla.suse.com/show_bug.cgi?id=1164503).
> 
> Filipe Manana (5):
>    btrfs: fix transaction leak and crash after RO remount caused by
>      qgroup rescan
>    btrfs: fix transaction leak and crash after cleaning up orphans on RO
>      mount
>    btrfs: fix race between RO remount and the cleaner task
>    btrfs: add assertion for empty list of transactions at late stage of
>      umount
>    btrfs: run delayed iputs when remounting RO to avoid leaking them
> 

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
