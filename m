Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEAC8165269
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2020 23:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgBSWVc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Feb 2020 17:21:32 -0500
Received: from luna.lichtvoll.de ([194.150.191.11]:37819 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726760AbgBSWVc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Feb 2020 17:21:32 -0500
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 5DFFBB3757;
        Wed, 19 Feb 2020 23:21:29 +0100 (CET)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Roman Mamedov <rm@romanrm.net>
Cc:     Marc MERLIN <marc@merlins.org>, dsterba@suse.cz,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: do not zero f_bavail if we have available space
Date:   Wed, 19 Feb 2020 23:21:29 +0100
Message-ID: <2656316.bop9uDDU3N@merkaba>
In-Reply-To: <20200219225051.39ca1082@natsu>
References: <20200131143105.52092-1-josef@toxicpanda.com> <20200219153652.GA26873@merlins.org> <20200219225051.39ca1082@natsu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Roman Mamedov - 19.02.20, 18:50:51 CET:
> On Wed, 19 Feb 2020 07:36:52 -0800
> 
> Marc MERLIN <marc@merlins.org> wrote:
> > Thanks. For some reason, debian's latest make-kpkg hangs forever on
> > 5.5 kernels (not sure why) so I can't build it right now, but I
> > just got 5.4.20 and I'm compiling that now, thanks.
> 
> Debian deprecates their own tooling for regular users (as opposed to
> package mantainers) to easily make custom kernel deb packages[1],
> they now suggest to use the kernel-provided "make bindeb-pkg"
> instead.

Yes. I use

eatmydata make -j4 bindeb-pkg LOCALVERSION=-tp520

to build my kernels meanwhile (still that good old ThinkPad T520 with 
the keyboard before Lenovo made it worse).

You also get a linux-headers package which I believe you need to install 
in order to have dkms build 3rd party modules if you have any.

> [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=925411#17

Best,
-- 
Martin


