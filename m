Return-Path: <linux-btrfs+bounces-16144-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 297C4B2B6A3
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Aug 2025 04:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF9517A3A2
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Aug 2025 02:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F3E2853ED;
	Tue, 19 Aug 2025 02:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMxmfkAK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05210189F20
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Aug 2025 02:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755569034; cv=none; b=h/y7H0mSJmymOYvuyMvY7XnyB8glPSYw1OUt6Dd7B47Xg89f6G4A/1mozlIRLQrDRXQuLR4nN1ReqgamSz+nHW2jCHGdD32pUfPyvCoz9SE6bZZw53cLYkwpxIZm3FBJG0GZmWBSG0dChwxzK5p+VtQ1L+QcXjR+PF1TsIt4Xuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755569034; c=relaxed/simple;
	bh=H0HuQKiCA16aq0OK8AK/eWTkctLKD+Gd8IXcGbLD/n4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MEZxKX7CFE+xZ4DqpDfz/QhRB9e667vlK7LxAlFeR/sLxISrXZrJgQj8CtPoSZqb8DizLOmMuIJqrPumPFM+79Lr9dlZJpvWbyxfUoK5xlLDx1i+e443JbiOSNnfweVQRcBbVZyCavAqLjGfFgpQHQM8vHu0lyWnAqFEc9iPOpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMxmfkAK; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2445806dc89so6886325ad.1
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Aug 2025 19:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755569032; x=1756173832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :reply-to:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=baW9r0pxbpLC4zS0RZ1pxBDw0l+6mRvugIDAiMmUIO4=;
        b=DMxmfkAK1vl6d54vp6g9pfWjq+X0RuvQp3OKAjNlcyd4OF8Dyz1CA/hfm2eKqy4I6+
         8OAShkwZg85XPKcmEE1VtJ9euTiJEy4zMk+BbopZQuWtbeS4Mz7trWJhdBXnCg9iufC8
         XOjrX+0T8aHafJ4suvmXjYdGIAmi6WdtddeAkw82Rw/Nd9PRGRMOmiyUPtHTPR7O5dFr
         BCb5bjzHD03l6F50WFgpM9N6nrzk9T6yER0kJOK8ZOlvOYA1KY92xj9fbLTFs+YeLhfc
         BojSESNtYvM3+ioeacCxjhnLvc4CKo7QTzO3N8hlLv3obbES6p37PvmZTuwvfntuCWoS
         xP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755569032; x=1756173832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :reply-to:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baW9r0pxbpLC4zS0RZ1pxBDw0l+6mRvugIDAiMmUIO4=;
        b=uW0XOagcPy6lpMvRA9JgK8ypmMqeN1AJ1I2fHEqsajo6ymY46uT+IG/qqlFcJk230m
         mFGI0GXLlSN3nYSiBVXYHvNYN2YqrDnhNU1r36qwHiuTQA0ojFc0xtdt3Dzf1pI9tTl9
         q/sRhVjhy/ly2j0T5SAX5dZvyGka74doFnLGslsQkCv1G0xh8T7RLSokR1T5LHR0ZbLo
         tPtznb/OC43eYSM2j6lP7YESPJ0bQP2dXjtuA0mlRAf4cMxpVdMfFzolY+gqiRcTGJW6
         hpZzz31wC6A5YEbgEh+aMLH+pIEsnyCzinpOljKeNWnr4kvvYOy0H4pQgBbUKHbiFUTJ
         SJCQ==
X-Gm-Message-State: AOJu0Yyojo7sAnqdXy7KM7WpyYG3y3QFv5nrh7HHOEOFYW7M3uVMvl6G
	sSHM7X0r5n//ieF/6bbd0gmWKtotMrkfXuj9jZz1q8GMJ1mvSGY145wLkQ4SCkzv
X-Gm-Gg: ASbGncsKS/04YPcB23wtnu50ZnMTHxkuxP1yI39ez2qJxiELRpsukX+udGmpfjtHzk5
	jaK0MLzUCOeBx/tIQq+WjiGM/zvWWxpPHHzmJzVpDhdgfemRsxG4TIHZDXGPF62WgammwNss+p8
	sxA9nHRmJpBiLdWTgRWsFvyoDrIW4VahM3l4J5Lkt8tMnQQXP76fCqrEsbp58uz+HjaFum2HP5f
	FwRTkL+vGpRu1JmFkjxgLOl22znRnW3avjpbJ2zCOBA6Ih+sWHXOLcxPWGUj9w2oHgJJ0A4mGqs
	9S8b4WK9IDKKlumNiHprHDGNSY8KEjucIy7XhaoMJ10S0blgRvDoL6liZfzN10zs5xejC92ATSJ
	woXyX43EkN7WEYZRGKypO5gg1ooCR2NHSetvNAuXH709iy6SpHdg1uRs=
X-Google-Smtp-Source: AGHT+IG1N/xwVIjjRjYV1eAqIb7rTSF3wq2WVpFzHtwK/4jm/1KGboHAdYHNx01NzT5aQWOPmCjR6A==
X-Received: by 2002:a17:902:eccf:b0:240:3e72:ef98 with SMTP id d9443c01a7336-245e05d0c1dmr5108765ad.10.1755569032099;
        Mon, 18 Aug 2025 19:03:52 -0700 (PDT)
Received: from saltykitkat.localnet ([156.246.92.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d548e59sm93087125ad.122.2025.08.18.19.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 19:03:51 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: dsterba@suse.cz
Reply-To: 20250818171047.GP22430@twin.jikos.cz
Cc: linux-btrfs@vger.kernel.org
Subject: Re: Remaining BTRFS_PATH_AUTO_FREE work
Date: Tue, 19 Aug 2025 10:03:45 +0800
Message-ID: <6181995.lOV4Wx5bFT@saltykitkat>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

There's no such pattern in files beginning with p, and files beginning with z 
has been converted. So files beginning with [r-x] need this work. I'm doing 
this on files beginning with r.

BTW, should we also do this for files in the test dir?



