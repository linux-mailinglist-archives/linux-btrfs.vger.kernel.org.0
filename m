Return-Path: <linux-btrfs+bounces-11884-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A575A46DA2
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 22:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278DD3B0584
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 21:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D662264A99;
	Wed, 26 Feb 2025 21:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="1U/sbtIk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A3626157F
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 21:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740605871; cv=none; b=emiCJQMl+pAknlWh+x7R2SrzPQJIo0kU2f4f4Mfw+NIExkbSUSWSolyDV1XxYBfZVi9/XWfDifo1l/Z6SBhfRTLnZYegWisWJVs+wnaKX1iZa/3IVJYYx0StbZ4fB/EteJYyTFpwNntzvYQq12Ta1jFxG/ppbOy7Fizsa7c1AdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740605871; c=relaxed/simple;
	bh=V5RHRNqTw4lI5IbZCuyA3x7FDKEYN2piwqVBrAEGwds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tp2vpQSdQFdDhBT1/CeHZVNShvO+AFXhb5L/wJSwqrx1MVkgmgK+30LsGAbNN3/0gCSqg2cBpWY1QfUlZwqLECVy2MYdG6VaYWxSLxxLkVV3Be5HtO0CrpPBep78q/JnmZ003KAU6Qnp/9oZg0NabmveLWulK3Im8CSUGlQyCz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=1U/sbtIk; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2234bec7192so5640635ad.2
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 13:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1740605869; x=1741210669; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MCUcEwmj1Jh7k+9CxWzzM/Zd6boDO4ys9mXEZIczeCM=;
        b=1U/sbtIkP5VJ0FGtf2ilFnh4zraIcwAbPbGodSh++OG9fN18+cMVt2fwsLBsSuvbtv
         VYqEWPl3i+RBpkdbGCWwjINf7nO2HzOdn5rGLDeZmIDfUspdFgt4QiRajLKEs0WDigMO
         IXdpiO5eWXcNMFJIDEOUdg82PDQV7ggyarGDD9246JuiuvGjjqk0XeNSCzShA84AH3DP
         urkmSan5xNkrdTs91Bo+Vurz/5C2UqLQPE+aL9mN5h+3TYwDWaes/CxmtJ2WfB2G/tdi
         T5FY5ETUQNNg3hNZbz0K+ojJjxx74kBxOKVP1sbme6RZGSUOob2STwKX7mk9YGyuZrSu
         Df/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740605869; x=1741210669;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MCUcEwmj1Jh7k+9CxWzzM/Zd6boDO4ys9mXEZIczeCM=;
        b=NrMaJGC0RRGDNmVosPCyg42mumeQsQlFSS9ZT7EMJ3Zu5ypd6QaZ68KjjljDcN9/Pp
         omWBY9cW1jEiXrK6lYKgcekKZe3174bS7BrN48gV5K/ovRW6xabbNDdHH+nwGNd2Fx+S
         1sMbo0F56yRkvQmWO1GaHWdKunFxkA/kFxa2Pot9NrsM8PYH7w/9hTb4jAAMWjpiDzP+
         bt++FAQpE1LhmgGvxIPf1D/mLgUAf/gOWALAWW7v4Tb7D54q34QrfjwnGZQ2n7NP8xCu
         HZSe9sS/wqcFRyv8ZPU5a3ECaKWFNzd54kpwBrpjw0sN8Qfs3JSgFJB910lLVUy4C0u4
         xlrA==
X-Forwarded-Encrypted: i=1; AJvYcCXSc/cXprDagfPNBZmaK/wb4cwQtxf403dwd+Hu1So+ud4Mzfn4CPrhg8UyBBiCz3rBbvY2TEw89E+lkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUbdUcWkgq/CeAThFGZoOitJQHlg47o9gavRMD3NL7XpGZ1Zon
	j+FXyAqAdWuyoY4n2KDcTFWNUHntfVpYUoxypLYg9fvk/8krBe2EjtBASAY7lls=
