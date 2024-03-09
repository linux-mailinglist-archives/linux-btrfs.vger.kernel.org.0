Return-Path: <linux-btrfs+bounces-3152-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3558773DB
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Mar 2024 21:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDE2A1F2119F
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Mar 2024 20:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B288328DAE;
	Sat,  9 Mar 2024 20:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="bL9PgwFM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB90916FF44
	for <linux-btrfs@vger.kernel.org>; Sat,  9 Mar 2024 20:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710016296; cv=none; b=DrPjzDqOfV3Uz+vUahlEIu4cxT6IRgAwUJxxDCtVC8mZ6NG4emmup+jW4Wyn+8Qw2vwxffhtGrQvzwksaokNNVXUFOpRs9x09i6vP13ilb6mtlbBMREtRzCP9asn68oOzSt56lhT8W4MbMAFyxuhzypZE2LEJMCPsxS6iqIwVTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710016296; c=relaxed/simple;
	bh=Kgp4bboaKwRNYnG1u5voWZjdkdXYoZhhfbzS6D7uANk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QlNfNMvcmdcvAbH0ZnNNpFBoqvCKF54ReZLUqZgrDY3rZMST6Q2t7qDY0kaa1frVakWP65qSHeMyStHwoJfdHZvI8HuyGUYYQRBb2+bmXFellg4gWIjv266yo52X7IarMSnKzhQ2KAyDYLf/KqyS7E8SBHJIra+Y4iTGAjjohtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=bL9PgwFM; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1710016290; x=1710621090; i=quwenruo.btrfs@gmx.com;
	bh=Kgp4bboaKwRNYnG1u5voWZjdkdXYoZhhfbzS6D7uANk=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=bL9PgwFM7YUFyum9oPBcHzgWg+7E6dr2NaQJ8mLrHSM2YBVhA+ejEkgRXMNt7ExG
	 gAAXnv7nFIKCFS9N3uYoeCbZU5d4SPUgNAbuhXLU89JqWhoh0fPT8vZhkey7peD6x
	 AjYtQtLBlBu0qsCAdZpLrFC3lyoEjzax9mUHAkGQ7hNEb/OAqewW4w2Oc5EanD8nh
	 /wCkopZg/kGmvomcFjbIcP2kpU6WLOmpnAyadqjna64IMDENXEdbPnCF2GKjptQ2k
	 /oIaJlj2001WmBSI2jXIPdvsP2l7DsJ371qnvDzxwEoTeuiRLIlLVYxwof8WtMGEt
	 +ya8tUsnxeOg4owDxA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N3bX1-1qk6jK3QEl-010aGT; Sat, 09
 Mar 2024 21:31:30 +0100
Message-ID: <08a65231-59c2-4606-9be9-5182b7e47087@gmx.com>
Date: Sun, 10 Mar 2024 07:01:26 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: scrub: last_physical not always updated when scrub is cancelled
Content-Language: en-US
To: Michel Palleau <michel.palleau@gmail.com>,
 Graham Cobb <g.btrfs@cobb.uk.net>
