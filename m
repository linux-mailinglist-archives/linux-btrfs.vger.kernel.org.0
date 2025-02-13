Return-Path: <linux-btrfs+bounces-11442-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B713A338E1
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 08:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ACC9166534
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 07:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774E820A5C6;
	Thu, 13 Feb 2025 07:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D/UG8gp9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9987D207A05
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2025 07:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739431925; cv=none; b=Pu2DyMym48yWb7E+k3butCaJ7nY+PUrKSecbpRqRgfcpUSX08ZWXM3PSZbytzq2IjFRuxH6aC8dXFfvJ6tlWT9aLdD/vqfMaz0e1m8ChB1oNgV5R1DBl3biAI+nBbVtrGLmu6f/IDr9tu3Jxl0ez8wPqppMNuhUC+SX2qxdGP7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739431925; c=relaxed/simple;
	bh=0cGuAL7vEQCYgN6VvH/CCx8pk3I1YWiE1lZ94k5HKpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kNfbnOMOpn922/QadXhFj3TuOKHd3ZKOPT/EPZs4xHYffl9YJGMsWm+H02yM61VxU6tw9mwbLrvBpobnCCehhi1ns0DpALF22IrMVFSVBXLd+zXMcC5rr7Y1Fb/Ggwk2iBcSz5t7OZJj0fO1xzirjHdQQu4CSlSU6G6K/h1mCv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D/UG8gp9; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab7e80c4b55so126586666b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2025 23:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739431922; x=1740036722; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lMinCuhGrs7sl9mj3/RPDKgpgb22aOAg5wvl1A1x0/Y=;
        b=D/UG8gp9rtl6fu/2kWaKcW/lCaqwAGlpe8YKPeF5u77YKQhd+emtS4v8X86Z8qlW6G
         5TGI6VPOTX0K4UthVQwsm0T/4yFXK/XGgQCSu5xvJOKDV4Lnq44P+wpCmZwPabaoOfSa
         rMbvs8ysZQyS7aBqLe34mbgmiJ1ppfTuWowURoFbqcqMt7wklNYpitNGVZTPPmdhszir
         7opHYuLyA6Yckrru79ru9QGhGm+n4Jd2T/09RpIhOCVwGVpZBudJ9LlPxKSIvRLyfNHE
         I31FFyXBtkA47Xw3lZCjMOWj3TCSxmTQ2Z1wa7CzkiweP8+wSnkXukPz0EQx82pqUAlk
         jZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739431922; x=1740036722;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lMinCuhGrs7sl9mj3/RPDKgpgb22aOAg5wvl1A1x0/Y=;
        b=ILTCKqB5BJufM8/+1++2GXkl87C6nPTO01ehRdRFyyxWSlU3ov8J9vRhyHI4xuhNHv
         ih8QOVEzgBKqp/kqMChR7N3ayUIFZ1kFu8OvxcGvV99IhS4l4RqM+RJ4Gc72iz/wtg5b
         HAH/eWpfWjGwdOtM6l6yMRO4qjn+1yX0OYKdrEADMi/aIGJeKnvoa4WJjAwhdjPOVmez
         LHOZkWs0tZ/0Lxjds/jfLZjj6dYqH4Ft52QAR3tq2keLGoimY010qkRVLmWIWFW71UwW
         Jy/iy+nVSHWRl9Rvv3+Umnga7ihJtktTUGMZLbdJVpHg9m3M29ux3B4id9OiwiBhq6he
         NM/A==
X-Gm-Message-State: AOJu0YzigFz6KRUHrkOVlnQScOKc4Dx5uhYfG5u/d2IbiBVbBmpQoLo0
	2QlEFbnEjA6KrBpKoqahjIx+rEnnnyEqVCMVyhYDwZX2r29/Dwwolq4vfeXORSs=
X-Gm-Gg: ASbGncvJGyz1N+OoNk2dUKCNfcbM+AclpNkSjoXnrmGQzA3/IVHAL+s/88K0v3DMiBJ
	9QBG9q2jx56knzVKDN4tjhkYKDK/VUVKtAheGzFceJznIKGDyLoeOlYLS9GFLSc/PG1XBodXu8N
	KHjOFRh6+pNTe1LPI+0IZdy2qlINTTwY+sFBGiNHxMINBCsL3GzRjqir0e5ypnjv3Zl+MKu2UR+
	qda4e1+dYEi/IuYyabdkjoHZnNtU7TI1ARBlcHMBlxhbI6yDPGsybeqOEWXBSnIbppvDUjTyClN
	iJTOAMaL7s0K0n9pmDR3
X-Google-Smtp-Source: AGHT+IGlYOy7yS5LFGahOJl0U7L0+sdrZCcFD8KSM/jjarUBcApbgmw9GynUD4eml/inj9fW4xbNTg==
X-Received: by 2002:a17:907:7e84:b0:ab7:c3d4:2551 with SMTP id a640c23a62f3a-aba4ebcf29emr189672466b.33.1739431921834;
        Wed, 12 Feb 2025 23:32:01 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-aba533763b4sm72184566b.123.2025.02.12.23.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 23:32:01 -0800 (PST)
Date: Thu, 13 Feb 2025 10:31:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: [bug report] btrfs: remove btrfs_fs_info::sectors_per_page
Message-ID: <555b6669-5b30-4f76-9073-23f44c563aa3@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Qu Wenruo,

This is a semi-automatic email about new static checker warnings.

Commit 8685d7a75e5f ("btrfs: remove btrfs_fs_info::sectors_per_page")
from Jan 24, 2025, leads to the following Smatch complaint:

    fs/btrfs/subpage.c:743 btrfs_folio_set_lock()
    warn: variable dereferenced before check 'fs_info' (see line 739)

fs/btrfs/subpage.c
   738		unsigned int nbits;
   739		const unsigned int blocks_per_folio = btrfs_blocks_per_folio(fs_info, folio);
                                                                             ^^^^^^^
The patch adds a dereference

   740		int ret;
   741	
   742		ASSERT(folio_test_locked(folio));
   743		if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, folio->mapping))
                             ^^^^^^^^
Checked too late.

   744			return;
   745	

regards,
dan carpenter

