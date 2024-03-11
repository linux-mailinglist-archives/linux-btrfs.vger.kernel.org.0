Return-Path: <linux-btrfs+bounces-3166-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F26BD8779C8
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 03:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1D3EB20D0B
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 02:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DCE23A0;
	Mon, 11 Mar 2024 02:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="jCk0db+n"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A1210E3
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Mar 2024 02:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710123433; cv=none; b=HQGvamoB9GLGUzHfJczm/MSbrcqrUdd6BbBvkjtvSVQmNRF9H+aVUcKhx4bmHv5g5RUnBgbtzUtffmM4zOU5lHTHlPDRVUVByBRrX4zeiUvk7lK0SwkNu6coj3/p6N4+SX+khhuIL16ttcZrJpuLVLL3pwrDngEDCcxoHHs2nmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710123433; c=relaxed/simple;
	bh=1L7MoSZFuvPSNtlP8t+DsIgAFz3OYQfQmtdX/FZeVDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZbbD70lnA1r7CCGi7bchajr0jG0BMlvJaQ0KstGj7KObjdR6IaSjxeRHpgirokpta8dPGM64quSK/AtIymO11Akmgn5HrNYbEqYIg+0sCBsbXLJWMh//VNI7sF22GnaWV7TZ0bgvwinemeDkYOwyiJsDYUO4E5CWpXvnvQA0Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=jCk0db+n; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5e4613f2b56so2341863a12.1
        for <linux-btrfs@vger.kernel.org>; Sun, 10 Mar 2024 19:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1710123431; x=1710728231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P2HOPvTzIOfPgTuaGyDXCX6Oprhe2Q5xowyCchEBaBY=;
        b=jCk0db+nO/Lk+OXykEwsQIfoYn/mAi0EHmQXCu1T3dBwlf9+KTQiLrby5GBp93j7U7
         V5ghmYNvale5vaOcsnZ+1He+O8nnGePtL2AI9KIg8S++ZwY4GcGyJtBjqF6y7n8hL4sD
         j46+YkXWN7Dv4S2FZm/DzLh46ak9YXGD+5wmbWSDv54w8oWWDrNLs6RfrvlbBdOv9kg4
         5sc4C5KzOT89NoK6Y3b2z4gB397PO7ySMlN4Qmk9wXAxMlTfgceg4KFbcfsxr79qz1Zx
         rtEI2xQihYLAwHnQH6V5mtU2k1CinLV/rS4y+0Pdh0uVG84aHteeiyNLpTxFKUctBVSb
         6Otg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710123431; x=1710728231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2HOPvTzIOfPgTuaGyDXCX6Oprhe2Q5xowyCchEBaBY=;
        b=m2+7oUFCzAgFizn5k7/1QcTcB0cbCdXpbC5k9aN4B9gkd3dbRUNLoceF9JSzAorjfI
         i1XTwLkiM9htKb0RHfJmk7zJElQiU00muonvI9iXVhfNOgCRrmE1LN7FmblBalbQWRxJ
         TlVvvAYAL9Cj4IRiDzdt5+5IEjwYbw4RXB/a3KLQRHqpDkw8t1zsVKE/FP7UU5+2uxel
         +WGTFtupWmgE0Cspj2nQ+UbYIYvAivK5SUImNkGVQkSmPEUhKPFYRMJv9JVlBjrrqXSA
         +Ja4Y6Ub5i8z1YtSDCWOUN64amk8BtFS4Slqr+csF47UkHJNRd5vOJJFoK7wp3XmSMGs
         qPYA==
X-Forwarded-Encrypted: i=1; AJvYcCXszA3/pNVzx2u0K01oSVnMdttg0jIvYmy24Zme7oD81q8BXAfqC/R/fapDqtuyI0FNlUn8llUtOtCZbtn6LwYkfd+9FRhjLKpVhCk=
X-Gm-Message-State: AOJu0YxDZ+MH2Y4gXhXzaoETi2do6y4NOz/g7Ai60iPGFclZkIu93YvB
	fa5GqnXRH/svMNg03e0FINV+VVk69JefuI/fc9iB4QU10CeniV41FU0ASQoyVn8=
X-Google-Smtp-Source: AGHT+IEgtGW5AN8mnjwdibd+gLuySW0tEDIBlzlkkIrMs8fV0hgNTvd0J7PfU9RiDNuMx2cvGySV0Q==
X-Received: by 2002:a17:90a:f417:b0:299:a69:1f8b with SMTP id ch23-20020a17090af41700b002990a691f8bmr3199478pjb.23.1710123431284;
        Sun, 10 Mar 2024 19:17:11 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-47-118.pa.nsw.optusnet.com.au. [49.179.47.118])
        by smtp.gmail.com with ESMTPSA id p3-20020a17090a348300b0029bc1c931d9sm3752893pjb.51.2024.03.10.19.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 19:17:10 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rjVDw-000GCA-1X;
	Mon, 11 Mar 2024 13:17:08 +1100
Date: Mon, 11 Mar 2024 13:17:08 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Neal Gompa <neal@gompa.dev>, linux-fsdevel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2] statx: stx_subvol
Message-ID: <Ze5ppBOFpVm1jyb+@dread.disaster.area>
References: <20240308022914.196982-1-kent.overstreet@linux.dev>
 <CAEg-Je96OKs_LOXorNVj1a1=e+1f=-gw34v4VWNOmfKXc6PLSQ@mail.gmail.com>
 <i2oeask3rxxd5w4k7ikky6zddnr2qgflrmu52i7ah6n4e7va26@2qmghvmb732p>
 <CAEg-Je_URgYd6VJL5Pd=YDGQM=0T5tspfnTvgVTMG-Ec1fTt6g@mail.gmail.com>
 <2uk6u4w7dp4fnd3mrpoqybkiojgibjodgatrordacejlsxxmxz@wg5zymrst2td>
 <20240308165633.GO6184@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308165633.GO6184@frogsfrogsfrogs>

On Fri, Mar 08, 2024 at 08:56:33AM -0800, Darrick J. Wong wrote:
> Should the XFS data and rt volumes be reported with different stx_vol
> values?

No, because all the inodes are on the data volume and the same inode
can have data on the data volume or the rt volume. i.e. "data on rt,
truncate, clear rt, copy data back into data dev".  It's still the
same inode, and may have exactly the same data, so why should change
stx_vol and make it appear to userspace as being a different inode?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

