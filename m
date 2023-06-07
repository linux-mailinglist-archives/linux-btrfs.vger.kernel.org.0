Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345C0725CB1
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 13:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240187AbjFGLHd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 07:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239885AbjFGLH2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 07:07:28 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FF21FDD
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 04:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686135991; x=1686740791; i=quwenruo.btrfs@gmx.com;
 bh=lhC46jKLRo2ww++Ujr52UmJ24gIBz0t2NyZgaThW6gY=;
 h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
 b=bTcUX6/iPyeTFNunGCue+o6qBbwQ8IcNQuR89Epqa3XZejBFJYz1lDadNmcHOK2E9tabyGE
 5Bl5oJLC3Vx3onpHfr5zDtnuGr5Wf+72SGaIq73I6GyJ90kyt8bh6yor7ODINtCohYCm9rXs2
 ZtGIxxIDVjmx1seRhg/lTXkSl0OILG7ZnB9nbAt7n/KundIZDFQmbyXMhIVxlAup+ZqNFRf73
 Drko/Pw2CblZYW49z3893xcThXqKMZYqu+iAgUeAwCr3yuLiSTblJv1agM4kt8toMtWESia3l
 wu6zuZ4fDNTCC7QoCbtuzBbTEPtrQUief25GOJ3tT9SYbWaN/WYQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MxDkm-1pvwsg49O4-00xblJ; Wed, 07
 Jun 2023 13:06:31 +0200
Message-ID: <89e1a74a-e8e0-ea44-974c-ac8877caf549@gmx.com>
Date:   Wed, 7 Jun 2023 19:06:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1686131669.git.anand.jain@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 0/9] btrfs-progs: btrfstune: accept multiple devices and
 cleanup
In-Reply-To: <cover.1686131669.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mXE3UCnchoTn8T+IKlzcaDQwBsHJL7MActL5EkIvvP/LEdrQi5m
 wDM8TK9b1lwnKE/2EEHMVm6ui+2cvDMH0hKC9ljNaGl/6mtjQyvDWa3bH6OpEeTgasXQLE9
 pgwRQNP2+JeFQ4LFugOge1pGgseTlafbuPnINfou3koQv4o6FDNyhoEvi8NpMBIy39Kddw1
 zeAsjAd14X6CMgPpi7C6g==
UI-OutboundReport: notjunk:1;M01:P0:XCY4aTSdj38=;nGReV/bpDhr9qzSvDTpu/Nyyq6C
 p5TGhBTTKIswUG7xIrGcP/ovi5HXVBBk5kpla25tYdICPkS6MrkfKBj4RqZNYH/t3yJjn4lge
 s4Whm6087i5mEV8aBCQwWK2lyfUyWtzZAeccsl1pQebRWQD8vYyJrB1gF7EivhY/d1q7hPbY0
 zmG80+E7O8dpafCRMA9vGoKMloTtOr3fK/C1kwov2I/8560lMVBMsM817tUPc00XaACYeuQAX
 pywmiB7YF4Fdtkqq+S7JdYzMfaR/mmGmZWVVsYawqoWSnogJfnnKugSEPZOlWoVBq3CEA+ZKN
 TWON0hXAuh193RdxrP/0ljVISBlAu/aFiwhstPqYPpEslwXAe88NaI+1q0VZbv8GwAMrcbJuG
 Qul50Io6Qf/2eay8RkqSPpeI7CC13ommREjS2QOfpereHdB5QYMuI4XgrxJpSXuGlj5r8dPqn
 LrjJgMu9sJT5cjCufLZPiwoPv0r8hmEmaGljxYEU/Dt5k45PI5wIeCiEBEi/QV4OpNg1xpPhI
 FWLqjWGUjQwR/jzcRcgr06Fitgh9cb92U7RWNNUFo8LLc4kV4q1MeHzlbFEMNxePBHpOP5/ba
 IJOhlkio9KEwun7af8AvkwoM35OD4lYeDDQMBEUKKysxhk//E3yYiGv/3UadMV2gGCB6yPyP2
 Gyaupm4vWQmNxT0flJ+seUk7a3EUPfaqgNVmDr1IoRju6sNLiKP9TsQblJnUC1rwxoc7faHpf
 v3vejbj6fYL445sxalEfVAQ5QUihAetza+DOo8tXhfPdpwUycQX6VnJkLIRMn6LLVUURFnesw
 VLwqmlO+j8QZ4IY3MC9s3czqhxPtlijiZ5e48uuEwWYiDP+bohaWO35k28KTE+EcLRK0WXEMr
 bs0ypmqsz05JNpjmrx2gJUeIV3vi25VUjt0z3BKXp16dFJjA3djCZuFPDCI5vPMBOx55cE3zC
 nXERTxY8I/JymZTmLdji3tyqRrw=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/7 17:59, Anand Jain wrote:
