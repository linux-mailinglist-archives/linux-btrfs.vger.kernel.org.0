Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7230D428AAF
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 12:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbhJKKV7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 06:21:59 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60292 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235714AbhJKKV6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 06:21:58 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7550F22009;
        Mon, 11 Oct 2021 10:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633947598;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zq4RjEp9bg5QA81e2rB0yfUkGdl30Gdb/l5BVrp4vUo=;
        b=QHjNNzJT41QAzDc7FzKZSqHIET/SEG3qewF7Qeh8sq8AHftDih5i5t8M1VjpnQZNYX8qvS
        ROfDa7R5i9pmAw765CkaXWdp2laHN29munN2emqIvatN+Z8DZMF7Oj74t8xoRy7DBVYqVp
        FtlXhazSMmr7/Ic4cOYCg4xXVP9Kq6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633947598;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zq4RjEp9bg5QA81e2rB0yfUkGdl30Gdb/l5BVrp4vUo=;
        b=u65p58//3M+EdwnRcSgXq55cBbFIzoNaZC4ORAqQy/kjCsAtZJ1+ZdM/1szf8Z56f5JKB0
        cWm4XIfcYeHXp6DA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 675F8A3B87;
        Mon, 11 Oct 2021 10:19:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 388F1DA704; Mon, 11 Oct 2021 12:19:35 +0200 (CEST)
Date:   Mon, 11 Oct 2021 12:19:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, wqu@suse.com,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/9] btrfs-progs: use an associative array for init mkfs
 blocks
Message-ID: <20211011101934.GA9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Wang Yugui <wangyugui@e16-tech.com>,
        Josef Bacik <josef@toxicpanda.com>, wqu@suse.com,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1629486429.git.josef@toxicpanda.com>
 <9e4cd53b74631be7c4bf78653de2d931d53dce3c.1629486429.git.josef@toxicpanda.com>
 <20211009143403.5A1F.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211009143403.5A1F.409509F4@e16-tech.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Oct 09, 2021 at 02:34:03PM +0800, Wang Yugui wrote:
> Hi, Josef Bacik, Qu Wenruo
> 
> This patchset will make a patch from Qu Wenruo will no longer work as
> expected.
> 
>  From:    Qu Wenruo <wqu@suse.com>
>  To:      linux-btrfs@vger.kernel.org
>  Cc:      Chris Murphy <lists@colorremedies.com>
>  Date:    Sat, 31 Jul 2021 15:42:40 +0800
>  Subject: [PATCH] btrfs-progs: mkfs: set super_cache_generation to 0 if we're using free space tree
> 
>   # mkfs.btrfs -R free-space-tree test.img
>   # btrfs inspect-internal dump-super test.img | grep cache_generation
> 
> 0 is expected, but -1 is returned since this patchset.

Thanks for the report, now tracked as
https://github.com/kdave/btrfs-progs/issues/414 .
