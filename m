Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4324C7846
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 19:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbiB1Sp4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 13:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbiB1Sph (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 13:45:37 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C476929A
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 10:44:43 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7E3811F3A3;
        Mon, 28 Feb 2022 18:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646073882;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QH+eSFejQIi+Q8BZrIrE208S32lL3sf3H6EvD8kAmWQ=;
        b=mZMRHSgvBGYpRsqDVM/fRAbpa1ziRMkHwMNf88jwllXavPFzNxaHxfb8Iw6R36QWwZMfRk
        E+ttAEzqLpnxYqiXu9OJsJTErKWihnYLI2hK/dggtR7fNm8c4BAIJCMusiBdG4ns9GZ08P
        SwUjeVLSCeGdtMDi1w7+wZTPlf4jfE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646073882;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QH+eSFejQIi+Q8BZrIrE208S32lL3sf3H6EvD8kAmWQ=;
        b=lwYGW1yV6gtm/h3rUJMIE84opwKt6Ga6eZ+Pf7ZUp73yM9QV1Y24kxemCWB5Bbb+oimSpm
        8izGmUnSD8dSSzCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 627D4A3B83;
        Mon, 28 Feb 2022 18:44:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1CEB9DA823; Mon, 28 Feb 2022 19:40:50 +0100 (CET)
Date:   Mon, 28 Feb 2022 19:40:50 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        dsterba@suse.cz,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
Subject: Re: Seed device is broken, again.
Message-ID: <20220228184050.GJ12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
References: <88176dfc-2500-1e9c-bac0-5e293b2c0b5c@suse.com>
 <20220225114729.GE12643@twin.jikos.cz>
 <56a6fe34-7556-c6c3-68da-f3ada22bd5ba@gmx.com>
 <YhkrfyzmCgOGG+5n@relinquished.localdomain>
 <f4525052-8938-42f9-543d-c333200353dd@gmx.com>
 <43aea7a1-7b4b-8285-020b-7747a29dc9a6@oracle.com>
 <00f162f7-774c-b7d4-9d1f-e04cc89b2aee@gmx.com>
 <508772bc-237a-552b-5b63-80827a5b268a@oracle.com>
 <4661c891-b15e-3a8f-6b98-f298e104262e@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4661c891-b15e-3a8f-6b98-f298e104262e@gmx.com>
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

On Mon, Feb 28, 2022 at 11:27:16AM +0800, Qu Wenruo wrote:
> > Ah. That's fine, IMO. It is a matter of understanding the nature of the
> > seed device. No?
> > The RO mount used to turn into an RW mount after the device-add a long
> > ago. It got changed without a trace.
> 
> Think twice about this, have you every seen another fs allowing a RO
> mount to be converted to RW without even remounting?

There's no other filesystem with a remotely close feature so we can't
follow an established pattern.

The ro->rw transition can be done from inside the filesystem too and
btrfs sort of does that in btrfs_mount, calling kern_mount.

> Still think this doesn't provide any surprise to end users?

The RO status means the filesystem does not support any write operations
from the user perspective that go through VFS. Adding the device in the
seed mode modifies the filesystem structures, ie. changes the block
device, but does not change the VFS status regarding writability.  The
read-write remount is mandatory to actually make use of the writable
device. This is documented and I don't find it confusing from the end
user perspective.

If you're concerned that there's a write to the block device then yes,
it's a bug that the mnt_set_write should be done just before we start
any change operation.

There was a discussion some time ago if the log replay should happen on
a read-only mount, or any potential repair action that could happen
regardless of the ro/rw mount status. The conclusion was that it could
happen, and guaranteeing no writes to the block device should be done
externally eg. by blockdev --setro. But I think we opted not to do any
writes anyway for btrfs.
