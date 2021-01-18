Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A412FAD98
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jan 2021 23:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390564AbhARW4L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jan 2021 17:56:11 -0500
Received: from mout.gmx.net ([212.227.17.20]:37101 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731543AbhARW4I (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jan 2021 17:56:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611010472;
        bh=i6I8aq++2l/nN5BmK4zwSmKDNH5dZ0Mfp+lUVhrI5+4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ZftJvkaSFR4wi1+0sYPEkZrR4pESrLKP788JOhO/MKXHlehpWtihKiCvGeCVzFiof
         9wr2qVG8Mc6Ulutz0Wk71COLOATNqx0ugYoLu03YOZYVVOxo15W/fTVNPIpsOz8AI6
         JqHVdCXZBBJOxrpFwAhfbklyWMySeDJOHw+sB3Kc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mn2WF-1liQwh0Dd1-00k4mE; Mon, 18
 Jan 2021 23:54:32 +0100
Subject: Re: [PATCH v4 03/18] btrfs: introduce the skeleton of btrfs_subpage
 structure
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-4-wqu@suse.com> <20210118224647.GK6430@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <65ab6681-f694-5cc4-1b2d-b33b70ba40a3@gmx.com>
Date:   Tue, 19 Jan 2021 06:54:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210118224647.GK6430@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UJt1rkG0nfMQIq7IzxUxR414xhfd9kxQt2Yv7gH0E2K3DWYUHIe
 hEWriLi9ahfVUt51bfSxPLWe9esg9AVGLS9+3AdljM9sI+HQxFJkX0dXxcasGXq4U7+rVgH
 yeYxcAVLaGD8e3t2EHWMFz6OP0iDFOZKqczRL0uNRXyB/IA2dyrq7R0rRbKG8EGz7MNBzwu
 QmhlThsr1OFqHfnI0imyA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:S3Fdssmbjas=:zegbFtx5jpLakkpTfyrOH8
 hP/u1PDTbXHJmxWfpJ5O1xuiT/ky0PfAu1GxPuboJcM/w31VzEHFSAFqDZv7j9yqAxynR/YMI
 wGQH8kC2jVRM6fi7JjvtcXqqJvdXKfFYKFBEa4YlweI/LS/XR5frWjXIo0DfTiFoazvfhCKkm
 OowEl1aPatoDlakfb6YvmD/XcpuqYgkD8xL5AgdrIPykadO8f4oyl6liU3cCfg2bZkzgyqYfj
 AFziWeUYDqI3X0LOBJ+ZOOcAQ3pVSl9Jj4sNFuDd5RnXdPY1/HbqlVdMZ5SYDpl1WpSRx98CP
 ctCB4dCHvmnS8N8H/R34CY+M95WLIwSsDpE6s8UUdutVE7LO7UDSU9d1d+2n8aHhazaTxFpG/
 z7XSvDLj0D0vDGhBmDCVXs8HXm/kk8CuX0A+9JY/RrJ5MDu3keU1d/7/LQAWO+aY/fWX0tsI7
 jZZ4zyko9L3QneA8Xgtu2CZn3uZI2BjiH65/gJbXyPDpV2CDwRTsjZlRoR3Q0xdY71NIxTBMB
 J7+MbD3JiEKj8tWwVLzofSJreaq5MfJsJKXNUc38EHicjmFOBM8fwY+9CRzWfMcN4NGyXKpXw
 +axHRSoKrXBA2KdGhH+tL00g+mWmqM/nfUhJoxq6VobJtsnLu3++M2bMIBS3GLBlvcQqwGI8O
 064cX7fHpKgBtUr0En3TqaL7wUagz4WqbEntrGJ7g5+5p3PvhR4tYgmaLZGYIOTypVnG3bWet
 LANngcqDIR0fqBwubwV2mehQ6vDr1Jj9mwrVH/M4KicjVr1Sly+S3sDcj31s412l867v/SQfP
 roc0Gr+b7wQ2b0JL2K0Iao6K+U+1LddV6pc0lCSMzKu2j+5mimJsTiF3+hrAyjZZteTKu4RLN
 H1C8Q36aHUuIgYAa5Vrw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/19 =E4=B8=8A=E5=8D=886:46, David Sterba wrote:
> On Sat, Jan 16, 2021 at 03:15:18PM +0800, Qu Wenruo wrote:
>> For btrfs subpage support, we need a structure to record extra info for
>> the status of each sectors of a page.
>>
>> This patch will introduce the skeleton structure for future btrfs
>> subpage support.
>> All subpage related code would go to subpage.[ch] to avoid populating
>> the existing code base.
>>
>> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/Makefile  |  3 ++-
>>   fs/btrfs/subpage.c | 39 +++++++++++++++++++++++++++++++++++++++
>>   fs/btrfs/subpage.h | 31 +++++++++++++++++++++++++++++++
>>   3 files changed, 72 insertions(+), 1 deletion(-)
>>   create mode 100644 fs/btrfs/subpage.c
>>   create mode 100644 fs/btrfs/subpage.h
>>
>> diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
>> index 9f1b1a88e317..942562e11456 100644
>> --- a/fs/btrfs/Makefile
>> +++ b/fs/btrfs/Makefile
>> @@ -11,7 +11,8 @@ btrfs-y +=3D super.o ctree.o extent-tree.o print-tree=
.o root-tree.o dir-item.o \
>>   	   compression.o delayed-ref.o relocation.o delayed-inode.o scrub.o =
\
>>   	   reada.o backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o =
\
>>   	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o=
 \
>> -	   block-rsv.o delalloc-space.o block-group.o discard.o reflink.o
>> +	   block-rsv.o delalloc-space.o block-group.o discard.o reflink.o \
>> +	   subpage.o
>>
>>   btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) +=3D acl.o
>>   btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) +=3D check-integrity.o
>> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
>> new file mode 100644
>> index 000000000000..c6ab32db3995
>> --- /dev/null
>> +++ b/fs/btrfs/subpage.c
>> @@ -0,0 +1,39 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include "subpage.h"
>> +
>> +int btrfs_attach_subpage(struct btrfs_fs_info *fs_info, struct page *p=
age)
>> +{
>> +	struct btrfs_subpage *subpage;
>> +
>> +	/*
>> +	 * We have cases like a dummy extent buffer page, which is not
>> +	 * mappped and doesn't need to be locked.
>> +	 */
>> +	if (page->mapping)
>> +		ASSERT(PageLocked(page));
>> +	/* Either not subpage, or the page already has private attached */
>> +	if (fs_info->sectorsize =3D=3D PAGE_SIZE || PagePrivate(page))
>> +		return 0;
>> +
>> +	subpage =3D kzalloc(sizeof(*subpage), GFP_NOFS);
>> +	if (!subpage)
>> +		return -ENOMEM;
>> +
>> +	spin_lock_init(&subpage->lock);
>> +	attach_page_private(page, subpage);
>> +	return 0;
>> +}
>> +
>> +void btrfs_detach_subpage(struct btrfs_fs_info *fs_info, struct page *=
page)
>> +{
>> +	struct btrfs_subpage *subpage;
>> +
>> +	/* Either not subpage, or already detached */
>> +	if (fs_info->sectorsize =3D=3D PAGE_SIZE || !PagePrivate(page))
>> +		return;
>> +
>> +	subpage =3D (struct btrfs_subpage *)detach_page_private(page);
>> +	ASSERT(subpage);
>> +	kfree(subpage);
>> +}
>> diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
>> new file mode 100644
>> index 000000000000..96f3b226913e
>> --- /dev/null
>> +++ b/fs/btrfs/subpage.h
>> @@ -0,0 +1,31 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#ifndef BTRFS_SUBPAGE_H
>> +#define BTRFS_SUBPAGE_H
>> +
>> +#include <linux/spinlock.h>
>> +#include "ctree.h"
>
> So subpage.h would pull the whole ctree.h, that's not very nice. If
> anything, the .c could include ctree.h because there are lots of the
> common structure and function definitions, but not the .h. This creates
> unnecessary include dependencies.
>
> Any pointer type you'd need in structures could be forward declared.

Unfortunately, the main needed pointer is fs_info, and we're accessing
it pretty frequently (mostly for sector/node size).

I don't believe forward declaration would help in this case.

Thanks,
Qu
>
>> +
>> +/*
>> + * Since the maximum page size btrfs is going to support is 64K while =
the
>> + * minimum sectorsize is 4K, this means a u16 bitmap is enough.
>> + *
>> + * The regular bitmap requires 32 bits as minimal bitmap size, so we c=
an't use
>> + * existing bitmap_* helpers here.
>> + */
>> +#define BTRFS_SUBPAGE_BITMAP_SIZE	16
>> +
>> +/*
>> + * Structure to trace status of each sector inside a page.
>> + *
>> + * Will be attached to page::private for both data and metadata inodes=
.
>> + */
>> +struct btrfs_subpage {
>> +	/* Common members for both data and metadata pages */
>> +	spinlock_t lock;
>> +};
>> +
>> +int btrfs_attach_subpage(struct btrfs_fs_info *fs_info, struct page *p=
age);
>> +void btrfs_detach_subpage(struct btrfs_fs_info *fs_info, struct page *=
page);
>> +
>> +#endif /* BTRFS_SUBPAGE_H */
>> --
>> 2.30.0
