Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B7F36E200
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Apr 2021 01:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhD1XMX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Apr 2021 19:12:23 -0400
Received: from mout.gmx.net ([212.227.17.22]:47491 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229479AbhD1XMW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Apr 2021 19:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619651494;
        bh=Wt+1ElR7+ygANAE9d93FBQzY0QirZ6M08uOhTpw/Z1Y=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=eGCju1DDNUqcdnfyPpoqy70Ar3pGFIZTUAJlqxK0U+Evf5qL7ewkYZ2cJa2fT1gf1
         BDA+hIZF1hYyJL35+5aW6sHACwakoK9ADdqS/+fQYyrvIa1DeqUA5BXXKQ57zOL+ZY
         QgJlwqktDF9cCvHDp4ke8584xu1OsYGPFOm9WDmE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1McH5Q-1l1S3u0ouq-00ckuN; Thu, 29
 Apr 2021 01:11:34 +0200
Subject: Re: [Patch v2 39/42] btrfs: reject raid5/6 fs for subpage
To:     Neal Gompa <ngompa13@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <20210427230349.369603-1-wqu@suse.com>
 <20210427230349.369603-40-wqu@suse.com>
 <CAEg-Je-Q4FfbjipyxZnHVrhyzx9kp_gv=s3Cb1v3q0LkRevqvQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <fb5fed4f-0ca0-075a-5faa-3a36fd902410@gmx.com>
Date:   Thu, 29 Apr 2021 07:11:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CAEg-Je-Q4FfbjipyxZnHVrhyzx9kp_gv=s3Cb1v3q0LkRevqvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TW1TJMNlv/l9bWbE8Y8cC48Zok1S642hdYZrxo3ckVTHR9umGL1
 QUA9xf9Nzr6oOdX3CsrklZ+jqMqxcIYLhtRVK/wlrMpK49XGQDyg4Zh0K40GQhFBGgyjNUM
 svFp6kYxDLHqEmvfDQhWpRgx1H9RxRjKbTIU3mFdcSktbkEodaiPFEtC6c2OVFvemGDWHKB
 S3iX0XOUYOSTHjsEjiPDQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fqNYjWp0zwc=:O4z4kvCTfiQuFLEULOaaOY
 d3WjnsRijydZ5CVKEzqccDYhh2Bqnvf5NAsL4b3AZWxxhcgUzMyCq+3vks3BvEVWwqmC+Qu9y
 4RcZTqnhQ/wQclFDqaLmmVdKP4QH+A5x9M6d0CsaY2DY2x5vIUAONFcB+ym8UjReeG2zmmuDO
 dVCQzg/aPw3ep83rmKuwabOTxaZ18sfhG8XxglIQwKxA0AMnjnAPlbiW5rNRaS9EPL6vnlzfk
 LMDyJPP8yDC3yWw2FEeA07YhJr7VAIfeTfEiElTX/iy8TS7R6QcIF9vGii8ESnFhKH0VfmpTR
 riDDMgEz5/4vNgSdJadgZL0jXB7eVBHUowfNb2mR/ERKy5Nv4VA1Gn2t8kDmWyfKo/6s6SgII
 wgLVwkJMN3l6btKTnENR2t/TRu1cL83p+t/EAS5IAZ8oAeL2aOqE1NFevFA9SXb14cG1lU4+h
 gLj31G5hKFhA4I81MIWx6XdQVn/YFYrRAFPrthpnOy5k/EPqDQ88CunHE7HmIDUFFGQ6XsqDr
 TUYFkcDe5Apay3WJVLtuhp1F/2scqoUHhwFm8ds6NdhuEQpHLCOEornSknmYnW/mH4grjJNfD
 Q+0rnfEJ4xg2Kn/y3s5X5PUolT5+Tin1GyYlp67wDvOX2a7f0gxKgYcZGPOLP1TtG/9WI1nVX
 wUZUvA46EbN0JjeuDgYDHUG76K5Y0kSSKgV0QUgj6sxsOwH15HiKkqwe7MQXMXI+6yTZHQ3ys
 cUFyb2wy5Famzm//m36C50dhJPsk944EYYGvt4Ayh38eR4nl1CPqldtBtSkcX98QEewTupUZ1
 +UiYP+ylcIaXyRm/2mkZv1TFTEap7VuxEp/hWVdv2GOw4CUTZnXGNqUqLNsFZeXutOWvgeI4t
 xqTBN/qZQnA6tvEJEQgPYEP0FLIVwS1nKopcMPbJ7CMQrPaBbz5UNmloK5Gqh2xwcv6BKcfqV
 GWUGxZpt3hAvDMHBmAqgKi1DzMVD6GVR51ss8s/+hAVVbLVZ6hYyjBaZkV4X1PuLIGBVFSThj
 5CfSLce/qugSy7BVz2HkD7+r58zEwR66cp1WZEtt/fM4H79xhF3NdUxtW8By00EnIRwFz4h5I
 POk22Bid41I2uxkO+RKtJkPvGxP7/xw2LrQ/P05etj7Ui9BNsV5Dwmff9Lx33tO4XTM9TCW8r
 6CfcGS0jAxo7gAspL0I4QQIKMyjY0PFzF/RH5xm1MhOROlwAMWH0i+EOs1nSB381skztjh2yN
 jMC8xxiicV9zEpESU
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/28 =E4=B8=8B=E5=8D=8810:22, Neal Gompa wrote:
> On Tue, Apr 27, 2021 at 7:06 PM Qu Wenruo <wqu@suse.com> wrote:
>>
>> Raid5/6 is not only unsafe due to its write-hole problem, but also has
>> tons of hardcoded PAGE_SIZE.
>>
>> So disable it for subpage support for now.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/disk-io.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index c9a3036c23bf..e6b941932a2b 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -3407,6 +3407,16 @@ int __cold open_ctree(struct super_block *sb, st=
ruct btrfs_fs_devices *fs_device
>>                          goto fail_alloc;
>>                  }
>>          }
>> +       if (sectorsize !=3D PAGE_SIZE) {
>> +               if (btrfs_super_incompat_flags(fs_info->super_copy) &
>> +                       BTRFS_FEATURE_INCOMPAT_RAID56) {
>> +                       btrfs_err(fs_info,
>> +       "raid5/6 is not yet supported for sector size %u with page size=
 %lu",
>> +                               sectorsize, PAGE_SIZE);
>> +                       err =3D -EINVAL;
>> +                       goto fail_alloc;
>> +               }
>> +       }
>>
>>          ret =3D btrfs_init_workqueues(fs_info, fs_devices);
>>          if (ret) {
>> --
>> 2.31.1
>>
>
> Couldn't this be restricted to ro-only safely?

I'm not confident, as there are too many BUG_ON()s related to PAGE_SIZE.

Thanks,
Qu
