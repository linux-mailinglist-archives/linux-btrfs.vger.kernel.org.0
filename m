Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8FE7B53C2
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Oct 2023 15:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237287AbjJBNEZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Oct 2023 09:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237186AbjJBNEZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Oct 2023 09:04:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1013DAD
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Oct 2023 06:04:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7D29D1F749;
        Mon,  2 Oct 2023 13:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696251860;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KUWJmVQDJh+S5fZthAla3LM9Fa04CYnd6by3HbMHFxY=;
        b=oqdBZMs4bFbisydz2ty1Z6zdZvss8QHc4iXQ1iCzmZw3AgN8zII2rWj1bsilx7bu45dODo
        3CAElHOihjOfEya0ks5LNjjxKChypzI5qB5MeJlDeDjVL6IYJ1BcAulCk3EYAt9RS3TJUI
        7GGz+3iSooLOe6uLkBQoxZ/riO6bimo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696251860;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KUWJmVQDJh+S5fZthAla3LM9Fa04CYnd6by3HbMHFxY=;
        b=bDwjqDq6bBsEQpa8JPDMt5q7BPSah5vZM1dKJ71OgCpUa/fC3aEcVJUPCTGczjX5tmae4h
        74vyOAW1amQIMdDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4D16B13456;
        Mon,  2 Oct 2023 13:04:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7gkCEtS/GmUWOgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 02 Oct 2023 13:04:20 +0000
Date:   Mon, 2 Oct 2023 14:57:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>
Subject: Re: [PATCH 2/2] btrfs: support cloned-device mount capability
Message-ID: <20231002125739.GN13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1695826320.git.anand.jain@oracle.com>
 <e85f357bfbcef98bba37e2f39e884a371fc25b56.1695826320.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e85f357bfbcef98bba37e2f39e884a371fc25b56.1695826320.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 28, 2023 at 09:09:47AM +0800, Anand Jain wrote:
> Guilherme's previous work [1] aimed at the mounting of cloned devices
> using a superblock flag SINGLE_DEV during mkfs.
>  [1] https://lore.kernel.org/linux-btrfs/20230831001544.3379273-1-gpiccoli@igalia.com/
> 
> Building upon this work, here is in memory only approach. As it mounts
> we determine if the same fsid is already mounted if then we generate a
> random temp fsid which shall be used the mount, in memory only not
> written to the disk. We distinguish devices by devt.
> 
> Example:
>   $ fallocate -l 300m ./disk1.img :0
>   $ mkfs.btrfs -f ./disk1.img :0
>   $ cp ./disk1.img ./disk2.img :0
>   $ cp ./disk1.img ./disk3.img :0
>   $ mount -o loop ./disk1.img /btrfs :0
>   $ mount -o ./disk2.img /btrfs1 :0
>   $ mount -o ./disk3.img /btrfs2 :0

I'm confused what the ":0" are supposed to mean, is it some artifact of
your editor?

> 
>   $ btrfs fi show -m :0
>   Label: none  uuid: 4a212b48-1bec-46a5-938a-783c8c1f0b02
> 	Total devices 1 FS bytes used 144.00KiB
> 	devid    1 size 300.00MiB used 88.00MiB path /dev/loop0
> 
>   Label: none  uuid: adabf2fe-5515-4ad0-95b4-7b1609218c16
> 	Total devices 1 FS bytes used 144.00KiB
> 	devid    1 size 300.00MiB used 88.00MiB path /dev/loop1
> 
>   Label: none  uuid: 1d77d0df-7d92-439e-adbd-20b9b86fdedb
> 	Total devices 1 FS bytes used 144.00KiB
> 	devid    1 size 300.00MiB used 88.00MiB path /dev/loop2
> 
> Co-developed-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
