Return-Path: <linux-btrfs+bounces-10013-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0349E0D90
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 22:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 045D5B39768
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 20:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F18D1DEFE9;
	Mon,  2 Dec 2024 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="C3C6OcOB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16881DE4C3
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Dec 2024 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733172028; cv=none; b=GD7TwlEImKJdoGqmiBGbID45En/oWaC6XApxdXdZsbScLfpQqsOl43ltmoGmt7M3niE84NOBOPIxzLO3WIlmGufxJgZajHldSuGN7zVtL4I8asb23vqsAGLRtpIa1xMMoGm8SG5f+tI5uwGdhDr+bjt9aOrn82yNf4CbD885+e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733172028; c=relaxed/simple;
	bh=993euOu6ezgU4MVGZSrK+1p9bAlbyTxWqacdipRsTC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U9p2Ic82UJHRAznXR48Ep8nn3r0FE2yk1pKRriJD77tn4Hs00ke1rIlt/VCJSk+EIEZZ1RoengIF3xj0zMCWPmYMKvXWRAeIEPhAUVQtl+KXG17SV0wiweB/uHlceXdpYGo2Cj7aZ7GwqtsMhCrElXeJf7l93Yz+33FzdccHIns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=C3C6OcOB; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1733172018; x=1733776818; i=quwenruo.btrfs@gmx.com;
	bh=Fme0slyyLLSJJ9QvCqCDXcdaErGLi719StnT4xLqbGg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=C3C6OcOB1xf7mXQ4JdPo5kRKqQ97uwBMahkKXEX1DwNIqRfAQqUZ0sGUnDIIkEf4
	 FmVQwwfk+hOmXHFXKMP0+tIiahc9fIZOUV5zNQn277EVIhYtOuM2OMo0i3PV8JFJx
	 rut8cT/ayOP231cxyPbqDKeIogjp3tuMOCqpv6nXipW9es5fjB4JvVg1pNzsmuEEg
	 Dl2RSMHmDoYu+wus6qi4d2mnGD7pBC0gc+nbIeCUANxFMKqcV8W3HI4aqGD4YYvEG
	 M+Gkd89vFLyty/QNZPBavhnAOQ0IZomHPJTkJAIqvu+gnAkv2yPNB5gLWvWZEI6gF
	 EzhqZBPhS6HodktsLA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M9Wys-1tLV013YNI-00Ac40; Mon, 02
 Dec 2024 21:40:18 +0100
Message-ID: <e16ef23c-9b54-430e-9b85-2ab65839555c@gmx.com>
Date: Tue, 3 Dec 2024 07:10:14 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: properly wait for writeback before buffered write
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org,
 syzbot+aac7bff85be224de5156@syzkaller.appspotmail.com
References: <7fae80d0a144312c09e4e40ff3491b6ce77ee4f5.1732952536.git.wqu@suse.com>
 <CAL3q7H65joDrgUKMYhKnghjHUA1b3Woo8Uq-aKgp5DmnUAmMVA@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <CAL3q7H65joDrgUKMYhKnghjHUA1b3Woo8Uq-aKgp5DmnUAmMVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KqfYvai5BnLwbYvyFBtVj7xttvK32wxedYweuTR/v83I/d4wo/n
 cuF1ho3lNHgMOovh076nIs3YcAcMiQt89X3wNM4byMeJVwB6aeEL3dPzEzFFPMII4WR1qqB
 qg5TT6LQf1lr34jAxP/ucBMGm9Fi5gq228HUBvg8/ZLGg6J6GgUNgH2WERhFf1q95ktUTou
 +hdiHH/6QnrXrMBMCMq4g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:orfCCtcsmzg=;ODIaW1U8TsFscsb/3dcBQqXWk/8
 +NJEVpwbqBssfsMh8o6ga6YHmjAIP36tPiJyXZJU9IyvUcoFs+PzjhO++Z72PPIZevgH+q96Z
 DAIoPvGgO8/05suiddaoPGuUeOzrByGhm+8PTq6TtfA6AnUH2tUELMh36F5V8FmVjVkOEp+wQ
 JI7lUS1QbWLOyGj3D/GNsgExpqZcbh55rh6Ob3OE6EE5oh2mHW6WOlL4zJuioxeKJfK79TdnY
 m06yX+3XbbVvr45p+DHmS6B2w8oTqpojAsjq6jXbneBdd0vidRkekysGX8BNYh6Bnq8x/zz1m
 iDG3qs9A0vdorpRBdSBAoVLLH8hdjrvTly9NSluPGqWuNAzqHUgIq+JS1HH5tD4pU1OTnPYmB
 ZKDWtwoT0FRV4MahTLV9CkIwTvGduAzRbPTaRczqVhcHh9ap/WEZvNFlSkPj7ZQnQFa9EhoHw
 Sj642beA85MG7+mbXeT9br+fXZ+o/CBcC7u4/nH9q2yp+Wh2njbTyB8N65I1f+9UfVQWIqHap
 0sxPgJYFg2gemh1ft8O+aQAvDf7WazIzB0nvMeTTOrx1bFmu8CvFGE7v6kMIIX26OtNejJtbZ
 JwRFJkWgVJLibZCh1DMsxiqeJ6rkq7VOngrMeLbaHamq1zyntVbqAsHuCA+U8lxMuyYr7K9IH
 78DHDfdintjpxERMSjIcqCLiReDGVol43Um3RXPPtwEpnfN3m4I4dWrmsijAeOW0JATqqfZey
 OOQpS8nVnkkJHi2xeXhuzJis1nOxdKH/AqDf5A6VzpwVtdR0/TZaFCkpl+0BwxmgxqAtoFO10
 d7Y2692jAQDaB1YW55pNZOJ5QOQew6+o6aIHEv+FBWNUtjAqxjecPBbqpvrD1Ruiw5a+qVOe+
 LeGGrClXIkgKXSXvfo3Hd9lAvpwOMIm7c4WPDbPV9pLtLry0WrUVALF/oguYV5DW5yT+6dAJY
 OgDjFBoz43ItxYQzm8HvgdFKgfMUoeGJdPAVPKybtmqRO9cIcvd68Ua1/3HM3Yf4X3/sAPCSE
 bRxu+0niQDFIkiZJHH5QTxfuo4HNHtpNfdidPdtLr6KQJJYdY6Ow24wh4wjYsEOwnp4sP3CBL
 3KU3YyvCsfAAwjDhWaNVB4w6XBOmiQ



