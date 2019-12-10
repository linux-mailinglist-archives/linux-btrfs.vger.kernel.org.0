Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9CD011964E
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2019 22:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbfLJVZ6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Dec 2019 16:25:58 -0500
Received: from ms11p00im-qufo17291901.me.com ([17.58.38.48]:54087 "EHLO
        ms11p00im-qufo17291901.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729534AbfLJVZy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Dec 2019 16:25:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1576013151;
        bh=+Z9h9IijmSNrmurFnIie2aAZeLsmlW9FkZG1h8i83YQ=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=meGHmh9cL+pAOvxlooJ8KShfFtmtQaTByyI8at1WZZ8FTs/z5kXb8eVjvHdK8h5cC
         +gQsW3iHukt61DzmG2swP+pYMKcsU753MHiDPCtJFlf/D2jE8MjDSfcAQsHRAFDT3J
         Bf8IQ+y+iyNQCkEpmGievzBOnG/mMo8e+r6OcoK8gP1u2IdQqHRcMnGLwgLHSFj91H
         ofcK9AaKQkADaz5Bwq/XFwYrDpGsjEvi1tNrpowcjNoBF3Vx19ncVaioN7nJybDeNN
         OjxyvEoBpx7nYEFAuxWX0cARbRRh+/vEUSJn03nAPlSIZw2cmogy6L12iVikEbAL5K
         r7ux+julD8W6g==
Received: from [192.168.15.23] (unknown [177.27.216.49])
        by ms11p00im-qufo17291901.me.com (Postfix) with ESMTPSA id B132F580EB4;
        Tue, 10 Dec 2019 21:25:50 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH] btrfs-progs: Skip device tree when we failed to read it
From:   Christian Wimmer <telefonchris@icloud.com>
In-Reply-To: <e461ee1a-dc24-dcde-34b5-2ddd53bb1827@suse.com>
Date:   Tue, 10 Dec 2019 18:25:47 -0300
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <18F0134D-AFF9-4CB9-A996-E44AC949DCAA@icloud.com>
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
To:     Qu WenRuo <wqu@suse.com>
X-Mailer: Apple Mail (2.3601.0.10)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-10_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1912100177
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu and all others,

thanks a lot for your help and patience!

Unfortunately I could not get out any file from the arrive yet but I can =
survive.

I would like just one more answer from you. Do you think with the newest =
version of btrfs it would not have happened?
Should I update to the newest version?

I have many partitions with btrfs and I like them a lot. Very nice file =
system indeed but am I safe with the version that I have (4.19.1)?

BTW, you are welcome to suggest any command or try anything with my =
broken file system that I still have backed up in case that you want to =
experiment with it.

Thanks=20

Chris


> On 7. Dec 2019, at 22:21, Qu WenRuo <wqu@suse.com> wrote:
>=20
>=20
>=20
> On 2019/12/8 =E4=B8=8A=E5=8D=8812:44, Christian Wimmer wrote:
>> Hi Qu,
>>=20
>> I was reading about chunk-recover. Do you think this could be worth a =
try?
>=20
> Nope, your chunk tree is good, so that makes no sense.
>=20
>>=20
>> Is there any other command that can search for files that make sense =
to recover?
>=20
> The only sane behavior here is to search the whole disk and grab
> anything looks like a tree block, and then extract data from it.
>=20
> This is not something supported by btrfs-progs yet, so really not much
> more can be done here.
>=20
> Thanks,
> Qu
>=20
>>=20
>> Regards,
>>=20
>> Chris
>>=20

