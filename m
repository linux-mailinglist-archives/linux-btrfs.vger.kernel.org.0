Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3E711B5E6
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2019 16:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731858AbfLKP5P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Dec 2019 10:57:15 -0500
Received: from ms11p00im-qufo17281401.me.com ([17.58.38.51]:40158 "EHLO
        ms11p00im-qufo17281401.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730962AbfLKP5L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Dec 2019 10:57:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1576079829;
        bh=8DSEtEZvRVHA7KzRwJUlqJ3kOhZ9hZTWfUBB4qaK9aE=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=CXaBRfR/zBQtkDeaBKh15mX4sbALd/UXNL7nZorSnosBPtYqrPnGV++bnG3s9EGJq
         XvAKR2pFIkOhOn8VLfcoe/po87IPStPveHK7mxHYIihyHmszmjs9KVlRhDoHpsf4Ms
         z2cPIXyV1c9nfeFdxXgmOr8DHndS0NOYDzbeTTcX0pgxSknI4qJCaBjBX8/nz05Hs9
         PqOScxi0Br29Hc9frKYAzU9V00MzoPCQ4ckPXtZUYjWzSoLYqfT3RTtcwMqwv6FDCn
         5rzfRL4WvJZN3yZhiBqHZZZlRdI7V6oFo4UzwP7QXEE+EuA7duldqBBlj4ozXYeG2K
         Fns2RbQ8g2jtw==
Received: from [192.168.15.23] (unknown [177.27.216.49])
        by ms11p00im-qufo17281401.me.com (Postfix) with ESMTPSA id 5323BBC0E91;
        Wed, 11 Dec 2019 15:57:08 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH] btrfs-progs: Skip device tree when we failed to read it
From:   Christian Wimmer <telefonchris@icloud.com>
In-Reply-To: <985d1845-d211-9134-4c9b-85a0956e7404@gmx.com>
Date:   Wed, 11 Dec 2019 12:57:05 -0300
Cc:     Qu WenRuo <wqu@suse.com>, Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <24850F04-1850-42AA-B05D-0E10EC648BBA@icloud.com>
References: <20191206034406.40167-1-wqu@suse.com>
 <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
 <762365A0-8BDF-454B-ABA9-AB2F0C958106@icloud.com>
 <94a6d1b2-ae32-5564-22ee-6982e952b100@suse.com>
 <4C0C9689-3ECF-4DF7-9F7E-734B6484AA63@icloud.com>
 <f7fe057d-adc1-ace5-03b3-0f0e608d68a3@gmx.com>
 <BF872461-4D5F-4125-85E6-719A42F5BD0F@icloud.com>
 <e8b667ab-6b71-7cd8-632a-5483ec4386d8@gmx.com>
 <6538780A-6160-4400-A997-E8324DB61F69@icloud.com>
 <e461ee1a-dc24-dcde-34b5-2ddd53bb1827@suse.com>
 <18F0134D-AFF9-4CB9-A996-E44AC949DCAA@icloud.com>
 <985d1845-d211-9134-4c9b-85a0956e7404@gmx.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
X-Mailer: Apple Mail (2.3601.0.10)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-11_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1912110134
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Perfect!

Thanks a lot!

Chris


> On 10. Dec 2019, at 21:36, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>=20
>=20
>=20
> On 2019/12/11 =E4=B8=8A=E5=8D=885:25, Christian Wimmer wrote:
>> Hi Qu and all others,
>>=20
>> thanks a lot for your help and patience!
>>=20
>> Unfortunately I could not get out any file from the arrive yet but I =
can survive.
>>=20
>> I would like just one more answer from you. Do you think with the =
newest version of btrfs it would not have happened?
>=20
> =46rom the result, it looks like either btrfs is doing wrong trim, or =
the
> storage stack below (including the Parallels, the apple fs, and the
> apple drivers) is blowing up data.
>=20
> In the latter case, it doesn't matter whatever kernel version you're
> using, if it happens, it will take your data along with it.
>=20
> But for the former case, newer kernel has improved trim check to =
prevent
> bad trim, so at least newer kernel is a little more safer.
>=20
>> Should I update to the newest version?
>=20
> Not always the newest, although we're trying our best to prevent bugs,
> but sometimes we still have some bugs sneaking into latest kernel.
>=20
>>=20
>> I have many partitions with btrfs and I like them a lot. Very nice =
file system indeed but am I safe with the version that I have (4.19.1)?
>=20
> Can't say it's unsafe, since SUSE has all necessary backports and =
quite
> some customers are using (testing) it.
> As long as you're using the latest SUSE updates, it should be safe and
> all found bugs should have fixes backported.
>=20
> Thanks,
> Qu
>>=20
>> BTW, you are welcome to suggest any command or try anything with my =
broken file system that I still have backed up in case that you want to =
experiment with it.
>>=20
>> Thanks=20
>>=20
>> Chris
>>=20
>>=20
>>> On 7. Dec 2019, at 22:21, Qu WenRuo <wqu@suse.com> wrote:
>>>=20
>>>=20
>>>=20
>>> On 2019/12/8 =E4=B8=8A=E5=8D=8812:44, Christian Wimmer wrote:
>>>> Hi Qu,
>>>>=20
>>>> I was reading about chunk-recover. Do you think this could be worth =
a try?
>>>=20
>>> Nope, your chunk tree is good, so that makes no sense.
>>>=20
>>>>=20
>>>> Is there any other command that can search for files that make =
sense to recover?
>>>=20
>>> The only sane behavior here is to search the whole disk and grab
>>> anything looks like a tree block, and then extract data from it.
>>>=20
>>> This is not something supported by btrfs-progs yet, so really not =
much
>>> more can be done here.
>>>=20
>>> Thanks,
>>> Qu
>>>=20
>>>>=20
>>>> Regards,
>>>>=20
>>>> Chris
>>>>=20
>>=20
>=20

