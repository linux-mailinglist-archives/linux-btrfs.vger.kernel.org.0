Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65D7726A15
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 21:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjFGTrM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 15:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjFGTrF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 15:47:05 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC147268C
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 12:46:41 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 7D77F5C0116;
        Wed,  7 Jun 2023 15:46:37 -0400 (EDT)
Received: from imap45 ([10.202.2.95])
  by compute1.internal (MEProxy); Wed, 07 Jun 2023 15:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1686167197; x=1686253597; bh=kL
        QjobKlNRUTF4Fcnwl4svY9ldXiIDlH2Cll8N0Q3jA=; b=PLGTkSV7nA388eAx5O
        r5bkfpHS2OLgOKJzSN8+iECU5NOoevMpb3XgY/uahMjNKIxC8bl5aUHpYV6UCHaw
        O8NKcWIuw6EzRHGzdYFe4150LfrOoLnmMmCpGlcSIka5aTt6gAHB4d+fmDPYZcQS
        DuLyzBDkl2nD6TFFFxqZO4lZNf3+apBZp5upS2rV440F0RPL9cx9+wcnw2CSnMoG
        BBPrUffamIJk/y7wqbxkiXyzFxAGdWGHb2ASrHLW4EaEUhhjtbFZJgI+gDLz2tKO
        /Zl9eekR5WDN9qYzETgiM5EY9iONnC5DT+OLRU4ocYtU1OAqtY473sbpwZX3hYzL
        wXUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686167197; x=1686253597; bh=kLQjobKlNRUTF
        4Fcnwl4svY9ldXiIDlH2Cll8N0Q3jA=; b=yIyWjG76LDxjKAsZm/ppM5KMHjsGN
        vxiKvQkyuw6e0yte7OSb/C+busRinRJ8tLudZIaGQM9wu7MYWhS08T/+Rn5y53u1
        5emw8Mj01NqiOJ4XXOviDGFODHfbp5tOW9PWAeFOLapX8YdmHKWJN1MYJlapyjyg
        J8fPfzWyN7WIG1/4ceQear9x3Vj725hFJj658R+QMlpKPpKhWuIsCShgx1/iAUi3
        NTHsB+mGXU/NLV+akemwagX6lODj39LL4gcRJVZ3TIXwADVPe416woNghHJO1/ZV
        2pHfY0OyeMyAs4X8u6Hhnze8Y2L88YHN3I171p4QpXtkkjvlWBj4JDryg==
X-ME-Sender: <xms:nd6AZBgHHtw8rLkJkKEh3chPod2slR0mWChXHCm7BEB3ewfmF9DbAA>
    <xme:nd6AZGCxPlXr24MvXiVmEpeHlqK31CcNggha1kynaJigeHNED-qYmTf2g4Sp-p39P
    RJTIuSzL_3DZbLGdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtgedgudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpehrvghm
    ihesghgvohhrghhirghnihhtrdgtohhmnecuggftrfgrthhtvghrnhepteejffeftdfghf
    efudfffeekjeelkeehjeejjefgheehtdefueffhffhfeffudetnecuffhomhgrihhnpehs
    uhgsvhholhhumhgvrdhmvhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehrvghmihesghgvohhrghhirghnihhtrdgtohhm
X-ME-Proxy: <xmx:nd6AZBEe7lokqSDWLpebzgQxP0ENnEHT1mXSvKHHZEE8QJFcGdD50g>
    <xmx:nd6AZGR_9WDTx0d0-9Yq0tb9LHTHjQ22v-saM16kUvaS6vPYj5DmyQ>
    <xmx:nd6AZOzZbj3BMTCUarBY1AQ23-qjckyZb7Iyant-cwjrCjCk2TBaFA>
    <xmx:nd6AZDuw45_g8zx9AIUFukWaHXRBvx6XXEXvzIYS3-eRdGcm26p1pg>
Feedback-ID: i10c840cd:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3545E2720080; Wed,  7 Jun 2023 15:46:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <d708df28-a0fc-411b-97a0-7d2bea2f5f72@app.fastmail.com>
In-Reply-To: <PR3PR04MB7340CB95E5AB4FC10706604DD653A@PR3PR04MB7340.eurprd04.prod.outlook.com>
References: <PR3PR04MB73400D4878EB0F8328B5D50BD652A@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <26251cfd-f138-a787-f0e8-528c1c5c6778@gmail.com>
 <PR3PR04MB734090961ACE766466980F04D653A@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <8c9b136c-c992-8c0e-a1e6-0e8aec1e89cd@gmail.com>
 <PR3PR04MB7340CB95E5AB4FC10706604DD653A@PR3PR04MB7340.eurprd04.prod.outlook.com>
Date:   Wed, 07 Jun 2023 15:46:16 -0400
From:   remi@georgianit.com
To:     "Bernd Lentes" <bernd.lentes@helmholtz-muenchen.de>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: rollback to a snapshot
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


On Wed, Jun 7, 2023, at 3:37 PM, Bernd Lentes wrote:

> VM images are on host BTRFS and i create the snapshots from them on the host.
>

So there are a couple choices on how you want to restore.

You can make a new snapshot from your 'good' snapshot.  This will roll back the entire subvolume.

mv /subvolume /subvolume-bad
btrfs sub snap /path-to-snapshot /subvolume

When you are confident that you want to delete the replaced subvolume

btrfs sub del /subvolume-bad

*Note*. you might want to first rename sobvolume-bad to something safe, like mv subvolume-bad deleteme; btrfs sub del deleteme
That way, is not not possible to accidentally hit <Enter> when you have btrfs sub del /subvolume on the command line.


Alternatively, you can just copy the disk image file from your snapshot into your active subvolume

cp -a --reflink=always /path-to-snapshot/vm.img /subvolume/vm.img

