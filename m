Return-Path: <linux-btrfs+bounces-3363-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D39BA87F098
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 20:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1F881C213E5
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 19:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DFE56B8C;
	Mon, 18 Mar 2024 19:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="FPekoRoz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1266711707
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710791601; cv=none; b=cpko2kAZ6uJf38k2gsi6vLMvd2wR69A3jVzqiuq8x5vAAtmaXU1N0p6A9SWJ4esrbNibZWTXlNVfN9wv1CciNZjQSWrluhRtHHfppGrdkf+5e7fbc2czjfxmwTEsRTVWPe269A25xmHd5wSwyegrWdd4ivjSBmP48/7oLWZHTKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710791601; c=relaxed/simple;
	bh=0Dc0vogXYac9yyUR/klSNNs2wC8MX5/mL5O0bwzS5AE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BXutIh+0zp045qtXn13XjzxRnafU/K3rmNa6qqQ/stJStqybuEnTwf9qqsxU51dq8CQglF2ZgXA56/kr7ij7iIS6+uXcIuXmfhof+f5AVKR6AUcLrMz/5qI2uwpTGL2/Vxm6/Ir/ab2UBX4imsUjlid41TsZCIHWp1h3PN5ofWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=FPekoRoz; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1710791592; x=1711396392; i=quwenruo.btrfs@gmx.com;
	bh=5EqP76lYB1IHwVfIxktvz8xsJrIsHvu2ljem7yKazhk=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=FPekoRozKu06sY0PfOalVgesw2jJTPmY5srLjRO0jyWY5UoqXXCo/SG5OHoYo7nM
	 V/YBZmUzhqeuwRGwbSW2FkkhaGPvLQTBMvkKJ/FAMHuMS3hOWA1f0fNeReAx3BVqM
	 wirODGsCbY8dL9MEf25W8BCfxiTz3KxAR5QaZUUYoWL/hq7AEggcPP5if1oGuHtO3
	 WgnWAS4UI2gVZH9+fduApVCegPwGKWXMOCuFrf1XtkB4B9Z3ROsYI9MnuauQ8jRKt
	 ulQogfJeiyUxo5YHSI32oysR1Il29jffL95ZNW/fewfiR4KjjEjnOD3MwAww9ZAXt
	 VrtYSasIfjb8e36ERw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MVvPD-1rNOC22FDJ-00RmDf; Mon, 18
 Mar 2024 20:53:12 +0100
Message-ID: <9fca4194-01cf-4b73-80e1-e1a55dd8c825@gmx.com>
Date: Tue, 19 Mar 2024 06:23:08 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] btrfs: scrub: remove unnecessary dev/physical lookup
 for scrub_stripe_report_errors()
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1710409033.git.wqu@suse.com>
 <348c07314744f4914f5d613c516e9790f8c725b5.1710409033.git.wqu@suse.com>
 <CAL3q7H5Wgh4VEiNjX5_UOEftg55FAsi9Gy3SMZOVtkfKCszGoQ@mail.gmail.com>
 <c3f5aafc-9c9b-4b16-a71c-56985964318c@gmx.com>
 <CAL3q7H67XsqdDXAS57r8i8QZZsSVoMsEZZjGSeY=si7GNbiM1A@mail.gmail.com>
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
In-Reply-To: <CAL3q7H67XsqdDXAS57r8i8QZZsSVoMsEZZjGSeY=si7GNbiM1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:02irTmQ+iJ7NNS1XniOP8+BBC6+dKg3+QP1bohlB7RompUVIYEQ
 B+TkvWvaoSYyeE6vnMTJGZyJrv8wlUeBJTrLRdkSFy+M8SThZITIQaRK0wICNoduAg8L7GD
 zjmaPuz/1t5K2f75kD2naYbHxznGUg2e3XdDFgStdWmIo9IsG5lNltGr+ODnjIb2GGtLRoe
 PTNwvxxOra2Lk/xDhFoqQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dyBbdPiH2vc=;kupYvWKf8B4Ig16mwzRDYASNakO
 mcgGn4kYuJ7fuqqsNmhU44SxkpxwGHaokBU9k/mnoIy8GI4L/FdxybA8IRtAiO8Ypqj0OlFkL
 hh52q5CcxxKXysBHPJV1+7Ntbypx9hmkl0D5EpK6H5jFfjFPQC8VJW1IZiQUqPREjhLBDWPIE
 RiJJoPtV/b7oyEO55LsAe49E3R8o6NJv2uEcUJrS3+DAgP2u1YwVN3zl0atpvNMVHFcdeAlRC
 pjPcmA06nShd4TWocLims4hDLpv2Oy7+p5iu/28SO5Z4MgObGcC+BHQ4ZYs+ArYO61WcwEWWC
 dlypZmmSKOatug5igYW8q2CE+tCv1pT5dNQsF8toUSWCPxxb95K2AlKvSOa9lOyZBTg5RpSBd
 dnJ1+n5TySZ/MrZ65CAbkTJgmMPiQ5TwxLzHGNkt1C4JtdrvOrtBC4orLEDndgAMM1FcbR/8O
 C5iSOfNa5kj1d3O7SZLhAUc+rZEWOp5/9mPnnV8nK/7Yo7XOyryctfL6wb8IDLLfeJUMNnpNT
 QxPfhKmIzDsXUxG1XmaWn918EdBRE+C4dJjYagAhGjP4GWeM+ttQVTqijPzQcArRQRtfpSBD/
 LpaPDN/wU1Je1NI/KWqEMArjyxcUBruXqYno150ycv3tDmuRZP2P4xRF299TG5pfF5CBIphIF
 cMlI7gAC19hJ79O1Fzhe5ZSfYIaAq56v9tOLFuxChDwkhhy0uxCVVp83cN1pCvht9kq5mntbO
 BwGSlffUZMbitMOQSjZiAIiT/UzcYDX5ji2AYqqvINJLz6+x8PCAdCgYEBq0T6pUqnbAitpJL
 rx9pLI/vIXbZNViLKa5Q3W02NpwZkz3fzsRr1Bpe3yNC8=



