Return-Path: <linux-btrfs+bounces-4246-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2538A463B
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 02:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D4F41C213EB
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 00:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C549FA38;
	Mon, 15 Apr 2024 00:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Xq5kjU+s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649A9193
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Apr 2024 00:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713139504; cv=none; b=gJDoY9mA1WKQmaaeQrKPKEmJLC37LgZ7HgPdOULFnas9en3w9tE5L5ZvbzLgX75hgYp1IVUDKnBjSq5J63OS9TXlan0UTDnkgoLrGyQoZehByEL7XLshKMSZEmd3ifDGsv7utuHLcgCdNyOxXInb56VfdFGzZGdIfV6JQ2Qz7wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713139504; c=relaxed/simple;
	bh=Cz1LHd5xphWd8ITTkOhdhlaAr2+LwXIBgZc1aORYjD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HFLdWXLlJJIz3rrUy6hXKIVqcsNpCCG/7D33cgzPNjY99XqYem1nHorfWZGRJUicKGjJTUL1KRon1S51x4+B2BJZ+Zw2Wrqpls4rJMfMwpPlETd0P6r/wD+CveOfVbdIhfHgmY57R1i8qKskpWtLUOItSxVlZGc+WfaZ3bUrUts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Xq5kjU+s; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1713139495; x=1713744295; i=quwenruo.btrfs@gmx.com;
	bh=jGt7td4/zioDp92O4OBAtriaBGpWHHtzCGn/wd+l3IA=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=Xq5kjU+sRVwWUMM3YIcZkWfH9OjBtb8QFuXjQgA/13rYoskq25I84RgM/wTcmMD1
	 3LaS8gS02QQBPUSi8rPrQZZhJJg3mV7G2aGpQHIJAFLMb2s0BU1+E9BA+DmPLRs9b
	 IFiD+kr5CGMkqXxtWACtsyz+RjpfHHBNOPYZqkchbqkAfLvOKT3rnT7QLnF7ZCJ8N
	 zQwCuWokeQP+XX1HQUH7jskDqCtvTCdPITudvwsAZ4jP3g+pMuCH9lRp6G7EQC1RZ
	 B1lhisa2hAg1JrdIQpilIDK/Ohes9Ci85iQ646gK7LQk+RRDSCUcz3JhRbqaTfKyt
	 JId3ZIjkoB0V7JbY7w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MatRT-1sU6gP3uJf-00cPx8; Mon, 15
 Apr 2024 02:04:55 +0200
Message-ID: <e8185e90-4145-464d-87f5-6ce57ddd9df8@gmx.com>
Date: Mon, 15 Apr 2024 09:34:49 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: set start on clone before calling
 copy_extent_buffer_full
To: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <cbf5bf79edc537544f383ee3d6c79a1bec45a964.1713100883.git.josef@toxicpanda.com>
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
In-Reply-To: <cbf5bf79edc537544f383ee3d6c79a1bec45a964.1713100883.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BgZ0U2RVfUBHmCrEwMMVDKv+KLGadwQOHBhK4ilq+faC5jPisNq
 ZeImBqWtYpRfFPMrCLv1SrOWQ0QDaQo4BnAtgUhNh3cpR1MM4eySQPWDV2n7kZ+d6XoEdRi
 9yOHdqKGXsgSWYhXOxN4Dz8PdnlSBBvSM/qwmiQmBenF2sygRpkiLDnl6Co0OoArzRsSwYp
 ywS45f8Q+8EvceZaVBs7Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YQwSFUNxZWY=;IsAw69Rn6d4u0PA6TZiy+CX4FUR
 /LKsSOpf1tn+CR7ispGZWF0gjGMSBUouffZVTDb9DloMPA5XhO2tT8uPZUVcPjwVLgC1vsgpO
 PTtyuj4CHe5npf1xAJoEdXw1eG4Q6TqKUXOd+VSaXFQdrTlcKHp9zYkvwouR+Ulbt/uD/Xrft
 VTk/wWprx58bs/HOsi/+v8/0NkG4qz1GAlHdD8yOqblJq/GDpueArTU70gP3KpfvO60INi5Ya
 BoFXR6PjtD7mYZvOe0iM2En3LVTq4SsL7w+fRRZgjImNnvCdGNq5DBo1iANBH3ovPnMyaefQv
 5Wf94mn34BpcRd+KEDM7sSJeTPiBy42DIYYfANzDZWojs6C59Nz0DMlLoN4ghRsBCEBFwixGr
 rceoSFFeh+bPYh1oUv10hOObEKtTVNVnIxABTkaxhtZlVl7YSdipqh/tEPLOVkbfwa9LHu+sm
 TGrTtD4wJ4TWVR9rapCrgFR9BwbFxteT4s96dJQSR9ir3Q8pAEq3TNtHmyd37qqlLHB2DJHLx
 zRZXOCe3GfJo7t28xieWI5yr1EGPE8lnKwRIZCnHVXlZpFUAaBoLBwJfH+8pnx8cuy1kR7YZi
 8OyWXU6SFN1Oi64wfVKfNU/fvy1j85FxBJkfAJHo4qD4pfimcVpjBT2Gt1wxK2db7JU1NFjgd
 MGHVL79OfIGQywdF42vYjmAk5VOgtKoNS6UL/nCWcJXjfWMNZZTnzgoXk1K9Ud81fKeioRfEE
 boZJYuFkD+Re5TK1BBMG3+vz92oC+BywL7vEPQvvY/A9747tTyIbQwV5y+hi5dmNFKYi0NHWH
 oxhc327MeF1XxUlxJpcnEs0VeDTXHWVy6FKODAMcw2JMw=



