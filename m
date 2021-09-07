Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B69C402A28
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Sep 2021 15:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhIGNwC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 09:52:02 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60922 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhIGNvw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Sep 2021 09:51:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DF0DF220CD;
        Tue,  7 Sep 2021 13:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631022645;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PYC7e5k1cSSpXALcWYX5WNB6pcicF+YzYj4qIPVWaOc=;
        b=o5N/yeZrP2NBd8H92Mk7ta+KcHEb2C7IMyU/wXU1RYYvmSSY0Ra9b0CwQ3mFcMS0wms0Cw
        eiM7ElEGxJArXRvNGW9SKBxl2JQm+r8ppE5emPsWQBAMSkFtZzC4ThJI9Wz4Z/bB+RLB3X
        L8at1Hm9QeS/B+p5aeJh+5aYndpwMI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631022645;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PYC7e5k1cSSpXALcWYX5WNB6pcicF+YzYj4qIPVWaOc=;
        b=uaBdDzsGLesqv2FvFnogIqxzJzyXaLyRLhn9EVB+JBek9t+RNBuDVY5jX41e3DcdnhTYbv
        3M7O/6uGyQUbPJAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D7ADBA3BA0;
        Tue,  7 Sep 2021 13:50:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 96C88DA7E1; Tue,  7 Sep 2021 15:50:41 +0200 (CEST)
Date:   Tue, 7 Sep 2021 15:50:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs-progs: fi show: Print missing device for a
 mounted file system
Message-ID: <20210907135041.GO3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210902100643.1075385-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902100643.1075385-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 02, 2021 at 01:06:42PM +0300, Nikolay Borisov wrote:
> Currently when a device is missing for a mounted filesystem the output
> that is produced is unhelpful:
> 
> Label: none  uuid: 139ef309-021f-4b98-a3a8-ce230a83b1e2
> 	Total devices 2 FS bytes used 128.00KiB
> 	devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
> 	*** Some devices missing
> 
> While the context which prints this is perfectly capable of showing
> which device exactly is missing, like so:
> 
> Label: none  uuid: 4a85a40b-9b79-4bde-8e52-c65a550a176b
> 	Total devices 2 FS bytes used 128.00KiB
> 	devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
> 	devid    2 size 0 used 0 path /dev/loop1 ***MISSING***

There was a discussion regarding the output, so what's the last version?
The path is not always available, so how does the output look like in
that case? I'd vote against the *** markers and rather establish some
parseable format, like

 	devid    2 size 0 used 0 MISSING (last: /dev/loop1)

The path is optional so it would bebetter to put it at the end.
