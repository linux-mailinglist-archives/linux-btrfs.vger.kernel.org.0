Return-Path: <linux-btrfs+bounces-20212-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A414CFFC49
	for <lists+linux-btrfs@lfdr.de>; Wed, 07 Jan 2026 20:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11D3930A50E7
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jan 2026 18:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A21346AE9;
	Wed,  7 Jan 2026 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1/Vk0Y3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D7726F29C
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Jan 2026 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767807967; cv=none; b=N8f969mD5KkVeuWzba/MT3e9kEOnvRfUKJ+k5ZYlcfkkHl2erkezD0VXXTfFFS8+Ok23BLpRFUG70rBXjAOxLbQF/1ZEk30YKO9uh6CHWA4JqfsxjnlYUkbe0W4UUc75ddw2mjV6KYmwPR1+33hM+1xv8xg9ivBNZbRexv0yvRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767807967; c=relaxed/simple;
	bh=qileGSf2c7ijmYzCuIc/EYVYDbMSNUHL9+gNmFw/7Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQWGgffx4k4gieZbaLrws127fFnW4AK5xc8JVBxMVv97Obh4LVDD31KBGBgWrmUObWYDe3ipKofBvg1Zf1diZrU3yRjHMTHXnCBL2+i4PdASV+KKS05dapG7zkPcJlRen35hYADwOML13noF3TDaQd//cPjX07pSiGQSV32oUWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1/Vk0Y3; arc=none smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-6446704997cso2037687d50.2
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jan 2026 09:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767807951; x=1768412751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07ypZOUFUGEXXmt2EssDaX9DCT/Cq3jKiLjKniS0MwA=;
        b=M1/Vk0Y314l9hUwgD6wLATQMdd93XLuG/zMJHX0dGyzO+pWQmhDCW0Of3C8ULlVxDh
         8zq3oAK6qD0eknLIYj4fWD+Ex5uFRbcAioOOq4nt4YQxTRQ1qJxfqKHDtH5OxSFk+pbh
         NieF7AhTPaJD9KWhkC0C3VtjH6UIUDQn7x/Ufofoeu9m882oe2dYKoCR49gPwKjHmvJN
         hT7huZ4K/7VlweS5M6rnXqw+jjw5Q24CRYjtZW/nLyDG5h0EZaL2LM9sAWHooHkFCWm8
         mEm27OjKWMXzgcGkCvVWCMWb+B54ryf8m/eswRCSE/qRQfb4hWeP2XKzx/l2k6Gv2Yom
         B1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767807951; x=1768412751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=07ypZOUFUGEXXmt2EssDaX9DCT/Cq3jKiLjKniS0MwA=;
        b=D2bN4oY7eAR+dXhixc3SuLgg15EF/P5H8fx1KVga3exYUwdOPzCqIibLOibY3+88+b
         dLOgqkON5RrKAP3Y3WrHx2J9xuXyw9qB146O+Q18u4S07RDs1EdDxZcPM6WLEfAMRaLj
         khE1XXllj01rZHeC6/hQLOYgI8yAjtZ4M943FHf3Qc8WSCy/nyDkonaKfpDvFquNHQVZ
         6CO1Tb6p1ZY1LSCJFK1L+RHXPenU1WuDJmiv4HvWqjSzpGqwdTKZfD7jHwFBFqpEQY98
         5jruhHUicNNBIFiobG8OlRRpCezjeCPj3ErU/CBk9JZd0TI6S+UG0XHW+a9fEzJwcsB4
         vDxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvODmRBp7edcOIziReOFquqyAEVHPL4teMvP0JZWtfcjhcUUpRmD+xxG5ukWViBUjvYdZ8IPrHqXPOWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrjQ6yAwT1ghOoeJn7K3Vh9uuOoFYb+CdFI9u3Q9p7TCkm6a4l
	DRgK0/EBoovZohH+Wg+DAK8+NhtQSf/7L3n8urhw2TOM3dtcytxPWxDo
