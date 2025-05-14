Return-Path: <linux-btrfs+bounces-13995-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80147AB682E
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 11:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 649BD7AEB3A
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 09:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F69F2627E9;
	Wed, 14 May 2025 09:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UUXeOEWm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B5126AC3
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 09:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747216573; cv=none; b=gSpB0ykIcOHxc4/3HcGc8fqmF5cldmFATk5MGqPuxfNDiL4wcgqFPXZ16I5lTN2UXpbyZ5mq4iJ1SKXQxoqQDA9bACoxsZ4yDU2QuJ+pxepnqtIuFsqeaG+N8ewa1GtmJ9d5c32l7G4ZJjftpZvkgy7On+jvE7IviI16i7xb3Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747216573; c=relaxed/simple;
	bh=7pZWUFb9HmQvHOr67mlD8XeHdJuE9CJ02sKRMD4EOMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UknikVWMX11hGxgtT9m6Q59nlp3WXUYPhu8ZYmWLog/L62cfTK2KkjsXEw6e9dVcBl5whdjRQcIXAQ95b8ELID55xfrVX70mcgh09dewXzOPaXZsWPO78Iip750QDe+EXleYKfqDnv/GgFdlwWtQwyM6rSe7mwq1Kp/Bl4mYvZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UUXeOEWm; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ad4ffb005d8so73312966b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 02:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747216569; x=1747821369; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7pZWUFb9HmQvHOr67mlD8XeHdJuE9CJ02sKRMD4EOMw=;
        b=UUXeOEWmm/XXf9FOq4cN6hBj9AHk0QZD8gJ+Nu6CGdU3nVEYpQV1SsO6TbSpThS+0M
         LZzMZCOTJhPYc+Vd5dmCDDE6g8NW+NAaLvi3TivY6TIk/pgrXLhDJBJW38nUqruLT5AI
         xCakQQ4kwAAB6ZnVudByxxwI00Q5pemvcVKt7MSWxZgTNa0JR8ZAGYd3/nj1By6uhS4L
         zElfywdc7qr2FYjVpGGrnuchzLXHWGVEW9yagBfLABZR5AxaTXyBh8nLjOF6Ta2+TsoG
         jeX72nRcPEEQNTJ7lioI9v5ZCSAOiuEcC227g1I9kaLIF/EQG+55b0I4yGqkjYwU0q2b
         2OIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747216569; x=1747821369;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7pZWUFb9HmQvHOr67mlD8XeHdJuE9CJ02sKRMD4EOMw=;
        b=wRxJEdY58CiLL9ypbIlZpYxyb6CIDL4ZgYruBHVoHhK0T9kcYVeNocQS7QK9PsvGi9
         VT01Mt9ia4RjgTy5YFBoYKTQqq/e4JNc53DbK3tgn5939YBAMbVpZIjPoNVwKmIpBwtA
         jxQvjjW3M4hae9jDXM3TQExnfXMOAGiuw5rEQvsRStdpieHqg8IsQDC+rfV3ghDSBZrT
         u2es+aO2KidA3QM3E4iuFIHWjxDzHpgN/VwCVIB1kTxaORdBp0lz9G8sxQkaJh5yvs4P
         7Iex2WjTl/xJ7VPlMmFgIZLCfaQb1jRhzXREVjVMKxYbF8Tcjp9w+QofFcDempgNtXEm
         Yj4A==
X-Forwarded-Encrypted: i=1; AJvYcCUdQ8C0ldaTuQKjuHTJmu6jbLw6m473Hzh4wAHIVLB2wHjCHsm1GJDv/fDBsecTrDsqTThKJ5tNoCIVaA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7VKsROPC9LV8RPBU9xQNRgrCoWD5E42qtpmAZnlS5Bk/5QMA6
	utyimjZDARZnVzmfKdgSuhIj93Qwl2GZisczXpifiwoPHc5M+vIJMywO1QVbDnOo2oW/DxPuq38
	1PGK5cEG2xoTN3SqmgsFjNsIobDni6kWF0ne3+Q==
