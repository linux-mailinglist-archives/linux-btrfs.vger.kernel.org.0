Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C71A779383
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Aug 2023 17:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbjHKPvk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Aug 2023 11:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjHKPvj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Aug 2023 11:51:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157F42123
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Aug 2023 08:51:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CAC031F890;
        Fri, 11 Aug 2023 15:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691769097;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WN0JM0erbfharefSHi1T14doiArVKlyeeY1GKC2aCJA=;
        b=3YKBCDmyPQ5oP5uJ2gbktT0guToOz2nqed2HKZKjtWwMZ/wtjqZTrqQco+A0ufNLu9Arnp
        0a1ZdVwM6IZu+CnE+mXCeNmOSx3Dj3hT1vGmu4rxrkf8EfTbXPWUY9EKhvswZfKmY2OoBQ
        9zdylgM/cELwQLMaoRsgKxGyf8w6OMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691769097;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WN0JM0erbfharefSHi1T14doiArVKlyeeY1GKC2aCJA=;
        b=H1IU64M/j3/uhKuYRkhqsGuA1F5Uk2gY9YD0lHbqYfJzQ0HP2zxbc/OxrWA6RttAlq9OdM
        PzX1PtK+03FcYECQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A470913592;
        Fri, 11 Aug 2023 15:51:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JMFhJwlZ1mR3PAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 11 Aug 2023 15:51:37 +0000
Date:   Fri, 11 Aug 2023 17:45:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/7 v2]  metadata_uuid misc cleanup and fixes part2
Message-ID: <20230811154512.GU2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1690792823.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1690792823.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 31, 2023 at 07:16:31PM +0800, Anand Jain wrote:
> v2:
> The new patch 1/7 peels btrfs_sb_fsid_prt() helper function from 1/4 in v1,
> This function is used in patch 2/7 and patch 4/7 in v2.
> 
> Patch 6/7, adds btrfs_sb_metadata_uuid_or_null() another helper func, used
> in 7/7 in volumes.c. Further, used in the upcoming fsid_changing patch.
> Pushing this set now which are ready. This has passed fstests -g quick.
> 
> ----- original -----
> These patches are cleanups related to metadata_uuid. Please ref to the
> patch for details.
> 
> Anand Jain (7):
>   btrfs: add a helper to read the superblock metadata_uuid
>   btrfs: simplify memcpy either of metadata_uuid or fsid
>   btrfs: fix fsid in btrfs_validate_super
>   btrfs: fix metadata_uuid in btrfs_validate_super
>   btrfs: drop redundant check to use fs_devices::metadata_uuid

The above added to misc-next, thanks.

>   btrfs: add a superblock helper to read metadata_uuid or NULL
>   btrfs: use btrfs_sb_metadata_uuid_or_null

I think this can simplify the alloc_fs_devices a bit more as commented,
please resend. Thanks.
