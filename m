Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8773F53A4
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 01:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbhHWX2k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 19:28:40 -0400
Received: from mout.gmx.net ([212.227.15.15]:49973 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhHWX2j (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 19:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629761273;
        bh=wGyEyx2UFE+Qr5FGkk+WmXb5g7QebBwRk8/mGK1ycoQ=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=gqyct3j+YLh6ioZ4L/T0QrZgIRgh0Ds8jENOWh/ujNbvvby1ovmXEOq1OOweAy5CE
         cWl9hagI+sNGH2aC3lBKosGE4TQWqEYZw4nZ6r0jk6TihDK2oI4ELWFMAz8cSOY6MS
         ePCdar/hmuYNn9eZA85ldpB70p/RLEfRya9HvgIE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MbzyP-1mtYaF3ozP-00dWDb; Tue, 24
 Aug 2021 01:27:53 +0200
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, mpdesouza@suse.com
References: <20210822070200.36953-1-wqu@suse.com>
 <20210823172420.GL5047@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH RFC 0/4] btrfs: qgroup: rescan enhancement related to
 INCONSISTENT flag
Message-ID: <ac47fa45-e2cf-a2f0-046c-60a77027c9e9@gmx.com>
Date:   Tue, 24 Aug 2021 07:27:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210823172420.GL5047@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V8qLfUE3vIIQ/TSelz+WA0ZmMGjti6r2wpH6fax2nSmNKEfWGQY
 YTiKrfX/2jatHXejxeomhSlsK1lssdSHvxkcCup+Vbv3a9WgsLoqeuNjNpccw1bFn02pXtD
 7pluZ02IMJzVV8FM2GSwfE7U/f+2IQpYD3a2dOH/Igo7xU8ivIcRqFWGED5w0vFtvVth0/6
 kERWZUkY4Hv+5+LSFC1aw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:d9OsWFl6FXU=:HYGaMyo1NWx7W9vpzTuUPl
 blNXf6Hj6uFsOse7sPW1y8B21mFZFYNp84E83s/pAcwtpXoFHp9Bjk3oQv+ISq9uk+5QqDNOx
 2cKkXsz1Ry8Y4qjyJfxtf/B3sVqpP8770zqjadj3QoOaJ9Ktli+Row9VxYW6QjSbTgzkrzhU6
 O7qppVeXPnD/xLfh3V+fiOtV6SklUJeAfeLYBvSLiumY6CHjzJCAfrMK4Z76Th0AqfFOhnErs
 qat/5KW5QbYjAe9ufjYsJKQPUKCCHcoRnvvHocyhuQ8CdhhWUYts7dRyuulJ+ONVmmdfPmVLa
 SszLY7JfLcOv8qKSETK9Wk3Dt337uaicPWOP0cik5s4k9pdZXsqonqeVYeECNZs7bpW4B+5I+
 +7P72GX7zph1x14rAJwB39z7uYWC3VD4mW8j5yD4fcp/YcxYDIAhyEVAJ8xbr+8ROoYcJLpVP
 WP5hb5lNM9jJQxQU3886Qk0hDYdghxiB1zUozbEUSYOPuiN2E9dspr+YsFvatqLe6fEx4K4K+
 FVwM7H5K0jvJ+LA2Uc1iRChn2oW1Ph4/7gg6RhQU966KOMaYA9BMfZhCtjkCmVKvPaKgMONZO
 AL65AfjtpTO+P0gd35DrZuTSE9330ArXKs8skXCu0gtcjE75mOIbZPF4zJDAUXHmn62tF7peI
 tPFj20aWoHDZjC8lPqgUq4KGy9gar/3jBrhqd7AIufQKDwOMiSkZmvWM1tRZpF72cjFsL/jAS
 8wo+Hx5w09kVigxLRrJ4Db5Q63U0juEc9ALEWUAn8OwJTfHhPlHKFtW9W51pDnHc6aI45SGLT
 HXJsPU+YFKF8ktdZTU6JhWGbT+n2Xuxb56WnilWCt3euOX4BE8M41OgdLOClESiAngzzIuGDX
 voM1BTILv9UmsgR4mxQLRiTQxsf8GNuuheTQjNKHZWZbsa7aYGWNgCHcVgPLlNmZ9DnrCECuy
 h0Hj6B4ZFOiXFCi+n8LHQGWd6ZBi5wKaZPooowmInQCgm2uxby35B5p8smDrGEXP8osTnp9Yd
 8DFDLzVOnDaksv3WndAY1KFXCUoiFsrb+9e21EYOAnIhf6ntwlOxtDkGMltIyZaS6TYf7P9z1
 uNuuv102v03I3fuVS8KZRNJ6UcQ56q61IT7tzJH2h4hb6/kim9T1U9f7Q==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/24 =E4=B8=8A=E5=8D=881:24, David Sterba wrote:
> On Sun, Aug 22, 2021 at 03:01:56PM +0800, Qu Wenruo wrote:
>> There is a long existing window that if we did some operations marking
>> qgroup INCONSISTENT during a qgroup rescan, the INCONSISTENT bit will b=
e
>> cleared by rescan, leaving incorrect qgroup numbers unnoticed.
>>
>> Furthermore, when we mark qgroup INCONSISTENT, we can in theory skip al=
l
>> qgroup accountings.
>> Since the numbers are already crazy, we don't really need to waste time
>> updating something that's already wrong.
>>
>> So here we introduce two runtime flags:
>>
>> - BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN
>>    To inform any running rescan to exit immediately and don't clear
>>    the INCONSISTENT bit on its exit.
>>
>> - BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING
>>    To inform qgroup code not to do any accounting for dirty extents.
>>
>>    But still allow operations on qgroup relationship to be continued.
>>
>> Both flags will be set when an operation marks the qgroup INCONSISTENT
>> and only get cleared when a new rescan is started.
>>
>>
>> With those flags, we can have the following enhancement:
>>
>> - Prevent qgroup rescan to clear inconsistent flag which should be kept
>>    If an operation marks qgroup inconsistent when a rescan is running,
>>    qgroup rescan will clear the inconsistent flag while the qgroup
>>    numbers are already wrong.
>>
>> - Skip qgroup accountings while qgroup numbers are already inconsistent
>>
>> - Skip huge subtree accounting when dropping subvolumes
>>    With the obvious cost of marking qgroup inconsistent
>>
>>
>> Reason for RFC:
>> - If the runtime qgroup flags are acceptable
>>
>> - If the behavior of marking qgroup inconsistent when dropping large
>>    subvolumes
>>
>> - If the lifespan of runtime qgroup flags are acceptable
>>    They have longer than needed lifespan (from inconsistent time point =
to
>>    next rescan), not sure if it's OK.
>
> How is this related to the patch from Marcos?
>
> https://lore.kernel.org/linux-btrfs/20210617123436.28327-1-mpdesouza@sus=
e.com/
>
> If there's way to cancel the rescan, does this patchset fix the possible
> problems?
>

It's a coincidence, as my primary objective here is to solve the final
piece of qgroup slow down from subvolume dropping.

Although the solution I take would not require ioctl to cancel a rescan
and also works for cases like qgroup inherit.

Thanks,
Qu
