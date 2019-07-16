Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C93E6A09A
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2019 04:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730915AbfGPCvF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jul 2019 22:51:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60144 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729292AbfGPCvE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jul 2019 22:51:04 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6G2nIrm132711;
        Tue, 16 Jul 2019 02:50:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=Z60q+OeCir9n0W+Ic/gjLkjkrkDZcJ0RHJAM5VRHWy4=;
 b=VhwdW7j+cnMX+ZRDvubMxd5ZQ9As5a+Yq7E0DEgOYDapq4JHDs9GXUIRuDTU2S3SkUGj
 TXBTQCUlXTy2Z7+qXmnXdRcqUB9rLDKPtoBi97BOUjqwOs+dHnFDZGW4T63msEaSAvfo
 mKh17/gibfxTJlQS5D5bV51+wlfVax95S1kJE1CBcVw5vxpVIVAy/uydSD2Sd18ZaY2E
 yOVpmp52W9fpc5RrDOtkviBNu8mXGUx8YbkAE/rkgZWIWyim5852E5BUkKJ5DIVlXEKc
 pR+7hKNeYSeNSiNEzud8L+wgjbKC7A7F3eiEiCOZGkN7W7M1XWo2VQzZtXbqOLwS9dm5 9w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2tq6qthuqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 02:50:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6G2mZdx155205;
        Tue, 16 Jul 2019 02:50:58 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2tq6mmm7ew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 02:50:58 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6G2ouRe027814;
        Tue, 16 Jul 2019 02:50:57 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Jul 2019 19:50:56 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] btrfs-progs: add verbose option to btrfs device scan
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <e8aaa2cf-3e10-4ff9-dabe-c6192583e93c@gmx.com>
Date:   Tue, 16 Jul 2019 10:50:52 +0800
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <34F9F895-BFE6-4C99-9458-221D7555FECC@oracle.com>
References: <20190715144241.1077-1-anand.jain@oracle.com>
 <4f150d66-0c4d-b0f2-4cf9-9bc1194d83e9@suse.com>
 <e8aaa2cf-3e10-4ff9-dabe-c6192583e93c@gmx.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9319 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907160034
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9319 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907160034
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> On 16 Jul 2019, at 9:26 AM, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>=20
>=20
>=20
> On 2019/7/15 =E4=B8=8B=E5=8D=8811:09, Nikolay Borisov wrote:
>>=20
>>=20
>> On 15.07.19 =D0=B3. 17:42 =D1=87., Anand Jain wrote:
>>> To help debug device scan issues, add verbose option to btrfs device =
scan.
>>>=20
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>=20
>> I fail to see what this patch helps for. We get the path in case of
>> errors, in case of success what good could the path be ?
>=20
> AFAIK it would provide an easy way to debug blkid related bug.
>=20
> E.g. scan only works on some devices and misses some devices.
>=20
> So it makes sense to me, although "debug" would be more suitable in =
this
> case.

 As the objective is to show the devices scanned with
 its device path, so IMO verbose would be suitable?  Its a small change,
 can be modified at the time of integration. Will send V2 with a nit fix
 to use bool instead of int.

Thanks, Anand=
