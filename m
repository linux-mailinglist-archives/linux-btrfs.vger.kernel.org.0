Return-Path: <linux-btrfs+bounces-18734-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05845C36CC8
	for <lists+linux-btrfs@lfdr.de>; Wed, 05 Nov 2025 17:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BDA214F882A
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Nov 2025 16:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3ED335546;
	Wed,  5 Nov 2025 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MWu2qJtv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E151F3B85
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Nov 2025 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360398; cv=none; b=U2VgOlXKjlocxoetQ0YlNBdJuSRjV+GPBE+fS2eYK7nYIS0SDLSewnTQtRrtw7LR0fwywnNf1pC1u1GnL3RJ6qyXA/VMmZvtSJSfKwNdOoWt2j4EFzGcxeJyKIzsf0/4yPeIfeP5OOAMoSqSm/KZ5pEdsbqJ1zp87WbXw/ppoWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360398; c=relaxed/simple;
	bh=Q3KigkSvYwK5JS9sgke5e3cj+3o6CQW5ok3nCz3pwtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNgnWRnXg01Z2l820pkyuc546jHJgrUaXqdqgz8MgERzPMZ2gNvduRFhimN8UezACNk3EwRRLpw74GY3TBg6PvsDkdxuTRWYOreQuPibQ9ezvA6Bqvgf5h7wb0cxd/mUb2dJpv01xPs6a46uQPjawr0B+lI+axT17pJoaJe+JXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MWu2qJtv; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4775a52e045so5835435e9.3
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Nov 2025 08:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762360394; x=1762965194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxgECH2xm74nun5bYq3yo2lzpHEkoDKEqM0ldiRMQUQ=;
        b=MWu2qJtv8JOAzbF1l/Dfac/mUsfdWhU2PrESm+dpybLCBJnwzUc5LHrzFeyYicizZV
         QL5LsPtr47GPBuYwF8wfqqratL1fUBnLrJQgjcd1b6s1YA5rBYsnDmKZtyC+Ow4HlU7q
         AQAzpscIlmpbTdyPvdctdJ4BMh5qMwsRjkj6Fvd9CQpDsyMSs6TflhqWP9RFDLa7M+s9
         2x+sz6cJAfEGwCS44z+5XqDOE7iMxrzY9LgrIibeHzjTnzPqRpjtAaPxUpMHDj3E8GAt
         yMCulqkogs5ujpeBt7WOZ06BLnkdGw2GL+AKqfoZKxG1ywoPe9n9aKsPQ94PivQ4Ssmu
         HHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762360394; x=1762965194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxgECH2xm74nun5bYq3yo2lzpHEkoDKEqM0ldiRMQUQ=;
        b=OXLpipuo+3iDrgOuQUcOqbk3f3zZjkYAwEraaDtqQ90CXGraCALZ8Sa4FrmDsxqBMM
         QDwcarTwUebZa8hD6MIjnP0Thf3hGApxzfTQRVmOR1kTfcD2KOnWGnhlcpIp3sBPTcVL
         Fp3B05UPlCTCE5uOgYpl3hQYexRPtMOIJnKBX0a6lshCK6D7D6BhR37v+IKVvDKgHVzP
         duUD0AXRvf+4bqKsw351JLiole0y67PQ12WjohujB4DNpaoJ6JRdQYiPjpG0qUHTCauv
         +I1jzBMHobuoK0vDU/kbi5KCbvZJzcH+7papLg2hUV6UBJWpsdGeAvTWO5bb0zpmU+VF
         pvpg==
X-Forwarded-Encrypted: i=1; AJvYcCWx+PSFVY0Ag8gZ3EsmYZlnacfXdEaAtuvMHzuYE/TZiEBG1vgX0iZRAh3x7/1kU9ptN/5ec4Ds7otisA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6lN5cu9mRs0KzolPIW6nTjZ1AoJCt3Yi9C4G8zqzfmwRGikL2
	slnfC8CIUaN74cutAEKIp9ekEJxntuz+YP52X6PjC5xdoYlNbq5tfaWa3yqkkBJ0YF30MyOhKmJ
	7DOvTxE6hh6b5G7H9sXOSrHSQoRT+jTiqUw02kvJF3A==
