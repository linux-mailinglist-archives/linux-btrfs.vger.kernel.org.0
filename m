Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 635DC12BAA5
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Dec 2019 19:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfL0ScF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Dec 2019 13:32:05 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:38642 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfL0ScF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Dec 2019 13:32:05 -0500
Received: by mail-qv1-f67.google.com with SMTP id t6so10327095qvs.5
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Dec 2019 10:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=7nDD6vWTQqkhi2zyDg/pl8amoziOxMKx4D4ZO5pTnt4=;
        b=gfCBFsa3bMEqf/SF+womEmS3w893OCJy7r/eadal23ZkXQpa3VCGNOKAfyt2pi4JtJ
         gzQnhGnCl3DYXrkrY32xDmBoASiI0P97AN/w9EEQs0v/WOBZpOgYsPgcwB2cOR/viPBp
         xDw/5vwuhvf4p9AMLJLvSj8qFoiqHan4QlKV2+O8myRekgSkvWsN08o1g9loL0jUQ81H
         ChbplFOqZY7/sdqAQmXfZYwwbpRAr5pGWCZvsxnZZobwd1lSmIUyle08rmiRkhoeVR2S
         lfFjy88XVFIAR5jyYVFMfE5JGNi98Rv2qXN0OmFBPtYsaLDuGAEQ+JnNRBrXmCMvlf4s
         1jXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7nDD6vWTQqkhi2zyDg/pl8amoziOxMKx4D4ZO5pTnt4=;
        b=mDY9Y2d/rVRanno2w2vKuReYYfHUUzgrIuFpsU7Q55zpLZ8Cmu6ca+1tc6ORZmGafd
         BzuI7Qd3e0Oxt8zxMiBNGpfT9B+IlC1tEdzRaxMg6q+7kR+TcB74gpMg9oWK2B7efr/d
         cbmwnH5khK2CswZM+b++hDjBTyyRRhxb6mJyYG68YbqOYDiJ2rXOw7SiGgJvOQSQp1HM
         atY6Z1UKQfoVNMK9+Iuqzem7CiOPwimOHWIhYV92YtsF04kXDYK051aPfRej9TtzZq3W
         /PJF0Tn+qtJilDK/Ww4KexoytuxZN3ZzC4USRc/6eBtGW8SBpbeW14F0Y2QP17MiRCAB
         gbCg==
X-Gm-Message-State: APjAAAVpQHKO9BXWP6OjzLAKtIv3DUqZinl0ycAL0Qo7wJXe36egHS6V
        TTkUkks82OMsyc1RVFkv+T1RG8Bdo9btbw==
X-Google-Smtp-Source: APXvYqwPVSu9AlB+HbeCF3FGi9VFW9wn2u8IO15wc6MtPhxlkXfkJMsvVJiffy/L1LaeNetkq9S35Q==
X-Received: by 2002:a0c:9c86:: with SMTP id i6mr41422063qvf.214.1577471523948;
        Fri, 27 Dec 2019 10:32:03 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::1bd4])
        by smtp.gmail.com with ESMTPSA id v5sm10966475qtc.64.2019.12.27.10.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Dec 2019 10:32:03 -0800 (PST)
Subject: Re: [PATCH RFC 0/3] Introduce per-profile available space array to
 avoid over-confident can_overcommit()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20191225133938.115733-1-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <34e46810-085e-e79e-c0f3-e6310baa3216@toxicpanda.com>
Date:   Fri, 27 Dec 2019 13:32:02 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191225133938.115733-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/25/19 8:39 AM, Qu Wenruo wrote:
> There are several bug reports of ENOSPC error in
> btrfs_run_delalloc_range().
> 
> With some extra info from one reporter, it turns out that
> can_overcommit() is using a wrong way to calculate allocatable metadata
> space.
> 
> The most typical case would look like:
>    devid 1 unallocated:	1G
>    devid 2 unallocated:  10G
>    metadata profile:	RAID1
> 
> In above case, we can at most allocate 1G chunk for metadata, due to
> unbalanced disk free space.
> But current can_overcommit() uses factor based calculation, which never
> consider the disk free space balance.
> 
> 
> To address this problem, here comes the per-profile available space
> array, which gets updated every time a chunk get allocated/removed or a
> device get grown or shrunk.
> 
> This provides a quick way for hotter place like can_overcommit() to grab
> an estimation on how many bytes it can over-commit.
> 
> The per-profile available space calculation tries to keep the behavior
> of chunk allocator, thus it can handle uneven disks pretty well.
> 
> The RFC tag is here because I'm not yet confident enough about the
> implementation.
> I'm not sure this is the proper to go, or just a over-engineered mess.
> 

In general I like the approach, however re-doing the whole calculation once we 
add or remove a chunk seems like overkill.  Can we get away with just doing the 
big expensive calculation on mount, and then adjust available up and down as we 
add and remove chunks?  We know the chunk allocator is not going to allow us to 
allocate more chunks than our smallest device, so we can be sure we're never 
going to go negative, and removing chunks is easy again because of the same reason.

Other than that the approach seems sound to me.  Thanks,

Josef
