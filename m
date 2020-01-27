Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2363D149F8C
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2020 09:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgA0IL5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jan 2020 03:11:57 -0500
Received: from mail-40130.protonmail.ch ([185.70.40.130]:37817 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgA0IL4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jan 2020 03:11:56 -0500
Date:   Mon, 27 Jan 2020 08:11:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1580112714;
        bh=X99L9KBqdDjeciEKrA624fUZdTj2ztPkr4uwKCOLYFU=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=KmvdIm3RO3o9BXGIad7a8OjWd1U0oVEs4PklSzVpBpJ/BmgRFgPezp0qRz8sxGxSc
         tM/FxzYyFTT09oVYUFZd2UulmS0pwyDdWEFgL7dot8bulsBUak9PlTV7HFcIr95iyr
         rJjHJZfHGUqn3VcndMlP6tkL/kirSmjQ/cmPS8NE=
To:     Nikolay Borisov <nborisov@suse.com>
From:   Raviu <raviu@protonmail.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Reply-To: Raviu <raviu@protonmail.com>
Subject: Re: fstrim segmentation fault and btrfs crash on vanilla 5.4.14
Message-ID: <wX-p4FiBlZKoayimhFOWfIDuatdV63zui8eZ_gWp0tXCu1Fe6FMD5Cna6aZtD66pGwWCRt3wLxWRsPpaLuQ-lqvmhBNOTOFo8mFa8k3KJaA=@protonmail.com>
In-Reply-To: <670bb0e5-aa42-2fd6-e15b-b1e11130c94b@suse.com>
References: <izW2WNyvy1dEDweBICizKnd2KDwDiDyY2EYQr4YCwk7pkuIpthx-JRn65MPBde00ND6V0_Lh8mW0kZwzDiLDv25pUYWxkskWNJnVP0kgdMA=@protonmail.com>
 <7tcxgXvMR83f-yW7IN3dKq8NWJETNoAMGo_0GShBJMjR_p_N4vE3nDMPkECoqBiOFDCEFsBM4IZ08Lkk0yT5-H81FkHAV-xEThPkbey0Z40=@protonmail.com>
 <1a8462a7-c77b-ecc9-681f-3cecb6a51576@suse.com>
 <hNqW0cNKaqya5Nvb99uUaI7KRF7zyl2urKDMfG6CkwEvLdLq6HlWnBLFrgtNCpleC2dfm8HLOHUdlQYPa1zi9zxfBaY1wwXli1mTAM-4qTQ=@protonmail.com>
 <1DC5LVxi3doXrpiHkvBd4EwjgymRJuf8Znu4UCC-Ut0mOy9f-QYOyvQT3hf-QJX3Hk8hm_UhBGk_3rLcGYs_b6NdpNHDuJU-qog6PFxjEDE=@protonmail.com>
 <B5lXpRtqEz0NPuXGaaqp8p0AKY3ndP946GmHLVHkhHDPIntSm5HopHG8RCNWlyx8bw39N0NdjMh0PSMuCqZ6-yts7YUKhASbJ2oLx3z06aM=@protonmail.com>
 <670bb0e5-aa42-2fd6-e15b-b1e11130c94b@suse.com>
Feedback-ID: s2UDJFOuCQB5skd1w8rqWlDOlD5NAbNnTyErhCdMqDC7lQ_PsWqTjpdH2pOmUWgBaEipj53UTbJWo1jzNMb12A==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,BAYES_50,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM
        shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> On 27.01.20 =D0=B3. 9:53 =D1=87., Raviu wrote:
>
> > Follow-up:
> > It seems that I could solve my problem. Maybe this can also help you kn=
ow the root cause and reproduce it some how.
> > My buggy btrfs was initially on a single partition, I've freed another =
partition later and added as `btrfs device add` as the free partition was t=
o the left of the original one so a resize was not possible.
> > Originally I'd metadata as dup and data as single.
> > Even after adding the new device it remained like that for few days, ye=
sterday, I noticed it reported both dup and RAID1 of metadata which was wei=
rd. It did some sort of metadata balance on its own when it got a new parti=
tion, actually I didn't run such balance command before as both partition a=
re on the same disk, so thought that raid-1 is useless.
> > So I've taken a backup, then run `btrfs balance start -mconvert=3Draid1=
 /home/` .. So only raid1 is reported now on `btrfs filesystem df` and `btr=
fs filesystem usage`. I then run fstrim and it worked fine.
>
> Yes, this is very hlepful. So if I got you correct you initially had
> everything in a single disk. Then you added a second disk but you hadn't
> run balance. And that's when it was crashing then you run balance and
> now it's not crashing? If that's the case then I know what the problem
> is and will send a fix.

Yes, exactly.

