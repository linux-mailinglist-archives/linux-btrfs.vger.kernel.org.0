Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776205324D0
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 May 2022 10:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiEXIE3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 May 2022 04:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiEXIEV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 May 2022 04:04:21 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE95493468
        for <linux-btrfs@vger.kernel.org>; Tue, 24 May 2022 01:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653379449;
        bh=tJ9pJ3Wf5osO/k2O/7CeHVot9P5fx0Ke3h994PljkXE=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=FOrTBMMug+qfMAxfufRH/LSjFnfSyxbnPpURqKDFfTxMZtJK9VfjIv4Ks75Poe7y7
         S8drKc9ypGNsCNpLmdZhGKcodUVjrCaG+luwQZtv/ZM0n4R2xvWnVNlgbni/wScIlE
         sfBgn9sGKs/vTvgVf2tYI6JdrIm4Bw1zBhlJQxq4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MsYux-1naNV52fHP-00u1aS; Tue, 24
 May 2022 10:04:09 +0200
Message-ID: <6047f29e-966d-1bf5-6052-915c1572d07a@gmx.com>
Date:   Tue, 24 May 2022 16:04:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20220522114754.173685-1-hch@lst.de>
 <20220522114754.173685-9-hch@lst.de>
 <d3065bfe-c7ae-5182-84de-17101afbd39e@gmx.com>
 <20220522123108.GA23355@lst.de>
 <d7a1e588-7b2b-e85e-c204-a711d54ecc7c@gmx.com>
 <20220522125337.GB24032@lst.de>
 <8a6fb996-64c3-63b3-7f9c-aec78e83504e@gmx.com>
 <20220523062636.GA29750@lst.de>
 <84b022dc-6310-1d52-b8e3-33f915a4fee7@gmx.com>
 <20220524073216.GB26145@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 8/8] btrfs: use btrfs_bio_for_each_sector in
 btrfs_check_read_dio_bio
In-Reply-To: <20220524073216.GB26145@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3ysF8X36I/OM3CpbhpmJQtbpn4QPwMb+q1kKES8YtF5SSaCu7EU
 9YX3gNYInH0G30zfP4DcQdw4NoM7gZ3ni2u2eSSlF0wrSi1IFknc0ojM2rejvO66FbBmKHl
 RCSvhDFjbtIdwC8QyRPA7s3B2wsEPUFeqtCOMK0q+znQf8LHSBo6h3iCPvE0KzkelOT83ZT
 fGQqm2bice6wnV0O51ALA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SX1c2KGhOFs=:xVkXkhxnPyG8qMuyLFdHWN
 HdlFV0zS0yym8yFjgOBKAGdix9QZgBpJg7odSAJqSKt5jHdUnzgGvj7EH31tA/+vPEiBIK/lX
 c20U0LUeKHvGBoKSFJ7j02r23sqpkyrdXWylY7Z33sv/Kj4JIxFeKST/bd4iOzM5ZsYJiuF58
 aeHJCMrGvBiZmZn9k0q9i46S3yZDFgOXj00T64bJdJok8Qlq/onbbqBNFxC1weiBTvZ7ItdmS
 7kRZUqm/CJkQPlWECW2mqHBoubTt4a2G9H6yty0chcEAndasaUvnRSpOdNK68g8a5JVfloo99
 dGNkTZMbwGW69NEWCrqkdyOBc6XKyWlpdKgkjfwY5TazdINDC9jl5eolNALb+QDwF5Nt4uJg8
 fLfDGX5RpZKyNOAeHt/rbYADESXwKKRz2gq3lvkb92AhsqJhPF50POxixvV6WYs2e+1OFIIJq
 SFTeyRsy2OkW26UiXZzfIgiRaRYL5MezEhiLeb3SlL2PSaE42J0P5U+RExOkMH2VoWXhwkkBI
 SK+wA2g/opYOGLWrNoizqu28zqqeNcyWhgL8sGTKJ9YRkrGABI4sjAJQLnLHu7prz+CoQZCgn
 Kzz9kPU4po2281Ngfmuu8TR434aLueITxUfCjl8TrLwREcww0vmI3hDCvTuMJ0HB0z35mKqJ9
 jMGYH/OTgo17K3w9y5qaGuwH0G6jVIjqaezsGUkwjBXCXj1ztR/WVdHOk1Sz8enlyjPIAVdgZ
 PipdPt9/eVBiBfxHS888FApaufi/Gs3iwAvQ4K8LCH6hMDq52xDEHZ7sKGqUAvjMl5Lor40dF
 kY5Lmv3fIeAGJMVv3P2GikJQO0cdzNREMLye50cr/QpxtzV3hZE/eW7dNt6Ok2dM25XiokaEg
 l1vLDzIkZkbEBDWE0TVD3r6mAOeqNoyje0bGAN87OySWgUmxKutIaXJAiHwqjth5hyUazCGWo
 M4JhT2ytoSsDLacRvII3REeN4NCeGrfzLepucmtjNf32alxtO3i4LJvu9pftGwpRhrK+3icT9
 psDSUndsiq+eESKoaBfrHcZJjFvtJu6DGssm38r6k2qWVUppOjQinSrl69DSHbnHXYolegrff
 uRzTNPkJM3ln1KwEPIA3NW1+aQ4hDc4TZwI1rQWLH3ucv8cEttiRifODw==
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/24 15:32, Christoph Hellwig wrote:
> On Mon, May 23, 2022 at 03:46:02PM +0800, Qu Wenruo wrote:
>>> Becasue btrfs_repair_io_failure can't handle multiple-page I/O.  It
>>> is also is rather cumbersome because it bypassed the normal bio
>>> mapping.  As a follow on I'd rather move it over to btrfs_map_bio
>>> with a special flag for the single mirror parity write rather than tha=
t
>>> hack.
>>
>> In fact so far for all callers of btrfs_repair_io_failure(), we are
>> always handling things inside one stripe.
>>
>> Thus we can easily enhance that function to handle multi page ranges.
>>
>> Although a dedicated btrfs_map_bio() flags seems more generic and bette=
r.
>
> I did think of moving btrfs_repair_io_failure over to my new
> infrastructure in fact, because it seems inherently possible.  Just
> not the highest priority right now.
>
>>> Because the whole bio at this point is all the bad sectors.  There
>>> is no point in writing only parts of the bio because that would leave
>>> corruption on disk.
>>>
>>>>     The only reason I can think of is, we're still trying to do some
>>>>     "optimization".
>>>>
>>>>     But all our bio submission is already synchronous, I doubt such
>>>>     "optimization" would make much difference.
>>>
>>> Can you explain what you mean here?
>>
>> We wait for the read bio anyway, I doubt the batched write part is that
>> important.
>
> I still don't understand the point.  Once we read more than a single
> page, writing it back as a patch is completely trivial as shown by
> this series.  Why would we not do it?
>
>>
>> If you really want, I can try to make the write part asynchronous, whil=
e
>> still keep the read part synchronous, and easier to read.
>
> Asynchronous writes gets us back into all the I/O completion handler
> complexities, which was the whole reason to start on the synchronous
> repair.
>
>> In your current version, the do {} while() loop iterates through all
>> mirrors.
>>
>> But for the following case, we will hit problems thanks to RAID1C3 agai=
n:
>>
>> Mirror 1 	|X|X|X|X|
>> Mirror 2	|X| |X| |
>> Mirror 3	| |X| |X|
>>
>> We hit mirror 1 initially, thus @initial_mirror is 1.
>>
>> Then when we try mirror 2, since the first sector is still bad, we jump
>> to the next mirror.
>>
>> For mirror 3, we fixed the first sector only. Then 2nd sector is still
>> from mirror 3 and didn't pass.
>> Now we have no more mirrors, and still return -EIO.
>
> Can you share a test case?

