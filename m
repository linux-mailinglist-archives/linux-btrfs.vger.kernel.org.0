Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15DDD49B668
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jan 2022 15:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578544AbiAYOfh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jan 2022 09:35:37 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44714 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578639AbiAYOUs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jan 2022 09:20:48 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EB6C321763;
        Tue, 25 Jan 2022 14:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643120441;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2AitzbZxhYn9Qq4+X8CLbblXlJ1YDMgg6DHrmrlhH8M=;
        b=fscLs5/eX5IMFmaxJU1BbUPKGYlQeRIuSnZKJfC56f11DqqyuVdF0LzO+6EGhpxoR11tRZ
        Zl58eP0iXolI4W9ycvNo7qVCKCG//b+ioaPhIoPbErfG25RnrHru5yo1n8CSuObfSCWhME
        tfKR4yjDOsS6Wh8vZ/GyYlTy9jFBpBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643120441;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2AitzbZxhYn9Qq4+X8CLbblXlJ1YDMgg6DHrmrlhH8M=;
        b=XNAR/v+xP+v/IGDrBajXhDeBKLCwZODa2ua3PzfYoXYGNZYVWFxM5Q/DUx0B9iu5t/GFXa
        edojQclthkIAswAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BC784A3B87;
        Tue, 25 Jan 2022 14:20:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 77C4ADA7A9; Tue, 25 Jan 2022 15:20:01 +0100 (CET)
Date:   Tue, 25 Jan 2022 15:20:01 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohire.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] btrfs-progs: add udev rule to use mq-deadline on zoned
 btrfs
Message-ID: <20220125142001.GP14046@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohire.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
References: <20220125132200.56122-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125132200.56122-1-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 25, 2022 at 05:22:00AM -0800, Johannes Thumshirn wrote:
> As zoned btrfs uses regular writes for metadata, it needs zone write
> locking in the IO scheduler. Add a udev rule that configures an IO
> scheduler doing zone write locking.

I'm not sure how the udev rules are distributed nowadays, if it's
supposed to be packaged with the tools themselves or with
systemd-something.  No problem adding it to btrfs-progs git but there
may be other parties interested.

Also, is there some sanity check in the zoned device driver to make sure
the mq-deadline is selected? To avoid accidental problems. Maybe we can
add some progs checks to to mkfs, if it makes sense to hardcode the io
scheduler name as they come and go in a rapid succession (measured on
geological time scale).
