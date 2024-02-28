Return-Path: <linux-btrfs+bounces-2866-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB76586B4C6
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 17:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C1E3B2C3EC
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 16:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2380B6EF00;
	Wed, 28 Feb 2024 16:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDgfBREh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0C320DD5;
	Wed, 28 Feb 2024 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709137393; cv=none; b=f2uPpJWRp+cVyrFnNjP+70pF2wbxWHOWFpzYD/dco2VCcMNEoD05fxEZttBLh5cQZr0Yx2on+g1zFuL/ORbaWNhKmPTyorMpuM1usaYNCUuhVnFSGU1Xez1kOz5lJ2s4UUAljapJAm8nkjPuh0h0yQbAFXHLs1kTwraVoqtP0sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709137393; c=relaxed/simple;
	bh=aKP3XKivBDkL7DKrt74vUAYWeR8YG5sZXUYI3JgNld8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3UvC7i/YJFKEGfiabpOVnk9USsZEnQ7weD+5Oy50UUUggHQRRGd4FB1De5ZIxuBwIQTKj1vCSkAPXK5qq2VEi6YRqSjPHRG8rejKwW5VNsoP45ST9LADF9s+W871refMRBD+UDYH/b3K4o040Sxj+lzmabLTmeCITodJbQMrdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDgfBREh; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60925d20af0so23003627b3.2;
        Wed, 28 Feb 2024 08:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709137391; x=1709742191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HbOEijThNH46+MKcExlVA1bAK6/6kIlRSRkEOFZjgxo=;
        b=eDgfBREhJUB32VSCBwiB9bs6+sMMXnn41wdepPJ53stqXOS7i7BIYvrrmr3tPHvodg
         WGACZf2oI5zJv0qVu1fMlpA9qO/0cowy2PzudSkqIaLOxI01ZZymtxsUcfL+7anIk2+F
         zLiBQqa13jLvwTD5p/kKda9dQzgqdv08cr5gFz1SsrRPtmQihttrXNuPOr/Ss+NqIg2y
         4oJpClzNZohC14sif75ggcFNCZzF3s5m6ZNpcohjLHnWJbF/qpGlcjabiLGEkjitINBi
         roU+uCncDYYVhSkoLF5HXGBW9MHQMAVyLMHPcGTx9ah4QggNpKF5MDzQaiXL9grB4cPs
         0uKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709137391; x=1709742191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbOEijThNH46+MKcExlVA1bAK6/6kIlRSRkEOFZjgxo=;
        b=YRvF6lHWJa3/urHc22BGM/XYTyvROevIKTBklfrUWLx/uOrMKK835dO3fzmPHIqzik
         NaeyGx4dCkgWX4kmheDcURZzKOZ8QbMbL51Z755tAam6fK3XaLvpRtnMdvkAVjVSHYth
         5JW0FJn1hO198RPmgIA+LwoIXp9k6hgz8RNZT3fUUapZRdGqUMWdrjEBmOibY3ku1xgR
         hv5v4xHIF+FmLnAy7ah2ecg9/CPjGA9AIn+AlUw2juU1gsmLq66g419Krh/A8KS+yV5Q
         ytoDeZ3XTBZeJuwMfyFFOXxwOlaNvyTACa8N3tGHl9rsfztp878EhkEhgdtf5k/CMzjK
         EfXw==
X-Forwarded-Encrypted: i=1; AJvYcCV5FyU0dAa61VOe3hvEXSsnoDoaCieBb7wvoC9rKcYEKPZ3E8T7PhlzzVcyXj05QlvZCeahDzqjfU7MAwNKK0q/jKfeZLrhBkHnwkT8DAf9Yu23yu/uih/vE0Cch3XksZ/FhEfDLwICR7Q0nOrP+UCFsDrpqfpFKj3obNb070NmO4Rlhr3M3lfZKFqA9888wIM8jZducyhyqIAJ6pQt
X-Gm-Message-State: AOJu0YwfVfpJ/rChWYMVdhx/W0TkudIDXSP0mYGnB4u7A4MKwFNGubXD
	q/9uzauhha0lfiOOTfcQ9aW84JRo43ZUvh6O+Jlu2JukKuW81Cqh
X-Google-Smtp-Source: AGHT+IGv4dKbA2FgkfgFeim73NTZL194kVoyen/ECEHKASPW+ceHW/ESvGQ3LlWv++LKuBu1H0b1TQ==
X-Received: by 2002:a81:4054:0:b0:609:205c:82b2 with SMTP id m20-20020a814054000000b00609205c82b2mr5476474ywn.0.1709137390676;
        Wed, 28 Feb 2024 08:23:10 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:2256:57ae:919c:373f])
        by smtp.gmail.com with ESMTPSA id o15-20020a81de4f000000b00607fe5723e6sm2380884ywl.109.2024.02.28.08.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 08:23:10 -0800 (PST)
Date: Wed, 28 Feb 2024 08:23:09 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Alexander Potapenko <glider@google.com>,
	Jiri Pirko <jiri@resnulli.us>, Ido Schimmel <idosch@nvidia.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>, linux-btrfs@vger.kernel.org,
	dm-devel@redhat.com, ntfs3@lists.linux.dev,
	linux-s390@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH net-next v5 06/21] bitops: let the compiler optimize
 {__,}assign_bit()
Message-ID: <Zd9d7XS+TtOx73zP@yury-ThinkPad>
References: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
 <20240201122216.2634007-7-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201122216.2634007-7-aleksander.lobakin@intel.com>

On Thu, Feb 01, 2024 at 01:22:01PM +0100, Alexander Lobakin wrote:
> Since commit b03fc1173c0c ("bitops: let optimize out non-atomic bitops
> on compile-time constants"), the compilers are able to expand inline
> bitmap operations to compile-time initializers when possible.
> However, during the round of replacement if-__set-else-__clear with
> __assign_bit() as per Andy's advice, bloat-o-meter showed +1024 bytes
> difference in object code size for one module (even one function),
> where the pattern:
> 
> 	DECLARE_BITMAP(foo) = { }; // on the stack, zeroed
> 
> 	if (a)
> 		__set_bit(const_bit_num, foo);
> 	if (b)
> 		__set_bit(another_const_bit_num, foo);
> 	...
> 
> is heavily used, although there should be no difference: the bitmap is
> zeroed, so the second half of __assign_bit() should be compiled-out as
> a no-op.
> I either missed the fact that __assign_bit() has bitmap pointer marked
> as `volatile` (as we usually do for bitops) or was hoping that the
> compilers would at least try to look past the `volatile` for
> __always_inline functions. Anyhow, due to that attribute, the compilers
> were always compiling the whole expression and no mentioned compile-time
> optimizations were working.
> 
> Convert __assign_bit() to a macro since it's a very simple if-else and
> all of the checks are performed inside __set_bit() and __clear_bit(),
> thus that wrapper has to be as transparent as possible. After that
> change, despite it showing only -20 bytes change for vmlinux (due to
> that it's still relatively unpopular), no drastic code size changes
> happen when replacing if-set-else-clear for onstack bitmaps with
> __assign_bit(), meaning the compiler now expands them to the actual
> operations will all the expected optimizations.
> 
> Atomic assign_bit() is less affected due to its nature, but let's
> convert it to a macro as well to keep the code consistent and not
> leave a place for possible suboptimal codegen. Moreover, with certain
> kernel configuration it actually gives some saves (x86):
> 
> do_ip_setsockopt    4154    4099     -55
> 
> Suggested-by: Yury Norov <yury.norov@gmail.com> # assign_bit(), too
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Acked-by: Yury Norov <yury.norov@gmail.com>

