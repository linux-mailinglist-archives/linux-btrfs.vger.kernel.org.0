Return-Path: <linux-btrfs+bounces-1360-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E10A9829660
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 10:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57E301F25A64
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 09:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEC23EA7E;
	Wed, 10 Jan 2024 09:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="TA1FwdRH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C87E56C
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 09:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1704879649; x=1705484449; i=quwenruo.btrfs@gmx.com;
	bh=hDQ/jeuDjkXEgI005dw7S02kRldAD8i0Vm3QCRt1Nnk=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=TA1FwdRHW/jZntjatElhTJDaWUKCDaaQEG4WxsHMIyimFDKAly3UXDhDDjkdDvjj
	 cs5z0yBWqXTPVFy2YDYakoV47yggNlI/7KVgVsA2jA4nZ5JycUUBIBaxwHxpm0rSl
	 TOVQbDaDM9mIrH3swG7EpQpiBMIXB97bsY5BNzfdvN2RzGCvwpB5+IRySLlAElLPB
	 KjkULosJO8F8PTaE4jbrAOcOTaTMMIm5im5zbicUMc5FStRpm7OXDKnk3+XpHlLNb
	 qD1si/jBzKUfMkesS03YsjQHn3Pr4PtKhz/sE10FujoepsHm1xJO7dycmuQNTYGxC
	 yPjZNPoRePWxj5fvZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([193.115.113.22]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Md6Mt-1qoAGB295v-00aDVV; Wed, 10
 Jan 2024 10:40:49 +0100
Message-ID: <794c3085-c5ee-417f-aeaf-d6c0ebd7d96f@gmx.com>
Date: Wed, 10 Jan 2024 20:10:44 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Scrub reports uncorrectable errors with correctable errors
 unrepaired, but all files are fine
Content-Language: en-US
To: Rongrong <i@rong.moe>, linux-btrfs@vger.kernel.org
References: <8bd12a1ee60172f53ee0c27374f41c3ec9976be8.camel@rong.moe>
 <27fb4ed5-c3ce-4ab7-a3fd-d77dc8dd4fb2@gmx.com>
 <b10d90cc5eb4f49eabfe3cc0df92ef40b64428b0.camel@rong.moe>
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
In-Reply-To: <b10d90cc5eb4f49eabfe3cc0df92ef40b64428b0.camel@rong.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:14wIsy6EKf3MT+A1xJbaeQzEnBi828/wN5GuWqP+9i+gG95vGtl
 wG4eyo0z9R1kSRVjkXwj3EaMqwF8Mo6bUiqztdImKkVAw3Pb3dfOjWDootPUipzY58rOIzV
 mPRNQZUpZCk7U/oEXCARB0DrsmR4VUmnXXZjc9HLamz0V9wB4Q2QbI4k0Zba5yWEq7e+GsB
 8Fb1KROvB0FIQKT9Ye9Jw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bfjV2oI+B/U=;kYg0s6ne2gqVn7qvsIP8hPsLdSm
 6lJIZb6SzSuvN3h01zmV9cw/7+x+85vahQD1eVaM4Mthmu/hgTG4fqnwLyUijuNL5Ul1zbcYy
 elSJ8ILar3/qRmRod99L2a/ck0GDvguydCXRiduNwMYZ1nR/rwM8V+61hFt3YB7oLy3vCSJSY
 V/htEJcXOyw68xBINcYwTy5ta0/vDGQsbacB/uCxpI7XBjppWG/kzbYbLLoH1cxq9/wzbhDT9
 rP+m/ZhE4SwMeR/s0/GPK4n5T7Rgpt8HX+niMAtS1Z5ks07jEr7psxYntpIITDMJA6IuatLhA
 lSRfXunKoSNGDfz3ieeUMPcEUziR1ayWV9oj420wkhVYi+KaBxsbXsGJd/6m3ZqFPDd+MMiNL
 Do+fG/jlg+KE7GgCozzeulC8aw5+82U97nSqvSQ7uZxsTKBF0Unz++dZzpuyV0Xm3lItEi1ul
 2okYbBrvFyxXtLEmuPIYzpB1EiaJM91lNK78HYJ95zl9Di+tBz0fZ5AAN7Jk1BJEWLbPMBRME
 6dsC/DU1svyBmehfXpQDI8z4dI/RTv/7wOVAH6hUNyIHPyYeBnVXkbRbYrnrXBmmT5uO2GpTC
 ecVntxWDYWpMKGhcn6xZvFkBXvYpqlz6x4TKkTyugQkHHfN7CocgLugpf7Q0z0XAx7JG6Bc+s
 pxTs8ejZK7IAWThWlUodYIDeqHd3I5k02WEV/Yv9IYHk4PsIqIHgRC9LpXtTJ9W8+pyrGEZqT
 raeJXFAkKpi9mSNttEx6e8LuoJ3rsKKirs3hy9+pRWb14hGM/PsXrDXl2s/dTEjG8ZO+L4yHC
 fCz/UgsXOI3XfmV3sDH/cBieAsmPFtf1BnJ7DWD5ngU8c8/MAIm9gY7/DZE+QKtZlOxkwVgTN
 3Qj6RZROBQLpXjZ2nTC4db+K7RzKi6CHox/exoF4D2G74NIdKCcENpqIsaT3V+PhSKDtNjnu3
 DDLxPGqKQK6Xce+F8Y+GCyuK2r8=



On 2024/1/10 19:42, Rongrong wrote:
> On Wed, 2024-01-10 at 07:49 +1030, Qu Wenruo wrote:
>>
>>
>> On 2024/1/10 04:36, Rongrong wrote:
>>> I guess the root cause of the issue is that one of the DUP metadata
>>> copies was somehow corrupted. Am I right?
>>
>> I don't think so, I think there may be some false alerts, either from
>> kernel scrub interface, or btrfs-progs.
>
> OK then. But I just wonder, if this is the case:
> Why `btrfs inspect-internal logical-resolve [LoC]` returned a file
> instead of ENOENT?

Then we're having very conflicting results.

"btrfs check --check-data-csum" is really the equivalent of scrub (just
offline), which will ensure EVERY copy is verified.

If "btrfs check --check-data-csum" shows no error, I can only came up
with one possibility.

- There is something missing csum and btrfs check doesn't report
   the problem in the first place

This doesn't looks that correct to me though, as we have test cases to
ensure btrfs check can detect extents without csum.

Can you provide the full dmesg/logical-resolve/btrfs-check result
without hiding the bytenrs?
That would help us to really clue all the problems.

Especially for dmesg, the full one (from boot to crash/report) is
appreciated.

> Why `btrfs inspect-internal dump-tree -b [LoC]` returned checksum
> mismatch instead of invalid mapping?

This is easy to answer, as long as the bytenr is inside a chunk,
dump-tree can read it, even if it may be a metadata chunk.

Thus it doesn't show much, given any aligned bytenr inside a chunk,
dump-tree would try to read it, e.g, we have such chunk layouts (an
empty btrfs):

	item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM 13631488) itemoff 16105 itemsize =
