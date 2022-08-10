Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE06B58F269
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Aug 2022 20:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbiHJSeX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Aug 2022 14:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbiHJSeC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Aug 2022 14:34:02 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E4D8C025;
        Wed, 10 Aug 2022 11:34:01 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 43E275806F4;
        Wed, 10 Aug 2022 14:33:59 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Wed, 10 Aug 2022 14:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660156439; x=
        1660160039; bh=s937p5S+ceUeuGttr8ilCz3uf4ZJwae9ficmCjs8F74=; b=a
        NMKIxViWmetgN3koeks1gxsuPGBEYp6vfI1oIkwcxq5nVjr6dt5uX2SPqCIv+ytp
        0dCgFrB13TluAJBVVakaxNkRZRTyDBvy0TQ/QXGsCN/kU/O9B/3lhEV+itpFGqOQ
        JoW4EYo7K/8fco/N2FciiGon1/9MpymrzcGSLsmW+8e2wOmIicQzBVyBiIUwG0AT
        tvv65YHVYJ/cLCJskw2QiGPsfYyBOtqRlsWaPDwhRZCDJqANFTMoiHqT8f3p5BE1
        4jqjJYd5KDhFi7JB+3gnyY0/XZ1q4BLWcFMGF50DYXF8s6B32duwM9YmlW8wnUhm
        AtNd5NiRHjhBVbRWZ9Irg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660156439; x=1660160039; bh=s937p5S+ceUeuGttr8ilCz3uf4ZJ
        wae9ficmCjs8F74=; b=Sr7lag5wE7wLcDL52FWeJg1TXR9hMWX/ZaWoLGbk4+pc
        ZxgtMWG0FmXZUiCHgnDnO175vswE961Q5uesBG9lA5gyTau3VVzPJTayINIs+14I
        T8rrVKqgwvyP4kA2mBPgmVnN7pky1jP/bHsL3IaxjR1/AI0+qlJNKX99b/CsAWwM
        g0zwGuJh8OzH5nBBQ6uSfFk0CcPCGZNheyzjQQJYAKIADfn9OT2kezgx98g4yq88
        AVJxPtC1ziZiUJuQPPVXOM0Unoke4QapWewxtbkyHqyz6zLEpNiWXuq/FGBlNXvQ
        OwbSgVD8gLrOMCTYnh/ImFXcEgzacxffYwMg4q/VCQ==
X-ME-Sender: <xms:F_rzYqXVth2Y0QCBlQTMkH0N1JX10vibAR_NSeglcadxF1HnvXSypw>
    <xme:F_rzYmlR3TxzE7L9ra93OciqpTFnquwB3zTVPig5ZwbzDsf4NsGf6rnDiwrXMwY4v
    9TsNLfN7aTGt2dktLM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegvddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdev
    hhhrihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtg
    homheqnecuggftrfgrthhtvghrnhepgfdvueektdefgfefgfdtleffvdeileetgfefuddt
    ffelueeiveeiveekhedtheeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:F_rzYuZXjNMWEjIMcz_Z6JH_qkj1Hbs5tgBhnP-W3MFuoCc-JWXGfg>
    <xmx:F_rzYhV9perismQnBGilPn0hCmmz-RwJVy1JKyViw8VyDeY24jR2sA>
    <xmx:F_rzYknkdljaHdKUVe3VG0TmVt0zQiRwWsZ2eXEEJumYs3jpabS96Q>
    <xmx:F_rzYpzRdFGTt3qs8SkQ2Z1pX4El1tPIEClcI8v48TNTkeiYowSaSQ>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 00DA91700083; Wed, 10 Aug 2022 14:33:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-811-gb808317eab-fm-20220801.001-gb808317e
Mime-Version: 1.0
Message-Id: <2220d403-e443-4e60-b7c3-d149e402c13e@www.fastmail.com>
In-Reply-To: <YvPvghdv6lzVRm/S@localhost.localdomain>
References: <e38aa76d-6034-4dde-8624-df1745bb17fc@www.fastmail.com>
 <YvPvghdv6lzVRm/S@localhost.localdomain>
Date:   Wed, 10 Aug 2022 14:33:38 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Josef Bacik" <josef@toxicpanda.com>
Cc:     "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: stalling IO regression in linux 5.12
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On Wed, Aug 10, 2022, at 1:48 PM, Josef Bacik wrote:

> To help narrow this down can you disable any IO controller you've got enabled
> and see if you can reproduce?  If you can sysrq+w is super helpful as it'll
> point us in the next direction to look.  Thanks,

I'm not following, sorry. I can boot with systemd.unified_cgroup_hierarchy=0 to make sure it's all off, but we're not using an IO cgroup controllers specifically as far as I'm aware.

-- 
Chris Murphy
