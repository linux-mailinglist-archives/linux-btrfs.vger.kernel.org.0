Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3D16EF037
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Apr 2023 10:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239715AbjDZI1e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Apr 2023 04:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjDZI1d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Apr 2023 04:27:33 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBAD3A94
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 01:27:32 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 7DA5F5C0145;
        Wed, 26 Apr 2023 04:27:31 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute4.internal (MEProxy); Wed, 26 Apr 2023 04:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dend.ro; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1682497651; x=1682584051; bh=0aZY+QS7YsT4DkKZLpa9ST/npyIfaZcxJDe
        CY5IBdjk=; b=e/8YSzAABmf5sUaI2tD50+6QQZ84YuAkWhZbcwXcU3A0mCnbRwR
        LJ7kg5xnMaAcqW+cYx9JOSSNYAV5MoYlxoNKztHvv8xffvoI10y5vOZ0QNjzzuIR
        f/fVSjRYjxNekWusVnPFnGQH0j2Q0HbhUCoOGymt5al4v02bfdvkduBEnADHTl7S
        TDM9S20nCMaKQZr7odUwBnyQj7ntyLIHEul5KJCFy4ojpJ2YjZhhTEqdZSSEtGjh
        jxrMaSv+alGnPezO9Jwowhd6VvM58ePlVzsy0ylu5ZkA/fi9oYOOSbBrq3p0I4vH
        ZbWjLGx3HciDi9Pcbh4fD/iS8rK3bFNYanw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1682497651; x=1682584051; bh=0aZY+QS7YsT4DkKZLpa9ST/npyIfaZcxJDe
        CY5IBdjk=; b=jJWqg/31NTBcibUQZhw04GtgeqR+bGwaphxSSwuHmHYWw5JJQAQ
        TFkJMRr5HEd38fytWlxOiswYZpS0E5YrTa6HMsbZYBWVvNUjld9H2d+9PeUA9fdo
        LPV47wZgFOPb8VprM+myEBErVzel5YsGdEWHilfCFHSQfs24NcLECWeI1j8yMgRQ
        YmJFZBqAqK7lUfQDONKMA1Yz7mR12htY4d5a0AQsFYjxpnh57v6rru87Tf18ZAHm
        jzGDQc5jcp+3DPAZl+F/thuX07p/3v3TRuFYCk60UFa/YCCL+awwnusH5C0O6tdd
        ByQfrEp3GmBkHkqX+VEGj1Mz2vp93aMDXnA==
X-ME-Sender: <xms:c-BIZLf58CU9qZEi8mcomqf2eU-4dGPHz8FxYuwMj2KGyQwE27FV_A>
    <xme:c-BIZBPZntbTbtiWexeoacB7zttteR6Z3OqHL6pazSbI8tORvVwsRzVYOPYPPOm9F
    6X_wWneYyKbZxodeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedugedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgfgse
    htqhertderreejnecuhfhrohhmpefnrghurhgvnhhtihhuucfpihgtohhlrgcuoehlnhhi
    tgholhgrseguvghnugdrrhhoqeenucggtffrrghtthgvrhhnpeevheetleejhefggfegud
    fhtdetgfeufedugeekleeltddvhfekheevtddtteelheenucffohhmrghinhepihhmghhu
    rhdrtghomhdprhgvughhrghtrdgtohhmpdgtfihilhhluhdrtghomhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehlnhhitgholhgrseguvghn
    ugdrrhho
X-ME-Proxy: <xmx:c-BIZEjXjafZByQVSKN5YRO4lXE-6vWFQDhULugifaJBR1GEaykJsg>
    <xmx:c-BIZM_FEvLKzAnkBdwUjtJm-1Qa5bnNMewR8VHHGD9TkskQp0u5uQ>
    <xmx:c-BIZHv3zQjJPo4SLTk-qPkLuvKIqd-jXk_kPnr0MYjmGi0f5GHC2g>
    <xmx:c-BIZE77z-8P4ve11o6HwZyWoLxNEPdGFzj1jLc62LAr_jzIVeYEjg>
Feedback-ID: ic7f8409e:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 56A161700089; Wed, 26 Apr 2023 04:27:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-374-g72c94f7a42-fm-20230417.001-g72c94f7a
Mime-Version: 1.0
Message-Id: <f057bdd1-bdd9-459f-b25f-6a2faa652499@betaapp.fastmail.com>
In-Reply-To: <a0f6195f-e6d1-f633-9cd7-310fe5786546@gmx.com>
References: <d2975210-6fd4-4bf2-b72f-ffba664bdcc0@betaapp.fastmail.com>
 <a0f6195f-e6d1-f633-9cd7-310fe5786546@gmx.com>
