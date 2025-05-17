Return-Path: <linux-btrfs+bounces-14100-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE50ABAA6A
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 May 2025 15:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 500D13B2596
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 May 2025 13:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4E71FF7B4;
	Sat, 17 May 2025 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICI5qGKe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253331F462C
	for <linux-btrfs@vger.kernel.org>; Sat, 17 May 2025 13:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747488825; cv=none; b=Ho+ljk13g2aAymYrUX0pr72Ugk1wvYisQZ09K1bGkjaw4bIBl88F2vqIO5sBBO84L7QvgDrnJyRLcvhTyTY/kA/mVmoZ9Rn35jcbFrvrWmE+C6thPfTZTId77HWLqO4wgpHyudPxBgxm63HSmamU3vcfOhupxvXScLQKJ1IiC0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747488825; c=relaxed/simple;
	bh=TQDL01qL8fOBUZ+ljuJdk6OQ+Q3Aq2B1vOhU1mavCC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GkrddxF/3G9myHYAZ9kv2mygmEtC1GYOHkJHvza/NGL5RhFACF/0Z2z38BwdL3SUus9Sb2lsuPRIMBu/Rtqu1JN5AamM0/Hy0ExEhs10KHoIKW1Pa2ZwD92xXESnmgI7HbRUYM0SEIuyOgSg/5ftL/2OM8GMXOJ/E3IjgrDOM1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICI5qGKe; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-af5499ca131so348113a12.3
        for <linux-btrfs@vger.kernel.org>; Sat, 17 May 2025 06:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747488822; x=1748093622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEL1RTqnALAjBA919sbsOdDrfPAwHQfT89yZTE6xv+k=;
        b=ICI5qGKeuwQAvj5/Fxu4jGzoK1sVc5ALbBEsFPIKtyeFcWgpgpLQcCKh8X93ksn9A+
         6UBcU1erOKH/dBGHCSGjkZqzDmKr7xk8oZ8i/oYv/dwyHaE9B3YDey8gzKpMShqxyleD
         SZaZqcTml1zftU8KUamHkv4/bbHIDLy3kQlAoqflUQ9iI1z+SgMB7iiS4KdxbWpST3rg
         Qtpb59Z4d9vym0umZEce4jD+05y7P/GVegNvWTtUjEV99jps2zQ7KZVi59cAYM+hETGZ
         4JiItCPvwFYC8XNRTJEsjIht8D5GeFSbJcRaxgDdNK3ahkR+IalLhF8+ag/HEJ0LL2Vl
         aIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747488822; x=1748093622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEL1RTqnALAjBA919sbsOdDrfPAwHQfT89yZTE6xv+k=;
        b=SACAf3hudb2SWQVVB9niokOJ2HsKSxB759LACatpvHu5JpPpC9Zw75QQprjvsnoQAd
         6cF7bGDUu2aTRrLzHNEqXFNv0ABgViSFXQkAUAxa1ZDA7mD7GlGegBwJ/LBjH4MrgwMz
         /TeN3jcZtzYslEMpXAReyxVLwPzOggHGYcK7IwEEsPTs2HyYWQGB6FgyJnxo9W7o2PY2
         rPTYfYS3/f0VM86ztFzWsVn6+l3pWkOxZMZiRo0TMW6nj042giNmPXiVgKEnw6oYRo8F
         GKLtfZI1hYTG45w15Bwkx41Eyj8P4pCIQh5XS9JPSjxA9iEWzqh5LyIho454a7E2scnW
         7EdQ==
X-Gm-Message-State: AOJu0YwW7itSNlxzE0zoqVvLMuBqhSzrSL1byem3nmd1vDZh5H15buGG
	t9qHDoysRPoMb9JJGYVueYqDr01Ru6JDl0Ow9CpjG1+J20/0b0+kZPHS
