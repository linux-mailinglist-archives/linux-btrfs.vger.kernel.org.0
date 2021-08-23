Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7157A3F53AD
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 01:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbhHWXfZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 19:35:25 -0400
Received: from mout.gmx.net ([212.227.15.19]:51759 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233182AbhHWXfZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 19:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629761677;
        bh=d59tLIRDiul/Kkv4JjYoWhkMh7lhao212hVFsC51F4o=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=PKiBsT6shamXAXggc+/62Bli+piO0V5acAUBMTWyUikKzoxNKqlEANzR9hICuzonI
         OIc8/POeYINjGYQBzrUdhab1frNgbgi7Cm2KNdF/Ab17jhYQeHZiZiBrLxNOvKBhXz
         i/2cJcCSLyZw58LrfH+wRC9hBI9USDXTxRKuECDI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MtwUw-1nAQc42dDQ-00uMgO; Tue, 24
 Aug 2021 01:34:37 +0200
Subject: Re: [PATCH v2 02/12] btrfs-progs: do not infinite loop on corrupt
 keys with lowmem mode
To:     Josef Bacik <josef@toxicpanda.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1629322156.git.josef@toxicpanda.com>
 <aaaf2cadf66d9e573e2dbcc3e8fab7984ce42f99.1629322156.git.josef@toxicpanda.com>
 <05f2cfc1-ab2f-0e92-13ef-488a9e7d716c@gmx.com>
 <20210823150408.GD5047@twin.jikos.cz>
 <029e900b-500c-937f-322e-1d64b3259355@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <d4ec5a5f-45c6-7d25-6137-b3206880763c@gmx.com>
Date:   Tue, 24 Aug 2021 07:34:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <029e900b-500c-937f-322e-1d64b3259355@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8bqM9oySeOJ3ioyJKClkiptg/N81meTzMRob1MOV4Iy2CbDmdBf
 vYOT0l7QDZKkCJfNUnlcr2nidQYV98AnkmEuxg0tjDpFj1Vg1xfQdtZ12sGPOVik2MBfF3q
 FT5eVmtaLyojjnN+Eu2R4+FvABFGBmL7EvidA/UYImpymq7afvbP/kCy8iB4RUpL1nwVAOo
 pGv9pRvfBeEcGRTU8BDpw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:StDw7V6hx3c=:2NcfXBjzqnojSBfOsNLYB/
 Fy7p93MCx0dWH/ppofFKU157Aw/Xq4Pe/hxeK3ludZoARkRVbQz56Pt00s5LZgjCQpG5O4Q3Z
 6PNGdktrq/3gB62y9VIz5IczFfiwt1cXthAPmiPRVl8ZHhAKKAg6BK7+DwQUy3TqiYRUlQkbq
 sszeeb/TYB775N+/My/z3vAIKNzrN2myGXb4gs4EvWnyi/vtlvnrSOMycn3ok8xt9qhxaqCGR
 jMXJBVEXe1gCnVvUqP2+lMst1rSnpEnsIaeQPqahlX/fO86p877bkfVVLP2NUulejXWh5rmP8
 hdMAQU8yk7XzdP/TuVjJOXNB0GW98wBwOassUi0SXC0XNhl/0sJUy6KtuMcl383A+z3UQ01Vo
 zSAZep+7xwxhGAs3jscyRTQr97plEbBjWuf0nPFEAeUFO8pZluQTVEA4Ioev5svutp2KNmrc3
 c9p/bU5i1OkWAu7CUpvhuw98IA3YIEDbPJI4GeKCjr1sFXniVKD4NlDbRBc//PeLcxZUKnieG
 snDLnr8IRbaZ/lxdSKDR2iesqXXg87Eq5YTzlVNBUt0GxecyW3lghs92SKw3Ym56nf88wutT4
 4tiHtnMZ8MwG0vb+iGYKj0pRYQGs/6ysst/9eFlQgag2ow+iZc4/GNfsslKK23u8YeA9VHnG9
 6/gkjem2aBDD27v79GHumDJLHLh8AL1HOG95PGI1KIxTW84oENY5YdJjIyWD3f1iYSC6uO8Pq
 BUB7VX33bOs2nalPMMCZyhxlI8EtMw/cSDFBKu8pjIG4ul+aJK8kK4bCMWIDxM0FUOUax6wXp
 m/pHpCvU1YfdCWDgxA03HnOjeepOZW4UXqj1tObPXuElK8UjuQaBdkWr4AQDf+v7/w+1SGaRF
 fZqlWTQL9Z7WiTuVSSPSNOCxU9nQpVwWom5VfsYG3c5eid0Wm8Ytr5sqjiQLFJWHMLLjteJvs
 A5rTnpdcBDPeg6CBtQ6CfKqpCEKpZjPlmg+aWbdMW22efWgy43GmgSNjbFzrZTNUKtOXZZPhn
 VrVTlcjHMseAztX51qCvazGq3cAlgbJOjyBLhUH4xnJtNQOa8DCp677yRvoA5JpFUJycwfKDT
 J7TM2AWo9DZt+KXWD2ulGZP41xi+6Y+nWzi7ollrrzklWvRAkHp3amJ+w==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/24 =E4=B8=8A=E5=8D=882:44, Josef Bacik wrote:
> On 8/23/21 11:04 AM, David Sterba wrote:
>> On Thu, Aug 19, 2021 at 01:42:39PM +0800, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/8/19 =E4=B8=8A=E5=8D=885:33, Josef Bacik wrote:
>>>> By enabling the lowmem checks properly I uncovered the case where tes=
t
>>>> 007 will infinite loop at the detection stage.=C2=A0 This is because =
when
>>>> checking the inode item we will just btrfs_next_item(), and because w=
e
>>>> ignore check tree block failures at read time we don't get an -EIO fr=
om
>>>> btrfs_next_leaf.=C2=A0 Generally what check usually does is validate =
the
>>>> leaves/nodes as we hit them, but in this case we're not doing that.
>>>> Fix
>>>> this by checking the leaf if we move to the next one and if it fails
>>>> bail.=C2=A0 This allows us to pass the 007 test with lowmem.
>>>
>>> Doesn't this mean btrfs_next_item() is not doing what it should do?
>>>
>>> Normally we would expect btrfs_next_item() to return -EIO other than
>>> manually checking the returned leaf.
>>
>> That's an interesting point, I think we rely on that behaviour
>> elsewhere too.
>>
>
> This is the result of how we deal with corrupt blocks.=C2=A0 We will hap=
pily
> read corrupt blocks with check, because we expect check to do it's own
> btrfs_check_node/btrfs_check_leaf().=C2=A0 The problem here is that if t=
he
> block is corrupt it's still in cache, and so btrfs_next_leaf() will
> return it because the buffer is marked uptodate.

Shouldn't we prevent the corrupted block from entering the cache?

>
> It looks like search does the extra check_block() specifically to catch
> this case, so I'll fix next_leaf to do the same thing as well.=C2=A0 Tha=
nks,

OK for now I think it's fine to have the extra check.

It won't cause any harm even if we solved the cache problem in the future.

Thanks,
Qu

>
> Josef
