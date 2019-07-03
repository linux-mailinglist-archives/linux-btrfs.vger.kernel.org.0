Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09ED35EF13
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2019 00:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfGCWRG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jul 2019 18:17:06 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52916 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfGCWRG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Jul 2019 18:17:06 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x63MDYgk008048;
        Wed, 3 Jul 2019 22:17:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=FjskcDDqBIoYa4MANNHp9K6++R4SbBiYIkLEobXlSn8=;
 b=GaU1GWBEUyPQQEOFGhdHkAI6rnPdeWeQ5v5VVTQ424NMA+NfY7a1AQBxICQG/ljxd6cx
 bh30JvHI39g84XSuVWfwfv1uWCLceTtR2z6nzIvJ4hChruCqQc7aLpkZkf3QlhqmFp/J
 tpWEZrPuU0q0Oow/GN7cYWAgJkLpud5QrGEHVrZ6Hs+q5RrYgLv2sCDPi+cX0/xxXmBO
 ckwrtDiRHXa3jfcbbApsyN7ynC0WwTKIJ05acizUyuE+jhYcG9Sv6zmxTBta/yZ9njlc
 LmEr/3hDaxQMpLgXT9RXGrNvrxF0niNvoXlXrVWl6eEM38Tnw+c+mjZjE9iZ5EgQ0jys Gg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2te5tbutch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Jul 2019 22:17:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x63MD9lf184683;
        Wed, 3 Jul 2019 22:17:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2tebbkkyrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Jul 2019 22:17:01 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x63MGxEU018715;
        Wed, 3 Jul 2019 22:17:00 GMT
Received: from dhcp-10-191-61-15.vpn.oracle.com (/10.191.61.15)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Jul 2019 15:16:59 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v7 RESEND Rebased] btrfs-progs: dump-tree: add noscan
 option
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20190703160907.GW20977@twin.jikos.cz>
Date:   Thu, 4 Jul 2019 06:16:54 +0800
Cc:     linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EFB71435-3B86-46A8-90A1-9DCA2BEFF934@oracle.com>
References: <20190626083017.1833-1-anand.jain@oracle.com>
 <20190703160907.GW20977@twin.jikos.cz>
To:     dsterba@suse.cz
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9307 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=6 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907030271
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9307 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=6 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907030271
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> On 4 Jul 2019, at 12:09 AM, David Sterba <dsterba@suse.cz> wrote:
>=20
> On Wed, Jun 26, 2019 at 01:30:17AM -0700, Anand Jain wrote:
>> From: Anand Jain <Anand.Jain@oracle.com>
>>=20
>> The cli 'btrfs inspect dump-tree <dev>' will scan for the partner =
devices
>> if any by default.
>>=20
>> So as of now you can not inspect each mirrored device independently.
>>=20
>> This patch adds noscan option, which when used won't scan the system =
for
>> the partner devices, instead it just uses the devices provided in the
>> argument.
>>=20
>> For example:
>>  btrfs inspect dump-tree --noscan <dev> [<dev>..]
>>=20
>> This helps to debug degraded raid1 and raid10.
>>=20
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>=20
> This makes misc-test/021-image-multi-devices fail
>=20
> =3D=3D=3D=3D=3D=3D RUN CHECK root_helper mount /dev/loop2 =
.../btrfs-progs/tests//mnt
> =3D=3D=3D=3D=3D=3D RUN CHECK md5sum .../btrfs-progs/tests//mnt/foobar
> md5sum: .../btrfs-progs/tests//mnt/foobar: Input/output error
> failed: md5sum .../btrfs-progs/tests//mnt/foobar
> =3D=3D=3D=3D=3D=3D RUN CHECK root_helper umount =
.../btrfs-progs/tests//mnt
> =3D=3D=3D=3D=3D=3D RUN CHECK root_helper losetup -d /dev/loop2
> =3D=3D=3D=3D=3D=3D RUN CHECK root_helper losetup -d /dev/loop3
>=20
> note the md5sum error, that does not happen otherwise


I am on devel. It runs fine. Test-misc/021 doesn=E2=80=99t use dump-tree =
at all.
Its strange that mnt/foobar fails to read in your case.

----
[root@dvm btrfs-progs]# make TEST=3D021\* test-misc
    [LD]     fssum
    [TEST]   misc-tests.sh
    [TEST/misc]   021-image-multi-devices
[root@dvm btrfs-progs]#=20
[root@dvm btrfs-progs]#=20
[root@dvm btrfs-progs]#=20
[root@dvm btrfs-progs]# gl | head -1
299892f3c43d btrfs-progs: dump-tree: add noscan option
[root@dvm btrfs-progs]# make all
make: Nothing to be done for `all'.
[root@dvm btrfs-progs]#=20
------



