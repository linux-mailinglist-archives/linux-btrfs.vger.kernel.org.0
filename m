Return-Path: <linux-btrfs+bounces-13401-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF66A9B8DC
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 22:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E698C4A3864
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 20:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BB0200B9B;
	Thu, 24 Apr 2025 20:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jl9w5AqV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A431FF5E3
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 20:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745525503; cv=none; b=kaSyAB5bc7MwgN5sYRdorxnTmiPbZGWccGvDiS6gETJruHANhO7naFcDJkXxjqm/gYfwi81/knc/J/QsW5/AXDo3LJdCF4qTSnHhu293k9KuxoyP+oQemtQURT2RI9Gx8zLeKWXQ1P7LEq9QZIgaFZsJUCBQglrxXT9KeEhsS/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745525503; c=relaxed/simple;
	bh=JQDgE0zdnIVsy36KD+VqdkNzTeXDEdCJeJwAPKR4JRs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=TYzsoq45GA4p17ht+w4k90eaCcmyYYE6/EVpgeN2DDDZh9p5Jjm8+siTUL0a6jgvE5m9KxBlloYWRrsqnqHMfkkLfD1cROosxZOaKxQII4Sbu98Zz2eHxKPoIwH+Jztt3vE0wia0Qcg66WdOoHuypXzq2w2LSCa4bwkRk87WEME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jl9w5AqV; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e8be1bdb7bso2404521a12.0
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 13:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745525499; x=1746130299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ki3L7U3UJMBKE50yPdgVdncMMsaGSi8NQcrvx68+WNo=;
        b=jl9w5AqVWTeoA/17XmMPF+SUePQcOTX+6OwvbWigYEkR4Ib47hVxLlUZ6UqZfjL+2f
         zNTMqqE2ybuocPTk4EbX+0w5FmBjBjApChXZs0Idw7dwHm+YNfsdHzDEmFyQNuVnKmgW
         Ti6EJL7IAffdixYrJRvOCEnx6EnUBaUcfq/aZQmq4DDWwn05EO3mm3x0EXmI2hBjg7Lp
         6EExsaFsa2EJ7J9PgNv/LTZqUijzCs6hVifmyL3M+5M1tj+IXodN1XfZA072pPVH6siX
         BKTFwWTJU4eipAmpS9fPm3jl36k2qace4FrD+gR1S4Bzqrg3hXq/MtZ3+Tp46yQdWYqZ
         Q6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745525499; x=1746130299;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ki3L7U3UJMBKE50yPdgVdncMMsaGSi8NQcrvx68+WNo=;
        b=VDitUdoZHtAmVRVH4BAQty7St2GBiRq9FBpqrg5964m5rdgFendADnSVFEHiLHmuco
         TeIslpB+4Sqr6dO4+3y4JF6xmuLuemr4gjfx688JrvVskrrXWTlzEYLDRP5JbrU+oq9e
         flERZyisYaZCpHsPPAHLVuOcCLY+Ysr/fL6cveckshHZel6SGAEahUSQQkC25ljbqe6t
         n7Fudf3Ph4qTIxjbphihlAG6VU2ZdES4MzLGVnWqqqCEbRdceS/bLhNWyhIk5CAIhf6Y
         XY3yr8p7SeFJS7Fdfr46uWrYk+QI+VtLqYhkSMlf9eqlV25PzkJXP497xV4OE2EcT02y
         Lojw==
X-Gm-Message-State: AOJu0YyUYzI4Texp/kVJPz+HMX/hHSXSMHsoMc7gel0DSIFIgPerH0LO
	+DNsPGJXxWKgeRZEARXZGW8jga8PPaBOcxRByI2ObgQDaRxsKqBf44XSGQ==
X-Gm-Gg: ASbGncvEQfAb2E13SQiJ6SWWwVF+zenRPc3XhsQXQ00WxkHvyc1G+btiokBW1/VTh4k
	NuCZM7Qjn5zjIabwdfY86yD5d6YhjsMt7V6Jljb2CTH52WQPUA17JsOuv5EoSs2eGqTSY8DMqKA
	nKZZwdVoUR4/k1BshXKb8qbfzWIEb5q8FqgDKXlx+YlYt1iuV3eRJwwCnD09/4O1MQgC580pH3x
	B9daWWisV+YKVyudhQo7+XxVcutq0jS4sAaY25WQH4UU7clzCv3FuM5NL9LhMeiul4mdYCZIB/p
	zKyOgAZykmBOjYyvh0qVmiIDkLTu04ucU+wbArIOdiley+fZF46kzndK/emxJcrvf+E/arETv/o
	Pa2MCv84BholBtAZ9lmhF3D7ld3QYPgNwUxCwQvEiEXuIo+uMhLIOUUOfXj4SY8Kz4jC+rZ5L
