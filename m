Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8768C60BFB5
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Oct 2022 02:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiJYAge (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Oct 2022 20:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiJYAgH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Oct 2022 20:36:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E31F45208
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Oct 2022 16:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666652556;
        bh=cJew7ZTZxhGTPpgUD+UiKIppMXKzaKvSq5ttNrhHlOw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=BTyePoAA8w1bUQliLozKyPNQ14ZsbnbbCmGT47mUEOxll3aR3oEIhs5tboTyX8+LW
         YlDkuC+tLdwiODuytBoDo6YW4utern7sHJ0/LhcqQbFC0A7oZjBPgRFEKS07vfYoPP
         /co2jPlZp0+Xz75eze/FOO4xXdepbEVXlGjciWss=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MqJqN-1pQ1zr0DQp-00nMkx; Tue, 25
 Oct 2022 01:02:36 +0200
Message-ID: <bd3446e9-90f4-c05d-c438-968a2fbe1cde@gmx.com>
Date:   Tue, 25 Oct 2022 07:02:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 00/15] btrfs: make open_ctree() init/exit sequence
 strictly matched
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1665565866.git.wqu@suse.com>
 <20221024134742.GB5824@twin.jikos.cz>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20221024134742.GB5824@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qZpDdvl5mZylPjOp5EjpWYjS4dnxU4Qpi5llOMYIyrujAyL/r2e
 /oT+xwISesIikkIoqqT7uP8YamGON0PJBog4CfcCxK5rQA5QFh4MCQB2nD4MHpZAFuUa/Iz
 0N0mcJk2KJWoOcGEYvsWUx1Jecg8F/6p0FdBg7nOQDEbgm6Hf+Fx/bADHUVIt54iJEbXlMH
 oFWYaJjoQ4Cvm6zb2BBlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E/SKZ+E+COs=:3Id8DoxP2V4ofAXMiZyXxv
 qLR2B549En1cu++LyXp9PHF/6D8ix0sLW42wF0TwHyiv/ILSzYgF03wiPdvB6yqc1l0yOiQG3
 NcpH1/5G39TEJOH5b2Gdur3kVzA1bKXs1TqkEgVXBJ4alq1OOK46GDfaH4+MQKUccD7DVLwDq
 CFfCwNKyxt2zk2LQ+lp6zLVTlqSK2bSA7mbFcQjRM1eMJmPDVvcorelDz+FTiQJKd8JOeuSVZ
 WJUqj/3dDnRxnAZKsN5Aag6QwE2tzUAwDORLH0sv4KJFybQ6FSD5jJz+XPKItCBFI7+Oc9jKh
 5CbQSOuOHiGCIGEaKu1VMeCN+c+9TWZCTdlhlnTsGVjjrDC3g9qUMdfIKUn1vJgn4dLN6lOfd
 OcMmSFMpPzILrsUv+Fnjw7QyJO+dW/XqwxZ3maNvbLKEavOTsfkHyTvUku3eMO7F1oDgXaFmA
 zt/3uJts6iLkdUHPrCYMUyWUron+/HNXjiKhsmVXGTXz3LuvC4A9Vbrbo4rTVhSZx8TXvkdf4
 fajNoeZNlE4DRVLQH73Dh6YZR/EdwJco6IdZz3VxpwYFja0G/36pP0JoqZhow6op7+mc2phMT
 Nliy62WM3rUzpmfVdBzuwLK1SaJgaQWPuKpImdNCEO+HIMEAeMwbfmtL6gSyP0h+WmPnBDxmH
 Gcx8LHeS5JkfW7/r2eAzQRUck/RuQt5VQpYhZEKe+Sod2uUZ1BukA7V+gmtak35FNr8Oupg5y
 IhzbG+5Db3NXuHGpnbZtqdrp6AaUH09GdfLnZI0S7U3kNtvBpkg1dG+o2KQYteZxm+a89h62j
 GEie5EsdODwdDJ6d5rwgRRgxMPbrmzR50wuhU1ra7Wk+Ce/H4yutj3XMKyaSgGTFGvbArM8gq
 mtkoM7h6N29Y5OrOUsJ/Pg5LZVFsfG8T947hSIJYv+Ji91NwkaHS7njhcdtJqq2iD0e4DILqv
 +/Iow/Bp5H5rKdsDqpqQBrSFfTzMzXqvWY4IE86vLWHpp49zDGxJUMVYI3i6zLBR2idSpbpad
 Kwpf7tLXRLGvpN0mjsHhfD8RHbIzg8MLOS8TLKLBuDsxXb62c7Ijfzi2trMUIy2qwxQYJamcM
 9LiIV+5g7GtKfOgs9pToZumGyFVgyn5cNQO0t4B1SAvTTneiOfa+HjyCXMjElDdKxayrKCtKZ
 5+tG1mzDsx2ltCXHx4KWf0+5/Wb6pl2ISBa+rVZ5cU1sL9BLbO6eJaAR9oIJfLOhrREiMY8qU
 /AVEcdpOxjnVkm8paaQdlYiLoV9jjOKOY1jgWQkeMtfJiJACb3/3FS5RlDkwc6u6bTw+YEj1+
 Qr4siudP7FpJ81I81e1oEDaLuOnPU76zQIyjD9A5Vd5szTaBTGH4+WtL7drGyHjyoGs+b5Dzo
 jrPPtutcxjCBgZT6KcaJ2RC/83d4rhEkWiZ3E96nTFfai3y1QpjER+c3A3SAbsA+BBobNJ7TJ
 c+9ei0fentcommO0svTcKjadpmygtjtaRzO5K+cIBfgymJsj/gfZkl4hqsIypYMSoyXViw6VJ
 L6R2+W05x00VARb/Xazy/ZHYCXZcAOZfJNJ7zxHyB+rfD
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/10/24 21:47, David Sterba wrote:
> On Wed, Oct 12, 2022 at 05:12:56PM +0800, Qu Wenruo wrote:
>> [Changelog]
>> v2:
>> - Rebased to latest misc-next
>>    Most conflicts comes from the new function btrfs_check_features().
>>
>>
>> Just like init_btrfs_fs(), open_ctree() also has tons of different
>> labels for its error handling.
>>
>> And unsurprisingly the error handling labels are not matched correctly,
>> e.g. we always call btrfs_mapping_tree_free() even we didn't reach
>> sys chunk array read.
>>
>> And every time we need to add some new function, it will be a disaster
>> just to understand where the new function should be put and how the
>> error handling should be done.
>>
>> This patchset will follow the init_btrfs_fs() method, by introducing
>> an open_ctree_seq[] array, which contains the following sections:
>>
>> - btree_inode init/exit
>> - super block read and verification
>> - mount options and features check
>> - workqueues init/exit
>> - chunk tree init/exit
>> - tree roots init/exit
>> - mount time check and various item load
>> - sysfs init/exit
>> - block group tree init/exit
>> - subvolume trees init/exit
>> - kthread init/exit
>> - qgroup init/exit
>>
>> The remaining part of open_ctree() is only less than 50 lines, and are
>> all related to the very end of the mount progress, including log-replay=
,
>> uuid tree check.
>
> I'm not sure it's a good idea to split the open_ctree to the sequence if
> initializers, some of the code looks like it's not isolated the same way
> as it was in the module init/exit. The readability is IMHO also worse,
> verifying that some parts depend on each other requires jumping in the
> file. Maybe some parts can be put into more helpers and we can make the
> exit sequence robust enough so we don't need tons of labels and the
> whole can be called regardless of from where it would be called.
>
> This is similar to the array based approach but keeps the code in one
> function. As it is implemented in this patchset I think it's taking it
> too far.

All right, then I'd manually fix the wrongly matched tags.

Thanks,
Qu
