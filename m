Return-Path: <linux-btrfs+bounces-8494-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C9598F0B6
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 15:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835052832D1
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 13:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5048C07;
	Thu,  3 Oct 2024 13:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="N1hK4VTv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE261474A2
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Oct 2024 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727963136; cv=none; b=q3DhhFLbv4LvJwScjbHyFxQXiiSXhAWtucReMcu2RUzOI8iJmo5/nhaZfM9NqLBQ189EdvYn+8iBi6n+1Jrl34mLdqZZN7v23kD2WJ7+y1NFn75yJxqkgVvPX2WKTP7rTC7//Rz6Z4sGt8lijM2SfVfxBcskPiPFXyPXM7vaiRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727963136; c=relaxed/simple;
	bh=A0K8nTar5ZZ6kXsR7wc+2H1+1X/eaZCQjVSjlq0obcA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BuojSFBjqT9uS+iqRFhSmCk+bzxVqMrrJzF3eDHizeqWxDQoXMZWmCaE9kFZPXs2+OMSup7r447bXusTC8znHRdWmJp5S6wkBIjdS1RpdiuuT/vTAiIxuLwkQ6S4J2i0ggHIs5tsWYKrGYR8q1zwszLtya1GvTl6ZdxTV/hsHlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=N1hK4VTv; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=i8ADvnXg2KKcDW9+HD6nQ82/Zz/63jALKUEWRr2U/Ss=; b=N1hK4VTvx4RgEpP6
	9B9qHzRAHlW5j1r8c5mjoK9OA23BTMkCIzwUJBNx7Gi0yLrjvbOV0uJW1CRkkv3ygvHMuYXV8X+mN
	3uQ/MCGQ9e+oyeMPufBXEhjVi70caBB10zmZQEwhoEtr90VHjOjWC5456e2HsFwjzRHBEKjxbJnxe
	yCLXUloogxAKvto3bXQaUn5FkgvIoLYl4gfXrTkn9gWzQPWI3PT5E1opK2CCwdX6hgOq9L9XmekoU
	Q/i2nLjcdf+8mDB3G91hnK+R3n3xBZ1O6/0rOyNrsihu1349Zt0yQg8ej54YI6CFBFv81Uf+Tk18g
	6DAsqdmpsJh2E5uKWA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1swM96-008f81-28;
	Thu, 03 Oct 2024 13:45:32 +0000
Date: Thu, 3 Oct 2024 13:45:32 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: boris@bur.io
Cc: linux-btrfs@vger.kernel.org
Subject: of btrfs_free_squota_rsv
Message-ID: <Zv6f_ALAoC_kFg9z@gallifrey>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 13:43:40 up 148 days, 57 min,  1 user,  load average: 0.03, 0.05,
 0.02
User-Agent: Mutt/2.2.12 (2023-09-09)

Hi Boris,
  One of my scripts noticed that 'btrfs_free_squota_rsv' is unused;
it came from your commit:

commit e85a0adacf170634878fffcbf34b725aff3f49ed
Author: Boris Burkov <boris@bur.io>
Date:   Fri Dec 1 13:00:13 2023 -0800

    btrfs: ensure releasing squota reserve on head refs

I was going to deadcode it, but then thought I'd better check since
unused 'free's sometime turn out to be someone forgot to free something!

Thoughts?

Dave
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

