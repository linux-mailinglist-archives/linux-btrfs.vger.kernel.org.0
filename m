Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F38432B7B
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 03:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbhJSB1s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Oct 2021 21:27:48 -0400
Received: from mout.gmx.net ([212.227.15.18]:58393 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhJSB1s (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Oct 2021 21:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634606732;
        bh=yxoimxA4Teg5RhLItixjUx7om9p/PuEQErRJgwUR8XY=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=BXEp4CrV4cna7Aml+pwJEBy9QCbZG6wwM6cg/lyQAwqPB103tGejamxx2oNfxGZTh
         OaTGziM5dRRO2Uc2EjLYUYIbFRFDQefbJp/P5+aiTeMqsdySiWsw8P1ensxPvcOqpl
         mNuDxsdAE0MBKLoxWXATCFqnirfrOk4ksGEKcL6g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MF3He-1mW3Fb3lIu-00FVdY; Tue, 19
 Oct 2021 03:25:32 +0200
Message-ID: <c36509b8-1084-8544-df09-505b083c7ed1@gmx.com>
Date:   Tue, 19 Oct 2021 09:25:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
Content-Language: en-US
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Su Yue <l@damenly.su>, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <CAJCQCtSsLSwtNTrUKq_4Rs0tauT45iSA1+AkGWnS9Nmkb=0oWg@mail.gmail.com>
 <9b153cca-2d9a-e217-a83f-1a8e663fc587@suse.com>
 <CAJCQCtTAHmvwmypAgnLVr-wmuJpOxnmXzpxy-UdHcHO8L+5THw@mail.gmail.com>
 <e18c983f-b197-4fc5-8030-cc4273eda881@suse.com>
 <CAJCQCtSAWqeX_3kapDLr8AzNiGxyrNE7cO_tr3dM-syOKDsDgw@mail.gmail.com>
 <b1fccb42-da8a-c676-5f0b-1d80319e38ca@suse.com>
 <CAJCQCtSRxFuU4bTTa5_q6fAPuwf3pwrnUXM1CKgc+r69WSE9tQ@mail.gmail.com>
 <eae44940-48cb-5199-c46f-7db4ec953edf@suse.com>
 <CAJCQCtR+YQ2Xypz3KyHgD=TvQ8KcUsCf08YnhvLrVtgb-h9aMw@mail.gmail.com>
 <CAJCQCtQHugvMaeRc1A0EJnG4LDaLM5V=JzTO5FSU9eKQA8wxfA@mail.gmail.com>
 <CAJCQCtT12qUxYqJAf8q3t9cvbovoJdSG9kaBpvULQnwLw=rnMg@mail.gmail.com>
 <bl3mimya.fsf@damenly.su> <e75cf666-0b3a-9819-c6ac-a34835734bfb@gmx.com>
 <CAJCQCtT1+ocw-kQAKkX3wKjd4A1S1JV=wJre+UK5KY-weS33rQ@mail.gmail.com>
 <CAJCQCtTqqHFVH5YMOnRSesNs9spMb4QEPDa5wEH=gMDJ_u+yUA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAJCQCtTqqHFVH5YMOnRSesNs9spMb4QEPDa5wEH=gMDJ_u+yUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kCLAo1jOYv8MlYTFrtOaE8xVfLkd1qdBWUmXYI/vjuQQ+pXOLz4
 uUZnag495EpcukDQiKWxPSq7Vt8mZUSclI4nnymDGGQRMVY3c3r6wvXZsKMCek+t5sJcjS5
 wTpZ6W0/s+64r3PkGHStQva+WW73fR4la86EfwyVfhXGdgXF9aS8OzR6+LOjaRpwHeHE9ZL
 CnOOB8Yk9+VsWBux2/gqQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PMB3302vUVA=:05I1bgBKG65qfx5Y4mDEpM
 iHP9Hq9sPo0q58fGrpqobF/nLtUqgT4QdFZDy67WPLpH+gdIyrItmei2HlabvHS7Js2ll5cRL
 drlPO/Qx8oxmBRo6bK6VniiRCARgkPSGClFMShHWNruERgftHin3bLMYqXyfl7z+gxwn5OWFV
 q1FYHdZyXRGqJTTdR7q0aP6ruBvUbcyYTELphXnf/AOdEHsJ6HbKIaoEvQ8QjB4x1VXyLsTkr
 dY1Zjsy1Yhd2Hv8alagw8k0l18VCYq8Gvjh/iElxrhEuSQxWUh03UvRo4PBRTgxows0a/7LlA
 LZ2CpPzYqpvqCN41FfkNr1rzzwJvE82zKQFcAjIh6B8SJB3dxpuyP4RN1iQnxy+0elS0DnUEN
 JwVYoHE0CYxvu+m5CuqC8ia3d+Q5rREJew5WOyvMzzinyzJKyBPwePALQfrC9jAyFSUTZbOVO
 mGFpjaxeVqdZKHbTtE0W/F+MIkPiQimQSD5Ri8lzXrTPBwfUY+mRlmrdDBkfYj2xICeUsNgu5
 rQaT7HRXqXkKmhn4w6zQT4Ai0T/gS7KsAbNp7ZQGPBhE2XsaEDEz8wAq7RKGDaXP63HPGp6p5
 RTUHqxT1aP4kPIxnznE5Yw8aniF48B0WKVTa8IvUXxCR+x1sMOmzafvhcGUVYjpKfpOZOLZRF
 kJM0varNZqDC3Mu9gBs9r2/UOczY609uYViNOMzMBjKo3+lYypTuP8T36g6zYd1RhqnocTlwp
 ygN+O2Hq2QUsJscy7bKRgMrihs6ubA5mwX2vxzNe2714W8dKwyisQnKhrgLLsieXUMDT339zP
 H8f3SaIJqJQBjtoVF6DLNog8BfDd7N4KD9k0/1QT5WxPiDmp6sxA89F41ru7AK4r84AXSPA6+
 axJW2rD2MAxMnmXTHAdg4NeMZk9pLFWZXsmRpPqJKIP/X4Cglb/0FerRnl1v+CXPSAiPS9peY
 nje6+/Zg0UVcWzLsnVPuDFdUCnRkr5D601Lm36ZQ6wvB6wqF7SjWobuCHSy1p6ZGyxe4iV+RS
 iajOgckaM9WQE5xR3vykamhqsqQnrCeqtxdiHUawnV4ioyfDiH4wT+7qslECEgV2kyvcuMWxX
 XeDrtC5QK1xiLw=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/19 02:24, Chris Murphy wrote:
> I've got kdump.service setup and ready, but I'm not sure about two thing=
s:
>
> 1.
> $ git clone https://github.com/kdave/btrfs-devel
> Cloning into 'btrfs-devel'...
> fatal: error reading section header 'shallow-info'

This looks strange, maybe you need to clone torvalds tree, and just add
that tree as a remote?

>
> 2.
> How to capture the kernel core dump, if I need to do anything to
> trigger it other than reproducing the reported problem or if I'll need
> to do sysrq+c or other.
>
> If it's faster, I can also get any developer access to the VM...
>
With current backtrace, it already points us to exact where the problem is=
.

Even if I have the access to the VM, I still need to download the source
code and rebuild the kernel myself to add extra debugging codes.
And I doubt if I built the kernel using different config/compiler, it
would no longer reproduce the bug.

Thanks,
Qu
