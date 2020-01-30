Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0111E14E60E
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 00:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgA3XMh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 30 Jan 2020 18:12:37 -0500
Received: from luna.lichtvoll.de ([194.150.191.11]:49559 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726514AbgA3XMh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 18:12:37 -0500
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 87D87A98A3;
        Fri, 31 Jan 2020 00:12:35 +0100 (CET)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Remi Gauvin <remi@georgianit.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: With Linux 5.5: Filesystem full while still 90 GiB free
Date:   Fri, 31 Jan 2020 00:12:34 +0100
Message-ID: <1746386.HyI1YD2b7T@merkaba>
In-Reply-To: <4b18e328-72fc-8167-d140-97c898c47e6a@georgianit.com>
References: <112911984.cFFYNXyRg4@merkaba> <1887603.ctEADUaVB5@merkaba> <4b18e328-72fc-8167-d140-97c898c47e6a@georgianit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Remi Gauvin - 30.01.20, 22:20:47 CET:
> On 2020-01-30 4:10 p.m., Martin Steigerwald wrote:
> > I am done with re-balancing experiments.
> 
> It should be pretty easy to fix.. use the metadata_ratio=1 mount
> option, then write enough to force the allocation of more data
> space,,
> 
> In your earlier attempt, you wrote 500MB, but from your btrfs
> filesystem usage, you had over 1GB of allocated but unused space.
> 
> If you wrote and deleted, say, 20GB of zeroes, that should force the
> allocation of metatada space to get you past the global reserve size
> that is causing this bug,, (Assuming this bug is even impacting you. 
> I was unclear from your messages if you are seeing any ill effects
> besides the misreporting in df.)

I thought more about writing a lot of little files as I expect that to 
use more metadata, but… I can just work around it by using command line 
tools instead of Dolphin to move data around. This is mostly my music, 
photos and so on filesystem, I do not change data on it very often, so 
that will most likely work just fine for me until there is a proper fix.

So do need to do any more things that could potentially age the 
filesystem. :)

-- 
Martin


