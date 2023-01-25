Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF4867B271
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jan 2023 13:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbjAYMOt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Jan 2023 07:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbjAYMOq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Jan 2023 07:14:46 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A916515549;
        Wed, 25 Jan 2023 04:14:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 654C921DCE;
        Wed, 25 Jan 2023 12:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674648884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a+YXLCcQEI5OgN4MH9YdlDfRG/WQvBKfRRJJLm3yQ/E=;
        b=otHRHXXt+Oqpzl9RbXvMVoJN1oj0N4YmPo6cw69Ixh+CrRkGKhrvOIogekT+ONMJtJ0C6D
        bFUA9d6MPHsUhGDpMBJYeb/S4BrZbRcuGRtnLJ9eZ1NcjuoD8D54vJxKG0RaGrkDPZgD2v
        9mp51t68NF4eTFlU8gc1UT+aoNqsg8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674648884;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a+YXLCcQEI5OgN4MH9YdlDfRG/WQvBKfRRJJLm3yQ/E=;
        b=UwxvXe8/SXryi+cb1Rnht6w/pa4ou4zJ6awr/LWADDGLKsiLIg+NArhXUPy333AjcezxKA
        lN1YeNXF6yIu/WCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 316FC1358F;
        Wed, 25 Jan 2023 12:14:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LXuJCjQd0WNiewAAMHmgww
        (envelope-from <ddiss@suse.de>); Wed, 25 Jan 2023 12:14:44 +0000
Date:   Wed, 25 Jan 2023 13:15:54 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs/299: update kernel commit hash and subject
Message-ID: <20230125131554.1fef6a07@echidna.fritz.box>
In-Reply-To: <3ccaa4e5f43538891d312ba7e9e4b38d61434d35.1674644818.git.fdmanana@suse.com>
References: <3ccaa4e5f43538891d312ba7e9e4b38d61434d35.1674644818.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 25 Jan 2023 11:07:39 +0000, fdmanana@kernel.org wrote:

> From: Filipe Manana <fdmanana@suse.com>
> 
> Test case btrfs/299 refers to a kernel patch with a subject of:
> 
>    "btrfs: fix logical_ino ioctl panic"
> 
> However when the patch was merged, the subject was renamed to:
> 
>    "btrfs: fix resolving backrefs for inline extent followed by prealloc"
> 
> So update the test with the correct subject and also add the commit's
> hash from Linus' tree.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Disseldorp <ddiss@suse.de>
