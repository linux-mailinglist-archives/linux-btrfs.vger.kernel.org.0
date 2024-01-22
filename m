Return-Path: <linux-btrfs+bounces-1625-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6956B837748
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 00:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBFFFB25DE7
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 23:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5243EA75;
	Mon, 22 Jan 2024 23:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Rb+4YSUj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32481364BB
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jan 2024 23:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705964496; cv=none; b=agowCbeIFxXisIm4NOQnnxJCZQ+fSzDRR0i/gAidPXF+vDRBo5V2SsKaS8sNOP/yqwZC+hybyKmgKAgNybIhjzQx5/A893B/Hn5XfQFqEAxuhjptDqfaRKT4VuQPQ0j0szcCwiImkmTkcNWe/e1W3uk86BCLQhFeMjZlD9Sv6xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705964496; c=relaxed/simple;
	bh=8cQOxzwWYJnNCmVmBs4ce9ATA/N4mz/+qpEV4kUBcOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H0aH1McaL00yEAMEVj4fWKXeUy3MBOHH/b+PRBTrek5EJHPy+ZklmEwMTYuIBplTn5PFxf1YnsKH22H94Kakz2zo7tS9flajHimuAwJ26IZRtJR712yVfOJ72qaMAMqk3UCVJVoNlVzE9KiK1XE+AA/RlEpuU9S0Zpk9gjpC2IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Rb+4YSUj; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e86a9fc4bso47708375e9.2
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Jan 2024 15:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705964492; x=1706569292; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TPlzJOHJ8wV3hedKz1a7v4FHImLT+aZ8tnfdq+8evgM=;
        b=Rb+4YSUjWdveoStXtotD3xXwIpIqsuOXpPCqkNYAKiZmRlDv7fZBwMjoPRIBI/d1+N
         Z41fnfedkU4+MU73dgdLoBiHs5+zIuLttQ3k29N1nU1k3jxvVt+1EMnaucXh2YP6Bsp8
         6J6na2OxokLFQc42/wpcHYJ7q/yKSr+x6p2rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705964492; x=1706569292;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPlzJOHJ8wV3hedKz1a7v4FHImLT+aZ8tnfdq+8evgM=;
        b=mZgu6MIbS4yAvYGTPdKGU8MI3y9EgFz1k0wzgEK34KSWM/v9kc4+A3Z96VTQEMlf39
         +FGrnC8KPJFYdTdzqXjXpSOVexAdKEfan/IrTrxeIb4AQJSyF1zg3R1IYlTLsM6JObZx
         Q5GozJbRPWKqZ2dUoIM/PqDfdg5oyKOn3zgoNQJZ6mlAeLnVH2c6UiMp0qoeMlXJDHZv
         5kJf130U6jQ4AnceSVErRqgTXlg9Kifb0oVMgG/p3r4Y+2DZRW8eZRbh4qYZPlXlGNGO
         AzMMInJ+60fNQTt5mn50r9aBPkUSc51vpGm9TdwcJyhhKcCaEsVi/HCsxKFYoXjQnLm+
         n7zw==
X-Gm-Message-State: AOJu0YwNo1vBJpCLuzBUeeNde8GCG/OJ3SsWqPBxrdV2Vz4Iy/es4/hn
	vxYtxUsVPnr/3EGiXgLWbjEkhNO7cqiKNE76zsCydx66qxuRbKBucP42pg+ZBLfmeCRUZq4vgGd
	iqmnHOw==
X-Google-Smtp-Source: AGHT+IFvpqnFKZaXRHJDIJOlXTNNaP3n8rj+HyTE8babGfhavYApJatA7+1PU6D3jv8l5mTadYtwQw==
X-Received: by 2002:a05:600c:224c:b0:40e:5c65:6880 with SMTP id a12-20020a05600c224c00b0040e5c656880mr2735353wmm.89.1705964492148;
        Mon, 22 Jan 2024 15:01:32 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id er25-20020a056402449900b0055a829811ddsm3799895edb.48.2024.01.22.15.01.31
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 15:01:31 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55a3a875f7fso4071024a12.3
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Jan 2024 15:01:31 -0800 (PST)
X-Received: by 2002:aa7:cfd2:0:b0:55a:9212:33d2 with SMTP id
 r18-20020aa7cfd2000000b0055a921233d2mr364232edy.26.1705964490997; Mon, 22 Jan
 2024 15:01:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705946889.git.dsterba@suse.com> <CAHk-=wgHDYsNm7CG3szZUotcNqE_w+ojcF+JG88gn5px7uNs0Q@mail.gmail.com>
 <CAHk-=wiroGW6OMrPXrFg8mxYJa+362XJTsD5HkHXUHffcMieAA@mail.gmail.com>
In-Reply-To: <CAHk-=wiroGW6OMrPXrFg8mxYJa+362XJTsD5HkHXUHffcMieAA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 22 Jan 2024 15:01:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjTVe-ZY5jd4tX4=rYEuuUVPECPU3_LvX9qu4nM8pd6_w@mail.gmail.com>
Message-ID: <CAHk-=wjTVe-ZY5jd4tX4=rYEuuUVPECPU3_LvX9qu4nM8pd6_w@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fixes for 6.8-rc2
To: David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 14:54, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Let me reboot to verify that at least my machine boots.

My tree with that commit reverted does indeed boot:

  Revert "btrfs: zstd: fix and simplify the inline extent decompression"

is working ok for me.

I do not think I have anything odd in my Kconfig, and I didn't see any
messages, and there is nothing logged either - just a hang at boot.

                Linus

