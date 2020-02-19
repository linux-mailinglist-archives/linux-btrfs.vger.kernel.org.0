Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB5D164C7F
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2020 18:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgBSRuy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Feb 2020 12:50:54 -0500
Received: from len.romanrm.net ([91.121.86.59]:36752 "EHLO len.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgBSRuy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Feb 2020 12:50:54 -0500
Received: from natsu (natsu.40.romanrm.net [IPv6:fd39:aa:c499:6515:e99e:8f1b:cfc9:ccb8])
        by len.romanrm.net (Postfix) with SMTP id 8AC1A4051D;
        Wed, 19 Feb 2020 17:50:51 +0000 (UTC)
Date:   Wed, 19 Feb 2020 22:50:51 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Marc MERLIN <marc@merlins.org>
Cc:     dsterba@suse.cz, Martin Steigerwald <martin@lichtvoll.de>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: do not zero f_bavail if we have available space
Message-ID: <20200219225051.39ca1082@natsu>
In-Reply-To: <20200219153652.GA26873@merlins.org>
References: <20200131143105.52092-1-josef@toxicpanda.com>
        <20200202175247.GB3929@twin.jikos.cz>
        <CAKhhfD7S=kcKLRURdNFZ8H4beS8=XjFvnOQXche7+SVOGFGC_w@mail.gmail.com>
        <2776783.E9KYCc1pZO@merkaba>
        <20200219134327.GD30993@merlins.org>
        <20200219143114.GY2902@suse.cz>
        <20200219153652.GA26873@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 19 Feb 2020 07:36:52 -0800
Marc MERLIN <marc@merlins.org> wrote:

> Thanks. For some reason, debian's latest make-kpkg hangs forever on 5.5
> kernels (not sure why) so I can't build it right now, but I just got
> 5.4.20 and I'm compiling that now, thanks.

Debian deprecates their own tooling for regular users (as opposed to package
mantainers) to easily make custom kernel deb packages[1], they now suggest to
use the kernel-provided "make bindeb-pkg" instead. 

[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=925411#17

> As for dm-thin, I'm not sure yet, I'll find out when the new kernel is
> installed. I was also hoping fstrim would work, I guess I'll find out.

Indeed fstrim does deprovision backing storage on thin LVM just fine.

However I am not sure what is the relation with the bug being discussed. The
"zero f_bavail" was just returning "0" to df, while that was not actually
true. Seems puzzling how would that lead to increased usage of dm-thin for you.

-- 
With respect,
Roman
