Return-Path: <linux-btrfs+bounces-14497-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 658EAACF4C7
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 18:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA805189C8C8
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 16:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF09027510C;
	Thu,  5 Jun 2025 16:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ej+BrAcN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519801D63C0
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 16:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749142356; cv=none; b=ipjDWTLurGI9m3pEtCoq7sQh3OrMUN4WRk1O/uKAvEcrk5l8KHnPM7rgIHSTzOoQZS/h+kq+qTpORA6FaAJ5F0ccY3y0hrg12BHo6iHXP8a3RHkzlumT9785uYy6a4xt7DJlS7VagnbaEO6LkZPNKhzvfbzSau8g2fKckdJeUC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749142356; c=relaxed/simple;
	bh=AiNRxUzGlD8uWylDoYIn63O0jItqWQznImESl+Pe2iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlnOAFwCA4VtlwMpvUvq9qXXlULMpuAsJrphL91VFvAKtRkpV8HWZiBGwFMEmFCdPVSak5PB3JcjExYKvpDdxVzbIuH72SIWRHF5OCUHCv0z8W8g4hVjgqjzpEC/C0uM9eNFU6qexbNyKhLYlwTJRFlPeayV4uvn8ItnD9PX7dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ej+BrAcN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749142353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CDcOaQsepgVz77KyArgIfG1W1IWE/RSxTcZaZFoY5jQ=;
	b=ej+BrAcNmcO0nVuWUYUWs7YLBxmPSj03NQi4iiFxHOSM86mzZ8P/MW7289/f6G1vMfZDfZ
	zesMy+TqihjqNfnDdQ5phhkstrwzrtH7fBjArR5oBXNWKX09k3OhqQ4yWzi1zyozt63S6Y
	VxysoU5nqPPnE4HVFgsVhyLlzL8cg3s=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-DTpew-JbN5CHHtkLGRufrw-1; Thu, 05 Jun 2025 12:52:32 -0400
X-MC-Unique: DTpew-JbN5CHHtkLGRufrw-1
X-Mimecast-MFC-AGG-ID: DTpew-JbN5CHHtkLGRufrw_1749142351
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-30a39fa0765so1897139a91.3
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Jun 2025 09:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749142351; x=1749747151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDcOaQsepgVz77KyArgIfG1W1IWE/RSxTcZaZFoY5jQ=;
        b=qIfWLW5fzyoJRLqYAtSoE3BhE0rsAD8U6U7JMYTAP4793glu0Mjhm7tbTsQAJVdHeP
         jOfQhGdEcS4hcW3zG9rzMe+M939rSPyJdpiw9OUuUctuFeRTIIo8DOcN0BC8qBGStxxU
         Abhd0+PIDTyXD6DtT24EnK4nUbMaoUuCjtPQps9fDtn51ZXVbpSUKOJ2w03NxF3aZqYP
         ItDhrGmjTLETbaeaMiOZplA/uG/h5/s4OL44HdaftcqpJ49m3Avj1DPQCOn4gIVC0ey9
         UzRssV4QQRWg5fpyz98twirdsulUVFK/AyHcY2BflX66gnv1fyQsKY+qymSjJQGJZa74
         rIIg==
X-Forwarded-Encrypted: i=1; AJvYcCXmjB8d25BYC9vJ1kEYp3VgeE9XJgDfDfu9wrxM1zvZUEWRtWfoAwizduyTl9uGC32bCEGOxlNxVMK6Og==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSxRoH7ESnOzfpg1RT3xi+pbFyGzqOkNDN5jhtLS0OzOnsUNIi
	MwwTwZAhUzQmGyVX2xtiLpCpJ1qQaqXC8wmFkY2lRkn4p2+NpaZrAFOuz6IDxCcvEhZem6kl60E
	cXjipQJl4K6pFEMqz1WsWcynk36N/f5UoWaVENmRLyu5p0T3hZKkv18grRcTj/gmT
X-Gm-Gg: ASbGncswEX5dSZG1Q8gbimqPK9pEcFODOWKb7EdgkZDzatvw5mjk99ZdRrv0i8AqU5B
	ra1Dau8catB/AcsCsyHq4LlHu58WBHBz8Bx6dSmyAci01iC2Z9kZ5jhG3kkE1/QzjdlC5/EneRG
	yGTvAyDe1x6z4N5sfDAYl1P5ZP8Db6djeYVzkIB/UsBUBq+kjbqHi8sIwlpoUsEgvKkjQhWCq6A
	Va8thRhc4jr5Qp8GwGJtiSwZPa8bIGjNajPNCYofGWDSFVpHXUDnK67E7hFABx5KMFeoUjn7HOO
	OE7V6LL1Dce68sFtnQ1T4XhsUeUzb3NIu+wcqMmPhiTV+W7xOEuc
