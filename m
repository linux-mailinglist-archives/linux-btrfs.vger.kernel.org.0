Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF537BBB82
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Oct 2023 17:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjJFPOo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Oct 2023 11:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbjJFPOl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Oct 2023 11:14:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3116FA
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Oct 2023 08:14:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 683081F896;
        Fri,  6 Oct 2023 15:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696605279;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AdoOoY3a2P96THRWWOw06UHUwMVfebk34n+8sq3PKQ0=;
        b=NNVA/OoW+44Oh86fQUDwjBS+9DdoGJ3MlWCRVAsAHVt1lsV1TMpU7jt588mWzUdEGVNeo/
        2i6XwaY0/6BuasKHedEmRAp2INSvu+PttNpWFUWyYl14PLXv2ntW7vR+hPHa0z4Yy8cQds
        gqNczvhnZc0OPSullh4qjPPFX89jzv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696605279;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AdoOoY3a2P96THRWWOw06UHUwMVfebk34n+8sq3PKQ0=;
        b=D5jSWRREEu0r5JvcXUuKryRI1wMc78SnNGRI1CRSnEi45fqE01c9+VHBAcNlx5eVUGui3M
        57ZjZjZBQeyp8bDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4796813A2E;
        Fri,  6 Oct 2023 15:14:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id acWqEF8kIGXWdgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 06 Oct 2023 15:14:39 +0000
Date:   Fri, 6 Oct 2023 17:07:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, gpiccoli@igalia.com
Subject: Re: [PATCH 0/4] btrfs: sysfs and unsupported temp-fsid features for
 clones
Message-ID: <20231006150755.GH28758@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1696431315.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696431315.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 04, 2023 at 11:00:23PM +0800, Anand Jain wrote:
> Seed and device-add are the two features that must be unsupported
> if a cloned device is using temp-fsid to mount, as they conflict
> with multi-device functionality.
> 
> Additionally, add sysfs files for the temp-fsid feature.
> 
> Anand Jain (4):
>   btrfs: comment for temp-fsid, fsid, and metadata_uuid
>   btrfs: disable seed feature for temp-fsid
>   btrfs: disable the device add feature for temp-fsid
>   btrfs: show temp_fsid feature in sysfs

Added to misc-next, thanks. The eventual change to the sysfs file can be
done later.

How are we going to proceed with the patch from Guilherme?
