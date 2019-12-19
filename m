Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C18D6126FC6
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2019 22:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfLSVfz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 19 Dec 2019 16:35:55 -0500
Received: from luna.lichtvoll.de ([194.150.191.11]:46899 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726880AbfLSVfz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Dec 2019 16:35:55 -0500
X-Greylist: delayed 597 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Dec 2019 16:35:54 EST
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id EB9589C912;
        Thu, 19 Dec 2019 22:25:56 +0100 (CET)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Ralf Zerres <Ralf.Zerres@networkx.de>
Cc:     "'linux-btrfs@vger.kernel.org'" <linux-btrfs@vger.kernel.org>
Subject: Re: How to heel this btrfs fi corruption?
Date:   Thu, 19 Dec 2019 22:25:55 +0100
Message-ID: <1774589.FgVfPneX5p@merkaba>
In-Reply-To: <C439384E8BF26546BDDE396FFA246D1001921619EB@NWXSBS11.networkx.de>
References: <C439384E8BF26546BDDE396FFA246D1001921619EB@NWXSBS11.networkx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Ralf.

Ralf Zerres - 19.12.19, 21:00:12 CET:
> at customer site i can't mount a given btrfs device in rw mode.
> this is production data and i do have a backup and managed to mount
> the filesystem in ro mode. I did copy out relevant stuff. Having said
> this, if btrfs --repair can't heal the situation, i could reformat
> the filesystem and start all over. But i would prefere to save the
> time and take the heeling as a proof of "production ready" status of
> btrfs-progs.
> 
> Here are the details:
> 
> kernel: 5.2.2 (Ubuntu 18.04.3)
> btrfs-progs: 5.2.1
[…]
> 4) As a forth step, i tried to repair it
> 
> # btrfs check --mode lowmem --progress --repair /dev/<mydev>
> # enabling repair mode
> # WARNING: low-memory mode repair support is only partial
> # Opening filesystem to check...
> # Checking filesystem on /dev/<mydev>
> # UUID: <my UUID>
> # [1/7] checking root items                      (0:00:33 elapsed,
> 20853512 items checked) 
> # Fixed 0 roots.
> # ERROR: extent[1988733435904, 134217728] referencer count mismatch
> (root: 261, owner: 286, offset: 5905580032) wanted: # 28, have: 34 
> #  ERROR: fail to allocate new chunk No space left on device

Maybe the filesystem check failed due to that error?

Just guess work tough!

You could try adding a device to the filesystem and then check again. It 
could even be a good (!) USB stick. This way BTRFS would have some 
additional space and maybe 'btrfs check' would complete.

May or may not work, no idea. But I noticed that the check itself 
mentioned an out of space condition so I thought I'd mention it.

Best of success,
-- 
Martin


