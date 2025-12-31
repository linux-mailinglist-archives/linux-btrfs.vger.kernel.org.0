Return-Path: <linux-btrfs+bounces-20043-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE678CEB2FF
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Dec 2025 04:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7E11301A1BB
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Dec 2025 03:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAC227AC54;
	Wed, 31 Dec 2025 03:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b="C5GLj/Ib"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610C181ACA
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Dec 2025 03:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767151774; cv=none; b=mwkz24NPTvtI9cuu9DFdxDALVy65gLUwlvbi8jEgiN4YY/DgMvQyuc5aC0lVgt5VhBIHRbuTC10SMuCX0+vFDSHoFvCSqiNKrTcKZZflzzpmUZXGaVItpq6VGe26J03wJDpPI6OstkeAmEQRysyCuuW1B61c/hjDcCBC+wFGLU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767151774; c=relaxed/simple;
	bh=FUWNh/5USFJVyFMB8cd+IQmb8lMJXdQe4wT4iDgdXb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VENkca5P5EQA4NGDRniEVvYKmtg1N14aozVck26hneH0csJgh07HpXAMbR3nA4hJ0bIx9vF8XbtPbW2M880ipnTmTEkQPtnXilxhRAZ6H7RblJQyNCm36EyZRuaUcJfq3S80e/5boZYqlD+hmT9EsvDUtOE5RnWQ3LkWV1F4hZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org; spf=pass smtp.mailfrom=quora.org; dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b=C5GLj/Ib; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quora.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7f1243792f2so7026169b3a.1
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Dec 2025 19:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quora.org; s=google; t=1767151773; x=1767756573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G67kP4OfpSHo7OALeELs+cnY6p+mrOe1CzAdcBKGxJg=;
        b=C5GLj/Ib1049RwMxW6Bmp6w46s9b0h7hoaa/uWsX/S7WEGcAd/nDZnDdHpaGI92Y/W
         Rl6UcHTMuwVa28wK3iMlsquBqYQdw8N3R7mA8vmr0sIODIK8KFZsjQ0N50zc0uxZp0yS
         BiJO3oVfWCI1cfKwExswJ5ORHrwNA/0z79UiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767151773; x=1767756573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G67kP4OfpSHo7OALeELs+cnY6p+mrOe1CzAdcBKGxJg=;
        b=l+Cvc0nkVIUQ8aaYJdMtHtgp51v48A9ZDbXKZoVbKqxXtJNKgRagAmL+++/UxNatiz
         nMjjF0Ho5qbPkcJ2NY7K4KNAVLaX1p3DY9WfpBUGhh6uhX6UwSG5TQSIpJKvBs+RAjxi
         /KJbC+97yxjC1BI1W3csTe7/Fyk7aH6mI7j1+2v5o5XMM5sYEgPVd+M7nJz/oeS/iCIa
         QdNovFUCEtLY2WWCTESlKmF4WHJlPrC/HK/nI8tCZHw/9uk2eDZsx6ZmWzJUJUtH3Cen
         VkA2zY8lkEpp2BdZ6jwW3+4P0Dbfhpww14nWcFH7Ly2yTELvrKKUme//BSv3Kov5Wti/
         kyqg==
X-Forwarded-Encrypted: i=1; AJvYcCWqeeaGTNhEXXtnz2MaRwlDToe+VzLdaDYkiIIeTCMHEKI67bkBLukcvvx3LnSZJeurLqdyjuwH8smD4w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+TTdY99vSou+tHHk2JXBe8CbeP9eHVPGGqZDEjL00PcK+Fsqq
	cz6VHszk5SqeCtAe2j2JFs5d70EwAciDs/6TdP7PgXPwtjrF+A7wQe9ob2zf0kg2S05UBQeUkRt
	cagAxIgtytAiixUqJj2JjJ3dnLmiL3nFPfigRNTx1GA==
X-Gm-Gg: AY/fxX74BN0dOxyLIL8Rk1CuKbJyFvP6yegy/H0YIaJbTaeuArh2qcTN+lB5Nv0a2Or
	p0dgRA9pP+Jdb1AecEox94OE2rxfaoVVZy9d5i7OwrnDa1iC/MknhSEk/Jx9A/0k8WAGhZ7ZYE6
	4Eluip5gwxz8EKuSCC2Nob1z2/+ycZ/N/FBWo3hZy1KWY73nHbIuGfGzZH+32p6oUTxfEmiASLu
	IoAmd+RGAE6x0r4It5+v7Qy8w6CfqYZMFEfRinx3qtntI9KMSutWWSH/siPpLlDW1eWotxGJV00
	CEAqQ5VEw8MAc5sHFurMWl746Q7v9oMB045DhlR5MiJhUU+eJjz12SFznj4f8pVYQeShHGXT3iV
	c/TC1wIceRld0UyG70i+eVlL045D5Jm1Ahz5nYw7nIS1Vwpu4iHSs9HGek1AE07uRCTaUWyHMXz
	ceZ1yqRfiAYWAJcdjUmQQE8IX7hjkZ+ELJyp4O
X-Google-Smtp-Source: AGHT+IFBZRVcxGLTGWxMS4UwhBBlidjXf0waQm1UjqTuUpn5WDs9/I39O8HqjrVHvmgaGKiBM2FMfXOwCxGzXAaIxK4=
X-Received: by 2002:a05:6a20:2584:b0:35f:b243:46cb with SMTP id
 adf61e73a8af0-376a75e793dmr34924153637.12.1767151772779; Tue, 30 Dec 2025
 19:29:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMVG2svM0G-=OZidTONdP6V7AjKiLLLYgwjZZC_fU7_pWa=zXQ@mail.gmail.com>
 <01d84dae-1354-4cd5-97ce-4b64a396316a@suse.com> <642a3e9a-f3f1-4673-8e06-d997b342e96b@suse.com>
