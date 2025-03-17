Return-Path: <linux-btrfs+bounces-12335-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DFFA652A0
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 15:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F0743ACD50
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 14:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636E71DFCB;
	Mon, 17 Mar 2025 14:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQmbZHHp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D44823770C;
	Mon, 17 Mar 2025 14:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742221003; cv=none; b=DRe9r+973hmQZD4ISUNqkrHILAttpNHm4ZTcW8iczBbTXQvWUSisvokApiqu2pgSe8wIo2IdTFqbCXHgwP8K+MTpXS3ZpxNohQ9bBlIPZZRL7/jhmaKl115gBcUG0JdGXyxtfqZBJY7L7xnNS/Tjh/gX4t+4p3GwovWHrn1e100=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742221003; c=relaxed/simple;
	bh=0ilSX9e2BRGSoa04k4V6buK/L3zHxwpAqwF0JBaigfk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ep7eQDeO1BgOBQzz0xMHrD3CM+qP3XzhvYMYtvnw11e4nXooJL82fj3/NqAL0O6xcU6V14YkXQYxOZeCL2TfYyeWNwg5BTDcVYN8lCZLuauZ9Jz2xkWUwkn4L11idnX/3f7hz/3xwf5yhqO0m1nRNDJXKiLqdaVr1GyrNMhvXdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQmbZHHp; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3995ff6b066so911787f8f.3;
        Mon, 17 Mar 2025 07:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742220999; x=1742825799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c27v+fvC8ONOiONTHIvwQnJldmxitxn94mbwD2g2Dgw=;
        b=LQmbZHHpcSXeYOy2WPU8g7E/xxvEPQmjDAFpDFI7JXitHsF3acDJQLb81hO7+wYxd7
         HHSOFExP1sQSpIhZwn8boh7C24xqEwIYF8CPiY41DM7Y1GuTe5OatgXGzn4lmZdtXG7R
         LVaozVXCvGvkdxR5qJYdvVPP4/eU8u1K6I8Xsb5fLCb214rvz+9McM9d6m/A4QDf7PQp
         oQVF5p1V4CQrEwduZSdzq4UxFcb0ijVcPP72TLqx8wVEfAkKokJjN/YK/SYb1dnDrLe1
         ulSSBlZVmlgbkQ5ywIY07OT8NEVamam/ld1cQLnUuPjEh0tRR6DsGLeWXKs3DYb+JuQd
         895w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742220999; x=1742825799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c27v+fvC8ONOiONTHIvwQnJldmxitxn94mbwD2g2Dgw=;
        b=CfkQcXWIMYxGOyCbuko4vs30DCgQJVLNsNeWaiHQCPBYDGuFQiZRsGbmzW0NZykK/S
         0qDK/meKNDgWXlg7aKYmfPUulPmVwS23yyMeKi6BTOuMeOJ2UkoScGtLcD7ZRFMyz/Mn
         4mj/+P3+6r69KXjiM+gf5GLT1rSh5Oqs0w6N5GR6VRjtV8q5VktgMYj+gpToMIHiJPU2
         Tw3eNQRw7Z3lLKqAzvvHzare2iPe8XXYlrTBVVMjUjBaIeyX8FYx7zMaXgRpqlb+PoQG
         wf2kl1Tb9QtjeQcGO7vVDiq64U/oxz970pdb9vnJnpZZmRoj7zESneMKPBCl0jyJbLU7
         eEYw==
X-Forwarded-Encrypted: i=1; AJvYcCU3fPF0259uY0H83pfDRSOSDVGExAd+at7N0rXXIo7bDkfnl4RFdC7FUogGNNvOkV/+iFhj/TvCiWgrIw==@vger.kernel.org, AJvYcCVw1/6M9ExOesXk13lENcIpXLodBO6zBppdNd/RcMYdcF4rseyxzWCqKpylWfy7yRiO33vsbQIZClMNv+eM@vger.kernel.org
X-Gm-Message-State: AOJu0YwWvaQlKJHgo9pU5AObnlKCIs4+wSJe2WIq8kF+6coLHCZxFRVo
	vbjucxBOtPCJjYFunakowSyq7jerWafYrbB2v+2HE57EEi+73ysE
X-Gm-Gg: ASbGncsC2+u0ClMBtjZnTSsYIIAh9RpimKRwUqKDhObkxbX6rW8oOjVrcGfLvz51i/6
	K5qZUJMzNf2R5Za69+hfJWA8aB81BOKs583LFTbF2U+tSn4krVO7f1W8noVCrsQRCXTHXkFfhKo
	ojSbCIdmrDH9Mujgyadqo35lTn8o6RkyrsWmLyKtT0EYUuM2KAOa2J54yDsJSQtXIAoCw8S3lK7
	MKbBk9TWTGhWBMWP93PQ14Ai6Ew0AHGstGyFZYlQAZ/3xIx7xPWRv+iDWWMN+0ODXLboE3I21Sc
	6A0piVe6xMCHj/L4jIJEbfbrVoDIwE5wuH9ph2Sh/QTbHD8i7BP+Yv4o7PB73i42wnc392VDKZz
	5rJQtoME=
X-Google-Smtp-Source: AGHT+IFj3IrRceB74+RXiXiFBoPZDpqrSS8EKJfu0cp/CuW2HsSBA6TromRFP9hqrvnND9IxwoP3bw==
X-Received: by 2002:a5d:6da9:0:b0:38d:e401:fd61 with SMTP id ffacd0b85a97d-39720d47e80mr14523459f8f.49.1742220999418;
        Mon, 17 Mar 2025 07:16:39 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb318afbsm15557735f8f.72.2025.03.17.07.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 07:16:38 -0700 (PDT)
Date: Mon, 17 Mar 2025 14:16:37 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David
 Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>, Arnd Bergmann
 <arnd@arndb.de>, Johannes Thumshirn <johannes.thumshirn@wdc.com>, Filipe
 Manana <fdmanana@suse.com>, Li Zetao <lizetao1@huawei.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org
Subject: Re: [PATCH] btrfs: fix signedness issue in min()
Message-ID: <20250317141637.5ee242ad@pumpkin>
In-Reply-To: <20250314155447.124842-1-arnd@kernel.org>
References: <20250314155447.124842-1-arnd@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Mar 2025 16:54:41 +0100
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> Comparing a u64 to an loff_t causes a warning in min()
> 
> fs/btrfs/extent_io.c: In function 'extent_write_locked_range':
> include/linux/compiler_types.h:557:45: error: call to '__compiletime_assert_588' declared with attribute error: min(folio_pos(folio) + folio_size(folio) - 1, end) signedness error
> fs/btrfs/extent_io.c:2472:27: note: in expansion of macro 'min'
>  2472 |                 cur_end = min(folio_pos(folio) + folio_size(folio) - 1, end);
>       |                           ^~~
> 
> Use min_t() instead.

It would be slightly better to use min_unsigned() since, regardless of the types
involved, it can't discard significant bits.

OTOH the real problem here is that both folio_pos() and folio_size() return signed types.

	David

> 
> Fixes: f286b1c72175 ("btrfs: prepare extent_io.c for future larger folio support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/btrfs/extent_io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index c2451194be66..88bced0bfa51 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2468,7 +2468,7 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
>  			continue;
>  		}
>  
> -		cur_end = min(folio_pos(folio) + folio_size(folio) - 1, end);
> +		cur_end = min_t(u64, folio_pos(folio) + folio_size(folio) - 1, end);
>  		cur_len = cur_end + 1 - cur;
>  
>  		ASSERT(folio_test_locked(folio));


