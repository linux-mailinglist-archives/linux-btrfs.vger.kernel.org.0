Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36F2286921
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Oct 2020 22:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgJGUbf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Oct 2020 16:31:35 -0400
Received: from st43p00im-ztdg10071801.me.com ([17.58.63.171]:46392 "EHLO
        st43p00im-ztdg10071801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727505AbgJGUbf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 7 Oct 2020 16:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1602102693;
        bh=3OiDRMkkjTImUO1F4XQSKFu0/jsNzokiLlutLAvoU2M=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=ZEco9GskXiXGrCQPnHE0RWDWNPSXGoy3KW2x9pR2Q6zx6BnRSO/AUGma9GhKcuV+n
         nH2CbLu7U7huQAajXGVzE7mT1V7R0/VW3IC39mfLa0yl1nc6Nk+dQ3AsN+atBqUtb6
         bjrSCh/jYBirp5ZY35osViaVnHiMEVtJUTA5LwiF/NyKmRmrcwmcTK1WvzX/YTR6/H
         z4RsQZWyeFmNg2SoJyvo4IS7lmNUctFcGiIiKU6HsXSz8xhiQ8Ied4h7JxWgezEwn6
         wQTn0aCSrsjijnWD+X9wek/0bKcea848KPsfwwF9b/PTz91aI2sb0UTnx7fcBqI8i/
         n76feeblHkI5w==
Received: from [192.168.10.103] (108-230-77-122.lightspeed.chtnsc.sbcglobal.net [108.230.77.122])
        by st43p00im-ztdg10071801.me.com (Postfix) with ESMTPSA id 40C415404B6;
        Wed,  7 Oct 2020 20:31:33 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
Subject: Re: Drive won't mount, please help
From:   J J <j333111@icloud.com>
In-Reply-To: <CAJCQCtTjj7Q9D9uKQRPixC6MPKRbNw3xkf=xdF1yONcqR=FM6w@mail.gmail.com>
Date:   Wed, 7 Oct 2020 16:31:31 -0400
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6BF631F4-3B9D-4332-AC42-2BCDE387322C@icloud.com>
References: <91595165-FA0C-4BFB-BA8F-30BEAE6281A3@icloud.com>
 <fff0f71b-0db7-cbfc-5546-ea87f9bbf838@gmx.com>
 <C83FF9DC-77A2-4D21-A26A-4C2AE5255A20@icloud.com>
 <c992de06-0df7-4b68-2b39-d8e78332c53d@gmx.com>
 <33E2EE2B-38B5-49A3-AB9F-0D99886751C4@icloud.com>
 <CAJCQCtTjj7Q9D9uKQRPixC6MPKRbNw3xkf=xdF1yONcqR=FM6w@mail.gmail.com>
To:     Chris Murphy <lists@colorremedies.com>
X-Mailer: Apple Mail (2.3445.104.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-07_10:2020-10-07,2020-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2010070131
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks Chris. The results :

btrfs insp dump-t -t 1 /dev/mapper/sda-crypt | grep -A1 'ROOT_REF'
parent transid verify failed on 2639007596544 wanted 395882 found 395362
parent transid verify failed on 2639007596544 wanted 395882 found 395362
parent transid verify failed on 2639007596544 wanted 395882 found 395362
parent transid verify failed on 2639007596544 wanted 395882 found 395362
Ignoring transid failure
leaf parent key incorrect 2639007596544

I dont see an output like your example


> On Sep 27, 2020, at 1:43 AM, Chris Murphy <lists@colorremedies.com> =
wrote:
>=20
> On Sat, Sep 26, 2020 at 11:27 AM J J <j333111@icloud.com> wrote:
>>=20
>> I ran btrfs-restore and recovered some data, but not most, and not =
the most critical. Believe it or not, my other backup drive failed =
within the same week (different file system, different location), so =
I=E2=80=99m worried I lost a lot of data.
>>=20
>> I'm Following this page =
https://btrfs.wiki.kernel.org/index.php/Restore, is this the best source =
for information?
>=20
> One thing missing is  -l|--list-roots doesn't show the
> subvolume/snapshot names. That might make recovery harder because if
> there's tree damage and the data you're after is in an older snapshot
> - decent chance that tree is not damaged and you can get data out that
> way.
>=20
> Something like this:
>=20
> btrfs insp dump-t -t 1 /dev/whatever | grep -A1 'ROOT_REF'
>=20
> For each item, first line contains the root ID number you need, and
> the second line contains the name you're familiar with.
>=20
>    item 4 key (FS_TREE ROOT_REF 258) itemoff 31311 itemsize 22
>        root ref key dirid 256 sequence 3 name home
>=20
> If I want to work on just home, I need to use
>=20
> btrfs restore --ignore-errors --verbose --root 258
>=20
> Also, you probably want newer btrfs-progs than 4.7. I don't know if
> there have been improvements to restore since then, but why not give
> it a shot and see. Most people give up because the restore tool is
> sort of a choose your own adventure book.
>=20
> In particular, the part about filtering with regex is a hurdle of its
> own but if the subvolume/snapshot you're restoring as a lot of files
> in it that you don't want to restore, then it can be useful time
> savings wise. If you'd rather filter through things later, then you
> can skip --path-regex option.
>=20
> --=20
> Chris Murphy