=E5=9C=A8 2024/12/3 01:04, Filipe Manana =E5=86=99=E9=81=93:
> On Sat, Nov 30, 2024 at 7:43=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> Syzbot reported a crash where btrfs is call folio_start_writeback()
>> while the folio is already marked writeback:
>>
>> ------------[ cut here ]------------
>> kernel BUG at mm/page-writeback.c:3119!
>> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
>> CPU: 0 UID: 0 PID: 12 Comm: kworker/u8:1 Not tainted 6.12.0-syzkaller-0=
8446-g228a1157fb9f #0
>> Workqueue: btrfs-delalloc btrfs_work_helper
>> RIP: 0010:__folio_start_writeback+0xc06/0x1050 mm/page-writeback.c:3119
>>   <TASK>
>>   process_one_folio fs/btrfs/extent_io.c:187 [inline]
>>   __process_folios_contig+0x31c/0x540 fs/btrfs/extent_io.c:216
>>   submit_one_async_extent fs/btrfs/inode.c:1229 [inline]
>>   submit_compressed_extents+0xdb3/0x16e0 fs/btrfs/inode.c:1632
>>   run_ordered_work fs/btrfs/async-thread.c:245 [inline]
>>   btrfs_work_helper+0x56b/0xc50 fs/btrfs/async-thread.c:324
>>   process_one_work kernel/workqueue.c:3229 [inline]
>>   process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
>>   worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>>   kthread+0x2f0/0x390 kernel/kthread.c:389
>>   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>>   </TASK>
>> ---[ end trace 0000000000000000 ]---
>>
>> Furthermore syzbot bisected the cause to commit c87c299776e4
>> ("btrfs: make buffered write to copy one page a time").
>>
>> [CAUSE]
>> Unfortunately I'm not able to reproduce the bug with my usual debug
>> kernel config.
>> But thanks to the bisection result, I can take a deeper look into the
>> offending commit.
>>
>> One of the change is to use FGP_STABLE to wait for folio writeback.
>
> change -> changes
>
> But I'm a bit confused.
> The commit that adds the use of GFP_STABLE is e820dbeb6ad1 ("btrfs:
> convert btrfs_buffered_write() to use folios"), but indirectly through
> the use of FGP_WRITEBEGIN.
>
> But you (and syzbot), say the offending commit is c87c299776e4
> ("btrfs: make buffered write to copy one page a time").

So it's either the bisection is not reliable or it's a different case.

I tend to believe it's the latter case, will update the commit message.

>
>> But unfortunately FGP_STABLE is not ensured to wait for writeback, it
>> only calls folio_wait_stable(), which only calls folio_wait_writeback()
>> if the address space has AS_STABLE_WRITES.
>>
>> Normally that flag is only set if the super block has
>> SB_I_STABLE_WRITES, and that is normally set if the that block device
>> has integrity checks or requires stable writes feature (normally has
>> some kind of digest to check).
>>
>> Although I'd argue btrfs should set such flag due to its data checksum,
>
> What about nocow writes?

NOCOW is not ensured to be respected, things like snapshot will force it
to be COW.

But I guess you mean NODATASUM instead?

In that case yes we can skip the writeback wait, but it won't hurt
performance either for the extra writeback wait which we always do in
the past.

>
> The change looks good and sane, just confused about that part in the cha=
ngelog.

Will update the commit message, to drop the syzbot report part.

Thanks a lot for the review,
Qu


>
> Thanks.
>
>> for now we do not have that flag, meaning FGP_STABLE will not wait for
>> any folio writeback to finish.
>>
>> This is going to cause races between buffered write and folio writeback=
,
>> leading to various data corruption/checksum mismatch.
>>
>> [FIX]
>> Instead of fully rely on FGP_STABLE, manually do the folio writeback
>> wait, until we set the btrfs super block with SB_I_STABLE_WRITES
>> manually.
>>
>> Reported-by: syzbot+aac7bff85be224de5156@syzkaller.appspotmail.com
>> Fixes: c87c299776e4 ("btrfs: make buffered write to copy one page a tim=
e")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/file.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
>> index fbb753300071..8734f5fc681f 100644
>> --- a/fs/btrfs/file.c
>> +++ b/fs/btrfs/file.c
>> @@ -911,6 +911,7 @@ static noinline int prepare_one_folio(struct inode =
*inode, struct folio **folio_
>>                          ret =3D PTR_ERR(folio);
>>                  return ret;
>>          }
>> +       folio_wait_writeback(folio);
>>          /* Only support page sized folio yet. */
>>          ASSERT(folio_order(folio) =3D=3D 0);
>>          ret =3D set_folio_extent_mapped(folio);
>> --
>> 2.47.1
>>
>>
>


