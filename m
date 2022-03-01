Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A7E4C80D4
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Mar 2022 03:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiCACPN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 28 Feb 2022 21:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiCACPK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 21:15:10 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91125BD33
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 18:14:27 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E9DCA2A0789;
        Tue,  1 Mar 2022 02:14:26 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id D88B72A0876;
        Tue,  1 Mar 2022 02:14:25 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1646100866; a=rsa-sha256;
        cv=none;
        b=flg5iRTJYeKhq6P8D59vrSgRyjLxyDKi1WJIlwX2iDXQXcyoUnDqSx3QxXczy6UHFZikin
        BivmmHtvI6QgxKBxdkHAmr5kI0ewiZBccKwl6x3QrOE4XSN7gmMHKD5XOzrDwY7b8qAcrj
        XgC6OuDrHJhSZ48L8T8oMn9H3ah9ilpFNJTo+n27H+0MVAyqA6gwLIrrxNkroDRkzVgVAW
        ZkPl2kiMSCouKjmge2gDlTazpLUrTHeeiqEWsm8AMol+QqoLQxBOl2Ys5vJ5FNk/BO54wR
        xBtzeXASata89rne6nsADjKrIzsPAWpOSQXuuTH66U8uxi0xuoG+1KbVSAlhbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1646100866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eXMnM4Nti+SULdWnXHe/grkmm8vfPefYUfzDYWXP4yw=;
        b=v2ovoZg6J7o4ZHPssy/C4fzJRSLW5dplnGA8gPwhvMH+wMBdjVJvLph7qIeYx8+os50vx/
        lx1alrpjqdfKyuZFgSufOkY3jdSGWuvb+ZRtA6AiSEg7XtfvyFYf2Ggvt+VY1pkenYJdp5
        wyznLzjHuxotT/FKfDX8XHGdjRyGOHtkhtyqPKDCnNp5d3oMW63agOxaV6YyIekLBLT4qR
        ZUUb/WfceWKUVfB9CRNX363NdO1rR6W9cVwUcxh8Hmn6XEhpAOgNB0vPBVs5eDYE/fEteS
        sg1qzKp3l9E7ghhMm5PZsLSHP9lE+LsENAFv3r8O7m8RcT2SdKSMyiQhUwKVSw==
ARC-Authentication-Results: i=1;
        rspamd-56df6fd94d-dzzdc;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.107.255.145 (trex/6.5.3);
        Tue, 01 Mar 2022 02:14:26 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Fumbling-Arithmetic: 6408d7d368355b6a_1646100866626_2488366073
X-MC-Loop-Signature: 1646100866626:1006266506
X-MC-Ingress-Time: 1646100866626
Received: from ppp-88-217-35-91.dynamic.mnet-online.de ([88.217.35.91]:50300 helo=[127.0.0.1])
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <calestyo@scientia.org>)
        id 1nOs1s-0007Wz-NL; Tue, 01 Mar 2022 02:14:24 +0000
Date:   Tue, 01 Mar 2022 03:14:18 +0100
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_BTRFS_error_=28device_dm-0=29=3A_parent_transid_ve?= =?US-ASCII?Q?rify_failed_on_1382301696_wanted_262166_found_22?=
User-Agent: K-9 Mail for Android
In-Reply-To: <d408c15d-60e2-0701-f1f1-e35087539ab3@gmx.com>
References: <2dfcbc130c55cc6fd067b93752e90bd2b079baca.camel@scientia.org> <5eb2e0c2-307b-0361-2b64-631254cf936c@gmx.com> <f7270877b2f8503291d5517f22068a2f3829c959.camel@scientia.org> <ff871fa3-901f-1c30-c579-2546299482da@gmx.com> <22f7f0a5c02599c42748c82b990153bf49263512.camel@scientia.org> <edefb747-0033-717d-5383-f8c2f22efc8f@gmx.com> <74ccc4a0bbd181dd547c06b32be2b071612aeb85.camel@scientia.org> <d408c15d-60e2-0701-f1f1-e35087539ab3@gmx.com>
Message-ID: <9049B0C3-5A30-4824-BCED-61AA9AC128E5@scientia.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
X-OutGoing-Spam-Status: No, score=-0.5
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey.

memtest[0] showed, that in fact memory is damaged in some higher region... as you've guessed, its always a single but flip.



Am 1. März 2022 01:19:12 MEZ schrieb Qu Wenruo <quwenruo.btrfs@gmx.com>:
>> It would be interesting to see how much is actually affected,...
>> shouldn't it be possible to run something like dd_rescue on it? I mean
>> I'd probably get thousands of csum errors, but in the end it should
>> show me how much of the file is gone.
>
>As said, no real file is damaged.
>It's just we can get csum.

Sure. I've had understood that. What I've meant was to find out how much of the file (or, if more were affected, which files) was not guaranteed to be integrity protected, because its csum data is broken.



>> So would expect that the corruption or bit-flip would need to have
>> happened at some point after it was first sent/received?
>
>I guess the corrupted csum tree block happen at that time.

It's still a bit strange, though, because I most likely had run a scrub since then,  and no errors were found...

But in principle, scrub should notice these corruptions in the csum tree, shouldn't it? 


>And fortunately that range doesn't get much utilized thus later
>read/write won't get interrupted by that corrupted tree block.

That I don't understand. You mean the csum tree isn't read/written in that region (i.e. not unless the associated files are read)... and that's why it went so long unnoticed?



>> Shouldn't I be able to find out simply by copying away each file (like
>> what I did during yesterday's backup)?
>
>Yep, that's possible.
>
>> Or something like tar -cf /dev/null /
>>
>> Every file that tar cannot read should give an error, and I'd see which
>> are affected?
>
>That's also a way.

Ok... if both works to find out files are affected (in the sense that they cannot be verified because the csum is broken... and thus may or may not be valid)... then I guess that's the easiest way for me to recover. 



>>> 1) Which logical bytenr range is in that csum tree block
>>>
>>> 2) Which files owns the logical bytenr range.
>>
>> Is this possible already with standard tools?
>
>We have tools for 2), "btrfs ins logical-resolve" to search for all the
>files owning a logical bytenr range.

So in principle,  since my tar yesterday brought no further errors,  the should result in only that one file. 


>> If I'd delete the affected file(s) would btrfs simply clear the broken
>> csum block?
>
>Nope. That generation mismatch would prevent btrfs to do any
>modification including CoW the tree block to a new location.

Ah, OK. 


Thanks,
Chris.

[0] For those who haven't seen yet,  there's pcmemtest (https://github.com/martinwhitaker/pcmemtest) which is a fork off (or based upon memtest86+)... but with UEFI support, which memtest86+ cannot be used with. 
