Return-Path: <linux-btrfs+bounces-11524-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E68B2A39174
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2025 04:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 826E37A31C5
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2025 03:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE28191F99;
	Tue, 18 Feb 2025 03:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JwCo3PpE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FC374040
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Feb 2025 03:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739850682; cv=none; b=dHEfITRHmlmO1HIM7YnuWWkakIygOqQZGVDkSMhdRHDdzHU4qSl0zuJj1XzRXwnaqZIaJBek3OKodQ8h2/PK2+magiShM/prqmdrql38n7k77owQpzEwkmo8rVMRotYdUD5Q/DK2dXnUWNDs8PGEqzZKHE9cWoW65lv+zfrz83U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739850682; c=relaxed/simple;
	bh=FvgKXlSU1t/pJyHHnTn4rTAIkocrayihITMD7T9bGUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csGwGZEtsHkz8aC/mbEykOKEZrevD7aNpG7AeZhtYODYs88P74lAiQ23DWALFpNSrK/1FG2PLQU4hR7Qfk7kY6X2wAl2s8Q3PSaeQsr64tPRQSwLKi+VHREXc9XkdZaZDEMMnbpZEZmN+QjMHVEp5hPeRWq3tLNtEiY9P2ABuYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JwCo3PpE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739850679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C1B0qnhCCL2r66FtfTHMj6MIYs0gWEo3WbaXK6R5xxQ=;
	b=JwCo3PpECW337CPml0ou7dAQTTOk5PoD9wbr09+6Ag4P9dY03c/NOABP2pK55WRotC/gW8
	B/r2sbP4IsopbXwqjXUBCVCRjJ+LWI6qNZxps5Z1J4HlsTQPBQlobXkiHz4UxG1xNUszzC
	dt1l0Z2tfslHu8MUQGUJMfUD+X0kfes=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-OLWxAjdTPdiFBQMjo2TPPw-1; Mon, 17 Feb 2025 22:51:17 -0500
X-MC-Unique: OLWxAjdTPdiFBQMjo2TPPw-1
X-Mimecast-MFC-AGG-ID: OLWxAjdTPdiFBQMjo2TPPw_1739850676
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fc404aaed5so8987790a91.3
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2025 19:51:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739850676; x=1740455476;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C1B0qnhCCL2r66FtfTHMj6MIYs0gWEo3WbaXK6R5xxQ=;
        b=vdqH2228wrR2iQo40nDegLGd1d+/akKT7lrKhAMV7O4aj8zL4L9pViprnMWQcb7bbt
         /WCaM6/C2D/zqXmezbZKuKzbS8qVhvXMUlNEPH3wZgGYpT6zHmB9um9IIBi6OLmtmp8W
         HdlhBwNdh6nTvkn/boXc0sSvOxv6JQSXT8zOTGm1EXE2uE/s7pxY6faIxRlDbqSiFqD5
         atP1fpNDFl1opMiivHm8zlhd4bRNnygFS3jRfS1XjaZELodWSwjBS0DHx5ENgUz5QBk5
         Fgm4v1cpQ1A4CA/sV8HuxoDplq6SeLlNOh27qcFOh95LtmClWQg29aigA+txkzojs4a0
         0zcg==
X-Forwarded-Encrypted: i=1; AJvYcCWL1N+ScRSSlCtUGc6FFtBiPbUma4Zn65iEI88cmMTcFRkREHNfQCmfsPEckxDqe80IKZuC3eMAdMLZ4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDT5/9Fgv0swdtjzF0ds1646HZcooV9PpdNmsQwl7hgF+Oa3Xf
	iF9urRXaXsdlr18qpw7QT0dFBSYI7EcsL3824asyryDk7j5aJilp0v58NjknXLQttGFL4sxorw8
	aaWJA0ngcIyRBHV9apzhm+uq/bgsJeCw4OeoEy2lJyoUXkAgks1jM1bJVT/G+Kd+++NmPQfU=
