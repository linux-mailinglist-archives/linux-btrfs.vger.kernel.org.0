Return-Path: <linux-btrfs+bounces-3977-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D144B89A4FA
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 21:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AE411F21831
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 19:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1436517334D;
	Fri,  5 Apr 2024 19:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="OfnyKkrm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078FB172BD3
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Apr 2024 19:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712345517; cv=none; b=pb/TB6/55DZkWofwObul3OlUFRA59jegGRvwxBUNqR+ggwzZgUM2n5dFGVXG6O0OubyuslXZDdEGootxDFBktdqdRx0Hu825pSYHC9nn9mI7nOc8fF99kC69RGwwTMSPcaVVQCEGOvtTBd1m8hX2pHdWlZEK/ogWmjYXevEA0JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712345517; c=relaxed/simple;
	bh=8kF6zCx5kRw6Jm6yRPVqDMiT1Gzmz8s6r5iiyIiC1FY=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=R4FIUbF1rls+M3qzjfjrEbj+1Gk6hOz4sl2HdYSdsIB+zNU0IcRKb9cAXypAHZ+jNn7iT6rH07Jvjk7Y6BNx5O2R5k6YaAicy4lUOGpaD8CksYylFTKTK5d7BOOZTVlXh1vJdcJdIqWaNX2Av9u+ImHpqJFdZn/SxitIb8K7O88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=OfnyKkrm; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e0878b76f3so21446285ad.0
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Apr 2024 12:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1712345513; x=1712950313; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ehiwGS0Z8Xqga4/SUXxg4ntgcCdy89JIq8/1UnR2uY4=;
        b=OfnyKkrmMpxS8E63Ua54ZDiz/m9wfoPfPUmhwmSnjH6pHXOqVZxpOGORD+iwkyDFOJ
         bTsgoubdsRwZkJLAHOyAIMQSXfJar96hH0xFyot64ugfpNBcAHpni6XLjVPuG0azoq8j
         GtEONsNMHdT6ypUE5jiQT49nNptq0Nq9IHarQN/qn3A3jvHvKnfVEp9tHuOp0dlut5Sj
         aLhEbBBjW2R3raq7Ydjw4CXTdAbjTSQx/YZ52kZX453SdtBks8UUPWfhoa4m997n+OkI
         B0Bi/60Vl3X05sPybQdmw08sbK46G6ewrKKcpFP1v8NDIjEQVYAWNV0/8A0WL9NLy8YA
         Ca9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712345513; x=1712950313;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ehiwGS0Z8Xqga4/SUXxg4ntgcCdy89JIq8/1UnR2uY4=;
        b=NyqPAIXXdWkm8MGECctmUAKhMEZm4K+Ax4zM5z6iAP/68IuiihIO7dqd3n/XFdnMXJ
         4UxH0HtHpBlqYGx9wjNCjvJKYSkKeV/m7hQe6UTOgb8owth7FjhJPKYY7pyzKM2KLf6y
         L62QU/BSKzE/TT8m+zV+xmmDkC6HwQKVoinML5CrZpg3UgmtOrIJ27o9FJ3tXUB8TQ6x
         MRAn5xZNQdaRHRn3Alp6SW0PZwlXA+m0ElPmOv8Uh4F5iLwCGms4Sq/mWPqoqPObPnQ/
         BI9xwSWcWeUqIVpmSv/Dd7SDLd5W+nFtvrEBMm9ZTUWLDNwj1pcSJQzoyojE0PFTJXyg
         Ubzw==
X-Forwarded-Encrypted: i=1; AJvYcCWvGQQbcPgsPm3ieE1wres/BEgIxUEHbLQ1ObO+w5iHgPQTliB13HUQTQ2Jkl67XFNpQJO/7WOd5tVNcWXDa0jQCOoLMiyZVlYeWTU=
X-Gm-Message-State: AOJu0Yxxtiire7p9FnQOnaBmVMzwRcwsr/yQFnf/jrDoLNGoj5RxLQwp
	7mcpAFTEyufLV4X7FJjJTkuGLB34xilrDOU2vcacuubVatPG+iW18oay7WV1tFs=
X-Google-Smtp-Source: AGHT+IHULb/f3rPAwSiSJQzmkPHmga62s3jlPMTEEo4kcs5KA8teOqWoWSLLG9DadK7OQz25CkIxEQ==
X-Received: by 2002:a17:903:41ca:b0:1e2:6482:db0f with SMTP id u10-20020a17090341ca00b001e26482db0fmr3114175ple.29.1712345513217;
        Fri, 05 Apr 2024 12:31:53 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id h18-20020a170902f2d200b001e29c4b7bd2sm1963190plc.240.2024.04.05.12.31.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2024 12:31:52 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <B6218039-714A-404F-BEDD-ADC54F99BE1C@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_0D1A6818-3729-442E-BD83-023C8BF27ABC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3 13/13] bcachefs: fiemap: emit new COMPRESSED state
