Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864672E6F86
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Dec 2020 10:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgL2Jnu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 29 Dec 2020 04:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgL2Jnt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Dec 2020 04:43:49 -0500
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FCEC0613D6
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Dec 2020 01:43:09 -0800 (PST)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 3B7D61AAA2D;
        Tue, 29 Dec 2020 10:42:23 +0100 (CET)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     =?ISO-8859-1?Q?St=E9phane?= Lesimple 
        <stephane_btrfs2@lesimple.fr>, Qu Wenruo <wqu@suse.com>,
        David Arendt <admin@prnet.org>, linux-btrfs@vger.kernel.org,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: 5.6-5.10 balance regression?
Date:   Tue, 29 Dec 2020 10:42:21 +0100
Message-ID: <11691195.O9o76ZdvQC@merkaba>
In-Reply-To: <5f819b6c-d737-bb73-5382-370875b599c1@gmx.com>
References: <518c15d55c3d540b26341a773ff7d99f@lesimple.fr> <485db52d-cf4d-3a5c-9253-13cdb40ccd5e@gmx.com> <5f819b6c-d737-bb73-5382-370875b599c1@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu Wenruo - 29.12.20, 01:44:07 CET:
> So what I can do is only to add a warning message to the problem.
> 
> To solve your problem, I also submitted a patch to btrfs-progs, to
> force v1 space cache cleaning even if the fs has v2 space cache
> enabled.
> 
> Or, you can disable v2 space cache first, using "btrfs check
> --clear-space-cache v2" first, then "btrfs check --clear-space_cache
> v1", and finally mount the fs with "space_cache=v2" again.
> 
> To verify there is no space cache v1 left, you can run the following
> command to verify:
> 
> # btrfs ins dump-tree -t root <device> | grep EXTENT_DATA
> 
> It should output nothing.

I have v1 space_cache stuff on filesystems which use v2 space_cache as 
well, so…

the fully working way to completely switch to spacecache_v2 for any 
BTRFS filesystem with space cache v1, is what you wrote above?

Or would it be more straight forward than that with a newer kernel?

Best,
-- 
Martin


