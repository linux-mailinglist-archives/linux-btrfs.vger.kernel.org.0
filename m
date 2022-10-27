Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1350360F8EE
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 15:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbiJ0NWS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 09:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236011AbiJ0NWQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 09:22:16 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E68176B90
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 06:22:15 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 4E6B92B064C1;
        Thu, 27 Oct 2022 09:22:14 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Thu, 27 Oct 2022 09:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1666876933; x=
        1666884133; bh=mmOJA1iSZhi2wjuraZShkU156wEc3NJ3HcP85KDoyS0=; b=q
        W15g+twMILNqkDifUm52dl49uz/vuA1qzrO5XKS3uUJ7Bjmzb59+vbZyHY0rjsIy
        dKjxzraixytg1FLcIuNmjbzPjN++BNOVf0WUNPQ0O4RWRJJ6vWwYTt1iT2N8XQ5c
        EWErNoEDC5fLB5J1CXdTqxG9Fw+Osbj8kR26zJTppOrKv+jU/MWn3tdhQNTJcOa6
        7OlMgF01E5N0uHuFyebPRl5IkXD3YaQF8uAYYvv9GM6nnsL9rUzFtuthwv7BJuVB
        ThJp1y3I+T05iJl9+fISce0Wqp5Z9ZfEyD+kUJFVvz2vnq4prt2fF1stGya/ehOG
        oZRgeUdVS23DncV34CNmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666876933; x=1666884133; bh=mmOJA1iSZhi2wjuraZShkU156wEc
        3NJ3HcP85KDoyS0=; b=bj+bOqLAzSXwWmm0vWMcfBSxTKV6nEGwlegsreAErsnk
        xpRpZxulHnd3XFkW8EXDd8I8am2M+5exDkJqjjez6S9/TX4mAiqNBajRAE6YlMgj
        FpQKCywzVemc0MVHyvsF9rDXDZwp1IbG2W3sF6YUowkUZ/UsGc6iYxXtU65f64T+
        Si1EU4h8qB53acvBRe3SSUN6osP00jB/svyIP1KqhmRPThVtNTBcwyysbVLUrrtA
        nKkMJmSuWdu1DzArEMgcZH6VkXSKsd9SSN6oHug+imrmSqgWjikEcDhiyo9AaB0W
        zkzlgI4voRkxzsrThZNqEaWqEYLJMcEKny3c4DYbxQ==
X-ME-Sender: <xms:BYZaY0k4up3A2Ab8lC8dQnYTLEEIXgcgbtsV_6Ao2qY7fOVrSGXQ_w>
    <xme:BYZaYz2pHfCetmWf_-JAkMQyC3i5pbgUBNjtgtRI_HNVMFIRm7qTJ-pF8TZbdaeW1
    ZTH-3GuiOhybYw7xfM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtdeggdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdevhhhr
    ihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
    eqnecuggftrfgrthhtvghrnhepgfdvueektdefgfefgfdtleffvdeileetgfefuddtffel
    ueeiveeiveekhedtheeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:BYZaYyo1SsRqGN5-VinG0jzXN1vvXygZrfYfjPrnS5LF9Qv6JW5ojQ>
    <xmx:BYZaYwnL9_K1nkEJkDWUZ2EBpnoar_FYMDajC3qIuwQEshLvBQL0hQ>
    <xmx:BYZaYy1Ne0rj50f6zXdyutMcsun6pUcbp3v1Rp0SOQj_ZU21U1mZAw>
    <xmx:BYZaY38N9VHwCBSiBF9M5cHrAy4qBdDWBILmYOx7EUs0zsmPv3Q21joFB1I>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 68C6B1700083; Thu, 27 Oct 2022 09:22:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <0f6f1ecb-84d4-4fac-9fcc-5932d5b4f73d@app.fastmail.com>
In-Reply-To: <Y1nY2FJGYS+iWMcS@hungrycats.org>
References: <3c352b84-c52a-9e01-1ace-6e984e167753@inbox.ru>
 <eee8a8e1-8e54-4170-af44-a94c524c37ad@app.fastmail.com>
 <fa62c9cb-0fe9-b838-3f69-477dc61dbd45@inbox.ru>
 <Y1nY2FJGYS+iWMcS@hungrycats.org>
Date:   Thu, 27 Oct 2022 09:21:53 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Zygo Blaxell" <ce3g8jdj@umail.furryterror.org>,
        "Nemcev Aleksey" <Nemcev_Aleksey@inbox.ru>
Cc:     "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re: compsize reports that filesystem uses zlib compression, while I set zstd
 compression everywhere
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On Wed, Oct 26, 2022, at 9:03 PM, Zygo Blaxell wrote:

>> And also it's not possible to specify compression level in defragment - so,
>> I'll change the level in subvolume properties, defragment with -czstd, and
>> change the level back.
>
> It's not possible to set the level in subvol properties either.  Only the
> compress= mount option can set the level.

$ sudo btrfs property set test compression zstd:1
$ sudo btrfs property get test
compression=zstd:1
$ sudo btrfs property set test compression zstd:f
$ sudo btrfs property get test
compression=zstd:f

It's allowing the arbitrary setting of compression values. This is with btrfs-progs 6.0. Progs is being too permissive, it shouldn't silently set invalid values. But then even with valid values, I'm pretty sure right now the kernel ignores the compression properties.

-- 
Chris Murphy
