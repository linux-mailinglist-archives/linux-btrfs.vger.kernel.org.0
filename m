Return-Path: <linux-btrfs+bounces-11327-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D4EA2AEF6
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 18:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254A03A624C
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 17:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5849C176AC5;
	Thu,  6 Feb 2025 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=merlins.org header.i=@merlins.org header.b="koKNesKk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC02813C809
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Feb 2025 17:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.81.13.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738863273; cv=none; b=KdfozxfI++M3RxqG05SPoAjzYf7GrmGi2VOFCLUOKk+UEcQV7G6qt14ZKCszZ3uweWE8D7fYEPq9d29eVN8FdAlIT67OoCG4GeX9dfI1BwsRXmxlXNsc6jAJ+20Pw7kZKNSmz59Z402iDr10VwVfaE9nvYIi8fHfq8bcm1JYhco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738863273; c=relaxed/simple;
	bh=rxoQSrHclIZ9ii/166eD6fg7NJHmwQF2pkNamoN+xhk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWvUP0cIZoy+n/UeYUIFD8mHp+jpoaowoGqdohXmglcLTlbOKN6gVmScBYL7nXnBu97kBXm4D8Rh8B4/GIucee6gXvUr6EiBtcZvHTieqaUCTOUTHI4i6M2+PXxcUwB+Jf6jONJ2afvHSrVq1U7eiluoGtwuEQ9iiCBdAorz+bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org; spf=pass smtp.mailfrom=merlins.org; dkim=fail (0-bit key) header.d=merlins.org header.i=@merlins.org header.b=koKNesKk reason="key not found in DNS"; arc=none smtp.client-ip=209.81.13.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=merlins.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=merlins.org
	; s=key; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=IHzmZJRTXlXoZHyMBelP6wc1DkHUOtZYSypOB/CIdBA=; b=koKNesKkjVG55dQE5RA+xAvXoR
	auPBHjKSBrYsMasQ+4SDFxdfS/T6SLtNy+me7B4jyC9L/QQcgsLQSEuE8lWrPmUIGUBwMEoVKLxkp
	+k+mQBJSze0cecGvljTPCIt2Cazew25yTCJwti0UiguhMtOA7XPB9DrUmrP4mzRBV4V7hGyzo4TXc
	fWST/VcJlTj1vVnJ3qMYH1iTdd5RsBFgrmW3S+GGN9CSypfYiac4dw2dSnIjoF1Rqmkpq8y9ORExX
	IMPAsUH2qEAnd3yQ10iG52QIdmb9fJ2PnUJv+FFUuJc1jZBQZw9P2tmJSgKZ+hufb0gibBndXU7dp
	4nei+j0g==;
Received: from [204.250.24.206] (port=43593 helo=sauron.svh.merlins.org)
	by mail1.merlins.org with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
	id 1tg4PT-0002fR-KB by authid <merlins.org> with srv_auth_plain; Thu, 06 Feb 2025 09:34:30 -0800
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.96)
	(envelope-from <marc@merlins.org>)
	id 1tg5ll-0005Dr-28;
	Thu, 06 Feb 2025 09:34:29 -0800
Date: Thu, 6 Feb 2025 09:34:29 -0800
From: Marc MERLIN <marc@merlins.org>
To: linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: BTRFS error (device dm-4): failed to run delayed ref for logical
 350223581184 num_bytes 16384 type 176 action 1 ref_mod 1: -117 (kernel
 6.11.2)
Message-ID: <Z6TypSioRGfQi1C7@merlins.org>
References: <Z6TsUwR7tyKJrZ7w@merlins.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="33LPZqFZE4agD9a5"
Content-Disposition: inline
In-Reply-To: <Z6TsUwR7tyKJrZ7w@merlins.org>
X-Sysadmin: BOFH
X-URL: http://marc.merlins.org/
X-Broken-Reverse-DNS: no host name for IP address 204.250.24.206
X-SA-Exim-Connect-IP: 204.250.24.206
X-SA-Exim-Mail-From: marc@merlins.org


--33LPZqFZE4agD9a5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 06, 2025 at 09:07:31AM -0800, Marc MERLIN wrote:
> [1821331.237716] 	item 0 key (350222417920 169 0) itemoff 16250 itemsize 33
> [1821331.237718] 		extent refs 1 gen 2907391 flags 2
> [1821331.237719] 		ref#0: tree block backref root 398
> (...(
> [1821331.238559] 	item 167 key (350225678336 169 0) itemoff 7733 itemsize 168
> [1821331.238560] 		extent refs 16 gen 4619087 flags 2
> [1821331.238561] 		ref#0: tree block backref root 398
> [1821331.238562] 		ref#1: shared block backref parent 737084112896
> [1821331.238563] 		ref#2: shared block backref parent 736609173504
> [1821331.238564] 		ref#3: shared block backref parent 471099588608
> [1821331.238565] 		ref#4: shared block backref parent 471017488384
> [1821331.238567] 		ref#5: shared block backref parent 470665625600
> [1821331.238568] 		ref#6: shared block backref parent 350806835200
> [1821331.238569] 		ref#7: shared block backref parent 350292066304

Sorry, I forgot to include the bzip'ed keys (big output, felt like too
much to paste, but maybe it's important)
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08

--33LPZqFZE4agD9a5
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="keys.bz2"
Content-Transfer-Encoding: base64

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
oBEyiKfgAIlgIn+xdyRThQkC6dDCQA==

--33LPZqFZE4agD9a5--

