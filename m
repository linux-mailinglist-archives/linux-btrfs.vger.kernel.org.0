Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218CA7DFC13
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Nov 2023 22:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjKBVpP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Nov 2023 17:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjKBVpP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 17:45:15 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E0D187
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Nov 2023 14:45:08 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 90B225C0060;
        Thu,  2 Nov 2023 17:45:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 02 Nov 2023 17:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1698961506; x=1699047906; bh=OS
        95olEUQjSBCy1jS3X/WpAnNvqfsZ3KBwsUZvHkir4=; b=q8SCtzrNAATplaTx2C
        nbeGMErw2nd66CImzN/vfm2owuVSha984rajteBAY+SBX4FCNoxt+WslrD53tyzc
        q8wjHRh6jqGuqStGVAdA/7NMz3Cg9U1Ykf9n+33LeBbWeR1ntx1cZ4JBsgJ4IuLs
        wSYjXEfLaY6afZYbd/3G+O8lTV+wwk24mOb9mNbTjIAR8/ykOwk+/YhW621IVxnE
        aGCHz685Mo+j6Vt1cosMxkGMS2OmvW6N4BmqYFdLklIHiwBjNFu3KB8jfU5gSjE0
        5BQMGb6PilmEWW5AA/jipdl4TDf2DvAozQfGkvdtKG8CgIbGvDgkT4t8TGFlOSd8
        5xrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698961506; x=1699047906; bh=OS95olEUQjSBC
        y1jS3X/WpAnNvqfsZ3KBwsUZvHkir4=; b=Vk4BQsq+DXvswrs6AGK9V3k2BBIY5
        Dun5/OXZB4PPM8fBrESsIIYpZ47UAfnOw7MuKs0k5DmlYQhS8vMvv76uW1wHrbPQ
        kW2kW/htSmhf3c910VhQWmvoYGzOhLAo6J7Hwr5l6QKzExKfC2JTa30yN3W1gt++
        fNnRtbP/qdmLi4RUoRze4yk5B9xh6PG9FDbxAIF1ukrj12uqac2XowqOIjo6y/7g
        LKmNbc+DUsjOyquvmwP72/in42uu41naXkQLBY0sGaLHCFl32vmFDqMPW+ILFHm8
        qj3AXBtb+ts534SL2FMlFwFwfZ3KbmhgBVPheSnYS+c+T7r0Koi+lNZnQ==
X-ME-Sender: <xms:YhhEZZ9y_WPW7arVnlKuPnujIO7iFFZHdUqDk8cDWoFCgadH5KB4Qg>
    <xme:YhhEZdvDbhzDuH13iIoSIxlxsEM9ZJAh20pB9tfw72pyy0ocyE9ZcySfGwqXwMjjA
    VKm4QT4_zQ4NIGXyz8>
X-ME-Received: <xmr:YhhEZXB-ZA6aqU4IwAo13MACav1YeUWSkY8veVPQ4mBPdLwDiNYcKee6A2E8knAmwS0OZP6m7Yxht4cEhbpT5xNPpXU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtiedgudehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:YhhEZdfhhV4Zkmi9Rmjj79guo9zRybC-i2HWbNHshPHs2wsjsGHSDw>
    <xmx:YhhEZeMWYGiJgxPp9blMpG6s-iRTwfXS4kFamHAOjxc-eyNhqmFQTA>
    <xmx:YhhEZflMpDnhOu0r3fTo24v6PHYB62nH8a306fJqihDQAiHNQpbEqw>
    <xmx:YhhEZQ2x8J5DWbxfib8f7ma__36R2M-9mzY_PPyWL1J9CtNkHShqmw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Nov 2023 17:45:05 -0400 (EDT)
Date:   Thu, 2 Nov 2023 14:46:27 -0700
From:   Boris Burkov <boris@bur.io>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: tree-checker: add type and sequence check for
 inline backrefs
