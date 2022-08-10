Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D19258F27A
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Aug 2022 20:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiHJSnE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Aug 2022 14:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiHJSnD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Aug 2022 14:43:03 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE90321;
        Wed, 10 Aug 2022 11:43:02 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8D04E580902;
        Wed, 10 Aug 2022 14:43:01 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Wed, 10 Aug 2022 14:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660156981; x=
        1660160581; bh=jLKPYg8r1NWKdk49fFDpdK5qae/XsFnguQ1wMSjTmTo=; b=j
        voINbCT7I34DAt8YlnXHdXbhohDUDl1XY9UryT5X3UbyLKV8Cm2dk2Ise8WlBqd7
        1nEH8aoK6oHWzw+vUUksa6p+ixc7ISyR9nhdQ5H7adMVrKTUz1wtwu4z+gDJgFK8
        HcIW4sglyTKAheCqk+nXraquVuV7m15vrXRZ/yyxStuGA5OXlZie/u/FWKGgoOrg
        kxqrrt2+sO6t9F0CBxxJsBhDDrgbkzuKVCQbwtbiKk9T+Liawo6I8mJ4YE30iwUt
        frQoFplUs0ZYoAlAU/vAo3KsC0k7wd1xLvoZgVJOWbQX7NptR91REaK6sOO5JLKH
        ySQIVaZl2aSPb5LpolyUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660156981; x=1660160581; bh=jLKPYg8r1NWKdk49fFDpdK5qae/X
        sFnguQ1wMSjTmTo=; b=EzwBop3RAVvNTG/DtwC3n8JGE2I78/II65Xbj98SF7l7
        lT4zzF0fs0NJge3SjchB21PrstCTQuc3MCfu+d578kAMSuVk516g2RK3kmVkWfxW
        s291/CCqRFRK7MFOh/l+Bp5ZE9gG/IhweejXJx4yC5iPyZporl97Tm0egwm3QKT9
        41Q/qa2TKiv58UuXZVZ9XcDU5jbwNtS5MW5KT4NGXdWvHWCOQiZkFFDYeoaDSARO
        ng4GRsNZb4HfBx2L6/ncyQMbTXil2xKqrJxoQ5XeL3WiOYS394H/rQ6hMRtSqpwD
        UhsYS0ACemJZILDR+ewe6rpM6Y3NrL7M4yQQdaDdxw==
X-ME-Sender: <xms:NfzzYhWCNuQn9fVQXz3T6nhp6J1tjwP-7gyZbibnfDoeCaVYH2uqGg>
    <xme:NfzzYhldZo0af02BNme-_-mOtAu9TB5GZ_3rSwWDjzEfQUY1s0kPUECNHUNj4lHNf
    -SbNTb7ry6M623AONw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegvddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdev
    hhhrihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtg
    homheqnecuggftrfgrthhtvghrnhepgfdvueektdefgfefgfdtleffvdeileetgfefuddt
    ffelueeiveeiveekhedtheeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:NfzzYtZxpqSPMcDEcb9wunEzs4mhBo8tUU1M8SbGGKODqryMStDiCA>
    <xmx:NfzzYkUoUG8J2SgR12g_Uh0Kevs7EPisA8sTtKrsiZHBoVBt5ikxRw>
    <xmx:NfzzYrnnLpuvA6bx7fmPQMCetmOgGX7oMc15pRNZ02gZU0B7y4G3AA>
    <xmx:NfzzYgzTf0SvU6stn5ePDNpMS45CQiQsyIksd-XiKARKz35tojJ6RQ>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 54B791700082; Wed, 10 Aug 2022 14:43:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-811-gb808317eab-fm-20220801.001-gb808317e
Mime-Version: 1.0
Message-Id: <cb1521d5-8b07-48d8-8b88-ca078828cf69@www.fastmail.com>
In-Reply-To: <2220d403-e443-4e60-b7c3-d149e402c13e@www.fastmail.com>
References: <e38aa76d-6034-4dde-8624-df1745bb17fc@www.fastmail.com>
 <YvPvghdv6lzVRm/S@localhost.localdomain>
 <2220d403-e443-4e60-b7c3-d149e402c13e@www.fastmail.com>
Date:   Wed, 10 Aug 2022 14:42:40 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Josef Bacik" <josef@toxicpanda.com>
Cc:     "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: stalling IO regression in linux 5.12
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



On Wed, Aug 10, 2022, at 2:33 PM, Chris Murphy wrote:
> On Wed, Aug 10, 2022, at 1:48 PM, Josef Bacik wrote:
>
>> To help narrow this down can you disable any IO controller you've got enabled
>> and see if you can reproduce?  If you can sysrq+w is super helpful as it'll
>> point us in the next direction to look.  Thanks,
>
> I'm not following, sorry. I can boot with 
> systemd.unified_cgroup_hierarchy=0 to make sure it's all off, but we're 
> not using an IO cgroup controllers specifically as far as I'm aware.

OK yeah that won't work because the workload requires cgroup2 or it won't run.


-- 
Chris Murphy
