Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1374292D1
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 17:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbhJKPHZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 11:07:25 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59218 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbhJKPHY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 11:07:24 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AAAC8220D0;
        Mon, 11 Oct 2021 15:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633964723;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6bQCB+KqFCPLY1FZKxjvWXFiUfcAMfu1jv9Iwrabo0E=;
        b=VHXq20CxD7ZyrzHwRZl0sp9ovDoZEqfdP024RFjFf/M7zxwAXzXUApn554qd5nxylER59x
        LfCqpSouP78uk/KBuT1dzzqqglQxll0TOFeIH9Jl+q0pp4NG6eJK87rwBfrGkBGYUWDR/L
        j7lILaGJlA/w0EmEK4wfH2un37cXCBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633964723;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6bQCB+KqFCPLY1FZKxjvWXFiUfcAMfu1jv9Iwrabo0E=;
        b=ameqUOaAhhemNxpY55SIXXJhndxY4UE0uAvDVYr+NzlZEDZBrTRtAt4z+tAYP1u9w0+DZO
        xepSI5WjGrGBkGAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A373FA3B81;
        Mon, 11 Oct 2021 15:05:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 948C0DA781; Mon, 11 Oct 2021 17:05:00 +0200 (CEST)
Date:   Mon, 11 Oct 2021 17:05:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/5] btrfs: pull up qgroup checks from delayed-ref core
 to init time
Message-ID: <20211011150500.GP9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211011101019.1409855-1-nborisov@suse.com>
 <20211011101019.1409855-5-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011101019.1409855-5-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 11, 2021 at 01:10:18PM +0300, Nikolay Borisov wrote:
> @@ -279,6 +279,8 @@ static inline void btrfs_init_tree_ref(struct btrfs_ref *generic_ref,
>  	generic_ref->tree_ref.level = level;
>  	generic_ref->tree_ref.owning_root = root;
>  	generic_ref->type = BTRFS_REF_METADATA;
> +	generic_ref->skip_qgroup = skip_qgroup || !(is_fstree(root) &&
> +				    (!mod_root || is_fstree(mod_root)));

Please avoid overly long conditions when assigning them as expression.
So far we've been doing only simple == or ?:, anything else should be
an if-else.
