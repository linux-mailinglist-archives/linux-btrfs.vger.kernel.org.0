Return-Path: <linux-btrfs+bounces-13010-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90017A88E23
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 23:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C57F11898477
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 21:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6711F3B8A;
	Mon, 14 Apr 2025 21:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="B1RceNSn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BDF1F30C4
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 21:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667150; cv=none; b=LBAhp3Vo0eEMHg0NfItjGDaAr8rArAUhw7AtoK9TOIRCzQNzGKGv7px6mmG3c6ebCHWWLWxllGSs384QDLlGFx0244J6vymuHLbVwj/nckZ961MhrZNN3pgeQBRh3OiVCZs0IZwTat8UiFYKWuvUdJLtHEjMXW2hZMO8zH2ud3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667150; c=relaxed/simple;
	bh=9Wfaj8YUCfPcuz4680kf6S/JqXbtleSPcsTBz7MnfAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V29J/9HZwIped1tMZeJhJ/j5djmw1KEsp6i9uTYo52mruIBzrH4pDhITR+AXyAN0GMUMkGY8h7KHDAK/6nP5XukwBL0LlbvvsbwhQ5R+FvxBiK7HQ8CegKpSE6Si1HDM/SUqvjnoOewXitZa7OfvxPquCVy5K5pAyzBCnBJemz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=B1RceNSn; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1744667146; x=1745271946; i=quwenruo.btrfs@gmx.com;
	bh=NCdmsJhenSd2GQE9G838MEakIHm/162hsIdeb0cRh9s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=B1RceNSn1HONO9oWzcvxtpPZ8si+bJHoqEkSScxE+5h+hFd9FVV26QhnZ4q4ub3K
	 dD2MT+NOdk6Ueez+WvhpDCexgoy6oGstBtDIO0YOWgIjRczSzkOkIfNUruRUhbKtK
	 e9xV/UqaAUWWf4OEFhRJ/r3f2N/g3G8+RqQ5f3qdmPgcod8iH+Nz1pA9c34VPBUFC
	 0QaXBfsuXOhNX1Vmv/i1aYVkOGX3P0ElfT2TCnzJDvtOnaLRzsJUaIPH3dhFG1P1S
	 G3gPXBNnkz5GpIKIoIzG2G12xCD+lEOELTyyyucPQ/SXvWQ6esV24w6gbloFtxndE
	 CBO0Nhh25n/eidKYjA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8GMq-1t0Qsj1zKi-017wYM; Mon, 14
 Apr 2025 23:45:45 +0200
Message-ID: <e13cf6fa-edd2-454f-8635-da8559b97ccc@gmx.com>
Date: Tue, 15 Apr 2025 07:15:42 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix race in subpage sync writeback handling
To: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <ff2b56ecb70e4db53de11a019530c768a24f48f1.1744659146.git.josef@toxicpanda.com>
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
In-Reply-To: <ff2b56ecb70e4db53de11a019530c768a24f48f1.1744659146.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0wXJsJh5pcJQYJ2gE6w3JYFZ4u0UFe/50/fvpUeBLFOrLSJwQsL
 6NpXAb1BCyC1wrkxCQz868Cv7ulbJk53gXyfmhkecA6ZSOZQp085vtvw56OwoUql1mdWLgN
 wlCUdZRsyEI0yh8yaFjcrCbEG9ll2rRHqGNAybrpzxPBMj4TIU0C0YqO6rsgEPff0VFuMAx
 wRtexshIjeSlugzhnOLGQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:p9TD5YX0zF4=;A6RV+NYqU4/JBnuIop1FwkoF10e
 SOZIfJSiNjALExmykn34lQ54ne0cZR+EiwnRlWMCL1BW3lTJmZMF4SfluvLWF8opjTyEb8SiV
 tvIDkSB8msGLUm7FD3VbGouZZrVaduyGdNX476vJtAElnzTEgl3Uee9px/2vzO/T+YGoX3jP2
 YMxRH2O68gdBlWR5+SGIkvr9CUh0HkmF5UiJ789qJf6qvTAuPJLtN7imaXx6864kBmLn/7VFq
 ldMQGEZyfvDwDcDnodIjqSSFGe78h3XLfcswBWZQWnlNsl0ToFVFOHdHetXPx0k1AtgcPWtyt
 V6U1W2ccsIyENAbGx4Wt9X8ViOEOLUzxxtVNgqt4WXXjDM5gB/Fkip+nSKyKfIJpsUG1dMorg
 tiKrQ/i7mCpSDaGZKOQ8fz+cL2yjytlnWatu4jqPZg0ZkHD7PHA29JM5Eqp98n+SoepiAVMvc
 r4+Tra51GKwb643oSmGQciyW5nmICQ/+4SQpSNKTTKnCCRbFOCLj/OSbna1cug9sduNedzonP
 nZ2HKyaHHsewg3cgrk2Ejm0us7ThNBCCDplJAp2M4hoNPl+OHsZNkh5mOCUMT5RZESDqkanuk
 CDODJfd+wlNM4FUyb46JKJGNOCsSMbT6sBxSvTqergaJMlmCwQDe9pXZv+r/m80O/d/rsVhCL
 /Bk1P2uxrhDhU/veiR51ueYRotpy8ipXhVArul4S0qOgB1m8emIFDyyE7khv58k0X6VeUcjU1
 2fVEJubSbvPjHQipPcucH/j179BKHXWNpHULzLJ7EXhEmjuJjQ55LWWkUzloKlcxO9IdZ0KaW
 OGSiG525wjUHEHOFj4QRMcc9+o7rWnRYVoOCkaTjG1O1ivG37081ybwJ0DNKlc9k87kjLLsje
 dLYlgS15rIUbOB/O3pIoiDF/NvdMOfsosgdHZM3583y8/eeuoZfmWTGXrtvK3oV1PyXQpLHnR
 A2rzl/gIYSNf5lDe+PljppMzzc3wii8cETsghs7Rc8oIAqWYFr8nfjbhzGuo9Gplo5DRIaweV
 rusVTA8viU1K0FDXnZuiYwnb/swor1g9ZELClhyxYKzYbc4AdhBMZhIB7uDt/tfmMFbSEQpiS
 X/R5Q720/oMVZONsPmWt035uBFUwfGoKg9YlJt+c88yrTQmGpNzK2cxjclclVZ1yQbw1iCa1q
 9CvGe/A8N7Sf7FFDzXuCzgm2xNlAdtHLZ1wo2/ERZ5piRtIFxAA9GmiNBOT3YhNoNytC2ibyy
 77TcZfMeRv6xuCGlGZo33hL7tgJI2hKy2S+oT3wAAIbLax6FmyeT7INHcJXCHOoiuaMYPN3no
 EBwWwyM8XdjBdCs/i1npsdZI63PGfUOdF76/w0sK1r2Bh4+C/1n4k0RAePICM5AwuIv/OQlxD
 eYUPf1mgpvQ+5IvRl0cB3n53qqfrlNi64B2PhbpN08gwcJhBFlnVT//WRFTuyiYMoejxeqL3A
 jrYA9pA==



