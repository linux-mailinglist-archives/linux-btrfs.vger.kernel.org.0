Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6AB28D552
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Oct 2020 22:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgJMU21 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Oct 2020 16:28:27 -0400
Received: from st43p00im-ztfb10061701.me.com ([17.58.63.172]:44511 "EHLO
        st43p00im-ztfb10061701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726137AbgJMU21 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Oct 2020 16:28:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1602620905;
        bh=AkAcAizm3aqxM9eSrv59tXfRdR3wejDs63uzCTsAegY=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=fgOh8TNcmNoDy+lTe0typvBPW+nxLtWce1nI0adsDnuV84QrUiaH8iRtN37fjWsSC
         jTP7S1huwLoCQ/tfo+qlFmoKCdjPAVcG55G3dzLMu2gqyD5arn6SGMYVGgbrM3gjhR
         RfgFiMK6uGb2taU6n0vRVWr+uT+vLjC30B7l1aAvI6VBXVbKlmXmTHN7Euj+RhyziT
         YhYj9VUos5BmC5cL8cwm/Ov6DgB7wx+P0qLdhmB5/rIw0fRIBUbTnDwEH2/05i2bYM
         6fUeCG1XB6slMAeNQUVSx1A9E2p949wzAgHD30DZkSTmHYs3h6YhLkFH+GdXT51CzK
         L3EYH2DjLzXUw==
Received: from [192.168.10.109] (108-230-77-122.lightspeed.chtnsc.sbcglobal.net [108.230.77.122])
        by st43p00im-ztfb10061701.me.com (Postfix) with ESMTPSA id 57ABEAC051F;
        Tue, 13 Oct 2020 20:28:25 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
Subject: Re: Drive won't mount, please help
From:   J J <j333111@icloud.com>
In-Reply-To: <CAJCQCtTvTH7XeA1F3nd011-X4vVUZJ15zRN2HK8cOL722oJ13A@mail.gmail.com>
Date:   Tue, 13 Oct 2020 16:28:22 -0400
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DFA69BD3-6415-4342-B17D-2CFBF0BED53F@icloud.com>
References: <91595165-FA0C-4BFB-BA8F-30BEAE6281A3@icloud.com>
 <fff0f71b-0db7-cbfc-5546-ea87f9bbf838@gmx.com>
 <C83FF9DC-77A2-4D21-A26A-4C2AE5255A20@icloud.com>
 <c992de06-0df7-4b68-2b39-d8e78332c53d@gmx.com>
 <33E2EE2B-38B5-49A3-AB9F-0D99886751C4@icloud.com>
 <CAJCQCtTjj7Q9D9uKQRPixC6MPKRbNw3xkf=xdF1yONcqR=FM6w@mail.gmail.com>
 <6BF631F4-3B9D-4332-AC42-2BCDE387322C@icloud.com>
 <CAJCQCtTvTH7XeA1F3nd011-X4vVUZJ15zRN2HK8cOL722oJ13A@mail.gmail.com>
To:     Chris Murphy <lists@colorremedies.com>
X-Mailer: Apple Mail (2.3445.104.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-13_13:2020-10-13,2020-10-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2010130145
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks again Chris,=20

Its btrfs-progs 4.7

I spent an hour just trying to figure out how to update it, and still =
unsuccessful : (

I=E2=80=99m running OMV 4, it=E2=80=99s debian.=20

Sorry for such noob questions but can you tell me simplest way to update =
btrfs-progs?

> On Oct 9, 2020, at 11:16 PM, Chris Murphy <lists@colorremedies.com> =
wrote:
>=20
> On Wed, Oct 7, 2020 at 2:31 PM J J <j333111@icloud.com> wrote:
>>=20
>> Thanks Chris. The results :
>>=20
>> btrfs insp dump-t -t 1 /dev/mapper/sda-crypt | grep -A1 'ROOT_REF'
>> parent transid verify failed on 2639007596544 wanted 395882 found =
395362
>> parent transid verify failed on 2639007596544 wanted 395882 found =
395362
>> parent transid verify failed on 2639007596544 wanted 395882 found =
395362
>> parent transid verify failed on 2639007596544 wanted 395882 found =
395362
>> Ignoring transid failure
>> leaf parent key incorrect 2639007596544
>>=20
>> I dont see an output like your example
>=20
> OK we'll have to find a tree that isn't this broken. But what version
> of btrfs-progs is this? I suggest something relatively recent 5.4 or
> newer. 5.7 is current.
>=20
> btrfs inspect-internal dump-super --full /dev/
>=20
> That'll get some possible alternatives for root tree. And plug that
> into 'dump-tree' as the value  for -b.
>=20
> btrfs insp dump-t -t 1 /dev/whatever | grep -A1 'ROOT_REF'
>=20
> becomes
>=20
> btrfs insp dump-t -t 1 -b <byteforbackuproot> /dev/whatever | grep -A1
> 'ROOT_REF'
>=20
> There are some other ways to get info what's in subvolume's, using
> dry-run or -d to get a basic listing and then infer from the output
> what subvolume it is. Older subvolumes (smaller ID number) might be
> more intact. But they will also not contain as much current data.
>=20
> --=20
> Chris Murphy

