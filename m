Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CD75346CA
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 May 2022 00:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbiEYWrB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 May 2022 18:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbiEYWrA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 May 2022 18:47:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFD6A5012
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 15:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653518810;
        bh=E12i3CiMHzAXnnOaugWWgjOcuhHpCIOj7QoPJ6atNQE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=CyZtYXKXMG3stjiNiqNtam6QKzWtE/aPpgc4rxPCKYywylDCpNumzcU3Pd0IWeGyo
         JIi4WHd43PnxtPcAs9RU7jV23shaT7iecl5UgwjA/DbEYk8VxJ38aoBtvAC2r+epnz
         GVMTIFIEWbrt5ZwlWrnspuaab1IxEuXfh5XYdH6s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N3siG-1nl5mD1Sd6-00zol6; Thu, 26
 May 2022 00:46:50 +0200
Message-ID: <e77c1b3d-558d-fe08-fc00-5aedff972ca0@gmx.com>
Date:   Thu, 26 May 2022 06:46:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 8/8] btrfs: use btrfs_bio_for_each_sector in
 btrfs_check_read_dio_bio
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, Christoph Hellwig <hch@lst.de>
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
 <bc9b6b97-ee10-e5eb-f8ab-b533399dc772@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <bc9b6b97-ee10-e5eb-f8ab-b533399dc772@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ywNGzuwj6BeMcbo1IdBz6rqyHse46MzZsjNzA6YiQu0DQyORar3
 CvXb8BhWwmkjRm3bWVhMx6UGtpz+EyZ03s/Y6CHdvL8lS5pPHfAzaMmMtn4u2DVVAMRCcR5
 qbkeKPARzPtMGKdm3tcAw71QHQ/Sn3yKaNS8/1sDEZTByOzvpBHAQnbVTDwI9r1X9xIzWMj
 oqV5Vurt3fvJE/KATTmlw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2maylBD3OfU=:coxdjqyCZVuF8Uwrg5BWK+
 UtOm+o41ytBSgM3eXVCRr0Ukp+MnqMR7ybhPfbT9gO5r7Kf85aIg/ezahvwJdwCbr0L+cVg0c
 Tpik9zJE8OHwqMTaQFxLWFQwwiRvRRS1GZitwMzOldbranA/3l0c/z+V7eZY2pFGtGVLLQIyn
 ii2m2lC3cEvWJAZX6DyJfAkhNFqUXZjvwqnfmPuqbypGJjRY+96kfXIzLP8YjfaFIfA7SRCFm
 RJ8U4l2KYDYBDUle8anQZx/fuA6CQgfAXGCiqo9E3WDa++6P/mJkOsxyfIuFdukbxp+PTS4dP
 AbsdXMO1s26oSXgSyuGYXauRG8vh76AHIZGiOTLlytfxDfa65w/qwd636dh9iXjgHKJ1aCmjY
 dktWWbwo00P85wsMQbutv7tPhYEBk8/qMIyQbFLRyYI13tMbnwT+cE+i2f50kLQJswhvGL/4M
 8ehG4J8OYq1Fye5+FAPYAQOFIIJjVJQfckCr1VNW0rHq7lTnzt6k1pS1u1x6gDnRIkyRGtyP1
 Xc72bEsviDWaENhNenNBWUpCu7RdMv+r6wY6rSlPnkMNM3EiV4XRWMotIwhxewI94cnOO9Qrs
 ZhoU15I34MJAejYn/zrn2QTF+3Do62aUvjbd9ro4jm7yVKPtFWCEujiZPzJPBVdcFKS7F98T2
 VHYSSy6e25Z3ibKBiHjLaDZAQp1k7SpAPtFo08bGeOwXSZG1jWgQJZMvi1QIBLeanF7kfM151
 NBXI7cp33K36LH8hkwYVtAEy70/lSYf7g2x8epoJPP3Q6aUbz9KjETyne+maqeutMxbk9IkM0
 XBiE50TQmXMLiAa2/HUbbaVTVaaNcNEABllty/RA4Z5utYMgBodgDRyIUjQvYqFSyNjWoOr+e
 CACw1vpPGpZlFctMwqv4lJhqZX/2RdGu+31WOT7GM6U5062pFaQYryMOyEgsVsb7g1PkTJRLw
 qPFwhvTJBONvG3Vy/6O8gQtvhq2m682dKygWOGpYNlV6+FnZPG3PCe3A2/elBhWXzbCNQGKzV
 QENFLVRUGp6+W1UVZSn2W3AdrIYYY8Oh8gigjvYOhIjjxUeEHti19GTr3ZI0/0OmZFH07Duly
 6Ej2h9b+sNijU6dMCNgccPYVfgeRqXNhLBhDMzxd+wGLBOZUsSDvMqUvQ==
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/25 23:12, Nikolay Borisov wrote:
>
>
> On 24.05.22 =D0=B3. 16:13 =D1=87., Qu Wenruo wrote:
>>
>>
>> On 2022/5/24 20:08, Christoph Hellwig wrote:
>>> On Tue, May 24, 2022 at 04:21:38PM +0800, Qu Wenruo wrote:
>>>>> The things like resetting initial_mirror, making the naming "initial=
"
>>>>> meaningless.
>>>>> And the reset on the length part is also very quirky.
>>>>
>>>> In fact, if you didn't do the initial_mirror and length change
>>>> (which is
>>>> a big disaster of readability, to change iterator in a loop, at
>>>> least to
>>>> me),
>>>
>>> So what is the big problem there?=C2=A0 Do I need more extensive
>>> documentation
>>> or as there anything in this concept that is just too confusing.
>>
>> Modifying the iterator inside a loop is the biggest problem to me.
>
> What iterator gets modified?

Mirror number.

Thanks,
Qu

> The code defines a local one, which gets
> initialized by copying the state from the bbio. Then the loop works as
> usual, that's not confusing and is in line with how the other bio vec
> iterator macros work.
>
>>
>> Yes, extra comments can help, but that doesn't help the readability.
>>
>> And that's why most of guys here prefer for () loop if we can.
>>
>> Thanks,
>> Qu
>>>
>>>> and rely on the VFS re-read behavior to fall back to sector by
>>>> secot read, I would call it better readability...
>>>
>>> I don't think relying on undocumented VFS behavior is a good idea.=C2=
=A0 It
>>> will also not work for direct I/O if any single direct I/O bio has
>>> ever more than a single page, which is something btrfs badly needs
>>> if it wants to get any kind of performance out of direct I/O.
>>
