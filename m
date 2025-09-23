Return-Path: <linux-btrfs+bounces-17127-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C2EB96ACB
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 17:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D8AE19C59B0
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 15:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4986826D4D4;
	Tue, 23 Sep 2025 15:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b="emwFha8+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA5D265CB2
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Sep 2025 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758642954; cv=none; b=N8ErXqF03NhdRmGY4sAVxSx1qMpzPp2RGc3+5LP5MJ0zENVtTXU0cFaubdNrZ5NwCUPK/jUu4oca2hJb2RoOaLJdr13DbmEM5zmOACgiW5yNJboYNP1OMZJpUi8eMMIVufTG51qgWtm9LheeS4f2Gu2A0vMAwY0oNVNyFQrQ6YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758642954; c=relaxed/simple;
	bh=q60l6JkIwsADmqyQGpYtx9sLrvphoYRJZLMv49gW458=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pCg2hQglpd8oW7y9uNWCuoFjayTOVxPsMdGCBKTEitfdZXVPdqXPsg2A2SuBP/epkSrhTdgsxfntPWN5VaqTEJkmOGHQUor4+ZXod+OnGTKH8Wvjlz2joBk9hEDmXWX68LPYX/C27NuUrFcG2sEcisUOYAG3yoN+NeXmZXXRMwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=allelesecurity.com; spf=pass smtp.mailfrom=allelesecurity.com; dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b=emwFha8+; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-54adce22b2cso938438e0c.3
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Sep 2025 08:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1758642951; x=1759247751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q60l6JkIwsADmqyQGpYtx9sLrvphoYRJZLMv49gW458=;
        b=emwFha8+lIkyJjuQicmKIWCTlcDyZdd6pviWUvzD/h/qVt9O9CID3W1Vdk90XfMQjy
         rfek5IJbWL5tDBZTKX+fXdvfuS+salDerQAGGU1PboVRyxtCWeZhz9rihXE7cfZ7FaxU
         2mLIv5kSlEaEE0RXPQWSfH/GP7ZVIcDW5zfiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758642951; x=1759247751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q60l6JkIwsADmqyQGpYtx9sLrvphoYRJZLMv49gW458=;
        b=lIo0Imgp98WPkFvvTYa9DNOwJoUNqqqYsmhzAJ9v73mKruSZdP8RMGA3ciNdugdhyr
         Jq32swUMlu0q9w/nwidYqw/PliMQqB82v6Pbt/QA/xo/JCgJrhnmrmeOQDYrI6hpwsIn
         SYeNk7g05swbV3Kkoq9U3Lm1Fj06KtvtuvwK68hAXnExYeGNf3ctvpqYNsdUvT51NkR6
         yXwUJtJ97Knd/Jwqn5yt9L5/wEhfsAcFGOUZGOL+a6/NeX3cLut6oFGyZ4CZ51+Ni7L0
         OCKnyUmhlBVluTZpeK19P0SK3bXI/ZMbee9/yobrSDmz6YnNtfyrXRYum0YD9dX0UV7W
         aStg==
X-Forwarded-Encrypted: i=1; AJvYcCXdKJA7sY3BIsE+gsEDgt/hdpq0veAbyvGTXeCf6EPtuJ541m/VHVpAIHLfbQuUPXJRKrvf9WNTsxyQEw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8hCaclSdcmK5RdaX0cXatnfIBXCBI5cZ8ptLF/eYaPc9802EX
	mSKnsID4RvVi80RRrOM5UnmFAdycaFKHAk3Ojhs2ArOsKB4q5rL9qvgMQh2WxsW5OqtXN7PDB16
	lCxgtGxZC32TGzZzmifg+WdTLbv8buM94GZZ/JFSnNw==
X-Gm-Gg: ASbGncvhHsJdR0ySmtMLMeQcGoWlFmFQ5f/Li3h+9bfNOMKcIWPZU/GWEIVsH/Gu7gb
	FAzUrBuKlhzCJLjzrsXrZ23u4cD0T/m50wAhYR43qsvMDnA0dF5cODRDGjVo3x0GK2wHrIaA8yR
	OkPJU58hQafdxRrp18SCpOVOFZxxnwSKLtGjdaAjl3dTrdWukqTULHv1aQPuymK69cHjo85BriN
	1IB/Omf
