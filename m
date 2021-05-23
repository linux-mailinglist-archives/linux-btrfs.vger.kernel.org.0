Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC5738D97B
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 May 2021 09:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbhEWHmG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 May 2021 03:42:06 -0400
Received: from mout.gmx.net ([212.227.17.21]:37413 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231628AbhEWHmF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 May 2021 03:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621755635;
        bh=49MjlR1HRF6lznE/wD0j46XTiJG464KSHiz6fA+Z0mM=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=CbrMTkY8l38W80FsUiRp4mEj1xF8QpWqBTA9151/+J1/nWC6oi5o8g/84DW0rTq0Z
         M+4KJ6pACoKrmjw0g23E2eqLZCA3mQ13+Le751Z4w2nmNpkMlUpODlptVSas4EzPZz
         YyNGNeXcyQ6EF8hs99EXV1FW8Q63B5A+ceGD8Kqc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6Daq-1lmwiA1XJ2-006c4n; Sun, 23
 May 2021 09:40:34 +0200
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <20210427230349.369603-1-wqu@suse.com>
 <20210427230349.369603-8-wqu@suse.com>
 <c72f998f-88c4-8554-815a-d2c25c651393@toxicpanda.com>
 <11a47593-81a3-12a9-a3c9-a6d3316922d7@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [Patch v2 07/42] btrfs: pass btrfs_inode into
 btrfs_writepage_endio_finish_ordered()
Message-ID: <0543dddf-d86e-fcfb-42d7-57b2e8993997@gmx.com>
Date:   Sun, 23 May 2021 15:40:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <11a47593-81a3-12a9-a3c9-a6d3316922d7@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SD/5IY1tAQ64aKBRP1UTarH0FU4gP2EghPQg10itaSow8Wex0Id
 3/7Qccpy4LD9LaldtgYaNYiqO31Xvl2iPeUR9gpfb6TzywKhq1FdB81LuuOU99p/slEkodL
 MOcJ9eQd9+HQj8iwW+T8+7d7NH1muRr0chtQIiogpe1wC/3/d3/1l0StY9kMvzbFUWGmv4A
 unqGUktG1YyJxPcc9IHNw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tmcdEQz+SYI=:w6jksottbGaEYyFOaj8xvk
 Mw7An3zY184IJomjzHQY8DAisiYyB2hIJz/KuSHkT5H9Qo4qpZWZhLYy5SGCkf3iuqrBIqe2F
 peYij/s8qQvs7ejl1WJP/Inoor4HDy4cBWdrZkGUs19/9nrUre1a4JeCpAlH56MgAFpbiYDIE
 uQPHKPkzPa17vle1mT+OXSEF60yG8pVdxiCKAj0s342hFEDwK3QFe4zBO6NneZ2p9FqEMAnqP
 152dPjsgkm0ZKhQzF29lldkTaWO3iEEtGIhv5/oZFE4zut+LKT34rNU3LfzqJgKMlcznH7cMQ
 A1eFgo49/1AozbkIOkHCVJEXTQQE0oCvt5MVPZ3J/bqW3XuRxwuWc71aZqyk5Seo3lZ93dL69
 McsnDDVhGgTYMGr8zP5//PXgfLUJObpCdD9QZmrPTAGFC8bAb/5NX8sgcqlf2YST6GKL/fjSb
 spzHNhJ1WG2IOrnVw+AaN4J8n7Nn1m/FcdrFkYUv6x/mIRGyZZyRla091IsVvUkW3HcsSwVNv
 qMbXadJy1H9IMBTjFJ87AvY22O9A4MaliTEA/KCqpN/4t2L/d4UlBOawRrZnyuI8ucFkSxGi3
 gjLhie98lu0UCBGegGnwjEmXZSOqv7WMM5mfxNqJNAYwXTncLIF9zeFko1i9vS/dBQMXjkx4Y
 MZiLIbMs7An8Wf6/7VWtglARsjvQQ8GvGmf/ZAVgshuHbYQboejoqke2C/uLte2dhHmfxxZhv
 vvR3kJRxSYsn6azweEQFn9LI2qGF/oBwsPh5tYlVTCx2O/xBj5vkd04ENsD3QmieSc0gTeZDI
 QN/OyAD+7ZzOEMPN+faN/OceFivgdroACIuXG1e8DA0g0m2Q8KW2pm6QwnWYPxtPiw09z1rpT
 6jtSJzFxb4tCrAysV3aDkyv8gfcYBr6OKdL1/bVLKO30VkOKNx8nR6FD/0ynrWKW7StE/dNJP
 29eh1AhN1uUTN1M5LZf6AR4Cd+kSb3G0rLkM/hhapEcVG2dZX7XPZAOYRyOpYHkbYjwMBApVd
 PLm74T6XopTIf6LcufoInG8PLTu2I6g4nEQSo1A39VyvRPGdCXadF6oD4p2anv18fDonPwzVQ
 k/6pv1NdnR5ykLNDLikysGbfn71O+8H1xr93pHsLcIdf/DAJ/HXfSbLUvvyG5pPmq1fWnn43M
 0qrBwJfg9a+rAgO+Jv7UYJWI/O2jvEbK8aREIEaQHLKKKfUxMXFGMe3gTcZyJDxiR3bjeLa9q
 c36rqfj5fnhEwIm5M
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/22 =E4=B8=8A=E5=8D=888:24, Qu Wenruo wrote:
>
>
> On 2021/5/21 =E4=B8=8B=E5=8D=8810:27, Josef Bacik wrote:
>> On 4/27/21 7:03 PM, Qu Wenruo wrote:
>>> There is a pretty bad abuse of btrfs_writepage_endio_finish_ordered() =
in
>>> end_compressed_bio_write().
>>>
>>> It passes compressed pages to btrfs_writepage_endio_finish_ordered(),
>>> which is only supposed to accept inode pages.
>>>
>>> Thankfully the important info here is the inode, so let's pass
>>> btrfs_inode directly into btrfs_writepage_endio_finish_ordered(), and
>>> make @page parameter optional.
>>>
>>> By this, end_compressed_bio_write() can happily pass page=3DNULL while
>>> still get everything done properly.
>>>
>>> Also, to cooperate with such modification, replace @page parameter for
>>> trace_btrfs_writepage_end_io_hook() with btrfs_inode.
>>> Although this removes page_index info, the existing start/len should b=
e
>>> enough for most usage.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>
>> This was merged into misc-next yesterday it looks like, and it's caused
>> both of my VM's that do compression variations to panic on different
>> tests, one on btrfs/011 and one on btrfs/027.=C2=A0 I bisected it to th=
is
>> patch, I'm not sure what's wrong with it but it needs to be dropped fro=
m
>> misc-next until it gets fixed otherwise it'll keep killing the overnigh=
t
>> xfstests runs.=C2=A0 Thanks,
>
> Any dying message to share?
>
> I just tried with "-o compress" mount option for btrfs/011 and
> btrfs/027, none of them crashed on my local branch (full subpage RW
> branch).

A full day passed, and still no reproduce.

And this patch really doesn't change anything for the involved
compressed write path.

And considering it's the BUG_ON() triggered inside btrfs_map_bio(), it
means we have some bio crossed stripe boundary.
It may be related to device size as that may change the on-disk data layou=
t.

Mind to shared the full fstests config and disk layout?

Thanks,
Qu
>
> Maybe it's some dependency missing or later subpage fixes needed?
>
> Thanks,
> Qu
>
>>
>> Josef
