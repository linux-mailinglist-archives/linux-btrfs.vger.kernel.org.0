Return-Path: <linux-btrfs+bounces-7977-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5A59773AC
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 23:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D0F9284978
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 21:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3331C174C;
	Thu, 12 Sep 2024 21:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="nEFxaO32"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0CB2C80;
	Thu, 12 Sep 2024 21:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726176943; cv=none; b=fASPz/UqV4EOQuswEiqEMcNX+QnEF9esH2Bq/7lm0QM2PSy1xJ+d9ibzpn8zRqBgOos39nuzQzdS3C/j+i0DYfNMQ+h+HYUgSNGte2rF2bcgCM9dS0rKVoQMDFl/DskOnqwL50tSc/R/ILMXGS0iYeOaUzpgXt0S9lN7xIF+Cts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726176943; c=relaxed/simple;
	bh=hcaSJNOKaKzVUWJ1JNBR0mLmzCxaWhSLXbJ5M+9Cj0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u6/SCY3Tf+JAx2bzKg7BYLGNCP773yw/sg5VxJ0G+v+w9cZ1ytapKUu5GJcW8ojh9WXhEuZpfzInm+Awud6ajBcfQt3Rt9SoFN8FgxSCFzb+l4jsKu2HsBW/G3bh+kweoY9DqgHGoDLC39ReUWavHUtDDLf7KPicKKZfdYKWDV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=nEFxaO32; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1726176934; x=1726781734; i=quwenruo.btrfs@gmx.com;
	bh=y4tt9c8/CDVs6N61r+jnPAv9En3aRlmm+Lz5g5B5nTc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=nEFxaO32kjyYsy5O9CNiuTi2Gwb+9ZYVWf7E3VNbH5p9Gl0wuIlMcgtCwO8j6CH0
	 K7wu+XvtGfNEm6IjnnKZErJuXN0m2zNKk0v8jtDzHunBgf+Kw1Eh2VVZsEB+DBoxZ
	 /QD/Nn7+E1UK4Or6LcODRSl2krc3vfF65lgLOBmZGF9E9k+AvwJDW358IyQep0uuW
	 I76nH6dODmCocdHoAM5U79qBMXRYkIRTcTKQQrVkfKH+Vs6fyabxClNUaceeFYUSn
	 B7ULkXHo5XhBnx+YRlnXEjvGZDPJtKQRKfYuaqptlcLGsLoPEpRPDlcMon+95jZAt
	 SJOif/2V6pgal5Kdog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mzyuc-1s33kR20n8-00x0hE; Thu, 12
 Sep 2024 23:35:34 +0200
Message-ID: <992b0055-12a2-47e8-91e2-38fb763cac9e@gmx.com>
Date: Fri, 13 Sep 2024 07:05:30 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/321: make the test work when compression is enabled
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <21f8d987309ca0699c6bb95666278d02da03ff32.1726145029.git.fdmanana@suse.com>
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
In-Reply-To: <21f8d987309ca0699c6bb95666278d02da03ff32.1726145029.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9/2RGrmHj3S14fFzesFqIC/ryfe0dpV3p8UELVfXOAOYyelG5Zl
 APwkIY4mn0Fr1ft6PVbghTkYzfGsXxqCr1I0S9xcm3Dkvehkd1qW4lszxbKWi7kevaYOhiW
 Pfm/zGzH29CQEeOxDNjPdGEfIoWYdqW8CirncuCALUUl2mffivXsyrq/+6w5KM2DsPRN/5c
 cgjXTkMq/x+8C2Y4Oez0w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FQQK2XS+Fqc=;WF649X7hn5U5Wl5zhwE+OslECEP
 xw+F3E7tYdpjStdXL+qNVjCDU6wutq35DuCpvnQeEv0RS9TJCBllRw8MO3NIDZI2M0IL/fDcG
 8yKNpvTAp+PLiggHvrpS0SUXO2xna3kBbSxFeDxKoyXLub6MGhuJiz3ru5fW5L3/VBqh0jUGx
 sI0c+lmmkHTFwrVR+vvBayBwcR1GUJeDZ/wxvRE55lEhh7zCiEoJeEJMjDsm+fMczVjoEhb9F
 v2gDBjTm3Pp4i4lRj3eQg94EAJJy4ZnQqR4twyX7APO1qlf4e9IMvBq2JUb7aMPXbkysRC3LR
 ly5S+Vj3OWxdrYeBiUeWeDsclw1YeAhePAh+JrvbwUoiXi8SsHDgals/DS8tAma7ymiIN211D
 bIoCp+iGMeSODY9CABXbIKlcEsPFJobDcPikfnJKjSTp/CCb5kqnROvEIpp8I2jB5zuebE+sO
 z5FMjf9juhR/K4esTEHvSOk/VK7aXcSo5yXwdrSnS0pYQE2E2ZKeE/v27mpzkEWC9QBsGmtGo
 6dBGYEgDqO/SOqfage5NlFpbmjCMw4GLUgyI54XHrpWKOjd5/tbR4vn1saa9OmVq37IJuYwRn
 peJVaZDYbUNJGOkljjLh99iGmlry5rhaCgtdoeTgNJ8X1OLsBR0QuSJPVKcPMOfnd9sbaOnUw
 F92AI2nj1aH7Tl5yDz6uIW5hMng5U+njrSc+NHe2HdqeFP6HiOzl1YS30TieNmyzgInkGJ6Go
 FbMdMG/SDh869D5lhA2kDoqMzhRQzEfVIFybcSzuj6csbgcvW28d2JQhUouCePhlhJxuqN3sC
 6z9ckCTDrxtA4j3lfmhW1JmQ==



