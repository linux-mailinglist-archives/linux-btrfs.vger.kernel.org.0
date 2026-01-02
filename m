Return-Path: <linux-btrfs+bounces-20078-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4335CEF1CC
	for <lists+linux-btrfs@lfdr.de>; Fri, 02 Jan 2026 18:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F6AB301D0DB
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jan 2026 17:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B412FB97A;
	Fri,  2 Jan 2026 17:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gavinwestwood.co.uk header.i=@gavinwestwood.co.uk header.b="K8IuEK1Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from willow.solutium.co.uk (willow.solutium.co.uk [85.119.82.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CC22F9DBB
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Jan 2026 17:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.119.82.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767376679; cv=none; b=G+IZDerfMgy0e3UZGhOMhDNoCkVpZquTHsuxvPKFjdq8ETH96qI9/8zzP4+aeFTHIlJtkzBWAeAze+NCzuxWHszIlecW7sKYF6LPqQqUPaJ8PWV6EQJXLydB0UwVcFGgZWFbB7VPd5a+6IJHfQpC3DngWTXMG8GdvsvuKsqPD8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767376679; c=relaxed/simple;
	bh=3PTNK3yEk4u3H+xAYC8TQg6ml/2KebpHOT2l1/qGu6M=;
	h=Message-ID:Date:MIME-Version:From:To:References:In-Reply-To:
	 Content-Type:Subject; b=TXReyq5yp4x/Y46gtHmpYWPpQVE6FZy6pLCm7Zn+dIn1LYpOb5IGONXQrym9IZeiB+e9a2X6nj4ioq7xFv5x0LxsdjMnCyqOxtvm+ZL0v47lh68k1EHxJDZskfmxcd0PFEZH/hRoygXXzPa+nbQwofminTgl8t86hLelNfCcHH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gavinwestwood.co.uk; spf=pass smtp.mailfrom=gavinwestwood.co.uk; dkim=pass (2048-bit key) header.d=gavinwestwood.co.uk header.i=@gavinwestwood.co.uk header.b=K8IuEK1Y; arc=none smtp.client-ip=85.119.82.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gavinwestwood.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gavinwestwood.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gavinwestwood.co.uk; s=dk20240123; h=Subject:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:To:From:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ib58zlEKeM5YHDnL6ANA+pd9ME+bjJ7HCLO9tSMw0c0=; b=K8IuEK1YwTyMkbjlreLoh5k6uA
	mZ/OIDX+fg1XmOt2IpsmmqXDq+RPp3vadys1kcOoyk4PgTJWEQDE3Inofe9Qr8TcEH8bZcmlEUFLq
	WnwOwW/HJlJ/FlnLz0XE7QDC9LbGUV8bXr/yQaz/lAjy5EOwNDkXotrm4Z3h2zXLXk37kFP8zkn66
	rQuANMxKMjStvSgmP5zAKbNstDlCOdpvNWb3/yNlE15eoypvn0GiRaz5+UP3OGs0JPW8NxIpers49
	rAgAMrauhkU51QmjKVr0Dd4p/540O4vjfDtmrO0ouPz2Et1Rd3V6+dTcY+s3Te2dCq0Dx+sGdsOJP
	d4IsVmTA==;
Received: from [2a02:390:5023:0:cff6:a37d:c924:5411]
	by willow.solutium.co.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <btrfs-issue-2025@gavinwestwood.co.uk>)
	id 1vbjPO-007Ehs-1R;
	Fri, 02 Jan 2026 17:57:56 +0000
Message-ID: <82b85270-3cbe-428b-b2ba-b5db37279c58@gavinwestwood.co.uk>
Date: Fri, 2 Jan 2026 17:57:54 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Gavin Westwood <btrfs-issue-2025@gavinwestwood.co.uk>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <bfcf30d4-92df-41e7-b7a7-f3684196b616@gavinwestwood.co.uk>
 <5e3796a6-75fc-4de5-9e3d-82155c1dc9b0@gmx.com>
Content-Language: en-GB
In-Reply-To: <5e3796a6-75fc-4de5-9e3d-82155c1dc9b0@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:390:5023:0:cff6:a37d:c924:5411
X-SA-Exim-Mail-From: btrfs-issue-2025@gavinwestwood.co.uk
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Report: 
	*  -20 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
	*      [score: 0.0000]
Subject: Re: Request for assistance: Error on rerun of btrfstune
 convert-to-block-group-tree after accidental Ctrl-C
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on willow.solutium.co.uk)

On 25/12/2025 20:25, Qu Wenruo wrote:
> 在 2025/12/23 00:31, Gavin Westwood 写道:
>> <SNIP>
>> Am I correct that the fix discussed there was included in 
>> btrfs-progs-6.15 and, based on the information I have provided below, 
>> installing/building then running that version on my system should 
>> resolve my issue of not being able to resume converting the 
>> filesystem to use a block group tree?
>
> Yes, that's the case.
>
> Newer btrfs-progs have quite some enhancements on btrfstune about the 
> bgt conversion.
>
> So it's highly recommended to use newer btrfs-progs instead.

Thank you.  I was able to manually install and run btrfs-progs 6.17.1-1 
from the testing (Forky) release on Debian Trixie without alterations 
(not too much divergence between the two releases yet) and it 
successfully completed the conversion without error.  I have been 
continuing to run that version of the tools without issue.  I ran a 
read-only btrfs check on the volume once the conversion was completed 
(no issues reported), plus a scrub (no issues) and some partial balance 
actions (again, no issues encountered).

I have just seen that btrfs-progs 6.17.1-1 was backported to Debian's 
trixie-backports on the 30th December, so to ensure ongoing 
compatibility I will be switching to that instead of the manually 
installed package from Forky.

Thanks again,

Gavin


