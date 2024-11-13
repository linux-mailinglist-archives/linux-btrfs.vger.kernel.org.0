Return-Path: <linux-btrfs+bounces-9595-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF829C731F
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 15:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 577DC281D47
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 14:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7BF1DDA15;
	Wed, 13 Nov 2024 14:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="Nzq/5cRa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0634B282ED
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 14:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731507261; cv=none; b=k823C5p1ulNsEsLivjN/FZ2QcXd71szOKMZB1u/R2HoWHi0wDgeMnJnJJUq3e8TviHKinNVilqeYSiHMxcsA/PGUnyg7H3TEmsa2i9wHrehzVJM9sj7Ebm5hTUeMdLQVOKUNzgfwkoDc79Il5Qvnn/3LqeDrBtJwoaMxBxVtt9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731507261; c=relaxed/simple;
	bh=W7xg/St2RsQ48M03wr4KKSEH6cOWTZciPUvuhGG/HdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXA5j8BEBL3l39AFyC8lDx3fAqxUfylDQ84HuLVsL/o6pHQglpq7tBQkZY/d3TMI7wTaSYAjkSN4V8bCSngN3yf3PyK/qd0spoEIUnDQSf7wM4v1+A5VJsJVYLlTbiEZnAVl25x4S48fv7XZCK4JEuR8JnP0UioYWKvi77mThMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com; spf=pass smtp.mailfrom=konsulko.com; dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b=Nzq/5cRa; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=konsulko.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6cbf0e6414aso33800386d6.1
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 06:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1731507259; x=1732112059; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W7xg/St2RsQ48M03wr4KKSEH6cOWTZciPUvuhGG/HdY=;
        b=Nzq/5cRaH2nYJFoLH3fP6jtnQXegWv8NeJpBj1fc4l4z9ndw2JXVei69wt9vsUbn4l
         gftEe/DgWqfN4efy9az+Dofp3x3mDiqR5zjNGsijMDf9ZXW4krZ3TxQdvPCYaz7vRg1b
         F26QR3FY30LAqnsFxU6gc8+onNYuoXSuwc6Dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731507259; x=1732112059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7xg/St2RsQ48M03wr4KKSEH6cOWTZciPUvuhGG/HdY=;
        b=CPamD02V+vC3HVaad/tHm9oA/4OUPy3EsTLucHGV45gfwTwv3wA+Ql00HYTcIg2ayA
         /NFc+kiJ8O2FaQ7+Jta2dZYhwMTTcXI6sj/k8d7E5aZEbcV+4W8FxwO+iydpWJ9Z7I1Z
         mC/nmbiNdPaCwaHn6uKsa6kOEKkqzuwx23+lCbtnPxc+/1Qxxp4boaUV1EPC7WxPLMCg
         jlZlqZp4V37chCAK7GbpWAUPAQfwroKdzVETLt5EtwjXhHvEAfevkvPaW9ChdV9LkBQ9
         uyqbbciNhJdXe+Kjnd1EOnDGkfE7OJt+rFp225E9ezkDkLrV2B/0kxgYyqfRWrEVHq1M
         LFUA==
X-Forwarded-Encrypted: i=1; AJvYcCWc9m8+4399Epv+TU9QDdCMCEsz6V2KPqJfm6oBfDc+I6zKT/XBeCzJJtX0rrEIBoy3Gb/PnPHXnIxJbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyL0wpeu1oZPn+wHrCycRvocVAGt7re0Ll2DeM0Z0J7di90rf8o
	4uApIFUQiPxA1i4C1Oi7GghCg9lI+6w/VxnZMw8NcjMM5mAka5cRR6fzUJ+RrmQ=
X-Google-Smtp-Source: AGHT+IFKNu8RFpUKb82zmFeg078VdB750jdzdO9JqfTChqkxZwxG+7WDOw2JaruFaSuWNkHf270sYQ==
X-Received: by 2002:a05:6214:419c:b0:6cb:c85c:5654 with SMTP id 6a1803df08f44-6d39e166f57mr244471876d6.4.1731507258769;
        Wed, 13 Nov 2024 06:14:18 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961df062sm84370036d6.11.2024.11.13.06.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 06:14:18 -0800 (PST)
Date: Wed, 13 Nov 2024 08:14:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Qu Wenruo <wqu@suse.com>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	linux-btrfs@vger.kernel.org, u-boot@lists.denx.de
Subject: Re: [u-boot PATCH] fs: btrfs: hide 'Cannot lookup file' errors on
 'load'
Message-ID: <20241113141415.GL3600562@bill-the-cat>
References: <ZzRAEgQYS46yM7Ct@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lyup+x3+f3wwzdiC"
Content-Disposition: inline
In-Reply-To: <ZzRAEgQYS46yM7Ct@codewreck.org>
X-Clacks-Overhead: GNU Terry Pratchett


--lyup+x3+f3wwzdiC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 02:58:42PM +0900, Dominique Martinet wrote:
> Dominique Martinet wrote on Wed, Nov 06, 2024 at 09:56:42AM +0900:
> > Running commands such as 'load mmc 2:1 $addr $path' when path does not
> > exists historically do not print any error on filesystems such as ext4
> > or fat.
> > Changing the root filesystem to btrfs would make existing boot script
> > print 'Cannot lookup file xxx' errors, confusing customers wondering if
> > there is a problem when the mmc load command was used in a if (for
> > example to load boot.scr conditionally)
>=20
> Ugh, sorry, I was a bit quick on checking with an updated u-boot on
> this... our tree is *cough* slightly *cough* old and that was the case
> at the time, but since somewhere in 2020 there is a warning in fs/fs.c
> in case load fails.
>=20
> That doesn't change the fact that this patch is useful to avoid the
> message being printed twice, but I'll need to update my scripts anyway
> to use `size` first instead (as a first approximation of `test -e`)
>=20
> Please let me know if you want me to resend this with an updated commit
> message; otherwise I'll let this sleep.

Yes, please reword the commit message based on current overall behavior,
thanks!

--=20
Tom

--lyup+x3+f3wwzdiC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc0tDcACgkQFHw5/5Y0
tyzquwv+P0eoEjhBQ+UOy6mWWmsEz0kw+ucwXk4Bjs+hF47kGH0wNw87Uxjd1s3a
cI6lzx5c+8SZYg7VR6+eSZ5GibhTiFVuHRz6KKM7O/WKDYJb0WuFa/hXTzz7H8Sl
QSni/1e+6u9XQXcAMD0lulll+gMCdQlhQ+ukt6pWjKVMDA9HcL+0GE+MpgtfV1f9
g2ouY3r4XbsqRPbXbWc1GAutFk1gNzOeLiiIjNcR16t7zdrblwDQLqQ2q3pWKXhR
ZiET1+Lk404tke0K6yO3VP527TbFocE3jBQM2OeIBEUoSgWYhJmvV8PiFYom6Itr
hvcXPuYLSS03rilcIxgv7lkgGHmOH9XxW1VUea1Vh/JD5xvgfjmpuMIPAjqJY78/
tiI/HQ34RxyO+9cZE12SpuumwEvkb6lI7hAS65PJsJhfwro1wDCd0BIkr6C/TMD4
Az4xFddsVL0l5Hem7W45GzP+irfHF8/KzyWXrkX/RhxApI+lIID8+SN/Wsi219qh
YMb5Wmkm
=q3Gb
-----END PGP SIGNATURE-----

--lyup+x3+f3wwzdiC--

