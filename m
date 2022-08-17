Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C68597455
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 18:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238050AbiHQQfN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 12:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237825AbiHQQfL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 12:35:11 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA2C5A81A;
        Wed, 17 Aug 2022 09:35:10 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id D6C18580D40;
        Wed, 17 Aug 2022 12:35:07 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Wed, 17 Aug 2022 12:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660754107; x=
        1660757707; bh=TWFUPTKciI9FuFZsf756Ud6YDkWosddvhORawGRFzBM=; b=d
        7xqd2HpyOZDjRS+qD16tcYZnD+D5563TrA1kiu3/8I/7N+jwa5ijg7JkRwi1byl2
        TcaWKbfmExk/oqFDcEoset0ODBykv4df76olXP+pk/LUbhu8NzaAPtCOES3yerW9
        N3PYu4HsXL73KONzBwfvJwObD65WCs1UNbKuIbObXP2poTjtEHuo1keV3faCHjAn
        p+tTAf89E89j/+Rud3yK4XolhP8jTlAsP6swDtzaiK+3JDN89H1+dUqW37bGzL7x
        kNvcrBVKmR9syn5ELpYbmDXXLwp6/bvphgwv5FpCftl6R7X8SU9RjoOFpASpEvZc
        i9ss0CdLCgOF098EaSyMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660754107; x=1660757707; bh=TWFUPTKciI9FuFZsf756Ud6YDkWo
        sddvhORawGRFzBM=; b=m++RJXdZAkg3Rpiw9AI4+wyCkLFuEoZ1FfGxzrmx0zMB
        KyJ99PLB80JkG1jVmEsGmqYGDjT/7EU5mVLoyi2rBVUyaheB0CkqqzpkI4XehzbT
        iFguqN7HgRwJieFGA95g/k+EZC2T5jR3Cg1r0QWUz8DmVAHKBy1PXdJtCsOXmp1a
        3aDoXPE2yO6QkIb1FVo8G8+iosrEedK841go7nisI7lDiREbDkOFhv05bcfS1+ie
        jtjrxwbqO2Wd0Fi56xHoB8zkzbIG59yyCbVMYM19dbxzneN+sV9bt4sojIvwbJWF
        P6PA0N6KnzvtiRYWRpIN6hHdklEYFowzojMM+u+khQ==
X-ME-Sender: <xms:uxj9Yn-I9lme5D9fBXhswqHMtnqeKe4abFKepjeczh4ZQ4SCxy5NsQ>
    <xme:uxj9YjtUpAvTqQ8GwemmWZrKZQ0NUhiIk8OKSC1NQYlyWQtAMNzC_VEJVI_lu5krw
    hLf6WxuvHXcG2HjYb0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehiedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdev
    hhhrihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtg
    homheqnecuggftrfgrthhtvghrnhepgfdvueektdefgfefgfdtleffvdeileetgfefuddt
    ffelueeiveeiveekhedtheeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:uxj9YlA3aWCWJgh2xotPHQGBSS8tQuT7_N5zciYzww7GdTGdqp_sIQ>
    <xmx:uxj9YjfZITecstfVN_fYfQDAz0sLxiAmBx6W8RS9k0L9XZB-gCjOLA>
    <xmx:uxj9YsOqiA-CFXq5rNB9X1AaetuejSCo4MuU9JKulFd03VrZsFR4DQ>
    <xmx:uxj9Yjdjh3oeQ-7qCgMyDv6cyz6WwJoGHr29VpYPrOrhAeNdCfzlyg>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 723671700084; Wed, 17 Aug 2022 12:35:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <35f0d608-7448-4276-8922-19a23d8f9049@www.fastmail.com>
In-Reply-To: <Yv0KmT8UYos2/4SX@T590>
References: <CAEzrpqe3rRTvH=s+-aXTtupn-XaCxe0=KUe_iQfEyHWp-pXb5w@mail.gmail.com>
 <d48c7e95-e21e-dcdc-a776-8ae7bed566cb@kernel.dk>
 <61e5ccda-a527-4fea-9850-91095ffa91c4@www.fastmail.com>
 <4995baed-c561-421d-ba3e-3a75d6a738a3@www.fastmail.com>
 <dcd8beea-d2d9-e692-6e5d-c96b2d29dfd1@suse.com>
 <2b8a38fa-f15f-45e8-8caa-61c5f8cd52de@www.fastmail.com>
 <CAFj5m9+6Vj3NdSg_n3nw1icscY1qr9f9SOvkWYyqpEtFBb_-1g@mail.gmail.com>
 <b236ca6e-2e69-4faf-9c95-642339d04543@www.fastmail.com>
 <Yv0A6UhioH3rbi0E@T590>
 <f633c476-bdc9-40e2-a93f-29601979f833@www.fastmail.com>
 <Yv0KmT8UYos2/4SX@T590>
Date:   Wed, 17 Aug 2022 12:34:42 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Ming Lei" <ming.lei@redhat.com>
Cc:     "Nikolay Borisov" <nborisov@suse.com>,
        "Jens Axboe" <axboe@kernel.dk>, "Jan Kara" <jack@suse.cz>,
        "Paolo Valente" <paolo.valente@linaro.org>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Josef Bacik" <josef@toxicpanda.com>
Subject: Re: stalling IO regression since linux 5.12, through 5.18
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On Wed, Aug 17, 2022, at 11:34 AM, Ming Lei wrote:

> From the 2nd log of blockdebugfs-all.txt, still not see any in-flight IO on
> request based block devices, but sda is _not_ included in this log, and
> only sdi, sdg and sdf are collected, is that expected?

While the problem was happening I did

cd /sys/kernel/debug/block
find . -type f -exec grep -aH . {} \;

The file has the nodes out of order, but I don't know enough about the interface to see if there are things that are missing, or what it means.


> BTW, all request based block devices should be observed in blk-mq debugfs.

/sys/kernel/debug/block contains

drwxr-xr-x.  2 root root 0 Aug 17 15:20 md0
drwxr-xr-x. 51 root root 0 Aug 17 15:20 sda
drwxr-xr-x. 51 root root 0 Aug 17 15:20 sdb
drwxr-xr-x. 51 root root 0 Aug 17 15:20 sdc
drwxr-xr-x. 51 root root 0 Aug 17 15:20 sdd
drwxr-xr-x. 51 root root 0 Aug 17 15:20 sde
drwxr-xr-x. 51 root root 0 Aug 17 15:20 sdf
drwxr-xr-x. 51 root root 0 Aug 17 15:20 sdg
drwxr-xr-x. 51 root root 0 Aug 17 15:20 sdh
drwxr-xr-x.  4 root root 0 Aug 17 15:20 sdi
drwxr-xr-x.  2 root root 0 Aug 17 15:20 zram0


-- 
Chris Murphy
