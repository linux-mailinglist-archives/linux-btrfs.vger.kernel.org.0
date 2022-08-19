Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183E759A805
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Aug 2022 00:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiHSWCX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Aug 2022 18:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiHSWCW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Aug 2022 18:02:22 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D91BB99DC
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Aug 2022 15:02:21 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 36CB532002F9;
        Fri, 19 Aug 2022 18:02:18 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Fri, 19 Aug 2022 18:02:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shamm.as; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1660946537; x=1661032937; bh=+czHXSYxqG
        D4NL1Kk1CwHqhEnlz9/RkYn4yrUw9BkjI=; b=Q+SEVDczZ7kgQgZz24hRJ331hO
        fLSI3IsycNY+LBJU+UUpCBDxO1g37B3EpimAPRZ5CbswRsBSBwgXXmGCo1LkPCnF
        pPLO6FIIjXTriJAgzVLnzNB+q2DRTlMfnwevsQmZ1Mys43C5WjwFHj5yox6A8ZH3
        LeOTnh7dPaK1wNu70Zl6edJXpWh9nLiafVhUC4R3Ov+ag6yYp7MUzoCjd17S09Ja
        fmAnKQSUS4D0erG4ADFWOBNga3HO6uyWW/Lec88m1n5sFU2y9BGxOHf9kscA7g4k
        xrXF2IWx8ETIBjWdSxxHlmp0YT3tYEvELWsz99EJBGBj4hCiUouP0W2U/lIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660946537; x=1661032937; bh=+czHXSYxqGD4NL1Kk1CwHqhEnlz9
        /RkYn4yrUw9BkjI=; b=e13LuxePsYIiLJ+9jdA+gpB4OsD7zucc6aYDT0z7ZkH+
        BUgjGcJ2NtCBhNJTNa/BzMohmxMCeQqE5ydkksx+VtjTiPKRbdQhtNat4W6F3xyp
        WKQpY7LqmGsVCmdGB5bzqNOsdXQTuQ+j3oyJE4ZViU/k8ECls4fY+IeH5Ul1GvL2
        1XGKbMw6trQOdh/6dukQMC1ia/bsRnK/NRx/HfxrztB5WK3iBIFQLoUrSPCK0Pnw
        muaMHqQabA0VKvGtbig4daVa6/cAbfqJtmodg6Ff+Tv7KTHIMgrGbTLrUfXVqVPb
        OLoV8ED5gjcfdVyuNLQ5xn57N6MRmV0wa2s5i4omSA==
X-ME-Sender: <xms:aQgAY2jp0WeUa7njBhFE_VQYUhyC1c1M6O7mALMipMLSuXF1eTiLcg>
    <xme:aQgAY3Dt6W-nzRkz5TyB2gwySv114ZkUwejTEr2Op2LdZ8tSUINtI-scGnaBEHpc5
    a2ziwMnQz3MjEBkdgU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeivddgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfifgv
    ohhrghgvucfuhhgrmhhmrghsfdcuoegsthhrfhhssehshhgrmhhmrdgrsheqnecuggftrf
    grthhtvghrnhepieevieefleetveefleeugeefleekudegteduieejtdethfejvdeffedv
    hffhkeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghtrhhfshesshhhrghmmhdrrghs
X-ME-Proxy: <xmx:aQgAY-EQjcxD5fIffthzKq_PTI2ekozRj89UxTo4V25pPObP1ByAtg>
    <xmx:aQgAY_TBicd8IID05upz_5iiXfU7Pw7r9B0DHns3CXFKoFB466nDDw>
    <xmx:aQgAYzyRHFsNy8YnLJytFxIxf6gOxWd6TO3xXI_IgK7twG-URRNcGQ>
    <xmx:aQgAY1t68YX2PFdr_yxHC9wWcMP1XuRzrrDdxATWZKGW8GfR798ljQ>
Feedback-ID: i1ac146fc:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0FCE0C6008B; Fri, 19 Aug 2022 18:02:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <a6b0c534-4f05-4f60-a7fa-f33cfce990d7@www.fastmail.com>
In-Reply-To: <87v8qokryt.fsf@vps.thesusis.net>
References: <a3fc9d94-4539-429a-b10f-105aa1fd3cf3@www.fastmail.com>
 <87v8qokryt.fsf@vps.thesusis.net>
Date:   Fri, 19 Aug 2022 18:01:55 -0400
From:   "George Shammas" <btrfs@shamm.as>
To:     "Phillip Susi" <phill@thesusis.net>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: What exactly is BTRFS Raid 10?
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

On Fri, Aug 19, 2022, at 2:10 PM, Phillip Susi wrote:
>> The Raid 1 example there also likely needs a bit of explanation or
>> validation, as all the blocks are written to one device. In that raid
>> one example three devices could be lost as long as it is not one of
>> them is the first device. It also cannot be accurate once the amount
>> stored is above 1 full drive.
>
> It is meant to show a *possible* layout, not every potential layout.
> The data may be stored like than and then yes, you could lose multiple
> drives and still recover as long as the lost drives were 2, 3, and 4.

I wouldn't expect all potential layouts, but maybe the _worst_ possible layout and an text. IE. If the layout blocks is random and only guarantees that each block will be on two disks. That would mean raid1 setup of 4 disks is pretty much guaranteed to have data loss if _any_ two disks fail.  This is important and should be made clear somewhere.

> Btrfs raid10 requires an even number of drives with a minimum of 4.

Is this true? I just experimented with 3 drives and `btrfs device usage`  ends up showing 'RAID10/2' But the data is equally spread across all three drives. Even though the stripe is 2, the data is still being placed evenly across three drives. See  [1] for an actual example I just created.

> It's pretty much raid 1+0.

Again, is it? raid 1+0 would imply that two drives are mirrored, and hence identical, and the blocks are striped  over mirrored sets. This would also force devices being in  multiple of two, which is not the case. 

If I had to take a guess at the actual implementation is that the block is striped and then the individual stripes are randomly placed on drives. Making a possible to have a lay out like the following where, similar to a btrfs raid1 setup, any two disk failures will lead to data loss. 

| SDA | SDB | SDC | SDD |
|-----|-----|-----|-----|
| A1  | A2  | A1  | A2  |
| B1  | B1  | B2  | B2  |
| C1  | D1  | D1  | C1  |
| D2  | C2  | C2  | D2  |

If I am right, and I don't know that I am, that would make raid1 and raid10 have the very similar data loss scenarios that are not completely obvious.

And the question remains if that is the case, is there ever a reason to choose raid1 over raid, and vice versa. 

--George

[1] # btrfs device usage /
/dev/sdc4, ID: 1
   Device size:           917.87GiB
   Device slack:            3.50KiB
   Data,RAID10/2:         341.00GiB
   Metadata,RAID10/2:       7.00GiB
   System,RAID10/2:        32.00MiB
   Unallocated:           569.84GiB

/dev/sdb4, ID: 2
   Device size:           917.87GiB
   Device slack:            3.50KiB
   Data,RAID10/2:         345.00GiB
   Metadata,RAID10/2:       4.00GiB
   Unallocated:           568.87GiB

/dev/sda4, ID: 3
   Device size:           917.87GiB
   Device slack:            3.50KiB
   Data,RAID10/2:         342.00GiB
   Metadata,RAID10/2:       7.00GiB
   System,RAID10/2:        32.00MiB
   Unallocated:           568.84GiB
 
