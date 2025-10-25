Return-Path: <linux-btrfs+bounces-18325-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 699BDC08B60
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Oct 2025 07:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 623033AC519
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Oct 2025 05:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2F52C0F6E;
	Sat, 25 Oct 2025 05:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pjvfa8SE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A68274FE8
	for <linux-btrfs@vger.kernel.org>; Sat, 25 Oct 2025 05:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761370009; cv=none; b=dsrCnS32wrjrXPn1zEjy4bKqaOC0oY4T9xw8mKpQ1WMFuy9NexJUasqbOCjvx8X1kubS2tGIiFPCbRJ4sovj3eHSeLhT9ccc8/QhHBvOvGRpkaP+uZje0K7dMfcgqPRv2sL+IbJHRkhBECVbJ5KlSxIW+DxGR2A9JQFmIjViTeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761370009; c=relaxed/simple;
	bh=/zQwfhMEJhTOa5/FV1euV1Dku1nFTDlTsbnBQjlqjDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khaVTYT4iyc5JProfXTnIpESp2jYPcfRMvrSglpATbG//Rezbu5DsqYth6y4UrINid4NJzDqrnN2o1p9LSwEQ4rJQQY1wvL+kxCqW42loMASyv668zLZRMPDr7tFLQ0+r9EE2UokQmdWcIh71EodlPIvDVdlG7syWso9JOPmZNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pjvfa8SE; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63c0c9a408aso4506443a12.3
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 22:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761370005; x=1761974805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mV8buuSZQP0rHOq5S4b8K+cOmbjRvDVQwA71gPDHBAE=;
        b=Pjvfa8SEZbxsM/zJR4PQ+NRDcthojbCwES9h0rerasc6DuX+QlbPq3ReB7mSmCwZzk
         G+RaYizITPByzjqWgNZCCdnHaJaARqKNOXhortmhpG6uojE+a0urH8nCO97GrZMm6zuO
         DdvtNpTMeHn5rWMFFQ7Ju4peQwzCN+8hsCog0MMBRSxOQ39Bv9ts+qL7kuXrPafx2mDp
         gsIImPcmgn6dRmfYObiegOz3nu/ZxylQPh2GOg8+npFQgjOqF89CdQqJEmYiltz2lDST
         DmfDH2jHtwgINimt1F9lgcm6fSLUUT2WEstjXw4+XuAN4I8VbQ5sjQS+kAyiVJ8caOWb
         zu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761370005; x=1761974805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mV8buuSZQP0rHOq5S4b8K+cOmbjRvDVQwA71gPDHBAE=;
        b=rle+fQLmstrFVMrVATFFOrgnsATdcUtAArb5vn1z3s4Z58/zOvQzcWYewjx6lrWMj5
         xn41DFNyMNuRATdKqV4uoryHcopYtDCzEq9DlckNIfP7uu7lNtN5fZchOvuW57T95LKP
         KfUs7neEm94UcbTLMiPCTfY1MPPXs1LVoEy0heGIkwI9X/DlbOMAu7NJFn10f2USZimt
         CUK+4Z4en9tO3gPKVr0mzLMzWNMZbx3KmA8+W9CtryrGA530OD5hq62in1navmh5k2SP
         R66CPT9fKksFXKooov/KgecAgmcXNIrcMS0ETimBlxzElsaj4VzgBpuENSvXdhVjIiBY
         mfoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqLLz2OsT3nL0qd8ap2oLYpjdZ3n0vTPcPvtrfT79ISa/rfjlXoGFiD3XKG9oAZ0Na/fskDXTgv0l2sA==@vger.kernel.org
X-Gm-Message-State: AOJu0YymToDV/ogAxi5v0Nuz6SjYmX7zl20u8ZKM/ff0gDQftR6hbqy5
	o4TP0ngfFTN4nh5zZPMO5Yl/TTw5ZsncMn7+8mQRFqXCkc3dEJ9WBvGz
X-Gm-Gg: ASbGnctcGwqfuik0of2ClVQTSJN30+oDd00QG9obiz+JNyplYsGNw9mVzpndJ0isHdK
	aBiCGkvrXiRO9khwNyuazP0MPYoHbYIlxlF0KxJdl9GMRKiLulLfmISs1o9XWCRoxhj4PylsS/P
	NyvixBkYiq1XLa59XUk4lPXxTrTxLsI7RRS2QaZgVbFB1ngHBlFWr6J7Qk4z7KEsZBxb3bYVoKu
	Sv2hXorGdg+a4tebGfsLkK7LXc23OWFR5kVdczthvXR5+Dqyk6yd0u4i1bqrmuOQ0Q8paNXxC80
	Rs1LfvWtPRpCiLl2DEaSDU0LC+mGgycZpi8vX8rN+F8LdF1UgCURRDK0cjgzCH+wkkpSY1O8Q3a
	iKFZADoo3/uy9vWx7oht2C8PF9w1kMHs73yW/o7zFGkyyVSLSlgFlJAYkB4SVOkj/8NPU4lh59Z
	2iGENm2HRdEew=
X-Google-Smtp-Source: AGHT+IHk4JGeekekahtUg2k/EhAC9kyrxVTGjCsIExfHrDtgIcN62P8FCtHZWZXypDamfyJkpyvf/Q==
X-Received: by 2002:a05:6402:40d5:b0:628:5b8c:64b7 with SMTP id 4fb4d7f45d1cf-63c1f64ec00mr33191598a12.6.1761370005212;
        Fri, 24 Oct 2025 22:26:45 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-63e7ef96105sm880960a12.19.2025.10.24.22.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 22:26:44 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: safinaskar@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	brauner@kernel.org,
	dm-devel@lists.linux.dev,
	ebiggers@kernel.org,
	gmazyland@gmail.com,
	kix@kix.es,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-lvm@lists.linux.dev,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	linux-raid@vger.kernel.org,
	lvm-devel@lists.linux.dev,
	mzxreary@0pointer.de,
	nphamcs@gmail.com,
	pavel@ucw.cz,
	rafael@kernel.org,
	ryncsn@gmail.com,
	torvalds@linux-foundation.org
Subject: Re: dm bug: hibernate to swap located on dm-integrity doesn't work (how to get data redundancy for swap?)
Date: Sat, 25 Oct 2025 08:26:37 +0300
Message-ID: <20251025052637.422902-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251024163142.376903-1-safinaskar@gmail.com>
References: <20251024163142.376903-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Askar Safin <safinaskar@gmail.com>:
> Here is output of this script on master:
> https://zerobin.net/?68ef6601ab203a11#7zBZ44AaVKmvRq161MJaOXIXY/5Hiv+hRUxWoqyZ7uE=
[...]
> Also, you will find backtrace in logs above. Disregard it. I think this
> is just some master bug, which is unrelated to our dm-integrity bug.

That WARNING in logs is unrelated bug, which happens always when I hibernate.
I reported it here: https://lore.kernel.org/regressions/20251025050812.421905-1-safinaskar@gmail.com/

-- 
Askar Safin

