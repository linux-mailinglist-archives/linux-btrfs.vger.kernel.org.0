Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBC747F79B
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2019 14:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390832AbfHBM4h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Aug 2019 08:56:37 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38494 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390817AbfHBM4h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Aug 2019 08:56:37 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x72Cs1PS029628;
        Fri, 2 Aug 2019 12:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=HNaHuPDIrmsWRHoZucWaleNBxBTgi7FbVUcEpYuy1oM=;
 b=LVJZKU4ssn89/+4gWGP/ba+lUkGcr5kub1A1c8SGTAVCCUbK+mu25aeg87B93F+m2mly
 bak9QqMuqxYn2bj4ImCBG51Ya9h00/c//jH4OeI98kuAZFR4pmW8zFgcuOy2/IEEXjMT
 x9lRdT6hZ6Ci9uDS/qZSKtpjlEGHyf9mVhoh6AS0U0EkAxaRXMkgT8aiStwAGoJCVK9V
 7foADSkDiuBsbtQzcs3lsYB4WU8qLHlxUH3/2weeKX1X1w2lhweRsvs+IiI6vrrSKk2j
 zCLz4Zj8LQIF6N4ZTgn1cGkttOU21E9UUITaVtLs1DHxpUhqgbPVfeves/uzxnHOnPw2 1g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2u0e1ua5v1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Aug 2019 12:56:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x72CqnHk036489;
        Fri, 2 Aug 2019 12:54:32 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2u3mbvjpxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Aug 2019 12:54:32 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x72CsVAh021115;
        Fri, 2 Aug 2019 12:54:31 GMT
Received: from [192.168.1.147] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 02 Aug 2019 05:54:31 -0700
Subject: Re: The btrfs 'label' property: device or filesystem-wide?
To:     Hans van Kranenburg <hans@knorrie.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <8e535199-800a-b794-07e4-cb42f2f9b0c5@knorrie.org>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <79005fd4-3314-aa73-5830-caad37ff1f2c@oracle.com>
Date:   Fri, 2 Aug 2019 20:54:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <8e535199-800a-b794-07e4-cb42f2f9b0c5@knorrie.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9336 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908020132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9336 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908020132
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/2/19 5:42 PM, Hans van Kranenburg wrote:
> Hi,
> 
> I was just looking at btrfs property and what it can do.
> 
> Now, I notice that the man page contains:
> 
>    label: label of device
> 
> When I look at a device and ask what properties I can set, I see:
> 
> -# btrfs property list -t device /dev/xvdb
> label               Set/get label of device.
> 
> But, when I try to set it, it complains:
> 
> -# btrfs property set -t device /dev/xvdb label yolo
> ERROR: device /dev/xvdb is mounted, use mount point
> 
> A mount point points to a whole filesystem, not a specific device.
> 
> -# btrfs property set -t device /btrfs label yolo
> 
> The result is that the label at filesystem level is set. A device
> doesn't even have something like a label itself.
> 
> -# btrfs fi show
> Label: 'yolo'  uuid: 370415b8-b96f-456e-8713-6833b2a65127
> 	Total devices 4 FS bytes used 144.00KiB
> 	devid    1 size 10.00GiB used 1.00GiB path /dev/xvdb
> 	devid    2 size 10.00GiB used 1.00GiB path /dev/xvdc
> 	devid    3 size 10.00GiB used 288.00MiB path /dev/xvdd
> 	devid    4 size 10.00GiB used 288.00MiB path /dev/xvde
> 
> So, am I missing something, or should this have been:
> 
> -# btrfs property set -t filesystem label foo /mountpoint

Yes. Label is for the whole filesystem.

Initially the label was set-able only using the device path (after
mkfs), for which the device has to be in unmounted state.

So when we implemented the label ioctl, so that label can be set on the
mounted fs, we had to maintain its backward compatible.

So at both, btrfs fi label and btrfs prop set the label works on the
mount-point or the device path if its unmounted. And even if the device
path is used the label is for the whole filesystem.

HTH
Anand


> Hans
> 

