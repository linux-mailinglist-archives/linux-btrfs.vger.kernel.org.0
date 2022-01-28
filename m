Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B0949FC40
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 15:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245099AbiA1O6U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 09:58:20 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:59896 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbiA1O6S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 09:58:18 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5B2231F391;
        Fri, 28 Jan 2022 14:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643381897;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MXhPQU+xzmYEp26g/Enp21P1t08Vk1Ylm7J7pnOBHTs=;
        b=VNGdZQ8AQ8jgGWyO1kTxxCNmCGrkZ1MdA1br4wunCtDH7Qz7lv3Zb5cyvsrWuQTe74nlnZ
        jv4sDHYkZ6JlaM9XAk7GbX9FSE+iQroKCsDZOSS8nKl3U0GlnPqKzdRglb6z/Jot0HABCp
        2ptTDkUyyDeW9ffiu75i1kNWSfIeUM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643381897;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MXhPQU+xzmYEp26g/Enp21P1t08Vk1Ylm7J7pnOBHTs=;
        b=ZA2WlWtzbhbiKp6uQQvsz/NQX0QkF3KrzQM5yE79Vuwap2r5YVwLwd2nOiyHDMixuP1U1R
        hhcT8jVT3gTlfTDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 510F4A3B81;
        Fri, 28 Jan 2022 14:58:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7BFBADA7A9; Fri, 28 Jan 2022 15:57:35 +0100 (CET)
Date:   Fri, 28 Jan 2022 15:57:35 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix 64bit mod compile error
Message-ID: <20220128145735.GG14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <139a265095afb1b3103d58bd3c8e19a89014db13.1643230494.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <139a265095afb1b3103d58bd3c8e19a89014db13.1643230494.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 26, 2022 at 03:55:12PM -0500, Josef Bacik wrote:
> kernelbuild test bot complained about a 64bit % operation in the patch
> 
> btrfs: add support for multiple global roots
> 
> Fix this using div64_u64_rem.  This can be folded in to the original
> patch.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Folded to the patch, thanks.
