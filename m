Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDDFC12D0A5
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 15:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfL3O3d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Dec 2019 09:29:33 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33545 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfL3O3d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Dec 2019 09:29:33 -0500
Received: by mail-qt1-f194.google.com with SMTP id d5so29743949qto.0
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Dec 2019 06:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=AAESzjTxkl8TYclrmUdscL2v26MV+x0FzdfVM/TVmXM=;
        b=JW/xR/QW/StqOu4/sZXlnQSQdXnWudOKS+DnH4DMKdem+/lDPn5iEezeHQNEsigLH/
         Pe0ky2WO/rvkHCMaJmY5NxY/bdSy3BaH9PYc8K0DwPHQeYZxB3XR3k5zn92yKyuoP7Xz
         Q93SisF/PJwNKC0fLTdwukhfh2qI8iJgSsPx8wx0yb3ovygPp1UYMmg0OtW0sdxeQKv2
         nUq4Qr9Sg1D9T7Ba+1sp7hJlNeo+vce/PR7eHktdXcK0RUKw+bET2hMbTEfgbA/bgPVh
         aHoKHYFqrF9lrQ7BiPKGT/wzL6QOEqeWCiAakDDNdJ9wUzZ8eZBWH7K17whxw4+UqOVr
         7Kbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AAESzjTxkl8TYclrmUdscL2v26MV+x0FzdfVM/TVmXM=;
        b=Yw+inchTXt+vUHknidJN9OQkBlkeiFblGUiTAe6i8VAjMcHsQAkwdzl+hnrxP1dZGz
         h+BSv4k1p+NBBVKrVRQnyEdyM22VWimf1TaCVzqacdBS1yBLYUvCarAWh4vI1zuW0M+O
         yB9+OwcEU89tQAJgJYCdUx3Cd3rCcr2jagGuapug25zCInWEnzvLxploLVqVXJOtsEFt
         Ev4D2mL5DE9zQNXzxPlJnKDshyi4tCxZjmaFI8I2q87BN4AskyLvjqXIY+kl/1RZ8hmm
         xPHrOlQVeSRbnUlpZM7EBisdpSAQuDaYsprV6FsVOyfNvfJdLu648DCUaq67+eQfe6OZ
         UEjw==
X-Gm-Message-State: APjAAAWtbpmBNibuKznq+3xn/fuF4EVPK+uLQ95EeHyKYBu+3Q49UPsy
        46BLLm8XttEBz4z9q02FgMhj5hmyObwyUQ==
X-Google-Smtp-Source: APXvYqzbtqU6iTRN+zUtXT5wC19p6eCh1Dn5BwpCjClBEKijrlXBt61q8C/rQpEFBP+wNrkX/Avf8Q==
X-Received: by 2002:ac8:24c1:: with SMTP id t1mr48471570qtt.257.1577716172052;
        Mon, 30 Dec 2019 06:29:32 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::2e4b])
        by smtp.gmail.com with ESMTPSA id n129sm12533057qkf.64.2019.12.30.06.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2019 06:29:31 -0800 (PST)
Subject: Re: [PATCH RFC 0/3] Introduce per-profile available space array to
 avoid over-confident can_overcommit()
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191225133938.115733-1-wqu@suse.com>
 <34e46810-085e-e79e-c0f3-e6310baa3216@toxicpanda.com>
 <0a71a88b-9942-ca8e-5478-d6ea48356daf@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <6a67c32a-668e-675b-e317-62f1aaf27fcd@toxicpanda.com>
Date:   Mon, 30 Dec 2019 09:29:30 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <0a71a88b-9942-ca8e-5478-d6ea48356daf@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/27/19 8:09 PM, Qu Wenruo wrote:
> 
> 
> On 2019/12/28 上午2:32, Josef Bacik wrote:
>> On 12/25/19 8:39 AM, Qu Wenruo wrote:
>>> There are several bug reports of ENOSPC error in
>>> btrfs_run_delalloc_range().
>>>
>>> With some extra info from one reporter, it turns out that
>>> can_overcommit() is using a wrong way to calculate allocatable metadata
>>> space.
>>>
>>> The most typical case would look like:
>>>     devid 1 unallocated:    1G
>>>     devid 2 unallocated:  10G
>>>     metadata profile:    RAID1
>>>
>>> In above case, we can at most allocate 1G chunk for metadata, due to
>>> unbalanced disk free space.
>>> But current can_overcommit() uses factor based calculation, which never
>>> consider the disk free space balance.
>>>
>>>
>>> To address this problem, here comes the per-profile available space
>>> array, which gets updated every time a chunk get allocated/removed or a
>>> device get grown or shrunk.
>>>
>>> This provides a quick way for hotter place like can_overcommit() to grab
>>> an estimation on how many bytes it can over-commit.
>>>
>>> The per-profile available space calculation tries to keep the behavior
>>> of chunk allocator, thus it can handle uneven disks pretty well.
>>>
>>> The RFC tag is here because I'm not yet confident enough about the
>>> implementation.
>>> I'm not sure this is the proper to go, or just a over-engineered mess.
>>>
>>
>> In general I like the approach, however re-doing the whole calculation
>> once we add or remove a chunk seems like overkill.  Can we get away with
>> just doing the big expensive calculation on mount, and then adjust
>> available up and down as we add and remove chunks?
> 
> That looks good on a quick glance, but in practice it may not work as
> expected, mostly due to the small difference in sort.
> 
> Current chunk allocator works by sorting the max hole size as primary
> sort index, thus it may cause difference on some corner case.
> Without proper re-calculation, the difference may drift larger and larger.
> 
> Thus I prefer to be a little safer to do extra calculation each time
> chunk get allocated/remove.
> And that calculation is not that heavy, it just iterate the device lists
> several times, and all access are in-memory without sleep, it should be
> pretty fast.
> 

Ahh I hadn't thought of different hole sizes.  You're right that it shouldn't 
matter in practice, it's not like chunk allocation is a fast path.  This seems 
reasonable to me then, I'll go through the patches properly.  Thanks,

Josef
