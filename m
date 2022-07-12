Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1A4571ACB
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jul 2022 15:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbiGLNFx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jul 2022 09:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbiGLNFs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jul 2022 09:05:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FED3B4BC6
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 06:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657631145;
        bh=zjWQbSUnm05o99LsZ7QgnQA42xiYpkLG5o/Cv9r29Os=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=DLe2Pyd+9xCK/yqGZYZpwGl880ZZLBGAiLhFEalHmuyjbkEFGQ+v4b3iyErPc0XNZ
         ImMuQBAkM1cMkV0TN7MZ0Yn8AnFK3r+rm+C7SvEupnR5+j3SQVnPlKG2+dS/ysnzW9
         pCw2dQItbSZJFL+yzADzTuGsEU/k0AjvXCyKXhYg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MMGRK-1nt2Vi2hJG-00JIfP; Tue, 12
 Jul 2022 15:05:45 +0200
Message-ID: <383ed3cd-749c-cfb2-cfed-3f767b443e88@gmx.com>
Date:   Tue, 12 Jul 2022 21:05:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: BIG_METADATA - dont understand fix or implications
Content-Language: en-US
To:     Peter Allebone <allebone@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAGSM=J8K7_GfaqL3-7obOSytNhtoqmJ1GQrOKAUgE2dF7OehTg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAGSM=J8K7_GfaqL3-7obOSytNhtoqmJ1GQrOKAUgE2dF7OehTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vYxnP0/W+COIavcBfEpNBUMC4c6XMNw25gyhv1T2X1ksZynIqQZ
 amP7QHYfzUOtIQmUdE+LboIj76kKGstVwhZDGshP+c6C7yq6s6LfnS/EhcNjH/YM0XYv6F2
 9gIySM7b8Z/wCOwD4UcrYP8AEnrvLpDOE1Svoq/tiZXsFKehLtPjgqz14AZbnRg24jdfG4X
 Lx6SvrKDdPvtUGAXuy05A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C+V5SccPL8g=:cJ8UPJXJVAOpQ1slLldsJm
 PCD6gyMMm+A1ha0n8XCPlc7RIYtRzd5WQqvU/uziQj+KwkwTAdbuwMKSx0sCdYu5lMzRP7TNC
 OtkxXBMYuIzw9uoHMcRuY1GaDgtAaAFsvAImV76sjx/la3ypxeP9wGImuq7sNxbgoHa4y2470
 TESq//dRZkAs6l1mapObxAyHzHydDiq4vErCTRBwXC/piwZus+KoP8n/cTt7Ei6V4Czw71Dt+
 UW7YQpykjlmfRBhiR9TWJsUJXSFCQ60SykBhEJoviloP1rDDVcf2HbLvVl1n7UefEXazjJYz1
 jTDRjtux3Dm4xxhXS9Osxg6XgjvEiTV/2KTUuOSrmRJPc1Wd/zVAS25lL3/Kf9KK5niSi0UaK
 a2NDfO5/0OihUPw0tgw5L0Y+hJCJoA+qVKa0oGU+xrPriDSHPwuCvsld76zEqc1aRv7rH4/cp
 zTXRaZjfvEtTvm4T1Tfjejjc9BNMXQvoQv3c11DDzD1rSg2CrywrOrvgPbQbNvnA20JRJ6qUY
 q08XLu6aVnwB4riR5m6JQI3sH1rzmOiyzpAtuTpxpN4oUF0beD97GfUMvRH6+BZQriWrU1PQZ
 uiwHwbqik6cVnZTMirFRafwOCcYNiG7HI1Kql6naygxa9yeLad4A0QDXGSmz4Na/OcTncc2zi
 zI8nZ6KomRmlEBP6iguhLPnUwPbaSF+rJNTOGfUB3LxK1BMC5iR8ydh91TlDktQmZgyKiSMRZ
 zx6p9saPRLnH97S+d3T4/13p2uGwFuqbwVrnsi9lmIfks0UHwxuz9kTZVJJzOletjWWUILqfG
 SaIoDYzQA7/CHPSpgoy+ajV8GFhNN7FBf/6KkYriKVp2i9xgRZLlF5vvVfPt4MEpAqHMnnyDU
 87gpRGhOFxwxZkcgk081wccKfWPos87ILV3ujt+oQxgRJNWTJmR9uVBcUs+LRHBCjDHD67fAq
 0mLQaD8Z8ZVAvUDUNOIxqK8oE+1qw+E+rFEA7Heq9EAyGav7x7qPvcL3C+/l4Pt0/KEcrv0if
 KuF1XQ5EC0AVmiEym+xcahVzck7kR8HsBn819SCIR6islIr0XKzdf6JLQKNUa0RGH0wrzDF2P
 k/8lAzGjYRCEtQM6oPlJj7vLZuM8lLACcPIccfiohiWLmARAxY2/59DtQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/12 20:24, Peter Allebone wrote:
> Hi there,
>
> Apologies in advance, I dont understand how I am affected by this issue =
here:
>
> https://lore.kernel.org/linux-btrfs/20220623142641.GQ20633@twin.jikos.cz=
/
>
> I have a problem where if I run "sudo btrfs inspect-internal
> dump-super /dev/sdbx" on some disks it  shows the BIG_METADATA flag
> and some disks it does not. I posted about it here on reddit:
>
> https://www.reddit.com/r/btrfs/comments/vo8run/why_does_the_inspectinter=
nal_command_not_show_big/
>
> My concern is what effect does this have and how do I fix it, once the
> patch makes its way down to me. Is there any concern with data on that
> disk changing in an unexpected way?

BIG_METADATA is a legacy flag to indicate the fs has nodesize larger
than sectorsize.

But the truth is, we shouldn't need the flag from the very beginning.

Just like the days before subpage, if the kernel detects some thing like
nodesize/sectorsize not supported, the kernel should rejects the fs with
proper dmesg output.


>
> Many thanks for any insight you can shed. I did read the thread but
> was not able to easily follow or understand what was implied or what
> would happen to someone affected by the issue.

For now, you don't even need to bother the flags.

No matter if we have the flag, kernel will do the correct thing to
handle the nodesize/sectorsize combination.

And since there is at least one end user concerning about this, I
strongly believe we should deprecate the flag, and make it disappear for
good.

Thanks,
Qu

>
> Thank you again in advance. Sorry for emailing in. Hope that is ok. I
> was just concerned.
>
> Kind regards
> Peter
