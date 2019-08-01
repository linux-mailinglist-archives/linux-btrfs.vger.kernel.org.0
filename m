Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 036537DCC5
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2019 15:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbfHANqt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Aug 2019 09:46:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34122 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbfHANqt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Aug 2019 09:46:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x71Dd9xZ086496;
        Thu, 1 Aug 2019 13:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=/DmnwiXvvjpcBBr5dNukyuKtjEV3AdD9WFsUDYHLahw=;
 b=xgyT/HdDm0YdA49fLS6gXMzlTsOBRC3EHU9b823UMbeCn7fC4VZENHNmYg4eXHvPMrnF
 sqrjSvM3nkToAiJTqGrnbiuZtT+UTQCVxv6M5uT7uYTtu2xHpeapy7tKYKkuK7Ta13jp
 04aDYjsOMgPzOhK2F3Kixl619BjlVba2W3YXfiwnqWhah5rfo/IexHlBjgyH21SEqXVE
 I5nybDp0i/H/YR6rlSEkQWhTicDDYFYSOj+Dw8whNz1VPBamYs1ZQyfhwnqFu1+3xWwj
 HY5zJoqJZprm+PgzcRlJN4Zcr5ITCqska9Occq3IzfQwFFXgoJr0e3tZtz6KtI90AEm3 Zw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2u0e1u463k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Aug 2019 13:46:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x71Dbwvi169042;
        Thu, 1 Aug 2019 13:46:37 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2u349e0309-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Aug 2019 13:46:36 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x71DkWPj027183;
        Thu, 1 Aug 2019 13:46:33 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 01 Aug 2019 06:46:32 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <e952ed13-07d4-426e-e872-60d8b4506619@gmx.com>
Date:   Thu, 1 Aug 2019 21:46:28 +0800
Cc:     =?utf-8?Q?Sw=C3=A2mi_Petaramesh?= <swami@petaramesh.org>,
        Lionel Bouton <lionel-subscription@bouton.name>,
        linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BD134906-E79B-49D4-80C4-954D574CCC68@oracle.com>
References: <bcb1a04b-f0b0-7699-92af-501e774de41a@petaramesh.org>
 <f8b08aec-2c43-9545-906e-7e41953d9ed4@bouton.name>
 <02f206eb-0c36-6ba7-94ce-f50fa3061271@bouton.name>
 <6fb5af6c-d7b8-951b-f213-e2b9b536ae6a@petaramesh.org>
 <d8c571e4-718e-1241-66ab-176d091d6b48@bouton.name>
 <f8dfd578-95ac-1711-e382-7304bf800fb2@petaramesh.org>
 <c4885e92-937c-8fc7-625a-3bfc372e3bf5@oracle.com>
 <0bba3536-391b-42ea-1030-bd4598f39140@petaramesh.org>
 <a199a382-3ea4-e061-e5fc-dc8c2cc66e73@gmx.com>
 <e73421f5-444b-2daa-4c28-45f3b5db007c@petaramesh.org>
 <e952ed13-07d4-426e-e872-60d8b4506619@gmx.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9335 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908010145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9335 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908010145
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> On 1 Aug 2019, at 4:43 PM, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>=20
>=20
>=20
> On 2019/8/1 =E4=B8=8B=E5=8D=884:07, Sw=C3=A2mi Petaramesh wrote:
>> On 8/1/19 8:36 AM, Qu Wenruo wrote:
>>> Could you give more detailed history, including each reboot?
>>> Like:
>>>=20
>>> CASE 1
>>> # Upgrade kernel (running 5.1)
>>> # Reboot
>>> # Kernel mount failure (running 5.2)
>>=20
>> No, it never was a =E2=80=9Ckernel mount failure=E2=80=9D, it was =
more of :
>>=20
>> - Running 5.1 OK
>>=20
>> - Upgrade to 5.2
>>=20
>> - Reboot without noticing problem on kernel 5.2.1-arch1-1
>>=20
>> - Performed usual remote rsync backup using kernel 5.2.1-arch1-1 =
WITHOUT
>> any error at 23:20 on july, 16
>>=20
>> - Quite unfortunately I do not backup /var/log in frequent rsync =
backups...
>>=20
>> - Machine does its usual cronned snapper snapshots auto-delete
>>=20
>> - Turned off machine for the night
>=20
> So it looks like damage is done at this point.
>=20
> It looks like some data doesn't reach disk properly.
>=20

 Yep I suspect the same.

 Swami, Do you have the kernel logs around this time frame?


>>=20
>> - Next days, boot machine as usual (without paying attention to
>> scrolling messages)
>>=20
>> - Machine boots. Cinnamon GUI fails loading. Wonders. Reboot.
>>=20
>> - Notice BTRFS error messages on console at boot. Still no GUI.
>>=20
>> - Reboot in systemd rescue mode. Run "btrfs check -f" in read-only =
mode.
>>=20
>> - Get LOADS of error messages.
>>=20
>> - Tells myself =C2=AB Jeez the damn thing screwed up ! =C2=BB
>>=20
>> - Reboot in multi-user.target console mode
>>=20
>> - Notice BTRFS errors again.
>>=20
>> - Connect external USB HD for performing an emergency full backup of
>> what can be.
>>=20
>> - Lack enough space on external USB HD. Delete a load of old =
snapshots
>> to make enough space.
>=20
> Indeed looks like some btrfs bug in 5.2 now.
>=20
> So far, the common workload involves snapshot deletion and proper =
shutdown.
>=20
> I need to double check the snapshot deletion with dm-logwrites.
>=20
> Thanks for the detailed history, this helps more than the btrfs
> check/log message.
>=20
> Thanks,
> Qu