Date:   Wed, 26 Apr 2023 11:27:11 +0300
From:   =?UTF-8?Q?Lauren=C8=9Biu_Nicola?= <lnicola@dend.ro>
To:     "Qu Wenruo" <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Corruption and error on Linux 6.2.8 in btrfs_commit_transaction ->
 btrfs_run_delayed_refs
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 26, 2023, at 11:11, Qu Wenruo wrote:
> On 2023/4/26 15:35, Lauren=C8=9Biu Nicola wrote:
>> Hi,
>>=20
> [...]
>>=20
>> WARNING: tree block [693902610432, 693902626816) is not nodesize alig=
ned, may cause problem for 64K page system
>
> This is already werid as newerly converted btrfs shouldn't have such=20
> tree blocks.

Hi,

I had it for about two weeks and probably did some heavy writes (100 GB =
- 1 TB) to it in the meanwhile, more if you count the uncompressed size.

>
>>=20
>> , then:
>>=20
>> ref mismatch on [634543001600 16384] extent item 0, found 1
>> tree extent[634543001600, 16384] root 258 has no backref item in exte=
nt tree
>> backpointer mismatch on [634543001600 16384]
>
> Corrupted extent tree, missing a lot of backrefs.
>
> [...]
>> extent item 693637414912 has multiple extent items
>
> And one very weird errors on that tree block too.
>
>> ref mismatch on [693637414912 16384] extent item 0, found 2
>> tree extent[693637414912, 16384] root 10 has no backref item in exten=
t tree
>> tree extent[693637414912, 16384] root 2 has no backref item in extent=
 tree
>> backpointer mismatch on [693637414912 16384]
>> bad metadata [693637414912, 693637431296) crossing stripe boundary
>> ERROR: errors found in extent allocation tree or chunk allocation
>> [3/7] checking free space tree
>> there is no free space entry for 634543001600-634545426432
>> cache appears valid but isn't 634260230144
>
> I'm not sure if the free space tree problem is related, but definitely=20
> not a good thing.
>
>> [4/7] checking fs roots
>> [5/7] checking only csums items (without verifying data)
>> [6/7] checking root refs
>> [7/7] checking quota groups skipped (not enabled on this FS)
>> Opening filesystem to check...
>> Checking filesystem on /dev/nvme0n1p5
>> UUID: ca0bd5c5-1e9b-4d7a-9e11-028ee4bfa22a
>> found 176460701697 bytes used, error(s) found
>> total csum bytes: 330310016
>> total tree bytes: 7177601024
>> total fs tree bytes: 4736794624
>> total extent tree bytes: 2011512832
>> btree space waste bytes: 1592634452
>> file data blocks allocated: 230763827200
>>   referenced 2489957961728
>>=20
>> Notice the problematic 693637414912 showing up again at the the end o=
f btrfs check.
>>=20
>> btrfs --repair did some stuff, but it didn't make the partition unmou=
ntable.
>>=20
>> This was my second broken btrfs file system (the first one failed aft=
er two months with a "parent transid verify failed" error, but I'm quite=
 inclined to trust the hardware I'm running. Both of these volumes had b=
lock-group-tree enabled and were running with discard=3Dasync.
>>=20
>> In addition, someone on IRC (also running Arch Linux) told today abou=
t a pretty similar issue, but block-group-tree was not involved there.
>>=20
>> I no longer have the volume, but I can try to answer any follow-up qu=
estions, and still have the photos and full dmesg output.
>
> Do you still have the initial RO flip kernel messages? That would be=20
> helpful.

No, unfortunately https://imgur.com/a/aJgCTw8 is all I have. If there wa=
s a more informative message, I must have missed it.

>
> Another thing is, I'd like to have memory tested on that machine.
> Normally some obvious bitflip can be caught by tree-checker, but exten=
t=20
> tree things are much harder to detect (as mostly of them needs cross=20
> checks).
> Thus it may cause some problems.

I did test it recently, but will try again and report if I encounter any=
 errors.

>
> The bg tree feature usage may be involved and interesting.
> Have you ever tried without bg tree?
> Bg tree feature only makes a difference for huge filesystem to reduce=20
> mount time, otherwise not that different.

Yeah, I've reformatted the two volumes without it and been using them fo=
r about 3 weeks and 1.5 months without any issues. However, I didn't do =
any heavy writes except a btrfs send/receive which gave me a NULL deref =
that's probably unrelated: https://bugzilla.redhat.com/show_bug.cgi?id=3D=
2189091.

I mentioned in my previous message an IRC user with a similar problem, t=
hey have some pastes at http://cwillu.com:8080/73.151.80.76. They've als=
o reported some checksum errors, so the hardware might be suspect. In an=
y case, perhaps you'll spot something.

Thanks,
Laurentiu

>
> Thanks,
> Qu
>
>>=20
>> Could this be some data corruption bug introduced around the 6.2 rele=
ase?
>>=20
>> Thanks,
>> Laurentiu
