Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33362722ED
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 13:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgIULqS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 07:46:18 -0400
Received: from luna.lichtvoll.de ([194.150.191.11]:46369 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726402AbgIULqR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 07:46:17 -0400
X-Greylist: delayed 4544 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 07:46:16 EDT
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 0C48A154A6F;
        Mon, 21 Sep 2020 13:46:15 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: external harddisk: bogus corrupt leaf error?
Date:   Mon, 21 Sep 2020 13:46:13 +0200
Message-ID: <8020498.oVlb7o6SH1@merkaba>
In-Reply-To: <8d2987f8-e27e-eedb-164f-b05d74ad8f3b@gmx.com>
References: <1978673.BsW9qxMyvF@merkaba> <4131924.Vjtf9Mc2VK@merkaba> <8d2987f8-e27e-eedb-164f-b05d74ad8f3b@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu Wenruo - 21.09.20, 13:14:05 CEST:
> >> For the root cause, it should be some older kernel creating the
> >> wrong
> >> root item size.
> >> I can't find the commit but it should be pretty old, as after v5.4
> >> we
> >> have mandatory write time tree checks, which will reject such write
> >> directly.
> > 
> > So eventually I would have to backup the disk and create FS from
> > scratch to get rid of the error? Or can I, even if its no subvolume
> > involved, find the item affected, copy it somewhere else and then
> > write it to the disk again?
> That's the theory.
> 
> We can easily rebuild that data reloc tree, since it should be empty
> if balance is not running.
> 
> But we don't have it ready at hand in btrfs-progs...
> 
> So you may either want to wait until some quick dirty fixer arrives,
> or can start backup right now.
> All the data/files shouldn't be affected at all.

Hmmm, do you have an idea if and when such a quick dirty fixer would be 
available?

Also, is it still safe to write to the filesystem? I looked at the disk, 
cause I wanted to move some large files over to it to free up some space 
on my laptop's internal SSDs.

If its still safe to write to the filesystem, I may just wait. I will 
refresh the backup of the disk anyway. But if its not safe to write to 
it anymore, I would redo the filesystem from scratch. Would give the 
added benefit of having everything zstd compressed and I could also go 
for XXHASH or what one of the faster of the new checksum algorithms was.

Best,
-- 
Martin


