Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5DF03A387D
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 02:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhFKAUh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Jun 2021 20:20:37 -0400
Received: from mout.gmx.net ([212.227.15.18]:48993 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230331AbhFKAUg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Jun 2021 20:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623370718;
        bh=DJ62jdJlthUQKmE7zSbUcwJkYyDVp6rwFqWrjnwB2AA=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=IfrIuoekFnx+opizTQdwASrinIjbaxGcqqeFaUqHpiB7L1Z0sj1pOZmih8V9JXnpZ
         HBdTXL/7E1YXI7Rhryqj8WjK3eRIS+XmmDViQluf7XHbjeBdUAi5mGq3QdLiPIZlA9
         rJcJi+JVAoZ4NcFPaAUDWS1nVXaH6PrXjDmbch2w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M2O6e-1luEy00P6s-003t20; Fri, 11
 Jun 2021 02:18:38 +0200
To:     Martin Raiber <martin@urbackup.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <01020179f656e348-b07c8001-7b74-432a-b215-ccc7b17fbfdf-000000@eu-west-1.amazonses.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Combining nodatasum + compression
Message-ID: <80834345-2626-a0a9-c3ae-fb2cc9435b49@gmx.com>
Date:   Fri, 11 Jun 2021 08:18:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <01020179f656e348-b07c8001-7b74-432a-b215-ccc7b17fbfdf-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r12gxZ2FyK7/jqVWM/PM47tqB52Ng0NLt4xBbrqKKQ8CH+CR0uV
 SgQCsHzgPAIajT1FbJ93SAsOENVhJV/s78keYZnu0+fdsMyRlkszQAFrelJnQUJwBzz8MOn
 BALEJxTmX+Sy39/58rmjrb+tbQdFIdnN+XQkg+LyzNE6jl6z3HZrDCqFvzWdN4hD8cMRQnw
 iT2hsk+oPoPOtpZeI/E1Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bMEzUh8EsMs=:rsjqtLhURf/KVbqKsdrW+F
 cAaRoEbwryUDgc3bHuceqWgd9wEXpa9MyvHehdYEc/dSb8hA8PJSAckaZIdqjcLUAp6amPDkl
 9dPVaPMoZhWdaNlPrGrnLtKPHmSjiu2fG2O2W6OT6CnpS/VH3OHMIAVtj4NfjM+ZX7+eESTlB
 2MWgoLyvBbT2kZLtDHQoocBIGutOBnchHXLrFlnFKliLommBnTmcbq32//VsoEX70cGVkZLH2
 QM4WusFgKAy3WIN1DBxN0gH0tb0UiPkARUDowOXls/6vU1lb2+9kcaKIjdVU+VfCeX7pDuhUg
 VtQ6UKRkuGhXvp+H71obsXwTjPs9OYCtBUytdU7DAOElykueVmvHIIdZg+0i3TRgYRrP/dAZ9
 myWRu45/f9WB4iKwdLBpHF10iUU7WpQEaMpALxToUU4CNldVCGqcE+9vlONaMlwzH9PkEabu1
 7fsRp0QYtIRrFO1QGtxOTEe1Uzn8OlAREPU4rlgdXOeqq8rldTHwjI9tl588NAcTXHNAfQuP/
 t5LASlUVoB4Q8z5Yr2enEtbMw0/Caho/deqN+8MF1/2ygqF0MN56y1E7ymZ5HpYNCAqSfxoao
 K/tiRhmdAjo3TEaW+QL1E7HALSrh+GEsU5yVjY17Pw4WzRC8Jt6OWwanExosa8+G4gx0lEJBg
 77PJdahulT4jPok5YGoAYP6wtZc2VFrpGVKSsvenju0Y2ckiunqUU290vwRyy2TelgWRp9Kcw
 8mEiEaH2vtlaOgR4jYuU81GJXj0JRwCdpAWkOj3L1cVcAK8sd0Fz1MsmlyT19wqewYzryDEu9
 Yaf1lvxWHF43FdFnPfeMmMmrOU5DtzcSl6sWYeGR3r25FcjOSp68P5k7xOsr214LlrGYFwX/0
 MyxquA5sfw+SxIZ+tIHvmbLYv5ocR7u7ofLMeIc2vtzwYvJs+0YqarBG9vwqNe0C2sYjgmwPF
 FsFXXpdk3H6tbiqs9QUFmb/5PH8VEAKO54RlqZiybfEmt0pJaIqkyzIdl1GnOXOBYbpMZXIR8
 mNBiqFrZul8t9X0kFyezQQjH+qL3boOCU07+l7IybVZus78iGjHlXQYFKZjYnxcnFwFXChena
 dNu4Yz9KAYJjrpclTjTtcc0xpONOeYNxAc2VbunyGZOzAPzfBTPfqX3/A==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/10 =E4=B8=8B=E5=8D=8810:32, Martin Raiber wrote:
> Hi,
>
> when btrfs is running on a block device that improves integrity (e.g.
> Ceph), it's usefull to run it with nodatasum to reduce the amount of
> metadata and random IO.
>
> In that case it would also be useful to be able to run it with
> compression combined with nodatasum as well.
>
> I actually found that if nodatasum is specified after compress-force,
> that it doesn't remove reset the compress/nodatasum bit, while the other
> way around it doesn't work.
>
> That combined with
>
> --- linux-5.10.39/fs/btrfs/inode.c.orig 2021-05-31 16:11:03.537017580 +0=
200
> +++ linux-5.10.39/fs/btrfs/inode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2021-05=
-31 16:11:19.461591523 +0200
> @@ -408,8 +408,7 @@
>  =C2=A0 */
>  =C2=A0static inline bool inode_can_compress(struct btrfs_inode *inode)
>  =C2=A0{
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (inode->flags & BTRFS_INODE_NOD=
ATACOW ||
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inode->fla=
gs & BTRFS_INODE_NODATASUM)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (inode->flags & BTRFS_INODE_NOD=
ATACOW)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return false;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>  =C2=A0}
>
> should do the trick. >
> The above code was added with the argument that having no checksums with
> compression would damage too much data in case of corruption (
> https://lore.kernel.org/linux-btrfs/20180515073622.18732-2-wqu@suse.com/
> ).

It doesn't make a difference whether it's a single device fs or not.
If we don't have csum, the corruption is not only affecting the sector
where the corruption is, but the full compressed extent.

Furthermore, it's not that simple.

Current code we always expect compressed read to find some csum.
Just check btrfs_submit_compressed_read(), it will call
btrfs_lookup_bio_sums().
Which will fill the csum array with 0 if it can not find any csum.

Then at endio callbacks, we verify the csum against the data we read, if
it's all zero, the csum will definitely mismatch and discard the data no
matter if it's correct or not.

The same thing applies to btrfs_submit_compressed_write(), it will
always generate csum.

The diff will just give you a false sense of compression without csum.
It will still generate csum for write and relies on csum check at read tim=
e.

Thanks,
Qu

> This argument doesn't apply much to single device file systems and
> even less to file systems on Ceph like volumes.
>
