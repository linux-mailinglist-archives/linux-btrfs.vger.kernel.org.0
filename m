Return-Path: <linux-btrfs+bounces-4597-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D398B54C5
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 12:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93338B21E35
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 10:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB992C68F;
	Mon, 29 Apr 2024 10:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXZ5qECP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9789117741
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 10:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714385515; cv=none; b=iTBI7nJRTOktXf4GPsoVP+EdtixFHgGyE2+w47QgiNuY2OD995oWFFBuVK/FSfOOLOcspL+SHhscutwWJ7BKkJVkY1qqWiNYZ2lsVhKmWzky5l0KJOadF99077iyuiI9dmS5EnSHlfgsUsK3omMcjD93q9SZdcTqnDblkC3OwEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714385515; c=relaxed/simple;
	bh=Foj7rRSbvwvk8RrsQY/QBAnKJONz//jkn1OUS7HJqnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YAWeEzGo4R8t9bprFY3Z3c9exIxL0FKvJpWBVFKM5560qjZzLrXhSRQNcGdi6bSfOJpZjYvturioBl2HQG4WWBlqIV257KvzMdd41Hl3hGAncYEeg/6uCe6Whuo9Kx5eqO5oEY+0zCa9ST3NFGcPsg3NDA+/089ChouvX68i98A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXZ5qECP; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-de45dba157cso3907087276.3
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 03:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714385512; x=1714990312; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/MJs9ZIgiZ75qmjRS0L+eOOATRm/WVrwvn012RsBNZ8=;
        b=RXZ5qECPBLiq9cPq2R4o4wtDg+6YL4epWSGazD/lW6t+ihWu+HVCOPnz69MzewiKVM
         lDsuHXxJfTfaQT5L/9Bmkyf5AgdMUKIufHJWkjeBT4hro22XDhtqvyudki7RgibVVkvZ
         SMwqL68SU+FglFUt6q5wtJqJU+E3bxH0YPBxYv4U/NHvRxXOw7Q3kTjr7wi0vOPMlUW0
         rQvoxYXVyZIOgwr34bav9a1PqjI1fw3QLN4JnKqVN2i8K7qZWWBW0iolHhx4bgjiHl3m
         ExSUlGXS1PpmcADhl92qUqo1weVhkBCK1Y6sHvrxx/QarVoU8fNnkmr4S63VRv6CG/ER
         HYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714385512; x=1714990312;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/MJs9ZIgiZ75qmjRS0L+eOOATRm/WVrwvn012RsBNZ8=;
        b=Jg0o/H5YZnrDwkY2/yGEDv/6iapPTQ6bn6y+UtwI6oBvS2ZowHkb+4kxcaiFiyfk2o
         ZMWjh43IHQjN07rBMvww11csODWuYBjy/fFPO+HXHi1QJzskJauUUrH4ZWSZNN0rH+qC
         yL39bKPag2VgZK3pT1dstCOj7SvRwsFKbXStWNS7vaQTxd6twb9Vjxo7BFPZSjNAs1Fu
         83MIWVUQxWlsbharSeOQAvan5Guof5HckuPABGj3iFwFGcYPMvMJ7s6zWL5RAbaU6jWO
         HRcTuQalNJID7J4fEpqesxML8ImJZWcRKeCI+LTvMdygaOipCWCJ4Mn1wk6+L4ist8bE
         gwFQ==
X-Gm-Message-State: AOJu0YxEXXjWoP8YMZagpJUdpqoLAhbfvyJHuyVkCqyXS1EnW1uMkKh8
	NRkOxmiqzbux9IqEpM0LeAIwmdZG9fKXHCzs94fo8Bn4Y9CnLT1AGx84KlVEymJOuhQd8E+uokB
	tOayzkcSM4sHZ85Z4mFn71oxnSag2w9PXlSc=
X-Google-Smtp-Source: AGHT+IFHTlKM1U/YOIXNl54eMIrBlgPldtvMMC1T0rD7sZ1EienhLYHeYYwwE6B8cbQrjoGZqcxluyk+0cLbGmD+BUE=
X-Received: by 2002:a25:accd:0:b0:de5:6a2f:725 with SMTP id
 x13-20020a25accd000000b00de56a2f0725mr10795069ybd.50.1714385512413; Mon, 29
 Apr 2024 03:11:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240428233134.GA355040@tik.uni-stuttgart.de>
In-Reply-To: <20240428233134.GA355040@tik.uni-stuttgart.de>
From: Andrea Gelmini <andrea.gelmini@gmail.com>
Date: Mon, 29 Apr 2024 12:11:36 +0200
Message-ID: <CAK-xaQZYFvUhQzx=atZEhs+DGPD1tNzO0EP4fPC=zOptXajsxQ@mail.gmail.com>
Subject: Re: 2 PB filesystem ok?
To: linux-btrfs@vger.kernel.org
Cc: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
Content-Type: text/plain; charset="UTF-8"

Il giorno lun 29 apr 2024 alle ore 01:40 Ulli Horlacher
<framstag@rus.uni-stuttgart.de> ha scritto:
> Is 2 PB ok for one btrfs filesystem?

Well, it works (you can play by yourself with loopback just for fun
with a test file!!!).

But, I dunno about RAM request if you are in trouble and need to run
fsck or repair. Also about the RAM requested to have all extents
mapped.
You could be in sad situation to not be able to mount it.
Also, better if you can update the kernel whenever you want, and you
don't have third party constraints.

In my experience (max 200TB volume),  I use BTRFS for big volumes, but
they need more extra care than the usual EXT4/XFS.

