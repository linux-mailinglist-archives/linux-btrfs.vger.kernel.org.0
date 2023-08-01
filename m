Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0736776A5D5
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Aug 2023 02:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjHAA7G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 20:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjHAA7E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 20:59:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A103FEA
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 17:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1690851536; x=1691456336; i=quwenruo.btrfs@gmx.com;
 bh=aSPc8Sbg4ozEA6L2dWiPe0e3sRriDloqacSFSwP+5BE=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=BnMOCUTVNKcqrlEW6fDH3F2Mko8tqM0zOANzSxK/qBMwR7MEXiN1qFFBu6ywqr08raZZ2y3
 1dT721fvPF/B/1xhMi47J7Okma8p6I4+169ExkMPt2akPi+PVrtln6Lk/eIEc3cbZgH4FKHOx
 2yfFXGASd2N/qbsuE6zKJPHnrrCXL5fXUArT6DfVps9nds3rNGBLMtrP9E7h2HK1oOka09egf
 7dhd/PYzMUVm+ByM2iJvxkZCEhBG3gkV0eW0tQfSEEQckPSK1Z09rBgVGtEeS3iaoC9Fr9v3b
 ZjlLTV/8R+ebDQsAuCVJuEoQ62uh3jPp9xLeOdwhqF4b19wkiBDQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5mKJ-1plkOK2Nyd-017DYI; Tue, 01
 Aug 2023 02:58:56 +0200
Message-ID: <d607847b-afab-2748-8a4f-0e675ab78db9@gmx.com>
Date:   Tue, 1 Aug 2023 08:58:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC] Btrfs: only subtract from len_to_oe_boundary when it
 is tracking an extent
Content-Language: en-US
To:     Chris Mason <clm@meta.com>, Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com, josef@toxicpanda.com
References: <20230730190226.4001117-1-clm@fb.com>
 <e6557f41-9c3c-628a-958d-057582f8cab9@gmx.com>
 <20230731070251.GB31096@lst.de>
 <c059da8d-b5d5-20bd-fadb-c6c241323cc1@meta.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <c059da8d-b5d5-20bd-fadb-c6c241323cc1@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Zyp7wlzjMH287coUB3gWsrDIQSTRA0X9PHvea5Z70FGypu8bygp
 Fm9rSMU9NcU61Of96QY07+d1FMTd1vq+9jTLkaGY3J/TZ3Zv+cP15Kh8t+tOUqudJrnh0TN
 fKqJ4T9xz/NTY/wI+ny9yf1nmIY7Dz71HUfIFrp3bNx+k+dLPUh2DCfSriv0yQ0Nk2sofWa
 8lNPCc6Dp+7BLrJUrnhbQ==
UI-OutboundReport: notjunk:1;M01:P0:SCIfRqU/2Oo=;fUnU976bs73LI20GthGEjNcbsoU
 cF00+jp6UWA/XrZG4BA0zWfNTWQgbY7rZRV7cLQhWtiT3XuFzDqK3LR8s1M6aBVDPgW87lEuX
 DcmfLbnRvVPAWFYywgpGmju8I67YyBWRlLj57uFfEvSxKTFrrXjGzWfi6GJK/iXCsqQQFYysk
 oCHL3yQcUxevBOr/q5QYsD3JdN6xrZwOep2/dRc5LeXnuhzK0IEGc9nG6mQqFZw1qaNRl/WRw
 PTC92GU6c77a1KdDQRvXDhCyJUSjQCQulzfSDWHXs0R3YZKDEHLuKTBgkscrQHOYlN5iiA4Ot
 JE7X5pJQUtXC5mwFz0CjjQ/DZTBL6a3LQcox/D5109hHsfSNMkhUhS2PsA8ztO0qiUZCTim1e
 o12ioGwUnZN/nzApg56IwxB3+l7/DOal3iypi/upebxDSwwI35tx7yNylbP5/81g5vsrK0/AM
 BOkBNEVrAvv/7TQVri3QKCbJ+i5Aw/X9LkaXOHfEdY7I6IwrySVaBiujwwoVb0JIrFLVVBReY
 jhd9jiL3W0dvU5ovzssiPulcuYwXE7h/3oRNyGdZyoW/E5Q0Gwgvcw0ffM/GK8DCgmAECajV6
 g3w/+BP2A8JAryopuT43/2OPAAsyF5G23vkG0f34+NF5mGlxMixhx6vr4Tf0c0wEjoM1M16pS
 QyIr5J5qrE24QBnWuLKU+0BKmkQBYvW2Ej6zDPKwdzkeiK27EH2CdjUT35iOElJ7i+nNZwZMZ
 kir30vgexEzWPwLA4sCUzRAvnUeNCvKXnzeZnAXBwpe0nY2uNobySM484XfyGd5up+A5TcdGS
 Sb+GJErFspqPDhvr1e+z8wnZmcfjOARHQkuZ7I7V8EUqHVL4/kkn7fgC8CGOAkR8IVlduQAlc
 e4Y6NfVwRzczW/AsF2PfB+xOw7KZjCpJwN67MwMQrqs7xpaAJDp1UJRKpDuL/SejOunIM8KFd
 H29cBeKm3esc+U8sLD4i6dKlcR8=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/1 02:10, Chris Mason wrote:
> On 7/31/23 3:02 AM, Christoph Hellwig wrote:
>> On Mon, Jul 31, 2023 at 10:27:02AM +0800, Qu Wenruo wrote:
>>> Personally speaking, I think we'd better moving the ordered extent bas=
ed
>>> split (only for zoned devices) to btrfs bio layer.
>>
>> That goes completely counter the direction I've been working to.  The
>> ordered extent is the "container" for writeback, so having a bio
>> that spawns them creates all kinds of problems.  Thats's the reason
>> why we now have a bbio->ordered pointer now.
>>
>>> Another concern is, how we could hit a bio which has a size larger tha=
n
>>> U32_MAX?
>>>
>>> The bio->bi_iter.size is only unsigned int, it should never exceed U32=
_MAX.
>>>
>>> It would help a lot if you can provide a backtrace of such unaligned b=
io.
>>
>> That's indeed a bit weird.
>>
>
> bio_full() is using a slightly different test:
>
>          if (bio->bi_iter.bi_size > UINT_MAX - len)
>                  return true;
>
> We're doing:
>
>                  /* Cap to the current ordered extent boundary if there =
is one. */
>                  if (len > bio_ctrl->len_to_oe_boundary) {
>                          ASSERT(bio_ctrl->compress_type =3D=3D BTRFS_COM=
PRESS_NONE);
>                          ASSERT(is_data_inode(&inode->vfs_inode));
>                          len =3D bio_ctrl->len_to_oe_boundary;
>                  }
>
> The end result of this is that when we get to a
> bio sized U32_MAX - PAGE_SIZE, both our len_to_oe_boundary and the
> bio_add_page() check will correctly decide we can only fit 4095 bytes.

Thanks for the details, now I can understand where the problem is.

Mind to add above explanation into the commit message?
Otherwise the fix looks good to me.

Thanks,
Qu
>
> The difference is bio_add_page() would just say no triggering bio
> submission.  But submit_extent_page()'s check is first, cutting the
> IO down to 4095 bytes instead.
>
> (I do have the stack trace, it's just a boring filemap_fdata_write_and_w=
ait() path off of file release)
>
> -chris
>
