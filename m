Return-Path: <linux-btrfs+bounces-15784-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C85AB17339
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Jul 2025 16:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A69B47A7465
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Jul 2025 14:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8DD153598;
	Thu, 31 Jul 2025 14:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A+h0bl1d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95D82F24
	for <linux-btrfs@vger.kernel.org>; Thu, 31 Jul 2025 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753971918; cv=none; b=cv7/E47xAWj3NI4a9cfLDbkoHP8Ap/rq+sMWxhiFTLf3/Tmssn4dzaN/LxXqtwlhD1xVpfr3dINZJ30oWjTTza6fFO92+JILztrDFjg6zTyBa0lFrsdHW594C7J3460Kf8OMEIAIPj+xd5Ue4/AogVHXAU3A8YzySjtvbtacRCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753971918; c=relaxed/simple;
	bh=oF1LCh+8I8uJb+GT1n66TkSlyJ+rlMFxS6gPvuzz0rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6kkxfMThfIIN4b5zIWmMJFwWacZErz8IEQYTEbv3G+VxNyqgEKOA7EnAr47IXupqSAYoMeqJ9nZlWQ40+sN1/v9MyUzvOj9h43YiA4iYnQO5fDd8ft+jW5QW3/JkTSOZ5CRFMxKQq5ovwyEwvFVBJsQn5m1R3tR6ryvmEFbtl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A+h0bl1d; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oF1LCh+8I8uJb+GT1n66TkSlyJ+rlMFxS6gPvuzz0rw=; b=A+h0bl1d7WnRsK5vSXOolrlF26
	UPzXI6P+7L+SDLzxiXhIyuiovukSnj34E8jnHaSbAL7lD5TAIS+66RgOHnsN76fY17cLr1/cTEz2H
	6Zjtd1WCWU0k6peRSrH7oEIJK2cXCO0H2gQvOV71S+eFdSNLYLvpUu4dgMUETsBwuTbAc/PnrSNbO
	ClJNWUzVNtnDxCRwou4XTz9Gmf02unX+tJsl4UzWVQ5Ha+k+IX5pDyzTZzh1xp5rbGdXobpbb1b2K
	RngFGPw4NXw8SUsnpXt3JCF53RZleYKLSsvcKf3f2kgv8kE6cFHJ5M7abz9GnwfskxMI4q28YA5SI
	H8pjuoww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhUDc-00000003pGy-1sEt;
	Thu, 31 Jul 2025 14:25:16 +0000
Date: Thu, 31 Jul 2025 07:25:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: use zero-range ioctl to verify discard
 support
Message-ID: <aIt8zGdVPXTnFS2s@infradead.org>
References: <2f9687740a9f9d60bdea8d24f215c6c0e2a9657b.1753713395.git.anand.jain@oracle.com>
 <yq1ldo5i0jn.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1ldo5i0jn.fsf@ca-mkp.ca.oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 30, 2025 at 10:56:12PM -0400, Martin K. Petersen wrote:
> The semantics visible to userspace were inadvertently changed and I
> would actually like to see that addressed. Reporting a default
> granularity of 512 when discard is unsupported has broken other apps
> too.

Next time you see a change that breaks interfaces, a timely bug report
would be really helpful.


