Return-Path: <linux-btrfs+bounces-17245-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539A0BA8658
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 10:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 087C03A5952
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 08:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D4926FA6F;
	Mon, 29 Sep 2025 08:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iB3Eq4ng"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5967A22F77E
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 08:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759134583; cv=none; b=e3UpbhF/3nLioL6D3zHFEAQccZDDJOmFKy0r1nxWu2jFEe9zbJtApUVOhI9nneKTPHNRX+odwEZWY3Obn4Qdu/XL8ZiuGBf+aBJi+9d2pQuxxjJgQ2Q8gi2Vebzj4QBertlYE6obSKAA7IF9ONADDnDzF21rWW1prVO4G/8CBx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759134583; c=relaxed/simple;
	bh=ozbmj6iNKsra64J5xYd3YOK/CyszWnGJEArcMob1UqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=VL9HBurntwD0OOPIqcGBPtDrf219e5DKA9+lcI3Gd3FUVtYK49tH/7FQtKO61PuPUrJTIRCYN71YIv3dsN3b5H6BAx0y1Fd2GVg72rDSCM9xpeYNH5xitdosGv4UMKoHrUQs/svkHu9fD0rGbyQuKvl1AmEbVR+sZMwUAlFtNa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iB3Eq4ng; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2699ef1b4e3so9529105ad.0
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 01:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759134581; x=1759739381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QX/9d6UXcgTIRZz1+b4Q0dTZyOkYPGVBWZFd71UXT10=;
        b=iB3Eq4ngH2Zz6iQejIrlCRKmjw2YfmH8EhGpJWzAgWDWglGfqzADeCvsgh3NTLxWOp
         RsIrVNgw7AXxEmQbenz2yRJLXUYxrQQG39DSjNOX8mK7Y/vSLT3t4WtJpjee1wd2tnSk
         HN/X1d5dNXkToTkirEFXnS33rMgytpcn1FRKic9gAugPl+qjIUH89p8VpraLL73y6MMD
         C99B/4SrhuhMT+VRnfzuSPQn9yR3nhPOfE3guUxI4/ABXc6G7M0ggKHTEiJxwkjtaHJM
         P9EsT9TewbbbstPiPTDDO5pACkf3QW3fMWYtPs4+ePuag+sCP0DcEffNr9cUpYd1FIlc
         JOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759134581; x=1759739381;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QX/9d6UXcgTIRZz1+b4Q0dTZyOkYPGVBWZFd71UXT10=;
        b=rYp08c76dAvSynbrDbtXsn6P3TrZcwUSo1r3SH+4HWEmK8xUFsZqmUqP7k3nJNfqSz
         RnxcwkBYD3z8Z65OBsIHgFE9h6zQdT9uLNHYBup+TsX3IuAfIxGEexPFgjtaO2rnPsYX
         CEU3JZKKjFiFD0DSqfaKqqHmXa3Eg/sxFBKOEIfkqxWAxMxswu46ugUVA5WAzW8YEcCz
         SKwb1ZeRG223M7Jo4oP0W3TlO47S0V8flj8N83XOf7NMH8WgKaqtyiBLatcWx6W6ffm3
         iUWIhrOE6ES6TfvrzimOY4SZsuuL3LJT3ZRNNUEEuD2oKneTPGuqzKyC3K/0iatmz8VD
         gUJA==
X-Gm-Message-State: AOJu0YxEwwvs//Bc7qJSICVQEQWF6mom0rFL37NrEymqvYDrMIzFsb2z
	93HIIwA/2HMTjkH/fo5llGD6tx6oXmkpeRCGnDytddo2GTf3yqOSSHoaa7YFuh9OOpp0kA==
X-Gm-Gg: ASbGncvqRvc0BMMuGekoHtnkVCGENMtlAZXnIz1eReNvzI8Q6ZwsQS0jigNfbm3vfBd
	xZjA7Tr4g/NuJheqtFe6of1/ili7ivcefApFTyMDA8HRJD2sGd0YBIHLIWS5qiBHDHRnm5T+lEa
	l4/gVvPcbJYhyOKgyHTJU3WVsBbVSn+AnIeWwzJ+s+Hd42Yn7Zrrrj9iLOmnHjp3Ic7+NRnEYdV
	0F7UI9WniBhZj/sqGVRT+U+m+LkcN3yrgGeAKqgpgbWHxkuE/gHKJHyfSnzqYpbXfSFFwtA87h3
	8DZVDTcqp0W+uzPH2PpkTb9FtegcPn7Ihlw/Z3ewUzmYsjCcluU/00BaUNlr5MRINBI2i6sgx1N
	KCmjvu6XH7qjPQuj3byAVfaM65MHQ9szsrF4/RCqBEpuoaRFlt6k=
X-Google-Smtp-Source: AGHT+IHqTWyaMPXMQ+4n4Ld4f3r280+OCfpKJ+E70OOQ+Ob6q05XMU5dIlKdHXkyhSXSMSfWjCPAWA==
X-Received: by 2002:a17:902:e886:b0:274:944f:9d84 with SMTP id d9443c01a7336-27ed4a66e4bmr105787165ad.11.1759134581530;
        Mon, 29 Sep 2025 01:29:41 -0700 (PDT)
Received: from saltykitkat.localnet ([154.3.38.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d6523sm123574385ad.11.2025.09.29.01.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 01:29:41 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: wqu@suse.com
Cc: linux-btrfs@vger.kernel.org
Subject:
 Re: [PATCH] btrfs: reorganize error handling in btrfs_tree_mod_log_insert_key
Date: Mon, 29 Sep 2025 16:25:44 +0800
Message-ID: <2394265.ElGaqSPkdT@saltykitkat>
In-Reply-To: <eb37da47-2a32-4ff1-9c63-b97a69cc019d@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

> > -	ret = tree_mod_log_insert(eb->fs_info, tm);
> > -out_unlock:
> > +	/* Deal with allocation error. */
> > +	if (tm)
> > +		ret = tree_mod_log_insert(eb->fs_info, tm);
> 
> Sorry, I don't think this is really that better.
> 
> In fact I'm wondering why we don't delay the allocation after
> tree_mod_dont_log()?

That's what I want to do at first. However, after looking further into 
tree_mod_dont_log(), I found that it trys to get the tree_mod_log_lock. I'm 
not sure if it's better or worse to do the allocation things after getting the 
lock.

> 
> That would be way more straightforward.
> 
> Thanks,
> Qu
> 
> > +	else
> > +		ret = -ENOMEM;
> > +
> > 

Thanks,
Sun YangKai





