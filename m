Return-Path: <linux-btrfs+bounces-3311-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4FF87C447
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 21:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED0531F22140
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 20:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DB07604D;
	Thu, 14 Mar 2024 20:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="D74AxCCO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F4C6FE0B
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 20:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710448125; cv=none; b=W+TxlVYTb/kq2VapVWXKiN1nAzfFCdTd8wsybkBM45qSV7EPZQTPpLv8ixkfhqXQoQz7KDG+o+ULChEES9TMtjOGk/u5BscG2FUjowY0sFgMeIhwlsd70IpLG2po3OF/g9sw2KlVYkd4Ptb7lpNezwa/hI0x+zF61IP+KoaN1Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710448125; c=relaxed/simple;
	bh=ejLpfM/ZNxfz9cluz4+FtV4Wu6EfPGPZ/XS0/Vjck/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ODFNQdqi3FQxEF/EX8vtvf4xhGOwPQFoPY2+yWChAIjRDi0Tvz1Qr5+aeQ5loFD4pICiASPRNWwWOfW3Wi/BdtbfROJtUKEdVSwt1tCsJNnrBUOG1cYDaSsvEDMIACwrljUOvBWJjV7AJaqL17kYg20iO/3ZPvfZTQs/oSyPHQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=D74AxCCO; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1710448115; x=1711052915; i=quwenruo.btrfs@gmx.com;
	bh=tMSSWRbRQOQX1dLUT3guWIugqHR/AjUv4Vd6SkRuLFY=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=D74AxCCOwXypLXfmrwgoic+mSV+pJOc3xWj21PhFc5VpA4OZCwj0JV3dIUtncgq0
	 gnzhghDcudl82z4YcNr38IhLctbvh1apf/i6ZYomidHWMkb+D7pslqeAJdflFNgt3
	 +N1qxnHL/qIJW0552z9+/qYRUMcp+rmkOHLUDX5KoBua9DNjlGRZ8ckIlCtxxb2U1
	 XMgHsLRXPwgUg8fOZnQECOe9b2mQH0WiM3Dg5gi+ENdESRWgEhBZqloB0kQg2SZFx
	 DVTZRyKKULHgLGNFZnbr2/A3rYjIy5ZzPALTxoOcdSVFVJsn3iD9hJ96R9a5QBuUm
	 cKgZs7EM2BE8lgpSRg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXp9Y-1rJImF12Z2-00YCGR; Thu, 14
 Mar 2024 21:28:35 +0100
