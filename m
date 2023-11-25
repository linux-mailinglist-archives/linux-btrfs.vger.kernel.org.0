Return-Path: <linux-btrfs+bounces-355-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1057F8962
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Nov 2023 09:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E4B281827
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Nov 2023 08:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AB49444;
	Sat, 25 Nov 2023 08:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ZUmuzc/3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5464CE6
	for <linux-btrfs@vger.kernel.org>; Sat, 25 Nov 2023 00:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1700901972; x=1701506772; i=quwenruo.btrfs@gmx.com;
	bh=Y2CXusdNyRzzRm09a4kd1Uon4hiUxNf69AeMZEwFdxk=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=ZUmuzc/3K4mAVkjJKwkoXgDko2N+hbGqbnAeUwU+wfgHEdt7ibfsRhEPXJD1Cjb6
	 I7lLfmKaoC+VOFYAMvt4oXURDk4r3qymPxR9KWAcWWvBB+YM58Es7EX4sa0vDcd4P
	 cwmKIdCRPfo2VtrBkx3t8LyA3x4Z9lRbNPKm36FaYLR8d9tzPa/1C9DsTYCubzso0
	 sm/PHDky9GBNefgITM3rhPEN81R8gS5U+eKiA6/wgfRGED8K+t+ZOgFZr2zf6RGQq
	 BLO+n24RJPCyEcfaGV0JMqmbrbXodJJIHxHv1to3HYA5jetGzK1FVfxS+vi8IiL3y
	 ws0cGlh02HPkf9YlDA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M9FnZ-1rCZC01s19-006RCE; Sat, 25
 Nov 2023 09:46:12 +0100
Message-ID: <a3f718be-021e-4711-b934-a0d59d97a054@gmx.com>
Date: Sat, 25 Nov 2023 19:16:07 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: free the allocated memory if
 btrfs_alloc_page_array() failed
Content-Language: en-US
To: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <0f34dd9fbefc379a65fe09074f975a199352d99e.1700796515.git.wqu@suse.com>
 <CAL3q7H5PzUKeGjBCVP16zQjpbvA_f3KuRd2ucpGZMWJHV7z13A@mail.gmail.com>
 <CAL3q7H4g=eD5y7DB6x8TW_S4D--2K9y4j5RKH37B-ZpAjfqctw@mail.gmail.com>
 <20231124142520.GC18929@twin.jikos.cz>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
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
In-Reply-To: <20231124142520.GC18929@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c0tFlJfrv3VghajjDbV80tWjXkKHuAZ0yrfZNKwj+STuWHrt7My
 svhHhsDifTuQqZuI4y24B3GZ/tfnAa738CQH19cHJp1McRTzN/dtrs6Abmy50Gk0wk8/zTa
 bNjtefw44+rWnubeoN8nSVTfCd4QluGrmQQQXXg3fQiWDt1IxxRKiGqK4sI6T8UNkwAagol
 OzLkn6LcOA7D1Z3ZwOV0g==
UI-OutboundReport: notjunk:1;M01:P0:CGVwhXbIfOQ=;2J5J0tnfz1uxfxArzdHdodpggyy
 iOSJDg43+ixqd2sNneGQRrg54tpeeNEblSYqdZYLd5rgDWdvqfG27KlNqBdl0p8g0Q2qrWW2C
 PYmaHqRIMvtiXRUmfC1ZlJcXa9M9ftqP3vh38GomNqOE5ZvLM7o6+Gr2y76yyAksViP/YXrtd
 FtE2T11UnTbRklLmQ6QH0eGApI/YczdPdxrO6Cqe0Ur3QfrzmQeCU+XtL8I1ykawxnJDk1veE
 oAtmCztlsT4qMnxfjVnD2cv/kUm6SZodNpfqA7UyZWjXXE2CT1Kt0c7B7KkYD7/xWvCgKtVy/
 2tPewKKwKapHX1sz6PGe9QrbgdBy7JaJ82QoWpLZxyYp5C8He95dn4Dmn3HSjsrjn93/+kAv1
 cPfEH2N6MVGYYoi6nIzSUlG/LKe7ssBZMTh8U9CoPxOvhvCpKTIqh6Y/zpHNqQsBOcJnAR2yh
 9hHZuPTrC7RQnxxjuMNqci7/veaIC/jpI0klRkoKEtDGtLnhqdLgP9dNXuDA9oVYObmiTq6Jt
 UR2aTPRoYCWZyMDKZos7LYHV+1J1jfEyK3/Gv0+b2KVFwfBr1Lwnw/BOegFtep0AM/U30Jdah
 Ijpb/frlTEJN/pErC9k1zhT7mpouViB2iWeEsv4xYcu1H7w6qhHZvkvXOw0BUntk/lghfVT1h
 NrTRZI1Tla/3JoEAQtfnKkEVTrlghtqY/V2MHzS2szelCApqkSJMz3SVoQDnDJANKPxPcLGq3
 zXz5BBO8Cfhjcnd9ufOXzC0v4gQY/IWQ6W4mI8vJhGuJPChnfL8SrfTzKgS5xiysZxEBIawZh
 BsZDabi61aAqWhjAO5y70iMDhJsdj2BD/UTSSafneDXkPPtuZO4tabU2AlhF7zFlOj09aeuWe
 z2mXnEfP9R97ixsvMQ4oCDjmZZYBbuApDaxSKw6HFw9PiCXC4l0nv8ZOqSXgjairJhyjdUU9q
 8AKEIk6Uk8cjQ3ATr0w/2XIuOrg=



