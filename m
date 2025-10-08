Return-Path: <linux-btrfs+bounces-17533-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 721F0BC5872
	for <lists+linux-btrfs@lfdr.de>; Wed, 08 Oct 2025 17:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C103D4F820E
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Oct 2025 15:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901092ECE87;
	Wed,  8 Oct 2025 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mI03c5Fy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01DC28C00D
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Oct 2025 15:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759936145; cv=none; b=u/khM23qlcFqjqe0xEnW1o2h0cnRN1la25f3RUWWratIF/ZYw+eW7rVz8wTbAq1DQnPAL46Fiy+Dk6Y6n6C3d4GuHJIqo9oQrTC2QFrfk0enYblC2+RJxpsSCjywWPIpDeuh9bsBUc21J2LJEdLDlz52KvOqrTkXaZbLDJcgueA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759936145; c=relaxed/simple;
	bh=1K+mZHhUUT08Buqc1WIo7B/dy9RfBBDC35AAmiVX12c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TzHBnkpNLPy++3sYg3Bl9ovzIcda+wheA8PsRA0pzpH7nqstOzFdzOHD/ZFnCvY2kxfPvXAY/M4l1FoXM6Jyrrxku/dP/CZAI9CxAVmSufjXSiq1fmHkdDEXsACY+T0FGANimubundx4l59j/oDQTePMNuYGZYnE/8viHqfMRtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mI03c5Fy; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42557c5cedcso30599f8f.0
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Oct 2025 08:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759936142; x=1760540942; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Lsv/v4r6+foGJWr+qrH8p2k9rjZsdGH+FPsXAlrkVQ=;
        b=mI03c5FyBkiUk2gVEx+fgak9+cVGldj/HtkrA540CoKE3m0m5NRX5kvSbwN80sGbAf
         KhvWqYI0G4Qax0E4sqGApnMAXK9MTQaV4BjDztbMPtt3dtdvby/pda4dPBbgitisniPC
         3qXXO2tQC5uufYxsSrnsCe1Iu4MR2NJCUj/sE/vPxci4lbxiBWDtvBD0H8iUajnYQOoA
         wshAese0+/HFGjHL9kiBi6MV9BkRXKR7WfJGNQ3dgjsflrOxNCa5eRvNFDPfcMb0Jb97
         UsOdPYWkSmSwev9urvcwEQrbTAncqCr0k8nELaAq9ozoUB4gSM2WwOAW/2g3EAT57235
         Jt2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759936142; x=1760540942;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Lsv/v4r6+foGJWr+qrH8p2k9rjZsdGH+FPsXAlrkVQ=;
        b=J+JJiLOoUtv2rGkgk73GPGeFrCom4sCq4NMblIV/SVpOFMTFsSpSxoze/UUBPptQR2
         neK6h7UyMzToeeB6clNsYiOtWhpA5PrYqDRkWPuO0+mlo8U4a4BZ//ipG/nrr/TDebT6
         VhycXT5gLKpYeYNzQ81I2RHNvYXnfkk/mt9bbd28IrHrb6meI7AHXKxfPHx4HRWvpkXG
         IgcBpC2VZcKBARUHkafpZXHZXb3nRN4UNhvI1sQ6IZwbIoLb48mAIax+sCfrR5l74J80
         ePlBgu8obifebBxVQniz+1xRKVj5O3MERR/fBK7ZbMpcFmM6C/E2ckuosR5HLofjaLI7
         EmqA==
X-Forwarded-Encrypted: i=1; AJvYcCUlJo7MsqCWTMlCdD5oqXD6vlS182gCxUPZi/eBSG09FpUA72/V7aUwMcjhoepCR+U7oUYK/hw2fJcxng==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2EG2Jk4I+dMAhpI7AK4XN6TzAP2RaTLQ+LqCe1164r4W+2/OO
	h18KE7jj/P7WyiRi0aTcNW95Fawvgj1zTf3cciRRnyW7djkOxZGR3YR38iLdz5YL+qE=
X-Gm-Gg: ASbGncv8VOuVcjdPFozzC0ctHtpQoLIm62gmIRfIPVz7mgP9TFGDUURTvKVzbLQ3o4p
	9kHHxK9ZqcLJH452aonjFdD+gUvV8UMyqIg1lbQ4vbkVLHz465XateAnN65g4a5xCj4zgxghuxK
	GaZnNjO6XVKhbVhEELAILo3xNDNo3hcEFr8CH+IHFYk0NJBTfnFOvgDjUyMxlvdAAYK4pnY8Jr3
	DgmmPr5Mp2X/gRtKpVTUql3jzskPKrh4VmiizH5arOHX25oDRuUCS8FAkecotApBqxs2XeYwfJZ
	1b6mi4RAvrYg8ZGLC4IKc0JcjJG+Rmgb80dUsx5PJbobztPAvJjLI12waXdjVbR7e4ErewOduzn
	btYO9UrLfBeLotkHMxob1L08mBiYNseuBJyh9b4qH1Q6beu8lnc/Ojsyt
X-Google-Smtp-Source: AGHT+IHYVsHAe0/w87MtOEqTgFE1mT/tsUBsMdlVHgFGbcOBnMrbBTOagFPDRArfyaH2aIEMb5EBvA==
X-Received: by 2002:a05:6000:2c0c:b0:3f1:5bdd:190a with SMTP id ffacd0b85a97d-42666ac3a16mr2508780f8f.3.1759936142001;
        Wed, 08 Oct 2025 08:09:02 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4255d869d50sm31248166f8f.0.2025.10.08.08.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 08:09:01 -0700 (PDT)
Date: Wed, 8 Oct 2025 18:08:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qu Wenruo <wqu@suse.com>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] btrfs: tree-checker: Fix bounds check in check_inode_extref()
Message-ID: <aOZ-inc8o7T63QHT@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The parentheses for the unlikely() annotation were put in the wrong
place so it means that the condition is basically never true and the
bounds checking is skipped.

Fixes: aab9458b9f00 ("btrfs: tree-checker: add inode extref checks")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/btrfs/tree-checker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index ca30b15ea452..c10b4c242acf 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1797,7 +1797,7 @@ static int check_inode_extref(struct extent_buffer *leaf,
 		struct btrfs_inode_extref *extref = (struct btrfs_inode_extref *)ptr;
 		u16 namelen;
 
-		if (unlikely(ptr + sizeof(*extref)) > end) {
+		if (unlikely(ptr + sizeof(*extref) > end)) {
 			inode_ref_err(leaf, slot,
 			"inode extref overflow, ptr %lu end %lu inode_extref size %zu",
 				      ptr, end, sizeof(*extref));
-- 
2.51.0


