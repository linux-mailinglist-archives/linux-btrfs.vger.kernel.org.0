Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E2771A201
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jun 2023 17:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbjFAPHN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jun 2023 11:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbjFAPGx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jun 2023 11:06:53 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB256E40
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Jun 2023 08:05:36 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 59BE15C012F;
        Thu,  1 Jun 2023 11:04:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 01 Jun 2023 11:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1685631880; x=1685718280; bh=WRMXWM2LWWIyTwdwoJ/sV+Qn/8BN+o42acs
        vJZbrqEk=; b=i6htiICGuJZtlbZnjtiHMyAawJD60yzCe9wLFAqfp+nmlzdpRlr
        Uv2x5SnZQDjojrVxWOVJr/mwKbDvAzKsb8fici6SjzMoNBAKF3/dLFROTK1ahJrd
        meNTAkFxQ286nXbHqmnuY+3VjO2hSvQgl3rHjsertS+3KOM1bg+iy1xMWnrLUN6C
        uYJatSEps3zRt1XYw/bXfTcBuW3zhpgZKD1B/aC5XMwy7VT/Xttc00P6b8vR7ZGx
        bbF+l8m8N/Doh2S2158Uqz10d0p8VJ9i6yEze1S/kkgZLpq9D8wBw8kDPmnEiNcA
        sSKrPUbdQ4PNO5pTlVR/p8Lt3ePM4SbtOAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685631880; x=1685718280; bh=WRMXWM2LWWIyTwdwoJ/sV+Qn/8BN+o42acs
        vJZbrqEk=; b=lxJ9VqGn8NWJo3nXUZNecm4VYUxdMGpPDOoRnf+SLbf44Wd5fjt
        HJL0lNISa8OFOKsS+Nc90Ko9INIfLRVjW+Y1msSgQIAmQl7bNOrg91xGARcHi/nj
        eQ10IRa+FvoOHtdgmRqr8qmlnbCPUifKBbe22uWTbOUdc+G5xmO8KyUfF5Vshada
        ZhjxDbz4sxUfSddOWeLryltwD5Z//IWr24ebvmeswS8N0wlOqzTw2t7cNlxaL90Z
        W0N5Owc+e53YA8hTwAEn04e/GiyPygqqMWyPeyEold+b9Y+I3LZyjWqgh2M0zz5P
        v8dz9z3Fk1ivcncIox9OqG01UcmnE7d0WhQ==
X-ME-Sender: <xms:iLN4ZJjKwrJ4ikvcXm19LwCfKpNggFPkreF2tnnkhAPClGDgw_KWhw>
    <xme:iLN4ZODuCvuPSVdEhwoev-fjutdgD8xgF-rs3GjJrQwanzr5KZ2ExZhFCe1Sx7YWT
    iJ-0lAfsdPJNFsPFHM>
X-ME-Received: <xmr:iLN4ZJFNJSQ4nAJb5QEKSpfopubrqex5_yY4uIY_CXM-bI-SzDaJloPs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeluddgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epudelhfdthfetuddvtefhfedtiedtteehvddtkedvledtvdevgedtuedutdeitdeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:iLN4ZOS4IWye56OyzhOcpTmqeTCQaE8cH3tFZrafkHqw-xmmVeMESQ>
    <xmx:iLN4ZGxV7LxBznQaYZ-MbK6Z9giaNiC59PvCRQ354U4ghymDPwpLsw>
    <xmx:iLN4ZE4D1q2iDOUpxXUsUiZ1kAZHW2E7LZEErIK8a3H18hSzXlhsqQ>
    <xmx:iLN4ZLp8eVKkDCX61ceEGL09t_L8DcPe5RQWSK1BDbcV7ktgtFt4pA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Jun 2023 11:04:39 -0400 (EDT)
Date:   Thu, 1 Jun 2023 08:04:27 -0700
From:   Boris Burkov <boris@bur.io>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 1/2] btrfs: warn on invalid slot in tree mod log rewind
Message-ID: <20230601150427.GA351553@zen>
References: <cover.1685546114.git.boris@bur.io>
 <bc3d9ec0aac7a1514165170c5fb73ed8f5d3a68b.1685546114.git.boris@bur.io>
 <CAL3q7H7paNTeHhF35o-1MVAfNzXFH6NW-vOVayk0V6u_u8o11Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H7paNTeHhF35o-1MVAfNzXFH6NW-vOVayk0V6u_u8o11Q@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 01, 2023 at 10:28:58AM +0100, Filipe Manana wrote:
> On Wed, May 31, 2023 at 5:22 PM Boris Burkov <boris@bur.io> wrote:
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
> >  fs/btrfs/tree-mod-log.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
> > index a555baa0143a..43f2ffa6f44d 100644
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
> 
> It would be better to document the intention of the special value
> (u32)-1, and perhaps also let the type be
> a signed integer and just check for -1 as meaning "no valid slot".

I really like the signed integer idea, I'll do that for v3.

> 
> > +                               max_slot = tm->slot;
> >                         break;
> >                 case BTRFS_MOD_LOG_KEY_REPLACE:
> >                         BUG_ON(tm->slot >= n);
> > @@ -693,12 +697,30 @@ static void tree_mod_log_rewind(struct btrfs_fs_info *fs_info,
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
> >                 case BTRFS_MOD_LOG_MOVE_KEYS:
> >                         o_dst = btrfs_node_key_ptr_offset(eb, tm->slot);
> >                         o_src = btrfs_node_key_ptr_offset(eb, tm->move.dst_slot);
> > +                       if (WARN_ON((tm->move.dst_slot + tm->move.nr_items - 1 > max_slot) ||
> > +                                   (max_slot == (u32)-1 && tm->move.nr_items > 0))) {
> 
> Like v1, I'm still a bit at odds with the check for  tm->move.nr_items > 0
> 
> Such a case should never be possible, we should assert that
> separately, plus when I read this it makes me think:
> why do we check it only when max_slot is (u32)-1 but not for the
> previous condition?
> It makes me think what would happen to the first condition if it's 0
> and dst_slot happens to be 0, we have an underflow, etc

Good point, I am actually assuming it is >0 for that other calculation,
so 0 is not as "valid" (if obviously pointless) of a value as I argued.

> 
> Maybe add an ASSERT(tm->move.nr_items > 0) before.

I think this is a good idea, and I'll mix it into the warning too. I
think the only thing I would "insist" on is that I don't want to panic
non debug builds on this condition, even if I can't think of a way it
would happen.

> 
> Thanks.
> 
> 
> > +                               btrfs_warn(fs_info,
> > +                                          "Move from invalid tree mod log slot eb %llu slot %d dst_slot %d nr_items %d seq %llu n %u max_slot %u\n",
> > +                                          eb->start, tm->slot,
> > +                                          tm->move.dst_slot, tm->move.nr_items,
> > +                                          tm->seq, n, max_slot);
> > +
> > +                       }
> >                         memmove_extent_buffer(eb, o_dst, o_src,
> >                                               tm->move.nr_items * p_size);
> >                         break;
> > --
> > 2.40.1
> >
