Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6405168F1
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 May 2022 02:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356190AbiEBAD1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 May 2022 20:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiEBAD0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 May 2022 20:03:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1451F42ED8
        for <linux-btrfs@vger.kernel.org>; Sun,  1 May 2022 16:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651449587;
        bh=gIHMR6xQ6TWedXQL68i9iiG6XJY4zp2ebdVWyLBBZdQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=LBcu3q/OYFBSVu7S5+0qH7zZqnRugwVFoaL+Nq9LnqiT8ZzNSwa5kIRz0hOFk8lmT
         FfoiGVa0EhfwNj68b5jGFPT9tn1BSZ3vykXxrW5ZJimoDVLnpska7odb8D29Pc2wp8
         LVZUtdEg1c0SEcYOg/KepcuMUh4JGQZXEYwt9PUE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZTmY-1nNkAe1S8U-00WRvO; Mon, 02
 May 2022 01:59:47 +0200
Message-ID: <32e7a9c3-00b8-9e59-276c-ce5965ccb92a@gmx.com>
Date:   Mon, 2 May 2022 07:59:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH RFC v2 05/12] btrfs: add a helper to queue a corrupted
 sector for read repair
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1651043617.git.wqu@suse.com>
 <a136fe858afe9efd29c8caa98d82cb7439d89677.1651043617.git.wqu@suse.com>
 <2fd10883-5a4d-5cbd-d09f-7a30bb326a4a@suse.com>
 <YmqaOynJjWS2XB76@infradead.org>
 <4ac0c01f-73f6-e830-f3bc-6281bd79b7d2@gmx.com>
 <YmwAzU+UORfX92Te@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YmwAzU+UORfX92Te@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8ov3P5nqNxkqcGFI7IR/hMbUZzay1H+x2vnqFfjFkiQzKFv1bSi
 8pnxd2tSW/keMG44vX3xL04NVVKUYUg/oUNBUT5y3C1/6/G13Tt4jclmjHQrwa7rQ3learK
 wD4aj4k2MhzjbEEaS8H5JKDIuPQ1aQr5eKjrR1L4pAYr6jAtb3C6QL7a3MdUv05FOKFFLmp
 kUWnxaMQ6gyZeqEKQ/zNg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g52KnOAcDdE=:T/lR3VT5t5gfwtI2tzgiOu
 3aGHCTth185VVUwg0XLqcnqYbNvcfXFJH467FE+HkU5Ye4wtvEFiHHd2GaCrJ/KZq1VMGQk/H
 Y59yoWpDcmOypdQKgQSVq3DKErtP7iDFPzzCuckzD3ZyX4xTaraz195TrDXYlJ2fTp4tjHbHU
 JAu3uxvllHjlR1eeuBqxRj77cu9GVbp35KmCwJS25ghb8GfcXDIJ2nKcDhMV88Co2kBv9BgzR
 3QuEx6A279ocGiYi9NCr3juhKANgNUtCKTsvQpZAEWEub99F/DPgryAgSZqSnbJSwVdDxCVkg
 mWBtJxXfCeEpuuJbLufTuD6ZEJgKCz5pYIeS3Nv+WRJ7YjUC8EVlXpeJoO8uVP83k2w1GDWM9
 lNmNADRnMEt6kE9vXa5zGN9GNIEpBJvK/R6v0933YlOQwCrK2fdGUSfwWU/UMVAPOjm+q1yLt
 FsLl3UnuP9sxoJ/cO9T3uboHg0YOM8x9OKyT4quAeciFjPZEleSJDEPe2eKeMNIxL+TK5Gggz
 1X5E/StLBrjhWd2SoioS/0OoC6SS5u877qOAgG7WylToW9VU2A7HsKLK43S/mXXD0p1WYB5Og
 Rp6s9DqNNAKaZut3l76zyg9bpVUaX7wJL//V4mOBL64Yxi6xB0gzD91pNoyHjUflhUsfy6z+i
 AaZjHOjlNQJMJ8oUps7vIMpIO9ssUZwdqAnQA48Fc0RYAJ4/QiOMMFUG4SyfHq4AMG4C+3Jgz
 4eUzim7lbN+NJfoxLokwm4IP4oKGs0FCdZrRU0fnkqQ88WbdiMOveQ2I7sl7fgL0y6dL2osqr
 kwHiOSIXgKTVTMa2TDN0PxTdYDqxelxGgMU3nHFHSAQ8FZOcyyh4Dkl5BbfK7KIfTxDQXaMIn
 Puq44xHa+oDo94MzyCcIWzl+lDsRpq2CWt08HQvDoxfG5wOvQvbkIE4xLbpIPuYJRmkQmRrPM
 dbjFZ5NxsGWEpGZOmngpuN4MovLap3vGMxKNd9BOb2FXY5UnfNx4TSYsP+2rOgUIc6H6bCaCv
 CGJG+u3ERHoX/JKKmBwSSnQfitzlHv1hassXzTVCPzL0C6u2iUyuN/dh19Qa0PMj9/MYEPILe
 fczzT+I+wTq0TI=
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/29 23:14, Christoph Hellwig wrote:
> On Fri, Apr 29, 2022 at 06:55:59AM +0800, Qu Wenruo wrote:
>> Another consideration is, would it really dead lock?
>>
>> We're only called for read path, not writeback path.
>> IIRC it's easier to hit dead lock at writeback path, as writeback can b=
e
>> triggered by memory pressure.
>>
>> But would the same problem happen just for read path?
>
> System with sever memory pressure needs to page something in to get
> something out.  The readpage uses the last available bio in the btrfs
> bioset, but that read now needs a read repair, which needs to allocate
> another bio from the bio_set -> deadlock.

So with your previous mention on mempool, did you mean that we allocate
another mempool for read repair only?

With the extra read repair mempool, even we exhaust the last btrfs bio
in the pool, we still have something like btrfs read repair bio?
(And we can get rid of the extra members unused in btrfs bio, since what
we really need is just a logical bytenr and pointer back to
btrfs_read_repair_ctrl).

This sounds pretty good to me then.

Thanks,
Qu
