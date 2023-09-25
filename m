Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C4C7AE095
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Sep 2023 23:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjIYVOk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Sep 2023 17:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjIYVOj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Sep 2023 17:14:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74897103
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Sep 2023 14:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1695676468; x=1696281268; i=quwenruo.btrfs@gmx.com;
 bh=3iGACLxPC/Yt840lh+L3yg4vhC1Ex/8K3JCauF+m9Kg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=XUdT0lMyOlH81rTXcbizxvAur7QpDTEhq6TCPdywCQ4CtqwtaDMlz7GhtCTqYpljSz8kYR3h1cH
 H3vE1v0FK/LCLX9JLikTXK9MWYzKs+606Fg1d7AXmUEDfBXjKtxl2FIeXjY9/fRwLUt9yGRwF5GCZ
 tuyhhxuuugA3/VanFA3QQWGSgrCzzHW5BzxcngxMwnm3L5MuHA6IePCD3X5S/qJP1Hinc88XTEN3s
 LxkuRcoFBaEn/6H76U2rsF7Teukg//N+LmBmdWmirZ7KW1pVh1GIApWHw9ki6wAz+VL+f9V3lA5Xz
 kfToLrJvA3uR16OSPfsbqLKG67quLId0Y+Zw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2f5T-1qoSTs3sDf-004Fyg; Mon, 25
 Sep 2023 23:14:28 +0200
Message-ID: <ceb9440b-a280-43ae-9e3f-162a18648a10@gmx.com>
Date:   Tue, 26 Sep 2023 06:44:24 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] btrfs: introduce "abort=" groups for more strict
 error handling
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1695350405.git.wqu@suse.com>
 <20230922145513.GF13697@twin.jikos.cz>
 <25c4f01f-a355-43b9-ab22-725353dc6380@suse.com>
 <20230925163740.GQ13697@twin.jikos.cz>
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
In-Reply-To: <20230925163740.GQ13697@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Vw5U5xGzeQk3yl+j7zfuojakDoLxN7XsoUJLW7lRtsYbeh+BFf9
 o7PHXHleIZyPIZ7VJ2zfsPHdupRK7K2FQpqz8DvoWwIAbmnswjo4JkDGrpypCMsPPY7P83/
 vuXFRXF58hjYUVD857nctPFwBpZStNVYamcSbk6vSHR0uim8S2ac9oik+NL4yOijq3gJHWO
 P6zRHs8hObHW1eH0yGv6g==
UI-OutboundReport: notjunk:1;M01:P0:UcyeyH8FnkA=;2bboxI5JUZrIHOIdyF1NOjliqer
 BlIGcF6ZACivYIqBJqygxMeFrypX55Jod6IgC+pnuWy8q6L/qp/6+Q7TxWkPijtuyNS2//04o
 00mpi6yh/RkXY2lerKDc/yxu65W/w+Uloib9A6uekyb/grVy9vglDt+BWCQlXUOXZQi/Dyl+I
 DJKTBqA+/5zk9pwnNx8Re1Pa+QFjwtYiXIWm/w0juzYoQeOlbnvqBEEl49Ro/SEdvjxg6+QFd
 NiDKyt6IP1IGxMcNOAKeCD2XroARDdN/r92RAw5ii4TNmkoinhoaKOOQ5c05kg6Fjiuz7yaTX
 70sHukvnGl4e137fmgMC0YQ6neQaok/5JyquHLwNTVUmdpu9/1rjj4wyOYRynsdnMptyVXvZn
 eSN195oj4ptNm3yG8u+yWR2WcBx+7Gifo7T/YTq8GCAEscxjaOrw3E+ZWYiVFBzQ/NwuLotkw
 f6YI/4MBojezT24VELK8a1OmTwjsLOuE41SukWSGaJWg8r/3aYPFkND+fmhEalDXxuFKlOXr4
 0/aPF0qJ19Ro2aAatvj6sP9eypa7wbE+4NnpLYu2Z0iiQf0UN0zrq5qViohL4GoR68zZM1kBj
 3ZUfpI0Y3g6ODkw9Slbu91423YgHS1prqBlD0mVXFgA2T513yaNc8jgDoyZo+YKJTmefGF/nn
 eSnAPT+FHBVijx7QJmQQMUow5pPj9zoN1CqIEPCSXuLaIx88w8fsWGM18uZ33Qpl12BRHYrdR
 zKHtjSFaexkYYtWKyj6NsfyoFaLaFhsoGVjvutAk32vIoHb7fOXu+R4eFb5blW5jiqg8sM3qX
 1TaMb/j1xHyrkHUwkuNf8REgFhJQXoNcqjKzEJa72H48HoH+9wclt1dowwKUf/WI6LPTQOO5K
 22HFcAB3USP9PaoyPXpuU3yT3Y12B2LxsW+Ni5A7C4JGveVlMv2OWwjFLRBxKYVC2w7jfUR+M
 4P4upRdN7L33ogxmGsJAyo/vcJE=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/26 02:07, David Sterba wrote:
