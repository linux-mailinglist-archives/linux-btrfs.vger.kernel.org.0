Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B0C3D7348
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 12:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbhG0Kcx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 06:32:53 -0400
Received: from mout.gmx.net ([212.227.15.15]:42783 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231745AbhG0Kcx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 06:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627381970;
        bh=k5o2x5l7Re4yJTSFP9wbpda2Lfi1DvEVwOkBNSxtzFE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=R3DUlftJ0cekauWZ+SBZXeSI+/ZNkC2MBMgcM30VNrwEciz4XiY2C5NNTNZ13O6/8
         42bwvNovkAexw+P9qwK7Gh03RZ/fQ036ht913iQQV85aTalzoAgbQQPa+kfIZRNOxu
         uuxqNIehZ1D3UdFJ42MjXrGS47A433abVvW771Cc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N49lD-1l8DUh0l0b-0107wt; Tue, 27
 Jul 2021 12:32:50 +0200
Subject: Re: [PATCH] btrfs: remove the unused @start and @end parameter for
 btrfs_run_delalloc_range()
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210727054132.164462-1-wqu@suse.com>
 <20210727101509.GP5047@twin.jikos.cz>
 <1c41b21e-4900-eab2-8f01-8e54245a570e@gmx.com>
 <20210727102417.GQ5047@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <e107652d-f69e-6fc7-9fc8-423dd74e92bc@gmx.com>
Date:   Tue, 27 Jul 2021 18:32:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210727102417.GQ5047@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j1NvIFTR7EtPJvbD5PF4YWtR1pe1l124ziFkdN7TXr5NbQPVTKo
 t633RKB4kgI0qFARnvzuKutKfyu2rfIE7rIAVz4R28SceCy0jVmc288A+byF63A5q0B3TJm
 4rT8mUFtWSwvhSCf9WdqeYL+zjOdYpSUtLCw5ni4dBNQUkF5Htp/gAImNk9QaKI3fSnuUIz
 XYeVN8OLD34XDNedV7f7A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qYpZ4eezUw4=:ffqsXLXVug8YmnJdEC/82H
 nPpnFh7ZrfzkKo4wvZ8/qCnpaqDGbuk0xl++3GAioOM/CFP/FHOYI0+Jho1DC/w/2PhlJIYBv
 jrNJEH08hfOFYlQzvmuFvkF3CyL96EaMVkhS74eQqH3euK/dTAQxw7peMZa8g7FxI+2TbtYdL
 jZKMeWCiuyN/g/ntkMmdlPJQcYBWAmxOlvLTHrOVn18wROcZQKSAW2caGD/vw4v4UMPKaHVBs
 FVXxzMWdvY6pK2AYmaTMa/Q1xaeDq2IPADaZhHrdXFzz31E88MCgv45ax0uHRE0+NsXczUfhQ
 dt7vZqnH/vNtHKNA2ltkiWLPbFUUYeQBIEeM5bTvB7DoepPCiF+8WqpalxzbP+8dWrcFlJyoM
 QzazuNCm2j9X1GATMfGxOzN0/+qa57awL6yTnoTmipizPU17aspP4cDN7rhLM9oV5z1JasPi2
 PSVrixCIgHBLS+KNqzafneNk8qXvKXxELsrG13TlR/PQ1cWH7hmG3qTGjN3f425xMJYrnf/H+
 YOem/kuR6M0kfAhgNVBB5RUkFOiv4Vida5/UXpzoTdarMXaxzPFeGf7+zjqVZIcr73mmQjG2/
 4FWIfcuYILI2Kg/4cziGDG/i0S4OrQK0uhPw1v18NfC+KsSBPrtaqBaXzNPb8yjPt9Vqf/nCv
 k4cTbgF+PZpZ17eEmZn7jx2d9y2MbuRDQJ7EbNviCkL/nzz+AM5Fmw05vEOhEk32ldNr3NtHt
 i4yL/qXaAlMKmmEweT1aIOyvoGLwi/2YzwWUSa8U95cqXQZJVIr4n1aE1wc3TzADALY91Hphp
 2qwUg8KuX491lQ1oX+TevyChxC2T3aYm9ioyNeOBm3bLP7ZJBMuOv2m00A8KUchD77Lc8206v
 Dr/CtmUPNledZuUz/ciOhIpbVTbVOu5GXfdGAVym5tlmLKTtAAAP2v9PUsfRYZJtcOEecFYLe
 tz92029RWV4gZKYDJK/F+/UZzivAbCmVOb70GUxUXl7d1Tcu7jNusrH8Jeum5WndX3mhr2gPc
 QLPICVDD/+C6k2Qjg4r5lj1MuNeX++2DZVs7ktcVeHu41yMGgYVPIQNHFicrKjd7YLez3vSOA
 J48H/KM2AhDv8pNvQazmKGHKhta3yEJXTYJIgZHJp3inkcCJPtRn4nzqQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/27 =E4=B8=8B=E5=8D=886:24, David Sterba wrote:
> On Tue, Jul 27, 2021 at 06:25:07PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/7/27 =E4=B8=8B=E5=8D=886:15, David Sterba wrote:
>>> On Tue, Jul 27, 2021 at 01:41:32PM +0800, Qu Wenruo wrote:
>>>> Since commit d75855b4518b ("btrfs: Remove
>>>> extent_io_ops::writepage_start_hook") removes the writepage_start_hoo=
k()
>>>> and added btrfs_writepage_cow_fixup() function, there is no need to
>>>> follow the old hook parameters.
>>>>
>>>> This patch just remove the @start and @end hook, since currently the
>>>> fixup check is full page check, it doesn't need @start and @end hook.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>
>>> Then at least start can be removed from __extent_writepage_io too with
>>> the following
>>>
>>> --- a/fs/btrfs/extent_io.c
>>> +++ b/fs/btrfs/extent_io.c
>>> @@ -3828,9 +3828,8 @@ static noinline_for_stack int __extent_writepage=
_io(struct btrfs_inode *inode,
>>>                                    int *nr_ret)
>>>    {
>>>           struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>>> -       u64 start =3D page_offset(page);
>>> -       u64 end =3D start + PAGE_SIZE - 1;
>>> -       u64 cur =3D start;
>>> +       u64 cur =3D page_offset(page);
>>> +       u64 end =3D cur + PAGE_SIZE - 1;
>>>           u64 extent_offset;
>>>           u64 block_start;
>>>           struct extent_map *em;
>>> ---
>>>
>>> There's no warning because start is set and used.
>>>
>> Awesome finding!
>>
>> Will update the patch to also include this one.
>
> Hold on, that's just a small fixup but I'm not yet sure about the
> nrwritten removal correctness.
>
Yeah, after looking into the code, it looks like this is unrelated to
the removal, thus it's better to be an independent fix.

For the correctness, it's indeed a little complex, so take your time.

Thanks,
Qu
