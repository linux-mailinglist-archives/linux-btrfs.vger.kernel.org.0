Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D723718556
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 16:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjEaOvm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 10:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjEaOvl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 10:51:41 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2125E2
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 07:51:37 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5F1C15C0156;
        Wed, 31 May 2023 10:51:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 31 May 2023 10:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1685544696; x=1685631096; bh=HyyZnmNFYIEBupzIBVxZ6H/8Y7SnMctyebk
        akhMoDe4=; b=G9DdEdud0y0Ql9B7FUMGE/c+oTeuK2ChbxWtnHqsFKiZu9LNlKu
        vSG3R/xd/be6kbTZdcIoP0vJlvAJQC3MiFx1/d5quWadTk6xNcRUkGtJIwlV6tGf
        4nUHh90HoQcuJpUFOKtsm5/PQyAQoEnAEVwwuWEviIoGZsGPb250eY4Jvo4Vfdqo
        xg2tE2MSTaTga8wzqz96K4IALvUVTIrrvIl44mRXI42Kx93RlZiWAZCPsRyDkB5a
        wd8VIN8npDrUP4BNJDgErc9ZBYxl1miWHGuSxqOUSyl6GbtCfE99xQuhFi369Qke
        YasFgIk+G1JMcksy9WYrLThMjW/qvaW479Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685544696; x=1685631096; bh=HyyZnmNFYIEBupzIBVxZ6H/8Y7SnMctyebk
        akhMoDe4=; b=I68bIcpbhr0q8n3y92NuwCI+MbOSYR9RVXh/Y/hBOWKj+RJrPYo
        IGVFCFwxeCTwzjYuCjU8mFMKTo8WQw218AScdS88KBGwXL5QNQOdSzk5zHlxRYAB
        eyN3M9lU3rYGpo88epOiLB8NRDpybCbIVSRFTEnp9F3uwAGcKGUBKZHv+5Xl57Lw
        sfjHSqdKYEkoVbAyH3zD/j/42SsUjT1guQhO/9Wd/ANKF/+NeM7WsL+jStvUnBaY
        wN2zk6HZHmCEIaU4+pVhgcrvlPVoUgJzfqLVXoY6iPrGVCrZf/0Z8T6s8j3EmRHT
        mYIcXd0C0zeFbhAYNWrpQm2Yam8Q4ij3uMA==
X-ME-Sender: <xms:-F53ZGPGRN7_X3YOMV0-kQzjvMZZkMglQ7Uzz6lFi5ZeklBHpWcSQA>
    <xme:-F53ZE-Gv3L4RQ8fnfVjjDP36r8yNnXTqRGVrllQuheRtDQoneRdsmNF6UHsptblm
    x4Qd6Uv2J2mpsCI0sY>
X-ME-Received: <xmr:-F53ZNSBazi1UBsQG1cSwSJMzehOgUQoT-NVUFdk_cK3dnxaMW_9Ynmx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekledgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epudelhfdthfetuddvtefhfedtiedtteehvddtkedvledtvdevgedtuedutdeitdeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:-F53ZGsrvmhRV4T4LaajzhzNA0OMTtYZ7aVlXuotox5sdczqMvLE9g>
    <xmx:-F53ZOdi4oBTH6OohwV5PllX-fGRiodjqd0cQrGT4dqDFqMVzU0cVQ>
    <xmx:-F53ZK1CGkUSAufy1gS-nNScp5LEP4SDhNmhaL5mMt8jPti8AR19qw>
    <xmx:-F53ZCEZSXSQaU1H9_FLYY5TYfxSqrAfPb0gL8phTArXjucpoFeirw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 May 2023 10:51:35 -0400 (EDT)
Date:   Wed, 31 May 2023 07:51:25 -0700
From:   Boris Burkov <boris@bur.io>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/2] btrfs: warn on invalid slot in tree mod log rewind
Message-ID: <20230531145125.GA2249308@zen>
References: <cover.1685474139.git.boris@bur.io>
 <ab57e130bc466300efe32f36e623e546e4cfa85d.1685474140.git.boris@bur.io>
 <CAL3q7H6Fage2sJLY6JEdzPVJGogOqHWWNnbpRL2gU3o24x9F6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H6Fage2sJLY6JEdzPVJGogOqHWWNnbpRL2gU3o24x9F6w@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 31, 2023 at 01:37:32PM +0100, Filipe Manana wrote:
