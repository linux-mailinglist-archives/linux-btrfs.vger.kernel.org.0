Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A379D7766E0
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Aug 2023 20:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjHISCk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Aug 2023 14:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjHISCh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Aug 2023 14:02:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D011982
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Aug 2023 11:02:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 83FE41F460;
        Wed,  9 Aug 2023 18:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691604154;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XcmMjWRaHw3i4/lTEPfYe7kFz338Q5HuJdCHddqd1Cw=;
        b=fjztkkhV090hWeVsH9LcqFF1KOW+qEPcgmVNWwmxxKZ05AMQ8gYQXID5vjI4l+oAAwP5ko
        eQj2vjHCP8N3iROaf826714mNVYB0BTOtKB5YG11HNyfsRz7VlJ5vmgZKge45aGpsnAx8D
        878DH/zG4aqT8SewHwt1Bmzb7BaD5Wc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691604154;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XcmMjWRaHw3i4/lTEPfYe7kFz338Q5HuJdCHddqd1Cw=;
        b=wqcWx7EJ6j4TnZpdz2u4WY2LGZpXlJg2Nddp751UWCuX8mwSbguVuGRTYgnNC4q3IpTz8m
        kodO9ELfbaovRGDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5888D13251;
        Wed,  9 Aug 2023 18:02:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IRGwFLrU02TrDgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 09 Aug 2023 18:02:34 +0000
Date:   Wed, 9 Aug 2023 20:02:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, hch@infradead.org,
        josef@toxicpanda.com, dsterba@suse.cz
Subject: Re: [PATCH v3 00/10] btrfs: zoned: write-time activation of metadata
 block group
Message-ID: <ZNPUuSsOzQC7CVck@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, hch@infradead.org,
        josef@toxicpanda.com
References: <cover.1691424260.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691424260.git.naohiro.aota@wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 08, 2023 at 01:12:30AM +0900, Naohiro Aota wrote:
> In the current implementation, block groups are activated at
> reservation time to ensure that all reserved bytes can be written to
> an active metadata block group. However, this approach has proven to
> be less efficient, as it activates block groups more frequently than
> necessary, putting pressure on the active zone resource and leading to
> potential issues such as early ENOSPC or hung_task.
> 
> Another drawback of the current method is that it hampers metadata
> over-commit, and necessitates additional flush operations and block
> group allocations, resulting in decreased overall performance.
> 
> Actually, we don't need so many active metadata block groups because
> there is only one sequential metadata write stream.
> 
> So, this series introduces a write-time activation of metadata and
> system block group. This involves reserving at least one active block
> group specifically for a metadata and system block group. When the
> write goes into a new block group, it should have allocated all the
> regions in the current active block group. So, we can wait for IOs to
> fill the space, and then switch to a new block group.
> 
> Switching to the write-time activation solves the above issue and will
> lead to better performance.
> 
> * Performance
> 
> There is a significant difference with a workload (buffered write without
> sync) because we re-enable metadata over-commit.
> 
> before the patch:  741.00 MB/sec
> after the patch:  1430.27 MB/sec (+ 93%)
> 
> * Organization
> 
> Patches 1-5 are preparation patches involves meta_write_pointer check.
> 
> Patches 6 and 7 are the main part of this series, implementing the
> write-time activation.
> 
> Patches 8-10 addresses code for reserve time activation: counting fresh
> block group as zone_unusable, activating a block group on allocation,
> and disabling metadata over-commit.
> 
> * Changes
> 
> - v3
>   - Rework the reservation patch to fix the over-reservation problem
>     https://lore.kernel.org/all/xpb5wdmxx5wops26ihulo73oluc64dt4zpxqc7cirp2wvxl3qy@hv7lsvma5hxf/
>   - Rename btrfs_eb_write_context's block_group to zoned_bg.

Added to misc-next, thanks. We need it in order to enable zoned tests in
the CI so this goes in now, any fixups or more review tags will be done
in the commits.
