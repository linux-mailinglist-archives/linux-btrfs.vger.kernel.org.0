Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32502749D2D
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 15:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjGFNSH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jul 2023 09:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbjGFNSF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jul 2023 09:18:05 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DA01992
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Jul 2023 06:18:04 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 8AB465C02D2;
        Thu,  6 Jul 2023 09:18:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 06 Jul 2023 09:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1688649483; x=1688735883; bh=rXJUhACN5waLgTYFeIv9fRF6W0NenZtXvk5
        pFoNQ3kM=; b=IxYFAuTyGKphD9G49EEobd0eIzSykDjpRE0SwT3J9DmH89rLPK2
        naCgmuk8GGgeNO6cvYqRNYk7QSEiKOCJuStN78vBZFtmqWyoQuPUZn2nJodSOToB
        tvs6G2U0d7jylbf0LHQkl+6qRFPmKXwgkY7X4LOM1N2RNEYE/jQ7CZd4DECpfF/7
        rgkYGK6EfReCMJNSaMv+8RW0669w006fLQDCUy/7fFJcZpmuttUcm6QDGz51xWpO
        p2aHQhLpPsEfZceAVtf4hduz8LNm6JO7yPnggX7UvPsrxWWwj9NDSL0aiYqYQ0be
        Gp67XzXcfMpvMD2GVWx2fFghG2XuvnkAT5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1688649483; x=
        1688735883; bh=rXJUhACN5waLgTYFeIv9fRF6W0NenZtXvk5pFoNQ3kM=; b=p
        bQxmGLuUcwyAVsh4QLDaZnwIg2fmBQbJUTuAXdUNFAg9WlbZQHH7j1GF3H0GCTPX
        BJsJ7kkmFJOtL2uCZdH+0pQ0TPc25ZAQcmTD/Rm+fuLoEmf/Gw01xz7a2P2eSfM8
        OnhFu85auB2rtbcfFj50MvNJRnHZpyoQt6IKUqV5Moda+MttMVmPcVm8TUvLIIih
        WSqjlxLInlphy0Gbbm+Q9kRXCC25YjIBfQod3rB6vZSKGALPwMOU1ly7IdXpi4s0
        TfmB8pL88Lv1ayCCT0ZXAaULBLj7hCHFBFz89i3ynkQGo/gM4bo1EvS/K3EszkAd
        zl3171hYW67m9sjKKcJ9A==
X-ME-Sender: <xms:Cr-mZJ_Ry247HjML3-qSwrXDh4-_ekuKdkyttfmWZqNdzyCDAbq-XA>
    <xme:Cr-mZNs2p7PU0Xoc_gaA7Udk_-KVL8qdJSmA9lt94Qg_madaUnPIvCfr0SVstwHQw
    8RyudDERPNgBrinSw>
X-ME-Received: <xmr:Cr-mZHB1vywurojcAjXlFBpfUDW77drkNUD-VHsLiJuP_XHtQKVEkTYrzrnFc84WtmGYzxsg4c4MDrAGMayzxtW3XYs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelgdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeftvghmihcu
    ifgruhhvihhnuceorhgvmhhisehgvghorhhgihgrnhhithdrtghomheqnecuggftrfgrth
    htvghrnhephffgfeeutddtudfhudejkeejudevledtudeufffhhfeukeejkeekiedtfffh
    ffeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprh
    gvmhhisehgvghorhhgihgrnhhithdrtghomh
X-ME-Proxy: <xmx:Cr-mZNcMK7kYwHtxmXmC2tNqHbGFwAbh49N8OOSrpy_czc3qzNGcBw>
    <xmx:Cr-mZONlVQkSygUHazJio2EKo5nRTZkcEKhq22l-alcGc5giwU1-Jg>
    <xmx:Cr-mZPnvEPttM54YRzL5kgq-rsAZktIrZLQMyhErmfdT28OIK-2p9g>
    <xmx:C7-mZA088Br2rQ2RwjEzv0Qw4VA9D0IOq0f6mljwiSpereTcf3I-yg>
Feedback-ID: i10c840cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jul 2023 09:18:02 -0400 (EDT)
Subject: Re: question to btrfs scrub
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <PR3PR04MB734055F52AB54D94193FA79CD625A@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <8a3d7ad6-0ddb-3160-eece-8d6228b9c0a6@gmx.com>
 <PR3PR04MB7340BD6CD63180053CCA023ED62AA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <3d208b62-efc2-afe4-e928-986dc4c53936@gmx.com>
 <PR3PR04MB7340ACCB059FA7C9A22052DBD62EA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <e4237dc0-2bdc-a8b3-9db5-6b0e24b7b513@suse.com>
 <PR3PR04MB7340B6C8F2191ED355D1232BD62FA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <80136f6f-0575-58e8-ea8d-7053c8af4db0@suse.com>
 <PR3PR04MB734063CF2AEA3709D3AFD9A5D62FA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <743f92ee-19e8-ba45-0426-795a91fc0e0b@georgianit.com>
 <00c1ea17-680f-18a0-d40a-f36bcdb9101d@gmx.com>
From:   Remi Gauvin <remi@georgianit.com>
Message-ID: <103cec84-6d26-0fa5-6229-6db5eea6a56e@georgianit.com>
Date:   Thu, 6 Jul 2023 09:18:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <00c1ea17-680f-18a0-d40a-f36bcdb9101d@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2023-07-06 2:23 a.m., Qu Wenruo wrote:

> 
> I hate to point my finger to btrfs itself, but I still remember in the
> old days some workload can lead to such false alerts.
> But I can not recall which commit is causing and which one is fixing the
> problem.
> 
> Another concern is, the report is using SINGLE for data, which is
> completely fine, but it doesn't help us to determine if it's really a
> hardware data corruption or btrfs bugs.
> 

Ok, but I think you missed my point here.

Given what we *do* know about *this* particular situation, (recent
kernel, copies of VM snapshots that were not used as live images, usb
device).  Correct me if I'm wrong, but with the caveat there is no way
to know, it is more likely that csum errors are the result of data
corruption on the disk.

The reason I bring this up, is because the user is being led by thread
into disabling error detection, which is the exact opposite of what
should be done in the case of problems caused by malfunctioning storage
device.
