Return-Path: <linux-btrfs+bounces-20082-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FACACEFDD4
	for <lists+linux-btrfs@lfdr.de>; Sat, 03 Jan 2026 11:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E0FE302AB8A
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Jan 2026 10:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A602D062F;
	Sat,  3 Jan 2026 10:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ev3teZ46"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4449714A8E
	for <linux-btrfs@vger.kernel.org>; Sat,  3 Jan 2026 10:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767434576; cv=none; b=YJLS8YwTQU+f9pDSVnKAhtx1tbNt4f/RZJiDq23OCobAfSJyK/4a7XYvw74p1j7i+w2xck5lV83WpyXPVh4Xr7lz7I2FYVcDCj/CEwxG9xUnYF9x9M2/ANWgALdOwgnX7XRY/rlmL8Gu8q6u6qU0AJ3wQi/yZvaGjnOccntJki0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767434576; c=relaxed/simple;
	bh=qPbRsMMm0OalGU9qVWShgfi/u94dI5ZvzdhcCM49xKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LW9QlS0jL3ztDtY0eFMbCR8AxeEgLfkNBd9KYibQE7XuEH6mOHasoFEScCgbRRsgvP1CV5XWpFHmx9UZWka4zd5/uzsAM9SM/kzEx0f+ZgNkeExuP4hJmdUnMyek+10eJ/4SXzIDrbXnJBZJ1gYadTX6k3xEcnAtJx5FHvHpCNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ev3teZ46; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42fed090e5fso5800056f8f.1
        for <linux-btrfs@vger.kernel.org>; Sat, 03 Jan 2026 02:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767434573; x=1768039373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pVMxWDM6IlrZiTwjie+uTeOt+ekq2BmDE9odN218w14=;
        b=ev3teZ462bb7tVeSQt2aEMywcPu9S9Rc1lg6eSompCoIFR8h40GXHaP4CGJ+lnZRSc
         NQVI0mTeAZikJ4k/VmePxkiKKrFrK7kCxO9b7GRqLsuAr9e2O2XYFkEf+6IHklu7MfK5
         G9FsIRvb3X7jMTtWzAtgAj++Hc0Gho9ywgzadxFLV4u2dcB0iixv2qbsB9RKISHuB5cG
         KU0p7P8dik1cTNXFzVpRfCex1nv68EMQXGpOJx2h01p0XVVAUH3KaoDltWwwxa6CGAbM
         2HicTPdZaEiYcGtXTxQam9InaisXrzhd86SCGJMhaIKRiSpVmVdK7SOa2FiSJIMJcqYu
         yWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767434574; x=1768039374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pVMxWDM6IlrZiTwjie+uTeOt+ekq2BmDE9odN218w14=;
        b=wrycCYpVO8oOKFMcQxYb1EbQKzfnmzt9APUZQT6gmcj5L+2XKhqFFJLN378P2+m3YR
         2n0r4QHjQQ6fsGRuRg2InFnrO3DFacvRgi4NPFLtQ2/zzvnymi1G9Qajmgp+rQnqZnSx
         PFP9NL5GlTHZ5Mvt7X+IQoex2810+pSQrAcrFhbsYghQPtaOUZ03RaExOxir//QRIrFF
         EtMfL8RCFcTuowiV7npGeiLzbuo/74N/inE1S1HjdqncVCzxCUisD1zuWHOYSGkefzbX
         vhGAD18tC36rtoQyd/ig6WjlNSegHZjAg7ZNYHTwuqD0lKbhtiTQYybfFRyqzEnowujC
         lMqw==
X-Forwarded-Encrypted: i=1; AJvYcCVquj5Rwhiha4dUkGhX/h8O6/ULvzzSKmDTU4nLNmrzVRSuTVjzshWwS91ivjUdmPm9u8LdZNzQ38xPcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBVEltIED5zMQmi6COE1RscgmJb+lYlv9zYysV+GrjVV6jcQg2
	GWLjzUgDlUDtLq/k2bpqLvbGUAavde9H4AYxqjKr+X206V53JrmoVVsPLsubYMpaeso=
