Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74196D6BF3
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Apr 2023 20:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbjDDS1X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Apr 2023 14:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbjDDS1K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Apr 2023 14:27:10 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A126A45
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Apr 2023 11:24:11 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id AE9C05C004E;
        Tue,  4 Apr 2023 14:23:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 04 Apr 2023 14:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1680632599; x=1680718999; bh=Ai
        Qi5Cw1/rZnptSfsuvBndr28ypkFZK63VDk4qsSMAo=; b=Qdeb5gGLHimARKOVqa
        gyeSfHn2pnCOfZCYJbYUiMb+9pzIQ1Mh6ZOFzvTTpQAfrmFSfCkZTfeW4rIEUxat
        gvzS0P2mqRnzQhf6a3hZK+iu8mOL8RiH44QgsDsygeuw7C0zdqY4XOrNFFXT0gnp
        gn8/IB/IrBomE5ZiK/XmvRsDKy+1/9gA6Uix3+ZzowYOWNcxVEXKFxY/BVHFaF5R
        zBdqUzas6K2L+kugx5tJ8zGpaa6Zmg4hwEE1IxJLjtLZr4smP2SdgT9I6yolWEnz
        ZW84xBxrGMd+gZBMQesO53i0HiOghF48uXfltCpPh/eC63V8nurGrYytyRJ4EEHX
        VkMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680632599; x=1680718999; bh=AiQi5Cw1/rZnp
        tSfsuvBndr28ypkFZK63VDk4qsSMAo=; b=A3ltF/Na3wHuLClSUEWYxvhSTeknD
        1P+QwwCn2r4CBAK4TBGEKnynNfLpdFQ9jCCnQxo2NmFw3ZMWzVhowof/IX8Rw6NB
        cBNxJmW20tfq1DdWkSxy2XYysO7qFCxEAZ0Wx4BTQNZn5+CRHUXFcbf1mjuXWmUT
        5yVW2HPvGA82pBRaQdfrea/U1pK7ZZ+JbrX10Glcji9cbI3M3PO/SGnZxXw6ovua
        z2vTliyiQCsNaNeokDu+vggkuNwaCtkBFnAZzKFnEBkrqVo+H6VpFzf9ikdNGvuy
        F6TnHPIKHI6mXgZj56p4pKSBnCVKUU0WNCAzK5UkVbYEJJO4qfBY07QZg==
X-ME-Sender: <xms:F2ssZPAnnKObayyjmcweXNR-6kYt0kND6a7s8haa8hv5I3GmJbD9Aw>
    <xme:F2ssZFi9lC40vx-jxJb_ahzVfbF9owZeaBWUq71um-LjMXcNiFIME5HFXpBLb4d5w
    gm73VvoX9I-cCD-o5Y>
X-ME-Received: <xmr:F2ssZKkG8ku-r6wEEG0BTwmr_Bn-sFVm2ItNLNsMAnk0xPwDqpCZsVdd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiledguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epudduvdeugfeftedvleekheffhfeutddvjeehheeitdduffetudefheetfedugeehnecu
    ffhomhgrihhnpehrvgguhhgrthdrtghomhdprhgvugguihhtrdgtohhmpdhlvggvmhhhuh
    hishdrihhnfhhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:F2ssZBwYuL5Z0F5fI-XPgfOq4JrmuXvf3zyPOI41rpfeFGztOm2njA>
    <xmx:F2ssZEQwH1gfCcLbrKtrGz3XGWW2zWjhaX4-Dd21WGB-fzTk8YWiWA>
    <xmx:F2ssZEZBO4KHp8UKujU8o_cd1K2M5PGFcRx1uJKMD3S6LdpQzIZV1w>
    <xmx:F2ssZHHrw8gsmWYBzYOs28Ly_Eqv_K4o4jd81wL1Tqdel5BlHa929g>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Apr 2023 14:23:18 -0400 (EDT)
Date:   Tue, 4 Apr 2023 11:23:12 -0700
From:   Boris Burkov <boris@bur.io>
To:     "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Cc:     Sergei Trofimovich <slyich@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christopher Price <pricechrispy@gmail.com>,
        anand.jain@oracle.com, clm@fb.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [6.2 regression][bisected]discard storm on idle since
 v6.1-rc8-59-g63a7cb130718 discard=async
Message-ID: <20230404182256.GA344341@zen>
References: <CAHmG9huwQcQXvy3HS0OP9bKFxwUa3aQj9MXZCr74emn0U+efqQ@mail.gmail.com>
 <CAEzrpqeOAiYCeHCuU2O8Hg5=xMwW_Suw1sXZtQ=f0f0WWHe9aw@mail.gmail.com>
 <ZBq+ktWm2gZR/sgq@infradead.org>
 <20230323222606.20d10de2@nz>
 <20d85dc4-b6c2-dac1-fdc6-94e44b43692a@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20d85dc4-b6c2-dac1-fdc6-94e44b43692a@leemhuis.info>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 04, 2023 at 12:49:40PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 23.03.23 23:26, Sergei Trofimovich wrote:
