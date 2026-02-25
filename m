Return-Path: <linux-btrfs+bounces-21902-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APMnEmNWnmnyUgQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21902-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 02:54:43 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A022C1902AB
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 02:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 074DE30BB764
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 01:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A25E252917;
	Wed, 25 Feb 2026 01:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkITWm59"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FE324503F
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 01:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771984478; cv=none; b=gngJuO1QEFtStXb/Buh2qvZBDlRwPH94neH5I7Vufk2rVOUGlHSLbz8ak+KTm0kFkfGGMkuhghH3Zi/MjnMucvg5kNwENHNefyMLvwy5WvfluV0rfNOKphTTOUu3bXFBeeOE6hhOLKV0x95ukMFTDWydek+9V3EQHvMhawd8Zck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771984478; c=relaxed/simple;
	bh=ihtOuFM/oDpxEJGfWP99kJT5Jq3CPwU50VjfHrHQ4eA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bVGlTH5vLv3GLUaNuaqx9XsT7+WjgO9eRM5kzhhmtGkyC6GCOjMtPd5dfpKPrT8kf7Azweddm9NZy0rB6r1vSudRX4zt7VXBTmvC6oM9KtEccvHI3oXjjW8TqDv4K3bu/5Wep3eVpfhixFVCzyiTmayS8a8+ptFN1ZQ4E330A8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkITWm59; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59e6b7b11ebso7010971e87.3
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 17:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771984475; x=1772589275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9fk4HjE9WzW3ynLGF+SH7gNYcU4+9bXvKwvDoOble0=;
        b=HkITWm59m7KKex7fU1JwVq+WblfsWiFd3UyLXY2zm3cpUA4a2ge2+GUvOoouiLOdN9
         0EdgO4NQ7Q/A1JMsw4Id/wBw2zSfalozqLLNrsCT0b60tK+YNZ0hLp3Hs/YZnm0fe+7y
         Zh7ngY6VGnlUrpbl+z+LySi5YHHdXkaCfaspWxZ0YcGmau+YAyzSfDrdTPrHLHT2Z9uc
         PkK6NTUg/wAg9zEzrufqLGztH6Vy5+jE1pHcXML2gQSvTC68Gj2UIycjchOsRuwGghC5
         fLxfWdC9YgppSm1IXCzRet6fG+HEqQbeSKJLzG4MJU3omuQJ/zo1gslvDmTk3XyyEh95
         VW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771984475; x=1772589275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y9fk4HjE9WzW3ynLGF+SH7gNYcU4+9bXvKwvDoOble0=;
        b=oV9eYtvjXiJDBjWUhV9at0I7vaPc/5A5AMwFrgYjewGITWrr8G8v4e8j7U4IX3DFO/
         Fllr2GYjMoLV3DbGEKlXEf6pVZeaI/05Tb9K9bwO6GlW5y+lg9JWd1opolAAIVNwGq8i
         PtVsCq9lOSmevE3r2ooyFuTITtXP0AC8tgT7OLftNQquS3UlO6LbYESesOB4yV5HWRdg
         oN27zK6GQrh7Y/FXK4gc790JxFRNvPat6ZHgA+q1oHKpfS3sq+9cCZaYT8Iq1jdOMybV
         Jk6NkrAqqIAqjnUB+mDecQejFnYAd7c5PLY24EsKCvjmiz4bG22OZteD5IyVF81PhKyT
         VC0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9wwT8ljuCTkHNtkaZtBJEHbctoljDSn4lIbC5ZRbRaxmDxAfVab2uzI6VksTUKbumCU6eyGPXkUQOoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsjekp0iyseeiR3bfmv62yY39FzBNnerPaXGxOp/G63j36st4V
	7cotd1ouC+L76BTQVRemKI9dpW+CYQDq6OPMY3cEazHAEFrgCnpQpVQV
X-Gm-Gg: ATEYQzxdcZS6/SA8JSThLLGvnJhYaZtoOVazAK+/ejj0JNAHOnQM7Z+sSlnDCaJloHK
	eFufjq+iMZ9L+6lp8BLFTBKfoggbX26aFM4HCmnYBtkxMI1/TcHOX/5vIDBucSHDiVv80tmfM0D
	CXp2EWa3O+j++0BAqErE760HaIWHmT8ovVEntfs+GC7B1i5Opj3rvReSdYU/Hd34xXhXXh4TE3f
	4zXDmzKOfzDmCAB8cKVSlWasDQ72l1FPZqYEKnW74BiJXp1jaRNq+j2p9/juloFELN3bzvtF61c
	CDEyDYYI6NkUMvxgMOjoauf34S8RYCjFO8tnnhgt8lRex032RShrYb+amkvEoCQKJqOvKrNKRRs
	kKAaTa64jfC8Jvz3Xt84spprr87IM5gEHOlnRHxkoQJeImxX5TijKyylkVv6bLkY3ThHl2xWeCN
	/212NKJPCC3hVC3SiKt5D/Mr2XJuaSid5fMvpndZw4vqCS
X-Received: by 2002:a05:6512:3e02:b0:59c:b819:1c13 with SMTP id 2adb3069b0e04-5a1026e0328mr162412e87.26.1771984474519;
        Tue, 24 Feb 2026 17:54:34 -0800 (PST)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a0eeb3ea71sm2569037e87.60.2026.02.24.17.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 17:54:33 -0800 (PST)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: chris.bainbridge@gmail.com,
	harry.yoo@oracle.com
Cc: vbabka@suse.cz,
	surenb@google.com,
	dsterba@suse.cz,
	hao.li@linux.dev,
	leitao@debian.org,
	Liam.Howlett@oracle.com,
	zhao1.liu@intel.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-btrfs@vger.kernel.org,
	regressions@lists.linux.dev,
	mikhail.v.gavrilov@gmail.com
Subject: Re: [REGRESSION] kswapd0: page allocation failure (bisected to "slab: add sheaves to most caches")
Date: Wed, 25 Feb 2026 06:53:59 +0500
Message-ID: <20260225015359.1495283-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aZw2LyOjxMc-c3dl@debian.local>
References: <aZw2LyOjxMc-c3dl@debian.local>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21902-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[suse.cz,google.com,linux.dev,debian.org,oracle.com,intel.com,vger.kernel.org,kvack.org,lists.linux.dev,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikhailvgavrilov@gmail.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A022C1902AB
X-Rspamd-Action: no action

I can confirm this issue on my system:

  Hardware: ASUS ROG STRIX B650E-I (AMD Ryzen), 64GB RAM
  Storage: btrfs with zram swap
  Kernel: 7.0.0-rc1 (commit 6de23f81a5e0+)

I was seeing the same kswapd0 page allocation failures periodically
under memory pressure with the identical call trace through
alloc_from_pcs -> __pcs_replace_empty_main -> refill_objects ->
allocate_slab.

Chris's btrfs __GFP_NOWARN patch suppresses the btrfs-originated
warnings, but after ~10 hours I hit the same sheaf refill failure
from a different caller -- amdgpu via kmalloc:

  chrome: page allocation failure: order:0,
  mode:0xc0cc0(GFP_KERNEL|__GFP_COMP|__GFP_NOMEMALLOC)

  allocate_slab
  refill_objects
  __pcs_replace_empty_main
  __kmalloc_cache_noprof
  drm_suballoc_new
  amdgpu_sa_bo_new

This confirms the fix needs to be on the slab side as Harry
suggested -- adding __GFP_NOWARN to sheaf refill when there's
a fallback path -- rather than patching individual callers.

Happy to test any slab-side fix.

Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

