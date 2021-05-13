Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291B93800E8
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 May 2021 01:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhEMXeR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 May 2021 19:34:17 -0400
Received: from mout.gmx.net ([212.227.17.21]:35597 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229460AbhEMXeQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 May 2021 19:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620948783;
        bh=51v77/pSanp8L3Ikpi8dkPZNkNs+CkI8QdrxaDc5qpw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ZXMbJvwcD/uUS1u7cGcXfgsZmwM9mkax38Qd0zEmlmKXFbwqKy1S+6j3Y41nzLURM
         koLLNoItwVLRGNEZmBOE0Z0XTso3y7MKo2la5EYYAEPDvF7Q2QJS/tCSiaJK0Y8jeA
         8BCKLu8HJZ0M/qJT+kAEGH5kAmt8jJhz32HwXUBg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MxDou-1lJ3mI45ai-00xdvm; Fri, 14
 May 2021 01:33:03 +0200
Subject: Re: [Patch v2 01/42] btrfs: scrub: fix subpage scrub repair error
 caused by hardcoded PAGE_SIZE
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210427230349.369603-1-wqu@suse.com>
 <20210427230349.369603-2-wqu@suse.com> <20210513225711.GM7604@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <8b7af653-62e9-358d-d1a9-c2c6d0e2052d@gmx.com>
Date:   Fri, 14 May 2021 07:32:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210513225711.GM7604@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:43REuUCCx2zdRg2JTjZrooJRoOgI19mxzIEXaVXV23m34L+n91i
 Mx1izrlw7VK1L4y+wi9z2bFEZOGfJi8WFwM6k9W+OOxZVpQYNm4RCTrIEtQ3iaJA68QQlu3
 q0/HpFlRDsdvuDJAvd1k1gmhrJG2KwiqKN3tGdv1oWuyvxGVSMpC04e/UuQK97JOqRfS4xC
 HVM+FasPuCtXx4SXwrQZg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qeb0IsILl4M=:ziN5wyTMEuxsb/5w67a4ze
 A1M9W0ilrbVEJ5QLvKc71lK4Ov+9kbHDR0RGlUyVDDRYB1i+UpRiDgF64qCgf9AORQq7JYxPX
 4YyTz/M0s70fyTWepdJfoSsub2ZB+faHfMHg2HAA+C8D9gZVeTgJJYCRDuK0MB/qKngfEHckA
 u7ifqNWiSk+rS+Rlzn1VNg/EJ4XPgtIgNagU+N17yZbq+E9MSJqifRF5tTamOhskXjob51MwA
 9/hEuxbh2d3+XrXG/wUO/8mS0DDMsHStcLJWfKNGRTNBaVbC9xDTMWxm9MRiLz1ARYHwKuUuB
 LrgMYw/pScNL6WGJLkMkk4RpzJL0Gj9yWF3/tb0kjPk6AA/nrawbJyj2jum4rvVBxm9Mskx/Q
 EM1JP5e6FcFFN3MCiosum91w/AJy8sM4Wfx0hCncc4u0Sf/KPdT0Xul0o/jkLPT1y19YcVoMV
 0RLWMbq5vfvM3VZaVdns9hAk25qE2E3bl8qDmsaCrVYyFaHbtSdne+1Sf6XVmxxJRjxw7/TAV
 jaE6j3+KvkR5hfhyEhCyT3j4hu8/sOxtEphIzBjUi5o8M6wqbENyk8kkwSBtlx+ELggKj0/0r
 FxFdZ5zpHuQZ/Kf8Jy9h1Br7B1/mJ/Kq2cFJdCVvdCuAXaA07yyiqlCkpXuzr3/Z+1/5xeaNh
 lminS1DYcqu/I8X3gxaXiVeCDjvvnNbxCZPVUBa21O0KU8yXw5s2T2koKFW5prkZr0IayhE/i
 isvxP0/FwW/8cIVVyp4plGNkBdUN/JB1bCFfP6HbSXR9DNNiu8wU+fkFkuCh+J9lqLyLzXnYl
 waMX/kZpZN8CgjgDgEhijh0BdoSFgHOvyy96GqS6ijJN9FEB8xQsh2FnJovnP7YH+lwfHPMXP
 vXtHTBkBgSZyjsOcqPvcu0SHvd7DEzj1bAsnlV3xW7sCE5VTmbKj25E8BHx35mdYFoiCqQ/L1
 ceQvtgXSB0mhWf/Gb8A7wzugQ8CG1Wcxt0gUTYd79cYseXXHizDYvrnLDGJpoo5HDXuY/+Kvy
 iZ1RLyhjmsYIEpWSZ65T8IZ9b7onYf1yAkdESHDJAnbEAuPNYZ85CCENBn665Z/scNldK8ieb
 N8EcwWnP04i22nLTJcu30pZR/EEPygUG5Mmsi/UzWwHms0fOG5ZGXmIth+9Npjx2sbp1e4EEr
 oOPSUbB4HvH/1Me40HLsy4tS6nn+yfdHJFc4uQ1/RyegWVtQrYs7uDXOWKnazBmi2U+oa1eZJ
 UBi8TMPlkULtDI6hf
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/14 =E4=B8=8A=E5=8D=886:57, David Sterba wrote:
> On Wed, Apr 28, 2021 at 07:03:08AM +0800, Qu Wenruo wrote:
>> [BUG]
>> For the following file layout, btrfs scrub will not be able to repair
>> all these two repairable error, but in fact make one corruption even
>> unrepairable:
>>
>> 	  inode offset 0      4k     8K
>> Mirror 1               |XXXXXX|      |
>> Mirror 2               |      |XXXXXX|
>>
>> [CAUSE]
>> The root cause is the hard coded PAGE_SIZE, which makes scrub repair to
>> go crazy for subpage.
>>
>> For above case, when reading the first sector, we use PAGE_SIZE other
>> than sectorsize to read, which makes us to read the full range [0, 64K)=
.
>> In fact, after 8K there may be no data at all, we can just get some
>> garbage.
>>
>> Then when doing the repair, we also writeback a full page from mirror 2=
,
>> this means, we will also writeback the corrupted data in mirror 2 back
>> to mirror 1, leaving the range [4K, 8K) unrepairable.
>>
>> [FIX]
>> This patch will modify the following PAGE_SIZE use with sectorsize:
>
> Let me take this as an example: the changelog is great and descriptive,
> the only thing I often change is an extra newline between the
> introductory paragraph ended by ":" and the item list. This is maybe a
> personal preference but I find it easier to read.

Thanks for pointing out, in fact I'm not sure whether a new inline
should be added.

Now I have a solid answer and will not longer be stingy to use new lines.

Thanks,
Qu
>
>> - scrub_print_warning_inode()
>>    Remove the min() and replace PAGE_SIZE with sectorsize.
>>    The min() makes no sense, as csum is done for the full sector with
>>    padding.
>>
>>    This fixes a bug that subpage report extra length like:
>>     checksum error at logical 298844160 on dev /dev/mapper/arm_nvme-tes=
t,
>>     physical 575668224, root 5, inode 257, offset 0, length 12288, link=
s 1 (path: file)
>>
>>    Where the error is only 1 sector.
>>
>> - scrub_handle_errored_block()
>>    Comments with PAGE|page involved, all changed to sector.
>>
>> - scrub_setup_recheck_block()
>> - scrub_repair_page_from_good_copy()
>> - scrub_add_page_to_wr_bio()
>> - scrub_wr_submit()
>> - scrub_add_page_to_rd_bio()
>> - scrub_block_complete()
>>    Replace PAGE_SIZE with sectorsize.
>>    This solves several problems where we read/write extra range for
>>    subpage case.
>
> ...
>
