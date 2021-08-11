Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0D93E8C54
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 10:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbhHKIsX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 04:48:23 -0400
Received: from mout.gmx.net ([212.227.17.22]:39333 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235282AbhHKIsX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 04:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628671678;
        bh=jqJfLIsyoWdMg3uRXlmBKE/UP3KP7zL7YzriOVqnLUg=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=jLLocD8hTkBfIIhQW7MAXwhhpjsFUaLzpuEJ4YNhSjDqzCb9v5p1cASFttts9qI6T
         0nQsdnXVVVQ/eNEyRqBeP3GOumTIGclbBOUH3IluE8BUKruiuGhIlp9owP0bEVSXGB
         AkV/d/IH58jDrrDTuBhOFwx9BFAnSex4H/MEKGgg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQeA2-1mRZHv1JbS-00NjHL; Wed, 11
 Aug 2021 10:47:57 +0200
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210810235445.44567-1-wqu@suse.com>
 <a9c908a2-ada5-24ab-dc01-ebd686294000@suse.com>
 <40072166-1fa6-33f0-ebad-b47e4c08b633@gmx.com>
 <26765bca-a9de-af53-2d9e-d1131de4d801@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs-progs: map-logical: handle corrupted fs better
Message-ID: <1d598b9f-830b-282f-0445-d7c2a8ba3d9d@gmx.com>
Date:   Wed, 11 Aug 2021 16:47:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <26765bca-a9de-af53-2d9e-d1131de4d801@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MgjGS1uJ/cDbW1lTjXQ3xcBdmAOSWFR4Ib1ti6op01Z9RNQSqMX
 yHPEoTiTHaVavtR6m7oxndUbys358TUX/UIoZjY8X9W21Y6OWSG1bNWzKD6kOfwUzUW6sAA
 zJjqSjCjYLDNQDjET9OkIRzpiX0XrWMUqWtFo0claD4QJU+crkoGb6TFADXmrJbR23Rqm/g
 MiPNF8QifplKKzL9ykd/Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fYst2o2kdxo=:fYnNf92HDdLue7NP3czH1n
 frgMgKN23xe+Ag9APHSld++x3751v39EhZjvSWr/HIrK6PB1e8IS5alFWTzzdm+4wpwgjwSl5
 qLVnWOGF9cRg1l2vdnIRMND2Du/QPXWBlLpD2kooJCz1hB1dicmXGEu8AVDsLUlW44u1tXZIs
 cPRp1CRIs18cfOXhKPTxCKfAasaBfyLPgkREa3dOIf9sRE/5LGdHx3JP3xPdsWskO4/8yyJvk
 CIUbw/zsegKTAOVPmGCR19bwKaGaC2mOx6/256ewbxYhjwe5mgqIziBGkUaBvD6Rt3cGZfjBF
 K5+M5g1VUDYvAXA3biyvEXnSm5SjoWlxxRySxul4WxAl12cdWU0B1S6OX3DduSMIyKSRpIsqR
 YIfrNl6Md3jLh5jZ9704CL5vRA9jn1+Op8yCfAaOaH7hP+Y+OQKsXmSigqEBOG4CGtZ2wokOJ
 CJ7uQLXXFXqiIouysZ78GEkc6XTz4JR3gPeBCNDkpTK9EWrjyhUZioZHBRnt+PoAu24c3a2wO
 iScIlUWdx89N8/fAmPWjhd7mt6lN3zK3tVAtqQARCrbDo6Otv5VMyxuG6UD7DW+ZJ/WstpJMm
 5yod+Hy1KuriO328am6fxGpbSJOq9989ATNORQd59mCizuZX9URKYXE0akdDsUjQV9HyfFrr5
 29T+NnOh35IajZCCJGiE8lkW5Q+d+UrHG9ftj32fPavK9bDZ5bVihB/CzuGJsomQ38PfozSoo
 atfeVxGlKd3vpt1tTsBjlA3PaqyAIq5hpVORccFcgqLR2JgStrTZ9DSIVLXjoxXRThHg2y3ce
 476yV5O948MslaPfzXWubfdhAhZDFHk7IxFfqpOBzUNDze+OvklEvkjCS6hMNdg+DEs0X56kZ
 L2OEYy3AbqpnP8lwMqvEvwM2V7qNqxhT4H29jYehot0WRN4w4BOPjTZVZHUqdzH3SlhkneL6r
 nbRBuvV1uKG4aAxzBJj0v2aKOs8SD91doXb8v1DlBvR+ssLjHpP5X7sa5ObV+2l3WT6Yu8mBs
 aSBGWlDOrmxdSnUZia3aM6iu7lRZGTlcxUXj6B4eLMz7IakrNS5AfLmssPIMaeiI+xDw0QXBA
 FBgAty7fAC22lFT9MnrBYBIuNXacQMWnhwEUah5gGQW5G7f6fQwSUL4EDYh2PrX70b5UghrAu
 MSIMhBvGt9dNjlvelwuxUomM6Mvc3Juaalq2T9GQJw0t1IMu8OT8Bq4d34x/dZG8lzSh4=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/11 =E4=B8=8B=E5=8D=883:28, Nikolay Borisov wrote:
>
>
> On 11.08.21 =D0=B3. 10:17, Qu Wenruo wrote:
>>
>>
>> On 2021/8/11 =E4=B8=8B=E5=8D=883:03, Nikolay Borisov wrote:
>>>
>>>
>>> On 11.08.21 =D0=B3. 2:54, Qu Wenruo wrote:
>>>> Currently if running btrfs-map-logical on a filesystem with corrupted
>>>> extent tree, it will fail due to open_ctree() error.
>>>>
>>>> But the truth is, btrfs-map-logical only requires chunk tree to do
>>>> logical bytenr mapping.
>>>>
>>>> Make btrfs-map-logical more robust by:
>>>>
>>>> - Loosen the open_ctree() requirement
>>>>  =C2=A0=C2=A0 Now it doesn't require an extent tree to work.
>>>>
>>>> - Don't return error for map_one_extent()
>>>>  =C2=A0=C2=A0 Function map_one_extent() is too lookup extent tree to =
ensure
>>>> there is
>>>>  =C2=A0=C2=A0 at least one extent for the range we're looking for.
>>>>
>>>>  =C2=A0=C2=A0 But since now we don't require extent tree at all, ther=
e is no hard
>>>>  =C2=A0=C2=A0 requirement for that function.
>>>>  =C2=A0=C2=A0 Thus here we change it to return void, and only do the =
check when
>>>>  =C2=A0=C2=A0 possible.
>>>>
>>>> Now btrfs-map-logical can work on a filesystem with corrupted extent
>>>> tree.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>
> <snip>
>
>>>
>>>
>>> Furthermore with map_one_extent present the semantics of the program i=
s
>>> that it prints the logical mapping of the real extent rather then the
>>> passed in bytes. Because the user is allowed to pass an offset for whi=
ch
>>> there isn't a real extent. So if we want to retain this your change is=
 a
>>> no-go.
>>
>> The change just makes the extent item lookup an optional operation.
>
>
>>
>> If by somehow we failed to lookup the extent item, we just continue wit=
h
>> the values passed-in, no longer to verify whether there is an extent.
>>
>> This is especially important for fs with corrupted extent tree.
>>
>>> OTOH if we want to have btrfs_map_logical to serve as a simple
>>> calculation aid i.e you pass in some logical byte, irrespective whethe=
r
>>> it contains a real extent or not, and have the program return what the
>>> physical mapping is then map_one_extent becomes redundant altogether.
>>
>> Yeah, I was also thinking about that, but not sure if we should
>> completely remove map_one_extent().
>>
>> Thus I took the middle land by rendering it optional.
>
> IMO the middle ground would be to add a command line switch i.e force
> which would ignore map_one_extent. In such exceptional cases a user with
> a problem could be instructed to run the command with an '-f' switch for
> example. The rest of the time the program would preserve its old logic
> which guarantees returning mapping for real extents.

But now I'm wondering, do we really need that extent check?

I mean, yes rejecting the lookup for non-existing range may be helpful,
but it's not perfect.

For example, if we are looking up a unwritten preallocated range, we can
pass the extent check, but still only gets garbage from the disk.

So why not just let users do whatever they want?

(Well, I should ask the same questions to the older me from 5 years ago)

Thanks,
Qu
>
>>
>> But if that's the way to go, I can't be more happier as that greatly
>> simplify the workflow of btrfs-map-logical.
>>
>> Thanks,
>> Qu
>>
>>>
>>> <snip>
>>>
>>
