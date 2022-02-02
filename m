Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1444A6D34
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Feb 2022 09:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245155AbiBBIqt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Feb 2022 03:46:49 -0500
Received: from mout.gmx.net ([212.227.17.20]:34183 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239242AbiBBIqt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Feb 2022 03:46:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643791606;
        bh=hg/Ci5eyqz24rfvcwWvY/bNMwHdZN0MQY8sYoL+kO94=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=RSVkPpfBk/MboolgYogSOX8AtJk9hfcPBpaHeVy5aFkTUHLgy3rm87FhPo6mANn+m
         Cz3NTdfetYtz9+KfQkryCZmeQTj6EVJyhiAckckMuJsgGf5G03LvU5kS2vnoBWXKNI
         XmmkvZrDqSUzgczp+gv31NyIYmutkW456NGv8vOo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvbG2-1mP04Z1nT4-00sg5z; Wed, 02
 Feb 2022 09:46:46 +0100
Message-ID: <b8e7550b-75df-94e0-8af0-1b86ca5b1749@gmx.com>
Date:   Wed, 2 Feb 2022 16:46:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] btrfs: add test case to verify that btrfs won't waste
 IO/CPU to defrag compressed extents already at their max size
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20220127055306.30252-1-wqu@suse.com>
 <20220201151439.GR14046@twin.jikos.cz>
 <9d3b5405-2d76-dd2e-1b1b-a404d3cb4db1@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <9d3b5405-2d76-dd2e-1b1b-a404d3cb4db1@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8o0BdUPbgsAgShR1rM+0QiaHyXzEuqbaLpUgVg0FcfyYpS2kxSi
 bdWuGNSsGGhXU4yVUX79wh9Ao7pfBYihkwJaEzgOoQX1ii5lcKERW7E9dd9xdB/w3XRr7Ps
 9pYh/6U8qnCvLAidtUOT2+YCEN+kUci2zBKCeQroNrqGV/hVQulD/KgCqQiKLrHXQFBCSc8
 e1cu8vVQ8UzxEnmAfDVsw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BPahAysbkOU=:FBK+DHMsH1DGUBwbboyhLS
 lfYFhdKpwgLi9yPayIubcf5tokI3sluTyQT6mDVA+RiNh34FX/mv4lpoGmrV26CnG3lU5NkDy
 V/+4Zix1nmRrkl3AVv2cO2ChGgJtCTCYGnuk17LRkzsnVzy83njt8d3aeaaXbuaQdS/tp5b0+
 Qg0Nkc6n4ia0TuyF42yJGoWkLCvyClwU8uRyNbvTIy5NlnSP7eFLgS3t4hqEhv9VvgYDSTNiM
 B8HHC1kNAliMiygHUGbqSk4Iiu51ds1djJ/9MrOuPTKWILQvr71zfDQgjHKoNagxjtTAXQ2QX
 U7FbA4QEYPRTPQkGPpEw9OKa1YLkzxM1BAkiqD8Rxhivyq/7f+hh0+r11zDw20VTFCZ8eZ75f
 Ho/Qk1DaV719QoIq8HzG57icNy7wR0V4JFY77QhZCK/28Ag/fs0Qq4koJjQ/yfXlfEnmB2VSt
 8A6rLFSr2oMpHZ38vtFjIIADqE8SnBtDa4a/8Kv7DwaqLDJliPc6ZNWcO/EWKsW7jnSeikZW8
 s1OojkbX+tn7unvnQI2JKUBZMLuyd0t5lwGaH3sCKR5Orzu8zzyn4lb6jC7Pgfq3JKxx5nu0O
 Fnel+YbQVR8+L4OPAaNiDhw57KPraB+dfsVhzfmMmuYxEsWkBIGKujxQNje0JkQgGDJMP0Qj1
 Dj3MbVzLbAlZo7W1O4M8mRa0Nq5H7/jPGPAckjIHHHQV3OOmqUHL7Y0pZ2m7+Ec9z+eqyqbSB
 oolxT5xzrW9mi5UX/s1nSN/rRC8hTv6GvQHNelRQt4l+ud9ZfiNHp+9Q7TGG8hSPBq6r7ua41
 aXE3IqAbSvEbu2NW5tj7hMWq+0WZj5mO39CORaMzIfdezv1ycEGoNT0nwqIW9Mm/fGYvaixny
 3/bDWmLadZ0PiP5fXaC0Eg8tiwn1PiMdDNHK+6xRmyfug7Nri2qT76hb8o5LsGq8AXAOEe46A
 jBwPvqMfe09YxIdx8dO4whym+J43rs/wITtQI2DBoyXGcpYJhCvGR3SpazLkzAnfizKoyxvaZ
 UUBjla7cNGVfjtXo+3okCpfei9l30Sr6Y2PAaE44cxnX9wDYT/+XPJdcK5n2fh/N8ObwOZiZB
 DW+tOEXY7mSDP8=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/2 08:07, Qu Wenruo wrote:
>
>
> On 2022/2/1 23:14, David Sterba wrote:
>> On Thu, Jan 27, 2022 at 01:53:06PM +0800, Qu Wenruo wrote:
>>> There is a long existing bug in btrfs defrag code that it will always
>>> try to defrag compressed extents, even they are already at max capacit=
y.
>>
>> As commended under the patch, this not considered a bug, because the
>> defrag ioctl is expected to reshuffle the extents, with or without
>> compression and improving the compression ratio if asked to recompress
>> with hither level. What is not perfect is the kernel side that could tr=
y
>> harder to merge extents into bigger contiguous chunks, but as long as
>> the compression is involved it's not possible to decide if the extents
>> should be skipped or not.
>
> What I can do is to add extra test to make sure if "btrfs fi defrag -c"
> always defrag the file no matter whatever.
>
> To me, these two factors don't conflict with each other at all.

Here comes the new test to make sure "btrfs fi defrag -c" can do what it
should do:
https://patchwork.kernel.org/project/linux-btrfs/patch/20220202083158.6826=
2-1-wqu@suse.com/

And of course, current (with the max capacity check) kernel can pass
both tests without problem, proving those two aspects are not in
conflict at all.

Thanks,
Qu

>
> Thanks,
> Qu