> > On Wed, 22 Mar 2023 01:38:42 -0700
> > Christoph Hellwig <hch@infradead.org> wrote:
> > 
> >> On Tue, Mar 21, 2023 at 05:26:49PM -0400, Josef Bacik wrote:
> >>> We got the defaults based on our testing with our workloads inside of
> >>> FB.  Clearly this isn't representative of a normal desktop usage, but
> >>> we've also got a lot of workloads so figured if it made the whole
> >>> fleet happy it would probably be fine everywhere.
> >>>
> >>> That being said this is tunable for a reason, your workload seems to
> >>> generate a lot of free'd extents and discards.  We can probably mess
> >>> with the async stuff to maybe pause discarding if there's no other
> >>> activity happening on the device at the moment, but tuning it to let
> >>> more discards through at a time is also completely valid.  Thanks,  
> 
> BTW, there is another report about this issue here:
> https://bugzilla.redhat.com/show_bug.cgi?id=2182228
> 
> /me wonders if there is a opensuse report as well, but a quick search
> didn't find one
> 
> And as fun fact or for completeness, the issue even made it to reddit, too:
> https://www.reddit.com/r/archlinux/comments/121htxn/btrfs_discard_storm_on_62x_kernel/

Good find, but also:
https://www.reddit.com/r/Fedora/comments/vjfpkv/periodic_trim_freezes_ssd/
So without harder data, there is a bit of bias inherent in cherrypicking
negative impressions from the internet.

> 
> >> FYI, discard performance differs a lot between different SSDs.
> >> It used to be pretty horrible for most devices early on, and then a
> >> certain hyperscaler started requiring decent performance for enterprise
> >> drives, so many of them are good now.  A lot less so for the typical
> >> consumer drive, especially at the lower end of the spectrum.
> >>
> >> And that jut NVMe, the still shipping SATA SSDs are another different
> >> story.  Not helped by the fact that we don't even support ranged
> >> discards for them in Linux.
> 
> Thx for your comments Christoph. Quick question, just to be sure I
> understand things properly:
> 
> I assume on some of those problematic devices these discard storms will
> lead to a performance regression?
> 
> I also heard people saying these discard storms might reduce the life
> time of some devices - is that true?
> 
> If the answer to at least one of these is "yes" I'd say we it might be
> best to revert 63a7cb130718 for now.
> 
> > Josef, what did you use as a signal to detect what value was good
> > enough? Did you crank up the number until discard backlog clears up in a
> > reasonable time?

Josef is OOO, so I'll try to clarify some things around async discard,
hopefully it's helpful to anyone wondering how to tune it.

Like you guessed, our tuning basically consists of looking at the
discardable_extents/discardable_bytes metric in the fleet and ensuring
it looks sane, and that we see an improvement in I/O tail latencies or
fix some concrete instances of bad tail latencies. e.g. with
iops_limit=10, we see concrete cases of bad latency go away and don't
see a steady buildup of discardable_extents.

> > 
> > I still don't understand what I should take into account to change the
> > default and whether I should change it at all. Is it fine if the discard
> > backlog takes a week to get through it? (Or a day? An hour? A minute?)

I believe the relevant metrics are:

- number of trims issued/bytes trimmed (you would measure this by tracing
  and by looking at discard_extent_bytes and discard_bitmap_bytes)
- bytes "wrongly" trimmed. (extents that were reallocated without getting
  trimmed are exposed in discard_bytes_saved, so if that drops, you are
  maybe trimming things that you may have not needed to)
- discardable_extents/discardable_bytes (in sysfs; the outstanding work)
- tail latency of file system operations
- disk idle time

By doing periodic trim you tradeoff better bytes_saved and better disk
idle time (big trim once a week, vs. "trim all the time" against worse
tail latency during the trim itself, and risking trimming too
infrequently, leading to worse latency on a drive that needs a trim.

> > 
> > Is it fine to send discards as fast as device allows instead of doing 10
> > IOPS? Does IOPS limit consider a device wearing tradeoff? Then low IOPS
> > makes sense. Or IOPS limit is just a way to reserve most bandwidth to
> > non-discard workloads? Then I would say unlimited IOPS as a default
> > would make more sense for btrfs.

Unfortunately, btrfs currently doesn't have a "fully unlimited" async
discard no matter how you tune it. Ignoring kbps_limit, which only
serves to increase the delay, iops_limit has an effective range between
1 and 1000. The basic premise of btrfs async discard is to meter out
the discards at a steady rate, asynchronously from file system
operations, so the effect of the tunables is to set that delay between
discard operations. The delay is clamped between 1ms and 1000ms, so
iops_limit > 1000 is the same as iops_limit = 1000. iops_limit=0 does
not lead to unmetered discards, but rather hits a hardcoded case of
metering them out over 6 hours. (no clue why, I don't personally love
that...)

Hope that's somewhat helpful,
Boris

> 
> /me would be interested in answers to these questions as well
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
