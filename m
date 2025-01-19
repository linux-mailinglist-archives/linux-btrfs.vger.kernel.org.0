Return-Path: <linux-btrfs+bounces-11009-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD69A16408
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jan 2025 22:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979D41884646
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jan 2025 21:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68A21DF96F;
	Sun, 19 Jan 2025 21:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNtC52Hu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663DD3F9D2
	for <linux-btrfs@vger.kernel.org>; Sun, 19 Jan 2025 21:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737323423; cv=none; b=QDEZyob94y1wg5IdP+822eSclg2PS6yI6zhiq/87DjfvKK+GlM1NYFTtlVvhguaKXEw2Tpm2+TckstNceQ5LCANroZEwFNIfb4yzKRkaza6KCIhl4hygp5huNeVla0HOtklWoB/nuEn9683vo7p/QKjXkP54GdAdZ04Xhh4FpBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737323423; c=relaxed/simple;
	bh=xjOcdorRFt++U+S6Nop6Fw6U3HmwWlt+jjNzzR92nr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PyPIFakE9OmBTjesXvg+9F2TAu3O15MxAVL7CqQ8T+Rptu/dx/G6wetAsQ2hShNV1x1itffW3QqwKXemvor6MgxH4YwshmeB0feGNhaUOHFidHr72k82KyZKzbh5rE55TV+BtCrh9dj2rq+R8Ni6nz6ZdYArgBWm4cYdh9tvNxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNtC52Hu; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e39779a268bso5697164276.1
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jan 2025 13:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737323421; x=1737928221; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xjOcdorRFt++U+S6Nop6Fw6U3HmwWlt+jjNzzR92nr8=;
        b=CNtC52HupN2G6fuMRjs1FdRjYOD7nx6EOmapq5Uxri2WEwgZsemHP9fB3Ebv0xa6lK
         wFVaHk4SeWV0g8xDdQhysc/d6MzCKJXZHPIXHCtUFa4bBGwUf85dbdfOxkR3c6KjTF3Q
         ZhhGkP84YG7nvt8rsqiRkvA72Mb8qU/db2WGyXX3QZFEInXFvuQVj4wankZhbcnd8dTy
         hGlA3S6VsaKTIX15CRZmIZrvDDWMpwhfjhVYHPon/q+98Jv6MAyXCjAjkkXuCJMrcpLx
         iNAx9ycDAOrqnAcvXKObYQOHirahXK7dHuK1PZFQPElpY2C+ipOuAgGeyOCASIdKO++Y
         bEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737323421; x=1737928221;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xjOcdorRFt++U+S6Nop6Fw6U3HmwWlt+jjNzzR92nr8=;
        b=BIqXJ7n3S+df+74YlI+/djR76zMpt6CuwJ5p+ImzwS+5tfjXCSToNha7G7za8ks4KJ
         OH64lt3FG8KdlaMSHCmYVo5hCv2wtyBd3t5y0L3kKFlau2cyZ/VCWEBTpAOUhBuOjuSw
         c9QOM/Lg/MrAnvbO21KwsSOoQ7dIASccmDmXx+h7O1PlW7N6K7qygXRgyYBF8TRmO5Lz
         AqnfnwyQ64bktmYSCecZxH6QAW+H7/EBO2xHZyGt/81j+aIbHWrqviAvnPMXccqfLs8F
         ScnMGT5hIeyMrjXx2896Ghppm4Nv644tsdblOZ1CdjPXDa2RBR75Bgq1SXbaBxU/Tjuw
         CyiQ==
X-Gm-Message-State: AOJu0YwdyVjKk7LJaHj4RqjYGseg69XW52nYiei/WA+K+OM0wIzVyxed
	ClmaBlpdTXFMA5rWMXaMpyGCa0CvcMpQAJ4nwmUsZt3Tf0ZDLAHPCaw4My4s1PBrjFyWU93Q/98
	E0MbRgtMceuGWAxm8QLqbNWXm5jWVX5JQ
X-Gm-Gg: ASbGncvfjF4H/UEaLcfKzj9986I80M7ksejXH2spIJuvkmgsA961P4nB/D9AkOK3M0A
	BDShOu+Wz/OQLjMWQrZWMyZlLteGPbZ0wzcKOtMzP9vv1LfPHJzw=
X-Google-Smtp-Source: AGHT+IGAB1cIPngB1X1iH3mKLnVYW8eLj5XvmSp166XcY+xHUO6tF3GDHQYtnyqgV2rrAj8S/AcDq7U3V6Q9SZYx01w=
X-Received: by 2002:a25:ce53:0:b0:e57:3165:296a with SMTP id
 3f1490d57ef6-e578a27234dmr14944311276.22.1737323421227; Sun, 19 Jan 2025
 13:50:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGdWbB4zZ4Xz2r7WSkC+2xt8umXn3jP6Gg43t7e8REbjJ2iioA@mail.gmail.com>
 <43f5b804-d18e-4bd6-8c19-08b4c688307c@gmx.com> <CAGdWbB6A5S7-+VM9HsPyb=5FMTqOSb3GVCzS+ix0vvRg3sfJ5g@mail.gmail.com>
 <34c2418a-c08e-4408-bf6e-3216d6b64ea3@gmx.com> <CAGdWbB7tFj_CT_XGEb0egRF+pDqB9+bVeP-Y1643y0WvsMcfMg@mail.gmail.com>
 <b2267eca-5528-4cec-8956-d0f666f79c9c@gmx.com> <CAGdWbB46VJrjDMUxcNmeXsAfxq+YCD52v4pKcHK7OjpRpgc8rA@mail.gmail.com>
 <cf1b590c-6ffa-4c92-bc39-7d72a4282d28@gmx.com>
In-Reply-To: <cf1b590c-6ffa-4c92-bc39-7d72a4282d28@gmx.com>
From: Dave T <davestechshop@gmail.com>
Date: Sun, 19 Jan 2025 16:50:10 -0500
X-Gm-Features: AbW1kvbVCLqYtoiZeIIMUx5yGlfSDH36H5cCYOXgCzAoZuSUzfIBCzGnV-HfuQM
Message-ID: <CAGdWbB5CfN_0i5u2iofPp1Wred9Kq5OsR6F6Q6uOKpnD4PR3Ow@mail.gmail.com>
Subject: Re: BTRFS critical: unable to find chunk map for logical
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

> > The laptop doesn't have ECC RAM. Is it even worth it to run memtest?
>
> Still recommended, as if it's really bad RAM and it's soldered, you
> should make sure that you didn't run btrfs check --repair, which is a
> dangerous operation with possible unreliable memory.

That was good advice! Thanks.
I'm glad I listened to it. The laptop has bad memory. It failed the memtest.

It is soldered, but I'll check with some repair shops.

