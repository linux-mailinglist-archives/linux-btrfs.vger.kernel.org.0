Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257567ADD8B
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Sep 2023 19:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjIYREx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Sep 2023 13:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIYREw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Sep 2023 13:04:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE1295
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Sep 2023 10:04:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9EC8D21858;
        Mon, 25 Sep 2023 17:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695661484;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jUO+nTsRTiE1Fwg4GM+dBmawBO6hVQnEXVT4FsjdFEg=;
        b=RZJCZbDLm4ot705ftnvV4DFzJAaVI5lKkLkAaSjtFGxln8zSS+dy0MpuIKU25hDQ0mLtVQ
        Py4Q+1iDOVX++bVwrNCxdbuNPuxbRYENAw0fJeJ4n961f4Ot92yuRhluLaC8usdswOJd4V
        dig11TcyU/iD3bir16Q8Lt+6aP7D82Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695661484;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jUO+nTsRTiE1Fwg4GM+dBmawBO6hVQnEXVT4FsjdFEg=;
        b=KBuW8YwbCQANxPL/runNhznN6VqjQjKwYeDJ0lvoP9yIeeo8QcSe0ihflM2Q51RUI668xQ
        O46jYZgJZkmKi9BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5CE0A13580;
        Mon, 25 Sep 2023 17:04:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jdyZE6y9EWUTCQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 25 Sep 2023 17:04:44 +0000
Date:   Mon, 25 Sep 2023 18:58:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2 v2] btrfs: reject device with CHANGING_FSID_V2 flag
Message-ID: <20230925165806.GR13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1695244296.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1695244296.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 21, 2023 at 05:51:12AM +0800, Anand Jain wrote:
> v2: Splits the patch into two parts: one for the new code to reject
> devices with CHANGING_FSID_V2 and the second to remove the unused code.
> 
> The btrfs-progs code to reunite devices with the CHANGING_FSID_V2 flag,
> which is ported from the kernel, can be found in the following btrfs-progs
> patchset:
> 
>  [PATCH 0/4 v4] btrfs-progs: recover from failed metadata_uuid port kernel
>     btrfs-progs: tune use the latest bdev in fs_devices for super_copy
>     btrfs-progs: add support to fix superblock with CHANGING_FSID_V2 flag
>     btrfs-progs: recover from the failed btrfstune -m|M
>     btrfs-progs: test btrfstune -m|M ability to fix previous failures
> 
> Furthermore, when the kernel stops supporting the CHANGING_FSID_V2 flag,
> we will need to update the btrfs-progs test case accordingly:
> 
>     btrfs-progs: misc-tests/034-metadata-uuid remove kernel support
> 
> v1:
> https://lore.kernel.org/linux-btrfs/02d59bdd7a8b778deb17e300354558498db59376.1692178060.git.anand.jain@oracle.com
> 
> 
> Anand Jain (2):
>   btrfs: reject device with CHANGING_FSID_V2
>   btrfs: remove unused code related to the CHANGING_FSID_V2 flag

Added to misc-next, thanks. I've updated the 2nd patch with some
historical background. The temp-fsid patch now does not apply cleanly,
I'll do a refresh on top of this series. Once it's in for-next, please
have a look. Thanks.
