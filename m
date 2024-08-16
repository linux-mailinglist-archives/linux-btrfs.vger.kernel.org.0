Return-Path: <linux-btrfs+bounces-7288-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B2A9552BE
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 23:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9618EB222A6
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 21:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EFA1C57B2;
	Fri, 16 Aug 2024 21:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="pkxfxJ0U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADC91C3F23
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2024 21:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723845192; cv=none; b=QXYChby5Xo09KalJZjGokqFfsfuUf5lkkakBu0i85jou+6l+VU264jaOFm5pe7i4gU/4FwdIDkGkIejeoHIpyqVbHGS3YJ2tbcFnx4ovWSRUEK2fzTBXsTG5zPtyOm5cWl4CV7LCATDpduVUlnQ9c37JMxTigb9WNg05SO0wuq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723845192; c=relaxed/simple;
	bh=a+INm+JYrpr2oUVd+ssRjVO5E1ur8zhkQRq9OA7lDcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FlkFujBOgp4oYfq0olzmlUS6JpPd+wPcdvndiZmd5gl+iac71Pllcr2CxrF4+ZB216fmUOQmke2Uf+/hxx3imdJMc1KXuMgespExO5R13uhOrL5tZ5fg6NyXVe+WB0+jW36cWTjZskV6nUp1Sn+kICCPtBkyh4ju/sPQjjkEg6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=pkxfxJ0U; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1723845181; x=1724449981; i=quwenruo.btrfs@gmx.com;
	bh=Dp1yXYo1/tHpdlT642C44xN3o3bpk+02rGTDtqV+gAw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pkxfxJ0U8KSc5S4hdkH9g7CriLpm4+CIk/x779oUckUwSu7z02d4VQemBPtcRYAw
	 F8zoyCflDzP+AK1KqFwQz6SaTKa9cjAUHqWTxmk66LP7qhsjHaM5d8rQgUnJclnBH
	 q9Q9H7DDwJJX2jki3c6TnS/0uZqItuHIL5Ra97Tc952cRzf4BUelgn6KBiV5F/EgI
	 utse6EKeov1CaZC7l9SoRLc5d4+S1r3fsf/dCNi+tpdnqgAkEyWkmJDuBJInVvTn5
	 8bh65855VYgRrY7LVNGpXGg0tUzcAVsf619gY505HNYePAmyB0WIWVf5sNiEQBgWk
	 6pRVbNogwGwIMsF9kQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8GQy-1sA7qe2Slk-013RBd; Fri, 16
 Aug 2024 23:53:01 +0200
Message-ID: <93abd2a7-9876-4353-8116-cd5f8135cb03@gmx.com>
Date: Sat, 17 Aug 2024 07:22:56 +0930
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
In-Reply-To: <CAL3q7H68VyuHLe3Y4ieBtkHk3ET3=sbXrCadK8Q9ck=EskeLEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KOSlPrVD0hRILAnbVL+aEPNWfZiX3kOAvmQ+QORqY4cleP4rG/X
 w5LILp2/oYqUAHIUb32oZQfPZ4lgS19yhhXcgLuaadNJI4HJkLZA/9UaQ2fz196+WJX9EhZ
 5WdlyG2dwAYIMbl2x9dAQyjPXv2WXgonfRRyro2W0hCVWh60/RNITwhUsATQmPUA5wdPUci
 E+r7CQ/Tj66YMi/Sf38Aw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Cwo836y4eV8=;UUxEerBHhz63sotdO6fCKF7jSah
 FIYqFDHBMXyZnBoZ4Ym4OWEVx+OzYAEbnejhPIvwTT1tEEp4ipXeJLjQsygaYSzq619RtA+gL
 W2jUn001OEQwDRVCk1qoVsbOLLclhZ1PR+6uulsz9403wNvuMYH+KEM31jlMrLmBMVQ6kUNQZ
 9wz7+cWU2r7W4k3eRiGRlU3b5JQhqOLJUyfHaKD6Unemb7/AgNGwOna9w3ZqFW1TCRuhlq5V4
 l4suDVAWEMLUSqInHe6yb5Vyz2rk25o4ZGSELW4Yw2cfi/TPOor4vj7EYSAOndZ9EaGshUXM4
 8xtmoNHcLiSXoK5oOo3AwbPOzJeyCIwkEwWhsDpgzt5oPaiOrDqKMbvW9fHaPO+J/4h+fsd4Q
 LLWfdB1gFpOfv/zh8PqMhQrSs0ZUY+AZwRHT7pA3fOqglAoTxxAK/lkDrNU/LLeGXeTV11c9s
 VdMAfQdA7fEBIhbPyJ+C4sqiUPGLrjTHSqgHbMx9+S+1dtVKMDMvvySXCSN2mwKYC9sONYgLU
 bWdNcx/VeGYZyVgYRD2NPBCng/Af8xdn/e5EnNKK5TIrjGLCREDK+7viCL+aAkRNzU6y6dbeQ
 YyD9fHPFWLe1CJPxStSwg90UQRyNyFQOqFE979WjpQYQsG8k6Xvy/TLkpyUc0lgsTJ48x+y8c
 hWf8aupe4db+egTkwtai78DQ0ypYmBjqW7W1e1oHU2vsdqklMjD0imvvPOrbcav0s75ij8ncP
 +tqRmoJDzHjK6cUkVpm8d5GEMO7zo6VIWet62nj65x/DgLyRUkySG0N81n2oWS60DHyYHvCVU
 A8AMd2d97YkJMz3GAnhaEKqqSxDi2WI503A1V97z7QcMM=



