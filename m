Return-Path: <linux-btrfs+bounces-11303-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4389A29B98
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 22:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED7B167E1F
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 21:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB11214A6D;
	Wed,  5 Feb 2025 21:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="iwlejYzT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DCF1DAC81
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Feb 2025 21:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738789543; cv=none; b=AUckqFxXuSP74h0Rfw8nlxvc59ydZUyjSRhOMyAdlAkbCsflZpviG/ETFeTexjZ/wMOIbaj2vFOxI11BcxwWHgDVPzUQYZL9/ZqEoCkhtslGXayJrBBLd4GbyqHn22qKWaOMRSB7vfo0xyiRo2EN2vdKhvEkyLg+HNZSvzc1zwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738789543; c=relaxed/simple;
	bh=nceELc9heKtnszHQ63KXnanBGABZsxRjjxIos6DEUTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Dg2S8vC8Qhma0eHlrUxej/CL/EsuJZtMheg7mZtP+LA1UyFcSdu4qt5QeLkGTYe5DwmMvScJIVN091uHP+QTBQGD74Hy0byIbpNGrjpOsSJ0k2JlsQ8JiTgLBg3/LmoEMEkC2tFUTuMKMKBiaArWZaLWD02eFNNSzGXlUE0rjUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=iwlejYzT; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1738789534; x=1739394334; i=quwenruo.btrfs@gmx.com;
	bh=3SQZuW2p+AUrF+BMKMsZhdZ7e/PNbBr7uINpXH4Tlss=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iwlejYzT9+7DcWSS15n9G96KrzcUdOpP7b6ZGEo9CRsEX39QugHGl2bWKhZ1+duf
	 XKGKQ7jarBg7Vs9WYp/LBejsf0igddKR4/igkmkQi9VuB7ELyhHx1xAPl5KEbqaL0
	 4iQ4hfdI1piFFubK1z16xC1nSJBX/1AAqg3Q4aZGDkjgdJ++qnf4bONURQ15lBCM0
	 fBi2vQ+K4KTPv4RzzpxN6cQG4ZXKqysfACvLXkxZCeXILjTOVh2xLLenCVNrSi0rF
	 CKFWDZw/DrX6FFx1Jm99rs9kKH05TIMGO8gJQxiCOKcaXsXj25ZUx0cYL0bub3hXy
	 YbS7gz4xGN1qAvVvhg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MMXQF-1txaig2kJ5-00WyrB; Wed, 05
 Feb 2025 22:05:34 +0100
Message-ID: <ba32a0f9-f699-46a1-8a8c-326bda01b356@gmx.com>
Date: Thu, 6 Feb 2025 07:35:30 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix hole expansion when writing at an offset
 beyond eof
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <974b00afc2e703d5e0085fefbb46a1e495956ae1.1738778225.git.fdmanana@suse.com>
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
In-Reply-To: <974b00afc2e703d5e0085fefbb46a1e495956ae1.1738778225.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O/i1qbpyHmOeyxCy2FOlQiY8YUCwTgUQ3T01kZpa3BivXZ+TdMH
 Kq8mc/DuNJAd4xw9eBNLzPG8rcJ0HamcHVm/3+p+2NRguxXjfcFSwr6juNFatKCYv7tPLwl
 59wN/xE4ujcm0v04cPizkqGErhLyPBAmf4Mb0Jyx4gfAeyizvEGWzoqfFDqupN2wFXzUH7z
 KZSbLys6J5hwd+AAP9qZg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:f6UjfHIPWYk=;Hyt6qGQxfH5EkoriOJMRY88yAe+
 K2skgLKPjPpQyz4cRM9KgmBfAr1wi1Kvaaur0ZRFgtmZo9soi3rTQPPTc0Fq8sIS2E+5JLLFO
 YzIFGZAPD/EN3IeDJlKMv6OlVccPN2/zKlZH2g0ZYUEs2ipKUvUzEUuCE7iI66of3oqJn+5B7
 5xeTuY9KLM8qrZwJc2N4JcYpco2mKKmCxAM53gcVNpvtOHWZeI2n0oBptRyNQXSdGhfNaOC2s
 znylCS/Df2Dtd/+6+4jwTV1LoZLrbQX5Q44c+ofusPWOnutF3ltkf/8dQTKdruTjvcxAMbMRr
 N6yEh19pQNCnGaowL0LLmLgGdbTJ+eiirJReXDb3xVk6H3UNN59a4BYIFUyz46rG5hQu1CAPG
 ypjPRwf5W0MH2ApY+rsPu0nW1VAutw6fhyc8xu8ufE2RIjgJByrPFivNVe4k630YWjWScfx7F
 4sNrx7BF6USoxFtTNci0Fb4qMZK1ZZOSgsUBZIWvu73xvJz/vy/woJHmg92EXhuS39iq0CGYv
 vkyrSEuLZYHTBoOG/DIfIb1OXjD7s9bYAP5ayE/NAvwHkfjccfkgKNr+Dnp4XvBJH/vfLa21z
 RocdJrKZEkPlqTYIKjifdQfv71yV281nixYoRSa0GgPQ1wsylNNokPHHy0lU2o2L4QM5rhfPU
 Fnwi/0SugFXxKShPNLbD9YvlM6ty43s29kGnNd5rOl1FcgVqmnIei9hNwBTI2UmnCaf1Rj87E
 1i9eHthtmEL6baJgefwEhia8M4roUcWfkoHZFqwmydNMtFRH13zILpqY+WMZnR5PZtK8rT9aC
 umMY07sxp6uoUjCu7BBJtHaTOJSp5xEzZ1Je/kejNsYzAqVvzdwP5a6rHMq56QElWJFUuPcSA
 D7CJoPY4LZNoo7B3MsydKRdneXR3dk+r+c9fvrIqxMPYAoGGSw7apKtnhb2MXWe4NmaG4x5Mo
 ekzAPcWyM2EVT24dtvUwzP/AY0w0NDod7jX7IYD1sVf5RMUyVxxHNyCf9wFF5yiBOQGKqIFod
 KIYzhgWZm07sjaeMbstOlmGZkxZZ0282SxB77l414x2aePPsvQqiOvVtiSEvCe6O+YHAXLqYG
 Ij1TsTEoz9W+/pESSPStrLZqS6jcwYZIaSoe6cc0g46fHmTlDq6gCOKzniW9hNkTIu0HPy9T3
 Xo/EjY5u4mjnlQQ9Sgf8Z+X0S+9d7TXoRwzNr/6oyLZG6vCfcO2RFh/LfFae3gCyRvRYL21IP
 dzB51ltTA0Ad68dvu6FbQ8xujC9Gq9vN+0O+3ZcBNZV3vgZhdcbrpL3F5CpU+Fx3ZQFVsRbdM
 kjLFP5lipEp/7ikdKsfuAGulZ2WurEtH7eHf3VL8aDJpOoksnNExyhtqYYGYfh6taC0Qx2sou
 AeSFWyDCRvht5cYV+1rZZll+4ZajjI8vFormb85dt+3EXlRamE6FO3leWC



