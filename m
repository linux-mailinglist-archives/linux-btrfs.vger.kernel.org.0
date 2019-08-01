Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9F737D4A7
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2019 06:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbfHAEvS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Aug 2019 00:51:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54786 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbfHAEvS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Aug 2019 00:51:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x714nRfq017969;
        Thu, 1 Aug 2019 04:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=+yr+tFreBibGQBrpZ2mKTrjHf4PuYaCNCVAToARn8k0=;
 b=aTqtuMltZKsxpfPzwqYCuqMntypM4BEuoUd8eu4bNTsg+ewMVZjhg2LD3i6ECtoUQ8rW
 aWEmIwfLmJfxAKO4yev9K/D4SsXjcOP5nva/jBcNl+dKQ3Bjj9o2yKkTZ+wwXBI5RU9g
 NszvG+JWmMEHvbE4KWRA5bRc9cCwSvB+TNFz8I9ZCtuuoeY/VijIY49bD/LI9qT7Vz94
 0sA+Qvl6MGRzw4kBg8lzk9pE1JpX9yYS4I0qV3vIQvNqSP2bmP9VzDSyD58vf/8DUBp0
 ANfzpxZTM843bkuKtpvO+abNbhWVV0rauPofuudsR+mjahkri3jhCrlRME96UCuZXier 8Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2u0f8r9207-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Aug 2019 04:51:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x714mEwD097032;
        Thu, 1 Aug 2019 04:51:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2u3mbtpxbf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Aug 2019 04:51:08 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x714p4nq018867;
        Thu, 1 Aug 2019 04:51:07 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 31 Jul 2019 21:51:04 -0700
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>
References: <bcb1a04b-f0b0-7699-92af-501e774de41a@petaramesh.org>
 <f8b08aec-2c43-9545-906e-7e41953d9ed4@bouton.name>
 <02f206eb-0c36-6ba7-94ce-f50fa3061271@bouton.name>
 <6fb5af6c-d7b8-951b-f213-e2b9b536ae6a@petaramesh.org>
 <d8c571e4-718e-1241-66ab-176d091d6b48@bouton.name>
 <f8dfd578-95ac-1711-e382-7304bf800fb2@petaramesh.org>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     Lionel Bouton <lionel-subscription@bouton.name>,
        linux-btrfs@vger.kernel.org
Message-ID: <c4885e92-937c-8fc7-625a-3bfc372e3bf5@oracle.com>
Date:   Thu, 1 Aug 2019 12:50:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f8dfd578-95ac-1711-e382-7304bf800fb2@petaramesh.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9335 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=865
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908010045
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9335 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=916 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908010045
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/7/19 10:04 PM, Swâmi Petaramesh wrote:
> On 7/29/19 3:58 PM, Lionel Bouton wrote:
>> For example I suspected that your SSD is a SATA one and I remember
>> data corruption bugs where the root cause was wrong assumptions made
>> between the filesystem layer and the io scheduler. As NVMe devices
>> triggered major io scheduler rework it seemed worthwhile to mention
>> that my system might differ from yours on this.
> 
> So, I've had the issue of 23 FSes so far :
> 
> - BTRFS FS on LVM over LUKS on a SATA SSD.
> 
> - BTRFS FS directly over LUKS on an USB-3 mechanical HD.
> 
> (All this having been perfectly stable until upgrade to 5.2 kernel...)
> 

  What kind of btrfs chunk profiles were used here (I guess its either 
single or dup)?
