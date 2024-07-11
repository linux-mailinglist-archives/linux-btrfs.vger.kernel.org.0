Return-Path: <linux-btrfs+bounces-6353-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C6192DEFD
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 05:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C9A1C211B9
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 03:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A72B374C6;
	Thu, 11 Jul 2024 03:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="SK3YzmzE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91601219F9;
	Thu, 11 Jul 2024 03:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720670234; cv=none; b=Z+vYR9KCM7PJlK0RY1yodyNVuD/CJ6onWh17lq1phphyXaKLSGgLDYmyMS9NFoAlXNdw2T88jHO/LuNu3H8OZa7Vc8X0UQXJdO5OhE2NVQ14zYkYbvOy2QQH/6y+wI9fK+8BlcXLNw/9lZRuPi9R8Ru7lAfTRaqot1Ey4C9xqBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720670234; c=relaxed/simple;
	bh=Sn0m0n8h0LjNnX0ZwUfsgYVGH+4sARnzpdS+NUzr028=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8dDqM3KOf/eEPAk/70/2ozv93Am9xj5trx78bncDvETnAH88PMRTiiG3SKBDvDsfmppW+/VcniiAHr2IVNXCXCcXzakWQY8PsLgi2EKoB5b622M6Ma49mq8blTL3IAt8/WwxCIUeYOJH7+yy/nFyaFvRauBqR9J9eByi4elce8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=SK3YzmzE; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1720670223; x=1721275023; i=quwenruo.btrfs@gmx.com;
	bh=DNRnfCoMzKk75DGoGzvU6x6hWtyUEUMaSCPTTjyLoE0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SK3YzmzEAoFMlmuWgXkqiaPzxte0D+N4VxZ95mrzoICvZeXoCLfVqQoqWYQBHZ68
	 9de4sftvypuZMW1jlLBpLcEjB/soiIwN8QPzxRemjVulMPHTjdqN4OnzGfuxpyi0X
	 Q80fpw/QXiy261sA30IRPGZeH2DrcQLwc10p2sNelCKIQqfoy8wHgzLIC8pP8nM7K
	 t9DPLzzdl/JtAXl8S+5DR9zAKUGWtmp0F4lRgrSSQKGeJIL+deXAcSkgRP03pxkzX
	 vuzsg713x5wV91u0oVitqm9YtzdXCwDKYqLDFlDALgZ+jXyTawlIxJX73Mcsdafn7
	 cQHXOJ831TkiYj6Z2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MzQg6-1sEbpW32vI-014ImQ; Thu, 11
 Jul 2024 05:57:03 +0200
Message-ID: <7ba1b64f-7969-4c27-87ae-33c2c9c6b236@gmx.com>
Date: Thu, 11 Jul 2024 13:26:57 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Fix slab-use-after-free Read in add_ra_bio_pages
To: Pei Li <peili.dev@gmail.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, syzkaller-bugs@googlegroups.com,
 linux-kernel-mentees@lists.linuxfoundation.org,
 syzbot+853d80cba98ce1157ae6@syzkaller.appspotmail.com
References: <20240710-bug11-v1-1-aa02297fbbc9@gmail.com>
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
In-Reply-To: <20240710-bug11-v1-1-aa02297fbbc9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mJZQldmAsf6/NGhO0DFRwORK706xJfe8utrJtrO0kcu5U2Etels
 7qjuZQmy/0oXUwmYJM6g0sg7QKbD6DHEz29Wup9jMn+BLF8GWLHPJqPTr1kKp184bz+s5kr
 865YsNaIkm2IjE1a/DF+aP/62IMSmVFUex22CrcfJ1tOPuJ+Wq+DsRDAcpjA2H/Xc3UzkW5
 Zvlh+Cc6amOEEgRq49hXg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:i2VrzLPIcx0=;vi3gkJ21e6XjU3rKexwRE2oTSsO
 vw1OiqIVG/kSDLfgs/WKg9ziLtoBnL05xd2er0ZOwixX5mLCthjKietHbVxDcH3+y7rh39OQl
 kKQRozFKEIf2JPUqTOqt3uf1uzVyU0IH+mCywF+J5NiCwsmlUDVJww1iPfzC2hcAPGDIHh8hp
 8CbYR0PgqOSstl3Z6g76hcLgkv33DycHrwu9yzyeu7rJk/6cunfE19k3BT2YOIGWrK1GEMzxN
 HL3Wh/mVox1jIzLBj4OFC6dKB/oF7Hj8EhTtGb9krbxShvcT0YjG8RPTFBddIdO/j6kJXjVsW
 +k5S1i5jEIMLXeyZccSCT+4uYgZsqoEB4s6nwWXbzIz0nRhajrhbF90aUrycPugbS7fH0e063
 tqQHwtCjwg6Q+0dO0+waRKWJJI5Dr5/9C2PGi1JXyuTR71fN0vE2K2eHwfoGoklkt4H4uhrEq
 nuqPMTTDsBIhEnEHLSBa3LX2Nd8zgLzJWEl9A1+W59fwVJTDVmDtNdlAlUQzoTjHdCG50K4mf
 88ZcjmyYqMzkY64cJUiMJ6DuWCPeeLvoigXy7Qd1H4Dhu7UyciPb7Jd2JTdi0H6qE710tRJww
 FLBLFh1mQsuDU92zYpSsadSMamk1n+YU+blfomtYEAGkr4XTbupoZc+FGu5TjgMEuB8PgcjYh
 VaVbc47pU3bacXLz6XSdEeAmowKAVSxDcT/dHo1uC/0Ob6bPtMBAA/g2yAHcdM8enjHWXFfP7
 Z9MtM4VDQ0YueJMeENx7IxwOYR4IT8CcNZeczpdTqDqttSoo8zoeftRSfBBW8nzZsjzRtAGEl
 tlpn8d3lKvW0okb9TcJnEPbw==



