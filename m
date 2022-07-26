Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99FE581A3A
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 21:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239789AbiGZTV5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 15:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGZTV4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 15:21:56 -0400
X-Greylist: delayed 114 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 26 Jul 2022 12:21:55 PDT
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8887733E39;
        Tue, 26 Jul 2022 12:21:55 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id A251F2B05A51;
        Tue, 26 Jul 2022 15:21:54 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Tue, 26 Jul 2022 15:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1658863313; x=
        1658866913; bh=PweAMHjIOF+cYwdE1sZvaXlEvHMPXsTwGJg3RCero2A=; b=s
        E4jewDf/Y186GuJwrzpJjZHrzlm5ACMkQXEi8FvBHZO7LY0IB2xJ4fZdmP1Tp3/8
        WtOQ27WItUBGA5DqezCiwVxcZ5vqUL7mwEon2k+hgORrDXr562AJgpjChfB001QC
        cIP6TxEUrbqqYNl9g960vSdDvADBYOpB7OqlHy8aVvSvXZdATUeheHvQOkN62l+r
        07+ObqS5iaAl8398HWSCMipL+SnNm+TqRkBRzVeKwJ/FiQI/G6U0ftmcRgU2bBqt
        HEQXJBzxn/a/GHn/x9cmNagIc36yoMwvppf3CF1cfl/qNQAvJrsctoBl3W+GvF82
        2Ccq6epBophGUxSXJVpuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        i06494636.fm3; t=1658863313; x=1658866913; bh=PweAMHjIOF+cYwdE1s
        ZvaXlEvHMPXsTwGJg3RCero2A=; b=OG/aZT1lhkvxuon3xOhXN69opPfmNSxdOe
        fuP/yBp61U4YRAvSzhTrWN/IqDxkpFWR1P0RctvfxfApo0cH2VDLgkaCdE33ayXQ
        xSXcHCdFa9eTvQlUD2EeuplRz+LzL9REEReXxWMKejb9nE/zJptpbo8dB6vB07PP
        6PM/skbfqT1TeAUjPcIKwf9mFYHkpwY3vtgWuxln5vO4K/LZWL9jtp/1AeWrSrj5
        fq+FN6I7PTmIYMQ0xs8pBTeqvGLMx8FI6Ry0JXXbXaqOqGBcucIc1ljbzdZVdPr4
        dI6WsSSLJQ4xbTcFwDflR7efTt2UukJLNE976iFxxTBbpsPNQeaw==
X-ME-Sender: <xms:0D7gYvhRhQB72pQV0y4cd_SxUmBmxya7toPD2dpIXs9295mL9ats8A>
    <xme:0D7gYsDS_uhXvCuYxKEXVAL84BH6vViMk1lumhgN5tVsuwlUZbwr7PhqOoFjcfC_r
    m8yqD3vG6CWXXOWts8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddutddgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdev
    hhhrihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtg
    homheqnecuggftrfgrthhtvghrnhepgfdvueektdefgfefgfdtleffvdeileetgfefuddt
    ffelueeiveeiveekhedtheeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:0D7gYvGTOOZ36ji9VpPzcyLMkV7YiZSQxNfpfSZxuel9DUKgEgiI0w>
    <xmx:0D7gYsTvEIA86sBvGN8guB4bLH1xqZ-qS8_T_D-d756lE46n7h2mHA>
    <xmx:0D7gYszyk_sqHkmtLIoS_BqiiaZrGW6ewCe0EDw_2LrBZQYoXIb8ug>
    <xmx:0T7gYpqvxIVlHjsnS4_B69XZ5BlqZ6Ks22vmLeE4d68Zz1_9kKTB4q_2DrovD-1g>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A9D31170007E; Tue, 26 Jul 2022 15:21:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-757-gc3ad9c75d3-fm-20220722.001-gc3ad9c75
Mime-Version: 1.0
Message-Id: <92e9ca9b-f458-409f-a9c4-150f6bce0b75@www.fastmail.com>
In-Reply-To: <fa57195c-cd1e-464e-b099-7552f65e39f5@www.fastmail.com>
References: <CABXGCsN+BcaGO0+0bJszDPvA=5JF_bOPfXC=OLzMzsXY2M8hyQ@mail.gmail.com>
 <20220726164250.GE13489@twin.jikos.cz>
 <fa57195c-cd1e-464e-b099-7552f65e39f5@www.fastmail.com>
Date:   Tue, 26 Jul 2022 15:21:32 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "David Sterba" <dsterba@suse.cz>,
        =?UTF-8?Q?=D0=9C=D0=B8=D1=85=D0=B0=D0=B8=D0=BB_=D0=93=D0=B0=D0=B2=D1=80?=
         =?UTF-8?Q?=D0=B8=D0=BB=D0=BE=D0=B2?= 
        <mikhail.v.gavrilov@gmail.com>
Cc:     "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On Tue, Jul 26, 2022, at 3:19 PM, Chris Murphy wrote:
> On Tue, Jul 26, 2022, at 12:42 PM, David Sterba wrote:
>> On Tue, Jul 26, 2022 at 05:32:54PM +0500, Mikhail Gavrilov wrote:
>>> Hi guys.
>>> Always with intensive writing on a btrfs volume, the message "BUG:
>>> MAX_LOCKDEP_CHAIN_HLOCKS too low!" appears in the kernel logs.
>>
>> Increase the config value of LOCKDEP_CHAINS_BITS, default is 16, 18
>> tends to work.
>
> Fedora is using 17. I'll make a request to bump it to 18. Thanks.

Should it be 18 across all archs? Or is it OK to only bump x86_64?

-- 
Chris Murphy
