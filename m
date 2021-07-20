Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C313D04B5
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 00:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhGTVyY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jul 2021 17:54:24 -0400
Received: from mout.gmx.net ([212.227.17.20]:37623 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229816AbhGTVyE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jul 2021 17:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626820462;
        bh=tELGuQdg4/h9VREKGzm9zcDdkAhaGb4w5RNCgORaigk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Pn6ug4vbU5Uup6ga6336z5xH/P1i3JnUYAVHfS+8gaaEr2dkhyaBvHOgYieL1QxNQ
         dxdisNmKYLNykjrAQU50g8X2GXwxTO3/DX9at/TMgRF1u66L4EH/OFeElrdzmAh+8/
         wgwmU871dzuiAR7/OUUbCeW/tfPIrXIYQ/RBSOtQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MeCtj-1lUyny1VCh-00bLeh; Wed, 21
 Jul 2021 00:34:22 +0200
Subject: Re: [PATCH RFC] fstests: allow running custom hooks
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Eryu Guan <eguan@linux.alibaba.com>,
        Dave Chinner <david@fromorbit.com>, Qu Wenruo <wqu@suse.com>,
        fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20210719071337.217501-1-wqu@suse.com>
 <20210720002536.GA2031856@dread.disaster.area>
 <3f2d4ebd-bf75-b283-45be-3fa81e65d5bf@gmx.com>
 <20210720021437.GB2031856@dread.disaster.area>
 <cb2bf09e-91fd-2976-4366-4daf29664890@gmx.com>
 <20210720064317.GC2031856@dread.disaster.area>
 <20210720075748.GJ60846@e18g06458.et15sqa>
 <3fd6494b-8f03-4d97-9d00-21343e0e8152@gmx.com>
 <6b7699a9-fc5e-32d9-78c5-9c0e3cf92895@gmx.com> <YPbt2ohi62VyWN7e@mit.edu>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <f37bec82-85cd-b818-8691-6c047751c4a6@gmx.com>
Date:   Wed, 21 Jul 2021 06:34:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YPbt2ohi62VyWN7e@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BMigt9LFwlJ9Yd3EqSipFidOpKxxWg1h532AxHCMPwKa5ICXRVq
 pWnXCXO+mqMzceDi8dpxr6EOpJ5Gs9ryP7hXEDGwDAi/hinNGlW9zeXlA7DYmIYkwDn+AbJ
 eUwKSNt5dpYfT04afj9t7Ai6gmcA8tPdBgT9YqK4kHZjrSvBHmT/4a+ks6Bc/KxFyE013xE
 EBraiDhszgTvjxZV29HrQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:T2RsIRwNdcI=:mMF1bU+9EwGlEhD8ta0Tw/
 xQcIMPmBJ88mJu2+8bHnJqEqOi+LeOYLpsjAsr3WDg6WrtNB9xUZgN0h972p2aooUyyNbIhqm
 uD3tDHZxKd4mdW3Z7gH0G6HK+WeBIgEt0Y4qc+xtBS1j4N74rWZelH5Rqje+EYBzd8fb69knB
 RdgpRWtpJtLrR+K7ckXDO5lkXcOyHS+Zt+BpAaft4U3WFXEWuEe5GlVwWfEGlBYLxNI8d+vVq
 obj0YciZ2gjWoobCZBSe20dch34gJU4DViVZjvOH3dfyDUqIqNRdWFMtc5u6Ddst45+teJyXL
 jEPwInJVjDHIaGLVb7Ch3yV7U+xLgKUTeDBn4dzR9G3F4AXXRNG4AZiI0WaC/8y6iGe+CqKuU
 V2v5BckMDplNoBEwweVa6Ge5VvJS9QzIfJpJO3KLGWUmV5ijeFQKoJ1nmI5q7HcI13xuqpnQK
 2j1uhY5ut3+4JyGzYPLcc9/JcV/6f8zTVf9jdW8KxmJ8WFG9wu8hia1LundZlhgvWNA2TmJ9r
 XuZywQ4eRgMiqDmSA9MyIq/LxhyRx/WSW0lCSv1yYqxMD2egCWVSd2yeli5q7al8FeddlU2y2
 B8+JZhARoo1gC/HNWgjnMfkKRsrPrxRHKA++EhzfQ2G4tJzzYe2HoSYrPodvuaqtu4Vh+5Ai0
 dHq8VS/5ooyHqUWntlwy8Xy4QFu9QIA+MyZt9aJ2cuUFCe30gfSroXu3phxj+NPuurvU7F2U5
 xrC3vAkFTn8NiHyCgNHDHHEhgKZmlcOe1efMiMl9UzCzmkAcG+Z+Fv0SC8gCz/4GS1JhzPd5a
 reN0fGXQg/bwl7aPMN76dPU64XQq3f5mQ1pxtc7d91KZ3l/u0cGuHeIHLwPBc0eOgT2sYWIhz
 bkM5SOo5ioUhesb2fMsHrE9qnM76AspxNuiov3xKSc04mZgdkufRbbjHIwjH3BVeJgOi6XPyZ
 cC5LtOBMLMvLyacknR1vLxj17TV9f+Ha7BBUnEmUQ2lC5EPeO9Y7V1CP5YC8fWKX9QMPeJo4x
 oyRUCQxDOCwRl8Og7bEUfd2Ehwus94YVqKmgdz4oKMWS3NyUAUE+U/zbb4ZGL6ph4wMkCJsJK
 QZoKZNqHbNN21S9auYX/cJRXnq4DeXJKp+FrWn4inyIJsInh/jZwKVRCQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/20 =E4=B8=8B=E5=8D=8811:38, Theodore Y. Ts'o wrote:
> On Tue, Jul 20, 2021 at 04:44:29PM +0800, Qu Wenruo wrote:
>> Anyway, if building a stable and complex API just for hooks, then it's
>> completely against my initial purpose.
>
> So you said you are only using this for debugging purposes; at least
> in my workflow, when I'm trying to debug a particular test case, I'm
> *only* run a single test.

Under most case, yes, and that's also what I usually do.

But I have seen some strange case which doesn't trigger error by itself,
but needs some other tests to be run before the triggering one.

>  So today, the way I handle this is to run
> hook scripts in the gce-xfstests framework before and after running
> the check script.  It does mean that there is excess work which gets
> traced from the check script setting up and cleaning up, but it's
> mainly been good enough for me.
>
> It would be slightly nicer if there was a way to start and stop
> various debugging hooks (e.g., starting and stopping traces, clearing
> and grabing the lock_Stat info), etc.,) jut before and starting the
> test.  But it was never important to me to propose changes to the
> upstream xfstests.

 From the feedback, I guess that's the case.
I would no longer consider to upstream any simple debug purposed code.

Thanks,
Qu
>
> In answer to the question which Darrick and Dave asked, yes, I could
> do this via the exclude list.  It just seemed that if we're going to
> add a programmtic hook, maybe it would make sense to do it via the
> hook script.  It is true that there are ways to do this, though,
> although there is a difference to a static excldue list that has to
> get created for all tests that might be run, versus hook script that
> is run for each test.  <Shrug>  There are other ways of doing things;
> the question is whether the hook script approach is sufficiently
> better that it's worth getting something like this upstream.  It may
> be that keeping things like this in each developer's own private test
> runner is the right thing.   I have "gce-xfstests --hooks <hookdir>" for
> my own use, and have had it for years.
>
> Cheers,
>
> 					- Ted
>
