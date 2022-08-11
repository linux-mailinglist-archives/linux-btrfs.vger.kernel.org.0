Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7703358F5DA
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Aug 2022 04:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbiHKCYL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Aug 2022 22:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbiHKCYK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Aug 2022 22:24:10 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEFB88DD9;
        Wed, 10 Aug 2022 19:24:09 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8083458082C;
        Wed, 10 Aug 2022 22:24:08 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Wed, 10 Aug 2022 22:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660184648; x=
        1660188248; bh=AByR1PJmDpTE0uFhsvdMKLFIvf9aRNuqEd1rQGv8pEc=; b=n
        iwO99PQMqU1llLMD3SbZLGQAlp5d46lxCl6P2eGLuoRW7IWjqJRmcWhTjk6szpaA
        DMhXFV3uoXXvNJiK6b6470MvPBcbnuJ1kW3aQFbhLPrMrQRhIKvHwhxVJuMsqApM
        yfzm/bgaxNa1fI1KpkSIOjW1M3ooMi6nOo8kgH2CdTaqPKfMA1FIGLF+8JFkv9q7
        J+RnQenlemrPiS/NTbIIOWhf7K3Q+IBYVxodQbSs9fzfGxCHbttNJo72TOnruxF1
        MBGkQggMGODk7QZ/Zmt6Wf019XT2fszzIG7o0yknL45NXHD88U3p0OUcbWAZuenJ
        s5trEinJlokUSiJzixKhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660184648; x=1660188248; bh=AByR1PJmDpTE0uFhsvdMKLFIvf9a
        RNuqEd1rQGv8pEc=; b=iMR01sRaRayHalljSLJIMUIAFCIg/69a3swUzHKrGyUD
        rnEL19jK/1pOv5BZ8cCYXZ7zY+3vWkXuDo2mWB2/I7xIf/zCRP2TYpr+lTnSC3sl
        7qjXb5TCI0cbsDuolACeyPg45VA2whdUFGzTLdQbp9poZoK47S7TUlApxHK7tO35
        bJZaO7IWwVWE6qTcbG0FyVqfwhy7MUiV1AZOJ6H5QdPwdB47OHnLEuhGtpfsggBD
        xOuiJP+lX/L1KKgJlUhL8tV509z09iUvHwjOA1vdlsLGJRjkeaJLKaRp43C6CFLw
        fA3aXdZPOniSJJ0W2D18PWaZ3GLvA+kn7hbzqydINA==
X-ME-Sender: <xms:SGj0Yl5nLBYWVdLJdk0x0el7mL6mNYeIIJQq2nqCBliUb4z4HIf1qA>
    <xme:SGj0Yi6TZGzWOXCDeQLNbPzhcbbZ0oHDF-Ty4CRPGJHCQcmEvMzwH0rsxvfpN6QGq
    _l-Rt51D2WzMcSObCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegfedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdevhhhr
    ihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
    eqnecuggftrfgrthhtvghrnhepuefftdffheekudeludefledvkefhgfeuleeuudetudeh
    veetleeiveekjedttdfhnecuffhomhgrihhnpehrvgguhhgrthdrtghomhdpkhgvrhhnvg
    hlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:SGj0YsdW1gwbx1MHdyAr4z_pH-AR-lWwtAYyoutH59q2-05mmnoaDg>
    <xmx:SGj0YuIokd9Jj2z3ekapzcS9StXlS7NXP4yrJZWeK2D2Q6mmMGVt1w>
    <xmx:SGj0YpI4JYQ4wZq0gdPIMemjPOvzDayl5M0jonkvDzQDOhhrthGXfQ>
    <xmx:SGj0YrzllhMerE3r4hCBOdwBE8IsNKrA2A7GksPi6232PKMnONWKtw>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2ECE21700082; Wed, 10 Aug 2022 22:24:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-811-gb808317eab-fm-20220801.001-gb808317e
Mime-Version: 1.0
Message-Id: <20fffbb6-fec5-476f-8d8a-471f14572a0c@www.fastmail.com>
In-Reply-To: <073b7d19-b02b-cbfc-9b61-dbacbf08ed93@gmx.com>
References: <f7c14f0f-56e5-4748-a3f7-d44bc635b020@www.fastmail.com>
 <073b7d19-b02b-cbfc-9b61-dbacbf08ed93@gmx.com>
Date:   Wed, 10 Aug 2022 22:21:31 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Qu Wenruo" <quwenruo.btrfs@gmx.com>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: 5.19.0: dnf install hangs when system is under load
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



On Wed, Aug 10, 2022, at 9:32 PM, Qu Wenruo wrote:
> On 2022/8/11 00:19, Chris Murphy wrote:
>> Downstream bug - 5.19.0: dnf install hangs when system is under load
>> https://bugzilla.redhat.com/show_bug.cgi?id=2117326
>>
>> 5.19.0-65.fc37.x86_64
>>
>> Setup
>> btrfs raid10 on 8x plain partitions
>>
>> Command
>> sudo dnf install pciutils
>>
>> Reproducible:
>> About 1 in 3, correlates with the system being under heavy load, otherwise it's not happening
>>
>> Get stuck at
>> Running scriptlet: sg3_utils-1.46-3.fc36.x86_64   2/2
>>
>> ps aux status for dnf is D+, kill -9 does nothing, strace shows nothing. The hang last at least 10 minutes, didn't test beyond that.
>>
>> Full dmesg with sysrq+w is attached to the bug report.
>>
>> snippet
>>
>> [ 2268.057017] sysrq: Show Blocked State
>> [ 2268.057866] task:kworker/u97:11  state:D stack:    0 pid:  340 ppid:     2 flags:0x00004000
>> [ 2268.058361] Workqueue: writeback wb_workfn (flush-btrfs-1)
>> [ 2268.058825] Call Trace:
>> [ 2268.059261]  <TASK>
>> [ 2268.059692]  __schedule+0x335/0x1240
>> [ 2268.060145]  ? __blk_mq_sched_dispatch_requests+0xe0/0x130
>> [ 2268.060611]  schedule+0x4e/0xb0
>> [ 2268.061059]  io_schedule+0x42/0x70
>> [ 2268.061473]  blk_mq_get_tag+0x10c/0x290
>
> All the hanging processes are waiting at blk_mq_get_tag(), thus I'm not
> sure if it's really btrfs, or something in the block layer.
>
> Adding block layer guys into the thread.

OK so it might just be the same problem I reported in this thread, which first appeared in the 5.12 merge window. The weird thing is, the 5.19 kernel is staying up for *days* unlike 5.12 through 5.18, except under heavy load I run dnf and then only dnf hangs.


https://lore.kernel.org/linux-btrfs/ad78a32c-7790-4e21-be9f-81c5848a4953@www.fastmail.com/T/#t

-- 
Chris Murphy
