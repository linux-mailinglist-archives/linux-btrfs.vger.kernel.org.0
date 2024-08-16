Return-Path: <linux-btrfs+bounces-7289-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9DF955314
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Aug 2024 00:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A7F282263
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 22:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4394143C67;
	Fri, 16 Aug 2024 22:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="E7s4M8za"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F354127E37
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2024 22:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723845962; cv=none; b=S+CyNTZqTVqmp6NA71IQVck/TK50yah149O9kSfnu5GrYi8pXEjAJjxOx/bBKQnpsnRx8I9OjhfxSFVwqKLkvueVXFZl1LKAwTFpqoEPjUGUpqKIiBEBuQLs4iw2UdvwIil6nCBY83tYadhTLYQ0aGgkmXDhxmNP2m9HgDb+A6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723845962; c=relaxed/simple;
	bh=jPbmKFRPfunSK4NyGJKOmDOK11LX0Ukj/tpg7d0id2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B+d4iTmGZXOals17JHB404NEHxqXkloAHxQGlopgGVkZ75zOPadoKiXFLTpeTmCiu2BBESjMPkgSUuHJA8ovqxWZ0wXt1rAOPyoMwdJFfeQ/5Sq6YfxPyCKuaWcd7CDVyxrkHb9Av5oXxr+T0rUtgRqB3+/0OtbGUGWsnBD7KKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=E7s4M8za; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1723845948; x=1724450748; i=quwenruo.btrfs@gmx.com;
	bh=jPbmKFRPfunSK4NyGJKOmDOK11LX0Ukj/tpg7d0id2w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=E7s4M8zaUXtwCqwlYfIYhR0pkX7LKRM1RVCfSJ9plTe/eiM6du9rIAZJ5u7OEWfX
	 /6KN2GmB0Mb8RsREBZFBz8ODFfrbK7sxPPb7QS7F2iwR1Vjtglt9hOyj38YGi5j8k
	 BYhjs0+xGZvldWn7OIY1PwY/I3g+lYtsROfF18Ae0dwN2T1Ejcg6DBbk6WpbyRTAU
	 XvN3OiFyhU6H8/XmNgH3s1Kfn3+7ZLB6cwQxt5kWaRz6Y8m91+lFfwKGiEUNH9S+U
	 bWhGh0so6+jdMAiMCvtRnin6yjEMFJ2KKfR7CxUPz2Gv9EnaI8bgl669iNXxNHOP9
	 smQ6BOxK0nDFa/pI2A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N95eJ-1s8CVQ3xjz-012cMS; Sat, 17
 Aug 2024 00:05:48 +0200
Message-ID: <916fc65b-8aeb-40d2-ab3e-1af99d71122c@gmx.com>
Date: Sat, 17 Aug 2024 07:35:44 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] btrfs: only run extent map shrinker inside cleaner
 kthread
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Ivan Shapovalov <intelfx@intelfx.name>,
 =?UTF-8?Q?Jannik_Gl=C3=BCckert?= <jannik.glueckert@gmail.com>
References: <b5f8d32e8b4fb1bfb3a88f5373530980f1d2f523.1723798569.git.wqu@suse.com>
 <CAL3q7H68VyuHLe3Y4ieBtkHk3ET3=sbXrCadK8Q9ck=EskeLEQ@mail.gmail.com>
 <93abd2a7-9876-4353-8116-cd5f8135cb03@gmx.com>
