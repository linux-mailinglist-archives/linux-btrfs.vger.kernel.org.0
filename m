Return-Path: <linux-btrfs+bounces-19975-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A82CD8277
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 06:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C2D7302CB8F
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 05:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEB0234973;
	Tue, 23 Dec 2025 05:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOxfjcd3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C13A2F0C7F
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Dec 2025 05:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766467809; cv=none; b=gI9CFczdw5Gmrj/Lm8Elq/wDb/KsogOncEMv7jWmN5Odlnspo633cNZD7+alyCrUQ2pLsyxKRoGJK+pFDPgV+x1xbP1/seCfYY0POdp3/QgS3Vbrh2xGnP75spo99HzNQxMqBb3BuRFPIEUImAFSgXLZXRqGJ/jfMZ24pmraiOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766467809; c=relaxed/simple;
	bh=LeHgaTCg3sZgaNtwPEbjvh+7JlJOUXsNXjaOCgEgLN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jn6UzUXfUTOJevhywqV9OeZuF0eK4OEzQLNSElup9hlnlMhjGDzHf2tmMFK1I95NAQau/qJZik8U+Lca9jfQo9QK4gxz52xUgwt3l9ZSV9LVZmpctgVu4einNMv9MSFjX2/PJpOEd3xhVrY600FojGDBr0AMs3/jWOH5kgazp7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOxfjcd3; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5943d20f352so5093863e87.0
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Dec 2025 21:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766467804; x=1767072604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjrVs5qAijx5UEiplGDR4bSOktnBgAEK/U0XoVs0/GM=;
        b=UOxfjcd3KLs0/zOnrEFXM55BIWgg4SWi7QASfMBxTSTBULhPeHWEyu9QQ41IsMHxJv
         Vp4J37vnn0MbCyyHvtoKWrrB5NPN16zaVrihzDqnjfnlEOIzQDiHn/X+3VkweluQlVpb
         b33rHk/R0YoujjZ2Dpv0aI1Upgc7yZ4hOw6Cmv/tLdRxRvhKexEtFEhctSH60l90r/Zd
         xlN0HuUDA8htT+yqvZR6jTx5OHYZZeMVU89zHBe7m9K23LD9P14tIhWQdD0HfBvxOzCG
         taDipDYZVRZsaI4qpACS606KN+Rw6yCh/03YJoxxr656Fng2iSGKjgipon8b0miprEbc
         BsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766467804; x=1767072604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CjrVs5qAijx5UEiplGDR4bSOktnBgAEK/U0XoVs0/GM=;
        b=SxuXCztthMeVIAKhZxajcpf9ZaZxnDytjujmUkzZfjGbiVKtnCr7L49jm7Xj+XBI8L
         rtsoiFGyY+y1/AydslXAseKnm3aI4tM2W9Ua1ymnD4PdFSV89vRMz66EUvuN9+EJ29e3
         uU/E6kJVjjfdFPwtlLYLcfti0svQhY7nO25/Y+Si5/gKtlcVKqp9B5BTcJBoVBYhJIpz
         cI+Jl9WKsfBsijq19JbT3fxuMEPBJ0JPDOClbXtExbQQOMEdhKwwNytf+b4Z5Rw6ThEx
         X2B5jw6UOCrA4KfAbctnbB/W+QUMKCrJvzQF89ITBOXgvwpLrAY0KSFwLHnJu1zzDBMw
         vO1g==
X-Forwarded-Encrypted: i=1; AJvYcCUWNg7Auc4YDRGAzicBkMczQiIY+cmYntGEWdykn1NL+1DfaHUWQwvDmsB0EaamIgj8imgbY0ofWTmqZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgjsmYH8G5zMDCKRrZbG5zJH5X6D7CQ4aUtv5pc/5jnoYfecZI
	rZ9WYdysJPBZUrgD7sUqiKeqeejgmpk9V7NjmB+8b7uLVyWiJQGvFT/PS2Y65TZn
