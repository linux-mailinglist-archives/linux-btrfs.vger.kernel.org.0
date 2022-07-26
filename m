Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C3F581AA2
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 22:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiGZUBK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 16:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239357AbiGZUBI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 16:01:08 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9612326EF
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jul 2022 13:01:04 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id E3ECC2B059CB;
        Tue, 26 Jul 2022 16:01:03 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Tue, 26 Jul 2022 16:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1658865663; x=
        1658869263; bh=SVdSqTdD0laPilubivUhklhYEy008iudz7e/SbYgf9E=; b=v
        mD6a2xUQj6ldmS1fOaTEw9shvcxr3wou22U6h7H22vPEYkN5AWaDELoY393ICKTD
        H0hiTM7VxkW+YYpZtqXYPurFpmy6qnEokkiyC/GzLM09hoFmabFD1WCcytxZFZWi
        /YdWjQ9CvmI06cF1Gp8PTMYMEQS4eLihvG01dx+XmVeLU3oqQqSeLISCY/EmjTrt
        VjEA6+Lml1Gj+kAdE6vRUDjwVV7MP6KQ9nJtoBv9JqgGttejR6eMncTW743MgvIB
        TdcIgIINhS04Mf/pD3v+JbmJPgtOwQTCL9Ap6a2ddcpYestJHcHNU2BQ+KyouxMT
        d6RT+r3wjOx3Qk9YNZv7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        i06494636.fm3; t=1658865663; x=1658869263; bh=SVdSqTdD0laPilubiv
        UhklhYEy008iudz7e/SbYgf9E=; b=ZQop+97YkUFieYIaPD6XFfYvDKhDtVSK/V
        blolnRQCw9bqW9mHANmAkiiRDa8gCHXQKdnJ/9SDt1YWZgXouNOpeATh8emesy6/
        kx7Cj+7hfbQsGo001GaiAuOvFemdXtOk7biLQcfwvI2oGIAoLjPwdFyRlktiHJh1
        eUeDbvUHheK0/PdEBD3v37eOF72iPY6d9nmXWpe+TihrcNkuI0G1nKHaII0srkgH
        AadbKQDlhqPLvt8XOOMfbxPQJLoQFHuTAg+9KbN87Qn6vue1XHNLPSKIDHGwyDMg
        +ydyF5OY+BRsYFRqNtucHr36Lu5Q6VzMozyEoFhtOmwUtl9O6dMA==
X-ME-Sender: <xms:_kfgYnIiEmgx1oLXTMWIbUzKQ6InW8W4ZfojMfQjZQ-Td6hqJVuN1w>
    <xme:_kfgYrIyuX-VUPYHV8O_j3-xCdDX9apTKnU1CmgHXmkfmJY12YBXQtpH--I5PFnH7
    zD6btkEVG_KVkKy4po>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddutddgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdev
    hhhrihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtg
    homheqnecuggftrfgrthhtvghrnhepgfdvueektdefgfefgfdtleffvdeileetgfefuddt
    ffelueeiveeiveekhedtheeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:_kfgYvvZ3tTuT2nKO00ii3pO8lS9NV-6YIzXYKuoMfk7zCSgvclQfQ>
    <xmx:_kfgYga-Ab3T-cy-NgGCD1Vmr_ZQITeF3StW_b5nDaP3nF2luZqB1g>
    <xmx:_kfgYuYQQ6grQJ56S4nMiArFVc1Yd8pUf0QM4Nr2lWKK_Ymyw_94fQ>
    <xmx:_0fgYtkULWBefUrWkFKMXZi1PDoTMVFULfBU4BfkLjq1pYSwmC8aTUyL5MS9fVI_>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AA29E170007E; Tue, 26 Jul 2022 16:01:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-757-gc3ad9c75d3-fm-20220722.001-gc3ad9c75
Mime-Version: 1.0
Message-Id: <336b3dc2-2ca9-4f14-ad45-1896b36e0e82@www.fastmail.com>
In-Reply-To: <20220725190811.GD13489@twin.jikos.cz>
References: <CAEg-Je_b1YtdsCR0zS5XZ_SbvJgN70ezwvRwLiCZgDGLbeMB=w@mail.gmail.com>
 <20220725190811.GD13489@twin.jikos.cz>
Date:   Tue, 26 Jul 2022 16:00:42 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "David Sterba" <dsterba@suse.cz>, "Neal Gompa" <ngompa13@gmail.com>
Cc:     "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>,
        "Chris Mason" <clm@fb.com>, "Josef Bacik" <josef@toxicpanda.com>
Subject: Re: Using async discard by default with SSDs?
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On Mon, Jul 25, 2022, at 3:08 PM, David Sterba wrote:

> I think it's safe to use by default, with the usual question who could
> be affected by that negatively. The async triggers, timeouts and
> thresholds are preset conservatively and so far there have been no
> complaints.
>
> The tunables have been hidden under debug, but there are also some stats
> (like how many bytes could be discarded in the next round), so it would
> be good to also publish that when it's on by default.

In my testing, discard=async rather quickly submits recently freed metadata blocks for gc, blocks referred by the backup roots in the super. Is this a concern for recovery? Is there a way to exclude the most recent ~5 generations of metadata from gc, and could it improve the usefulness of backup roots for recovery?

-- 
Chris Murphy
