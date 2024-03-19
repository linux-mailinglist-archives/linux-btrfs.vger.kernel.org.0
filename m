Return-Path: <linux-btrfs+bounces-3434-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A218803CE
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 18:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A05AB22C36
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 17:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884342B9C4;
	Tue, 19 Mar 2024 17:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Y5dlS+Rw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD397286AD
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870250; cv=none; b=CL8GkV0LYABKqploMnwBMxDc/ue99xc1wadlWIHsWdocCRdqn17zPi2XN6NE9xfKeHCLeO+y30Pc3gBCEB035OOFuoIkH/wR2HdjcLE0HDbi43YdNcH3UZp9gpgnuCssVQKxVL7pmmH8yTpVUawXDcS9i0/JdJw9PF1n1Imztb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870250; c=relaxed/simple;
	bh=GUoGg0w8XtQ+ImuTrhR5cl3MB36tYftXlYwJ4OKPkuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihsYJbt66Ah+u5rH0M65dnxr5fuCJQZLNuGRY3I2KiM6f6lX0Fva/xFc/VILRnjYF/9kmS0iMN1n0NeLd1Srx86GEoalVHakJpIwv514u4fEkc8S/eRtj4M+zx54ssTFNop9EsJhWB3NMKnDKUw069Sp5PXZilEY3hdS2643YX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Y5dlS+Rw; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-789d0c90cadso359425085a.3
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 10:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1710870248; x=1711475048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W3ZpiLCuEUZj1JXUW0QL1hAfKnbbS8ODi1ifZWkXGPg=;
        b=Y5dlS+Rw5vUfm0lLYP/HEuGQjWuVGkROKuoUIkQVKyUgq6pQVzTGfXBHc4Vmxdhafp
         ddzJ7UeP+Kp8X3Ej5TCzQkXQnI/ScS4CDPBkx5hcEEQA1Cu7FI0TstSLHcqopxD5baLd
         PwkeUJZvZfZJO/Ni/jhl8KdeZEDcCriBgs9ZUAl3WqHn0hkEN7mqJj+Zgwn0lFGTaBXn
         QS5oLmCJ4xRMnWdjlnaB6CXvJtdUtIkyikmJJQOoBHJSmw3RqfyAc2/zxrx/UysIXbkX
         ZcoWc42EUEWTx9TJ2box4NZyvP61Zmz16+8Re9o9bAm4MY/Rofu4dTh8o306RpvtEP+B
         zc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710870248; x=1711475048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3ZpiLCuEUZj1JXUW0QL1hAfKnbbS8ODi1ifZWkXGPg=;
        b=X8DTY9kXWw22hjA77TaqoiAYuacZX3Ta0Y4OHNwFL8vAm1QqHu5Z8Rr+qRI4NUapgH
         N4uaKBzLTfNzhyGO6tcKcYl0efNg7vr6sn++FEwBxIGGrLwGPcpqJrqikCNv4OzBx7eV
         Q9QsxBEjA1ckyL9WpbzYcNeYv4ldH3DhDkk6b61B5v1sjSflNc5S7ozyP4W2ckbuO6tw
         9I6i65sDfnmJqYyk6texFavEb+sbieQrt+SvWEWZ234qd/M37dBkJR+9To8G1O2qfjex
         8ao2CmgUhvQgGJu4LUra0mbGvX5TrOT1S9g6E7+huCJvVr7DN1LzjcXgiRZGRi3WdkuG
         YEpw==
X-Gm-Message-State: AOJu0Yy+ZWszXX326QIrutGmVFH1tuvo3Rommeu17TtYbvgf/pQxBbeS
	hsC9ezU+g7oLu/w0nV7xXTTAdlAPAF2L76oG49A0KDBHyiLf3UnXX3sipoJk+pc=
X-Google-Smtp-Source: AGHT+IHjSHiCqMHgvqlnnr8vKH8K+ZyIl6WAyz4lyCijFF6tNo25UYH6PA6oLjYCwMzJdhu6ZsNItw==
X-Received: by 2002:a05:620a:4044:b0:789:c797:16ff with SMTP id i4-20020a05620a404400b00789c79716ffmr4500180qko.60.1710870247809;
        Tue, 19 Mar 2024 10:44:07 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id dc33-20020a05620a522100b007885cd1c058sm5688529qkb.103.2024.03.19.10.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 10:44:07 -0700 (PDT)
Date: Tue, 19 Mar 2024 13:44:06 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 07/29] btrfs: btrfs_find_orphan_roots rename ret to ret2
 and err to ret
Message-ID: <20240319174406.GB2982591@perftesting>
References: <cover.1710857863.git.anand.jain@oracle.com>
 <a5b8d4ef4c88f3c6bb87c81e58a75e91af1053c8.1710857863.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5b8d4ef4c88f3c6bb87c81e58a75e91af1053c8.1710857863.git.anand.jain@oracle.com>

On Tue, Mar 19, 2024 at 08:25:15PM +0530, Anand Jain wrote:
> Variable err is the actual return value of this function, and variable ret
> is a helper variable for err. So, rename them to ret and ret2 respectively.
> 

This is just overkill, we don't ever need to hold both ret and ret2 in
consistent state, you can just to a straight conversion of err to ret and it'll
be fine.  Thanks,

Josef

