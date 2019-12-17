Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C20E712357D
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 20:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfLQTTQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 14:19:16 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41083 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfLQTTQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 14:19:16 -0500
Received: by mail-qt1-f195.google.com with SMTP id k40so3686719qtk.8
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 11:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ODmK9wo9VaNV4g8hEuC0K1L+W5TivQmVB3AbYOv+BI8=;
        b=z1CfHuj6B986ZD1ZGs0Q8OzQROds2VhFzGyYI3bcEV+9YHG1ygRN654/emI0AC2SHY
         XYtrCvM4xLHHU/eX+yxHMfruEmTBkYdz9oXHl3D+t2IWVTr1G36GToMZU+Oe/MPmp8+p
         +OeSGEBjgP66QCgMeMTHsS9pbBMz4cjIQYI2rPXGS9TQuubv6L1yv88i/1+TsyX5YBwa
         clK57Q3Xhvdul1HZUFeWdF02QDb7zrtNuD8lJkiDrQIPeyWKqzbk4siXnpl03BQU4x8M
         QeFXvYYkGOBKcgoMoxENWfFc204EFp1a9Hz4MxtgdkOtItM+SYlMyIHpKymVDJGuJXBd
         yypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ODmK9wo9VaNV4g8hEuC0K1L+W5TivQmVB3AbYOv+BI8=;
        b=mDHjs6l3sUBhPP1R/nk7yULmMD7CX9abtgzCa9ThAVu4QnIp2Z3mndeSwlVt/BiC0c
         tIftjEugYgt6OjmvoQzy9sBm5aPf+l1U0ipNw3WF8dioOB7CNn1dAZ3MRKegtzKHQApJ
         79rat+1zBivisCN4uHegvmHPD89i7znpbE1Rr7J4ZKiczbIgQzXqnIfFV6WG7a8TUx8K
         /NHbqIYG/l6fdCQaLFGyHxti6ABtNurd1CKnWut7035ivcth1DUZujjjCUxm6mZRqQQ2
         rN+VRJeEe/ZB5iB7MrFnXoEV1y2lcGWW0h9yC1qgvKliV0Kjc5hsMyS59F/EC5SeE1+w
         8BvQ==
X-Gm-Message-State: APjAAAUlxsNpjLf4tTh0R1MjvDCC4cpQAQu8Or0MilUu3iviGI/5g2Yr
        qLxmuTRyNVs/z0IAb/GzbsutSQ==
X-Google-Smtp-Source: APXvYqySbjoifYUQPBeJTdNUUbDi/Y0gvFQjT0LDOemy+yTrBVB4moo6B8U+B9SBb7I3KRo0M15sBA==
X-Received: by 2002:ac8:5448:: with SMTP id d8mr5816750qtq.205.1576610355524;
        Tue, 17 Dec 2019 11:19:15 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4217])
        by smtp.gmail.com with ESMTPSA id c20sm8713347qtc.13.2019.12.17.11.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 11:19:14 -0800 (PST)
Subject: Re: [PATCH v6 10/28] btrfs: do sequential extent allocation in
 HMZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-11-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8fb85e67-d1ed-b31a-a6b7-25c52e48626b@toxicpanda.com>
Date:   Tue, 17 Dec 2019 14:19:13 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213040915.3502922-11-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/12/19 11:08 PM, Naohiro Aota wrote:
> On HMZONED drives, writes must always be sequential and directed at a block
> group zone write pointer position. Thus, block allocation in a block group
> must also be done sequentially using an allocation pointer equal to the
> block group zone write pointer plus the number of blocks allocated but not
> yet written.
> 
> Sequential allocation function find_free_extent_zoned() bypass the checks
> in find_free_extent() and increase the reserved byte counter by itself. It
> is impossible to revert once allocated region in the sequential allocation,
> since it might race with other allocations and leave an allocation hole,
> which breaks the sequential write rule.
> 
> Furthermore, this commit introduce two new variable to struct
> btrfs_block_group. "wp_broken" indicate that write pointer is broken (e.g.
> not synced on a RAID1 block group) and mark that block group read only.
> "zone_unusable" keeps track of the size of once allocated then freed region
> in a block group. Such region is never usable until resetting underlying
> zones.
> 
> This commit also introduce "bytes_zone_unusable" to track such unusable
> bytes in a space_info. Pinned bytes are always reclaimed to
> "bytes_zone_unusable". They are not usable until resetting them first.
> 

Please separate this out into it's own patch, these things are a bear as it is 
to review, it doesn't help that I need to keep track of two different things per 
patch.  Thanks,

Josef