80
		length 8388608 owner 2 stripe_len 65536 type DATA|single
	item 2 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096) itemoff 15993
itemsize 112
		length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
	item 3 key (FIRST_CHUNK_TREE CHUNK_ITEM 30408704) itemoff 15881
itemsize 112
		length 33554432 owner 2 stripe_len 65536 type METADATA|DUP

Then dump-tree can even try to read a tree block from a data chunk:

$ btrfs ins dump-tree -b 13631488 ~/test.img
btrfs-progs v6.6.3
checksum verify failed on 13631488 wanted 0x00000000 found 0xb6bde3e4
ERROR: failed to read tree block 13631488

>
>>> I am to confirm:
>>> 1. is this behavior (false "fixed up") of scrub intended?
>>
>> Nope. Considering "btrfs check" and "btrfs check --check-data-csum"
>> is
>> totally fine, this should be a bug related to scrub.
>>
>>> 2. why btrfs check finished without error under such a
>>> circumstance?
>>
>> Because that is probably the real case.
>>
>>> 3. since all files were fine and btrfs check finished without
>>> error,
>>> should these "uncorrectable" errors be actually correctable?
>>
>> I believe it's some bugs, either from scrub functionality of btrfs
>> kernel module, or btrfs-progs reporting.
>>
>> Would you please try the following?
>>
>> - A different btrfs-progs to do the same scrub
>>  =C2=A0=C2=A0 To rule out some btrfs-progs regression.
>
> `btrfs scrub start -RBd` with btrfs-progs v6.6.3 and v6.3.3, no
> difference.
>
>> - "btrfs scrub start -RD"
>>  =C2=A0=C2=A0 This shows the raw data reported, including where the cor=
ruptions
>> are
>>  =C2=A0=C2=A0 (data/metadata, and scrubbed bytes etc).
>
> Did you mean `btrfs scrub start -RBd`? If so:
>
> Starting scrub on devid 1
>
> Scrub device /dev/vdb (id 1) done
> Scrub started:    Wed Jan 10 14:00:57 2024
> Status:           finished
> Duration:         0:35:50
>          data_extents_scrubbed: 21561913
>          tree_extents_scrubbed: 313438
>          data_bytes_scrubbed: 1128612171776
>          tree_bytes_scrubbed: 5135368192
>          read_errors: 416
>          csum_errors: 0
>          verify_errors: 0
>          no_csum: 0
>          csum_discards: 0
>          super_errors: 0
>          malloc_errors: 0
>          uncorrectable_errors: 248
>          unverified_errors: 0
>          corrected_errors: 168
>          last_physical: 1994106359808
> ERROR: there are uncorrectable errors
>
>> - Do a readonly scrub on a readonly mounted btrfs
>>  =C2=A0=C2=A0 Just to rule out any write-time races, which can help us =
to pin
>> down
>>  =C2=A0=C2=A0 the possible cause.
>
> `btrfs scrub start -rRBd` on an ro mount with btrfs-progs v6.6.3, still
> no difference.
> In particular, I still saw "fixed up error" in dmesg.
>
>> Thanks,
>> Qu
>
> I have more to say. There is actually another bug that can lead to
> kernel oops. Due to the bug, these requested tests were done on a
> patched kernel.
> I considered it should be a different bug so I decided to firstly
> discuss the case that scrub can successfully finish without oops in
> this thread, and planned to write another detailed bug report in the
> following days. Since I used a patched kernel to finish requested
> tests, let me make a brief description in advance:
>
> Oops usually occurred when the scrub progress is 1~30%.
> Bisect shows the buggy commit is
> ae76d8e3e1351aa1ba09cc68dab6866d356f2e17. Any version comes with the
> commit or have the commit backported should be affected (in my tests,
> 6.5.4, 6.6.10, 6.7). 6.4.15 and 6.5.3 was fine in my tests.
> The version of btrfs-progs was irrelevant.
> Oops can be either (quite random):
> - unable to handle page fault (not-present page)
> - general protection fault, probably for non-canonical address
> - Kernel BUG at __blk_rq_map_sg (block/blk-merge.c:584)

