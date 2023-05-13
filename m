Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B775E70149D
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 May 2023 08:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjEMGcL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 May 2023 02:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEMGcK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 May 2023 02:32:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CF62D48
        for <linux-btrfs@vger.kernel.org>; Fri, 12 May 2023 23:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1683959518; i=quwenruo.btrfs@gmx.com;
        bh=MHhGFH9XrWNL4rq/eGGoycUFIt5QimEILa0o9kluOkY=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=e1WUc2z5UushdIn4cqEIUBZx6oYlN0VAbXmQQikXyYeShgVIVwxFVeq8UwOWJYmfL
         m2/s+vX5lGn5rwoJu9GZy5mnM/s7/m086pKkUO1o1qv3pP+HuP4n8KQQq3Kj/8O8v0
         jfKW/0n0fhschQBPIderx7dNQoiBh6/qg7H5QnjcmhIiJlfucuQwgoJOR4zftM9ow/
         4wr9nzfsVrpkEhcc9g+4NL/tFniX0jQuBaJjvuewK0X/LKNAATQTeI4XplcW+LLL6j
         nDEFZHq07R2yWiffPPfpgCgmsZwkOi1DzflivTHDVrpinGZy+D03gUSdMjWXRgWsT6
         c9B3A/Bz2NIrw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M2f5Z-1ptaC23GON-004FZy; Sat, 13
 May 2023 08:31:58 +0200
Message-ID: <7f0d127f-9295-39dd-1b3f-6124544a7bb0@gmx.com>
Date:   Sat, 13 May 2023 14:31:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1683075170.git.boris@bur.io>
 <7a4b78e240d2f26eb3d7be82d4c0b8ddaa409519.1683075170.git.boris@bur.io>
 <c10a17cb-506a-2540-eb19-c79c6c00f788@gmx.com>
 <20230510165705.GV32559@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 3/9] btrfs: track original extent subvol in a new inline
 ref
In-Reply-To: <20230510165705.GV32559@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dhHsdkNQZnRv0v3x1zSoVkDWxRfAwDdK53grHDyvuv/vUacnfXu
 F12ubh8u0k0a+1lvu1ih02dQ6Hrxm0c/XqfR1kJFxCdX6r5Hv2NLq7R5KJvUSoeShkQD//0
 BWAQSLK7NE0XhQN+yWlIwinJ0UeWjMUEL1NdIol9JK3aSeal6d3oaXbwwFRKbM1lyVHpa7/
 Qzp3rlTMhPH6rXQb0jvvQ==
