Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096894FBA96
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Apr 2022 13:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244820AbiDKLNj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Apr 2022 07:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346040AbiDKLNB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Apr 2022 07:13:01 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE951090
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Apr 2022 04:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649675397;
        bh=Ass4UeakMOJWGfJSzFM6o57dHzI3uTTF016ginBovvs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ar4fMF08sAI4nqUM/7qyet1OHg+5MVFbV62+ZzBkvhjItFLr7qEN4FD5PKr7zHIs2
         GOzcVMsJuDcI6Y3tcrWhvCaBjjuBcEyQsT9RN994vBZWx46rwbm4QpWsXY3N5hSz6z
         vkGLDrxXFghj6pH/0RgCJUkuyeOnOQKZdvLhHHyg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MUGeB-1nW0873Qrz-00RLQM; Mon, 11
 Apr 2022 13:09:57 +0200
Message-ID: <fe62ec14-eb4d-de6e-b601-d275c3572ec6@gmx.com>
Date:   Mon, 11 Apr 2022 19:09:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 03/16] btrfs: introduce new cached members for
 btrfs_raid_bio
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.rutgers.edu
References: <cover.1648807440.git.wqu@suse.com>
 <a2f049f315b3c218d909c854ab117779d8842abe.1648807440.git.wqu@suse.com>
 <alpine.DEB.2.22.394.2204111227010.37905@ramsan.of.borg>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <alpine.DEB.2.22.394.2204111227010.37905@ramsan.of.borg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ggZuGumqEegTswIUeXPFW8dw4RGMv0vVEclBuhbkWDzWiyFUiC2
 W6tn6s7AZ9uATOJLwsvPtUg5FhOB1S9SDNZi3evzzvF1kS7/reQ2IEZF4+tXZAiqr2OspaR
 ObONQiqOACKgaBtogdxjq8hQc7QsKf08slVHZ57c6LeXU+v2nS8uTNhWfJ1dxVUVDtIwCfY
 Mqb5mF+0SPNK5UOZ93Ktg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:61rXQmOiarU=:nLgSbXP6SaAqVn+KMmD+Qo
 DJW0QntU3TYVDDKqnxYPBTPCtayU5KW4pwGVEMBuwn8DFwgGk9aZftrFvqpwWwANcD4Y3Kiu+
 ZLGMnP5o58A2BjTPEpr39OjYloNsdpOA7doF7h352Pv1TZcONB1fdtyPOcyfzfAVNrvT6y/Ei
 UPWgpczJ216AhTGSqdGldM7ePpHMay3AMD8dK2LKL6Wh7Rsmh3Ckj4ZoplyHwJU/Rl5eV543u
 r8P5+/qutDxE3PI7J8iV/HZNVBG0RT2Dj5altyDVgUXXPX7ZA5utFoqAXtOIv6WpY0eLrp8Zj
 qgK4h/0dpGAoEm9wrj/gR3nO8YhSiL5KneFzA3UaQBTqKwgqfJ8dR4QYSYpP8MgtYaoGCYrrP
 nH6GvKeXuUERZpV0FrVypX8+sADdR1+iNO+zLN1yJSr8HUykWi1qqC+jyNwILAhffrwEFtj99
 gkDA2UQ6EIRmUN2EC4qJhLC9PmY30Y1al7R50f5vNi9rD9YARPZ+XeKSqoXL/EEwjcZP+K3zd
 5xGFCdTTxY4VYXogEWrwceJrCz28/01klp3w1d2v2BelaxU+szN7IBxR6nBXkd23Pb1Rq8ifM
 gS//MGfSLQ7+AjqLsJgffpB4Ry8Eeo8+RDlmvq8r5KzebaZjSLLPz+QhmGtQcqcXg4CEz8af5
 DSR8mZJCRBsqjcERQrYv2cPB57ljtC8vTc32IgQ8JCgBvSKHXjCYzfVQTwbEOZ6EnkY0qn46t
 RJpy5ZoPxoV3SUm9ammzpxGzRGjnAj/HIDpRViyyg0Lu80p6CSavVUMUyKjjEcUkN7AZfiar2
 NiD2BqQ3gbxEB9JPSPuXa1azyCiiEn8xbiybeKMJLGLx+9RG0uZfeTDZu0bnz6WJVydp3d9gg
 risjNHSMhYmnjwbBX0bqbza4Ce788LOgXQdpSf8amt5LQ912y069aAiaKpmVn44xS1qlIuvZI
 9M0yuBsxzbKM7w1bZJ+dpFl4uQAj/ijipBKrX6WaCPeIAkt08oPL4CYyiHGz73pFFS6mW4lk3
 X6jKTU/NQ+CpEcJNnKjgjZi5I0zcHhzHgD+Zi0sf5VjOmH1HQgdUbbvT/T3XXr6E/k5dWfRcr
 lHRChMVhRMQDaw=
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/11 18:29, Geert Uytterhoeven wrote:
>  =C2=A0=C2=A0=C2=A0=C2=A0Hi Qu,
>
> On Fri, 1 Apr 2022, Qu Wenruo wrote:
>> The new members are all related to number of sectors, but the existing
>> number of pages members are kept as is:
>>
>> - nr_sectors
>> =C2=A0Total sectors of the full stripe including P/Q.
>>
>> - stripe_nsectors
>> =C2=A0The sectors of a single stripe.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Thanks for your patch, which is now commit f1e779cdb7f165f0
> ("btrfs: raid56: introduce new cached members for btrfs_raid_bio") in
> next-20220411.
>
>> --- a/fs/btrfs/raid56.c
>> +++ b/fs/btrfs/raid56.c
>> @@ -958,18 +964,25 @@ static struct btrfs_raid_bio *alloc_rbio(struct
>> btrfs_fs_info *fs_info,
>> =C2=A0=C2=A0=C2=A0=C2=A0const unsigned int real_stripes =3D bioc->num_s=
tripes -
>> bioc->num_tgtdevs;
>> =C2=A0=C2=A0=C2=A0=C2=A0const unsigned int num_pages =3D DIV_ROUND_UP(s=
tripe_len, PAGE_SIZE) *
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 real_strip=
es;
>> +=C2=A0=C2=A0=C2=A0 const unsigned int num_sectors =3D DIV_ROUND_UP(str=
ipe_len *
>> real_stripes,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_info->sectorsize);
>
> noreply@ellerman.id.au reports for m68k builds:
>
>  =C2=A0=C2=A0=C2=A0 ERROR: modpost: "__udivdi3" [fs/btrfs/btrfs.ko] unde=
fined!
>
> As this is a 64-by-32 division, you should not use a plain division,
> but e.g. a shift by fs_info->sectorsize_bits.
>
>> =C2=A0=C2=A0=C2=A0=C2=A0const unsigned int stripe_npages =3D DIV_ROUND_=
UP(stripe_len,
>> PAGE_SIZE);
>> +=C2=A0=C2=A0=C2=A0 const unsigned int stripe_nsectors =3D DIV_ROUND_UP=
(stripe_len,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_info->sectorsize);

All my bad, in fact when I crafting this exact line, the
64-diveded-by-32 problem is already in my mind.

But my initial assumption that stripe_len should be u32, prevents me to
do a proper check.

In fact, stripe_len should never be u64. U32 is definitely enough, and
we should avoid abusing u64 for those members.

I'll update the patchset, with one new patch to address the abuse of u64
specifically.

Thank you very much for pointing this out,
Qu

>
> Likewise.
>
> Gr{oetje,eeting}s,
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Geer=
t
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
> geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker.
> But
> when I'm talking to journalists I just say "programmer" or something
> like that.
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- Linus Torvalds