X-Gm-Gg: ASbGncuJr8jc2S6Pfhtw40N7iFspdREZfrviV/pK7k+F4YAJX5pKlmaK6jEoP611Yft
	thS1LOy2Hyqg+pIe5FMt2o8T1gtR3dpDy0cgOwBfMgz3SifLTQFycCVbLobM96qDW7Bg7qNgcqr
	CU87tP+XcTKf7k4DHG83YsVzr42bsSCoA=
X-Google-Smtp-Source: AGHT+IF40a6Z0554V4pGLebUeFU/ySRMLQkenNnwyYHmdPAZa+WyLPu0lLBNkCojqP8ZMyuFEdH5HF15VUaevHbQCWs=
X-Received: by 2002:a17:907:728a:b0:ace:3a1b:d3d with SMTP id
 a640c23a62f3a-ad4f70d41femr281384366b.2.1747216569424; Wed, 14 May 2025
 02:56:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512172321.3004779-1-neelx@suse.com> <20250512202054.GX9140@twin.jikos.cz>
 <CAPjX3Fe1izCGUJhTWk1mB=9uK7kNHeCOj51_TZQG7DOe_aooig@mail.gmail.com> <20250513171039.GC9140@twin.jikos.cz>
In-Reply-To: <20250513171039.GC9140@twin.jikos.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 14 May 2025 11:55:58 +0200
X-Gm-Features: AX0GCFuBxnVKslCn40-HTNQff2wu26HSsjEL8fSwRFHyPOgr2Q8bBPvLqdwa1N4
Message-ID: <CAPjX3FfhfYGdMJLi4KLKnTd9BdhMLzScxtN0KKQxwYQ8JScxjg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: index buffer_tree using node size
To: dsterba@suse.cz
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 May 2025 at 19:10, David Sterba <dsterba@suse.cz> wrote:
>
> On Tue, May 13, 2025 at 09:56:19AM +0200, Daniel Vacek wrote:
> > On Mon, 12 May 2025 at 22:20, David Sterba <dsterba@suse.cz> wrote:
> > >
> > > On Mon, May 12, 2025 at 07:23:20PM +0200, Daniel Vacek wrote:
> > > > So far we are deriving the buffer tree index using the sector size. But each
> > > > extent buffer covers multiple sectors. This makes the buffer tree rather sparse.
> > > >
> > > > For example the typical and quite common configuration uses sector size of 4KiB
> > > > and node size of 16KiB. In this case it means the buffer tree is using up to
> > > > the maximum of 25% of it's slots. Or in other words at least 75% of the tree
> > > > slots are wasted as never used.
> > > >
> > > > We can score significant memory savings on the required tree nodes by indexing
> > > > the tree using the node size instead. As a result far less slots are wasted
> > > > and the tree can now use up to all 100% of it's slots this way.
> > >
> > > This looks interesting. Is there a way to get xarray stats? I don't see
> > > anything in the public API, e.g. depth, fanout, slack per level. For
> > > debugging purposes we can put it to sysfs or as syslog message,
> > > eventually as non-debugging output to commit_stats.
> >
> > I'm using a python script in crash (even live on my laptop). I believe
> > you could do the same in dragon. Though that's not the runtime stats
> > you described. And I don't really think it's worth it.
>
> How come you don't think it's worth it? You claim some numbers and we
> don't have a way to verify that or gather on various setups or
> workloads. I'd be interested in the numbers also to better understand
> how xarray performs with the extent buffers but I don't now how to write
> the analysis scripts in any of the tools, nor have time for that.

Well, xarray behaves as a generic radix tree. That's basic theory. It
is just a tool. A tool you know. You know how it works, what it is
good for and what to expect from it. That's why you decide to use it,
right?

I only claim, we're now limited to using 16 slots per node (mistakenly
skipping every 3 out of 4 slots as we're not using the last 2 bits
from the index) and this can be quite simply fixed by correct indexing
and we can use the xarray correctly. Basically we're not using the
tool correctly at the moment and we are using it very inefficiently. I
believe you can see that. So far so good, right?
No stats would explain it better than this. This is already the best
information you can get to describe, depict and understand the issue,
IMO.

