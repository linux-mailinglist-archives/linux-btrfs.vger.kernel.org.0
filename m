Return-Path: <linux-btrfs+bounces-5264-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F998CDA02
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 20:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B76ED1C21515
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 18:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B7920DF7;
	Thu, 23 May 2024 18:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENBfeCHl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08614F602
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 18:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716489172; cv=none; b=Oc9GzWeGwO/VFDJhOCwGjG6z1nJnIib5To6nic4Egz1toBQSbuWDH/3clemwuwdigffIIzfJkIe/iuQD5VFJmo39iXVUjSdSMedWdRCCF7AIiMpR1M4VH3QNmZvsDxaW5euqmRbQlfy5ezS30vBgPFvB2t8nP6+xQhlwKmt96qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716489172; c=relaxed/simple;
	bh=R1jjHa0/3OCLFAXE2z6WiDsp2fCn6r1ShAsltft/eBo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=l+E3QmXtNPZ7bqGF46wQVZBPt9vWC5KKmUi+Hdn2soWhiwEylPzIjqLg7+VDag2vFCfQc5tGh4S1O4cTU7TNcqeMel5h09r/hikPWFeVJrkYrUaF5wI7jSqfX3v1rs5YFl4pHh+GauPVLmUI3QCtuR5KV0uSa7E4ENAUqNnYj1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENBfeCHl; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-627dfbcf42aso23949137b3.1
        for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 11:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716489169; x=1717093969; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R1jjHa0/3OCLFAXE2z6WiDsp2fCn6r1ShAsltft/eBo=;
        b=ENBfeCHl2Z5AWpLixE+kqtKZNQei//s1hPJD7fkbnxlc7iuXVAiVumQKRhwoKuOb0b
         srPGw0YC7yjKIByk1IvFbP9Iu/KKjVtO6ZXuSx7LCa4evn7KYAHAqTlh8Os+DHga/ewd
         XAG9KtyAwPsScBtOtw9VBIsQFxB/wxfNVtI2ILIDXFDI7caRvhnILcfdpWBiSPrIaKST
         RZi8tXYYlnQz3O2tavVRs6nlTipDvssXp7NnplM/lIyxoHdbMl2cBhxZf/4X/HtbP86W
         GgX/m3T6c6nHaUx/RcdM+fNJz2xjcmSx0EtYRfV1TmeKT5qiUvd0wfie8jX0vw1vWUSM
         xY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716489169; x=1717093969;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R1jjHa0/3OCLFAXE2z6WiDsp2fCn6r1ShAsltft/eBo=;
        b=A8+XyNGRooTOKpX0Y23q99DQzibDDoNRJx/aA02l1qmq/NgkuwlMHi2FqiEXwgq8PS
         RmXkrt59L/z3a1OdRPqQ7pahMo8+exEvhcdwmdL6G19Rtve/mYokyVxH+jxzm1A3g1tu
         UCmN6jl2mp1c78WpewcAvMZVgVeIi+sR2O6qRd4rEtt35qPC+29yHJva85hxeOW4gd8S
         z95SHJi7T4oYxN764KYKGDm4loCM9m1OkT1adqCwT9xQnd6uAKZnqw6JN3q6FOOnDd0Z
         WfYzLkDShnuQLNVUjvTx4sEvFrY25srw/f+gNUT5eddOSoPFMD7DfupPp0CRUcYLCEMP
         tB2g==
X-Gm-Message-State: AOJu0YxmHacj8PbJvnqAj9pfgC+JIq1yzDRv456y2QUmpR4Wr6DUaNo9
	sGFWj18X/verxEG2GxwwR5MOZ+fnZLoplPHtOA0MgUr6OLA1HBbCXyj5oxGYQ2AtsF0SLYdn6Aq
	aqGVwB47zmj+LiS9Z/vwBJ0xIGdhPjfDB
X-Google-Smtp-Source: AGHT+IGmjTTJXptINYm18B4Gdet6brknX7DGf+e5ADSCi1A1lyxTEK4i3c9B3L4mRu/zgaJDE7VESIap81aan6XFPaI=
X-Received: by 2002:a0d:e206:0:b0:61b:3304:cdc7 with SMTP id
 00721157ae682-627e4824bc6mr57685747b3.29.1716489169322; Thu, 23 May 2024
 11:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sijie Lan <sijielan@gmail.com>
Date: Fri, 24 May 2024 02:32:38 +0800
Message-ID: <CAGAHmYDquz9v1eABjGkYq=ja1vPkwAz9HmcCQVZk0htb5W830w@mail.gmail.com>
Subject: Question about btrfs compression
To: linux-btrfs@vger.kernel.org, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"

As described in
https://archive.kernel.org/oldwiki/btrfs.wiki.kernel.org/index.php/Compression.html.
"The compression processes ranges of a file of maximum size 128 KiB
and compresses each 4 KiB (or page-sized) block separately. Accessing
a byte in the middle of the given 128 KiB range requires to decompress
the whole range. This is not optimal and is subject to optimizations
and further development."

Since Btrfs compresses each 4KiB block of data separately. My question
is that when randomly accessing some of the bytes in the entire
compressed chunk, decompressing some of the bytes in the entire chunk
seems to be much more efficient than decompressing the entire range
(128 KiB), but the current method still decompresses the entire 128KiB
chunk when accessing some of the bytes in the chunk (e.g., 4KiB). So
why is it not optimized for this, is it a basic implementation
difficulty or something else?

