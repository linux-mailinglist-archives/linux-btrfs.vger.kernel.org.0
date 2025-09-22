Return-Path: <linux-btrfs+bounces-17085-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A27B91300
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 14:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68374189F74F
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 12:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A86307AE1;
	Mon, 22 Sep 2025 12:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="kKc01khb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF32617A2FB;
	Mon, 22 Sep 2025 12:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758545253; cv=none; b=Ce+YWYAlUgVa2m9sC/TDn5OEtTsufEmHfGdNqjJAY0U7BSiEKWY8MJVXE6NOyKmoW4ntef9pWX8ndaIFDn/36OM0DkwG/mejS12DnY5BPmqzHX7IKF8qWxanyUpb+jzArbElEWypC7n2R6BQ/8GYEqV4iZxOXqNrWwA1ZB4SulM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758545253; c=relaxed/simple;
	bh=woqjYdr6fYQ/tq8XxibmlyTyVlBuByAOdKiPLXjTrtU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k/qw1py6Tvm0PrKWkakNWWviwpkJDcD4arZw47IC5TWYRuzG0/eYlJd0Mdvu/y98R2JxFdvTw2Sdc1R52+7lOaLBaKYeEeWHIoRU6R9K6igWcXj9a16SDrcb9q5ApuMJ0giWxIeSaRkF1MzppCgX8mbRlF/plt+s/mkr61yLcBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=kKc01khb; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4cVjYd1j2wz9yXX;
	Mon, 22 Sep 2025 14:47:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1758545237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=woqjYdr6fYQ/tq8XxibmlyTyVlBuByAOdKiPLXjTrtU=;
	b=kKc01khbIUo4IyTASFpsTzwS2a0hqdnJQ1I4eD7VW9+1/0IpIq0k22/CTIjntgf7GiwiQX
	6mH6HXb35vRzGtH6/s9jz49amQ2USEMmmzjwzg1QST5d2fCR+cFB3c9viwtoPJhdR5SO1b
	onH0taTuBtjwHFvYreTHsUFSu2TOCU+MdPIEMr6e8r7mWk4RS0AWIjEIKZ13pKMGOE3w4Q
	JPxTBlIRbPqlCUopIG1qT3uAwX+RpQ2N7DNIGUAqS6NWTRDnum19IRalNToe+LryCLZoJF
	HTkzPt1gNAvFT6RbyloDZzqLuWjWCBc12kV7TRP0P4sofru6likGiHBIJNNWgQ==
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>
To: David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org,  clm@fb.com,  dsterba@suse.com,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: Prevent open-coded arithmetic in kmalloc
In-Reply-To: <20250922102850.GL5333@twin.jikos.cz> (David Sterba's message of
	"Mon, 22 Sep 2025 12:28:50 +0200")
References: <20250919145816.959845-1-mssola@mssola.com>
	<20250919145816.959845-2-mssola@mssola.com>
	<20250922102850.GL5333@twin.jikos.cz>
Date: Mon, 22 Sep 2025 14:47:13 +0200
Message-ID: <87h5wu4pta.fsf@>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

David Sterba @ 2025-09-22 12:28 +02:

> On Fri, Sep 19, 2025 at 04:58:15PM +0200, Miquel Sabat=C3=A9 Sol=C3=A0 wr=
ote:
>> As pointed out in the documentation, calling 'kmalloc' with open-coded
>> arithmetic can lead to unfortunate overflows and this particular way of
>> using it has been deprecated. Instead, it's preferred to use
>> 'kmalloc_array' in cases where it might apply so an overflow check is
>> performed.
>
> So this is an API cleanup and it makes sense to use the checked
> multiplication but it should be also said that this is not fixing any
> overflow because in all cases the multipliers are bounded small numbers
> derived from number of items in leaves/nodes.

Yes, it's just an API cleanup and I don't think it fixes any current bug
in the code base. So no need to CC stable or anything like that.

>
>> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mssola@mssola.com>
>
> Reviewed-by: David Sterba <dsterba@suse.com>

Thanks for the review!
Miquel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJiBAEBCgBMFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmjRRVEbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEhxtc3NvbGFAbXNzb2xhLmNvbQAKCRCWvoxv2J1l
ZYfqEACKq6YPm10/IKgn3T2JtNX9lsveTTusqpmw4z2J+jvcrGF6au/58Zz3NmTE
pIJrx3/RtGy697Di1rXigIE/35YXdoGlCt/AHMcLa5MOEkC8Tl2k0EVkaTd3LpnF
BHp0Q/tEWGLuN1bT2Cq3nDTZnZAhekw45mIsT18saDDqHNZibe15VXIgGvS/g2zv
ZbpQwtVO3/E7ELTnNBcrw52urbHjHz1MPMiX/g0dfbo27USkgqcTqbJldHycdjQR
GG9ueZoHDpxY3Ymck2fSQ/1BwbIBugFJSyLQQH5WQPfGd9fPx0dRwR6l2+Q8CwIT
x7p/zYmAdmAsnw5gHwPWO5L+cf/bt/uN/R448KztIBkILOX8IFkobEM/wtEKP17u
+liAXPa5OvwEOmnnjZBfOFJ7NWaebCJ/2Q4KODwtxnZZU7ecxwqu3dtb3zoIMI/B
CeITXKzcRHCbsjPJz0r6xdmDRL4tRJUfHB9JcMKw22D+DjXl6H8BFgzSilFGHVQF
o9nBZWXNFvh9UJ7/DUvEQ9qCNin7y1ddVeA+ok7gZOG008WmwzjvGKnVlc/r2wuL
SCBHK4MBMVQcU3f7SQVMcKZqlwjMFwu1U2g20xunD8IJahrIIPCEnncOxkECXX2Q
y41tUbBWPa+8Ex1gje91/bWojsBOOeogxjagB/90HJMr5Kk5uw==
=R7Ll
-----END PGP SIGNATURE-----
--=-=-=--

