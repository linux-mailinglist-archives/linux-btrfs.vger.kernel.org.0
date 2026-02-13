Return-Path: <linux-btrfs+bounces-21671-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TOteLTWGj2mpRQEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21671-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Feb 2026 21:14:45 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE4413959D
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Feb 2026 21:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAEEE303A5D0
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Feb 2026 20:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5E827EFE3;
	Fri, 13 Feb 2026 20:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FAO+WVuH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kvg+aizJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8144E23E320
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Feb 2026 20:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771013676; cv=none; b=Lz051bfv4n3Q6WJn+sIb2GKlclajHDAfi81ywkZ0/fJ3+8PKtauKbiLf5Dzamym1cg0hmJz2qMWuXDUPyDhMQhRM9nXj2+26RkxR/CdgCRGrh8yxdGB4xjT0RKgNMrTGQKjjXbIuAgE+QQzv1UsbV5cRYVr5t8PSZPP/HasIgr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771013676; c=relaxed/simple;
	bh=2yWBR7+6uAiJGZh1+gaD/4Oxl4AB92Rb/uWzQN6SEVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GilGIRBCU9kdqyOhU6qscI6aZ1f+r8EtcX2qP6ENg+XT9Vw1RXcULKtKNzq5eIrh6nQdFw7mxsUhxXT6w2Yb5a2B+6ugmrx291VSdRi562gw/y+lrhsIwzxdN1JUuk2NPHT36A2ceRiIv7gtizCdExqmb0CbXX2q2+gQGQVzZPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FAO+WVuH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kvg+aizJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771013674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8+Sx9VmchKCkAbDF8WdRHlLXOLo0NV/E7WV9Z+vjBJg=;
	b=FAO+WVuHuDleg/WrSkBTZhtkxrAfZfd5DOMTuQym9zKJINrjIZSDJWZQakD3PGG16i4Lmc
	EiO2CeKlgPuspqdh8hdqGg1gMOIO/9gI5vCKzdy09UOPC2oLFf1Mej9Eb94GMdf9F/PtJ/
	zujQFGMfjJHacwl+6h6IGFghhgeNeus=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-0RARNAnkMoWbRDP8b2swAg-1; Fri, 13 Feb 2026 15:14:33 -0500
X-MC-Unique: 0RARNAnkMoWbRDP8b2swAg-1
X-Mimecast-MFC-AGG-ID: 0RARNAnkMoWbRDP8b2swAg_1771013672
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35845fcf0f5so112483a91.0
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Feb 2026 12:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771013672; x=1771618472; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8+Sx9VmchKCkAbDF8WdRHlLXOLo0NV/E7WV9Z+vjBJg=;
        b=kvg+aizJSqAo2/mt3//2RslgvnhDERbS3TadMdlm1OGLQdvaVBbahxSBuxNu1des+c
         ZvYlzFMz3Y7n8nO8HA1Q6DsFyIE+BVWHCSn2w0WjFREjR0x3XAsujrYrmTdKC6bONMLF
         /t0ABWpKCj40V9RI5pjH+8ALOfM8flJaPgYbCGFC0OBWWmZIxnJQDKmmzQPa6ICH1HId
         8ewYP6Ynmk9qT3gpFhhHirbwCPWv3pJFl8yQpr/CaCPFeg2O9Y/7nevsekkl+GwiPCxS
         PcF01TgMlGsX5qzlTfMuQWCu5GZPpBP/EqpTgPENY9MjVihx4oYGVQ2ImL7s1eE6+cuq
         qijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771013672; x=1771618472;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+Sx9VmchKCkAbDF8WdRHlLXOLo0NV/E7WV9Z+vjBJg=;
        b=C247vF8uX2Z9ds/jrInHpn+w2x1559sRUsOvM30VK1R8lQubMGgxXtwC5o+9xfAIrk
         gyb+uPzDny03BDfKZo9WTg+ng/pLujblL0CrceSgC01A/gfdeCpr56i8ZfVthGw/JjYa
         F40DMjtL8DchPxA9Qq7TkQvJ52MYGgugfLxY3aXIROabce6cpOnNuWWVQa5pPCg4jZWo
         BO43ppCYqiPOBrL3iCjeKU8UruHpdcCxNLN10skwLHFjOjwNWZV16EjA5DAf4Jdc5oQb
         tma6VwoGp+Dj37BSrPRlI4ePrTq8WaFmonrLXPWhjoMuyqs0Ze1nut+jwBlZfU5r5Ijk
         kvzg==
X-Forwarded-Encrypted: i=1; AJvYcCUAc8FPxKWATE5Mv/IP3/uj/wWNkTUF4bd/CvYtgeLWlhNZbmv4PbM+ZhkSGC4helQJirvj+u11tdgHPA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc6FIOSLbhT/4Wgiv6WdSGTXhuxy+ETqIklcB6eqQB5GOL/Hua
	d8SS0d3I0aCxD2EUl+0TBRAwmxG9zuRaXS0W9y/XHJHj2DeNKw0+RbDmEI33W+BfFnomnGpa7Ks
	y+eWat1rFm6F1JnHSer9gykYp95ImD7AqIK8h2lsgpuoFprEy1WQSFfTEo/0lPUJhWxmHNJQF
