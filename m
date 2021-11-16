Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C2B453C8E
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Nov 2021 00:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbhKPXMm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Nov 2021 18:12:42 -0500
Received: from mout.gmx.net ([212.227.17.22]:50779 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229704AbhKPXMl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Nov 2021 18:12:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637104181;
        bh=qnCznAuoBIQ4fSJaEsmO8Bmx8bhK1QkJNp9UNXhNjAE=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=MWg2bIZPChz8J+Vk4dH2v/zDJLqFF1eE3lJzoZrnLlMK1I3uxgSer4BHafJiXg0NZ
         wGPc3rlJDc7stS3qBIU35zAJub58jYWRzHUeS9pRpi1kkc6RFQYfkNqjiAQRYytLQV
         oEeNjAWgR+3pRnyAouDsOUTaFarPqjMg7zjWSrJ0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N6sn1-1mbzsB3wkB-018GAX; Wed, 17
 Nov 2021 00:09:41 +0100
Message-ID: <4dbad01d-00e7-882c-6d91-c0351514df71@gmx.com>
Date:   Wed, 17 Nov 2021 07:09:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] btrfs-progs: raid56: fix the wrong recovery condition for
 data and P case
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211116131051.247977-1-wqu@suse.com>
 <20211116135222.GP28560@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20211116135222.GP28560@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SAD+2HovguM8XPJv8tCBlrjtzrDIr+Ko2cC3fOaokBby5yRKSkK
 O53MwQaJx6BuUPOXlkEXdyZ9utxt7/Rf8Ehcqyq2lVw0dzjSxkEtDudcolXVZOb3jf1f51z
 McTvRWwfxca+UtSqXEzs8LASN9asGRTYU+D/CVVJzHlAltA0h4zfrULZhqASL10SFIffdVe
 kXLKOWBfhnK2Pb/WL/vIQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IwGl0UJ43vs=:LOOj2vbDTEnOOmCeTRc46Z
 ms0QiywBi15PS2VakeurAsJB42V9OcgvOWsKIJrrZA6m8YO7h5nLmAUMve5yDdMspSCSIZrLT
 grTZYEe20iVH/rwjBxanzozjgWdNKlNMM/IZeuYnTARUIQTnrPsdTiNauoBmVulKGChZI+jqn
 1pIY3YrMJXSxBdEx0cz50KuzM8jbgUnE/LXWClwc57mEVXfAxXmWtDNfHTSVwTsDPoElJ080z
 8fSbiUROnoVRky1KxR8QQD8edaGD6/QxKLG80two3YvyHHqBXTBdUoyVhbNtZpmvdZtOcbc/T
 JwaqR3yESzxc/1tN1SDTKTRyu1rxdX9pDmfoUroRMGMa9kygkijEfdZYN+gY9dPGaoQEHVd++
 pPe1uGRTKqWsYvGuwoP7pF5RMi41oD9sYiMjCpDTCp69lAww4gFKXjgkoq6hgx2iz17mYzSPQ
 FvQ4xBaqqzLQ6XqVZYVwsIDaeEeIZBzPpYbnxX6NT700zqsZAyOkNx07fh5vN1fjX8W9R0XBL
 UNJYKhje1VGFYoZ4stlOblHO2iTUk9YqdbucocVtjGE8/75vgkt6fCdpU82irNnF/K3ELmPfA
 6V7WFO9rvET94LsagRPgWJTi5bU2Xei1qdjde/gwNh7T+2i9oHDiEF9H8TeLpsJtdc6hmEiNX
 IK0WCf92rO9YF0Pa7H/Cg8UGy9vMIqyConJ5lGk+t2lQGuEDwufIDgtrJHYsS7PZimt5b1Tvq
 13R62R8FqLROp9nAsbNLy3uAVSCOf+F0jzfr732vP9NvuPeRsjRaOi1pgnYVXfxDnRcEEztuS
 kUuh9CtlXrseCHVmj5SGJoaBokY8n49455Wxnk7fcqkVZyPaEK+gBZRnQNZSUDK76M2zQsVhE
 491DIkuqe7u/FGeAHzPuHhC8GORAxxf0fl29UfWS8HAs1YBvhwJWQPtOWMjR4kGnPgjSbStjH
 Pmnjhvn2AbgLE3/i3C3wU8wR7+1Lv3CCrwIOs+p7s9KKpSK30t71rrn/4hXREM/ETRuYhkG9F
 0pgkh0H9Z0cWCBq3ih5c/RLzuUb9Kfq9Mr7jwb84OQ+p75+YF31y3JKGFxzZbe6Vjv9XxqOxz
 +rdnXlOBblLC/4=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/16 21:52, David Sterba wrote:
> On Tue, Nov 16, 2021 at 09:10:51PM +0800, Qu Wenruo wrote:
>> There is a bug in raid56_recov() which doesn't properly repair data and
>> P case corruption:
>>
>> 	/* Data and P*/
>> 	if (dest2 =3D=3D nr_devs - 1)
>> 		return raid6_recov_datap(nr_devs, stripe_len, dest1, data);
>>
>> Note that, dest1/2 is to indicate which slot has corruption.
>>
>> For RAID6 cases:
>>
>> [0, nr_devs - 2) is for data stripes,
>> @data_devs - 2 is for P,
>> @data_devs - 1 is for Q.
>>
>> For above code, the comment is correct, but the check condition is
>> wrong, and leads to the only project, btrfs-fuse, to report raid6
>> recovery error for 2 devices missing case.
>>
>> Fix it by using correct condition.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> But I'm more interested in why this function is still there, as there
>> seems to be no caller of this function in btrfs-progs anyway.
>
> The file is there from old times when the radi56 implementation landed
> and the file was a copy of something in the lib/raid6 directory, but the
> sources have diverged.
>
> The function was not used as there was no repair code in userspace, so
> the question is if w still want it there or remove it.
>
But then the problem is, how could userspace doesn't have any RAID56
recovery mechanism?

Things like btrfs check still needs RAID56 recovery to read fs with
missing devices, this doesn't make any sense to me.

The only good news is now we have another project which would do a full
coverage test for btrfs-progs...

Thanks,
Qu
