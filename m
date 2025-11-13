Return-Path: <linux-btrfs+bounces-18945-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAD3C576EE
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 13:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50C1C3B402F
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 12:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673B4332ED9;
	Thu, 13 Nov 2025 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Igr4Hvdq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6820F44C8F
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 12:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763037053; cv=none; b=afB+36r9M7sBnj7X492b1Be/R3VLISLTLcSJr0jNJgFX0CGpkGDW5kab89WNo7u9gbIJ/oWJg6ZRGlvm4HBHbWhCaV5VuLpQj9AOgPnmuEewMjhaSBLqJO7ffY7mq9thUTinMCp5rt9DlRe3V1HhrXIPkZZWSDIPwI3NCi/dsPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763037053; c=relaxed/simple;
	bh=A2fhQ2/KBTrdnYDye7ghdl7QYaygI+ZGlpMm/6JoSiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ketoQbYBdRNvdpiwOtXWQLBw/v09L7VTVdV8pSCOoGn2m0dENWEZX/3KQKN0tRtNtCWDTd/afFEPXljl1dO1lJrYJcThAy6pLQGWlQjzCRtxZhytbAobGW4/8EG43njfiKDYiw5uSDaKBY+pbpnP3tGND+V8n0AjH77d701eZ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Igr4Hvdq; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47728f914a4so4956475e9.1
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 04:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763037050; x=1763641850; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qrCwq6g4qJ/eiWE4fzuFVPtWBnMqMIh/+G4br43U4t8=;
        b=Igr4Hvdq83KyJzV6IpXDIs8z7CZRkbeYtcQIb6QRjROzm8gdya26/bp0ldBZQMhYAL
         DPjPY9Arvoa4DFOdiLTXPVi06zaa5nR+hpExix/ojlKzxGJgwJBD84LWwL0SqQuCoi8E
         qMQsDvpoFnYVhoXrVuVoK/L28Dv2EdzKSCpY6skLzJUonZS+L+2vPlKDBq9oPbHSoY63
         uzpf3U59mK3NjZuIQxlxhw6Xrpc9gnqxfgL29AEyh4o///6tRrTTaLlSk1+X65gMNwhZ
         17ScG+9OjjNi9lC+DbkkTGj6n9Qdx8xb8uF6CcMstaDqJWdROQjXeDERrBx0QZBmAqzi
         uSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763037050; x=1763641850;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrCwq6g4qJ/eiWE4fzuFVPtWBnMqMIh/+G4br43U4t8=;
        b=FRNND6fwX/enyE82ef743iR+ClcTL9c61sThf52RsxGv7mTzECFhwft6Bwlwb8RHpk
         nH/AI9+W0j0ewYHa3FVA2m+Z81tCvD4S6U2Tsq3tjngnIn4mWJtrTY6USmgvwq7dpkrU
         KtGXkCwepnHKy1562Kwxonv3NDrRgQ7DKWz7OCQtVC2IIBMHdseqeGpDz7wHvOZ/rH4E
         EJtamErspD2n6JWsQSOaho7xanoqp/EVvftrnA+Lfbb6s/OuyOAGDTpPXBNU5GxB6uhP
         sCG7gcjOI6h1AdjXqxcAnrWhqBTVEdudH6lHobKYLFF42wrEvlWkwYZH+9c0gTuQFz5y
         Lhrg==
X-Forwarded-Encrypted: i=1; AJvYcCVj2DuTMVoDAjwphooqCLvgervCnLoP5iKVMuiDYCIZfRAeSlaK+Hya0LM37iOFAH0k2sp6sWe7ZyBiLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLD040v5mA2AuW3MQQ/IuxsaWXkMgYlUmYnjFVUffje7IYMTLK
	Os6JfX72DQGluXjX65o7I/a+0Q/6BxkB3NxWDvInHhO7XEnmo5D47VckMemnzMbV35cO7Zu3UIN
	OUa3wQ1SjLXppdiclIK1nZhfVuMY3dOGbMjUu2BskpIis6vLpFvrTGxs=
X-Gm-Gg: ASbGncs0byZjJsPwbZAjEHVb72vzgZoqh6qNicFeiJs82De3tRGL/GURY0gS2k9IzSJ
	R5ZtnCWGIbjS+1o5u0mS8XLt17eiBHeIlPmGB8F9pGwzm3grrl2aRx2vGvkoT+CUWlBeAlpw00T
	nz36I2TtX/a40T9oGEiNAthIklXOX7ip2ineMxeJoIvlJ2L24WfY7nINJ/Yq3d67tkRBnxS6thB
	i2dDiTF2MDZmMZlEBWfzaHXuCrnFQsbLTC7oL7srn2Gc+RnCJslhr3E99dSWytXGSTCrBKLsjPB
	5iHH/BPRVmokwGC4BxhN/i75SYZggS/5YmWxZ09/3oS27S/JiejvY/NLVg==
X-Google-Smtp-Source: AGHT+IHiAAHAOq5J8r/kHDgff+Eb6mU47kysXO0Bq+GkER/xA2+JNPCnRYlxP4yd+QacdC6d3J5CDnv10Ii/0ybdHkY=
X-Received: by 2002:a05:600c:138b:b0:46d:ba6d:65bb with SMTP id
 5b1f17b1804b1-477870c31c4mr62295625e9.31.1763037049738; Thu, 13 Nov 2025
 04:30:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1762972845.git.foxido@foxido.dev> <c7abcfeb7e549bf5ad9861044c97b9a111d64370.1762972845.git.foxido@foxido.dev>
 <20251113084323.GG13846@twin.jikos.cz> <35e1977e-7cca-4ea3-9df8-0a2b43bc0f85@foxido.dev>
 <20251113112514.GN13846@suse.cz>
