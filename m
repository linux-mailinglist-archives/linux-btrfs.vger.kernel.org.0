Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA08D2F4382
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jan 2021 06:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbhAMFIB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jan 2021 00:08:01 -0500
Received: from mout.gmx.net ([212.227.17.20]:38915 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbhAMFIA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jan 2021 00:08:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610514387;
        bh=ZmUPbeIGLCgQYiqhRhUoguioS0WRLTI/fKXt08LOaBg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=XdRx5QsJzWHbmYv8k0cQMEYH0TthGwFdDElyKLy84ijE/eaBWr7qowmPt94ILoGyP
         NZx7uz1oI9gyHsfNPa9AKq4/Kc+ERaLPgAaUqlshDKcmA/LCyrDdrnRyQiPTE1W5pP
         Xil7kfYO1IPo1EuL6q/7mBJhSDtP1TWlKkzBZX3o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MVeI8-1kXwnu24Ye-00RV54; Wed, 13
 Jan 2021 06:06:27 +0100
Subject: Re: [PATCH v3 00/22] btrfs: add read-only support for subpage sector
 size
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210106010201.37864-1-wqu@suse.com>
 <20210112151412.GR6430@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <2147de52-e613-c6c0-35ae-795c51d91e6c@gmx.com>
Date:   Wed, 13 Jan 2021 13:06:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210112151412.GR6430@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KMHc+ayhLY0xrV2RuNH5UwyiOjkrILkHC46Fsfyul6VUaEEu2Ae
 zH72S7Q4hmAkpD1UFT/r26UcOHiV26y4643uUfjKRPTO9o0zaNANJl4aCfuG0WqGrFxcyzY
 FXz/Wd6y/U1JLj6iP0tNWxONKw4GPeSZQgTPHuC4cs2Lxp3iugQqFGpg374ANBNwk9vdWJd
 4zlDwp7Mfx9pilVPk/NwA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VPtcq0h/52s=:02alHXOUa9aBWgyyyF3MHp
 9cnP403/1SZNnDOexnTMY1Ihv7EjAe/fchKgSAqPOexWK2g0dEv5dw4728+wrYitQU0zVOEpj
 dCoakMgtgzbJiJwmF/d8AcKbIJpeQaj557/w2BXNKOnaUhOkmZuWH/Hj83DbxHp+ttgoyglpa
 6oyWELImA6lMB+uigXj7JknQUBwE//fDPH8H0TQdbXOi8PYxkyzYJrK4gw9UPzSJmodrNV52d
 xagwodJrsrgnvLppssS9KpZD4j5HyLGyPYTt2TRELmO0FFTmTUIaBr8eW/4edG9528SEa+dvm
 zbc454vdBl1eScF58Yjc9nNVphVlip1vlFbGQ2CzYrfab/ZoVD/vQVHwEMZoyLxa7SAHRn3X5
 Vaz5bRiPJL07SzAaAesHjBpWejGgZND8E7tZqwdcNIdQklrHCswk4No2IHf3ekVI1QY20zsjO
 sCwfmRC1xt5d5zcCeveVV3BHqMxWRVO0b26IuLY+UoEXsg9ApuaSvou8AxiQJrL3ls+wsNHjT
 8FOzVSbxfStgyWsyNIMwNmC3r0tgntWAWN6CQbJ9O8izaTyU/kNl+UhReAPJNhRUwlChnqTVq
 wtdkMoOZLD5rhAFyY65TCsU+ZlzJwJzdIdIm86CYSL5J+l+jH6DFFZOJPv1M9/V+FgsVzXABa
 7kSSZoFcs5vD0vmN6VpNPcpwLPLuIlSvoKmo5QpF+yEjfrKU6OHjUhVQK8y2UMsqv6vBKqHUG
 FjJxfBWtHN/t8/zjtJK94GIkCgTXCfZkyTaOpA+UkYtG4lnaTRtUd+Tz+khvuieb7oMhdwXW0
 E1yd1GegKSGUecha67eGuZe75CtxhQFPNvkeFqu9rLnwGOHarsAbOsXd7TpWPje5YmruUSMX7
 Vc99MCn0WBrJTKIHm7+w==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/12 =E4=B8=8B=E5=8D=8811:14, David Sterba wrote:
> On Wed, Jan 06, 2021 at 09:01:39AM +0800, Qu Wenruo wrote:
>> Patches can be fetched from github:
>> https://github.com/adam900710/linux/tree/subpage
>> Currently the branch also contains partial RW data support (still some
>> out-of-sync subpage data page status).
>>
>> Great thanks to David for his effort reviewing and merging the
>> preparation patches into misc-next.
>> Now all previously submitted preparation patches are already in
>> misc-next.
>
> I merged 1, 2, 3, 6 to misc-next as they're obvious and independent.
> The rest is up for review, I haven't looked closely on the open
> questions.

I just fetched misc-next from github/kernel, and none of the branches
have the patches.

Maybe I should be more patient?

>
>> Qu Wenruo (22):
>>    btrfs: extent_io: rename @offset parameter to @disk_bytenr for
>>      submit_extent_page()
>
> Please drop "extent_io:" from any future patch subjects, they get too
> long already and we haven't been using this prefix consistently anyway.
>
Got it.

Thanks,
Qu
