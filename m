Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A4644623C
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 11:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbhKEKha (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 06:37:30 -0400
Received: from mout.gmx.net ([212.227.15.18]:39503 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233134AbhKEKh0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Nov 2021 06:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636108484;
        bh=xzgTpfyWJCKMoKofou8MLEybnext3YORW67LVndzEQ0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=R6d9jDtlZVHJ6ynX7YmdE+FiltWJ6jdPV4/YINrTxfh0vYMVr+RfIl9EboSOw6lfU
         QAhq2MtKpPhJc5kGRELdc36/7b16smFcNV5lpWkMuov4NeQ6Bsg3CSTe9uSWfKiFSS
         UStP4+MpqSHDCSvwl7uGXJ7fgkcHWn5glAJKTEOo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MfpSl-1mGDW6126b-00gKIF; Fri, 05
 Nov 2021 11:34:44 +0100
Message-ID: <0c3ce396-e1b8-d650-223a-e152bca25204@gmx.com>
Date:   Fri, 5 Nov 2021 18:34:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] fstests: btrfs: make nospace_cache related test cases to
 work with latest v2 cache
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20211104005553.14485-1-wqu@suse.com>
 <YYUGfguehWpzCE6d@localhost.localdomain>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YYUGfguehWpzCE6d@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aQuHL/Iwq7P7d7r6cYwyG5px2a8YKI31LLY/NQqwdo5ph0c/22h
 MBUjsnpY+R7oSpIgsPNcaSGu6yZ8fNMOlOAOx2TgfEVew77j8xCT4wgHmetfe64ua57S4eU
 R223Jq+/8RwPVDQ9eeTaNGbkNESpcm8QWbXM4q0Nq26U3YTr5Lm5oVcOPfboaBWwoBbDra1
 LRzpDQweYD+NNrQOmScjw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cc55I35jov8=:qnyKJbqFerjAikECFqdOHh
 cuakW4zHjD4oxgcgt+G/UU54dOMh70ee7fn0fpQgL0XFmfH0zhRP9saF4R4az06wht7dLpNUN
 VbnUtqt8JDQzNllfqvhMWtjdU/HdSmelnbetkcDggg/j4TxbE/2A2rnsKJgQx0LjkckeCYvel
 7fuHjEZ3enL20Th4F0cnQ//AS8o56eH9fasO6KYAhZoZb4VkCIzcvJC47E+pdQRici64wjnwq
 SkPSn4dy5DRqKT3IvTBpZABhYt494m9o8cdwbOVZkIHAZBLUv7xByn9ZSy2V/9o25glLojZLD
 pTio14cih35I6Ho+9hCVgJzLrCz7OTaBNevtterO97IbCsu5AOWCLMmhm4uT7uGWJzwyw2vpB
 DZtOzLvWCQu01AuhVxCYf4PK7l30ScLbKO5rwvA5xyGFCXHmqixAwk0xadxTd3S1D3iRoqvcW
 o1IN8orequXfg1L8nw7t6YehZPJ9WIOnq1lTcZnvcc9YAMS6lR2pxDmSAWYZzwfkcO6o2i+qG
 J5CbxZuX+AK63TX6aVeBjY+k5AN9yuGUlvZcG7B9cr5Pgrd0UmLDkFrmscTkzRT6TYG/DfuNC
 Raluauy0WRtkNjthl2AliGzL1M3Qtpq3uZrgEvjvkbK3cH7Oe1dbKWLKlRBYcAK4TRenxSoRR
 UBOh7PABfJ8QVYLj+Lf0OBKRy2piIwqUrl/aG4t5flVOhpniwTuOEf4rvOZsltlK6dpT8KHXi
 03cHrb0e5mIFa6M/4zmmpg+F7xLUcHE+esW7pJI3su1j2+d1dc+rdgtc1fAuKaZHPJsLsDjZE
 XDjErEuEVkttn/3zCdrn0viTi0Lw1TxOH17IO3NdHqATzHYtF2EI2klVbPI6RZ/1MY++HcKzZ
 8eZgexH/1TXmjWIg2LHusWkMP3tJHCwf2Lt6HqqQShrTurjcUKTjfUBmdJUUG3pDm8fxt81WE
 QERlgQSd/U+0RyeOgC45hCXi5k+sytgScwvFZhz1XqdcarHe9Dq28f5X5YYYfci7n7sNsU7wT
 hHgjb/XXJbJ343ZcEFPxFizP6/UaTwj7GESkgZjP/VhUTwHWRKMfjDnNeSIaMZGzN3ksopUYo
 AnQRr/541iu32Q=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/5 18:25, Josef Bacik wrote:
> On Thu, Nov 04, 2021 at 08:55:53AM +0800, Qu Wenruo wrote:
>> In the coming btrfs-progs v5.15 release, mkfs.btrfs will change to use
>> v2 cache by default.
>>
>> However nospace_cache mount option will not work with v2 cache, as it
>> will make v2 cache out of sync with on-disk used space.
>>
>> So mounting a btrfs with v2 cache using "nospace_cache" will make btrfs
>> to reject the mount.
>>
>> There are quite some test cases relying on nospace_cache to prevent v1
>> cache to take up data space.
>>
>> For that case, we can append "clear_cache" mount option to it, so that
>> btrfs knows we do not only want to prevent cache from being created, bu=
t
>> also want to clear any existing v2 cache.
>>
>> By this, we can keep those existing tests to do the same behavior for
>> both v1 and v2 cache.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> This will re-generate the free space tree needlessly, and in fact won't =
be
> allowed for extent-tree-v2, so we'll just have to mess with it again.  I=
nstead
> add a helper to get the options if they're needed, something like
>
> _btrfs_nocache_opt() {
> 	$BTRFS_UTIL_PROG inspect-internal $SCRATCH_DEV | grep FREE_SPACE_TREE
> 	if [ $? -eq 0 ]; then
> 		return "-o nospace_cache"
> 	fi
> 	return ""
> }

OK, this indeed sounds better.

Thanks,
Qu
>
> or something like that.  Thanks,
>
> Josef
>
