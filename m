Return-Path: <linux-btrfs+bounces-20906-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAKIB6v4cWmvZwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20906-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 11:15:07 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E45FB65197
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 11:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2221F669620
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 10:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE4C3346B8;
	Thu, 22 Jan 2026 10:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWf8CMi7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbrG89ng"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A9634E776
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Jan 2026 10:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076309; cv=none; b=clTtCpiZ571wIUrBeN+bb3EEqLI5uSPzz6T7QZ+mKprblmXtBEmlMV3Nw5YaXCP9oVsHx8+sMj83xXKqbp5G7Q/C6awYF1edQiS79H+v6XECnZJGtXdLRiP4S0ohDAovRrVvVlel9JHPZpfCXKexCsYSjcq/qclQZs8YoWYHfsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076309; c=relaxed/simple;
	bh=MRan9B0EEcK8gXicfj+D1fSVd5Gt317ZxAZHXGkA7nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tchNCRBecYaEE0w4iteqsy2p4QJb9Y9qMrAgTmggbDbLQEhovrpHPFkIIw3VFZP200V5E2vBZnT/Y05BW30kvOWBIPiaLNRWkNisPc9ZR3ssQmTb396OO14QdFi6e9MWa4iuewKAAOwoIPLeBdkYhD0o4lrrv2CfNBxrAN9lNtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWf8CMi7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IbrG89ng; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769076307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YNqvczIVehNho1K6yzOe7LZ08YqMOyw0NvDlIw+P6AI=;
	b=XWf8CMi72NELo3h9CCYJe6airjNy8gH8lzXJiSPqO2Sh9VCBzFGjLHnMlNPSrhLXWFD72g
	bWbC11vmPKUscRUifPz8mF88PrwdRv5Dp5IvyfeOzjRc9cu2b4fdQkEJkQj3OOlQQWYoBx
	HrZrVhkuGWAoru6QNh5ddV/Fcw7pY0s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-gB5CYFHPPeGPnakVtiWOGA-1; Thu, 22 Jan 2026 05:05:05 -0500
X-MC-Unique: gB5CYFHPPeGPnakVtiWOGA-1
X-Mimecast-MFC-AGG-ID: gB5CYFHPPeGPnakVtiWOGA_1769076305
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4801bceb317so7117465e9.1
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jan 2026 02:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769076305; x=1769681105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YNqvczIVehNho1K6yzOe7LZ08YqMOyw0NvDlIw+P6AI=;
        b=IbrG89ng7l/l3NUjGV/5ES+iwxfQt8UmoECllKmxhWrmNndN6b1hILcaWqhtK6fUQw
         QIkpzqQLxVhqESfc4VLG2hq7bxrO96q2tRbXcyyqDwzvTkBkfcYZs0Bs16FkTkgVMK6F
         SAlnKivW4Hnwp8oWPnscdpZeQTXWZ6NmILqAv1Rpq+4IrPS01MPS/nSHgtxJyR/eaHr6
         IfdXxausYBxNoPEwU438EPs/Wwfyc59JTDU0Y4Hex7FUAGsrlv4ZZtqrsHNmZWW0+pYY
         zU0a/TppeL+YyKHB/+qw06ixDBCHoYSOVdZCaeg0lXGOgaOijRvUUVKTjrqXfNMxYGah
         e6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769076305; x=1769681105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YNqvczIVehNho1K6yzOe7LZ08YqMOyw0NvDlIw+P6AI=;
        b=sjFskH/KNDHU7RtLLCl+dbOwXtPNmnPJkLQfW2oAD6Utvwjg22vZrs2KhJA0jKFKA7
         DKfye/xcnr0llF2gkOSgVIAu+DzkhklKE/fupIaI6rxIIvPf8kL8Y4wYB2CVPyOg7CId
         oMsoAi8hG6DEoSu30QA5a2IMeMhLhvcxPfpMsiFcQxuSm7Nrqt0fTB4LGk6xjq5pIMpG
         9hxOQWQad9/bbv270X/V6d8plJ3/QS8b4tJFkT39qpnImthk3KHimmi5Ozr6yDirQtzZ
         ZjFLeom26rOjy+Q3qGmMfKFW3RsPALJzm+1FiTNCmWC6xFTMusc5rGPxgLE1EnACNLlT
         f2XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpaQPvt3XdQBI1XU/P9pqHxYF+bOWjmo+B9QOEkhDFZTysaCbRJWWdZz9W/YvWI6dgu4s1PZqt+GgMzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWW5nsU5IL/2a4sHgS/jcMwdOFj89KmMIS2ZGdgr2/OxkP+dWn
	ibtaTFC38K8pGcHuai4A0ARGrr7Ca/rd99vSSGsdsLQMeoScYoAjOpFagCC8qP43ixXe77jyVaa
	KZ3O+qzhLW2BaaniBfiY6ckHBfJGgvbcbfucK5PiEFMtXvBFWx+49W41XihQsvgY=
X-Gm-Gg: AZuq6aI6wPpy87V68PGYuTJo6s4L+Z63eFg2HfY7YNpNu5GW528zBZam6ogTigqMw1j
	oshv79gGs0+wJxKZryRVti0oiZVGqF8kF0Xf8hjQoUZQA2BtXhexDK6bAC50VwgmqO2EfolZO6L
	si9pw8RTcghzm/brtlNXXKkZ3YxGVHFVzLP+qCcvkSfiE+HwlplCsJ+hiparOip8Owrzp4eNLMj
	DNdUrQQ554X4kvkt85u5m0i90JUAVVRbs9OCvlN1+JtDiyKP2b2Xx67nQZjeFlNmaNvVE35T24a
	f/qTGjB1+8+yEiT0coHa3qjDOGwYW3ARjQAOPh+m85m0/N168PAalgLBQ38Qq3mjTDvMYss6UVg
	=
X-Received: by 2002:a05:600c:1388:b0:477:a36f:1a57 with SMTP id 5b1f17b1804b1-480409ca767mr113935905e9.3.1769076304279;
        Thu, 22 Jan 2026 02:05:04 -0800 (PST)
X-Received: by 2002:a05:600c:1388:b0:477:a36f:1a57 with SMTP id 5b1f17b1804b1-480409ca767mr113935225e9.3.1769076303635;
        Thu, 22 Jan 2026 02:05:03 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804704087asm53174235e9.6.2026.01.22.02.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 02:05:03 -0800 (PST)
Date: Thu, 22 Jan 2026 11:04:32 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Eric Biggers <ebiggers@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>, 
	Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, fsverity@lists.linux.dev
Subject: Re: [PATCH 03/11] fsverity: pass struct file to
 ->write_merkle_tree_block
Message-ID: <2i3y4kybtm2lusa7eoutefawgrkhoqhuyquilu3qvkziyhpbvf@jeyk27glmeyg>
References: <20260122082214.452153-1-hch@lst.de>
 <20260122082214.452153-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122082214.452153-4-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20906-lists,linux-btrfs=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@redhat.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: E45FB65197
X-Rspamd-Action: no action

On 2026-01-22 09:21:59, Christoph Hellwig wrote:
> This will make an iomap implementation of the method easier.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

looks good to me
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey


