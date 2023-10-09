Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12C27BE7A5
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 19:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377871AbjJIRTp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Oct 2023 13:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377864AbjJIRTm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Oct 2023 13:19:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7905CC5
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Oct 2023 10:19:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E04E31F889;
        Mon,  9 Oct 2023 17:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696871978;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yYqAOf+uxan+9wDigIxFCm5zL9+H9LHh/dYHuNIhveg=;
        b=nBHsq1jBotWeS9+3/Pv2kZKkIbXjBwWwbDisAloejNFcmvuLBFJVoVE1aukAhee3O+JiBl
        W2lPjRyzDLurHF6yfpfvbKCpKFkC6iJKHbyOIkoCXzqkypN55UqtNzYiFsV05brGlAAQcc
        0vHos5i9NuKFdLAtAjPZFcSHdoOY6NE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696871978;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yYqAOf+uxan+9wDigIxFCm5zL9+H9LHh/dYHuNIhveg=;
        b=/5W65H40BeC9xk/fprTYMO3tmB0GzepxuYG9x+2n+IimEGi3PoCFsrMb7FJI8fw+WV8rhi
        79ExjUf/Fiwbb6Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF1E013905;
        Mon,  9 Oct 2023 17:19:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id R3/eLSo2JGVMagAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 09 Oct 2023 17:19:38 +0000
Date:   Mon, 9 Oct 2023 19:12:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: properly reserve metadata space for bgt
 conversion
Message-ID: <20231009171253.GV28758@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <6c556ce0456303fb8ec23a454c3b5e18b874ae91.1696291742.git.wqu@suse.com>
 <20231006153540.GK28758@twin.jikos.cz>
 <6a31bf7f-5109-4b72-a2ca-a915f3ca5732@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a31bf7f-5109-4b72-a2ca-a915f3ca5732@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 09, 2023 at 09:55:58AM +1030, Qu Wenruo wrote:
> 
> 
> On 2023/10/7 02:05, David Sterba wrote:
> > On Tue, Oct 03, 2023 at 10:39:18AM +1030, Qu Wenruo wrote:
> >> There is a bug report that btrfstune failed to convert to block group
> >> tree.
> >> The bug report shows some very weird call trace, mostly fail at free
> >> space tree code.
> > 
> > If you mention a bug report please either add a link or describe the key
> > details of the report.
> 
> Here it is:
> 
> https://lore.kernel.org/linux-btrfs/3c93d0b5-a8cb-ebe3-f8d6-76ea6340f23e@gmail.com/
> 
> I didn't put it in the first place is, it's really just an inspiration, 
> not a concrete bug report.

That's also good reason to mention it in the changelog as it's relevant
for the patch and can add more context e.g. about the use case.

> But for sure, in the future I can also put those inspirational reports 
> into "Link:" tag.

Yeah, you can mention id like "This is based on discussion in [1]" or
similar.

> >> One of the concern is the failed conversion may be caused by exhausted
> >> metadata space.
> >> In that case, we're doing quite some metadata operations (one
> >> transaction to convert 64 block groups in one go).
> >>
> >> But for each transaction we have only reserved the metadata for one
> >> block group conversion (1 block for extent tree and 1 block for block
> >> group tree, this excludes free space and extent tree operations, as they
> >> should go global rsv).
> >>
> >> Although we're not 100% sure about the failed conversion, at least we
> >> should handle the metadata reservation correctly, by properly reserve
> >> the needed space for the batch, and reduce the batch size just in case
> >> there isn't much metadata space left.
> > 
> > This is probably reasonable.
> 
> The change itself is reasonable, but don't be surprised that, 
> btrfs-progs has no metadata reservation at all.
> 
> It really goes allocate-as-we-can method, until it crashes at some 
> critical path, and make the fs unable to be mounted/used by kernel due 
> to -ENOSPC.

I am not surprised.

> The extra safenet for a simple metadata rsv check is introduced in this 
> patch:
> 
> https://lore.kernel.org/linux-btrfs/6081e57fe6f43b3ab44c883814c6a197513c66c0.1696489737.git.wqu@suse.com/

Thanks. I think historically there was not much need for that as the
only offlline writing action was 'check' that relied on the single
transaction to do everything. Now we do more conversion changes so the
sanity checks will be needed.
