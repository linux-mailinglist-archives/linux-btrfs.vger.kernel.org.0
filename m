Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19D7797D93
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Sep 2023 22:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237013AbjIGUud (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 16:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjIGUud (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 16:50:33 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BFD1BCB
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 13:50:29 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C0DEF5C01CC;
        Thu,  7 Sep 2023 16:50:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 07 Sep 2023 16:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1694119828; x=1694206228; bh=hw
        zqJPRJza20zli6G+HAIDt2DWfMXFEP6lvX1HBf44I=; b=FlKsDGQjD/8HRE3097
        dv493hHo4r0N/HidPhkK46mENsJD/+91hlDWVPhuECYVXnkGj6iulUHcX1VY3CI4
        sKmmNpszWbs0mrugo+EN8FWbORTgg3SQVfFfeViTIolpchs4aGczBZpiPSIhHoIk
        dt04FzaeTAadAo96MthS6NAeks8Vb3reOD0CN6l4YYwSEOKmrJfmhjpOinz6vU55
        iyAjy5yxJg77zkAPp+612xqeVVlAO5nark2s3tNr7tnRGRSDa/b3e7vy1mwWL3Gq
        sPwGx5WDV2VBBwTYxQ0ccjfrE6KGdZLGXkGUhevxXBf5ia1BA/YLDh6T9iPw35k2
        GwRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694119828; x=1694206228; bh=hwzqJPRJza20z
        li6G+HAIDt2DWfMXFEP6lvX1HBf44I=; b=BjeONcTZ4NVGyZCR6iqzzjtOTFXXX
        n242T5uw7I1/6epbvPuFRWv2/v7dGGD8HfqvjnJqc33LyJJQjgBehUPnxySd12yy
        MVzbTLQGKD7rkpaFxty41C5nqS9wi/I9nU8lq3uFlfUyBjYJ479AeQneq2qGK+iH
        QGyELexyvblhyMiGOtroPC5heRL/y9maWQJTNUdpuxpIjlJyiZD6ye9i9i89gbF1
        0z8H2jyUZDKef6tkb2z1oB/eKBXWmoXfMHoLcG5VtvwrfqOyGp5dLv0Rup64FOy8
        oTVfS+Uke9fXBvKKGgeS1xtwCUPOR4Yh5dlrghZ0Db1m2pwwtBcGyk7jw==
X-ME-Sender: <xms:lDf6ZDr_L3caWb63EAPHsXMhjkQTo_JfZc6FAPjBgAg3dyNO-MV1sw>
    <xme:lDf6ZNrjK7x-BqddlEMM8MTUOm5ZW_FCwmOqBD42lgRsMXIq54c_trbvDf3em2Ccl
    z0FAkwS9oPmLXb9Wkc>
X-ME-Received: <xmr:lDf6ZAM4vp3P434psOKh0v1fjkI8iNLiI6wSCIVN7tBwEhIbyTeDdHDhoVHKeCXqG5PwJIJIAQtc3G9oPI-Fiiv_dUo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehhedgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:lDf6ZG7395FenwVjqLuiUWHuoJpYRff-E02ZziLwdENXiqvU9ecHNA>
    <xmx:lDf6ZC7yjKg74KESETfnqa9yCRgs08Amgqimj4PPDZpmdCB5LCenaA>
    <xmx:lDf6ZOgN5ww074R_B6oEDERkJz4vU-ibWnwLeLYiybgy9DUHTL6H5w>
    <xmx:lDf6ZIRC4QOaPxQ0YPP1uN2N_Em3-yKTsrBh7HEUdWQSQxaRayEmhg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Sep 2023 16:50:27 -0400 (EDT)
Date:   Thu, 7 Sep 2023 13:51:31 -0700
From:   Boris Burkov <boris@bur.io>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 00/18] btrfs: simple quotas
Message-ID: <20230907205131.GA5581@zen>
References: <cover.1690495785.git.boris@bur.io>
 <20230907105115.GA3159@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907105115.GA3159@twin.jikos.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 07, 2023 at 12:51:15PM +0200, David Sterba wrote:
> On Thu, Jul 27, 2023 at 03:12:47PM -0700, Boris Burkov wrote:
> > btrfs quota groups (qgroups) are a compelling feature of btrfs that
> > allow flexible control for limiting subvolume data and metadata usage.
> > However, due to btrfs's high level decision to tradeoff snapshot
> > performance against ref-counting performance, qgroups suffer from
> > non-trivial performance issues that make them unattractive in certain
> > workloads. Particularly, frequent backref walking during writes and
> > during commits can make operations increasingly expensive as the number
> > of snapshots scales up. For that reason, we have never been able to
> > commit to using qgroups in production at Meta, despite significant
> > interest from people running container workloads, where we would benefit
> > from protecting the rest of the host from a buggy application in a
> > container running away with disk usage. This patch series introduces a
> > simplified version of qgroups called
> > simple quotas (squotas) which never computes global reference counts
> > for extents, and thus has similar performance characteristics to normal,
> > quotas disabled, btrfs. The "trick" is that in simple quotas mode, we
> > account all extents permanently to the subvolume in which they were
> > originally created. That allows us to make all accounting 1:1 with
> > extent item lifetime, removing the need to walk backrefs. However,
> > this sacrifices the ability to compute shared vs. exclusive usage. It
> > also results in counter-intuitive, though still predictable and simple
> > accounting in the cases where an original extent is removed while a
> > shared copy still exists. Qgroups is able to detect that case and count
> > the remaining copy as an exclusive owner, while squotas is not. As a
> > result, squotas works best when the original extent is immutable and
> > outlives any clones.
> > 
> > ==Format Change==
> > In order to track the original creating subvolume of a data extent in
> > the face of reflinks, it is necessary to add additional accounting to
> > the extent item. To save space, this is done with a new inline ref item.
> > However, the downside of this approach is that it makes enabling squota
> > an incompat change, denoted by the new incompat bit SIMPLE_QUOTA. When
> > this bit is set and quotas are enabled, new extent items get the extra
> > accounting, and freed extent items check for the accounting to find
> > their creating subvolume. In addition, 1:1 with this incompat bit,
> > the quota status item now tracks a "quota enablement generation" needed
> > for properly handling deleting extents with predate enablement.
> > 
> > ==API==
> > Squotas reuses the api of qgroups.
> 
> So apart from the accounting, the hierarchy of qgroups can be still
> built as before, right? In the example you create a group 1/100 so I
> assume that it's still qgroups from the outside, and that the limits can
> be set.

Yes, you can create quota group hierarchies with the same nesting
behavior. I am only changing the accounting methodology (and added auto
hierarchy)

> 
> Because if not, then squotas would make more sense as a separate
> infrastructure, under quotas. Like that quotas are the abstraction while
> qgroups or squota would be the implementation.
> 
> > The only difference is that when you
> > enable quotas via `btrfs quota enable`, you pass the `--simple` flag.
> > Squotas will always report exclusive == shared for each qgroup. Squotas
> > deal with extent_item/metadata_item sizes and thus do not do anything
> > special with compression. Squotas also introduce auto inheritance for
> > nested subvols. The API is documented more fully in the documentation
> > patches in btrfs-progs.
> 
> The lack of exclusive size sharing will be confusing I guess, so we need
> to make it clear in the documentation and in the UI that it's either
> full or simple mode.

I am happy to iterate on that. I think always reporting as shared=0,
since the *ownership* is exclusive. I opted for making them equal since
it sort of both shared usage (we don't know if it's shared nor when it
will be freed) and exclusive usage (belongs to this subvol by owner ref)

> 
> I've added the patchset to for-next, we may need an iteration or two to
> fix some issues I've seen so far but on the fundamental level I think
> it's ok.
