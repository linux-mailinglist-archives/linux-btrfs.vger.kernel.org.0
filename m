Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A978E5F0F7
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2019 03:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfGDBaA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jul 2019 21:30:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38692 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfGDBaA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Jul 2019 21:30:00 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x641Tj6w032611;
        Thu, 4 Jul 2019 01:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=cmKuS4KeJFl9ASxA7gBQ8wPJCVj3yikdCNcW0UURFW4=;
 b=Ir/nqolhXXhpXExPWLBvR1D8rq1EaJXjcJElWoJe55EynQ0ttiH6VJrTOKz/HcC1NtfT
 nzRRxh+lTN67W447gsS/+V/JZmko++Iyaiqsl8ZqpmoIZdtHJesB5Ux+sXyFkuaGDeEV
 ygI97BVOGE9yMRmeUQRTEEpvQWhvtqDIlZLVpF1h+O1F3Ie9M6KWu/rjLe5H5jMNdSMV
 yHTO/DXTdFhnOvMZbfwkMQcy56G74UoBkSvvyK/6XNKoEqJoHzUP6taCzdrJIWAy6+KO
 7irKHxu+lJpp60Eir59hU8EqKct+JDG1jTN8uemV4KQX1VJ+QdLOqnN+ysBpQ8ozlEAD bw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2te61ec6jv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jul 2019 01:29:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x641SIAj114316;
        Thu, 4 Jul 2019 01:29:55 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2tebkv5x6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jul 2019 01:29:55 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x641Tr2W001314;
        Thu, 4 Jul 2019 01:29:54 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Jul 2019 18:29:53 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v7 RESEND Rebased] btrfs-progs: dump-tree: add noscan
 option
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20190703233905.GX20977@suse.cz>
Date:   Thu, 4 Jul 2019 09:29:50 +0800
Cc:     linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <33A1847C-A73A-4794-B34F-C653FAD44318@oracle.com>
References: <20190626083017.1833-1-anand.jain@oracle.com>
 <20190703160907.GW20977@twin.jikos.cz>
 <EFB71435-3B86-46A8-90A1-9DCA2BEFF934@oracle.com>
 <20190703233905.GX20977@suse.cz>
To:     David Sterba <dsterba@suse.cz>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9307 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907040017
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9307 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907040018
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> On 4 Jul 2019, at 7:39 AM, David Sterba <dsterba@suse.cz> wrote:
>=20
> On Thu, Jul 04, 2019 at 06:16:54AM +0800, Anand Jain wrote:
>>=20
>>=20
>>> On 4 Jul 2019, at 12:09 AM, David Sterba <dsterba@suse.cz> wrote:
>>>=20
>>> On Wed, Jun 26, 2019 at 01:30:17AM -0700, Anand Jain wrote:
>>>> From: Anand Jain <Anand.Jain@oracle.com>
>>>>=20
>>>> The cli 'btrfs inspect dump-tree <dev>' will scan for the partner =
devices
>>>> if any by default.
>>>>=20
>>>> So as of now you can not inspect each mirrored device =
independently.
>>>>=20
>>>> This patch adds noscan option, which when used won't scan the =
system for
>>>> the partner devices, instead it just uses the devices provided in =
the
>>>> argument.
>>>>=20
>>>> For example:
>>>> btrfs inspect dump-tree --noscan <dev> [<dev>..]
>>>>=20
>>>> This helps to debug degraded raid1 and raid10.
>>>>=20
>>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>>=20
>>> This makes misc-test/021-image-multi-devices fail
>>>=20
>>> =3D=3D=3D=3D=3D=3D RUN CHECK root_helper mount /dev/loop2 =
.../btrfs-progs/tests//mnt
>>> =3D=3D=3D=3D=3D=3D RUN CHECK md5sum =
.../btrfs-progs/tests//mnt/foobar
>>> md5sum: .../btrfs-progs/tests//mnt/foobar: Input/output error
>>> failed: md5sum .../btrfs-progs/tests//mnt/foobar
>>> =3D=3D=3D=3D=3D=3D RUN CHECK root_helper umount =
.../btrfs-progs/tests//mnt
>>> =3D=3D=3D=3D=3D=3D RUN CHECK root_helper losetup -d /dev/loop2
>>> =3D=3D=3D=3D=3D=3D RUN CHECK root_helper losetup -d /dev/loop3
>>>=20
>>> note the md5sum error, that does not happen otherwise
>>=20
>>=20
>> I am on devel. It runs fine. Test-misc/021 doesn=E2=80=99t use =
dump-tree at all.
>> Its strange that mnt/foobar fails to read in your case.
>=20
> Sorry, I replied to the wrong patch,


> it's the other one "btrfs-progs:
> dump-tree: add noscan option=E2=80=9D.

 Typo in the other one? Because "dump-tree: add noscan option=E2=80=9D =
is this.

