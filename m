Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFE32D976E
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Dec 2020 12:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437701AbgLNLer (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Dec 2020 06:34:47 -0500
Received: from mout.gmx.net ([212.227.17.21]:37197 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407709AbgLNLej (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Dec 2020 06:34:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607945580;
        bh=BfeUEOYLtgIIIlCsV61l2NMeXuXfSo7yBUHurRBiBWo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=lMpgYwhV5mmmtkDpulUsKrv8dAs/bQ6urWkooNtPGF1tJiFt85IAsTUZjQHgGW4OQ
         /grw4BennEkpiFiM+8P+FW4IV4p5mdKy/XIhTKfxxLyHYdiFrlHvVssog0vryUhVbV
         JteGW14ekT3rEYLK2+r8eMgKdiVHitPubnVhZwnE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8ykg-1kijxU3yHW-0068nu; Mon, 14
 Dec 2020 12:33:00 +0100
Subject: Re: [PATCH v2 15/18] btrfs: disk-io: introduce subpage metadata
 validation check
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201210063905.75727-1-wqu@suse.com>
 <20201210063905.75727-16-wqu@suse.com>
 <a0ff059f-b1d1-29fa-6d0d-2d37a5c5a5e3@suse.com>
 <0741b6ef-106e-8a12-b6c4-267a3ee57b67@gmx.com>
 <f57e6204-2a8f-611f-346b-6814916b95b4@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <f63aeb1c-30ca-2ef4-0795-d2eb15d6e085@gmx.com>
Date:   Mon, 14 Dec 2020 19:32:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <f57e6204-2a8f-611f-346b-6814916b95b4@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KuWbErl/hy9ctWoxMwCTWPc6HLNd4oJ25yaHBj0f5ppAqp2x7nE
 dF2w7GiiUj7d1rhsQhDtGLhhiyYcolQfAXYIhHscgpOQ0qx4xtFNhT3nHW/B3SdakFZezEL
 UZy8y5PvLL8YKS/WDoUli3f2ydXyN63V4j5O1XvVFrv4wxlpF1i63iqgo+XWcvEy48QUAhq
 JayUFyxHjMpwiSIJcToFw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VzbRQ1Lkmjw=:UP2qVgJSt9G8qJ/FYHumyf
 clcifBKkru4kVkACbopPhmpbIoSaMdaGPQMOpH3OqiXS9IftFi7ysHFT3NAizjvlsOmgtp/q2
 to69gnVH6SZ+DbgvGubvmRmf1oJIoVgM81Vz93jtY0HrMxurYcEd8El9zViWul6sX0z6qTtQv
 VVKmgrCznCadvozIcgRDSTXhf5FBfNkyjCa/dr3UTW5YCcW/EX9SCZ4XxzPcS+9hJ1z+OCTiD
 4MepS7GQs4kDgBkUtJKPNfmFGLmSAXgAMgPrq/5MWanIrVBOpiBFEvryd6WAsMVM44ilZydFV
 QXBHLZN9RkT07DJvcKOiNUdDy/414LYl2dx/mO49brph1Bjb8Bmudj10zQoYhwTPW/BdmvUhx
 CYTFaidmyxYwHC/cf1Dkr9nHLm7Ql75CmoPSoYJYZuyUGpJ/pBj0QhwbHS2091DIm60QGqd6g
 eb0osNaCDZkWzGKcT3efRjx6J7dMGRUVIE3ziQeAFJDNug17GNQ21CQDfZp9GJtbp7QvIz17U
 PKDmM673HmoyqwMo0AjaerXgInxC9mFXVBYpE8fHkEtzIcjOpr/iUQZl9q0OTari1aiHCvRqt
 sd3jUPJJXVAQODNoPOVMVnAZxLvRClxT4bJNkzBSBgOKIwFgSU3G8Jef8FkQfz2LLdzrNWEHC
 8l6Ik08q1PGEBXb5SECrVlthovVVNV2STOL/nblha4hF0aOeY4sxkEsOwzH4NwApcVMq/PqTA
 RVTgdSmxw8WmPZwv5BqkhnjMKSBd6f6sBggT9HrF3PWwY42OaRrNWsdR/9SnGQxYrBXc/QEO+
 k50/YoF4oCHAPfIAp9K9Bq+D/Sb5AqtJOEREhLboRQDRiGT8fXFfQxZ31vXaRSnTXv1AIMk3m
 1KwVeKbA5FzntTWJtvkA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/12/14 =E4=B8=8B=E5=8D=887:17, Nikolay Borisov wrote:
>
>
> On 14.12.20 =D0=B3. 12:50 =D1=87., Qu Wenruo wrote:
>>
>> IIRC ASSERT() won't execute whatever in it for non debug build.
>> Thus ASSERT(atomic_*) would cause non-debug kernel not to decrease the
>> io_pages and hangs the system.
>
> Nope:
>
>    3362 #ifdef CONFIG_BTRFS_ASSERT
>       1 __cold __noreturn
>       2 static inline void assertfail(const char *expr, const char *file=
, int line)
>       3 {
>       4         pr_err("assertion failed: %s, in %s:%d\n", expr, file, l=
ine);
>       5         BUG();
>       6 }
>       7
>       8 #define ASSERT(expr)                                            =
\
>       9         (likely(expr) ? (void)0 : assertfail(#expr, __FILE__, __=
LINE__))
>      10
>      11 #else
>      12 static inline void assertfail(const char *expr, const char* file=
, int line) { }
>      13 #define ASSERT(expr)    (void)(expr)               <-- expressio=
n is evaluated.
>      14 #endif
>
Wow, that's too tricky and maybe that's the reason why Josef is
complaining about the ASSERT()s slows down the system.

In fact, from the assert(3) man page, we're doing things differently
than user space at least:

   If the macro NDEBUG is defined at the moment <assert.h> was last
   included, the macro assert() generates no code, and hence does nothing
   at all.

So I'm confused, what's the proper way to do ASSERT()?

Thanks,
Qu
