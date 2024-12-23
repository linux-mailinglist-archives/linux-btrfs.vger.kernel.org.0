Return-Path: <linux-btrfs+bounces-10638-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5539FAB3F
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Dec 2024 08:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4143D161197
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Dec 2024 07:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D27118052;
	Mon, 23 Dec 2024 07:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGNVq35c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB9A38385
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Dec 2024 07:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734939755; cv=none; b=iPff4GtJv41rOdhpLfBSrWiOD5vLllatSKz8CO5wsuuG1Wzc19ngJxw6UXUSkPhYPC8MXArbgu4Cc0OVe8Lp/UOHEqHdOzDmAb6Jt9beyPcoFmKLy3wA3a+tx7hzkRd2t2DZnn76Jsz7ITkS+lFqjxArM+qvWXYSAKKSGZW7fkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734939755; c=relaxed/simple;
	bh=vJ5f4dLrmkl+xDDvEqtQFtQ+uXgBErcF2xPJIuqtWzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pcQE1OfXR7su30Glz8kv05budyTIR8+u+ftsiGmjCZ22jVLV90at6u1MYRHZycXxKiFmgx5ubKcB0OGaaX8PFUsOWj+mSiYv5IhaCYRvp5HtJfM6bLZDQLFg9wrW8gQDgv2YxhixfIFu4RqMOP2neb6lj2PgXe1zQMQ8Iia903E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGNVq35c; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5401bd6cdb4so4390586e87.2
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Dec 2024 23:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734939752; x=1735544552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+gOuMcSeZMvNtl/F0QglhyX3waqEL3E7dkjWME7fG4=;
        b=MGNVq35czdMF2MAQ/K0oon1aXoR5Pp31TaFiPpVSHx3SXKGV+jkV2CqBq3iD1GJzTY
         mOSZy10Gir/LZsFz8yUekbZdSqaqFgK5qoe0BVWDV5CnHYNBzUMzHLaPwQ+kZj1yV3kl
         eNHerDmP5y4a8toTrOkm0iO3x9X642nEUQ7N29WePMdlnYUvx+K2QtX/QtkNskq0ZnRc
         8gObY6dYPpot4+rM1Dp9wR7RKAhKd92dDvTQWOOIA0CdKmIVWS+11bfZ9sF3FEIuXCa9
         NGsOayxx/OPmmVXEoaPmqkf38fcIILybPhh1gPfP53UuvL8Kn1AcBj0IyZd4AJuaJBsl
         3q8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734939752; x=1735544552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+gOuMcSeZMvNtl/F0QglhyX3waqEL3E7dkjWME7fG4=;
        b=pNgnZzrH2UMIMcxevuCLYF1+WTC5IDkVSfaGjp6NcvlAhwJPiJ+UWs0gp9Ch3DrQSo
         4lyfkprxeIBNiN9pGSkUlLw99HDnS41C12TedGkaeo++4RNPLtIa5Im8AbtxSRIoNubw
         iquMZuxXK4rY4JXmv64aOo3HpTN4/UkgdQUDLsMCfqK07lFJLFJ+osKKb6PSypPR4Y1r
         da7+MfB/tF5IOxtSglQbPphvhpfjTExseGF3+YbmdQr1QRtKDJeck/krWIc1cKvVgBXM
         yFaI9mFa+zbkWv0As5VSM4SRaFBjweHElL0vyo/L/xiWOKIc3Lbs7dSCfIJFmCUSZb2E
         Exug==
X-Forwarded-Encrypted: i=1; AJvYcCXc7U4k8ErDAijEsB4UvL5JKm23J1Nr7uS82W7/chRjYlxYCmYsBFRvc58VqGCNnw3BEI1XEw2tooOfPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMasumP1TVVJnhM3ABX0VOqVn+jXproum9UJ53pEQ3Ju9cRWH4
	1G89ThGtlRHIMswJO7RL40cwDM1VgdJUf9+gR6PVY7xw5ALvkx6kT/8AE0Dk3qGf7Wfo44DM+Ge
	cJVtgeX1jJnm3tSSaHkbAJ/w3V0M=
X-Gm-Gg: ASbGncvZDayOkByhyb0C9rf6PdJk59ecJ/aeH8bxF+xzlT2NH/xDRI0gr0XJXkTkGSN
	yM+NTIJLu1+z+IfVrE4bWh/XXdQm2NMF4dxTz7zY=
X-Google-Smtp-Source: AGHT+IG8pOog6n+9OoO60mFvOkenorAhmfGxxIu1rvnaO1LynviH3iKljKGy9TTPHvajkdR/eKXOK8WKJxUSHMwwzWM=
X-Received: by 2002:a05:6512:3f20:b0:542:2137:3a2c with SMTP id
 2adb3069b0e04-54229547780mr4454933e87.24.1734939751669; Sun, 22 Dec 2024
 23:42:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <97b4f930-e1bd-43d0-ad00-d201119df33c@scoopta.email>
 <45adaefb-b0fe-4925-bc83-6d1f5f65a6dc@suse.com> <24abfa4c-e56b-4364-a210-f5bfb7c0f40e@gmail.com>
 <a5982710-0e14-4559-82f0-7914a11d1306@gmx.com> <d906fbb8-e268-4dbd-a33a-8ed583942580@gmail.com>
 <48fa5494-33f0-4f2a-882d-ad4fd12c4a63@gmx.com> <93a52b5f-9a87-420e-b52e-81c6d441bcd7@gmail.com>
 <b5f70481-34a1-4d65-a607-a3151009964d@suse.com> <9ae3c85e-6f0b-4e33-85eb-665b3292638e@gmail.com>
 <cfa74363-b310-49f0-b4bf-07a98c1be972@gmx.com> <Z1eonzLzseG2_vny@hungrycats.org>
 <8d4d83e.80527959.193ea7e5d3e@tnonline.net> <e2ca9ceb-4ead-4739-af8b-f37b1a902170@libero.it>
