Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2331148EE91
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jan 2022 17:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbiANQlf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jan 2022 11:41:35 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:32828 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243544AbiANQlf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jan 2022 11:41:35 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2E488219B1;
        Fri, 14 Jan 2022 16:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642178494;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CbGuuOClyvdP+L0KolY6SODgzzYDKn/I6y1z6L8UWd0=;
        b=cA1Kf7FKbJdoPmkX9kPXG8u80p7Ka8zBP9SwK1aNPzIRGgakCtvcTVoUk800tOvWb1zLLn
        JgSXe9ExiyNmf8iCs1cVr5CV+DcbJVih/aN9nXI6TnFjj5dCXJIsWrnpus4/+RbWkdR9vU
        P1LFbeJi0rDta2REITptGM3IPloWzAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642178494;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CbGuuOClyvdP+L0KolY6SODgzzYDKn/I6y1z6L8UWd0=;
        b=GB5VPx+3gIdky/RLPoFTNRWS+wCoU5kspwMuiiwE2OE34fmcCzaLMXyW3eHWYANfQx7qfI
        1f+0hNOfORpWrzDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 286B5A3B89;
        Fri, 14 Jan 2022 16:41:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8B12EDA781; Fri, 14 Jan 2022 17:40:59 +0100 (CET)
Date:   Fri, 14 Jan 2022 17:40:59 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 5/5] btrfs-progs: fsck-tests: add test case for
 init-csum-tree
Message-ID: <20220114164059.GD14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220114005123.19426-1-wqu@suse.com>
 <20220114005123.19426-6-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220114005123.19426-6-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 14, 2022 at 08:51:23AM +0800, Qu Wenruo wrote:
> +run_check $SUDO_HELPER "$TOP/btrfs" check --force \
> +	--init-csum-tree "$TEST_DEV"
> +
> +# No error should be found
> +run_check $SUDO_HELPER "$TOP/btrfs" check "$TEST_DEV"
> +btrfs ins dump-tree "$TEST_DEV" > /tmp/dump

Is this some leftover from debugging?

> +
> +# --init-csum-tree with --init-extent-tree should not fail
> +#run_check $SUDO_HELPER "$TOP/btrfs" check --force \
> +#	--init-csum-tree --init-extent-tree "$TEST_DEV"
> +
> +# No error should be found
