Return-Path: <linux-btrfs+bounces-18006-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DCEBEDDE3
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Oct 2025 04:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A0823E3570
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Oct 2025 02:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3141E1EF0B0;
	Sun, 19 Oct 2025 02:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKK9EUiL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC6E635
	for <linux-btrfs@vger.kernel.org>; Sun, 19 Oct 2025 02:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760841804; cv=none; b=NlQWZ+lmpRkHX7ODkPAvtR7rEL59hIx0LVh9w8d9zCJbWhf177KrlKrj4WkA0W7q8dbEDehcjKH+msgazSMDd+8rw6BwQZOOpGaq+1bSSNEclN/o9TT25Gw6+Rc6MCDlMrtEfvqLHTK/Z219NWdrHoDYklJq936epdBfUNzPxeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760841804; c=relaxed/simple;
	bh=4VgyEH3oZbI0ffOUbrDhAeqd8xAgB/GPzwq8OMYK2EA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cd+quAkWdgqHbZuW79rD+4oFGgfG1f7fvStZxEd3+3W6IdUPPLT6v86Qvju7luIXpaHxRalzFRbjKhJECJ4pAOx77cwvtwo2SUmyqR/Ij/mnMXxO+sClKW4nZjZGX6xDYDiam6RDrxX2OfbD75zPCH/mPxqAshuRZC81jePmkaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKK9EUiL; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4711810948aso19315095e9.2
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Oct 2025 19:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760841801; x=1761446601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqpOpkMst37L/nR1mGxPz8hixv97H5K7fP4DSsCE94A=;
        b=UKK9EUiLTU79u3BdquraYdlvPA3zpICasw7GgZjsmEWBGWdMn2Wj/jwuWL4g95rXyR
         qWefCR7K3PRj3IijhXRKxKSK+zr8ULASOSEe9w2QzTUhkPbFebPZxf15z/xLuncenA2Y
         nybP+j/lftqN7OKU29KxZxbYGek6UY87Uc3jIJ+ZhjwmsLaKuMiW/pPmkvp4QrERIbS0
         2TU0sxcOBqWGIrGHkH5xn4tPK0Xf7bCpM65rIO/xHsTM5zHAhS2xSjothQCovWG9QvAH
         +3K0uKcWYt6JKebvi4uru+Xjc/yZT6Gjedk9DK6iVUXNdW8B6OMKdWl5aF6i/A5lH1PZ
         ayIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760841801; x=1761446601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqpOpkMst37L/nR1mGxPz8hixv97H5K7fP4DSsCE94A=;
        b=oONnVnDmPvV/iY9BZkzVX5Zm1/eDxS7fDvNXj10VOiOyk9E4IGXMyQdrj/LaoTH1t4
         AGZp1H9ekTS/07IVqVoJ+bgl9NYSBj1NKZVq1DqmW+iHp0GHpZenExZngtK9H4vb0lNy
         DsFvBOoRqTK/TzC0jTuOE5oVKWQ4NrZxcNr25NwEuPSsPaJkKEntKulahyQLjyo1k525
         /S8LBtSwrQLyzozyG1ooS36Zsh6ZPtx98G+CeQ+hSbra6I+i7E9m02urvPBWL6o2O0IH
         A4tr0iW1qWjMoktnG29TuOtYrvIYdBmEER0MpK8qasMN7ML95pfFgULlj8UmiNtDf4Ni
         X9nA==
X-Gm-Message-State: AOJu0Yzkj7DaqXYKu0p3TJeb7GungaOryVqdcGNoDAZ29JQb1sAnIkWL
	QrvNeqOLhVMBc9YinIVk+yhm+lQ25B0TkMXBFmD0p3zELZbHel8qsEbm
X-Gm-Gg: ASbGnctGh7RHcH3LPqQ4yp2LK47FuitjbWY05AYClKGjniF4SljqUyS/z2eyrEhq592
	jDRPUjbaWFnf3G4R/r2YbjRQkG9hwKOqXuNnKeQdcEQRH8AA0D9xKnvhe9x4EgJrv5s6GDOc5a0
	q/CSM5zcNAaAFKk9mmqdSrmvoAnrC8/o2PWd2cvJf/kLKxPHmzToc18gBzrqTiqYoPyTGDMTNFs
	cgQCqWIOJVzgaUF7HJ7HRsYk1ZQtfB1QxcwhLxmmj+hRqa0KdnlBbhWHxJJ4C895tg5A96HtTzW
	rht2X2AE+UEEP0TOweOC0kDiuyOGoFv/EmkKG3X6nYZJ3TKDtjJozYeTPE027MUFQiPDGn3Vndm
	q9kHEBBxPggqpH8VCJTTfwNR3tzanh954UItqvYKu
X-Google-Smtp-Source: AGHT+IHRHmC0YjVVkH7pTT9CRovEOIEEw0L6RbNb28BBZy6dLczB1jxVWpXSGkYcVmfhoFW5snqnXA==
X-Received: by 2002:a05:600c:1d9b:b0:45d:d353:a491 with SMTP id 5b1f17b1804b1-47117875e7amr53369845e9.1.1760841799287;
        Sat, 18 Oct 2025 19:43:19 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427f00ce08asm7708336f8f.44.2025.10.18.19.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Oct 2025 19:43:18 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: wqu@suse.com
Cc: linux-btrfs@vger.kernel.org,
	safinaskar@gmail.com
Subject: Re: [PATCH v3 0/3] btrfs: scrub: enhance freezing and signal handling
Date: Sun, 19 Oct 2025 05:43:13 +0300
Message-ID: <20251019024313.164846-1-safinaskar@gmail.com>
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

I like this version. Especially EINTR/ECANCELLED distinction. Thank you!

-- 
Askar Safin

