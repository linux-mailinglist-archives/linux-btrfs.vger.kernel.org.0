Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7763A12F332
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 04:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbgACDFT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 22:05:19 -0500
Received: from mout.gmx.net ([212.227.17.20]:44863 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727234AbgACDFT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jan 2020 22:05:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578020683;
        bh=RrzqF5T7J4qBmU0ujsPOZcK52c8cQhA5NLO6JB+v4tk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=DV3JoOrvp+cW0aYGDB6+gDSSatTzkQzmaz3DVZRX+jJ+5EH9has2Pl78wN7kDhIzs
         Fku1IKFjCLWEHJ/Pmq5kN6avavgN4sPscgOqhCwLW9C0F8weLw7avFGEjzrib0EMop
         Vj5MFbfcZTxFQmndtzZROh45ulB+Kegl9BDu07Ag=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.187] ([104.199.231.176]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M1po0-1il0L43glM-002Dgv; Fri, 03
 Jan 2020 04:04:43 +0100
Subject: Re: [PATCH 6/6] btrfs-progs: extent-tree: Fix a by-one error in
 exclude_super_stripes()
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20191218011942.9830-1-wqu@suse.com>
 <20191218011942.9830-7-wqu@suse.com> <20200102165603.GL3929@twin.jikos.cz>
 <eb9033f0-c390-0d83-07a6-63e89cb2020b@gmx.com>
From:   Su Yue <Damenly_Su@gmx.com>
Message-ID: <24abf4b3-8525-5d77-721b-f97cca22a5f9@gmx.com>
Date:   Fri, 3 Jan 2020 11:04:38 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <eb9033f0-c390-0d83-07a6-63e89cb2020b@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iLxUsjBR/glRi1k4mqc7pVQHVFMbG0C7nuHeNTKifjAl1jZm0Db
 4xvISufvlNPsYV6dXLMcYTu+silNPg4+Lokxnmdvi01uxrORx2cweoOM2aM/T6vHpDmt30D
 JX1rhaiOQkVWqLhmFabs5mcXs/4GTDTG2D38OjEibpfwRjrdIqfiVx3abIovY8LhJta/Zvx
 CmwZr++XOyEaFRz4kifqQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:laeHzR/qa/g=:/HEh4d65wTtpdq0yqp4MN9
 4E/+AnbpwXoXBmJQjrJUAdhYnoxYFGImLNYamGYC9QEuFFEG54fDMuDdPt2+YgFYSRfLT1T5Z
 5PofdKteDztoZ6By7IQeYpocqsMY1w9xImVxpZMFdwhRGPjPIjXFs40y/s2pU1VK47p7Tx4oK
 VzAo2caRQ5hxCj2oUzU6sK/94IQIyDdB9loK7OmWPJEyE+qIqegNF1e53OZbL0nug5nivDVSr
 3XYHGsg/O0iyjkR+8d+mq6be+V9LQ3Ttv1mURTmKLNnDTELeLmVMmRrHok08/urOpp4iyedXq
 xrAAvaKTXA+ewcJLAR01VLOZeBND1oAZivMG7+TxCwC32CeeLytjTCIONZG4R4U61Rq+tEXUP
 zBY1/uXkOkkgdnSvTUOH759SuFRCoPGytFzL/TI6VjY3pxhhLQ9RdrQproFUHbgvFBUtoQ9YA
 HEZlxmTmjAh3e8sxmUW/eqQliKuI6WJqWTpsSpnLBY2WUbFsr9n9I8CMQyk+Ne/uZ+goSVQB8
 arRc/IwVHFltzHZmAeKObAWf1oQ/JT9vvYFuDSSVmyz3Il6syy6yoek7S6nTf0dmCWmx4CRrJ
 RxOkH4vi2qoYjYci2x+Uhhdg4SwLaqW69TprVaYzkg5TaDXJOsS0KD6NCZKCsM0Gb3CazmOel
 sK1e5iR84iHwnWbCCon6amhIpIVcgDhmKN2BZkPOllJ/sjZR3UEVchR+1BWQqkBcmEiZ7Ni2N
 C9I4DJWr5ewG/FrRuh7LabSJ3vEskUwZ1VosV9kzeVFkHKIUMxhbEvuLGGzA1pNEMdsvCIOB/
 MFp/TixYCj4NZM7XsnFquqnR6lmTX+WWe0Mvq0o+sYO54rd/DPqM5JcMRVZNfMHuNHuVddTjL
 GgqPiZ47NP0JEX7BF+0tevA8GFIvb4CbCXC/DvnwNZuPxTu43H+8rj2EUpsFT0bOfd69iqviv
 gP6KbOGO0t3NqIYqmVD8HYmMvY6wsoJ7PlvvnbV37TiKzEz8MqAyh4FpvDsD8PM7DCDY4CUGC
 KarnrVxTqrBsDxFlsjvGe8SDhE5ySdQUoHGg5HQSk65e2N7tQDuvqyg+rr2g0FznFj8EVnjcu
 YjXBhRDnHYigoFnlIj1+VHPj8ovdP+BeUHS59n7C8eJ6/zXsVIA4QB1YNZYuHBKrc4wiKbUBj
 LujY+wonjqRFDTsxJPclhuB1bHF+gZroZEGUMhbz62Cj0UtjwJfMV1LZlauIKULCRQTxBvrY+
 W08cqiOy8vwfqKCMP/WQW4kLICZK1nw4ey/LmZkN5bMPWdLM/5q8nIAZIrhA=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020/1/3 8:42 AM, Qu Wenruo wrote:
>
>
> On 2020/1/3 =E4=B8=8A=E5=8D=8812:56, David Sterba wrote:
>> On Wed, Dec 18, 2019 at 09:19:42AM +0800, Qu Wenruo wrote:
>>> [BUG]
>>> For certain btrfs images, a BUG_ON() can be triggered at open_ctree()
>>> time:
>>>    Opening filesystem to check...
>>>    extent_io.c:158: insert_state: BUG_ON `end < start` triggered, valu=
e 1
>>>    btrfs(+0x2de57)[0x560c4d7cfe57]
>>>    btrfs(+0x2e210)[0x560c4d7d0210]
>>>    btrfs(set_extent_bits+0x254)[0x560c4d7d0854]
>>>    btrfs(exclude_super_stripes+0xbf)[0x560c4d7c65ff]
>>>    btrfs(btrfs_read_block_groups+0x29d)[0x560c4d7c698d]
>>>    btrfs(btrfs_setup_all_roots+0x3f3)[0x560c4d7c0b23]
>>>    btrfs(+0x1ef53)[0x560c4d7c0f53]
>>>    btrfs(open_ctree_fs_info+0x90)[0x560c4d7c11a0]
>>>    btrfs(+0x6d3f9)[0x560c4d80f3f9]
>>>    btrfs(main+0x94)[0x560c4d7b60c4]
>>>    /usr/lib/libc.so.6(__libc_start_main+0xf3)[0x7fd189773ee3]
>>>    btrfs(_start+0x2e)[0x560c4d7b635e]
>>>
>>> [CAUSE]
>>> This is caused by passing @len =3D=3D 0 to add_excluded_extent(), whic=
h
>>> means one revsere mapped range is just out of the block group range,
>>> normally means a by-one error.
>>>
>>> [FIX]
>>> Fix the boundary check on the reserve mapped range against block group
>>> range.
>>> If a reverse mapped super block starts at the end of the block group, =
it
>>> doesn't cover so we don't need to bother the case.
>>>
>>> Issue: #210
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>   extent-tree.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/extent-tree.c b/extent-tree.c
>>> index 6288c8a3..7ba80375 100644
>>> --- a/extent-tree.c
>>> +++ b/extent-tree.c
>>> @@ -3640,7 +3640,7 @@ int exclude_super_stripes(struct btrfs_fs_info *=
fs_info,
>>>   		while (nr--) {
>>>   			u64 start, len;
>>>
>>> -			if (logical[nr] > cache->key.objectid +
>>> +			if (logical[nr] >=3D cache->key.objectid +
>>>   			    cache->key.offset)
>>
>> Do we have the same problem in kernel? The code does ">".
>>
> Oh, kernel looks to have the same problem.
>

Gentle reminder to save your time.

I saw the '>' as in the kernel code and send a patch for it.
Then Nikolay pointed out that the patch is unnecessary[1].
The fuzz image is rejected to be mounted by tree-checker earlier.

Besides, a cleanup series[2] was sent by him.

[1]:
https://lore.kernel.org/linux-btrfs/24721dc8-8bda-a086-ff1a-31a0b21a02b4@s=
use.com/T/#m4cc5153d1645177e0f81f00c86e10dfb36015def
[2]: https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D20510=
3

> Time to fix it.
>
> Thanks,
> Qu
>

