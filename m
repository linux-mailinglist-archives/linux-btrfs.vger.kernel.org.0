Return-Path: <linux-btrfs+bounces-6302-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7C392A73C
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 18:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5FE1F20F43
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 16:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE27145A0E;
	Mon,  8 Jul 2024 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTihxPmo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A8780027
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jul 2024 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720455860; cv=none; b=AreytFX8fGt4JAyz8EYVC73l1/Vfshj9SjhErT3kqitOPwDoMaqtFa4ozOg6xI3IVmKM/HjCWoRHp0drVJRWAWhPm2KHaEtwTHaiG1OFzggmBZ+Bgp0O6/cPHKJCPlvs6Pkpo77RPKkV8X5wflaoDXSAAPca8tSm7TyPCDSC/hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720455860; c=relaxed/simple;
	bh=72Ahxx1qQJ2yvWwX7Q4CkbYzKUoTTt1C9GscgybAPRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iCCZ+H4Z/f2UD+kbrRluE5QS3NgVZRm0EZeAPLDjHIwcSdLtLNGB5d9p7JtPkBhqCLHQAX2GUHA+4RVAjPVlcm/wC7wQkfrm55jqKyGnTfPrZbAqG5wjReWhyxbEt5JMB2+ThkTz1T+I9r06hIOib5qFwPSQt4dQtMapzWSLqtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTihxPmo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947FFC116B1
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jul 2024 16:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720455859;
	bh=72Ahxx1qQJ2yvWwX7Q4CkbYzKUoTTt1C9GscgybAPRE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fTihxPmoiUEVQ7rhb6Uoh7if58vFWW3exUrkjNwJ+B3XM9/QXCZvDvJ/Cq1JjLeIT
	 yxwBDRMYOd67vWmhzeFPlFZXLhL45sI/g3+RIAfV1KdUf9CoOBVr/N6OHR9YnT2Hec
	 EJ2mooHWZC1u8iv6yGrf+dE8L7RSUOC6y1CsyQgj/kbj8AZsmkfqX5mKNnvu6jfw9J
	 xk3yFyiTNEXXvgdixlMnh/sk1Gz+nLR50BoirT2cNxGgX4uXZlBx9FZoCrZ4sdDuXc
	 pmT2BGPWFAFk6xuG78n97zKw+bBbV0yCxSV3rBhR8kPHGbdwQCxLSe9+nb28jUeKjx
	 4h1Q658dk4Tgw==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-58b447c513aso4856981a12.2
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Jul 2024 09:24:19 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy1auf+t+k1IrVvdfWZBtyhZfsGzBgT+/lTpCxNVZM4QaOjjX1K
	RVKaO9sdZY/gStOQMMS+O0hG8qh5oiaypLFMVeIz12YTpIrtWx8nm9c9BXDlIZ4oXONBx4s4GBB
	RENzN+AhIOL6gwHh1U9d/227JXlA=
X-Google-Smtp-Source: AGHT+IExevXusOeCqPeqIFWQXwv9LnHHFterSzlSumqA02N39HaVHqGEDXOE8C0MaKowFOZ7MB+Y2vg3hiq6MPxYs+Q=
X-Received: by 2002:a17:906:81d2:b0:a77:c8a8:fd71 with SMTP id
 a640c23a62f3a-a780b6b30d9mr6471766b.32.1720455858147; Mon, 08 Jul 2024
 09:24:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5152cead4acef28ac0dff3db80692a6e8852ddc4.1719828039.git.fdmanana@suse.com>
 <20240702145200.GF21023@twin.jikos.cz> <CAL3q7H7X9zMZh-0ruaQV++mMY2q3oFTq6kW2BwOe=v+0OECGQQ@mail.gmail.com>
 <20240702154606.GG21023@twin.jikos.cz> <20240703230546.GR21023@twin.jikos.cz>
In-Reply-To: <20240703230546.GR21023@twin.jikos.cz>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 8 Jul 2024 17:23:41 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4u-P4WEuUcz6xj2Dkaq_Y39Fe3JjzVZLWF3YGemS+nLg@mail.gmail.com>
Message-ID: <CAL3q7H4u-P4WEuUcz6xj2Dkaq_Y39Fe3JjzVZLWF3YGemS+nLg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix data race when accessing the last_trans field
 of a root
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 12:05=E2=80=AFAM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Tue, Jul 02, 2024 at 05:46:06PM +0200, David Sterba wrote:
> > On Tue, Jul 02, 2024 at 04:09:42PM +0100, Filipe Manana wrote:
> > > On Tue, Jul 2, 2024 at 3:52=E2=80=AFPM David Sterba <dsterba@suse.cz>=
 wrote:
> > > > On Mon, Jul 01, 2024 at 11:01:53AM +0100, fdmanana@kernel.org wrote=
:
> > > > >   [  199.564372]  __s390x_sys_write+0x68/0x88
> > > > >   [  199.564397]  do_syscall+0x1c6/0x210
> > > > >   [  199.564424]  __do_syscall+0xc8/0xf0
> > > > >   [  199.564452]  system_call+0x70/0x98
> > > > >
> > > > > This is because we update and read last_trans concurrently withou=
t any
> > > > > type of synchronization. This should be generally harmless and in=
 the
