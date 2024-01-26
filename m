Return-Path: <linux-btrfs+bounces-1831-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8917883E39F
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 22:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C3A81F250BC
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 21:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF6F24B20;
	Fri, 26 Jan 2024 21:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="QA6Af9Gx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9239D249F9;
	Fri, 26 Jan 2024 21:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706303185; cv=none; b=Src+0SiKFRif9d1fv4xvQR45vzOpcOWobrSYGWWXYzEfPDR/J9mCOAfDcNFGIuY8KiBQCljmRJ6Hpsvaw6tys4IHeCHiPyMM11vWZneFIXU48F76x6DqoatxdlnQKJVA940wly4XYF3CIMNTkCK9F7LbQeEoXGAFxw2HVJLqtvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706303185; c=relaxed/simple;
	bh=8EeTfp4YIzP2sHw+KXgV72UgZNP3OOmicCf14DCJbcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ivlOMTn9OOejbRSZv0z/VYYdp/Tf+TJBtZYF+WCMm409dr8Y4SowGTyLQ5IoqN+xmjwtkmsc5Si1krSDB15Zdf4iYGTNC/gGoZqLRKSe243q9NKiQ4O8fym2BW/Aaoxao7IC9CR72wO1MM1xiQhR26o2tIi5KlLxzsMZoB/eCak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=QA6Af9Gx; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1706303155; x=1706907955; i=quwenruo.btrfs@gmx.com;
	bh=8EeTfp4YIzP2sHw+KXgV72UgZNP3OOmicCf14DCJbcY=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=QA6Af9GxyQKGckOhGVhou+6BZWiNGm163xS3Ag+B2wLfyGasIJ2XDp9YQCi055t6
	 bjfyJpKNQJ5dyWZJgc1jwCoAVtnOlR8B/A0O9m33QyAIJiA5vgNlmee1FLTk+g1bi
	 04XE8W5X3m4ovDzpbGBivP4qEJKFmT1YBy8vAaKQSP+zNFR2zpSTBomhjeTb8YIUf
	 sMH7/gqWhxzpVpVyj0vcSsN6doUsAWENLmc6dJBAMCteJVTFSClaXm/vj3/2C/WnC
	 al8+hHDsn8kf8AmFGY9bYLku4vqyYgmkUDLp2JjVGW7SEDh0yYI0o08Qu5SU0XpUL
	 YypFhO4iJXEFdLWJxA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([61.245.157.120]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MNKlu-1rjSmG2rVK-00Oqwl; Fri, 26
 Jan 2024 22:05:55 +0100
Message-ID: <58e6edb7-e282-4e04-8b8c-885d79252f8b@gmx.com>
Date: Sat, 27 Jan 2024 07:35:51 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Btrfs fixes for 6.8-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>,
 David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1705946889.git.dsterba@suse.com>
 <CAHk-=whNdMaN9ntZ47XRKP6DBes2E5w7fi-0U3H2+PS18p+Pzw@mail.gmail.com>
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
In-Reply-To: <CAHk-=whNdMaN9ntZ47XRKP6DBes2E5w7fi-0U3H2+PS18p+Pzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AoeMAOoSNr5uhJI7/H3i5yqBzwpX5l77gxSAulvyINq5gaOpT6v
 dnRedghlB0SY0CMEQpF3vzGGT+FyNx4bIbTRWLqizw0zkxSt1TyJ4I7msfNKbW82g8v6IBf
 ikAiRaAPDTIhu8znnAJwO7gl8Y727koIqGkBaVuyz9fk+H8Ri4vpPwbsbzwzd7z9vT5pNiD
 YiG+h8SyH2x2/49/Qzkvg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qxXHE0SVQ88=;L0sMBOK3Lt/LoLFbDlai/UR0L4f
 tevOEcHSLKb3Xv3erYPiyESlIjzSFBmpiBkHDzKIc8H3/UCUpyIZ/UrgdI6CYpvRQCcOzIeOB
 JOPzH5U+h6TobHC7W/qCROTU0lJ4SgKI+Njo//rHEAPhe/5kUQSvS1nVujPGHX1YP71N/EH1X
 4p0Xu8SqDvNsgs6ZrYSb4dJdLj+dNE+DFMFtmhbN8Pii1UH59440N/y3GyIsTmyWlB6f3CpxE
 UvutmwkLAk/oe+A4OEpNFL25iCQUjbEAEFDSQQRPPmICax1/eCoaiWWOuHT9iBKH+sbXva3Nd
 hTSd2EjvZBs7QXtwhgFz0dW1ufPxcvGooomVIpvP+u90i4vB5G6ZQBrNWVYatO8MIj7O0UaYA
 aqdbGmwmyGO5ajeTr9I3PpjwAXuXnNBl+q1hNzw9KgaoU/VDsLs90TUwOvwBIP5I1GHhnQFPY
 +jlRLP+kd3lA0saZh3EPg5GUaA8vNvSs2pF6BHyyhRMdhoyvf7+GJfm28GyEqNJQt24AVX4NX
 D8cMIBx0aJXFoALGy4TQDzAzFIDWxHRYUDyKoc0O4y+zALU0znbKB+SCbY8Q8W2yeU5Q7VEJy
 LpdnaSghBP0PTKEt+conxfruODYmXp7XphMQE4fpP3vEGks/k23+taoC5rrsr3gnI88UQR4f5
 HG1UhefhmBsATTO8+6jU27OanMYCC5aC2A9OVxl4FfSkz+tymZ0BicGWkqL2QNwROt5TCmZE1
 lNKeX8I5UgSyjI5QRyD2k0/Y4+28+c+mHauaVJUWHlf3484eWrNXoqHx+piH+WOWXbcoixBOI
 YpwR9OhYqcFrlxQ95cB3x5K7FB6BY+JUjLKtimDneW82ST1HWWkR+zhdSeNXI4oQSqebY5zfu
 Mw58gKXzGfBi42/qnGU2rMmU9/roeABWf6rhygIxkuhI+Ub3pH/7/Rwa5vnOvJrtuzbPxPpcc
 3WZ6mA==



On 2024/1/27 05:55, Linus Torvalds wrote:
> On Mon, 22 Jan 2024 at 10:34, David Sterba <dsterba@suse.com> wrote:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/f=
or-6.8-rc1-tag
>
> I have no idea if this is related to the new fixes, but I have never
> seen it before:
>
>    BTRFS critical (device dm-0): corrupted node, root=3D256
> block=3D8550954455682405139 owner mismatch, have 11858205567642294356
> expect [256, 18446744073709551360]
>    BTRFS critical (device dm-0): corrupted node, root=3D256
> block=3D8550954455682405139 owner mismatch, have 11858205567642294356
> expect [256, 18446744073709551360]
>    BTRFS critical (device dm-0): corrupted node, root=3D256
> block=3D8550954455682405139 owner mismatch, have 11858205567642294356
> expect [256, 18446744073709551360]

This is triggered during a btrfs btree search, for XATTR read.

The root=3D256 means the tree search operation is triggered from subvolume
256, which is completely sane.

But the other number, 11858205567642294356, which is still inside the
allowed subvolume range, but beyond the 0 level qgroup, thus it makes
is_fstree() return false, and triggered the error.

Normally we should not have this many subvolumes, and since 2015 we
already has such check against subvolume creation.

But I don't really believe that's the case, unless there are really that
many snapshots/subvolumes in the fs (beyond 1 << 48 snapshots)

>    SELinux: inode_doinit_use_xattr:  getxattr returned 117 for dev=3Ddm-=
0
> ino=3D5737268
>    SELinux: inode_doinit_use_xattr:  getxattr returned 117 for dev=3Ddm-=
0
> ino=3D5737267
>
> and it caused an actual warning to be printed for my kernel tree from 'g=
it':
>
>     error: failed to stat 'sound/pci/ice1712/se.c': Structure needs clea=
ning
>
> (and yes, 117 is EUCLEAN, aka "Structure needs cleaning")
>
> The problem seems to have self-corrected, because it didn't happen
> when repeating the command, and that file that failed to stat looks
> perfectly fine.

I guess since the error is self-corrected, there is no tree dump of
block 8550954455682405139 just after the error.

Personally speaking the number 11858205567642294356 is really too large,
so that it looks like some runtime garbage.
I don't have any clue for now, but if you hit it again, you may want to
run "btrfs ins dump-tree -b <bytenr> <device>" to dump the content.

Meanwhile I'll make kernel tree-checker to dump the content of the
offending tree block so that it's easier to debug.

>
> But it is clearly worrisome.
>
> The "owner mismatch" check isn't new - it was added back in 5.19 in
> commit 88c602ab4460 ("btrfs: tree-checker: check extent buffer owner
> against owner rootid"). So something else must have changed to trigger
> it.

Anyway I'll keep an eye on the situation.

Thanks,
Qu

>
>             Linus
>

