Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6007B4371A5
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Oct 2021 08:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhJVGVZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Oct 2021 02:21:25 -0400
Received: from eu-shark1.inbox.eu ([195.216.236.81]:36496 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhJVGVV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Oct 2021 02:21:21 -0400
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id E94336C008CC;
        Fri, 22 Oct 2021 09:19:03 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1634883543; bh=/3rXM3v9XnidTCNlzKBLjCRxMaTDbzI+t/wuZES1fxI=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=fjpmIlTlUg2CV/Slmz/BdhVgaGI26wmDzF0WtwOs0jNyZLbDyXYyg1MUe7qFbLNLS
         uGQMcBK9bfcjYi0mqIWAhHDppuJ4JaIu7cUxWuQLi1Fn/r2qH1VcxVvDGgUbgIslCB
         agQIqj8kTv9MFbVktaoVk6+Ub9VfOiC7BgmXmXZg=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id D39BE6C008CE;
        Fri, 22 Oct 2021 09:19:03 +0300 (EEST)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id JX3zkYaoj1NE; Fri, 22 Oct 2021 09:19:03 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 280B86C008CC;
        Fri, 22 Oct 2021 09:19:03 +0300 (EEST)
Received: from nas (unknown [117.62.172.224])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 62CDF1BE01CB;
        Fri, 22 Oct 2021 09:19:01 +0300 (EEST)
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
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
 <7de9iylb.fsf@damenly.su>
 <CAJCQCtSUDSvMvbk1RmfTzBQ=UiZHrDeG6PE+LQK5pi_ZMCSp6A@mail.gmail.com>
 <35owijrm.fsf@damenly.su>
 <CAJCQCtS-QhnZm2X_k77BZPDP_gybn-Ao_qPOJhXLabgPHUvKng@mail.gmail.com>
 <9b2cd532-3abc-13db-0c51-c604b8c1d227@suse.com>
User-agent: mu4e 1.7.0; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
Date:   Fri, 22 Oct 2021 14:17:22 +0800
In-reply-to: <9b2cd532-3abc-13db-0c51-c604b8c1d227@suse.com>
Message-ID: <lf2lh99s.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: OK
X-ESPOL: 6N1mkZYsbjOljF6gQXPdBAIxs1k6UZ6b55TE3V0G3GeDUSOFf08TVhKpnGt0U366uiM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Fri 22 Oct 2021 at 09:02, Nikolay Borisov <nborisov@suse.com>=20
wrote:

> On 22.10.21 =D0=B3. 5:36, Chris Murphy wrote:
>> OK I have a vmcore file:
>> https://dustymabe.fedorapeople.org/bz2011928-vmcore/
>>
>> lib/modules/5.14.10-300.fc35.aarch64/vmlinuz
>> https://drive.google.com/file/d/1xXM8XGRi_Wzyupbm4MSNteF0rwUzO4GE/view?u=
sp=3Dsharing
>
> In order to open the dump we require the vmlinux as well as the=20
> debug
> vmlinuz and also btrfs.ko.debug file as well.
>
kernel-debuginfo-5.14.10-300.fc35.aarch64.rpm is on
https://koji.fedoraproject.org/koji/buildinfo?buildID=3D1843224

--
Su
>>
>>
>> --
>> Chris Murphy
>>
