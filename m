Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0213D37F140
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 May 2021 04:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhEMCWm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 May 2021 22:22:42 -0400
Received: from mout.gmx.net ([212.227.17.21]:57961 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229630AbhEMCWl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 May 2021 22:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620872489;
        bh=mPoPuaCVnQdagW3NzF8zq96WLiQReWdTC6V/WXAXQBU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=NMcGAhu57w4fuPefhy76uiRbGOxYDKiv5mQs5QzB1PS52BJYaWuwxfD+POdQQb+36
         bGSwSSXrba5/bqdyMMiJwvHOSdizjBV/F3TNElAJYDsilQSmWtJnd2LVJvBHReQSEi
         q/ljvXBCs+kL06yNiBcjwaN9eXm9Ya7+Vo1ZSZRA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2V0B-1lVh9L1Pu3-013uCx; Thu, 13
 May 2021 04:21:29 +0200
Subject: Re: [Patch v2 00/42] btrfs: add data write support for subpage
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210427230349.369603-1-wqu@suse.com>
 <20210512221821.GB7604@twin.jikos.cz>
 <de2c2a25-a8da-4d69-819e-847c4721b3f4@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <36e94393-d6cf-cc3d-d710-79c517de4ecc@gmx.com>
Date:   Thu, 13 May 2021 10:21:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <de2c2a25-a8da-4d69-819e-847c4721b3f4@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0lkHUIrZ7nXRSHT9qH/H2pHBP28fr2c0QGebH6SSGXi+KzoiY7k
 A6hbZfzEnRR1zVUxzXJJP+rmQNSwOyu6C667xYZrOTXvqWJD0/fXAUMEk1gf6A7GT2uOZtC
 s7ZGqcvWwmL3r6p7z+JrKjl2JKohtBoU/JJU3v4mzaMSddPdiBTdqn5DO76ketPvgTJYjPh
 6q6eIQfFL8ZhoNQxtGP/A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fqnB74KDK/w=:jycO3EDQIPdqxq5C5KYkDC
 QqSiRCqPesgLtl3HEkauZJXug95maR5dglGfAU3SGzgt0YZM6642w4t/l2Jj4owttyxBtwjq3
 bbYoooeZRkI8DbCAcp0ByOK34ak5FcfakONEQdthFe5gvuWgPCdU+2T6s+5d37DVAUNHfTJM9
 gjRSKfGl/xjlBdVX2Tfi/nR0vCTHbjWwwqfB+bScl7qFZjlkEfa1PGH57F6M0gN/2h45lroI9
 ocQdPPtwv0YqZ1+dZ8WwcUOCxCmU/S/93o2C+cXp2xxHsd22ByU89zPwk3BlK+bUVU2LH4T+c
 Upa3PfB1K1oIj99eprhzlvjFQwU57ovVyFTiYfvJF44QvPafrom3NWqJ2+jcg2CFs/bCW6USG
 vwkn7io3aD96vBpS3TyG8bI6eJ6SmwEeRSTat9zWyshHkn6vHXLbBAZwAZJksixz0EmUMOK6i
 1xytp1fX4wswEm/banVGbyerUyhbjBtDFaXeC08FAEFFFPZGh9ihO8mhgZumnnL7o5Kf2eqUY
 JmQ9I+jS1g542Yo7ySPOP96CkKZFfn0qG3LvGMnbQwlIghGTVRUZrgei9/UXPXX8DJYNXleDw
 +VZjiCkRgrI1rwKgR9flNVtErblsNk/MNnDUo8frIiuRSy2yLeX6HJxvRjqUAioSfak/keqzL
 qGI3+2a7JfpOGkmUInFtkYuQDx5jqQnksDFO/a8S1BGNmCPzKw9teErhhOiqbbhwAE/6boGCs
 f9kZn/9a8KXUOEHM97+S8/eXhelw2eaT17L8IN2QVNSReVfXibfOw5SVcK7ZZZ+2dr7IK5qKo
 /snyO7mAvRtnYlnnbz6lw8aXkvAgam/MwGUNaCBgA5AsZJhe1x4ox1AIJmUj0tHXlVWWYFrty
 z+QE4pD7SFyFMTk1Ww6yPz+fZYxWfaO/ZHB8HJi/mfWbye7deiSn9CqRuOEQa9x8p/EZVIais
 dIW9NTVN9W5ijF5d0Eee4Gq9itvpmOMY86iyeV/EJOEBOwtq+tA2mibAIRAzBPiPldXQRTgTi
 Ci5GGWyqP3U08iggBmkY4UeqyJn8nxS3hPSSOS8t+jFQpUMKk1OR1Q9NZl3JXoLZNmDrmZ+M9
 dFIprv7cM/YqH7tDSsP5g7BcBxpoYhpCHlB/ocp/AXRRAs0cd6bzDVL1wjPiHrO5XanCi0kIc
 BHzQaQiLvgBZ9YNKEReqPShn7jdzcgsNVJd5p9PcPw07H/BhiQjLpWal0iaoKefxr0dxZPHqZ
 Xt6IhljTw9cWupLGW
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/13 =E4=B8=8A=E5=8D=887:48, Qu Wenruo wrote:
>
>
> On 2021/5/13 =E4=B8=8A=E5=8D=886:18, David Sterba wrote:
>> On Wed, Apr 28, 2021 at 07:03:07AM +0800, Qu Wenruo wrote:
>>> =3D=3D=3D Patchset structure =3D=3D=3D
>>>
>>> Patch 01~02:=C2=A0=C2=A0=C2=A0 hardcoded PAGE_SIZE related fixes
>>> Patch 03~05:=C2=A0=C2=A0=C2=A0 submit_extent_page() refactor which wil=
l reduce overhead
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for write path.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This should benefit 4K page=
 the most. Although the
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 primary objective is just t=
o make the code easier to
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 read.
>>> Patch 06:=C2=A0=C2=A0=C2=A0 Cleanup for metadata writepath, to reduce =
the impact on
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regular sectorsize path.
>>> Patch 07~13:=C2=A0=C2=A0=C2=A0 PagePrivate2 and ordered extent related=
 refactor.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Although it's still a refac=
tor, the refactor is pretty
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 important for subpage data =
write path, as for subpage we
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 could have btrfs_writepage_=
endio_finish_ordered() call
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 across several sectors, whi=
ch may or may not have
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ordered extent for those se=
ctors.
>>>
>>> ^^^ Above patches are all subpage data write preparation ^^^
>>
>> Do you think the patches 1-13 are safe to be merged independently? I've
>> paged through the whole patchset and some of the patches are obviously
>> preparatory stuff so they can go in without much risk.
>
> Yes. I believe they are OK for merge.
>
> I have run the full tests on x86 VM for the whole patchset, no new
> regression.
>
> Especially patch 03~05 would benefit 4K page size the most, thus merging
> them first would definitely help.
>
> Just let me to run the tests with patch 1~13 only, to see if there is
> any special dependency missing.

Yep, patch 1~13 with the v5 read time repair patches are safe for x86.

So they should be fine for the next merge window.

Thanks,
Qu

>
>>
>> I haven't looked at your git if there are updates from what was posted,
>> but I don't expect any significant changes, but what I saw looked ok to
>> me.
>
> I haven't touched those patches since v2 submission, thus there
> shouldn't be any modification to them.
> (At most some cosmetic change for the commit message/comments)
>>
>> If there are changes, please post 1-13 (ie. all the preparatory
>> patches), I'll put them to misc-next so you can focus on the rest.
>>
>
> Thanks a lot!
> Qu