X-Gm-Gg: AZuq6aIv3LvaO1LYwghTM7zlM5nd+KySsllym5PneZ8ivelPLstv5lGJCxm8Ockol9h
	ujLRs57q3OQzE713+tvxML7yyHe03PszOS8AImxsfx/2IKZqiV3V7FDrkLsQpsTXPmIQTUJiFKa
	qQKx104+vijvwDbP6b8aSTnz2DL0AAe1eHZ0UZjOono7uCdusWBrwcYo8Tcf631M6EqT630VJpL
	RmA9mjcTijRt/LIW1YYiVUonoMMPSyqgnCZXu2Wz75ec6VdCEI9C6r+sWE/Hd6ha6fsg7vQLXcO
	lrPnB9EBXa86raB3kCEYbqbxmgvGJOHcP8m/vMkfOjAkuBg8dE7XIbtOhQQpeVPjEPhsoSQ1GFz
	PsRPtL9EjkbNvD/wXOefdmtK5ns8ysDJbX/YS5Zoi6KEsUWMyYtJKdVP5G5y5jQ==
X-Received: by 2002:a17:90b:53cf:b0:34c:2aac:21a7 with SMTP id 98e67ed59e1d1-357b50c4fb4mr1093925a91.7.1771013671761;
        Fri, 13 Feb 2026 12:14:31 -0800 (PST)
X-Received: by 2002:a17:90b:53cf:b0:34c:2aac:21a7 with SMTP id 98e67ed59e1d1-357b50c4fb4mr1093908a91.7.1771013671115;
        Fri, 13 Feb 2026 12:14:31 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-356629314fbsm12715216a91.0.2026.02.13.12.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 12:14:30 -0800 (PST)
Date: Sat, 14 Feb 2026 04:14:25 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v3] fstests: btrfs: add a regression test for incorrect
 inode incompressible flag
Message-ID: <20260213201425.d6dz4ovcx25zdzjp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20260209095735.130049-1-wqu@suse.com>
 <20260212184006.5pyxjnwxd5n5uad2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <74b8dbc6-34cc-470b-9812-b595af95c5b6@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74b8dbc6-34cc-470b-9812-b595af95c5b6@gmx.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21671-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zlang@redhat.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dell-per750-06-vm-08.rhts.eng.pek2.redhat.com:mid]
X-Rspamd-Queue-Id: 1AE4413959D
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 07:24:17AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2026/2/13 05:10, Zorro Lang 写道:
> [...]
> > > +
> > > +blocksize=$(_get_block_size $SCRATCH_MNT)
> > 
> > Do you mind I replace _get_block_size with _get_file_block_size when I merge it?
> 
> Sure, and I'll try to remember to use that newer helper in the future.
> 
> And if needed, I can replace the existing callsites with the newer helper in
> a dedicated patch.

Don't worry, since some cases might genuinely need the bare _get_block_size, so I
didn't do a blanket replacement, just keep an eye on it during code reviewing :)
Anyway, I'll review this patch at first.

Thanks,
Zorro

> 
> Thanks,
> Qu
> 
> > Even though btrfs currently doesn't require special handling to get the correct block
> > size, using this interface is more future-proof. It will help us to easily add specific
> > logic later if btrfs ever needs it. Others are good to me,
> > 
> > Reviewed-by: Zorro Lang <zlang@redhat.com>
> > 
> > > +
> > > +# Create a sparse file which is 2 * blocksize, then try a small write at
> > > +# file offset 0 which should not be inlined.
> > > +# Sync so that [0, 2K) range is written, then write a larger range which
> > > +# should be able to be compressed.
> > > +$XFS_IO_PROG -f -c "truncate $((2 * $blocksize))" -c "pwrite 0 2k" -c sync \
> > > +		-c "pwrite 1m 1m" $SCRATCH_MNT/foobar >> $seqres.full
> > > +ino=$(stat -c "%i" $SCRATCH_MNT/foobar)
> > > +_scratch_unmount
> > > +
> > > +# Dump the fstree into seqres.full for debug.
> > > +$BTRFS_UTIL_PROG inspect-internal dump-tree -t 5 $SCRATCH_DEV >> $seqres.full
> > > +
> > > +# Check the NOCOMPRESS flag of the inode.
> > > +$BTRFS_UTIL_PROG inspect-internal dump-tree -t 5 $SCRATCH_DEV |\
> > > +grep -A 4 -e "item .* key ($ino INODE_ITEM 0)" | grep -q NOCOMPRESS
> > > +[ $? -eq 0 ] && echo "inode $ino has NOCOMPRESS flag"
> > > +
> > > +# Check the file extent at fileoffset 1m.
> > > +$BTRFS_UTIL_PROG inspect-internal dump-tree -t 5 $SCRATCH_DEV |\
> > > +grep -A 4 -e "item .* key ($ino EXTENT_DATA 1048576)" | grep -q "compression 0"
> > > +[ $? -eq 0 ] && echo "inode $ino file offset 1M is not compressed"
> > > +
> > > +echo "Silence is golden"
> > > +# success, all done
> > > +_exit 0
> > > diff --git a/tests/btrfs/343.out b/tests/btrfs/343.out
> > > new file mode 100644
> > > index 00000000..2eb30e4f
> > > --- /dev/null
> > > +++ b/tests/btrfs/343.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 343
> > > +Silence is golden
> > > -- 
> > > 2.51.2
> > > 
> > > 
> > 
> > 
> 
> 


