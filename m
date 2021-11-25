Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A2745DC52
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Nov 2021 15:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240255AbhKYOcN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Nov 2021 09:32:13 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:44574 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353988AbhKYOaP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Nov 2021 09:30:15 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BF5981FD34;
        Thu, 25 Nov 2021 14:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637850423;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PBYzt0XffX/ggu5fE3/JyU8+9m2yBzaLiOWWzLqlPRw=;
        b=B7LoMLzPOWoNfKpDswKRwC98TZHLUqqjzpBq9btCUiRJeAH7NCywHOryxTyvD/3Z71iwMx
        mM0qrOqaSqBEc7CBIGhHpU/uBDWjJ+MYvvJfZBVngKkg/jMp2n5CiQCKIUpxeY1ceGmvSp
        tXXdzGoPMFE7TGMVTUAmHvEY3dnHXkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637850423;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PBYzt0XffX/ggu5fE3/JyU8+9m2yBzaLiOWWzLqlPRw=;
        b=DkEGXpvbnXlVwVT/symVrHQsHlT1bw0migjjDNpgZe8RgGTwxlaRqsS1Wrr5+MFCyHGvu7
        yGsE7D6yJoe55UCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BA1DDA3B88;
        Thu, 25 Nov 2021 14:27:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 88E0DDA735; Thu, 25 Nov 2021 15:26:55 +0100 (CET)
Date:   Thu, 25 Nov 2021 15:26:55 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: Add test for btrfs fi usage output
Message-ID: <20211125142655.GY28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211118152204.424144-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118152204.424144-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 18, 2021 at 05:22:04PM +0200, Nikolay Borisov wrote:
> There was a regression in btrfs progs release 5.15 due to changes in how
> the ratio for the various raid profiles got calculated and this in turn
> had a cascading effect on unallocated/allocated space reported.
> 
> Add a test to ensure this regression doesn't occur again.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to devel, thanks.

> +report_numbers()
> +{
> +	vars=($(run_check_stdout $SUDO_HELPER "$TOP/btrfs" filesystem usage -b "$TEST_MNT" | awk '

Please declare local variables

> +	/Data ratio/ { ratio=$3 }
> +	a {dev_alloc=$2; exit}
> +	/Data,(DUP|RAID[0156][C34]{0,2}|single)/ { size=substr($2,6,length($2)-6); a=1 }
> +END {print ratio " " size " " dev_alloc}'))
> +
> +	echo "${vars[@]}"
> +}
> +
> +test_dup()
> +{
> +	run_check_mkfs_test_dev -ddup
> +	run_check_mount_test_dev
> +	vars=($(report_numbers))
> +	data_chunk_size=${vars[1]}
> +	used_on_dev=${vars[2]}
> +	data_ratio=${vars[0]}

And the whole bunch

> +
> +	[[ $used_on_dev -eq $((2*$data_chunk_size)) ]] || _fail "DUP inconsistent chunk/device usage. Chunk: $data_chunk_size Device: $used_on_dev"

Though there's no limit for the line width, if it can be at the pipe/||
point it's preferred, in this case the _fail is not hidden in the middle
of the long command.

All fixed.
