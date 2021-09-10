Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D43C406966
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Sep 2021 11:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbhIJKAW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Sep 2021 06:00:22 -0400
Received: from mout.gmx.net ([212.227.15.15]:34157 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231991AbhIJKAV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Sep 2021 06:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631267947;
        bh=O/DT+4MD/vz5gVOltZkBh7TG2JCkAwBwKd/tK5UdNwI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=CsO3Z187rBFX96O+wAylT006CcaocSUXsKKUDWJyjrVbTceXxGjeZqcWw4/mE/d8B
         5bmeZkkE9tF+CJb+Abuz0VdAlmJ9dbqXLnP2ZaFHltxJUtBTHjZt01lYruxT46svrz
         9k/vXfVJK/uL1eDfrUk+lxY/hkWAjLlqkMlOPzSE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MZkpR-1mTMFh2V0B-00WkNc; Fri, 10
 Sep 2021 11:59:07 +0200
Subject: Re: [PATCH 2/2] btrfs-progs: doc: add extra note on flipping
 read-only on received subvolumes
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210910060335.38617-1-wqu@suse.com>
 <20210910060335.38617-3-wqu@suse.com>
 <9ad982a7-2a40-5f52-1d88-cca79d9d411f@suse.com>
 <20210910094510.GB15306@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <7485b65e-84d0-31dd-3891-16363c8ea790@gmx.com>
Date:   Fri, 10 Sep 2021 17:59:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210910094510.GB15306@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3F5jCQXvEAPK/bojrV5siBzXn1QLXkSJXYVS3FJ7mnpaKKG9rQI
 35xGVDechlHS58IgnxmnnDYWAKPiiE+Q8TfguqqjCmLPLgnjb43fwacZEJGB5crRGjkhzlD
 P8yEDBC7yFqN4LovNtAfEpuX9HZGrKdUy9AZSqnstWXhrWNls+7Qb62ulHbgVNx53LoIqSV
 vLi/LM5Ra1Y6s9A6FY4zg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xnrC0d80jJo=:yYLE4MkQ9Zw/5S4VRY/stI
 lrIGPT6mtKHlVEYh4Icbk6Rcs2lQipp0RIZnIX9+ZWSJjsHEilvkrl4UCb9xlIGl31bxXsqCp
 pUMKHXw9kdmQc51WGhflF7ZtPSmDUIHwg7aUjib52OKGD5LwxCJ54Gjx/jeVC90S7HyQZPEEW
 J8jVprZpMhFhBTTE9p0wpUSKzeze+BCyu/0yK3iF8Ine3an1YZVSQ9nhkf+9A9N889yT4qip9
 MtmceO8LmZJDWpk+etNwzwR6iuHFcE21nR95mPUFFAacZr//CWD7FOvRq4mu56M/lynh13nxA
 ogcNdcUpMW4+X1y8cG81EJqczjVO879tD/D5mD+QeHSQrSuylsAWcEJwtzOTtpKCqmATGFIDb
 81e6lRVPryhhexxDYqXoDW0CbhmdA6l4qThcKYKwEfA7M1cv5Czn8iWNP5/yoLgN7PgM7NVgO
 FKXp9wszfrWGVowrIT/laR7La3hYdpCG7s5tChpBlsAIY6xmabiF/NuiMxgqFXYD6L2GkwbHK
 xHl3hLFLP/j6KnAJWG5GXNX+2Se7bYo6NfP1zdNxkVsEBm4lJ+r3TXGQJwXK9HtIIxd+DzZ33
 2NL95YJOR8PA5zURS9S6eNvnqmpUW8wa360CkjsSQjjVQxLWCG/FwPwL/FfJXI3RpE/ktd82G
 7/et3+JX+dcmt8kEmXdv7vrPBgTPumYsfiqP+3h2jRn8sB8vXfDF+G+NyXfPE7E5BNXPQ56Jl
 gsFfaca9yeNkw55gm0eT3afT2NOtYjTbPaZNOp2V5Kg6ZqknHkV+4Pfmk51WYxASy4j52uRkE
 dzfSwlMJmbMWSkrk4fMzuX/+fLtPokoaZOsWgs+IFCpXfBauByTZx/yoUB/He13lJ4EesIrBv
 IDWbQmTNU15tX3FezfeTe3cRETVP53SRox5ZpSpl4IJY/BS3Q3jaBEpRujBAZLyqCIl4JYdVg
 HnudwredwypCl3ENM6Ko5C88kbf7nNVvKAzOwHqamVRHN4R0/m2esnYX0ZOUJEAA+0z1BbYn7
 AxPVXD+PzfCTF7hgRR2ph5bBx7dF8fqAMkCzpV+90AJ2QlgO9Ds/uA5k4qim1XeGw03HszhnM
 765RjqgZ/6ERRI=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/10 =E4=B8=8B=E5=8D=885:45, David Sterba wrote:
> On Fri, Sep 10, 2021 at 09:33:41AM +0300, Nikolay Borisov wrote:
>>
>>
>> On 10.09.21 =D0=B3. 9:03, Qu Wenruo wrote:
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>   Documentation/btrfs-property.asciidoc | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/Documentation/btrfs-property.asciidoc b/Documentation/btr=
fs-property.asciidoc
>>> index 4796083378e4..8949ea22edae 100644
>>> --- a/Documentation/btrfs-property.asciidoc
>>> +++ b/Documentation/btrfs-property.asciidoc
>>> @@ -42,6 +42,12 @@ the following:
>>>
>>>   ro::::
>>>   read-only flag of subvolume: true or false
>>> ++
>>> +NOTE: For recevied subvolumes, flipping from read-only to read-write =
will
>>> +either remove the recevied UUID and prevent future incremental receiv=
e
>>> +(on newer kernels), or cause future data corruption and recevie failu=
re
>>> +(on older kernels).
>>
>> Hang on a minute, flipping RO->RW won't cause corruption by itself. So
>> flipping will just break incremental sends which is completely fine.
>
> I'm still not decided if it's 'completely fine' to break incremental
> send so easily.
>

Then even we just keep the existing behavior, we still need some
educational warning here.

In that keep-recevied-uuid case, here we just need to warn the users
about that, later incremental receive may fail and the recevied data may
not be correct, and call it a day (without any kernel modification).

In that case, it's all users' fault and except the corrupted data and
receive failure, everything else should be fine.

Kernel won't crash, users get their "expected" corrupted data, and we
won't need to bother the kernel behavior change.

But I don't think that would be any better than a sudden behavior change..=
.

Thanks,
Qu
