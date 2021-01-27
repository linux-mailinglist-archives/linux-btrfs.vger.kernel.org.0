Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CAE3063A5
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 20:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbhA0TA4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 14:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbhA0TAs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 14:00:48 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360D8C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 11:00:08 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id t63so2840041qkc.1
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 11:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lbQ1hKbKX3Iz2k2bLREEdjG9Yc5BFgk5Uck40TjHD7o=;
        b=0u4hkIq+SgGzdQtAAEiOkHb4pDTcv97ITzlVDsz9uY1h7XO2msbWe9ZrYduxxq3lQl
         5b0+A/+NdG39C1FhbcvP4y2nrfdFeyV8OTIF94CHG7PUDhZ6ZVzpRhYH4wix1GDIZ2fE
         PnGKGJ5WEy8dK/+FEksqwZezoCuWMIpOh8FK/FyUNbT5CEpw6wX6IbChts7Li/48p2Cu
         gEEGKtRntETs8CRy1g4R8TZ4fr59EDdtGKwHeTjeSNabYF4gn3Y3uWbniipeFaHzGZWC
         eWraZfTVyeUYiVZtY0ryxZ0pwP0dHZTwt8kUmS9oTwYISnSNrRvni1CaOyGeRSK2mcg6
         4dmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lbQ1hKbKX3Iz2k2bLREEdjG9Yc5BFgk5Uck40TjHD7o=;
        b=exp76NE5n4qiG0QRwGCCc53Y42u3J7S7UxIeddR/2pjqM7qzuTukhHA9ZWeokEzi2J
         GB0GgA+Z4dGmuPIpqMugeL5IgviqayMKxVOyDPbTSP0m3qiItz9F+OgC5mhQFx7ZLxuG
         ug2qOGoKctjJhKIFQ2qvzjeMezvrJypjyIS2CX7eK2aUYMz3lCSGO2zCCf0YGU+9CGbm
         DpLLIljoR7AOlb8XF+RtVTXFF4SoAKq65NIS8o2ShqKeh4euJ9FARo6tahCBxjd7fO/i
         DSvVzXmCrIa6zdfodo0IkG/hq7vxi7rbsTsrMk9ZdGjSj5u6BGFLCQhOdf0UpE5Ll+2F
         /sxQ==
X-Gm-Message-State: AOAM532fDyAySM60m0BC2XWIkRpa1IjvsQyFWSxHYyeCgY/xtZJad1WT
        dxkKjytS8cXyZ8rDO8cEgRJH9w==
X-Google-Smtp-Source: ABdhPJxT8On0SWhKGAoGIe5DzysBx7AfisdCp9fXXKkofwXN9itzJTqOxW5g7eMb1wzH20bFKNWkNg==
X-Received: by 2002:a37:4dce:: with SMTP id a197mr12068637qkb.272.1611774007134;
        Wed, 27 Jan 2021 11:00:07 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c1sm1797399qke.2.2021.01.27.11.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 11:00:06 -0800 (PST)
Subject: Re: [PATCH v14 22/42] btrfs: split ordered extent when bio is sent
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        kernel test robot <lkp@intel.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
 <4293f37cdedd93b58df550eb0cdbea44e05e1280.1611627788.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <42bd1b1a-99db-630a-e28c-3dc06af6134d@toxicpanda.com>
Date:   Wed, 27 Jan 2021 14:00:05 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <4293f37cdedd93b58df550eb0cdbea44e05e1280.1611627788.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/25/21 9:25 PM, Naohiro Aota wrote:
> For a zone append write, the device decides the location the data is
> written to. Therefore we cannot ensure that two bios are written
> consecutively on the device. In order to ensure that a ordered extent maps
> to a contiguous region on disk, we need to maintain a "one bio == one
> ordered extent" rule.
> 
> This commit implements the splitting of an ordered extent and extent map
> on bio submission to adhere to the rule.
> 
> [testbot] made extract_ordered_extent static
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
