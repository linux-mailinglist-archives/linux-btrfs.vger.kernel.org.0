Return-Path: <linux-btrfs+bounces-1842-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D9183EE1B
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jan 2024 16:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 975F81F22A0A
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jan 2024 15:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A4A2941E;
	Sat, 27 Jan 2024 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aveT/YBj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDB225764
	for <linux-btrfs@vger.kernel.org>; Sat, 27 Jan 2024 15:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706370930; cv=none; b=IfUZPlFt6ll10rjo9KRcew3DQVcxP9Sb55Z+IsYA6PZe1VSisKFSlGK/RM04I0xyt9QYxhpHhun+KR5I6RCjOTZtmxpOu/FN55q7Hmco17de87ygbBxykeL81Lw7opw8QqjV8+NcdR3cPU/euR4DyzSJEdh+mdnXUXONkiboZVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706370930; c=relaxed/simple;
	bh=ptCX21hK7FKJBjpCKt0RRHlMj3O8Zof3shHyPFrxqEw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=sFr1cauX0Xo6bzaWQtB6Vq2yTmfxX0UM96zCXIP/XhGFXCfHRE3QSkTD6HdRXw+6ODQu9we2CFvsgmlV8NUbYrOvANUjQO/K/K/EAkRuT+eVutPg8Lqw+IRphTQdMzbaGLcLnvuSFBhPbEbEHsYMY0c2V+xb52xr4UKfH3m4f6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aveT/YBj; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33ade380b9fso1991077f8f.2
        for <linux-btrfs@vger.kernel.org>; Sat, 27 Jan 2024 07:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706370927; x=1706975727; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4zqV+41/hyRvoZyNtE7zvH1L7Se/TH+Zwi2XJes1hw4=;
        b=aveT/YBjrixpUak//5QVKo7gKdl25p5rNGk8Z+g7Q+tZZgZxCM9LFclXQy3F2Ra6Mq
         ige/ArVQ6RTO5lw7YhTTFT4zW1xuRQ78CoZKV3HDxuOuHpz//8GQ2D1DN55Lny96Vhu1
         eBLwDHWxG5boz1nPJcs6E3ihMI3ebgfnvWcNgsK/CckVkDDlEDawy0+ptdNaFYhvK+ej
         TE9g4Ov/OaoLkyUuuqGGS9vZeUeyjEhhdqltkXjc5yNcHyjDUOg8xZhYW/hlMg9LqW0R
         phm+x3fCBYoZO7ifrWPgsWTh1JWF9+SPpECcfUBUOapMeZHNH+ngk3dEL+rMZ8zKty/+
         wrrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706370927; x=1706975727;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4zqV+41/hyRvoZyNtE7zvH1L7Se/TH+Zwi2XJes1hw4=;
        b=oNuhRZ3omqFlV8TxjXXH5RnYMorT57tYsOAY/U+0TBgSWz11kBGj/8bQpcSJZUlYWr
         fHtA+AlPWhTAzyHO5jIxjRpN7Yr+JAuwxAGfiOBUNilF4cZMWT/0blKcOcoQCwv8iHMl
         ezMPbG5/CxtpvqvS8cBO0QzJOgw5jfWz3pFvylw9I95Jk9kKFiWerTIqpPfBI49SDoiP
         uTdXlHbyMg+Le/lcB3kxXOxO+138Bb/+qwPOeHrrl92cY+dCo3DDiAhP3fyQitWaxOwp
         h64Q41Dq04uGlFRN51W5I/EVuHcjsBL+e3vJHMteQQ0wneJmIb1uoe1m2PRYr2HYn9+T
         IcRw==
X-Gm-Message-State: AOJu0YwX+r7fCF0OPepbQncQEaxm0tgRcpHGA8o7eainGJY0oO1QIdko
	wmXo0lbJ658t6bhx3cg92s+iYz1nKWFbBAN6Ho1uIVWFYwGa8H1MsmrVlnHmfZw7sj8RDLTd9sn
	UB5ubXcqnvuxexVoQbmQNrqKEsbEPzAja0Wc=
X-Google-Smtp-Source: AGHT+IFy3JQkfwdKLnX2y/SgM7sSAQ0UDBZOhOFcspVbienNu0JJaTTFV+FxvGTHqhItrX2uyV9858o2Bd9duWP92EM=
X-Received: by 2002:adf:f783:0:b0:337:bec0:d5b7 with SMTP id
 q3-20020adff783000000b00337bec0d5b7mr924735wrp.160.1706370926875; Sat, 27 Jan
 2024 07:55:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: pk <pkoroau@gmail.com>
Date: Sat, 27 Jan 2024 16:55:15 +0100
Message-ID: <CAMNwjEJ-4ecq-sA7610CH4N34ft3j0uYivYteSA6GKFL5A30zA@mail.gmail.com>
Subject: send / receive handling of I/O errors
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello from a Debian user. I ran this, while decommissioning an SSD with many
broken sectors.

    btrfs send /ssd/subvolume_with_broken_files  |  btrfs receive /dest

- btrfs send stopped at I/O error.
- I was left with a draft subvolume, with two empty subdirectories, whose names
  were auto-generated identifiers.

I know that oldstable (5.10.1) is ancient, but I cannot find a mention of these
on the manpage and changelogs, so I thought they might apply to the current
version.

- btrfs send: What about an option to skip files on error and print non-fatal
  warnings?
- btrfs receive: Is it intentional that it leaves a draft subvolume when the
  stream EOF's unexpectedly?