In-Reply-To: <e2ca9ceb-4ead-4739-af8b-f37b1a902170@libero.it>
From: Andrei Borzenkov <arvidjaar@gmail.com>
Date: Mon, 23 Dec 2024 10:42:20 +0300
Message-ID: <CAA91j0VkpOLjRtSjTDLKoT6zwoKmTPZkOZqpkon040zyn=dNiw@mail.gmail.com>
Subject: Re: Proposal for RAID-PN (was Re: Using btrfs raid5/6)
To: kreijack@inwind.it
Cc: Forza <forza@tnonline.net>, Zygo Blaxell <ce3g8jdj@umail.furryterror.org>, 
	Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>, Scoopta <mlist@scoopta.email>, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 22, 2024 at 3:00=E2=80=AFPM Goffredo Baroncelli <kreijack@liber=
o.it> wrote:
>
> On 21/12/2024 19.32, Forza wrote:
> >
> >
> >
> >
> > Hi,
> >
> > Thank you for the detailed explanations and suggestions regarding the w=
rite hole issues in Btrfs RAID5/6. I would like to contribute to this discu=
ssion by proposing an alternative implementation, which I call RAID-PN, an =
extent-based parity scheme that avoids the write hole while addressing the =
shortcomings of the current RAID5/6 implementation.
> >
> >
> > I hope this proposal provides a useful perspective on addressing the wr=
ite hole and improving RAID performance in Btrfs. I welcome feedback on its=
 feasibility and implementation details.
> >
> >
> > ---
> >
> > Proposal: RAID-PN
> >
> > RAID-PN introduces a dynamic parity scheme that uses data sub-extents a=
nd parity extents rather than fixed-width stripes. It eliminates RMW cycles=
, ensures atomic writes, and provides flexible redundancy levels comparable=
 to or exceeding RAID6 and RAID1c4.
> >
> > Design Overview
> >
> > 1. Non-Striped Data and Parity:
> >
> > Data extents are divided into sub-extents based on the pool size. Parit=
y extents are calculated for the current data sub-extents and written atomi=
cally in the same transaction.
> >
> > Each parity extent is independent and immutable, ensuring consistency.
> >
> > Example: A 6-device RAID-P3 setup allocates 3 data sub-extents and 3 pa=
rity extents. This configuration achieves 50% space efficiency while tolera=
ting the same number of device failures as RAID1c4, which only achieves 25%=
 efficiency on 6 devices.

Giving something a pretty name does not really explain how it works.
Can you show an example layout?

...
>
> 5 - let me to add another possible implementation:
>
> The parity is stored inside the extent, at fixed offset. Then the extent =
is written in a striped profile.
>
> 1) map the disks like a striped (non raid) profile: the first block is th=
e first block of the 1st disk, the second block is the 1st block of the 2nd=
 disk... the n block is the 1st block of the n disk, the n+1 block is the 2=
nd block of the first disk...
>
> 2) in the begin of the extent there are the parity blocks, and the parity=
 blocks are at fixed offset (each n blocks); in the example below we assume=
 6 disks, and 3 parity
>
>      if we have to write 1 data block, the extent will contain
>                 {P11, P21, P31,     D1}
>

What happens with the holes? If they can be filled later, we are back
on square one. If not, this is a partial stripe that was mentioned
already.

The challenge with implementing partial stripes is tracking unused
(and unusable) space efficiently. The most straightforward
implementation - only use RAID stripe for one extent. Practically it
means always allocating and freeing space in the units of RAID stripe.
This should not require any on-disk format changes and minimal
allocator changes but can waste space for small extents. Making RAID
strip size smaller than 64K will improve space utilization at the cost
of impacting sequential IO.

Packing multiple small extents in one stripe needs extra metadata to
track still used stripe after some extents are deallocated.

>      if we have to write 2 data block, the extent will contain
>                 {P112, P212, P312,  D1, D2}
>
>      if we have to write 6 data block, the extent will contain:
>                 {P1135, P2135, P3135,  D1, D3, D5,
>                   P1246, P2246, P3246,  D2, D4, D6}
>
>      if we have to write 12 data block, the extent will contain
>                 {P1159,  P2159,  P3159,   D1, D5, D9,
>                   P12610, P22610, P2610,   D2, D6, D10,
>                   P13711, P23711, P33711,  D3, D7, D11,
>                   P14812, P24812, P34812,  D4, D8, D12}
>
> In this way, the number of the extents remain low, and the allocator logi=
c should be the same.
>
> Rewriting in the middle of an extent would be a mess, but as pointed out =
by Zygo, this doesn't happen.
>
>
> > Implementation Considerations
> >
> > RAID-PN requires changes to support sub-extents for data. Parity extent=
s must be tracked and linked to the corresponding data extents/sub-extents.=
.
> >
> >
> > NoCOW files remain problematic. We need to be able to generate parity d=
ata, which is similarly difficult to generating csum, making NoCOW files un=
protected under RAID-PN.
> >
> >
> > Random small I/O is likely to outperform RAID56 due to the lack of RMW =
cycles. Large sequential I/O should perform similarly to RAID56.
> >
> > ---
> >
> >
> >
>
>
> --
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

