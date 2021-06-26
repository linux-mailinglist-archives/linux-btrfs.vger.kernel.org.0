Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4FDC3B4DF6
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Jun 2021 12:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhFZKUw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 26 Jun 2021 06:20:52 -0400
Received: from luna.lichtvoll.de ([194.150.191.11]:46345 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229518AbhFZKUw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 26 Jun 2021 06:20:52 -0400
X-Greylist: delayed 5336 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Jun 2021 06:20:52 EDT
Received: from ananda.localnet (unknown [IPv6:2001:a62:1a52:5a00:19da:1263:b56c:4c4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 43B3727B021;
        Sat, 26 Jun 2021 12:18:29 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     linux-block@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Assumption on fixed device numbers in Plasma's desktop search Baloo
Date:   Sat, 26 Jun 2021 12:18:26 +0200
Message-ID: <3602587.1ANNM6WTHT@ananda>
In-Reply-To: <d24989e1-c8e0-d6c7-706e-2b5b8e9b124c@gmx.com>
References: <41661070.mPYKQbcTYQ@ananda> <2009039.b04VgvrTqe@ananda> <d24989e1-c8e0-d6c7-706e-2b5b8e9b124c@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin2 smtp.mailfrom=martin@lichtvoll.de
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu Wenruo - 26.06.21, 11:33:17 CEST:
> > I am not aware of an option for fstab to mount this one first and
> > then the other second, but I could set the second mount to noauto
> > and mount it when I need it.
> > 
> >> But this also means, all later subvolumes not in the fixed
> >> mount/read sequence can not get a fixed number.
> > 
> > I somehow thought this would get complicated.
> 
> It's already complicated.
> 
> So this just proves Neil is right, device number is only reliable at
> the lifespan of the fs, nothing else.

Thank you again.

I informed upstream about the conclusions from this thread.

Let's see what they come up with.

They have an energy efficiency goal, for that it would be desirable to 
stop indexing files twice or thrice or even more times. :)

Best,
-- 
Martin