=E5=9C=A8 2024/9/12 22:15, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> When running btrfs/321 with compression enabled it fails like this:
>
>    $ MOUNT_OPTIONS=3D"-o compress" ./check btrfs/321
>    FSTYP         -- btrfs
>    PLATFORM      -- Linux/x86_64 debian0 6.11.0-rc7-btrfs-next-174+ #1 S=
MP PREEMPT_DYNAMIC Tue Sep 10 17:11:38 WEST 2024
>    MKFS_OPTIONS  -- /dev/sdc
>    MOUNT_OPTIONS -- -o compress /dev/sdc /home/fdmanana/btrfs-tests/scra=
tch_1
>
>    btrfs/321 2s ... [failed, exit status 1]- output mismatch (see /home/=
fdmanana/git/hub/xfstests/results//btrfs/321.out.bad)
>        --- tests/btrfs/321.out	2024-09-12 12:12:11.259272125 +0100
>        +++ /home/fdmanana/git/hub/xfstests/results//btrfs/321.out.bad	20=
24-09-12 13:18:40.231120012 +0100
>        @@ -1,2 +1,5 @@
>         QA output created by 321
>        -Silence is golden
>        +mount: /home/fdmanana/btrfs-tests/scratch_1: can't read superblo=
ck on /dev/sdc.
>        +       dmesg(1) may have more information after failed mount sys=
tem call.
>        +mount -o compress -o ro /dev/sdc /home/fdmanana/btrfs-tests/scra=
tch_1 failed
>        +(see /home/fdmanana/git/hub/xfstests/results//btrfs/321.full for=
 details)
>        ...
>        (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/321.out=
 /home/fdmanana/git/hub/xfstests/results//btrfs/321.out.bad'  to see the e=
ntire diff)
>
>    HINT: You _MAY_ be missing kernel fix:
>          10d9d8c3512f btrfs: fix a use-after-free bug when hitting error=
s inside btrfs_submit_chunk()
>
>    Ran: btrfs/321
>    Failures: btrfs/321
>    Failed 1 of 1 tests
>
> This is because with compression enabled we get a csum tree that has onl=
y
> one leaf, and that leaf is the root of the csum tree. That means that
> after the test corrupts the leaf, the next mount will fail since an erro=
r
> loading the root is critical and makes the mount operation fail.
>
> Fix this by creating a file with 128M of data instead of 32M, as this
> guarantees that even if compression is enabled, and even with the maximu=
m
> allowed leaf size (64K), we still get a csum tree with multiple leaves,
> making the test work.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

My bad, I forgot compression, which will reduce the csum size.

Thanks,
Qu
> ---
>   tests/btrfs/321 | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/tests/btrfs/321 b/tests/btrfs/321
> index 93935530..c13ccc1e 100755
> --- a/tests/btrfs/321
> +++ b/tests/btrfs/321
> @@ -33,9 +33,11 @@ _scratch_pool_mkfs "-d raid0 -m single -n 4k -s 4k" >=
> $seqres.full 2>&1
>   # This test requires data checksum to trigger the bug.
>   _scratch_mount -o datasum,datacow
>
> -# For the smallest csum size (CRC32C) it's 4 bytes per 4K, writing 32M =
data
> -# will need 32K data checksum at minimal, which is at least 8 leaves.
> -_pwrite_byte 0xef 0 32m "$SCRATCH_MNT/foobar" > /dev/null
> +# For the smallest csum size (CRC32C) it's 4 bytes per 4K, writing 128M=
 of data
> +# will need 128K data checksum at minimal, which is at least 34 leaves =
when
> +# running without compression and a leaf size of 64K. With compression =
enabled
> +# and a 64K leaf size, it will be 2 leaves.
> +_pwrite_byte 0xef 0 128m "$SCRATCH_MNT/foobar" > /dev/null
>   _scratch_unmount
>
>