X-Gm-Gg: ASbGncvNSf7KgV/8ZG92DnxJCohzxv0oBdaORq0lqpJBE6RDwdy9hmz150xzXX+NpxY
	+QEpgCFyWQpDy37W0hVG8GC4Arp1gRkihNASbshWMRIKgDh3BhF6/CZ0c7Ta6iwrEXRFL0Gl59k
	GdROBww987iNwMH4+eqib+K0L+wnO1wCcmAHT9j9RWSRKMAlFpIPyio78Mjbkx+WcLsSCnaFxTh
	zBPV+SkOZ2FbsOEM12U0XaZ4LH1IzJHReCRdRCE2dBVlV1UGQN3j/ugwYvcMw0Y4QzEqiZUFprD
	bW1df+34FV8s9oJA0C9SDcehKDFc0h1GcCxaXu2TsNkh9kqhMiemNnvggROrfO1s4LVIaw==
X-Google-Smtp-Source: AGHT+IFU+/p94NXyqqpwxtwE0kDiirnh/X8cOjOopORYY/aV727TuLMRCpZB/53DlLgA/rX6LM7Yog==
X-Received: by 2002:a17:90b:3e8e:b0:2ff:7b67:2358 with SMTP id 98e67ed59e1d1-30e7d505e1amr4140355a91.2.1747488822172;
        Sat, 17 May 2025 06:33:42 -0700 (PDT)
Received: from saltykitkat.localnet ([154.3.35.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e7d46f862sm3347396a91.6.2025.05.17.06.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 06:33:41 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
Subject:
 Re: [PATCH v2] btrfs: fix nonzero lowest level handling in
 btrfs_search_forward()
Date: Sat, 17 May 2025 21:33:37 +0800
Message-ID: <2803405.mvXUDI8C0e@saltykitkat>
In-Reply-To: <6048084.MhkbZ0Pkbq@saltykitkat>
References:
 <20250422125807.30218-1-sunk67188@gmail.com>
 <20250429152759.GD9140@twin.jikos.cz> <6048084.MhkbZ0Pkbq@saltykitkat>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

> > On Tue, Apr 29, 2025 at 02:57:02PM +0800, Sun YangKai wrote:
> > > Hi maintainers and community,
> > > 
> > > I'd like to request some feedback on this issue.
> > > 
> > > Is this behavior not considered a bug, or does it require further work?
> > > 
> > > Given that this issue never seems to be triggered in the current code
> > > base,
> > > perhaps we could consider cleaning up and removing the lowest_level
> > > related
> > > logic altogether?
> > 
> > I've looked at this a few times and I'm not decided what to do. It's an
> > old code and works given that we haven't seen any problems so removing
> > dead code makes sense. OTOH that one function does not pass some
> > values of parameters does not mean want to remove the implementation
> > completely. At least some assertions should be added to handle the
> > case(s) for the removed code if there's a new use.
> 
> Thank you for your kind reply.
> 
> The current implementation contains misleading functionality regarding non-
> zero lowest_level values. While the code appears to support customized path-
> >lowest_level cases, the actual handling of non-zero lowest_level values
> 
> contains critical flaws. This creates a false impression that the function
> can operate correctly under these conditions when in reality the
> implementation is invalid. The presence of this obsolete code path risks
> user confusion and potential misuse.
> 
> So I come up with some options about what we can do:
> 
> 1. (this is what this patch trying to do) Try to fix the wrong code and make
> this function work well on non-zero `path->lowest_level`. But since the
> non- zero lowest_level codepath is never used, maybe this just changes some
> dead code to prevent potential errors that may occur in the future.
> 
> 2. Since this function has never been called with non-zero
> path->lowest_level, we can safely eliminate the associated validation,
> permanently disregard the parameter, and explicitly document this behavior
> (always searching down to level 0) in comments. This simplifies the logic
> by removing obsolete dead code.
> 
> 3. Remove the dead code like 2, but add assertions when this function is
> called with a non-zero `path->lowest_path`. This can also prevent potential
> errors.
> 
> 4. Leave the code untouched, add a comment saying that never call this with
> a non-zero `path->lowest_level`.
> 
> Given its legacy status, there's no foreseeable requirement to retain
> non-zero level search capabilities in this code. So maybe option 2 is good
> enough.

Sorry I just found that I forget to cc the mail list in the last reply.

I will send a new patch later, maybe this version is better.

YangKai





