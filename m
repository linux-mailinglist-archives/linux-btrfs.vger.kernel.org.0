Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4FC7B593D
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Oct 2023 19:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjJBR0c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Oct 2023 13:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjJBR0b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Oct 2023 13:26:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8530EAC
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Oct 2023 10:26:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3CDD7210DF;
        Mon,  2 Oct 2023 17:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696267587;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0YvO+X48MOEujKChSR8MD2U4z43s9gFlpSTVhZFdGjg=;
        b=pzTNTcdlrtO/qQKmiDawIHL77xoQ9j4X2+eo6r8XigJPLC6yBx172oqAmbmDI31xnAf1xu
        3FL6PGACisd8V99qwe+G0piyBpnGv3UVXj4JB2E0pTiy/qqP+msBexw0akmDUcT7n9iCLn
        YuJ4D2sD7JSDKQUHqxkjYN7aHCYIwx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696267587;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0YvO+X48MOEujKChSR8MD2U4z43s9gFlpSTVhZFdGjg=;
        b=qV0y274xERMwz3lxW50lQvY2AlD0h6Jf9BBNU3j/GxGm+LFuZnxzYW/QFYq78SU+cAU1hh
        4M4U84uigUZUgFAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1901A13434;
        Mon,  2 Oct 2023 17:26:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9dZ5BUP9GmUWPgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 02 Oct 2023 17:26:27 +0000
Date:   Mon, 2 Oct 2023 19:19:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH 4/4] btrfs-progs: test btrfstune -m|M ability to fix
 previous failures
Message-ID: <20231002171945.GY13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1694749532.git.anand.jain@oracle.com>
 <db8c6de3dfda46d9e3c0dbebc7f10a898f8be112.1694749532.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db8c6de3dfda46d9e3c0dbebc7f10a898f8be112.1694749532.git.anand.jain@oracle.com>
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

On Fri, Sep 15, 2023 at 12:08:59PM +0800, Anand Jain wrote:
> The misc-test/034-metadata_uuid test case, has four sets of disk images to
> simulate failed writes during btrfstune -m|M operations. As of now, this
> tests kernel only. Update the test case to verify btrfstune -m|M's
> capacity to recover from the same scenarios.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

With all the problems fixed, the test still fails.  I'm not sure which case it
is:

====== RUN CHECK root_helper losetup --find --show ./disk1.raw.restored
/dev/loop0
====== RUN CHECK root_helper losetup --find --show ./disk2.raw.restored
/dev/loop1
====== RUN CHECK root_helper udevadm settle
====== RUN CHECK root_helper /labs/dsterba/gits/btrfs-progs/btrfstune -m /dev/loop1
parent transid verify failed on 30425088 wanted 6 found 4
parent transid verify failed on 30441472 wanted 6 found 4
Error writing to device 1
ERROR: failed to write tree block 30457856: Operation not permitted
ERROR: btrfstune failed
failed: root_helper /labs/dsterba/gits/btrfs-progs/btrfstune -m /dev/loop1
test failed for case 034-metadata-uuid

Looks like a write that's beyond the device limit. I'll keep the patches
and tests in devel so you can have a look.
