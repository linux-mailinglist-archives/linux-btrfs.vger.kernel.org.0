Return-Path: <linux-btrfs+bounces-18860-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A670EC4D447
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 12:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 11ED74FC98A
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 10:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17AA351FB0;
	Tue, 11 Nov 2025 10:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpaERnuM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5A43587D0
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Nov 2025 10:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858294; cv=none; b=QIDFG8A0HFSjBFM8KToLVHkxDjN1GJUV9gFMVPnPISasOA6QZXhWL16emd92NtStQn4GSS4Et9JkKI7eGztjEGNKHexZI5zRnKfXcbqpTArr5GYEIMR+dgs+x4gifWaIZdIiG9IzN0byuRipa9ix9QV5NpPgvTXw0JXZYzNMPoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858294; c=relaxed/simple;
	bh=vPr1scoxGtbmI1TsSsArbT+P8jwt6C9MLoZFTdOfUEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ravna8fg6U+Jnl4vKrFm1cEBReFiHqhaeslhvQhId5grnVhrUy4FBWsFYzLMKErpfiV8eGae1yjpZsNDprHxl16wC2fW9EeLRt4w5YJy4c/7WlH+WeXhwHKTXuvUfk9f+aq0tWdrbtXG8/EzyUAebBk73mVanQd3/GCj/aPI3ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpaERnuM; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b72b495aa81so481996466b.2
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Nov 2025 02:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762858290; x=1763463090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyRA6gYtZbT9Mw3sUgTpl2KwYTBM16vhFluIQHKp75o=;
        b=QpaERnuMTABIskdkD5nmVq7dv34QFBIgaFwvrvRl9fVlr1DbCtHz5B1oHoz4bL2ieE
         JoQvn992ASDqXAknpRQOKOICUcW63r/nsl5ThTnTVhDFsvudLTejokGkmtXn7O4uc8gc
         QuyCVll6QY+hPt61DjQBFSBbBpPdXEI9AJZs82IdRe0q7cs9Ygz8xhOY+UkWJYE+hAx7
         NofMT2tHNoEj1l0Bygb7UMR97Hn4dc076EInKbbJ5qY+GbzsQZLofHEMa/MejlsuPA34
         yiddEybSXJN7Gnm/Ar+UljD9gkYOjb79ECQi8q8RqxRmSvUx1/mZvD2JU/WypfTPC8zO
         0tvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762858290; x=1763463090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JyRA6gYtZbT9Mw3sUgTpl2KwYTBM16vhFluIQHKp75o=;
        b=chuHU2BpL3V+ArE/z1D54i3vbOzxF9B9UOxjZuPAfTTzjPkvGev1b6AQlFK6SThpTw
         c2qUeofp4+uEhLAVr9ytON4PfQb+vbRJprp1HQtPG4ef7jZX/LvAVyFIMlqpGhLI5qZy
         vXmKPBxM7OPq+QVSgIOUD8vrx71JyQO7IBHISIKQB59GjYS3a9QegxFL+Ycq0Jw9ow7V
         E3s3b+tETMclNa/IpkisOVVDx6L759r0nk80bqFrSxsIzTKEy4mNzxT3xqCCJYFvG4NE
         0sAqubXq3GqEQCs4RcGh9XXAGNWVd/jnBydvtnWbpOGKAUwbmjqSCCR5YBjGBu4hSX/f
         U1ug==
X-Forwarded-Encrypted: i=1; AJvYcCW7HN4cULncdUABI0FokoFG+Aa6p39rCQpR5L7pc8tkzDe0J236meX56ombYM0Zyg+y/avKTmXwm+EuvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaAan8jl/hbii4rBMI91HLgk4lvk3dGni67o2txZKJpnnj8Qu4
	IqsaFeieAUCaVvuIfWbCNcMrNDjIrLH+sRijJ3b169dT4XZIOA3HsIHN/pWfuXw2TTk/YTP9bG1
	frkvAT9KLvwH86+b3ADWTBKXt44zywiw=
X-Gm-Gg: ASbGncszXVD9xVmAz+09ooTnUmU+6Qrldze89j+kOqC2gsD5yVihoEn+VRd8aB53ayA
	r+zlUKZjRnEqLUu06sqLXInNJU3m0yQ4XIMOZHZVG9uSoFERUTBQdhY5gWEXfGQuvQ+WAquH3Ti
	tleXdHbHP2QLwFiSMg11QJl3Y7Q8BPFDZF10m/i58y+f6gZEHwU57q7cF2fJ6qk/5S76cgo/hUi
	B22IrBAcgIfL2KQzWS6+7mkMWABElCeVZY5lmWQP4yF/7Q2PAhU6Bxv211DiyJe8jAgg03dNuGa
	cgLvAyiO3ts5RuWKeZf6WNtY8g==
X-Google-Smtp-Source: AGHT+IFP90bpnxcRJbh5J12wLzHjlkCHBBywRDplR18eZEpmH4Rt7zS3FsYlYjWxsSba+YDC3P23rVwO6aIRX36AZeo=
X-Received: by 2002:a17:907:a0c8:b0:b3f:9b9c:d49e with SMTP id
 a640c23a62f3a-b72e053f2b5mr1192133066b.57.1762858290266; Tue, 11 Nov 2025
 02:51:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107142149.989998-1-mjguzik@gmail.com> <20251107142149.989998-2-mjguzik@gmail.com>
 <20251111-zeitablauf-plagen-8b0406abbdc6@brauner>
In-Reply-To: <20251111-zeitablauf-plagen-8b0406abbdc6@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 11 Nov 2025 11:51:17 +0100
X-Gm-Features: AWmQ_bnCfFeVSWAwyetntRCBd7NVaEKInyv2_DDSmZq9FVu_iIxSbOqFI30GDbo
Message-ID: <CAGudoHEXQb0yYG8K10HfLdwKF4s7jKpdYHJxsASDAvkrTjd0bw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] fs: speed up path lookup with cheaper handling of MAY_EXEC
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, tytso@mit.edu, 
	torvalds@linux-foundation.org, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 10:41=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Fri, Nov 07, 2025 at 03:21:47PM +0100, Mateusz Guzik wrote:
> > +     if (unlikely(((inode->i_mode & 0111) !=3D 0111) || !no_acl_inode(=
inode)))
>
> Can you send a follow-up where 0111 is a constant with some descriptive
> name, please? Can be local to the file. I hate these raw-coded
> permission masks with a passion.
>

#define UNIX_PERM_ALL_X 0111?

I have no opinion about hardcoding this vs using a macro, but don't
have a good name for that one either.