Content-Language: en-US
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
In-Reply-To: <93abd2a7-9876-4353-8116-cd5f8135cb03@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yjH857JpDsHuQeiyb4tnJ15EIF0l28ctIayzC/tlkbxR8KWomU0
 ZXc2aIp+GllSCBCYLgshgGy3/kHZsOOxlRDpvki6V7rza/Nv8HZk5HTVVPkaZ/58HA5tR+d
 FK4wyVk09K6WXshaMKqjhO638qAmvDHuWO4DA5t+9+IOtpuo82RVaHlnmCOON/cyNZQho88
 xcw8GUJzTS1Wd9XTgVCnw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kCX6DF4FQz8=;XGDRGnzcjbyUiklA/sxLYlBivBo
 zrXi6kNvnY3vQk69hJCazWhmeutGz3EvAQ+LZKgWaBjXsKxOSvDq43+JE1OsTL9j2akZ4CTJ6
 I1wydfo7RtmNd0qVVbkru/Z82ymaffCbCL+Pd79HM6Uf+La4oISUZwPTsFz6eyEdlHrhQs3x4
 URMtw0g0jqBxKAnUC8m1HyI/c2zWmOm1e3BJgUxHRrG8T08MNRLYdqfKDyGPN3Lej28t5UpNW
 AyCPpaSdq2RwwKW9BhwwujfQhqwQ4yaCU8Eis2sSIZqpwpN7vTtScGg+5YHKOomFtyklbb2z9
 E2tb2zsIhR5UXto/ZwxaKMjgzfHLa3Wgh50vUw1WcPb/BIK6+/BFgy66gv9WlFugBTNx/PP2p
 ItSBABHKzHx69gPWD+JwkDF+x7lHZN5zK+PyBOXnB2RGSwSwfyU2ER2MHdExnfXnIW+Dl0g6L
 bsi1zpJ+PoiYGzlh8STMvcE/sxpqN0jsQyhATyEWCvtt5PgQ5M4TOdMHpkWX34MdTCpe1aiBI
 R76gnkyXs+jfZkQX/ASDMu1CCXxJDeGkm8qaE95xyj5FzjyQwmZqPNtAlFgTTmXJaTalDSmqT
 5+0tjWzue+jIrXPWDffUwFseGDNk5ZfnfSgGDGcDEPpn439D7iF7I3A2T0i5TVuw6EvmtJoBS
 3okjMgLIfkKR75e+w/jYCZ442r8TsDYypdaRSoR6azZzBS31vfUUy4X+BNO5VwZXPtECrKAYo
 QqysWfCwvqkfuAM7y13RmMWc/p0J6op0fmeJh6UrGSRR8Xs90YtnFdYvPBrfNryEXaGYlH9l2
 pnDdoawvQ7AKLdesb8LAE2JDBk1GFjhVFepF5O+37V8Eo=



