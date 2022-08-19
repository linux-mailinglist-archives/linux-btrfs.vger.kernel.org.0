Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D3159A35A
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Aug 2022 20:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349946AbiHSRl1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Aug 2022 13:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355047AbiHSRlD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Aug 2022 13:41:03 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5861256EF
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Aug 2022 10:00:52 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 1F861320095E
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Aug 2022 12:50:12 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Fri, 19 Aug 2022 12:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shamm.as; h=cc
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1660927811; x=1661014211; bh=hqlBkiseb7Mvv+b2QFBKzA8+ubhZCp/OMu7
        kw61EWfA=; b=pXlBGt3ZYglxztn2ScJ91bhk1hzyHCvHIZwrqxgTEtuXS5VISox
        ubWm7igA0yYSNgaRI/9w9MHQMy4EEfwzJiDLnkFDpk0P/y3F7k3/9UguDlSh7ubY
        rSOjdNdbGDtU4jRcqixvm5UWiWQY50K+56q37mIurypgNKXEmppNwteS51dcKqg3
        /LUBL/bFx2YnsTra2vwm8FDNjsUJdreqr0rthK69j1ZTzC7Dlv3EF65AXD+XrvRW
        QLNie6uL/OoqIZb9xc7v25HixTDVtwbi02fpc+dG1tAWGitJmWVeYwE5N+OcBmU6
        CIu6a6AalFr7o91sLDRnWgg1LQjQTs1WX5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660927811; x=
        1661014211; bh=hqlBkiseb7Mvv+b2QFBKzA8+ubhZCp/OMu7kw61EWfA=; b=c
        2tnmiQBQ3dSA5QWaXy/diH21lDWQVTu1CgvhOh86v+fw8qVcYcYCXHDu03dD7u7C
        LY8+MdUR6fCLgAAufYUJAoelc5a7TcyVbXhQtDfa6wvFHqih3JMuYVOtjyeJXZ2N
        CV/KMOYfZLYY4ZdBK5eNwoGvWQlzlfBuwGIYp8ICjFNVDJ2pNSZCzKIMs/cIdbb9
        wUi8SY8f/WYsL025Eb+pyK4wXy6jQaD5aBrQbjOfDowvCX0ABEnuO4rqT4y3L2XZ
        umfP+JsMWkRBir17xd9tpZx1Xq5uZ7226YfjmUfwzpGPtR4F2Vy0qnMPq+Rfefph
        gfs1oBPJo+COpi6byNrEw==
X-ME-Sender: <xms:Q7__YpPG_5ZrpnoQVYBVeaqsgFh5_FB_M6UAHENbPZ9YbshjUMYyNA>
    <xme:Q7__Yr-6yeiXz2nj3yug6V0YECBlEtpNXASKY9ZYTh7KTFHVUe61Ee7SHxAobdNXt
    jAue8P4h1WqDRN6Vts>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeiuddguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkfffhvffutgesthdtre
    dtreertdenucfhrhhomhepfdfivghorhhgvgcuufhhrghmmhgrshdfuceosghtrhhfshes
    shhhrghmmhdrrghsqeenucggtffrrghtthgvrhhnpefhteeivedugeefgeelgffgfefhge
    ejleejjeehteeitddvhfffueefleffieelkeenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgpdhrvggrughthhgvughotghsrdhiohdprhgvugguihhtrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghtrhhfshesshhhrghm
    mhdrrghs
X-ME-Proxy: <xmx:Q7__YoR1IB0syV9xFQhW1-a0YhkgDO7jwn2x3QqlGS7TrRAyNEhoJg>
    <xmx:Q7__YlsN-qKtkzmI3sjPoy_Q6i8r_UFzfnwfzMEEwwcplUJoUz0lsg>
    <xmx:Q7__Yhc2n4I7_3GCajUrcMCwiePsfE95P95_9_bWdLXqEIqbWpydew>
    <xmx:Q7__Yl56hA7Zj5m-feA2yZ5UBau9F9jlH0lSDUQRqzUfzJgQA-MkRg>
Feedback-ID: i1ac146fc:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 26174C6008B; Fri, 19 Aug 2022 12:50:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <a3fc9d94-4539-429a-b10f-105aa1fd3cf3@www.fastmail.com>
Date:   Fri, 19 Aug 2022 12:49:50 -0400
From:   "George Shammas" <btrfs@shamm.as>
To:     linux-btrfs@vger.kernel.org
Subject: What exactly is BTRFS Raid 10?
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

 I've been searching and reading docs for a few days now, and btrfs raid 10 is a mystery to me. 

This is mostly a documentation question, as many places reference it but nothing actually describes it and the real question is how does it differ from btrfs raid1.

Both BTRFS Raid1 and Raid10 
 - Allows arbitrary number of drives (>=2), including odd numbers. 
 - Will write duplicate blocks across disks.

Raid 10 is referenced in many places, including being the example on using btrfs on multiple devices

https://btrfs.wiki.kernel.org/index.php/Using_Btrfs_with_Multiple_Devices

And while raid0,1,5,6 are described in several places, raid 10 is missing. Including in the layout examples here:

https://btrfs.readthedocs.io/en/latest/mkfs.btrfs.html?highlight=raid10#profile-layout

The Raid 1 example there also likely needs a bit of explanation or validation, as all the blocks are written to one device. In that raid one example three devices could be lost as long as it is not one of them is the first device. It also cannot be accurate once the amount stored is above 1 full drive. 

Since raid10 allows for two devices, is there ever a scenario in which choose raid10 would be bad when you want raid1?

BTRFS defaults to raid1 for Data and Metadata, is there a reason that doesn't default to raid10?

Since BTRFS raid modes aren't like traditional block level raids, it would be very useful to explain this somewhere and the pros and cons of each. Maybe even merging the two modes if they cover the same use cases. 

--George

PS:

There is a lot of misinformation out there about btrfs raid as well. For example:

https://www.reddit.com/r/btrfs/comments/f5unv5/raid_1_vs_raid_10/

None of the comments seem accurate, as they are describing traditional raid setups. The second comment says btrfs raid10 is actively harmful, but I has no references to collaborate that. 
