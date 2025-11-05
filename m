Return-Path: <linux-btrfs+bounces-18722-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DF8C34781
	for <lists+linux-btrfs@lfdr.de>; Wed, 05 Nov 2025 09:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A81334F6463
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Nov 2025 08:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2EB2C15A9;
	Wed,  5 Nov 2025 08:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PEjhYRDI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE26292B4B
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Nov 2025 08:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762331292; cv=none; b=qWI05zAaTWoXDAVvpyrsCw/Sm2tRw0UEfQ1r2s8e+pGDLARIRYMIHPLlmWRipzLcEn4Hvk51blh8T3ZIt2NN3ylWBgM50eXhnCSgEwhE9nczfwvE+I7TjeDJFryhRMVj6d8I+Se5KkUT05evwxsq0GVE7MlgJ3ASwW1vgljH1JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762331292; c=relaxed/simple;
	bh=8NKSGVCmyL4Ifwyu1+zZIXLky+wioMllSkmrJhgn+2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L1wQC1kErpPgjUjVpHlOBJhyduRYae81UEhFjtn6oGV2wb1B1GZyezpdi4/5081Agm0oDfzP1ejVsOlVGaypgpS/2RuSMjOHcshXEDaaXCaj3C5CjkYesN8kEMJp2dHi4pcntKRewNWtuaCQVrE6QGtss19VHhzpC6lVwdGq55E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PEjhYRDI; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-429b895458cso4293965f8f.1
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Nov 2025 00:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762331289; x=1762936089; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8NKSGVCmyL4Ifwyu1+zZIXLky+wioMllSkmrJhgn+2E=;
        b=PEjhYRDI2BeZS+ZxHyM8e8juQZ36+WhuEl7ZbRHCd4of0ZrxFeFEbMZjRk9W2Bta2O
         yile+2XSTUqyZidKhl+W4IdXz2JPjcrMdB8vmDKsGV2Iar4HqI8Fg9W2xUQzud/GxtMZ
         lmm1j0AGzBpJDuA8hDq9SSn2msvuf8bKlQ7IWS6ZsSuB3fcNDnBmudQ+3dcJh5ZXJSEP
         TRBeYtbcm3VFVAZzaor9ijYbc48go0b3JQJQTqDcUj0nmxoS0Y9dedlNXij/HdnmZ2ez
         PTro748UrVEshKXkFXfOSmu13Jp9h25WI4QVkDuA4ZRx/rD6Iyziz7QgYBrGNa+iyxQN
         E0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762331289; x=1762936089;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8NKSGVCmyL4Ifwyu1+zZIXLky+wioMllSkmrJhgn+2E=;
        b=RSZWVRBlBLsor11df9jejmxT+eS1O+ySJs3UUkbLdXt2pdQr8EKmL1MIhQgkKNITMJ
         BBQf90KwvUdSyJUjusiwQb+0g9yZroz+bXhRRt0ZaBaKheGZu3xKqafC1uATcvKRQa8m
         PTvkKFYLXsBvVpbB+zFZYZX/w4aGFB1eMk3ovXVNUOUV9etlD0Ov9R7uRYypY0bTNi2r
         NPos/NBXLv36jDMZfcplN3EuNGwG7O/F5CisYP3xdAbaHydil39LinDEM1jWo4/MX6zB
         Hp36WueGYmK/AGs8wP8+nZrtQJ9GyekYVzh6CKUlU7cQ3vlvyh9DC+kFqJricHKPFt9p
         bTSw==
X-Forwarded-Encrypted: i=1; AJvYcCUdJtt7kbxO2i8EUmWUjpshLqPNHxghIPxGXScQQhI9qGdvEcZJtrCqWPmKk/xXnauEzDM46oNeeU5fjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJoKuu9N/dqjxyR9qctErzjbjadkYAthTwPKeDoREPhyaPZmyN
	Kk6lvdX7iozUWwuHb2SPbRNTF0E6aaUGrPWGjoxJQJwXGuVmVTr/mAIQrpyQMA6KVLG6idwKhhI
	9z+rAfg9NMaUrz0u4lpMbxDSYfTgBqBzNRZZ83Ef4Fg==
X-Gm-Gg: ASbGncs0fiyx27+6Nw84lO44pmL6/4Y6OfXdZarOnFKDSnjah9gwrUtSJeWTIlnDRG7
	O51RLuKaLCkuQtt7ZrPQUjvLJ3NwHGwWNU9dAmiU13zyotdU0cL0I1RCeejEj4cmZ4r3mna8LEY
	qETsn9iLaV0BnAZh1Xr/05+1N2LHGliIYip/aIU3u4TZ45NCuf6W6Lm7+M7dGHKyEgBCiLbnv8w
	pH+WGNImUyNd1OBl1Ql8wzMck9Zcutjep43Ai8JrXpkzUXpSM6bfZk4B4ZJaygvf7C7nhx2vT9j
	wQs/e5pGQAcFhaLGcCkZA00xkHz5shQn/PT8wZ5LZ3fPwUf8xSwTE0eedg==
X-Google-Smtp-Source: AGHT+IGgXcKyICCNrZzVXlI5SaCjOvqSaiDD8Lr+7/wl7uFs7o7ENZkgys9D5bZ1UGORGn2KxiZSpU1SvKVjqVoc6AA=
X-Received: by 2002:a05:6000:2f88:b0:429:dc4a:4094 with SMTP id
 ffacd0b85a97d-429e3306521mr1772837f8f.30.1762331289156; Wed, 05 Nov 2025
 00:28:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015121157.1348124-1-neelx@suse.com> <20251015121157.1348124-4-neelx@suse.com>
 <20251024212920.GE20913@twin.jikos.cz> <CAPjX3Fc6abzXgE+_S6tKjmh9uUmsYo+UUE+5V8uGMK0QqLAKbg@mail.gmail.com>
In-Reply-To: <CAPjX3Fc6abzXgE+_S6tKjmh9uUmsYo+UUE+5V8uGMK0QqLAKbg@mail.gmail.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 5 Nov 2025 09:27:58 +0100
X-Gm-Features: AWmQ_bnq1EID4_2ZwjsCO9l0xH4wKbTJvkNcJ-rtV2QqOiojehFhsJKOY5Aup_k
Message-ID: <CAPjX3FcLQMOK66PkrwTSmuEckhK5G=dZYcFkY=tBohWcJwpfhA@mail.gmail.com>
Subject: Re: [PATCH 3/8] btrfs-progs: start tracking extent encryption context info
To: dsterba@suse.cz
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Nov 2025 at 09:22, Daniel Vacek <neelx@suse.com> wrote:
> And it still makes sense to me keeping the

This bit should have been deleted but somehow resurrected from the grave :/