=E5=9C=A8 2024/8/16 20:39, Filipe Manana =E5=86=99=E9=81=93:
> On Fri, Aug 16, 2024 at 9:58=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> There are still reports about extent map shrinker is causing high CPU
>> usage.
>>
>> It turns out that the call backs can be very frequent, even inside
>> kswapd (and we can have multiple kswapd if the system have several
>> nodes).
>
> You mean numa nodes?
> Are you sure that's the problem, and not something like tasks waiting
> long for a kswapd task because it's doing extent map removal?

I'm pretty sure this is not the root cause.

>
>>
>> For the only other fs implementing the reclaim callbacks, XFS does it
>> very differently by ensure the following conditions:
>>
>> - Make sure there is only one reclaim work queued
>>
>> - Add a delay before queuing the reclaim workload
>>    The default delay is 18s (60% of xfs_syncd_centisecs)
>>
>> In btrfs, there is already a context which is very similar to the XFS
>> condition: cleaner kthread.
>>
>> There is only one cleaner kthread for the fs, and it's waken periodical=
ly
>> (the same time interval as commit interval, which is 30s by default).
>>
>> So it's much better to run the extent map shrinker inside cleaner
>> kthread.
>
> No please, don't do it in the cleaner.
>
> There's already a lot of different work that the cleaner does, from
> running delayed iputs, to defrag inodes, remove deleted roots, etc.
> Adding the shrinker there only increases the delay for those tasks and
> those tasks increase the delay for the shrinker to run and free
> memory.
>
> I'd rather have this done as an unbounded work queue item like we do
> for space reclaim.
> In fact one thing I have in my todo list is to get rid of the cleaner
> and have all work done in work queues (it's not that straightforward
> as it may seem).

OK, that also works fine for me, although it would be better also to
introduce the extra delay just like XFS.

