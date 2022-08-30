Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F485A6F72
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Aug 2022 23:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbiH3VtX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Aug 2022 17:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiH3VtW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Aug 2022 17:49:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B288E9B5
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Aug 2022 14:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661896157;
        bh=PY9GJMqMwvSPMulWPC+2s2hoa7n6FYfmt0vnGUzGrLw=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=KtbBqWfgAYWLerRaKsTUK3JEdjiUgC1XS5ZSk13xG6xrobgpUOlBgjDYY9IS9J78D
         nLwtV+d6YgdbXGPl4DBlxknuF4kmnFu8yKZ5M1eykAlctJrns7sNkHFLR7wugsQfO7
         tLFAxb0LyMv4sKqAKxWHSKL+Us9SNpt6HnBEZ1dQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQ5vc-1opEKK1gRc-00M4pU; Tue, 30
 Aug 2022 23:49:17 +0200
Message-ID: <72b31d43-07fc-6126-b326-5110315ae342@gmx.com>
Date:   Wed, 31 Aug 2022 05:49:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] btrfs-progs: fix eb leakage caused by missing
 btrfs_release_path() call.
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <043f1db2c7548723eaff302ebba4183afb910830.1661835430.git.wqu@suse.com>
 <20220830171730.GB13489@twin.jikos.cz>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220830171730.GB13489@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ShqcYSUnWtd+F0ER96/uDdfKY/LhcR2jFWRgq2I20ZIZp2AUpVT
 IKtMaNI8gCj5enHioMed+MPbaUtiAWJlO3ceF3Lh/LwoK69ci8LrtrukT/1jAYx5QDIt+Gy
 ZZGBDP7cfq3mRVh4fR8rFAiRfLNoF8eY7DmbX/Ccf/eDFNDvxXN3HGZcLz18bZyevDCXeeD
 bTMhaosSTES8UN/ch9qRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6njysmsMol8=:rIl3jXQjeqzcsud7k7BE1c
 QutFz9vEMFFI4YPFUED/mmwijbVqNMTjsMbjUhP9g8pr4wGj3GuzkH5eHVzvfFhDLPLNkQrHE
 sg3bJmPXdBSfQE7ua4YkquP5H1QY5iX5cHUbSSJFirTQrhb0Z6EY7RSUgeP2tOMy2HN1nVO18
 fh4SYsErRY0hr9bUSh5g78PvKrpjvS2EfcgWsbq7/QCi/QnJU0m7l05ImUkxB8GhqKbWh8hR8
 etY90jRy+02Npqdy3h4Nut3mk0mOZr7WZSAzK0MpY4QH5l+8Dz7bMQexM5nlWXdgmHCxMLsPV
 E4OBqK41aNJryCxyvpcB2yuOKIuXVmGMmMchcd8JfwZgwP78rHfyqnh31cJQe1VxrBXr3t7DS
 LDdYchQd5KxY3zyGjurmvkmtxHTDIiDnldaknlj2oyJEgSP3twTY+BElar1tGdPk+OYk1+7Zm
 JtdSc/qRLNnn5UZghu+zFSjYR9zBNeIqqtwhEf+wvY+OxfK0ULWgh+w71RwPXiDciZE+ycrkU
 fKaszPBx3cPip4RNU6RJQxqyf23+23aHHvRVD/xv5mJIHIvIttga0LKS94lulopkIVVxWDPCi
 eyNWN+O6OLHTwAWs1s5GtiQ4ls+CxaUYYnQBomPfI8Fbt6FxOxhXlqv7Sj9WjbiCbZigxsO45
 Z3jKfA744lNQIVkIyV7MAW75x1t/YitKqMegY6spf/xaOUyeBI+MTiuvpvVAjxVBXdAk9eyu7
 BXxTTfzGTBwHW47IYKNvORfeuIOuUOB8yqs1oeh0JAcbrAfWL5oFNGbOZYDvBTFjBjv1aThsu
 N1PzjnbaqQZWPCR8Ej+RS86v2nH0ma53VNjTS9k7JYNJHiy+N5arQrBAW/84WORBAeDHJwURO
 sJtzUsX5lKJxVlA8NLYc/e9SHpsKh4K0EdiCA2xsya+bZyFs50wrJ6968tp0vGKDk1YKJ3gUX
 ElZ2cPyPBUlamVVm/B7QQWFlx+fy86JuJfxidchU6TyX8nUmI4UWFRSsX9XOXFrUGBwJ6HxQI
 tDzbuUI90yTMNYC4YIjbLpdn06do876QmwlJ7c4ZDAml1oXxbdiTKNtKMCB8aI8M/XMBzTJ7H
 bayzVg2Li4nc71Uo0v6YOkT4CpuMGYxI8qd7MxOGEDR2JQaR9WV5/PzNQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/31 01:17, David Sterba wrote:
