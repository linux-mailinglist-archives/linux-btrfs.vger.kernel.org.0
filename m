Return-Path: <linux-btrfs+bounces-18738-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF27C3758C
	for <lists+linux-btrfs@lfdr.de>; Wed, 05 Nov 2025 19:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D6274EBE43
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Nov 2025 18:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8C4280A29;
	Wed,  5 Nov 2025 18:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SjKKMhOk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39EF2BE7B2
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Nov 2025 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367630; cv=none; b=H2F2Z0qg/UeTfhM00fL0ClliWyLMvXqILGOQ/HvBK8W1fS59n9uYb0YlUnfWNHTJ9wcAwN8VVCk5Nwald5EqtyTTF1/2ZeZTr0GLmxaHl2dk0CTFKhNiNYn1Vz6S2BMGuzVewmHdb6xfqrzupCb3aFtIGWtfNdUJYZthA3Lwxxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367630; c=relaxed/simple;
	bh=QdIsCbGU61ikoVL7GQujIgBmKZhEQF493waeOpnzVho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lA9OD5jDD8xqdxKrZiikSH3DsOoNF6qsB0o6/2DrcBFhqQarQwQUaHQI5GOfnRKTrFbqa3rr01+uaTC1lPetAA/E905IFV94g06fBjNc3SAYailct+wpumMhf1IKfvviKvePK/AVgDNmpa5Pk9Ql4Xz+d83t7ganarIPsHelaVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SjKKMhOk; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-429c48e05aeso109356f8f.1
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Nov 2025 10:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762367626; x=1762972426; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xw9BgXv3xuEvlMmxJm1mpqDieF/LQYS6cC55AYGAEG0=;
        b=SjKKMhOkVclgt5wp06tjOozRABfkZ157n3Ix5SYUyCzRY+YcIQn4QR4INg0zTXV7c3
         XQqAs/5SJF8dWArGKQr5D8jX+CBl8EQVU7u+hurVf1xXm1M0uR3lMX+wHxb8vRNPuSPK
         x4WoIBrMnpNbP+QNvjLsL3J8WYSLS2PzrFwkVegZOaDDYG5rYoQY90YxxZe2tqFrcVZ/
         NsAs0WqPGEAVPNGME6r72Hs9paI8xPPjpmqTY97a0odiAAIGcM8+DhblCWihcvFVsiCq
         v42x1ScK1W7eFMjWRS/gnctfipQXCjKwSEDOC/acfQ41eI3++x+s0/1tRNrYLaCQPmfx
         A5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762367626; x=1762972426;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xw9BgXv3xuEvlMmxJm1mpqDieF/LQYS6cC55AYGAEG0=;
        b=HI7YDrGwV6tbDxvcNIr/W9ocQqsosSyi/ZEwQ7YgEjzJ8x2MvS9I+A3cF5fVUIQHq9
         PeMYeA8M8XXWFAIMaFktZE4iAGmiYyyrftiLg8umtqG0xyJ3igsRg/NoHDcFNczOGHRo
         QSG9FWXmWPETil8/y3GcrIB0UC9WxxVHj/Xr7pXhh3+CVjt46cwbAKOc4oF2daxgrVmv
         292cJO3o1iOcD7bo0LSOhxM+kJzKQAIcY/egJ0EfQMMckDcHwq/j0K48wFl76e8KuAfz
         R1AXKXhJ8bB/oIuF+Ocn0RUIm1musm1tvIIpXKNcAu0AxKCW56C7ZGH9wzpda4Ne6PTb
         qunQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGxIC7DWxucwlfztyekR2o2Q25XrAbgpNRuwbnhK39zlyeDhnsHDye+FS0FJ3qoGF391j6lnm3Nk9taw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxKaEzDJ1l3peobxmpZUzfbaSvqOibW9O1StyS5aNH4bs/6ihW
	5qM53o20Z/VlMyy6+eARAverLhe80p9/GoCZ9mUhPZAdF3CgBe7kfbGqRO0ZcIi6SbsfwSiZ3wz
	jlmhsldDCCOZOAFJONrYpDMG5fPGSwJ2C6X1A7Z0jzg==
X-Gm-Gg: ASbGncubCeydiMZLfolICWQVlyaG3dvO+LvxhG0piU9tAcEeaH3mbeWKGdk+wlMRX7I
	lBDUrbUxlJgwTlgFnAMoxeK3gHlw9unmaTbegiuN/mqGoQR52GzdvBwDbm0SCIE8aNL7yPAbZ1J
	lKwYwCjIrq/xLP5W9H6DAyWUQkWoEO25wgn8+4SKqXJDJz0bwz0G8ej27NrLjmQYqYdHl71Pjxx
	5N/fdO/+2N3XehhE/dbPa6J35/e+M9ytht5P7aqm+xc8xXLm+uJbcjjmx0oGW85gJ7gBFpefwDl
	d5ZSm28OCNWS9zuP3GmA4fNy+IsZLivYG/ty91vSngHBvR8xTWPiMPH3PA==
X-Google-Smtp-Source: AGHT+IFCZTc3E2XHwDCl+YRtQQFR97QktfT8RGPDVIDrhNNHjq8LIXQFn/CmjbQ3aTH0Rp5kdEDKiM0TTWzYhWFlzC4=
X-Received: by 2002:a05:6000:1849:b0:426:f9d3:2feb with SMTP id
 ffacd0b85a97d-429eb18aaacmr432745f8f.23.1762367625965; Wed, 05 Nov 2025
 10:33:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104-work-guards-v1-0-5108ac78a171@kernel.org> <20251104-work-guards-v1-5-5108ac78a171@kernel.org>
In-Reply-To: <20251104-work-guards-v1-5-5108ac78a171@kernel.org>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 5 Nov 2025 19:33:35 +0100
X-Gm-Features: AWmQ_bl6PadzQPI3bpD_bJBLSeiXboTP6hljfgJQkUA_P8mn02EqfL9ZuICWSd8
Message-ID: <CAPjX3FeEZd7gX1OeCxRXrdBMafHOONB2WQO_JOZuxKoVEygzuQ@mail.gmail.com>
Subject: Re: [PATCH RFC 5/8] ext4: use super write guard in write_mmp_block()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Nov 2025 at 13:16, Christian Brauner <brauner@kernel.org> wrote:
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/ext4/mmp.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
> index ab1ff51302fb..6f57c181ff77 100644
> --- a/fs/ext4/mmp.c
> +++ b/fs/ext4/mmp.c
> @@ -57,16 +57,12 @@ static int write_mmp_block_thawed(struct super_block *sb,
>
>  static int write_mmp_block(struct super_block *sb, struct buffer_head *bh)
>  {
> -       int err;
> -
>         /*
>          * We protect against freezing so that we don't create dirty buffers
>          * on frozen filesystem.
>          */
> -       sb_start_write(sb);
> -       err = write_mmp_block_thawed(sb, bh);
> -       sb_end_write(sb);
> -       return err;
> +       scoped_guard(super_write, sb)
> +               return write_mmp_block_thawed(sb, bh);

Why the scoped_guard here? Should the simple guard(super_write)(sb) be
just as fine here?

--nX

>  }
>
>  /*
>
> --
> 2.47.3
>
>

