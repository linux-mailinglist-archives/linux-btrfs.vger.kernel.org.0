Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0632F3B80A2
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jun 2021 12:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbhF3KLy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Jun 2021 06:11:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42748 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbhF3KLp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Jun 2021 06:11:45 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1DAA31FE65;
        Wed, 30 Jun 2021 10:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625047756;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b0HNvCVvy7/EJa/w0/2tgbsYknPwd+OPPcwT4ybe3FY=;
        b=ERUdr7iLUQEPGOwxK6dUyf4DxERwtl1V6KdDc1Xcij4Id4O8xpa9k6XQs1gccV540ZYBo4
        owVMnKDa6BvccjCGSW+rcu7ktyQ+W3RP/qkOUUB0K8kl2kOSeziZYX8NnAXZyuHv0sJoMV
        /v7VvJAkFqm/womIg/mbDjxf/r5vUwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625047756;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b0HNvCVvy7/EJa/w0/2tgbsYknPwd+OPPcwT4ybe3FY=;
        b=otYyar+b1emai5NZ3jmtQy4/hiFCFP3mq0pzyQS6J7qiRdDRp+2xhEmPINsAxK23cpZ/YF
        I+Ahet5FHTQdFyBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1E8E9A3B8C;
        Wed, 30 Jun 2021 10:09:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1F34FDA7A2; Wed, 30 Jun 2021 12:06:45 +0200 (CEST)
Date:   Wed, 30 Jun 2021 12:06:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: improve logging message for auto reclaim
Message-ID: <20210630100644.GI2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
References: <3786140da052ad5067bc6d2990325519c4abd1e0.1624904192.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3786140da052ad5067bc6d2990325519c4abd1e0.1624904192.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 29, 2021 at 03:16:46AM +0900, Johannes Thumshirn wrote:
> When we're automatically reclaiming a zone, because its zone_unusable
> value is above the reclaim threshold, we're only logging how much percent
> of the zone's capacity are used, but not how much of the capacity is unusable.
> 
> Also print the percentage of the unusable space in the block group before
> we're reclaiming it.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Added to misc-next, thanks.
