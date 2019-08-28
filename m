Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6EDEA03CB
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2019 15:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfH1N4v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Aug 2019 09:56:51 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51372 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfH1N4v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Aug 2019 09:56:51 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7SDnK9O055494;
        Wed, 28 Aug 2019 13:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=KmUqy6IRaf1apgVcFrF1MuHKTUwGAXG+0/xdzzPXcOI=;
 b=p0XVGy3f/tTJtrs/wLab7DQ9vc/DZuJcYUNOJd+vUdzxUIkPmr6tqNoykWBuGzdbnyYB
 0b0m+L6NbXh77ezLjA3BX/uVvw66sQcWRHTzNYCnvzew9S/TSzPwyv6SxlgHWWbjv9gZ
 YjAluu34lc9N9A4bYNZ9+iyfxfngvFqDivyDBZaxjUYGVNH8QNeO3tHdJdyhG7XFi20O
 paIzsQ8gyXGyVdyBpd6pvHPTPWu/+uBOSrY6lXF154afHJYs+E9vTN1LgkO0nw0FKgMT
 TKjTDvA128d6+/9cK1L5DF3eeaJbZndwabdb9LExSqHo85V+pJeMxTtIESfflDdCmV7Q 3g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2untrv03jn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 13:56:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7SDYKO7055292;
        Wed, 28 Aug 2019 13:49:44 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2undw7fuah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 13:49:44 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7SDnhNp025913;
        Wed, 28 Aug 2019 13:49:43 GMT
Received: from [192.168.1.119] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Aug 2019 06:49:42 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/2] btrfs-progs: add BTRFS_DEV_ITEMS_OBJECTID in comment
 in print-tree
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20190828132400.GB2752@twin.jikos.cz>
Date:   Wed, 28 Aug 2019 21:49:38 +0800
Cc:     Anand Jain <anand.jain@oracle.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <04CACA33-1584-4FB8-85BC-F2414A4BDCE3@oracle.com>
References: <20190828095619.9923-1-anand.jain@oracle.com>
 <f5992432-3bed-de22-0cb2-3c631aa01a03@suse.com>
 <20190828132400.GB2752@twin.jikos.cz>
To:     David Sterba <dsterba@suse.cz>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908280144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908280145
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> On 28 Aug 2019, at 9:24 PM, David Sterba <dsterba@suse.cz> wrote:
>=20
> On Wed, Aug 28, 2019 at 04:01:04PM +0300, Nikolay Borisov wrote:
>>=20
>>=20
>> On 28.08.19 =D0=B3. 12:56 =D1=87., Anand Jain wrote:
>>> So when searching for BTRFS_DEV_ITEMS_OBJECTID it hits. Albeit it is
>>> defined same as BTRFS_ROOT_TREE_OBJECTID.
>>>=20
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>> print-tree.c | 1 +
>>> 1 file changed, 1 insertion(+)
>>>=20
>>> diff --git a/print-tree.c b/print-tree.c
>>> index b31e515f8989..5832f3089e3d 100644
>>> --- a/print-tree.c
>>> +++ b/print-tree.c
>>> @@ -704,6 +704,7 @@ void print_objectid(FILE *stream, u64 objectid, =
u8 type)
>>> 	}
>>>=20
>>> 	switch (objectid) {
>>> +	/* BTRFS_DEV_ITEMS_OBJECTID */
>>=20
>> That comment looks really cryptic to someone just looking at the =
code.
>> Adding case BTRFS_DEV_ITEMS_OBJECTID: is better.
>=20
>>> 	case BTRFS_ROOT_TREE_OBJECTID:
>=20
> Both constants have the same value so they can't be in one switch, but
> yeah the comment should be a bit more verbose, just the constant name =
is
> bringing more questions than answers.

 Oh. Hmm. Let me try.

Thanks, Anand