> In an attempt to enable btrfstune to accept multiple devices from the
> command line, this patch includes some cleanup around the related code
> and functions.

Mind to share the use case of the new ability?

My concern related to multi-device parameters are:

- What if the provided devices are belonging to different filesystems?
   Should we still do the tune operation on all of them or just the
   first/last device?

- What's the proper error handling if operation on one of the parameter
   failed if we choose to do the tune for all involved devices?
   Should we revert the operation on the succeeded ones?
   Should we continue on the remaining ones?

I understand it's better to add the ability to do manual scan, but it
looks like the multi-device arguments can be a little more complex than
what we thought.

At least I think we should add a dedicate --scan/--device option, and
allow multiple --scan/--device to be provided for device list assembly,
then still keep the single argument to avoid possible confusion.

This also solves the problem I mentioned above. If multiple filesystems
are provided, they are just assembled into device list, won't have an
impact on the tune target.

And since we still have a single device to tune, there is no extra error
handling, nor confusion.

Thanks,
Qu

>
> Patches 1 to 5 primarily consist of cleanups. Patches 6 and 8 serve as
> preparatory changes. Patch 7 enables btrfstune to accept multiple
> devices. Patch 9 ensures that btrfstune no longer automatically uses the
> system block devices when --noscan option is specified.
> Patches 10 and 11 are help and documentation part.
>
> Anand Jain (11):
>    btrfs-progs: check_mounted_where declare is_btrfs as bool
>    btrfs-progs: check_mounted_where pack varibles type by size
>    btrfs-progs: rename struct open_ctree_flags to open_ctree_args
>    btrfs-progs: optimize device_list_add
>    btrfs-progs: simplify btrfs_scan_one_device()
>    btrfs-progs: factor out btrfs_scan_stdin_devices
>    btrfs-progs: tune: add stdin device list
>    btrfs-progs: refactor check_where_mounted with noscan option
>    btrfs-progs: tune: add noscan option
>    btrfs-progs: tune: add help for multiple devices and noscan option
>    btrfs-progs: Documentation: update btrfstune --noscan option
>
>   Documentation/btrfstune.rst |  4 ++++
>   btrfs-find-root.c           |  2 +-
>   check/main.c                |  2 +-
>   cmds/filesystem.c           |  2 +-
>   cmds/inspect-dump-tree.c    | 39 ++++---------------------------------
>   cmds/rescue.c               |  4 ++--
>   cmds/restore.c              |  2 +-
>   common/device-scan.c        | 39 +++++++++++++++++++++++++++++++++++++
>   common/device-scan.h        |  1 +
>   common/open-utils.c         | 21 +++++++++++---------
>   common/open-utils.h         |  3 ++-
>   common/utils.c              |  3 ++-
>   image/main.c                |  4 ++--
>   kernel-shared/disk-io.c     |  8 ++++----
>   kernel-shared/disk-io.h     |  4 ++--
>   kernel-shared/volumes.c     | 14 +++++--------
>   mkfs/main.c                 |  2 +-
>   tune/main.c                 | 25 +++++++++++++++++++-----
>   18 files changed, 104 insertions(+), 75 deletions(-)
>
