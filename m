Return-Path: <linux-btrfs+bounces-12943-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4A5A83A77
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Apr 2025 09:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF98C4A3E3D
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Apr 2025 07:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24ADD2036E6;
	Thu, 10 Apr 2025 07:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uhex8PPp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C055C2046BF
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Apr 2025 07:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744269182; cv=none; b=Glpo1whKRjJTC4FFzKT39TObzbNuCHXjlw2h45vZdfV2/E7tbpQqjBuhxtmxIr940Jhqd/OKnTw1VauJYe9SpXclRS9q3uPyS5fXGLXIQ36tOv2h8wucmwFV8jNfnONOI7SCJzyIPIXprZBY5uIF/ZMRgDmz9LQaqEhGi1GfhpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744269182; c=relaxed/simple;
	bh=dgp/2rKKxxNSIsXyMQ1kK4w/FMv4WGX637EAMMmYllU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q42EmnbBUkmWNNrsWrykrGsFpTbgb/QPidXBzHKCTgqKC03MnzwTNuSDAyRmjLW4STOqKiOeFx3fvVOL8EC9wOkzij3yvSs/tMgu2P1Ie1C9xhgYh4vWhOvGOHhtQ3y4bPL8DL7QUGu1yldH7qdBBG1hNkjqwFE5OmJFR4uRcFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uhex8PPp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744269179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0Ufsk8sEM9LLx8Qh6h7FxkCqp6rSVr/lNG7nBCQ78s=;
	b=Uhex8PPp7MH8Q8pDDuXzTC2/I4KG1nz6GqcpM0ZSdKUazxB88K4V4XJEEMju0NVE3fDKJf
	FgYQACMfvP8gbX1zorbrzY5vlw/yxJhEEMestn5rW5ENnmW4hXMDqAI0iGRSVBcLRH8BJk
	/i0zP8QCthXjn0ydEkMsB/O9tWgjgS4=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-EpXX6_LAMU6Sh2X40123IQ-1; Thu, 10 Apr 2025 03:12:58 -0400
X-MC-Unique: EpXX6_LAMU6Sh2X40123IQ-1
X-Mimecast-MFC-AGG-ID: EpXX6_LAMU6Sh2X40123IQ_1744269177
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b00ce246e38so686283a12.2
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Apr 2025 00:12:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744269177; x=1744873977;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r0Ufsk8sEM9LLx8Qh6h7FxkCqp6rSVr/lNG7nBCQ78s=;
        b=gQ4x5OE0WqPiE1tXWYRcvgRXYJEjAJnej5M2811ugAmLbHeCLeoicoDiEqR6mqQ29H
         dl7TEtuEfoLBdHKgJ+Syb52FJvH9KkhuCW1iJH5u18/hxMiGG/bLGdrGaSkU9NUisXzM
         jx0/ERXfCY+blDeux9m9iBanRZ2y6IuIVjLgS9oFVb6j5H4luUMP2gYedBT28oC8uvlO
         AVk+A0yIxRiXnjuLvwLrfDjOXsztMCpm7x40Wm/hOEbZfucz5MEpD5WJp4P4IkxCTus5
         Pd/AwTBLjz+p2VaSflpC0fKunQVbK+m7SfFnn4znEmCWkBdSZ4sNyosdY98+k+viQZlS
         hFNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSq1G/RNBYVPo3ercDctDbjrIeXxrBD9N1mcDelKQehnliIkTxcMTt7LUdHRrjrCxT6issFAWUwBGYVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBi0PxCtY4aKQLLkQBcqrvsFl3Z/9SFfVMx89PWlvPzFLRZq26
	zsalRcM0SG0id2WNiGGBb+ds8mmJtcY60qtdOGKsXm6q3JwwZlBHtQgB2MSLJ8WiDjRN3RHuNmN
	nGHQkuFl/S4uw872CuY9K1V3HMh2JQbBpT66X0OXOOC+2m6y8c7hGi8YBRuUB
