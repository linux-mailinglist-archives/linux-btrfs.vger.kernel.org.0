Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503C33BEA24
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jul 2021 16:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbhGGO73 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jul 2021 10:59:29 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38416 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbhGGO7O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jul 2021 10:59:14 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1C2C722251;
        Wed,  7 Jul 2021 14:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625669602;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1K0uj2UaKKCEgLmDi0NyOHurtBzFDbCrqUYA741JTNc=;
        b=oJja2kgWV+c/8lLnw4tg/rINhEN7M6cA8wVmaYXzElKJwNc40beBBe62waUqleQOcYzHiK
        HhPuS8b4uBjhiRrVh11pSdugChc2vlY6yO5H6d5VYbxZP1jssHCUn1Ku4Myzitr3BLxom3
        +6KT0iCrj6ZKAv4BUUQKnNtfCdwc6a4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625669602;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1K0uj2UaKKCEgLmDi0NyOHurtBzFDbCrqUYA741JTNc=;
        b=dhX7TKNrHWxthttH8Dq/MAxgv3EWfwpGg1JQ3/ZEQURDykG3dR8g5GtqTbpE6KoS8skE8P
        1xEDmF5iVmp5bdAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DC314A3B9F;
        Wed,  7 Jul 2021 14:53:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 36C4DDA6FD; Wed,  7 Jul 2021 16:50:48 +0200 (CEST)
Date:   Wed, 7 Jul 2021 16:50:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH] btrfs-progs:  default to SINGLE profile on zoned devices
Message-ID: <20210707145048.GK2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <20210706091922.38650-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706091922.38650-1-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 06, 2021 at 06:19:22PM +0900, Johannes Thumshirn wrote:
> On zoned devices we're currently not supporting any other block group
> profile than the SINGLE profile, so pick it as default value otherwise a
> user would have to specify it manually at mkfs time for rotational zoned
> devices.

Yes this is annoying but careful with setting defaults, it's hard to
change them. And in case of zoned devices it will be possible to set
something else in the future so defaulting to single/single needs to be
justified in another way than "currently we don't support anything
else".

The SSD fallback to single is not showing as useful and there's ongoing
work to make it default to dup for metadata again. For consistency I'd
rather have simple logic for selecting defaults and give hints
eventually instead of checking random things in the system and then
selectin on behalf of the user. Unfortunatelly it's not that easy as
there are conflicting valid interests and we don't have defaults that
fits all scenarios.