Cc: linux-btrfs@vger.kernel.org
References: <CAMFk-+igFTv2E8svg=cQ6o3e6CrR5QwgQ3Ok9EyRaEvvthpqCQ@mail.gmail.com>
 <ba3a8690-1604-429e-9e8a-7c381e6592f8@gmx.com>
 <fcfab114-c1a0-4059-990d-e4724b457437@cobb.uk.net>
 <CAMFk-+ifZiN4PhqyLAbsCZxcaJ6CU_gXUxZRMPr3eC741X=4sQ@mail.gmail.com>
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
In-Reply-To: <CAMFk-+ifZiN4PhqyLAbsCZxcaJ6CU_gXUxZRMPr3eC741X=4sQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5MVIjtl1WiZDmLGPpJihoT108McuTX+Bu6RRhDhtGpGIFWVrWIT
 x5zs7bC2vcEY3gn4XPdtllTUBMzBOtDM7oORwk+DOES2xr8/J078QelfvcaWCgxfy7ywknH
 3gwCNCwS1YkT/3SQ2ThlzGeFnIGaBetOnGKiRNcWQA3YCQYybtz/62aAbZlJ+c/lotK5jts
 n5Hldz63wRaa3pjh2O/BA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SBykOrE9V/g=;R5TN0CHKPjvQLcgdEhgiyNE6AsT
 meP0J6Gio/5JWReQi+YhAdCxodCA74iKcAozsmj2YBOQriHzPVUEczFZHkSkbsfHhalwygFay
 LY2xfl3YnWz6uV1esz0MFqXM05G/BoaTxOtlQG7gKVTofkmWtGg/kUGWDyCkvKo0Ix7+1lANm
 2VyeIukl62QWRk1NlCu6STYF8Ov2Y3utxKi4Rw8x7V3onCCL+r7Vxtbp/Cy6zppE22damxYju
 pQHaADq2j10WKKt0sWxBKlQoAVXTHlRwTVRGl7viJS9Pbt5bbCYA/mxj6Yu5ZX3DgAKcyS/zw
 bln2mrbwWFvfYd1q2Mx9Pj7670MkEa77kq0cDIen80vXwKZ6TE668JYq0t39JmvB+ubcB9dDi
 6i5x6o4jlO0SkROPFCcqZ6dc7L9u8jcxVWjjo91UC808hAbSE53ARflyv+Cr8VPb2HJ0Z52sI
 gT8+RaC/9rbkLLrax2NaF7yWoSC1O9pmo+Vx4tQ813Z4dnHsmj8PWh1q+dwQl+0b0qe6HoK5/
 dYCxZY7B5sD9OxF2OkhM1+f9bq/gGFp7hOMlWc8aTTtnws7ekj0I63wuyioR7imIumUuSKGDw
 NfrnBYyuP9u8f8hJapnziCOdcoHA9z1AdRRW7VYbfYojSjzi1aeIuFhEWTBBvtVpvPmis0T4c
 J73QHVKGa8ufuYpvr9IMqA35WPAYlDz9igBRR4W0JLb8Bk5AA7jVeqAR+ro1LUpJ/mVbkCJqT
 ilL0m4Dc4TRNDI5wFBB4YcPlqZhosnOyNdokJoc4xDY5gmtKT/BL27uHod9ck9H2pZs0/IPyO
 l0I8Et5D0bW/J7ZJpmULXbi9bxidxvhOn8mG8LhxIxhQo=



=E5=9C=A8 2024/3/10 05:56, Michel Palleau =E5=86=99=E9=81=93:
> Hello Qu,
>
> I have tested your patches today, with
> - btrfs scrub status | fgrep last_phys in one console, every second
> - btrfs scrub start/resume in another
>
> last_phys is now increasing steadily (while before it was remaining
> constant for several minutes).
>
> But there is still a small window after resuming a scrub where the
> value reported by scrub status is not consistent.
> Here is the output of btrfs scrub status | fgrep last_phys every second:
>         last_physical: 0
>         last_physical: 80805888
>         last_physical: 1986068480
> ...
>         last_physical: 50135564288
>         last_physical: 52316602368
>         last_physical: 52769587200
> ... (scrub has been cancelled)
>         last_physical: 52769587200
>         last_physical: 52719255552  <-- reported value is smaller than b=
efore

IIRC restarted scrub doesn't fully follow the start/end parameter passed
in, mostly due to our current scrub code is fully chunk based.

This means, even if we updated our last_physical correctly on a
per-stripe basis, after resuming a canceled one, we would still restart
at the last chunk, not the last extent.

To change this behavior, it would require some extra work.

>         last_physical: 54866739200
>         last_physical: 57014222848
> ...
>         last_physical: 74621911040
>         last_physical: 76844892160
>         last_physical: 77566312448
> ... (scrub has been cancelled)
>         last_physical: 77566312448
>         last_physical: 0            <-- reported value is 0, scrub
> process has not updated last_phys field yet
>         last_physical: 79562801152
>         last_physical: 81819336704
>
> I think a smaller last_physical indicates that the resume operation
> has not started exactly from last_physical, but somewhere before.
> It can be a little surprising, but not a big deal.

Yes, the resume would only start at the beginning of the last chunk.

> last_physical: 0 indicates that scrub has not yet written last_phys.
>
> Then I chained scrub resume and scrub cancel. I saw once that
> last_physical was getting smaller than before.
> But I never saw a reset of last_physical. It looks like last_phys is
> always written before exiting the scrub operation.
>
> To fix progress reporting a last_physical at 0, I propose the following =
change:
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 9a39f33dc..a43dcfd6a 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -2910,6 +2910,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info
> *fs_info, u64 devid, u64 start,
>     sctx =3D scrub_setup_ctx(fs_info, is_dev_replace);
>     if (IS_ERR(sctx))
>         return PTR_ERR(sctx);
> +    sctx->stat.last_physical =3D start;
>
>     ret =3D scrub_workers_get(fs_info);
>     if (ret)

