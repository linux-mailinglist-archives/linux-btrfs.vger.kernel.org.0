Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF9C415E68
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 14:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240995AbhIWMcH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Sep 2021 08:32:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58756 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240961AbhIWMcE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Sep 2021 08:32:04 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1218C2235E;
        Thu, 23 Sep 2021 12:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632400232;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JG1f+CTSaTgL+dtaAwzxlJuuLp7jEqKFfEI/QtUEmD0=;
        b=DAMPDgstuSm5ontYs4Ea1alg+lR/ZCbZxO7DIjq+niarviVTAzVfoAgSQ0q0/beRh6Bwil
        oYY2iixjgrGKNgUH8XfLGceQfIWbq7lMy2Uvd3tp2+m3NFRNui50SvY1VshNUbNt5curEA
        +v+Eg8ZMUljpp8SPpiO+7ufghweZ58k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632400232;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JG1f+CTSaTgL+dtaAwzxlJuuLp7jEqKFfEI/QtUEmD0=;
        b=yHK/KqU3ZYbnqA1D1QqJwVehoAhfmBD1ckUNRyoXSMsN1lkZnGAV4OJDvaEr2NCVdAk5SU
        3S2QqEoQJaMagPCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay1.suse.de (Postfix) with ESMTP id 0AD5525D3C;
        Thu, 23 Sep 2021 12:30:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1EBB8DA799; Thu, 23 Sep 2021 14:30:19 +0200 (CEST)
Date:   Thu, 23 Sep 2021 14:30:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: check: fix indent --clear-ino-cache option
Message-ID: <20210923123018.GV9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210923085649.109622-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923085649.109622-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 23, 2021 at 04:56:49PM +0800, Qu Wenruo wrote:
> Help string for "--clear-ino-cache" option is not following the indent
> of other help strings:
> 
>       repair options:
>            --init-csum-tree            create a new CRC tree
>            --init-extent-tree          create a new extent tree
>            --clear-space-cache v1|v2   clear space cache for v1 or v2
>            --clear-ino-cache 	    clear ino cache leftover items
> 
> The problem is caused by the usage of tab instead of space as indent.
> 
> Fix it by using space instead.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.
