Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278A74165E9
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 21:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242842AbhIWTVK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Sep 2021 15:21:10 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49094 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242823AbhIWTVG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Sep 2021 15:21:06 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out1.suse.de (Postfix) with ESMTP id A2D6D22379;
        Thu, 23 Sep 2021 19:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632424773;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b4PCGxdwO00IQDRMf4Mbw7o6f6bDiH7PYetmvgtfMv0=;
        b=IkqwiFoB+1de9HXcvv0WYAdK6Aq/kIBiSMr84Fpd8iX/MSOt9vD4bqqnHNUp/hvp0PdaUe
        NytiahIyv960rlx69Bf/Qi0LwebH3bDWnEgZkP4KODrBz7/zyoJllle45SMs2lPyC7jOc5
        5eKI2Wy1QEflm0j3gV1s9L6fViV8ye4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632424773;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b4PCGxdwO00IQDRMf4Mbw7o6f6bDiH7PYetmvgtfMv0=;
        b=VPVVbWX9JdqaU1e7Xusa+nOGls4KJb2lzqrol1j+pZcJeGuhGBEIl2cMWpE3O55+Bk+hlO
        QklwrbjUjBZ4E/BA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay1.suse.de (Postfix) with ESMTP id 6F85925D3C;
        Thu, 23 Sep 2021 19:19:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6F91EDA799; Thu, 23 Sep 2021 21:19:20 +0200 (CEST)
Date:   Thu, 23 Sep 2021 21:19:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: remove max_zone_append_size logic
Message-ID: <20210923191920.GX9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20210923124221.14530-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923124221.14530-1-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 23, 2021 at 09:42:21PM +0900, Johannes Thumshirn wrote:
> max_zone_append_size is unused and can as well be removed just like we did
> on the kernel side.
> 
> Keep one sanity check though, so we're not adding devices to a zoned FS
> that aren't supporting zone append.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Added to devel, thanks.
