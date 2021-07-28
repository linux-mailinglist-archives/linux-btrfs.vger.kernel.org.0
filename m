Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CAD3D8E48
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 14:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbhG1Mw0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 08:52:26 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52388 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235130AbhG1MwZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 08:52:25 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6742C22289;
        Wed, 28 Jul 2021 12:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627476743;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oRqwjLY1lMsx5G7GBghoCJ1wbxI2ogqQgpF3xp29uJ4=;
        b=PKfleePcsLW3LrHXGyfz7l3I5ijcdBctD3otSb9BGoYAnD7NuFztFyx/pUQvqbTSOuv3lh
        K1RsN6iNxvIjj16m/agVPuzd24Dd4mdDPciL9QdRlr+poYHkFdFgvCbq34zPfrRfVbvTpi
        oyvaSm+if0Y3izTqTNh7P6V1U4vbr7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627476743;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oRqwjLY1lMsx5G7GBghoCJ1wbxI2ogqQgpF3xp29uJ4=;
        b=QI0Tu6HLmW6Jcs0yD3R3kxqShG0VQ4V8kgLvUjCJbaHJCb31Ye946W1BOShezUnbWAMYoP
        u17QoHeIZK6++PAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5F6A3A3B81;
        Wed, 28 Jul 2021 12:52:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7DC48DA8A7; Wed, 28 Jul 2021 14:49:38 +0200 (CEST)
Date:   Wed, 28 Jul 2021 14:49:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: optimize check_raid_min_devices drop ret
Message-ID: <20210728124938.GD5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <1523fbf731f23108f3b490600d1dbb1c9a6360fc.1627426829.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523fbf731f23108f3b490600d1dbb1c9a6360fc.1627426829.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 28, 2021 at 07:03:05AM +0800, Anand Jain wrote:
> Function btrfs_check_raid_min_devices() returns error code from the enum
> btrfs_err_code and it starts from 1. So there is no need to check if ret
> is > 0. So drop this check and also drop the local variable ret.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Added to misc-next, thanks.