X-Google-Smtp-Source: AGHT+IE8ZvWiTiGqXTWcpfVsTbk//TxRzsy5cpmA75sT4dqaycKQ5AGoujI4y1Wxl+s9LkZCTdJ/lchQSDdcK3BT5l4=
X-Received: by 2002:a05:6122:3d04:b0:544:75d1:15ba with SMTP id
 71dfb90a1353d-54bcae9778amr849180e0c.8.1758642950707; Tue, 23 Sep 2025
 08:55:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0cc81bcf-b830-4ec3-8d5e-67afbc2e7c47@allelesecurity.com>
 <20250909224520.GC5333@twin.jikos.cz> <CAPhRvkzgR+8L93VF8XtZDG9P_q7O0+BSBxnHtesLY5oj6uhwmg@mail.gmail.com>
 <20250923151110.GV5333@suse.cz>
In-Reply-To: <20250923151110.GV5333@suse.cz>
From: Anderson Nascimento <anderson@allelesecurity.com>
Date: Tue, 23 Sep 2025 12:55:39 -0300
X-Gm-Features: AS18NWAXLSWsrK9SrcbyQoYBYwXUR7GXLiaQTIy3LWlL1HCKbnJYgWqOj7HIa0g
Message-ID: <CAPhRvkwLg=5mKv3XKvfLUOPUcbNCAYW2reNub60s5pkLXP=xSQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Avoid potential out-of-bounds in btrfs_encode_fh()
To: dsterba@suse.cz
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 12:11=E2=80=AFPM David Sterba <dsterba@suse.cz> wro=
te:
>
> On Tue, Sep 23, 2025 at 11:37:33AM -0300, Anderson Nascimento wrote:
> > On Tue, Sep 9, 2025 at 7:45=E2=80=AFPM David Sterba <dsterba@suse.cz> w=
rote:
> > >
> > > On Mon, Sep 08, 2025 at 09:49:02AM -0300, Anderson Nascimento wrote:
> > > > Hello all,
> > > >
> > > > The function btrfs_encode_fh() does not properly account for the th=
ree
> > > > cases it handles.
> > > >
> > > > Before writing to the file handle (fh), the function only returns t=
o the
> > > > user BTRFS_FID_SIZE_NON_CONNECTABLE (5 dwords, 20 bytes) or
> > > > BTRFS_FID_SIZE_CONNECTABLE (8 dwords, 32 bytes).
> > > >
> > > > However, when a parent exists and the root ID of the parent and the
> > > > inode are different, the function writes BTRFS_FID_SIZE_CONNECTABLE=
_ROOT
> > > > (10 dwords, 40 bytes).
> > > >
> > > > If *max_len is not large enough, this write goes out of bounds beca=
use
> > > > BTRFS_FID_SIZE_CONNECTABLE_ROOT is greater than
> > > > BTRFS_FID_SIZE_CONNECTABLE originally returned.
> > > >
> > > > This results in an 8-byte out-of-bounds write at
> > > > fid->parent_root_objectid =3D parent_root_id.
> > > >
> > > > A previous attempt to fix this issue was made but was lost.
> > > >
> > > > https://lore.kernel.org/all/4CADAEEC020000780001B32C@vpn.id2.novell=
.com/
> > > >
> > > > Although this issue does not seem to be easily triggerable, it is a
> > > > potential memory corruption bug that should be fixed. This patch
> > > > resolves the issue by ensuring the function returns the appropriate=
 size
> > > > for all three cases and validates that *max_len is large enough bef=
ore
> > > > writing any data.
> > > >
> > > > Tested on v6.17-rc4.
> > > >
> > > > Fixes: be6e8dc0ba84 ("NFS support for btrfs - v3")
> > > > Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>
> > >
> > > Thanks for finding the problem and the fix. It's 17 years old though =
the
> > > other patch was sent about 2 years after btrfs merge to linux kernel.
> > > I'll add it to for-next, with the minor whitespace issues fixed.
> >
> > David, has it been queued somewhere? I don't see it in any of your bran=
ches.
>
> That's strange, I thought I'd applied it the same day but the patch is
> nowhere to be found. I'll add it to for-next again, sorry.

No worries, thank you very much.

--=20
Anderson Nascimento
Allele Security Intelligence
https://www.allelesecurity.com