Date: Fri, 5 Apr 2024 13:34:00 -0600
In-Reply-To: <7CF0A3D0-50E7-448F-A992-90B9168D557F@dilger.ca>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Brian Foster <bfoster@redhat.com>,
 Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 linux-doc@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-bcachefs@vger.kernel.org,
 linux-btrfs <linux-btrfs@vger.kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 kernel-team@meta.com
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
 Kent Overstreet <kent.overstreet@linux.dev>
References: <cover.1712126039.git.sweettea-kernel@dorminy.me>
 <943938ff75580b210eebf6c885659dd95f029486.1712126039.git.sweettea-kernel@dorminy.me>
 <7CF0A3D0-50E7-448F-A992-90B9168D557F@dilger.ca>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_0D1A6818-3729-442E-BD83-023C8BF27ABC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Apr 5, 2024, at 1:17 PM, Andreas Dilger <adilger@dilger.ca> wrote:
>=20
> On Apr 3, 2024, at 1:22 AM, Sweet Tea Dorminy =
<sweettea-kernel@dorminy.me> wrote:
>>=20
>> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
>> ---
>> fs/bcachefs/fs.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
>> index d2793bae842d..54f613f977b4 100644
>> --- a/fs/bcachefs/fs.c
>> +++ b/fs/bcachefs/fs.c
>> @@ -921,7 +921,7 @@ static int bch2_fill_extent(struct bch_fs *c,
>> 				flags2 |=3D FIEMAP_EXTENT_UNWRITTEN;
>>=20
>> 			if (p.crc.compression_type) {
>> -				flags2 |=3D FIEMAP_EXTENT_ENCODED;
>> +				flags2 |=3D =
FIEMAP_EXTENT_DATA_COMPRESSED;
>=20
> (defect) This should *also* set FIEMAP_EXTENT_ENCODED in this case,
> along with FIEMAP_EXTENT_DATA_COMPRESSED.  Both for compatibility with
> older code that doesn't understand FIEMAP_EXTENT_DATA_COMPRESSED, and
> because the data still cannot be read directly from the volume when it
> is not mounted.
>=20
> Probably Kent should chime in here with what needs to be done to set
> the phys_len properly for bcachefs, or leave this patch out of your
> series and let him submit it directly.  With proposed wrapper in the
> first patch of the series there isn't a hard requirement to change
> all of the filesystems in one shot.

Ah, I missed the 11/13 patch that is handling up most of the bcachefs
phys_len changes.  I think this should be folded into that patch so
it is clear to the callers that the data is compressed when they see
fe_physical_length is not the same as fe_logical_length.

Cheers, Andreas






--Apple-Mail=_0D1A6818-3729-442E-BD83-023C8BF27ABC
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmYQUikACgkQcqXauRfM
H+B07w/+MmXpmeeehpinb/y0l8UhYl0eqiljcSOE4SDFyKHRdwMRb9tUzdvr3ZOI
YSglCdxdJ7umd1U5D38IjlSEfNPIJ4EQ7aYo/R8DaNballbpfROENbO7B2RxVQV/
KiJ7kJjSIgDL+T8Evdt0VopojAHlPxJlWcMh4HR4KCeaaKstdKuC1IVncs/zFtD6
Fui3/nG6LLK2dFTtvbY1cdN7MWRDPntZ7Kt5ovjZq2AWQHBc3bSF5LF/9KHD8yAS
yBx8McpPFcH7jFcb/YG6oby4vsvNr+g7x+l6lBFPsxzwJeQ03L8ZcDNP4eUcDGTQ
MxwgYvbktgldnwy6V2UIG8SWQhlUFkvu6Tes5mKtRi+k3kaBiTxCFiYRtGHUD5J7
VvJI5Ttx1fWKZAD9w+viFAgyg+q7bLL7zNeb9yKiGN60GDZzJw8kCzNYPQGC2D/T
+q+vTtpn8hzJ89OYhDNfJRYWtpq2E3UCQZERcDHmGyjn+GVkpsXc+tCfqjYQUctD
500EVWcI//t2TuZi7Khbp1enFw0Hg0tqbLPZcOcZxkQAm8NGTPIWr8+6PwMVI4qM
SFYbecP+LjPBbcDggyOE63dZQfjo/Hl0LJByapB8gLLyrqhFYkC/Lwo6LyH+D6NE
k6cJ4CjhLs67thiPQfWHvNId0/YTsQ7l02b7EGERyAkLuV637gA=
=gQCH
-----END PGP SIGNATURE-----

--Apple-Mail=_0D1A6818-3729-442E-BD83-023C8BF27ABC--