Message-ID: <c3f5aafc-9c9b-4b16-a71c-56985964318c@gmx.com>
Date: Fri, 15 Mar 2024 06:58:32 +1030
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
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1710409033.git.wqu@suse.com>
 <348c07314744f4914f5d613c516e9790f8c725b5.1710409033.git.wqu@suse.com>
 <CAL3q7H5Wgh4VEiNjX5_UOEftg55FAsi9Gy3SMZOVtkfKCszGoQ@mail.gmail.com>
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
In-Reply-To: <CAL3q7H5Wgh4VEiNjX5_UOEftg55FAsi9Gy3SMZOVtkfKCszGoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hc0rC4VlMu9Xc0weXBNgZR1zOufe2oGptAzqa5pmY1RNdtblFDI
 U9WPgFkb82tjMCVy4b7jzeGeUywMoZevHPji7F981+zEKAw5LIas874702MJh/5eVSacNtG
 IaVERGAYiqGIKZkdbJUR0Uj1Hfy2/Q5/cfBFnDdM4uRYvuab5rxqrb2Qin/znoNI6/gadGy
 rL6+C72YKeKswh4iT16yQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ODN75xZKxaQ=;672PZo6MJs4AIyHtLeWmYcQmsjD
 6i2m95qR8lSKsUA9vOol9PYZos8fmY0EeLtYqeW8+MxZrC7rB8PhpJZbY8S/I0Qy6dMxbALni
 aV7HNHiAQcPySWlxcZzdyMnex2P1ChimPkqoWe9KwS13DQA9hEJLYvxL0+wNHgmYj7JmmivG9
 ktKSosAtFWoV26CElzWKYmrWiVBD4hHblWzpuh6xRvNOHmTayGY15TlBdoDSwvKPdc5RJQ2Un
 7gujUF2knws63rmrUNAzXuZC02IIqnlmjJ6nM3ijrksB0FW1n7FdSwrKYjUanfyLos/HRPUdt
 N5iU5AuX06a6UWZrsh/VjrVaJouC4vaKPSrwwIqQd62CGRwej2rkKPwgg9bP3lVXWO0Ytn9ac
 841JRtBlmnVXu4IS78pRzUcP4B9Tm7JjvewUh1xu+HbhugxMiSCijLvhdSGYZZ/bXpCiZOcMS
 u6hCoC6Zi0DmqPnzyg+4+HHy0Sx8rMrlGZbHOnuR+8tNp4xw0ds9tSJN+HLUVZ3LP8JMu5ZkI
 B+DVsplmdGVOaB1EVGJj/mn2rESE7gAFYJBqZFeGkttxgV/W792ywUxfgZizyyxHzIwH17NpK
 OsVVmWiwk9KLasftei3QommpD8zmpcQdqiLGc81WZH91yAw8wSHNjAcOTiZhDB2QNQyY19vmN
 rAL8FsmdHuwFeJa6MWdditpd4/hr5kc78JtGxc8m1d+tSz9XQL3l8QB16R+wm+4YgIzxyCWKb
 hKgwY7BFWyLLVCflcJSBi1pB/m/4h6UgKz7lMdm0BOV+H6++y+SmyXdPcevK4MwU4Zf0Ed3Lz
 l8AgyHz3oXPzZJ+v1dIRnOL7dGOFVXAXXseAf0PLAZquo=



