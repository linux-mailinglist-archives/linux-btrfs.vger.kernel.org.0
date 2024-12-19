Return-Path: <linux-btrfs+bounces-10601-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4139F754F
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2024 08:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A19307A179E
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2024 07:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539A221765F;
	Thu, 19 Dec 2024 07:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1ZJ5kYm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763AA216E0F
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Dec 2024 07:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734592967; cv=none; b=QKKlhCvMkUarVPcO+aaQfec7bVH7TAqVimNn2p/nv0jb2sX7IiRE1PH18PfhyY0LqMqnUhgQAwb75sPxRu/KDwBFsQSXvcTMDXJ5vKBAsIqRJS8IGc3MlZXVAlbqRVPTSEH2cPt8LPxltOrDi1ae8OWMTh5RnRCA62SdhyRoH+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734592967; c=relaxed/simple;
	bh=SMoxBIEDl51NElxgkIPUPugSoLyV/3grqovJxZgQFOw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=T1HlthhlM91RCx4RjEohSetKFK9gi8yp00C0XA/cRo5KHXXAvKiUxrKQxFNH+8TejVtiNwhEwPi322ur0l9smotuXu0lAC2mEC5evDawIRD5HyPazZ1ArH8VYBtXa6+tTyuB3AM+qfgMrszgfOJ7mY5k7xe6oDjnTkMLfB0TUgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1ZJ5kYm; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6f277a1ecfdso3292157b3.2
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 23:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734592963; x=1735197763; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SMoxBIEDl51NElxgkIPUPugSoLyV/3grqovJxZgQFOw=;
        b=F1ZJ5kYmLEWrsJT5GRyxjAYrELw0efOxk3eR6GK10iY8R42TuBlBXg90aiTji2/sGT
         urMkJwpfbxzabmJfUVGxvPH+0Y6mToBkoupslpUbBTDZtwwtHnXEusU71X6Iag9E0e2W
         KZ2MrvfKrNUjS8MQ8Xq5FgRPtzxpWbB6Cnzu1tQfO6Rw7CmonatnH3sWQcxcRUPu/1TE
         n+vKYSTy3750tqcc5NHyAoOzWcuYggi11jUVQBJekNqQ0Bqop5rUrLKt3gfG3QqQn8vN
         9sWrAbcr8OGMKeVBX0huds+MirvC2Bd5aMFKrUhMSkyZMUuGkm3yYEAE4R62XPZzmydk
         VEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734592963; x=1735197763;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SMoxBIEDl51NElxgkIPUPugSoLyV/3grqovJxZgQFOw=;
        b=hB7HjZDaEGCBNWP8Hb50hNEzmOZDA010Z1VtNOnSXdT60Ds9BY6qeeep04E6LSY6+5
         47yNrUJQFagdD7q/i/X+gKNBbxx76J+4yDGM9gOOdMc0kQx8LpmgEOnF2fQvWwUTU93r
         OvXwLSOzb/0u6mfbusnNWbvbvppSQcuQvUymNCk8qiBgcjlfmEG3hhPtSL/Cil5VddtL
         pKvbxeUv0TYRnuI9q7jG4SOXkiP1RpVyZ/1Zn0yydBx68Rn4s6RA1RIO5Ej5Sjo0z69V
         Z2GFakyYiTHmwCV0mXdlhakdG1fimDDKKaOm137bpFl7aPr+mJrqoB55sDR2byXlsJ9t
         PuUw==
X-Gm-Message-State: AOJu0YwQ2iW+RhyPKtM9Svn6EfFl/rFvB+Mc+BZssNSETGXzRKFJubnG
	8evwPvHYD5A/FcWngjVQaa8W1WJOWLkHrCI+Kym0pN6MIElYVxpIYZLrHTiKE2Jcp30kL5IGZMT
	+lPZtdtUx3Uo38N52cNTw5Lm0bP/X2CHew5k=
X-Gm-Gg: ASbGncthGdmxd0G4P+evtq6t1TraY6WAsBwgOo9lCEbN7dJYdBcZ68ZLJIJO0g5ht5/
	M5vL06p9KOQO71154TOLycvqA4y7CQqtfEmhQfm3qeUmjJDKVFeWYOYU185UYNh7U2Bbeie0=
X-Google-Smtp-Source: AGHT+IEZ7TsKawAntFXtkZEvQm5yx0GmaYkYfZ6HcrK8d/Ay3lBWNznjK/jvJn0dOkwuEH8Vsq6/KEqhOgW+/4JRK5w=
X-Received: by 2002:a05:690c:25c5:b0:6ef:146a:aac3 with SMTP id
 00721157ae682-6f3e1b0e862mr23975507b3.1.1734592963358; Wed, 18 Dec 2024
 23:22:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Clemens Eisserer <linuxhippy@gmail.com>
Date: Thu, 19 Dec 2024 08:22:32 +0100
Message-ID: <CAFvQSYTmpGK3w_07RinTWXzgsnkLr5TA4me40mi-evYqgkBQZg@mail.gmail.com>
Subject: btrfs check reports backpointer mismatch / owner ref check failed
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I am using btrfs send/receive to keep two root-filesytems in sync so I
can simply sync the rootfs of my laptops internal nvme disk to an
external usb drive and boot from it when traveling, as well as syncing
back. Thanks again to Andrei Borzenkov for the suggestions and help
that made this possible:
https://www.spinics.net/lists/linux-btrfs/msg142484.html

For a year now everything worked fine, I did scrubs from time to time
and they always reported 0 errors.
Recently I tried to give btrfs check a try and got many errors of the same kind.

The first group of errors looks like:
ref mismatch on [78987264 16384] extent item 1, found 0
tree extent[78987264, 16384] parent 30588928 has no tree block found
incorrect global backref count on 78987264 found 1 wanted 0
backpointer mismatch on [78987264 16384]
owner ref check failed [78987264 16384]

the other "class" like this:
ref mismatch on [389818982400 8192] extent item 1, found 0
data extent[389818982400, 8192] bytenr mimsmatch, extent item bytenr
389818982400 file item bytenr 0
data extent[389818982400, 8192] referencer count mismatch (parent
657195008) wanted 1 have 0
backpointer mismatch on [389818982400 8192]
owner ref check failed [389818982400 8192]

Should I be worried? Those file systems have never given me any
trouble, I was quite suprised to see all those errors when checking.
Could this be some bug triggered by all those snapshotting? What kind
of additional information would be helpful to pinpoint this?

Thanks & best regards, Clemens

