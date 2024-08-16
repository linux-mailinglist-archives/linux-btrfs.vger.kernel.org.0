Return-Path: <linux-btrfs+bounces-7232-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86581954831
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 13:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E78C281C7B
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 11:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9312B1AB53B;
	Fri, 16 Aug 2024 11:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MvF12n4k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1182B19EEC0
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2024 11:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723808574; cv=none; b=NBJZ0dPqKk1PhQDG4KvCZzSobM50NUQt1xks3CqAl0tzZY5AOx0QGwfyX7PpifgAZ1tYdBBr1ZbrP4qOiU5B2Eb3afSFEmxV+6hKS04vchqj01Xlr9Jn3TfHOUhVO3EpbSDFvy2i6mFpZqlidPLOZpf56C1BMIqphUZ/DfXpOmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723808574; c=relaxed/simple;
	bh=2mVTsqxNSKcFUF22bN7u9NeuSTPq+ny+GLfwgME3W/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DT/TfI4fRGY1bL9G1AEId+6k0X4pP1omV1mXZ4u3ZxObXHcuJ1rqhhepobs/5KZU1Vsyh/mkGURj0goLyVVR7JR+Bc5AQNWpsRYQxxgz2ED3vYV6C+BfP3QTwZ7w69CoYtQh45Ni20C2TApd4SIKkWuCNQXZidpY2PVWxI+7TI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MvF12n4k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723808571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=59r0sawk1GsuglTZhsCX1OUeGQomXixjBhl57tHpsFo=;
	b=MvF12n4kK3nO/Ol80jas4AkbogzNzJqaB3FX4fULFYD9yiyPFXfvwlG9/VZH9Lhl3aCLE5
	ERnOaP6kkcMaGAqPzxxbD6zwx5q2PQaXia6a07m+YZcyh7QXH1DyCkGCJiexxLiBP8oMbc
	+niLPMuJTmi4U9XhcbrvCS/AimG/lOg=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-BRS-3QXXPjC8C1DNi9pR3w-1; Fri, 16 Aug 2024 07:42:50 -0400
X-MC-Unique: BRS-3QXXPjC8C1DNi9pR3w-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-70d1df50db2so1442521b3a.0
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2024 04:42:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723808569; x=1724413369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59r0sawk1GsuglTZhsCX1OUeGQomXixjBhl57tHpsFo=;
        b=PMJpMG741mKmQF9UivZC8CBZGNCXIB6+6gdkGhGwZF8I2QB0WCm46fGdEx9kRUtg2a
         4kSlKdHYQhrhfBy2fY079obSZQvidaGdtQ0Ij6IiBage1aXV9G5YhaT6X5YGvUsr2Ddm
         5pbNgANVxQQw1us27VG0LC7LKpqo16zb8sk0HloR1aFfJ1yrSjpX0X+txlsmre0WqPL1
         IEUfq+V4U3oFqfkrrzJmmxk0pZbKx2gnar740YO1P0hgMjIjCTHFhwv5aO6JDZeHSgX+
         +AYMeTVyLIewbizxVSZistGz9NXpHNtM/VvrXPQIpWTnTWr4rjrk2riVZvl5bbRKxLRo
         QTiA==
X-Gm-Message-State: AOJu0YwPuTJckaHsbJTxDSrN1feeYI175KPDBHXWHhQQbYpu5eE4cuSh
	czxP2HQELg5S2yWjYQGUjEp3c1/Mr9sRHCRHiLNxzfMfH3CeVbtvTlilhuB/KY05SvGa6oVqWo5
	ZRdPxDPdJu7y/IlNtQZoD39hog89UdOqZ3Wi5XrSYcHryjLkwtKEMjtRFF7tJ4uHXKsM2heQ=
X-Received: by 2002:a05:6a00:2e29:b0:708:41c4:8849 with SMTP id d2e1a72fcca58-713c666c435mr3505016b3a.9.1723808569395;
        Fri, 16 Aug 2024 04:42:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqMKUdSBtB+QUYrQ4lrRa7GmaVwYM1LO/AF82w524Y9KAd3uWV+nbBAxcFBZDZT/E8WXh3+Q==
X-Received: by 2002:a05:6a00:2e29:b0:708:41c4:8849 with SMTP id d2e1a72fcca58-713c666c435mr3504967b3a.9.1723808568779;
        Fri, 16 Aug 2024 04:42:48 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b6357b67sm2800873a12.72.2024.08.16.04.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 04:42:48 -0700 (PDT)
Date: Fri, 16 Aug 2024 19:42:45 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
	fstests@vger.kernel.org, fdmanana@kernel.org
Subject: Re: [PATCH] btrfs: test send clones extents with unaligned end
 offset ending at i_size
Message-ID: <20240816114245.mgugfp66skww72nu@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <177f429d65afb5cc99a7f950779ba15b130cd581.1723470203.git.fdmanana@suse.com>
 <ffe34979-75bf-4cb4-ac66-d21bdc85578c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffe34979-75bf-4cb4-ac66-d21bdc85578c@oracle.com>

On Fri, Aug 16, 2024 at 06:58:37PM +0800, Anand Jain wrote:
> On 12/8/24 9:51 pm, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > Test that a send operation will issue a clone operation for a shared
> > extent of a file if the extent ends at the i_size of the file and the
> > i_size is not sector size aligned.
> > 
> > This verifies an improvement to the btrfs send feature implemented by
> > the following kernel patch:
> > 
> >    "btrfs: send: allow cloning non-aligned extent if it ends at i_size"
> > 
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> 
> 
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> 
> Zorro,
> 
> Could you please add this to the patches in queue? Since this is the only
> patch pending, I will not be sending a PR this week

Sure, thanks Anand :)

> 
> Thx, Anand
> 