=E5=9C=A8 2024/3/15 03:56, Filipe Manana =E5=86=99=E9=81=93:
> On Thu, Mar 14, 2024 at 9:50=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> The @stripe passed into scrub_stripe_report_errors() either has
>> stripe->dev and stripe->physical properly populated (regular data
>> stripes) or stripe->flags would have SCRUB_STRIPE_FLAG_NO_REPORT
>> (RAID56 P/Q stripes).
>>
>> Thus there is no need to go with btrfs_map_block() to get the
>> dev/physical.
>>
>> Just add an extra ASSERT() to make sure we get stripe->dev populated
>> correctly.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/scrub.c | 59 ++++++-----------------------------------------=
-
>>   1 file changed, 7 insertions(+), 52 deletions(-)
>>
>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>> index 5e371ffdb37b..277583464371 100644
>> --- a/fs/btrfs/scrub.c
>> +++ b/fs/btrfs/scrub.c
>> @@ -860,10 +860,8 @@ static void scrub_stripe_submit_repair_read(struct=
 scrub_stripe *stripe,
>>   static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
>>                                         struct scrub_stripe *stripe)
>>   {
>> -       static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
>> -                                     DEFAULT_RATELIMIT_BURST);
>>          struct btrfs_fs_info *fs_info =3D sctx->fs_info;
>> -       struct btrfs_device *dev =3D NULL;
>> +       struct btrfs_device *dev =3D stripe->dev;
>>          u64 stripe_physical =3D stripe->physical;
>>          int nr_data_sectors =3D 0;
>>          int nr_meta_sectors =3D 0;
>> @@ -874,35 +872,7 @@ static void scrub_stripe_report_errors(struct scru=
b_ctx *sctx,
>>          if (test_bit(SCRUB_STRIPE_FLAG_NO_REPORT, &stripe->state))
>>                  return;
>>
>> -       /*
>> -        * Init needed infos for error reporting.
>> -        *
>> -        * Although our scrub_stripe infrastructure is mostly based on =
btrfs_submit_bio()
>> -        * thus no need for dev/physical, error reporting still needs d=
ev and physical.
>> -        */
>> -       if (!bitmap_empty(&stripe->init_error_bitmap, stripe->nr_sector=
s)) {
>> -               u64 mapped_len =3D fs_info->sectorsize;
>> -               struct btrfs_io_context *bioc =3D NULL;
>> -               int stripe_index =3D stripe->mirror_num - 1;
>> -               int ret;
>> -
>> -               /* For scrub, our mirror_num should always start at 1. =
*/
>> -               ASSERT(stripe->mirror_num >=3D 1);
>> -               ret =3D btrfs_map_block(fs_info, BTRFS_MAP_GET_READ_MIR=
RORS,
>> -                                     stripe->logical, &mapped_len, &bi=
oc,
>> -                                     NULL, NULL);
>> -               /*
>> -                * If we failed, dev will be NULL, and later detailed r=
eports
>> -                * will just be skipped.
>> -                */
>> -               if (ret < 0)
>> -                       goto skip;
>> -               stripe_physical =3D bioc->stripes[stripe_index].physica=
l;
>> -               dev =3D bioc->stripes[stripe_index].dev;
>> -               btrfs_put_bioc(bioc);
>> -       }
>> -
>> -skip:
>> +       ASSERT(dev);
>>          for_each_set_bit(sector_nr, &stripe->extent_sector_bitmap, str=
ipe->nr_sectors) {
>>                  u64 logical =3D stripe->logical +
>>                                (sector_nr << fs_info->sectorsize_bits);
>> @@ -933,42 +903,27 @@ static void scrub_stripe_report_errors(struct scr=
ub_ctx *sctx,
>>                   * output the message of repaired message.
>>                   */
>>                  if (repaired) {
>> -                       if (dev) {
>> -                               btrfs_err_rl_in_rcu(fs_info,
>> +                       btrfs_err_rl_in_rcu(fs_info,
>>                          "fixed up error at logical %llu on dev %s phys=
ical %llu",
>>                                              logical, btrfs_dev_name(de=
v),
>>                                              physical);
>> -                       } else {
>> -                               btrfs_err_rl_in_rcu(fs_info,
>> -                       "fixed up error at logical %llu on mirror %u",
>> -                                           logical, stripe->mirror_num=
);
>> -                       }
>>                          continue;
>>                  }
>>
>>                  /* The remaining are all for unrepaired. */
>> -               if (dev) {
>> -                       btrfs_err_rl_in_rcu(fs_info,
>> +               btrfs_err_rl_in_rcu(fs_info,
>>          "unable to fixup (regular) error at logical %llu on dev %s phy=
sical %llu",
>>                                              logical, btrfs_dev_name(de=
v),
>>                                              physical);
>> -               } else {
>> -                       btrfs_err_rl_in_rcu(fs_info,
>> -       "unable to fixup (regular) error at logical %llu on mirror %u",
>> -                                           logical, stripe->mirror_num=
);
>> -               }
>>
>>                  if (test_bit(sector_nr, &stripe->io_error_bitmap))
>> -                       if (__ratelimit(&rs) && dev)
>> -                               scrub_print_common_warning("i/o error",=
 dev,
>> +                       scrub_print_common_warning("i/o error", dev,
>>                                                       logical, physical=
);
>>                  if (test_bit(sector_nr, &stripe->csum_error_bitmap))
>> -                       if (__ratelimit(&rs) && dev)
>> -                               scrub_print_common_warning("checksum er=
ror", dev,
>> +                       scrub_print_common_warning("checksum error", de=
v,
>>                                                       logical, physical=
);
>>                  if (test_bit(sector_nr, &stripe->meta_error_bitmap))
>> -                       if (__ratelimit(&rs) && dev)
>> -                               scrub_print_common_warning("header erro=
r", dev,
>> +                       scrub_print_common_warning("header error", dev,
>
> Why are we removing the rate limiting?
> This seems like an unrelated change.

Because the ratelimit is not consistent.

E.g. the "fixed up error" line is not rated limited by @rs, but by
btrfs_err_rl_in_rcu().

And we would have scrub_print_common_warning() to go btrfs_*_rl() helper
in the coming patches.

Thanks,
Qu
>
> Everything else looks ok.
>
> Thanks.
>
>>                                                       logical, physical=
);
>>          }
>>
>> --
>> 2.44.0
>>
>>
>

