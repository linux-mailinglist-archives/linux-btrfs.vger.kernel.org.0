Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E89D4EABA2
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Mar 2022 12:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbiC2KvH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Mar 2022 06:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiC2KvD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Mar 2022 06:51:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B3513CDD
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Mar 2022 03:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648550954;
        bh=k+bDxaF0Rv5Am7Xd14stfzTdAeTs8WxMAfYA4y1YM9g=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=Qeld8/DxNl0wkiUboCFhBMUPVwUCXJ3Jh+mOoo9R0ys+2aX1oOllz71CJ1tI4/BAO
         lL1M/v0qfjg1/n/HkjJpaygHPrnJA3kNqQW/WM6eFJsSL0F4MvROaUJuhdd+Nasc4O
         Pr9j9Hfrj94Aom0xezMJKE0PnkQdQUQVmXzpncuY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MOzOw-1nPCjt3ZG8-00PP8s; Tue, 29
 Mar 2022 12:49:14 +0200
Message-ID: <ed81efec-0303-d152-a84d-74f4ff4f5058@gmx.com>
Date:   Tue, 29 Mar 2022 18:49:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] btrfs: replace a wrong memset() with memzero_page()
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org
References: <8d6f911a0282eba76f9e05d6f1e7c6f091d4870b.1648199349.git.wqu@suse.com>
 <20220328185121.GQ2237@twin.jikos.cz> <YkLYJ+xRvmm0yN9Y@debian9.Home>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YkLYJ+xRvmm0yN9Y@debian9.Home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aZ69dZ+u3fiVNmm2AnoHcMY8NhCe6PNQxaRKd/vKVuwwTMFjlef
 Qit3ZJIGvD59A0NjDMQRZ8HSS/ZDOaNHVEl2gdeeFHWNj+U2vVWS0pSu4ApyYLLMT091Nt6
 TOmtPWj/lLkV7c0gSD6m/40b+w/9ieQCrF6LadSLi83u68ljfNRpA9lpXnEHyg4/t/TOC8l
 cS5ZblGDovwqm5URABhag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lQj+anHFuUg=:j6AddLsxTfcjCS8R1hft+b
 QDqVZttddhd1cIqpmGkdLoO5RpRC/dfty/h+++d2A/9nbqgDmTbKkPNnilad65eNt4FvVFmDb
 r23n14xwCIAYVJCqdoMKA3xy6mr+yslUk2Fff/ncNI+ZKnLZvaR8AmpsdECZ0tiZNnh28kM36
 XQ5fs7kJrsJBIfBUHkoL6OhdWyLi7b0mc4ZhTZFrkVwMciLpA8mtux1qlctj5sPD+Npl2InHY
 Txs0CLUVKcYAhxphQjKJS+wWf+9WTQMxo6z5scOuPezLGQiKsHfw6dCeb/Nh6Bb2ajb3O/GSe
 1dJtmgzs/joiew5LvevVNECyf6jKVIDbj02WEPYKmfEsgecYRb2qCbfM6c7TY8mawn7YUD/KS
 0kUgc4nKxHxHWWkADYzWlA0HlbxZWEPqm0SPxt4ijwP5RLLxcu7/2+Uv+Tbax2h+7gNnYXGrm
 WfOl89bw+akm/UcVRsLnC04VpnNEsyvAKvucRLdOdXVRRg0pk2vFGx1Li36rh9s7P5i8zswMb
 hRz+F+rAiTwLl0CAtWUvYR+MTSO8XY/q4tTzy4cZg6vKblHANwHbDRejk+QrtOt4KVKqwlTqq
 Gos431WI+4v8MTEio0kk68Ebbf6Xuuw7mPCjAgSelzIuOfOBN48bnPgailgVMOez9KuV+4399
 sXYF3zfK13YqJYkWSv70wYj5wrkf9hfxdY0/dV+J2ruvU35YqCiDAmNEvP41zetLtxne0xOgZ
 k8xIXx5iwkOX0ZWfDfBJwavDXjP9QbfX4cOMdhjnC3GuW5katj4zPjrp10C5R7cvHxLtfhbv7
 h5InMq0bqGKAn2Vqtg0u19ge02ctTSvEN22TzcbeDs1Mf3a+pieLtsBEye+Ao1XRlHFKsIlVs
 E3IjRtM7wHB9PtnK3fXDfoBXBMesOCVSQ89x7m5EFpYUWacbV6bp2aWFHiP+pAiR9ZW6voUnN
 1tnoXwrfafIRjRTlXNKOZFhUGzanHOXGlGQrJvep5PeiMYeQ8Nn5Co9Ymh26n0Qv4ZiOETUXX
 zP8hkKZHuPf2+1Vivl2J0mw0t7eSXQXX9s4psT/NkvjqJZHHJCHxl5ieBR1TLdA4+ZqpNfnNb
 hjedFLsTiiCchY=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/29 17:57, Filipe Manana wrote:
> On Mon, Mar 28, 2022 at 08:51:21PM +0200, David Sterba wrote:
>> On Fri, Mar 25, 2022 at 05:37:59PM +0800, Qu Wenruo wrote:
>>> The original code is not really setting the memory to 0x00 but 0x01.
>>>
>>> To prevent such problem from happening, use memzero_page() instead.
>>
>> This should at least mention we think that setting it to 0 is right, as
>> you call it wrong but give no hint why it's thought to be wrong.
>
> My guess is that something different from zero makes it easier to spot
> the problem in user space, as 0 is not uncommon (holes, prealloced exten=
ts)
> and may get unnoticed by applications/users.

OK, that makes some sense.

But shouldn't user space tool get an -EIO directly?

As the corrupted range won't have PageUptodate set anyway.

Thanks,
Qu
>
> I don't see a good reason to change this behaviour. Maybe it's just the
> label name 'zeroit' that makes it confusing. >
>>
>>> Since we're here, also make @len const since it's just sectorsize.
>>
>> Please don't do that, adding const is fine when the line gets touched
>> but otherwise adding it to an unrelated fix is not what I want to
>> encourage.
>
