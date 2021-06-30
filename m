Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D033B814D
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jun 2021 13:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbhF3LcR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Jun 2021 07:32:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36986 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbhF3LcQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Jun 2021 07:32:16 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 194891FE76;
        Wed, 30 Jun 2021 11:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625052587;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xPlVznWY17sCdzDew0ArEqg6XigOQOCtFmbDtY+DTDg=;
        b=ahMFe4kxqAr6ueSduanu8ivNo0m8vDKaSEkb4pG/Qi/05WQRTOrGkzh1J40pYoAJ3KBikV
        M5JYxKcMeW0svIA/2h2D7Veog/xZ+B8jDsWLdxSJDpkdqWV9IphicqsKgIpyp5JJEPF1Oh
        R9PvwOBQhAK+NvxsEWVRcSz7joKLYXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625052587;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xPlVznWY17sCdzDew0ArEqg6XigOQOCtFmbDtY+DTDg=;
        b=ISanfFyNsTDcmf/hJGeEewWmmA9CgWCXw2JvPbz70fjhijtToL0lFRU1PwRQLCUjZpzy/+
        +yWiGRLd8SPAPQBQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id BC248118DD;
        Wed, 30 Jun 2021 11:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625052587;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xPlVznWY17sCdzDew0ArEqg6XigOQOCtFmbDtY+DTDg=;
        b=ahMFe4kxqAr6ueSduanu8ivNo0m8vDKaSEkb4pG/Qi/05WQRTOrGkzh1J40pYoAJ3KBikV
        M5JYxKcMeW0svIA/2h2D7Veog/xZ+B8jDsWLdxSJDpkdqWV9IphicqsKgIpyp5JJEPF1Oh
        R9PvwOBQhAK+NvxsEWVRcSz7joKLYXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625052587;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xPlVznWY17sCdzDew0ArEqg6XigOQOCtFmbDtY+DTDg=;
        b=ISanfFyNsTDcmf/hJGeEewWmmA9CgWCXw2JvPbz70fjhijtToL0lFRU1PwRQLCUjZpzy/+
        +yWiGRLd8SPAPQBQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id ImMGLKpV3GD+LgAALh3uQQ
        (envelope-from <pvorel@suse.cz>); Wed, 30 Jun 2021 11:29:46 +0000
Date:   Wed, 30 Jun 2021 13:29:45 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>, Chris Mason <clm@fb.com>,
        "kernel-team@lists.ubuntu.com" <kernel-team@lists.ubuntu.com>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>,
        David Sterba <dsterba@suse.com>,
        Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [LTP] [BUG] btrfs potential failure on 32 core LTP test
 (fallocate05)
Message-ID: <YNxVqca+WeQcBmzA@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <a3b42abc-6996-ab06-ea9f-238e7c6f08d7@canonical.com>
 <e4c71c01-ed70-10a6-be4d-11966d1fcb75@toxicpanda.com>
 <b5c6779b-f11d-661e-18c5-569a07f6fd8e@canonical.com>
 <YNxTr43lvviG0GOn@pevik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNxTr43lvviG0GOn@pevik>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

...
> > >> Reproduction steps:
> > >> git clone https://github.com/linux-test-project/ltp.git
> > >> cd ltp
> > >> ./build.sh && make install -j8
> > >> cd ../ltp-install
> > >> sudo ./runltp -f syscalls -s fallocate05

NOTE: you can also be a bit faster if you test just single test, see
https://github.com/linux-test-project/ltp#shortcut-to-running-a-single-test
(not compiling and installing whole LTP)

$ cd testcases/kernel/syscalls/fallocate/
$ make -j`nproc`
$ sudo ./fallocate05

> > > This thing keeps trying to test ext2, how do I make it only test btrfs?  Thanks,

> > It tests all available file systems, just wait till it gets to btrfs. I
> > don't know how to limit it only to one file system.
> In the future we can add environment variable to specify the only fs to be
> tested. There is LTP_DEV_FS_TYPE, but that does not work when .all_filesystems
> flag is enabled. Thus just patch the file:

NOTE: It detect kernel filesystem support and presence of mkfs.xxx.
Thus other way to limit filesystem is to rename mkfs.xxx of other filesystems
(in case you test LTP from package and don't want / cannot compile and can
modify root filesystem).

Kind regards,
Petr
