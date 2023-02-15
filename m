Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D31698564
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 21:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjBOURE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 15:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBOURD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 15:17:03 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89ADF2A6FB
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 12:17:01 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 079313200900
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 15:17:00 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute5.internal (MEProxy); Wed, 15 Feb 2023 15:17:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1676492220; x=
        1676578620; bh=oEGdyz/W/1KbVi5d8As5uAOPTBYLeUpadP7LQriPkLQ=; b=T
        5MknTdSfVSmRPv4LLPc/mteC0cPsQEmAgBRq0KB95pVabfKBpbUTaMhviXR8Qu//
        PteImq63LdKxCZ/of9vr4zLEZRBBOxF+5H6BKzkuNfNKQrWbmdIe77nCP9LC5VvB
        qftnwQnswdiYmu+d+f3cUCbZypf9TbxHBgF9YCwo8G+pyjkU0yhMItt+Cwq6++3E
        Ic9/0fcaGP+nNsPF6Oleb8FV7hB6OgMo4WjL4/eQJ6xiDwEkJNK2SjVl9frJzRkM
        InGnoaRK3cDDJIHkcETUqTo+nsNWLT+YISASynSCuP7CMvJ8+CeB5Fsk9NQrgiBj
        pwvumuqew7R+raKptB9jA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676492220; x=1676578620; bh=oEGdyz/W/1KbVi5d8As5uAOPTBYL
        eUpadP7LQriPkLQ=; b=hKrE4k0lSagsYQWmq1TFJaLH76GSst7Ru0Lf9XbWic4c
        MEFyCM3P9FZNqufyWerIiVVTO12YCLTUj73ntD1YszYgn3qhK8X5ega5L2fNJlIi
        AeG1dt7PGoxxDp2x6oaSTbpz580GkpunqPoIh5LT8mwywVBu+G/1TAerNZpQapi3
        x7IAbU+pgmaqgHQJS1tNsxAf4Z7tBxfkAR+L59jtq5c82eDc7FpsgyYgDhUN0OYy
        VEHnSZaBeJdj/1xpEq/U0PLM4UbiPDLQ21gW8d5Ca5mAsuJCUgSYeXuyzjGopWfK
        dRLzJ3SoSb5oinFs3XR8gh04zQ3MMWMAjt2Y802Otw==
X-ME-Sender: <xms:vD3tY1QSGTIyvojZ-c_iUr5Ehfh1m28uy9BnFVt9bM--Ou1EcPjbJQ>
    <xme:vD3tY-xhiuBcnxi1lVnRlO6ztUjFnc9UmMGFTq3N_yRBHQiMAbbjdsWFJHGF3pQ5n
    QENpDYslbvWG5nFqc8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeihedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfvehh
    rhhishcuofhurhhphhihfdcuoegthhhrihhssegtohhlohhrrhgvmhgvughivghsrdgtoh
    hmqeenucggtffrrghtthgvrhhnpedtvdfggfeikeffkedvheefveffhedujeeugedtudfg
    ieefgfffiedufffhgefgkeenucffohhmrghinheprhgvughhrghtrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrhhishestgho
    lhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:vD3tY60R1tNrVPacubNPnwT81xwNzAXQ0UsN44ElBPRgb7paRiE8hw>
    <xmx:vD3tY9BgZhxrh1l2OozWFL1BONnMSX7MqZ_kbXz7SP8L6e3PmcxcOw>
    <xmx:vD3tY-jcle6NmAm5XlE_Gpc1lirwUrnj0vvjRvlJ4lR5LLZzMsCQGg>
    <xmx:vD3tY5vzEWa-slr33ZrIX584qxb-RcBbQRIw6-PIPzHthxAk8CPMPA>
Feedback-ID: i07814636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 56DA01700127; Wed, 15 Feb 2023 15:17:00 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <124a916c-786b-42ec-bc9d-db97bb081881@app.fastmail.com>
In-Reply-To: <aa1fb69e-b613-47aa-a99e-a0a2c9ed273f@app.fastmail.com>
References: <aa1fb69e-b613-47aa-a99e-a0a2c9ed273f@app.fastmail.com>
Date:   Wed, 15 Feb 2023 15:16:39 -0500
From:   "Chris Murphy" <chris@colorremedies.com>
To:     "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re: LMDB mdb_copy produces a corrupt database on btrfs, but not on ext4
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On Wed, Feb 15, 2023, at 3:04 PM, Chris Murphy wrote:
> Downstream bug report, reproducer test file, and gdb session transcript
> https://bugzilla.redhat.com/show_bug.cgi?id=2169947
>
> I speculated that maybe it's similar to the issue we have with VM's 
> when O_DIRECT is used, but it seems that's not the case here.

I can reproduce the mismatching checksums whether the test files are datacow or nodatacow (using chattr +C). There are no kernel messages during the tests.

kernel 6.2rc7 in my case; and in the bug report kernel series 6.1, 6.0, and 5.17 reproduce the problem.


-- 
Chris Murphy
