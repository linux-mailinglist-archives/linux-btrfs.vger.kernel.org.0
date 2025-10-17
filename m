Return-Path: <linux-btrfs+bounces-17961-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EDABE8B79
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 15:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1967D1AA4B07
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 13:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E74C331A49;
	Fri, 17 Oct 2025 13:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moD+WMGr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3A3328B79
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Oct 2025 13:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760706246; cv=none; b=U2fIQkX4vo5CGyCRof2LEXfNq23XvG7jDENrClMnn5WQCCBBOn6dWmxeKD0UKRQUBom/f0vb0PhxQ0wJhhhkFcGLWUwkuU/htL20Xx+G0t18Mro9jHuLVVhfIFHZTnYxU1ItPbq1bogceYcIWoUf0WCKAd4BwvADeaJNRfbq4yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760706246; c=relaxed/simple;
	bh=EnbZpCV2oos3Jgvhi11hSD+v/55Wmtyl1F1TrRakyyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szsnrNutr1RjIvWhpu7UJ8CQlGIil56mTk53GYDU+YyC17XIWbza/jO2yTCjEgFiAlqFMb3KSiYbViDSjVXaEtfP60youDqYmjQM0qp/s9EYa1MqOdDcBbNdMJ3UbXlPafpYltpFECg4BmUQaK3gTdCEN+vferYdVHEXQf3Vk/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moD+WMGr; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e42fa08e4so17721695e9.3
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Oct 2025 06:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760706244; x=1761311044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFTC0WsD5qvNosCiq2VmFrrRyJq6s96dRtq2SvFE0SM=;
        b=moD+WMGr98s86nDujas9yVGz3UCrSzusiyKUT0WLpAvmNz7pRELkrSfoyOsd06kuAC
         yb1UHgf1G9+avqFX+PJyMQBoumxj4trk1hEr9/lTn6ETLKEv0EM+Amk2UVnG1pIliKyj
         uUKaqmOn2eJuwHO2KDkK9VUl1YN2xGSx/46oNDbWTLyk3E/JCgka0j2BJjMhfCL/jcEO
         pu2VqFOTnz8p0NBN0CX4nBEfw5iSiv2Q9Y+z/5kIFUa/MfioGzKbcI7P5hzCaSRmV/r6
         u5eGxWrqJVuvtbp32Mmj86e6KUsJIxchILWSbQxHAt1RqqDnVVlt53WAYp444SirtoRz
         pW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760706244; x=1761311044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wFTC0WsD5qvNosCiq2VmFrrRyJq6s96dRtq2SvFE0SM=;
        b=nJGa+BUZ5FgDG4X4wF6kWpPsbo8U8fGCIorEmkAYnKbEBznaUITT8H+PLxCNCZO4L+
         mxhcCvvkQJ+4W2BFBbUdrpxoiyaJOGK2XrEl1haRLIQ5CItso3pYVLAmXFW2bzVT1mDz
         gkZ0xByavcxtaoqgoyC8nIRCmr0xp7q0J8lKXXWAtqrVo1flmaL6XqxXhIq+XNmvfau1
         Rjawj0kWFiv0IfNM4PUFGnGbqeMUFynCbnmfgv79ngY+FWIPxxX6ln2jFmNl6tFnL52c
         2komwr8yLX9LLa9VGmfsf/xnAWc9uRIC1HHxoHb8nOmQ20tLTOGUlewo/NwjELh+n+pT
         Gd5A==
X-Gm-Message-State: AOJu0YzdOVNDim7sLB7xv4lJm8g2lQrHo2d6uPPZreQQXQu2jGX/bk2M
	lwGoFUo0ahxrjBEVMdyl7ev5ofy/4nt+N9W1iXeEniiyzrIVBO5nDO60
X-Gm-Gg: ASbGncsVhMz1GfzvWt1XepAjhu4K5d6YG3n7DbWPBW2XVkUmiiHjw6b35GTnbZcheIG
	1P/luLdW5zNu+0JyFcTx4c6Mgi5G3NOOypQEiNtx/nKoaSlw7Az9w5IIIC9T+E0P9jW7VEj1Xfd
	3xOS4/QrmYPtpvWZqVrlE+cVnWiZCM+j6FrCKBs8GgRbLFdk7O/EwnFXPAve19ZyVv7Bzr9wrHv
	lyZn0VNTo7yXCKnzogjbLZTaAC5vdL0lh9gJ+DkfyKbBCmQHFyNYFRxM25QNJwfM+nn7uiinJfv
	bv6bJC3AbpY/lYFUPLwv7ERJMvUA4t+VVFVWeiw3SkD7bVoyUvpjle8A2E+blJPL+DJYhd8ykBd
	lHkfS8v3ZtGW0otpo/0YrQyCyLcHfUbj9Y/ymM2bzMkiSQ2LfyHzVjvPplvpSUKqfJcZ2ciiKlM
	M0lv6sHCeMWsXo
X-Google-Smtp-Source: AGHT+IHxdVe8R4Ee/9NeMrGNCke8XwsGOQ/x9Bf3YavpVSyroujqC8TZYteAQvxyAAHNQAEj7b2TKw==
X-Received: by 2002:a05:600c:3e0a:b0:45d:d8d6:7fcc with SMTP id 5b1f17b1804b1-4711791c522mr25667535e9.27.1760706243321;
        Fri, 17 Oct 2025 06:04:03 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42701a5f83bsm8490768f8f.16.2025.10.17.06.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 06:04:02 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: safinaskar@gmail.com
Cc: linux-btrfs@vger.kernel.org,
	wqu@suse.com
Subject: Re: [PATCH v2 0/3] btrfs: scrub: enhance freezing and signal handling
Date: Fri, 17 Oct 2025 16:03:31 +0300
Message-ID: <20251017130331.4045-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017093947.1170945-1-safinaskar@gmail.com>
References: <20251017093947.1170945-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I did some more testing. I found that when systemd freezes processes using
cgroup freezer, then:
- fatal_signal_pending(current) returns false
- freezing(current) returns false
- signal_pending(current) returns true

So, systemd cgroup freezer indeed looks very similar to signal.

-- 
Askar Safin

