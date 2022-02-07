Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0366E4AB98B
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Feb 2022 12:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239397AbiBGLQr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Feb 2022 06:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348675AbiBGLGi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Feb 2022 06:06:38 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38C6C043181
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Feb 2022 03:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644231991;
        bh=XTqERLcqe8Od2m5CoK97uQ21dx7BtKDOMAcbf69nEWs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=VbPUyGnuUuzI8+t2iDFhgOn8qO+LgE/URUwvOFOQI/R+fivochNM1EKIuRySDsY/R
         1i3RFeRYVXr7K8sKFlxv72U6e5KmTkpU9YNs95+cyib/Xs9gsqIvVcFBDMyECBydtX
         QtYMcSsvfTF877WcZUQmnCdAXzxwhgjcTDahgdT0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MLQxN-1nZNwr1c71-00IXIV; Mon, 07
 Feb 2022 12:06:31 +0100
Message-ID: <05e40ca7-dcd6-b605-b109-e47b79baeca3@gmx.com>
Date:   Mon, 7 Feb 2022 19:06:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] btrfs: defrag: don't try to defrag extent which is going
 to be written back
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <9df1dce96466f4314190cc4120f19d5b7d0fe5ed.1644210926.git.wqu@suse.com>
 <YgD17pDNz8b165yN@debian9.Home>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YgD17pDNz8b165yN@debian9.Home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+ovZCNhOW9SAEmHcWlHk4DYaNYku06von9usRYz6Y1orLJeTcq7
 /8PZpEEQL/PBkiZXsP7cnewazga7NNBdIZdVFuErzWx4GT8kj6uHqau7xR1/v4X8SzjINoY
 3ZAJrffiGdmcFvjv7jqWsZfwEw43ore9tcDtBon2M4E3nZm6QM8IJZrvs6/8P3S4fAeWm/V
 h/a9sanWux9n1SepoTOYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/qasgTXKg6o=:XZqG64bgDBhw7oBZQJC0Bn
 dYMT4CRqvURKg4t1ePeONPnhs0fRh4uvKaeoU3k1FRvYcUi8rL+DUzidTBI3/fT6r05CXhBgo
 +PrqnS3CgpKIRSCvRPqDg/vgkynzwVdYDdUvXzG8O9cRVz6QhcoFMgXyzrcp+CAGK56mIeRcy
 b7r+7aYLOKYjEJV99cbF4JyGn21t7XFHqdnZe4ROwqe+7B/MamWY512LVKs/2T9Q9UiTlTLeW
 3nYj8OhihXC925wIxDlvUUlJn5eMBc4hVG5TfclHdncLai2d1L53CmCW2sNJJ9vMQsdfcleco
 xY5IPty/QxDvYyjlNoUNqPwiyoA1NAabMpykGtzhZJ4Pb6jm8n2anT6mTXRsQrnJrETy1IGOT
 +rvgyOrxygf5xkUP6OU6fEb8ORoyBfJhbJmwkL4IOrpAxOKn9GVN1m82bKSBM31ZKsLGZfKbi
 uIr15q5H4qSF8weQVcY3b/Qr7eYxyQhk/8YNKYb9ciaQlJM4CE2vASBnGEUjXzSwsfRI4Lktc
 eU2XsmNJcyLEyxT7wqiHcMrVZkZI5Ls+MkYHFxcZbr05Pj5EApp9I13uWnNJVgVbxijoCfbfI
 WmtuhTAOGgKbIA6J+Y1IBgEOaBM6sTpFKaEZgdIUXg6KDuR1//tija3aLwYGo36X1yCEeUnu9
 p6Br4lSYSVJYAl7z/ZXGeBDIpOTf3nfXMc0pyk5ciXz8TVe1URpJKA6Yfu2BdVd+MVkBmLW0q
 9zZmpJ5628X0l9fzt1z9Y5TpnwlO6t9E5Ff6LcV1uCdaKqPIpzy65pc8v/GCnuzGQ2DpVRNfn
 syuqXhrlk4WFFXIqvrH5BRoBnty+7HYHkS1aDpbjMexJTzT+aGxhlxFj/szTEHd/xT2BS9gKD
 RW5yIT4Jk4wRBaqSookDgVutHr+6Q3Ycx45v7IahaS0nl4q5EdZkqS3j/DvbRAn5EukGeAHOA
 GH3Ft/XqSZrKsbd0WNOfUisdOR6gFhd0Rw/IkXvAi8jr+pbpyYJH2XnZJghNB8kevs3cyi7Mo
 FueaOL+ENLFcpnh/hbb7eEdrl0JoDdDQNoepPK+S7F/qoqIUfdYeUgixoXpBZ17jyCRavfoal
 jwb2eDSj3LPQz0=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/7 18:35, Filipe Manana wrote:
> On Mon, Feb 07, 2022 at 01:17:15PM +0800, Qu Wenruo wrote:
>> In defrag_collect_targets() if we hit an extent map which is created by
>> create_io_em(), it will be considered as target as its generation is
>> (u64)-1, thus will pass the generation check.
>>
>> Furthermore since all delalloc functions will clear EXTENT_DELALLOC,
>
> What are delalloc functions?
> This should say that once we start writeback (we run delalloc), we alloc=
ate
> an extent, create an extent map point to that extent, with a generation =
of
> (u64)-1, created the ordered extent and then clear the DELALLOC bit from=
 the
> range in the inode's io tree.

I mean the functions called inside btrfs_run_dealloc_ranges(), like
cow_file_range() etc.

>
>> such extent map will also pass the EXTENT_DELALLOC check.
>>
>> Defragging such extent will make no sense, in fact this will cause extr=
a
>> IO as we will just re-dirty the range and submit it for writeback again=
,
>> causing wasted IO.
>
> defrag_prepare_one_page() will wait for the ordered extent to complete,
> and after the wait, the extent map's generation is updated from (u64)-1 =
to
> something else.
>
> So the second pass of defrag_collect_targets() will see a generation tha=
t
> is not (u64)-1.

Yes, for the 2nd loop we will no longer see the (u64)-1 generations.

>
>>
>> Unfortunately this behavior seems to exist in older kernels too (v5.15
>> and older), but I don't have a solid test case to prove it nor test the
>> patched behavior.
>
> This is exactly the first patch I sent Fran=C3=A7ois when the first repo=
rt
> of unusable autodefrag popped up:
>
> https://lore.kernel.org/linux-btrfs/YeVawBBE3r6hVhgs@debian9.Home/T/#ma1=
c8a9848c9b7e4edb471f7be184599d38e288bb

Oh, mind to send out the proper patch as you're the original author with
this idea?

Thanks,
Qu
>
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/ioctl.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index 133e3e2e2e79..0ba98e1d9329 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -1353,6 +1353,10 @@ static int defrag_collect_targets(struct btrfs_i=
node *inode,
>>   		if (em->generation < ctrl->newer_than)
>>   			goto next;
>>
>> +		/* This em is goging to be written back, no need to defrag */
>
> goging -> going
>
> Saying that it is under writeback is more correct.
> By saying is "going to be", it gives the idea that writeback may have no=
t started yet,
> but an extent map with a generation of (u64)-1 is created when writeback=
 starts.
>
>
>> +		if (em->generation =3D=3D (u64)-1)
>> +			goto next;
>> +
>>   		/*
>>   		 * Our start offset might be in the middle of an existing extent
>>   		 * map, so take that into account.
>> --
>> 2.35.0
>>
