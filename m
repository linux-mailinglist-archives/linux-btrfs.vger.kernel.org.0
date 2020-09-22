Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32538273D82
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 10:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgIVIkg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 22 Sep 2020 04:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgIVIkg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 04:40:36 -0400
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFEFC061755
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Sep 2020 01:40:36 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id BF559155503;
        Tue, 22 Sep 2020 10:40:34 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: external harddisk: bogus corrupt leaf error?
Date:   Tue, 22 Sep 2020 10:40:33 +0200
Message-ID: <4501761.uZMkQUx0QA@merkaba>
In-Reply-To: <6e508d1c-32fe-1162-f905-2e57022f8dc6@gmx.com>
References: <1978673.BsW9qxMyvF@merkaba> <f0fd36fd-3ffa-ff02-e5d9-265fc64e38f3@gmx.com> <6e508d1c-32fe-1162-f905-2e57022f8dc6@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu Wenruo - 22.09.20, 04:14:34 CEST:
> On 2020/9/22 上午7:48, Qu Wenruo wrote:
> > On 2020/9/21 下午7:46, Martin Steigerwald wrote:
> >> Qu Wenruo - 21.09.20, 13:14:05 CEST:
> >>>>> For the root cause, it should be some older kernel creating the
> >>>>> wrong
> >>>>> root item size.
> >>>>> I can't find the commit but it should be pretty old, as after
> >>>>> v5.4
> >>>>> we
> >>>>> have mandatory write time tree checks, which will reject such
> >>>>> write
> >>>>> directly.
> >>>> 
> >>>> So eventually I would have to backup the disk and create FS from
> >>>> scratch to get rid of the error? Or can I, even if its no
> >>>> subvolume
> >>>> involved, find the item affected, copy it somewhere else and then
> >>>> write it to the disk again?
> >>> 
> >>> That's the theory.
> >>> 
> >>> We can easily rebuild that data reloc tree, since it should be
> >>> empty
> >>> if balance is not running.
> >>> 
> >>> But we don't have it ready at hand in btrfs-progs...
> >>> 
> >>> So you may either want to wait until some quick dirty fixer
> >>> arrives,
> >>> or can start backup right now.
> >>> All the data/files shouldn't be affected at all.
> >> 
> >> Hmmm, do you have an idea if and when such a quick dirty fixer
> >> would be available?
> > 
> > If you need, I guess in 24 hours.
> 
> Here you go:
> https://github.com/adam900710/btrfs-progs/tree/dirty_fix
> 
> You need to compile the btrfs-progs (in fact, you need to compile
> btrfs-corrupt-block).
> Then execute:
> # ./btrfs-corrupt-block -X <device>
> 
> It should solve the problem.
> If nothing is output, and no crash, then the repair is done.
> Or you will see a crash with calltrace, and your on-disk data is
> untouched.

Thank you very much for the prompt delivery of that tool.

No, in case its safe enough to write it would have not been that urgent.

I hope to find time to try it out this evening. Currently in a training.

Ciao,
-- 
Martin