=E5=9C=A8 2024/3/19 02:46, Filipe Manana =E5=86=99=E9=81=93:
> On Thu, Mar 14, 2024 at 8:28=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
>>
>>
>>
>> =E5=9C=A8 2024/3/15 03:56, Filipe Manana =E5=86=99=E9=81=93:
>>> On Thu, Mar 14, 2024 at 9:50=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote=
:
>>>>
>>>> The @stripe passed into scrub_stripe_report_errors() either has
>>>> stripe->dev and stripe->physical properly populated (regular data
>>>> stripes) or stripe->flags would have SCRUB_STRIPE_FLAG_NO_REPORT
>>>> (RAID56 P/Q stripes).
>>>>
>>>> Thus there is no need to go with btrfs_map_block() to get the
>>>> dev/physical.
>>>>
>>>> Just add an extra ASSERT() to make sure we get stripe->dev populated
>>>> correctly.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>    fs/btrfs/scrub.c | 59 ++++++--------------------------------------=
----
>>>>    1 file changed, 7 insertions(+), 52 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>>>> index 5e371ffdb37b..277583464371 100644
>>>> --- a/fs/btrfs/scrub.c
>>>> +++ b/fs/btrfs/scrub.c
>>>> @@ -860,10 +860,8 @@ static void scrub_stripe_submit_repair_read(stru=
ct scrub_stripe *stripe,
>>>>    static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
>>>>                                          struct scrub_stripe *stripe)
>>>>    {
>>>> -       static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
>>>> -                                     DEFAULT_RATELIMIT_BURST);
>>>>           struct btrfs_fs_info *fs_info =3D sctx->fs_info;
>>>> -       struct btrfs_device *dev =3D NULL;
>>>> +       struct btrfs_device *dev =3D stripe->dev;
>>>>           u64 stripe_physical =3D stripe->physical;
>>>>           int nr_data_sectors =3D 0;
>>>>           int nr_meta_sectors =3D 0;
>>>> @@ -874,35 +872,7 @@ static void scrub_stripe_report_errors(struct sc=
rub_ctx *sctx,
>>>>           if (test_bit(SCRUB_STRIPE_FLAG_NO_REPORT, &stripe->state))
>>>>                   return;
>>>>
>>>> -       /*
>>>> -        * Init needed infos for error reporting.
>>>> -        *
>>>> -        * Although our scrub_stripe infrastructure is mostly based o=
n btrfs_submit_bio()
>>>> -        * thus no need for dev/physical, error reporting still needs=
 dev and physical.
>>>> -        */
>>>> -       if (!bitmap_empty(&stripe->init_error_bitmap, stripe->nr_sect=
ors)) {
>>>> -               u64 mapped_len =3D fs_info->sectorsize;
>>>> -               struct btrfs_io_context *bioc =3D NULL;
>>>> -               int stripe_index =3D stripe->mirror_num - 1;
>>>> -               int ret;
>>>> -
>>>> -               /* For scrub, our mirror_num should always start at 1=
. */
>>>> -               ASSERT(stripe->mirror_num >=3D 1);
>>>> -               ret =3D btrfs_map_block(fs_info, BTRFS_MAP_GET_READ_M=
IRRORS,
>>>> -                                     stripe->logical, &mapped_len, &=
bioc,
>>>> -                                     NULL, NULL);
>>>> -               /*
>>>> -                * If we failed, dev will be NULL, and later detailed=
 reports
>>>> -                * will just be skipped.
>>>> -                */
>>>> -               if (ret < 0)
>>>> -                       goto skip;
>>>> -               stripe_physical =3D bioc->stripes[stripe_index].physi=
cal;
>>>> -               dev =3D bioc->stripes[stripe_index].dev;
>>>> -               btrfs_put_bioc(bioc);
>>>> -       }
>>>> -
>>>> -skip:
>>>> +       ASSERT(dev);
>>>>           for_each_set_bit(sector_nr, &stripe->extent_sector_bitmap, =
stripe->nr_sectors) {
>>>>                   u64 logical =3D stripe->logical +
>>>>                                 (sector_nr << fs_info->sectorsize_bit=
s);
>>>> @@ -933,42 +903,27 @@ static void scrub_stripe_report_errors(struct s=
crub_ctx *sctx,
>>>>                    * output the message of repaired message.
>>>>                    */
>>>>                   if (repaired) {
>>>> -                       if (dev) {
>>>> -                               btrfs_err_rl_in_rcu(fs_info,
>>>> +                       btrfs_err_rl_in_rcu(fs_info,
>>>>                           "fixed up error at logical %llu on dev %s p=
hysical %llu",
>>>>                                               logical, btrfs_dev_name=
(dev),
>>>>                                               physical);
>>>> -                       } else {
>>>> -                               btrfs_err_rl_in_rcu(fs_info,
>>>> -                       "fixed up error at logical %llu on mirror %u"=
,
>>>> -                                           logical, stripe->mirror_n=
um);
>>>> -                       }
>>>>                           continue;
>>>>                   }
>>>>
>>>>                   /* The remaining are all for unrepaired. */
>>>> -               if (dev) {
>>>> -                       btrfs_err_rl_in_rcu(fs_info,
>>>> +               btrfs_err_rl_in_rcu(fs_info,
>>>>           "unable to fixup (regular) error at logical %llu on dev %s =
physical %llu",
>>>>                                               logical, btrfs_dev_name=
(dev),
>>>>                                               physical);
>>>> -               } else {
>>>> -                       btrfs_err_rl_in_rcu(fs_info,
>>>> -       "unable to fixup (regular) error at logical %llu on mirror %u=
",
>>>> -                                           logical, stripe->mirror_n=
um);
>>>> -               }
>>>>
>>>>                   if (test_bit(sector_nr, &stripe->io_error_bitmap))
>>>> -                       if (__ratelimit(&rs) && dev)
>>>> -                               scrub_print_common_warning("i/o error=
", dev,
>>>> +                       scrub_print_common_warning("i/o error", dev,
>>>>                                                        logical, physi=
cal);
>>>>                   if (test_bit(sector_nr, &stripe->csum_error_bitmap)=
)
>>>> -                       if (__ratelimit(&rs) && dev)
>>>> -                               scrub_print_common_warning("checksum =
error", dev,
>>>> +                       scrub_print_common_warning("checksum error", =
dev,
>>>>                                                        logical, physi=
cal);
>>>>                   if (test_bit(sector_nr, &stripe->meta_error_bitmap)=
)
>>>> -                       if (__ratelimit(&rs) && dev)
>>>> -                               scrub_print_common_warning("header er=
ror", dev,
>>>> +                       scrub_print_common_warning("header error", de=
v,
>>>
>>> Why are we removing the rate limiting?
>>> This seems like an unrelated change.
>>
>> Because the ratelimit is not consistent.
>>
>> E.g. the "fixed up error" line is not rated limited by @rs, but by
>> btrfs_err_rl_in_rcu().
>
> That I don't understand.
>
> What I see is that scrub_print_common_warning() calls
> btrfs_warn_in_rcu() or btrfs_warn() or scrub_print_warning_inode()
> (which calls btrfs_warn_in_rcu()).
> I don't see where btrfs_err_rl_in_rcu() is called. So to me it seems
> @rs is doing the rate limiting.
>
>>
>> And we would have scrub_print_common_warning() to go btrfs_*_rl() helpe=
r
>> in the coming patches.
>
> Ok, but if @rs is indeed doing the rate limiting here, then from an
> organization point of view, it should be removed in the later patch
> that makes scrub_print_common_warning() use the btrfs_*_rl() helpers.

OK, I'll rearrange the patches so that @rs would only be removed after
we have migrate all the messages are migrated to rate limited versions.

Thanks,
Qu
>
> Thanks.
>
>>
>> Thanks,
>> Qu
>>>
>>> Everything else looks ok.
>>>
>>> Thanks.
>>>
>>>>                                                        logical, physi=
cal);
>>>>           }
>>>>
>>>> --
>>>> 2.44.0
>>>>
>>>>
>>>

