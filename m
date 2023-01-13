Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2637F6698C1
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jan 2023 14:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241519AbjAMNiX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Jan 2023 08:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241584AbjAMNiG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Jan 2023 08:38:06 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188F03C73B
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Jan 2023 05:32:02 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8B75C6B30B;
        Fri, 13 Jan 2023 13:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673616721;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MZLI4TPsW3NBiqgwAG7JOyjvESIccK1em6d2MxKvj3U=;
        b=SFv94e8aG3FN32OFVOpvOudDACUg0+BoPd762xS9zfkFYzu+dzQ8EDtMOMOxcFTLaJrXNt
        bdcrs5O0v3JcMQ7cMTGow7+yx7Ht+xL5HqovgRocAFnQ0LhhJrAL0P7tgakGmo6i7dJAIK
        W8JH02eDkvIJFbHximnLl+OEvasPkIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673616721;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MZLI4TPsW3NBiqgwAG7JOyjvESIccK1em6d2MxKvj3U=;
        b=fQH79mbD7/sq33O/0vLj29oAL1ljmsjbjAh8QHGvi1X2AYFPqceHOX+/PBNQdAOLRPSW2E
        ba+Jwzu6xUgagUBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 661FE1358A;
        Fri, 13 Jan 2023 13:32:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QU9IF1FdwWMIeQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 13 Jan 2023 13:32:01 +0000
Date:   Fri, 13 Jan 2023 14:26:25 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: hold block_group refcount during async discard
Message-ID: <20230113132625.GV11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <07df5461bf34cf138f2f4b281a6fa6a0b389ff68.1673568238.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07df5461bf34cf138f2f4b281a6fa6a0b389ff68.1673568238.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 12, 2023 at 04:05:11PM -0800, Boris Burkov wrote:
> Async discard does not acquire the block group reference count while it
> holds a reference on the discard list. This is generally OK, as the
> paths which destroy block groups tend to try to synchronize on
> cancelling async discard work. However, relying on cancelling work
> requires careful analysis to be sure it is safe from races with
> unpinning scheduling more work.
> 
> While I am unable to find a race with unpinning in the current code for
> either the unused bgs or relocation paths, I believe we have one in an
> older version of auto relocation in a Meta internal build. This suggests
> that this is in fact an error prone model, and could be fragile to
> future changes to these bg deletion paths.

Which version is that? I'll add stable tag anyway but for a cross
reference from a real deployment. Thanks.