X-Gm-Gg: ASbGncsHD5jLfSrePLmnYZyxUgd/Fkqg5fmqf5d5cBKkXLeTSJB3C6euGqyYCkBrv/p
	slWNpjq47wYlLeBhxSGaaTii+5cFS3Gw4BoIsXcWFSeLXffTvtvpGZ125f50pTVlK6eA/EydZZg
	e/hu7tJaRtGvNGKEOUYXdfJLyCMx8WW7j9jrFPgKr5QWPkUBFz9AeXah+QIdP8/D5YhV12A57Vd
	mWA42Dmj+YodMc5nkf/MPhzl/gGWJbZ+0oqu0/m3peumXVXQf66Qly2EcIBmzwo5pdPOTU5vOW8
	OMSRx7p3xRUKbOvUHSLyKp5LRriRKCx6JqBWi6/+LLMksA==
X-Received: by 2002:a17:90b:3812:b0:2fa:1e3e:9be0 with SMTP id 98e67ed59e1d1-2fc40f234bemr17952766a91.19.1739850676263;
        Mon, 17 Feb 2025 19:51:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFe+w2oPmg28Eu9GUkVxZOKp/RdRyEsiEvIXBVOCAAvqW2XxT60wREOtQdIcYfwIkQd9fQNDA==
X-Received: by 2002:a17:90b:3812:b0:2fa:1e3e:9be0 with SMTP id 98e67ed59e1d1-2fc40f234bemr17952747a91.19.1739850675919;
        Mon, 17 Feb 2025 19:51:15 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13b91227sm8938088a91.32.2025.02.17.19.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 19:51:15 -0800 (PST)
Date: Tue, 18 Feb 2025 11:51:11 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [GIT PULL] fstests: btrfs changes for master and/or for-next
 v2025.02.14
Message-ID: <20250218035111.vkdtzkjskutvpvqa@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250214110521.40103-1-anand.jain@oracle.com>
 <3b2a541f-da83-4658-a47b-8b8a1ea75b83@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b2a541f-da83-4658-a47b-8b8a1ea75b83@oracle.com>

On Tue, Feb 18, 2025 at 08:26:20AM +0800, Anand Jain wrote:
> 
> Zorro,
> 
> I wonder if you've already pulled this?
> 
> The branches in the PR below also include nitpick suggestions
> and fixes that didn’t go through the reroll.
> 
> For example, commit ("fstests: btrfs/226: use nodatasum mount
> option to prevent false alerts") updates a comment that’s missing
> from your for-next branch.

Oh, I've merged this patch from your for-next branch when I saw
you said: "Fixed. Applied to for-next at https://github.com/asj/fstests.git":

  https://lore.kernel.org/fstests/68aa436b-4ddd-4ee7-ad5a-8eca55aae176@oracle.com/

Sorry, I saw you used "past tense", I didn't notice you changed it after that.
Please feel free to send another patch to do this change, there'll be a release
this week too :)

Thanks,
Zorro

