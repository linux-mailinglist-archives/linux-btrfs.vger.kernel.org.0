Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C0A753A47
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jul 2023 13:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbjGNL7z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jul 2023 07:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235512AbjGNL7x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jul 2023 07:59:53 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECECE30D7
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jul 2023 04:59:51 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 1D5265C00E9;
        Fri, 14 Jul 2023 07:59:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 14 Jul 2023 07:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1689335991; x=1689422391; bh=2t7KWanFLOStVO6QOMN8DR1VyHTTRXQfft2
        fu92UbZs=; b=TfE8R83esGHnJaKU0/gVkUOrU+I6xUt7BsxQkxCNIDRlXOqn2Z6
        kj7FqRth0g+6pl3VXwRG8nf3Yt+fIz8Yv1oBNmsxe6Oj8OKtZyuYCM0nqWA7jUp5
        9W8wHXkbocNNyhCbs7+mC3e0oGxDZBJF1hXi812o4HzDmeNpk7YcLjoFC80vNPre
        3D6HYDP20/ptGhmDbdADTZRR/tTGOMSssg/9/Cfb7wMEgOtGHghDorDvn3hJUK8a
        h+vMq51/vpgVcS5fEwd0BlVP5MCAEWWCXnMAq3Wd4SIFB2laogf9bK0guHI2FZ34
        WbOzq5qCFdOeUSn0Jm7iYKN4hEvw9Qgr5Sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1689335991; x=
        1689422391; bh=2t7KWanFLOStVO6QOMN8DR1VyHTTRXQfft2fu92UbZs=; b=e
        lHOmMpJNpd2zvE9I/vLfFHILQwxnTnVKMscpWRMB6kqhLsnHOkie94tvoAz5CdDo
        yxBIz0YKyGM8WPC41qCzG4ZUjfES2zsbWufl5pJOKXxrakM2ZOVg5NJLqcVGGnCW
        nclConRm1fXZKAGAzoJgoabatxyUTwtV4Btxg6knAJ2tSAvXFgZbIHagWkHNGATB
        VN9SwIa3nAwCAZ6XC+QSnhS8mfgyT68cKcwRYjhAcro47CmIAocGsjA1XXZ3jyaE
        nN/+a5mKExDl8/xK8x8Y2VDgnA/UNtI3ozL6ZdkYr9zg41TazTN6d60TBODqIioa
        R1zAVdb2uRw54HfeTf2tQ==
X-ME-Sender: <xms:tjixZKz-S1_DN99vjS8xVy0X5xsJRqsPQQq8qj7KYN8Ag6_xCuswsw>
    <xme:tjixZGQTsBBpw0uv-JlLBJWv0d60IUaIASnL4Gr3Nqvc4d1y4pr9jCnvGRB2W12mr
    MEy3YZ1-YSSiAk93Q>
X-ME-Received: <xmr:tjixZMVx9NuaCq42IHCkcZDSDklBnDmu4Vw-HMQqlBPPDqB8pqlXe5GeTCawanCzN6W-OZz3oMdQpajPYeQYHRy2h_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfeeigdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeftvghmihcu
    ifgruhhvihhnuceorhgvmhhisehgvghorhhgihgrnhhithdrtghomheqnecuggftrfgrth
    htvghrnhephffgfeeutddtudfhudejkeejudevledtudeufffhhfeukeejkeekiedtfffh
    ffeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprh
    gvmhhisehgvghorhhgihgrnhhithdrtghomh
X-ME-Proxy: <xmx:tjixZAjbykErCHaTCbs2LEcbJC4o5TgTZlxqwnLGiPCdBu5IqFm99g>
    <xmx:tjixZMA2zFsNhyC9rTe-tYXwjonZt3jjERKTiGSf1XRMluAvyQsEnQ>
    <xmx:tjixZBJsCglJLtbU3wtfOi7YzyxG4y3I37RNh0YjU0AwSG-buJQJzA>
    <xmx:tzixZHoi8iHGmeThJjifqqWTcaku5mW9QYT5dWnOsFcIOaLMHDgMQQ>
Feedback-ID: i10c840cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jul 2023 07:59:50 -0400 (EDT)
Subject: Re: how do i restore a single file from a snapshot ?
To:     Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <PR3PR04MB7340EB61443EC55A38734D35D637A@PR3PR04MB7340.eurprd04.prod.outlook.com>
From:   Remi Gauvin <remi@georgianit.com>
Message-ID: <8eafb5a6-3391-0516-e434-db418e59213f@georgianit.com>
Date:   Fri, 14 Jul 2023 07:59:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <PR3PR04MB7340EB61443EC55A38734D35D637A@PR3PR04MB7340.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2023-07-13 5:30 p.m., Bernd Lentes wrote:

> Let's assume i need to restore a file from 12072023. How can i achieve that ?
> Just cp the file from the snapshot over the original ? cp with --reflink ?

Either will work.  cp with --reflink will take no disk space... cp
without reflink (unless cp now defaults to auto) will make a physical
copy, (ie, duplicate disk space.)

> Delete or rename the original before ?

Up to you.  I'm always paranoid about deleting data.  Some people are
more confident they will no longer need that file.


Mount the snapshot before cp ?

No.. Not only is there no reason to do this, but it will make it
impossible/difficult to copy with --reflink.  (You can not reflink
between mount points, even if it's the same filesystem underneath.

