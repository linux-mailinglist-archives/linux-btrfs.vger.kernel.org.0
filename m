Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B6F4ECFEC
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Mar 2022 01:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbiC3XRY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Mar 2022 19:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbiC3XRX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Mar 2022 19:17:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD473F889
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 16:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648682062;
        bh=WZJ65tfE15uuzeUIxT2QAlHJG9sy/qlXd6qK3WXuhb8=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=EVzafBpZcX5oGF4JkwBKb5vHwhHYxoSejX80oqiyrSmkuFgCgagywL26pZZMztk4h
         lGZhUWwNGLy20VmwXmQIEEfWMuQXaLX9SfkwCyo85BgdZ2cOTdrAv79IsIkdCn9llm
         Pm3q4gJlZ0k0bwezFBN3BIO7+rF1v+yD33SZkH2Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MhU5R-1oE0UA2Ect-00eYwz; Thu, 31
 Mar 2022 01:14:22 +0200
Message-ID: <a2973c8d-0c8b-368f-1733-b4326eed121c@gmx.com>
Date:   Thu, 31 Mar 2022 07:14:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <20220324160628.1572613-1-hch@lst.de>
 <20220324160628.1572613-2-hch@lst.de> <20220330144358.GF2237@twin.jikos.cz>
 <bcb7b671-6c82-1914-7442-a96fcc460b71@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 1/2] btrfs: fix direct I/O read repair for split bios
In-Reply-To: <bcb7b671-6c82-1914-7442-a96fcc460b71@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:57+Hs5PY7CxTqC8lQz6JRdj2CbwM663GPAfgiCTkyXgS7CbxL7Y
 1gh/f67/elwz+/SgnkaMu4xZYHaKrRfIkZChmcnPnEihMgwwGi/VjJr0Y5fbLBx13PUvixt
 OxDO6J8Ni7qeQ+ocFe9rG2eJ9eD2qpKMX39+qlG6iVWQ8r0AWmSxfnUu6RqKuCJ1qxX/vaF
 XJP+kcGW9ZegU8JPHdzBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VNkoRSBeFzk=:sWmCFH5mJDm0Nugv2nHNIw
 l7EZY9mcq8k+dVDhN/LPeLZKG3AT8YVgiYsSMgFIGNJ7ANr7Ogll9/f+MHMi0cswtQ5X9/vYL
 if89QLzMXYg+1eEBZNi41h5nbKnIjlu2ac0D0Y57iP25u9cFU7ZqyDMDzIB69shURun7M3zd6
 BjB5pce5MeSKJDa9Um7RyifyhdpE/7DmrDOkN05DHsUqHZVnWcTj2Q+xieVOZ6A3Ml9bXr7Mn
 70O6ML2u7GuEC5WIChOjJef0C/DL5SBUH/0E0hoSy9CHnH7S5meu27YuX/jnebVzeyHo76+sx
 2LygLFycwqHkMED05yTrrF4JX//oXs1EuZUY12oXcrKpGpGw4eUWIjZ1P2q19bjmgcDcIKZnn
 lCv/I3yD6mmexQdPDwQAei5jjhHchKi5o5XLVa+qa4wiUat8SXZ7ksUORrc5oraaU9DrPf/xB
 HvH6ygKowlJWq2nnjf7pTZm1ml8ILjA7Go7AwQycXWDnkJKUxB7EkUL8Q8Z4WLiFyuBHfa5sZ
 bNVilWNWocFHb6F3Zl1iV4w5OGhptsHX6mzwVAgBauzWUqZMmVU+pzBA5QhCjiruWsxmhUmVJ
 VFaegpXdiXa8ddroxzgatm2XRr2WOgMWGoe6ynlefbK4cVZE95dPuZ1padLCqucLVwmPdvF3F
 MazC9zbdi7WqWoq+wQvKFjDsb4WwRMbswBwKeIGc/LeZbCRFSWv8IqkjaEXcWCis69aXXTAJP
 +zjX3/hAYBes8mE7n1Hye8zsoHFiLU6H04wmAiAd5+7ZvUK0EZI7kLOcDIbcdM8enimWkZUmI
 lQBJBcjVT3NQyJwv2mQ5wFZXDtCJcpoEgT1yEG4Owp41u60P6NdLYVzfXjT+slhmKwDAMsCFo
 ESfL588QeFHUrMm+ZQbeVaSN7Gexf8HHrhKoE98mghBkGUOOFNTkE1vh6EREn+aieLzWCauP5
 LgyA6PfykQVp9gWfDewkDMWjHN0BJ9qHZOBz5bdEpQNszHr9VkKXQzESqYhS+IUFVseaxoSy/
 UNcINankih76ICttLPm9PSn8k1iyTRZI8HMjAZslRgFmjocs+yjRX5aaOuUhFMaipZN/SJTOA
 pce8JwpzluXrwo=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/31 06:24, Qu Wenruo wrote:
>
>
> On 2022/3/30 22:43, David Sterba wrote:
>> On Thu, Mar 24, 2022 at 05:06:27PM +0100, Christoph Hellwig wrote:
>>> When a bio is split in btrfs_submit_direct, dip->file_offset contains
>>> the file offset for the first bio.=C2=A0 But this means the start valu=
e used
>>> in btrfs_check_read_dio_bio is incorrect for subsequent bios.=C2=A0 Ad=
d
>>> a file_offset field to struct btrfs_bio to pass along the correct
>>> offset.
>>>
>>> Given that check_data_csum only uses start of an error message this
>>> means problems with this miscalculation will only show up when I/O
>>> fails or checksums mismatch.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
>> Qu, you've removed the same logic in f4f39fc5dc30 ("btrfs: remove
>> btrfs_bio::logical member") where it was a different name for the same
>> variable. What changed in the logic that we don't need to store it alon=
g
>> the btrfs_bio and that btrfs_dio_private can't provide anymore?
>
> All my fault, I didn't realize that in btrfs_submit_direct() what we
> really do is splitting the iomap bio.
>
> Thus we still need that @logical member as dip is only allocated for the
> whole iomap bio, not for each split btrfs bio.
>
> Thus we need the fixes: tag.
>
>>
>> I'm a bit worried about your changes that remove/rewrite code, silently
>> introducing bugs so it has to be reinstated. We don't have enough
>> review coverage and in the amount of patches you send I'm increasingly
>> worried how many bugs I've inadvertently let in.
>
> Normally it should be caught by test cases. But test case coverage is
> not that better than our review coverage, especially for read repair, as
> it's a btrfs specific feature, and almost impossible to do stress tests.
>
> The good news is, for most of my subpage related rewrite, the existing
> test cases are pretty good catching the bugs.
>
>
> I don't really have better way other than adding regression tests cases
> until we found some regression.

While crafting the test case for this particular case, I found all the
existing tools, like dd (iflag=3Ddirect) or xfs_io (pwrite -d -i), are all
reading the content using 4K block, even block size is specified.

Thus unable to reproduce the bug (no split will happen).

Any good tool to cause a large direct IO read?

Thanks,
Qu

>
> Thanks,
> Qu
