Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3309E4742DF
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Dec 2021 13:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbhLNMqK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Dec 2021 07:46:10 -0500
Received: from mout.gmx.net ([212.227.15.15]:38749 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234109AbhLNMqK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Dec 2021 07:46:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639485967;
        bh=iyu6JJU4oiDfC8uDEhF014hZdlkQc+hrpQdha1OWQ9I=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=C/Ifv4eqfoInDmmH7/CzyA/JebFfaBmTXDXFhv/zq+FbLbi5pebug7odUQc9U/W6w
         4mv0G2uno/Sq/MSHTzZdI/GoYgAjAFIfHa2GSvSAChSqGz9TVj0FLy+YV3ByKeFSVH
         YO9DXXRbMzIZVAk+j2vGTDH1o5a4jbwaxAZYc2Tg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N0FxV-1mcxY11xCB-00xOO7; Tue, 14
 Dec 2021 13:46:07 +0100
Message-ID: <94148b8a-856c-3d35-5df5-dbbbcbdbc230@gmx.com>
Date:   Tue, 14 Dec 2021 20:45:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 0/3] btrfs: use btrfs_path::reada to replace the
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211213131054.102526-1-wqu@suse.com>
 <20211214124152.GQ28560@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20211214124152.GQ28560@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ce+LOjwkrZM73wnPhW59wYYBIy3P+vLPHwNmI0GK3QiFUdjJIii
 ORqK5TOIatfG96GBeZWDo5cmlfNFve83REKuTijjVU5xpN5R5PF/y/TLELZDmDl9IpzrS8F
 OP18bAg6gsq4krxGGkKCroNw1OBiCZOErH+KTmj8ssUrUXuuCTmuNKvsdHD6iS1YtSORSn9
 DNmzVlRlC7Gr3L+q3o0KQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Emjcf7ulfoQ=:EFsTf+jlEPGOLWWeNSyup0
 +vqzSL5pppO3yy2ewwJt64uSU12Y8iE2rKj7zV6kADP+Js60asRC70NhPhgJmDbBDEwJ2w9MO
 VhVVvZYvouNk/6DkTiJwYVocVdx4lOnGwPq6E4Th1BrLIeHwtypks++qI9c81+Ua83EwHrKkG
 cF7E9efzLJLTDCmOHQt7PXxGv/CJXZTG1rwfWzVgOvYlyLQ+tabUpQxAKK25omDtA5wvMLnXA
 KaAr5gNgQ432uelavm/N428FCVkfFD5c5dCjnzrAOxfymQkIw8c//TI+g3e+MtD/yg1FgbSge
 BFJqfgMGIikYuvMOaJidn0bT7RkN/rRuR/ifMOZViZEOSHmNCF1NSxLAAC7sR2n1A2vSQy+EW
 KunTjNrFNQ1xdMsaM1s75xnkSNyfBHQaIhUXjBW592iW1ZpH9So+SNHCcSZmtDmuNL9RyrHBQ
 9OEu8hizaZ8VUaeo6bzK5+zSW91yx186rryjvz8tE4zGxWH0J3Pp3QvTnlcH47ohNzjB1+RRK
 ghPXEy4QALEN/v51cg24WOc3YYKM++bbRjnKa3RSCu6vFZM5hri94uSzGr6TiYA/m1KM5XnNJ
 SvrJ0NstPrpEXJ8Gj8nws8Poip29E/i3FpbFc5YasU1G03WTt3dVkOeM3nP5sOv+R/UB6NaPZ
 Nl9F6QS1ejarYVQ/pdzL1inJm7ktod6h5FY1/75r3wkEVExuf6jwa9U1JwuO0BUdmFcz0zX8+
 pioxrzjJ8gGhFLB4tOZuW1wlaAUORAzzV0x9FwIh31LIbK3S0RporOHv+5lN4wrSGbL/1kHFZ
 nsX1JR1tdRVISMmJ4kp4A1pEMJ9HHZE3WzovSWax90cwlVu6rnNo1FD/+FTgSFUu9TpQZOrOm
 TjxTaQKAehf8+OEYOFab0kWEww2GZs1JMTDRq3//IfaS/e2ga1Zqb5P+xZdtaK5BGGjcTKSKT
 YWQjF61a6R4RokYYoHxczD9S9xg8QmR5gu96L7Bz3q2Wmyl+2vJ5dwh4Is2K4IPuQ40+SyuZP
 E61sJVQXkhMztxHO4NEBrG6mR/p/j8p3SH3KiHcyVSbUajeHqf1wGMPZhatkR3icrcQDUzPUe
 n9GbBaSQgMxVcI=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/14 20:41, David Sterba wrote:
> On Mon, Dec 13, 2021 at 09:10:51PM +0800, Qu Wenruo wrote:
>> [PROBLEMS]
>> The metadata readahead code is introduced in 2011 (surprisingly, the
>> commit message even contains changelog), but now there is only one user
>> for it, and even for the only one user, the readahead mechanism can't
>> provide all it needs:
>>
>> - No support for commit tree readahead
>>    Only support readahead on current tree.
>>
>> - Bad layer separation
>>    To manage on-fly bios, btrfs_reada_add() mechanism internally manage=
s
>>    a kinda complex zone system, and it's bind to per-device.
>>
>>    This is against the common layer separation, as metadata should all =
be
>>    in btrfs logical address space, should not be bound to device physic=
al
>>    layer.
>>
>>    In fact, this is the cause of all recent reada related bugs.
>>
>> - No caller for asynchronous metadata readahead
>>    Even btrfs_reada_add() is designed to be fully asynchronous, scrub
>>    only calls it in a synchronous way (call btrfs_reada_add() and
>>    immediately call btrfs_reada_wait()).
>>    Thus rendering a lot of code unnecessary.
>
> I agree with removing the reada.c code, it's overengineered perhaps with
> intentions to use it in more places but this hasn't happened and nobody
> is interested doing the work. We have the path readahead so it's not
> we'd lose readahead capabilities at all.
>
> Thanks for benchmarking it, the drop is acceptable and we know people
> are more interested in limiting the load anyway.
>
>> [BENCHMARK]
>> The conclusion looks like this:
>>
>> For the worst case (no dirty metadata, slow HDD), there will be around =
5%
>> performance drop for scrub.
>> For other cases (even SATA SSD), there is no distinguishable performanc=
e
>> difference.
>>
>> The number is reported scrub speed, in MiB/s.
>> The resolution is limited by the reported duration, which only has a
>> resolution of 1 second.
>>
>> 	Old		New		Diff
>> SSD	455.3		466.332		+2.42%
>> HDD	103.927 	98.012		-5.69%
>
> I'll copy this information to the last patch changelog.

Since I found a bug in the first patch, let me have the chance to
re-order the patches, and put this into the patch removing reada.

Thanks,
Qu
