Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF7144583B
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Nov 2021 18:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbhKDR0m convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 4 Nov 2021 13:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234901AbhKDR0W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Nov 2021 13:26:22 -0400
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5329C061714
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Nov 2021 10:23:44 -0700 (PDT)
Received: from ananda.localnet (unknown [IPv6:2001:a62:1a2d:e700:1e95:40e5:99df:91ba])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 456DF2F082A;
        Thu,  4 Nov 2021 18:23:43 +0100 (CET)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     linux-btrfs@vger.kernel.org, Forza <forza@tnonline.net>
Subject: Re: Settings compression for a filesystem
Date:   Thu, 04 Nov 2021 18:23:42 +0100
Message-ID: <4290595.HUiMQM4q2P@ananda>
In-Reply-To: <8479126f-c24d-4f2a-2ceb-2d71f063a294@tnonline.net>
References: <11237766.pNdQY1Vl8f@ananda> <8479126f-c24d-4f2a-2ceb-2d71f063a294@tnonline.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin2 smtp.mailfrom=martin@lichtvoll.de
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Forza - 04.11.21, 16:14:31 CET:
> You can use `btrfs property set <file> compression zstd`[1] on
> directories and files. This enables compression for any new writes to
> those directories and files. If you set compression on a directory,
> any new files and directories will inherit the property, while
> existing files and directories won't.
> 
> After mounting your disks you can use find to set compression
> recursively:
> 
> # find /media/btrfs/ -exec btrfs prop set {} compression zstd \;

So it just inherits to the newly created files and directories in that 
directory directly.

Ah, I see… then in case I set it on the root inode of a new empty 
filesystem it just works, otherwise… I'd need to use find unless I choose 
to add an entry for each of the disks.

Thanks,
-- 
Martin


