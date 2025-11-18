Return-Path: <linux-btrfs+bounces-19109-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFBEC6A8DA
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 17:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id F30E52BF4E
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 16:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4403730F4;
	Tue, 18 Nov 2025 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="En2jZ360"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121BD329374
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 16:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763482474; cv=none; b=uLM8+RHD2jrW0HQh63gOpaj2uFxILJ6reM29EPU/2CPxpmtiR04o7kV84I1m7wviVlUmnV8bcWo+OQEOtBBxNEz74CgG73FLCwjkmdzLrCegdsWQ5EAiQCpCFbSXItxRrJZLtsvdwjxZpXj8ng1EQhEM7oH/RcBu1CUlQMFXH6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763482474; c=relaxed/simple;
	bh=095QqxEHyKFyXu0YX5339M+w+Ng4yJrUOQZ+tGpdkaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rnFTcaLfcON0sYjmGdT3gpIaUxoW5MGItjp5BvPot94sYsxIIYKHt2eD+6EpUkjc81uWkfQd9TDwEx1oXwyQAHRbCNxEJ6Fjul+Y5iv+ZgrEzieQ2AV55LzYp6ekY6GdeoOrqAIEaOm8YEykrCkyMKydC/zvhlEt4DeOZLWxZiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=En2jZ360; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42b387483bbso4656707f8f.1
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 08:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763482469; x=1764087269; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rm/KnPGKVObTZHNr3EJFdyLwOib73iBj7GYq/QLaFjQ=;
        b=En2jZ360DgmYTCjSYoeRQEk6jYIg8HoHRWPgxe+k3aR9onthzROe0GZXVDqlG7vJin
         fbaGqAvjcnrpInzFzxI5DE2mvx8E9UwJU1sL8wbDS4QaKFWEXYc2pvWIdYggzJ7HShkI
         +fa2FNds44OVqswX3MyGgB37zvGO2xEeNzcvh+Vas9msoNoh1J+q7ICNTydkFJMFXOPb
         KH4rjtS2IJwYRrsEOcZb1Uzl7uiSmq4tEYdcjZi6TDAGESugLfjBsXDU+4sXz5KQCWyG
         3UGT13F9oDe/S6sDU4v57CUG4FuMAtWUBCMwYszzu7cnHq4GCTYyNtwvIfsWMedqx2hQ
         7J9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763482469; x=1764087269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rm/KnPGKVObTZHNr3EJFdyLwOib73iBj7GYq/QLaFjQ=;
        b=EmHItpdoqMUvBxL9givhoo2/YzGHqBE6SHBTWPdlFjmxsV5EHaNkZA9ODX84QbD3/V
         Or7s89onOfeunXEkF3CZI9je4ygWlDw7U3BImS9N7BUhPasB3PTJee5X/VtB0sQpjiLV
         1Ougla/OBTqcyRWXvQ6of7lO+oxhgss//5I7vMPJiaJczmr1rb70KcQsVS8yq1Iv29jr
         r3Ho5jOQQoeIGb/ez39ZAKNmU+Mu86dKF+8OjW3j6HavAYC/FojKnRFVLWnW9tTLP5AO
         EYFXg+mhsy1cUQ4INglcsD6EUCQrLpbYtdwx0zuxiV/uLln1hY6ByCmgJpOjKR6ehFei
         3mrw==
X-Forwarded-Encrypted: i=1; AJvYcCVokX8Xb182Dq9JXfcvnWG5mm5QKpmDOmMrSfv9SAZ5GhnD7p4GDOTrpilSpcP5b7MUs1VE3wMQ9bsAjA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzm7wQZYa37v2Pmo3Saunr90Sre4m0M9Tu3fER4+CGlXMGUsN0
	UnDwn4+sJvWThzIrTC2qZhDNr420X800/CYdhQtkeby6s+Ptgk+IKBSl1GqXw56ECdL60+9AwZe
	5LyO9/1vyJvR/8r4RvgvJIObAsnVtSJPHzA3G3fkU1Q==