=E5=9C=A8 2024/4/14 22:52, Josef Bacik =E5=86=99=E9=81=93:
> Our subpage testing started hanging on generic/560 and I bisected it
> down to 1cab1375ba6d ("btrfs: reuse cloned extent buffer during
> fiemap to avoid re-allocations").  This is subtle because we use
> eb->start to figure out where in the folio we're copying to when we're
> subpage, as our ->start may refer to an area inside of the folio.
>
> For example, assume a 16k page size machine with a 4k node size, and
> assume that we already have a cloned extent buffer when we cloned the
> previous search.
>
> copy_extent_buffer_full() will do the following when copying the extent
> buffer path->nodes[0] (src) into cloned (dest):
>
> src->start =3D 8k; // this is the new leaf we're cloning
> cloned->start =3D 4k; // this is left over from the previous clone
>
> src_addr =3D folio_address(src->folios[0]);
> dest_addr =3D folio_address(dest->folios[0]);
>
> memcpy(dest_addr + get_eb_offset_in_folio(dst, 0),
>         src_addr + get_eb_offset_in_folio(src, 0), src->len);
>
> Now get_eb_offset_in_folio() is where the problems occur, because for
> sub-pagesize blocksize we can have multiple eb's per folio, the code for
> this is as follows
>
> size_t get_eb_offset_in_folio(eb, offset) {
> 	return (eb->start + offset & (folio_size(eb->folio[0]) - 1));
> }
>
> So in the above example we are copying into offset 4k inside the folio.
> However once we update cloned->start to 8k to match the src the math for
> get_eb_offset_in_folio() changes, and any subsequent reads (ie
> btrfs_item_key_to_cpu()) will start reading from the offset 8k instead
> of 4k where we copied to, giving us garbage.
>
> Fix this by setting start before we co copy_extent_buffer_full() to make
> sure that we're copying into the same offset inside of the folio that we
> will read from later.
>
> All other sites of copy_extent_buffer_full() are correct because we
> either set ->start beforehand or we simply don't change it in the case
> of the tree-log usage.
>
> With this fix we now pass generic/560 on our subpage tests.
>
> Fixes: 1cab1375ba6d ("btrfs: reuse cloned extent buffer during fiemap to=
 avoid re-allocations")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

I also checked the the related code, personally speaking I'm not a huge
fan using a cloned extent buffer and change its start halfway, nor using
btrfs_path just to hold a single cloned extent buffer.

But since it's a fix, it's fine for now.

Thanks,
Qu

> ---
>   fs/btrfs/extent_io.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 49f7161a6578..a59cd88cf318 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2809,13 +2809,19 @@ static int fiemap_next_leaf_item(struct btrfs_in=
ode *inode, struct btrfs_path *p
>   		goto out;
>   	}
>
> -	/* See the comment at fiemap_search_slot() about why we clone. */
> -	copy_extent_buffer_full(clone, path->nodes[0]);
>   	/*
>   	 * Important to preserve the start field, for the optimizations when
>   	 * checking if extents are shared (see extent_fiemap()).
> +	 *
> +	 * We must set ->start before calling copy_extent_buffer_full().  If w=
e
> +	 * are on sub-pagesize blocksize, we use ->start to determine the offs=
et
> +	 * into the folio where our eb exists, and if we update ->start after
> +	 * the fact then any subsequent reads of the eb may read from a
> +	 * different offset in the folio than where we originally copied into.
>   	 */
>   	clone->start =3D path->nodes[0]->start;
> +	/* See the comment at fiemap_search_slot() about why we clone. */
> +	copy_extent_buffer_full(clone, path->nodes[0]);
>
>   	slot =3D path->slots[0];
>   	btrfs_release_path(path);

