Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C122C6CB281
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 01:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjC0XfT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 19:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjC0XfN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 19:35:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CCD2129
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 16:35:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 12ADD219DB;
        Mon, 27 Mar 2023 23:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679960100;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kHzgvWw1K/LFrA3L81qqobFYl+YaoKHCOFbk3RZVHsQ=;
        b=hdPPvyMoBmremEanZbrZS+V4C0nW4E13Nxo4xFqLFe9tOs+wTQ7PgHEAZpbdfhorBLlY9y
        uro1iqGp9QgiHpZNRJ5mN27EyXinsGEBvcESNR54yHzF7Zthj965INa7FrzZfB9IguCrPf
        S+Fo7DxJx2Yx/71AJibWLO4IXumawtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679960100;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kHzgvWw1K/LFrA3L81qqobFYl+YaoKHCOFbk3RZVHsQ=;
        b=SDYWklZFw/iieYAGy+UlfJ35Z+yeLGjj4gDL9uln+ucPyfmaqaNSZn+GM3ekGbd0KlC6C7
        KpEzmcYNDI1D19Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D5A4213482;
        Mon, 27 Mar 2023 23:34:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tNcbMyMoImTZaQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 27 Mar 2023 23:34:59 +0000
Date:   Tue, 28 Mar 2023 01:28:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 00/12] btrfs: scrub: use a more reader friendly code
 to implement scrub_simple_mirror()
Message-ID: <20230327232846.GL10580@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1679278088.git.wqu@suse.com>
 <20230321000918.GI10580@twin.jikos.cz>
 <0a96db1a-84a0-5fc5-3e92-8824c29907b9@gmx.com>
 <20230323175118.GV10580@twin.jikos.cz>
 <10dba572-0877-b372-3790-32bd6c116afa@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10dba572-0877-b372-3790-32bd6c116afa@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 24, 2023 at 08:42:22AM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/3/24 01:51, David Sterba wrote:
> > On Thu, Mar 23, 2023 at 02:28:16PM +0800, Qu Wenruo wrote:
> >>
> >>
> >> On 2023/3/21 08:09, David Sterba wrote:
> >>> On Mon, Mar 20, 2023 at 10:12:46AM +0800, Qu Wenruo wrote:
> >>>> [TODO]
> >>>>
> >>>> - More testing on zoned devices
> >>>>     Now the patchset can already pass all scrub/replace groups with
> >>>>     regular devices.
> >>>
> >>> I think I noticed some disparity in the old and new code for the zoned
> >>> devices. This should be found by testing so I'd add this series to
> >>> for-next and see.
> >>
> >> Just want to be sure, if I want to further update the series (mostly
> >> style and small cleanups), I should just base all my updates on your
> >> for-next branch, right?
> > 
> > No, please base it on misc-next. For-next is for an early testing but
> > patchsets can be updated or completely dropped.
> 
> My bad, my question should be: Should I fetch all the patches from for-next?
> 
> Because I thought there may be some modification when you apply the 
> patches, but it turns out it's really applied as is, so no need for that.

Ah I see what you mean, yeah that's a valid question. For patches that
get feedback regarding non-trivial changes I don't do my edits until
it's more or less finalized. This is implied by the status in the
mailing list, not reflected in the branch names, or if there's a tracking
issue for the patchset I add the 'update' label.
