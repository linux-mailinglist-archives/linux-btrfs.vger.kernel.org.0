Return-Path: <linux-btrfs+bounces-6704-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B9793CB28
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 01:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D99501F22209
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2024 23:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538A3146A8A;
	Thu, 25 Jul 2024 23:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="cmi5LwdV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F8CDF6C
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2024 23:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721949567; cv=none; b=URaPdboupc2GYP14PKTZQiSAfmYinL0NlxxryEaN1hIBRypq48V2ETjhU8jbEX7VfRMgQg9Mlf/uRPAYsAWoZR82FKOVmg/oROb4tgShyoebbG1QVsoEpYKP6qHzUXTtPvNIp+cPlJmT6J2KuAQRlfHGb2sd6+B1rAuaG+VJyeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721949567; c=relaxed/simple;
	bh=swBZ/0aa/AzifAo/WQqZzoP+/Kc4+kSgFY36255wO90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y1FWgljENyFrDCeYVnbA6cfi3D7QBm+DTOaemmHCUe6BVGTfG/BLgRLbsZHREOgL+NUhGkv+mAp4b0leSJCPc1KT+MLm2xqupVcODv/wvOmN2T1u6dgtoY1kUCrF0TF0pr0Pw49GWwTaibD49UeMt1y3IJqXJyg01fm//Fd/DOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=cmi5LwdV; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1721949553; x=1722554353; i=quwenruo.btrfs@gmx.com;
	bh=Gzy/c1SB5pWQPjg5NaCUvfNU7Z35DpDLKJhOfE6wae4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cmi5LwdVGO6p1zSgHpQ5OTWElethPTekGrmoLmyfeHgOP4P41S6qw3R8N2mD2+p+
	 XnBpHt3N5Tjt7GNImdXnm68lHlaAd65NNtfaZgujOs/xEn+IkWoEfeq1+4iwgBG6l
	 J3QHi8+031Y55TYgKALdnX8xB6bhzcqPPxaLeZD23CYtgAXsYb6QZaVi7VXIEYL17
	 W4WmsUHrXMwqwu3gtxPlCh50mefNcNsxLFwA2UYWVjf5B4Ce/VKg/oGx6bDX8B34G
	 jBfEgj5ex5COfmVnun83IOix0+lYiN/sqpU5qwFdnvPHKOhNp1Uazlohacg2pwHlR
	 u658qn46SkD90ev6Ag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MRTRH-1suPDQ0BD3-00Y2se; Fri, 26
 Jul 2024 01:19:13 +0200
Message-ID: <aeed4735-f6f2-49ef-9a02-816a3b74cbd3@gmx.com>
Date: Fri, 26 Jul 2024 08:49:10 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Force remove of broken extent/subvolume? (Crash in
 btrfs_run_delayed_refs)
To: dsterba@suse.cz, "Emil.s" <emil@sandnabba.se>
Cc: linux-btrfs@vger.kernel.org
References: <CAEA9r7DVO8gCRz-9vbwaNWznz9AOFxOyPLO0ukOJh-6Ef0o5Bw@mail.gmail.com>
 <20240725224757.GD17473@twin.jikos.cz>
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
In-Reply-To: <20240725224757.GD17473@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qhLR16nKu2kGVJKeGqPKlUcevwp4b8vYL4spneinv2z5vphfbTm
 lZB9FOWQxYTls6Y2osIVLmH5H7rJefJLI5KwqzTy7CFxSWF4s0dt0adNz9DZKMSvQky/Ocd
 55OSP1PKk+dg3wpgYSl+Sx0DMmCSuW6qnAPRTbT2/CzCiWkV9SmzxO+a7kJNkAfxXqFwZ8Y
 fFxTsqR1gVMFbFW5mjFKg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6QNi+AxaFME=;93KrQRW5QtIYCfhNM27XFCF7E9M
 pkl5c6Po6GMzeMf/G+mXiFJIPZzJenWj3ZT2gssjw5PunPATL3Q2cI4YRuniGkzLMfTq+BgaP
 /wQYrPEitfKXk/5KYKKJf5kxwd82ALQdZ/ypBYSfJhhI8lBfRfne7ab4FhLAlmmfMuS1tlIlc
 1hCLYpjBabjpjzlq5RbDg06mPun9OkjhCCT+Ud0toVP9xvfXf30PvRAujMH4jid2RL8tS7Nnu
 iP+Q3rmzyweJ5YO+lZEylHE9Z8avALWWyLckxO0rucgmcHRDUVC2r6FGhPPzmP6vcakfe6zFH
 sdGQZN3wRLiaLDenCuGPHuaGTP74umHnRu42dQnxC7MzLyIbJTuDIaqk0D/mBjT+mmFr8UBAJ
 9sZiScj37LGDOw9HhzHTk45gIrvlXxCgrdZKuAVcwYxwNe9kvzIsAlqOHahkUWyvD4q+He/9u
 XvzU4dhFw+3TPJLNUDjkDU04pNndhGTpe8nW1Br+Ix6r2jQbV9oATqN3duSyVS9nhuDD9eFWE
 iQQ6NTdt8pq1gwdU+95aJOIgiGjbrKlT6E+tmwyXeND81TGg2zW8ekz7U1AO+3Acg2t2pHSVh
 SbP6Jq2vNhw4zz8KaMf93TzHZtg65y4Le7PqQ9vcvGu0pgy1Sc/70EYf+T+mL86umek/xCROh
 vJdqWm29H6WwQ56l30CBzhDun9nFmkdNbOMEFSary2gLB/TwlL+fI6kHNG4gds/D1K7VgAkzp
 soIC9BgcLfyC5q3JGuDYC2QeExosZ5f7XwQPT1YHLqsQG4o1ai6EVaCzDG1VHkugMP2ZvamcX
 ArWnMUOtw1i7ml/AxoJ9aIdQ==



