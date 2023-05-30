Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B87716897
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 18:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjE3QER (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 12:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjE3QEP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 12:04:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B963B2
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 09:03:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6E24F1FDD9;
        Tue, 30 May 2023 16:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685462579;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NgOUGLrq65o8fiotajYsKZbpLVSfHiI0MxC/4vY3kN4=;
        b=DYXpvjZvLbvyE4nRGfiym6OdhJ+cXcKDh9U18iyDHP6YtfXtPmyCd6LrirYiybUmYH254g
        ukk4LV4otMp0cLta9ir5CsGL5KNR/FAou/G1FNCkLCxpMqx+PWd/YuEyYKySFr/Vf9IOj1
        GD/KkZbUPkr+kV8CrmUQD1FcN8T3h60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685462579;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NgOUGLrq65o8fiotajYsKZbpLVSfHiI0MxC/4vY3kN4=;
        b=NZobAQy5PwWPRoAOBTz3au+hlpjv9bfX47/baC8VXOronRobxmIENmEB6GdFJNi+JbGPsZ
        gsZUwxO+X2uR5dDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A0FB13597;
        Tue, 30 May 2023 16:02:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id r+p0DTMedmScIAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 30 May 2023 16:02:59 +0000
Date:   Tue, 30 May 2023 17:56:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     David Sterba <dsterba@suse.cz>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
        naohiro.aota@wdc.com
Subject: Re: [PATCH 3/3] btrfs: don't hold an extra reference for redirtied
 buffers
Message-ID: <20230530155648.GB30110@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230508145839.43725-1-hch@lst.de>
 <20230508145839.43725-4-hch@lst.de>
 <20230509225737.GK32559@twin.jikos.cz>
 <20230515092254.GA21580@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515092254.GA21580@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 15, 2023 at 11:22:54AM +0200, Christoph Hellwig wrote:
> On Wed, May 10, 2023 at 12:57:37AM +0200, David Sterba wrote:
> > On Mon, May 08, 2023 at 07:58:39AM -0700, Christoph Hellwig wrote:
> > > When btrfs_redirty_list_add redirties a buffer, it also acquires
> > > an extra reference that is released on transaction commit.  But
> > > this is not required as buffers that are dirty or under writeback
> > > are never freed (look for calls to extent_buffer_under_io())).
> > > 
> > > Remove the extra reference and the infrastructure used to drop it
> > > again.
> > 
> > I vaguely remember that the redirty list was need for zoned to avoid
> > some write pattern that disrupts the ordering, added in d3575156f662
> > ("btrfs: zoned: redirty released extent buffers").
> 
> So the redirting itself is needed for that - without it buffers where
> the dirty bit wasn't ever set would never get written, leading to a
> write outside of the zone pointer.  But the extra reference can't
> influece the write pattern, as we don't make writeback descriptions
> based of it.
> 
> > I'd appreciate more eyes on this patch, with the indirections and
> > writeback involved it's not clear to me that we don't need the list at
> > all.
> 
> My suspicision is that Aoto-san wanted the extra safety of the extra
> reference because he didn't want to trust or hadn't noticed the
> extent_buffer_under_io() magic.  Auto-san, can you confirm or deny? :)

The number of patches above this one in the queue is increasing so it
would get harder to remove it. I took another look and agree that
regarding the references it's safe but would still like a confirmation.
