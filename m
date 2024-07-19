Return-Path: <linux-btrfs+bounces-6575-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3137937460
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 09:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E6022832DD
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 07:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E3454BE7;
	Fri, 19 Jul 2024 07:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W+gvuEef"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9FC52F70
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 07:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721374015; cv=none; b=pGJFWjHWbHIWH5BSJvF75nAyt4RrqIeEMIw73RvFGS2NxlbkmiWGtSQtbQ4vvoQYutKWV4RlJZ7BJCTZWGUGtXmrk71r3IHdWNtfM5hHERB3FDICwgkEClrUIGFq/UiUv4LoiQOR4Qfz0uK0zM+o6+FsrAprqnqVORCmOWnYbus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721374015; c=relaxed/simple;
	bh=muXnVbC7nnGyLLk/HzLatPo9PELK4R8ESXmi65y94D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSiobij+mhSE9CQ/i7BaH0Ten/MxSP8fghDFzXQTT6ZdB8oxrQdH7KEw54s+8qR2ROvm0ar1d5zwJdMpCZT9VMdcSeDopfxyxo1v3ZOx+GwBHEMwnY95+8ih5a0+st6Ud2fw4KwVqXAnFgvhkZalBoSu5etC7THItmXwq0viko0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W+gvuEef; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4279c924ca7so10089675e9.2
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 00:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721374012; x=1721978812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UeDGhmHJPJxSYVrElxPRKS8Tro4wfhJ7UU7o9dReABc=;
        b=W+gvuEef5CzP9VJ+aSqocDOg7KiOROIleQGq7IC44bOuWxF1iSpS8DRkFcy6xRpv3X
         G2ULxNRlV4rBTYDbqbUdJLhASAfcw1BzShsnvf185fQl4K7FCi01/3N7uljmII5Oa78q
         dlQ25/vhe3+dh6q3to780v/PXdQlu68YZI5R49VbaRs8ns03B1KE9kkHf4wi/VZVC+WP
         L20nGdnRvITlard+IOcYGSeLJGnxAVBs6DtT4vMoYTOYAPD47YnO+C4Ir5EhBHq790tq
         gaFVbPApVw1bCatkfqxrjZpt0Y7t622rcxTTcVTTZM59l8B+wQHHE83KtNUgNBB8u9Uf
         16vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721374012; x=1721978812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UeDGhmHJPJxSYVrElxPRKS8Tro4wfhJ7UU7o9dReABc=;
        b=ZfvZBsu00ZZYfbcogGWB8zRyYy9igIuRYCTvkBgjN2+b867hBniUFGaHXlP9GvxAh9
         weaE+JDhxL9YR3DaDorVn1Jtt3M2S5m6kXmzD/c2Zwk+M9a7P1FtInkzthiGVbeE0kZl
         iBlw/8im54XONWglpxwzv8iOAWEDdqru9qcCc3xL9aXwIfIcQV7UgF84W0eTJDSqr+DQ
         kwsYmUvV61OSUzpbT99GhOgl+7LFsvONvzK0yDCwfdmJs6ncP2woR3wT3Nf2Pg4vtasA
         F+CcOeOD+VDxjdIYxaiO6FqAU8nfKW3jJNNGkRZGZ9Dd0l6Hrkox6XXzcu1UCrBJNCmg
         Uruw==
X-Forwarded-Encrypted: i=1; AJvYcCU1mhNlASomJ1VEQJP1FEtMAipYyCTERxjsn1DbAFSFM5DSwVeWuvoEoDo60VBa7/anflWf3kXQaJwpqIeUmLDK1JZdFFujLCSGwEc=
X-Gm-Message-State: AOJu0Yz6/pO42Dj3sYW0Ft5Ki/SwAq59OXhlX7ZMRUGoCWr2+MYCCaOR
	+d2DakFoFLWOqH1P2jv338HV6Wq1LBzF3Wio+ZBUHbfFmkFhxoxHiGG6IrCMBao=
X-Google-Smtp-Source: AGHT+IHZakqE4aOIlft8Vqa51rj5+/EmM2bBmPZ/gyR6QuUOzyoXXurdlRAvvVkXrp6UhbeYhHkFbQ==
X-Received: by 2002:a05:600c:4f42:b0:426:6573:7058 with SMTP id 5b1f17b1804b1-427c2ca9119mr48859885e9.11.1721374012036;
        Fri, 19 Jul 2024 00:26:52 -0700 (PDT)
Received: from localhost (109-81-94-157.rct.o2.cz. [109.81.94.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a6efc5sm41419055e9.21.2024.07.19.00.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 00:26:51 -0700 (PDT)
Date: Fri, 19 Jul 2024 09:26:50 +0200
From: Michal Hocko <mhocko@suse.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH v5 1/2] btrfs: always uses root memcgroup for
 filemap_add_folio()
Message-ID: <ZpoVOvMe7Tt9Ok49@tiehlicka>
References: <cover.1721363035.git.wqu@suse.com>
 <d408a1b35307101e82a6845e26af4a122c8e5a25.1721363035.git.wqu@suse.com>
 <ZpoQ_28XHCUO9_TT@tiehlicka>
 <99334ebf-583a-4295-be52-118c253d5fca@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99334ebf-583a-4295-be52-118c253d5fca@gmx.com>

On Fri 19-07-24 16:46:50, Qu Wenruo wrote:
> Meanwhile, can we just define root_mem_cgroup as NULL globally?
> That looks more reasonable to me, and if that's fine I can send out an
> extra patch just for that.

I think it would be sufficient to pull root_mem_cgroup declaration out
of ifdef in memcontrol.h. We do not really have to define it. Please
send the patch and add all memcg maintainers. Ideally with this patch in
the series so that the intention is clear.
-- 
Michal Hocko
SUSE Labs

