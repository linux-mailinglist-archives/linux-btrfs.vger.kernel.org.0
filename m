Return-Path: <linux-btrfs+bounces-18119-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE56BF72BD
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 16:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92D319C2E46
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 14:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79874340A61;
	Tue, 21 Oct 2025 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lc4AP85R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A3734029D;
	Tue, 21 Oct 2025 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058161; cv=none; b=kp28kG2bauaVa2cI9IZ1FEUOkDSHTK5TOCHsytPqZ+vYu6wbdb2Zwhbk2CfOJd56yjqS952AjiMDRMO1bEY8smbxhdhYZeQ73ZBVG2TSc387J0PbQqz47fA8zd5JJw6TLX4K6Be5u72J2UvEurRqAykxVqIg/p6V7t5Wq2yzfSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058161; c=relaxed/simple;
	bh=YIFVVDZlVutCfPBrVpQ6UPbWPq4Gs7+P0hr88XbNjj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVUNw14RjiGElQ+pn8x2hXxQE7i3wLerk1qgMWSd5J4RG9LBDK2+dopufZGdSrfQnG99b/YK0DHk2LUPA89dMfW9q2PYpug+oIC+awZ8TlLbjCOB9FiAB6kVicusBQZp/kU9gaK4DHlhMBn9FaW0z5XC0FJ/O7QsRTVEoxLhNi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lc4AP85R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C36C4CEF5;
	Tue, 21 Oct 2025 14:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761058161;
	bh=YIFVVDZlVutCfPBrVpQ6UPbWPq4Gs7+P0hr88XbNjj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lc4AP85RXUsFVQRbUv5ZeD9uWxo4kImmq1uVqiwvQWhmBu4mW/uNKdjADaB1ECMRj
	 oga9n5JXCgpKZxx7XnD7h+UovXUpyg03t3gjgFzwM/r5ODLjsMTQsjZ3Y0hAAsvwdl
	 +j0lDFc5+v1u8bdwq37r575vI6NnKZNcKnp561ntK+RfLR12wZ23WjeA0MRoiBcYT5
	 odi+vklo0iA1tTymQq3+0lZjBUhvimjExSA2JC/j1VfAGzWpV0+knoDx1Frk2mNizX
	 D+LGXpojFL+WS2QGkxjhdgr+UrmeOKuF24rZa1ZziAleYrKmaZ+enmJ6r8PI3SXp3q
	 xWb7XXbB7LEEw==
Date: Tue, 21 Oct 2025 07:49:20 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Zorro Lang <zlang@redhat.com>, hch <hch@lst.de>,
	Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Hans Holmberg <Hans.Holmberg@wdc.com>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH v5 3/3] generic: basic smoke for filesystems on zoned
 block devices
Message-ID: <20251021144920.GH3356773@frogsfrogsfrogs>
References: <20251016152032.654284-1-johannes.thumshirn@wdc.com>
 <20251016152032.654284-4-johannes.thumshirn@wdc.com>
 <20251017185633.pvpapg5gq47s2vmm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <0d05cde5-024b-4136-ad51-9a56361f4b51@wdc.com>
 <20251018140518.2xlpmmqajgaeg7xq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <8253d6b9-e98b-4a05-80c0-f255ec32ee38@wdc.com>
 <16e539fe-b9f0-4645-b135-3930df249eab@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16e539fe-b9f0-4645-b135-3930df249eab@wdc.com>

On Tue, Oct 21, 2025 at 09:33:05AM +0000, Johannes Thumshirn wrote:
> On 10/20/25 8:21 AM, Johannes Thumshirn wrote:
> > On 10/18/25 4:05 PM, Zorro Lang wrote:
> >> On Sat, Oct 18, 2025 at 11:13:03AM +0000, Johannes Thumshirn wrote:
> >>> On 10/17/25 8:56 PM, Zorro Lang wrote:
> >>>> Does this mean the current FSTYP doesn't support zoned?
> >>>>
> >>>> As this's a generic test case, the FSTYP can be any other filesystems, likes
> >>>> nfs, cifs, overlay, exfat, tmpfs and so on, can we create zloop on any of them?
> >>>> If not, how about _notrun if current FSTYP doesn't support.
> >>> I did that in v1 and got told that I shouldn't do this.
> >> This's your V1, right?
> >> https://lore.kernel.org/fstests/20251007041321.GA15727@lst.de/T/#u
> >>
> >> Which line is "_notrun if current FSTYP doesn't support zloop creation"? And where is
> >> the message that told you don't to that? Could you provides more details, I'd like
> >> to learn about more, thanks :)
> > Ah sh*t, it was a non public 1st version. It had a check like this:
> >
> >
> > _require_zoned_support()
> > {
> >       case "$FSTYP"
> >       btrfs)
> >           test -f /sys/fs/btrfs/features/zoned
> >           ;;
> >       f2fs)
> >           test -f /sys/fs/f2fs/features/blkzoned
> >           ;;
> >       xfs)
> >           true
> >           ;;
> >       *)
> >           false
> >           ;;
> >       esac
> >
> > }
> >
> > But as xfs doesn't have a features sysfs entry Christoph said, it'll be
> > better to just _try_mkfs and see if there are any errors.
> >
> >
> Zorro,
> 
> Should I bring that helper back so all FSes but f2fs, btrfs and xfs are 
> skipped and then still use _try_mkfs so xfs without zoned RT support is 
> skipped?

Except for zonefs, I think you probably have to try mkfsing the zoned
block device to decide if the fs really works because the others all had
zone support added after the initial release.

--D

