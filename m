Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514623BF9E2
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jul 2021 14:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhGHMNv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jul 2021 08:13:51 -0400
Received: from mout.gmx.net ([212.227.15.19]:59967 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231404AbhGHMNu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 8 Jul 2021 08:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625746266;
        bh=/S3KTEsWj4o0twJj5q9aPeNWOTcJAvPBNUM8nnIs/sk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=dufTARth9IPPZl4rXPKn6/85WewADwKcwZAIXlXR8HD/uTDbwyWKw3u6T2VRL/lFh
         zyGEnw1takEFYbS+DgXauCdUMAtjx8sIVNLnkPLyMdWhcEOGPV0TxXdhnwQRv3WkFL
         h0Gc6hjaJcRyRs8Uvxl7jyisezu/mbtahY4VWOd4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MysRk-1lEKK33NIo-00vtVu; Thu, 08
 Jul 2021 14:11:06 +0200
Subject: Re: [PATCH v6 02/15] btrfs: remove the GFP_HIGHMEM flag for
 compression code
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210705020110.89358-1-wqu@suse.com>
 <20210705020110.89358-3-wqu@suse.com> <20210708115410.GX2610@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <40b037ee-24e7-08a1-da48-3df4507c0e89@gmx.com>
Date:   Thu, 8 Jul 2021 20:11:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210708115410.GX2610@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+YiX4oW6SZkHfN8FtiJp1Ur7IhktWJjc+oB31+w++r2Y4Irg3Ph
 hexlAfmwsT+FhTxf7KjUOukYYS6+0qCQFMBBk8w6FebIwbZSooCSGHQfk1iSr2Dl6qdoLto
 DQo2sMF/me3GKHw4JUt4F6tgGLSKtudkqNVHTNMJmJwNTq9NAjXeDY1XBf2/EeC0MCN2cWn
 Uv6+jGpYUWhgoz1xNaANQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:50UnglClHU0=:zW4FYDBAFHk3u7zl+9mrGI
 oWwhK6PjEHOtjHeduKJIK1APTyGD6HVlkqitXxItogtpudQ5GIbebo3a+tj56laAthHKjZ/+8
 NnhrthYMwh5urc9oH9bUi9iIK4tGBZHHKlAIPPY/wBWpfSF75vUG7V74sA1KRDwggfxdYbBxg
 ztumKUG8+fBh9BbS6koW22/tvT47iPTNrg9tfrrXmQXmTjB0vt3cHvIhzYE5C0tNUca4ZzL0j
 sHd/TPc/RPC3JvT+3B9wguaP7lDezvz0s75aETniirpDsTgMtbVvaYVYK93Uqvrr54OMBbLx8
 IoZefC2wSkFfOiijPlihMWDWFErPH431sRRm3ykTqfDVaDDmVSDERQW9IMdQips6U77lgConY
 JhSNfUYqIedNe7FFrQh9DwaWYm7jmC3NMYUu77UldSmgydWuCXFV540Y6szn85J1ZPPd4ymaN
 nST7R45jvfvc/6NmH96omEDNchHbnb8JgevkzcLDA3g+yqID4myh+Cstz4zEz36iHGCxgXhBF
 4vzciGA//izA4S3pFVOeq5Etjc8+RW+ZwBVZ8oFZG3CKpdGKEKQDsSO5UHzWfoQ6lGCRo/avb
 LGPFHruuD09LriIaTQxjQ4ZMJFARNj+XXbnmSdCPiynFgfwBsUPYP1MyHY0A4lC9h1nupCfgE
 zPKQvAPkSAIqkD9cTGC4r8q6QNgy74pOiQsys+XGQk84W3J+qNHAQBG+aRYKdZjI+iqftjBHr
 5biiImkjjrbLNKFKk8QTTltRiKIxG1cK9PaslmF5nWcCpITzeEQEAtwn6GndBHplfueBiycl3
 jcMSgSB/CQ0pgSC/tLsXBio7jBSRjzeaTXK1a7jOJ/qSYjHgMqXKsv/iM8iwm4xeBC942edhQ
 uQJPezkLALnEjQT2FUPJkhe3o3tJf52uRlu/WWF85NxqYLLOwzsAXRU+aPcVaifz9QqxPvS2G
 3+IMBebFT+vVlLiNBZxQ8cxmslouMJcmScd2Y6YJGBh7RZrluW4QPP4LHqX6eJ38e+NflaoDh
 YU30twpyCor+23563gBbr+nR2bQVs5QaeKBMx+moquqXGHn+5W5p797V6EsT2T3Y+qT4BWBO/
 3C/P+g9t2AdFyo4Rf+tXLLjZW4t4qvvmjHz20qC+kiugWXkYEfR+smhlw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/8 =E4=B8=8B=E5=8D=887:54, David Sterba wrote:
> On Mon, Jul 05, 2021 at 10:00:57AM +0800, Qu Wenruo wrote:
>> This allows later decompress functions to get rid of kmap()/kunmap()
>> pairs.
>>
>> And since all other filesystems are getting rid of HIGHMEM, it should
>> not be a problem for btrfs.
>>
>> Although we removed the HIGHMEM allocation, we still keep the
>> kmap()/kunmap() pairs.
>> They will be removed when involved functions are refactored later.
>
> I've sent the highmem cleanup and will drop this patch, there should be
> minimal conflicts in the followup changes.
>
Thanks, that's great.

I'll update the patchset later after I have shaken out all bugs in
subpage compressed read path.
(Optimistic ETA, around v5.14-rc3)

As previously without a way to write compressed extent under subpage
case, we have no coverage for subpage compressed read.

I hope not to submit new fixes just for subpage compressed read path
after the initial enablement.

Thanks,
Qu
