Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2088278E220
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Aug 2023 00:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245203AbjH3WK4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Aug 2023 18:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245157AbjH3WKy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Aug 2023 18:10:54 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D4EC5
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Aug 2023 15:10:26 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B56EC5C00BB;
        Wed, 30 Aug 2023 18:09:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 30 Aug 2023 18:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1693433350; x=1693519750; bh=1z
        OgtgUDpWB15HAAGOtJcds/GajoCVi2CirhPwpKBw8=; b=dWiEvRn6CuhHiJgG6M
        dnHQtXmBgLzj3tw2BWD8MiYNIIsbHznQ7fYKQ12gXHZjBQ91fBSTBJSkZKDHLHTv
        FViW/kT07e2iXKvBuRJZKDlXA62F9dLuNt9jDM1+cyYpTza7OYkqXNm0MxLfANPy
        CeGZ/Nycbcf4gKoaYlwM9jR3im4NUXpheT8VV7Le13caLasLfVykYG1fhCeEm/wK
        IOvXq+vE6hta0/l9H15TGgzXSVmtyZe4jV5MM/KK51JAWfr3POqgYXOr/n/KwXeY
        gZIlKXn7giP9j/7+33TeFKAgiTbT6CudsLY1g4C24BC7ewXd3laEBnz30fFXChu9
        HtqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1693433350; x=1693519750; bh=1zOgtgUDpWB15
        HAAGOtJcds/GajoCVi2CirhPwpKBw8=; b=Djqw9+ltfqccwDGjpAF66a0iyXbxJ
        RKa0pWMBBsY/HssL/ln9e0HkaM72CPCSZBVSB6RszOdlxzUtFzAngihEKGq4ZkRO
        R2XTHPZ2E/3c4FmYw9cf78ABugghyTM2HhUzuGq3Q+U8pcnBshUlHQwLpa29K9XK
        0sTgzN8AEGzus0cuU4viUsb00T19sCVEk4i2sRg/P4qJuJjslCZeKdF6Uamar5c+
        m6sNimrmKxABItR29Pwq7QZJytlhsFH0aloxyMn5SXZvqsnNpvDtkAVh+EUGtdBo
        gBL6xykDSSOYFFk9aMrSDPmSlJI/vXFCn2FYYjwHqd5q6QHhtbGIin0lg==
X-ME-Sender: <xms:Br7vZADt2BJdXMCLufd2qbX2asrf9SPYlmdiI1vG18QCZxb71IXruA>
    <xme:Br7vZCgFQa_4Ira8_tBTsd1jMe-HIcQZ7SCM7xfMBIbPSfya6GfEdZm9mW_KgFCch
    BF-RN-ix0cC9TX9UjU>
X-ME-Received: <xmr:Br7vZDl6kXEUc6d88lnh1xe_WqTsbahzoI2Z4xrKvP60ItWrgFO0jMgu1kVe0jgnoGo8WrDrg15efFXiST4Z1V34nSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefledgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    elffegveegteeugeeltdeuledutddukeehhfduueehgeefveeiheetveeijeeuteenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:Br7vZGysL25rYGpyuSISo6WRaw3Q8aLxOC2a5SNvJeRdjwRaE6JEzQ>
    <xmx:Br7vZFQ2CZcNNnGHMEHV9C00tj-DWp7xJ-3pWz_xx7WdXKcNd8zScg>
    <xmx:Br7vZBY2EgQO1V8CaneI2Xfs1IwvFekkEJfC4DwLjRI_ChYvDxJE1A>
    <xmx:Br7vZG5FNDj3XBbazVDamIqjxzdMLUAsakb5shynYSYZdcFSEYwK7Q>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Aug 2023 18:09:10 -0400 (EDT)
Date:   Wed, 30 Aug 2023 15:06:37 -0700
From:   Boris Burkov <boris@bur.io>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5] btrfs: qgroup: reduce GFP_ATOMIC usage for ulist
Message-ID: <20230830220637.GB834639@zen>
References: <cover.1693391268.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1693391268.git.wqu@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 30, 2023 at 06:37:22PM +0800, Qu Wenruo wrote:
> [REPO]
> https://github.com/adam900710/linux/tree/qgroup_mutex
> 
> Yep, the branch name shows my previous failed attempt to solve the
> problem.
> 
> [PROBLEM]
> There are quite some GFP_ATOMIC usage for btrfs qgroups, most of them
> are for ulists.
> 
> Those ulists are just used as a temporary memory to trace the involved
> qgroups.
> 
> [ENHANCEMENT]
> This patchset would address the problem by adding a new list_head called
> iterator for btrfs_qgroup.
> 
> And all call sites but one of ulist allocation can be migrated to use
> the new qgroup_iterator facility to iterate qgroups without any memory
> allocation.
> 
> The only remaining ulist call site is @qgroups ulist utilized inside
> btrfs_qgroup_account_extent(), which is utilized to get all involved
> qgroups for both old and new roots.
> 
> I tried to extract the qgroups collection code into a dedicate loop
> out of qgroup_update_refcnt(), but it would lead to test case failure of
> btrfs/028 (accounts underflow).
> 
> Thus for now only the safe part is sent to the list.
> 
> And BTW since we can skip quite some memory allocation failure handling
> (since there is no memory allocation), we also save some lines of code.

These all LGTM, thanks!

Reviewed-by: Boris Burkov <boris@bur.io>

> 
> Qu Wenruo (5):
>   btrfs: qgroup: iterate qgroups without memory allocation for
>     qgroup_reserve()
>   btrfs: qgroup: use qgroup_iterator facility for
>     btrfs_qgroup_free_refroot()
>   btrfs: qgroup: use qgroup_iterator facility for qgroup_convert_meta()
>   btrfs: qgroup: use qgroup_iterator facility for
>     __qgroup_excl_accounting()
>   btrfs: qgroup: use qgroup_iterator facility to replace @tmp ulist of
>     qgroup_update_refcnt()
> 
>  fs/btrfs/qgroup.c | 252 ++++++++++++++++------------------------------
>  fs/btrfs/qgroup.h |   9 ++
>  2 files changed, 94 insertions(+), 167 deletions(-)
> 
> -- 
> 2.41.0
> 
