Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45ACB5339BF
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 May 2022 11:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiEYJQK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 May 2022 05:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242146AbiEYJPI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 May 2022 05:15:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DE991577
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 02:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653469995;
        bh=6pb+DKeZYYP0+/t4VPkVnME8IJO/L7HTIwWHU/akKX0=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=bIpZjIqBU3cGhOOiQXD6hmfanUTB/K2QpHgKBE8QGzgUUaVsMDK313fwjLxKwWCWW
         LUxtCMcDFIS5yqgJmdr9iccsun/gaGyjZew1XCuL2cDQjxF46zydZB5jefmqCDDlt3
         tjsWIn955phj+XwHf5M4/6+TpRh4cg+LBW1F9s94=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M59C8-1nsh9K3EBw-001EdP; Wed, 25
 May 2022 11:13:15 +0200
Message-ID: <bd6ac4d4-41bf-f662-e7c0-7841895554a6@gmx.com>
Date:   Wed, 25 May 2022 17:13:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <f6679e0b681f9b1a74dfccbe05dcb5b6eb0878f6.1653372729.git.wqu@suse.com>
 <20220524170234.GW18596@twin.jikos.cz> <Yo3wRJO/h+Cx47bw@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
In-Reply-To: <Yo3wRJO/h+Cx47bw@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Sg5l6w7pBSYh4SjHiMhlltJAlpEim6E6uJnKbFYQptlF6Y2V7Zz
 5kiSloIB6PSQvG7J7QMUfgYCwKikRfeX2FriMttuFMrtSNOh19sI5Z92zd0ecAcYTyVGIA7
 UnpiMnm25oIa00/c0psSWdjgQ1x5KHqdKiJntZT9oqYIFeb+hW7r2aq5UV8fi6QLNz16l2J
 fF2B7dbg27S3usyE7Z8YQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Hg6CSOnMQX8=:0/N7lQaYzvGoed0LdGGcWr
 Kr5euTQIcizQo7vrtrUwCZoIqRlRXHWG8XLMOQp+9YS2J6sAAPdLhG8dIGHpXcBmBLZUOrK+4
 eXqz2EmHzFpVgUxqHBLxcXqNtmri1hSLbNOO6MoH9HClb8hr4PP4pwKlAzjL2Hh4tEgswqpgr
 MlFusVwERwo7CUzKdReVNXr2YLnNwNRs+wQfqwHQLoliBmRdmRVOkqyrC1SnwT1f2NtHUZcHF
 XrlS1nEDnSzbzL/SBzGPm5SCABjX0VxfVPcU6Ee2JRV6AM5hCKW28d3leVg4hmo3pFOdUvc/u
 zgmnZCragc07dHU4x7+wGnsp60SQS/iJsI4+VIjy7pWDIGarEwrXJ8XYRQVsLoOGVd6/qOpBb
 x9GYQXpSslHR0ScGbSfPKa5mLaMBD+a7IiVotO80oz6Y+KiBRCObuMZsfa4lxNxco6Bl0V1dD
 tJj61toHdFYrCuNNtYl0BoWF3MEhtwR5P+WtY2IoP/2Xrbhfsyq9k8Ajqf0hLc63XAW4L0cgY
 DCKed/P88NQ3Bk7Tt4/FEdp3dSf+sC8jO2PRltFydUibwJBfaMSpDvSz5FbwUQ5mqDPhb5QI0
 Eql0BBM+H9XlSvh7xfeBjj95qq/fLyriksLt2WQXEJrCeYZlzhRJAc/uYtWN88v64nrED4vnF
 IKU04foIdNLJFTJJ3bI9mJuCV1O/cvqk8WwA6K9HhQD/P7P3eXYJ4usV29Tf8tJNqdGV+kPbg
 id7xBnHDqf+dE8glKLzjkIi5AnGcdGlm2cNIuil4dA/RrUt0ql0ZgaN7brIiWGJIC92FuV/mb
 d59uMs1xupnCGz1mJbE11tg7xxk5ovXJ6jQpRNYB+p6SrlFUkv15xJnDERwZrW6JOIS8O89q4
 EvJGwC5yboEaEuwwd6risJ5T4uI8Ym1uvQQ6yS7a3Wl8X9ZQE69Q4EMpAJrnR9g3gptKlr5ou
 WYpqccmQC7bZMGFKt8+IzYyDX7tY1bp9oEFNpUTwaew6kcMfoMcglj86/mcjq4FANVtO9Weuy
 r1iZFyPtdinxJSTrIY1scUjmuwzClfHPSidfL8svXpsqi4wGncXTi0fFSMz7zoqITzEBfnRGk
 jfJq4CC/7s9E+SUlAMAAXfh+i6H/UePWwfkQ/bk7ylyDACeigrHCLgLwQ==
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/25 17:00, Christoph Hellwig wrote:
> On Tue, May 24, 2022 at 07:02:34PM +0200, David Sterba wrote:
>> Well, that does not sound encouraging. One option discussed in the past
>> how to fix the write hole was to always do full RMW cycle. Having a "no=
t
>> fast journal at all" would require a format change and have probably a
>> comparable performance drop.
>
> So maybe I'm just dumb, but what is the problem with only using
> raid56 for data, forbidding nowcow for it and thus avoiding the
> problem entirely?

The problem is, we can have partial write for RAID56, no matter if we
use NODATACOW or not.

For example, we have a very typical 3 disks RAID5:

	0	32K	64K
Disk 1  |DDDDDDD|       |
Disk 2  |ddddddd|ddddddd|
Disk 3  |PPPPPPP|PPPPPPP|


D =3D old data, it's there for a while.
d =3D new data, we want to write.

Now bio for disk 1 and disk 3 finished, but before bio for disk2 can
finish, we hit power loss.

Btrfs reverts to old data, so we should still only see D, but no new data =
d.

So far so good.

But what if disk 1 now disappear?

To read out old data (DDDDD), we need to rebuild using disk2 and disk3.

But please note that, now Disk 3 has the new parity, but disk2 is still
old data.

Now the recovered data will be wrong, and not pass btrfs csum check.

This is the write-hole problem, it's not screwing up all our data by a
sudden, but corrupt out data bytes by bytes each time we hit a power loss.

Thanks,
Qu

