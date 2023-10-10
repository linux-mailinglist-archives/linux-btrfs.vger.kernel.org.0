Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1827E7BFE56
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 15:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbjJJNri (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 09:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbjJJNr1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 09:47:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F9818F
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 06:47:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5822F1F38A;
        Tue, 10 Oct 2023 13:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696945643;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g3TeCgDLD3hH01CLAuZw2dwj48tUpaR6f0G53ONlfXE=;
        b=vCwtJ2Sa9BBc6rV37aV7H1tZnAsRa30mBW5Y+7HKEy43IvKDfzOeLc0Czcr5tlyGm/VAGv
        H07ANF917k6Psr/mlciXbICtG9cgogoV0HtTLmtJLkc/wH5+sm6bYUXG01ddBt709HNnvA
        32MNuYePqUp9OXAFFvgdsLwA1UrCRKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696945643;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g3TeCgDLD3hH01CLAuZw2dwj48tUpaR6f0G53ONlfXE=;
        b=3pZfwhDC5vL9nGZP6tTabomAQk3DpbaQUQXNPh5FJqLw0NeSvkVzfYnDnjhoYeyNZKz3YI
        98MKvSRGBmOmdZAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C6951358F;
        Tue, 10 Oct 2023 13:47:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PVkeCutVJWUXcgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 10 Oct 2023 13:47:23 +0000
Date:   Tue, 10 Oct 2023 15:40:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.cz>, Qu Wenruo <wqu@suse.com>
Subject: Re: [bug report] btrfs mount failure with SELinux context option on
 kernel v6.6-rc5
Message-ID: <20231010134033.GB2211@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <yq5o7y5cptazpevhohy5e2ddfjdzsi35pbpijjnzjzejtx233p@phog4jcu4mtr>
 <f3ac7b74-c011-4d1f-a510-677679fc9743@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3ac7b74-c011-4d1f-a510-677679fc9743@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 10, 2023 at 04:11:41PM +1030, Qu Wenruo wrote:
> 
> 
> On 2023/10/10 15:52, Shinichiro Kawasaki wrote:
> > Hi all,
> >
> > I found fstests runs for btrfs on my test systems fail with the kernel v6.6-rc5.
> > Mount commands for btrfs fail with this message:
> >
> >    mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sdc, missing codepage or helper program, or other error.
> >         dmesg(1) may have more information after failed mount system call.
> >
> > And kernel reported:
> >
> >    BTRFS error: unrecognized mount option 'context="system_u:object_r:root_t:s0"
> >
> > My test system has Fedora which enables SELinux. Fstests adds SELinux security
> > context of the system to the mount command option list. Mount commands with the
> > added option fail:
> >
> >    $ sudo mount -o context=system_u:object_r:root_t:s0 /dev/sdX /mnt
> >
> > With the kernel v6.6-rc4, the mount command succeeded. I bisected between rc4
> > and rc5 then found the trigger commit is 5f521494cc73 ("btrfs: reject unknown
> > mount options early"). When I revert the commit from v6.6-rc5, the mount command
> > succeeds.
> >
> > Since the trigger is in the kernel, I guess a fix is required on the kernel side
> > rather than fstests or mount command. Actions for fix will be appreciated.
> 
> OK, the problem is, the SELinux options are only handled later, in
> btrfs_mount_root(), meanwhile btrfs_mount() is called earlier, thus the
> SELinux options are rejected.
> 
> Unfortunately my environment doesn't utilize SELinux, thus it doesn't
> get caught at all...
> 
> David, please revert the offending patch, a proper fix would be more
> complex.

Revert on the way, I'll send the pull request today.

https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/commit/?h=next-fixes&id=54f67decddeb47680f08c720c94b4d4f67181442
