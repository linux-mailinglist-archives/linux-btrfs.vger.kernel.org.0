Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 438CA59479
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2019 08:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfF1G4T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jun 2019 02:56:19 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59272 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfF1G4T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jun 2019 02:56:19 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5S6sFR9141506;
        Fri, 28 Jun 2019 06:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=IMLauZ8gIn0MLA0goli/UIDF3BjLsuGUggFujdl2cd0=;
 b=oxAcIDH0WsGOyyGB5rJUX4g8jmOUtlJe0d5GgHm6sTf1boTT/QBWZjK0MnR/z0Oek7G8
 oJPVmIYXhykNlhAX075tU0GaOywEoySXqYJjDrbiaj67YuFxkLA2NVwPAQJdaPiHBolD
 jJHK4EP4mqA1TJDKTOfAaQHkms/jRNdTthkJq3LnYpfzfevKM36vJcNetO5qj5eKSslX
 lg32yu802b2JPzDGQsI4K9VQzrkjo1qgCuDyWDbHRskkcmuBhg5bNGMjzWn9ZnEQvUvd
 OeQgXuFefpKnUdGOE6s2BjhmtXy27t+9kOmqiHw1qf9iomK/hIOidtEXS7KhHXPhTE5p SQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2t9brtkymk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 06:56:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5S6srwN030369;
        Fri, 28 Jun 2019 06:56:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2t9p6vr383-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 06:56:10 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5S6u8SR025775;
        Fri, 28 Jun 2019 06:56:09 GMT
Received: from dhcp-10-186-50-241.sg.oracle.com (/10.186.50.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Jun 2019 23:56:08 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/2] btrfs: inode: Don't compress if NODATASUM or
 NODATACOW set
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <4581937c-cfa1-91e2-7a83-7c3f40f02857@gmx.com>
Date:   Fri, 28 Jun 2019 14:56:05 +0800
Cc:     David Sterba <dsterba@suse.cz>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A47A32AA-1457-4B98-BEB4-A9209694842E@oracle.com>
References: <20180515073622.18732-1-wqu@suse.com>
 <20180515073622.18732-2-wqu@suse.com>
 <95e8171b-6d08-e989-a835-637ccf2efe76@gmx.com>
 <20190627145849.GA20977@twin.jikos.cz>
 <fa804a25-b0a8-ad1d-760a-bf543418970a@oracle.com>
 <4581937c-cfa1-91e2-7a83-7c3f40f02857@gmx.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906280078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906280078
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> On 28 Jun 2019, at 1:58 PM, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>=20
>=20
>=20
> On 2019/6/28 =E4=B8=8A=E5=8D=8810:47, Anand Jain wrote:
>> On 27/6/19 10:58 PM, David Sterba wrote:
>>> On Tue, Jun 25, 2019 at 04:24:57PM +0800, Qu Wenruo wrote:
>>>> Ping?
>>>>=20
>>>> This patch should fix the problem of compressed extent even when
>>>> nodatasum is set.
>>>>=20
>>>> It has been one year but we still didn't get a conclusion on where
>>>> force_compress should behave.
>>>=20
>>> Note that pings to patches sent year ago will get lost, I noticed =
only
>>> because you resent it and I remembered that we had some discussions,
>>> without conclusions.
>>>=20
>>>> But at least to me, NODATASUM is a strong exclusion for compress, =
no
>>>> matter whatever option we use, we should NEVER compress data =
without
>>>> datasum/datacow.
>>>=20
>>> That's correct,=20
>>=20
>>  But I wonder what's the reason that datasum/datacow is prerequisite =
for
>> the compression ?
>=20
> It's easy to understand the hard requirement for data COW.
>=20
> If you overwrite compressed extent, a powerloss before transaction
> commit could easily screw up the data.

 This scenario is even true for non compressed data, right?

> Furthermore, what will happen if you're overwriting a 16K data extent
> while its original compressed size is only 4K, while the new data =
after
> compression is 8K?

 Sorry I can=E2=80=99t think of any limitation, any idea?

> For checksum, I'd say it's not as a hard requirement as data cow, but
> still a very preferred one.
>=20
> Since compressed data corruption could cause more problem, e.g. one =
bit
> corruption can cause the whole extent to be corrupted, it's highly
> recommended to have checksum to protect them.

 Isn=E2=80=99t it true that compression boundary/granularity is an =
extent,
 so the corrupted extent remains corrupted the same way after the
 decompress, and corruption won=E2=80=99t perpetuate to the other =
extents
 in the file. But can a non-impending corruption due to external
 factors be the reason for datasum perrequisite? it can=E2=80=99t be =
IMO.

Thanks, Anand

> Thanks,
> Qu
>>=20
>> Thanks, Anand
>>=20
>>> but the way you fix it is IMO not right. This was also
>>> noticed by Nikolay, that there are 2 locations that call
>>> inode_need_compress but with different semantics.
>>>=20
>>> One is the decision if compression applies at all, and the second =
one
>>> when that's certain it's compression, to do it or not based on the
>>> status decision of eg. heuristics.
>>>=20
>>=20
>=20

