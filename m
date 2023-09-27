Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF07B7B0B50
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Sep 2023 19:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjI0Rtp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 13:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0Rto (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 13:49:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7E3A1
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 10:49:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C551D1F894;
        Wed, 27 Sep 2023 17:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695836981;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cbvov6lllapcTfBaXuvE83V+QnAV1M+HXZBmpPVRGps=;
        b=Z3Y6DEErhB7ERRItxkVfAFNoKRW2nNvderQx1e5gP+Ysoqn/DiIWMlqrJOxLPtJxXD0Dsc
        G99ZVUw2B6ytgpIyEJCXkhxpbNOJh9v9PKr31RWfm+jrus4Ea4jdrWUAZrYvK7jRIIaIKr
        FJAvCPOWeB9pGhWL3fjUphnp4wdsz8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695836981;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cbvov6lllapcTfBaXuvE83V+QnAV1M+HXZBmpPVRGps=;
        b=njL56WNrZGppKWB3YBYFJdtPZfF8JG9cINKjSQfim+cx9WstzEJiCEAe9gs3SKthOPg5bK
        DE/pZcUj6XmTNGAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A42BE13479;
        Wed, 27 Sep 2023 17:49:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RTRMJzVrFGUaNAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 27 Sep 2023 17:49:41 +0000
Date:   Wed, 27 Sep 2023 19:43:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2 v2] btrfs: reject device with CHANGING_FSID_V2 flag
Message-ID: <20230927174303.GA13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1695244296.git.anand.jain@oracle.com>
 <20230925165806.GR13697@twin.jikos.cz>
 <757517d8-2f79-4897-7d43-5c12fd6274bd@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <757517d8-2f79-4897-7d43-5c12fd6274bd@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 26, 2023 at 07:56:57AM +0800, Anand Jain wrote:
> On 26/09/2023 00:58, David Sterba wrote:
> > On Thu, Sep 21, 2023 at 05:51:12AM +0800, Anand Jain wrote:
> >> v2: Splits the patch into two parts: one for the new code to reject
> >> devices with CHANGING_FSID_V2 and the second to remove the unused code.
> >>
> >> The btrfs-progs code to reunite devices with the CHANGING_FSID_V2 flag,
> >> which is ported from the kernel, can be found in the following btrfs-progs
> >> patchset:
> >>
> >>   [PATCH 0/4 v4] btrfs-progs: recover from failed metadata_uuid port kernel
> >>      btrfs-progs: tune use the latest bdev in fs_devices for super_copy
> >>      btrfs-progs: add support to fix superblock with CHANGING_FSID_V2 flag
> >>      btrfs-progs: recover from the failed btrfstune -m|M
> >>      btrfs-progs: test btrfstune -m|M ability to fix previous failures
> >>
> >> Furthermore, when the kernel stops supporting the CHANGING_FSID_V2 flag,
> >> we will need to update the btrfs-progs test case accordingly:
> >>
> >>      btrfs-progs: misc-tests/034-metadata-uuid remove kernel support
> >>
> >> v1:
> >> https://lore.kernel.org/linux-btrfs/02d59bdd7a8b778deb17e300354558498db59376.1692178060.git.anand.jain@oracle.com
> >>
> >>
> >> Anand Jain (2):
> >>    btrfs: reject device with CHANGING_FSID_V2
> >>    btrfs: remove unused code related to the CHANGING_FSID_V2 flag
> > 
> 
> 
> > Added to misc-next, thanks.
> 
> > I've updated the 2nd patch with some
> > historical background.
> 
> Now much more complete! Thanks.
> 
> > The temp-fsid patch now does not apply cleanly,
> > I'll do a refresh on top of this series. Once it's in for-next, please
> > have a look. Thanks.
> 
> Sure. But, temp-fsid v4 still has a subvol mount bug, as reported
> before. I have a fix that is in-memory only. I am trying to get a
> reasonable list of fstests passed before sending it out. Guilherme
> can add the super-block flag on top of this, although it is not
> mandatory from the btrfs internals pov. I will send out the
> in-memory based temp-fsid soon I get the fstests (with some fix)
> working today.

Feel free the send the patches even if there are still failing tests,
I'd like to get an idea of how are you fixing the remaining problem(s).
Thanks.