On 2023/11/25 00:55, David Sterba wrote:
> On Fri, Nov 24, 2023 at 12:47:37PM +0000, Filipe Manana wrote:
>> On Fri, Nov 24, 2023 at 11:50=E2=80=AFAM Filipe Manana <fdmanana@kernel=
.org> wrote:
>>>
>>> On Fri, Nov 24, 2023 at 4:30=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote=
:
>>>>
>>>> [BUG]
>>>> If btrfs_alloc_page_array() failed to allocate all pages but part of =
the
>>>> slots, then the partially allocated pages would be leaked in function
>>>> btrfs_submit_compressed_read().
>>>>
>>>> [CAUSE]
>>>> As explicitly stated, if btrfs_alloc_page_array() returned -ENOMEM,
>>>> caller is responsible to free the partially allocated pages.
>>>>
>>>> For the existing call sites, most of them are fine:
>>>>
>>>> - btrfs_raid_bio::stripe_pages
>>>>    Handled by free_raid_bio().
>>>>
>>>> - extent_buffer::pages[]
>>>>    Handled btrfs_release_extent_buffer_pages().
>>>>
>>>> - scrub_stripe::pages[]
>>>>    Handled by release_scrub_stripe().
>>>>
>>>> But there is one exception in btrfs_submit_compressed_read(), if
>>>> btrfs_alloc_page_array() failed, we didn't cleanup the array and free=
d
>>>> the array pointer directly.
>>>>
>>>> Initially there is still the error handling in commit dd137dd1f2d7
>>>> ("btrfs: factor out allocating an array of pages"), but later in comm=
it
>>>> 544fe4a903ce ("btrfs: embed a btrfs_bio into struct compressed_bio"),
>>>> the error handling is removed, leading to the possible memory leak.
>>>>
>>>> [FIX]
>>>> This patch would add back the error handling first, then to prevent s=
uch
>>>> situation from happening again, also make btrfs_alloc_page_array() to
>>>> free the allocated pages as a extra safe net.
>>>>
>>>> Fixes: 544fe4a903ce ("btrfs: embed a btrfs_bio into struct compressed=
_bio")
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>
>>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>>>
>>> Looks good, thanks.
>>
>> Well, just one comment, see below.
>>
>>>
>>>> ---
>>>>   fs/btrfs/compression.c |  4 ++++
>>>>   fs/btrfs/extent_io.c   | 10 +++++++---
>>>>   2 files changed, 11 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
>>>> index 19b22b4653c8..d6120741774b 100644
>>>> --- a/fs/btrfs/compression.c
>>>> +++ b/fs/btrfs/compression.c
>>>> @@ -534,6 +534,10 @@ void btrfs_submit_compressed_read(struct btrfs_b=
io *bbio)
>>>>          return;
>>>>
>>>>   out_free_compressed_pages:
>>>> +       for (int i =3D 0; i < cb->nr_pages; i++) {
>>>> +               if (cb->compressed_pages[i])
>>>> +                       __free_page(cb->compressed_pages[i]);
>>>> +       }
>>
>> So this hunk is not needed, because of the changes you did to
>> btrfs_alloc_page_array(), as now it always frees any allocated pages
>> on -ENOMEM.
>
> Right, I'll drop the hunk, thanks.

In that case you may also want to delete the following commit message:

 > <<This patch would add back the error handling first, then>> to
prevent such

Thanks,
Qu
>