>
>>
>> And make the free_cached_objects() callback to only record the latest
>> number to free.
>>
>> Link: https://lore.kernel.org/linux-btrfs/3df4acd616a07ef4d2dc6bad66870=
1504b412ffc.camel@intelfx.name/
>> Link: https://lore.kernel.org/linux-btrfs/c30fd6b3-ca7a-4759-8a53-d4287=
8bf84f7@gmail.com/
>> Reported-by: Ivan Shapovalov <intelfx@intelfx.name>
>> Reported-by: Jannik Gl=C3=BCckert <jannik.glueckert@gmail.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Reason for RFC:
>>
>> I do not have an environment which can trigger the reclaim that
>> frequently, thus more tests would be appreciated.
>
> So I'd rather have time spent analysing things and testing them than
> having hypothetical test patches.
>
>>
>> If one wants to test, please use this branch:
>> https://github.com/adam900710/linux.git em_shrink_freq
>>
>> And enable CONFIG_BTRFS_DEBUG (since the previous patch hides the
>> shrinker behind DEBUG builds).
>>
>> ---
>>   fs/btrfs/disk-io.c    |  3 +++
>>   fs/btrfs/extent_map.c |  3 ++-
>>   fs/btrfs/extent_map.h |  2 +-
>>   fs/btrfs/fs.h         |  1 +
>>   fs/btrfs/super.c      | 22 +++++++---------------
>>   5 files changed, 14 insertions(+), 17 deletions(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index a6f5441e62d1..624dd7552e0f 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -1542,6 +1542,9 @@ static int cleaner_kthread(void *arg)
>>                   * space.
>>                   */
>>                  btrfs_reclaim_bgs(fs_info);
>> +
>> +               if (IS_ENABLED(CONFIG_BTRFS_DEBUG))
>> +                       btrfs_free_extent_maps(fs_info);
>>   sleep:
>>                  clear_and_wake_up_bit(BTRFS_FS_CLEANER_RUNNING, &fs_in=
fo->flags);
>>                  if (kthread_should_park())
>> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
>> index 25d191f1ac10..1491429f9386 100644
>> --- a/fs/btrfs/extent_map.c
>> +++ b/fs/btrfs/extent_map.c
>> @@ -1248,13 +1248,14 @@ static long btrfs_scan_root(struct btrfs_root *=
root, struct btrfs_em_shrink_ctx
>>          return nr_dropped;
>>   }
>>
>> -long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_=
scan)
>> +long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info)
>>   {
>>          struct btrfs_em_shrink_ctx ctx;
>>          u64 start_root_id;
>>          u64 next_root_id;
>>          bool cycled =3D false;
>>          long nr_dropped =3D 0;
>> +       long nr_to_scan =3D READ_ONCE(fs_info->extent_map_shrinker_nr_t=
o_scan);
>>
>>          ctx.scanned =3D 0;
>>          ctx.nr_to_scan =3D nr_to_scan;
>> diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
>> index 5154a8f1d26c..070621b4467f 100644
>> --- a/fs/btrfs/extent_map.h
>> +++ b/fs/btrfs/extent_map.h
>> @@ -189,6 +189,6 @@ void btrfs_drop_extent_map_range(struct btrfs_inode=
 *inode,
>>   int btrfs_replace_extent_map_range(struct btrfs_inode *inode,
>>                                     struct extent_map *new_em,
>>                                     bool modified);
>> -long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_=
scan);
>> +long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info);
>>
>>   #endif
>> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
>> index 3d6d4b503220..a594c8309693 100644
>> --- a/fs/btrfs/fs.h
>> +++ b/fs/btrfs/fs.h
>> @@ -636,6 +636,7 @@ struct btrfs_fs_info {
>>          spinlock_t extent_map_shrinker_lock;
>>          u64 extent_map_shrinker_last_root;
>>          u64 extent_map_shrinker_last_ino;
>> +       long extent_map_shrinker_nr_to_scan;
>>
>>          /* Protected by 'trans_lock'. */
>>          struct list_head dirty_cowonly_roots;
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>> index 98fa0f382480..5d9958063ddd 100644
>> --- a/fs/btrfs/super.c
>> +++ b/fs/btrfs/super.c
>> @@ -2402,13 +2402,7 @@ static long btrfs_nr_cached_objects(struct super=
_block *sb, struct shrink_contro
>>
>>          trace_btrfs_extent_map_shrinker_count(fs_info, nr);
>>
>> -       /*
>> -        * Only report the real number for DEBUG builds, as there are r=
eports of
>> -        * serious performance degradation caused by too frequent shrin=
ks.
>> -        */
>> -       if (IS_ENABLED(CONFIG_BTRFS_DEBUG))
>> -               return nr;
>> -       return 0;
>> +       return nr;
>>   }
>>
>>   static long btrfs_free_cached_objects(struct super_block *sb, struct =
shrink_control *sc)
>> @@ -2417,15 +2411,13 @@ static long btrfs_free_cached_objects(struct su=
per_block *sb, struct shrink_cont
>>          struct btrfs_fs_info *fs_info =3D btrfs_sb(sb);
>>
>>          /*
>> -        * We may be called from any task trying to allocate memory and=
 we don't
>> -        * want to slow it down with scanning and dropping extent maps.=
 It would
>> -        * also cause heavy lock contention if many tasks concurrently =
enter
>> -        * here. Therefore only allow kswapd tasks to scan and drop ext=
ent maps.
>> +        * Only record the latest nr_to_scan value. The real scan will =
happen
>> +        * at cleaner kthread.
>> +        * As free_cached_objects() can be triggered very frequently, i=
t's
>> +        * not practical to scan the whole fs to reclaim extent maps.
>>           */
>> -       if (!current_is_kswapd())
>> -               return 0;
>> -
>> -       return btrfs_free_extent_maps(fs_info, nr_to_scan);
>> +       WRITE_ONCE(fs_info->extent_map_shrinker_nr_to_scan, nr_to_scan)=
;
>
> This is never reset to 0, so the shrinker will run even when we don't
> need to free extent maps anymore, doing extra work, causing some
> fsyncs to go to the slow path, etc.

This will be updated by any newer free_cached_objects() call back, with
the calculated nr_to_scan.

If there is really nothing to free, it will be set to 0, as the
nr_cached_objects() will return 0.

>
> If you can wait about 1 week for me to be back from vacation, I can
> continue with plans I have for the shrinker, and just disable the
> shrinker in the meanwhile.

Sure, that also works for me.

Thanks,
Qu

>
> Thanks Qu.
>
>> +       return 0;
>>   }
>>
>>   static const struct super_operations btrfs_super_ops =3D {
>> --
>> 2.46.0
>>
>>
>

