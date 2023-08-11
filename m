Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4666779671
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Aug 2023 19:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbjHKRsU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Aug 2023 13:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjHKRsT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Aug 2023 13:48:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C02AF5
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Aug 2023 10:48:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1B313218A9;
        Fri, 11 Aug 2023 17:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691776098;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SURBQqPg4Ai0X0RSCiHw2lqcTNjLuqhSChIbTjRqO1Y=;
        b=2M9d7jq6y0REGdBDfPsv28W1IK5A7JdoEZNlcsnvZLC0pRTKhxdx2akCeV+wq0riVQZhPs
        SzkfQyBy1ZguyvftFovRK+dZzh5L7w4Ac8CAY8q5xE6VrerHkNRc3kdzedNYbBwZcYPIl0
        GZNp0CjAVtUmj92d43wbJjzn6PHgfP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691776098;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SURBQqPg4Ai0X0RSCiHw2lqcTNjLuqhSChIbTjRqO1Y=;
        b=usCWL8DhcvUG9S5DKvdZ11mo0MHwc7JVLwK0EIb8IzNll1OjVjhFA+kUapHR3Xz62tUQuY
        ehvvCH5fHuCHOgAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 028EC13592;
        Fri, 11 Aug 2023 17:48:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QwpqO2F01mT0ZgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 11 Aug 2023 17:48:17 +0000
Date:   Fri, 11 Aug 2023 19:41:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 07/10] btrfs-progs: track num_devices per fs_devices
Message-ID: <20230811174152.GX2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1690985783.git.anand.jain@oracle.com>
 <bef7d89c5e6564fcd621787a647fedfe72f94c0b.1690985783.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bef7d89c5e6564fcd621787a647fedfe72f94c0b.1690985783.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 03, 2023 at 07:29:43AM +0800, Anand Jain wrote:
> Similar to the kernel we need to track the number of devices scanned
> per fs_devices. A preparation patch to fix incomplete fsid changing.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Patch looks ok and makes sense but it crashes on segfault with test 001
in misc-tests. I haven't analyzed what exactly it is but given that
there's only one pointer dereference it must be it. Reverting the patch
makes it work (with the whole series applied), so I'll drop it for now
so you can have a look.
