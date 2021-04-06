Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E367355FCF
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Apr 2021 01:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245309AbhDFX7e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Apr 2021 19:59:34 -0400
Received: from mout.gmx.net ([212.227.15.19]:34575 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235884AbhDFX7d (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 6 Apr 2021 19:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617753554;
        bh=3Q6Vy08Ffm+YDMhrEmMpU7ZKFO5t1qsBM3DelBKEsgQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=A1uRrbCJ6Rcd9A48pz0ksHiv+KrW2RqK4x1+ElnpmlXCIMnYKT9VDfSHNpqaIZPqx
         bYPr9AaukI2ECu8IjL9Z/HkOUXPiKLjNkTwJdW8AWBRE26gXVYzOxqVtaULk8ToXDx
         XPvCgAQZl+rs/hyNICrPKylA2IpdFZF2T49o1n4A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M3lc9-1lUkoU2yXb-000r7X; Wed, 07
 Apr 2021 01:59:14 +0200
Subject: Re: [PATCH v3 00/13] btrfs: support read-write for subpage metadata
To:     Anand Jain <anand.jain@oracle.com>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210325071445.90896-1-wqu@suse.com>
 <20210403110853.GD7604@twin.jikos.cz>
 <aa1c1709-a29b-1c64-1174-b395dd5cd5de@gmx.com>
 <10c3098d-94e3-7cdd-030e-bd4ef5061163@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <edd99fcf-8821-cc76-7b20-077e2f38869e@gmx.com>
Date:   Wed, 7 Apr 2021 07:59:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <10c3098d-94e3-7cdd-030e-bd4ef5061163@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lQYymsmOhwwVYeAxhmtsEXiiL2qyyNvyKKDcNXbO2d0QkRbNQIz
 JCHr+2JCDJwC9m61a7AW3q2EfNdMXj+egOl1seIPj8PorCYuvdL4t06+u/7ZIP+B/uuSHJk
 caKCaDa174pYpgzmsskHNbobWqG/fhNvlHQTJH5mZYhWUVlaZS8TdBbwixbJG0JhjIq4ayV
 LZuTp/NKdZGXgYYd2R8NQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CPyPSVn+Mkg=:ULaQC+56EMZjhl+O/OqKVN
 dln0N/U85bSdbHNccgz9DGSxElIZATYopxSjfii0BHZdfjDlSxX5ycmA05EOe2NS6Gz1PweJw
 B2ijWvh11258KUsWcVB9/Ae0+eTb5uQUkr/IdQMPJaqMNEKEmoi8FtIZpNrhdk71/BHHk5Za0
 qZVIDZk5YwKCYpUjdrZx91Mb2qFrKW/qJR4K3waX3fIAyisTBjo2tP4hZYBxTvEoLF/x3j8pZ
 frb8lTMBNOlmgYwaKOaE0Bwqn2XBe6iEo2rOKtB105Rs93idKftsefubAHne/3hjydO9aVH7f
 RrrPX/bdpGpwD8u9B6uzPSew3mIYAS0GFyVF6P5j5lNhIjg+PDQsUZ7B5z0nhDkVd8ws9YbWT
 6yukhEOCazp1ZlTnpOCmQOqw0QYXsWZfMt8i098P4aVnEPhi9chSUVJbySPCskfq0OCAaMxKv
 2vfGiwVyXaaWl8N7XbJCdl/oavlg4WwiAXgsgH2OkntmDcO/RCaRMZghrgi335FOdmjdOt30h
 bSGY45pwa6Ec6ru23JgRbNn//5l5T5GOXj3qLa15xLAzQntArLlfCKJEA8vaM5XsPDXEVv9zI
 mE86Ww6VdqQc7pf22bTyB8QDaEc1brMMqjSkkoeovVojp4Qni4URbYn3jNhB7Gx4VBCq7buxv
 ti4TLp2Fe9JVRXDlvzXptWJXoZ9UZ8PZEU8c3n4C2pEux6L1LzcjTf5gWuOKTNX1EfQgAVxfq
 VtRNhQrmNeyW322IdWcTXZjDXD2JYhh8wH+2ylRwX940tnMXbHma5AwpWV5hjIqVqEtyZoorm
 ybJWmkaD3GqlsVBPkM3P5kDc0VvAwJsbfX55KGRMsvu8DCqjY10EhZ/IRCSfDDyjnnKdxmga5
 1lHFco1Mqqc8zvN58NxQIVEcf9a21K82UwEq3ij8pyfYVIwNP3l3pwHmrsbcRTv1XJUYE42Vk
 ovwizGV4raT738ruZjkTTsPIrtQGDkEuP8ysxeJ93+q8VdchKP72cn6mjmveHc0uOOgpYSrDF
 IknrF5j48lj4sm5J/woaiHpcFwdhFrAlzLndr+hQYsSmbOMrlz+v0b/FLgdcApYoIEU2C8gQv
 1EY4N37wcP4zGfusUKUIeWG1JU2qxoQEy56MwXXDCPmnacitCtplsE8nXHNis255M9QYcLG9p
 YgFAASgtR9l/H9TLV0m/v5PDx02pTTQoetldRhOCAka1qdHAW0VCWrbIn/uoSvcica6/D2jwY
 CERTt9xqQDbWsiU/J
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/6 =E4=B8=8A=E5=8D=8810:31, Anand Jain wrote:
> On 05/04/2021 14:14, Qu Wenruo wrote:
>>
>>
>> On 2021/4/3 =E4=B8=8B=E5=8D=887:08, David Sterba wrote:
>>> On Thu, Mar 25, 2021 at 03:14:32PM +0800, Qu Wenruo wrote:
>>>> This patchset can be fetched from the following github repo, along wi=
th
>>>> the full subpage RW support:
>>>> https://github.com/adam900710/linux/tree/subpage
>>>>
>>>> This patchset is for metadata read write support.
>>>
>>>> Qu Wenruo (13):
>>>> =C2=A0=C2=A0 btrfs: add sysfs interface for supported sectorsize
>>>> =C2=A0=C2=A0 btrfs: use min() to replace open-code in btrfs_invalidat=
epage()
>>>> =C2=A0=C2=A0 btrfs: remove unnecessary variable shadowing in
>>>> btrfs_invalidatepage()
>>>> =C2=A0=C2=A0 btrfs: refactor how we iterate ordered extent in
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 btrfs_invalidatepage()
>>>> =C2=A0=C2=A0 btrfs: introduce helpers for subpage dirty status
>>>> =C2=A0=C2=A0 btrfs: introduce helpers for subpage writeback status
>>>> =C2=A0=C2=A0 btrfs: allow btree_set_page_dirty() to do more sanity ch=
eck on
>>>> subpage
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 metadata
>>>> =C2=A0=C2=A0 btrfs: support subpage metadata csum calculation at writ=
e time
>>>> =C2=A0=C2=A0 btrfs: make alloc_extent_buffer() check subpage dirty bi=
tmap
>>>> =C2=A0=C2=A0 btrfs: make the page uptodate assert to be subpage compa=
tible
>>>> =C2=A0=C2=A0 btrfs: make set/clear_extent_buffer_dirty() to be subpag=
e compatible
>>>> =C2=A0=C2=A0 btrfs: make set_btree_ioerr() accept extent buffer and t=
o be subpage
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 compatible
>>>> =C2=A0=C2=A0 btrfs: add subpage overview comments
>>>
>>> Moved from topic branch to misc-next.
>>>
>>
>> Note sure if it's too late, but I inserted the last comment patch into
>> the wrong location.
>>
>> In fact, there are 4 more patches to make
>
>
>> subpage metadata RW really work:
>
> I took some time to go through these patches, which are lined up for
> integration.
>
> With this set of patches that are being integrated, we don't yet
> support RW mount of filesystem if PAGESIZE > sectorsize as a whole.
> Subpage metadata RW support, how is it to be used in the production?

I'd say, without the ability to write subpage metadata, how would
subpage even be utilized in production environment?

> OR How is this supposed to be tested?

There are two ways:
- Craft some scripts to only do metadata operations without any data
   writes

- Wait for my data write support then run regular full test suites

I used to go method 1, but since in my local branch it's already full
subpage RW support, I'm doing method 2.

Although it exposes quite some bugs in data write path, it has been
quite a long time after last metadata related bug.

>
> OR should you just cleanup the title as preparatory patches to support
> subpage RW? It is confusing.

Well, considering this is the last patchset before full subpage RW, such
"preparatory" mention would be saved for next big function add.
(Thankfully, there is no such plan yet)

Thanks,
Qu

>
> Thanks, Anand
>
>
>> btrfs: make lock_extent_buffer_for_io() to be subpage compatible
>> btrfs: introduce submit_eb_subpage() to submit a subpage metadata page
>> btrfs: introduce end_bio_subpage_eb_writepage() function
>> btrfs: introduce write_one_subpage_eb() function
>>
>> Those 4 patches should be before the final comment patch.
>>
>> Should I just send the 4 patches in a separate series?
>>
>> Sorry for the bad split, it looks like multi-series patches indeed has
>> such problem...
>>
>> Thanks,
>> Qu
>
