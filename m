Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D9A7C95FF
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Oct 2023 21:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjJNTKT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 14 Oct 2023 15:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjJNTKT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 14 Oct 2023 15:10:19 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E7DBF
        for <linux-btrfs@vger.kernel.org>; Sat, 14 Oct 2023 12:10:17 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id E84065C0362;
        Sat, 14 Oct 2023 15:10:16 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute4.internal (MEProxy); Sat, 14 Oct 2023 15:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1697310616; x=1697397016; bh=CkWvhXp5v6J9f99NBw8IZBhISFO45zdBrhN
        rMkJqLV0=; b=G54YQLV7VObCkFwo+TPZqo+pkBPu/Q8lncdAuiifhwFXcOz1YJk
        JW27Q7lnfzz63YV1it5waiWhqzmG8/5gBbr0ITlcQLJgFxvS6ZapmOvCfEtNfdUP
        +ovVM9gpFCVledekAn6A5U9QVYmCLylItu1DWL7XRHxH0uuYQjp6cSBTDBuB4J6O
        yz9XzBUnd6IIt5iJTUURVCxyZ+CbLVGgaCGQsX+jGkh2lx/eymo8R0r1UBiXVCsB
        wSDgFiDtdm0k3wAPui57KbDTR2szsZTs8GU+zkvwTDr1DJ5TNHZxRsFOb6FvHUt5
        c+geoVXDjzkuriMIpV0omRYk5DkXpfovBgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1697310616; x=1697397016; bh=CkWvhXp5v6J9f
        99NBw8IZBhISFO45zdBrhNrMkJqLV0=; b=YKkl0RtOC3E2ZsKQ8wXD6XDt6jx75
        CH0IMq21vguP3RODp/r0BqlC4ezXSIfYdOHIgxRwIEedRnWPl5RQyMYbXwdTJuGO
        jKviYlSxysPEJmQMS5Bwhdd/AK+qZ0aOp8VZNIbcAmCMylrIU1y0aC9Qy/5GU6o7
        /jv/KYSlLBcuxBsWNolSsyPJbb3vqYjU6PfpiDAKQu+1GnzYzGqysJjRviKRC97R
        3V+YhIT0Uf1gV4CoWxeiCEDb8Obh8CYe0xCWmocShnMjZD3TXiwcwaGhhnvvqu8s
        834fegCn30hwlE6j9YD6Y+LyPf7LzLXr2iA2A8eHLFpLNYZ3rXTw+ZChA==
X-ME-Sender: <xms:mOcqZUXop6Pwrbk9SV3DEtXBgYMCKFfJTmpcL8gocMQNg7JbgrnUww>
    <xme:mOcqZYn_vca8JBlZb1YRoqPDdIqkPzqelqpDGpZ21bs9WhQ2BAGu_2tj_Zx5gPEov
    AqZnMJPie0BT6yetwM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrieehgddufedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfvehh
    rhhishcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtoh
    hmqeenucggtffrrghtthgvrhhnpefgvdeukedtfefgfefgtdelffdvieeltefgfedutdff
    leeuieevieevkeehtdehueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhm
X-ME-Proxy: <xmx:mOcqZYY7J6pGoa_f5zO2HDLtJD4QRS3Ie46lZ9-3iDgjW_uxe1qNaA>
    <xmx:mOcqZTUomgq-pGqAr7mQv5iPHwAiDI7wi9jUxfLIFUvbgQnZMXbxKg>
    <xmx:mOcqZemA4kYaFIer8W750Jp80hC7R3HF3iyBLPDXYCTCx0AWLw1lGQ>
    <xmx:mOcqZSsl2PJIZzSfp4_6jVirf8RPY9td2zoKX8Qw2kLoJga-p28wsg>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 83F561700089; Sat, 14 Oct 2023 15:10:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
MIME-Version: 1.0
Message-Id: <7dd58d68-3daf-4dd5-b6b7-e3ee0e160f68@app.fastmail.com>
In-Reply-To: <7bcaeca0-641a-43e8-8ffb-1f729e5e327d@gmx.com>
References: <NeBMdyL--3-9@tutanota.com>
 <4b8a10e4-4df8-4d96-9c6f-fbbe85c64575@suse.com> <NeGkwyI--3-9@tutanota.com>
 <bb668050-7d43-467f-8648-8bc5f2c314f1@gmx.com> <NeKx2tK--3-9@tutanota.com>
 <NfJJCdh--3-9@tutanota.com> <4cb27e5b-2903-4079-8e72-d9db2f19ced7@gmx.com>
 <NfT7gZI--3-9@tutanota.com> <d6fb2fd0-8c59-449c-a342-84eb908de969@gmx.com>
 <Ngf8uVZ--7-9@tutanota.com> <7bcaeca0-641a-43e8-8ffb-1f729e5e327d@gmx.com>
Date:   Sat, 14 Oct 2023 15:09:56 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Qu Wenruo" <quwenruo.btrfs@gmx.com>, fdavidl073rnovn@tutanota.com
Cc:     "Qu WenRuo" <wqu@suse.com>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re: Deleting large amounts of data causes system freeze due to OOM.
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On Fri, Oct 13, 2023, at 6:32 PM, Qu Wenruo wrote:
> On 2023/10/14 08:58, fdavidl073rnovn@tutanota.com wrote:

>> Is there anything else I can do to make sure this is addressed at some point? I would like to eventually be able to re-enable compression as it was saving me several terabytes.
>
> I believe Filipe is working on improving the extent map code recently.
> You may want to test his patchset when it comes out.
>
> Otherwise you may need to keep away from compression for now.

Is the cost of tracking extents reduced at all by increasing leaf/node size? The number of extents is the same, so that cost wouldn't be reduced - and maybe that's the bulk of the problem. But if it's also related to the cost of having so many leaves, maybe it would help?
