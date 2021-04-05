Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD276353C0D
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Apr 2021 08:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhDEGOy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Apr 2021 02:14:54 -0400
Received: from mout.gmx.net ([212.227.15.18]:59847 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229454AbhDEGOy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Apr 2021 02:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617603278;
        bh=3nYHzufJkzP0o+DFcPzZV3ShZ1P11qiAVlypEl9Vlyk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=dmCjEZlCYsF7rKOGSPmvHA6jAg+jmhaTt30IDT3qgDXhaoi8t6csk4OibI/qDdElK
         d7s1GRSNJFWgapOna9t1sAg9JkLWVVioS30HZ8J4FIM3Iyq9azagjad3U46qIeSqn4
         VN+5CKM+DbTlPUqccHK9+TFU75rQ0DpJLlrl341o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MUXpK-1l2vvx3mNc-00QX9j; Mon, 05
 Apr 2021 08:14:38 +0200
Subject: Re: [PATCH v3 00/13] btrfs: support read-write for subpage metadata
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210325071445.90896-1-wqu@suse.com>
 <20210403110853.GD7604@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <aa1c1709-a29b-1c64-1174-b395dd5cd5de@gmx.com>
Date:   Mon, 5 Apr 2021 14:14:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210403110853.GD7604@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UZ61AWNPtya15Zp/F7FvTHLhGH5JPO54LdJC0ZpqEgQbqQCJ01e
 X5SUdzb54D0i2Pff5B6uP1aKFbke/Dj1no8mPg+YizgPoff3YV1Ey2Mv0Krsw4zLIcpZZ2e
 7ctYcXN8Bhnmsb12+YsGGd0t2qjPKNy8jiPf7zrwmQSHehuI2UFKt/xm/nJz5Gr6oK1IJFW
 QwmeADBU5HJ5Ni3G97DTQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ateyDgYO12U=:IORNtmf3HmbyvF240R3PB0
 MUt0B8uxwDfgtPRh7SSBqlgoaw78Bglmw0Eo3UFKjqo+J/bNaJh3WobAcmFWw5awrjDDexup8
 m00nOO4ri4u+VRXCTnXMoJtBNw3gI++5VSDlTChnqalaDlyuKtJ28nKh2XOW9JBxwER/Wtnqd
 dHkVofRcARCY/c3K/HYFYcRaVBgMNFNtOMfIqfBs5GcMJh9UgewuCzlvcHehMhQgpcF0NegOO
 iZG8qY5WoWSzZcJ12ei8P4UZr1ZVZ4ZUcKEniKtoLIBXAc8j8nLqXi9ae6EYFRMd5DLr65/TM
 O+vP8wxiro8lijlK6bOKPVQYKQlIC5ezodCA3IZRkAwcVXXXZ8NNUUCawxveOmXm0tLzS2koV
 3Q0IqexBDIAKG4X9Dublkr4Tnpz6Qwe3KzT+UyYFhUP1TITmkLvumXd0r82Cn0Qw9i/t+dZpc
 3gYWUuLVnrGjv1j0HNlWvkxp1sWmfuOVDJmB+befjsxCn3qWsufzO++VxiFVDkfii1avl/7vo
 i48/sNnBxay92V1WTdZpfN8Btyb15/3mjTMsN5sjwJt44RO6GunPEGy8az6LrD65pN1FrznTi
 pbt/H2sYD/JWoE3Oc8d1ydiPuk5UAP9OwaWlaehfFlDz4yNHrDzvyjMese1ruMhT62tJzBT4y
 ZHLLdtGy6c2BTf6C9a1x9Fi78edsjrE70mSCfGqCR57dWCr/jqVbA1rPQjac28w7yyRhYwmlQ
 wAF/bWDtHtQbRkoKB8otWsobNHltvZV1RAhV2Ks9P/pL8mwkDpwsgvc3KpVZP7ti/siVQrw32
 hGo3busoAC8nl83VZm3m/qjLSgHan9obRFupknmNiBciZsaa9nL71U2RRDdXEHTlpEtTh8JyG
 zawa78COF9RpRptjYdmwd/8XtddhSmMTkZWtAsl3eRmamb5LU67p76BlEO1jcF0L2qyMIAWmg
 MtUw6WeBOiHutZnf3tXoI3SMB3bVBU/9Xa2IthAtzD8SKvjA4uYdN5bopAByx4JYrOjwMT7l9
 lQj33W2EttefSoWvyeyPgZoBej0jBZZcC7rfLjERcJ/uRtvIX/efcm3bQu3iR9T8tqLWPSYva
 GM4K5/FpHxKmioc9fdutwD/Tw+GjghF0zxDKvzsmOUc4Fs6UFGFL5R7FFdlox2+DLssbsxa60
 gyltq0J3QsKVjnyI1aGX+PeeM2EFti6umoFKGGugOzLZORVpomkYr/gYfTTRSyfCkq/PdXSQo
 p4ZK9CKLeDnMpPb5T
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/3 =E4=B8=8B=E5=8D=887:08, David Sterba wrote:
> On Thu, Mar 25, 2021 at 03:14:32PM +0800, Qu Wenruo wrote:
>> This patchset can be fetched from the following github repo, along with
>> the full subpage RW support:
>> https://github.com/adam900710/linux/tree/subpage
>>
>> This patchset is for metadata read write support.
>
>> Qu Wenruo (13):
>>    btrfs: add sysfs interface for supported sectorsize
>>    btrfs: use min() to replace open-code in btrfs_invalidatepage()
>>    btrfs: remove unnecessary variable shadowing in btrfs_invalidatepage=
()
>>    btrfs: refactor how we iterate ordered extent in
>>      btrfs_invalidatepage()
>>    btrfs: introduce helpers for subpage dirty status
>>    btrfs: introduce helpers for subpage writeback status
>>    btrfs: allow btree_set_page_dirty() to do more sanity check on subpa=
ge
>>      metadata
>>    btrfs: support subpage metadata csum calculation at write time
>>    btrfs: make alloc_extent_buffer() check subpage dirty bitmap
>>    btrfs: make the page uptodate assert to be subpage compatible
>>    btrfs: make set/clear_extent_buffer_dirty() to be subpage compatible
>>    btrfs: make set_btree_ioerr() accept extent buffer and to be subpage
>>      compatible
>>    btrfs: add subpage overview comments
>
> Moved from topic branch to misc-next.
>

Note sure if it's too late, but I inserted the last comment patch into
the wrong location.

In fact, there are 4 more patches to make subpage metadata RW really work:
  btrfs: make lock_extent_buffer_for_io() to be subpage compatible
  btrfs: introduce submit_eb_subpage() to submit a subpage metadata page
  btrfs: introduce end_bio_subpage_eb_writepage() function
  btrfs: introduce write_one_subpage_eb() function

Those 4 patches should be before the final comment patch.

Should I just send the 4 patches in a separate series?

Sorry for the bad split, it looks like multi-series patches indeed has
such problem...

Thanks,
Qu
