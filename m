Return-Path: <linux-btrfs+bounces-2876-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C2C86B542
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 17:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D0DA2883F0
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 16:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED7A208D5;
	Wed, 28 Feb 2024 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRSXZdSn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5AC6EEE4;
	Wed, 28 Feb 2024 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709138794; cv=none; b=jBxdT7/IYKvA9/6OwUtnizzbuCqEffo4NLSmJ5MpOLvbCJgNh7IoPOQOt0y11lXIg7owtp2Tx6Wqia9/mK/KHUGHWn24+41gmsjcKtFc4k/mi6+Rlr+I6yOKWNpqN1brCXbeIJRm2C3C4AZXqBkbDVSUtGzgdN8230ZHJdtfhdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709138794; c=relaxed/simple;
	bh=V+Wes0yro1vaPybdAdIYTu58twkZIP8KrE4+vLrxbsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJDCU6bzZgDObSzdAj/wfkw7SxuiR0CN/4aPBKVy+SRxA5kQDWvo2q11yW7WxiWy0gIyZ0oZHFxf1hQLuTv44pzWGUrrZQIgtXuTzJc5fHlZIr2D3jTztaPcshl6fS5Hsii86X8K5yxNEEFz+qQoQSmdm65EtOGQA4nUSVPfEaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRSXZdSn; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so1118638276.0;
        Wed, 28 Feb 2024 08:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709138791; x=1709743591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DxwTMwCJVFMBDDvjxN0uaNIVMWBc/m50PoGk4vNalyY=;
        b=DRSXZdSn37qd1kKt+dhafidPKpXvIpn+/ObqdhivrtC3F6e7ddTn5l0YtNgaRKGK+M
         d9MQ9UTXf4FbnpAV1R5XwfiT79PBjpgF+VSWxQoms07ghIBsJt9l9X0V0bZUWn5pvFi9
         SMRb4BM5i8GqKWF6xtBRccDsVisltO0HNlOm2pUdMvbiYCxNJnKjCpNQ7xvMzCWEOl9U
         FPiP2lA92mTaALlKGf9KEjmm6zlmTO6nhzCvlOKzyEXaKH/36SB3tArGkhSeFElCnv9E
         S2h1Tby5FPY1XGorSyWLSt17PR++PDYbmqjrQr7PqUIPzyZZTbLLxX2W3NJJsOj9X676
         qKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709138791; x=1709743591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxwTMwCJVFMBDDvjxN0uaNIVMWBc/m50PoGk4vNalyY=;
        b=a50gL7jA1ORb2QEq2pYlynwcNl0O52+fwa0MV9XzhcKv5+ciUASQQ71Y1QySSYYfUA
         WeqI5LW+5lVJm8C8vBb5guu1JvWre0maYL2yprNwwKq8DZEzrBuW+leOvIW887Cg18aW
         NwNd2I+CnV0iRENfqbsjXzEJSYk30KwJGIeIChfW9PMvH9KGcoQN5IMJ12fNhQngNtDd
         1Lmkj89KsB8ubmHanAtu26cY86bpOaRY7iiVdg1nbH0IhyzEED6FvWwos3uvcjYtAOOs
         JWpN7fpeDD29z1N22+b/dPyxmaN5iWTwcUThf0wt3FCBgKYLjly4wonrevKIxOiy0j/+
         s2Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUywO9m1zecZ3ofWeU4sUrDKcNKkLn2VCQMyXB7ROcp4X+Vdxi7mpbbg9PD2sUb2LbwwINZN3xFiWr6kFRX4tgGmmVSM6GfkCljFuy/sJaFWqnQ0NeFRikRTp3HCYNf/Qm4zGzoDePoM9aQJhKIjHqDXS/VWGD28XkWhcbI+7fWOcDAbakQ0Fp5lfLOM3D6ZFSY2f6M78ZvrgAKsl7z
X-Gm-Message-State: AOJu0Yw4HKJSOkFC79K8pPJKgiFkUlYMrSkS/iDvlwmRKYtukMLTgMW3
	h5/PHqjWSIk45Hua/eVOSfgCPIcC9qeqQRjebQy2VFf2af8GswLkAzvPJxgjThw=
X-Google-Smtp-Source: AGHT+IG+T6i0Kg6hK0OXQQpUI7eVIpugJ4UsU/eSwtZUJTDnNAIjX3r6X/tjo8tk0qDTO98RF+EAJQ==
X-Received: by 2002:a25:72c1:0:b0:dc7:3362:4b2f with SMTP id n184-20020a2572c1000000b00dc733624b2fmr2053330ybc.13.1709138791147;
        Wed, 28 Feb 2024 08:46:31 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:2256:57ae:919c:373f])
        by smtp.gmail.com with ESMTPSA id t13-20020a25aa8d000000b00dcc620f4139sm2082379ybi.14.2024.02.28.08.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 08:46:30 -0800 (PST)
Date: Wed, 28 Feb 2024 08:46:29 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	linux-s390@vger.kernel.org, ntfs3@lists.linux.dev,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, dm-devel@redhat.com,
	linux-kernel@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
	Eric Dumazet <edumazet@google.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Alexander Potapenko <glider@google.com>,
	Simon Horman <horms@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-btrfs@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Subject: Re: [Intel-wired-lan] [PATCH net-next v5 00/21] ice: add PFCP filter
 support
Message-ID: <Zd9jZZafcVyDGOTw@yury-ThinkPad>
References: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
 <c90e7c78-47e9-46d0-a4e5-cb4aca737d11@intel.com>
 <20240207070535.37223e13@kernel.org>
 <4f4f3d68-7978-44c4-a7d3-6446b88a1c8e@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f4f3d68-7978-44c4-a7d3-6446b88a1c8e@intel.com>

On Mon, Feb 12, 2024 at 12:35:38PM +0100, Alexander Lobakin wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Wed, 7 Feb 2024 07:05:35 -0800
> 
> > On Tue, 6 Feb 2024 13:46:44 +0100 Alexander Lobakin wrote:
> >>> Add support for creating PFCP filters in switchdev mode. Add pfcp module
> >>> that allows to create a PFCP-type netdev. The netdev then can be passed to
> >>> tc when creating a filter to indicate that PFCP filter should be created.  
> >>
> >> I believe folks agreed that bitmap_{read,write}() should stay inline,
> >> ping then?
> > 
> > Well, Dave dropped this from PW, again. Can you ping people to give you
> 
> Why was it dropped? :D
> 
> > the acks and repost? What's your plan?
> 
> Ufff, I thought people read their emails...
> 
> Yury, Konstantin, s390 folks? Could you please give some missing acks? I
> don't want to ping everyone privately :z

Hi Alexander, Jakub,

I reviewed the series again and added my SOBs for bitmap-related
patches, and Acks or RBs for the rest, where appropriate.

Regarding the patch #17, I don't think that network-related tests
should be hosted in lib/test-bitmap. This is not a critical issue,
but Alexander, can you find a better place for the code?

The rest of the series is OK for me. I think Jakub wants to pull this
as a whole in his -net branch? If so please go ahead, if not - I can
pull bitmap-related part in bitmap-for-next.

Thanks,
Yury

