Return-Path: <linux-btrfs+bounces-11208-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 499DEA24C5A
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Feb 2025 01:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81541884438
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Feb 2025 00:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714BF1798F;
	Sun,  2 Feb 2025 00:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="H4YWNiKu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF38BE6C
	for <linux-btrfs@vger.kernel.org>; Sun,  2 Feb 2025 00:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738457929; cv=none; b=PiJT7UlTnooBHmo4Gx4/Nx0j1PSjXi8Lv4+RzZ3p+uFS6eYQ89baBBppU2/y1bJ3ienm/2Wh4MX0T6z2iakXwgrpkIVbQB7a7jtVMXJCB+qKdWvH02XOcF4X6to05fUaN455TxBL4SKpaDXTba0fiHbvGiE+EbWXS6m5a1FZ8tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738457929; c=relaxed/simple;
	bh=wTdxQSHNowLLmMobvaMcMprIsVZ+/hyqVnL+ii8pks8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HjI7xRe7UAJEVtMT9DVf6dQyHfvpDgwMdrJxkTc3S3Dsf9gVK6l3NOQ32UddTPRy0oXAT/J9ybsxSoe1MoT4r5jSWqtmfZUEnBx/onJNOmPUtraEhIL/yTMLEaPNKGPXKH9237bpc+UgXoSsUTtwGer4C39NRNObWz2+os5smHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=H4YWNiKu; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab2aea81cd8so576699766b.2
        for <linux-btrfs@vger.kernel.org>; Sat, 01 Feb 2025 16:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1738457925; x=1739062725; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0i2RBA9AG5RGJ2Y4fhUq4YhT8DGp5O3OFexnsh+308w=;
        b=H4YWNiKuJxm7svy3nGYkMeVz4s6fiiRqKR9K6yesIcZ8SCOeHWSIpWS7qZTeTjQ0/q
         e49p3+AVTZkDA7yy3/Ezviqv1XRWr7GUHH3BeCQ+iNfzl6NcgrDJ/mogP8OCfk0+3nFf
         xhJ2ve+ua06Mk3vSASa4cDdNAi3rvKeXcN79U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738457925; x=1739062725;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0i2RBA9AG5RGJ2Y4fhUq4YhT8DGp5O3OFexnsh+308w=;
        b=EcU+5UTwatzZ01pcYvktnRpHm+IGuYv2dldxdzbR2RJ+rbfAnukHnKDGfnreHDOGOK
         WJQ/Lx7ToHJxEKumzAEa22f4bvJjtJahpqb1VWRNsKYEJ1PRVEzYio5ma6Y1ZB3qgks2
         l4WlbUsqAI3pWIo7YRpdVhAKvCw8Jdu4H+RIiwZs7jqEnM6U+OLljCjUT3Zm/rILOwvq
         NPn4Dvw50R9itLfP2hSRSqnx69LMse1lssozeMHkVie+y3ZPNCCUWE7D2J7whCTQeL9i
         ocl2KxAIb+IWypFUk/9ftOalrl6Ua204FNP6H84E3LE0jxSFsaVMibrSfdoRrfUlMEFB
         i78Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnKvE9XXzuhHgCZUuj2QBw0YR0e2ZJhJ/eM2DK4ZbkK04TYg87L2eleLCkKrXzx/pE7BGdBLk1N+z8pA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0CHlb6PBucdzoLJLlGnmZzjNxh8TtdPBP4MIGc6gevcjReQ5g
	ONbS/p6wPQb+HdDU1dcXfWxrOIvD8OXxuXrc2MpgXfICipoT4elDZdjXO5dwoLsVW1JF/OT3BJQ
	bEdeD0A==