> On Sat, Sep 23, 2023 at 06:46:26AM +0930, Qu Wenruo wrote:
>> On 2023/9/23 00:25, David Sterba wrote:
>>> On Fri, Sep 22, 2023 at 12:25:18PM +0930, Qu Wenruo wrote:
>>>> On the other hand, I totally understand if just a single sector faile=
d
>>>> to be write and we mark the whole fs read-only, it can be super
>>>> frustrating for regular end users, thus we can not make it the defaul=
t
>>>> behavior.
>>>
>>> I can't imagine a realistic scenario where a user would like this
>>> behaviour, one EIO takes down whole filesystem could make sense only f=
or
>>> some testing environments.
>>
>> I doubt, for some environment with expensive hardware, one may not even
>> expect any -EIO for valid operations.
>> If that happens, it may mean bad firmware or bad hardware, neither is a
>> good thing especially if they paid extra money for the fancy hardware o=
r
>> the support fee.
>
> So the semantics we'd need is like "fail on first error of <type>" where
> we can define a set of errors, like EIO, superblock write erorr or
> something related to devices.

The "set of errors" would be very specific, thus -EIO is not a good idea
AFAIK.

>
>>>> So here we introduce a mount option group "abort=3D", and make the
>>>> following errors more noisy and abort early if specified by the user.
>>>
>>> Default andswer for a new mount option is 'no', here we also have one
>>> that is probably doing the same, 'fatal_errors', so if you really want
>>> to do that by a mount option then please use this one.
>>
>> Or I can go sysfs interface and put it under some debug directory.
>
> For a prototype it's much more convenient until we understand what's the
> actual usecase.

Well, not that convenient, as we need to expand the mount option bits to
U64, or on 32bit systems we're going to cause problems due to the fact
that we're go beyond 32 mount options. (the first patch)

>
>>>
>>>>     This new "rescue=3Dsuper" may be more frequently used considering=
 how
>>>>     loose our existing tolerance is.
>>>>
>>>> - Any data writeback failure
>>>>     This is only for the data writeback at btrfs bio layer.
>>>>     This means, if a data sector is going to be written to a RAID1 ch=
unk,
>>>>     and one mirror failed, we still consider the writeback succeeded.
>>>>
>>>> There would be another one for btrfs bio layer, but I have found
>>>> something weird in the code, thus it would only be introduced after I
>>>> solved the problem there, meanwhile we can discuss on the usefulness =
of
>>>> this patchset.
>>>
>>> We can possibly enhance the error checking with additional knobs and
>>> checkpoints that will have to survive or detect specific testing, but =
as
>>> mount options it's not very flexible. We can possibly do it via sysfs =
or
>>> BPF but this may not be the proper interface anyway.
>>
>> I think sysfs would be better, but not familiar enough with BPF to
>> determine if it's any better or worse.
>
> BPF is probably a bad idea, I mentioned only as a potential way, it's
> another extensible interface.
>
> What you suggest looks like the forced shutdown of filesystem. This can
> be done internally or externally (ioctl). I haven't looked at the
> interface to what extent it's configurable, but let's say there's a
> bitmask set by admin and the filesystem checks that in case a given type
> of error happens. Then forced shutown would be like a transaction abort,
> followed by read-only. We have decent support for that but with the
> shutdown some kind of audit would have to happen anyway, namely for the
> EIO type of errors. Specific context like super block write error would
> be relatively easy.

I'm not sure if I understand the bitmask thing correctly.

The idea of the series is to catch certain types of error which are by
default ignored/handled gracefully.
The bitmask looks a little too generic, what we want is to catch
specific error at certain call sites (thus I can understand why you
mention ebpf).

Thus we can not just simple use a bitmask to handle all the generic
errors, but add checks into the route we're interested in.

Thanks,
Qu