Can you provide any (or several) backtrace for it?

I'd to know the calltrace at least.

> - (RK3399) Unable to handle kernel paging request at virtual address
> It was reproducible on:
> - Intel CPU (i7-7567U), host, intel_iommu=3Doff, SATA HDD
> - Intel CPU (i7-7567U), host, intel_iommu=3Don/off, loop (disk dump)
> - Intel CPU (i7-13700H), host, intel_iommu=3Doff, USB-SATA HDD
> - Intel CPU (i7-7567U), KVM, virtio-scsi (disk dump)
> - Intel CPU (i7-13700H), KVM, virtio-scsi (USB-SATA HDD)

Would virtio-blk cause any difference?
That's also most of my development environment using.

You can still assign the block device to libvirt/qemu directly without
using virtio-scsi.

> - AMD Ryzen CPU (PRO 4750U), KVM, virtio-scsi (USB-SATA HDD)
> - RK3399, host, USB-SATA HDD
> It was not reproducible on:
> - Intel CPU (i7-7567U/i7-13700H), intel_iommu=3Don, (USB-)SATA HDD
> - AMD Ryzen CPU (PRO 4750U), host, amd_iommu=3Don/off, USB-SATA HDD
>
> Removing the usage of blk_plug in submit_initial_group_read
> dramatically made the oops disappear.
>
> Again, I aims to discuss the case that scrub can successfully finish
> without oops in this thread. But due to the above oops, to make it
> easier (scrubbing on HDD is painfully slow), all the above tests was
> done on "Intel CPU (i7-7567U), KVM, virtio-scsi (disk dump)", and Linux
> v6.7 **with the below patch**. If you consider I'd better do the tests
> without the patch, would you please tell your preferred test
> environment?
>
> (PS: if the above information is enough for you to fix the oops, please
> tell me so that I don't need to make another bug report)

Considering it's hard to reproduce here, mind to enable KASAN on your
test environment? (Inside VM is good enough).

Another possible thing is the IO scheduler.

For all my virtio-blk based environment, the default scheduler is "none".
Maybe that could affect the situation?

Finally, since you're using USB-SATA convertor, have you tried to
connect the SATA disk to a native SATA connector on a desktop motherboard?
(I guess it may not be possible)

Thanks,
Qu
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index f62a408671cb..62695b9aee07 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -1768,14 +1768,11 @@ static void submit_initial_group_read(struct scr=
ub_ctx *sctx,
>   				      unsigned int first_slot,
>   				      unsigned int nr_stripes)
>   {
> -	struct blk_plug plug;
> -
>   	ASSERT(first_slot < SCRUB_TOTAL_STRIPES);
>   	ASSERT(first_slot + nr_stripes <=3D SCRUB_TOTAL_STRIPES);
>
>   	scrub_throttle_dev_io(sctx, sctx->stripes[0].dev,
>   			      btrfs_stripe_nr_to_offset(nr_stripes));
> -	blk_start_plug(&plug);
>   	for (int i =3D 0; i < nr_stripes; i++) {
>   		struct scrub_stripe *stripe =3D &sctx->stripes[first_slot + i];
>
> @@ -1783,7 +1780,6 @@ static void submit_initial_group_read(struct scrub=
_ctx *sctx,
>   		ASSERT(test_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &stripe->state));
>   		scrub_submit_initial_read(sctx, stripe);
>   	}
> -	blk_finish_plug(&plug);
>   }
>
>   static int flush_scrub_stripes(struct scrub_ctx *sctx)
>
>
>

