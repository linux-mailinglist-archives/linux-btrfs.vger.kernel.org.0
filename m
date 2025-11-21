Return-Path: <linux-btrfs+bounces-19242-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6BCC77AE3
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 08:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id A925B307E8
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 07:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBDB23C4E9;
	Fri, 21 Nov 2025 07:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VzMC/OrJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A3429A30E
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763709680; cv=none; b=e7LA3IotuZjBJZ1Bl9/o6x+2KMfHvEGZjLPdak+Z08JR/KZW9clu6iz6BZm5WhGpTL+POECc0Tx/gSCz2p7EeFWfxc9X4JrwfizToawV0IZFNSdTi5tF5Qi2tNM/OHPkAxl1yBrzcvQVx6Z8ODvsu21YIB4tUvJvNZNxP8fjy1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763709680; c=relaxed/simple;
	bh=mmgn1MkpWAiG4N6OPpOiD05W0EXpxXOrm0xB5zmmqmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DOAIswZEH2org7hGyLKZKN9NMt0G8NpFdD+zw0X9ExVV5QO2bL4+nKK5r7jMFDm5SKCwf6khSRbrL0Fex32Q14sGoobUAJVA9OH6OCzXvmqN0fZN3hNO2ADQQZZhBdVVKPN2WUawV9Bxoqx8Q9z8aiRU3MLifI7j0Wyx9Zhgu9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VzMC/OrJ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so15120545e9.2
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 23:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763709675; x=1764314475; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+0VJopVhJiYzAmZw8UhWm8SrDtfWhDKSvGV32cTFWRU=;
        b=VzMC/OrJGbiSXyQdkQ2K+E1Ll/wj9nQBnFIyJ2RmgQv6I6qTZhJ7k0cqe2Y1b400ga
         GRenyTCWtNbRy8fH255fljRDyjyOmuCErIQDH/x2PiOZh2gEKoqjdVpCu9dM6bCJfrBd
         RnOOx7kPDjnsHx4raubvW8TI5o5rFz6oP67MqvMzRmhw/z8s0rlrUCCkgHDNiIAXkLVQ
         MUG2xJAxdnGmpCVY3aP7dZ6Zl0XAyjnmk3tbVu+cg3kwP6Hy5tcT9Sh5MgnuUwMQpH9e
         Sbk3D4krEdA92z+O49ntbcN4MX9j9UPGnNxVTIkH2RnC2sMNKRFqKaEhQjuBFEA7X5Im
         nhjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763709675; x=1764314475;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0VJopVhJiYzAmZw8UhWm8SrDtfWhDKSvGV32cTFWRU=;
        b=v4jra2gKFwhgYxvpYpmJMeQipscZOkA239sGOfsiIR6SoId2FOJpVyx2iE6CUOydHt
         jj6kV8LhHD7100aujMDNYZVODXiMh4RvXwSGARgI5oVc63PBQZ7YpsLFW1Yneg6bQY81
         AK0vjO+F8sMEuFZzwZSzsZcuZNdM+ma7h74CLg5xiImqQsuE1OEa+2uUJImPJGw83ugC
         s0IXPgHuRkh8r71FPhk3LsV6HPjk7fJmSnmFm1HmdEeXZ8RVp2gTZB/vXRB19qEaaJAG
         GjwR2FsT4sAtEYC38Nsn6DFyFBLHRikX6YcXr4oQZk0/FVT2C+cV3YQ6B3wWdo/x73Uz
         0IYA==
X-Forwarded-Encrypted: i=1; AJvYcCWcJzZ6QP7gEzD2KQtymoIKtKSLTehqj3ZReJvVKbxoN7+IMA+71sFiSLZfGkWnILxYH6mWfzkc59LwXA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4mwwdCKAn+YN47LZtDEy+JhXx9Sar2oI6vY7jfTNG46o+SPOl
	cKOGhjrm+cAa3qBP9W7R2MrMM4lY+aRAO+OQNBGe8mnmwLbwOQPYnFkR7tX0onox59KReWEej2q
	bzx6esd7ROQvDgCons/mnvnZFo3CO2rgjv4lZ0Bg88g==
