Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C253D514306
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 09:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354976AbiD2HO5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 03:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354793AbiD2HOz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 03:14:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3F2186C5
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 00:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651216286;
        bh=cp1JYdeN/MaNJcXFIb2AcpphmuimG8YgEDCm9Y9Ij+k=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=i3I1mAZ4iqTITAXIjyj7upn+kQWpO9jNfWC3XRyh9QeXInVp9mMWXisWot+kAjoDR
         olMxqWorijEukPNpDAroO7m8JLY51V+QyoFHXn5yqeioi+eCCL2ldTnUpSpCAjhs+B
         xvNe37tZze8I4iDj8hZO0wICLjJN6mE87J/kCJRA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mk0NU-1o8Q8T29Ae-00kQzd; Fri, 29
 Apr 2022 09:11:26 +0200
Message-ID: <fe9f5fd9-c99b-5853-f203-89e37be6b040@gmx.com>
Date:   Fri, 29 Apr 2022 15:11:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH RFC v2 05/12] btrfs: add a helper to queue a corrupted
 sector for read repair
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1651043617.git.wqu@suse.com>
 <a136fe858afe9efd29c8caa98d82cb7439d89677.1651043617.git.wqu@suse.com>
 <2fd10883-5a4d-5cbd-d09f-7a30bb326a4a@suse.com>
 <YmqaOynJjWS2XB76@infradead.org>
 <4ac0c01f-73f6-e830-f3bc-6281bd79b7d2@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <4ac0c01f-73f6-e830-f3bc-6281bd79b7d2@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8Fp9jo4Aw6+SXRi8aUS+fQcRfDwcK+dsS25ntQk1TDB1fnnfTmJ
 ggC09JS8mAdSCtJQE/Zx0JiU9inNoGxpyrfQb8QEnXSLM74OExuThdqE7c4CvQ5dAEJKbXj
 gMIOyjGigxjR5XYHpPcuC7StHWwQD1tQQpqAFo5Xh+qiFHwjElmMU6TLNAxuNS4s23G4PKf
 FCSgn3qkanOTyyFMW5ZOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WG02TZGfQQw=:MiFPRXJcQ+9vs2WsPIJBk+
 5jDhug6lySiAIAiMn8dMEDbAKmreHx8NBHanLzqDtAGjwearHRKUHiFSpc+l5C48UZLkHsqCI
 BMMI5zo6RvRWYPZrQZ2pRK9KIJ6UrXfaMJz3v8mda4PAILMoJxf1EJGsZFLMNQXEdEcxGJWkQ
 uqmD9P/Rm8OzFxyUSW0bhE6Kfm7IHeF6bsc57t2BWMNWdAtfebtPZm/PaXDnF+tvU3rTnHUgZ
 YJLca2mCkD7Cuz8d2j2Xlku1zftxhcPwOU3NfPcixndW3/OSwSf93jZq+xpqfRLUJjGI+yUaZ
 MNSBG4uy/Q9044VnLRn034/9e11Pv4usLZuh5zChlpEVCMRx8mdNzKbpbrrEgUYSMVlsRarQA
 w2wT7kGfnRPh1neGAbSpWAkJnnP7qiZuTX27vvyTle7X7inEUfPa61M5bTfdrVftpJNUl2Ez0
 /zhy1VZg9rtYjtmbkmxhQgbUtuddYqaxkMUEvmGHR8GcCz+q9DLtwBJ0uwRvkxXizrcfO5pZj
 bRF1MANmyFkWV9ursA31sRJKEMGlhaW+3Gm4bS5x0IKbTcdf2Fa6QXbSr0JtMF/C4g8EcK9t7
 DFQgL8Tm8bPSH5iBSIQFIV87g0xQX5nERGLfRQBOqCWeqATzfcEY2/wwL4So2EHwe9V8tdfPG
 tv4NmesGnvRE0xFBEshaFGZiQgG7RTGEoYTN6b3148G0PpUBRgnrZX/XelPyoVZqUmVjN0rl7
 Cikx3aMFIQTUyMNvbqkIV+3DBO/Lj9f6aHqKXwza6TDdMnUKH+VcMlDXvSh4ETMDosuQuha1C
 KOKHdPAH4TwuYEQ0q1BNYB4cKErpI4EfErnFCV9Z5+wUMigmBeg4P7D8qf3+IQ6CLAHWMmO8V
 zi7U/dV2gzXocnKAbBZjJnCdgcTPPoj/xTJrw7v3CizmA4g2u2UrDDaLwW6ot+H4p905t4aA9
 i793C/JguzVfnhOD94Nvcw2FFbRBvFqk/wDfLP3rnGewhF6Pey+hdGeWo+W6Ol63HqeTYyiQJ
 1Hd0w1Un+aERGbLAsEAucCz16bD6m/UcG6l6VlTULLHb2sgaMmPhhI9RwboAySChYaIfMufRi
 nQT1dbNbuCeg/4=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/29 06:55, Qu Wenruo wrote:
