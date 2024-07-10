Return-Path: <linux-btrfs+bounces-6343-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7F092D68F
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2024 18:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7196E1F27132
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2024 16:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402A2197A87;
	Wed, 10 Jul 2024 16:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="h+Q7VXqI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q4HLDQqm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EEA3236
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jul 2024 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720629037; cv=none; b=gAV149l52wNCGmggeWDd7RxxHpzf/Zzna9ba7Cb6JkoLAmO659aWC3a7sFLZXZT4RPYS/YMiYml9uoiwqUY8yEOO8juX0WTJYyYhX08PTG3URJnTEPZowlRz/ANsC+CtSlxKX+OG2gqDdKmvi1XvSkNMXlvNDrWVOCFsDFlH+YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720629037; c=relaxed/simple;
	bh=Af9vxgUV+ez6WPRIn3K0+MQA7ulwMORcnjlARfKQzFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sf8ySfDZ/4jzfmgh1fmlVQ7R7huPkRWJIMw45So1bym30h05n/qOOUbBJsqIpKh5x1i1TEehXM5UjPo5kNgZ8187dA6eDaWVp2k1//fcES//+m/whD4xAoMvMQyIvyv1pWhX8od25Di7HXqctSV+3DgOAB2nitRsZXZcLnoiv7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=h+Q7VXqI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q4HLDQqm; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 692001142349;
	Wed, 10 Jul 2024 12:30:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 10 Jul 2024 12:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1720629034; x=1720715434; bh=CwOaGcD88l
	KZ7aCqDn0B5sDBeFkJ5MNLyIjh5SzOBmk=; b=h+Q7VXqILUFTaOQgDIgAHbhZKy
	tSjG5GlYjf6CSnRSwTCGwcXISJ90rNRhXjB782Ct36RjXO9aPBbsfNFSBrYvlUh0
	YyGEWAq+Lfv0q86FqVGxKQ1TAn03DIospyVw14lDKP9gTvTbceYMFhjlj3NEG58g
	k8txm80IbGG+rBOtvFvlJb1nvmVMHJ0ukwhBY0mBaNLLTpo1xuBa5caKEqA3vew8
	XxRuNUX3dZt0rRahx13XdDFDpgKTXtqroOalyGQbPNxr65KffSIfb0iFfGSbL5Pn
	/hzONhuicCDqfBYtsdgb6c9lFEyj8tRMyAldb6g0y4f43wdCaZbSRld2et5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720629034; x=1720715434; bh=CwOaGcD88lKZ7aCqDn0B5sDBeFkJ
	5MNLyIjh5SzOBmk=; b=Q4HLDQqmWin4X2jElVrLF8l+N4xZCUYXxhNrxac4/jx4
	aS0CEnTjHYiSIDMM4OdnNhSoQI+Hd6rUJF0APhUa8NrsCTWUbuRWs3R059FOTwvS
	fswR1t6T3o6zamcZ1v5pKn7gjypCvEpoXwHytyRHFYbqEzxeFaGDPwuSssv1oPrw
	6tjmjUmqoqB2+XACq1S0KdsDdWE5xBncoeJJouT4JNSVB+ymN/m19fzbsPoFsSOJ
	Jd9CroSlLHTQiRUupuV8lr6baboSnL5EBkDYTi3/jqLhahLZkwWecen0UhGdLDZj
	mQbXwY2SJ+E7QC0KvPPgE/ySCMR2ATySubhJ/4Osaw==
X-ME-Sender: <xms:KLeOZhwjfIkfaLT88XkHSRPDbHqwIRBspavy6_45uOUeEAcDO8tu8Q>
    <xme:KLeOZhQ3LP-Le0Mklvxxe9b5C6DaxHhHxbPB2yYh9MU7ywiOwrRdD1oaBSlFNRUVX
    kUG0CwD-eIFOzemVxw>
