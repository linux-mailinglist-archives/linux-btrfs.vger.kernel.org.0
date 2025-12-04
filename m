Return-Path: <linux-btrfs+bounces-19529-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B171CA559E
	for <lists+linux-btrfs@lfdr.de>; Thu, 04 Dec 2025 21:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05CCC3017921
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Dec 2025 20:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAE535CB91;
	Thu,  4 Dec 2025 20:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgg5Ez86"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A44835CB83
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Dec 2025 20:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764878798; cv=none; b=QigXI+2Ri/Do4KRMk29ppcuViGMqO+A/NxAFKuh/zq1Vaj0Ryt0Ss/BZ7+PDyjGD5AtC5FvPEdjS4SwLIOSU8k11SFLFBgNx1T8KzIJ5EG7MFiCRC201EFdj0LmVynIMYdRlBJhQs6BcFmgd0cf+/Zy3Sa/bTHezsZBPQNrwnP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764878798; c=relaxed/simple;
	bh=/NEcRFspOe9gEVs38BMOKUdImj2lBEAMhFOd00j/nTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJbS1vIfXjkWXGC0fxzb7eGwa/I1+OgcgWz+L9+FRMDMP/X1ueXtEgdWhfqQu7iS8OIpqsPI1x2JkcuZHeMEIvqVVA9gdCPa7WURKLT72SPMHde8QptIJaVBH/kiSVKtsw4TWGz1/B1s5rhVGzFSa0GE812vWPZncb3pRAx4TJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgg5Ez86; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-37b95f87d4eso10603611fa.1
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Dec 2025 12:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764878794; x=1765483594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQb/7YmW6ISyDQ/7QMoKmPvWtSDT25otmzwTFNv9W1o=;
        b=jgg5Ez86NCBV2foypIHgH5p43CNuTomZez/9NL7IPreRFjwk3sDkfPerAXZEfiFAI8
         vXho8RkgCpU2WQOnlaiRc/bQv5fR/7M+uX/3+KpWiERvkP33sDOCMXDkh02EYpWkyLu8
         Rrhkin+s3GqtJl7v/Al4TVsa/CFAXrQmUGPkpHrWLVZNUJgwlU1UU0g0j7ZO9oQJPj7d
         RVFNCZ1WiZ3daF8CkZtilJ3VOIgO0Nc5+ei4toYuN2i5FBekilR0eYQ4daPJsR1u5IuZ
         o7oglAP1v1lR8Q3Kay+sJv2uHwnfJLYyKrNlP1fgdXcVdyrs1RA0qpWPtuDDq5R1dJX4
         FyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764878794; x=1765483594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DQb/7YmW6ISyDQ/7QMoKmPvWtSDT25otmzwTFNv9W1o=;
        b=tJdjLCwR82UlzrAKgwFSQvaItJWe1X/4+53jrNg5rbvg8pcqvnl2pC/WRX/230KpR5
         qLGod05djB8fI68oz8kJ61zfS+FaIpIQOTPeAr+43QRJUiXG3mqt7oBAugQtp09Xu42r
         8iPDuuUVz5r/nHWMn1Q9f+mOUIKtvFksjYDEQbarkzUJm0d9Yr0kmbB8RbQ6243eA4w8
         VoDL5wwJzmjJorf0Klxn6qTjDaQmlft/Is7odmU9uP4Z4sKhIIRVCfZK8a+rYNTNYxsE
         RYYkYYRXNj6bU8j3Vhm4ofmpSyCjS6S2R+sAdkc6F2vhZR6B49FeIluY/h2guGDxx2sc
         G2Bw==
X-Gm-Message-State: AOJu0Yy8rSFL5k1eF0Jz5nDLIgu5sR1v7jxO/czBbq0CQFfH0h+CM4XA
	/YgIKns4M5LniDFOBeBoOjLjrMy0eZYkw4AINPhL34AwvGQq5fCINdB8
X-Gm-Gg: ASbGncsUX9/7oVg+v+JAullyZsbAQ3mcOwZOSBkfdyNiSahaPZIjC5EqWctKnmM7a5y
	Kz5Vvw964uyG3VxNT5p2EhuCfbIl4pkFvbTGNGyK1PJqAU/6PAHefCcbWSQvKCjxC8FIifhJ2qo
	sC6NhpWs3rm703HNCyQo4Hge2WXfKlPaYfL+pQxpS+j46CfsqPi9PdG4hMZEMqGFAaD8GcH0A+h
	yzuI+oQuRF7e0dif/W+1uerq0j/arHGuFLPsJtg/kglEh+kulDfEZ6q/uQ/yoG04SnFIdNqHUZe
	e7nNzhiMWrs67IaFb1GzhrVfvRA7lAKKNiD+Fmls5IAqD/lqpvrK/lCxQmNEGXlcjq03dO7e927
	k2r7Tm1J6o4pur2ASRPbInPYiOSb81FntLAEaVRX3umzNzHPj5eLgzQPVnEoZMzR/HIhS9bxEia
	dNqa6FGGs=
X-Google-Smtp-Source: AGHT+IGKgSRTk9/lRhF8sPIVvGOObGAO1dpFrkaZkbDCNwg3c7b28nXEbhIGZsunzMb3axHrz25S3Q==
X-Received: by 2002:a05:651c:25dc:10b0:37a:5990:2ba8 with SMTP id 38308e7fff4ca-37e63907132mr24200111fa.23.1764878794242;
        Thu, 04 Dec 2025 12:06:34 -0800 (PST)
Received: from localhost ([194.190.17.114])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-37e705ccf4bsm7929401fa.34.2025.12.04.12.06.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 12:06:33 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: wqu@suse.com
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/3] btrfs: scrub: enhance freezing and signal handling
Date: Thu,  4 Dec 2025 23:06:26 +0300
Message-ID: <20251204200626.1273558-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1760834294.git.wqu@suse.com>
References: <cover.1760834294.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Qu Wenruo <wqu@suse.com>:
> It's a long known bug that when scrub/dev-replace is running, power
> management suspension will time out and fail.

Please, also fix btrfs trim.

I just tested hibernation with trim (with current mainline 559e608c4655), and I see that hibernation works
if /sys/power/freeze_filesystems is 0 (current default), but doesn't work if
/sys/power/freeze_filesystems is 1 (future default).

So, I think we need similar thing for trim (i. e. check for superblock
freeze and "signal_pending").

-- 
Askar Safin

