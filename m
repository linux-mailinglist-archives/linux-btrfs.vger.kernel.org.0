Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2782F2069
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 21:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404033AbhAKUJA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 15:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391532AbhAKUIx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 15:08:53 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29D6C061786
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jan 2021 12:08:12 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id 186so22696qkj.3
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jan 2021 12:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FHth/aaRGXw8bPkksN5hjPH+DYHe+92fn3EKoOPKveU=;
        b=xSKSRey0zDYxR9bJ7/hLqOBHXUc9MMX6Fkw6qu1x8skDncTMF78XOi1DpZ8ODOBDFY
         d9MwZXZ54AUoqB3Od0Q0Rj5vtrB86BQ8hrPzGc0bcfQ12izILc7cOxJ0xTXw2XPsXE1C
         DeAiElQ9+y2KeHsgZBdKDoJIjsEdFWH9EqDCj5O0Cd0KEg9MYI5bPUg4U4HINubTMDQ2
         PSMfy269yHRn12ac5ISOsmbcC+p9ocWk7T/S4YhFxKSkk0mn/SOta9Ih6hseyLmwbiEV
         H1UHa9QrKyC5s6R9j7vTIQmHbTMP9322xXbsgV003Sh2Bhb02hoUbbTw1QDkgEacYpqt
         C4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FHth/aaRGXw8bPkksN5hjPH+DYHe+92fn3EKoOPKveU=;
        b=FsJg5W0x32eBfxgfI/Gtb3OaQpXS7Kk1qYTaUqDvM+HNLYLFVo3ohYFXV22xUfBfOr
         IJv6BupsznF+tchRDeoERWfSdw76oC2Zv7KIbRjhk7axd2VzTfsKts+7UKNqSerMEzU6
         /Dlpe5jL+SRn7WGF6ranQj6uFCN/Z+uwSQKvucQk/v2ZpQiqAN8QbdRw9eiwGfsuCiDM
         UwTaRPMvnSlNn0U8GACp4YGxvKMVWt60KCGtPW54t06S47uhAaBRzEUl9AhDAT+etksa
         qEV90MwKfNMgQWbmANJaw/d71XW57fpS0r6OCHOE8CjYxLCWVzJEM0UlBWHqDIN5D2TT
         wD0g==
X-Gm-Message-State: AOAM530NZl7RqnzYMxxrAKWjxJunxhsruZajStuBTMsUb4vtnij9O+zQ
        J1/KhppapoRNRx16jgxu5+vF8GWrrEqU9wq+
X-Google-Smtp-Source: ABdhPJyHKp00d1h8tDaA+yMYqHjhyBUP9PWFx/rhtQ9gpobh9qAoUOCdrATVHf4Ij84rffpiFz5b2g==
X-Received: by 2002:a05:620a:1467:: with SMTP id j7mr1064813qkl.266.1610395692123;
        Mon, 11 Jan 2021 12:08:12 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a22sm443706qkl.121.2021.01.11.12.08.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 12:08:11 -0800 (PST)
Subject: Re: [PATCH v11 06/40] btrfs: do not load fs_info->zoned from incompat
 flag
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <fb24b16fb695d521254f92d70241246f859ffa36.1608608848.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <21c01c81-22fd-437f-4e41-ce4563d71dc9@toxicpanda.com>
Date:   Mon, 11 Jan 2021 15:08:10 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <fb24b16fb695d521254f92d70241246f859ffa36.1608608848.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/21/20 10:48 PM, Naohiro Aota wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Since fs_info->zoned is unioned with fs_info->zone_size, loading
> fs_info->zoned from the incompat flag screw up the zone_size. So, let's
> avoid to load it from the flag. It will be eventually set by
> btrfs_get_dev_zone_info_all_devices().
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

May want to take another crack at that changelog, the grammar is way off.  The 
code is fine tho

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