=E5=9C=A8 2024/7/11 13:12, Pei Li =E5=86=99=E9=81=93:
> We are accessing the start and len field in em after it is free'd.
>
> This patch stores the values that we are going to access from em before
> it was free'd so we won't access free'd memory.
>
> Reported-by: syzbot+853d80cba98ce1157ae6@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D853d80cba98ce1157ae6
> Signed-off-by: Pei Li <peili.dev@gmail.com>

And missing the fixes tag:

Fixes: 6a4049102055 ("btrfs: subpage: make add_ra_bio_pages() compatible")

And it is better to Cc to stable kernel for v5.16 and newer kernels.

> ---
> Syzbot reported the following error:
> BUG: KASAN: slab-use-after-free in add_ra_bio_pages.constprop.0.isra.0+0=
xf03/0xfb0 fs/btrfs/compression.c:529
>
> This is because we are reading the values from em right after freeing it
> before through free_extent_map(em).
>
> This patch stores the values that we are going to access from em before
> it was free'd so we won't access free'd memory.

Indeed it's a use after free.

But the only usage is in this line:

	add_size =3D min(em->start + em->len, page_end + 1) - cur;

So why not just move that line before "free_extent_map(em);"?
It should be much easier to read than the current change.

Thanks,
Qu
> ---
>   fs/btrfs/compression.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 6441e47d8a5e..42b528aee63b 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -449,6 +449,7 @@ static noinline int add_ra_bio_pages(struct inode *i=
node,
>   		u64 page_end;
>   		u64 pg_index =3D cur >> PAGE_SHIFT;
>   		u32 add_size;
> +		u64 start =3D 0, len =3D 0;
>
>   		if (pg_index > end_index)
>   			break;
> @@ -500,12 +501,17 @@ static noinline int add_ra_bio_pages(struct inode =
*inode,
>   		em =3D lookup_extent_mapping(em_tree, cur, page_end + 1 - cur);
>   		read_unlock(&em_tree->lock);
>
> +		if (em) {
> +			start =3D em->start;
> +			len =3D em->len;
> +		}
> +
>   		/*
>   		 * At this point, we have a locked page in the page cache for
>   		 * these bytes in the file.  But, we have to make sure they map
>   		 * to this compressed extent on disk.
>   		 */
> -		if (!em || cur < em->start ||
> +		if (!em || cur < start ||
>   		    (cur + fs_info->sectorsize > extent_map_end(em)) ||
>   		    (em->block_start >> SECTOR_SHIFT) !=3D orig_bio->bi_iter.bi_sect=
or) {
>   			free_extent_map(em);
> @@ -526,7 +532,7 @@ static noinline int add_ra_bio_pages(struct inode *i=
node,
>   			}
>   		}
>
> -		add_size =3D min(em->start + em->len, page_end + 1) - cur;
> +		add_size =3D min(start + len, page_end + 1) - cur;
>   		ret =3D bio_add_page(orig_bio, page, add_size, offset_in_page(cur));
>   		if (ret !=3D add_size) {
>   			unlock_extent(tree, cur, page_end, NULL);
>
> ---
> base-commit: 563a50672d8a86ec4b114a4a2f44d6e7ff855f5b
> change-id: 20240710-bug11-a8ac18afb724
>
> Best regards,

