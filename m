Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A6442A234
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Oct 2021 12:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbhJLKhL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Oct 2021 06:37:11 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36272 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235796AbhJLKhK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Oct 2021 06:37:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 36E5E220E9;
        Tue, 12 Oct 2021 10:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634034908;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gPYFcvkLgcM2UFltvFtZ1DeJLZ2t8LN4RspcEwl8wAE=;
        b=c9F5bE8p4JXC20EEnkH6XDKyr90AAPq9DWMPzprYA9Ya9koAqvKTDFy43nn9ks+5DXXbH2
        yB8qVefpoSyIp6hRtmg1X9lqAdn3wma7ne/fsfC/EHnvSMQUJzaRW8yzO/GpJqfOR+IjqG
        zg3/uz2b2kBfiXof0/7/GEELqd+4znM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634034908;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gPYFcvkLgcM2UFltvFtZ1DeJLZ2t8LN4RspcEwl8wAE=;
        b=i6/Kd5UJ60Yp7fcqn+PJK8Zd2w46oHe9sWAYo3pOxMo3WOTfZ+/DpqF2wcA5wDgpAzDxQf
        K+qMHVvcFS+3pVCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2EA6CA3B89;
        Tue, 12 Oct 2021 10:35:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AA4EEDA781; Tue, 12 Oct 2021 12:34:44 +0200 (CEST)
Date:   Tue, 12 Oct 2021 12:34:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: test-misc: search the backup slot to use at
 runtime
Message-ID: <20211012103444.GX9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211012083712.31592-1-wqu@suse.com>
 <20211012101230.GV9286@twin.jikos.cz>
 <c2919020-bbdd-be93-7293-a2270df45dfa@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2919020-bbdd-be93-7293-a2270df45dfa@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 12, 2021 at 06:19:44PM +0800, Qu Wenruo wrote:
> >> +slot_num=$(echo $found | cut -f1 -d:)
> >> +# To follow the dump-super output, where backup slot starts at 0.
> >> +slot_num=$(($slot_num - 1))
> >> +
> >> +# Save the backup slot info into the log
> >> +_log "Backup slot $slot_num will be utilized"
> >> +dump_super | grep -A9 "backup $slot_num:" >> "$RESULTS"
> > 
> > Please don't use the $RESULTS in tests, it's an implementation detail
> > and there should always be helpers hiding, in this case it's run_check.
> 
> In this particular case, won't run_check dump all the output into the log?
> 
> As here we only want the grep result to be output, not the full dump_super.

Sorry, I was not specific, what I meant is:

"dump_super | run_check grep ..."

so only the result of grep ends up in the log.

> >>   run_check "$INTERNAL_BIN/btrfs-corrupt-block" -m $main_root_ptr -f generation "$TEST_DEV"
> >                                                      ^^^^^^^^^^^^^^
> > 
> > Please always quote variables (unless there's a reason not to like for
> > $SUDO_HELPER).
> 
> Forgot it again, but it should be safe as $main_root_ptr should just be 
> a u64 number.
> 
> But yeah, I should quote it...

I know in this case it's clear there's a number, the point is
consistency of the whole testsuite, so one does not have to think if
this unquoted variable is ok or not. The initialization may happen in
other context or lines away or the variable name could be misleading.

IIRC I've seen some commands fail and instead of a single word in the
output there was the error message. Quoting makes it fail at least
somehow safely instead of letting the variable words be interpreted as
individual parameters.
