Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70CB540BF84
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Sep 2021 08:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhIOGDx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Sep 2021 02:03:53 -0400
Received: from mout.gmx.net ([212.227.17.22]:50105 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230381AbhIOGDx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Sep 2021 02:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631685752;
        bh=bfghdO1Q9G6pvA7kuK8vX7rmUloqCD+yLJeQRTfWqX8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Uq67OmJZlnW05E//vmmBg5f4xNOUPbe5EFcTYy8T460gdHqDX5zppW5ul6YzlGFlk
         eHB09ZWvf1mdV6EWqkWwwxmMWXzsFVuKOzS+8QQkIf+zjZT8nwwqMxsuYPpFLjBfSz
         rAG7iCa7pb4YSARNlvPRH31oV49YchgHrcvBXbco=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7K3Y-1mY5dL0qHk-007o5B; Wed, 15
 Sep 2021 08:02:31 +0200
Subject: Re: [PATCH v2 1/3] btrfs: rename btrfs_bio to btrfs_io_context
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210914012543.12746-1-wqu@suse.com>
 <20210914012543.12746-2-wqu@suse.com> <20210914164201.GF9286@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <a497de2f-0906-44fd-2f6b-0a1cbcbc9666@gmx.com>
Date:   Wed, 15 Sep 2021 14:02:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914164201.GF9286@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PFlVt8USqAK/nNt029lMIaQ6z2hibYXwU8S0kBDNlWjNwJfBAiO
 /ONbCiXHNGlgggsnKFThJufd+xTYBpkb8QS2sSK5hzlHQt0ee+X8TtL0MpJCR3FprWJh/+J
 reSjAiqr3rKFsQU2jk8U3xuDE2CRieKOiC7s4OYbes0oSUyTilKMJYaJVVZlKhrJL3GkmyV
 7bsq+CSVuZiGZxhKwltfQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rLCkiCbIcpA=:8c7MY7ULef+0l/4vCqy1U9
 Sq/yZ5aIO3JS59x4646hyTqwJCW3GosRNI6DcqM7DV+TLPFh+qcjMWae7iAjk+9qcLHHpAxNd
 tJnfbpv+onKb0cnYGIGzL9nPhfM+9McuvhJywvq2ZLtLkAM7435y/8/gmNSZ1qyb9xI/rHPgd
 e/e9JYktB7sUvSPs9kAAIYytBsQpsS7cfY1eShFke55P2eWYT7HyF1gWfpFGYGhZqknROiERh
 N/uTtXMe0gmVD4oOcyisWfaxP8L6I4xL/s0++0/xvK0AQ8OKZuK4QYe8stjkcsORit8c9o4PE
 NdQl9PeHVmkVxnGcdHmpBujGgpVM9lhSUeejmX8U8o7Zu35mK3nDzHQrhQfjObhxy3EofXkAz
 PF8+6kio//2J1xfgfHZOh70jXFeMoqfhLOmRl6Md5b5yEdG4Hax4hbW28eWtuZmsda97F1RPF
 bBzCrrlqXdQlZOGhvi3EE2XSUCAr/n5rH+XDZfWVObmW90xAieGumG60nRwSsKE8tkjWWZFbF
 wO1EFmcM3mk9uY+7FM1ZoYN89BkaOlvK1+0DLMs2sQIXIJ8xFtD9wGhxmML3LkIWN/3v6Nf3h
 eCUJuoD5wjK6hCbkS8/C4+LBEfcMl08d33f6EGuRZ0BgtDyNN0kbgybupQb2/uBWxxMmRQjWF
 iB4WnjFsFsypY3X4MymEKdSjjZZI3JHgISHzuAbC0YGL39YvZNGjATu9a+b/9ZQb4XoXACjPI
 7LgYHD4xTAzFc+/ZSsaOl3kZo9pt7JTZX8kPqp59Yq/NHoCSVjd7gaSLyR5u1eiPVhZzjrps8
 aUWc5ct1OMUGD6dGCRFQN12iFOTDPcJ+oLH7r2egwrOY1CrmDCa/wK6LJovUUFd6FP976gmb+
 7FZk9fHtd0UJ1oXLdqktkagb2zgjULtzVKAph3SFc6kCw/IbZewGVnKsovmrfV+T23wJzPMgy
 Xsxd0xSxRwFOhfPHJDymGKEUoCCRSi1KSOL5OKmrtyBdNObyENVRHTkKLSpbcqEG0bTALjbHJ
 hlMCOrCwEVnup/5hHIAKgRERxvbAKFMgFl1vt2wM8Lqi8aHPrONH6Cbhku/epKJt24wN8HQFq
 j123Wgt5Vj+D7A=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/15 =E4=B8=8A=E5=8D=8812:42, David Sterba wrote:
> On Tue, Sep 14, 2021 at 09:25:41AM +0800, Qu Wenruo wrote:
>> The structure btrfs_bio is mostly used for stripe submission, and it it=
s
>> used by SINGLE/DUP/RAID1*/RAID10, while only parse stripe map layout fo=
r
>> RAID56.
>>
>> Currently it's not always bind to a bio, and contains more info for IO
>> context, thus renaming it will make the naming less confusing.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
[...]
>>   {
>> -	struct btrfs_bio *bbio =3D rbio->bbio;
>> +	struct btrfs_io_context *bioc=3D rbio->bioc;
>
> This looks like a systematic error with some replacement expression
> missing the space before '=3D'

All my bad. I get too used to "dw" of vim, which will also delete the
space after the current word.

I should use "de" instead...

Thanks,
Qu
