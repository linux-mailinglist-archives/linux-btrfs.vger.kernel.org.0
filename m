Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5824C286B
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Feb 2022 10:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbiBXJpr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Feb 2022 04:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbiBXJpp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Feb 2022 04:45:45 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1266727DF31
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Feb 2022 01:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645695911;
        bh=5jxb3eiKieHDJtPb0qAXvo68pKjuuraujiZ7MgnROZc=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=MW8jxzZccJ8Eil8DgC7Tw+Yi6OdkTi6huUjbmkBCmmtBEdi8T7PVC+s1lVQyy628u
         ytBJVYutrTzMSLJAeh+MNu+kL7doXlRllHY8jWms7913TqmfechR9zVg+ifFFnZj4T
         Aj2brX+HylylkfWkuy3moJBzBKbkxQS1+lQvsbeM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MA7GS-1nXf483Tic-00BdQp; Thu, 24
 Feb 2022 10:45:11 +0100
Message-ID: <d760d854-b3d4-6118-9b8d-5b1e775333e7@gmx.com>
Date:   Thu, 24 Feb 2022 17:45:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 3/4] btrfs: autodefrag: only scan one inode once
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1644737297.git.wqu@suse.com>
 <7e33c57855a9d323be8f70123d365429a8463d7b.1644737297.git.wqu@suse.com>
 <20220222173202.GL12643@twin.jikos.cz>
 <64987622-6786-6a67-ffac-65dc92ea90d0@gmx.com>
 <20220223155301.GP12643@twin.jikos.cz>
 <64e0cb5e-c5f0-a18b-1aa2-3aced6bb307c@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <64e0cb5e-c5f0-a18b-1aa2-3aced6bb307c@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3OuYi900X2RT5jNPiPQ8YYjV3LjUGaqkONWFhyLrP8pjxGyN/6z
 5IHjtf5TrMCrfuuyjXlSkWIgsXyB7pVc5SgdbR9POO+sZshI/gqX0bPOAnSuagPJ/tJWRPA
 I+RaNARrhx9GGssZsq8AY1oMCsl+Sa0O2u1t9veCE06qwgMNdMu3A4w7CM39ZGlS7PaO23a
 c1Bfy6hsw4Et91J5kRybA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8DXtCALpiE8=:GG+F/AMYSmmtNZc0yLqn3N
 AHKPGK150HVIq2WO7JtZaCE/+56TrYrNhZ09uO+PpjOIPqNOLi/buEWtlDzl54soSJA01cWTS
 ojlVm6nYShDjFmzlhCsE9vKpNTqZlkmo3yjvDa6FjmMCs8E7t3FJjcEQzRM+Paiz5ZYcyV9UI
 xrC7sSGuo/fopa24etJkK6vwgB2vmfpJ+RG49qJ/xqa15yFjaQZuYqnwWnwybcvoYy7rP0NZM
 HyVJ4VJqce+W1y7Oc87BeS3vI+tJwwQrBfUUd10wSG/SXr5m+ZIa9+Sm4AZW2C3rtjUoc5Vjn
 FQea49RTlyZBJvFpA1xWsV5JY/CClXQUSYFUupfpSK+UD709x/0p0x9OPhg+76XKU0g47Dx1d
 qVygI1GcgZsd6tVS/Aqkx1g2DmHk+/0Xndy518jlrs/VHDXWM4IR3Le4zHIGaZueOANoJ6/F5
 EVT7iicNFB1he44NWZESmPvAK3Dph6EiT1TMzSkGt3/GP2Dt69c6X6A85KXwdMO0ypbFgIB3O
 YVD+xhyKevp4R1+IKkTr37mD5IW1McXLGx6vH6Pfpo5gk5n3I9J7YqgkP/r0GoAb+4enWV33H
 lk4bJOgoDBRtMcK50VS9PQptNxUIVhLqaDCLSm6HrUp5mEOAls5qf731TnluIw7wQX5lPZihs
 u2APmsaBQ6zT/a3fzAagtoxbxX/4LHjF1EIHqAorHgWtgxpQGLiHiRFCiv8K7hOPVGRcIRWss
 xWCfHAv/gV5trgmH9Q+pvVhg4KcZJj1FqqkWY4KS7VVb8o2JB8s0n9Qow4ICj2l5+ZfAdSKL9
 onlwFRPGCfCutWsZ4tBIsoqZQwi6YoFZcVYEm9vE/LE0FxMlRHXj5rGlWNVMJcMGRl9kaoOcp
 kchW+5L5q+rfjx0lLZpL0bOxJlADaLK4WrlCxLfpNju/JzQGwanWaeo5DbNZAlj+r2eTMEqli
 9PtDX8QHv6Zbb259zFvsUmAXTa4yHsaMabgk989LhAlHZlWoepMiyEzBW1Wyp5e8t6+bZsmeR
 kvDEiUcz/uzeooqQwYcq02xDJHuFAk3Z99FFCtx7C1jMqPfEcEewcZBHa6b5OQJTVS0vrXHjQ
 irWWhFC7gfcSQo=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/24 14:59, Qu Wenruo wrote:
>
>
> On 2022/2/23 23:53, David Sterba wrote:
>> On Wed, Feb 23, 2022 at 07:42:05AM +0800, Qu Wenruo wrote:
>>> On 2022/2/23 01:32, David Sterba wrote:
>>>> On Sun, Feb 13, 2022 at 03:42:32PM +0800, Qu Wenruo wrote:
>>>> @@ -295,39 +265,29 @@ static int __btrfs_run_defrag_inode(struct
>>>> btrfs_fs_info *fs_info,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto cle=
anup;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>
>>>> +=C2=A0=C2=A0=C2=A0 if (cur >=3D i_size_read(inode)) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iput(inode);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>
>>> Would this even compile?
>>> Break without a while loop?
>>
>> That was a typo, s/break/goto cleanup/.
>>
>>> To me, the open-coded while loop using goto is even worse.
>>> I don't think just saving one indent is worthy.
>>
>> Well for backport purposes the fix should be minimal and not necessaril=
y
>> pretty. Indenting code produces a diff that replaces one blob with
>> another blob, with additional changes and increases line count, which i=
s
>> one of the criteria for stable acceptance.
>>
>>> Where can I find the final version to do more testing/review?
>>
>> Now pushed to branch fix/autodefrag-io in my git repos, I've only
>> updated changelogs.
>
> Checked the code, it looks fine to me, just one small question related
> to the ret < 0 case.
>
> Unlike the refactored version, which can return < 0 even if we defragged
> some sectors. (Since we have different members to record those info)
>
> If we have defragged any sector in btrfs_defrag_file(), but some other
> problems happened later, we will get a return value > 0 in this version.
>
> It's a not a big deal, as we will skip to the last scanned position
> anyway, and we even have the safenet to increase @cur even if
> range.start doesn't get increased.
>
> For backport it's completely fine.
>
> Just want to make sure for the proper version, what's is the expected
> behavior.
> Exit as soon as any error hit, or continue defrag as much as possible?
>
>
> And I'll rebase my btrfs_defrag_ctrl patchset upon your fixes.

OK, during my rebasing, I found a bug in the rebased version of "btrfs:
reduce extent threshold for autodefrag".

It doesn't really pass defrag->extent_thresh into btrfs_defrag_file(),
thus it's not working at all.

Thanks,
Qu
>
> Thanks,
> Qu
