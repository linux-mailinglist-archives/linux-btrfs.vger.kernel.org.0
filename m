Return-Path: <linux-btrfs+bounces-11876-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E327CA461FD
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 15:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F33843AE050
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 14:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CE422157F;
	Wed, 26 Feb 2025 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRb74Edi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C83C1F8908;
	Wed, 26 Feb 2025 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579214; cv=none; b=s8A9b6285XMoMxJ9bGskNUAORQF1lW/8wY03j8qzwzmqROCNffMa7fVbW0/TFnQxEIDpThXLTPvPxwvV3LqPRaPZiJW678XratnL8hNnUHWR1Shc/f5LOQQQOJIcjw6vQGS4Xx2w7iCXfPO7eqSVcudNpuZS4dm/VlF6pInIUkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579214; c=relaxed/simple;
	bh=sF+wrjoqh7eS2eosvwwxS9kfFbryi7H+R+0xBrcNTwY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pUKvTcK7TFjwkhZdVtkbVtRaX8BYcM+bWBlMJQBAuNY1CsDtLLdEowPHgz0Rb4TH4NRuUUSWlWaHRFueU2cYjAybnAZ7xnFRqF6ypffFdHP5diYP34tdtdpTHjonBci0KS8lh8HKTzdEDjcwB7bLa63Rf9uteZ6VHqP/Ef2SllQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRb74Edi; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38f3ac22948so3618327f8f.0;
        Wed, 26 Feb 2025 06:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740579211; x=1741184011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXi+eUzL7kkJHbA3feNPv6qZ/m6EwXmdoOaHeEp4SMA=;
        b=FRb74Edi+y/gTpxXT2574WpVWgdXBC5IvY9vtECyVbogBSdPdIUqYsq46k4NFCj9Lp
         tmRaCsFz9T5F+vY7Jlo0KA506foUQG0uQXAJ/XTFdc0y+iXGuxcVaODqO4r0lP92lV/p
         3GjUvLrDxbkc4zRPg0MNwzkmOQ1WFWZe5TqRJCe1YOZ/KqRJaY0tTiDSfcyuJhuaVu6+
         02M2edbNL3eEwaXZkHW2KJnW8Sxstm4ShBWB79c5eCzRyIYJtAVNnwm6lUKllijNMfxy
         6xjgLUpPrIobTZ4GNSVaWCoanRDQ7xm6Sdq+6ALoognroeT4qm+XuQQI9ty+YN0C43fw
         h/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740579211; x=1741184011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXi+eUzL7kkJHbA3feNPv6qZ/m6EwXmdoOaHeEp4SMA=;
        b=hYCEzPZMyOdDF3DVoYf2nQSCqDPkTxAsMYBx3oC+ltaYb3D4w5XLP4IKoaUCZzvgVu
         UTn693wae0WoBfovzMsukaYqiF6LoeRX5MasuciwDKdFmmzu1Gqf+/JcubYMEz2kzkJg
         7+yIZUno/Fyc+bDQTFf0EwqbP4KquGAO7GPAERUYzsUax78iZ818qEAKwjhneQ2UATv4
         4XPr9byaRo1J8VOnxowV/AEvIt/I8g+R2vjXjfxpQyChdFzxh1LQW4TTGA1KF51FREym
         oYau0sBCvCFZ+OWtTfns7oc5dzoXL6zsMmBRrovxLO1pBSO7A4/Bvp7zSZs96pYVz44k
         cAZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrrVBTK1uNfBT1B7xev3584MXxfxnmXsVxH1w+GWV0hqOZpb+UIs2yx5eu+FNy9E6NjUmN1CUhIF4wrIiI@vger.kernel.org, AJvYcCWbemc6x60eEEgLlUIy2+MwpFA8WjA6FTWkuGCtItV+bINmlUkSwdVbiuMgnyxKwEbuKzibRPqP+ViXUA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQOf0Ja1K7p1Wnj+JeVXr2QI/bnTPefRLIWlC/dHTwi4V5ff2N
	8DsQlGeDD8GmL7K46NYzZmrhMTaj+SLF++vPeW4gNIP0yhXXVNE4
