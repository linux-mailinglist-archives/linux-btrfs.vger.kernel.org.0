Return-Path: <linux-btrfs+bounces-16269-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0E9B31352
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 11:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A45FAE6DF5
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 09:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CA72F2900;
	Fri, 22 Aug 2025 09:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="X7cEZDDF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C71D2F3C15
	for <linux-btrfs@vger.kernel.org>; Fri, 22 Aug 2025 09:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854914; cv=none; b=BqW6k9wTjx7fEvfzv2UTZ+OKP5VxEK6MAHkCGvxjWIH9ER+LhCOxgJbgAAVT6Jf/9B1U5WmXwmJFnIgXwhLDdnQHfWiZLvlR94dmj78Hkubzdzllza78EyDpi9VtM5VcxfKS7Un2LzWwgn/VcMYRQ2DwSCILTA8Z/skiqR9Am3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854914; c=relaxed/simple;
	bh=wmwgknyVkYInObDZTr2Hm600bAvuWe10GFbru4HVzms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0epEVlatE77RNqaMI+LToHqK662k2pXvk0AId3exf4QoFWrsF+ip/nJKHAUS8Rq/LTKxng4gF2zYx1xCZysz1hr/M6L7rMJYe3OSeGD5ADWw3bpuXBfox0d+ynXkDjXPu/ZhufeM6z5yIs0OMBkdeuLG7Hy3A+dpAyZEpQ2NQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=X7cEZDDF; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e2e6038cfso2245669b3a.0
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Aug 2025 02:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1755854912; x=1756459712; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=75HTqSrm7uVdUPk6AX7RB/ymIGadUulsGOItLR1tuas=;
        b=X7cEZDDF5qKWDwS0HLezIwbUBfRBVsl2iioMkFXMP5skrxeeQ1cKYKN7TcAO1bQroY
         k2tg8ABlPo83MBiwIxw+iIYAz8sXow0m7mOW61muHLJWCq97qkHnDtqwzvqwivIKzCv5
         kujFZwKfqVuDEN/X7A6hzAl92YedWVfvO+iGsPCICYUguraC39FtjaTsRIN/vdUHCtNv
         szgS+TvSRgK3pduEPxBLf8X0ChMWdPiUXTySjKek9BaAWjrC8O137qqfe0jydUNnJ4As
         ucZkb7SlRVCUWTI0K9aGtRNJLmGfi2/EMmOu5F8OVUN/PqL+ile/VgF6zWQZtn2J0NEV
         DeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854912; x=1756459712;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=75HTqSrm7uVdUPk6AX7RB/ymIGadUulsGOItLR1tuas=;
        b=xAkWveoAFnPD3rkETiAvTSHK2le/o1ww2Uj3lwPAr+Cubg+04DMIPpCPvDz3q2mq0t
         1wU8nMDjq8YqsyULySdO/qacQ4NErgY5g9pDbkk6l0xgq9Y20vgBpvmkuRgVxR8Z7e/v
         4EBbiDXUdQRfWMDVF+3GfM+LxjSBl38wh4xcjeNhgZCyNJBhceHh/Rl8wcoKgAtBL+el
         h+FHB19kcEhCUIZepfSkI4ApH+Zf/qEiSKJS0jEOkxyEx/aMauUUngyq5traxL2g8CMN
         Y90h4qcp93vO+qRNbKAtXEFcdpnVApDdAVKBCQzi8xqbHgOn2y2nG9GgIBAiizPfsA2D
         /K4g==
X-Forwarded-Encrypted: i=1; AJvYcCWy7nOsDd2Wnx18B/nhgrWe0L7OTnmnkSZpTdgta/ac6aJKYfehTXiYZDF8N7WkR+esdinkWJZlkbOqVw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0CSse8YOlMTblJ9Sb+jVfjdggCdqkoKQ0IptD9TlXbLRqAdKb
	FQdMJyBC5NciEYdwRsP540gm+hGG83wXCJB/tW8LT7W5oOm+TwWUngVbGivXMDXxvYlzbFzBevl
	/2L9Dyf8=
