Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213DF3800EB
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 May 2021 01:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhEMXhF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 May 2021 19:37:05 -0400
Received: from mout.gmx.net ([212.227.17.20]:48735 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229460AbhEMXhE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 May 2021 19:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620948952;
        bh=BBmutGXATj2xy518sbnZasP2WsObrNSBD1f9jXk13vk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=G+fzZzSd9C+uX1G09YVQAIeSc8d9sjYPVD4KmHEDsuDjq60DTGxv30GhnN9ouLstA
         sHXgy+TUOW0rsqA7GGlwdWq/O30PxADdeRuEcKo3vceO9TznFFXEfmG3+o9kWSQvnt
         Mq4Zh1LqeBMeuCtIGQVexWCqO52aazCFOBF75PBA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTAFb-1m4kDQ1uEp-00UXdm; Fri, 14
 May 2021 01:35:52 +0200
Subject: Re: [Patch v2 07/42] btrfs: pass btrfs_inode into
 btrfs_writepage_endio_finish_ordered()
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210427230349.369603-1-wqu@suse.com>
 <20210427230349.369603-8-wqu@suse.com> <20210513230646.GP7604@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <c01eea5a-5aa1-8f8e-cf0a-0da60f6d61b9@gmx.com>
Date:   Fri, 14 May 2021 07:35:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210513230646.GP7604@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XgnLDrkXroDPfVOJ8+nzTBMmbigeNjVpcuy1/iy3s3ZlXUbnf1j
 VTxutZ9rUaYssmONf4UvFWmdR9HU4hJ9Rm5MoJtU7jYA/DzXAzMLxaAxTaj3i1EO5FNkB+S
 w/YikDQ/pN6ozaERBHSIN2s9eL7aEIYRp3AjLHd0jJ2miX9vxJASF+h5qh9ZPpPttSyBbRd
 CyitFq4GqxrZe8eHQ+UOQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Hi5zjwGrUYU=:a+hov+8mk7d3fV6FS+tVNz
 SgPymIB49Y1JjrPrOoDWHfWDJP/RJAj3uggdMDPyOckPU08D0dRcQEXbZ7kjcOyXibnTMiwJ9
 3MrMTT7KvwjlQ+0rHk10+J4hJMM1ZDyNMp4c7VT0zdqwdeyfg2pVnL6BveOFSkwODpcwVACrV
 Cb5m98+pW6HdHX+hnPmpz8RXnJ3JUyVR04MmSm5UQqmRgRegIOInyT4lGpZxxj7P+1eDoLY7c
 AfO45P24/vGotRGWuIDelr++Of6Hl8AtuKkWIAxfVWFbBL9bn2KFpPWJXC1sdnV74yoSRPWb4
 lwCkRaY/2YitDd3pelw+cRtZ1kyyutv78PAYvvFedNs/22q4B6bPRZMzaGyXnitqFv02QCVSR
 FnLAedBlrmdMXzl/vfOd+UWAljG70iUX4wKEAPD4t1mRPb6Ea1WAW79UAj/wOeQKpegWlHpaO
 kEeSja5XxO0tx8cSXx0qdnkVi7sTanU0h3H684/FJuyzL5zrRGrhaPWUk/LEFW4nqysE4vH5+
 iV6twLAStcdDdmbA80jmKq00Wz+Jjd+bk0zvVcyt93b6JPhkbkkfowvbDKmm1+SytzFOqa26T
 KlqC7iAEf0S7+uhNs80HvDOLTxn9vWWPz+DykQUjqDK1cc7Jyk76ZosiR8tSATUOeIC1Zn0hO
 T5WIOHmYFoDk2WKNG/MsC8PGtypxAKQllhzYMGg8LIw6krjl7Wx7gcbUHhRuER4AqmaDvWz+W
 8uOj7g+Xss+j3Fkghvv8tPKzJgIe3RCkPbbld1o9BimP0OB39LC0uIys6S3uo/elpWR6H4bi2
 IQRaDHuYAV5J94XlP4BMBiAntSmii0ldP0gIIoyJdpKliQn1hKUJh5YY57pxXtvulMHIaLH3c
 wetTqRyR0djCsete30dc9tlpGyzny68eGqn6YiVAcBUaiUcuscMnaYfRnMU/OVMiS0o2s7OPh
 7g8OLLvEaU57Rc1AohFgg8UWHqJ9xfK8Un8YipZm7fp/at3blnH82q/W3vKQVZgmLQpFTfkWF
 XMo6WAh/SbMFzUfn3AlSeYsixXJXG2dd9M0dkxlkgttPQoUM7lwZ8ke8l+vtaYXXppt0owqgf
 /16s4TZ87tyliSW1IheOHSmDOy8c/+nc70LbtU74XFOJ0t4kAEJGsi3m4YhHkoXWGfnm8YnMd
 ZNcYIeyyK8k4X5tT/AgcWXpJDH7DGEsHEuVEyAgJb+Ryizm3lH8Dd0TtDRG+rhwS+bVlToeTy
 fPod0fTOwT4A3+rbn
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/14 =E4=B8=8A=E5=8D=887:06, David Sterba wrote:
> On Wed, Apr 28, 2021 at 07:03:14AM +0800, Qu Wenruo wrote:
>> +	inode =3D BTRFS_I(page->mapping->host);
>
> This is an unrelated comment to the subpage patchset itself, but I've
> seen so many page->mapping->host that I think we should add helpers
> wrapping all that, eg. page_to_fs_info or page_to_inode or
> bio_to_fs_info etc.

That makes sense.

In fact the usage of page->mapping is never ensured to be safe.
Especially for DIO pages.

Thus a proper helper with extra ASSERT() for page->mapping is always a
good idea.

Thanks,
Qu
>
>> -	TP_printk_btrfs("root=3D%llu(%s) ino=3D%llu page_index=3D%lu start=3D=
%llu "
>> +	TP_printk_btrfs("root=3D%llu(%s) ino=3D%llu start=3D%llu "
>
> I don't think the page index is useful, so it's fine to remove it IMO.
>
