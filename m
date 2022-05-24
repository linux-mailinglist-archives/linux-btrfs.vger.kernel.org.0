Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE683532BE8
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 May 2022 16:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238079AbiEXOCX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 May 2022 10:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238083AbiEXOCV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 May 2022 10:02:21 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D53D42A13
        for <linux-btrfs@vger.kernel.org>; Tue, 24 May 2022 07:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653400928;
        bh=jG66rWTPlq48jnrXXZeaGfpNQ9aTcTbjLyG2rOlz4dk=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=ToKnKZ8QB3hgBjgv1K7uMJLrfBd0gJ9YIw5lZY6nN0ZPPPti1n9E2Xy7pSipQospq
         FZAzzRBYBnGfMa7Fl2jYZ19X6pdm1YSai3DYx+7nDrPOIEOynrbChhkdzJuLOeJn8d
         wxtC5AwqkIsY8wew+Qszso0rceXQvcVOf7avOMGw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MrQIv-1nX4OW0AZL-00oYKT; Tue, 24
 May 2022 16:02:07 +0200
Message-ID: <5f138a22-4e2e-ea52-f37c-9de017440a48@gmx.com>
Date:   Tue, 24 May 2022 22:02:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 8/8] btrfs: use btrfs_bio_for_each_sector in
 btrfs_check_read_dio_bio
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <d3065bfe-c7ae-5182-84de-17101afbd39e@gmx.com>
 <20220522123108.GA23355@lst.de>
 <d7a1e588-7b2b-e85e-c204-a711d54ecc7c@gmx.com>
 <20220522125337.GB24032@lst.de>
 <8a6fb996-64c3-63b3-7f9c-aec78e83504e@gmx.com>
 <20220523062636.GA29750@lst.de>
 <84b022dc-6310-1d52-b8e3-33f915a4fee7@gmx.com>
 <20220524073216.GB26145@lst.de>
 <6047f29e-966d-1bf5-6052-915c1572d07a@gmx.com>
 <b78b6c09-eb70-68a7-7e69-e8481378b968@gmx.com>
 <20220524120847.GA18478@lst.de>
 <d966f776-79d7-1eec-efe0-bce1c771bc77@gmx.com>
In-Reply-To: <d966f776-79d7-1eec-efe0-bce1c771bc77@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GZo31Z+bfGtfS4bbkqoK3hA3qZX9fzr29zjtOuskklHfC1sKlNX
 aAO8auoCvYzt0mNGyApRipjLf0YXuv2fw3e9XbUloY/RBY7z1zJYyxG9TSA4V7B9/Hi1C65
 cFc+zamiSkhrbZNf9M8q+IizXQOD375Z3fAcIHyvCJuj6UVntSZytRMkvjStyIGoBJrXmpN
 VpA1Cl/PksZdy5Ow6rUpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TiEts5Yh1+g=:6ylxjLJOm8AVmdavEDdx7f
 13InwPlKzyK3MuTofLiXTt8fJD35qFJtN2CTnBGEY86vpsN1GD1tPNDbvVCqxixaAGz7zmVzn
 M8Sg4nMSkxzCrL91fXtYJgCkltPBMmwAUEs40ZarnC+279zHtRrXKolUiCC8pQtC3gMMyaZYg
 7d05/qXsd1btvJ3DoeTEB8YBL2ePUtRBQg+DS7Pdu58rOIkQgyX8lHSzw2tnQ0PpAOQ4ps/oL
 vGTk6JIhgZ5uVkQZs9M974gpSrOd1Dw562nl/QEtQq2pNGIU6lE28ZsQxpvEfLtptJhkTfd06
 7+F76D6C7Rf0UGLSZpC6di4sM7juGaZ9g2UGjj7Zs6jV82PcJb9QD9EIqKoVUMF2KQUGRaRY0
 XVDsr8PjmfE0nSW+TVo/RDHquPnavqVcVKEI1daPUuMskNVUykSBtP1E7oU3wECVyr6WTMYTk
 wZmGwlX1k8L7VzfrDGp0is3gclF3f3AciPf+pYhrS0ad0h1/f1omjWlMbdWgWTqXFFAzg09lm
 rhxzxePmrag08cpjglKSbxaD2bRC8PN5aLopjMcS8DbjfWrVCtQQA+DJHFNckTstMQ490qTGf
 8TVWM8NeHhcZlv5JGCJH2S5Gch35FqIio214gjJn22PIngxOFd/hICHKW3vowz15M3AZ6E5Bm
 u2ZpbHkbbBremB6SysLbJ/+zulqZIFyxRPpzFriqxXnh6d3nsgttahMJ4ZtJ7iS4B9ASrN93A
 KkdNIMU/cIgcfKyu9fECmZaP0A2PESfTmL+/J/qMHtPah8nwQTF31qaHS5EwPB79WnEKNhdZw
 venfPXcqg+kWqXjqbo8gXk//bCu4t6PY+F6AGLYLHSXNN7cNmJvY+fGLOtRYUh3EbJTK21smE
 WT9qaRjPAWvcRB8SHxMKJrj5SX3XsPNX5gpSnttYvzERZe4vqS69DIdqLyx64hetgzoktJmF3
 R3kJF1f/cyqgVHaWHDO8qv/uGKSTmLiyliEQE/XdDu1R6FLZWk93KDDgzFuPsIPdQEvGSQq1Q
 xAp2056SxA2I+dWreIiQpik6Nh2twePZx0s4+pkEBNa3x6K3Kvt1qowafb7aM7QrewHIVCB8l
 63OpqKMvjZKKadsLmEK6rX4jjKDnOW4y7wB2bYbOksTvk3YrjGao4jAeA==
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/24 21:13, Qu Wenruo wrote:
>
>
> On 2022/5/24 20:08, Christoph Hellwig wrote:
>> On Tue, May 24, 2022 at 04:21:38PM +0800, Qu Wenruo wrote:
>>>> The things like resetting initial_mirror, making the naming "initial"
>>>> meaningless.
>>>> And the reset on the length part is also very quirky.
>>>
>>> In fact, if you didn't do the initial_mirror and length change (which =
is
>>> a big disaster of readability, to change iterator in a loop, at least =
to
>>> me),
>>
>> So what is the big problem there?=C2=A0 Do I need more extensive docume=
ntation
>> or as there anything in this concept that is just too confusing.
>
> Modifying the iterator inside a loop is the biggest problem to me.
>
> Yes, extra comments can help, but that doesn't help the readability.
>
> And that's why most of guys here prefer for () loop if we can.

Just allow me to do another attempt on this.

This time, still bitmap based, but no pre/runtime allocation.
Just use the on-stack structure to contain a u32 bitmap.


And we no longer use the bitmap for the whole bio, but only for the
first corrupted sector, to the next good sector.

If the bitmap is not large enough to contain the next sector, we just
finish the current batch.

Now we should have all the best things, batched submission, no memory
allocation, no modification on the iterator inside a loop.

Although the cost is that, we are still doing the bitmap way, and we
have more call sites of btrfs_read_repair_finish().

Thanks,
Qu
>
> Thanks,
> Qu
>>
>>> and rely on the VFS re-read behavior to fall back to sector by
>>> secot read, I would call it better readability...
>>
>> I don't think relying on undocumented VFS behavior is a good idea.=C2=
=A0 It
>> will also not work for direct I/O if any single direct I/O bio has
>> ever more than a single page, which is something btrfs badly needs
>> if it wants to get any kind of performance out of direct I/O.
