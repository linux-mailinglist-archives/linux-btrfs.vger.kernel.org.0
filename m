Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8A8797D9F
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Sep 2023 22:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbjIGUzo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 16:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjIGUzn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 16:55:43 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBBA1990
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 13:55:39 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id D90E55C0134;
        Thu,  7 Sep 2023 16:55:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 07 Sep 2023 16:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1694120138; x=1694206538; bh=/h
        cP65p+2ftBOtSPOcb9jee32LWYMrQ1TMEukNZAcKc=; b=cvYpa3qECJp0xcHEiw
        pCTWA3RSpqrHvkXMU/K+Hhk88uygDGbCqOkUw0NMvs3VnFFW58q6Ff361N82oTen
        5ax/qCJmyJbPVtKkYLuD0HXLyVCSpDHVnwgDjyMDGC6Ajqj9BelJzMqt/eWAnGLG
        +wxVYyxsYi0YzYEP2n78ydvzmGWWmu91qYnaLbQuLCNMSB4I6xYT/7EUzJVsFsIb
        WlqMlG4QEolhy4lHHM665BtIUevWLjfbqDfdy3JjslRRB4QmN1tS/AvI8PPNUMvp
        JfEM14JatFOtD+00/dDRKh8GUStFUqWClR4YL+LCoh7R16SRnYx866s/K4X4o6Zu
        jucg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694120138; x=1694206538; bh=/hcP65p+2ftBO
        tSPOcb9jee32LWYMrQ1TMEukNZAcKc=; b=HWUR9MSON3RQ1/S5WPQUgemkMiAHm
        fm1giLZPkfbadZ7bKAql+lVrBQl8mvilHl/rKLqSbosnkJKtUGwO5OvLXd2yN9sS
        yBnn4J7orAz1Ug1GaZtj4dxfWNPxKYhm5dr3Ri5X+V/fpUM+qoRLVwMKYqPt/3Ri
        O+98DBuwzQJsiJv2zIlR/C9RxwtIEXUnHWDgRbcJanJEQsMQ7abZ4PaqXeEz7cZx
        upIs9jmZanY1z+ux8EHqFrE/nFcPLaPjsX33dffAWgi3IsJS/gaF1YglhhfOBn45
        1SPTmImnLIu7jxa95LAlKux0rqzvV36BB5NLMXbE2d3izsfxe9rXDlnYA==
X-ME-Sender: <xms:yjj6ZPzppwXC3BIzZIZOCgVf9I2xU-QANVhDURknzjlZuYnDxPg_Ug>
    <xme:yjj6ZHQk_cgjBImK7J3_sreyJL-OmY9ALMs_DiQW6Dd_c2bUsn671lFxMs8Mv3lB2
    hhR2AT_OgKaAkFXbX8>
X-ME-Received: <xmr:yjj6ZJUV2Syx8ZPM8FXR05RkLqszwmDLnlL31dd5kEdBmzCHGazUsQH9jBqB_exNMUjRnZqBMyWtE1mJsOqrCA0mhAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehhedgudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:yjj6ZJh6EYIWjVignD9M5ojJgHx27IzwVli8gNajlXDj_X2JaChu0A>
    <xmx:yjj6ZBCH-SV3zc5iytn6JKDgWos1Cz2ODBhnICmEzCspNGOwctnYvw>
    <xmx:yjj6ZCJ-PT7Nf8SE6n6OWgXAp1Wis2sZiRPgi2IOMR-XJiMziCuaow>
    <xmx:yjj6ZO5AtNqd4-UITu8SBDgofp3GqiMeTU7r5SMczJvG032zFOP-wQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Sep 2023 16:55:38 -0400 (EDT)
Date:   Thu, 7 Sep 2023 13:56:42 -0700
From:   Boris Burkov <boris@bur.io>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 04/18] btrfs: add simple_quota incompat feature to
 sysfs
Message-ID: <20230907205642.GB5581@zen>
References: <cover.1690495785.git.boris@bur.io>
 <f3aa781253502054034c839ab0d0b18ec35a3d3d.1690495785.git.boris@bur.io>
 <20230907112825.GD3159@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907112825.GD3159@twin.jikos.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 07, 2023 at 01:28:25PM +0200, David Sterba wrote:
> On Thu, Jul 27, 2023 at 03:12:51PM -0700, Boris Burkov wrote:
> > Add an entry in the features directory for the new incompat flag
> > 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >  fs/btrfs/sysfs.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> > index e53614753391..f62bba0068ca 100644
> > --- a/fs/btrfs/sysfs.c
> > +++ b/fs/btrfs/sysfs.c
> > @@ -291,6 +291,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
> >  BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
> >  BTRFS_FEAT_ATTR_COMPAT_RO(block_group_tree, BLOCK_GROUP_TREE);
> >  BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
> > +BTRFS_FEAT_ATTR_INCOMPAT(simple_quota, SIMPLE_QUOTA);
> 
> I'm not sure if you mentioned in the cover letter or if we had discussed
> it before, but does this need to be a full incompat bit? I.e. no mount
> on older kernels, compared to a COMPAT_RO which would allow
> read-only mount.

Unfortunately, as it is, simple quotas does need a full incompat bit.
That is because of the details of how the kernel parses inline refs, but
essentially that code relies on item size being fully exhausted by an
iteration that steps forward by hard-code-computed inline ref size
chunks. That parsing code blows up on the new structures in a way that
can't be fixed, as far as I can tell.

To be COMPAT_RO, we would need to introduce an entirely new item. We
discussed this in one of the early discussions and concluded that was
not worth the space cost compared to an inline item.

> 
> >  #ifdef CONFIG_BLK_DEV_ZONED
> >  BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
> >  #endif
> > @@ -322,6 +323,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
> >  	BTRFS_FEAT_ATTR_PTR(free_space_tree),
> >  	BTRFS_FEAT_ATTR_PTR(raid1c34),
> >  	BTRFS_FEAT_ATTR_PTR(block_group_tree),
> > +	BTRFS_FEAT_ATTR_PTR(simple_quota),
> >  #ifdef CONFIG_BLK_DEV_ZONED
> >  	BTRFS_FEAT_ATTR_PTR(zoned),
> >  #endif
> > -- 
> > 2.41.0
