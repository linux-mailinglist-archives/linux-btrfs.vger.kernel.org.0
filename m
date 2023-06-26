Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8264A73DC63
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jun 2023 12:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjFZKlg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jun 2023 06:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjFZKlf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jun 2023 06:41:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F18DE60;
        Mon, 26 Jun 2023 03:41:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 15A492184D;
        Mon, 26 Jun 2023 10:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687776092;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BHBo2bZ95N8srXARN2sLMVRVxhFftEqboGwZ9EwEh4w=;
        b=dZt3ZXbp004V0rh85seO3FuqLH1tCpWJ2r3OzeqfyjK0K8ZBXReGFb8qxdY7Ghy/UeF/cw
        SQC8ji8MVSFRM+V2gbmPe9ntYHWbPEVtu5rZIdhyYfBTV02KnqOSR52JGkUIu35KqipqgE
        E0zaIYW33vn6h9GL1gq3DiAFSij3bcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687776092;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BHBo2bZ95N8srXARN2sLMVRVxhFftEqboGwZ9EwEh4w=;
        b=AjfvSXZnpH24L6jEtbqsXSVZb94Bkmm5pt5U51PymhacvLFkg9FV4I4A4biql6uwoVI9jB
        uskjZMIyAULPuvBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E61EC13905;
        Mon, 26 Jun 2023 10:41:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WZp2N1trmWQSFAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 26 Jun 2023 10:41:31 +0000
Date:   Mon, 26 Jun 2023 12:35:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] btrfs: add a test case to verify the write behavior of
 large RAID5 data chunks
Message-ID: <20230626103505.GX16168@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230622065438.86402-1-wqu@suse.com>
 <20230622172303.GV16168@twin.jikos.cz>
 <d97babbd-eab8-19cf-4839-7740f5642399@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d97babbd-eab8-19cf-4839-7740f5642399@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 23, 2023 at 06:03:54AM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/6/23 01:23, David Sterba wrote:
> > On Thu, Jun 22, 2023 at 02:54:38PM +0800, Qu Wenruo wrote:
> >> There is a recent regression during v6.4 merge window, that a u32 left
> >> shift overflow can cause problems with large data chunks (over 4G)
> >> sized.
> >>
> >> This is especially nasty for RAID56, which can lead to ASSERT() during
> >> regular writes, or corrupt memory if CONFIG_BTRFS_ASSERT is not enabled.
> >>
> >> This is the regression test case for it.
> >
> > I am not able to reproduce the problem with the previous fix
> > a7299a18a179a971 applied
> 
> Well, it's 100% reproducible here.

So the cause was that binaries of VM fstests built in fstests got out of
sync with the system and thus many things did not work. After resolving
that I was able to test it properly.
