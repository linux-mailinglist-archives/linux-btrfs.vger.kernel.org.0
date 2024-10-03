Return-Path: <linux-btrfs+bounces-8520-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2770C98F824
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 22:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B472EB229EB
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 20:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615F71ABEDF;
	Thu,  3 Oct 2024 20:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="IwEIs4cy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA411A7247
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Oct 2024 20:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727987676; cv=none; b=acTlDcsu5TNV6CMKo1iJNuqvkGUoMqqMOXkNg6jd12REVUDkDYAbQ6hJwE4qe5Z8hS6Wy1l2LyPZIVb6QuuIlnlk3+1WxXXUFLhCU0sWE9UDXefTSJXA+JDoKKEgcBFDx3vK5u3sKgrzInb+K0/soObxAyyPpI7vEDjbU4g2lkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727987676; c=relaxed/simple;
	bh=rSJugYB12Be5tJtXg3BLUdroNcARAcSEwBJHTipc7tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSEC1iWDTRPtHN1tyZWlNpnF+KNQHTsvvBlIdU0GxEcg8eMjpbs5og4Pv6nBuCVL/JLw8j+1GxYTXo4YpU73NsxUIoVx2RndVr7/4HLHWXTLlKWzr7I9l5+W0za+rUkEtsmjj349L4Q0BtF3+UwzkZXlRnJP0pQi7h6/QA3/oWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=IwEIs4cy; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=ZYr5RpKP20D+JTMcEMmg41hG9Ee7l7J5/7UXgIl1MK0=; b=IwEIs4cyCKmNghDG
	yiVZTKpKFcRkm1xUuXZ2qclWBjDDH48Mcv00+5sg8F1ksgjEWJXvizikJY5zAnTReVS5WlKi+COIi
	iVYuCpPvSno+lE7t68FxHarFNvaJk6JCnSSwH2b5y5srDO6LrpTSWzxUc3VuL5bpSS2XvnmDQlNAy
	17MKGKrQfJnR32s1MyrQpWRqmKtll4NvuiAx48BD1Pz1gEpe6QjrNobu3ZjqjarUbz3ybUw0SSjSo
	gf10MNzDIj1aV28AeJa/CPoyde3O5McifUtv13Bqb+mu2X1v4qxHNdOR46fza8AB34NadTIRP4bSN
	NRxJYvrewLaDXSDxJQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1swSWv-008jYZ-07;
	Thu, 03 Oct 2024 20:34:33 +0000
Date: Thu, 3 Oct 2024 20:34:32 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: of btrfs_free_squota_rsv
Message-ID: <Zv7_2EIYI9W7tjw2@gallifrey>
References: <Zv6f_ALAoC_kFg9z@gallifrey>
 <20241003183802.GA414021@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241003183802.GA414021@zen.localdomain>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 20:33:50 up 148 days,  7:47,  1 user,  load average: 0.08, 0.02,
 0.01
User-Agent: Mutt/2.2.12 (2023-09-09)

* Boris Burkov (boris@bur.io) wrote:
> On Thu, Oct 03, 2024 at 01:45:32PM +0000, Dr. David Alan Gilbert wrote:
> > Hi Boris,
> >   One of my scripts noticed that 'btrfs_free_squota_rsv' is unused;
> > it came from your commit:
> > 
> > commit e85a0adacf170634878fffcbf34b725aff3f49ed
> > Author: Boris Burkov <boris@bur.io>
> > Date:   Fri Dec 1 13:00:13 2023 -0800
> > 
> >     btrfs: ensure releasing squota reserve on head refs
> > 
> > I was going to deadcode it, but then thought I'd better check since
> > unused 'free's sometime turn out to be someone forgot to free something!
> > 
> > Thoughts?
> 
> Hi Dave,
> 
> Thanks for catching it, and for the thoughtful message.
> 
> I believe that function is just pure sloppy duplication. The same
> functionality is in introduced in the same patch in
> fs/btrfs/extent-tree.c in `free_head_ref_squota_rsv`, which _is_ used
> in the cleanup path.
> 
> So with that said, please deadcode away!

OK then, please see my just posted message 20241003203319.241687-1-linux@treblig.org
(from my linux@treblig.org alias)

Thanks again,

Dave

> Boris
> 
> > 
> > Dave
> > -- 
> >  -----Open up your eyes, open up your mind, open up your code -------   
> > / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> > \        dave @ treblig.org |                               | In Hex /
> >  \ _________________________|_____ http://www.treblig.org   |_______/
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