>
>
> On 2022/4/28 21:44, Christoph Hellwig wrote:
>> On Thu, Apr 28, 2022 at 01:20:37PM +0800, Qu Wenruo wrote:
>>> This function will get called very frequently, and I really want to
>>> avoid
>>> doing such re-search every time from the beginning of the original bio=
.
>>>
>>> Maybe we can cache a bvec_iter and using the bi_size to check if the
>>> target
>>> offset is still beyond us (then advance), or re-wind and re-search
>>> from the
>>> beginning.
>>>
>>> I guess there is no existing helper to do the same work, right?
>>
>> It is basically impossible to review this because you just add a
>> standalone static helper without the callers.=C2=A0 Please split the
>> work into logical chunks that actually are reviewable.=C2=A0 Yes, that =
will
>> be a pretty large patch, but that's still much better than having to
>> jump around hal a dozen ones.
>>
>> No, there is no way to efficiently look up what bvec in a bio some
>> offset falls into, because the bvecs are variable length.
>>
>> It seems like the caller (at least the one added a little later, not
>> sure if there are more) is iterating over the bitmap and then calls
>> this for every bit set.=C2=A0 So for that you're much better off making
>> the __bio_for_each_segment the main loop, and then at the beginning of
>> the loop checking the bitmap if we need to handle this sector.
>>
>>
>>>> +=C2=A0=C2=A0=C2=A0 struct bio_list read_bios;
>>
>> I'd just calls this bios.=C2=A0 Obviously they are used for reading her=
e.
>>
>> Also please be very careful about dead locks.=C2=A0 The mempool for the
>> btrfs_bios is small right now, you need to size it up by the
>> largerst number of bios that can be on this list.

Forgot to mention one thing here.

The old behavior will also allocate new bios for repair, even it's even
worse, check out the old btrsf_repair_one_sector(), which will always
allocate a btrfs_bio, for every *sector* corrupted.

While in our new code, that would only be the worst case.

If we have adjacent corrupted sectors, we will just append the new
sector into the existing bios.

So if we have dead locks, I believe we should hit more frequently using
the old code.

Thus the new behavior is no worst than the old one, except the extra
bitmap allocation (which I'll try to move them to btrfs_bio then, maybe
using a union to share the csum pointer).

Thanks,
Qu

>
> In fact I have some version locally checking the return value from
> btrfs_bio_alloc(), if we failed to alloc memory, then just mark the
> btrfs_read_repair_ctrl::error bit, and mark all remaining bad sectors as
> error, no more repairing.
>
> As memory allocation failure is much more a problem than failed read
> repair.
>
> Another consideration is, would it really dead lock?
>
> We're only called for read path, not writeback path.
> IIRC it's easier to hit dead lock at writeback path, as writeback can be
> triggered by memory pressure.
>
> But would the same problem happen just for read path?
>
> Thanks,
> Qu