X-Gm-Gg: AY/fxX67V6HRXJU/NjA2OkaOukKlzwB8N/22oz80Cbq1xBMORgBAT0VM6KMvcnU+vuq
	sfwvDKGzQEnOtwQYqzO5S5/3bRoB7HJ4nEq5QKNltoyHvhW/y888MiwtqC2bZTyxi+vQ/JnGEjV
	hja5znmo4NUY3O4wVySha8s4Bcvkpl+q2drEw87omrNx13lbXWMXl9B5rGScc8dLgYnXJ0lzeZh
	oDh1p+R77KlH2pTJBkQ9bhSRwWvW1rn31LHoak6z7RegJJJ06nBZD5trGvOTm/7nWxW4JiZ+tAD
	tlFmadHY/lqi0E+/QRdJW4dMXJqo7VDAu/3CMi1ktE9XTrTDVxiUk67itFxDSRfNonrFx7jdadh
	h4i5AZW9qg7RH6UmJR9cgYl3HYCzaf1NPtBXcyaXr7/Oy7fb+9eLj+NJ3ggdkoKRsbIjWh4kyCj
	dZznpdnQEYP47sg4c32g==
X-Google-Smtp-Source: AGHT+IGe8EGyArCaPl6GeiH6SavSmbbiVzVu/Bk+lLN8nQq1AiFyxt9JzdYvdO+sL6LB5P6YV/OBpw==
X-Received: by 2002:a05:690e:58a:b0:63f:9448:e81 with SMTP id 956f58d0204a3-64716baea7fmr2229980d50.39.1767807950666;
        Wed, 07 Jan 2026 09:45:50 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:44::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d89d4fasm2292246d50.15.2026.01.07.09.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 09:45:50 -0800 (PST)
From: Leo Martins <loemra.dev@gmail.com>
To: Christian Heusel <christian@heusel.eu>
Cc: Gideon Farrell <gideon@solnickfarrell.co.uk>,
	linux-btrfs@vger.kernel.org,
	regressions@lists.linux.dev,
	arch-devops@lists.archlinux.org
Subject: Re: refcount_warn_saturate in __btrfs_release_delayed_node for 6.18.2-arch2-1
Date: Wed,  7 Jan 2026 09:45:38 -0800
Message-ID: <20260107174547.3875297-1-loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <584c770b-8e59-457c-a8a4-0f9630ec9635@heusel.eu>
References: 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 7 Jan 2026 14:15:56 +0100 Christian Heusel <christian@heusel.eu> wrote:

> On 26/01/07 02:52AM, Christian Heusel wrote:
> > On 26/01/06 05:10PM, Leo Martins wrote:
> > > On Tue, 06 Jan 2026 22:01:58 +0000 "Gideon Farrell" <gideon@solnickfarrell.co.uk> wrote:
> > > 
> > > > Hi there,
> > > > 
> > > > I recently experienced a type of crash I haven't seen before on this system which seems to originate in __btrfs_release_delayed_node on Kernel 6.18.2-arch2-1.
> > > 
> > > Hey, thanks for the report. This looks very similar to a different
> > > report that has been fixed in 6.19-rc5.
> > > Report: https://lore.kernel.org/oe-lkp/202511262228.6dda231e-lkp@intel.com/
> > 
> > I think this is the issue we have been seeing on the Arch Linux
> > infrastructure aswell, see this issue for reference:
> > 
> > https://gitlab.archlinux.org/archlinux/infrastructure/-/issues/788#note_385420
> > 
> > This has caused us to downgrade the kernel on all hosts in our
> > infrastructure due to the crashes caused by this.
> > 
> > > Fix: https://lore.kernel.org/linux-btrfs/7c89417ac3352ce3cb0a6373a1746155c1e2754d.1765588168.git.loemra.dev@gmail.com/
> > > 
> > > Please let me know if this fixes your issue.
> > 
> > So far we have not found a good lab-setting to reproduce the issue
> > outside of the production machines workloads (but we have also not
> > looked into the issue a lot).
> > 
> > Do you have a good reproducer already that we could use to verify the
> > fix?

I believe the lkp-test from the original report is able to consistently
reproduce this.

> > 
> > Also the fix is not yet even scheduled for inclusion in the stable
> > trees, since it is still not in linus tree right?
> 
> Sorry, I messed up here! I got fooled by the output of `git log --grep`
> and therefore missed the commit! As pointed out by heftig on gitlab the
> commit already is present in 6.18.3 which I'll try to roll out to our
> systems shortly! :)

Let me know if you're still seeing any issues after rolling out the fix.

Thanks,
Leo Martins.

> 
> > 
> > > 
> > > > 
> > > > Here's the stack trace:
> > > > 
> > > > ```
> > > 
> > > Are these the first refcount_t: warnings in your dmesg? I would
> > > expect an earlier warning that looks like
> > > refcount_t: addition on 0; use-after-free.
> > > 
> > 
> > This is what our stacktrace looks like:
> > 
> > [...]
> > 
> > Cheers,
> > Chris
> 
> 
> 