=E5=9C=A8 2025/4/15 05:02, Josef Bacik =E5=86=99=E9=81=93:
> While debugging a fs corruption with subpage we noticed a potential race
> in how we do tagging for writeback.  Boris came up with the following
> diagram to describe the race potential
>=20
> EB1                                                       EB2
> btree_write_cache_pages
>    tag_pages_for_writeback
>    filemap_get_folios_tag(TOWRITE)
>    submit_eb_page
>      submit_eb_subpage
>        for eb in folio:
>          write_one_eb
>                                                            set_extent_bu=
ffer_dirty
>                                                            btrfs_meta_fo=
lio_set_dirty
>                                                            ...
>                                                            filemap_fdata=
write_range
>                                                              btree_write=
_cache_pages
>                                                              tag_pages_f=
or_writeback
>            folio_lock
>            btrfs_meta_folio_clear_dirty
>            btrfs_meta_folio_set_writeback // clear TOWRITE
>            folio_unlock
>                                                              filemap_get=
_folios_tag(TOWRITE) //missed
>=20
> The problem here is that we'll call folio_start_writeback() the first
> time we initiate writeback on one extent buffer, if we happened to dirty
> the extent buffer behind the one we were currently writing in the first
> task, and race in as described above, we would miss the TOWRITE tag as
> it would have been cleared, and we will never initiate writeback on that
> EB.
>=20
> This is kind of complicated for us, the best thing to do here is to
> simply leave the TOWRITE tag in place, and only clear it if we aren't
> dirty after we finish processing all the eb's in the folio.
>=20
> Fixes: c4aec299fa8f ("btrfs: introduce submit_eb_subpage() to submit a s=
ubpage metadata page")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/extent_io.c | 23 +++++++++++++++++++++++
>   fs/btrfs/subpage.c   |  2 +-
>   2 files changed, 24 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 6cfd286b8bbc..5d09a47c1c28 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2063,6 +2063,29 @@ static int submit_eb_subpage(struct folio *folio,=
 struct writeback_control *wbc)
>   		}
>   		free_extent_buffer(eb);
>   	}
> +	/*
> +	 * Normally folio_start_writeback() will clear TAG_TOWRITE, but for
> +	 * subpage we use __folio_start_writeback(folio, true), which keeps it
> +	 * from clearing TOWRITE.  This is because we walk the bitmap and
> +	 * process each eb one at a time, and then locking the folio when we
> +	 * process the eb.  We could have somebody dirty behind us, and then
> +	 * subsequently mark this range as TOWRITE.  In that case we must not
> +	 * clear TOWRITE or we will skip writing back the dirty folio.
> +	 *
> +	 * So here lock the folio, if it is clean we know we are done with it,
> +	 * and we can clear TOWRITE.
> +	 */
> +	folio_lock(folio);
> +	if (!folio_test_dirty(folio)) {
> +		XA_STATE(xas, &folio->mapping->i_pages, folio_index(folio));
> +		unsigned long flags;
> +
> +		xas_lock_irqsave(&xas, flags);
> +		xas_load(&xas);
> +		xas_clear_mark(&xas, PAGECACHE_TAG_TOWRITE);
> +		xas_unlock_irqrestore(&xas, flags);
> +	}
> +	folio_unlock(folio);
>   	return submitted;
>   }
>  =20
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index d4f019233493..53140a9dad9d 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -454,7 +454,7 @@ void btrfs_subpage_set_writeback(const struct btrfs_=
fs_info *fs_info,
>   	spin_lock_irqsave(&subpage->lock, flags);
>   	bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bi=
ts);
>   	if (!folio_test_writeback(folio))
> -		folio_start_writeback(folio);
> +		__folio_start_writeback(folio, true);

This looks a little dangerous to me, as for data writeback we rely on=20
folio_start_writeback() to clear the TOWRITE tag before this change.

Can we do a test on the dirty bitmap and only call clear TOWRITE tag=20
when there is no dirty blocks?

(This also means, we must clear the folio dirty before start writeback,=20
there are some exceptions that needs to be addressed)

By that, we do not need the manual tag handling in submit_eb_subpage().

Thanks,
Qu

>   	spin_unlock_irqrestore(&subpage->lock, flags);
>   }
>  =20


