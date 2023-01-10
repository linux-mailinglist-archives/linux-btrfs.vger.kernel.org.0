Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DFC66433A
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jan 2023 15:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjAJO1z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Jan 2023 09:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjAJO1i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Jan 2023 09:27:38 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225A1C23;
        Tue, 10 Jan 2023 06:27:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BA24C4EE97;
        Tue, 10 Jan 2023 14:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1673360855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N95YqtyiDnnu4YjgEXHdAHMC186z6QZbh/D/Ev2Odno=;
        b=yWmmAwqvitOD8eoSGJPj/tNrwrcBTAOLSeZbPKddYM+Ij9jNwYjhVukKiVeVo5LakadbXA
        tQ7Xxy8mUz6pPbLInIuBftmBci+amjp/xTgHzM+t+qGO6kf9sViSUWKLgxof3SfgdEI5fc
        fvrKviTxX/ABqopGJBGDDo1Z6wN1lMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1673360855;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N95YqtyiDnnu4YjgEXHdAHMC186z6QZbh/D/Ev2Odno=;
        b=vNGMR9HA56P8sfYCIlts+FMlS79yLEjnWlzNlz6IctectiuXvrLgbJ8GLqunSEW0Q1PBim
        QtjULEH1fd043bDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8CB381358A;
        Tue, 10 Jan 2023 14:27:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Qe3RINd1vWNWXgAAMHmgww
        (envelope-from <ddiss@suse.de>); Tue, 10 Jan 2023 14:27:35 +0000
Date:   Tue, 10 Jan 2023 15:28:39 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Wang Yugui <wangyugui@e16-tech.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs/012: check if ext4 is available
Message-ID: <20230110152839.091750bc@echidna.fritz.box>
In-Reply-To: <20230110141223.adgbm5oehxwh5tnw@zlang-mailbox>
References: <20230110082924.1687152-1-johannes.thumshirn@wdc.com>
        <20230110192321.34D5.409509F4@e16-tech.com>
        <20230110141223.adgbm5oehxwh5tnw@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 10 Jan 2023 22:12:23 +0800, Zorro Lang wrote:

> On Tue, Jan 10, 2023 at 07:23:22PM +0800, Wang Yugui wrote:
> > Hi,
> >   
> > > btrfs/012 is requiring ext4 support to test the conversion, but the test
> > > case is only checking if mkfs.ext4 is available, not if the filesystem
> > > driver is actually available on the test host.
> > > 
> > > Check if the driver is available as well, before trying to run the test.
> > > 
> > > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > > ---
> > >  tests/btrfs/012 | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/tests/btrfs/012 b/tests/btrfs/012
> > > index 60461a342545..86fbbb7ac189 100755
> > > --- a/tests/btrfs/012
> > > +++ b/tests/btrfs/012
> > > @@ -32,6 +32,8 @@ _require_command "$E2FSCK_PROG" e2fsck
> > >  _require_non_zoned_device "${SCRATCH_DEV}"
> > >  _require_loop
> > >  
> > > +grep -q ext4 /proc/filesystems || _notrun "no ext4 support"  
> > 
> > when ext4 is module, and is not used, 'ext4' will not be in /proc/filesystems.  
> 
> Really? Actually I'm not sure about that. There's an existing helper in
> common/rc named _require_extra_fs(). Which we usually used to check if
> a secondary filesystem is supported by the current kernel. Likes:

Yes, if the ext4 kmod is not loaded then it won't appear in
/proc/filesystems. _require_extra_fs should work, as it calls modprobe
before checking /proc/filesystems.

Cheers, David