X-Gm-Gg: ASbGncvY3XTAGaTJWCryOmBcGm6K18omu7DQtjOPNWKyhP8yetsPVc9M4LbZmCgqcOo
	ZN8O/cJkNSdVCM1Q/TUj4Ee9av1WQPxdZ3+8Viv/Ziymp1xOxHQT46BOflV7vuS8qRIeLw1j4/Z
	BofsNL1M3vSs8OveitFnT8UCTNNOVYvMqYTQH/0xOX9Mw+BOORNlEE8CJRwRPejn9KZzqJvbP9x
	r+rNpviqxq4U96S+ME3DUMl95EqAEMqvoiz8CTWEijS2tpVI/ckXRaOVkvIgQ6ztU6y6aq9fH02
	8X+cDGNTbM44eaUIYBK6+CQneT+aAt7ylVLNiEMJBhPV0h54Hb6U
X-Received: by 2002:a05:6a21:6d81:b0:1fe:61a4:71d8 with SMTP id adf61e73a8af0-201694d1378mr3510418637.22.1744269177184;
        Thu, 10 Apr 2025 00:12:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOEW7oyWmu75wGcNwOzudVcP9hJ/wierR/YQ/cxHk2ZTupQ2jVWFm+f7300goqsTX4Fbaa/w==
X-Received: by 2002:a05:6a21:6d81:b0:1fe:61a4:71d8 with SMTP id adf61e73a8af0-201694d1378mr3510392637.22.1744269176884;
        Thu, 10 Apr 2025 00:12:56 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a11d3b43sm2335971a12.39.2025.04.10.00.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 00:12:56 -0700 (PDT)
Date: Thu, 10 Apr 2025 15:12:53 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH v6 2/6] fstests: check: fix unset seqres in run_section()
Message-ID: <20250410071253.ykwnm7vvsqw7myqb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1744183008.git.anand.jain@oracle.com>
 <12a741fc7606f1b1e13524b9ee745456feade656.1744183008.git.anand.jain@oracle.com>
 <20250409095725.xumxhw54igwapuue@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <9dc6a550-5e4a-4ff1-8961-9d6dd758a83f@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9dc6a550-5e4a-4ff1-8961-9d6dd758a83f@oracle.com>

On Thu, Apr 10, 2025 at 05:31:39AM +0800, Anand Jain wrote:
> 
> 
> On 9/4/25 17:57, Zorro Lang wrote:
> > On Wed, Apr 09, 2025 at 03:43:14PM +0800, Anand Jain wrote:
> > > Ensure seqres is set early in run_section().
> > > 
> > > Signed-off-by: Anand Jain <anand.jain@oracle.com>
> > > ---
> > >   check | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/check b/check
> > > index 32890470a020..16f695e9d75c 100755
> > > --- a/check
> > > +++ b/check
> > > @@ -804,6 +804,7 @@ function run_section()
> > >   	seq="check.$$"
> > >   	check="$RESULT_BASE/check"
> > > +	seqres="$check"
> > 
> > The "seqres" even might be used earlier than that. If your rootfs is readonly,
> > you'll see that.
> > 
> 
> Zorro,
> 
> Thanks a lot for the review and RVB!
> 
> I’ll take care of this patch 2/6 in a separate patchset.
> Meanwhile, could you help merge the rest of the sysfs patches,
> except for patch 2/6? I don't want the seqres issue to block
> the rest of the sysfs patches.

OK, let's have the test coverage at first. You can merge this patchset without
the 2/6 in your branch, (or use the way you did in
https://lore.kernel.org/fstests/5e081252abdcf7253ad83d2b5eda49a8818305ad.1743996408.git.anand.jain@oracle.com/
temporarily). Then send PR to me, I'll try to push this patchset in this week :)

Thanks,
Zorro

> 
> Thanks, Anand
> 
> > Thanks,
> > Zorro
> > 
> > >   	# don't leave old full output behind on a clean run
> > >   	rm -f $check.full
> > > @@ -849,7 +850,6 @@ function run_section()
> > >   	  fi
> > >   	fi
> > > -	seqres="$check"
> > >   	_check_test_fs
> > >   	loop_status=()	# track rerun-on-failure state
> > > -- 
> > > 2.47.0
> > > 
> > 
> 