Unfortunately no real test case can work here.

The problem is, VFS will try to re-read with smaller block size.
In that case, fallback to sector-by-sector repair, thus even if we have
some policy terribly wrong, as long as the sector-by-sector behavior is
  fine, it will be hidden.

That's why when I do my bitmap version, I have to add extra trace events
to make sure it's not the retry, but really my read-repair code doing
the correct repair, without triggering the re-read.

>  The code resets initial_mirror as soon as
> we made any progress so that should not happen.

Oh, didn't see that part.

And in that case, yes, it will work for the checker pattern, although
not really any more efficient.

We will do 4 different reads to fix it, no better than sector-by-sector
repair.
And worse than 2 reads from the bitmap version.

But I get your point, it can handle continuous corruption better than
sector-by-sector, and no worse than bitmap version in that case.

>
>> So my points still stand, if we want to do batched handling, either we
>> go bitmap or we give up.
>
> Why?  For the very common case of clustered corruption or entirely
> failing reads it is significantly faster than a simple synchronous
> read of each sector, and also much better than the existing code.
> It also is a lot less code than the existing code base, and (maybe
> I'm biassed) a lot more readable.

The problem here is, yes, you can pick the common case one, but it comes
with the burden of worst cases too.

And for the readable part, I strongly doubt.

The things like resetting initial_mirror, making the naming "initial"
meaningless.
And the reset on the length part is also very quirky.

Yes, my bitmap version is super complex, that's no doubt, but the idea
and code should be very straightforward.

Just loop all mirrors until the bad bitmap is all zero. No need to reset
the length or whatever halfway, bitmap and mirror number is the only
iterator.

And even for the bitmap preallocation failure part, we have VFS to bail
us out.
And code wise, it's not that simpler, if you ignore the bitmap
pre-allocation part...

And for the ultimate readability, the sector-by-sector method can not be
beaten.
Thus I'm not a particular fan of any middle ground here.

>
> Bitmaps only help you with randomly splattered corruption, which simply
> is not how SSDs or hard drives actually fail.

But that's the case you have to take into consideration.

Even for cases where real world SSD to corrupt a big range of data, we
can still submit a read that crosses the corruption boundary.

>
>> Such hacky bandage seems to work at first glance and will pass your new
>> test cases, but it doesn't do it any better than sector-by-sector waiti=
ng.
>> (Forgot to mention, the new RAID1C3 test case may also be flawed, as an=
y
>> read on other mirrors will cause read-repair, screwing up our later
>> retry, thus we must check pid first before doing any read.)
>
> The updated version uses the read from mirror loop from btrfs/142
> that cleverly used bash internals to not issue the read if it would
> be done using the wrong mirror.  Which also really nicely speeds up
> the tests including the exist 140 and 141 ones.
>
That's wonderful.

However the smaller problem is still there, we have no way to know if
it's the read-repair itself does its part correctly, or it's VFS retry
saves our day.

But yeah, btrfs/142 method is much better and should be backported to
btrfs/140 and btrfs/141.

Thanks,
Qu