In-Reply-To: <642a3e9a-f3f1-4673-8e06-d997b342e96b@suse.com>
From: Daniel J Blueman <daniel@quora.org>
Date: Wed, 31 Dec 2025 11:29:21 +0800
X-Gm-Features: AQt7F2ofFVt5VnckQkFFfjA_Gx7RA7HP0MVRsu_4qEI5AFJmBtF9jr5EQ6Eq6FI
Message-ID: <CAMVG2suYnp-D9EX0dHB5daYOLT++v_kvyY8wV-r6g36T6DZhzg@mail.gmail.com>
Subject: Re: [6.19-rc3] xxhash invalid access during BTRFS mount
To: Qu Wenruo <wqu@suse.com>
Cc: David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, 
	Linux BTRFS <linux-btrfs@vger.kernel.org>, linux-crypto@vger.kernel.org, 
	Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Dec 2025 at 17:28, Qu Wenruo <wqu@suse.com> wrote:
> =E5=9C=A8 2025/12/30 19:26, Qu Wenruo =E5=86=99=E9=81=93:
> > =E5=9C=A8 2025/12/30 18:02, Daniel J Blueman =E5=86=99=E9=81=93:
> >> When mounting a BTRFS filesystem on 6.19-rc3 on ARM64 using xxhash
> >> checksumming and KASAN, I see invalid access:
> >
> > Mind to share the page size? As aarch64 has 3 different supported pages
> > size (4K, 16K, 64K).
> >
> > I'll give it a try on that branch. Although on my rc1 based development
> > branch it looks OK so far.
>
> Tried both 4K and 64K page size with KASAN enabled, all on 6.19-rc3 tag,
> no reproduce on newly created fs with xxhash.
>
> My environment is aarch64 VM on Orion O6 board.
>
> The xxhash implementation is the same xxhash64-generic:
>
> [   17.035933] BTRFS: device fsid 260364b9-d059-410c-92de-56243c346d6d
> devid 1 transid 8 /dev/mapper/test-scratch1 (253:2) scanned by mount (629=
)
> [   17.038033] BTRFS info (device dm-2): first mount of filesystem
> 260364b9-d059-410c-92de-56243c346d6d
> [   17.038645] BTRFS info (device dm-2): using xxhash64
> (xxhash64-generic) checksum algorithm
> [   17.041303] BTRFS info (device dm-2): checking UUID tree
> [   17.041390] BTRFS info (device dm-2): turning on async discard
> [   17.041393] BTRFS info (device dm-2): enabling free space tree
> [   19.032109] BTRFS info (device dm-2): last unmount of filesystem
> 260364b9-d059-410c-92de-56243c346d6d
>
> So there maybe something else involved, either related to the fs or the
> hardware.

Thanks for checking Wenruo!

With KASAN_GENERIC or KASAN_HW_TAGS, I don't see "kasan:
KernelAddressSanitizer initialized", so please ensure you are using
KASAN_SW_TAGS, KASAN_OUTLINE and 4KB pages. Full config at
https://gist.github.com/dblueman/cb4113f2cf880520081cf3f7c8dae13f

Also ensure your mount options resolve similar to
"rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,subvoli=
d=3D5,subvol=3D/".

Failing that, let me know of any significant filesystem differences from:
# btrfs inspect-internal dump-super /dev/nvme0n1p5
superblock: bytenr=3D65536, device=3D/dev/nvme0n1p5
---------------------------------------------------------
csum_type        1 (xxhash64)
csum_size        8
csum            0x97ec1a3695ae35d0 [match]
bytenr            65536
flags            0x1
            ( WRITTEN )
magic            _BHRfS_M [match]
fsid            f99f2753-0283-4f93-8f5d-7a9f59f148cc
metadata_uuid        00000000-0000-0000-0000-000000000000
label
generation        34305
root            586579968
sys_array_size        129
chunk_root_generation    33351
root_level        0
chunk_root        19357892608
chunk_root_level    0
log_root        0
log_root_transid (deprecated)    0
log_root_level        0
total_bytes        83886080000
bytes_used        14462930944
sectorsize        4096
nodesize        16384
leafsize (deprecated)    16384
stripesize        4096
root_dir        6
num_devices        1
compat_flags        0x0
compat_ro_flags        0x3
            ( FREE_SPACE_TREE |
              FREE_SPACE_TREE_VALID )
incompat_flags        0x361
            ( MIXED_BACKREF |
              BIG_METADATA |
              EXTENDED_IREF |
              SKINNY_METADATA |
              NO_HOLES )
cache_generation    0
uuid_tree_generation    34305
dev_item.uuid        86166b5f-2258-4ab9-aac6-0d0e37ffbdb6
dev_item.fsid        f99f2753-0283-4f93-8f5d-7a9f59f148cc [match]
dev_item.type        0
dev_item.total_bytes    83886080000
dev_item.bytes_used    22624075776
dev_item.io_align    4096
dev_item.io_width    4096
dev_item.sector_size    4096
dev_item.devid        1
dev_item.dev_group    0
dev_item.seek_speed    0
dev_item.bandwidth    0
dev_item.generation    0

Thanks,
  Dan
--
Daniel J Blueman

