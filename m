Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CE3788683
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 14:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238114AbjHYMAJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Aug 2023 08:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237180AbjHYL7h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Aug 2023 07:59:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B42198E
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 04:59:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B8CF62247C;
        Fri, 25 Aug 2023 11:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692964774;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pT2JXp601qvLA2vP6ZpYSQAeWNupkXvIqxQ+BH7IzFg=;
        b=RYi7Yb1uq5KBR9/4DhNUitRnvf13sTQh2xiEN77cDjQcH6CMfT3CjPKtQb1uBueaWXTPT2
        0ZY/gMEZ7LStwZdR8J723mdFUuXJ+W/NAVJyIs5GBfdcBv5/RV3En7l2HoyTZJi1XHkM9v
        7j2kEvrS026EQZYkFYzo1wTMTUcidK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692964774;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pT2JXp601qvLA2vP6ZpYSQAeWNupkXvIqxQ+BH7IzFg=;
        b=jUr0lFH6S5B4WR0zNibi58ugLlOMnrBg9L9MX7CkZ/f3453FNQw3lXw3DA8If/0GoTGLp8
        95dvRVsAYeXmB2CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F06B138F9;
        Fri, 25 Aug 2023 11:59:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UVQLJqaX6GSiSwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 25 Aug 2023 11:59:34 +0000
Date:   Fri, 25 Aug 2023 13:53:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/16] btrfs-progs: recover from failed metadata_uuid
Message-ID: <20230825115301.GP2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1692018849.git.anand.jain@oracle.com>
 <20230823221315.GL2420@twin.jikos.cz>
 <20230823222434.GM2420@twin.jikos.cz>
 <ee88691e-f484-58cd-4e48-50d2671e7e71@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee88691e-f484-58cd-4e48-50d2671e7e71@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 24, 2023 at 09:54:30PM +0800, Anand Jain wrote:
> >> Patches added to devel, thanks.
> > 
> > On my machine the metadata uuid test does not run because the module is
> > not loadable, but the GH actions report a failure:
> > https://github.com/kdave/btrfs-progs/actions/runs/5956097489/job/1615613826
> 
> Local VM successfully runs misc-tests/034*. However, on OCI, the same
> error as GH. Error reports missing device. It appears, inconsistent
> results due to the varying device scan order from system to system.
> I am looking more.

Patches 13-16 have been removed from devel until the issue is resolved.
I've enabled build tests for pull requests you can use the github CI for
testing too (open a PR against devel or master branch).
