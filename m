Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC4D5F8AD6
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Oct 2022 13:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiJILOI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Oct 2022 07:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiJILOC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 9 Oct 2022 07:14:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092582AC55
        for <linux-btrfs@vger.kernel.org>; Sun,  9 Oct 2022 04:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1665314036;
        bh=vDLvKvUyyMn/mFvj/CNNwLGX9XgH8lrw41ie23Jux8M=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=S2W0uCk86/VsScVMmFpaI70KulAWvIb6DmzIgIHc/iLOq0eRbLiPXCf39wM2VR7xI
         Kqbli0XFfxzhu2wBFZUW1gOCr+TMVOC+Qn9i7WtYHCAeOkXabti0Jc5FSDkMhh3hq3
         H9Uu3E7hQ1cETY1ZjjYxJQ6rO+AEBGX9jPvS25E4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfYLQ-1pN9f10w2q-00fz1z; Sun, 09
 Oct 2022 13:13:56 +0200
Message-ID: <9167e4a5-252c-0192-6814-da91e3692b88@gmx.com>
Date:   Sun, 9 Oct 2022 19:13:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: BTRFS w/ quotas hangs on read-write mount using all available RAM
 - rev2
Content-Language: en-US
To:     admiral@admiralbulli.de, linux-btrfs@vger.kernel.org
References: <133101d8dbce$c666a030$5333e090$@admiralbulli.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <133101d8dbce$c666a030$5333e090$@admiralbulli.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cXHhavG6sl0grdeDZeYM4arr8qfZGB7h08U6dGpshlL41TFVS5/
 BS1/dWnkH4j2f2zhCe/ID3pDKxaESe4Yf+jBbZaDA87+QffleREdesCWX2kqedCAZAXZl/q
 2RW7yeLT2MY9jGDmqDUV1MUuA1ChzBeprxdzS9su1sptLGN5L+Bs1JUR5DakuMfAPgrUtTO
 rDUoaCSE6qikmckwpuJjA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b/8W8rk4tZg=:ho0+ZcOsMjFTnDyJaeuk9e
 iUIyNltQorfrTRITUOJ+kE3zy5U7qwSurvNqe5u3Ng6m85sf4Tgmw3ldnmmiDm+vre3zVkCnm
 ktYpr2zYVl8zWgBEHRvDkwH0V38zQj+yoJVJm1GV60ClLNCi5gVJAI4b/VfSVM4/MlgMcFysz
 uLwvW6ppPl5AjwtpRv8p2gJKcrqI+Wr0sqIKOFznITjqWVN5IflhKWFFCzNwKWw3nP5X51A2D
 hH4u2jG5OPDLhJQogqmFHsdWa04BvIsAf1ADFrUAb7aZvYyUh6ApyWor3VK8BWLYw736d3K0A
 E9izctXHpWaYBE8Dqb22/SUpceEc9uvFkyoVTTUq7+mOFKZhVD55OhvvpN1WkuWrLvT+3Pz3v
 QKK5xV0LEc5vY8+y2kCof3gAtDNCKgKEzAJ93M8rixkfhwqcqmn1fTQJMoN77b5F0JjtrNe6t
 0iIGNHkfTnNOBKt4j0UHeBmHEWllCuBFsjhMBP0S7ROzHwk8bbQpPaNK+cxbcyGUK9buFLlOK
 VtToq/ulsJIt/VNhbgPLvMlewzVSZ1XMiUBYBNYCWMwXCx0xDClvygaHm93WDhSag6iUbs2F3
 RwG40pz83JKyG/pgJF7obTYerwxpB69Nq3CwTZiopbeAXY8WqEkLgOcsqL2meZvSEdoKRM3NV
 H87ae3Ha9D22sq19LFoK0FsMBfDsbaWz5LrKNMT2pTC6j2ucWgxoIeIo6xzvI1FCYTy37pGSt
 /9dXCDrWm60KPd6pMT/1o2lQCpc/hZ/cvB3B/BcHDFuV3Xq9a8CodjeMQRJIwI8Gsz/xP1ZGw
 VKXyjkvwSj86P0gNHo+hMheeEBySiOzrS/5kUnCEHgd3bvVM9U9a7qngVsca61bVmbVYLomRM
 w5UkDUHZ8xmtiYtsxyK5HpYloAofZ8p+XevI8RurkIsFvpscjZ2RWe3C2nQllsrnqVoVbxV/p
 wTVO+LdWZJUG5hoaLOLpBb0FdaQu1NWgfx0qiUg3unU2e4oQp4B7yDE3MTAEIL16TrtIemDrw
 0+o+KOD5rJIniSzZ841dgCZyXxGrluptQUyI5U/MEAQcgDDK+aDnW951rbMC9ITcNORb1UeGw
 4q8uTsTiYMlrxerkFd7TvsMZhyk4bMStheIc4B1bSHmTxwhqTAtYnmN6s+BBs8RngTlpkhOhE
 VYHqoYItXVLOVJ2en+FXQUDiuzKQ2bTcignnCj+3/bXBQn4mJ15+HAGxrRdLH8ijzzTLcjdXo
 qWaOaBjwES/fzUSdfCLiDWh2hzj/SjPZfTcMWGw1gFF7W6WumPnsBuBFJX/waFvPDr6CQHHAF
 OeM89F8aTkzf+r02VJy1SDfhhbikoognomCczFT7ZubH5WvXQER+eyRS9kDjpOKqb0/fJK6zD
 jdOZ+0sBX4XvfHWglmpRE8IlM0DygG8L45HnLdOZluM3054IAZS5RmT300MTGmp3e0oNB/xiv
 cxMMHcJTHnTcu/RY0S8/xdKVpD+PLhXtxF56AcnmQ497C4RFDhumpjmrVn67hjF4prGyMDnHf
 ZIsxWgITy6B/b3+vJDIc+h4iawWugUUQb2EH8rtVnCWlh
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/10/9 19:03, admiral@admiralbulli.de wrote:
> Dear btrfs team,
> thanks for all your great work!
> I have been running btrfs now for several years and really like the
> robustness and ease of use!
>
> Last week I experienced 99% the same thing as described here by Loren M.
> Lang:
> https://www.spinics.net/lists/linux-btrfs/msg81173.html
> only difference: This is not my / but a 40TB storage mounted to
> /media/btrfs1/
>
> quick summary what happend:
> - enabled quotas to better understand where all my space has gone
> - started balancing
> - system got completely stuck due to the meanwhile well understood reaso=
ns
> - pushed reset button
>
> I can mount my btrfs system perfectly read-only and access the data. As =
soon
> as I try to mount rw, my system will exremely slow down, memory will fil=
l up
> until I will finally end up with a panicking kernel.
>
> So, no problem to successfully boot with the fstab entries on ro or
> commented out.
>
>     admiral@server:/$ uname -a
>     Linux server.domain.loc 4.19.0-21-amd64 #1 SMP Debian 4.19.249-2
> (2022-06-30) x86_64 GNU/Linux

Your kernel is just one version too old...

In fact, v5.0 kernel we have introduced a lot of qgroup optimization to
address the slow performance (including hang, huge memory usage) of
balance with qgroup enabled.

Although that optimization also introduced some regression, all the
known regression should have been fixed and backported.

But for older kernels, like your 4.x kernels, we don't have the
optimization at all.

Thus in your case, you may want to use the latest LTS kernel at least
(v5.15.x).

Thanks,
Qu

>
>     admiral@server:/$ btrfs --version
>     btrfs-progs v5.10.1
>
> Here the question:
> I am looking for the option to disable quota on an unmounted btrfs like
> described here:
> https://patchwork.kernel.org/project/linux-btrfs/patch/20180812013358.16=
431-
> 1-wqu@suse.com/
>
> All my trials and checks et cetera were performed with btrfs-progs v4.20=
.1-2
> as debian buster's latest state:
> https://packages.debian.org/de/buster/btrfs-progs
>
> I already upgraded the btrfs-progs to debian backport v5.10.1 but do not
> find any option to offline disable quota, yet:
> https://packages.debian.org/buster-backports/btrfs-progs
>
> Can you point me some direction how to move forward to recover the btrfs=
?
>
> Thanks a lot,
>
> admiralbulli
>
