Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E45178DA41
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Aug 2023 20:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236758AbjH3Sfx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Aug 2023 14:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243847AbjH3Lya (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Aug 2023 07:54:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BE41B0
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Aug 2023 04:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1693396456; x=1694001256; i=quwenruo.btrfs@gmx.com;
 bh=lzjNV5Jzf/xj6UtZ8T1zBxM0cSqdrYTJE+F9WL4iTng=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=s6QOIMLZTDZAh1Eb6JRTvR585iWqbBcEgvA1QgJtg9m66fTlWDl/6PsOFtSRZU+moefzN0z
 pO2jZW9eWFIzuXYxfY3dVKFU/i4iMZAhSCUB4GShtTOHHork2NQuCgboqXe6NSc8Lwzy8qIPr
 g4Rt8NOe53HZc6aE92d49SU2Aw0NPcybL/dmjC2p/LWERYIoVyCk3chWyCJz0b55qW107ju3k
 XvfqZO+jPx7zJhWPOeCGttQet22/Fv8DICP9twbwvYv5zsVHw8M1T/mXVjWSu2i2UeSTlQHKs
 2Vf9b5PEHvd5Mq22PLa6myKrc0XiT/6otY8GOndo69ez1wH7puGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mz9Z5-1poJtT06BH-00wGMG; Wed, 30
 Aug 2023 13:54:16 +0200
Message-ID: <da72818c-6327-44d3-aee8-a73e7ee42b65@gmx.com>
Date:   Wed, 30 Aug 2023 19:54:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (PING) btrfs sequential 8K read()s from compressed files are not
 merging
To:     Dimitrios Apostolou <jimis@gmx.net>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-btrfs@vger.kernel.org
References: <0db91235-810e-1c6e-7192-48f698c55c59@gmx.net>
 <4b16bd02-a446-8000-b10e-4b24aaede854@gmx.net>
 <fd0bbbc3-4a42-3472-dc6e-5a1cb51df10e@gmx.net>
 <ZMEXhfDG2BinQEOy@infradead.org>
 <62b24a0c-08e9-5dfd-33a6-a34dd93b1727@gmx.net>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <62b24a0c-08e9-5dfd-33a6-a34dd93b1727@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IuMUwdvQcVoo/v+nGRs1Y4ol0/pAvSC3+5igIXlQ4o1GyH1IUZv
 0rHK0vL6nq/e+xT/YxqrlfI4sYRZt/eZwwa2C+BJbZqhSVsB3SvkTtGuDOzyP7qagyM4+ZE
 dD9YHRYLom4SFSlUVgSTtg1+34HoT8SVNToFdn5Nrsg8Ye0VPb1nJwDyyzqwTpbqLGf49nY
 +aNiQ20XyVL8VaiHsNpRA==
UI-OutboundReport: notjunk:1;M01:P0:09MJbUd1vWE=;0EZRXbTRYYe04GJ3sRU1K0cRL9M
 isz9kdr+4yE2dwqFHmcSfeYFw9lHZZu/QtC5BDA241YUdPwanrFNxFKIV07/G8jd6HtOPKzWG
 ZHSEw5+qxoHpMypBuQbZnMyqu6V2nOdT+SD8hUJTm72W3QY/UNrxjc0zL/CEUPETLrhvS3A/U
 zNtCru2/upc3l8leuAnzp2oDmXR9rqvYAAa6Qhj1iaEP9RgU1fxQBqOSgedT46SHWhW1xGXVc
 1+gZe4QiMX0j03QsBVGw1EBPpDMPwdvaQ001Z6tAuxav7a/BSLZ6J+UQZhDpCOGI/EMCfEpTK
 zyjHjzq8qea5gFZt9YcsmGDNn1yk9E6AO5hur/YTkKDxs3aFLYm/o0HjQsj0pfcE/DtYO99do
 UYjJMi9zurkAjTaFVaFBSTqgFjj4udypQKOb8DC2G6DlgHoBwFigQvw5rll2JqqEtLFnjOcW0
 3pP0KTu63Kg5D59Ecb02CG40WOHKTfbDrGB2xyX0dQXRStfdsvOAJLQ6c5hM70POpcAu75pJU
 wwPBKb78aceajp7lJXm+Qr+58DdbaW27cx5EJ5PvFL/sr35bP1IJ5KoJw1zASFPlPpqUbWZIv
 jNfEGI/s/84TGK7QNEkb7OOTHUgPDb0LY5YC5m3iaOiNrVAIzFpK28GlUFrf2nvlG2CtrKKJm
 H99wxC9J6ZbBM60P0E4XWOwzqXixkBbNczeVaut0aho0bg/SJMyBdOxkk9/npVREZu41KCbOu
 1ZR7uz/sA5oKL+64M888kC7b+Jx3LVXqF/cZT9escdMOATvMY3/IwqCo/MReVpt6qODH3Vq9O
 NkgZJDG6wRqtvYCPiays4AZFWm+r4GmsmMtZfxLdfu8asxHtwufcD06lbzxVEZ54wr7qJASWd
 VIpUPzYMVqQ7iHttsJ6M2fwO17eFbTHGe8MetuSQAHbRz2zdRz5OpKoD+lQYNd10BJK0q1Egm
 LWjZMWGhmtZDJGE5ZHIku8FZ2A4=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/29 21:02, Dimitrios Apostolou wrote:
> On Wed, 26 Jul 2023, Christoph Hellwig wrote:
>
>> FYI, I can reproduce similar findings to yours.=C2=A0 I'm somewhere bet=
ween
>> dealing with regressions and travel and don't actually have time to
>> fully root cause it.
>>
>> The most likely scenario is probably some interaction between the read
>> ahead window that is based around the actual I/O size, and the btrfs
>> compressed extent design that always compressed a fixed sized chunk
>> of data.
>
> So the issue is still an issue (btrfs being unreasonably slow when readi=
ng
> sequentially 8K blocks from a compressed file) and I'm trying to figure
> out the reasons.
>
> I'm wondering, when an application read()s an 8K block from a big
> btrfs-compressed file, apparently the full 128KB compressed chunk has to
> be decompressed. But what does btrfs store in the kernel buffercache?

The kernel page cache is mostly for inode, aka the decompressed data.

As long as you're doing cached read, the decompressed data would be cached=
.

But there is another catch, if the file extent only points to a very
small part of the decompressed range, we still need to read the full
compressed extent, do the decompression, and only copy the small range
into the page cache.

>
> a. Does it store only the specific 8K block of decompressed data that wa=
s
>  =C2=A0=C2=A0 requested?

If it's buffered read, the read can be merged with other blocks, and we
also have readahead, in that case we can still submit a much larger read.

But mostly it's case a), as for dd, it would wait for the read to finish.

Meanwhile if it's direct IO, there would be no merge, nor any cache.
(That's expected though)

>
> b. Does it store the full compressed block (128KB AFAIK) and will be
>  =C2=A0=C2=A0 re-decompressed upon read() from any application?
>
> c. Or does it store the full de-compressed block, which might even be 1M=
B
>  =C2=A0=C2=A0 in size?
>
> I guess it's doing [a], because of the performance issue I'm facing. Bot=
h
> [b] and [c] would work as some kind of automatic read-ahead. But any kin=
d
> of verification would be helpful to nail the problem, as I can't see thi=
s
> level of detail exposed in any way, from a userspace point of view.

Although there are other factors which can be involved, like fragments
(especially damaging performance for compressed extents).

One thing I want to verify is, could you create a big file with all
compressed extents (dd writes, blocksize doesn't matter that much as by
default it's buffered write), other than postgres data bases?

Then do the same read with 32K and 512K and see if there is still the
same slow performance.
(The compressed extent size limit is 128K, thus 512K would cover 4 file
extents, and hopefully to increase the performance.)

I'm afraid the postgres data may be fragmented due to the database
workload, and contributes to the slow down.

Thanks,
Qu
>
>
> Thanks,
> Dimitris
>