> On Tue, Aug 30, 2022 at 12:57:16PM +0800, Qu Wenruo wrote:
>> [BUG]
>> Commit 06b6ad5e017e ("btrfs-progs: check: check for invalid free space
>> tree entries") makes btrfs check to report eb leakage even on newly
>> created btrfs:
>>
>>   # mkfs.btrfs -f test.img
>>   # btrfs check test.img
>>    Opening filesystem to check...
>>    Checking filesystem on test.img
>>    UUID: 13c26b6a-3b2c-49b3-94c7-80bcfa4e494b
>>    [1/7] checking root items
>>    [2/7] checking extents
>>    [3/7] checking free space tree
>>    [4/7] checking fs roots
>>    [5/7] checking only csums items (without verifying data)
>>    [6/7] checking root refs
>>    [7/7] checking quota groups skipped (not enabled on this FS)
>>    found 147456 bytes used, no error found
>>    total csum bytes: 0
>>    total tree bytes: 147456
>>    total fs tree bytes: 32768
>>    total extent tree bytes: 16384
>>    btree space waste bytes: 140595
>>    file data blocks allocated: 0
>>     referenced 0
>>    extent buffer leak: start 30572544 len 16384 <<< Extent buffer leaka=
ge
>>
>> [CAUSE]
>> Surprisingly the patch submitted to the mailing list is correct:
>>
>> +	path =3D btrfs_alloc_path();
>> +	if (!path)
>> +		return -ENOMEM;
>> +
>> +	while (1) {
>> ...
>> +		if (ret < 0)
>> +			goto out;
>> +		if (path->slots[0] >=3D btrfs_header_nritems(path->nodes[0]))
>> +			break;
>> ...
>> +	}
>> +	ret =3D 0;
>> +out:
>> +	btrfs_free_path(path);
>> +	return ret;
>> +}
>
> Please don't put diffs into changelogs, it confuses some tools that
> parse the mails or patches.
>
>>
>> So no matter if it's an error or we exhausted the free space tree, the
>> path will be released and freed eventually.
>>
>> But the commit merged into btrfs-progs goes on-stack path method:
>
> I do that because that's the preferred style, but not all people respond
> to mailing list comments so we're left with unfixed bug with patch or a
> unclean version committed if there's no followup. Or something in
> between that could introduce bugs.

Another thing related to this on-stack path usage is, do we need the
same change in kernel space?

And do we prefer on-stack path initialized to all 0, or use
btrfs_init_path()?

Thanks,
Qu
>
>>
>> +       btrfs_init_path(&path);
>> +
>> +       while (1) {
>> ...
>> +               if (ret < 0)
>> +                       goto out;
>> +               if (path.slots[0] >=3D btrfs_header_nritems(path.nodes[=
0]))
>> +                       break;
>> +
>> +               btrfs_release_path(&path);
>> ...
>> +       }
>> +       ret =3D 0;
>> +out:
>> +       return ret;
>> +}
>> +
>>
>> Now we only release the path inside the while loop, no at out tag.
>> This means, if we hit error or even just exhausted free space tree as
>> expected, we will leak the path to free space tree root.
>>
>> Thus leading to the above leakage report.
>>
>> [FIX]
>> Fix the bug by calling btrfs_release_path() at out: tag too.
>>
>> This should make the code behave the same as the patch submitted to the
>> mailing list.
>>
>> Fixes: 06b6ad5e017e ("btrfs-progs: check: check for invalid free space =
tree entries")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Added to devel, thanks.
