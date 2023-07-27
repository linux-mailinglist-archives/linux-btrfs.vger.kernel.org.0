Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF0E7657C5
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jul 2023 17:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjG0Pfu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 11:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjG0Pft (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 11:35:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B56211C
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 08:35:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B741321A4D;
        Thu, 27 Jul 2023 15:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1690472146;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dwcg2tv93PFevTtdVY3gMVS/xbQeH8DvFDMIAa/f+tA=;
        b=Lrii8lb0G+5NX05WoPCm17yBEJ7cz4fhrkUyBbNOI768vGY7JgBxjVIXJFslp2EHWtslTi
        k31wry9lvjp0mBj5lBBAQwFcgXZ+onxjbg8BWKNV2SjW4/6ogje0jB09YjIuiKNvkw3rVT
        mc2eFmBc76g5CU581oTKDPK6cAR7Vpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1690472146;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dwcg2tv93PFevTtdVY3gMVS/xbQeH8DvFDMIAa/f+tA=;
        b=Cvkl4QY66mpfFZs5S74jX/4A+Acq2HEnaAa1VM8rLhqfBP7DhJDEuSyIYius39Bl5oMZ3z
        jUAkAM0hXfsizFAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8AC0313902;
        Thu, 27 Jul 2023 15:35:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Plp4INKOwmSsMQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 27 Jul 2023 15:35:46 +0000
Date:   Thu, 27 Jul 2023 17:29:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: improve message log due to race with systemd and
 mount
Message-ID: <20230727152924.GD17922@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <41c08d979d1d994803317fbfd98fe91c1e9f6b9e.1690465916.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41c08d979d1d994803317fbfd98fe91c1e9f6b9e.1690465916.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 27, 2023 at 09:53:03PM +0800, Anand Jain wrote:
> There is a race between systemd and mount, as both of them try to register
> the device in the kernel. When systemd loses the race, it prints the
> following message:
> 
>   BTRFS error: device /dev/sdb7 belongs to fsid 1b3bacbf-14db-49c9-a3ef-547998aacc4e, and the fs is already mounted.
> 
> The 'btrfs dev scan' registers one device at a time, so there is no way
> for the mount thread to wait in the kernel for all the devices to have
> registered as it won't know if all the devices are discovered.
> 
> For now, improve the error log by printing the command name and process
> ID along with the error message.
> 
> Signee-off-by: Anand Jain <anand.jain@oracle.com>

With the fixup, added to misc-next, thanks.
