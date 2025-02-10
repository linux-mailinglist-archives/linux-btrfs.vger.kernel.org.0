Return-Path: <linux-btrfs+bounces-11362-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A916CA2EFFF
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2025 15:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06E003A6851
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2025 14:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0D123AE81;
	Mon, 10 Feb 2025 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGiOkgSt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2D61F8BDE
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Feb 2025 14:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739198232; cv=none; b=pI0c2AAPkZLdW3MkQP9z0Co6dbofgk3kHXoTJXrhjAkSVaVs5pYygYW/+EUnkZRQJQ9MLi0coH0288RfS6jZoS40uaxB3DxA6nadR4xiGwDnX0SpXU4nxV0euXSluL8MVU1AqcbLxg2G6peRSt4hVNy8+AtkQaehmKn8Nz3VC3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739198232; c=relaxed/simple;
	bh=oLkSYzp2rjWHxZ/xe4AQNAnA2eN1EDgni3aOnfU/H7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJVdienQaCk0Ml/10aYAyaymJXGRKhRceYlxjeNwmET69q6ywS4Oog4klZX4JO+r91DM4gbOHghA4MJHFG/UtkHDo5dPBga8tDR1BWMkpFtIb5w2k+u6u5ogax6eppDH8nWdL3yoPJgjaa6F4IpIASWWShu1HaOBcgRmUcyUkq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XGiOkgSt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739198229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=McHz0EtfK587W5vJv2MbBgm5E6tBye8+lH/5p5Sbniw=;
	b=XGiOkgSt62oXPUmTMVHfM9h974FNTXzEm5isEXZF85+8wJr2vl6C7AwmUUC6+MS2/LWSVP
	Wlnfq8FAdzuOa+V2iqCEMMaD16hbLXGo6LkoPenCMWoqXPKEc7DPcZ23RivSi9e4H6D5Zk
	NhVZnBZytCtLP7xXtkP0eYGUoRjvfwU=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-WJwdMxEZPSWVURkUDWI8TQ-1; Mon, 10 Feb 2025 09:37:08 -0500
X-MC-Unique: WJwdMxEZPSWVURkUDWI8TQ-1
X-Mimecast-MFC-AGG-ID: WJwdMxEZPSWVURkUDWI8TQ
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-216266cc0acso106779505ad.0
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Feb 2025 06:37:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739198227; x=1739803027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=McHz0EtfK587W5vJv2MbBgm5E6tBye8+lH/5p5Sbniw=;
        b=dqRu06Eit0yTPSUO9tzrb+765hkH3wp2mB4PLRwu5Rv4m1GuIk+DgI4RtoJMoBd3Kb
         C35Qi6C9YGOPUJKL01QrhLKexudJpzyjqmezuqScrfy032kDMwFuj3WQzNVxXKh4+A9F
         uTePxJRqcIr/cvRqcu3ha9+j1DJAggbvz11VszeVy0hW/53BLFw/5CpE+oRkzrB8TWX/
         n295X76Ma8f+DbpkJrOljNkdeX5I4p5Ny65cB0qwq8TqwZB4q2OfMMxw5EX5bXtR63vb
         mu8eZjF0VUCl5rfizMK0S66Ad8Md/VIFHOp8tOWyY8JE/Ax+tBpU9tpDgzF7M0vVAWC9
         +1GA==
X-Forwarded-Encrypted: i=1; AJvYcCUF2YVSKD06b8rz9/E5QcTpP70TWZFtHx51KvRgXgw5qO5kaRpIoR96NGRAicL2Zs5zIOh1/2Hr5EIpkw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzH/kH4PvW0cjGWNhr18V8xzK5/rkPXCcHnd/6IiGrMFBQBO836
	/+ImTj/T9sCQR0LlDxXzeZmaAH6W1Uae3Asjokp2nG/GvQGBPMHNVNFhRHG3kZh4NF4v/nD5Zrb
	/OBLURFYBi7HDwiCSJanEZcdMH2wr7mvB+Qjc2ab04bqt/wySrhLlLP2RmhaY
