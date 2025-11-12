Return-Path: <linux-btrfs+bounces-18890-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F17C50E05
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 08:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7165B34CEC8
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 07:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E2E2C2343;
	Wed, 12 Nov 2025 07:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aID24jyr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5816F2C21E7
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Nov 2025 07:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762931591; cv=none; b=Wr7MAsmaHPMX0f7WMk72YIIeFU9+po+Jn4t02MWyCGzqtii1avveBxVbZq+xZKMStjCjXKQcnZzdDvS9iABZAjOpf660I3ISXgvyrBnqHTeXpWzxP0ihfb+damM8LHV0a3U/OOqkqhfk+BuDT4zJU2D/gPvLM7/yE+StyKaIPUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762931591; c=relaxed/simple;
	bh=3lv4YkEhlJJke60VBfirdbNW/h+g6hx1bFuOtwOQyY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KaRRgrt5oYJKdb5IfWJSOoA5mqRDtPVj1JKnfR1g8qoAHqd/0Se+L7eqbvnxImOWhKj6ccr6p3F66sZTUQ5EXhh/Pg3NZuxoiYC7oZwSzohwL3pFlB/pVP2COhPiQ/htoH8Z/iZ9TGKZifgwySol+PT1Nfq46AG5m/ZmdSayAdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aID24jyr; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47789cd2083so428245e9.2
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Nov 2025 23:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762931587; x=1763536387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+42J+CZB9YyyvPspCrFm1Otjy3jMz7v30d7ZdNR5xz0=;
        b=aID24jyrlccPDWaBsG0PYonj2gzsWvve3qc0fsCq1Iom4Zqkm3wdOPiPVzZrud783O
         N4q9jDL0zvKyVZIyuNeYoO3RQRpEpy/zgeNqmQibdwcreHa4WznNhi+lTYlufVl4j2XW
         21WfhP4+tWQ+hVWQ/1l5tUWs9/tUP5gzFc7P0yTnexfk5fneONdOcxsE6SP683AI2LI3
         3Adv5BuSboYQEBw9GPhAX+Et3v6tFxYha9o2evYS3FVD32U0r+iqCulEJ1Ka0h8Lb3Uv
         Z8EQQwhjWRIL2LBZukbLavern+0P0EmGG7+9xOh3Ic+q8GHmUtvPGwgvVttIv7FBxjDv
         baqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762931587; x=1763536387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+42J+CZB9YyyvPspCrFm1Otjy3jMz7v30d7ZdNR5xz0=;
        b=eV/Ystcp4LAa6lVJWD6DVohVNp0omPgLZVYhvj+oq7Ak2I0YybA2JxY0xaTUmQ7Bay
         EG3Ung0a5gpnTG+ltkUftiu6Wj/AGt4bXOMzzDhlWk/uKBQmYKJ8cgPkRlAplGuoIQtJ
         GRe/hITK2Gxl4wdrV31kM62oiv5pYcHoCX15if3TCSzj7ZvuXzLgdAX4xOLRGUOWEwOd
         LuFd7rLK+BfrMUirz9AiRaiKiq3mIaOYdTEmVaKJKb+cr2zl+QBtid8pmCBakzuolKW3
         AOVj2wKxreTYBRMT4Zn+OUehtVk5P18EhgmmxdxkMRK9WsRd9+n+pCVnYHGzHTtkw7n5
         KA3g==
X-Gm-Message-State: AOJu0YyTByPXTZnBpMKS7n24UNsCpzzUDsFUP06bA0qL21tqP6mKwrJ3
	83Cn09rT2Wzsp+RZfiY+RjTw2Vy+R/HjwyNhVTCLbu0W/BJVOSeDPvgjOcqMA57C0vR0i3x4HSY
	Bdjg9pPCl1n+BXD25sNa8f8vIoSASMKzd1KlzQ11mzkGBmYK/QvLg
X-Gm-Gg: ASbGncttdJqv1uDEcf3aFrdLvl/YBw1gBUf5bbcOlUedZGJpiABWG3t2/uLBuuiAkBC
	I6iRL2gNEBpYQx/gOcHXFPSINM4a28vd26oX+emqq0PgcDJOOWVuoGEDglRG76Uaxneqpdy/Mha
	W/SEJw+Vyj9BTzFVPheMnUVp3/1k6ctytTyLIos23n9EbzHEsjgFQ2dOIWTAwfZOO55Dg5Lr/ie
	C1kHKwchkcpC/mZ5qfPnRSoBQIW+S8+iKrND/pWsr6XqKLSLLX5KYvD3NEjEoGhO3vK7i7DZ0un
	Lfd120KyefzBGPVcnoU8WGr6G1WkVKnSk2gKshZEg7jbVybjuL8QiMFXHg==
X-Google-Smtp-Source: AGHT+IEvuj4VJm/YLrnNJHxn3AeAIY2eAJxnYU43RF3m3BgAU1Cg8jrnDAooaNSfobWtwQdhalbtriXZr1T0z9I/Xk8=
X-Received: by 2002:a05:600c:1819:b0:477:8801:a906 with SMTP id
 5b1f17b1804b1-4778801aa28mr6119285e9.35.1762931587625; Tue, 11 Nov 2025
 23:13:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761715649.git.wqu@suse.com> <2b4ff4103f157ffd2d7206a413246990b3ef2746.1761715650.git.wqu@suse.com>
 <CAPjX3FcPa3mHYajjKJsOSk57o7O3Uas_qP1bvf7QJK3VQzJS7w@mail.gmail.com> <efd483bc-ff94-4cf4-845b-a6c101226324@suse.com>
In-Reply-To: <efd483bc-ff94-4cf4-845b-a6c101226324@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 12 Nov 2025 08:12:55 +0100
X-Gm-Features: AWmQ_bnBK8EcoqgJWPIto9yLQvEkjS5fES2aB1WONkVZFK1CzDYcC8AgipNaGoA
Message-ID: <CAPjX3Fc8hcMPXdGhyHe6T8W9_9T58U7hTjz9+rDO+Se_P6GQyg@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] btrfs: introduce btrfs_bio::async_csum
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Nov 2025 at 21:38, Qu Wenruo <wqu@suse.com> wrote:
> =E5=9C=A8 2025/11/11 23:11, Daniel Vacek =E5=86=99=E9=81=93:
> > On Wed, 29 Oct 2025 at 06:43, Qu Wenruo <wqu@suse.com> wrote:
> [...]
> >> -/*
> >> - * Calculate checksums of the data contained inside a bio.
> >> - */
> >> -int btrfs_csum_one_bio(struct btrfs_bio *bbio)
> >> +static void csum_one_bio(struct btrfs_bio *bbio, struct bvec_iter *sr=
c)
> >>   {
> >> -       struct btrfs_ordered_extent *ordered =3D bbio->ordered;
> >>          struct btrfs_inode *inode =3D bbio->inode;
> >>          struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> >
> > If you use bbio->fs_info, the inode can be also removed.
>
> Please check the patch 3/7.
>
> There is no more btrfs_bio::fs_info.

Right. I missed that. Not a big deal then. The inode is still not
needed here, though.

Sorry about the noise.

