Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C948B78636C
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Aug 2023 00:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238656AbjHWWbn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 18:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238655AbjHWWbO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 18:31:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72E91702
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 15:31:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 696232267B;
        Wed, 23 Aug 2023 22:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692829867;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W+DhcPrwueb0skpZ5yR++4EqlP/mBO3byd0dze1xbBo=;
        b=P4c17KlGJ/PG1xM1TH484tDfFDV2LON8i7l3iTMpBIVh3VSUWcm1CIl5PXv/P4sZmhFX7L
        SPWEUfP6KeN2y85ckm0ULsVyo+s7wwBDnTCxxu95gQNVzrOthdRErU6kwUh46MFGLb9AZU
        nf/VRSWBCJrq2c6HDxDV3+3KsU8hAaM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692829867;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W+DhcPrwueb0skpZ5yR++4EqlP/mBO3byd0dze1xbBo=;
        b=XS5hwm/bXVMdnPprXctWIcGyqY9CFLX7Zl9t8vAZavTUa0mM41eWcBZtyk0y8FUfLu2d8J
        OYo8QhcMjsfax7Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4779913458;
        Wed, 23 Aug 2023 22:31:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eCG4EKuI5mR0VgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 23 Aug 2023 22:31:07 +0000
Date:   Thu, 24 Aug 2023 00:24:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/16] btrfs-progs: recover from failed metadata_uuid
Message-ID: <20230823222434.GM2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1692018849.git.anand.jain@oracle.com>
 <20230823221315.GL2420@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823221315.GL2420@twin.jikos.cz>
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

On Thu, Aug 24, 2023 at 12:13:15AM +0200, David Sterba wrote:
> On Mon, Aug 14, 2023 at 11:27:56PM +0800, Anand Jain wrote:
> > The kernel reunites split-brained devices after a failed `btrfstune -m|M`
> > operation. We can achieve the same in btrfs-progs. So port it here.
> > Ref the discussion here:
> > 
> >    https://lore.kernel.org/all/1fa6802b-5812-14a8-3fc8-5da54bb5f79d@oracle.com/
> > 
> > Patch 1/16 wasn't integrated as part of the set
> > 	[PATCH 00/10 v2] fixes and preparatory related to metadata_uuid
> > it's now merged with this patchset.
> > 
> > Patches [2-6,11,12] are cleanup patches.
> > 
> > Patches [7,8,10] are preparatory.
> > 
> > Patch [9] addresses a bug.
> > 
> > Patches [13, 14, 15] provide recovery from previously failed
> > `btrfstune -m|M` operations.
> > 
> > Patch [16] enhances the misc-test `034-metadata-uuid` to also validate this
> > new recovery feature.
> > 
> > This set has been successfully tested with the btrfs-progs testsuite.
> > 
> > This patchset is on top the latest devel last commit:
> >  8aba9b0052b6 btrfs-progs: btrfstune: consolidate error handling in main()
> > 
> > 
> > Anand Jain (16):
> >   btrfs-progs: track num_devices per fs_devices
> >   btrfs-progs: tune can use local fs_info variable
> >   btrfs-progs: rename set_metadata_uuid arg to new_fsid_str
> >   btrfs-progs: rename set_metadata_uuid new_fsid to fsid
> >   btrfs-progs: rename set_metadata_uuid new_uuid to new_fsid
> >   btrfs-progs: rename set_metadata_uuid uuid_changed to fsid_changed
> >   btrfs-progs: pass fsid in check_unfinished_fsid_change arg2
> >   btrfs-progs: pass metadata_uuid in check_unfinished_fsid_change arg3
> >   btrfs-progs: fix return without flag reset commit in tune
> >   btrfs-progs: preparing the latest device's superblock for commit
> >   btrfs-progs: rename fs_devices::list to match the kernel
> >   btrfs-progs: rename fs_devices::latest_trans to match the kernel
> >   btrfs-progs: tune use the latest bdev in fs_devices for super_copy
> >   btrfs-progs: add support to fix superblock with CHANGING_FSID_V2 flag
> >   btrfs-progs: recover from the failed btrfstune -m|M
> >   btrfs-progs: test btrfstune -m|M ability to fix previous failures
> 
> Patches added to devel, thanks.

On my machine the metadata uuid test does not run because the module is
not loadable, but the GH actions report a failure:
https://github.com/kdave/btrfs-progs/actions/runs/5956097489/job/16156138260
