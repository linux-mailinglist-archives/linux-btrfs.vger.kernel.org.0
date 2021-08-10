Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971613E5C85
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Aug 2021 16:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238889AbhHJOHq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Aug 2021 10:07:46 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34852 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237375AbhHJOHq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Aug 2021 10:07:46 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2D695200B9;
        Tue, 10 Aug 2021 14:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628604443;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ok+5PZ4Wccz0hdrjClnsxQOONPiU0T6dDCCUsxFO3j8=;
        b=mLY4XBs/Jo2O3j6m2412n0TZL2Loqn9h2T89v3X1Huu+HJ33kEEsEEqCfBbcpdm2EUbh8F
        BAkYRUrA3XdNf/bHfrnjNyTDKFsuSkx5pnmq8pwyfVYco2uB8xRZ4vG5Rmkab4LV4gZ87Z
        Wv3Mdz//fwS6MWAfFRpPXCV5p/Fsgv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628604443;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ok+5PZ4Wccz0hdrjClnsxQOONPiU0T6dDCCUsxFO3j8=;
        b=CJgslxqRLCzaUehonPi9WY+8ncC257RT3iRB1WwnFy4v4kBv0x26wiydrzF4xLG6XIH1tP
        hGg4OxjbrvCbbMBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 23BFEA3B8A;
        Tue, 10 Aug 2021 14:07:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AE002DA880; Tue, 10 Aug 2021 16:04:30 +0200 (CEST)
Date:   Tue, 10 Aug 2021 16:04:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [PATCH v2] fstests: btrfs/244: add test case to verify the
 behavior of deleting non-existing device
Message-ID: <20210810140430.GV5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20210806113333.328261-1-wqu@suse.com>
 <5547039c-2989-e9d7-6126-15877758b3f0@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5547039c-2989-e9d7-6126-15877758b3f0@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 06, 2021 at 02:42:36PM +0300, Nikolay Borisov wrote:
> > +if [ $ret -ne 1 ]; then
> > +	echo "Unexpected return value from btrfs command, has $ret expected 1"
> > +fi
> 
> <rant>
> This just shows how broken progs are w.r.t return values. The generally
> accepted return value is 0 on success, yet it returns 1 on success since
> the functions implementing this functionality in progs treat the return
> value as a boolean.
> </rant>

Heh, not following the common convention of 0 for success, !0 for errors
would be crazy and hardly left unnoticed by users.