In-Reply-To: <20251113112514.GN13846@suse.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 13 Nov 2025 13:30:38 +0100
X-Gm-Features: AWmQ_blnxNnvDzEZMqTYwUC-BTC_2Ojhag6zmMej5SMBzsbJu-YcbvcQwXN-4lM
Message-ID: <CAPjX3Fed9D1wdjvLyhXq5MB2aKOtUPsxx7gaEM_81q32hgnKtQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/8] btrfs: simplify function protections with guards
To: dsterba@suse.cz
Cc: Gladyshev Ilya <foxido@foxido.dev>, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Nov 2025 at 12:25, David Sterba <dsterba@suse.cz> wrote:
>
> On Thu, Nov 13, 2025 at 01:06:42PM +0300, Gladyshev Ilya wrote:
> > On 11/13/25 11:43, David Sterba wrote:
> > > On Wed, Nov 12, 2025 at 09:49:40PM +0300, Gladyshev Ilya wrote:
> > >> Replaces cases like
> > >>
> > >> void foo() {
> > >>      spin_lock(&lock);
> > >>      ... some code ...
> > >>      spin_unlock(&lock)
> > >> }
> > >>
> > >> with
> > >>
> > >> void foo() {
> > >>      guard(spinlock)(&lock);
> > >>      ... some code ...
> > >> }
> > >>
> > >> While it doesn't has any measurable impact,
> > >
> > > There is impact, as Daniel mentioned elsewhere, this also adds the
> > > variable on stack. It's measuable on the stack meter, one variable is
> > > "nothing" but combined wherever the guards are used can add up. We don't
> > > mind adding variables where needed, occasional cleanups and stack
> > > reduction is done. Here it's a systematic stack use increase, not a
> > > reason to reject the guards but still something I cannot just brush off
> > I thought it would be optimized out by the compiler in the end, I will
> > probably recheck this
>
> There are cases where compiler will optimize it out, IIRC when the lock
> is embedded in a structure, and not when the pointer is dereferenced.

Yes. If you have a pointer to a structure with a lock embedded in it,
the compiler knows the local variable is stable (as in non-volatile or
const, the pointer does not change) and is happy to use it and
optimize out the explicit copy. It knows both values are the same and
so it is safe to do so. At least starting with -O2 with gcc with my
tests.

But if you have a pointer to a pointer to some structure, the compiler
(unlike us) cannot make the same assumptions. Strictly speaking, since
the address to the structure containing the lock is not in a local
variable but somewhere in the memory, it can change during the
execution of the function. We as developers know the pointers are
reasonably stable as the code is usually designed in such a way. And
if it's not, we know that as well and modify the locking accordingly.
So usually we're happy to `spin_unlock(&foo->bar->lock)`, but for the
compiler this may be a different lock then the one initially locked
before. From the language point of view, the address of `bar` could
have changed in the meantime. And so the compiler is forced to use the
local copy of the pointer to the lock saved when acquiring the lock
and cannot optimize it out.

So this really depends case by case. Using the guard in place of
patterns like `spin_unlock(&foo->lock)` can be optimized out while
guard for patterns like `spin_unlock(&foo->bar->lock)` need to use an
extra stack space for the local variable storing a copy of the lock
address.

You would really have to use `struct bar *bar = foo->bar;
guard(spinlock)(&bar->lock); ...`. But then you are explicitly using
the stack yourself. So it's equivalent.

> > >> it makes clear that whole
> > >> function body is protected under lock and removes future errors with
> > >> additional cleanup paths.
> > >
> > > The pattern above is the one I find problematic the most, namely in
> > > longer functions or evolved code. Using your example as starting point
> > > a followup change adds code outside of the locked section:
> > >
> > > void foo() {
> > >      spin_lock(&lock);
> > >      ... some code ...
> > >      spin_unlock(&lock)
> > >
> > >      new code;
> > > }
> > >
> > > with
> > >
> > > void foo() {
> > >      guard(spinlock)(&lock);
> > >      ... some code ...
> > >
> > >      new code;
> > > }
> > >
> > > This will lead to longer critical sections or even incorrect code
> > > regarding locking when new code must not run under lock.
> > >
> > > The fix is to convert it to scoped locking, with indentation and code
> > > churn to unrelated code to the new one.
> > >
> > > Suggestions like refactoring to make minimal helpers and functions is
> > > another unecessary churn and breaks code reading flow.
> >
> > What if something like C++ unique_lock existed? So code like this would
> > be possible:
> >
> > void foo() {
> >    GUARD = unique_lock(&spin);
> >
> >    if (a)
> >      // No unlocking required -> it will be done automatically
> >      return;
> >
> >    unlock(GUARD);
> >
> >    ... unlocked code ...
> >
> >    // Guard undestands that it's unlocked and does nothing
> >    return;
> > }
> >
> > It has similar semantics to scoped_guard [however it has weaker
> > protection -- goto from locked section can bypass `unlock` and hold lock
> > until return], but it doesn't introduce diff noise correlated with
> > indentations.
> >
> > Another approach is allowing scoped_guards to have different indentation
> > codestyle to avoid indentation of internal block [like goto labels for
> > example].
> >
> > However both of this approaches has their own downsides and are pure
> > proposals
>
> Thanks, it's good to have concrete examples to discuss. It feels like
> we'd switch away from C and force patterns that are maybe common in
> other languages like C++ that do things under the hood and it's fine
> there as it's the mental programming model one has. This feels alien to
> kernel C programming, namely for locking where the "hide things" is IMO
> worse than "make things explicit".
>
> There are cases where switching to guards would be reasonable because
> the functions are short and simple but then it does not utilize the
> semantics of automatic cleanup. In more complex functions it would mean
> to make more structural changes to the code at the cost of churn and
> merge conflicts of backported patches.

