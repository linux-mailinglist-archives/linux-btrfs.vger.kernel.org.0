Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6163ED85E
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Aug 2021 16:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbhHPOBJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Aug 2021 10:01:09 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59906 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbhHPN70 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Aug 2021 09:59:26 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7229321DBE;
        Mon, 16 Aug 2021 13:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629122299;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=inAKI4z9w5AAAPtQI6gH3Ohr5GGE1IG9AJWLT2A1sZU=;
        b=qBsPbcURwXDG28Qiodphf9of6yy9Hpr4e1xVuxlJVBDuTQV4BXJm9jVppSj2P/YdqTUSMU
        M+14gmoMDAHM26Tc3jiLqiOZZtVCbwNtX1Y/mW/HfsHWa5Cg7e5GprsW9IY7GqBcO3azs5
        3+xbqgCJ+Rr9JtMp7doLc/dL4ijZP6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629122299;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=inAKI4z9w5AAAPtQI6gH3Ohr5GGE1IG9AJWLT2A1sZU=;
        b=adPiJ+MhAHOh0ST1u3TJ9pgzcQS/gykdvoFlZs9jT2vzI/JPwMRc+csg+MPg3gdlmX3e4B
        3id3LjLWLo8EWaAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6ACD3A3B96;
        Mon, 16 Aug 2021 13:58:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 85A96DA72C; Mon, 16 Aug 2021 15:55:23 +0200 (CEST)
Date:   Mon, 16 Aug 2021 15:55:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/2] Preemptive flushing fixes
Message-ID: <20210816135523.GB5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1628706812.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1628706812.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 11, 2021 at 02:37:14PM -0400, Josef Bacik wrote:
> Hello,
> 
> I thought I had fixed the preemptive flushing burning CPU's problem with my
> previous set of fixes, but I was wrong.  However those tracepoints gave me the
> information I needed to fix the problem properly.  The first patch
> 
> btrfs: reduce the preemptive flushing threshold to 90%
> 
> can go back to stable and make its way into the distros to stop the pain for the
> current users having problems.  The second patch augments the fix with a little
> less of a strong hammer.
> 
> The problem is for very full file systems on slower disks will end up with a
> very small threshold to start preemptive flushing.  We were relying on sanity
> checks to bail out ahead of time, however they were not strong enough.  These
> problematic cases existed in the short area where there was enough space to
> operate without needing to do synchronous flushing, but not enough space to
> avoid flushing all of the time.
> 
> The fix is to adjust the sanity checks to something more reasonable to account
> for these cases and avoid spinning doing preemptive flushing constantly.
> Thanks,
> 
> Josef
> 
> Josef Bacik (2):
>   btrfs: reduce the preemptive flushing threshold to 90%
>   btrfs: do not do preemptive flushing if the majority is global rsv

Added to misc-next, thanks.
