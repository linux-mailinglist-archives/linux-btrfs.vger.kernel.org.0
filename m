Return-Path: <linux-btrfs+bounces-16298-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4720DB31C81
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 16:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91541BA217B
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 14:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2595F3128D1;
	Fri, 22 Aug 2025 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="i8/sQ+5y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDF8307481
	for <linux-btrfs@vger.kernel.org>; Fri, 22 Aug 2025 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873641; cv=none; b=fiA3vvrd3cLBzj2TiP3BiCsGFKIAq3WvabDyBrTZL0gQcoqCb3jRp6ADEO/sRQrTfAo5wSfHzTVB0koErwslfye1cHYuXUMmrKK27aiNWoB5E1yAEwOC2ERnfHr3AxK46Rem2mYdHSGxvtLUg9qCSwArFMZ/79wmTbehFfjC2mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873641; c=relaxed/simple;
	bh=fEOMn/md0OE1QvUICBnX8O+3a7PgQ6vANjZfZQ8gxr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiiiCf9ZTE7ZBnPqdJEV0NzSXXPT1NQ4ClriuhjlmmM9P5gsJxJFVorGXKR43iAMYGANM/PvE6mlH7Ui29zI11VAQkA5bL2LMX6D6jUQxdEBfcZwiUE1SZ2Zuq3N/yzWyXFlwgI49f/15uQgWsOYRGZIxAp+5Yq0FspCSPasAVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=i8/sQ+5y; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71fd55c0320so8713657b3.0
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Aug 2025 07:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755873639; x=1756478439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v3OogfFXdkMqRNtpkZ1fUtnIz6uf3uzEeX+PeKEs10Q=;
        b=i8/sQ+5yP0y5waScnpXxaiCGriykOo7dKLZBW/UVl2/Ox8nFmz4CaG8+8oE+MK9DeY
         v6rOsykQD7lN01mNwtBmg7G4Ge0ZfboOtXzDgQLPCAcT60JPjk5veoMzj/DpCKAwrZGg
         3wGmi6/rfhzIO+R3z5OPleQwzdZssNDN4nxOYWP1WAqfZotkcVkgYgRHOJ/Qo4DXJ4mj
         +cRhJWbAKLK73lQB09EE84bAZzw+u2m8HaTwjjmU6dcXhd6rJxCTZGJIjxyhnXCxjs/A
         ljjbtRaR/oreiI728cIm8TszR1f6Ug5cDYHBUb7RG9O1PUmdyaMLNtf903eMPfTzZJVe
         NHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755873639; x=1756478439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3OogfFXdkMqRNtpkZ1fUtnIz6uf3uzEeX+PeKEs10Q=;
        b=teugeBlU4JFOoqWvn7gjREmqbx9XVxGSry+ex/R4BG33U/23+/GJ2zF1xTQ9YEcBAg
         WZqYeD/Gmigozw5wIFJN6D4DhBWsoBA4OgDWf+GIhS9c3ywUSiZFb5kUn+j9nQZzb1DP
         Za2TEvfHZBLPb3Gt/BJz+TpATqVtERfh1X34Pf9kEd5kP9/Cc9A7/gZ0PPIWgWlkTnKj
         8gETEKF1lkFw6x+uvu8M9jrUBZnD/ZTH9zeCO6Ozyz9CeQWi9xkstoahlsCgCJUU2usC
         wCkHyBXDJsl6Jb/6O0DO4e4FdagucAnRsju9WLZpod9AwK1eIWSd8q4uQMTe49S1DcJ7
         7uLw==
X-Forwarded-Encrypted: i=1; AJvYcCUvO66HdxwlNurXDwEl+wCx3mErnBqpvgYDrstpm7i+fbJSY392tWpqz7LYCu0yJwwmIKGvNWqvR4FvWg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1kqeMMthwH+65gYB75Wy2ArP7eb67Iu6/t/Qxl3lvPkPvfhSu
	jhixHrXOeMSMGHgO/AGqvT0TTVFNQPyiHuo9dFfEZy6zk5dS09FCWT/dti5Pe+dtrHc=
X-Gm-Gg: ASbGncslQU3OHWQNlnA0qR2za6vOm9DWrkY6/uZ12BIocsuiOltwX2OU/2ezy23sOEO
	9CY1XMDn0KWNKJT6q9hFF0gdNE6Bw71+zjqBkG8Cau2lXJuZj4MYwG4jMusV24BBV7TF8RRZ0Xo
	8799waRy4LwiE/CD4nJ6bRDj1nhdy07CAuCsb+iutzwTp2OnEs+pd+v/hRFc4bXQlwoIHXVlqjf
	Pvg/KIe8IFG5AMLyc8iRCvUAuRQlnyO28uLAf0b4IiIpJ3BxRaY/1LVmznXPjzUj5tKYbq1Gjdg
	Rjhqaei3Pq42xA6ajZPVhpH2pzGrBsDz3SUUwNToiJRqudZwHwrIjtJCu0kSz0mq0dOeM/SSJOn
	9Mz8zk75F1Clt5S493WFy6AefsSRQ/eic7GDDdsjU/0dSugI1Ao/sLI9IjKM=
X-Google-Smtp-Source: AGHT+IHOy5Mb0Jt/cJA6ywQp6sLORvyAzia/tx+cqSm3UKE5FfWzv+W3sub+zG2wAFxqmQLGUh57tw==
X-Received: by 2002:a05:690c:6bc6:b0:71c:1754:26d0 with SMTP id 00721157ae682-71fc9c664f6mr55261597b3.6.1755873638329;
        Fri, 22 Aug 2025 07:40:38 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71fd92b885fsm6937457b3.10.2025.08.22.07.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 07:40:37 -0700 (PDT)
Date: Fri, 22 Aug 2025 10:40:36 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Sun YangKai <sunk67188@gmail.com>
Cc: brauner@kernel.org, kernel-team@fb.com, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 02/50] fs: make the i_state flags an enum
Message-ID: <20250822144036.GC927384@perftesting>
References: <02211105388c53dc68b7f4332f9b5649d5b66b71.1755806649.git.josef@toxicpanda.com>
 <3307530.5fSG56mABF@saltykitkat>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3307530.5fSG56mABF@saltykitkat>

On Fri, Aug 22, 2025 at 07:18:26PM +0800, Sun YangKai wrote:
> Hi Josef,
> 
> Sorry for the bothering, and I hope this isn't too far off-topic for the 
> current patch series discussion.
> 
> I recently learned about the x-macro trick and was wondering if it might be 
> suitable for use in this context since we are rewriting this. I'd appreciate 
> any thoughts or feedback on whether this approach could be applied here.
> 
> Thanks in advance for your insights!

That's super useful, thanks for that! Christian wants me to do it a different
way so I'm going to do that. But I'll definitely keep this in mind for code he
can't see ;).  Thanks,

Josef

