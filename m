Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 156D4161F55
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2020 04:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgBRDOg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 22:14:36 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39664 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbgBRDOg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 22:14:36 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01I3DE7Q112614;
        Tue, 18 Feb 2020 03:14:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=TjPXhulibGYh6gesJn2QXRjUMlybOft5mytGvTPclgk=;
 b=vwYbkbOdJ8MpmI50y6rlZtUIjHntGPB02nlnYmlC9g0LkbWxMBn5h4ksEUZXbNZ/RTlC
 QURbQ1F3sTG/HNdDlSzR7N92sZshZ6fShgWRghZYTJRM1Bmxtyhh1RHHIXNFXsGFzu4K
 FPIHT4Amaqq7heLwn4mIGyHNt/BcWBftRLHcE0F0NouQttNPySXBHEidOUkSvHyfawyn
 9BV5pytru4S87g06VRudh8CP0N2KsFQuW3Hv5klGjwufWK5iMK1QubSkbGG6DfS8a3Jc
 Vp+WVMTQH+mSgL3PyPw1yNxM+/SXmlZDJNKsN2KxlY5NBrK20gUpKUQN24SNZfp0JSBf rQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2y68kqtwgk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 03:14:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01I3C0v0068946;
        Tue, 18 Feb 2020 03:14:26 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2y6tenav78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 03:14:26 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01I3EMlC019411;
        Tue, 18 Feb 2020 03:14:22 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Feb 2020 19:14:22 -0800
Subject: Re: [PATCH v8 3/8] btrfs: reduce scope of btrfs_scratch_superblocks()
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20200213152436.13276-1-johannes.thumshirn@wdc.com>
 <20200213152436.13276-4-johannes.thumshirn@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <5800c692-6860-e9b1-41dc-c028ce2137f7@oracle.com>
Date:   Tue, 18 Feb 2020 11:14:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200213152436.13276-4-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9534 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=797 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002180024
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9534 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=831 malwarescore=0 priorityscore=1501
 clxscore=1011 mlxscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002180024
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/13/20 11:24 PM, Johannes Thumshirn wrote:
> btrfs_scratch_superblocks() isn't used anywhere outside volumes.c so
> remove it from the header file and mark it as static.
> 
> Also move it above it's callers so we don't need a forward declaration.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>