X-Gm-Gg: ASbGnctEI03dPGYEzWbVWoYywalDTObO6etIxtTbRdQvJqFfAsOHdxxyEGQiZqbtgYz
	16f8I3xb/wJ2L48iYPiE1ExKJW15sTlM1+meEW/c5i3Wl5PG/wsmbqsW02WIvs2X020Mmvq4Fi0
	J50X+Bf48ZE8wgRtGM5eWcLljWiw2rWy42EmkKjY+/lkU9SDrWNLQqt336YIiud3NS4cz5mYlp/
	Se45OpDhLs5ArTgi0OdCGvCKpebxlfY5dsQ6DMjztaHfGhBcThIlOyiW2scN0bSg0PjRKOkr0RA
	vx/DU/aIbguhY9V46REstyh/Y/yO5hb99+iyCGfmiIKwXlRhsedPuHr7QMkI8WWC8A==
X-Google-Smtp-Source: AGHT+IERRQ3y9Xz5zQQ/7e9EnVEmIY0W0YKePAps7xRUpBwwR86WeHiv2vLlV8mP2FVkAuWMImN0Ww==
X-Received: by 2002:a17:907:86a7:b0:ab6:dace:e763 with SMTP id a640c23a62f3a-ab6dacf0140mr1835490366b.38.1738457925423;
        Sat, 01 Feb 2025 16:58:45 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47a7ffasm500141666b.7.2025.02.01.16.58.43
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2025 16:58:44 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso2465394a12.3
        for <linux-btrfs@vger.kernel.org>; Sat, 01 Feb 2025 16:58:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWsDn5BUKwLhFbNMSraf4/o3TJTgdSuVubU6jNobFiNp6kF5mBQ/WcO8HRqHCUGj+D5tyDe0hbOB0P3XA==@vger.kernel.org
X-Received: by 2002:a05:6402:50ca:b0:5d9:a55:42ef with SMTP id
 4fb4d7f45d1cf-5dc5efc4586mr20023222a12.17.1738457922880; Sat, 01 Feb 2025
 16:58:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731684329.git.josef@toxicpanda.com> <9035b82cff08a3801cef3d06bbf2778b2e5a4dba.1731684329.git.josef@toxicpanda.com>
 <20250131121703.1e4d00a7.alex.williamson@redhat.com> <CAHk-=wjMPZ7htPTzxtF52-ZPShfFOQ4R-pHVxLO+pfOW5avC4Q@mail.gmail.com>
 <Z512mt1hmX5Jg7iH@x1.local> <20250201-legehennen-klopfen-2ab140dc0422@brauner>
In-Reply-To: <20250201-legehennen-klopfen-2ab140dc0422@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 1 Feb 2025 16:58:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi2pThSVY=zhO=ZKxViBj5QCRX-=AS2+rVknQgJnHXDFg@mail.gmail.com>
X-Gm-Features: AWEUYZkrc1rbpsukghJrnBMXjfiiupnnm33djYsyEN114ENNjNC4tG_tthCj53k
Message-ID: <CAHk-=wi2pThSVY=zhO=ZKxViBj5QCRX-=AS2+rVknQgJnHXDFg@mail.gmail.com>
Subject: Re: [REGRESSION] Re: [PATCH v8 15/19] mm: don't allow huge faults for
 files with pre content watches
To: Christian Brauner <brauner@kernel.org>
Cc: Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, amir73il@gmail.com, viro@zeniv.linux.org.uk, 
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-ext4@vger.kernel.org, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 1 Feb 2025 at 06:38, Christian Brauner <brauner@kernel.org> wrote:
>
> Ok, but those "device fds" aren't really device fds in the sense that
> they are character fds. They are regular files afaict from:
>
> vfio_device_open_file(struct vfio_device *device)
>
> (Well, it's actually worse as anon_inode_getfile() files don't have any
> mode at all but that's beside the point.)?
>
> In any case, I think you're right that such files would (accidently?)
> qualify for content watches afaict. So at least that should probably get
> FMODE_NONOTIFY.

Hmm. Can we just make all anon_inodes do that? I don't think you can
sanely have pre-content watches on anon-inodes, since you can't really
have access to them to _set_ the content watch from outside anyway..

In fact, maybe do it in alloc_file_pseudo()?

Amir / Josef?

              Linus

