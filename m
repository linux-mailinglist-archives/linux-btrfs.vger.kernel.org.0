Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF4C0179D35
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2020 02:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbgCEBSi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 20:18:38 -0500
Received: from mout.gmx.net ([212.227.17.22]:33607 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbgCEBSi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Mar 2020 20:18:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583371111;
        bh=8DqQ07vqx40dG76rjDFkcVO9sxOe9bysVB90NR2E5BE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=la9rcA4LaugIH2/pKgOx1YCvEyUcbijfwh3CcaPIXocCAGLNh+DUGiZLlMVwCEtGu
         Z36KlbNqqSSNXhNyecQMxiGU2yZBFfUF7uHprfc9QssRWQvKUOTMqFXZNYjm3GpMd6
         2pNOrVG5qORP4dojxTnUvLOWRzKMU4UJ9jHl2kaA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.111] ([34.92.246.95]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MeCpb-1jkvNh2nqx-00bGAv; Thu, 05
 Mar 2020 02:18:31 +0100
Subject: Re: [PATCH 00/11] btrfs-progs: metadata_uuid feature fixes and
 portation
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        damenly.su@gmail.com, linux-btrfs@vger.kernel.org
References: <20191212110204.11128-1-Damenly_Su@gmx.com>
 <2974237d-ea96-bde8-bc48-2cf8bd6a375b@suse.com>
 <c6ceaa56-f5db-54ec-a2ba-130d469ec992@gmx.com>
 <20200304141438.GT2902@twin.jikos.cz>
From:   Su Yue <Damenly_Su@gmx.com>
Message-ID: <930018ec-80b9-6000-4de6-2a8cd36576bb@gmx.com>
Date:   Thu, 5 Mar 2020 09:18:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200304141438.GT2902@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cBxaRbqHHJPnB5QIeISc48iBESrFd7/xP/dcs0YF9LHL+ETeLfq
 GRZb2va9VWdqK8zruGPikwI/mRGahEe5eY2hSZu73qt+U3eQOw5IUcDk6hg0JOoKW3hNW/J
 euOfnnEP70dWTofZQmmcuILV5dY84A4nXWMEly0DVGVCoeOD2OkFHng25UcmFSiQcecEQj8
 5Gvh6xJqRiKrvhBJJBR6g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/wd1xO4zpKk=:n3vDXpuxab2m7ATUgOIPbP
 /yNZIGm2Pk0ylCf7wHIUdnjFqeZCzoDZ7aDPXyrZe0c57BIWN3fsk3lrXmxJnJa7Hf2RG3ptc
 LhZYkTIVn+sjZPkayYljTBdyCpR0hunWKB5i2k5oGM/CXJ0lLX6fHG3F3sKsm2TKWvwQ4rHf9
 RGrVPtv3aOh0to2pZ1MJvOj29FGLuQLpHvoQdirdDuCNu97StFLREZx8T4lCTvVq2rcUkVD/Y
 vpce2RwpHgOKZXBOHpzGEJQxsbFBGyT09oPqVklLri4kqSNy+rBEF02t1e39hdBx5pY36s/JB
 bVwgEtHE2qiCaSPiMpnA1kzHFGPbC5zEB2e4EA7YEP8lv++agHEF0PCvZM9L9xf4xJuAMBv0b
 QaN9+1q3mRJpZDt8y5Kbbg/WaxliY8HYqyscJWd/UGq/iAFFnQVM3NHzz8yTL7TbdLM5ketDH
 yATo3uSDLbLnW7Dq+1Qvm9+3EGWP0bnHbkME0CD/1118sk+IhQczNnjifoymO7n4Qr8RBzSmE
 Yfi/pjpyfGP6FKjyy3306SGR00FT5oHmyn3zzpOzwImTisgZ3A0FqCJp7dAQ3twowzzsJpJCq
 wEBvuoAdH4utb21+1XXjsZUNdmPKxnX59T8NweBqiun08aZRHvRNx+YFoPQa5d49k3dVg2mxH
 VMYyFKMU5tzuKFHz3/VRJihtiv6ab14bwheEcsNGZamctMccdDM7hJjqY5IWEHnEImrwtjwT7
 RuS+nqGQF2VkXXl1EDBAQE3Ho7i+vV2WaddvwmzvyCVsi2l4BW4ka/6yHkZVUnuQ8uMkYtWfL
 3zzkqKOqnPbu/XC5H8kCutTXoj1/Lmd2FiiN3gV0FAUwX4+Qygh2z/saMQTT6jrLsKsy8OB1j
 huTmvxQS7i7j4LQfBiHmF3Ngu7XEWP3jZ58VKTbc6dagVzzvfVvuXdSjgoVbuUO0j6Q3ZnV94
 NwWENSXjjEuM0TPra+ThB7b4xqtMJIqc6rLlmLV2OAD7KtpDcJ6MCvJ2hftrjh4pPQC/8Q/Iz
 sJJ/vdByKIFgrHpSx/znDKoIfD50OhE2cunq61kP8ZI1fkIlZ6zO1FcxcbsvtV4hbGGRXrMGq
 rc0WJiZNTKAeh5Po0Tyovn4fVJN9nVgmQkp8QZp4lOPzErF559Lth10NSDLZl7p37B2Rd5EC8
 OsYnfzwCv4XHaUCfnFJurXOJYXsL77PZvbNLv60Nhbr2Vb37we/9xFLUZXSTY+Vv+dQioKVG/
 jyU6Nn/XhaEPP3bhV
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020/3/4 10:14 PM, David Sterba wrote:
> On Fri, Jan 31, 2020 at 06:04:42PM +0800, Su Yue wrote:
>> On 2020/1/31 4:05 PM, Nikolay Borisov wrote:
>>>
>>>
>>> On 12.12.19 =D0=B3. 13:01 =D1=87., damenly.su@gmail.com wrote:
>>>> From: Su Yue <Damenly_Su@gmx.com>
>>>>
>>>> The series are inspired by easy failing misc-tests/034.
>>>> Those patches fix misc-tests/034 and add new test images.
>>>>
>>>> After portation of kernel find fs_devices code, progs is able to
>>>> work on devices with FSID_CHANGING_V2 flag, not sure whether the
>>>> functionality is necessary. If not, I will remove it in next version.
>>>
>>> For now I think it's best if this is not added. Kernel is supposed to
>>> handle split-brain scenarios upon device scan which is triggered
>>> automatically by udev. If the need arises in the future then we can
>>> think about integrating this code in btrfs-progs.
>>>
>>
>> Okay, so drop patch[3-11].
>
> So patches 1 and 2 have been applied. Thanks.
>
Sorry. David, please remove the patch 2 if applied.
There is another better solution applied by Marcos
https://www.spinics.net/lists/linux-btrfs/msg98370.html.

Try to update status about dropping things on time next time:).

Thanks