X-Gm-Gg: ASbGnctxXHPHA1kni4adinXg5BzCVDOvJc+BQCDM1czvCAvmlo/UAj85VhXrFvZwhQE
	s/nRkJNV+cAmUYtULDh1REnXM+KiqBk2mcjXSHJh2SQ2NOKUlxqUlVmtTZgw33SbxNIJfUKEr8k
	tHqvOraMeUsMyvVJdSZlCSLQAW1MKg9ZigOqaow5nO4MICf+T/o4/4mL/H/BEqf2lKgBaSFqx1s
	RGHSGP/sNEN/U8RnAYpMiIWoNzIJtWXwMRTJUJn00Um8eMOflpSxdrj5Y2LZr39O0tsnpJTIZ97
	tIj0zxmUnQFAKGJw7EkRCBO3QWRfCom8J8ra4bfQWyNHOw==
X-Received: by 2002:a05:6a20:c88e:b0:1e1:adb8:c011 with SMTP id adf61e73a8af0-1ee053cabbamr21290469637.18.1739198226980;
        Mon, 10 Feb 2025 06:37:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzV+2GQl25CC/2c8IMQ0s/PL42Lma0Ascoev6c4sd1nuiLwhosL113K/kCkSjuY7odIP9xjw==
X-Received: by 2002:a05:6a20:c88e:b0:1e1:adb8:c011 with SMTP id adf61e73a8af0-1ee053cabbamr21290436637.18.1739198226639;
        Mon, 10 Feb 2025 06:37:06 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51aecd55esm7774969a12.29.2025.02.10.06.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 06:37:06 -0800 (PST)
Date: Mon, 10 Feb 2025 22:37:02 +0800
From: Zorro Lang <zlang@redhat.com>
To: Filipe Manana <fdmanana@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>, fdmanana@kernel.org,
	fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] generic: suggest fs specific fix only if the tested
 filesystem matches
Message-ID: <20250210143702.6f5fet6rzrkha7r2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <8c64ba21953b44b682c72b448bebe273dba64013.1738847088.git.fdmanana@suse.com>
 <Z6TC_yP7pTlzDOH4@infradead.org>
 <20250206155501.GM21799@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206155501.GM21799@frogsfrogsfrogs>

On Thu, Feb 06, 2025 at 07:55:01AM -0800, Darrick J. Wong wrote:
> On Thu, Feb 06, 2025 at 06:11:11AM -0800, Christoph Hellwig wrote:
> > On Thu, Feb 06, 2025 at 01:05:06PM +0000, fdmanana@kernel.org wrote:
> > > +if [ "$FSTYP" = "xfs" ]; then
> > > +	_fixed_by_kernel_commit 68415b349f3f \
> > > +		"xfs: Fix the owner setting issue for rmap query in xfs fsmap"
> > > +	_fixed_by_kernel_commit ca6448aed4f1 \
> > > +		"xfs: Fix missing interval for missing_owner in xfs fsmap"
> > > +fi
> > 
> > How about you add a new helper instead of the boilerplate, something
> > like
> > 
> > _fixed_by_fs_kernel_commit xfs 68415b349f3f \
> > 	"xfs: Fix the owner setting issue for rmap query in xfs fsmap"

This looks good to me ^^

> 
> While we're at it, we should move these _fixed_by* functions to a
> separate file to declutter common/rc?
> 
> And maybe add a few more dumb wrappers like
> 
> _fixed_by_xfsprogs_commit()
> {
> 	test "$FSTYP" = "xfs" && \
> 		__fixed_by_git_commit xfsprogs "$@"

Yes, this makes sense to me.

Hi Filipe, I can review and merge this patch at first, if you'd like to
do above changes in another patch. Or I'll ignore this one, and wait your
next patchset. What's your plan?

Thanks,
Zorro

> }
> 
> to replace the opencoded versions?
> 
> --D
> 
> > ?
> > 
> 


