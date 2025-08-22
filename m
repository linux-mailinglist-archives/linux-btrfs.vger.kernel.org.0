Return-Path: <linux-btrfs+bounces-16302-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1B5B31FE6
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 18:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF7F6827E1
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 15:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C17221A428;
	Fri, 22 Aug 2025 15:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="Ck8AGqnU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015C520FAA4
	for <linux-btrfs@vger.kernel.org>; Fri, 22 Aug 2025 15:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755878058; cv=none; b=PLfdC0M2S0+K5TTXYB61zOdChHriq+VeQKLTNwJLKL35IJuTEu6ZrO7sinia7TG4oHAWsV/LCg/yTNMQ2OSRVqt6oHD3RMoF5s2aCA05jy5lItYuJxdfNDPBClBjN8eFR5HXtfVO7BXi42rsxH/miCjvrJc5hjV/VIlQxP9BG4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755878058; c=relaxed/simple;
	bh=E8IPpbz4CqvSwDJYcSuyd5RflZNdftOYlnNwRQVksa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+RlLMQg9uQA8JxG1lxiwXrEcljTHDduyaH04AY7+fScmTvVftRDTagm8F+Kd+UWyZ737op7uBIUZ2gR3gdzRD6L2CkorZos0u4h22SeyzT06xgWwjcPpISKWPP7AjNjFPlEdl/mWbslDXtMMoBBPy3OJXdDwmCSWsSmKIIweys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=Ck8AGqnU; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e2ea6ccb7so1861875b3a.2
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Aug 2025 08:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1755878056; x=1756482856; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aFSKEiFb2/LkRiYnMxR7soDvPVRVjcdcP0MBXJaSzfY=;
        b=Ck8AGqnU/jK4pMQKogIA8JOIMAsy0fhNKIr3LJqGIQ6w/Tz2Ib3pQnWWU6IZq6uiSQ
         uc7xHGXYsQ999g37nEn0lHJdnsLbz9JuIoBVKC5IpUnchnaJE6xNZz7RQRiXBCUjNBKj
         bkFt30UeQDB8zV3DccBguyHvtTrvAUJVZQy7bNDnng7yOFm7+vRHIPahp7cQQNiQ1HOk
         SV8YOhAS6dV1NN/8PlcOgE2MuM8nYDtbMkY4JzniQPu633iauQMnaRc//AHC0bh09gs0
         o0Z95onRNyTDVyfBfirdalFfUrTXT4KVtbu+LRSSdIIEHljNaLkzAZfzNs7lyN5ECEBW
         4afg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755878056; x=1756482856;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aFSKEiFb2/LkRiYnMxR7soDvPVRVjcdcP0MBXJaSzfY=;
        b=SUL3kmEhCJplpQu2AGjlyb3SS7Ekh2fEZolX2+OGm9kfy/JuBytPceDX1Pe0KL0LNK
         Glum3Vts8wtzRfdfyeFgBBmbJD+3Tsb6UsQUU64riK9f73yM+qS7zT1tF1HvWlR+Digh
         VT6vXtpm5fe9R5WUY6sWhNIZIcA3MX48d4WpJ1WTLS22U3XlvVJaups/+AUsgPb0tbq8
         o9wRVLlt9WqgSZCW/5d88eFjbxRMiKGNBcI2XI8uVshotMisFy/09cTt71ac0yxw0v/R
         FCk70A7rP9g4T6gy4vg4U+6YEdqjq+ANmGxqPao7W+V+TccR4Qbq3EFLmDTu/3cIxcej
         G17Q==
X-Forwarded-Encrypted: i=1; AJvYcCVg/z408uDtI5lpAwUWQQy9EgbgiVo6F4YC612VCEQfaKP7YOpPwK6jxrJHb+FUOFWcVXn5YtgAiAsiJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyTbHYtgrKqM32uDBofqOZGSIdwcHbAUrRt9JQd5jzSFjyP5vx
	tofzgUODtSNZ1leATaV0VRIV6EGnbQC5V7aN0kcxAeiGUAjMmO6xIoJbS55PtXagRvc=
X-Gm-Gg: ASbGnct62nl6InWbznHzJmmwmXZumznPbL21XniMhMT8xICUJWvx4n3CLJduLuUnHIB
	RKdJYi1PSyRk8Fkl0/uG44mJfLbl1TuY1X0nIvekr7RJbiXGZZ3MEDtpHfY+QS47kREdM1HISzJ
	D7okXe1m3rPYszECl9EpL2e1PH3heZpmoi9b3M4FoFI4BsgVQ7bpidmDnhoGhb46zyicwkduaOb
	oQgMBoXczbcbcevR7xJF7ogv7Qu+pUQPCXA1mSSYmEUBKTHDK/uu44jltpxvtVwHIexj/cuY8fJ
	YKKRvJm9QkwdXi1o8BNKtGzEGZyE19Gs2J+EEvZ+EFWj5jYzdIDYhiCllgS/8bDf5gSxMdOjQem
	37d8dvcF6DFDp5PsvnjhgOBxs