=E5=9C=A8 2025/2/6 04:30, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> At btrfs_write_check() if our file's i_size is not sector size aligned a=
nd
> we have a write that starts at an offset larger than the i_size that fal=
ls
> within the same page of the i_size, then we end up not zeroing the file
> range [i_size, write_offset).
>
> The code is this:
>
>      start_pos =3D round_down(pos, fs_info->sectorsize);
>      oldsize =3D i_size_read(inode);
>      if (start_pos > oldsize) {
>          /* Expand hole size to cover write data, preventing empty gap *=
/
>          loff_t end_pos =3D round_up(pos + count, fs_info->sectorsize);
>
>          ret =3D btrfs_cont_expand(BTRFS_I(inode), oldsize, end_pos);
>          if (ret)
>              return ret;
>      }
>
> So if our file's i_size is 90269 bytes and a write at offset 90365 bytes
> comes in, we get 'start_pos' set to 90112 bytes, which is less than the
> i_size and therefore we don't zero out the range [90269, 90365) by
> calling btrfs_cont_expand().
>
> This is an old bug introduced in commit 9036c10208e1 ("Btrfs: update hol=
e
> handling v2"), from 2008, and the buggy code got moved around over the
> years.
>
> Fix this by discarding 'start_pos' and comparing against the write offse=
t
> ('pos') without any alignment.
>
> This bug was recently exposed by test case generic/363 which tests this
> scenario by polluting ranges beyond eof with a mmap write and than verif=
y
> that after a file increases we get zeroes for the range which is suppose=
d
> to be a hole and not what we wrote with the previous mmaped write.
>
> We're only seeing this exposed now because generic/363 used to run only
> on xfs until last Sunday's fstests update.
>
> The test was failing like this:
>
>     $ ./check generic/363
>     FSTYP         -- btrfs
>     PLATFORM      -- Linux/x86_64 debian0 6.13.0-rc7-btrfs-next-185+ #17=
 SMP PREEMPT_DYNAMIC Mon Feb  3 12:28:46 WET 2025
>     MKFS_OPTIONS  -- /dev/sdc
>     MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
>
>     generic/363 0s ... [failed, exit status 1]- output mismatch (see /ho=
me/fdmanana/git/hub/xfstests/results//generic/363.out.bad)
>         --- tests/generic/363.out	2025-02-05 15:31:14.013646509 +0000
>         +++ /home/fdmanana/git/hub/xfstests/results//generic/363.out.bad=
	2025-02-05 17:25:33.112630781 +0000
>         @@ -1 +1,46 @@
>          QA output created by 363
>         +READ BAD DATA: offset =3D 0xdcad, size =3D 0xd921, fname =3D /h=
ome/fdmanana/btrfs-tests/dev/junk
>         +OFFSET      GOOD    BAD     RANGE
>         +0x1609d     0x0000  0x3104  0x0
>         +operation# (mod 256) for the bad data may be 4
>         +0x1609e     0x0000  0x0472  0x1
>         +operation# (mod 256) for the bad data may be 4
>         ...
>         (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/generic/363.=
out /home/fdmanana/git/hub/xfstests/results//generic/363.out.bad'  to see =
the entire diff)
>     Ran: generic/363
>     Failures: generic/363
>     Failed 1 of 1 tests
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/file.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 36f51c311bb1..ed3c0d6546c5 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1039,7 +1039,6 @@ int btrfs_write_check(struct kiocb *iocb, size_t c=
ount)
>   	loff_t pos =3D iocb->ki_pos;
>   	int ret;
>   	loff_t oldsize;
> -	loff_t start_pos;
>
>   	/*
>   	 * Quickly bail out on NOWAIT writes if we don't have the nodatacow o=
r
> @@ -1066,9 +1065,8 @@ int btrfs_write_check(struct kiocb *iocb, size_t c=
ount)
>   		inode_inc_iversion(inode);
>   	}
>
> -	start_pos =3D round_down(pos, fs_info->sectorsize);
>   	oldsize =3D i_size_read(inode);
> -	if (start_pos > oldsize) {
> +	if (pos > oldsize) {
>   		/* Expand hole size to cover write data, preventing empty gap */
>   		loff_t end_pos =3D round_up(pos + count, fs_info->sectorsize);
>


