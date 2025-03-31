Return-Path: <linux-btrfs+bounces-12683-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5AAA7633E
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 11:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0486A3A762D
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 09:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1241DDC07;
	Mon, 31 Mar 2025 09:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I9x3VF76"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D19E2110
	for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 09:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743413739; cv=none; b=K5QbZvWZqNSkLTCNSnPtOEtlUMpk3ahto0VfWVoY9P1RJ/0XY1Qw3Jdc9fJArRk5YMeoaPWwx0V1QtIqmg/aphSDff8aE/uSeU/98idSO3mEG5x66fLFv51egNB+gBfHGu5LYqvlz2qILotUajxRtQLek780AGV4V8kDn80LF5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743413739; c=relaxed/simple;
	bh=8na/WWQKxg1YyfaW4XmatUmsV/z4fScBtdgctwoiYno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qgLgrh0aH9tvYJaDvnHLizU0Ps1BiI98vHIRdmS7O+4OVT7zWBh7rHXjwIoNKNNf0X2yZuVa4jUBTcKmrDv7jzD3eq9cr0ZwpFpOh1rJ5f3aJe0AqScYnRl1aDU1hWi/afhzbTJTjtTEOof0QgJsWwzBQEKculGL8gea3UIJ0fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I9x3VF76; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac6e8cf9132so753174366b.2
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 02:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743413735; x=1744018535; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8na/WWQKxg1YyfaW4XmatUmsV/z4fScBtdgctwoiYno=;
        b=I9x3VF76vUI+wEBkAForaUN1TgTH3MeHQ093PJW6yKfyPWkwFOVPG6jnf1zh3/lQT0
         WgZK/FM0kBkLkPRMOnw1I1PRZuwRZ2dwbMS6NGTTqAxs05ptfUJPeAObjKIRcCIFh9CT
         KOd8Is87E/vRvUFZCqQwOipXzzoQenJtOyNmse8eU0MKZVMisjrIeguQpAf6lKcjd3wY
         X8N811N769wKo0co3K7YLF08W0lHggH9tiCxKPppz779WudvZv2F1duT/MY07Dyijhls
         BZuP7JpD9bne6+XzycAQihdD3olpkce5v66hkYk95zmwPeOu16pKP1nIxM3Zf0YaRNzQ
         zaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743413735; x=1744018535;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8na/WWQKxg1YyfaW4XmatUmsV/z4fScBtdgctwoiYno=;
        b=lILGt4GjokKfulTDpTlpRrFOZwESMh+ncjT1BLrUSbvO/QEJ8oyF6/ccN4xrjjLHWq
         4qr96LK8b/q0pIomN+Odg7Jw4LWW+gCOJ6zhkvHYhZ4KNLPyDhvnkXegCZ+rzyRR3PRQ
         qGD6ciTjStrs8D2P2AejEdFykTd1OIzGHNhdgZAyKOERCfCKo6l30pTLMgr23cnmDaT5
         aWRtT66rql0nZLaQIcSrRogekmSHoZyKXnsi7R3aQkM6Kyr1xjRrYoYuiQduSisGxjpO
         9iifUCav6glHhziFPMDZ141CR1zi5BvV14hiTkmHHYhW3bQm7Pwpg68uKGW6xpJg3g5f
         OmrA==
X-Forwarded-Encrypted: i=1; AJvYcCUWrjIfEzBGWG4MF8G1RSDcEajppBEjO6v9hkZDdtr+NBJVUiYnJwtAcMnOjzRHNWgC8KrKfp6ccpbdBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCxX+dOfKm/2AQFyvlwzIERS9N+6jxhWr22hUMEACZR8lqdf7C
	ZnHwFLKsOy+41cvyUOQrqaMFyPKorTteWd7Rcw/raiuSvHAme+X1UM8gPD0+1xinLPJ3g2FN3D7
	/c6V5meqJHkfbMV6FzzLQw7XNxCkKi01OAKS/Tw==
X-Gm-Gg: ASbGncu5aZ5OQyFLoPmPGlOYG2Vi4+o9tSt4SiJPed9VOSJ62oNB0RPD0lAaDrao7Jf
	TAeSKXfe04T//7Ncfj4BMkmpSJxSV9IRvWmhxKbEGx7JPqQ+iVLxvJ8iEIsDtii6dds9kMf5Nyl
	Dy3KafbjXEsl9lCKLHqpfO6mYlR0djU4kw/vw=
X-Google-Smtp-Source: AGHT+IE2yGpZbe6YhYoSHUt9Opw8iplyQ8zwdEtM6ZNbm3AkUqTrj7+J7TxELtEucmRmKuvGDuM9jz4S+VvB0c25ovU=
X-Received: by 2002:a17:907:7e9c:b0:abb:9d27:290b with SMTP id
 a640c23a62f3a-ac738a0d389mr645715966b.9.1743413735544; Mon, 31 Mar 2025
 02:35:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1742834133.git.dsterba@suse.com> <20250328132751.GA1379678@perftesting>
 <20250328173644.GG32661@twin.jikos.cz> <20250328193927.GA1393046@perftesting>
In-Reply-To: <20250328193927.GA1393046@perftesting>
From: Daniel Vacek <neelx@suse.com>
Date: Mon, 31 Mar 2025 11:35:24 +0200
X-Gm-Features: AQ5f1Jor3wg0DW-TpNt8Z5OTTqK_NgkwYFqhoOQvG9-3hnaJFXjKF-c8nICErII
Message-ID: <CAPjX3Fd=iZ3TTYdc5_P9jCE-ntdjv5s3WhG=gy0JNyq8nX+vzQ@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs updates for 6.15
To: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.cz>, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Mar 2025 at 20:40, Josef Bacik <josef@toxicpanda.com> wrote:
>
> ... Should we maybe allow for users to indicate
> they're not dumb and can be trusted to do O_DIRECT properly? I just think this

Seriously, I don't think it's a good idea.

Though, I'd vote for adding a tracing point so that people chasing a
performance issue/regression can check if this is possibly the cause.
Yet, that wouldn't restore the performance for you, of course.

Anyways, if you really trust your app that much (hey, it's your call,
right?) you can always patch *your* kernel. But IMO such a hack does
not belong to the upstream kernel.
As Qu mentioned, the FS needs to stay consistent and not allow users
to shoot themselves into a leg.

--nX

>
> Josef
>

