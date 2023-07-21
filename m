Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E39275D7D8
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Jul 2023 01:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjGUXPs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jul 2023 19:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjGUXPr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jul 2023 19:15:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1418F1715
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 16:15:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AF73F1F889;
        Fri, 21 Jul 2023 23:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689981343;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KXBRHCBQjNnPJ3f+IWVdWD5TgHdeDPw7dAeSOFFQfpM=;
        b=AFKAFFLYlWLCZ6vOmSQCgmLRwyB8G17WrB7+tfGb72ESF4SJemq/I54Z+aQo4bt2HY5AKd
        B4hqTVbSCGjkt1DdO1LVCuUPK9K1dKZr57A6/JLagfHqg6INw1P4cVsnLuHzexdf3PNwFp
        zpgT1Yo3DSx0yforlXATAuNXOoxoAFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689981343;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KXBRHCBQjNnPJ3f+IWVdWD5TgHdeDPw7dAeSOFFQfpM=;
        b=Ap0nTUi21HlDKGikS3FWwYRw8cTIVm1ob2FvKXvkFLC82D8N6SbDSlFOcWJCVOa84P4Dxp
        GinMqHFkm1pi+9Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5CAC1134BA;
        Fri, 21 Jul 2023 23:15:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1sKfE58Ru2RlawAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 21 Jul 2023 23:15:43 +0000
Date:   Sat, 22 Jul 2023 01:09:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 01/20] btrfs: free qgroup rsv on io failure
Message-ID: <20230721230901.GF20457@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1689955162.git.boris@bur.io>
 <a260b7a8e02aa9deca066f9dcc53b2ba028f6d42.1689955162.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a260b7a8e02aa9deca066f9dcc53b2ba028f6d42.1689955162.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 21, 2023 at 09:02:06AM -0700, Boris Burkov wrote:
> If we do a write whose bio suffers an error, we will never reclaim the
> qgroup reserved space for it. We allocate the space in the write_iter
> codepath, then release the reservation as we allocate the ordered
> extent, but we only create a delayed ref if the ordered extent finishes.
> If it has an error, we simply leak the rsv. This is apparent in running
> any error injecting (dmerror) fstests like btrfs/146 or btrfs/160. Such
> tests fail due to dmesg on umount complaining about the leaked qgroup
> data space.
> 
> When we clean up other aspects of space on failed ordered_extents, also
> free the qgroup rsv.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>

This and patch 2 are fixes unrealted to squota so I'll merge them now,
they could have been sent separately. Thanks.