X-Gm-Gg: ASbGncvZT5McI6MTt4yRPa4Iur3EnDlP5yg14vs/qbBGiyfk0CctqV4uZ7GyJxQvwYd
	kAw+NAase+ERjHIz8bRCz1D6B0AwLiQwmXXBW2UtUJzKVAADXXqo+7jkhw0UT6s/D45vV9AHR3Z
	f3mif2Ro3jkSstLe4RQI1tYE0nDzreeQ9yYTMcKdqExAmH2NM5b+dyqPLf2x919LxLoxY66XhCH
	675wmisp/twXb77Mb+7Baiz/5Q9QgO0XPBTPIH9385EaEGM9yoByaJFljwQh+os+CNJiu6a9NtI
	f7W3P0upk68k2QT34NuEK+8YBF6UkiCa2eSHmdTGd0HKZVNjAGi3xoSuAFq3ib2TYpK4DKI8dtt
	T5zEI+jcudW64pvdemQfveohv
X-Google-Smtp-Source: AGHT+IE7bfBjxUJexxsZZW/IgJ7nBmNFkLVFwpD4zkiJn0jvfJcJvW7DjylmTmJ65B1S77Lzg+gd4A==
X-Received: by 2002:a05:6a20:6a1c:b0:243:15b9:765a with SMTP id adf61e73a8af0-24340d61060mr3857179637.52.1755854912434;
        Fri, 22 Aug 2025 02:28:32 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d10fdd6sm10508155b3a.29.2025.08.22.02.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:28:31 -0700 (PDT)
Date: Fri, 22 Aug 2025 02:28:29 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Daniel Vacek <neelx@suse.com>, David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>
Subject: Re: [PATCH] btrfs: Accept and ignore compression level for lzo
Message-ID: <aKg4PcgUCvXblVCY@mozart.vkv.me>
References: <a5e0515b8c558f03ba2a9613c736d65f2b36b5fe.1755848139.git.calvin@wbinvd.org>
 <a637a576-f107-4d05-84c8-280b133e925a@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a637a576-f107-4d05-84c8-280b133e925a@gmx.com>

On Friday 08/22 at 17:57 +0930, Qu Wenruo wrote:
> 在 2025/8/22 17:15, Calvin Owens 写道:
> > The compression level is meaningless for lzo, but before commit
> > 3f093ccb95f30 ("btrfs: harden parsing of compression mount options"),
> > it was silently ignored if passed.
> 
> Since LZO doesn't support compression level, why providing a level parameter
> in the first place?

Interpreting "no level" as "level is always one" doesn't seem that
unreasonable to me, especially since it has worked forever.

> I think it's time for those users to properly update their mount options.

It's a user visable regression, and fixing it has zero possible
downside. I think you should take my patch :)

Thanks,
Calvin

> > 
> > After that commit, passing a level with lzo fails to mount:
> > 
> >      BTRFS error: unrecognized compression value lzo:1
> > 
> > Restore the old behavior, in case any users were relying on it.
> > 
> > Fixes: 3f093ccb95f30 ("btrfs: harden parsing of compression mount options")
> > Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> > ---
> >   fs/btrfs/super.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > index a262b494a89f..7ee35038c7fb 100644
> > --- a/fs/btrfs/super.c
> > +++ b/fs/btrfs/super.c
> > @@ -299,7 +299,7 @@ static int btrfs_parse_compress(struct btrfs_fs_context *ctx,
> >   		btrfs_set_opt(ctx->mount_opt, COMPRESS);
> >   		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
> >   		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
> > -	} else if (btrfs_match_compress_type(string, "lzo", false)) {
> > +	} else if (btrfs_match_compress_type(string, "lzo", true)) {
> >   		ctx->compress_type = BTRFS_COMPRESS_LZO;
> >   		ctx->compress_level = 0;
> >   		btrfs_set_opt(ctx->mount_opt, COMPRESS);
> 