In my experience, sometimes more stats can be misleading or
misinterpreted. Even by kernel engineers. Sometimes the stats can be
confusing or even not really relevant. So it's better to focus on the
right facts for the given issue.

And I also believe there is a reason xarray does not provide or even
keep any stats. What for? Would users need it? Would they benefit? Do
you care about any tree stats on your cell phone? I quite doubt so.
And kernel would be doing additional work just to keep the stats for
no use. That would also be inefficient and useless overhead.
Perhaps if it was an optional feature only for debug builds, maybe
useful during the development process??? But even then, you already
know you need to use this tool. And if you don't implement it from
scratch and you rather use the one kernel provides, you also know it
already works the best it can. In the end it's just a plain radix
tree.

Looking at it the other way around. The fact that xarray does not
provide any stats perhaps means no one really needed that so far? It
won't be that hard to implement if someone really needed it.
So why is it not there already? Maybe it would be just an additional
overhead which seems not justified so far, considering the feature is
still not implemented.
And IMO, that fact itself that it's still not implemented is also a
very good hint that it does not make much sense to really check.
Either it's the right tool for you no matter how the stats would end
up, or you need a different tool.

Now if you'd like some numbers to refresh how radix trees behave in
general, I can show the numbers I pulled yday for Filipe as he was
also curious. I'm going to be rather brief below, for further details
check my other email.

So for a radix tree, the height as well as the width of the tree are
fully determined by the maximal index. The one implemented in kernel
grows and shrinks accordingly. All the leaves are on the same/last
level. In a sense the leaves are kinda 'flat'.
Checking my /home fs on the lap I'm now writing from, the max
buffer_radix index at the moment was 4341c9c which means 5 levels.
Xarray uses radix 64 which means each 6 bits of index need a new tree
level. Now, since we're filling the last 2 bits of index with zeroes
(well, depending on the eb->start offset/alignment maybe some other
constant, but still a constant) we're effectively using only 4 bits
for the last (leaf) level. That's why we fill the leaves only up to
25% tops (provided the ebs densely follow each other). Of course we
don't always allocate all ebs, so the tree can be sparse by design.
But that's still OK, that's what we want. But...
We also make the tree needlessly wider than what would be optimal.
Correctly (what this patch does) we should get rid of the 2
constant/redundant index bits: 4341c9c >> 2 = 10d0727. See? Now the
width of the tree would be 10d0727 instead of 4341c9c. It's still the
same 5 levels of height, but it's now much more narrow/dense.
Depending on how sparse the tree is some nodes can be merged to one
this way. In theory up to 4, but again - that depends on how dense or
sparse the tree is to begin with.
The difference really is that the tree will not use more nodes than
needed which unfortunately can happen without the fix as the tree is
additionally filled with a thin air.

Out of curiosity I also checked how many ebs were actually present and
how many leaves were used in the tree. For this FS it was 13k of ebs
fitted in 4150 leaf nodes. So on average a bit over 3 ebs per leaf.
I'd estimate that with the fix we can get in a ballpark of 7-9 ebs per
leaf. Maybe something like 1600 leaves instead of 4150 for the same
13k ebs. IMO, that's a very nice win indeed.
The worst case would be no change. But the tree is not that sparse really.

Now imagine, if you wanted to use the rb tree here, you'd need 13k
tree nodes, but they'd be embedded in the ebs themselves. But the tree
height would be something like 14-28 depending on balancing.

In terms of used memory, for this example the rb tree would use about
300KB while the xarray could be estimated to about 900KB with this
patch (using 2.4MB now). That's if I estimate 1.5 megs saved by the
fix. That's the difference between using the tree correctly and
incorrectly.
And even if the estimation is not exact, we'll always get at least some savings.

Hopefully this gives you a better picture to satisfy your curiosity.

