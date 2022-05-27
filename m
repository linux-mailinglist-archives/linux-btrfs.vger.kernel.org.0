Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1237C53635E
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 15:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351985AbiE0Nia (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 09:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240544AbiE0Ni2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 09:38:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1717A11E48A
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 06:38:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 940591F889;
        Fri, 27 May 2022 13:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653658705;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C9sMgXdSqxmbbEzJwztIm1chKq9600yH8qiHIhCB3SE=;
        b=kp0JaGq/Zruw1X5AznmjH7Zks/tXyUEuw7lZLNP5/l2RAQ2OLu+3fd6dXbUkOEuebjzshb
        y+Yo0gCoKQdBzkyZsLoazJo1sgwDSs74E2w6/Ju/aDe3Q8/u2zX6rr6JzKB66KuBRJCcGi
        mFJZavTm1cslzWCU5LDJK4vt9NmRaw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653658705;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C9sMgXdSqxmbbEzJwztIm1chKq9600yH8qiHIhCB3SE=;
        b=pH/I5RrqD88v5FVMBOM2HuPhiSDq78pnsxsXbHVy4R0VwkXpf+zyP87qKlu7t1wZBI+aln
        aShyGTdeMg8hBaCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 65CEE139C4;
        Fri, 27 May 2022 13:38:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jmf1F1HUkGIHSgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 27 May 2022 13:38:25 +0000
Date:   Fri, 27 May 2022 15:34:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Stefan Roesch <shr@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v1 0/3] btrfs: add sysfs switch to get/set metadata size
Message-ID: <20220527133401.GA20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Stefan Roesch <shr@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20220208193122.492533-1-shr@fb.com>
 <20220404163102.GR15609@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404163102.GR15609@twin.jikos.cz>
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

On Mon, Apr 04, 2022 at 06:31:02PM +0200, David Sterba wrote:
> On Tue, Feb 08, 2022 at 11:31:19AM -0800, Stefan Roesch wrote:
> > The btrfs allocator is currently not ideal for all workloads. It tends
> > to suffer from overallocating data block groups and underallocating
> > metadata block groups. This results in filesystems becoming read-only
> > even though there is plenty of "free" space.
> > 
> > This patch adds the ability to query and set the metadata allocation
> > size.
> > 
> >   Patch 1: btrfs: store chunk size in space-info struct.
> >     Store the stripe and chunk size in the btrfs_space_info structure
> >     to be able to expose and set the metadata allocation size.
> >     
> >   Patch 2: btrfs: expose chunk size in sysfs.
> >     Add a sysfs entry to read and write the above information.
> >     
> >   btrfs: add force_chunk_alloc sysfs entry to force allocation
> >     For testing purposes and under a debug flag add a sysfs entry to
> >     force a space allocation.
> 
> Sorry for late response, I'm now reviewing the patches, there are still
> some things to fix, commends under the

There was no update since, I've applied the fixups and merged the
patches. Changelogs have been updated to mention the individual changes
and what are the constraints of the chunk_size values.
