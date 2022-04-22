Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D1950C4FE
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Apr 2022 01:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiDVXXn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Apr 2022 19:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiDVXXZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Apr 2022 19:23:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2631759C7
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Apr 2022 15:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650668309;
        bh=JjcDOXzblS9KCS50jKcVSNPOrP4FtymSKlKDyOCsDeU=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=TuUzOl+aXqxJ4JZHWws9nsCPEDhf+wXzDgPUSskXgZ4zPFKb6kBGEcqO3J61laMkL
         yBo0gms8fV8Hldo0SJWppXpC54twWnyAoL7aysp+GpOSsbx9F3UvbJFl4c6LVxfqH1
         qbKYFA+203077I4yv+jcov+A/K0u5mAHnFPdHe7I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1McY8d-1oKPJx1IU9-00cusF; Sat, 23
 Apr 2022 00:58:29 +0200
Message-ID: <6bd7fdf2-62eb-d109-44bb-21a9eed09d3b@gmx.com>
Date:   Sat, 23 Apr 2022 06:58:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/3] btrfs: simplify WQ_HIGHPRI handling in struct
 btrfs_workqueue
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20220418044311.359720-1-hch@lst.de>
 <20220418044311.359720-2-hch@lst.de>
 <03ea07cb-d724-26f6-bfce-99befb3ab15e@suse.com>
 <20220422210525.GL18596@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220422210525.GL18596@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OQKgajLFgsR9ifjzD2EjTC730GSmhtaCSsRVvhE10Yth7f64YdZ
 1qT/l1UdvzaCRghKrRckHOIaDLrhlGgY6X/OIkQgmT83VKGvjcNSZVPrnGLQIdGDf7dNDWr
 od4Ve7tq/U/k8h+pn3j9zXlp29hNACY28OKjWRgxREdr0CKfhrjqv+6QQ45WOFi+UDq3n/s
 6Rdn1bG++7NXjG2jPXYrg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ku2CD5qVXMk=:lVMrng9G6b1folgecH/8Xt
 ETIXEAPfsiziYhG2uqK1DTvw29CkHHlcLfM3RXQQmIT4qO9b5FSPdzQolitebOpK49anLXb8R
 DdAP6MhwmvczpCVHhAdGerrzj0zbBLlQR/hQ0864pohSkgMgsVW6/QAsmWvMfEwlpbph2A6tu
 UyfayzhUuV6JRIhNv+S1NGTtf2Zllm9AQNxzltxbEFCwh8vlegaKz0N+U0SYBowkxw1mBsTfD
 fblOo1I439ywPv/AXa56gsr97EaWNOedoLCC5jEVJBaPvlY4OneaX433AK4mGxwZExgE18m8S
 zL5gfn/TVfSHMfrbd2JF8/INbFT6fcn4WBssdH0dKdr5DrnUlOBSwfifYiHF4eBVSnZP+clZt
 Dsawjo5/NxQLs1WeIUsYtxc7Foi45u9XgUxdAC5+8dU4YfuO+0Yq7xkxhI/0W9i6ueCcLIad8
 7F3M3BNQP3xgVFyQus9qDtrgKN+GWQEHIHl7W115tBiZpi0c3hRXP7npDkGUvnmQBvTrACuRP
 piBoBY+F1Xibgb8Y3eREuN+zO4tTsrZwmP035pPDWoqLBHcSTYcgY406RV0MSnMqqcig90j2I
 uVmMMlk1KMJsy6wwXl9i275apiqkb0DxIPAbtZUmHpJC5q/bNuNgioX6AEcY5/FQOIhPMnHMe
 8KCmxYfRG+L3GU4kjhQBLLs3JRT72U/XvmBYbKNWHRBiOZdeRrgYW7iQIS5RfOC7Icccckda2
 17wEmj10F/CI34OVrOvZ+5dn/3+RJekh01+f2blI+vdrInWQeLGkQRnr1kQput0WHaKbclEhb
 ZUwl+ZwOyGqsAjkLhoy37uKMObo+ViPiiFwbHeJWwXtzMcrkjgQ/8a2ZfwuKyQkI/pd1nm5HH
 sq2SRlSXkw+cR5EYSNhxAf/+IoruO/MtxTe69HRCsrOlrT6zM0RNK5sL6FxyNITFlJ6qQhvJQ
 ks5blsXWZVxXMqYI0ww5jXJVD8rrQMropaOowwrCBJA7sNYS0on4zS/5EmGv4hTwK1qmlGoMN
 ZJ4MjJY6dr7VLXlMGZgK/Wq9nbCkTb5LrBazkAEdgBL466ymbeajY1P40X8whZf1HvO6wa3WU
 m86dWI+aMFSoeI=
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/23 05:05, David Sterba wrote:
> On Mon, Apr 18, 2022 at 04:03:43PM +0800, Qu Wenruo wrote:
>>> -struct __btrfs_workqueue {
>>> +struct btrfs_workqueue {
>>>    	struct workqueue_struct *normal_wq;
>>
>> I guess we can also rename @normal_wq here, as there is only one wq in
>> each btrfs_workqueue, no need to distinguish them in btrfs_workqueue.
>
> Yeah now the 'normal_' prefix does not make sense.
>
>> And since we're here, doing a pahole optimization would also be a good
>> idea (can be done in a sepearate patchset).
>>
>> Especially there is a huge 16 bytes hole between @ordered_list and
>> @list_lock.
>
> On a release build the packing is good, I don't see any holes there:

Oh, I'm using debug builds, no wonder.

Just by my pure curiosity, there seems to be some topic on randomizing
kernel structures (definitely not all, that would not only screw up
on-disk format but also various interface).

But for structures only used inside one module, and not exposed, is
there any attribute to allow compiler to do the optimization at runtime?

Thanks,
Qu
>
> struct btrfs_work {
>          btrfs_func_t               func;                 /*     0     8=
 */
>          btrfs_func_t               ordered_func;         /*     8     8=
 */
>          btrfs_func_t               ordered_free;         /*    16     8=
 */
>          struct work_struct         normal_work;          /*    24    32=
 */
>          struct list_head           ordered_list;         /*    56    16=
 */
>          /* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
>          struct btrfs_workqueue *   wq;                   /*    72     8=
 */
>          long unsigned int          flags;                /*    80     8=
 */
>
>          /* size: 88, cachelines: 2, members: 7 */
>          /* last cacheline: 24 bytes */
> };
>
> The fs_info structure grew a bit but it's a large one and there's still
> enough space before it hits 4K.