X-Gm-Gg: AY/fxX6C61IiHSvuC4aTh116VdBWucMCGNx1yPksMUMtcwkT/WW6RXQAfrEhSwsxMba
	gEDxTCYHvkUjeMH1l5nkxOi2ac78xh2Hntkcx1E9FRKJL+q/MeADWgT4KPZ4kNvnKWHGHohsU+r
	XHALr209VJmOYPiHIIdq2Bq+k3XknhmotVQtE0LJ50t+8Tm/LveTq2yuiQmXqsuFP50E/2AWjrX
	pEQ3pOM+q1yewJkh57N4FiQ6q1CrPxHKLYMqlwwy31xbEPEGjtz37mEFVQNsxsx49RK5tFwVudW
	k8rovV7wQuByr9tUUVRwmojwgRQi3ydIftPIDP0/wZFGr4s4vIor2VYOWEl5KJ0bkHRhmaX9hV/
	OpuYy3mtUKdYnTLLdaMPLhXw6yxKgs7+qAVhjucOzM7AV138W83TeUWLBCEaqjDQaAc6d7O26pq
	K+L79LnRXZhBi4thP8pypeGyoBpQ==
X-Google-Smtp-Source: AGHT+IFPkanq3RHUbcsbNCpasG6Z313jdsfGQVH9J5om8n/FtqWwK7E4sTbdu6zUmursa5ksRK1pIw==
X-Received: by 2002:a05:6000:3113:b0:42f:bb4a:9989 with SMTP id ffacd0b85a97d-4324e4d0fc1mr49661835f8f.28.1767434573075;
        Sat, 03 Jan 2026 02:02:53 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab2a94sm89174903f8f.43.2026.01.03.02.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 02:02:52 -0800 (PST)
Date: Sat, 3 Jan 2026 13:02:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kbuild@vger.kernel.org, linux-sparse@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-btrfs@vger.kernel.org,
	linux-hardening@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] overflow: Update is_non_negative() and is_negative()
 comment
Message-ID: <903ba91b-f052-4b1c-827d-6292965026c5@moroto.mountain>
References: <20251220-remove_wtype-limits-v3-0-24b170af700e@kernel.org>
 <20251220-remove_wtype-limits-v3-3-24b170af700e@kernel.org>
 <acdd84b2-e893-419c-8a46-da55d695dda2@kernel.org>
 <20260101-futuristic-petrel-of-ecstasy-23db5f@lindesnes>
 <CANiq72=jRT+6+2PBgshsK-TpxPiRK70H-+3D6sYaN-fdfC83qw@mail.gmail.com>
 <b549e430-5623-4c60-acb1-4b5e095ae870@kernel.org>
 <b6b35138-2c37-4b82-894e-59e897ec7d58@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6b35138-2c37-4b82-894e-59e897ec7d58@kernel.org>

Thanks Randy, for sending this to me.  I'm on the sparse list, but
I've been on vacation and haven't caught up with my email.  I can
easily silence this in Smatch.

regards,
dan carpenter

diff --git a/check_unsigned_lt_zero.c b/check_unsigned_lt_zero.c
index bfeb3261f91d..ac3e650704ce 100644
--- a/check_unsigned_lt_zero.c
+++ b/check_unsigned_lt_zero.c
@@ -105,7 +105,8 @@ static bool is_allowed_zero(struct expression *expr)
 	    strcmp(macro, "STRTO_H") == 0 ||
 	    strcmp(macro, "SUB_EXTEND_USTAT") == 0 ||
 	    strcmp(macro, "TEST_CASTABLE_TO_TYPE_VAR") == 0 ||
-	    strcmp(macro, "TEST_ONE_SHIFT") == 0)
+	    strcmp(macro, "TEST_ONE_SHIFT") == 0 ||
+	    strcmp(macro, "check_shl_overflow") == 0)
 		return true;
 	return false;
 }

