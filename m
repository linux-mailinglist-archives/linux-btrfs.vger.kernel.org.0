Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4534D7B58F7
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Oct 2023 19:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238705AbjJBRRf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Oct 2023 13:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjJBRRf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Oct 2023 13:17:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BBFA4
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Oct 2023 10:17:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B483E21870;
        Mon,  2 Oct 2023 17:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696267051;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J4JhjYnWiD7AcvjQbznvNB+FWQfyARAGc4u5zofJwjo=;
        b=b6tE4/vExcNL3Pca7azqysrL1W3PBUEwArqDN7ViMPp5juyV5osTwcq1oWG2LAQurqx9n+
        GQ6mqDSHAg+Q9KBMVT5rTGtqH5OYFhKzDxhlxsbJx4hqvIoS7yyy7BG+msTve2GZAkwp8O
        3ooznUM5sbHRNORAdyZxbMx6dwjcdms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696267051;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J4JhjYnWiD7AcvjQbznvNB+FWQfyARAGc4u5zofJwjo=;
        b=nB831eLjdZCe02wSY1iLxNDPxY+Ug7JYJV+1701CjbB8l+B8L6/bIXePYVCcOE3kOo1r/x
        aL9bFXo8ZEkUDCAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9AFAC13434;
        Mon,  2 Oct 2023 17:17:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AQYBJSv7GmUFOgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 02 Oct 2023 17:17:31 +0000
Date:   Mon, 2 Oct 2023 19:10:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: misc-tests/034-metadata-uuid remove kernel
 support
Message-ID: <20231002171050.GW13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <c4d569b4e92cbc6ca2a7bd87e0bc0df1758bbba8.1694525360.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4d569b4e92cbc6ca2a7bd87e0bc0df1758bbba8.1694525360.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 21, 2023 at 06:35:10AM +0800, Anand Jain wrote:
> The kernel patch, ("btrfs: reject device with CHANGING_FSID_V2 flag"),
> removes kernel support for the CHANGING_FSID_V2 flag. So, drop its
> related testcase.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> Apply this on top of
> 
>  [PATCH 0/4 v4] btrfs-progs: recover from failed metadata_uuid port kernel
>     btrfs-progs: tune use the latest bdev in fs_devices for super_copy
>     btrfs-progs: add support to fix superblock with CHANGING_FSID_V2 flag
>     btrfs-progs: recover from the failed btrfstune -m|M
>     btrfs-progs: test btrfstune -m|M ability to fix previous failures

The above patches are now in devel but the test still fails because you
haven't removed the check for builtin/module status of btrfs.
