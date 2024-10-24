Return-Path: <linux-btrfs+bounces-9128-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721219AE5F0
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 15:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0382DB25A61
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 13:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA511DD0CA;
	Thu, 24 Oct 2024 13:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RiI211BT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0252A1DFEF
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776015; cv=none; b=aryCbIPujo/24CPTDPI5l3oQM2bOJTXk4dXWur2RQIReAKTTWQ1kwAlrvBxNKESFCm5GqQbZqMejAdHGsgSkL+CzA7tAMoNDUFPJsBwRMFVr4UwQi6PIBi0OzzhfAZnxy5534oa5d/2Tp7smtI6Ey6B15G7p9o4aunfRu8P2Fv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776015; c=relaxed/simple;
	bh=R2INtfzSnpxZhUbY/N7iGAAfGhG/ByhdP2AB7v8J2+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RK9H5CYxprLYKSF4zjx/yTTCalkoMJSBv/bJqdkpHn0NvL5Qv7Q8xqA9/fLprshLRSwSqTp5p0Es4lI6AtIb2nwdsxX+/Hg6eoKEefJbgRGZi2mP6LKNodm0kQjZa6pJhnFVYBGLILngTaGdvkSLz35nlympLioXrnAwthnk3v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RiI211BT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729776012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8iJ7W3nz4WvfyoieNtKm3ENtdAmy3aJMmF0WG4f6orY=;
	b=RiI211BTU07V3MaLStoIApAFKsfGYzAji3sRPapWs7SCCvgvdkOUYvEByIL6fkBDd9xplh
	ZymZNdzuxuVZbmLJwju2v3NG8emLivcbT4VUtmC4a16xejCkKz1ZKTp5cspJVmCcCvOTd4
	yZ5S9MvD8IhbPugMhac/gUynV/iMuVo=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-FFCeXdIIP_aaDq5slM2rgA-1; Thu, 24 Oct 2024 09:20:10 -0400
X-MC-Unique: FFCeXdIIP_aaDq5slM2rgA-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-207510f3242so9727995ad.0
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 06:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729776009; x=1730380809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8iJ7W3nz4WvfyoieNtKm3ENtdAmy3aJMmF0WG4f6orY=;
        b=dheTAFuMAtFXxHlS++O1N32OBZZfQIzs76XnJtEfO6cRgZc68DSgzdwVKhq1TUdZJj
         dmw6+uTxOPgMPM5EEQB8MCgKIcpXBzMe/HBsvE6Ety6MgpTs2Aj0NAEkQjvCuvrPx1II
         sg+H2jko8dbnj/6/DCMMZfgB0ruyxZUB246hw+MdV0BfIkQ2prtGxa5lWJWrTd87OKzs
         ozP+nZv1YE8HDQDjLVnCNXbzxJn0ct/0zGy8znRyc6nATKOF9OM0N0pFLogA93XfdUmc
         Jce69NaWmL/wmgVOPl0+0xFMmP43F8pSxqMyqkUTsKlu5FQq3VrEP6r/x8yWcHsYTaQi
         f68Q==
X-Forwarded-Encrypted: i=1; AJvYcCX22Zknp4Cn1ysJ2yKO3uSInp4ujPU1regZdMzlPgfJ/ht7pmQahF3Q1Z9A5Tp70scrP7gsoje2oXu7ug==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx0YFKPTWGxRLSV5dXeI1zZ+9oB5JcYuHnDBWkmazEHkDmozzT
	5+1YtkgZ+e/MpMR7AyWNKBYY7AnngRnpMBFr6+zlybwfqe/lUAYF6Fe3R6wt61atnfTaUjjxPJL
	4FgJ/aF7rtLDBpDi55V7IX8SaJ5lEbmlLdEuUcbanMkFdN9uff5NkcybXeLkk
X-Received: by 2002:a17:902:d50d:b0:20b:b238:9d02 with SMTP id d9443c01a7336-20fa9e62d13mr82149785ad.33.1729776009487;
        Thu, 24 Oct 2024 06:20:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvW9z1JTtlbfYBN395xVJAQWFiwEBT3KCPZwAslFGgJ/BgpM1/xnrVvqALn9Te4Tviz7UGdQ==
X-Received: by 2002:a17:902:d50d:b0:20b:b238:9d02 with SMTP id d9443c01a7336-20fa9e62d13mr82149535ad.33.1729776009099;
        Thu, 24 Oct 2024 06:20:09 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0de428sm72571315ad.230.2024.10.24.06.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 06:20:08 -0700 (PDT)
Date: Thu, 24 Oct 2024 21:20:03 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org,
	zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: avoid deadlock when reading a partial uptodate
 folio
Message-ID: <20241024132003.64sxshdq4qh6fnwu@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <62bf73ada7be2888d45a787c2b6fd252103a5d25.1729725088.git.wqu@suse.com>
 <ZxnXtI_6HCwvCvLT@infradead.org>
 <d373ef6a-956e-4319-ad2c-36f67a887a58@suse.com>
 <ZxnaqgJrYFjGxPEn@infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxnaqgJrYFjGxPEn@infradead.org>

On Wed, Oct 23, 2024 at 10:27:06PM -0700, Christoph Hellwig wrote:
> On Thu, Oct 24, 2024 at 03:54:54PM +1030, Qu Wenruo wrote:
> > And generic/095 has a much higher chance to trigger it than the minimal one.
> > The minimal one is only easier to debug and faster to finish one run.
> > 
> > Do I still need to add the minimal one to fstests?
> 
> If I have bug with a well known isolated reproducer I love
> having it in xfstests.  I don't know if everyone agrees, though.

generic/095 isn't a specific test case for a known issue, it's a common test case.
If you want to have a reproducer for a particular bug, feel free add it to xfstests,
mark _fixed_by_xxxx and describe more details about that bug in the test case.
If one day we update g/095, it might not cover the bug you need. Then a specific
regression test case will help.

Thanks,
Zorro

> 
> 


