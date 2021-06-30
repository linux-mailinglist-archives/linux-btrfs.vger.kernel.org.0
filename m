Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099563B8136
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jun 2021 13:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbhF3LXv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Jun 2021 07:23:51 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34632 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbhF3LXv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Jun 2021 07:23:51 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9B9601FE6D;
        Wed, 30 Jun 2021 11:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625052081;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hcRrArCHTfHDKlREc0v42yvAQqrwOWz0WZkZ5LO8n4s=;
        b=S3IgIuyWDyuX8p2yDrC3P+Zz7yT+dUmn/Q6buRpXFUfisYyCMyfNIJWXEN6ZSsrke1Ochg
        tC1VjYU8C99xr5NncDqOxxOQSNuAhBjXsVLrlolY0wB641brbwa7KvHEePQ8UWspIWoM5t
        WKjlPxLok/2NLp39IXq4wdlJxdrTe8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625052081;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hcRrArCHTfHDKlREc0v42yvAQqrwOWz0WZkZ5LO8n4s=;
        b=YZseHrTOXyx8NbqFSghQTJlPmC4BLf6geabxgn9iGXUrZRW14LrFuJo+1c2Lhbco0oO7Lp
        X1cwoETxqbMMOODQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 27488118DD;
        Wed, 30 Jun 2021 11:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625052081;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hcRrArCHTfHDKlREc0v42yvAQqrwOWz0WZkZ5LO8n4s=;
        b=S3IgIuyWDyuX8p2yDrC3P+Zz7yT+dUmn/Q6buRpXFUfisYyCMyfNIJWXEN6ZSsrke1Ochg
        tC1VjYU8C99xr5NncDqOxxOQSNuAhBjXsVLrlolY0wB641brbwa7KvHEePQ8UWspIWoM5t
        WKjlPxLok/2NLp39IXq4wdlJxdrTe8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625052081;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hcRrArCHTfHDKlREc0v42yvAQqrwOWz0WZkZ5LO8n4s=;
        b=YZseHrTOXyx8NbqFSghQTJlPmC4BLf6geabxgn9iGXUrZRW14LrFuJo+1c2Lhbco0oO7Lp
        X1cwoETxqbMMOODQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id MyrsBrFT3GCRKQAALh3uQQ
        (envelope-from <pvorel@suse.cz>); Wed, 30 Jun 2021 11:21:21 +0000
Date:   Wed, 30 Jun 2021 13:21:19 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "kernel-team@lists.ubuntu.com" <kernel-team@lists.ubuntu.com>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>,
        Qu Wenruo <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>
Subject: Re: [LTP] [BUG] btrfs potential failure on 32 core LTP test
 (fallocate05)
Message-ID: <YNxTr43lvviG0GOn@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <a3b42abc-6996-ab06-ea9f-238e7c6f08d7@canonical.com>
 <e4c71c01-ed70-10a6-be4d-11966d1fcb75@toxicpanda.com>
 <b5c6779b-f11d-661e-18c5-569a07f6fd8e@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5c6779b-f11d-661e-18c5-569a07f6fd8e@canonical.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> On 29/06/2021 19:20, Josef Bacik wrote:
> > On 6/29/21 1:00 PM, Krzysztof Kozlowski wrote:
> >> Dear BTRFS folks,

> >> I am hitting a potential regression of btrfs, visible only with
> >> fallocate05 test from LTP (Linux Test Project) only on 32+ core Azure
> >> instances (x86_64).

> >> Tested:
> >> v5.8 (Ubuntu with our stable patches): PASS
> >> v5.11 (Ubuntu with our stable patches): FAIL
> >> v5.13 mainline: FAIL

> >> PASS means test passes on all instances
> >> FAIL means test passes on other instance types (e.g. 4 or 16 core) but
> >> fails on 32 and 64 core instances (did not test higher),
> >> e.g.: Standard_F32s_v2, Standard_F64s_v2, Standard_D32s_v3,
> >> Standard_E32s_v3

> >> Reproduction steps:
> >> git clone https://github.com/linux-test-project/ltp.git
> >> cd ltp
> >> ./build.sh && make install -j8
> >> cd ../ltp-install
> >> sudo ./runltp -f syscalls -s fallocate05


> > This thing keeps trying to test ext2, how do I make it only test btrfs?  Thanks,

> It tests all available file systems, just wait till it gets to btrfs. I
> don't know how to limit it only to one file system.
In the future we can add environment variable to specify the only fs to be
tested. There is LTP_DEV_FS_TYPE, but that does not work when .all_filesystems
flag is enabled. Thus just patch the file:

Kind regards,
Petr

diff --git testcases/kernel/syscalls/fallocate/fallocate05.c testcases/kernel/syscalls/fallocate/fallocate05.c
index 55ec1aee4..7f5a3005a 100644
--- testcases/kernel/syscalls/fallocate/fallocate05.c
+++ testcases/kernel/syscalls/fallocate/fallocate05.c
@@ -149,7 +149,8 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.dev_min_size = 512,
 	.mntpoint = MNTPOINT,
-	.all_filesystems = 1,
+	.needs_device = 1,
+	.dev_fs_type = "btrfs",
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = run,
