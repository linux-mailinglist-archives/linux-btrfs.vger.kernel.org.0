Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5661B5892F5
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Aug 2022 22:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbiHCUBS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Aug 2022 16:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiHCUBR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Aug 2022 16:01:17 -0400
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CFC13FB9;
        Wed,  3 Aug 2022 13:01:14 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id A435D2B05A24;
        Wed,  3 Aug 2022 16:01:11 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Wed, 03 Aug 2022 16:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1659556871; x=
        1659560471; bh=aQAgnwwHsBgv1g2PrR0xhkq6jXoEU2i3Abs0rA+lRiU=; b=u
        tc2P+LfVOzmagABHIY/CytS+1BHvgFBr9eSLQ7vVipWcMeaz7F0OoaZlahIjdDbL
        0P2eRJn/GTQP2LNmXVtOSi/usoyK75wke+LOFmsigCovf0+hvGFc2C48hUtLFg0V
        dLTj3+QfdSQ0hE0ptf8MfC4lYW7lyWauRji8gtxLYZRY9iMphnF3fgpe/d6XLBk+
        LRzRKGnkdjL1CROhSuRp9aQ8zex5Aaew61dnm5MGJVWu5NSW3A75Ji7Yqwhhl/cK
        7X1OIfUe5rjnJqFZ+f/9h6l33aXb2GO7KpwyEB+SEuf7HasG51WPIC8V8sIDlmWK
        M/ibo6tTDJXdMvBgxoHgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1659556871; x=1659560471; bh=aQAgnwwHsBgv1g2PrR0xhkq6jXoE
        U2i3Abs0rA+lRiU=; b=T7CVZBFDdm69u+GwrJ1Odko1pohpEj6Jbr02PEdm3pja
        LZsB23txNLX/J7PvBE4gqKSedUdf/YjrczOCCI9ap/Retq3ttDCVzxG0uGJ3xq2W
        xjf8FIXiGuULXiV7XtDhkd+M/O1iaU8hDFwloro8bJOHHXpsJHZNQSQOy7AzpGV/
        0hLDoSxqypempECpe2yaflxuTM2FwvIusIXttjBOzIFuuKd2ekmfDB3qDWPsl6eJ
        rsYlkHZM488YakSMa1rFOmjqJNMTFrvn6p7gvgVHSVUEh5A3EjqlBbGnZVW93iUJ
        m9X/69SsyHcVIEKSvP8D3b1+qMDmdM6sM+QE72MtsA==
X-ME-Sender: <xms:BtTqYq6c_7e6rBZh0UxCl4F_9hfYTAvGyAOQR3G1fjOt_12WXYB_JA>
    <xme:BtTqYj4m-JqguzEWbw9TW2S5pXsYkoHzkxoziA69Q-no6NDfLT4ysQccTyS3uE4gA
    _1KecjG6XGwfa_RMwY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvjedgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdev
    hhhrihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtg
    homheqnecuggftrfgrthhtvghrnheplefgfeduvdfhheeviedutdevtddtjeeukeehleej
    leettedtueeutdeuhfffheevnecuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehlihhsthhssegt
    ohhlohhrrhgvmhgvughivghsrdgtohhm
X-ME-Proxy: <xmx:BtTqYpdUjOq9S6dEEqAmaTESQwDaHcj1Uw9geqACXLxP-_EuEh7ZIg>
    <xmx:BtTqYnIa1yOHNjo0dt8JG5GcT9lDiOzLSI1PpGc7sKnO9Bd5pyH4qw>
    <xmx:BtTqYuJytP1lyw037Mq3a9vxXc6cJM8dUVjsG3UFW2BmGQ84JE4bPQ>
    <xmx:BtTqYq09hiyWa9IDK4d3Z3HO1yo8tIHNFlwUNpun-X6HIkpjtbOftuJb0GQ>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 132B6170007E; Wed,  3 Aug 2022 16:01:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-758-ge0d20a54e1-fm-20220729.001-ge0d20a54
Mime-Version: 1.0
Message-Id: <1d1afda7-2b4b-4984-adbe-51339ebbdd18@www.fastmail.com>
In-Reply-To: <CABXGCsMNF_SKns-av1kAWtR5Yd7u6sjwsFT9er8tSebfuLG8VQ@mail.gmail.com>
References: <CABXGCsN+BcaGO0+0bJszDPvA=5JF_bOPfXC=OLzMzsXY2M8hyQ@mail.gmail.com>
 <20220726164250.GE13489@twin.jikos.cz>
 <CABXGCsMNF_SKns-av1kAWtR5Yd7u6sjwsFT9er8tSebfuLG8VQ@mail.gmail.com>
Date:   Wed, 03 Aug 2022 16:00:40 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     =?UTF-8?Q?=D0=9C=D0=B8=D1=85=D0=B0=D0=B8=D0=BB_=D0=93=D0=B0=D0=B2=D1=80?=
         =?UTF-8?Q?=D0=B8=D0=BB=D0=BE=D0=B2?= 
        <mikhail.v.gavrilov@gmail.com>, "David Sterba" <dsterba@suse.cz>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     "Tetsuo Handa" <penguin-kernel@i-love.sakura.ne.jp>,
        dvyukov@google.com
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



On Wed, Aug 3, 2022, at 3:28 PM, Mikhail Gavrilov wrote:
> On Tue, Jul 26, 2022 at 9:47 PM David Sterba <dsterba@suse.cz> wrote:
>>
>> On Tue, Jul 26, 2022 at 05:32:54PM +0500, Mikhail Gavrilov wrote:
>> > Hi guys.
>> > Always with intensive writing on a btrfs volume, the message "BUG:
>> > MAX_LOCKDEP_CHAIN_HLOCKS too low!" appears in the kernel logs.
>>
>> Increase the config value of LOCKDEP_CHAINS_BITS, default is 16, 18
>> tends to work.
>
> I confirm that after bumping LOCKDEP_CHAINS_BITS to 18 several days of
> continuous writing on the BTRFS partition with different files with a
> total size of 10Tb I didn't see this kernel bug message again.
> Tetsuo, I saw your commit 5dc33592e95534dc8455ce3e9baaaf3dae0fff82 [1]
> set for LOCKDEP_CHAINS_BITS default value 16.
> Why not increase LOCKDEP_CHAINS_BITS to 18 by default?

This will be making it into Fedora debug kernels, which have lockdep enabled on them, starting with 5.20 series, which are now building in koji.
https://gitlab.com/cki-project/kernel-ark/-/merge_requests/1921




-- 
Chris Murphy