X-Gm-Gg: ASbGncsaed/T7gtwMxsiDPk+DClFeMXtqhfeDmmggDTsh7x/9SwN9KgOOdDpONR0hXi
	DFMCozHy/lYXJk9ep0D6iJleHViUAEwMV33Gh8Jh4pCz6p7lPa5OFeikEU51XRDn6Eeqp56vmHc
	n842EIyYXdlAC0Fs/6EFLxMPjeIWyjK8qYtzRdddf3zKEDXAB+c9e9NOKebPt6wkuSM0yyaJ33A
	MwpwqmcY/yb99jCdObzMfN/b86UAMkkMSQazietji/Q9HlpUWrx42ciZQMDAh7Nj0N0omW++/hA
	TU3k57V3lUxKnfsF2dzsxhqw+Kivm6froWawoFuFNbVDg3yU//11I/gN0oXJOZaeDOF2Gx0CNm/
	61Q==
X-Google-Smtp-Source: AGHT+IHNqRpXCuSGBS+Xg8ISiTxFsZCpyrUty1AnGDojZW1XuESCjdL+Ctc0rMGpJj7o3PpbI9dUdA==
X-Received: by 2002:a05:6a00:21cb:b0:730:7771:39c6 with SMTP id d2e1a72fcca58-7348bdb3e0bmr8947565b3a.8.1740605869526;
        Wed, 26 Feb 2025 13:37:49 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe2ad91sm24930b3a.13.2025.02.26.13.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 13:37:48 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tnP6A-00000006MMg-1KKF;
	Thu, 27 Feb 2025 08:37:46 +1100
Date: Thu, 27 Feb 2025 08:37:46 +1100
From: Dave Chinner <david@fromorbit.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Zorro Lang <zlang@redhat.com>,
	Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] fstests: finish UMOUNT_PROG to _unmount conversion
Message-ID: <Z7-JqucPHv2E6ncE@dread.disaster.area>
References: <cover.1739989076.git.fdmanana@suse.com>
 <9aa6c8318d11b2fd1c2e208d85b2f83ea81ff88d.1739989076.git.fdmanana@suse.com>
 <d2d72753-5bf2-48cf-b2f0-cfe184ec75a7@oracle.com>
 <20250220170333.GV21799@frogsfrogsfrogs>
 <CAL3q7H6cH26jarU+YEogd5O5FuHi+YNtaWgmsV72NuXacPQU6w@mail.gmail.com>
 <20250221041819.GX21799@frogsfrogsfrogs>
 <Z75B38rmY9TPsftf@dread.disaster.area>
 <CAL3q7H41a=gzDtQDX8L4ep5PhD4ZpuSCUiNGzx5eK2h_N6bQXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H41a=gzDtQDX8L4ep5PhD4ZpuSCUiNGzx5eK2h_N6bQXQ@mail.gmail.com>

On Wed, Feb 26, 2025 at 10:37:20AM +0000, Filipe Manana wrote:
> On Tue, Feb 25, 2025 at 10:19 PM Dave Chinner <david@fromorbit.com> wrote:
> > diff --git a/tests/btrfs/029 b/tests/btrfs/029
> > index c37ad63fb..1f8201af3 100755
> > --- a/tests/btrfs/029
> > +++ b/tests/btrfs/029
> > @@ -74,7 +74,7 @@ cp --reflink=always $orig_file $copy_file >> $seqres.full 2>&1 || echo "cp refli
> >  md5sum $orig_file | _filter_testdir_and_scratch
> >  md5sum $copy_file | _filter_testdir_and_scratch
> >
> > -$UMOUNT_PROG $reflink_test_dir
> > +_unmount $reflink_test_dir
> 
> This isn't equivalent to directly calling UMOUNT_PROG since the
> _unmount helper always redirects stdout and stderr to $seqres.full.

Please update your tree to the latest for-next. _unmount does,
indeed, return stdout/stderr to the caller, and so as the commit
message says, it is a drop-in replacement for UMOUNT_PROG.

I wouldn't have sent the patch in this form if that hadn't been
fixed.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