UI-OutboundReport: notjunk:1;M01:P0:1CGHP6CXgjA=;obXi2cMgxh3+4pnAlPvqy1CFqat
 ysLI/OKw3szrLGvDVl3YpA94jVj34w89lpDDUvV8Mk2iMSfvoJv4Bw8Wob3CP1CCKHyFSPOFS
 4vlvizziu9UELMyhfJV+brGOodQeeTRBf6jR1PmU8SKZH9bG3l0j6rGTLmM6cEWszPb9ciJ40
 KALftHNN/+gLWGLxSYx8xK3Cb4Tob3VJHEQ66HDjwiRYMlHuiDciacu8ZOVCR+UpFhA7VTJFO
 uzxyWAYDLBD22WCGI1ji+06sQEOUEUVyUmNYsbXnythx+YYHgE4aHNzNMlJT3Gy3uumQqI1+3
 JB4GjSkIqRbDO1wjFq9zkMmrxsHzdGiQZ6ql8n7yADNdp+0osyazAWSvuXSuskgJMKUs68XKj
 v2pL7RI0BShn5zp/DgnAQL0iQHB+9vW+ZSfi6CkQbFzvvsOvZX7zJf8p2VjG/6VWXZlAXYJeO
 AuvVjY8KI8DcVWHwi/5JGGQ5kNS9yOuxjIEPc4viw/MENn54rXsgF83NZOogHWYoDNK7QMFL+
 H3lVz+mnsIOBQ8CZ3aSZzvDx2jEUNdfHMJhkDDpAi3sXVu1pOIlrpEaBwPGi1MRAyDfn9zb1j
 x4cQVBj4qXM9d6xXxrFVbVuNSjbJNJQcMCzeApVrkFf+gDoO8gbHGxYJIMWdr1eyAUhtyL+L+
 xybaEMUMKHub2RLcpGT8gTOJ0kKxKPlJlWywYbejU0z7+gSZRuVr5J02XpbPoMzNYwDfeIR5v
 RsMpyQyIyZ6AHNQG3jZ2xzSZ2CPtuywIyL+NB794rmbwMqLHJUhJN1Je/ZGgkdduzrGO552Y5
 oCVY5qPgojBMzxzFuEiJdCnWjhzzPIJgLT6fE2Xx3QjbUM2OHXU4PJqdH1l+PxJfxcre190b3
 LdOQ8HQDFuTCTQupJu/FmseZQHEtda8Napq9LXkrcbs73AklPu2G7r6SmLJWI7ltKSg2vVejE
 YgrJ/sFDbBgQZNVCqKtc/1jJwN8=
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/11 00:57, David Sterba wrote:
> On Wed, May 03, 2023 at 11:17:12AM +0800, Qu Wenruo wrote:
>> On 2023/5/3 08:59, Boris Burkov wrote:
>>> In order to implement simple quota groups, we need to be able to
>>> associate a data extent with the subvolume that created it. Once you
>>> account for reflink, this information cannot be recovered without
>>> explicitly storing it. Options for storing it are:
>>> - a new key/item
>>> - a new extent inline ref item
>>>
>>> The former is backwards compatible, but wastes space, the latter is
>>> incompat, but is efficient in space and reuses the existing inline ref
>>> machinery, while only abusing it a tiny amount -- specifically, the ne=
w
>>> item is not a ref, per-se.
>>
>> Even we introduce new extent tree items, we can still mark the fs compa=
t_ro.
>>
>> As long as we don't do any writes, we can still read the fs without any
>> compatibility problem, and the enable/disable should be addressed by
>> btrfstune/mkfs anyway.
>
> There a was a discussion today how the simple quotas should be enabled.
> We have 3 ways, ioctl, mkfs and btrfstune. Currently the qgroups can be
> enabled by an ioctl and newly at mkfs time.
>
> For squotas I'd do the same, for interface parity and because the quotas
> are a feature that allows that, it's an accounting layer on top of the
> extent structures. Other mkfs features are once and for the whole
> filesystem lifetime.
>
> You suggest to avoid doing ioctl, which I'd understand to avoid all the
> problems with races and deadlocks that we have been fixing. Fortunatelly
> the quota enable ioctl is extensible so we can add the squota
> enable/disable commands and built on top of the whole quota
> infrastructure we already have.
>
> In addition the mkfs enabling should work too, like for qgroups. I think
> we should support the use case when the need to start accounting data
> comes later than mkfs and unmounting the filesystem is not feasible.
>
> This also follows the existing usage of the generic quotas that can be
> enabled or disabled as needed.

BTW, if we go ioctl method, there may be more trade-off to do between
dedicated tree and inside extent tree:

- Scan progress
   If go regular extent tree, we need to update quite a large part (if
   not the whole) of the extent tree, for both enable and disable.

   If go dedicate tree, it's at least less large as the extent tree.
   For the item space inefficiency, we can pack several <bytenr, owner>
   pair into the leaf items, a little like how we handle csum items.

- Subvolume deletion (without any snapshot)
   For regular extent tree, it's less a concern, as we need to delete
   related extents anyway.

   But for dedicated tree if the subvolume is large enough, we may update
   the whole dedicate tree in just one transaction.
   (although it should still be smaller than the extent tree).

- Compatibility with extent tree v2
   For regular extent tree, it's pretty straight forward.
   But for dedicated tree, should we split the tree?

Thanks,
Qu
