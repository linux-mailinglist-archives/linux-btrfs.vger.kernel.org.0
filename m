Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B6D475B91
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 16:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbhLOPNd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 10:13:33 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47282 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhLOPNd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 10:13:33 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 12E6C1F3CB;
        Wed, 15 Dec 2021 15:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639581212;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9ufEwkcdsSkJpJuyJNI2NLlABMGgou4vWZbF5PLiddc=;
        b=lsuCrUlIAgNAG4Gs5jUy+dwiN5wPonMwC4pQ9/rZDJGC1ciol7F7N5yHDnBEpVVPICriZX
        LTjQnqTHNsCC04BO+tEtgWgZZfHT5Mnt7/5V/SCfcXBSLKGESqsVb9Q9TuztfKP706dagi
        fY47de2ebPa2Kv49TwFZ/ZTmZM1/Mvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639581212;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9ufEwkcdsSkJpJuyJNI2NLlABMGgou4vWZbF5PLiddc=;
        b=Ya9gs4VdbsMYdQoRIliZtjqzTb2zQewivAepQN+iiVM5hdW/Hz794Mzc6u5tNAyd9y9WXk
        mCflas5p4bo8N7Dw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0AC94A3B8A;
        Wed, 15 Dec 2021 15:13:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2041FDA781; Wed, 15 Dec 2021 16:13:13 +0100 (CET)
Date:   Wed, 15 Dec 2021 16:13:13 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/6] Support resize and device delete cancel ops
Message-ID: <20211215151313.GZ28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1621526221.git.dsterba@suse.com>
 <8af5cc22-bc1f-907b-2447-d60f9587c887@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8af5cc22-bc1f-907b-2447-d60f9587c887@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 14, 2021 at 10:49:37PM +0800, Anand Jain wrote:
> 
> On 21/05/2021 20:06, David Sterba wrote:
> > We don't have a nice interface to cancel the resize or device deletion
> > from a command. Since recently, both commands can be interrupted by a
> > signal, which also means Ctrl-C from terminal, but given the long
> > history of absence of the commands I think this is not yet well known.
> > 
> > Examples:
> > 
> >    $ btrfs fi resize -10G /mnt
> >    ...
> >    $ btrfs fi resize cancel /mnt
> > 
> >    $ btrfs device delete /dev/sdx /mnt
> >    ...
> >    $ btrfs device delete cancel /mnt
> 
> 
> David,
> 
> These cancel commands don't fail with un-supported ioctl error codes on 
> the older kernels as we didn't define a new ioctl for this purpose.
> 
> Generally, the latest btrfs-progs are compatible with the older kernels, 
> especially useful for the fsck fixes.
> 
> Moving forward does the newer btrfs-progs version will continue to be 
> compatible with the older kernels?

Yes, the compatibility of old kernel and new (latest) progs is supposed
to be maintained, eg. by adding checks for supported features or if the
ioctls work, version check is the last resort.