> On Tue, May 30, 2023 at 8:52 PM Boris Burkov <boris@bur.io> wrote:
> >
> > The way that tree mod log tracks the ultimate length of the eb, the
> > variable 'n', eventually turns up the correct value, but at intermediate
> > steps during the rewind, n can be inaccurate as a representation of the
> > end of the eb. For example, it doesn't get updated on move rewinds, and
> > it does get updated for add/remove in the middle of the eb.
> >
> > To detect cases with invalid moves, introduce a separate variable called
> > max_slot which tries to track the maximum valid slot in the rewind eb.
> > We can then warn if we do a move whose src range goes beyond the max
> > valid slot.
> >
> > There is a commented caveat that it is possible to have this value be an
> > overestimate due to the challenge of properly handling 'add' operations
> > in the middle of the eb, but in practice it doesn't cause enough of a
> > problem to throw out the max idea in favor of tracking every valid slot.
> >
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >  fs/btrfs/tree-mod-log.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
> > index a555baa0143a..1b1ae9ce9d1e 100644
> > --- a/fs/btrfs/tree-mod-log.c
> > +++ b/fs/btrfs/tree-mod-log.c
> > @@ -664,8 +664,10 @@ static void tree_mod_log_rewind(struct btrfs_fs_info *fs_info,
> >         unsigned long o_dst;
> >         unsigned long o_src;
> >         unsigned long p_size = sizeof(struct btrfs_key_ptr);
> > +       u32 max_slot;
> >
> >         n = btrfs_header_nritems(eb);
> > +       max_slot = n - 1;
> >         read_lock(&fs_info->tree_mod_log_lock);
> >         while (tm && tm->seq >= time_seq) {
> >                 /*
> > @@ -684,6 +686,8 @@ static void tree_mod_log_rewind(struct btrfs_fs_info *fs_info,
> >                         btrfs_set_node_ptr_generation(eb, tm->slot,
> >                                                       tm->generation);
> >                         n++;
> > +                       if (max_slot == (u32)-1 || tm->slot > max_slot)
> > +                               max_slot = tm->slot;
> >                         break;
> >                 case BTRFS_MOD_LOG_KEY_REPLACE:
> >                         BUG_ON(tm->slot >= n);
> > @@ -693,6 +697,15 @@ static void tree_mod_log_rewind(struct btrfs_fs_info *fs_info,
> >                                                       tm->generation);
> >                         break;
> >                 case BTRFS_MOD_LOG_KEY_ADD:
> > +                       /*
> > +                        * It is possible we could have already removed keys behind the known
> > +                        * max slot, so this will be an overestimate. In practice, the copy
> > +                        * operation inserts them in increasing order, and overestimating just
> > +                        * means we miss some warnings, so it's OK. It isn't worth carefully
> > +                        * tracking the full array of valid slots to check against when moving.
> > +                        */
> > +                       if (tm->slot == max_slot)
> > +                               max_slot--;
> >                         /* if a move operation is needed it's in the log */
> >                         n--;
> >                         break;
> > @@ -701,6 +714,12 @@ static void tree_mod_log_rewind(struct btrfs_fs_info *fs_info,
> >                         o_src = btrfs_node_key_ptr_offset(eb, tm->move.dst_slot);
> >                         memmove_extent_buffer(eb, o_dst, o_src,
> >                                               tm->move.nr_items * p_size);
> > +                       WARN((tm->move.dst_slot + tm->move.nr_items - 1 > max_slot) ||
> > +                            (max_slot == (u32)-1 && tm->move.nr_items > 0),
> 
> Why the: "tm->move.nr_items > 0" ?
> It's actually a bug, or in the best case a pointless operation that
> should not have been logged, to have a move operation for 0 items.

My thinking was that max_slot models the maximum valid slot with
(u32)-1 meaning "no slot is valid". But a move of size 0 doesn't read
any slot so doesn't constitute a bug per-se, just a dumb no-op tree mod
log entry. I can still warn on it, if you think that's better.

> 
> > +                            "Move from invalid tree mod log slot eb %llu slot %d dst_slot %d nr_items %d seq %llu n %u max_slot %u\n",
> > +                            eb->start, tm->slot, tm->move.dst_slot, tm->move.nr_items,
> > +                            tm->seq, n, max_slot);
> 
> Why trigger the warning after doing the memmove, and not before?
> I would say it's preferable, because in case the bad memmove triggers
> a crash/panic, we get the warning logged with some useful information.
> 
> It's also possibly better to log using the btrfs_warn() helper, as it
> prints information about the affected filesystem, etc.
> So like a: if (WARN_ON(conditions)) btrfs_warn()

Good points, thanks for the review.

> 
> Thanks.
> 
> 
> > +                       max_slot = tm->slot + tm->move.nr_items - 1;
> >                         break;
> >                 case BTRFS_MOD_LOG_ROOT_REPLACE:
> >                         /*
> > --
> > 2.40.1
> >
