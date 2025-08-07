Return-Path: <linux-btrfs+bounces-15911-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 244F1B1DD4A
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Aug 2025 21:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14E997A4B8E
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Aug 2025 19:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CF4221737;
	Thu,  7 Aug 2025 19:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbCvLUWl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64F0198A2F
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Aug 2025 19:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754593472; cv=none; b=YvR5prlaEHuMq3YJyumDP9kvLuoLF+KF/uJx+gqK8miHPUaS97MlqnMuRGUdgvw6sfB1ZSHNuOKrA0jWmlEfTVuynMoUIfOt1lPYNPKHYWjQcRVV2mYE1bIxbtVlU+Sij0vbYdEUCfY33ZTQX21waJbOzgI7hg514IdP72zLCjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754593472; c=relaxed/simple;
	bh=c9MB4SgeqbPEIwl4u5tTT+AOeTcQQicO8kkRTrjbIng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JjRCyloFBsrlB9Pu6SK8EJ9qFc4WcCAPPQ25n9ZzCAucrHXkbrzmUrCdmtjUGJT3O+FaOGGU/vz3I296s9CEDo1cLlraPRu0s3HwINQ0xxSPJkt9//ELraaA3Hxb02U+M1tTV3bAtkwkDlCSwQ/mKVIkM9ohMo4ohcBNSeCb9yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbCvLUWl; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4fc19b5fd8cso477984137.2
        for <linux-btrfs@vger.kernel.org>; Thu, 07 Aug 2025 12:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754593470; x=1755198270; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c9MB4SgeqbPEIwl4u5tTT+AOeTcQQicO8kkRTrjbIng=;
        b=nbCvLUWlhYErPJ0Uuh7Jc/VSre0PK/211rXlkBUNVQLLnI4EpxhK+sE1iDu3PLtpO7
         njACpTOZsQnPF7p7df0rtDGB4UGVAc7qhQpHg3wCol7aTtvnmBGksFlcWIs+FjfFIuFC
         PKWiQlLoRHHqTAJ2yWRLXAplF2zyLsRuIS6w7r01ozWr21WHaYI3yafpcIy5Lj1W5dg5
         EFpkqi7vdAl4m/L+pkDOzCr+NLAfJ/mF3V2Xu2Qu9LN6wVoi2UVqyskZtLvsuzVwp5yd
         +vyFQeDZ+7f5/AEV+RpPg1cnFYCzuHGP8zbpmVv1rufbP1TmqpqjtLM0s8Mkvj+kgj7n
         0G2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754593470; x=1755198270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c9MB4SgeqbPEIwl4u5tTT+AOeTcQQicO8kkRTrjbIng=;
        b=OHTZf5mr/6w9qmQmH0TTAQk+oRK1dQwZfR2aE/gB6hOOpsM/C1a54ezk4QOfxb0ux2
         +JrSoh4A8dqTQMSgu9/lGJ5iCtCKL0N366Bpd/ZZTFSqTc7QpRY+S/DwP6lVUSIucUV5
         5+Rx7lopK95nGQjcObnUtzSvgkOBNVIxYOEi61Dzsm+UTduqq6Y3215QVQC9HBVQBCPT
         GQy0Ny2Wtp2n3BkDB2FWoHJvdXXkncRzqZstgIGuSGxZJH2bdiwCfAwANKaGgeRBjmod
         Iw7n1aEEoxeN0aMDuvL61KjJImyO+20DQXOMa0+gxZX8qUGWEeQDYs0gnMSggtRxYZjG
         3TrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSPzycNK7C2T6xBH/xpwEghj1XtzGL5vAjl8+T4J0zOmAtIDHvnA83L5PmeilrFHZBZwm4AmHZFH1X9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhKp7762T4CD4+SWYIcSz9rEm2mwS1l6iIuOLLXPymH8mfdhI3
	fFk46VgMM2jaIyfRP7fzKYBli0HirlTFFO4lS7w9Bg0yC7FrtKQWHmCS3yXo2wvD0PGdi3ZYPU2
	QiPQ19Cf6wyasJ06ITtDI7WoPopB0W0Q=
X-Gm-Gg: ASbGncu5aMfMujd03lUPocLN9rHSKaG89fJh9KwuW3N1pbkJS6ckLd+Y1u3k6dv0yw5
	sbaS2KKZjJ4020e2MrM7G+0cPah1gFZpvIzsDeLI7p4wlZz2i92W23bkUnMlMtD1oSoOs9nBzaa
	pnZyqKw1mx+Y/OxZN9HE5S+RXZIAWX59PblBNBXrmhsH6Ccg4mPIzen2//LrJrJW9i2gNcZvduZ
	q2hVfk=
X-Google-Smtp-Source: AGHT+IHqsOiul5mdyk7ALT6wyG5GJUC/a2pmMa+jLA5npl65CF0dObuYy/8beVkJZbWXm++lmuFlX9ZbbB2/O6q90TE=
X-Received: by 2002:a05:6102:5128:b0:4f1:7946:ed52 with SMTP id
 ada2fe7eead31-5060d7c1df1mr148271137.12.1754593469664; Thu, 07 Aug 2025
 12:04:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728020719.37318-1-sawara04.o@gmail.com> <20250807182350.GO6704@twin.jikos.cz>
In-Reply-To: <20250807182350.GO6704@twin.jikos.cz>
From: Kyoji Ogasawara <sawara04.o@gmail.com>
Date: Fri, 8 Aug 2025 04:04:18 +0900
X-Gm-Features: Ac12FXzmiwwGLsVrfd1raJfSlEvHUQli4G0NegkKm47dmEx9lUg-i3gXZgTazP4
Message-ID: <CAKNDObCBkhaWrU_tNK87Dvb7yBy0njnU4=xD4G0vpk+SNzJSLg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: restore mount option info messages during mount
To: dsterba@suse.cz
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	johannes.thumshirn@wdc.com, brauner@kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > After the fsconfig migration, mount option info messages are no longer
> > displayed during mount operations because btrfs_emit_options() is only
> > called during remount, not during initial mount.
>
> I see messages at first mount that I'd expect to see:
>
> [625.459381] BTRFS info (device vda): first mount of filesystem bca4e1c1-9ca9-441c-8a6a-7004e31763bf
> [625.460384] BTRFS info (device vda): using crc32c (crc32c-generic) checksum algorithm
> [625.461192] BTRFS info (device vda): using free-space-tree
>
> is there anything specific in your test other than mkfs and mount?

No, not really. I've only tested the mkfs and mount operations.

