Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53CC380187
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 May 2021 03:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhENBmg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 May 2021 21:42:36 -0400
Received: from mout.gmx.net ([212.227.17.21]:37099 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230460AbhENBmf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 May 2021 21:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620956482;
        bh=Kn+ag+sH5NaNLuwOYqi7S65R4MjW2L7GDjCTPycgFqg=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=JZyJVQLTFQ9s1/OX12w9PqBf4ny0lUx7xjsBeHdsXYoxzxm9m+9Nv8g8Goa2IOLRN
         P+mGUFFneAOKhHltbgXyz3ODXz8i4Dq6W88DZI6Kiqs6kXaQ4EDnIXqAhjuWE1xIqT
         P9is4wRInMNWrs4OYpAh9DyCTi6XL4l4NJYGTSDw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mlw3X-1lH8te48F1-00j41i; Fri, 14
 May 2021 03:41:22 +0200
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210427230349.369603-1-wqu@suse.com>
 <20210512221821.GB7604@twin.jikos.cz>
 <de2c2a25-a8da-4d69-819e-847c4721b3f4@gmx.com>
 <36e94393-d6cf-cc3d-d710-79c517de4ecc@gmx.com>
 <20210513225409.GL7604@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [Patch v2 00/42] btrfs: add data write support for subpage
Message-ID: <2b05bb47-f16c-62dd-d234-8bffdd332081@gmx.com>
Date:   Fri, 14 May 2021 09:41:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210513225409.GL7604@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fuo7EinRtelEP+2SsDc5p0zmq7WtGR6zBqk/exFdiG8gyeogwdD
 1t/h6RIU5XrpwY8IFoOOni8RV7jPINIwtP9TmGoNga/TF+pQA2o8/fCVU+lGJCQ3+Wp2Jk7
 mHocs3xLcitTTjvej82AWlwvmmU33IDQFghWoC9Ty76rxp72LprfREoq9vAE3kYI6ckYNHA
 5uSeW5x+X5V38Z/SZy07g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rVq/mJ9g3s8=:7cer1+Wv/voOxlOLOo1mG0
 xXsBKv6W1HKozGMl6hjBNskLsQNaFuqSoOQmP/4Cd7XuTI/FsWcbG942gyr50D+I6sqDr7cvt
 uL/FYM93SX0tzh0YEwdEdsMHJmXtAoL7QsbhAMI8ReRifpBL22oBlUJYbwmHWRm3nGTDkwvwq
 qk4cxJpPnpr/YI4in9rMA3CNP9lk3+NC5gG26r0OKJYrL8i+WbJYJ+RN90kmk8tPcP9lMQAIY
 9S7hPB7Iwo5PVUPDIIo9/0q1H9stjYX7tvcTRq7VPbLQ1zdtTdax4IZLLutnVkHgNDynxT3Gw
 AZV7j4hqDxOQyoIZI/5TktmO9Vp53CfFdNCX7iuab/jxyfLcTGqTnbVl9iVEdFiycA6DF96kM
 Q2dH7QWohZuMihdVLV3iSTvTldCahxzssPYI43z/sav74P5RmZvzwV1WEWZIiG7hpAV0Ni9Vr
 6hHlYvGCqaoSV+j7pVWcvT+hgojhs8/G+Crul+NipWkYH5B9X7polYHbhrhE5BZp1SslMRwkB
 696Nqq69X8IyM48GYJKz35EWtdK9JkJjf9A8YAEazmGfWil7aPXml05qapfqiZ2A7uBXnHBDH
 6Yg+JPvmeaf3U222q0QyR0peOOahgRsaaDkDoN/eoPzo5TboWNxogoazzQcDMkPcu0xPeJVW2
 IaIZahaTcLi7ulCDKAUKvwUeAD5Qp7PLKK4RGNRoSdfRog8ILg/VSbYP63R9szqVXrRSkqekA
 KWDtkVT3CXGuzPAthi3A+W7ZtWhWaDZk/aIVqOXOJ/gnhbBnniZNLyqrOazAv2rzKp3ukujtV
 sLBshBXxGny858myGYuNfbOww4nvgjpW8MGtq/XWwhYJ9FoIoVkbBff565k2S83psY8PMUQOy
 GL6TuJcyGLHT8mXyq/ySK7rU7URNh/amarazQdC/8phy9bSLnGZewhe13nQasQLWu0PzdvRIG
 gXfGnAmirK8kGweGJr1ubDNmyAWvbMoNF721bpXcOcK8phUTr9arEGnFIwLWepe34j7RsmCx3
 fuVcvjWHfAaCpB6mJ80D1N84Ctt61TfCIDg+uzHYLlVbb9cIkpgyTlaSSsPY0VKj51krKNjNn
 fVqRCHoBoyJxH6CRm5O5cAdmBFrbUAWiygrDiaS/DQiUWazy0HvK/Lf0US2yXLgVJcT1uigAa
 AZfD3X8A/+F0Ihj7Kj+kfPhfXXm8Rrad7oGaTp2KRDO+OyHs3CqyK3OfrDIcR8s8eM/EONCr3
 XhCvv2Jj42l0M2Qcl
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/14 =E4=B8=8A=E5=8D=886:54, David Sterba wrote:
> On Thu, May 13, 2021 at 10:21:24AM +0800, Qu Wenruo wrote:
>>>> Do you think the patches 1-13 are safe to be merged independently? I'=
ve
>>>> paged through the whole patchset and some of the patches are obviousl=
y
>>>> preparatory stuff so they can go in without much risk.
>>>
>>> Yes. I believe they are OK for merge.
>>>
>>> I have run the full tests on x86 VM for the whole patchset, no new
>>> regression.
>>>
>>> Especially patch 03~05 would benefit 4K page size the most, thus mergi=
ng
>>> them first would definitely help.
>>>
>>> Just let me to run the tests with patch 1~13 only, to see if there is
>>> any special dependency missing.
>>
>> Yep, patch 1~13 with the v5 read time repair patches are safe for x86.
>>
>> So they should be fine for the next merge window.
>>>>
>>>> I haven't looked at your git if there are updates from what was poste=
d,
>>>> but I don't expect any significant changes, but what I saw looked ok =
to
>>>> me.
>>>
>>> I haven't touched those patches since v2 submission, thus there
>>> shouldn't be any modification to them.
>>> (At most some cosmetic change for the commit message/comments)
>>>>
>>>> If there are changes, please post 1-13 (ie. all the preparatory
>>>> patches), I'll put them to misc-next so you can focus on the rest.
>
> I did another pass and found a few unimportant style fixes, it's now
> pushed to branch ext/qu/subpage-prep-13. I'll run tests before merging
> it to misc-next, the cleanups are great, some changes scare me a bit
> though. Handling the ordered extents gets changed a bit, nothing
> obviously wrong but based on past experience there are some subtle bugs
> lurking.

Yes, that's also what I'm a little concerned of.

But with more understanding on ordered extent, it should be less a
concern, at least for x86.

Currently the biggest change is in the new
btrfs_mark_ordered_io_finished(), it will do extra skip for range
without Ordered (Private2) bit.

For x86 it shouldn't be a big problem as one page represents one sector,
and the only location we may get such call is for cases we don't need to
submit IO.

Those cases are fully covered by fstests, according to my countless
crashes/failures during initial tests.

Other than that, the btrfs_mark_ordered_io_finished() behavior should be
the same as old one, at least for x86.

Although more tests are always helpful.

Thanks,
Qu
>
> The plan is to add the branch to misc-next soon so we have enough time
> to test it. I'll reply to the individual patches with comments that
> stand out among the trivialities.
>