X-Google-Smtp-Source: AGHT+IFM4p6lMZNVLC0jFnDTCPAyZHgETTKFHiT1zCcgafDpM4NLL77NZoZHbblr2jsx9i3vSP1Ibw==
X-Received: by 2002:a05:6a20:5493:b0:243:755:58b7 with SMTP id adf61e73a8af0-24340d92b54mr5564480637.56.1755878056120;
        Fri, 22 Aug 2025 08:54:16 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbbaca53sm156320a12.48.2025.08.22.08.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 08:54:15 -0700 (PDT)
Date: Fri, 22 Aug 2025 08:54:13 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Sun YangKai <sunk67188@gmail.com>, clm@fb.com, dsterba@suse.com,
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, neelx@suse.com
Subject: Re: [PATCH] btrfs: Accept and ignore compression level for lzo
Message-ID: <aKiSpTytAOXgHan5@mozart.vkv.me>
References: <2022221.PYKUYFuaPT@saltykitkat>
 <810d2b19-47ed-4902-bd8d-eb69bacbf0c6@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <810d2b19-47ed-4902-bd8d-eb69bacbf0c6@gmx.com>

On Friday 08/22 at 19:53 +0930, Qu Wenruo wrote:
> 在 2025/8/22 19:50, Sun YangKai 写道:
> > > The compression level is meaningless for lzo, but before commit
> > > 3f093ccb95f30 ("btrfs: harden parsing of compression mount options"),
> > > it was silently ignored if passed.
> > > 
> > > After that commit, passing a level with lzo fails to mount:
> > >      BTRFS error: unrecognized compression value lzo:1
> > > 
> > > Restore the old behavior, in case any users were relying on it.
> > > 
> > > Fixes: 3f093ccb95f30 ("btrfs: harden parsing of compression mount options")
> > > Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> > > ---
> > > 
> > >   fs/btrfs/super.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > > index a262b494a89f..7ee35038c7fb 100644
> > > --- a/fs/btrfs/super.c
> > > +++ b/fs/btrfs/super.c
> > > @@ -299,7 +299,7 @@ static int btrfs_parse_compress(struct btrfs_fs_context
> > > *ctx,>
> > >   		btrfs_set_opt(ctx->mount_opt, COMPRESS);
> > >   		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
> > >   		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
> > > 
> > > -	} else if (btrfs_match_compress_type(string, "lzo", false)) {
> > > +	} else if (btrfs_match_compress_type(string, "lzo", true)) {
> > > 
> > >   		ctx->compress_type = BTRFS_COMPRESS_LZO;
> > >   		ctx->compress_level = 0;
> > >   		btrfs_set_opt(ctx->mount_opt, COMPRESS);
> > > 
> > > --
> > > 2.47.2
> > 
> > A possible improvement would be to emit a warning in
> > btrfs_match_compress_type() when @may_have_level is false but a
> > level is still provided. And the warning message can be something like
> > "Providing a compression level for {compression_type} is not supported, the
> > level is ignored."
> > 
> > This way:
> > 1. users receive a clearer hint about what happened,
> 
> I'm fine with the extra warning, but I do not believe those kind of users
> who provides incorrect mount option will really read the dmesg.
> 
> > 2. existing setups relying on this behavior continue to work,
> 
> Or let them fix the damn incorrect mount option.

You're acting like I'm asking for "compress=lzo:iamafancyboy" to keep
working here. I think what I proposed is a lot more reasonable than
that, I'm *really* surprised you feel so strongly about this.

In my case it was actually little ARM boards with an /etc/fstab
generated by templating code that didn't understand lzo is special.

I'm not debating that it's incorrect (I've already fixed it). But given
that passing the level has worked forever, I'm sure this thing sitting
on my desk right now is not the only thing in the world that assumed it
would keep working...

> I'm fine with warning, but the mount should still fail.
> Or those people will never learn to read the doc.

The warning is pointless IMHO, it's already obvious why it failed. My
only goal was to avoid breaking existing systems in the real world when
they upgrade the kernel.

If you'd take a patch that makes it work with a WARN(), I'll happily
send you that. But I'm not going to add the WARN() and keep it failing:
if that's all you'll accept, let's just drop it.

Thanks,
Calvin

> > 3. the @may_have_level semantics remain consistent.
> > 
> > 

