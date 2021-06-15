Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954493A8C41
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jun 2021 01:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhFOXL7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Jun 2021 19:11:59 -0400
Received: from mout.gmx.net ([212.227.15.18]:50949 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229898AbhFOXL6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Jun 2021 19:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623798589;
        bh=LY8rEQ8y7z6i1gkGmoMXtPXAH2p3AHB/7zU2sT0cZQg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=QJslMDZrcKTMOHKItIe/Ip/dkMf2F9819iaoQ2AeM1K8krKHikts8tQMiO9Blh8Sb
         pO0Qdo+C8sGD3/H7TheKALlJp4vbNuZn+PXrmJpqam9uJazV5nW/OMfRysHbnTEVne
         4uLhUGERmK8QX3/CE8PjxmcsEav01pIv92ODq5ME=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MWics-1lmicG1wAi-00X224; Wed, 16
 Jun 2021 01:09:49 +0200
Subject: Re: [PATCH v3 6/9] btrfs: introduce alloc_submit_compressed_bio() for
 compression
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20210615121836.365105-1-wqu@suse.com>
 <20210615121836.365105-7-wqu@suse.com>
 <PH0PR04MB7416F076827A67A7560A341F9B309@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <88f89e31-b87a-4086-2bf1-8bea6c886b31@gmx.com>
Date:   Wed, 16 Jun 2021 07:09:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <PH0PR04MB7416F076827A67A7560A341F9B309@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1FnrmSTTiwvv66cQW5iboI53vJNCXbd/Rtsdyd+hO/BBYAcCqDo
 pqm5n7MRywer3MYJoKyONK1f9E9cKijJr7o2yk+sKn0rtxdjsWkhDPi/9fm5nI4WOL7swK9
 rimvLYxXnGTydPnlthHaR/ak2+Fy92YD8Xb4xPADsj27A/nStvy1gJ/NJZRBTA/5s6TnU3R
 WrEp6JQokXVi7n3leYXxw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:r64ytcj4Pdk=:E6TRhj5P5IW3L4b6a42QxW
 9jro1us/GpXzE7+FXDGK7VQe5/p0W+A/l5v4Uev3c3P+XCtmxfKadtn5yVDZ0id24P6KREQ4a
 HUKm+RM+ROs1KJAnbEDl/Xi8faqtIndHh6p0apYfEasZ6DBT+DBj9HpfYFoNU/miLVZotoK5N
 jgURDi7747enEyNhI78rfzkUp6u//XI4EGdziSi8IaXuDD9C6/2GhOjUS4mZciIyvqL3qlIx0
 pXjMeBMu2/XteQMuSCrILYExM97isMvTrNXCmhlba5ad2Fsl8W3iTFwUa5MBuCCpCy5Xe0xI7
 1UlTaP0y5YUCMyRoE3ebpQhKcIIur8vBbcjdYvYjI8Ig7ZLW4OrTZTBWTgeBOL2oiwYcGyDTI
 AB3fcocFukkoZ9velwvDn0++e+UKOxcdBlao0ZAz1w6cZnSIX3y+G/SFkLcgGh6jzNAQTJ7Oj
 1roxYTO7oVWPxEfdZHWyNe+qN4t/euNMWWrIcKwCI3irfWu77663z6Trbho/SYsgpXMIlv7kX
 NmMP1FAcsYGqy8/B1GA9HM0+/+toor0qfmO7f5QwQ225oyyJvyk2ERA1JjnBLXr55v4lI3MDv
 sDl0EakaNR1lmQAMpBWiKClwMFBE72r44YofBw0wtk4kFfOMb8LNTD6sPiO6TjffT3l/KD/GS
 2wcnerwcbUKwZor8pF/L19MSdpv3Se8aglgxBk1gZGuqD30gZOpK1FU6gGbZguirWysaEHfTP
 +KED5x8ReLEDf8AXCwSwecW1OUxP+wJA/r/BbA7PaJhuWzCb1TW1uP+pWLj16qFjUAuXBa/FU
 G5SshPl/xFndTtAWw+6t6WRioPtmfL70zE4QYrD2WG44WLWXJE6J6/x4BWZEZuTfFQW4yTcKd
 wqKGJGPu/fTSGz8XotVNY0dCgoL0rYldie/NcD5L5Gkx0gpjbwLvnur47pvZ4m7og99UngbYD
 vlnsxKBYPJ//B5FtCpvUZsrQKgAAncP95NMuYw7M342vmqQwXh1GBN4wPBdvte/79N2OTdLx5
 0+Zh5TNdYNgvOsxPgD8F1gpKb8/qJ4rj1zIArCzMEo3NQIjo3Oeh+nrnYeNCI/xDoYlBWs8Ns
 efws2dKrcYU3cLMpNsoUqF+8NRBnQ/5Oh/zw3LnapiM+GH3Qh6EqVphFg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/15 =E4=B8=8B=E5=8D=8811:58, Johannes Thumshirn wrote:
> On 15/06/2021 14:18, Qu Wenruo wrote:
>> +static struct bio *alloc_compressed_bio(struct compressed_bio *cb, u64=
 disk_bytenr,
>> +					unsigned int opf, bio_end_io_t endio_func)
>> +{
>> +	struct bio *bio;
>> +
>> +	bio =3D btrfs_bio_alloc(disk_bytenr);
>> +	/* bioset allocation should not fail */
>> +	ASSERT(bio);
>
> Here you write that bio allocation shouldn't fail (because it's backed
> by a bioset/mempool and we're not calling from IRQ context).

But alloc_compressed_bio() has other error path, namingly
btrfs_get_chunk_map() and btrfs_get_io_geometry() can fail, thus caller
still need to check that.

Although thanks to your mention, I find that I should call bio_put() for
the above error cases before returning ERR_CAST().

Thanks,
Qu
>
> [...]
>
>> +	bio =3D alloc_compressed_bio(cb, first_byte, bio_op | write_flags,
>> +				   end_compressed_bio_write);
>> +	if (IS_ERR(bio)) {
>> +		kfree(cb);
>> +		return errno_to_blk_status(PTR_ERR(bio));
>>   	}
>
> Here you're checking for IS_ERR().
>
>> @@ -545,10 +569,14 @@ blk_status_t btrfs_submit_compressed_write(struct=
 btrfs_inode *inode, u64 start,
>
> [...]
>
>> +			bio =3D alloc_compressed_bio(cb, first_byte,
>> +					bio_op | write_flags,
>> +					end_compressed_bio_write);
>> +			if (IS_ERR(bio)) {
>> +				ret =3D errno_to_blk_status(PTR_ERR(bio));
>> +				bio =3D NULL;
>> +				goto finish_cb;
>> +			}
>
> same
>
>> @@ -812,10 +840,13 @@ blk_status_t btrfs_submit_compressed_read(struct =
inode *inode, struct bio *bio,
>
> [...]
>
>> +	comp_bio =3D alloc_compressed_bio(cb, cur_disk_byte, REQ_OP_READ,
>> +					end_compressed_bio_read);
>> +	if (IS_ERR(comp_bio)) {
>> +		ret =3D errno_to_blk_status(PTR_ERR(comp_bio));
>> +		comp_bio =3D NULL;
>> +		goto fail2;
>> +	}
>>
>
> same
>
> if btrfs_bio_alloc() would have failed we'd already crash on a nullptr
> dereference much earlier.
>
