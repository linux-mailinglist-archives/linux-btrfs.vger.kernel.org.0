Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339517B701E
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Oct 2023 19:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjJCRnX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Oct 2023 13:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjJCRnX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Oct 2023 13:43:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6009DAC
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Oct 2023 10:43:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B0FD82188F;
        Tue,  3 Oct 2023 17:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696354998;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oJy7V7WHHraLOqJtR89eE5jD6X0hRejuJNA1YIq/+eM=;
        b=a0eL4VQVqx3KNL/FU8PqBv0eT22ik8uMv7q+tz9iaoHENXLfVvZnn5jRSM7VuYmyFhqz1+
        /vSgUeBAf5ZdBgDBqXk0qj9v6TmWX+dCKtPOysL58638qphkunVvdgxZP5j0MGVa2MHO+Q
        SJpKzIK2vS1bak+pF9+ceO6kID7vTyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696354998;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oJy7V7WHHraLOqJtR89eE5jD6X0hRejuJNA1YIq/+eM=;
        b=M+TZ4y6G2DSBebr/FOJQev/xMzC4Ei1F+sr1/pQcuY4v24wz4Olb4eDbWvRYj5t96Ha6q8
        OP6yaWuWstHLRDBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8221A132D4;
        Tue,  3 Oct 2023 17:43:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EyLvHrZSHGXzKwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 03 Oct 2023 17:43:18 +0000
Date:   Tue, 3 Oct 2023 19:36:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH 4/4] btrfs-progs: test btrfstune -m|M ability to fix
 previous failures
Message-ID: <20231003173636.GZ13697@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1694749532.git.anand.jain@oracle.com>
 <db8c6de3dfda46d9e3c0dbebc7f10a898f8be112.1694749532.git.anand.jain@oracle.com>
 <20231002171945.GY13697@twin.jikos.cz>
 <a488ca32-0546-a7a0-62c5-9e1f3b301aa4@oracle.com>
 <086c2106-2743-f1f7-dfc4-85a9403be47a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <086c2106-2743-f1f7-dfc4-85a9403be47a@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 03, 2023 at 04:38:49PM +0800, Anand Jain wrote:
> On 3/10/23 16:00, Anand Jain wrote:
> > 
> > 
> > On 3/10/23 01:19, David Sterba wrote:
> >> On Fri, Sep 15, 2023 at 12:08:59PM +0800, Anand Jain wrote:
> >>> The misc-test/034-metadata_uuid test case, has four sets of disk 
> >>> images to
> >>> simulate failed writes during btrfstune -m|M operations. As of now, this
> >>> tests kernel only. Update the test case to verify btrfstune -m|M's
> >>> capacity to recover from the same scenarios.
> >>>
> >>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> >>
> >> With all the problems fixed, the test still fails.  I'm not sure which 
> >> case it
> >> is:
> >>
> >> ====== RUN CHECK root_helper losetup --find --show ./disk1.raw.restored
> >> /dev/loop0
> >> ====== RUN CHECK root_helper losetup --find --show ./disk2.raw.restored
> >> /dev/loop1
> >> ====== RUN CHECK root_helper udevadm settle
> >> ====== RUN CHECK root_helper /labs/dsterba/gits/btrfs-progs/btrfstune 
> >> -m /dev/loop1
> >> parent transid verify failed on 30425088 wanted 6 found 4
> >> parent transid verify failed on 30441472 wanted 6 found 4
> >> Error writing to device 1
> >> ERROR: failed to write tree block 30457856: Operation not permitted
> >> ERROR: btrfstune failed
> >> failed: root_helper /labs/dsterba/gits/btrfs-progs/btrfstune -m 
> >> /dev/loop1
> >> test failed for case 034-metadata-uuid
> >>
> >> Looks like a write that's beyond the device limit. I'll keep the patches
> >> and tests in devel so you can have a look.
> > 
> > 
> > As a root user, your devel branch passes here.
> > 
> > (Generally, I have been using the following command as root:)
> > 
> >   $ make TEST=034* test-misc
> >   [LD] fssum
> >   [LD] fsstress
> >   [TEST] misc-tests.sh
> >   [TEST/misc] 034-metadata-uuid
> >   Scanning /btrfs-progs/tests/misc-tests-results.txt
> > 
> > Let me try as a non-root user.
> > 
> > Also, could you please make sure that all the 
> > 'tests/misc-tests/034-metadata-uuid/*.restored' files are removed before 
> > starting the test case?
> 
> This pass as non-root.
> 
> $ sudo make TEST=034* test-misc
>      [LD]     fssum
>      [LD]     fsstress
>      [TEST]   misc-tests.sh
>      [TEST/misc]   034-metadata-uuid
> Scanning /btrfs-progs/tests/misc-tests-results.txt
> 
> So I think there might be some stale *restored images; Could you pls check.

It was indeed something on my side, the test now passes and also in CI.