=E5=9C=A8 2024/8/17 07:22, Qu Wenruo =E5=86=99=E9=81=93:
>
>
> =E5=9C=A8 2024/8/16 20:39, Filipe Manana =E5=86=99=E9=81=93:
>> On Fri, Aug 16, 2024 at 9:58=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>>
>>> There are still reports about extent map shrinker is causing high CPU
>>> usage.
>>>
>>> It turns out that the call backs can be very frequent, even inside
>>> kswapd (and we can have multiple kswapd if the system have several
>>> nodes).
>>
>> You mean numa nodes?
>> Are you sure that's the problem, and not something like tasks waiting
>> long for a kswapd task because it's doing extent map removal?
>
> I'm pretty sure this is not the root cause.
>
>>
>>>
>>> For the only other fs implementing the reclaim callbacks, XFS does it
>>> very differently by ensure the following conditions:
>>>
>>> - Make sure there is only one reclaim work queued
>>>
>>> - Add a delay before queuing the reclaim workload
>>> =C2=A0=C2=A0 The default delay is 18s (60% of xfs_syncd_centisecs)
>>>
>>> In btrfs, there is already a context which is very similar to the XFS
>>> condition: cleaner kthread.
>>>
>>> There is only one cleaner kthread for the fs, and it's waken
>>> periodically
>>> (the same time interval as commit interval, which is 30s by default).
>>>
>>> So it's much better to run the extent map shrinker inside cleaner
>>> kthread.
>>
>> No please, don't do it in the cleaner.
>>
>> There's already a lot of different work that the cleaner does, from
>> running delayed iputs, to defrag inodes, remove deleted roots, etc.
>> Adding the shrinker there only increases the delay for those tasks and
>> those tasks increase the delay for the shrinker to run and free
>> memory.
>>
>> I'd rather have this done as an unbounded work queue item like we do
>> for space reclaim.
>> In fact one thing I have in my todo list is to get rid of the cleaner
>> and have all work done in work queues (it's not that straightforward
>> as it may seem).
>
> OK, that also works fine for me, although it would be better also to
> introduce the extra delay just like XFS.
>
>>
>>>
>>> And make the free_cached_objects() callback to only record the latest
>>> number to free.
>>>
>>> Link:
>>> https://lore.kernel.org/linux-btrfs/3df4acd616a07ef4d2dc6bad668701504b=
412ffc.camel@intelfx.name/
>>> Link:
>>> https://lore.kernel.org/linux-btrfs/c30fd6b3-ca7a-4759-8a53-d42878bf84=
f7@gmail.com/
>>> Reported-by: Ivan Shapovalov <intelfx@intelfx.name>
>>> Reported-by: Jannik Gl=C3=BCckert <jannik.glueckert@gmail.com>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>> Reason for RFC:
>>>
>>> I do not have an environment which can trigger the reclaim that
>>> frequently, thus more tests would be appreciated.
>>
>> So I'd rather have time spent analysing things and testing them than
>> having hypothetical test patches.
>>
>>>
>>> If one wants to test, please use this branch:
>>> https://github.com/adam900710/linux.git em_shrink_freq
>>>
>>> And enable CONFIG_BTRFS_DEBUG (since the previous patch hides the
>>> shrinker behind DEBUG builds).
>>>
>>> ---
>>> =C2=A0 fs/btrfs/disk-io.c=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +++
>>> =C2=A0 fs/btrfs/extent_map.c |=C2=A0 3 ++-
>>> =C2=A0 fs/btrfs/extent_map.h |=C2=A0 2 +-
>>> =C2=A0 fs/btrfs/fs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 1 +
>>> =C2=A0 fs/btrfs/super.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 22 +++++++----=
-----------
>>> =C2=A0 5 files changed, 14 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>>> index a6f5441e62d1..624dd7552e0f 100644
>>> --- a/fs/btrfs/disk-io.c
>>> +++ b/fs/btrfs/disk-io.c
>>> @@ -1542,6 +1542,9 @@ static int cleaner_kthread(void *arg)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * space.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_reclaim_bgs(fs_info);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (IS_ENABLED(CONFIG_BTRFS_DEBUG))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_free=
_extent_maps(fs_info);
>>> =C2=A0 sleep:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 clear_and_wake_up_bit(BTRFS_FS_CLEANER_RUNNING=
,
>>> &fs_info->flags);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (kthread_should_park())
>>> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
>>> index 25d191f1ac10..1491429f9386 100644
>>> --- a/fs/btrfs/extent_map.c
>>> +++ b/fs/btrfs/extent_map.c
>>> @@ -1248,13 +1248,14 @@ static long btrfs_scan_root(struct btrfs_root
>>> *root, struct btrfs_em_shrink_ctx
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return nr_dropped;
>>> =C2=A0 }
>>>
>>> -long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long
>>> nr_to_scan)
>>> +long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_em_shrin=
k_ctx ctx;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 start_root_id;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 next_root_id;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool cycled =3D false=
;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 long nr_dropped =3D 0=
;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 long nr_to_scan =3D
>>> READ_ONCE(fs_info->extent_map_shrinker_nr_to_scan);
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctx.scanned =3D 0;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctx.nr_to_scan =3D nr=
_to_scan;
>>> diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
>>> index 5154a8f1d26c..070621b4467f 100644
>>> --- a/fs/btrfs/extent_map.h
>>> +++ b/fs/btrfs/extent_map.h
>>> @@ -189,6 +189,6 @@ void btrfs_drop_extent_map_range(struct
>>> btrfs_inode *inode,
>>> =C2=A0 int btrfs_replace_extent_map_range(struct btrfs_inode *inode,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stru=
ct extent_map *new_em,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool=
 modified);
>>> -long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long
>>> nr_to_scan);
>>> +long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info);
>>>
>>> =C2=A0 #endif
>>> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
>>> index 3d6d4b503220..a594c8309693 100644
>>> --- a/fs/btrfs/fs.h
>>> +++ b/fs/btrfs/fs.h
>>> @@ -636,6 +636,7 @@ struct btrfs_fs_info {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spinlock_t extent_map=
_shrinker_lock;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 extent_map_shrink=
er_last_root;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 extent_map_shrink=
er_last_ino;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 long extent_map_shrinker_nr_to_s=
can;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Protected by 'tran=
s_lock'. */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct list_head dirt=
y_cowonly_roots;
>>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>>> index 98fa0f382480..5d9958063ddd 100644
>>> --- a/fs/btrfs/super.c
>>> +++ b/fs/btrfs/super.c
>>> @@ -2402,13 +2402,7 @@ static long btrfs_nr_cached_objects(struct
>>> super_block *sb, struct shrink_contro
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_btrfs_extent_ma=
p_shrinker_count(fs_info, nr);
>>>
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Only report the real num=
ber for DEBUG builds, as there are
>>> reports of
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * serious performance degr=
adation caused by too frequent
>>> shrinks.
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ENABLED(CONFIG_BTRFS_DEBU=
G))
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return nr;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return nr;
>>> =C2=A0 }
>>>
>>> =C2=A0 static long btrfs_free_cached_objects(struct super_block *sb,
>>> struct shrink_control *sc)
>>> @@ -2417,15 +2411,13 @@ static long btrfs_free_cached_objects(struct
>>> super_block *sb, struct shrink_cont
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_fs_info =
*fs_info =3D btrfs_sb(sb);
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We may be called from an=
y task trying to allocate memory
>>> and we don't
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * want to slow it down wit=
h scanning and dropping extent
>>> maps. It would
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * also cause heavy lock co=
ntention if many tasks
>>> concurrently enter
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * here. Therefore only all=
ow kswapd tasks to scan and drop
>>> extent maps.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Only record the latest n=
r_to_scan value. The real scan
>>> will happen
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * at cleaner kthread.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * As free_cached_objects()=
 can be triggered very frequently,
>>> it's
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * not practical to scan th=
e whole fs to reclaim extent maps.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!current_is_kswapd())
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return 0;
>>> -
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return btrfs_free_extent_maps(fs=
_info, nr_to_scan);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WRITE_ONCE(fs_info->extent_map_s=
hrinker_nr_to_scan, nr_to_scan);
>>
>> This is never reset to 0, so the shrinker will run even when we don't
>> need to free extent maps anymore, doing extra work, causing some
>> fsyncs to go to the slow path, etc.
>
> This will be updated by any newer free_cached_objects() call back, with
> the calculated nr_to_scan.
>
> If there is really nothing to free, it will be set to 0, as the
> nr_cached_objects() will return 0.

My bad, this is not going to work as if nr_cached_objects() returns 0,
free_cached_objects() will not be called.

So you're totally right, this is not the correct way to go.

Thanks,
Qu

>
>>
>> If you can wait about 1 week for me to be back from vacation, I can
>> continue with plans I have for the shrinker, and just disable the
>> shrinker in the meanwhile.
>
> Sure, that also works for me.
>
> Thanks,
> Qu
>
>>
>> Thanks Qu.
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> =C2=A0 }
>>>
>>> =C2=A0 static const struct super_operations btrfs_super_ops =3D {
>>> --
>>> 2.46.0
>>>
>>>
>>
>

