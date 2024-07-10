Return-Path: <linux-btrfs+bounces-6340-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0866F92D12E
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2024 13:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B29A11F24FB4
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2024 11:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809AE19069C;
	Wed, 10 Jul 2024 11:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b="ypZILg8j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.sws.net.au (smtp.sws.net.au [144.76.186.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333D3190053
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jul 2024 11:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.186.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720612780; cv=none; b=tHv2S+1mDgd7iaDM+NUND+5FLePRy1tUPqWGR0WE193WwI/KKX8nqAlYHoy3Rbpd+YDus6zERNYR9zQ3tXdPlfnzd8EagNfmRGEF2mzbtcrPfRQA4sv6WmMF/RffcNqyS3WQZWEve14KZV9sq5MUTRdiDtE8Me/0vI58fJ8wtaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720612780; c=relaxed/simple;
	bh=dRoNf7HL8jCWVDDxODh/1IPWTQZTsSGdlFjcIkY/PmQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O8KwihLgZJ4Q854q3K9Wg4YqaLGplUv9uGKVvlrpeUrHNSeL7eB4e7ajXY9NlAeJowkarlxkjnikOFmlDuaFl9KHWuTD48IGc/6X+lXVqEzP3DKELY0x7EF/oHjKsRe+LVDKoyoU/clKmdK5wrrlo9vuIuEr8vgk2jhyQidPibc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au; spf=pass smtp.mailfrom=coker.com.au; dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b=ypZILg8j; arc=none smtp.client-ip=144.76.186.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coker.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coker.com.au;
	s=2008; t=1720612340;
	bh=xg9ZH1KNvSjxsr1MaVLG1CxvPGnpLUHjNv7qfwY8+WA=; l=849;
	h=From:To:Subject:Date:From;
	b=ypZILg8jCwgtLQO1beboVX5vRnzXjPeJkD2lDUBVNXqLPkardS8aQ9QLrLFJxmOPE
	 5B5EfmsaqmrBAkCK+ZpntYMQt4byNGvM6Klr2rBLZ0vD/kmaCEHDStdKiPOuI2jCIf
	 gSUDif0Cj9vwdmsy3uthRZeSbsr05ryrsZH8lJWw=
Received: from liv.coker.com.au (unknown [IPv6:2001:4479:4503:b300:b469:455c:f0c5:f241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: russell@coker.com.au)
	by smtp.sws.net.au (Postfix) with ESMTPSA id 3C806FC4D
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jul 2024 21:52:18 +1000 (AEST)
From: Russell Coker <russell@coker.com.au>
To: linux-btrfs@vger.kernel.org
Subject: btrfs-progs: btrfs dev usa as non-root is wrong and should just abort
Date: Wed, 10 Jul 2024 21:52:14 +1000
Message-ID: <2159193.PIDvDuAF1L@cupcakke>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Below is the difference between running btrfs dev usa as root and non-root on 
a laptop with kernel 6.8.12-amd64.  When run as non-root it gets everything 
wrong and in my tests I have never been able to see it give nay accurate data 
as non-root.  I think it should just abort with an error in that situation, 
there's no point in giving a wrong answer.

# btrfs dev usa /
/dev/mapper/root, ID: 1
   Device size:           476.37GiB
   Device slack:            1.50KiB
   Data,single:           216.01GiB
   Metadata,DUP:            6.00GiB
   System,DUP:             64.00MiB
   Unallocated:           254.29GiB

$ btrfs dev usa /
WARNING: cannot read detailed chunk info, per-device usage will not be shown, 
run as root
/dev/mapper/root, ID: 1
   Device size:           952.73MiB
   Device slack:           16.00EiB
   Unallocated:           476.37GiB

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/




