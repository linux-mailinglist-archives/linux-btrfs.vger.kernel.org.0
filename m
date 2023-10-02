Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026BA7B5925
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Oct 2023 19:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238633AbjJBRG4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Oct 2023 13:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238523AbjJBRGz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Oct 2023 13:06:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48A5B8
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Oct 2023 10:06:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3065121864;
        Mon,  2 Oct 2023 17:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696266409;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G78RpVQG2LJ2/LSMVgpZ4YJ9XAPBy+Il+Hjq3mZ9XFg=;
        b=AFHe/6LUVwbWRW82HWkhImsAb6TPDFDJZ1HsBDXp+eMzw2HSNDKABTFqF/jY/+OM+g3Nf6
        2ffrT9FTF5jseATded8ob+m0EBmDT9TkVejvqELY9n6EjiixWHEtQsqEWiqiYwmA44OLQQ
        /imyR+QduEEx4SU2Z1stG/ARL7cVWGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696266409;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G78RpVQG2LJ2/LSMVgpZ4YJ9XAPBy+Il+Hjq3mZ9XFg=;
        b=e3jpX0lKlutkJkhRTggJMB+KYKE0nGMQNysnVERFdBAdCoPBYajZ7mrpWKdnxMl0A5GbBM
        7LYeW5KI+tL5WnAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 142FA13434;
        Mon,  2 Oct 2023 17:06:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fsodBKn4GmX+NAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 02 Oct 2023 17:06:49 +0000
Date:   Mon, 2 Oct 2023 19:00:07 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH 0/4 v4] btrfs-progs: recover from failed metadata_uuid
 port kernel
Message-ID: <20231002170007.GV13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1694749532.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694749532.git.anand.jain@oracle.com>
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

On Fri, Sep 15, 2023 at 12:08:55PM +0800, Anand Jain wrote:
> v4:
> Remove the patch that has already been merged.
> Update the commit log of 1/4 as per David's review comment (Thanks).
> No code changes.
> 
> v3:
> This current patchset contains the remaining unmerged patches and
> addresses the reported bug:
> 
>  bug report: https://github.com/kdave/btrfs-progs/actions/runs/5956097489/job/16156138260
> 
> In v3 of this patchset, btrfs_fs_devices::inconsistent_super variable
> added, which helps determine whether all the devices in the fs_devices
> share the same fsid and metadata_uuid.
> 
> v2:
> The earlier revision, v2, of this patchset consisted of 16 patches, out of
> which 12 have already been merged into the devel branch.
> 
>  v2: https://patchwork.kernel.org/project/linux-btrfs/list/?series=776027
> 
> Anand Jain (4):
>   btrfs-progs: tune use the latest bdev in fs_devices for super_copy
>   btrfs-progs: add support to fix superblock with CHANGING_FSID_V2 flag
>   btrfs-progs: recover from the failed btrfstune -m|M
>   btrfs-progs: test btrfstune -m|M ability to fix previous failures

Added to devel, thanks.