X-Gm-Gg: ASbGncsKc2ByiFA7swzRkJUCb1UunwbgC/ZZiIx4xbUgKDUOHtaHz9+8PLM7acMGdxq
	jzx77uyA+f4xeDEdrhLDVLvL/Z9h8+SLTburngbcoVIK8wNZ+avwm4JcGAYHBDGTgrK19jAbyuw
	Cj+RJKcl++S6AFIQawmJ7rvndH3cKHb8H0rHIsVKKzHO6t/zsaFsFonq2Vg/6+9gAcP8q3iWSDL
	whhgYlrgyq3FV/LS/ecOzd5FYfOTsADcEQ/zRh0ddurlfZg3yyf/7YTD/skyGC9s72dIZGisezJ
	eq+Z30LOIx8tI1hx4EG0ZC1k50TAEUKSoyLVPlJkcVfkmBg1ZEl+TrZABA==
X-Google-Smtp-Source: AGHT+IEz7I4CY+GlSdoe/bflZWVcU0m0o1McZfVokzTIe0B2RRVoH+RBVlVjzJASkrgFqD3eiDzaXjnkv21y5vlztVg=
X-Received: by 2002:a05:600c:4584:b0:477:55de:4a6 with SMTP id
 5b1f17b1804b1-4775cdbe238mr35989165e9.3.1762360394279; Wed, 05 Nov 2025
 08:33:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104-work-guards-v1-0-5108ac78a171@kernel.org>
 <20251104-work-guards-v1-2-5108ac78a171@kernel.org> <247c8075-60d3-4090-a76d-8d59d9e859ca@suse.com>
In-Reply-To: <247c8075-60d3-4090-a76d-8d59d9e859ca@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 5 Nov 2025 17:33:03 +0100
X-Gm-Features: AWmQ_blmtnDHlxA5kivLFHuNDFJT0rxb6Yv2ZgkGpfB5WfZtUJKHjLM2jWHF-pQ
Message-ID: <CAPjX3Ffptip7onCpm30OiC+zvfNV05_B1GQYM4-Lem-V12_ERQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/8] btrfs: use super write guard in btrfs_reclaim_bgs_work()
To: Qu Wenruo <wqu@suse.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Nov 2025 at 21:43, Qu Wenruo <wqu@suse.com> wrote:
> =E5=9C=A8 2025/11/4 22:42, Christian Brauner =E5=86=99=E9=81=93:
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >   fs/btrfs/block-group.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > index 5322ef2ae015..8284b9435758 100644
> > --- a/fs/btrfs/block-group.c
> > +++ b/fs/btrfs/block-group.c
> > @@ -1850,7 +1850,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *w=
ork)
> >       if (!btrfs_should_reclaim(fs_info))
> >               return;
> >
> > -     sb_start_write(fs_info->sb);
> > +     guard(super_write)(fs_info->sb);
> >
> >       if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE)) {
> >               sb_end_write(fs_info->sb);
>
> This one is still left using the old scheme, and there is another one in
> the mutex_trylock() branch.
>
> I'm wondering how safe is the new scope based auto freeing.
>
> Like when the freeing function is called? Will it break the existing
> freeing/locking sequence in other locations?
>
> For this call site, sb_end_write() is always called last so it's fine.

It needs to be used sensibly. In this case it matches the original semantic=
s.
Well, up to the part where a guard just consumes additional
stack/register storing the sb pointer. That is the price which needs
to be accounted for.

--nX

> Thanks,
> Qu
>
> > @@ -2030,7 +2030,6 @@ void btrfs_reclaim_bgs_work(struct work_struct *w=
ork)
> >       list_splice_tail(&retry_list, &fs_info->reclaim_bgs);
> >       spin_unlock(&fs_info->unused_bgs_lock);
> >       btrfs_exclop_finish(fs_info);
> > -     sb_end_write(fs_info->sb);
> >   }
> >
> >   void btrfs_reclaim_bgs(struct btrfs_fs_info *fs_info)
> >
>
>

