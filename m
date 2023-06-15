Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1F3731CD3
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jun 2023 17:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241289AbjFOPip (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Jun 2023 11:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240831AbjFOPio (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Jun 2023 11:38:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFAFB6
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Jun 2023 08:38:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ECB9821AD6;
        Thu, 15 Jun 2023 15:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686843519;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rqliqehYRw2IQGl4Md8P8HAfIUDp7Y6g9GFrTwKSfxk=;
        b=bNeC3jArOwNTbOAX/kf9MupLW6rL5GVHd88q8shDtGuy5qd0MyCVDFNpbXKeWqeY943HLj
        qVihunhb1h3mgGOgXMQ30FclpOG5zWAgGryMbuHQQYb4OOqL1D0gW6/sGbui8/018DeKky
        dH0v3QL6L3Q3M5lyT5rldd9ZbUe2tmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686843519;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rqliqehYRw2IQGl4Md8P8HAfIUDp7Y6g9GFrTwKSfxk=;
        b=rPZC/416IpmUnaL7Nzm4igOIo5DLhgCq7I2rG7IwshaCvqVsG6VYQIJPmpApxkXo+2sdtx
        gWhpOZaAqWIiiuAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B7ED613467;
        Thu, 15 Jun 2023 15:38:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZZzrK38wi2SvGwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 15 Jun 2023 15:38:39 +0000
Date:   Thu, 15 Jun 2023 17:32:19 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Regression that causes data csum mismatch
Message-ID: <20230615153219.GX13486@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <da414ecc-f329-48ec-94d2-67c94755effb@gmx.com>
 <20230613160247.GK13486@twin.jikos.cz>
 <0523f743-38e0-bc21-df4e-6a9d4e842ecf@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0523f743-38e0-bc21-df4e-6a9d4e842ecf@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 14, 2023 at 06:17:31AM +0800, Qu Wenruo wrote:
> On 2023/6/14 00:02, David Sterba wrote:
> > It would be good to share the updates to fstests with the tests. I've
> > added the data csum check to _check_btrfs_filesystem.
> >
> >> Furthermore this is profile independent, I have see all profiles hitting
> >> such data corruption.
> >
> > How does the corruption look like?
> 
> Just some csum mismatch, which both scrub and btrfs check
> --check-data-csum report.
> 
> One of my concern here is the temperature of my environment, with AC
> running it no longer reproduces...
> 
> Hope it's really just a false alert.

No signs of problems so far, blaming it on overheating would fit the
mysterious hard to reproduce bugs. We'll keep testing and see but this
should not get a status of regression until we have something more
concrete.
