Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAC13F0FD6
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 03:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbhHSBIx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 21:08:53 -0400
Received: from mout.gmx.net ([212.227.17.20]:43191 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232954AbhHSBIw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 21:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629335294;
        bh=eP6+VzoRXtDR+YIQcVWFmUgAIwChPqG3d133bwHRAOw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=JBfrMyo2C5zuecNaKiAS5m6B25AHuCjD5oEiVEhFgGfoauMhgxE8jLrNg4kbxg+d2
         xt8H3YIpJBz3KxuRfdOOalvHqq23W+vXqbjTT6zEHn66aQRJsfE89v7hnaj8ukLN5i
         1hiH2IDVkd9wF8pFew1QSQOKatdoePCi/P+Ph6Ec=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mel81-1moCnQ18tR-00apzn; Thu, 19
 Aug 2021 03:08:14 +0200
Subject: Re: [PATCH v2] btrfs: replace BUG_ON() in btrfs_csum_one_bio() with
 proper error handling
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210816235540.9475-1-wqu@suse.com>
 <8babcc1b-2456-8632-7b56-f9867d333a0d@suse.com>
 <ac42cd2a-82dd-1987-4e18-e9d27e127172@gmx.com>
 <20210818230032.GA5047@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <0f469eae-d30f-64cf-b07f-fb0a097e6741@gmx.com>
Date:   Thu, 19 Aug 2021 09:08:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210818230032.GA5047@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SAWUnJl9807SWQjaPWMAjZbfqWkEzw+Fjcfk6wLqtY19x9notGm
 g4Z3yUMojcX5JcxGd9W+14D2ZatCoKHgrXEdFkH7cWPymF8czQlu3fW5Vkg4UHALRwH/sEC
 3AT2cMtCDX25FViSdpZ90K6rr4L1ShblAAkqmfmo7ZAC8U6L83UuR99t/0dnAx7pqQt6RyY
 8MmS2ElixEGj3M+o8rKdw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:v012VPRs8V4=:2J4qpNRM5yS64BqRmyZ+jI
 J1A8Wj2E2itPCkTAKhpDBfBm1sLjpHngXoVbUBBqz+51lNM83oteaE+4RyHYwAbt0w3skc/Uz
 jLsuRT6A7z39uSx8XM+lzd+V5AHngFmJUisRD5hXqUS6IjmrniZ1EIzY0ISEX2ukkgCzlreZe
 gwUbcVOlucXYT6RG3Jfu6vYr8SCh7T6vYM6kncQPa2+2yQK19+WntOuRb3g5q7RjJ6BgNeSwj
 irSjgb3iyCJlcPhAzHQAG0hZUxrU2t7UB6bKaN4xfqzFxKE/22HuB4h36iVTuBgeZSB9nTBdg
 xVDk3O0al0sDihtZWU7MhitclJ5/D9g8JxEkleD+V41Ih8LOotGh7SLSC80pK2Adl4C34nrhh
 AVviWg/6sE0BjdOfyIN924YMtJFrGnXF0mPSwKOW6fWrOFepwT9xWMwM9bBK3EaicR7N8KGCn
 xOwoNZAFofDwYggE+aEC3NYVhcU3NusxGriw95+8xeG5tgGURPxNMmt8duCuIMz9/MsVggoRg
 AmqPPdZSOUXds4fDPqof/aK0okT3CcAozNgQQDVLtBlpF59pv4da6OWosVRRxTu76imar9WMg
 mSWy7MtQyzUCFiyY7CsfIoRCOnxDMX4IwWO8fGvOi2fyfSTsX81Cx1s6j1o7Nblu5p7p4cE6j
 WrJ7JjSSRv3PGwyhlhm9fvClmzAzqgW5rhqZIj/yy3v46b3ZMmnroERDvwaCJInl9Kpzc+NV6
 cYHkBVo7y47VGx8HkTwE+bgiBAhbK3MCRe85OHNic7iUQq0EipZrpNP9cGXNj0WCiQ9KVNRWp
 OJ1je/GOylA7KtvWYqP7RfbFqC2IJBeuDB5PuUBwXM51wrWAfVkSnQ99VrVMsOGjtXswKqXcN
 8P3Mbl9LOlXzGVvI1zjySEYQBLRO2Iu1M3KBwC8uwuIU6iv6wixCVrh3486mWBDhwKAwNsaVe
 TPnA2PyDR7J1FItVnyQIaR6nz5D6d8UlZXoE7EuhrvJtmNRBYkliK9IZ1WCb6HRacUcbCl3VF
 eEAzuF5GQ8qiHXv9xvnBvOkfbqUNYLBhCIcaeOjf6ZqL24b1znIjIjOYNvIvLQT0arPfgtf8H
 K61usWESEK1I1+bAW/33+kZFUTghz5EsG/512vkR4d73PVM5EB/fM4/lQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/19 =E4=B8=8A=E5=8D=887:00, David Sterba wrote:
> On Tue, Aug 17, 2021 at 04:10:43PM +0800, Qu Wenruo wrote:
>> On 2021/8/17 =E4=B8=8B=E5=8D=883:55, Nikolay Borisov wrote:
>>> On 17.08.21 =D0=B3. 2:55, Qu Wenruo wrote:
>>>> @@ -665,7 +665,18 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_ino=
de *inode, struct bio *bio,
>>>>
>>>>    		if (!ordered) {
>>>>    			ordered =3D btrfs_lookup_ordered_extent(inode, offset);
>>>> -			BUG_ON(!ordered); /* Logic error */
>>>> +			/*
>>>> +			 * The bio range is not covered by any ordered extent,
>>>> +			 * must be a code logic error.
>>>> +			 */
>>>> +			if (unlikely(!ordered)) {
>>>> +				WARN(1, KERN_WARNING
>>>> +		"no ordered extent for root %llu ino %llu offset %llu\n",
>>>> +				     inode->root->root_key.objectid,
>>>> +				     btrfs_ino(inode), offset);
>>>> +				kvfree(sums);
>>>> +				return BLK_STS_IOERR;
>>>> +			}
>>>
>>> nit: How about :
>>>
>>> if (WARN_ON(!ordered)  {
>>
>> I still remember that if (WARN_ON()) usage is not recommended by David.
>>
>> Is that still the case?
>
> Quick grep shows there are many if (WARN_ON(...)) so as long as it's a
> simple "if (WARN_ON(condition))" and the code is readable I won't
> object.
>
> The problematic one is "if (!WARN_ON(condition))", because it warns when
> condition is true, but the if does not continue and that breaks the
> reading flow. The acceptable pattern read like "if condition and warn
> eventually and continue".
>

I want to play safe by never bothering the WARN_ON() in if () condition
anymore.

The fact that some if (WARN_ON()) is acceptable and some is not is
already worrying.

Can we just stick to no-WARN_ON-in-if policy?

Thanks,
Qu
