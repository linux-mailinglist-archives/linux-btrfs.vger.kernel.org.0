Return-Path: <linux-btrfs+bounces-17412-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E56A4BB7036
	for <lists+linux-btrfs@lfdr.de>; Fri, 03 Oct 2025 15:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFB893BA4E3
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Oct 2025 13:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E01A2F0C5C;
	Fri,  3 Oct 2025 13:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6EeDXA2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED07B2F2D
	for <linux-btrfs@vger.kernel.org>; Fri,  3 Oct 2025 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759497949; cv=none; b=PqUxNSTNX0Pkh46UjOCpz7MHgxPSJjDu5arbghGqGZ+GASrICWeDtY94RJMyZkR0CrP4yjUyGEeKgT099jnQwJ41WQcuKZ7uM/vvWnGfvwiY7caQR7HaiLViJml4BikcWkd8isyZJ72PpHtSFW+t8svwX2RfQeGVN0q/T9JECGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759497949; c=relaxed/simple;
	bh=lXoinWuk7LcPByoZgbYxrsiJlpNjzWGndm6j+rSNBHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQdkL7elOir0DtLHumLQkjZzIXvsMWmOR8IOXSpEBdMt0V3sY462nRN66uS7wFBJ5UxVxwo7qD0jpsJNFmv1Vjm5pFZRwsIuTBji3P+cLFkOAka12G79XieRzZnzw2veIdeiW/wVc1tfJvDyMrM/5apeQtZEyiyv2gg40BMAhV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6EeDXA2; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-27eceb38eb1so21935195ad.3
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Oct 2025 06:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759497947; x=1760102747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6iGJQ9sNQ8HMQ2w/YdZJV7Y46XjQibOSjc27097Uy4c=;
        b=P6EeDXA2BNK5kbmVJQs/wGfNf7LUh/MEQ74EtjjOJCOLwi3wPwmr2y1cdjeD702Rg3
         BPIWhbY6cQ+PA+YaZ0Pe9msRr0UZxy3TyL30HSSbJkKccZl8yOPx3M5/x1kLg1SyeKuJ
         PnNfhSDkI4AtOWtuTnkn1bXzjuB/inkhdgpg/kftoPcWwq0qNYo788pL/WUOH8LeaC/I
         hPHhduZn+cGYHWlJVS/by0gGUScjGafr/PURauIlvaE8SfMMy8OBaBirkjI0AvfD/622
         69yi2ckn0jBFkkHS0MeJNkx8KK185ieTtao5px+iXvDB1wZ8kGFbKJnm4FtWo0INFTYf
         BmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759497947; x=1760102747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6iGJQ9sNQ8HMQ2w/YdZJV7Y46XjQibOSjc27097Uy4c=;
        b=UaH4KVaDdvk4I4BudJ8To8a+qxz7JpKpmfRg1+U68dqrUoED0hX1d0GnWwuUZg2V8p
         TaCpi1U0lVm+zMYZfOYf16HXbXMSLuHCgsuMD0TjOA4qge6JXEC81hPdDzZCeigdb0bt
         cfioG96N2lc1PYXBxSNtHSoIIP4iXZHXj3Lvw0T8/LO0N5LBRcwUJt3JGTw/h+6gPTZx
         /TPp88+28qGj4zW+LdDkl4R5GyNuMnQymBMFbNgRTk8NA7Byp9FKUEX2rnAhuEhO9XAr
         C3gWgHlL2NoGwBNTV8bqO+pn1QtLTBHC3ufrD/AD9JbNz7soGns31DMUKCcqSsKOVkQw
         4+Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUvEeeYi/ZD12NNZWw68Fao9Q+d77l8QCKu/MOKI1fJW8G1CTArR6q+sxFLxbt5L+oybuhEuIdqrLdd4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqTgSKY8CsB+k+r+wMOqie8MSnfEd5BZF0RSZbBLW3WVNmsDIw
	aIrf581eJjskm9xCddDU7rhQQ1g6HcvUmFknH9DRkr6aZgi0K/nVnXAM
X-Gm-Gg: ASbGncsFdQX3qJYh47ncNM1OCC9tKrXeWdqJFdcKY3Zlv4Vl1afHRHq/EDPpAHsgNNo
	+fe666JTjTf4/szPtdWK9u2AJOwfopkU1aNfW+csR1twhjtYSE4ivPKxdZMYDkBfQIAUVobqXLC
	6IajKjCKBUedjkQ1cXmQOGGcRSWRdTYScjemntUPRyM2Lp7MOjL0Le4HFlVyWTZKQD3qPbxrS5K
	n4lblrqSXPZURRRoStGDaO7sbhtcsIf8MPlQFLTGNDW8DeM/meUWHu0kb0s6A3+d4wT13ePSIBF
	hu29zanx8lyEiWENXGtjnahEDbumT1yKrJpucmlkeXSYoqU0n6DVmkmkGmL/CqNDOxungIp0I/U
	R964oKGzhpqjFaO2Orj9D2jQp8+AYlkG58EQvb5DHk0eo1eTW//FBi/4uQXflmgIBWBUTJNc2BW
	aDNwTjnV/rTw==
X-Google-Smtp-Source: AGHT+IHiIZWyVFyajM0ujPkWk6tstsfUZUxnpu86ptRRwqj75xBIwN6itlGKR9miAD3w9z4iACTwwQ==
X-Received: by 2002:a17:903:3c63:b0:28e:7dd9:5c29 with SMTP id d9443c01a7336-28e9a650f81mr31775805ad.51.1759497947183;
        Fri, 03 Oct 2025 06:25:47 -0700 (PDT)
Received: from fedora ([45.116.149.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d5e36sm51069855ad.114.2025.10.03.06.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 06:25:46 -0700 (PDT)
From: rtapadia730@gmail.com
To: fdmanana@kernel.org
Cc: clm@fb.com,
	david.hunter.linux@gmail.com,
	dsterba@suse.com,
	fdmanana@suse.com,
	khalid@kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rtapadia730@gmail.com,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] btrfs: push memalloc_nofs_save/restore() out of alloc_bitmap()
Date: Fri,  3 Oct 2025 18:55:35 +0530
Message-ID: <20251003132535.42760-1-rtapadia730@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAL3q7H6BQpWAtfkA+tnW-fBkdqSDb4udAeJvdgHfKSKfpYWAOA@mail.gmail.com>
References: <CAL3q7H6BQpWAtfkA+tnW-fBkdqSDb4udAeJvdgHfKSKfpYWAOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for the review and explanation.


> We test btrfs with fstests. The sanity tests aren't enough, they are
> mostly to test internal functions.
> Please don't declare variables in the middle of the code.
> We always declare variables at the top of the current scope.
Okay I will remember this for future patches.


> Just fix the comment, removing the TODO and mention that the reason we
> can't recurse is because we are holding a transaction handle open - it
> doesn't matter if we are in critical section of a transaction commit
> or not - all it matters is that we are holding a transaction handle
> open, so a GFP_KERNEL allocation results in a deadlock if it recurses
> to the filesystem to commit the transaction.
I'll send a v2 patch that just removes TODO and update the comment for 
clearity.