X-ME-Received: <xmr:KLeOZrXDH3UEN0VlXnIQIiboOjzfapbnaxkXuVEIRmrF_ni4K3sikv_1gfW1NKZJYUMe2iYP99nkvAlJeychz7I78-o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfedvgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhephe
    dvkedttdfgkefgtdekfffgkeeludfgfeejfeetlefhueefteegfeffteehveefnecuffho
    mhgrihhnpegtohhkvghrrdgtohhmrdgruhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:KLeOZjheGg4s6nCS_rtpNgteVupDeZaCCv-3OsdO9TDYIruSDZmbRw>
    <xmx:KLeOZjAyxFnLurJUPEpOBtQSUrYCvho2F8bxFH_p86Xaw1K1Aud40w>
    <xmx:KLeOZsIax-KD-4nqkh0lnq3vLTylByDH5GEwsexZAaKHInb3N_eA4A>
    <xmx:KLeOZiBCRsoG5Q4ddIRkT2xIV8uXrOADfJzwj7mTHvE9jv-TWotFnQ>
    <xmx:KreOZmNVMTu8q4wdj926CUY_vKZ-_RYxTW0dLPGlljXBoA35LuhJ0lUo>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jul 2024 12:30:32 -0400 (EDT)
Date: Wed, 10 Jul 2024 09:29:38 -0700
From: Boris Burkov <boris@bur.io>
To: Russell Coker <russell@coker.com.au>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: btrfs-progs: btrfs dev usa as non-root is wrong and should just
 abort
Message-ID: <20240710162938.GA3394284@zen.localdomain>
References: <2159193.PIDvDuAF1L@cupcakke>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2159193.PIDvDuAF1L@cupcakke>

On Wed, Jul 10, 2024 at 09:52:14PM +1000, Russell Coker wrote:
> Below is the difference between running btrfs dev usa as root and non-root on 
> a laptop with kernel 6.8.12-amd64.  When run as non-root it gets everything 
> wrong and in my tests I have never been able to see it give nay accurate data 
> as non-root.  I think it should just abort with an error in that situation, 
> there's no point in giving a wrong answer.
> 
> # btrfs dev usa /
> /dev/mapper/root, ID: 1
>    Device size:           476.37GiB
>    Device slack:            1.50KiB
>    Data,single:           216.01GiB
>    Metadata,DUP:            6.00GiB
>    System,DUP:             64.00MiB
>    Unallocated:           254.29GiB
> 
> $ btrfs dev usa /
> WARNING: cannot read detailed chunk info, per-device usage will not be shown, 
> run as root
> /dev/mapper/root, ID: 1
>    Device size:           952.73MiB
Hmm..
>    Device slack:           16.00EiB
>    Unallocated:           476.37GiB
Also wrong, but at least it's the "size" number?!

btrfs device usage (and btrfs filesystem usage) usually give
pretty reasonable results without root on my systems, so this is sort of
surprising to me, especially since it looks like we both have the same
trivial raid/volume setup and you are on a relatively new kernel.
e.g., on my system running 6.9:

$ sudo btrfs dev usage /home
/dev/mapper/vol-home, ID: 1
   Device size:           826.50GiB
   Device slack:              0.00B
   Data,single:           117.01GiB
   Metadata,DUP:            2.00GiB
   System,DUP:             16.00MiB
   Unallocated:           707.47GiB

$ btrfs dev usage /home
WARNING: cannot read detailed chunk info, per-device usage will not be shown, run as root
/dev/mapper/vol-home, ID: 1
   Device size:           826.50GiB
   Device slack:              0.00B
   Unallocated:                 N/A

I suppose my non-root output is lacking usage information, it at least
gets the size right.

Does the same discrepancy happen for you when running
'btrfs filesystem usage /' with and without root? That command gives me
lots of useful, interesting output without root. e.g.,

$ btrfs fi usage /home
WARNING: cannot read detailed chunk info, per-device usage will not be shown, run as root
Overall:
    Device size:                 826.50GiB
    Device allocated:            119.02GiB
    Device unallocated:          707.47GiB
    Device missing:                  0.00B
    Device slack:                    0.00B
    Used:                        109.38GiB
    Free (estimated):            716.59GiB      (min: 362.85GiB)
    Free (statfs, df):           716.59GiB
    Data ratio:                       1.00
    Metadata ratio:                   2.00
    Global reserve:              168.02MiB      (used: 0.00B)
    Multiple profiles:                  no

Data,single: Size:117.01GiB, Used:107.89GiB (92.21%)

Metadata,DUP: Size:1.00GiB, Used:764.42MiB (74.65%)

System,DUP: Size:8.00MiB, Used:16.00KiB (0.20%)

Thanks,
Boris

> 
> -- 
> My Main Blog         http://etbe.coker.com.au/
> My Documents Blog    http://doc.coker.com.au/
> 
> 
> 

