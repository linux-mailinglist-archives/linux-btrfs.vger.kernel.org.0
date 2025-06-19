Return-Path: <linux-btrfs+bounces-14796-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E43BAE0C7A
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jun 2025 20:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38685A062F
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jun 2025 18:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C7A2EAB98;
	Thu, 19 Jun 2025 18:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="XT8TQKeN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6442EA147;
	Thu, 19 Jun 2025 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750356191; cv=none; b=YlQFhuxzTaoqkCvuKG7OyMGa5rMZnT+RaCGQ5uMFO/z/+JqP/RcsE6x0qV59dHF+XK6dCFeYjeusNLKM6YAZm0idrd/P7SR5sn9bmiRsldqEgvtP/0jtTD71BcgJrAyJp3Lb2HeDYZAczWbh1MjjuPNE7gVOOqskNQK4wSsCcus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750356191; c=relaxed/simple;
	bh=QgRnJQjjaG0lHb6r46rNtsVFVW8jHSf63KpGKk/LcXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGoP4BGVHBKkYwnHfghRhsRpOjCAojpdxC66MaBzOHekwt/4E4ZPI+d8kgQpCD1t2sQPjfH57MzFuT5Wnn1L3mpkHtLOjugS8gLVotsilSCMustG9kWd4UWLAUn2RM6eDmrdNvisakGyPLOp4TuNwy3h91I4AfLPz/E4pMDnOk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=XT8TQKeN; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bNT3r6kfLz9sjn;
	Thu, 19 Jun 2025 20:03:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1750356185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dJz0m9ZKgaOE0mfoFA58FeAszfuLuWVAcvP93Vnfl4M=;
	b=XT8TQKeNCzK/UuQ49mnrezkFNiYkP91hch1yUiQuXyEeaRXsH0yjEknwXA9eWVBtwYFrtF
	NmvV2LS1O8qk0vr7WYZuRe7ttR28pUr0ih9OOUNhBf9IVYDF9YjDUC0j3pbyBs/B0CnU51
	Jl/h7qx0hv18Tjkh+fImKDacx6qnmgxigSEy4l3qE7MLCkWMNMwgC6+CRYHSRrX4p4Ijn7
	Sw+JE3YObDCMyPSn1GFEc9UVnNkVCIiPwqzdY9U9YL0XLGg1kuEyqkUHAlL1xbF+tjbUoH
	fvmsrNiPhqWg+Jt1B+k3qXFb4H6r75/OOpjm3CxzmL0tnAFPVTUr9cTuCGmIxQ==
Date: Thu, 19 Jun 2025 23:32:58 +0530
From: Brahmajit Das <listout@listout.xyz>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	kees@kernel.org
Subject: Re: [PATCH] btrfs: replace deprecated strcpy with strscpy
Message-ID: <gsykswmdo5yusthxun4y5duhim6etxirrfezq6o6w4tlalcvxp@3wqjjzurypzc>
References: <20250619140623.3139-1-listout@listout.xyz>
 <c278bbd3-c024-41ea-8640-d7bf7e8cff47@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c278bbd3-c024-41ea-8640-d7bf7e8cff47@harmstone.com>
X-Rspamd-Queue-Id: 4bNT3r6kfLz9sjn

On 19.06.2025 18:03, Mark Harmstone wrote:
> On 19/06/2025 3.06 pm, Brahmajit Das wrote:
> > strcpy is deprecated due to lack of bounds checking. This patch replaces
> > strcpy with strscpy, the recommended alternative for null terminated
> > strings, to follow best practices.
> 
> I think calling strcpy "deprecated" is a bit tendentious. IMHO the way to proceed
> is to use KASAN, which catches the misuse of strcpy as well as other bugs.
> 
Understood, thanks for point it out.
> > ...snip...
> 
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -215,7 +215,7 @@ void btrfs_describe_block_groups(u64 bg_flags, char *buf, u32 size_buf)
> >   	u32 size_bp = size_buf;
> >   	if (!flags) {
> > -		strcpy(bp, "NONE");
> > +		memcpy(bp, "NONE", 4);
> >   		return;
> >   	}
> 
> These aren't equivalent. strcpy copies the source plus its trailing null - the
> equivalent would be memcpy(bp, "NONE", 4). So 4 here should really be 5 - but
> you shouldn't be hardcoding magic numbers anyway.
> 
> On top of that memcpy is just as "unsafe" as strcpy, so there's no benefit to
> this particular change. gcc -O2 compiles it the same way anyway:
> https://godbolt.org/z/8fEaKTTzo
> 
> Mark
> 

I was planning to use strscpy, but it doesn't work with char pointers,
hence went with memcpy. If you or anyone has a better approach for this,
I'm more than happy to send that as a v3.
-- 
Regards,
listout

