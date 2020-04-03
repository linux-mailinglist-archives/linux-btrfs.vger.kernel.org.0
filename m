Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF07119DD72
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Apr 2020 20:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgDCSF2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Apr 2020 14:05:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36000 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728219AbgDCSF2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Apr 2020 14:05:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id n10so3879226pff.3
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Apr 2020 11:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m7KNNakCxzyCDeyW1nXNPV2KgpJMsyfUpwmheHCyCEc=;
        b=RieReGF/6edy7+7N8WPrQoEAmsuWgn95QdIUDxqfQ6OghnuDQNHApgeMhy3tN7p7/Z
         yOm+Bp1MFkze7hAgbEgFwXKISf7WEjm5c1wl26mi5nuyNhrKkNjD3RIW6XamE9e88ZGj
         K9em3JcVbdnufv6vr978GXvV4cDfWiMsH+9l68pGpSklIj4XXiZyIIl6heIBh2vZTTwX
         t3DE2qsozm22GH0WQ/Zug4gP0Ea9LStqqUM1kjDIZUFrSTCvRNobYF71CAgLysYSLN4o
         E7YydvD951M6et9UoO0ZsCpRoXSJCBWwF1Sxk2rxQYqwoijqRCIyBIANjiVQeYEwrVdi
         uthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m7KNNakCxzyCDeyW1nXNPV2KgpJMsyfUpwmheHCyCEc=;
        b=rlmDip0uwUz3+wJ/Br45JX9nwIu3TtMlEXfwU/q14jjSpt6ouj4LTeOE3gxpgF4Pnm
         nED2hvm4z0bJqHaUI2I6ujCZEQeauPdpkvC2k0iHB0yf8GcbD/EqCitFHGPyDAxhIMUw
         IrQ9a2eHk89JzdJQ44FN0WG8N7sLQ/h3JwSROQDfoVrDv7uxDPJ920zCFe0FN/5G3W7K
         jskj7KlmZTm1I+qyoEEcN4/nxeGUt3b/+HGozsz+2ZBtJEz1yaokh5YzDfmaUGyd+3Qv
         gsVeFCr8g152OINnxom295PpAXaieRD6y7HWDqFfNrMjZ5LrZmH8ya6QcCFK2p13fL/K
         0xjw==
X-Gm-Message-State: AGi0PuYrZvephJNjHHMkwy3xZMeF6ebmzexIGmElbkY7zoKXG641gKtK
        5634WtzhPidUe1cH6MmF7dFziQ==
X-Google-Smtp-Source: APiQypIKhujtADPHv+DVPka2hctyKzuB6o8tHtR1EBEEz7chPoMUabtRH1soKSeRuu7lo4R7ytxiCg==
X-Received: by 2002:a63:7511:: with SMTP id q17mr9236738pgc.90.1585937126818;
        Fri, 03 Apr 2020 11:05:26 -0700 (PDT)
Received: from vader ([2620:10d:c090:400::5:30ea])
        by smtp.gmail.com with ESMTPSA id i7sm6306554pfq.217.2020.04.03.11.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 11:05:26 -0700 (PDT)
Date:   Fri, 3 Apr 2020 11:05:23 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 13/15] btrfs: simplify direct I/O read repair
Message-ID: <20200403180523.GA189126@vader>
References: <cover.1583789410.git.osandov@fb.com>
 <38cea444fa3f88ca514d161bd979d004c254e969.1583789410.git.osandov@fb.com>
 <20200403164050.GH5920@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403164050.GH5920@twin.jikos.cz>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 03, 2020 at 06:40:51PM +0200, David Sterba wrote:
> On Mon, Mar 09, 2020 at 02:32:39PM -0700, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > Direct I/O read repair is an over-complicated mess. There is major code
> > duplication between __btrfs_subio_endio_read() (checks checksums and
> > handles I/O errors for files with checksums),
> > __btrfs_correct_data_nocsum() (handles I/O errors for files without
> > checksums), btrfs_retry_endio() (checks checksums and handles I/O errors
> > for retries of files with checksums), and btrfs_retry_endio_nocsum()
> > (handles I/O errors for retries of files without checksum). If it sounds
> > like these should be one function, that's because they should.
> > 
> > After the previous commit getting rid of orig_bio, we can reuse the same
> > endio callback for repair I/O and the original I/O, we just need to
> > track the file offset and original iterator in the repair bio. We can
> > also unify the handling of files with and without checksums and replace
> > the atrocity that was probably the inspiration for "Go To Statement
> > Considered Harmful" with normal loops. We also no longer have to wait
> > for each repair I/O to complete one by one.
> 
> This patch looks like a revert of 8b110e393c5a ("Btrfs: implement repair
> function when direct read fails"), that probably added the extra layer
> you're removing.
> 
> So instead of the funny remarks, I'd rather see some analysis that the
> issues in the original patch are not coming back.  Quoting from the
> changelog:
> 
> - When we find the data is not right, we try to read the data from the other
>   mirror.
> - When the io on the mirror ends, we will insert the endio work into the
>   dedicated btrfs workqueue, not common read endio workqueue, because the
>   original endio work is still blocked in the btrfs endio workqueue, if we
>   insert the endio work of the io on the mirror into that workqueue, deadlock
>   would happen.
> - After we get right data, we write it back to the corrupted mirror.
> - And if the data on the new mirror is still corrupted, we will try next
>   mirror until we read right data or all the mirrors are traversed.
> - After the above work, we set the uptodate flag according to the result.
> 
> It's not too detailed either, but what immediatelly looks suspicious is
> the extra workqueue that was added to avoid deadlocks. That is now going
> to be removed. This seems like a high level change even for such an old
> code (2014) so that its effects are not affected by some other changes
> in the dio code.

This patch doesn't touch the extra workqueue. The next patch that gets
rid of it has an explanation:

    This was originally added in commit 8b110e393c5a ("Btrfs: implement
    repair function when direct read fails") because the original bio waited
    for the repair bio to complete, so the repair I/O couldn't go through
    the same workqueue. As of the previous commit, this is no longer true,
    so this separate workqueue is unnecessary.

I can expand on that for v2. The deadlock addressed by the original code
is pretty much that while the worker is executing the original bio, it
will be blocked on the repair bio completing, and the repair bio will be
blocked on the worker finishing the original bio. With this rework, the
original bio doesn't block on the repair bio, so the worker becomes
available for the repair bio right away.