> > > > > worst case it can make us do extra locking (btrfs_record_root_in_=
trans())
> > > > > trigger some warnings at ctree.c or do extra work during relocati=
on - this
> > > > > would probably only happen in case of load or store tearing.
> > > > >
> > > > > So fix this by always reading and updating the field using READ_O=
NCE()
> > > > > and WRITE_ONCE(), this silences KCSAN and prevents load and store=
 tearing.
> > > >
> > > > I'm curious why you mention the load/store tearing, as we discussed=
 this
> > > > last time under some READ_ONCE/WRITE_ONCE change it's not happening=
 on
> > > > aligned addresses for any integer type, I provided links to intel m=
anuals.
> > >
> > > Yes, I do remember that.
> > > But that was a different case, it was about a pointer type.
> > >
> > > This is a u64. Can't the load/store tearing happen at the very least
> > > on 32 bits systems?
> >
> > Right, it was for a pointer type. I'll continue searching for a
> > definitive answer regarding 64bit types on 32bit architectures.
>
> I have a counter example, but this is a weak "proof by compiler", yet at
> least something tangible:
>
> in space-info.c:
> void btrfs_update_space_info_chunk_size(struct btrfs_space_info *space_in=
fo,
>                                         u64 chunk_size)
> {
>         WRITE_ONCE(space_info->chunk_size, chunk_size);
> }
>
> This uses _ONCE for the sysfs use case but demonstrates that it does not
> prevent load tearing on 32bit:
>
> 000012f4 <btrfs_update_space_info_chunk_size>:
>     12f4:       /-- e8 fc ff ff ff                      calll  12f5 <btrf=
s_update_space_info_chunk_size+0x1>
>                         12f5: R_386_PC32        __fentry__
>     12f9:           55                                  pushl  %ebp
>     12fa:           89 e5                               movl   %esp,%ebp
>     12fc:           53                                  pushl  %ebx
>     12fd:           5b                                  popl   %ebx
>
>     12fe:           89 50 44                            movl   %edx,0x44(=
%eax)
>     1301:           89 48 48                            movl   %ecx,0x48(=
%eax)
>
>     1304:           5d                                  popl   %ebp
>     1305:       /-- e9 fc ff ff ff                      jmpl   1306 <btrf=
s_update_space_info_chunk_size+0x12>
>                         1306: R_386_PC32        __x86_return_thunk
>     130a:           66 90                               xchgw  %ax,%ax
>
>
> eax - first parameter, a pointer to struct
> edx - first half of the first parameter (u64)
> ecx - second half of the first parameter
>
> I found this example as it easy to identify, many other _ONCE uses are
> static inlines or mixed in other code.
>
> I've also tried various compilers on godbolt.org, on 32bit architectures
> like MIPS32, SPARC32 and maybe others, there are two (or more)
> instructions needed.

Ok, so that's actually mentioned to be expected in one lwn article at
least, see below.

But I'm under the impression that access/update to variables without
locking or using an atomic type, should use the _ONCE macros, and
several places mention that explicitly.
For example https://lwn.net/Articles/846700/  says:

"... it is highly recommended to use READ_ONCE() and WRITE_ONCE() to
load and store shared data outside a lock."

There's similar recommendation in the Linux-Kernel Memory Model
document at https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2018/p0124r=
6.html
which says:

"Loads from and stores to shared (but non-atomic) variables should be
protected with the READ_ONCE(), WRITE_ONCE(), and the now-obsolete
ACCESS_ONCE()..."

Going back to "Who's afraid of a big bad optimizing compiler?"
(https://lwn.net/Articles/793253/) there's a whole list of problems
when accessing shared data without a lock or an atomic type, from
load/store fusing, to invented loads/stores, etc - for all of them the
use of _ONCE() is recommended.

For the load/store tearing, forgetting the 64 bits read on a 32 bits
system case, it mentions that reading a word sized variable (a
pointer) can result in loading it byte by byte.
And recommends _ONCE()  to solve such problems as long as we have
properly aligned and machine-word-sized accesses.

For the 64 bits access in a 32 bits platform it says:

"Of course, the compiler simply has no choice but to tear some stores
in the general case, given the possibility of code using 64-bit
integers running on a 32-bit system."

Which matches what you observed by disassembling code.

For some cases going with data_race() is probably just fine because
reading a stale or bogus value would be harmless, like reading a value
from a block reserve.
For others which I'm not so sure about, the _ONCE() use seems to be the saf=
est.

And what do you want to do with the patch, which is already in for-next?

Thanks.

>
> The question that remains is if the 2 instruction load/store matters in
> case if the value is in one cache line as this depends on the MESI cache
> synchronization protocol. The only case I see where it could tear it is
> when the process gets rescheduled exactly between the instructions. An
> outer lock/mutex synchronization could prevent it so it depends.

