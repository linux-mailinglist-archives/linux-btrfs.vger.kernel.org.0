Return-Path: <linux-btrfs+bounces-10880-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23FCA082C9
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 23:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA183A849D
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 22:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4BC2054F1;
	Thu,  9 Jan 2025 22:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhrDQZ9I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92346A2D
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Jan 2025 22:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736461975; cv=none; b=jlxswIpJ0sRpGu2CrvdGwZlqcClaRsbaSEMgNjT365YFuo5SC94x/D9kgu00yFwznugaNMjohZ35jvXHFDvGndzcjmp7DckcIY18EPkBV2JRUeXiRnYMsCbjV/GsUBGXND0bXyIu5PjDDoVUALfp457Sp25xqRpvuz6JnVnqxy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736461975; c=relaxed/simple;
	bh=hDyWuEV/xZwnq17fR3wcmMtCd5Zws5yOpCngcZE0fpk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=uTyuT7ZzWGBO7BfcG9mpGvyIdwdXVZhIRhDtl2Q5ZA35q6nRcn/8hk65raLS6eSrgQ6KrT9Ybvi/NL07i/plIi19agh2KGZJR7E+8j0S4dG7hfbSAzJyC6x0+ECIYoFPQLKGkDR0f+lLd0TkoO2ZAGicalzb0rqgUQplIQCRmwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhrDQZ9I; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa68b513abcso261993266b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Jan 2025 14:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736461970; x=1737066770; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hDyWuEV/xZwnq17fR3wcmMtCd5Zws5yOpCngcZE0fpk=;
        b=FhrDQZ9I5U7a30fMygAtbRV66Iosax4B2vhm7yKGKMRtRFQ2JAr40ba9MD4HXz86N6
         mhtwb7xit4LkknI9SCajZQtAkKmXrzfdfvU0fbMlyl/rg5B7i24pBHJ/VRYLMz7B2st4
         OnIlNExHwVgKSebk/lkr+yqL69mFRq8cgih6dCvUmmOv0CwAC0H6U/OEjs28zEQXaz1t
         nJYILIw4Q5o8LOlBLQ9sneyHl/VnCvdbHSHmWCjAWKw4jAsxavdqUlrTlR//9L8nmlAR
         F5bE+7if8hAPM9j89LbUIH7xzbN+TpbjEk1aiLjcbyYIBPY0qMzvY7e1JHYCRiDpotGu
         NbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736461970; x=1737066770;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hDyWuEV/xZwnq17fR3wcmMtCd5Zws5yOpCngcZE0fpk=;
        b=rPhrlcudZFtQ4dKTVCVh0g7cavh85xfQw1PpuNiD6VxTPHtcf1FX6tPv71lHlzkhZi
         NoCwQUDGQwZvjI/ClBXtqgxWN+X6T17Cf1N5Cvjun87ljfRXn9F6vviy2T9b00RCCyHd
         1En+415a/PjyQ6k6ShrfCODDgF8hZpQk00KfrhfC3Iul+dsz4rbCpwyN4F0Y80D+6CVc
         bGS4LQ8XSeYOpr8Lzh8hwRZXU8TYKZkiydkbbpNunggf/gq2yGwxnznH6wXkXwODyEgE
         xzvlw2svcjqH+P8+OAgHXYiTYR/PhVxPJC6fg/DEg9tmGcdqMANyKPmQRPNg1XZtqT6v
         Wd+w==
X-Gm-Message-State: AOJu0YxjAHT/qTbLJQnRSuwP1DFSgdh6eFWU8ragdZKOsTk2Y2fApRQc
	L8UBJJ65tZy4xwupCsBH6/CamC1Zomsf/n1QaMQ6uFFt7FUGLHLNrG36pi6VJygqpd+SYjLrDEx
	ajvx3CKI2o9FcYaIVhd7Nm1mmqFHgNMRhie9Gsg==
X-Gm-Gg: ASbGncsAY4GcHpE3Rh409j1Vq+KyyG4PcIUWc6MOa0Y/NfP1piOjAwn75hVA8Hn6I1L
	rRiu+1izNJ7H9GfiKk5mIY2Y9q+jup3kOSmJI2+Q=
X-Google-Smtp-Source: AGHT+IFoUCdxWAvPLZgI1OcYBIwzIyAybF4sLEE9GOntqPiKZ8UccY/9Pk7ZuI+MRxxxE7szIGq9XOck+eqnMAJzJr0=
X-Received: by 2002:a17:907:2da6:b0:aac:2297:377d with SMTP id
 a640c23a62f3a-ab2abdc09eemr713752966b.52.1736461970251; Thu, 09 Jan 2025
 14:32:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Date: Fri, 10 Jan 2025 00:32:38 +0200
X-Gm-Features: AbW1kvYkqFd_UqP17wwUEhQWwJGAu6BWcDtMSGNWiro8uTeka_8IvFeAFiTswII
Message-ID: <CAOE4rSzjUzf66T0ZxuN-PJqjRuoXoC9-LBQqg4TJ+4Hvx4h9zQ@mail.gmail.com>
Subject: I created btrfs repair/data recovery tools
To: BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Maybe it's just my luck but over the years I've gotten several btrfs
filesystems corrupted due to various issues.
And of course I'm a real man without backups :)

So I have created https://github.com/davispuh/btrfs-data-recovery tool
which allows to fix various corruptions to minimize data loss.

I have successfully used it on 3 separate corrupted btrfs filesystems:
* HBA card failure
* Power outage
* Bad RAM (single bit flip)

It was able to repair atleast 99% of corrupted blocks with matching checksu=
ms.

It consists of 2 main tools `btrfs-scanner` and `btrfs-fixer.rb`
`btrfs-scanner` - scans all devices for btrfs block headers on every
offset % sectorsize and stores this in SQLite database
`btrfs-fixer.rb` - uses created database to find and fix corrupted blocks
Because most of the time block checksum is correct but only content
itself is corrupted,
that means you can find earlier generation (unreferenced) block and
try to guess/reconstruct corrupted block by copying data from the
earlier generation block.
And if checksum matches you know you got it right.
Additionally CSUM blocks can be fixed by calculating data checksum
again and if block's header checksum matches you know your data (and
checksums) is good aswell.
These are just few ways how to 100% verifiably fix some corruptions
but `btrfs-fixer.rb` does more (it also tries best effort in some
cases it's not possible to be 100% original - ie. missing generation)
and additional repair methods could be implemented too.

Note that in my corrupted filesystem cases I tested that `btrfs check
--repair` caused more corruption/data loss so `btrfs-fixer.rb` is a
safer option to try first.
Also I'm not aware of any other tools like this.

Best regards,
D=C4=81vis