X-Gm-Gg: ASbGnctSaCALarw1rmRf/vt25N+u+HcqDzhmnfMyur3IRtaX06gS2sYyLEVU3mS1Hfi
	P+PmSEPFOZnfJlTMMaGhc93VcGGr6twmWMC3mWukGY4z+vykGorwubCU3MeYI+nWd3FTs/3vrYP
	dtBpKPuWVwEoVHGeo4tRGV4hnB2vr/7tduu+ZMlvzHEMx7MTLASMALzJWBkpHuUbwtVXYsYZsQq
	Yio0u2CiJhKuhWjzQYUKuZsk7Z0kOgOEQcpAec3Dnf4h/Ovt16Dg3GIKzRYPLHZU90sUZn6agof
	jncUSapZTHujaTqZsHzpcbTQdaNdo0Lix/zMAg6/MfTbtclv8RceKPePZJHNw6rIbffv
X-Google-Smtp-Source: AGHT+IGQdMkHAyWHnC61cG7Gt/4lE/BQnHp3pckAvYO7i2VegNkbu68mwzwfgi0x4+ISNSX7lTOnCkHbGQkE3s8NXDY=
X-Received: by 2002:a5d:588c:0:b0:42b:4069:428a with SMTP id
 ffacd0b85a97d-42cc1cd5d0bmr1196211f8f.12.1763709675563; Thu, 20 Nov 2025
 23:21:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120141948.5323-1-sunk67188@gmail.com> <20251120141948.5323-3-sunk67188@gmail.com>
 <20251120190206.GM13846@twin.jikos.cz> <6e3d587b-89ed-4b44-ab62-c485b8fdf814@gmail.com>
In-Reply-To: <6e3d587b-89ed-4b44-ab62-c485b8fdf814@gmail.com>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 21 Nov 2025 08:21:04 +0100
X-Gm-Features: AWmQ_bksVcNeCSMYHjcQAKooK9hl0aKVl1Y1Z85hx3gb2bf2rbrOkKV-bbF9Mnk
Message-ID: <CAPjX3FdAY_uLsQX5b0RBgM2jnetTREDyGJGnPRCvBXSN6wTC2w@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: simplify boolean argument for btrfs_{inc,dec}_ref
To: Sun Yangkai <sunk67188@gmail.com>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org, boris@bur.io
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Nov 2025 at 04:17, Sun Yangkai <sunk67188@gmail.com> wrote:
> > I find this worse than the original because the key piece of code is the
> > condition and putting it to the argument obscures it. I think we have
> > the condition in paramter in some places but it's where it does not
> > matter that much.
>
> Yes, I totally understand. The condition in function parameter is annoying. We can
>
> 1. Leave the `if (cond) foo(true); else foo(false);` untouched. This seems a
> little stupid and we have to repeat the same thing in different branches.
> But it is more clear and the if-branch condition fits better with the common
> style. If you prefer it, just feel free to drop the second patch.
>
> 2. Do something like this patch. But the foo(cond) style is rare and alien for
> people not get used to it.
>
> 3. We can optionally add a local variable like Boris mentioned.

And perhaps add a comment on top of that.

> > Nice improvement on patch 2. It's much better already, but I am also
> > sort of curious how you feel about giving the bool a name to make it
> > more self-documenting.
> >
> > e.g.,
> > bool full_backref = btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID;
> > btrfs_inc_ref(trans, root, cow, full_backref);
>
> It looks better than 2, but still seems uncommon. And
>   - The local variable may be declared far away from where we need to use it.
>   - The same condition might be used elsewhere in the scope, so we also want to
> replace those usages with the new local variable and the name full_backref is no
> longer proper.
>
> So I didn't do this in the patch.
>
> Thanks,
> Sun YangKai
>
>

