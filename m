Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826DA31F34A
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Feb 2021 01:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhBSAVP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Feb 2021 19:21:15 -0500
Received: from mout.gmx.net ([212.227.15.19]:43949 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229468AbhBSAVN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Feb 2021 19:21:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613693980;
        bh=BCEDHNyssoLjJ9PAp9YC5PKH44pf6vk6zFgTJFAdfwY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=i/mk9an/3Ww5ICN0BammIX+zdeUGTjzv7J+TMUYWcVXdetusmyKFCu5LzXehhWhZW
         4xfUCnLdg9MHa3c0dpB2lKV9N+GGn5hn0NSd6y2GQg1cXf+VymkiWr20cVl5n2Syqe
         L4U+G/Br7HnyfrAu2YK46b4qLyfD9m/8GZymJL3c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mq2nA-1lhKn33FMw-00nCKk; Fri, 19
 Feb 2021 01:19:40 +0100
Subject: Re: [PATCH] btrfs: make btrfs_dirty_inode() to always reserve
 metadata space
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210108053659.87728-1-wqu@suse.com>
 <fe04fa6f-57b9-546c-1715-ecc97e81fe14@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <9308da0b-a705-1ab4-d44d-2639a0ddb8e5@gmx.com>
Date:   Fri, 19 Feb 2021 08:19:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <fe04fa6f-57b9-546c-1715-ecc97e81fe14@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z4bBI4tgvKgmjQ/ANzI/TF3UHVtzcZhDD2516nNTVK38pvxElhs
 SGagMRJmRVErhA5TOmd6q5j3gO6m2mPMbEXaRJREXZ45KaTNZdLwXqdh8P147DCQReai37I
 DMKEAAPNfHkiFx3je0CB9QqPDC622cevpQXgkfn8amOnhzoegEfPwVxmX7Gkm/0l6hNd+7h
 TCppQsoD4uTP93YsUyXzg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wNDDrUabgSQ=:q1cRYcZzmPvKG+n4LVZ4V8
 ZbK7ztojqGl70dTrkJoWQubIbF4wkBL3var+oEnAtU5xNHer0phjQc8USdpJwsGWTLtedE4SN
 w785S/kV0nGzhCCgYFZluqS/b1/ta8ZHtKyW4gvCUYrmAZ0qDLCA8g2WUswE2E0McQdT/y0e1
 gJ1ctkVddYyrBwkASEWVzpEBeq1cUBu6Hh/BA6D8QK/9HBr6rxn7FjCA6U8eOxQV5dj9gdX5L
 KiKHXXWYeXx4loXF6i8wu/UN7HveYM3yftX3xInuzD5bp3vNgihCqSjmq2nCYrYhkonUFFooR
 nvH4Hzg9yNK8PNLgg1j0FLA4NMw7grIYpqa1u0KdaJh3CbhbsuTz8mZOzBLRaWE0wsxTMRBvC
 zyntiP2odkpPpWfUQZe4flUaI5Z1tooWDfnzinHpy6/L1glYjEZn5pe7v990RUUtK/MMyCB6w
 OFDu3FQ0TqqPfWUsgRiI2oGJP0LuzJnZ1GSosPpoxEbBhhKtEBcD8irzhVqvZT4JdpC+Mg2XI
 qRx0HnssCzP3pYMV9m7G6gwE4vrl1qHhrBYw2ZoW0jUDStICLup6NP5LbIRaF3cYjTSzxImAu
 /rJBzM266NNTn0K2mNY65EdodmDm3GLtiQvTEHZV0+kkFIn2cIJdziInW5bKsgdKO3mY2rucQ
 W7mFMckZ4+lMXktQlCiYF02X24n6CmduXeiq+xYwZz1d1K0tDFqzNUx/H9TLo57SwrAN+E3vJ
 Z26KjdkR7w/e5wUZcfNIOeaNmhqOkV/tUeHDDyZd147UaJxIP4oRWv6bqd/i19USByJ5HU5CV
 WEf41fsSacsdU6yAACcyNS2P+WmsAfqSMdqKhQ0bZF7hMjNCS5BiYicUyLQhOieCkpG1qTnS4
 m+5gOUT3J4uemEjXxkWQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/2/18 =E4=B8=8B=E5=8D=8811:28, Nikolay Borisov wrote:
>
>
> On 8.01.21 =D0=B3. 7:36 =D1=87., Qu Wenruo wrote:
>> There are several qgroup flush related bugs fixed recently, all of them
>> are caused by the fact that we can trigger qgroup metadata space
>> reservation holding a transaction handle.
>>
>> Thankfully the only situation to trigger above reservation is
>> btrfs_dirty_inode().
>>
>> Currently btrfs_dirty_inode() will try join transactio first, then
>> update the inode.
>> If btrfs_update_inode() fails with -ENOSPC, then it retry to start
>> transaction to reserve metadata space.
>>
>> This not only forces us to reserve metadata space with a transaction
>> handle hold, but can't handle other errors like -EDQUOT.
>>
>> This patch will make btrfs_dirty_inode() to call
>> btrfs_start_transaction() directly without first try joining then
>> starting, so that in try_flush_qgroup() we won't hold a trans handle.
>>
>> This will slow down btrfs_dirty_inode() but my fstests doesn't show too
>> much different for most test cases, thus it may be worthy to skip such
>> performance "optimization".
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
>
> Ok I actually run 2 tests against this patch. The first one is a 10
> second run of  stress-ng's utime test (stress-ng --temp-path
> /media/scratch --utime 4 -M -t 10 ; done) to see if I can reproduce
> intel's results and here's what I found:
>
>
> bogo ops/s real (Before-patch)	bogo ops/s real (After Patch)
> 	35993	                         32968
> 	35712	                         33146
> 	35369	                         32996
> 	35544	                         33159
> 	35623	                         33000
> 	35939	                         33016
> 	35693	                         32829
> 	35562	                         32685
> 	35675	                         32815
> Std dev	182.161981912585	146.829034703967
> HMean	35677.9600871036	32957.1111111111
> Diff%:		                -7.626
>
> So there's a 7.6% decrease in the rate of utime() calls we can make,
> given that we now start a transaction I'd say that's expected.
>
> The other test was a randwrite with fio as I was mostly worried that
> making btrfs_dirty_inode more expensive would hit write performance
> since file_update_times is called from the generic iter. But inspecting
> the code btrfs uses update_time_for_write which doesn't dirty the inode
> per-se as this is deferred to endio completion time.  I also measured
> the impact during buffered read time as file_accessed is called a lot of
> times but the following bpftrace script:
>
> BEGIN {@execs =3D 0; }
> kprobe:btrfs_dirty_inode
> {
> 	@test[kstack] =3D count();
> 	@execs++;
> }
>
> kprobe:touch_atime
> {
> 	@test[kstack] =3D count();
> }
> END{
> 	printf("Total btrfs_dirty_inode calls: %llu\n", @execs);
> }
>
>
> confirmed we only ever execute around 8 btrfs_dirty_inode out of 1048773
> execution of touch_atimes from generic_file_buffered_read with the
> following fio workload:
>
> fio --name=3Drandom-readers --thread --ioengine=3Dsync --iodepth=3D4
> --rw=3Drandread --bs=3D4k --direct=3D0 --size=3D1g --numjobs=3D4
> --directory=3D/media/scratch --filename_format=3DFioWorkloads.\$jobnum
> --new_group --group_reporting=3D1
>
>
> So performance-wise I'm inclined to give it a "pass".
>
Great. Mind me to add such info into the commit message and add you as sob=
?

Thanks,
Qu
