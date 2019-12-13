Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAA3711E810
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2019 17:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbfLMQVK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Dec 2019 11:21:10 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:37715 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728204AbfLMQVK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Dec 2019 11:21:10 -0500
Received: by mail-qv1-f65.google.com with SMTP id t7so1042395qve.4
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2019 08:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bwMfLBfUPnpy1+h0cP7CMdNrE/Vkj9pRhLZrgNJKj98=;
        b=CRFOKprqTIlntLWHItOjgLpGuDp1stoVtPddGs/TnSeJxSaAJ1qoudHPkeawuqTbB0
         qAkKbhivXKbXI9xE5RRKWNlblv3IWi0foaPvcXXf62GSeVh9qpgeO6kCpYZPNdnW92YU
         o2gFYukkGLx9rxrxneVvXy4CQynNApSuLNoZeN6DyrrDypM6zOVYwiSeFfwK6U8AP4qw
         2YxZG2pLqVKrRrCaB2CArHHPhEPpxWELG5ToYP6bueyb3ARdPPL8oq4u880toCIwlZNE
         lz8auKw6r20aZJfl/WsW7kmS87rcvmg+YaZM+CHSfRfabocEOKZteiBqkAPTRf3nXFho
         OTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bwMfLBfUPnpy1+h0cP7CMdNrE/Vkj9pRhLZrgNJKj98=;
        b=SUZBzYBckmP7pCrjmxxQjoVIkf2IcIVpAHvmqtv0+ybPY0OhG+EGaotYvNIKKCOYRx
         XgOMXb5PWWbvjxsZTxgH9Dz5ehcpXTokQlSVBkCLAG97KoChFkUHzXFWuBSTcCpX2Ggw
         5/XaiJr/M3eKmbcm8hLS3d/GPUgLwvK1kwTP02pV8oo81K/HqzHPpmIXLxjp+pQdKcHI
         XA+OW4YUQ51Zlw+SvNijMukG7ZkbIY5KZEwzu6S44uvl3qoifCNngGJRCW3qqVGjYU6l
         Vtt6Wja8DN2SOx77yYyqMM60GaqntSj2tKKkoIDxh/2fGqcIP3qT8Vn7BQiejmU7BHjU
         DDAw==
X-Gm-Message-State: APjAAAXpG2Qf9Ikr24bV+h0dh9OMq1imWEq6MBB3gd+bKO6Mfo9ECavY
        VQDggRSnQNh64ifh+dNEy8b77w==
X-Google-Smtp-Source: APXvYqw6GEsmdghhUmJo4cQtXmAUGBEfXKGURKddA+2KYuADWQwcBnSypLp1qEIjKUtcRF4OyhK8DA==
X-Received: by 2002:ad4:4908:: with SMTP id bh8mr14381079qvb.251.1576254069075;
        Fri, 13 Dec 2019 08:21:09 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4e65])
        by smtp.gmail.com with ESMTPSA id c37sm3568375qta.56.2019.12.13.08.21.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 08:21:08 -0800 (PST)
Subject: Re: [PATCH v6 03/28] btrfs: Check and enable HMZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-4-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a51f1292-3097-cd4b-bee5-dee5d4141ffb@toxicpanda.com>
Date:   Fri, 13 Dec 2019 11:21:07 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213040915.3502922-4-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/12/19 11:08 PM, Naohiro Aota wrote:
> HMZONED mode cannot be used together with the RAID5/6 profile for now.
> Introduce the function btrfs_check_hmzoned_mode() to check this. This
> function will also check if HMZONED flag is enabled on the file system and
> if the file system consists of zoned devices with equal zone size.
> 
> Additionally, as updates to the space cache are in-place, the space cache
> cannot be located over sequential zones and there is no guarantees that the
> device will have enough conventional zones to store this cache. Resolve
> this problem by completely disabling the space cache.  This does not
> introduce any problems in HMZONED mode: all the free space is located after
> the allocation pointer and no free space is located before the pointer.
> There is no need to have such cache.
> 
> For the same reason, NODATACOW is also disabled.
> 
> Also INODE_MAP_CACHE is also disabled to avoid preallocation in the
> INODE_MAP_CACHE inode.
> 
> In summary, HMZONED will disable:
> 
> | Disabled features | Reason                                              |
> |-------------------+-----------------------------------------------------|
> | RAID5/6           | 1) Non-full stripe write cause overwriting of       |
> |                   | parity block                                        |
> |                   | 2) Rebuilding on high capacity volume (usually with |
> |                   | SMR) can lead to higher failure rate                |
> |-------------------+-----------------------------------------------------|
> | space_cache (v1)  | In-place updating                                   |
> | NODATACOW         | In-place updating                                   |
> |-------------------+-----------------------------------------------------|
> | fallocate         | Reserved extent will be a write hole                |
> | INODE_MAP_CACHE   | Need pre-allocation. (and will be deprecated?)      |
> |-------------------+-----------------------------------------------------|
> | MIXED_BG          | Allocated metadata region will be write holes for   |
> |                   | data writes                                         |
> | async checksum    | Not to mix up bios by multiple workers              |
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

I assume the progs will be updated to account for these limitations as well?

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