X-Gm-Gg: ASbGncuQb69CAj7PMFRFm4SDCMQy2c/XCF6dODBXQ1Uj5PNxQiUdFRoj75uL/C8r9yN
	eveocbJrkFHgFJ+p85Jqk2YbsvAF4eVKlAJkwj+KAE6IVQmR1cbOextD9KBKa9itKNsT3ifD5NQ
	SiSzjnmzELz4uEzsPn8/TlX6tPo8ewnwRia3WDAeCisTwTbDhnnle3I1YV8OVaNWgDKtChEZb5V
	1izfDdbTpieRbqEHdqKO/A5/jBNzEkTF8kfGsLWckCGvjT1cTqPiiPZu/uosi7+CCJT3N0D5j7Z
	6YJc6s7DMVZlZwKKcfz2Yw98DlnICNhIRa+Q25wwWFHwE/RkfylUOthUxV4IGpvG
X-Google-Smtp-Source: AGHT+IERgDII+QzJfQCdxmEiU11JLMf4j5Itf9olIlCQol2DM9XddoJiIukJUn84pxF63XXvFAVL5A==
X-Received: by 2002:a5d:5f53:0:b0:38f:3b9b:6f91 with SMTP id ffacd0b85a97d-390cc60293cmr5354277f8f.12.1740579210344;
        Wed, 26 Feb 2025 06:13:30 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390de5a5b5esm1091851f8f.89.2025.02.26.06.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 06:13:29 -0800 (PST)
Date: Wed, 26 Feb 2025 14:13:28 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David
 Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>, Arnd Bergmann
 <arnd@arndb.de>, kernel test robot <lkp@intel.com>, Johannes Thumshirn
 <johannes.thumshirn@wdc.com>, Anand Jain <anand.jain@oracle.com>, Filipe
 Manana <fdmanana@suse.com>, Li Zetao <lizetao1@huawei.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: use min_t() for mismatched type comparison
Message-ID: <20250226141328.76239d58@pumpkin>
In-Reply-To: <20250225194416.3076650-1-arnd@kernel.org>
References: <20250225194416.3076650-1-arnd@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Feb 2025 20:44:10 +0100
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> loff_t is a signed type, so using min() to compare it against a u64
> causes a compiler warning:
> 
> fs/btrfs/extent_io.c:2497:13: error: call to '__compiletime_assert_728' declared with 'error' attribute: min(folio_pos(folio) + folio_size(folio) - 1, end) signedness error
>  2497 |                 cur_end = min(folio_pos(folio) + folio_size(folio) - 1, end);

Isn't the actual problem that folio_pos() has the wrong return type.
I can't remember what loff_t is supposed to be for, but here you want
something that reduces to 'unsigned long'.

> Use min_t() instead.

If a signed variable is known to contain a non-negative value then
min_unsigned() is better.
In particular it will never discard upper bits.

Enough min_t() cause bugs (usually due to high bits being discarded when the
type of the destination (eg u8) is used) that is is tempting to start a 'duck shoot'
season against them.

> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202502211908.aCcQQyEY-lkp@intel.com/
> Fixes: aba063bf9336 ("btrfs: prepare extent_io.c for future larger folio support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/btrfs/extent_io.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index f0a1da40d641..7dc996e7e249 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2485,7 +2485,7 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
>  		 * code is just in case, but shouldn't actually be run.
>  		 */
>  		if (IS_ERR(folio)) {
> -			cur_end = min(round_down(cur, PAGE_SIZE) + PAGE_SIZE - 1, end);
> +			cur_end = min_t(u64, round_down(cur, PAGE_SIZE) + PAGE_SIZE - 1, end);

That one is fine and doesn't need changing.

>  			cur_len = cur_end + 1 - cur;
>  			btrfs_mark_ordered_io_finished(BTRFS_I(inode), NULL,
>  						       cur, cur_len, false);
> @@ -2494,7 +2494,7 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
>  			continue;
>  		}
>  
> -		cur_end = min(folio_pos(folio) + folio_size(folio) - 1, end);
> +		cur_end = min_t(u64, folio_pos(folio) + folio_size(folio) - 1, end);

A subtle alternative to min_unsigned() is to change the 1 to 1ull.

	David

>  		cur_len = cur_end + 1 - cur;
>  
>  		ASSERT(folio_test_locked(folio));


