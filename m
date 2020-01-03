Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6416112FA76
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 17:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgACQbI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jan 2020 11:31:08 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44177 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbgACQbI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jan 2020 11:31:08 -0500
Received: by mail-qk1-f196.google.com with SMTP id w127so34153850qkb.11
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Jan 2020 08:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=YD9ME5827v5UgHSNot2XzXkpRRnvrzjMHvHH0eVazvU=;
        b=hsPe1J/IWmqz2KBYEO8dIATi7wTCCZb5SFSjGGG7lgg49VXhX4s+bqjnnBdSpMLqQc
         rSDJDK2r8NbvMxeWqSK8q8w2chCnMsHrVbI2X4BuH0ZDBD0LBIsZUrVbmefWMQpu85Lx
         IKJeyCnkI4bVvAgY6KfLmh2+1hHluX3IukbZb/O5Io09eH/hpZWbTW1652FYzO9JjkEB
         hhl8fpMD8P1myf9Fv6Hjm12Rmmeq069hbPK3oOvhT6Wosufjn9ddw1QW2s6GKRYzCkZe
         eEFQSeGurxpIWqO4Xnbj1AQkCwFoTk29psycT+j/h5NRTjFGIB6A0Fl+h9Ks/rkBxlEj
         LbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YD9ME5827v5UgHSNot2XzXkpRRnvrzjMHvHH0eVazvU=;
        b=PBCWu3OgINyev/WfFBNZL49zB6W9kBjefu72zzKUdWLQoO7/rJEGCUBGvoYU3v/Bmq
         5sgwOigS7qiqPuvaZcQP0acFHSaOz7Uad2+tmJJA9XyPORq2AYE5VbuqVvbhL/W2gAd0
         dxza1+gi6fW1nEOR3SKqp7XDsFO2sAyPwVlL/7jCt2QidqS5pN598pA5LoQ5Kzua8lDZ
         cMXxQ5i8oOc/WzIP+wat7VLU+4ub1jcRwZwNgn564vO7hskLNcspO5WxZSzyWOWHIfPq
         Gvx6K1dTAEYLIPcT6EtJKqYbFCmeQRWnakhN6qMpIkRyQrOuLEfdu9vJzBp+jUJUyTr9
         KZ/g==
X-Gm-Message-State: APjAAAWIo0Iw2rU5V+/pRVQd2gNd6jeGam4/e+BQ5JcS7AMmqmToUAm5
        RNwjFjtydZfuvhvpi+iDJHy16jdpkJbDEw==
X-Google-Smtp-Source: APXvYqzexFSh6Nfx6+fB/yW8yVcTDOR88o/vaAs/p8wo3ryk4xWwBdD8UUwhNT3fjjqMywD1oZF/ig==
X-Received: by 2002:a05:620a:12ae:: with SMTP id x14mr74464033qki.5.1578069066490;
        Fri, 03 Jan 2020 08:31:06 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s20sm16629961qkj.100.2020.01.03.08.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2020 08:31:05 -0800 (PST)
Subject: Re: [PATCH] btrfs: add extra ending condition for indirect data
 backref resolution
To:     ethanwu <ethanwu@synology.com>, linux-btrfs@vger.kernel.org
References: <1578044681-25562-1-git-send-email-ethanwu@synology.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <017fb679-ca13-f38e-e67b-6f1d42c1fbbd@toxicpanda.com>
Date:   Fri, 3 Jan 2020 11:31:04 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1578044681-25562-1-git-send-email-ethanwu@synology.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/3/20 4:44 AM, ethanwu wrote:
> Btrfs has two types of data backref.
> For BTRFS_EXTENT_DATA_REF_KEY type of backref, we don't have the
> exact block number. Therefore, we need to call resolve_indirect_refs
> which uses btrfs_search_slot to locate the leaf block. After that,
> we need to walk through the leafs to search for the EXTENT_DATA items
> that have disk bytenr matching the extent item(add_all_parents).
> 
> The only conditions we'll stop searching are
> 1. We find different object id or type is not EXTENT_DATA
> 2. We've already got all the refs we want(total_refs)
> 
> Take the following EXTENT_ITEM as example:
> item 11 key (40831553536 EXTENT_ITEM 4194304) itemoff 15460 itemsize 95
>      extent refs 24 gen 7302 flags DATA
>      extent data backref root 257 objectid 260 offset 65536 count 5 #backref entry 1
>      extent data backref root 258 objectid 265 offset 0 count 9 #backref entry 2
>      shared data backref parent 394985472 count 10 #backref entry 3
> 
> If we want to search for backref entry 1, total_refs here would be 24 rather
> than its count 5.
> 
> The reason to use 24 is because some EXTENT_DATA in backref entry 3 block
> 394985472 also points to EXTENT_ITEM 40831553536, if this block also belongs to
> root 257 and lies between these 5 items of backref entry 1,
> and we use total_refs = 5, we'll end up missing some refs from backref
> entry 1.
> 

This seems like the crux of the problem here.  The backref stuff is just blindly 
looking for counts, without keeping track of which counts matter.  So for full 
refs we should only be looking down paths where generation > the snapshot 
generation.  And then for the shared refs it should be anything that comes from 
that shared block.  That would be the proper way to fix the problem, not put 
some arbitrary limit on how far into the inode we can search.

That's not to say what you are doing here is wrong, we really won't have 
anything past the given extent size so we can definitely break out earlier.  But 
what I worry about is say 394985472 _was_ in between the leaves while searching 
down for backref entry #1, we'd end up with duplicate entries and not catch some 
of the other entries.  This feels like we need to fix the backref logic to know 
if it's looking for direct refs, and thus only go down paths with generation > 
snapshot generation, or shared refs and thus only count things that directly 
point to the parent block.  Thanks,

Josef
