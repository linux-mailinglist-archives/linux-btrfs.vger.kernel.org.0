Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13130396A46
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jun 2021 02:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbhFAAXj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 May 2021 20:23:39 -0400
Received: from mout.gmx.net ([212.227.17.20]:50423 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232081AbhFAAXi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 May 2021 20:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1622506916;
        bh=AGRV79e2qh5ZlQadnMSAuJJXJgyZHa82otkCUWznDv0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=DoLw03VolhCB5JBajvigmzKWBFn6jdLn9MtT1cFoWmrCDjbnJHny9agZvigK9XpE+
         OYQUpZCtxHnt+ik9UmoLV2dCIqbh2Dsw4hxK/h+33i+Oa/dzaU01HEImJ1ziWf1grn
         jhnOliDvppf062mdcVhImzuW+TogF4hfmX8LvJyA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYeMt-1lsQcK1i3H-00VjI0; Tue, 01
 Jun 2021 02:21:56 +0200
Subject: Re: [PATCH v4 00/30] btrfs: add data write support for subpage
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210531085106.259490-1-wqu@suse.com>
 <20210531140902.GD14136@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <3fb550f3-e8cc-6beb-51df-da9415205913@gmx.com>
Date:   Tue, 1 Jun 2021 08:21:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210531140902.GD14136@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EC9twRgLWjHOB0i+OWaUWrXQmuzmv8IEWUZk/w95GgyILSwIl66
 0jn0kWAvPoz5vZ4iJEg9xwYOTAaJ1fNmq/LQDi7faTXJOeWTmM2YFaTu1Xm2Gwflwd06zoH
 Hy8UZttYc+bhg8JGi8XTsh4kNSjPDeXvjqmndqtq2/VxzCdu9d3o6CeY23l6jlVzp+PS2BO
 ygdCtZcqwSewtdqpbMtCg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9yBzGZwqPoM=:XwZMgYcTYsGCUIWn2bps93
 jcJQEhT4vfzZMsGaC9XL3nnvWpGW1sPxRC/hCymixFeOaDbn57bTw3T9zAmZdZUD820pXNJEV
 MpL7p+bSGFQmrizoNfOUOqfWa0aEvaDIjoWnl+anScSvQzV4vCfli5gGB/fF6PSuE2RAXunNa
 Qxf2HHHIR7PgtLTJw5QsYY2NrMUT4aCH2g2GjhIxmMxDd3cusL+OpHRCita7u7pX7+1/1n4s9
 Isezmc07jXIYftFWeT6qXG12kJsk6jiEJtDuNbiBVU6DyzwP2cqEBxF/vK9GEhNcMbVMSNLci
 7i9tcLtXV2hhGrKLTl1WcOZl8uSvOcCfK+qW4j5dr2iGkgNvN926w2AX568yyfU6uLs0tRbr8
 ftaOmTAHhajX/Wpv9Hr3JM7nOW7kIRAyeEYkKRx7R8fMTqp7eHlENIkR7LdS1mMA6MXAaOmaX
 rBl+pwo6fDF8/o3ivitiKDe2ASVmO5XJmdFHHyRg2a5HouaouIslKr4Xo5z4eQr5hYY84D+S6
 yknYcB9QN3BBryRpYpmdWfy5t0mH0pZ2bp4jPiAf/FwDby4fYMzCiSxYsPOhc/lTjV0gszdJV
 HkQ0eCsZCr0qKlxgGsbgX5DOreiY4UU74QrmrT2us8bpVulrfcQ49HlmPXExDCHDIg72LGMPT
 OdUbGbi+kJ51PwN43IxpM0A155NT2PficBvntNmYTIdzsbM5kcoBWXCSVDQTNkh1aqX9rMlx8
 EIEW6JRXDO1pPtfqlJ5zjI7jbw5m04sNKZQ3usiAWMShaGbgLWVF5iflErYIlnIlaK8se3mC5
 54LMx+yHgmos5bHJn54ocAnjc6BeTG5H7Rj5ubKf9vOSrdFY3hKOf4cC/bfV8MWxkNhBsqZ3D
 GJg38njuB1ePRLBQId765/4PtU4+/gHrebjaEh/Jef8p1ISRw1AWt1MGq1qX4s1ConuKYyg4t
 8gETqZMtUBoyytNTTbXHnA+hCYoVoecT6oX0MTX79JwYJQBZexhzkmdzMPt35xBvoO/l3/vuN
 eFd4SY2qF0w31Ew2Gtnp1rqUDltY+8BOYbPOm8hPlx5xjD17epjjts9ePdZto5dwy7qk7yS6m
 GoaRZQ4F9qgpAfRn+mIHUd9W1otKQXMcyguEyEeq601BjEZp4dWhnquOg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/31 =E4=B8=8B=E5=8D=8810:09, David Sterba wrote:
> On Mon, May 31, 2021 at 04:50:36PM +0800, Qu Wenruo wrote:
>> This huge patchset can be fetched from github:
>> https://github.com/adam900710/linux/tree/subpage
>>
>> =3D=3D=3D Current stage =3D=3D=3D
>> The tests on x86 pass without new failure, and generic test group on
>> arm64 with 64K page size passes except known failure and defrag group.
>>
>> For btrfs test group, all pass except compression/raid56/defrag.
>>
>> For anyone who is interested in testing, please apply this patch for
>> btrfs-progs before testing.
>> https://patchwork.kernel.org/project/linux-btrfs/patch/20210420073036.2=
43715-1-wqu@suse.com/
>> Or there will be too many false alerts.
>
> This patch has been merged to progs 5.12.
>>
>> =3D=3D=3D Limitation =3D=3D=3D
>> There are several limitations introduced just for subpage:
>> - No compressed write support
>>    Read is no problem, but compression write path has more things left =
to
>>    be modified.
>>    Thus for current patchset, no matter what inode attribute or mount
>>    option is, no new compressed extent can be created for subpage case.
>>
>> - No inline extent will be created
>>    This is mostly due to the fact that filemap_fdatawrite_range() will
>>    trigger more write than the range specified.
>>    In fallocate calls, this behavior can make us to writeback which can
>>    be inlined, before we enlarge the isize, causing inline extent being
>>    created along with regular extents.
>>
>> - No support for RAID56
>>    There are still too many hardcoded PAGE_SIZE in raid56 code.
>>    Considering it's already considered unsafe due to its write-hole
>>    problem, disabling RAID56 for subpage looks sane to me.
>>
>> - No defrag support for subpage
>>    The support for subpage defrag has already an initial version
>>    submitted to the mail list.
>>    Thus the correct support won't be included in this patchset.
>>
>> =3D=3D=3D Patchset structure =3D=3D=3D
>>
>> Patch 01~19:	Make data write path to be subpage compatible
>
> We can chop the first series batch again as this is still preparatory
> and we need to make sure it does not interfere with other patches.
>
Considering how many tests those patches haven been tested, and how
little they get modified during development, I'm totally fine to get
them merged first.

Thanks,
Qu