X-Gm-Gg: AY/fxX6e/RTJO5X0vzaI8K4PuVU0mBklagBmQYXUzhCSMBGs8jUWjfnYbk640lLCwXx
	tJ8LmjPCQ594MTGwWouwMI4jORPmn/0i8bbFWonXGOKALl3BHsdHPPjsXyPhWw7noFq9v6RAQPx
	K2MvuIlOT4mYnLc/7mlipznwcWBngVXgq8v6Cw4d1B6GCcoljXdbefLD5Pozz30u+o7h8z87GNX
	C0eQY3Hy8t7kgJKFJ5mvo+vzL3UcvxrYbOqQXU6Hl/TSyMIi/ddfxenb9Hj4of4FQ+S1vtdqYXZ
	0BLc83ftA1rEUjskveMuor0N3XkTi7+E3sTDkDcVRmCK37Y74tQvkx9Lfin2rpNV+Ag8GBB5/9w
	0lXBgrtVJevCK5rqOdY6iU+Y9r/r/5uawhNoYOGO6xeO4a65m/HiZM5KX/t9muA4hbtzGcZ+Aup
	tN//FdZn7E
X-Google-Smtp-Source: AGHT+IFBJ4czf5dy7NoHG6Z5fLR0sF8QwzLoI7Shb3fIF5XKnuFbQtFm8MSKsqZe2birAQ3bGk4BUg==
X-Received: by 2002:a05:6512:3a85:b0:598:8f90:eff5 with SMTP id 2adb3069b0e04-59a17df6969mr4474213e87.53.1766467803957;
        Mon, 22 Dec 2025 21:30:03 -0800 (PST)
Received: from localhost ([194.190.17.114])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-59a18618ce8sm3818747e87.54.2025.12.22.21.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 21:30:02 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: gmazyland@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-lvm@lists.linux.dev,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	linux-raid@vger.kernel.org,
	lvm-devel@lists.linux.dev,
	mpatocka@redhat.com,
	pavel@ucw.cz,
	rafael@kernel.org
Subject: Re: [RFC PATCH 2/2] swsusp: make it possible to hibernate to device mapper devices
Date: Tue, 23 Dec 2025 08:29:52 +0300
Message-ID: <20251223052952.2623971-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <86300955-72e4-42d5-892d-f49bdf14441e@gmail.com>
References: <86300955-72e4-42d5-892d-f49bdf14441e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Milan Broz <gmazyland@gmail.com>:
> Anyway, my understanding is that all device-mapper targets use mempools,
> which should ensure that they can process even under memory pressure.

I used journal mode so far, but, as well as I understand, direct mode is
okay for my use case.

Okay, I spent some time carefully reading dm-integrity source code.

I have read v6.12.48, because this is kernel I use.

And I conclude that dm-integrity code never allocate (not even from mempool)...
...in main code paths (as opposed to initialization code paths)...
...in direct ('D') mode...
...if I/O doesn't fail and checksums match.

(As I said in previous letter, mempools are bad, too, as well as I understand.)

I found exactly one place, where we seem to allocate in main code path:
https://elixir.bootlin.com/linux/v6.12.48/source/drivers/md/dm-integrity.c#L1789
(i. e. these two kmalloc's).

But I think this okay, because:
- we pass GFP_NOIO, so, as well as I understand, this should not lead to
recursion
- we pass __GFP_NORETRY, so, as well as I understand, we will not block in
this kmalloc for too much time
- we gracefully handle possible failure

Other strange place I found is this:
https://elixir.bootlin.com/linux/v6.12.48/source/drivers/md/dm-integrity.c#L1704 .

But I think this is okay, because:
- integrity_recheck is only ever called from here:
https://elixir.bootlin.com/linux/v6.12.48/source/drivers/md/dm-integrity.c#L1857
- that integrity_recheck call is only ever happens if dm_integrity_rw_tag failed
- as well as I understand, dm_integrity_rw_tag can only fail if we got actual
I/O error or checksum mismatch

So, this mempool_alloc call is okay for my use case.

So: in 'D' mode everything should be okay for my use case.

Another note: I used very stupid way to search functions, which allocate:
if function has "alloc" in its name, then I consider it allocating. :)

And final note: there is an elephant in a room: bufio.

As well as I understand, when pages are swapped in my use case, they first
will get to dm-integrity bufio cache, and only after that, they will
actually hit disk.

This, of course, defeats whole purpose of swap.

And possibly can lead to deadlocks.

Is there a way to disable bufio?

Or maybe bufio is used for checksums and metadata only?

-- 
Askar Safin

