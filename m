Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15337416FC3
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Sep 2021 11:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245366AbhIXJ7c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Sep 2021 05:59:32 -0400
Received: from mout.gmx.net ([212.227.15.19]:42747 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245299AbhIXJ7b (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Sep 2021 05:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632477476;
        bh=2qSgyZjd4IzApmInJIWBf35Nr2dCmIzofz+989Di634=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=jioPgUDThPTfiBwKDoMFyE7i3QPCDQ1Pv7FXsd9Z4TBcz7zvc3VQitRJn6qxjHwG3
         mxTc/C7tNvmA2Gz9061RTUcw/vXocQDhfuw/W4MTmQBW4uYNyqsWGyAGhkW8luz99R
         2Awe0f8FU0639LF2iWGB3wcpqNjdt3TUqpRYoMxU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N6bk4-1mvgbd3NFO-0181OS; Fri, 24
 Sep 2021 11:57:56 +0200
Message-ID: <bcb6a3ca-f349-2547-a9ec-4ae69e3aec26@gmx.com>
Date:   Fri, 24 Sep 2021 17:57:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: btrfs receive fails with "failed to clone extents"
Content-Language: en-US
To:     Yuxuan Shui <yshuiv7@gmail.com>
Cc:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAGqt0zz9YrxXPCCGVFjcMoVk5T4MekPBNMaPapxZimcFmsb4Ww@mail.gmail.com>
 <e45e799c-b41a-d8c7-e8d8-598d81602369@gmx.com>
 <CAGqt0zyEx1pyStPVTSnvsZGYKAGEv9yUunv-82Mj6ZED3WNKRA@mail.gmail.com>
 <CAGqt0zy6a8+awo6ifUn4x+WxN=c6e8PnuMW5kYRodxOQ6vwU-A@mail.gmail.com>
 <72d66f13-6380-7fcd-3475-8152caa965c4@gmx.com>
 <CAGqt0zz+=nUYbNwLSPYwzYcNLgyxsWT22p+jwwFpAOcyAHAWgA@mail.gmail.com>
 <e83029f0-8583-91b9-47c8-a99d4b00a6ae@gmx.com>
 <CAGqt0zykaioT1LJAtOM8Zc4eJBXxTEy2ugBrLpgZ=BzCJzixXQ@mail.gmail.com>
 <CAGqt0zwchNdLKz4_qHrdbuxx7RWY9YbdiZ4KBYJcrwWa3sxBZw@mail.gmail.com>
 <529263b6-4ff9-1bf6-8566-ed1ec648a539@suse.com>
 <CAGqt0zxrm=A8v7Mm6CDNUv77Sxsgt_kp4uJpCbpbCGXrnUmBqA@mail.gmail.com>
 <8af945a3-db88-d1b8-bba3-3f6180f91fcf@suse.com>
 <CAL3q7H7Ty-0HOy5xQU_JMuzYZoNbihL9-gdk+vwk64+GowEmCQ@mail.gmail.com>
 <8a781d5e-bdee-b44c-f237-292804b822ab@gmx.com>
 <CAGqt0zx+eC0B1Pr-GXOkwn7icc0OWBduWbcmYRg3K8Uw1DXC5Q@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAGqt0zx+eC0B1Pr-GXOkwn7icc0OWBduWbcmYRg3K8Uw1DXC5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vMLXoFYXrvZ8yjVwBHZWnzS3aC0Vv8mAm79k0+MtU0m/Bfqpszb
 0449FWuMMLh8Qed15rzEB53VaFpK43bSJOEF5rnB+JSqV86wLv320qWYnsf+KVCQ7v2E4jc
 kbFhTZrv2ES3Ncd2cGA78FQleV0USBL8HTJe0yhDx/y7KdelAgGoDOUbaQ/ooZtB51hSair
 ExtjBd00BIptWQZwFaYGQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:B+1PRyHXgfM=:z3EeyB3xnFm5vFlfPvGvIg
 M9xVDS62BHW5SQiTgZgB0aUw6hm3xbbO220I4eGxZsx5Pg0bycNGhV5qH6bSKEZ5iqDzUSiZH
 ZzwHUOJ1EoODAS7q1W0/omZTw6jnlH3IayE9mJRs/RlQIO+8axE7zH1r5HGwIE1RxdZN08rPc
 JFGxxc5+a83daUJIEUVrAV2oBjJC2f8WHHzha6HsBxhoTp6sT+0O5wjLxnhDgqgPfZvlDTAja
 Z7CDkBL8mv39Rwer4MatzFkaJlUCWmLQ3To86L4vPUorWmDOmXfnz71IRhXTtshnlvMWTWe0d
 En/HX9DqOK6ywRJjtOc0bz2gigBJFIJXUW7/r6VBOHw8Pzz2Qc4pzZF10Apx0HWVD7Z9zkJVA
 NWfTVo/8MiNUluzJqfC1MsRVMnzkBeJyQIaA/DpLxQSUt2UAWdQTx3BLIKCpq31iMTG6qe+2K
 rJ3L9qhom4ik0dKB3c5Z5hi7SWv5kmyNe9hQyI1F8bvmbqJF8ytUNnoWSIEE38kLv9hxxEkdz
 vbhrARIxfdm9VtQQIA94CR+YBhGNQcKaNDHhsPlbpRNQoX8hHg1N7bHf2B0eODg1KuYnOp18s
 HC3YBAZdtgzxydyo2q3NC5etmJ249MCBolP9yT9h+4kFConVsp3vriyjgL4o/8fuo3eVSMTdS
 Vv19IwfM2oDH9l9x6abhNxwGXh0LFCBp5ARFmPh1VH1JLEQanlvv4F0/CUmtYEsk98ZdPZwIa
 eBvdS8yXilUgbIQU0U0YRi33PTyliL9YV9NqTbTsDOV/k9prOBGkvk/mDw1+uKhXbtdL9IG3M
 7Q36n7cj7YT3TYQ19iPjEoo2fogBuBHy2y2nAUmfXayBp+2Ga66vSILTy9FIBXtFj5oHlOWv2
 v5NPBzzdtSGzTYkWOUMw/QuUSk6qEglGnH0Fy+NciQbLgfmg5+JHERYuIiwdFeAs1OmXjShre
 ewhLkqlyXgocq89SPA9uzWhOLFRUWypOpdJkldub6wp9Pn86sOLNgKoLR6qySRJQVwTpZzAqS
 T2MHIaZB9Xq10LPY7ZOmciCqpeLxz+bq+ixiC5iGiKGQjkQNMXAu7RPW8x143ZOrP3gOSgF2p
 gfALDxTn8Ksy5k=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/24 17:47, Yuxuan Shui wrote:
> Hello,
>
> On Thu, Sep 23, 2021 at 12:16 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>
>>
[...]
>>
>> Exactly.
>>
>> We can craft a test case for it (but without a fix for a while).
>
> As a quick fix, is it possible to convert existing files that are not
> nodatasum to nodatasum?

Well, this is embarrassing now, I don't even know a way to show/set
per-file NODATASUM flag.

So I'm afraid it's not possible yet.

>
>>
>>>
>>> I'm thinking that for cases like this, we could use a flag for send to
>>> tell it to not generate clone operations and do regular write commands
>>> instead.
>>
>> My biggest concern here is, we should properly include the inode flags
>> in the send stream, and provide an interface to change btrfs specific
>> flags (currently only NODATASUM) at the receive side.
>>
>> With that we can set the proper inode flags before writing/cloning, no
>> matter the mount option.
>>
>> But this is a big project, involving changing send stream format,
>> introducing new ioctl interface.
>>
>> Thanks,
>> Qu
>>
>>>
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>
>>>
>
> I have a dumb question. As an outsider, it seems to me that cloning
> from a file with datasum to a file with nodatasum can have a well
> defined semantic? i.e. say I clone from A (datasum) to B (nodatasum),
> then reading from B should skip checksum verification, and modifying B
> would write data without checksum, and leaving A with checksum.

Clone means it will share the on-disk data, without doing real write.

Then the problem is, one inode says the data should has data checksum,
the other says the same data should has no data checksum.

This inconsistent status is prevent us from cloning in the first place.

>
> Is this not practical to implement due to btrfs' internal structure?

I discussed with Filipe, we're more or less fine to fix it in
btrfs-progs (receive side) by fallback back to buffered write (read the
data from the inode, write it back to the destination).

By this, we can workaround the problem as a quick (and maybe final) fix.

Thanks,
Qu

>
> Thanks!
>
