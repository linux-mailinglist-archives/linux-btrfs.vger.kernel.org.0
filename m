Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA8A574E88
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jul 2022 15:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238944AbiGNNCO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jul 2022 09:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238724AbiGNNCN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jul 2022 09:02:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341CF5B061
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jul 2022 06:02:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E32D533E4D;
        Thu, 14 Jul 2022 13:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657803730;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CnMEE30+3IfPjp5aZFwg0L7qhMlWAtu57W9KM26zzpI=;
        b=qdfqX1TUgHgVW2ZlABl5XbGaM/YOLYav0Nh0USkmQf5GufSbz9RmKEZvw3VQqtb5NLucd6
        egAMolavWaMMqyxOrId5WhYhESzQOjkVHykgqCPfxB1s7HP1ZKaK8GxjTl9za0ACKYTKtm
        zKhUvpmSs40a9+tVCP8emzlQZLBCMcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657803730;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CnMEE30+3IfPjp5aZFwg0L7qhMlWAtu57W9KM26zzpI=;
        b=PjuYAiBjdn7CWl6DHRq4nbWPDl6Blan/Ca303sfyXPjOvz6VcKER+7IN/6HZDoJpvJX6cp
        /JyOaK1H5qGLAXAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C707D13A61;
        Thu, 14 Jul 2022 13:02:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VFecL9IT0GJ6DAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 14 Jul 2022 13:02:10 +0000
Date:   Thu, 14 Jul 2022 14:57:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: simplify error handling in btrfs_lookup_dentry
Message-ID: <20220714125720.GK15169@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220714104810.2733591-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714104810.2733591-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 14, 2022 at 01:48:10PM +0300, Nikolay Borisov wrote:
> In btrfs_lookup_dentry releasing the reference of the sub_root and the
> running orphan cleanup should only happen if the dentry found actually
> represents a subvolume. This can only be true in the 'else' branch as
> otherwise either fixup_tree_root_location returned an ENOENT error, in
> which case sub_root wouldn't have been changed or if we got a different
> errno this means btrfs_get_fs_root couldn't have executed successfully
> again meaning sub_root will equal to root. So simplify all the branches
> by moving the code into the 'else'.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Thanks, I find this version more comprehensible than v1, added to
misc-next.
