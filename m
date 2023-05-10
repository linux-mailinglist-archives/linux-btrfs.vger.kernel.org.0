Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259556FD36A
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 May 2023 03:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjEJBGM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 21:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjEJBGM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 21:06:12 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A9F2729
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 18:06:08 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id EE310320097D;
        Tue,  9 May 2023 21:06:05 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute5.internal (MEProxy); Tue, 09 May 2023 21:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1683680765; x=1683767165; bh=FDsGoiZQkzujrXsvhxK5dBPRkCQYBPPok3n
        4VXYpAHc=; b=qAhfGrDRFU8xhAZxsOyahMFpPn9P7IyLbnjdBr8W0bxZVvbxYE1
        FkJwH/5edMS1M4ua7OyUDD9zv9y+gd8FSqQJ3Wd1m5GMqDHXd8ByICvNSQ97v0/B
        SiUl46vShEikaFhubrwGVUrT/2oihIHPXwvkrcSnzwGT3Aeti7/2aVUTLfULU32m
        8O05MERPLTz8Tee+DMrgF6TF3CwzdRQn0XAPE70kOWdbFIBcbFxoHli0rL4RspHt
        Uq46hc6f2y1nYJEJTaPLSKklDYlygT4RVqD0c8pSAbZNYjuwvAN3RobIyeSbJm7P
        +6++fMXntW+j08q+esoQf6KV390fUBojdJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683680765; x=1683767165; bh=FDsGoiZQkzujr
        XsvhxK5dBPRkCQYBPPok3n4VXYpAHc=; b=A1/tk3H7CLCjS8WChWM668y4KmDpY
        017WfnIlRB5oJGRuJqDtbVqBn9CqFKsVbYa5LvSiSaRqxdKei5N82dpKXJxOvi1d
        5FTqUmOp+AcbPQFWpfSJ9gh81q/gbpILYexdJ1tvQwE1wnYL5G9dXAi9y5KwRD8K
        MxxLhpTj4XYMMcpTQmdyZgaeyV4Jw9V14L1ZXOX0iGdvyr0A15Uw/ZuwWB5JmF1B
        wLP9iaNvkC7zVNabzFF3UFtyq92VQNvtlZ7Aq4lQSrYDcPmEqN1HhPrMZpyjmJHJ
        4a8exhZg+urqavZ09IH5iRz7PC2K504pDnXCW9uQ8pgztuF3l1i1aHz2g==
X-ME-Sender: <xms:_e1aZNnLd3rfo83yORsu4OhNjBVJP_vRbXQtKWePu5qV1Y-bOIOzWg>
    <xme:_e1aZI3dKChOapKNSoiNzOT9B77nB_OX_KtvacvVj_snl5ZnkvupCT8vmDkQf9jDi
    gH5mmVEdWBX_xtMXB4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegvddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfvehh
    rhhishcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtoh
    hmqeenucggtffrrghtthgvrhhnpefgvdeukedtfefgfefgtdelffdvieeltefgfedutdff
    leeuieevieevkeehtdehueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhm
X-ME-Proxy: <xmx:_e1aZDpbz0s6PwZ4f64GjRDHQ-EhLaaabmEmuQV9ioPMyvs87DRZZw>
    <xmx:_e1aZNlfmz384qdko4dVfpOEV3JSd-BX6hb89rupG9zPcTvZ3KvXDA>
    <xmx:_e1aZL2JlJlEIhUatXnBCo4pLSl1XHX8HaenwQw78-q7Q0wJqEMIeQ>
    <xmx:_e1aZI_lEu1RR90Qr_qwTzyb5TyRDHobbrTU9HxROA1i3jDGkoDoog>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3775B1700167; Tue,  9 May 2023 21:06:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-415-gf2b17fe6c3-fm-20230503.001-gf2b17fe6
Mime-Version: 1.0
Message-Id: <f73c20ae-f52a-436f-9fa4-6e3839d4b9a6@app.fastmail.com>
In-Reply-To: <dcc34c41-f7c8-e8b2-0a78-c134a257a8db@nerdbynature.de>
References: <837c4ca9-7694-4633-50b8-57547e120444@nerdbynature.de>
 <8a3f47c0-5b0f-a6c8-d1c4-714e3251b9eb@nerdbynature.de>
 <61025b77-2057-5a90-032b-f36ffa85deb4@gmx.com>
 <1a1a6ccf-25f9-d362-d890-8a609ff743f2@nerdbynature.de>
 <7d4287c6-e854-e79a-874a-0f76ea4285a4@nerdbynature.de>
 <ecd355db-e252-4993-97c4-1987963507cd@app.fastmail.com>
 <dcc34c41-f7c8-e8b2-0a78-c134a257a8db@nerdbynature.de>
Date:   Tue, 09 May 2023 21:05:45 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Christian Kujau" <lists@nerdbynature.de>
Cc:     "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>,
        "Qu Wenruo" <quwenruo.btrfs@gmx.com>
Subject: Re: btrfs-transaction stalls
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On Tue, May 9, 2023, at 5:48 PM, Christian Kujau wrote:
> On Tue, 9 May 2023, Chris Murphy wrote:
>> On Tue, May 9, 2023, at 8:30 AM, Christian Kujau wrote:
>> > After upgrading from Fedora 37 to Fedora 38 the problem did NOT magically 
>> > go away (heh!) and I've run another full balance (and a scrub too), 
>> > although this did not help much in the past.
>> >
>> > I've since switched the mount option from "discard" to "discard=async" and 
>> > the problem has not recurred....yet :-)
>> 
>> There are some edge case performance issues with async discards that 
>> should be fixed in 6.2.13 or newer. I suggest upgrading your kernel 
>> andremoving the discard inhibition so it is used (the default). And 
>> report back if it fixes the problem or not.
>
> Well, Fedora 38 has 6.2.14-300.fc38.x86_64, but I had these weird stalls 
> right after the upgrade to F38 again. But "discard=async" (instead of 
> plain "discard", which defaults to "discard=sync") appears to help. Knock 
> on wood.

That is confusing. If you do not specify any discard mount option, 6.2 kernels default to discard=async.

If you are manually specifying only discard, you should get async discards, not sync discards. I think sync discards is a bug. Surely with 6.2 kernels and newer it should be async, but arguably it should be backported to all stable kernels still accepting changes. If not specified, async should be implied.

-- 
Chris Murphy