X-Received: by 2002:a17:90b:1d8a:b0:311:bdea:dca0 with SMTP id 98e67ed59e1d1-31347077612mr590246a91.33.1749142350882;
        Thu, 05 Jun 2025 09:52:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFARWL9qtlcsraN/mDHABEO9OFY3sm0RKZTVJ0Qs1c6/NIFr8pUABLaleMONsPmzupTPrDw9g==
X-Received: by 2002:a17:90b:1d8a:b0:311:bdea:dca0 with SMTP id 98e67ed59e1d1-31347077612mr590215a91.33.1749142350432;
        Thu, 05 Jun 2025 09:52:30 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3132c0985e3sm1760237a91.27.2025.06.05.09.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 09:52:30 -0700 (PDT)
Date: Fri, 6 Jun 2025 00:52:25 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic/032: fix failure due to attempt to wait for
 non-child process
Message-ID: <20250605165225.fajg7aj3btuejhnp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <ad779afaef849e0febdce26cbcb5503beed87341.1748432418.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad779afaef849e0febdce26cbcb5503beed87341.1748432418.git.fdmanana@suse.com>

On Wed, May 28, 2025 at 12:42:20PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Running generic/032 can sporadically fail like this:
> 
>   generic/032 11s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//generic/032.out.bad)
>       --- tests/generic/032.out   2023-03-02 21:47:53.884609618 +0000
>       +++ /home/fdmanana/git/hub/xfstests/results//generic/032.out.bad    2025-05-28 10:39:34.549499493 +0100
>       @@ -1,5 +1,6 @@
>        QA output created by 032
>        100 iterations
>       +/home/fdmanana/git/hub/xfstests/tests/generic/032: line 90: wait: pid 3708239 is not a child of this shell
>        000000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >................<
>        *
>        100000
>       ...
>       (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/generic/032.out /home/fdmanana/git/h
> 
> This is because we are attempting to wait for a process that is not a
> child process of the test process and it's instead a child of a process
> spawned by the test.
> 
> To make sure that after we kill the process running _syncloop() there
> isn't any xfs_io process still running syncfs, add instead a trap to
> to _syncloop() that waits for xfs_io to finish before the process running
> that function exits.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Oh... I didn't remove the _pgrep when I reverted those "setsid" things.

CC Darrick, what do you think if I remove the _pgrep from common/rc
and generic/032 :) On the other words, revert the:

  commit 1bb15a27573eea1df493d4b7223ada2e6c04a07a
  Author: Darrick J. Wong <djwong@kernel.org>
  Date:   Mon Feb 3 14:00:29 2025 -0800

      generic/032: fix pinned mount failure

Thanks,
Zorro

>  tests/generic/032 | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/tests/generic/032 b/tests/generic/032
> index 48d594fe..b04b84de 100755
> --- a/tests/generic/032
> +++ b/tests/generic/032
> @@ -28,6 +28,10 @@ _cleanup()
>  
>  _syncloop()
>  {
> +	# Wait for any running xfs_io command running syncfs before we exit so
> +	# that unmount will not fail due to the mount being pinned by xfs_io.
> +	trap "wait; exit" SIGTERM
> +
>  	while [ true ]; do
>  		_scratch_sync
>  	done
> @@ -81,15 +85,6 @@ echo $iters iterations
>  kill $syncpid
>  wait
>  
> -# The xfs_io instance started by _scratch_sync could be stuck in D state when
> -# the subshell running _syncloop & is killed.  That xfs_io process pins the
> -# mount so we must kill it and wait for it to die before cycling the mount.
> -dead_syncfs_pid=$(_pgrep xfs_io)
> -if [ -n "$dead_syncfs_pid" ]; then
> -	_pkill xfs_io
> -	wait $dead_syncfs_pid
> -fi
> -
>  # clear page cache and dump the file
>  _scratch_cycle_mount
>  _hexdump $SCRATCH_MNT/file
> -- 
> 2.47.2
> 
> 


