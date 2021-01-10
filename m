Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3BD62F0995
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Jan 2021 20:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbhAJT4X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Jan 2021 14:56:23 -0500
Received: from smtp-33.italiaonline.it ([213.209.10.33]:38307 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726267AbhAJT4W (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Jan 2021 14:56:22 -0500
Received: from venice.bhome ([94.37.172.193])
        by smtp-33.iol.local with ESMTPA
        id ygoKkXNUE11DDygoKkmGTR; Sun, 10 Jan 2021 20:55:39 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1610308539; bh=7uezALET3L5FRHI5fim5Cq2+sW4b5wiNJqWYXou5HQw=;
        h=From;
        b=XXSTczz/KKNgv5WMQLin27cUtn+P8bjvt9qwWEtVqxsqZ87Wu0NEwjymcxmsGK2t1
         O4HCb4FopgDfTTnMh2xbp7lyu2oAdxmwnGgBzWaGg2SsghDLVOOrbvZ6R281ZF18Fy
         M9TPSlSKi5PhsvN5KigpJZsB3MICWAyczZUFlJ2lQyV9lKSnCpHmbEviKNSwADReTv
         dzX5bizF5IoqH3SU7YcTHGt+YBqMxuGSPGew3ZRTOVe1BcShQxBq42Ae5WQciITazG
         Wkzm/DepWsOYUfH0V75r3t0dF7GX63DsyhMVH07LJgkZj+SZt5oqcMl5kZhXI2RJJP
         yzoJkJF6lXX0Q==
X-CNFS-Analysis: v=2.4 cv=ba6u7MDB c=1 sm=1 tr=0 ts=5ffb5bbb cx=a_exe
 a=z1y4hvBwYU35dpVEhKc0WA==:117 a=z1y4hvBwYU35dpVEhKc0WA==:17
 a=IkcTkHD0fZMA:10 a=uF-7IkXcZ87nL_LRmAkA:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [RFC][PATCH V4] btrfs: preferred_metadata: preferred device for
 metadata
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org, Michael <mclaud@roznica.com.ua>,
        Hugo Mills <hugo@carfax.org.uk>,
        Martin Svec <martin.svec@zoner.cz>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Paul Jones <paul@pauljones.id.au>,
        Adam Borowski <kilobyte@angband.pl>
References: <20200528183451.16654-1-kreijack@libero.it>
 <20210108010511.GZ31381@hungrycats.org>
 <bc7d874f-3f8b-7eff-6d18-f9613e7c6972@libero.it>
 <20210109212332.GB31381@hungrycats.org>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <7a9baa1b-8426-751a-cd73-47ad246a946f@inwind.it>
Date:   Sun, 10 Jan 2021 20:55:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210109212332.GB31381@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfNPymNDcNc4QPNpoNu/uKw9R5/Ou5wttvmIRG4VYZ4EvefuieXeyYJx7DobIqQyY06UbmGJkod0rIZ4s9FnLVu9L5uQ6wTmWo4nB4WH9s74hqI1h8Ny3
 vlHoFpKnKo7U/xz2QVqcHHdYjW9A6Sbe1N3kz1wQwkcFQBp4wjww3LCSiVgPvenl+S1LYcYJ0iiFrgIUTWzfYViZS2trX1qK/Vo6QFp8FhN/bqmUMxXMRFM/
 1JkgfZxs3DctEuiyjG3AL3YUu41JOfjk6x4xhzDsg0efSryLxUin6oDcCrM5Kbl0pIIQ32iY2ce/X7KBpQHJU97VIWe5cgSHz1CuD5saL/WwzNjYHP2K5qZq
 78ICydB7b4cTr4at0gZECiA4dCbUFhVq8FX1XBuypLGJ0Pbl87756eFGNa8ZzP1nO6RWexwCl8v4pH5gkKi55f201M4m8A==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/9/21 10:23 PM, Zygo Blaxell wrote:

> On a loaded test server, I observed 90th percentile fsync times
> drop from 7 seconds without preferred_metadata to 0.7 seconds with
> preferred_metadata when all the metadata is on the SSDs.  If some metadata
> ever lands on a spinner, we go back to almost 7 seconds latency again
> (it sometimes only gets up to 5 or 6 seconds, but it's still very bad).
> We lost our performance gain, so our test resulted in failure.

Wow, this is a very interesting information: an use case where there is a
10x increase of speed !

Could you share more detail about this server. With more data that supporting
this patch, we can convince David to include it.

[...]
> 
> We could handle all these use cases with two bits:
> 
> 	bit 0:  0 = prefer data, 1 = prefer metadata
> 	bit 1:  0 = allow other types, 1 = exclude other types
> 
> which gives 4 encoded values:
> 
> 	0 = prefer data, allow metadata (default)
> 	1 = prefer metadata, allow data (same as v4 patch)
> 	2 = prefer data, disallow metadata
> 	3 = prefer metadata, disallow data

What you are suggesting allows the maximum flexibility. However I still
fear that we are mixing two discussions that are unrelated except that
the solution *may* be the same:

1) the first discussion is related to the increasing of performance
because we put the metadata in the faster disks and the data in
the slower one.

2) the second discussion is how avoid that the chunk data consumes space of
the metadata.

Regarding 2), I think that a more generic approach is something like:
- don't allocate *data* chunk if the chunk free space is less than <X>
Where <X> is the maximum size of a metadata chunk (IIRC 1GB ?), eventually
multiplied by 2x or 3x.
Instead the metadata allocation policy is still constrained only to have
enough space. As further step (to allow a metadata balance command to success), we
could constraint the metadata allocation policy to allocate up to the half of the
available space ( or 1 GB, whichever is smaller)

Regarding 1) I prefer to leave the patch as simple as possible to increase
the likelihood of an inclusion. Eventually we can put further constraint after.

Anyway I am rebasing the patch to the latest kernel. Let me to check how complex
could be implement you algorithm (the two bits one).

BR
G.Baroncelli

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