The snippet looks mostly fine, but as I explained above, the scrub
progress always restarts at the last chunk, thus even if we reset the
last_physical here, it would soon be reset to a bytenr smaller than
@start, and can be a little confusing.

Although I don't really have any better idea on the value to set.

Maybe @last_physical set to 0 for a small window won't be that bad?
(Indicating scrub has not yet scrubbed any content?)

Thanks,
Qu
>
> Best Regards,
> Michel
>
> Cordialement,
> Michel Palleau
>
>
> Le ven. 8 mars 2024 =C3=A0 10:45, Graham Cobb <g.btrfs@cobb.uk.net> a =
=C3=A9crit :
>>
>> By the way, I have noticed this problem for some time, but haven't got
>> around to analysing it, sorry. I had actually assumed it was a race
>> condition in the user mode processing of cancelling/resuming scrubs.
>>
>> In my case, I do regular scrubs of several disks. However, this is very
>> intrusive to the overall system performance and so I have scripts which
>> suspend critical processing which causes problems if it times out (such
>> as inbound mail handling) during the scrub. I suspend these processes,
>> run the scrub for a short while, then cancel the scrub and run the mail
>> for a while, then back to suspending the mail and resuming the scrub.
>> Typically it means scrubs on the main system and backup disks take
>> several days and get cancelled and resumed *many* times.
>>
>> This has worked for many years - until recently-ish (some months ago),
>> when I noticed that scrub was losing track of where it had got to. It
>> was jumping backwards, or even, in some cases, setting last_physical
>> back to 0 and starting all over again!!
>>
>> I haven't had time to track it down - I just hacked the scripts to
>> terminate if it happened. Better to have the scrub not complete than to
>> hobble performance forever!
>>
>> If anyone wants to try the scripts they are in
>> https://github.com/GrahamCobb/btrfs-balance-slowly (see
>> btrfs-scrub-slowly). A typical invocation looks like:
>>
>> /usr/local/sbin/btrfs-scrub-slowly --debug --portion-time $((10*60))
>> --interval $((5*60)) --hook hook-nomail /mnt/data/
>>
>> As this script seem to be able to reproduce the problem fairly reliably
>> (although after several hours - the filesystems I use this for range
>> from 7TB to 17TB and each take 2-3 days to fully scrub with this script=
)
>> they may be useful to someone else. Unfortunately I do not expect to be
>> able to build a kernel to test the proposed fix myself in the next
>> couple of weeks.
>>
>> Graham
>>
>>
>> On 08/03/2024 00:26, Qu Wenruo wrote:
>>>
>>>
>>> =E5=9C=A8 2024/3/8 07:07, Michel Palleau =E5=86=99=E9=81=93:
>>>> Hello everyone,
>>>>
>>>> While playing with the scrub operation, using cancel and resume (with
>>>> btrfs-progs), I saw that my scrub operation was taking much more time
>>>> than expected.
>>>> Analyzing deeper, I think I found an issue on the kernel side, in the
>>>> update of last_physical field.
>>>>
>>>> I am running a 6.7.5 kernel (ArchLinux: 6.7.5-arch1-1), with a basic
>>>> btrfs (single device, 640 GiB used out of 922 GiB, SSD).
>>>>
>>>> Error scenario:
>>>> - I start a scrub, monitor it with scrub status and when I see no
>>>> progress in the last_physical field (likely because it is scrubbing a
>>>> big chunk), I cancel the scrub,
>>>> - then I resume the scrub operation: if I do a scrub status,
>>>> last_physical is 0. If I do a scrub cancel, last_physical is still 0.
>>>> The state file saves 0, and so next resume will start from the very
>>>> beginning. Progress has been lost!
>>>>
>>>> Note that for my fs, if I do not cancel it, I can see the
>>>> last_physical field remaining constant for more than 3 minutes, while
>>>> the data_bytes_scrubbed is increasing fastly. The complete scrub need=
s
>>>> less than 10 min.
>>>>
>>>> I have put at the bottom the outputs of the start/resume commands as
>>>> well as the scrub.status file after each operation.
>>>>
>>>> Looking at kernel code, last_physical seems to be rarely updated. And
>>>> in case of scrub cancel, the current position is not written into
>>>> last_physical, so the value remains the last written value. Which can
>>>> be 0 if it has not been written since the scrub has been resumed.
>>>>
>>>> I see 2 problems here:
>>>> 1. when resuming a scrub, the returned last_physical shall be at leas=
t
>>>> equal to the start position, so that the scrub operation is not doing
>>>> a step backward,
>>>> 2. on cancel, the returned last_physical shall be as near as possible
>>>> to the current scrub position, so that the resume operation is not
>>>> redoing the same operations again. Several minutes without an update
>>>> is a waste.
>>>>
>>>> Pb 1 is pretty easy to fix: in btrfs_scrub_dev(), fill the
>>>> last_physical field with the start parameter after initialization of
>>>> the context.
>>>
>>> Indeed, we're only updating last_physical way too infrequently.
>>>
>>>> Pb 2 looks more difficult: updating last_physical more often implies
>>>> the capability to resume from this position.
>>>
>>> The truth is, every time we finished a stripe, we should update
>>> last_physical, so that in resume case, we would waste at most a stripe
>>> (64K), which should be minimal compared to the size of the fs.
>>>
>>> This is not hard to do inside flush_scrub_stripes() for non-RAID56
>>> profiles.
>>>
>>> It may needs a slightly more handling for RAID56, but overall I believ=
e
>>> it can be done.
>>>
>>> Let me craft a patch for you to test soon.
>>>
>>> Thanks,
>>> Qu
>>>
>>>
>>>>
>>>> Here are output of the different steps:
>>>>
>>>> # btrfs scrub start -BR /mnt/clonux_btrfs
>>>> Starting scrub on devid 1
>>>> scrub canceled for 4c61ff6d-a903-42f6-b490-a3ce3690604e
>>>> Scrub started:    Thu Mar  7 17:11:17 2024
>>>> Status:           aborted
>>>> Duration:         0:00:22
>>>>           data_extents_scrubbed: 1392059
>>>>           tree_extents_scrubbed: 57626
>>>>           data_bytes_scrubbed: 44623339520
>>>>           tree_bytes_scrubbed: 944144384
>>>>           read_errors: 0
>>>>           csum_errors: 0
>>>>           verify_errors: 0
>>>>           no_csum: 1853
>>>>           csum_discards: 0
>>>>           super_errors: 0
>>>>           malloc_errors: 0
>>>>           uncorrectable_errors: 0
>>>>           unverified_errors: 0
>>>>           corrected_errors: 0
>>>>           last_physical: 36529242112
>>>>
>>>> # cat scrub.status.4c61ff6d-a903-42f6-b490-a3ce3690604e
>>>> scrub status:1
>>>> 4c61ff6d-a903-42f6-b490-a3ce3690604e:1|data_extents_scrubbed:1392059|=
tree_extents_scrubbed:57626|data_bytes_scrubbed:44623339520|tree_bytes_scr=
ubbed:944144384|read_errors:0|csum_errors:0|verify_errors:0|no_csum:1853|c=
sum_discards:0|super_errors:0|malloc_errors:0|uncorrectable_errors:0|corre=
cted_errors:0|last_physical:36529242112|t_start:1709827877|t_resumed:0|dur=
ation:22|canceled:1|finished:1
>>>>
>>>> # btrfs scrub resume -BR /mnt/clonux_btrfs
>>>> Starting scrub on devid 1
>>>> scrub canceled for 4c61ff6d-a903-42f6-b490-a3ce3690604e
>>>> Scrub started:    Thu Mar  7 17:13:07 2024
>>>> Status:           aborted
>>>> Duration:         0:00:07
>>>>           data_extents_scrubbed: 250206
>>>>           tree_extents_scrubbed: 0
>>>>           data_bytes_scrubbed: 14311002112
>>>>           tree_bytes_scrubbed: 0
>>>>           read_errors: 0
>>>>           csum_errors: 0
>>>>           verify_errors: 0
>>>>           no_csum: 591
>>>>           csum_discards: 0
>>>>           super_errors: 0
>>>>           malloc_errors: 0
>>>>           uncorrectable_errors: 0
>>>>           unverified_errors: 0
>>>>           corrected_errors: 0
>>>>           last_physical: 0
>>>>
>>>> # cat scrub.status.4c61ff6d-a903-42f6-b490-a3ce3690604e
>>>> scrub status:1
>>>> 4c61ff6d-a903-42f6-b490-a3ce3690604e:1|data_extents_scrubbed:1642265|=
tree_extents_scrubbed:57626|data_bytes_scrubbed:58934341632|tree_bytes_scr=
ubbed:944144384|read_errors:0|csum_errors:0|verify_errors:0|no_csum:2444|c=
sum_discards:0|super_errors:0|malloc_errors:0|uncorrectable_errors:0|corre=
cted_errors:0|last_physical:0|t_start:1709827877|t_resumed:1709827987|dura=
tion:29|canceled:1|finished:1
>>>>
>>>> Best Regards,
>>>> Michel Palleau
>>>>
>>>
>>

