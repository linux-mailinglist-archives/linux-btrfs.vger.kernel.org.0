Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15E378B49D
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Aug 2023 17:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjH1PiE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Aug 2023 11:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjH1Phz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Aug 2023 11:37:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BAD99
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 08:37:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8576C1F37E;
        Mon, 28 Aug 2023 15:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693237072;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MoicYI+e3OPQ9UQ8yDnwqS9bYCPCvHNrwX6IG3EYuRg=;
        b=w9rdZvseZOJ68p883amoxuYFxz+ksZKSap9R6CynoDNVOz/t/mAnSjFrhnM9hTXHrBZEdB
        uGZmQk9qC1mojcUAr9SCq6MMygncCjBUbDX9imcN8KYj0ktGEgQ++9Q2NyVsnc9VX7xLyq
        WU4bQJ+Mzbij/ll8bDP+2mjz2R1+FwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693237072;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MoicYI+e3OPQ9UQ8yDnwqS9bYCPCvHNrwX6IG3EYuRg=;
        b=iaUvYun3f7IcTzIDBaF/PsvxClzT/ctJ9R0YBbR24ojTY3k9t/waMftToJljpAoDFZ0Dpv
        G6GCNElccgoRZWAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5C05813A11;
        Mon, 28 Aug 2023 15:37:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HCunFVC/7GS2CQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 28 Aug 2023 15:37:52 +0000
Date:   Mon, 28 Aug 2023 17:31:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH 0/5 v3] btrfs-progs: recover from failed metadata_uuid
 port kernel
Message-ID: <20230828153117.GD14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1692963810.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1692963810.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 25, 2023 at 10:47:46PM +0800, Anand Jain wrote:
> The earlier revision, v2, of this patchset consisted of 16 patches, out of
> which 12 have already been merged into the devel branch.
> 
>  v2: https://patchwork.kernel.org/project/linux-btrfs/list/?series=776027
> 
> This current patchset contains the remaining unmerged patches and
> addresses the reported bug:
> 
>  bug report: https://github.com/kdave/btrfs-progs/actions/runs/5956097489/job/16156138260
> 
> In v3 of this patchset, btrfs_fs_devices::inconsistent_super variable
> added, which helps determine whether all the devices in the fs_devices
> share the same fsid and metadata_uuid.
> 
> Anand Jain (5):
>   btrfs-progs: cleanup duplicate check metadata_uuid flag
>   btrfs-progs: tune use the latest bdev in fs_devices for super_copy
>   btrfs-progs: add support to fix superblock with CHANGING_FSID_V2 flag
>   btrfs-progs: recover from the failed btrfstune -m|M
>   btrfs-progs: test btrfstune -m|M ability to fix previous failures

The first patch has been folded in.  I'll postpone the rest of the
series after the next release, ETA 6.5.1, I need to refresh the
metadata_uuid error states.