=E5=9C=A8 2024/7/26 08:17, David Sterba =E5=86=99=E9=81=93:
> On Thu, Jul 25, 2024 at 11:06:00PM +0200, Emil.s wrote:
>> Hello!
>>
>> I got a corrupt filesystem due to backpointer mismatches:
>> ---
>> [2/7] checking extents
>> data extent[780333588480, 942080] size mismatch, extent item size
>> 925696 file item size 942080
>
> This looks like a single bit flip:
>
>>>> bin(925696)
> '0b11100010000000000000'
>>>> bin(942080)
> '0b11100110000000000000'
>>>> bin(942080 ^ 925696)
> 0b100000000000000'
>
> or an off by one error, as the delta is 0x4000, 4x page which is one
> node size.
>
>> backpointer mismatch on [780333588480 925696]
>> ---
>>
>> However only two extents seem to be affected, in a subvolume only used
>> for backups.
>>
>> Since I've not been able to repair it, I thought that I could just
>> delete the subvolume and recreate it.
>> But now the btrfs_run_delayed_refs function crashes a while after
>> mounting the filesystem. (Which is quite obvious when I think about
>> it, since I guess it's trying to reclaim space, hitting the bad extent
>> in the process?)
>>
>> Anyhow, is it possible to force removal of these extents in any way?
>> My understanding is that extents are mapped to a specific subvolume as
>> well?
>>
>> Here is the full crash dump:
>> https://gist.github.com/sandnabba/e3ed7f57e4d32f404355fdf988fcfbff
>
> WARNING: CPU: 3 PID: 199588 at fs/btrfs/extent-tree.c:858 lookup_inline_=
extent_backref+0x5c3/0x760 [btrfs]
>
>   858         } else if (WARN_ON(ret)) {
>   859                 btrfs_print_leaf(path->nodes[0]);
>   860                 btrfs_err(fs_info,
>   861 "extent item not found for insert, bytenr %llu num_bytes %llu pare=
nt %llu root_objectid %llu owner %llu offset %llu",
>   862                           bytenr, num_bytes, parent, root_objectid=
, owner,
>   863                           offset);
>   864                 ret =3D -EUCLEAN;
>   865                 goto out;
>   866         }
>   867
>
> CPU: 3 PID: 199588 Comm: btrfs-transacti Tainted: P           OE      6.=
9.9-arch1-1 #1 a564e80ab10c5cd5584d6e9a0715907a10e33ca4
> Hardware name: LENOVO 30B4S01W00/102F, BIOS S00KT73A 05/24/2022
> RIP: 0010:lookup_inline_extent_backref+0x5c3/0x760 [btrfs]
> RSP: 0018:ffffabb2cd4e3b00 EFLAGS: 00010202
> RAX: 0000000000000001 RBX: ffff992307d5c1c0 RCX: 0000000000000000
> RDX: 0000000000000001 RSI: ffff992312c0d590 RDI: ffff99222faff680
> RBP: 0000000000000000 R08: 00000000000000bc R09: 0000000000000001
> R10: a8000000b5a8c360 R11: 0000000000000000 R12: 000000b5af81a000
> R13: ffffabb2cd4e3b57 R14: 00000000000e6000 R15: ffff9927ca7551f8
> FS:  0000000000000000(0000) GS:ffff992997980000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000ad404625100 CR3: 000000080ea20002 CR4: 00000000003706f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   ? lookup_inline_extent_backref+0x5c3/0x760 [btrfs dcbea9ede49f9413c43a=
944f40925c800621e78e]
>   ? __warn.cold+0x8e/0xe8
>   ? lookup_inline_extent_backref+0x5c3/0x760 [btrfs dcbea9ede49f9413c43a=
944f40925c800621e78e]
>   ? report_bug+0xff/0x140
>   ? handle_bug+0x3c/0x80
>   ? exc_invalid_op+0x17/0x70
>   ? asm_exc_invalid_op+0x1a/0x20
>   ? lookup_inline_extent_backref+0x5c3/0x760 [btrfs dcbea9ede49f9413c43a=
944f40925c800621e78e]
>   ? set_extent_buffer_dirty+0x19/0x170 [btrfs dcbea9ede49f9413c43a944f40=
925c800621e78e]
>   insert_inline_extent_backref+0x82/0x160 [btrfs dcbea9ede49f9413c43a944=
f40925c800621e78e]
>   __btrfs_inc_extent_ref+0x9c/0x220 [btrfs dcbea9ede49f9413c43a944f40925=
c800621e78e]
>   ? __btrfs_run_delayed_refs+0xf64/0xfb0 [btrfs dcbea9ede49f9413c43a944f=
40925c800621e78e]
>   __btrfs_run_delayed_refs+0xaf2/0xfb0 [btrfs dcbea9ede49f9413c43a944f40=
925c800621e78e]
>   btrfs_run_delayed_refs+0x3b/0xd0 [btrfs dcbea9ede49f9413c43a944f40925c=
800621e78e]
>   btrfs_commit_transaction+0x6c/0xc80 [btrfs dcbea9ede49f9413c43a944f409=
25c800621e78e]
>   ? start_transaction+0x22c/0x830 [btrfs dcbea9ede49f9413c43a944f40925c8=
00621e78e]
>   transaction_kthread+0x159/0x1c0 [btrfs dcbea9ede49f9413c43a944f40925c8=
00621e78e]
>
> followed by leaf dump with items relevant to the numbers:
>
>        item 117 key (780331704320 168 942080) itemoff 11917 itemsize 37
>                extent refs 1 gen 2245328 flags 1
>                ref#0: shared data backref parent 4455386873856 count 1
>        item 118 key (780332646400 168 942080) itemoff 11880 itemsize 37
>                extent refs 1 gen 2245328 flags 1
>                ref#0: shared data backref parent 4455386873856 count 1
>        item 119 key (780333588480 168 925696) itemoff 11827 itemsize 53
>                      ^^^^^^^^^^^^^^^^^^^^^^^
>
>                extent refs 1 gen 2245328 flags 1
>                ref#0: extent data backref root 2404 objectid 1141024 off=
set 0 count 1
>        item 120 key (780334530560 168 942080) itemoff 11774 itemsize 53
>                extent refs 1 gen 2245328 flags 1
>                ref#0: extent data backref root 2404 objectid 1141025 off=
set 0 count 1
>        item 121 key (780335472640 168 942080) itemoff 11721 itemsize 53
>                extent refs 1 gen 2245328 flags 1
>                ref#0: extent data backref root 2404 objectid 1141026 off=
set 0 count 1
>
> as you can see item 119 is the problematic one and also out of sequence,=
 the
> adjacent items have the key offset 942080. Which confirms the bitlip
> case.
>
> As for any bitflip induced errors, it's hard to tell how far it got
> propagated, this could be the only instance or there could be other
> items referring to that one too.
>
> We don't have any ready made tool for fixing that, the bitlips hit
> random data structure groups or data, each is basically unique and would
> require analysis of tree dump and look for clues how bad it is.
>

Since we're pretty sure it's a bitflip now, would you please provide the
following info?

- History of the fs
   Since you're using Arch kernel, and since 5.14 we have all the write-
   time checkers, normally we should detect such out-of-key situation by
   flipping the fs RO.
   I'm wondering if the fs is handled by some older kernels thus tree-
   checker didn't catch it early.

- The hardware spec
   The dmesg only contains hardware spec "LENOVO 30B4S01W00", which seems
   to be a workstation.
   I'm wondering if it's certain CPU models which leads to possible
   unreliable memories.
   From my experience, the memory chip itself is pretty rare to be the
   cause, but either the connection (from BGA to DIMM slot) or the memory
   controller (nowadays in the CPU die).

Thanks,
Qu

