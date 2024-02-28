Return-Path: <linux-btrfs+bounces-2873-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5724986B518
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 17:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53676B2B229
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 16:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B17208B2;
	Wed, 28 Feb 2024 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOF8+Iwm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4441DFE8;
	Wed, 28 Feb 2024 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709137917; cv=none; b=ZzPQd1spsWA3nqLCOXNCZDeICmLVTB8sQHKxZY519ok2/cGGf0SS4C3qu8h4QHo91G8yw1SpPt0S8jUuEwdnPhxaWR9kd+cVQiXnCx3mDMXAXFOcTjoO3HmBD7HhK1kivMjsftncNHBUlBppVLSTNAqhQ6cRDFcfYM9pmK3t3Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709137917; c=relaxed/simple;
	bh=g0Ik/3ZcsyoaSr3tfeDW9hLUH99COK9VQZxIwEPar6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svTVxCRYMUBBKIDyGGnnK9IYue3J9vBzVTRezsG8BODOnvDAc/WwiWIDJtjibi/v3gF3MrLTKQ+ecpm8bLvEH2negCp+5A0MQ9QTDuaN9RHvbJqc7Vc25u5Xylgr2MM432c72Wq05gm3hF1/QplHlTIePgKEJv0KDcvfaYg2Ir0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOF8+Iwm; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-607bfa4c913so57498357b3.3;
        Wed, 28 Feb 2024 08:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709137915; x=1709742715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y00SGrd9M6s3CDkf95KQLhsTphwzXhcDaiAvmjSSj6k=;
        b=aOF8+IwmRQT8FCYjM7J0Mfabs3SJICuzu82sTQqLndgEzqLviqtyikiHUxs8gYOJm3
         d0+ZNr2iL0jDxLjQHL5sHHv5tcaKOOzHm7ZALojyyuTI9N59wFxLrysiU/f3QzRmD70U
         WOeBnw3j++97XpnviQLZ9hGHCAohf/74mnf++ZBTvbJIMJkFyCHXo23BpPjG4bRSl4rL
         cTZYaHa9lwSEzcXYU6C1NA/SnIaXR1sCU9hB5U4nNAG3W5S2Syx5fNnjpTL6iwaaLREb
         p8S5ZnZcYZ2EbB+f3/iDQPGN67lqEhL65R8uaWuagyLW2u1B4vt6XCR0es5XZ5YKROrF
         YqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709137915; x=1709742715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y00SGrd9M6s3CDkf95KQLhsTphwzXhcDaiAvmjSSj6k=;
        b=K8dpYytGG9332bYnvo34gI8DfkaC1j1SqCy036805eNu2tzq0rW/lGWMxHbBCi3Bw+
         TpVim3wpt71VKXdqLbrylDjK5hvgKzlZlXJoRznTBaLtpUhtreR4F/Z2Pmn2WBjchBKC
         WhPBBvoWGrUzeKeLlk1+zrehOldW7/RSHnqc1OcPzLtCIeT1JpEE6KhGsXcrDhbkYZMc
         KrAX0W11ZDPSlfi69VgBBTlpLORBB7oBXPcXJNbXIqXfRBKgEN1oQMsep4Yi/qupyFqS
         6Higkov7yxebNsTHGChu2IxVLtop/x6sC7nY7yDpjCCt0dDl6xRNmf6nDIsaTzbBOwpJ
         LFOg==
X-Forwarded-Encrypted: i=1; AJvYcCXej2XWyBkJEhjJk+xWTTXDZouULoEDfixjQqOAxX2CIzc+z3pNxxM64h3v7BU9kdpDlVIDy6wD6nDzyTHmGGd20AvmSDtIdhaBTLpn4pfscPUREGLw43uUmr+T8aYBDjot1pq3FKRgsBx84rAqMvajVXJ2HVwUJZGhJ9D+byzeJXX3LlIgFvsDBq35pdAV39PWewJO+na7LaqCEVXb
X-Gm-Message-State: AOJu0Yy6RWf+Fy38+YQm6Y5SHSsC0fIZlyfvYCV09NBynkQSmiwKyeay
	j6//6+lmh5ZBAVqWIatsGsBzAgLeTx8jnwtczOcGcRrEA/vLS13A
X-Google-Smtp-Source: AGHT+IGj4/IjP6v6QkD8PC0HSa34HyvewYGdsnXngXKn//7R1aZlo6viivB4X2GagxTTDYApigz2/w==
X-Received: by 2002:a81:ef14:0:b0:609:37fe:fb97 with SMTP id o20-20020a81ef14000000b0060937fefb97mr3571358ywm.4.1709137914777;
        Wed, 28 Feb 2024 08:31:54 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:2256:57ae:919c:373f])
        by smtp.gmail.com with ESMTPSA id h135-20020a816c8d000000b0060923196f02sm1154828ywc.13.2024.02.28.08.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 08:31:54 -0800 (PST)
Date: Wed, 28 Feb 2024 08:31:53 -0800
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
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 13/21] bitmap: make bitmap_{get,set}_value8()
 use bitmap_{read,write}()
Message-ID: <Zd9f+W33T+jWalBF@yury-ThinkPad>
References: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
 <20240201122216.2634007-14-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201122216.2634007-14-aleksander.lobakin@intel.com>

On Thu, Feb 01, 2024 at 01:22:08PM +0100, Alexander Lobakin wrote:
> Now that we have generic bitmap_read() and bitmap_write(), which are
> inline and try to take care of non-bound-crossing and aligned cases
> to keep them optimized, collapse bitmap_{get,set}_value8() into
> simple wrappers around the former ones.
> bloat-o-meter shows no difference in vmlinux and -2 bytes for
> gpio-pca953x.ko, which says the optimization didn't suffer due to
> that change. The converted helpers have the value width embedded
> and always compile-time constant and that helps a lot.
> 
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Signed-off-by: Yury Norov <yury.norov@gmail.com>

