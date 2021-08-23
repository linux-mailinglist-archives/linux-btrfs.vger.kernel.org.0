Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207243F4CBE
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 16:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhHWO6V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 10:58:21 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60044 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhHWO6U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 10:58:20 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8062D1FFFF;
        Mon, 23 Aug 2021 14:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629730657;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vIb6yaqqNQ8/tIpNN0+ITQj9s0yKXzTtV5BT/hcW6aU=;
        b=HK5CiKqEW+9/sxxboSGA8Ien+AMwsuZpOpqp3FuJdlY9MJMiFVwp2Kng3/2rA3zqF9/TDy
        nXhs6xV9MLQNhPJM1W8WCkgYVUWzlQW7EhoMQs+gd/4Fy/29TnQkASCMKpSIn4mtUmOKp0
        VdXhdEjiGhamnV0OH6pxzJt5auLjBwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629730657;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vIb6yaqqNQ8/tIpNN0+ITQj9s0yKXzTtV5BT/hcW6aU=;
        b=NlgVkmyn6OQlnrwkNz/3FjUHWP2MtR2r3j4W2Itj4k9hetLhIG5JJk135bchfrxIriffkA
        YsE1VorZm5zUDJBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 776EDA3BBE;
        Mon, 23 Aug 2021 14:57:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5EF89DA725; Mon, 23 Aug 2021 16:54:36 +0200 (CEST)
Date:   Mon, 23 Aug 2021 16:54:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 01/12] btrfs-progs: fix running lowmem check tests
Message-ID: <20210823145436.GB5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1629322156.git.josef@toxicpanda.com>
 <45ba3fd15ba81f18136d9f6a7e10e7d6bc2422d5.1629322156.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45ba3fd15ba81f18136d9f6a7e10e7d6bc2422d5.1629322156.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 18, 2021 at 05:33:13PM -0400, Josef Bacik wrote:
> When I added the invalid super image I saw that the lowmem tests were
> passing, despite not having the detection code yet.  Turns out this is
> because we weren't using a run command helper which does the proper
> expansion and adds the --mode=lowmem option.  Fix this to use the proper
> handler, and now the lowmem test fails properly without my patch to add
> this support to the lowmem mode.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  tests/common | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/common b/tests/common
> index 805a447c..5b255689 100644
> --- a/tests/common
> +++ b/tests/common
> @@ -425,9 +425,8 @@ check_image()
>  
>  	image=$1
>  	echo "testing image $(basename $image)" >> "$RESULTS"
> -	"$TOP/btrfs" check "$image" >> "$RESULTS" 2>&1
> -	[ $? -eq 0 ] && _fail "btrfs check should have detected corruption"
> -
> +	run_mustfail "btrfs check should have detected corruption" \
> +		"$TOP/btrfs" check "$image"

This seems correct but Qu sent a patch that processes the output looking
for some specific error messages so I've applied his version
("btrfs-progs: tests: also check subpage warning for check_image cases")

>  	run_check "$TOP/btrfs" check --repair --force "$image"
>  	run_check "$TOP/btrfs" check "$image"
>  }
> -- 
> 2.26.3
