Return-Path: <linux-btrfs+bounces-18586-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FA8C2D00C
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 17:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28BA746016D
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 15:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FFA313E2B;
	Mon,  3 Nov 2025 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSYZGuZi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFBF3148AB
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Nov 2025 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762185234; cv=none; b=JJTt3NUydFQawlzBD2Yc/OiihcHBytJnohctRhmqQi0r4nhz1/97dfSUhJUztMjdKPvBHpRGJf62U0G5AOfVZ2SCAybpNMOnqr+dKt4L3eDX7eAf2EJ3ki759WE0HWam7lhL/J0YeD/J3RKAWsAKoaqu9hnYeJuAMVEjR9mIBW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762185234; c=relaxed/simple;
	bh=qrT9BCtX5Q+ZrBSV86ofie64KLKL7GM3W7AojJFifCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rtK8V6AXYQrkMfR+/0ktEQFUsuIkMFdQN4uIsQFFaxuC0aav6prGet85sDmXOm8VIPvKFxYnEsBxjmzDTBTi47m7MuBNT0r3WrE2Q1L9yvQ5MVYH5P9q3rVzyHZaR3x4Tk24HCdAN0jq58iVwwR7Q6tv7ilBDQDr3SVhZV6Vleg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSYZGuZi; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477442b1de0so11677335e9.1
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Nov 2025 07:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762185231; x=1762790031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLey69Q1yRBIRmkA9w/tF6nJaEmvXdViphT1MNeupw4=;
        b=HSYZGuZiIcI0W8S8M894OpH3yfk5w71l42+mebiaC3OAjR+bvqAWD9FzbzDwu8IY8q
         5wyxNEEzI89Aqt17V+goy/gOs6aR4adkVDx1XHOZ9rMfU/c7uMdhxjXo0ABXKGSA3cl1
         4fnWSbywWsDd7WwfUI5AQTIJsJus8C7+frvSNkUeMhSDx4TDN/vlcPAdSoW6IWOPOAvq
         tP5i9W4iKxca1M0NddqZM4uNIhdM+51ZMTAm1hSOk/7ACW1+XOi2pNA2UIutcb2hqeF9
         /r+JOBgkOtBHcOBtNEOzk0yNer5Uz91237F30lKwsZHRFnbr8foaeDwsT4hQzPxDOOmB
         wreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762185231; x=1762790031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fLey69Q1yRBIRmkA9w/tF6nJaEmvXdViphT1MNeupw4=;
        b=W2CQEMroLZD7dxi2raz3KrNjqbUc4dOCK6acqnaXvNG8+S/X4+pJXVaI1ivYWorkSE
         U9yEgjNnGuqE8euzFltMYFCeUQPSmjmILC3Xb6MvROiS3c2EN35JSKAmo94pCP7uhxEe
         kzE2hXa13QfbfC5cUPNtAp0EACwo4S9Ytxl77To3KquujucJuD0WGtd0tjIk5JuI9oWQ
         FsqBgsP2h1yb5TN7McGB2ry5BeItEh5Rjht1TH5O9WbAU6h+AkjqH317Y9Xe9NQ2AtPh
         DnP6wUekBUCPHWWCahHLEHYB90KOGeTn1tlmYECeYgueu+1lqXi98P5gkV7NvESJALSx
         9AoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPFq3S8eVD/DYLumTGGG3cy8hCjCzlJdtsNW2i5UuP8UkntIXajF6zWgyY4V6gUz0gSfhPhLAAjLy+vQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yze8wIVAY02byNwSDgjv1eHTf0XDz6Hmco0+Zs1szGHZWATbvhV
	ngEAvvR2Rg6oMb98mvwlf9P8xILZzEzSGLyK1o0N6srjbuxIE4QePpbC
X-Gm-Gg: ASbGncuHe1GzAwQeAICIPtrAoXu+Kn4olZiCv2OSPvbNhtrfeeOEMdzvYgVVrpmPq/R
	BwmZ2y161fQOTUtybTm0qYzKCay0HfQUyrIN9sGcujKrkENC/lkso14AtBRABCcIvsibFdx/1CX
	5Rp3Okyw4eM9WKM07bJIgybu/3grkwmLRHAQjdNl7IG7GCFVunD1rcSVv0PIBYlp6wdn2rT33Np
	H8uxxRMeWJnQx4rO0+IR0C/i8iS9WHBN22zgGiblgiXt7Ic/PA01q2SgLgj8zai78dMdDaF+Dti
	MeuxyyvhotvSiWr967zPNd/En/2lGaeCgsCBlaFrd8or9QGJdLW07MvsCTMmD0o7lWVegiKMDFG
	uk9bPSeMjiiUS8EKfZ5yq54VU5WI9CX0F4vxAzzIFMDb6xK/zmXy/sbHRMYbQ0dan2ciyVlpc
X-Google-Smtp-Source: AGHT+IGy41LT8aj0/Xvj0W53yZvKvDn5c9ABQJxOklSZONmqbPHs8HNDAqrjQAZba3bO5xPU/Rodqg==
X-Received: by 2002:a05:600c:3511:b0:470:bcc4:b07c with SMTP id 5b1f17b1804b1-477308a8f36mr118541675e9.37.1762185230454;
        Mon, 03 Nov 2025 07:53:50 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4773c48de65sm161908635e9.1.2025.11.03.07.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 07:53:50 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: mpatocka@redhat.com
Cc: Dell.Client.Kernel@dell.com,
	agk@redhat.com,
	brauner@kernel.org,
	dm-devel@lists.linux.dev,
	ebiggers@kernel.org,
	kix@kix.es,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-lvm@lists.linux.dev,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	linux-raid@vger.kernel.org,
	lvm-devel@lists.linux.dev,
	milan@mazyland.cz,
	msnitzer@redhat.com,
	mzxreary@0pointer.de,
	nphamcs@gmail.com,
	pavel@ucw.cz,
	rafael@kernel.org,
	ryncsn@gmail.com,
	safinaskar@gmail.com,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 1/2] pm-hibernate: flush disk cache when suspending
Date: Mon,  3 Nov 2025 18:53:45 +0300
Message-ID: <20251103155345.1153213-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <c44942f2-cf4d-04c2-908f-d16e2e60aae2@redhat.com>
References: <c44942f2-cf4d-04c2-908f-d16e2e60aae2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mikulas Patocka <mpatocka@redhat.com>:
> [PATCH 1/2] pm-hibernate: flush disk cache when suspending
> 
> There was reported failure that suspend doesn't work with dm-integrity.
> The reason for the failure is that the suspend code doesn't issue the
> FLUSH bio - the data still sits in the dm-integrity cache and they are
> lost when poweroff happens.

Thank you! I hope I will test this within 2 weeks.

-- 
Askar Safin

