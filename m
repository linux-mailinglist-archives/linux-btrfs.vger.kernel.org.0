Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46DAD42A2C0
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Oct 2021 12:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbhJLLBi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Oct 2021 07:01:38 -0400
Received: from mout.gmx.net ([212.227.15.15]:38669 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232810AbhJLLBi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Oct 2021 07:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634036374;
        bh=N+fcnmhrtJb1ejhT2woPuSKPLvaoh+lwfOj+oF94u88=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=eMcHmBzZpZ8PTnt2RY3lYO+0VVR+KOrotqsfgtG8Qp82Dz4UViL66myBxcbMgKlz+
         TM3hksoozJF2ybIc3tRt+/U+ZlxOnemyyGdm9LoErKhcIX37wrmuM3DgNIv6M6oJ26
         I2iqfORT4qqnWuaeT8qR7in7Ju8tK/QMeHiHXLXE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mdeb5-1n9JH23BxZ-00ZhxJ; Tue, 12
 Oct 2021 12:59:34 +0200
Message-ID: <bf23e581-e03a-7254-b6d7-b9d67efaadc0@gmx.com>
Date:   Tue, 12 Oct 2021 18:59:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] btrfs-progs: parse-utils: allow single number qgroup id
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211011070937.32419-1-wqu@suse.com>
 <20211011132132.GH9286@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20211011132132.GH9286@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CMQe6GnIqQQ64uXT+Xrk9Phns2XL4vMCB+SG1MvuXkKady6FAk0
 O/0AEBv0XIWHqds/aJxCN5AhOenzBgBBUh4aM9phmtkp/qL+sYSCt6TqZN6HSVC+jogVBGe
 +6c6nRgaMqcfb9gnKcwOvyFSmdBMgKAEiSx41o7mfATDUtxkvINATRZnYdJUgHccIbP9T87
 f+cFbykzyd1omvmFWFJyA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GujL629CzHY=:c8+MfbkbFd5yP/jZ26jjbZ
 h6gavIKkc8+mqRI9oaa38U/EMSQatO8da7XWQp/bUzE5vg4Aqk0g6Tte0Qv7pS1HXpDJILBGw
 R6Kks+IwPm6DYBwFzHzy22lK1RbDDrpRCNdC0DfVlPxT1FBjiXT8+5YklXqq3vtfuxTVtAlE+
 lUa0GfhR99f047/SGxkdKCKITiOYODnDvYeK2LveE5CazolhC/t4KMlXDCWd8YrRgd5eiA6Uk
 xQ5+oFdGr9qQlyOb3eQfygcfFZ/dS4XZU4KpG7kJ5Z317O+shnbkdUDjWTCRBNTox09HoBmIi
 PFjkDASWnpc5BPu3hhjD92pB/UR/+knk7X7s8G6rwbPaVCfaIor8huiPp++F3mjI8cNQTHB/J
 WjoP+XkbInX9OWpEYJU/yz1pViAHtFXfxFeIBdg/sMvL3a4TqXtCDe8qdoqCS7qRq/j4Otb1m
 eB3d/XkgsNbaW6X4RvKUiiqBLjkFz37BeCfck7ZJOPSuSH+87tZI2KnYcvCP/BRXBwW5Xjk30
 BGzckrJpLxEdUL6IwLEdxXWFhCWjHixZd30FIH93pa4sUcXFM1tM4ARlv8Efe+PHpqi+RjeJU
 GzIhBd6d0D1xDopZL7vic+X7KyZR4RAgi68J7MRWVXDcvl2fncAl1WhP9noTyQXdsKMjgv49B
 6pyCW7LlHxFvnx/mja7goYeeBIKfQT3F0+JHlTPJ+qprKlg9iaRYz5DOHB2QryD88CBVPHc71
 32uWTK84t3YMnz2VaAM7zfc+oPI/4AGD2dLUXcURYjEWGyyL5Cy5T2NLvyDEQHhmUdqeZz8Z4
 tJpo486/qvSSQtp5AK+yLAvEaKvYH3CJlwkH/89Wy/nsyUtNjiGgXdgE6Dr4mY35as7qC3h/W
 HHpVTT53ZmKMcODnX46hsd/1rkYpIanlTcm+O2u3PIAOKqVsFheN/CUGftQoAirAjrbLTkjLi
 hsvkt5nKWZhyWxDzJCCvGjx2wkKTeTK5PfTCcyeMrJgg5lQGcetbZdIQFvCMF5sRhxccH3hbN
 N3J0QYnzSAR0pmf9Dtw9g9lX/zwUiKPtzt8VWRp9B8d1QVdDNbWLB/FzH4I8la6OBkMWPXPhL
 Z74mUyAWtQQrRU=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/11 21:21, David Sterba wrote:
> On Mon, Oct 11, 2021 at 03:09:37PM +0800, Qu Wenruo wrote:
>> [BUG]
>> Since btrfs-progs v5.14, fstests/btrfs/099 always fail with the
>> following output in 099.full:
>>
>>    ...
>>    # /usr/bin/btrfs quota enable /mnt/scratch
>>    # /usr/bin/btrfs qgroup limit 134217728 5 /mnt/scratch
>>    ERROR: invalid qgroupid or subvolume path: 5
>>    failed: '/usr/bin/btrfs qgroup limit 134217728 5 /mnt/scratch'
>>
>> [CAUSE]
>> Since commit cb5a542871f9 ("btrfs-progs: factor out plain qgroupid
>> parsing"), btrfs qgroup parser no longer accepts single number qgroup i=
d
>> like "5" used in that test case.
>>
>> That commit is not a plain refactor without functional change, but
>> removed a simple feature.
>>
>> [FIX]
>> Add back the handling for single number qgroupid.
>
> This unfortunately breaks something else, as it's changing the whole
> parse_qgroupid helper to accept single value id, which is also used for
> 'qgroup create'.

For 'qgroup create' I think it's OK to accept single value id.

It's a handy shortcut for '0/<subvolid>'.

And for higher level qgroup, we need the level anyway.

>
> There's another combined helper for parsing qgroup id and path, so we
> may need to add another one that also accepts the subvolid, in commands
> where this makes sense. The helper parse_qgroupid should really remain
> as it is and parse the 'number/number' format.
>
Then I'm completely fine to update the test case to go "0/5".

But I'm not sure if this change would affect the existing user scripts.

(Considering there is no report yet I guess it's not that widely used
anyway?)

Thanks,
Qu