> 
> --------------
> diff --git a/tests/btrfs/226 b/tests/btrfs/226
> index 359813c4f394..ce53b7d48c49 100755
> --- a/tests/btrfs/226
> +++ b/tests/btrfs/226
> @@ -22,10 +22,8 @@ _require_xfs_io_command fpunch
> 
>  _scratch_mkfs >>$seqres.full 2>&1
> 
> -# This test involves RWF_NOWAIT direct IOs, but for inodes with data
> checksum,
> -# btrfs will fall back to buffered IO unconditionally to prevent data
> checksum
> -# mimsatch, and that will break RWF_NOWAIT with -EAGAIN.
> -# So here we have to go with nodatasum mount option.
> +# RWF_NOWAIT works only with direct I/O and requires an inode with
> nodatasum
> +# to avoid checksum mismatches. Otherwise, it falls back to buffered I/O.
>  _scratch_mount -o nodatasum
> 
>  # Test a write against COW file/extent - should fail with -EAGAIN. Disable
> the
> --------------
> 
> 
> Thanks, Anand
> 
> 
> On 14/2/25 19:05, Anand Jain wrote:
> > Zorro,
> > 
> > Please pull these branches with the Btrfs test case changes.
> > 
> > 
> >   [1]  https://github.com/asj/fstests.git staged-20250214-master_or_for-next
> > 
> > The branch [1] is good to merge directly into master. It’s been tested,
> > doesn’t affect other file systems, and has RB from key Btrfs contributors.
> > But if you feel we need to discuss it more before doing it, no problem—
> > kindly help merge it into for-next. (It is based on the master).
> > 
> > After that, could you pull this branch [2] into your for-next only? as it
> > depends on the btrfs/333 test case, which is not yet in the master.
> > 
> >    [2] https://github.com/asj/fstests.git staged-20250214-for-next
> > 
> > Thank you.
> > 
> > PR 1:
> > ====
> > 
> > The following changes since commit 8467552f09e1672a02712653b532a84bd46ea10e:
> > 
> >    btrfs/327: add a test case to verify inline extent data read (2024-11-29 11:20:18 +0800)
> > 
> > are available in the Git repository at:
> > 
> >    https://github.com/asj/fstests.git staged-20250214-master_or_for-next
> > 
> > for you to fetch changes up to 429ed656f99c06f8036eff1088d93059d782add4:
> > 
> >    btrfs: skip tests that exercise compression property when using nodatasum (2025-02-14 18:35:16 +0800)
> > 
> > ----------------------------------------------------------------
> > Filipe Manana (7):
> >        btrfs: skip tests incompatible with compression when compression is enabled
> >        btrfs/290: skip test if we are running with nodatacow mount option
> >        common/btrfs: add a _require_btrfs_no_nodatasum helper
> >        btrfs/205: skip test when running with nodatasum mount option
> >        btrfs: skip tests exercising data corruption and repair when using nodatasum
> >        btrfs/281: skip test when running with nodatasum mount option
> >        btrfs: skip tests that exercise compression property when using nodatasum
> > 
> > Qu Wenruo (1):
> >        fstests: btrfs/226: use nodatasum mount option to prevent false alerts
> > 
> >   common/btrfs    |  7 +++++++
> >   tests/btrfs/048 |  3 +++
> >   tests/btrfs/059 |  3 +++
> >   tests/btrfs/140 |  4 +++-
> >   tests/btrfs/141 |  4 +++-
> >   tests/btrfs/157 |  4 +++-
> >   tests/btrfs/158 |  4 +++-
> >   tests/btrfs/205 |  5 +++++
> >   tests/btrfs/215 |  8 +++++++-
> >   tests/btrfs/226 |  5 ++++-
> >   tests/btrfs/265 |  7 ++++++-
> >   tests/btrfs/266 |  7 ++++++-
> >   tests/btrfs/267 |  7 ++++++-
> >   tests/btrfs/268 |  7 ++++++-
> >   tests/btrfs/269 |  7 ++++++-
> >   tests/btrfs/281 |  2 ++
> >   tests/btrfs/289 |  8 ++++++--
> >   tests/btrfs/290 | 12 ++++++++++++
> >   tests/btrfs/297 |  4 ++++
> >   19 files changed, 95 insertions(+), 13 deletions(-)
> > 
> > PR 2:
> > =====
> > 
> > The following changes since commit d1adf462e4b291547014212f0d602e3d2a7c7cef:
> > 
> >    check: Fix fs specfic imports when $FSTYPE!=$OLD_FSTYPE (2025-02-02 21:28:37 +0800)
> > 
> > are available in the Git repository at:
> > 
> >    https://github.com/asj/fstests.git staged-20250214-for-next
> > 
> > for you to fetch changes up to dd2c1d2fa744aa305c88bd5910cce0e19dfb6f41:
> > 
> >    btrfs/333: skip the test when running with nodatacow or nodatasum (2025-02-14 18:37:09 +0800)
> > 
> > ----------------------------------------------------------------
> > Filipe Manana (1):
> >        btrfs/333: skip the test when running with nodatacow or nodatasum
> > 
> >   tests/btrfs/333 | 5 +++++
> >   1 file changed, 5 insertions(+)
> 
> 


