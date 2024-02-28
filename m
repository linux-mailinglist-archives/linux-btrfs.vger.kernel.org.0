Return-Path: <linux-btrfs+bounces-2864-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F85986B495
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 17:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B54E61F22A60
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 16:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D216E6EF08;
	Wed, 28 Feb 2024 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNGHozCs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2231C10;
	Wed, 28 Feb 2024 16:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709137099; cv=none; b=EvVQEypqXgWpDQRIP0RtYyqJnQItG0FNKwS4E2OqTUQhKUIWUPYDw3bAA39Af/gq45Zu6s/sxX9Q5XqvoREcHYj28HjSLNDtWMSXq/sr/wGDCHcHSoPV5gaXiObx2tgWpPR2KUl8CMj+GuXuBtG149Ws6fOnjBIuOtwEOXB3QeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709137099; c=relaxed/simple;
	bh=COF6G92ulT1WirswD6YovX9eGiOC1l37L7KzMeYAzi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObrD179tuiPiNYUAMPlnfxXSsN4xwCUQzDDu96NJqav2aG9Vu60J75zBCNagR77fnSYyNo8tlku1CfSVV8yjv4hTiTeCL9O5aNfQvY7TwP6v+ny3owiINKqirCfDKj8/g5inGxveiZQfNwJbYKHciTA2Xc2P4PKH0qoVoG/xxyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNGHozCs; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso5976002276.0;
        Wed, 28 Feb 2024 08:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709137096; x=1709741896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rl2J8wUQ0nkL1SOPD3XRF42shMc7kd3Rtbu+FuDVg5g=;
        b=cNGHozCsYhuN8mbGN/wzJfmALAgHLRzhgQhbCpEI+P1z9yllAPYEUnwUxkaR9mTtB1
         WyOwoL+CRwnwIlv0Ht6Eqt/jxrXnA1BYOy2p9YmNLYQuJr75rAZU9AyuwAkTvfkF7BRv
         h5JwnCVDxojQcOEM96fqa70igLJHNOmoYpk9ZyyOm43ihD1yBBRfSC38abWKUEEe/UOk
         nTQFJapD6g/M8HFMwQhFKuILg4VRuw1JzpwvU8mu5OWXFXSaQFYtmeYH+UXuI+Dyo0k0
         TeHcTCTBbhQtA9Mfvv4jC60gmQ8tDBQ+yPqBZ1YIKzU3+dDzJIV6ccqEJX6NCb96Ucqz
         MDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709137096; x=1709741896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rl2J8wUQ0nkL1SOPD3XRF42shMc7kd3Rtbu+FuDVg5g=;
        b=Ad0obNvxUIfn96YSeAKKxIcToxCmfAMbV8Mj596xmwPc3iT1XUZ2alvjmaw7MPKmpd
         DoKhfwOigOmVsViz8mugc+WOqbt7e5njwUqnDU4236UnsZAnzxLGLnekC4ZXbWr8mg1G
         xjXqk9RWmo2tOj+gN61LO6SA37nGZvMITtB3n+ZiNTiQSg2VDOhlabsoeIFsVyM7MZPp
         /Z0M/fD34Mrg7Mv4bpGWEQFveUREWbNQF7UbOFjOWEIU1gLKLFwzc1qvvsUssd8RjHLg
         Ak2samWNDE5ct8m2cLeeDtxfY/rsFsRt3NvbGHzcLg9vb4HCPhs3JlSrCU7dQCCpakj4
         17kA==
X-Forwarded-Encrypted: i=1; AJvYcCWZk1qYZwjJVDyjDDL/2Lps+uKutNUVVB9/564JXZOlp+JI+JYSvmeVRNE3D/Vy55kXrXLDOtV89ZfGJCbp+pGN/rCaRPNgGBmmQ3Az0++YpmPto36qumS/JQsw0/+As7QAJZsQDuRkXE/SyREp5C6fblsJz5Iisnv75pe6WHY+aJ/MOnpJ049GMoeXaRK9SGQ8Hn680FBr3YuszP2v7DVDp0+1lgI0QEQVdMvMa8LTkIWNocVe
X-Gm-Message-State: AOJu0Yw+O65AF03gij6EA6BWjfk5RRkU/OTGyxyEd5edCdJpB/d5vH4G
	ycEFHzsKozZaY15OSG+++EVw4Bg3hk6ZSwJpj/ut2ikiGJQmBP1Z
X-Google-Smtp-Source: AGHT+IHq8mQJHHCspvj6dHRiMav2oJi1D7d3a2gVdEsp6p3DsPADLGfhpHlDysvZKge1cU6fkAdzkw==
X-Received: by 2002:a25:2f46:0:b0:dcd:5f08:3666 with SMTP id v67-20020a252f46000000b00dcd5f083666mr3229434ybv.29.1709137096483;
        Wed, 28 Feb 2024 08:18:16 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:2256:57ae:919c:373f])
        by smtp.gmail.com with ESMTPSA id b26-20020a25ae9a000000b00dcc75d4e22dsm2063296ybj.5.2024.02.28.08.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 08:18:16 -0800 (PST)
Date: Wed, 28 Feb 2024 08:18:15 -0800
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
	stable@vger.kernel.org
Subject: Re: [PATCH net-next v5 04/21] bitops: add missing prototype check
Message-ID: <Zd9cxygyGo8nla0I@yury-ThinkPad>
References: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
 <20240201122216.2634007-5-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201122216.2634007-5-aleksander.lobakin@intel.com>

On Thu, Feb 01, 2024 at 01:21:59PM +0100, Alexander Lobakin wrote:
> Commit 8238b4579866 ("wait_on_bit: add an acquire memory barrier") added
> a new bitop, test_bit_acquire(), with proper wrapping in order to try to
> optimize it at compile-time, but missed the list of bitops used for
> checking their prototypes a bit below.
> The functions added have consistent prototypes, so that no more changes
> are required and no functional changes take place.
> 
> Fixes: 8238b4579866 ("wait_on_bit: add an acquire memory barrier")
> Cc: stable@vger.kernel.org # 6.0+
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Acked-by: Yury Norov <yury.norov@gmail.com>

