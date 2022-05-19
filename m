Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A13B52D175
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 May 2022 13:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbiESL1x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 May 2022 07:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiESL1w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 May 2022 07:27:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE98337A30
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 04:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652959662;
        bh=cWvBMK+vxK11JyNuBVkpWw0WuYW0TWyB+Wehembkhv4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=g/w3ysB1oXnVfoCEM6l6MYu3JphPLYhF7ZoEmvxFKjqjGTJBsy2KaOSbdklO+Bi4O
         YZ0gnDxDRiF+xP8MTWfJPYz/z5o++dBUe4DT1DHJx9dFljIb2Ngk5Klt2w2DijtFV8
         Yjc4XO2+gLItYm3eTiCW4BbiRSEkghSqzL7ZiKeo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MhD6g-1nMSR52hWs-00eJq3; Thu, 19
 May 2022 13:27:42 +0200
Message-ID: <28c36dab-c02f-281b-97a0-cfbe2c6ac850@gmx.com>
Date:   Thu, 19 May 2022 19:27:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 12/15] btrfs: add new read repair infrastructure
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <wqu@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20220517145039.3202184-1-hch@lst.de>
 <20220517145039.3202184-13-hch@lst.de>
 <e2c4e54c-548b-2221-3bf7-31f6c14a03ee@gmx.com>
 <20220519093641.GA32623@lst.de>
 <d99b2ba3-23d2-0ea1-9aa4-13a898e77ab6@suse.com>
 <20220519105023.GA5891@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220519105023.GA5891@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yQq6uPUj2jSfghX52Dn6T2hu0OqYEt8jNOf24XYeeGQbTGksO0e
 lSIaNQmBJ2ndzRpMZKFM+D+nPHKSzRsj2DP6JsftLkJM+N/S7nGQ3LtdbZHuV5tzbRAhkzc
 bsB3f+tjGZ/mOdk3dfT8NI0sOzKsuve/KAfVK/7vU/vfYyth7/BtVswhSCcpfzi9m8CH3kB
 rmep85beZiD7YO8amMhBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9/lQ9Vs43UE=:0yXeMUqgt3n2G/I9ruqI3R
 kxY2XwRj6YRlOKW7yloBJVAOBfSyw6VmjttnaFEWPMRRqJKWbdDXST9uThccyuXN8yz/al8AP
 ww7IEuJqDz1DAfbM00pFDmhKSZeEGXEhDwoScxOu39Q+YdsFeMUbhN1pmdZjeodhyxYL0cTcQ
 KGIHWpBwJf/tCHsz1wdUQwHQIWKoHw8Uyoq+MgfgnNmoAxiDUUIpq028k0iiDkFa3q8M/95ir
 S+6FGN+e9h7MwcmE2bBtOFHCRMl98p3IfSlvAYKjCmt9W01abhW+dEG62BbJ+TBER7FxZECB9
 lAmav8tmmwEotzPhLMTHWcrh+6uCoe8BcuSzHOMQO7XK1XpgJmuxm2Moexs59NwzfQmqQpUH3
 zOvP6JbPG1sT2uGjPFESdBT0JbsFt+xKL2Ad5iQdzolRg4D7ddLKWDm2BkyR03dqGvBJFT5nf
 1v4DP+O0LgdCut92NeGGDUig9NfsiXbk9X01icIxnLMOH7a31OXc2M7zSo4f9PId4Om/bwot8
 av812f2os/9d3EZifAczN9RkMiwayGZVm+WTG7ubTHLBbaFxxl+NZ6WIZ0AtJRjj8YC7f/TvV
 N1fMXB3fKocAnQfoFOjUWjdUP6/Ks9+6kFv9OGGFmbY2ETbUVVnFOsI4jTGP8+l4JFd7J3Mdz
 plKNGhkUJQ9iIsQA9ijbqzNvq1Alrie4Jp6BUodC4t6B0oKBgYoNhh7LVmgKR3m/jngDo/a2J
 Td/9Zyc1IbrKdXEzZVPCJx+IAAxtXaFjV6HR6E+ffE9FfZNgQYMeL3ptHUOe/OrWD1jRlzPX7
 nrXXbOeM//83g71Mqiy8FOrdaVvty+mUanVPX8ogl2hY2uPPtAQYZNkfbVXthnw7F1bhxBXXN
 WzqNBTn7jcHgmI1+O9SF8Hg7h+eyLXyJtsqJtFfuJUs2/T727DGIRkRvXe9ricc+flRIIiaDw
 1Z5Rd3ouRY9kmiDJ7SM2/SCMWIDLna2/oqdU8JSjyVeVHYNuebLpB2Q22moY8RJSp8b7P+o1q
 3DbLSeKaO246O06WK1eSaF+nm1++P5YMUq/wA3XKDiULw6lLYs5tiD7pV9Xf4JaiHerrIxLaY
 uxxLg3sUE9OYtWDwVDFLerCFjx/yhvFDv3TYMF9M5PaZHrnJhE8o++sMg==
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/19 18:50, Christoph Hellwig wrote:
> On Thu, May 19, 2022 at 06:41:52PM +0800, Qu Wenruo wrote:
>> So in that case, the best solution is to use "btrfs-map-logical -l
>> 343998464", which will directly return the physical offset of the wante=
d
>> logical on each involved devices.
>>
>> Although we need to note:
>>
>> - btrfs-map-logical may not always be shipped in progs in the future
>>    This tool really looks like a debug tool. I'm not sure if we will ke=
ep
>>    shipping it (personally I really hope to)
>>
>> - btrfs-map-logical only return data stripes
>>    Thus it doesn't work for RAID56 just in case you want to use it.
>>
>> Despite the weird extent logical bytenr, everything should be fine with
>> btrfs-map-logical.
>
>
> Oh, nice, this is much better than the hackery in the existing tests.
>
> That bein said the -c option does not seem to work.  No matter what
> I specify it always returns all three mirrors.  I guess a little
> awk will fix that, but the behavior seems odd.

Currently the copy number is only used for -o option, not for regular
chunk mapping printing.

Thus we still need awk to fix the awkward behavior. (no pun intended)

Another problem related to btrfs-map-logical is it doesn't work if the
range has no data/metadata extent there.

So Nik is right, we need a better tool integrated into btrfs-ins, other
than this historical one.

Thanks,
Qu
