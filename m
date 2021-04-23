Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7C9369CD1
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Apr 2021 00:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244194AbhDWWfU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Apr 2021 18:35:20 -0400
Received: from mout.gmx.net ([212.227.17.21]:45269 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231218AbhDWWfD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Apr 2021 18:35:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619217256;
        bh=AWV/AjNKUOgREnTChBRKdOOlMr3JXLpYfu98o0X7SsY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=G8i21ZNIEJLheuMJKk0UhzCIuPDmuW5fVAsw+erkm+J3CSej44f6iA8nlz3xTnnRX
         aUJVwnVSnKXUtH/uQ0kE+DsrNnNMhyDALV1r64YLBXPNkco/sk0UqYxTOByASTFS1B
         jWWKEKmeYS47qrFXRs77ZCfpfxaSwkVaueyl6eQ0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvsJ5-1lIodr0V5L-00sv6m; Sat, 24
 Apr 2021 00:34:16 +0200
Subject: Re: [PATCH 0/4] btrfs: the missing 4 patches to implement metadata
 write path
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210406003603.64381-1-wqu@suse.com>
 <20210423112938.GG7604@twin.jikos.cz>
 <af78885d-b9a3-7629-d659-812121696bab@gmx.com>
 <20210423203103.GH7604@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <1d6a373f-2c76-4650-44f0-245375c0d0f2@gmx.com>
Date:   Sat, 24 Apr 2021 06:34:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210423203103.GH7604@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IxBLEY4XnqZAvxcYBYiwXehDGrJN2jPrSx5c8/IdaX7Le6w93bl
 VXUwlPRodD1oysej8nxpKYgnabB06mWT31j/RInF1uklA29AaVBURkBBwmM9QG6wwJ0Xvox
 4176gS2k1ZhfWs5nFkHFMeZ33stGRyvnLjP+ChQhIWkfCVozJpOzp7C4Zw9iUgsQdmDlYic
 VosVjCmxYAFBShq31GAlw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:u4a9Oy7QP3o=:peMRUumnOM8CeHRGOz59pQ
 O5fo4RJOPFN+FijGD1gD0HQLx9PXETLdkuW9DBMR4LKXvGPkZSNG3zf0S/WV75Blmd7sSACe5
 g7oiz8ItLITaOgeV8ZBuNCh7VFlxXaG+mhBIKaF5pJxz4FoPGTYzqzvSxG+xoti9/deJGQQ/O
 6ABLFivYdk8R8PQ4dXeaXUJsffu6LvVXI6hyjLngX16b12CLZtVY1AEDTD1Yp4/GdjTbhwKCT
 GuMQ3Cpmeao8dp7rwZJP0vCPgxKe5QjDEEC1Vn/BkUoN5yfDm89TNVjrf8i3IH6yYSH1mcNU+
 c/CCH+nWwMki78Bcr136+zBjZVPpWkrLozYIerm7nWdU8zuxR9xRJFps8cQDbrDD1SUgWgGSv
 KARMqilXKjucKKuz/Zgl52CpqLxJG6r7TbvMJ8WPaSq2E3c8WsDIBwg/kPM4jvwPxgKGQ6Tz0
 BWiSLUtqeR/mVarLHcLpnsID4mK4LuLt4Qs+xRScj6wHGSvoId9HXpqoX8LdueQ2GisW7NB7w
 a5q6t7nco5R7wl2xHNej+L2hinMPGwPFQiqAGWDl+Gyq6S739qqj+CSmvmITo5iP5MosVY5L0
 VCkMp+suSzWq+FxdnXN95H4NgoR6Vrq+S00LB2pGzgHu1B3D5OJwj8bnij5/JV6x/fkvtGkkv
 xZki1Xp4NH1dFLj0GSrC/Vy4f0NySWnlP7tMknzMD4KQEPiz1v2fMK9cIpIGlmxwA/lWPXRBz
 MRXsRn7d3HUYoV92tQ0rQotMuKt/PzceuUbaKV6BF6t43OaFTAApcmm+c/Bl5TPg/SAYx61Al
 NJ99OqL25YmBZaMavi8ZUcQE1TWcvqKZgtRn8EWbK3JvvA71EbAAUycgAOHJaQ+va45FwcbP1
 5f9jtqAd9BtcixaRhQU1uoteVO+Ek+kj+dRrusiP9GJvTpLKjR6LD2+GiPGjWgI8cx1Tj6sPN
 k6OY5BNhloRFloWMJEQVdJtva8iJcyy+bdgRlUL+I38r5NSKOFalsAlyhNeEmoFgwviEjsFYs
 iRqoEh1bIcCj3eLVv70ROcbtJTCuThf/F2YyO28LQwDXSDT7GGrlrpXbTDhZUBD4CQbLIOBVD
 zZHcYyZZZR8FTQ/wG7vy1Uv7pKWlcQRBQQvzKL1AVazxbPlTMiinI6g7rcv4HVpc1PCQfZ1XD
 P59V59y4qXeuYZMMl7D3TJnwk5nnQcstfqyP61RS4oxL7csSD5Dy7JaeoIrKB/8n3pcQLIjCB
 Gt60lpI9O+zp2Dve9
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/24 =E4=B8=8A=E5=8D=884:31, David Sterba wrote:
> On Fri, Apr 23, 2021 at 07:36:29PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/4/23 =E4=B8=8B=E5=8D=887:29, David Sterba wrote:
>>> On Tue, Apr 06, 2021 at 08:35:59AM +0800, Qu Wenruo wrote:
>>>> When adding the comments for subpage metadata code, I inserted the
>>>> comment patch into the wrong position, and then use that patch as a
>>>> separator between data and metadata write path.
>>>>
>>>> Thus the submitted metadata write path patchset lacks the real functi=
ons
>>>> to submit subpage metadata write bio.
>>>>
>>>> Qu Wenruo (4):
>>>>     btrfs: introduce end_bio_subpage_eb_writepage() function
>>>>     btrfs: introduce write_one_subpage_eb() function
>>>>     btrfs: make lock_extent_buffer_for_io() to be subpage compatible
>>>>     btrfs: introduce submit_eb_subpage() to submit a subpage metadata=
 page
>>>
>>> For the record, the patches have been added to 5.13 queue a few days
>>> ago.
>>>
>>
>> Josef had some comments on them, most of them are just related to
>> introducing a new subpage specific endio function other than reusing th=
e
>> existing one.
>
> I haven't seen any comments for that patchset.

It's for the big subpage RW patchset, which includes the four missing
patches.

Thanks,
Qu
>
>> So I guess if I go that direction, I should just add new patches as a
>> refactor?
>
> Yes please.
>
