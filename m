Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90BB226A2B3
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 12:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgIOKFZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 06:05:25 -0400
Received: from mout.gmx.net ([212.227.17.20]:60957 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbgIOKFU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 06:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600164316;
        bh=kWpfk9WZ/bEvQwBCF+XHh5T9P2NDxcVQIdduhI2YNqM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=I+XPPt3rfgC/eIVU2HvdEfqx014OejWxMj4HylJwIoi5MhgXQKNAgSThk03Bf9o1n
         t/ajEePAfQsVAOysGxESPVGV2atnzYFPbhPxDSR5XrwszuJ8XnkwUB+ljp1e1qktpK
         PahBV2gYnyew+iBS3AXBe5rreXY45zNQdVixr4vQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5G9t-1kSGfm12Wb-011Bqx; Tue, 15
 Sep 2020 12:05:15 +0200
Subject: Re: [PATCH v2 03/19] btrfs: calculate inline extent buffer page size
 based on page size
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200915053532.63279-1-wqu@suse.com>
 <20200915053532.63279-4-wqu@suse.com>
 <acd4c9ff-841e-1449-7253-222d5469967d@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <7e36f34f-2f16-a771-9a3e-9dcdae8db878@gmx.com>
Date:   Tue, 15 Sep 2020 18:05:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <acd4c9ff-841e-1449-7253-222d5469967d@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DUf27DWCBYBcWBQD+EKSGNIKNBXqeg0LwprlU3Trr/TytMN8VDd
 T3MmiKalcWuco9jAB8viMdOx5iGJ89u2I/SuZC4JEqYBGlnfwnSkR40CxAmCMK5r2qXVdss
 WYLTk/PE2MOx3MFFcEsEfQKOtcYUh2elrHrwAk0jdnzhDoXIZft4qlWLB+nj/OcEekfQkdx
 TvC07G1LdI0vWoAv3Du5g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:D69bVwQYrj4=:V1sTt4oL0AAUqB7hlbkkqs
 Mk2Tsn5PDE1QsPnNfzy1rqeT3nQMcS+uo0tGiCtKiUm+IpI5myZC7NWjQV54V9C9h8SHsPB3f
 x4dZh1EsUXwCjNOjiMO4+yMUMpBEyp3WJvKh0L48AQ073H7TA+bLtGqtFQTIexTM1DrR7Q38U
 TgcQayJySpZBiHEgbeYcvOQDx+UEIjv91HVUInNeRm2/c7vnGkPjiGbdkXxEqShKjK/qkiNxh
 pb5cV+M0+2Y2SLuchaXbtRfTLjyUQx0eIKPrR05GEEz5CI3qLOhq1ZxN08H1SBs15xpm9XL4S
 gUVcUlkc/F+DBqf8IUNXI4LUV6guF64DCf2CPDYWw9BA2mvhjSwBwLbr1lLPRCNBs62fBwZNU
 MlMnc0zarwqrcBrFB/l51+/XCC7vU8vO84ztpgaYsNoBv/lUGwOiDocvUUnRCxqf7IhvB5BLX
 hIymRCBg8xcKF5Ab0J1zKdwKiX8pKGO7Y7vUn6UUjV/Sm7Ufqcfpkf5TIOspBz2blHKdxu5EC
 uvOFbCrx5RSCmqqi483kVDWEV2YxHf9+LNst5m6PJiKqS2fOpqcaGiRbqk8suT5uJc299iM/F
 Tkt/2zg0zblkLX+a+ndykQMRkBAj5o1hdBOkEDl/5VkNDSO+FOVvc3mTmhmudqORxNZsbGaB7
 F4nlQYG+h59R9iNw3BPDhCkLqipODThzqk+YjjgkvKWZ95yBMgwBZ18qZ7NRz5Lp/M1ONHCux
 gez9NC4B0dO9h9eR+fhizSanv9QRfw6/3Q0pWBHa4oUMwaFkYpFNgWyBB7HV/kc/RTXbTMcfY
 cQhUWeThyTffhT7uVd9o+HVtCeOSINjN4h/t3/Fxm9gRzMjn4qp2cVtDhbFT+JnvU7dNyXo2v
 LZUukmyPV9lUXidLkfvcxbxxPxcSiI79A+CcIhjk2PUSnUkAHghLY8RrWtmKZV6GOwhVGSMlI
 Qr2XNedAIpZVpVTHMT64C9oi70R0ObEjcfobXWsClZ9p+spH7DT2aKL4N7Hin/0/8vOAUPXbP
 EhXFexBW/K+djfkdBgaY99MPVw3m3KWuIZH1JVnuHmpnTN6/CIucflFnACPswwwFNhZZaww/E
 bqmqRev4t7Svzi1F2h3ZVFRHTsUPw3c5JDMsUlCq7gslo7AG5Bt4s0FfsrblLqZleAERnJLgX
 JkMdetua4PmeqsewMkxSjTJhXWjOIJRO9tipFgwcqQpynvRCkiDY1+Q5iUx3+kHZVkDglP0tq
 T6ptmSvtgFek9fC3HWDim0TLgVdOdAC+xqXyIlA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/9/15 =E4=B8=8B=E5=8D=884:35, Nikolay Borisov wrote:
>
>
> On 15.09.20 =D0=B3. 8:35 =D1=87., Qu Wenruo wrote:
>> Btrfs only support 64K as max node size, thus for 4K page system, we
>> would have at most 16 pages for one extent buffer.
>>
>> For a system using 64K page size, we would really have just one
>> single page.
>>
>> While we always use 16 pages for extent_buffer::pages[], this means for
>> systems using 64K pages, we are wasting memory for the 15 pages which
>> will never be utilized.
>>
>> So this patch will change how the extent_buffer::pages[] array size is
>> calclulated, now it will be calculated using
>> BTRFS_MAX_METADATA_BLOCKSIZE and PAGE_SIZE.
>>
>> For systems using 4K page size, it will stay 16 pages.
>> For systems using 64K page size, it will be just 1 page.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
>
> <snip>
>
>> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
>> index 00a88f2eb5ab..d511890702cc 100644
>> --- a/fs/btrfs/extent_io.h
>> +++ b/fs/btrfs/extent_io.h
>> @@ -85,9 +85,11 @@ struct extent_io_ops {
>>  				    int mirror);
>>  };
>>
>> -
>> -#define INLINE_EXTENT_BUFFER_PAGES 16
>> -#define MAX_INLINE_EXTENT_BUFFER_SIZE (INLINE_EXTENT_BUFFER_PAGES * PA=
GE_SIZE)
>> +/*
>> + * The SZ_64K is BTRFS_MAX_METADATA_BLOCKSIZE, here just to avoid circ=
le
>> + * including "ctree.h".
>> + */
>> +#define INLINE_EXTENT_BUFFER_PAGES (SZ_64K / PAGE_SIZE)
>
> nit: Instead of doing this it would be better if this define is simply
> moved next to BTRFS_MAX_METADATA_BLOCKSIZE so that every define relating
> to eb's are clustered together.

It would be better to only define the macro in extent buffer context.

We have put too many things into ctree.h so that we hit such problem in
the first place.

Thanks,
Qu
>
>>  struct extent_buffer {
>>  	u64 start;
>>  	unsigned long len;
>>