Message-ID: <20231102214627.GA123395@zen.localdomain>
References: <23fbab97bd9dbce7869e858cb59d96a7238db57e.1698105469.git.wqu@suse.com>
 <20231102190720.GA113907@zen.localdomain>
 <d69a339c-0cc2-4168-ac90-f6c1b91517b4@gmx.com>
 <20231102203529.GA119621@zen.localdomain>
 <12595173-fdc6-4e49-9e37-e97a6b7e8606@gmx.com>
 <20231102213430.GA123227@zen.localdomain>
 <1035a27a-a1a9-492b-8d4d-3634367fece8@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1035a27a-a1a9-492b-8d4d-3634367fece8@gmx.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 03, 2023 at 08:09:10AM +1030, Qu Wenruo wrote:
> 
> 
> On 2023/11/3 08:04, Boris Burkov wrote:
> [...]
> > > 
> > > 
> > > Another thing to mention is, that EXTENT_OWNER_REF seems to be inlined
> > > only, has no keyed version.
> > > 
> > > I have already come upon a rare corner case:
> > > 
> > >    What if an EXTENT_ITEM is already so large that it can not add a new
> > >    inline ref?
> > > 
> > > I guess this can only be a problem for converting, as for now squota can
> > > only be enabled at mkfs time, thus the new EXTENT_OWNER_REF can always
> > > be inlined.
> > 
> > It's a good point, but the answer is slightly subtler. You can enable
> > squota on a live fs, it just doesn't/can't do the O(extents)
> > conversion for existing extents. The owner ref is created for all *new*
> > extent items, but when creating an extent item, you dictate the item
> > size which leaves enough room for the inline refs (including the owner
> > ref).
> 
> Oh, that's way safer.
> 
> Although I guess we may want btrfs-progs conversion support for an
> unmounted btrfs in the future, in that case we may need to consider the
> keyed version of EXTENT_OWNER_REF, to be able to handle an existing
> large EXTENT_ITEM.

I would love that, except I couldn't think of a way to do it while
keeping the semantics of simple quotas, well.. simple :)

We just don't know what subvol an extent is from post-hoc, so any
conversion would be guessing. Reflinks are really opaque from this
perspective (and the reason for needing this unpleasant format changing
item at all).

I suppose "pick the first ref for conversion" could be reasonable and
useful for some (all?) users.

Current btrfstune for squotas just turns it on for the next mount
without converting extents.

> 
> And of course, for the sake of consistency (since all the existing 4
> types all can be inlined or keyed).

True.

> 
> Thanks,
> Qu
> 
> > 
> > > 
> > > Thanks,
> > > Qu
> > > 
> > > > 
> > > > e.g., this works to fix it:
> > > > 
> > > > diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> > > > index 50fdc69fdddf..62150419c6d4 100644
> > > > --- a/fs/btrfs/tree-checker.c
> > > > +++ b/fs/btrfs/tree-checker.c
> > > > @@ -1496,6 +1496,9 @@ static int check_extent_item(struct extent_buffer *leaf,
> > > >    				   inline_type);
> > > >    			return -EUCLEAN;
> > > >    		}
> > > > +
> > > > +		if (last_type == BTRFS_EXTENT_OWNER_REF_KEY)
> > > > +			goto next;
> > > >    		if (inline_type < last_type) {
> > > >    			extent_err(leaf, slot,
> > > >    				   "inline ref out-of-order: has type %u, prev type %u",
> > > > @@ -1512,6 +1515,7 @@ static int check_extent_item(struct extent_buffer *leaf,
> > > >    				   last_type, last_seq);
> > > >    			return -EUCLEAN;
> > > >    		}
> > > > +next:
> > > >    		last_type = inline_type;
> > > >    		last_seq = seq;
> > > >    		ptr += btrfs_extent_inline_ref_size(inline_type);
> > > > 
> > > > > 
> > > > > If so, can we fix it in the kernel first?
> > > > > 
> > > > > Thanks,
> > > > > Qu
> > > > > > 
> > > > > > For a repro, btrfs/301 (available in the master fstests branch) fails
> > > > > > with the patch but passes without it.
