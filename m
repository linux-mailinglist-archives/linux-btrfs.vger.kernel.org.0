Return-Path: <linux-btrfs+bounces-3134-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A19D7876BFA
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 21:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E93B2835C7
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 20:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5275E08A;
	Fri,  8 Mar 2024 20:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d.umn.edu header.i=@d.umn.edu header.b="DpWNVNxM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mta-p7.oit.umn.edu (mta-p7.oit.umn.edu [134.84.196.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF742B9A0
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Mar 2024 20:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.84.196.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709930724; cv=none; b=SOLEciHz80nMWqeK/uDKTH6rwycLbDRHLdv8Z4OIJ9t3Mu15f7Q3dxpDYBRzhS3FctOSEBJKtWx2XEHSue+YK1sGtVmDqmHgLDuZn31yuvp0gEyQVpiSpNLYPnH27d0gRIMhanDh89iwhVJvOkLQ8cA7kqp04rUFAE5KCHPdIXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709930724; c=relaxed/simple;
	bh=lpDrlI0nhlooJyZ7Vq5/rMDQtL/Xq4MijUhgxZ+09hU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=UQKI53EaB708Z8vQOv8aqt/D7y9fglIDRO0hMGRChgQHGtrCMHCJrevE9YJvuh0YOFbascihUlIRIYbb+8ypqesxGqlaRnAsD4QZxuvpx1ttdHxq4rUch794oEm4sVYN9ePCFsRX528UupA6ahzGFr3UEHG9u+jKqOb2xxO9o6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d.umn.edu; spf=pass smtp.mailfrom=d.umn.edu; dkim=pass (2048-bit key) header.d=d.umn.edu header.i=@d.umn.edu header.b=DpWNVNxM; arc=none smtp.client-ip=134.84.196.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d.umn.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d.umn.edu
Received: from localhost (unknown [127.0.0.1])
	by mta-p7.oit.umn.edu (Postfix) with ESMTP id 4TryhH58g8z9vJrl
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Mar 2024 20:39:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
	by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 04CDKOZV9H3H for <linux-btrfs@vger.kernel.org>;
	Fri,  8 Mar 2024 14:39:27 -0600 (CST)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 4TryhH2qnHz9vJrW
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Mar 2024 14:39:27 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 4TryhH2qnHz9vJrW
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 4TryhH2qnHz9vJrW
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-299783294a6so2026191a91.3
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Mar 2024 12:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=d.umn.edu; s=google; t=1709930366; x=1710535166; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lpDrlI0nhlooJyZ7Vq5/rMDQtL/Xq4MijUhgxZ+09hU=;
        b=DpWNVNxMX6wSEhMY582u6uDuYaYdbXVLYLt4Sh52HVW01fnHCZt/Mv0JndNfmHMuJR
         n/qay7HMc99pG+P//OWWByxFxToab5nx3Y1MF3t9DqgX6YY8zW0MVg9lKTzjwpE1QGX/
         vdRqnb4WV4/DHeNT3e6NY9MTMcaMyGEXcxMO6XVoFlRGuSk2ay9+aFhSt91fwHp817Ai
         S0PLsH/2OCnGq7rQnJvzO8JnK+LlDiUBG1ykcRxOx3cA99uZlV9OG09BBTwrP5DfxbQo
         lOsds4rxsIuI7LGeVdz9xspYXXtQea91JrUY+WOlEHnYUXiagq/jA5mSOqnyp+8rV8SQ
         fYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709930366; x=1710535166;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lpDrlI0nhlooJyZ7Vq5/rMDQtL/Xq4MijUhgxZ+09hU=;
        b=aQBWTCL867d0e6MgEEfmlKxq8b2YDVU1sjitDhcfeC4yTSg5ttXcund6OO2689Df9w
         +oXK5nwuwUUGQpQ0GbDkChzEruiRyZNO8BAjOvWcODkz9tLLRQOADnzdgV93MrcnN050
         gG6u+CuxkPgHZWQy61GOCtM5LnSrzSXgQa03Zck3eNLlOjMSPIQSX05xNiTzNIlr/nPk
         cvB6lRHGiV8XojpfbEz3JA3DWxioyOZ2q7rmRLKurp0cuAd+kIRqM8zjKOuC49pkYEFr
         OGHixT8YMgjXHXP7jgTg8Kl3HV/OQjtyLSyfvSB5kWXSamwap88f7CFvs8ZjEwBAxhRk
         tNSw==
X-Gm-Message-State: AOJu0YzY+8IX13P4AqUgDg/PC8wA2zOcxzUG1NwKCbfzNbmOJfUOftXI
	lau/gvpu5IuUL7oixfkxKv6Z07ma4oluJ9sfdzTdJiIYZE3mxBLLgwH2EZf6300JOMp1rs/qeWr
	aADjcuOgJ0wQscD/iHm6Ssg1tSMrL9URjPt5sZ0T+E0KeRpreF1o+wrAmfOAc3Eokp1xcP4Cb5c
	dOkJ1eEEzXsWGCupi11DL0QMqoZlb8xGXCLuCKiNGshv5p1nXG
X-Received: by 2002:a17:90a:66c8:b0:29b:2d64:68e5 with SMTP id z8-20020a17090a66c800b0029b2d6468e5mr296890pjl.31.1709930366472;
        Fri, 08 Mar 2024 12:39:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF33fNmI4rMu5mTGcNslhzvkY3nL3NkkyKcI2oM9P8kEr9hXod1KhVAo/xpyFYAu0+WMmIJz0nUEXGAeuN5vaw=
X-Received: by 2002:a17:90a:66c8:b0:29b:2d64:68e5 with SMTP id
 z8-20020a17090a66c800b0029b2d6468e5mr296879pjl.31.1709930366171; Fri, 08 Mar
 2024 12:39:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Matt Zagrabelny <mzagrabe@d.umn.edu>
Date: Fri, 8 Mar 2024 14:39:14 -0600
Message-ID: <CAOLfK3UccL8z7Xf_KSp=foS6hM8Byf5n_21uwO96=9ND=-j84A@mail.gmail.com>
Subject: raid1 root device with efi
To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Greetings,

I've read some conflicting info online about the best way to have a
raid1 btrfs root device.

I've got two disks, with identical partitioning and I tried the
following scenario (call it scenario 1):

partition 1: EFI
partition 2: btrfs RAID1 (/)

There are some docs that claim that the above is possible and others
that say you need the following scenario, call it scenario 2:

partition 1: EFI
partition 2: MD RAID1 (/boot)
partition 3: btrfs RAID1 (/)

What do folks think? Is the first scenario setup possible? or is the
second setup the preferred way to achieve a btrfs RAID1 root
filesystem?

The reason I ask is that I followed a guide (for scenario 1) and
rebooted the computer after each step to verify that things worked.
After I finished the whole guide, I unplugged one of the disks (with
the system off) and the BIOS could no longer find the disk. I then
plugged the disk back in and the BIOS could still not find the disk,
so something is amiss.

Thanks for any commentary and help!

-m

