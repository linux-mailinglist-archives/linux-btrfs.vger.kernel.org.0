Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EB462A348
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 21:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbiKOUqP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 15:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbiKOUqO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 15:46:14 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87BB30F60
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 12:46:13 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id E1F3C3200903;
        Tue, 15 Nov 2022 15:46:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 15 Nov 2022 15:46:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1668545172; x=1668631572; bh=Og9fg9afYM
        rGM4KJ1gIxGfagnpWeM44ar1VTO9zuogY=; b=fFvt4xoMqUyTzV8qiv7lgV/z11
        hz7RNiQqh4at/wP1L2KNArFA3y9mY8SKQUUxNTJMbYUQUI47O29BvA139/GUNWlj
        jslOezc1PzbaXWC+w9lm3wUEd4P28HIZMOz5qO/Bdgwx3mLF2VFsAE/+w5MRJ9z7
        nsn8t6lhpoE/0MR9t7b24edK0/1PppDvwBmu1cAMdP6JXqGG79Imj8AVVKr6zzdv
        d6YCCmDC5WOtczJQDy8Jc5pMAfyQ6Mtdyb/BA1j+ZN8HkTOAKov4AiwA1cLRGmXI
        wZRSm7CPC06XKzfqQ5yAODSWkaRpZYCNij45gB7psFAzCiuNXXE/CMWyhcOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668545172; x=1668631572; bh=Og9fg9afYMrGM4KJ1gIxGfagnpWe
        M44ar1VTO9zuogY=; b=dBa3rw18iheid33uSvnN27iYahVhSS497Bm/7FFyuHZM
        AXogqGJrI49gfeyZz9vHmWMUkryf8snsoyFCl0xmBFQaD/8/iOEQ2qPahziTMPN7
        nZmfeDno3qqOctGbMz3cJs/9HTxCjBPNDkKc0g5ULv309moWgbC3sFizKR7Nmpw2
        B7HiZjRb291yMHMKZKwjoBiVD/fqSs13Eij1Gj5BjzmMf2t4OsdZn4e0ieT7S/uJ
        aPd1cbpN4xBZ5+4zudyAinzxc33O7LumkLrtPo8OE9R1+t/RYfUbL025vX6tmJ92
        ygi1paw7CwhmEzVJ+P90BQBWlixVasy7JVmXtPedyA==
X-ME-Sender: <xms:lPpzY5roetagT_oLnOPFJr1Qqr4OICj086IFT-LRWobxrBxXCWz5kQ>
    <xme:lPpzY7qBPQEcMtHvxhfPM_oy370Ai2nzfRzRJyOU3E9E4PKLXdYYS7RA5i-gSMpyS
    QJCPU46q2AbbftooRk>
X-ME-Received: <xmr:lPpzY2OwlaQoD58d1TwJWoYwjASFTWFk0VkXOZ-HjHSfrdBHI2MtvayD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeeggddugedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvve
    eiieeiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:lPpzY054XEpjf0OmI73Cq_eR1Dk5XjemiNn0pC65EyYSwT_g1xKKFQ>
    <xmx:lPpzY44RoYVOQN0vTFhxJG51vJJXPnCZ8FKFgiA-MVfxOhTrblYJYQ>
    <xmx:lPpzY8ipKG-3rnS6Iz3ubxukJ4Q3OtePDddQ00ptFEJ2pgbNOcX9sQ>
    <xmx:lPpzY9hWdVPGJ5ksRDD_aa_rzQTicqOC4TYH9qIiKTwXz7Ui3xwaqg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Nov 2022 15:46:11 -0500 (EST)
Date:   Tue, 15 Nov 2022 12:46:10 -0800
From:   Boris Burkov <boris@bur.io>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs-progs: receive: add debug messages when
 processing fallocate
Message-ID: <Y3P6kndoSY1EellE@zen>
References: <cover.1668529099.git.fdmanana@suse.com>
 <7125ba99d511229e958daa14e385224e342b8a5c.1668529099.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7125ba99d511229e958daa14e385224e342b8a5c.1668529099.git.fdmanana@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 15, 2022 at 04:25:25PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Unlike for commands from the v1 stream, we have no debug messages logged
> when processing fallocate commands, which makes it harder to debug issues.
> 
> So add log messages, when the log verbosity level is >= 3, for fallocate
> commands, mentioning the value of all fields.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  cmds/receive.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/cmds/receive.c b/cmds/receive.c
> index b75a5634..e6f1aeab 100644
> --- a/cmds/receive.c
> +++ b/cmds/receive.c
> @@ -1296,6 +1296,11 @@ static int process_fallocate(const char *path, int mode, u64 offset, u64 len,
>  	struct btrfs_receive *rctx = user;
>  	char full_path[PATH_MAX];
>  
> +	if (bconf.verbose >= 3)
> +		fprintf(stderr,
> +			"fallocate %s - offset=%llu, len=%llu, mode=%d\n",
> +			path, offset, len, mode);
> +
>  	ret = path_cat_out(full_path, rctx->full_subvol_path, path);
>  	if (ret < 0) {
>  		error("fallocate: path invalid: %s", path);
> -- 
> 2.35.1
> 
