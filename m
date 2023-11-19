Return-Path: <linux-btrfs+bounces-190-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 830587F085C
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Nov 2023 19:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BD0F280D36
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Nov 2023 18:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DEB612F;
	Sun, 19 Nov 2023 18:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.lichtvoll.de (luna.lichtvoll.de [194.150.191.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BEAC2
	for <linux-btrfs@vger.kernel.org>; Sun, 19 Nov 2023 10:42:01 -0800 (PST)
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id 3EC368172F4
	for <linux-btrfs@vger.kernel.org>; Sun, 19 Nov 2023 19:41:59 +0100 (CET)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: linux-btrfs@vger.kernel.org
Subject: Re: parent transid verify failed + level verify failed
Date: Sun, 19 Nov 2023 19:41:58 +0100
Message-ID: <4868643.GXAFRqVoOG@lichtvoll.de>
In-Reply-To: <4896535.31r3eYUQgx@lichtvoll.de>
References:
 <9221302.CDJkKcVGEf@lichtvoll.de> <4896535.31r3eYUQgx@lichtvoll.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Martin Steigerwald - 19.11.23, 17:41:17 CET:
> / was not mountable anymore after booting into GRML. Made image with dd
> and restored from backup onto a newly created BTRFS.

I at least have a possible explanation.

Yesterday I experienced 6.7-almost-rc2 not hibernating correctly, but 
instead hanging with black screen. I rebooted into 6.6.1. Last thing I did 
was remove 6.7-almost-rc2 and hibernate.

In the morning I was greeted by GRUB command line prompt for a reason I do 
not understand yet either. I recovered from this with two GRML sessions. 
For that at least I unlocked LUKS and mounted / and /boot in GRML. If my 
memory is correct after I fixed booting up in these two GRML sessions, 
kernel 6.6.1 resumed from hibernation. That does make some session as in 
the GRML session I did not touch the swap volume. So I bet the hibernation 
image was not invalidated. However that would explain the corruption on / 
filesystem. Cause it was mounted in between and then the kernel resumed 
from a hibernation image with outdated in-memory data structures for 
BTRFS.

If my memory and analysis is correct this would easily explain the 
corruption on /. Still not sure what happened to /home. I think I did not 
touch it on attempting to repair GRUB. However I am not 100% sure about 
that.

Would be interesting to know whether diagnostic data would fit that 
explanation.

In case that is correct, then I think it would be good that in case I ever 
need to fix up GRUB again I also activate swap volume within GRML in the 
hope to invalidate the hibernation image. But I am not completely sure 
whether activating swap would be enough for that.

> /home also had errors. Did not take a chance. Scrubbed it, updated a
> backup with good old rsync, recreated filesystem and restored from
> updated backup.

Best,
-- 
Martin



