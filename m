Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED536C6FCA
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 18:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjCWR5f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 13:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjCWR5c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 13:57:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AC32FCC6
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 10:57:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3637133831;
        Thu, 23 Mar 2023 17:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679594250;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kpzsNz3SlZt7ND1tSJYPS3LxWGuMTq9lWCkwU2KtI2I=;
        b=sqp1S+EApnZsXkQuJUCJE/MtJqYFr04OOLDUWTHMrQBsOPOxHLoqyBiKSExzOnznR6qssP
        Hfwdz4CwzN8Ikwn/pkbwbTRXID6vNp18oyMdrzI4ZPprErwFWfRZOhcURHP6tOOUnVXREF
        4IMEZVpH40ZIwJIIWnk83U2/U8rjBww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679594250;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kpzsNz3SlZt7ND1tSJYPS3LxWGuMTq9lWCkwU2KtI2I=;
        b=wJEQVQtkffC8GxqTBtvNbB6imZjDuTVPO+6VnznthYTYf0n7Ny4vFxwKNM/yjpyrUs/B/y
        iDqiuziycxIA6TAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1096413596;
        Thu, 23 Mar 2023 17:57:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NqcDAwqTHGSgegAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 23 Mar 2023 17:57:30 +0000
Date:   Thu, 23 Mar 2023 18:51:18 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 00/12] btrfs: scrub: use a more reader friendly code
 to implement scrub_simple_mirror()
Message-ID: <20230323175118.GV10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1679278088.git.wqu@suse.com>
 <20230321000918.GI10580@twin.jikos.cz>
 <0a96db1a-84a0-5fc5-3e92-8824c29907b9@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a96db1a-84a0-5fc5-3e92-8824c29907b9@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 23, 2023 at 02:28:16PM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/3/21 08:09, David Sterba wrote:
> > On Mon, Mar 20, 2023 at 10:12:46AM +0800, Qu Wenruo wrote:
> >> [TODO]
> >>
> >> - More testing on zoned devices
> >>    Now the patchset can already pass all scrub/replace groups with
> >>    regular devices.
> > 
> > I think I noticed some disparity in the old and new code for the zoned
> > devices. This should be found by testing so I'd add this series to
> > for-next and see.
> 
> Just want to be sure, if I want to further update the series (mostly 
> style and small cleanups), I should just base all my updates on your 
> for-next branch, right?

No, please base it on misc-next. For-next is for an early testing but
patchsets can be updated or completely dropped.
