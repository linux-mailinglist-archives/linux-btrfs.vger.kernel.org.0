Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E585A4C913E
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Mar 2022 18:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbiCAROL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Mar 2022 12:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236343AbiCAROJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Mar 2022 12:14:09 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E43849F84
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Mar 2022 09:13:23 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9857921891;
        Tue,  1 Mar 2022 17:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646154802;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KKYcmplxr3LZpVyzH5HZ56YbZt5colDKdN0mGTJJWvE=;
        b=boBKQ2gP8m8SZQpoM3tNYEwReAJKsoXnXQGx3LRj8zb3Wz0tTMvgX3n5mJbrkJeoivFuaz
        ER75ZlmU8T7n909lyBG+InQ+iUK8nB6E58CWHGstm6HjPI2woKPxbo/M3F2XWt9d4OrQ6+
        kd5VNbOpWSgXdsJX0XArzkFtOj/BC14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646154802;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KKYcmplxr3LZpVyzH5HZ56YbZt5colDKdN0mGTJJWvE=;
        b=v9l0gRfzSKn5/DV5UZsIplgdELtEX5D/TFIgvDo2bcD2pEeUQbmXRbQovD2L/UlR78vqK5
        Rcxuj1EuFUH8hwCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 89AD9A3B93;
        Tue,  1 Mar 2022 17:13:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DA155DA80E; Tue,  1 Mar 2022 18:09:30 +0100 (CET)
Date:   Tue, 1 Mar 2022 18:09:30 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
Subject: Re: Seed device is broken, again.
Message-ID: <20220301170930.GR12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
References: <20220225114729.GE12643@twin.jikos.cz>
 <56a6fe34-7556-c6c3-68da-f3ada22bd5ba@gmx.com>
 <YhkrfyzmCgOGG+5n@relinquished.localdomain>
 <f4525052-8938-42f9-543d-c333200353dd@gmx.com>
 <43aea7a1-7b4b-8285-020b-7747a29dc9a6@oracle.com>
 <00f162f7-774c-b7d4-9d1f-e04cc89b2aee@gmx.com>
 <508772bc-237a-552b-5b63-80827a5b268a@oracle.com>
 <4661c891-b15e-3a8f-6b98-f298e104262e@gmx.com>
 <20220228184050.GJ12643@twin.jikos.cz>
 <7feddd5a-856c-a525-a05c-fd682574aa49@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7feddd5a-856c-a525-a05c-fd682574aa49@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 01, 2022 at 08:13:28AM +0800, Qu Wenruo wrote:
> 
> >
> > There was a discussion some time ago if the log replay should happen on
> > a read-only mount, or any potential repair action that could happen
> > regardless of the ro/rw mount status. The conclusion was that it could
> > happen, and guaranteeing no writes to the block device should be done
> > externally eg. by blockdev --setro. But I think we opted not to do any
> > writes anyway for btrfs.
> 
> My main concern is still there, we change RO to RW without any remount.

We also do emergency remount from RO to RW, so I take it as that
changing the status is partiall in the hands of filesystem, not
violating APIs and such.

> It's weird from the beginning, but we just accept that.
> 
> If we have chance to rethink this, would we still take the same path?
> Other than making seed device into user space tool like mkfs?

I'm not sure it would work the same way as now, the seeding device can
be mounted several times in parallel as the UUID is generated at each
mount, then added the writeable device, then thrown away. Any detour
through userspace make it more complicated, but I haven't thought that
through. We could add it no top of the on-line seeding as another
usecase but if current users are fine with how it works now I don't
think we need to spend time on implementing it.