X-Gm-Gg: ASbGnctQ6WlYEl9ECsqe012ZIwKdubdYYAcnVSolwfVBwUUL/r5HE84V6DpNeL/1C5N
	mQ+/5ZPE0RYl2xw6YVHz7tWfFoqjkBWF1a9LZ8ryb0o6B13RQSSFllq5KmNMP6nRSMS7y0TsrpX
	+bRCYEcXYwdOh6HRpSoiKFpv/6iAM3AlON7Hh4ywzi/rw4oVpwyA9+AtEC9ssX0ObuJTXC6LiU2
	a+sMMGVVQ8PX4VI7xjbrQG8IJP9sSpZdmHxyWSly9BAjKKCuBIvzyGXsHvlM6yehDavDcm9LAHh
	hbnB2TjzgPQgJMez/xC6X2GY04UXrUd4RzT+rjW0/QVdyYQZGcgnwPgRbapxeBHPHSUPPOxncud
	0vgE=
X-Google-Smtp-Source: AGHT+IGhYLzoBqhx3r6Pkw69ivHEuSBQ5ebqkWmzM/S4RwdalrVZLhlGPCtLy8OK+Qwsdo346Nc+qOK2pcSpWWefgwg=
X-Received: by 2002:a05:6000:40cc:b0:42b:2c53:3abc with SMTP id
 ffacd0b85a97d-42b593414d2mr16473282f8f.19.1763482469289; Tue, 18 Nov 2025
 08:14:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112193611.2536093-1-neelx@suse.com> <20251118150444.GW13846@twin.jikos.cz>
In-Reply-To: <20251118150444.GW13846@twin.jikos.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 18 Nov 2025 17:14:18 +0100
X-Gm-Features: AWmQ_bk9KfXjeU7vZaRczCLSV6m4nLUJXIpCUoMDdp5vHDfZdi_JHFNgcZxpleM
Message-ID: <CAPjX3Ff+tUNq18hYExXzY6ZOY2nuGi90abvFTgGmEY5iKn4mgg@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] btrfs: add fscrypt support, PART 1
To: dsterba@suse.cz
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Nov 2025 at 16:04, David Sterba <dsterba@suse.cz> wrote:
> On Wed, Nov 12, 2025 at 08:36:00PM +0100, Daniel Vacek wrote:
> > This is a revive of former work [1] of Omar, Sweet Tea and Josef to bring
> > native encryption support to btrfs.
> >
> > It will come in more parts. The first part this time is splitting the simple
> > and isolated stuff out first to reduce the size of the final patchset.
> >
> > Changes since v5 [1] are mostly rebase to the latest for-next and cleaning
> > up the conflicts.
> >
> > The remaining part needs further cleanup and a bit of redesign and it will
> > follow later.
> >
> > [1] https://lore.kernel.org/linux-btrfs/cover.1706116485.git.josef@toxicpanda.com/
> >
> > Josef Bacik (6):
> >   btrfs: add a bio argument to btrfs_csum_one_bio
> >   btrfs: add orig_logical to btrfs_bio
> >   btrfs: don't rewrite ret from inode_permission
> >   btrfs: move inode_to_path higher in backref.c
> >   btrfs: don't search back for dir inode item in INO_LOOKUP_USER
> >   btrfs: set the appropriate free space settings in reconfigure
> >
> > Omar Sandoval (1):
> >   btrfs: disable various operations on encrypted inodes
> >
> > Sweet Tea Dorminy (1):
> >   btrfs: disable verity on encrypted inodes
>
> Please resend the series what is OK for merge right now, I'm counting
> two dropped patches. For the signed-off we might need to add an
> explanation why there are so many or only keep the first one as the
> patch author, the others usually mean only the pass through and not
> really doing any contribution. Eventually there could be Co-developed-by
> but this would need more investigation in the previous patch iterations.
> This can be done once the patches are in for-next.

I just did. The SoBs I just kept as they were in v5 from Josef so I
understand that's what it was agreed on before.

--nX

