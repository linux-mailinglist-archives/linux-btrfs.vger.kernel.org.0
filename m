Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0860379AFB5
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 01:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356214AbjIKWDM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 18:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243915AbjIKSTL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 14:19:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF69110
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 11:19:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0F8F91F38D;
        Mon, 11 Sep 2023 18:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694456346;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CnDy+qcoNmJWgIicxpIEKVqF8dIjIW21rSfcfs+vVZk=;
        b=otitNM2hjP+0M7Qgx31GyDis2xrABUbZufvFWx0n3Hxi0wySIZk22pHhmoxIGGpEUYLVvI
        9W7czsXZeQSMBRxn1sBQwsHFaDfNdf0Ho+GDZP0OjKv+ukMZk+Ppg6OneLSFpFMcx97XxE
        vtNBihuvMEf1gmJccePF5gMV2uuOTpY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694456346;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CnDy+qcoNmJWgIicxpIEKVqF8dIjIW21rSfcfs+vVZk=;
        b=kwXit/Fqr0Ai9RYrVspN29bh0EdMCpu8QKhaNmaF00Ylom4husmy4gQQ+qJNsYL7gihn8O
        f9g1jLkWJhHb5dAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E5B2F13780;
        Mon, 11 Sep 2023 18:19:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DnxMNxla/2TUPAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 11 Sep 2023 18:19:05 +0000
Date:   Mon, 11 Sep 2023 20:12:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v5 00/18] btrfs: simple quotas
Message-ID: <20230911181231.GH3159@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1690495785.git.boris@bur.io>
 <20230907105115.GA3159@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907105115.GA3159@twin.jikos.cz>
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

On Thu, Sep 07, 2023 at 12:51:15PM +0200, David Sterba wrote:
> On Thu, Jul 27, 2023 at 03:12:47PM -0700, Boris Burkov wrote:
> I've added the patchset to for-next,

There's a merge conflict due to Filipe's delayed refs changes,
"btrfs: record simple quota deltas" new parameter to
__btrfs_free_extent, run_delayed_data_ref and maybe others. I may
resolve that for for-next but this could duplicate work if you that too
so I can wait for a resend with other things updated.
