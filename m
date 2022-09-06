Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE445ADFC9
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Sep 2022 08:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238007AbiIFGbK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Sep 2022 02:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbiIFGbI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Sep 2022 02:31:08 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C19F550BB
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Sep 2022 23:31:04 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 003AB5C00B5;
        Tue,  6 Sep 2022 02:31:02 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Tue, 06 Sep 2022 02:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1662445861; x=
        1662532261; bh=5Dp8jE449rHV1f28bIIlLXq7R/qK04cDkRRlsmvrEXk=; b=q
        4ZcI5qh5ilh53ZqlPWFkxbXEp3vJWWLXgsZ1zW/khrcfL0Slen5TuXr2JwoB33E6
        dY5pSXKBPPuDVd+PhD6R9IfZjZ++Cy+HeTKIwDmEiHoPkUU633DR6gdLHjGAiHYu
        TxvCcSlT5lG/9WBzJ8TpIMx76PG4+dHp4TYQ9xWsCXRZ5NrdLR4Jfjn/Bb4x2Rt0
        CNrNv9IpRzPeLHqRYEXd7IxHprMyZoHwXQ9oUtu8KLRxRxBvLB+0fqYIQP7Iw2tW
        Qf3x2zBSgRWPWSo6cxGuLSWHlTuGa5qvWZCLxh+W7LN4LmnrKUHYLvvMxPe2aJTc
        iUPwva40nXD6VvmjHS/qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662445861; x=1662532261; bh=5Dp8jE449rHV1f28bIIlLXq7R/qK
        04cDkRRlsmvrEXk=; b=sceqI/tXyMEy3eciugNwPcpesmeyiva2APovmQQ6ovIO
        WCt6/cxYFQM0LxG1hGBJ3ICXUJg4POlrNBYQD9KhFMS8AJFu0AR7phR2UfvCGInq
        +rtZgSiMYlJMhQinXJ3kLtsrRAWXtWdxcBztpmQu1++S2LDJlBBK9PC0zyeOnvdG
        sShFJmUAJXLigAwQErceyXL69z92BGlXtPptbyFgt+WyQ/mlTbje2Net9bDWpblc
        dEt19QgiMiw+v4cEgaXKCjQfUcuoKfvdXIDiUBiQgY0jp0IeRzog1lUL9UbcodMj
        ihhyrBP4lDRsImuur9hXl3yYOmCyMQwRItdp6NS0nw==
X-ME-Sender: <xms:JekWY7eEN4iv5mt7hfOQ400TqFCqAo4AORtSS9tP4t7KssRNt3PrEg>
    <xme:JekWYxMIijMdO13CK35IWjJs9A9JrnLPT7IovERoqY05JW5-85viE_X_gVLtJA6mv
    pZHrg7wsF2ILBgQov8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeljedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfvehh
    rhhishcuofhurhhphhihfdcuoegthhhrihhssegtohhlohhrrhgvmhgvughivghsrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeffueegheelhfefvdejieehfeeggfekvddvvdeggeff
    jeekheeuvdfhudevteeuudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegthhhrihhssegtohhlohhrrhgvmhgvughivghsrdgtohhm
X-ME-Proxy: <xmx:JekWY0ja6tdiSeJs4cyhsBqhOS1bSkPNUbEJ-E8D3HJfAO3NRji7rg>
    <xmx:JekWY88MX97xnX1AylCdzaQYAlEM21uu-H_mMQVagEb_8eggT1e8RQ>
    <xmx:JekWY3syEqF1hvd_4UJt6u-bNF6JKQ-nXasuBS2Xjz8_GhwYmucHKQ>
    <xmx:JekWY04KUsflNYteYmwM1ZgDrOh0a7ljNuKE2wALaOJRhi17m--m2w>
Feedback-ID: i07814636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C39451700083; Tue,  6 Sep 2022 02:31:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-927-gf4c98c8499-fm-20220826.002-gf4c98c84
Mime-Version: 1.0
Message-Id: <b95be691-4374-4473-92df-be0db013e75d@www.fastmail.com>
In-Reply-To: <trinity-5dc69f90-9c41-4b10-9294-aaaddc708c8b-1662442389621@3c-app-gmx-bap71>
References: <trinity-2ed29f2d-59e7-439a-893d-3fc3b41be07f-1662419772647@3c-app-gmx-bap56>
 <d759fd64-fe5c-491e-9c24-c27067cbb195@www.fastmail.com>
 <trinity-5dc69f90-9c41-4b10-9294-aaaddc708c8b-1662442389621@3c-app-gmx-bap71>
Date:   Tue, 06 Sep 2022 02:30:40 -0400
From:   "Chris Murphy" <chris@colorremedies.com>
To:     "Steve Keller" <keller.steve@gmx.de>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re: RAID1/RAID0, online replace
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



On Tue, Sep 6, 2022, at 1:33 AM, Steve Keller wrote:
> Chris Murphy <lists@colorremedies.com> writes:
>
>> Ostensibly it's all one profile per block group type. But if the
>> conversion was interrupted or cancelled, yeah you'd have mixed
>> profile block groups, thus some files could be one or the other. But
>> this is not really controllable.
>
> So, you couldn't even have different RAID config per subvolume, right?

No.


>
>> `btrfs replace` is an online command.
>
> I read that the default is RAID1 for metadata and RAID0 for data.

Default profile for data is single, since btrfs-progs 5.8 or 5.9.

> But that would mean that in case of a disk failure almost all files,
> i.e. those which have at least one data block on the failed drive,
> are damaged. What does 'btrfs replace' do with these files? Isn't
> the purpose of RAID defeated, when in case of disk failure most files
> are damaged and you need to restore from backup?

If a drive fails with raid0 for any profile, it can't be mounted rw anymore and thus you can't use btrfs replace.  You should recreate and restore from backup. Sub optimal fall back is copy off the good data to some other file system, the rest is lost.



-- 
Chris