X-Google-Smtp-Source: AGHT+IEQNPb5F67uNsyIbT0uPYGDiUyzJDMPyIV4AwxuO2GQM0wvhCmpsobC91CQ6PJG62f6A4j1Aw==
X-Received: by 2002:a05:6402:1ecd:b0:5eb:9673:feb with SMTP id 4fb4d7f45d1cf-5f6df233455mr3613223a12.25.1745525498669;
        Thu, 24 Apr 2025 13:11:38 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:e82f:dba5:732c:3d0a? (2a02-a466-68ed-1-e82f-dba5-732c-3d0a.fixed6.kpn.net. [2a02:a466:68ed:1:e82f:dba5:732c:3d0a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f70354638bsm122018a12.63.2025.04.24.13.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 13:11:38 -0700 (PDT)
Message-ID: <d98ffb69-195b-4c07-ac56-8ae1f811af32@gmail.com>
Date: Thu, 24 Apr 2025 22:11:37 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Errors on newly created file system
From: Ferry Toth <fntoth@gmail.com>
To: linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <669c174e-5835-471f-9065-279a7da8f190@gmail.com>
 <2366963.X513TT2pbd@ferry-quad>
 <b2ac7b22-ab50-4eb4-a90a-0d110407ba36@gmx.com>
 <3309589.KRxA6XjA2N@ferry-quad>
Content-Language: en-US
In-Reply-To: <3309589.KRxA6XjA2N@ferry-quad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi

Op 24-04-2025 om 13:31 schreef Ferry Toth:
>
> Op donderdag 24 april 2025 01:24:23 CEST schreef Qu Wenruo:
>
> >
>
> > 在 2025/4/24 01:36, Ferry Toth 写道:
>
> > > Op woensdag 23 april 2025 00:00:36 CEST schreef Qu Wenruo:
>
> > >
>
> > [...]
>
> >
>
> > >
>
> > >  > > Yocto users on Scarthgap (5.0 LTS) with version 6.7.1 may 
> copy the
>
> > >
>
> > >  > > recipe meta/recipes-devtools/btrfs-tools/btrfs-tools_6.13.bb from
>
> > >
>
> > >  > > walnascar or 6.14 from master. If they are building 
> additional tools
>
> > >
>
> > >  > > that use headers from this package like btrfs-compsize these 
> may break.
>
> > >
>
> > >  > >> Thanks,
>
> > >
>
> > >  > >> Qu
>
> > >
>
> > >
>
> > > While here, am I right that we can not generate the rootfs with
>
> > > compression on?
>
> > >
>
> > >
>
> > > Reason I ask is, Yocto of course builds the rootfs and than has
>
> > > mkfs.btrfs create the image. But it runs as unprivileged user, so can
>
> > > not do mount.
>
> > >
>
> > > And then can not do defrag.
>
> >
>
> > We have this feature recently thanks to Mark!
>
> >
>
> > In the latest release v6.13, there is a new option "--compress" 
> added to
>
> > mkfs.btrfs, which must be used with "--rootdir".
>
> >
>
> > And the result is exactly what you expected, mkfs.btrfs will try to
>
> > compress the file extents at runtime.
>
> > For uncompressible data, it will detect at the beginning and 
> fallback to
>
> > uncompressed data instead, exactly like the kernel.
>
>
> That is great, thanks!
>
>
> > But considering how new this feature this, it will be appreciated if
>
> > Yocto guys can do some extra testing to make sure nothing is broken.
>
> > (Normally a btrfs check after the mkfs will be good enough)
>
> >
>
>
> I will test this.
>
>
> In the meanwhile I found another problem (and I am not the first it 
> seems see
>
> /https://stackoverflow.com/questions/79475262/yocto-root-filesystem-ownership-issue/79590289#79590289/ 
> <https://stackoverflow.com/questions/79475262/yocto-root-filesystem-ownership-issue/79590289#79590289>)
>
>
> Yocto uses pseudo to fake root ownership. Even though the directory to 
> be copied into the new fs is owned by an unprivileged user inside the 
> btrfs image the files are owned by root, when created by mkfs.ext4 and 
> mkfs.btrfs.
>
>
> Except with newer mkfs.btrfs (I tested using 6.13) the files are owned 
> by the unprivileged user.
>
>
> The result is, the image will not boot correctly.
>
>
I found more about this issue here

https://lore.kernel.org/yocto/tRtu.1740682678597454399.5171@lists.yoctoproject.org/T/#m5de0afa17d2c0f640e86ffe67e0d74aea467fd5b

> > Thanks,
>
> > Qu
>
> >
>
> >
>
> > >
>
> > >
>
> > >  > >
>
> > >
>
> > >  > >
>
> > >
>
> > >  >
>
> > >
>
> > >  >
>
> > >
>
> > >
>
> > >
>
> >
>
> >
>
>
>

