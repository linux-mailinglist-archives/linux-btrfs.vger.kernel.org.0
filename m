Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2249508C5E
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 17:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351366AbiDTPs5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Apr 2022 11:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349122AbiDTPs4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Apr 2022 11:48:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25401E016
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 08:46:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D30A71F74F;
        Wed, 20 Apr 2022 15:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650469564;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0+KO9OtR7DH3VnBlcjltjNFgrj6seOz+Rn9vWxd0gHA=;
        b=ihC52rWMd2JCyFr3SfybQvr72k9YZw2LBL/RiBodCktMW3KpAfsbBVYO2b8RMyjWhIdGDt
        1QfaV0J3nxNuaimOKVNXqXQrF9r+M5cMlM4mGGKM9tX6VnA8ZfHFbiogxbfGeKbG40fACy
        q3JGduJZZ2L0SpWmd4P+bReCHqDDLzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650469564;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0+KO9OtR7DH3VnBlcjltjNFgrj6seOz+Rn9vWxd0gHA=;
        b=xrOrNPHEpQOHzIv2F2MyfhbFxLCDE234fsAeD5COPnNJJ42zEs8rUQ6GUVzzw+fDUP7aFT
        mcomdLtC8HzLpuAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D81A13AD5;
        Wed, 20 Apr 2022 15:46:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7rCTJbwqYGKvPAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 20 Apr 2022 15:46:04 +0000
Date:   Wed, 20 Apr 2022 17:42:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        Luca =?iso-8859-1?Q?B=E9la?= Palkovics 
        <luca.bela.palkovics@gmail.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: repair super block num_devices automatically
Message-ID: <20220420154200.GG1513@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        Luca =?iso-8859-1?Q?B=E9la?= Palkovics <luca.bela.palkovics@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <732d0a86c3624bc96df3cca05512edac40efc75d.1646031785.git.wqu@suse.com>
 <ebdb0e67-0e9e-4ca6-1d2e-4dd2a7a7c103@oracle.com>
 <a6923955-00f9-d739-c70a-3beace0b85e1@gmx.com>
 <82df81f6-74a1-b77d-c4e9-48d20ab1bd68@oracle.com>
 <f8c0610e-466b-256b-347f-d10c517023ae@gmx.com>
 <c8009e2d-7569-4dec-3745-e9c3718ec57c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8009e2d-7569-4dec-3745-e9c3718ec57c@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 28, 2022 at 08:51:30PM +0800, Anand Jain wrote:
> >>> I didn't get your point.
> >>> What do you want to get from this patch?
> >>>
> >>> Isn't this already the behavior of this patch?
> >>
> >>   Let me clarify - we don't need this patch if we fix the actual bug as
> >> above. IMO.
> > 
> > Big NO NO.
> > 
> > The damage is already done, we must be responsible for whatever damage
> > we caused, especially the damage has already reached disk.
> > 
> > Just fixing the cause and call it a day is definitely not a responsible 
> > way.
> > 
> > Especially when the damage is done, you have no way to mount it, just
> > like the reporter.
> > 
> > You dare to say the same thing to the end user?
> 
> You have a btrfs-progs patch to recover from that situation. Right?
> Plus, I suppose you are sending a kernel patch for the actual bug
> which is causing this corruption. No?

Normally we'd have just the repair code in check, but this is sometimes
difficult to run eg. on a root filesystem, or if the boot fails because
some mount fails and ends up in the rescue environment with limited
options.

> This patch is the reporter side fix. I don't encourage fixing the
> reporter because a similar corruption might happen for reasons unknown
> yet. For example, raid1 split-brain? Which is not yet completely
> analyzed and test-cased yet.

So that's a valid question if the auto-repair should be done or not in
kernel. But an offline repair would do the same thing, read number of
device items and set the num_devices. The decision on kernel side at
mount or by user when running btrfs check has the same amount of
information, so forcing user to do offline repair is a bit less
convenient.

The num_devices is basically a cached value of the number of device
items, used in many places as a shortcut so we don't have to count them
each time. Once we make sure that the numbers are in sync, it's the
correct stat. We know about one scenario where it would get out of sync,
now fixed, so the simple auto repair is IMHO safe.

For the raid1 split brain, I can't tell and if you say it's not analyzed
properly we'd have to rely on other mechanisms to catch the
inconsistency. Eg. a missing physical device would be recognized and
would require degraded mount, but it's unrelated to the value of
num_devices.
