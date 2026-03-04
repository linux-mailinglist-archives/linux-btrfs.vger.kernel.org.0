Return-Path: <linux-btrfs+bounces-22229-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6H2SBytQqGmvsgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22229-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 16:30:51 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B48202B66
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 16:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7907630A12D9
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2026 15:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083B33264ED;
	Wed,  4 Mar 2026 15:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GR22i0iG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tIUexOSA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6B93264E2
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Mar 2026 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772637492; cv=none; b=rlLYbhidd4JoLe5I8yUeY+6Y9qMEFD6FQYbPpHFYC7bSBzghCiUtnYkBAFyeIH9TGDJHZIj7+BXMAGLKNT6uwm657rhiuN0x48n64mrk0R314EjpM+lg52XiKsCFcQTyIgkfExFi1m+WM4ukVfYNzGfRrtB8+FYHkr1ScemLf5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772637492; c=relaxed/simple;
	bh=R2Y58A8d6w17HztjmtgRVKKs/bnaU3iN5P6Rgwuu4xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LU9/LQbtTps+VNnU+nnvPZdme4F4T7mofo/N5fP1Uk6qxvjAdIaXFOHOyi/pUcEkDzS/Orzs4Xz1rTucDuVBjJAkUphRSRvus3pJAeoi5TOBs8K6OZEUelkadZrYxtLyIADEYGBkHMclWqB4+YaN6lnh192kTGvDRigjjuS99Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GR22i0iG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tIUexOSA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772637490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=00JJFGOrDTHitcGq6XabMTYCTpc+QyAEd0XE4dW5bTU=;
	b=GR22i0iGcCiNyDDdBS3TV/B4i0QuP40HtgAQ3V1RKye/+HVLzH8Nq9ezU816l0IuK7ANw6
	JmM+8YSfpdvJ9vHrmARjf183IZUappuodzLCO7xuQAu/1h+IHKL6I4HEp880sgfIL5UGC8
	JNtc1DCcyuxI/UtdEA/f+eKNr5PmXLI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-RsLJa80XPOSgAsK1wf_qFA-1; Wed, 04 Mar 2026 10:18:08 -0500
X-MC-Unique: RsLJa80XPOSgAsK1wf_qFA-1
X-Mimecast-MFC-AGG-ID: RsLJa80XPOSgAsK1wf_qFA_1772637487
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c629a3276e9so26200953a12.2
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Mar 2026 07:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772637486; x=1773242286; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=00JJFGOrDTHitcGq6XabMTYCTpc+QyAEd0XE4dW5bTU=;
        b=tIUexOSAX22IMkySE6z0KSaGIJ73f/doREc3++sJRrwqbd8NgrkCXqlJDikxfF55fk
         lM5DXnEILKtDGM8iQwuMbC9LA9uHVTShIo1r1eeisv+/4dKEMVac0yXfCSl3AA6SakDQ
         524GibHP42v0w+Wgmvp/2DOuEsVD1yo/Te7Whmq37uyBH4HxhOK7x0ss4LomfVg71VbA
         7iFxgoULEZwhIhB6/mAgQ36r+fC0/gbp9Tmc3ZUMQEtvxFPyryR/HntSXeNuO08e7wGC
         xtI3IB8wTy3qmRZX0TZBpE1JyrU9csB28+8xiQGyDnGBSOXenyLzdO99hTtp0M2vMupO
         jz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772637486; x=1773242286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00JJFGOrDTHitcGq6XabMTYCTpc+QyAEd0XE4dW5bTU=;
        b=mbEvZ4YDpPJ8Jf4tfl4qSzXQh/kBb6i7PldZ8DcFjHaMcRid+ijfHnf9XI322wI8br
         rxkqAE/tecoonKZbpELmCD8aUjpOMfj0ezR6tVNSdv2D2UQR5AticUKUbIxzVgsRdBUl
         sspdB2BSRR+ROqda9nPVL233/wgqeVk0m/Yy2bjnYfI6lK3PStsYYlatZSZGCMeyagFn
         GPV/ZRZ5d6la+PP8MdvCVdMd5ado/ECpwjGA8Rf8o2K9zuiPT8TLl8o67gQWGwau5d0m
         vj1pyGn9w0yitT2vKHwB+PW/H3jCVq+KsG1QCmXn3azejcBEUdkF5eifqv/7v2jHp/TK
         k2Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWIRCA1bt9iDOp9/qU/DqwQCJ+Sfg9BkYYarw17eCYzuhBFKbaO08FZAOWY69GlBAcIdyivaWeH9AcRLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjHuiPb0zQ9rCtpq8OcyebYvM2SmG3M3Ea+NBps0Gte7DAILeY
	KlY1xVZUYI48InVhjzK5GjCRxi1Nfwvhmj56BHPpPDjR+vMFbU9vWqCqA9sl3i4NtJfcgTEJBoS
	G5JBsxomhQZKZKrzWn3qnvV14oDT1C752hJ75FfXGb32kgf2qI+FA+GAfcJqPxw+3DrPe5XDE
X-Gm-Gg: ATEYQzxta18Z/b6BN3wOAlXA7xZ7wC6kJZ3lf0SYABRg+IxCm+vG40sr8wwJgIF9+qv
	SDWTuaboC8wTF7OH9HqWBeaMpql6b+/BjG0h2Zo6sUyJFyyLkBR2fbtmdcb1BPl1GtIVfztj0jC
	G7T6H7RI1deAc9FctntzWT/efVj4piq05eYFPdbXc4KMnQZlHv4LvtHWNUUXcrdYisSRu4LbHAl
	nYC0tLPCB9LoWLjKsoQ58aSnIfhYcYHvGK488/RNt4GX0hsVkcXXpXn8zZzOe0t74M2JLidXSf2
	zVPx2RLuLpQaNXrpCCJo/fzGUDDrIlvmKIbPQnIIxl5qDjwzyFdTzEpnGyzo6gpccT9gdkgFj/X
	9sq45qUHXmZhAO9FBTud3VC/hqUlncRR7K8aGOkq5uZjFzyZbAm6uaubXLBkAsA==
X-Received: by 2002:a05:6a00:a206:b0:827:343a:a1ef with SMTP id d2e1a72fcca58-82972ca4112mr2176540b3a.52.1772637486543;
        Wed, 04 Mar 2026 07:18:06 -0800 (PST)
X-Received: by 2002:a05:6a00:a206:b0:827:343a:a1ef with SMTP id d2e1a72fcca58-82972ca4112mr2176500b3a.52.1772637485820;
        Wed, 04 Mar 2026 07:18:05 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739ff325esm23132141b3a.37.2026.03.04.07.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 07:18:05 -0800 (PST)
Date: Wed, 4 Mar 2026 23:18:00 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: fdmanana@kernel.org, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] btrfs: test a directory fsync scenaro after replacing
 a subdir with a file
Message-ID: <20260304151800.6qkmxjsufen7sbq4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <8e3c1626b6e49678976db67a861cb5dcfdb532c0.1772558357.git.fdmanana@suse.com>
 <7997e07a4f530bc52edd1b93e662907c4cd07377.1772561118.git.fdmanana@suse.com>
 <aaguMUK6TgYfwtZk@infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaguMUK6TgYfwtZk@infradead.org>
X-Rspamd-Queue-Id: C0B48202B66
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22229-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zlang@redhat.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 05:05:53AM -0800, Christoph Hellwig wrote:
> The subject is wrong, this is actually a generic test.

Yeah, thanks Christoph, I'll change it to "generic" when I merge it.

> 
> 


