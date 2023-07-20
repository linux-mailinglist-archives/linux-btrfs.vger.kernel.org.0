Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E97A75BAA1
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 00:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjGTWaZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 18:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjGTWaY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 18:30:24 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE12A1705
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 15:30:23 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5677D5C01B7;
        Thu, 20 Jul 2023 18:30:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 20 Jul 2023 18:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1689892223; x=1689978623; bh=jd
        o3vu27+54LUr0Uk/rjLqh4aXgzIP8DKz63RmHUyVQ=; b=aQDsIYhG+jnC8vgQVL
        pyxJpcG7frPcXbKaPKndJOlck/GXunz9lvGe4xCSEvTWIogw3i0E7yU0o1T3GOQU
        pG92+BLnyZNuZdEyRRE3aBhG9cGGsVMNpyW5EINRUrlOGKYXRHQsF+haEl1BJEgz
        PWZeRc14sKAJC7/vFiLaw/1QlymhKce6B/Qm/0QPXRB4zjfWWupraPsZDvh5MFEG
        Q1XK6idh9mMDAP7v2SAfHrC/VPWfkQu0iFEpiUxJtSyhncn3qFXJ1AyONBaUoTcQ
        /gyUpSh5i68mZmQVyBmyN2QXroaRCA2CpWQrmzbpleWRYsm1cq47jplrJl7MfDA0
        JzrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689892223; x=1689978623; bh=jdo3vu27+54LU
        r0Uk/rjLqh4aXgzIP8DKz63RmHUyVQ=; b=oKmq5ujyiR8l/GvdFNdTKq7ptmukH
        4DhFDptK1nZiBDyEh3IuimM6OSUrtBdq2XoPFUp8O3NxzH5B3Y1OVsZHRA78MsZ7
        DkBPRu0PIRXLKTOAh2qs0fDTaIQ73CRl0zkDDHpVihwUFcXfYQH1N8q+858Irib1
        yHehje39jKiiAuXnXzv3OyQDPE1D/svcqvVOQNdxBYK/Wag6CV03mN/ClptlYHp3
        1s57cuuu4Ls2M0RrW7IvzHurq6nphvZEMpzmHQZFpXX3T9r8r8bEbHGjZmshiVnU
        83iMms0vioOQZbE/1rwiukVRN3IF3gSRhv2AVCmdAsvLTcuUo2Yex87hQ==
X-ME-Sender: <xms:f7W5ZG-HxeyZJARpmKjoD3K2ItKtSeAX8U_VXTO8aU1E465BOCRDww>
    <xme:f7W5ZGuAEqwhjiuAGBh2opPHUxczN-RaP_-VtJg1iocas2rhXjTQxEjh5IgapN5aW
    phi47BSNB07Kh2Bzv0>
X-ME-Received: <xmr:f7W5ZMAnRQdmVOSGqv5ozffBJ8WjapX6iq6vTg2uIJWLzDY868wiTTBcUOEWgnPLi6qs2MIMIkHcY3Ragl41N3KYecU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedugddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepke
    dvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihho
X-ME-Proxy: <xmx:f7W5ZOfYC6S0_8FK5vfQ39i6NER1o2o1wQYuWoPitK9RFKmJTSIPMg>
    <xmx:f7W5ZLOoIgEUfp9GdNTK922qSjSBQNHSuDhj2Xkz6CWr4KEaxNanQg>
    <xmx:f7W5ZIlCPd-KazH0rViSWxs9b8kueh6iOncz4-f5T23d9dd9ea--dQ>
    <xmx:f7W5ZB16-G6OCGd6LPbxWKa2aSFqbVpoz6KSg6YDVN8WgViETYnU6Q>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 18:30:22 -0400 (EDT)
Date:   Thu, 20 Jul 2023 15:28:54 -0700
From:   Boris Burkov <boris@bur.io>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/3] btrfs: move comments to btrfs_loop_type definition
Message-ID: <20230720222854.GC545904@zen>
References: <cover.1689883754.git.josef@toxicpanda.com>
 <6abfcd8c6763baf92199be9532db3bd9e9e0e418.1689883754.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6abfcd8c6763baf92199be9532db3bd9e9e0e418.1689883754.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 20, 2023 at 04:12:15PM -0400, Josef Bacik wrote:
> Some of these loop types aren't described, and they should be with the
> definitions to make it easier to tell what each of them do.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Boris Burkov <boris@bur.io>
