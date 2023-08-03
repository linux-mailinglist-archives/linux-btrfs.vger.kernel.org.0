Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D14176DCD6
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Aug 2023 02:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbjHCAo7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Aug 2023 20:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjHCAo6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Aug 2023 20:44:58 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DF819BE
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 17:44:51 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 3C9A8320090F;
        Wed,  2 Aug 2023 20:44:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 02 Aug 2023 20:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1691023489; x=1691109889; bh=1S
        2bnLziETtFgiwBCeXFpTUnNbhFSc4gLGj2rm9IAOc=; b=ooULmeQrmOL7keo0yX
        eTJRON/z6XGTnlpSwW+ZsPiIq0Yf7sPIJv2Rd+qk/NBTZyHAl/U/gnf2aLMv2LVU
        97Z7ymsv3Bp7i0H06y1aJZiK275q7aC1wAxG3MdEkxCIml2BOB0lmAU3b3iF8v/j
        zKKyezNiOBRd+kt8E1quDmi59RzhDQD1+xDAue2Nf/l9VTVdJmagvsqPxuH2Bp/v
        gVBoSwBihEmbpqsib18YcDMmkzq+kc7gZxN10mYoJ4Qc9VrA27hHVLVnKJ3zvI/h
        zSR+pIxdphFGLnbUPVxr6omfG0MwAlNf5urIBZtkVIz+2cUs9NoX3oW6eiUMyyVS
        iSYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691023489; x=1691109889; bh=1S2bnLziETtFg
        iwBCeXFpTUnNbhFSc4gLGj2rm9IAOc=; b=PVka/K6qeEkLypy3NNTsfGBeo6ISZ
        tKmKrRqs+HJUpk2UNviswsdWRKZxzP9RSrL2qgzJxQaEmnmGCfcGiy+RuF4B7eav
        kySTehMs7klgPBUwyNNE4Ijev5AjYJqFrQxnDxUDc+C5jNPrGNsuogBC8o9BWV5G
        JW1EE9ouaM371lnpCno17XVRlXzJDLmKaUE5zsfLMzyJ/7VycFrZg/0hnuW9+q0F
        EE4iDz6VIfXO4qbB3rwIDnhrUnLD+zbWvHIWOQ0eJ5CMaWWRByBP9IDh9c3bq8o8
        HhHCTcBqETCVdP0yKwjH6ZsTmRt7UyGgTiceFgLB5hQgNZd5VD06Tc3+A==
X-ME-Sender: <xms:gfjKZBLx7_QaOaxxxcRd2WP8JohAdZkfPfx-KQ2qD1Rq87WURBo01Q>
    <xme:gfjKZNLsTf03szpXy2TkAQwfzRvhHPHEjmdQn5StHNOl-VmOFU6iy9hJLUCgEFgNl
    9wLHiSn44gi2mvuGo0>
X-ME-Received: <xmr:gfjKZJvZ6kFy-ywWTAntQmgzTn4-KNOrGOW4dVwK0nEieMxOU8isBfIWzVVDeQ5akPFkU67xdmflpehQADe6ioOZNx0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkedugdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepke
    dvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihho
X-ME-Proxy: <xmx:gfjKZCZVR1oyw_ZkGvGZj5zNHdenJ1nLjajkExy1fHVpMWlL8EtW2Q>
    <xmx:gfjKZIYpKzaMX7keu2FKGQRp72qkDKMkBtAH2LDWbRGZJbs9ZdcC0w>
    <xmx:gfjKZGCuHdRP8N3p2NkvU6O_CAgGCRxa2oyrOf9-krE97z117Ok0Ng>
    <xmx:gfjKZAGAqYBiZ8VLKCPMPfv53SOeA-f56_D1r1R6XR-Vscfjh3mZlQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Aug 2023 20:44:49 -0400 (EDT)
Date:   Wed, 2 Aug 2023 17:42:59 -0700
From:   Boris Burkov <boris@bur.io>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 6/9] btrfs: stop submitting I/O after an error in
 extent_write_locked_range
Message-ID: <20230803004259.GC1934467@zen>
References: <20230724132701.816771-1-hch@lst.de>
 <20230724132701.816771-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724132701.816771-7-hch@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 24, 2023 at 06:26:58AM -0700, Christoph Hellwig wrote:
> As soon a __extent_writepage_io returns an error we know that the
> extent_map is corrupted or we're out of memory, and there is no point
> in continuing to submit I/O.  Follow the behavior in extent_write_cache
> pages and stop submitting I/O, and instead just unlock all pages.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Boris Burkov <boris@bur.io>
