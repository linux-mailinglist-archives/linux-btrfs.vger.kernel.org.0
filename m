Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B061D93E8
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 May 2020 12:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgESKCo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 May 2020 06:02:44 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41284 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgESKCn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 May 2020 06:02:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04JA1hcD038047;
        Tue, 19 May 2020 10:02:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=CrMNP7uTiyM+3erDd6enSk9WDSnH7i6Ecsz3fiQHQbE=;
 b=k+mY+Tx8FNYOFDQnbNskCKtfhlwkE+9h7T+TkF2Fm1yx81EKa4meg2n+AbxPqMwmsdyf
 2VMkBOqrOVzEiSiQZHdVC63N3XjQ2jtjY6Gku0XbeDXTsYDrz85bcispl5fmqGE5k1uH
 he1Ir3Jr5zBP17VqFJX//lwJC3srAuRSyalnq+f5x6ahx5KaCTQJxPa2593O5uPPNOQn
 cOa7mf7JDmAy7qgi3F0FB9B6d8kvFzs3yNRwzXr21R1lF0ULa8Vjz+EB8bzCJy0LsdBK
 rQyKaL9CRAdjwONP5OjDt0hbDS8pPpPExbunaFy3tBb87wuBCyVliQRhvpT3DVdf0+lm eA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 31284kvg19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 May 2020 10:02:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04J9xBVM040935;
        Tue, 19 May 2020 10:02:36 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 312sxsd1ae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 May 2020 10:02:36 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04JA2ZJr026916;
        Tue, 19 May 2020 10:02:36 GMT
Received: from [192.168.1.102] (/39.109.177.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 May 2020 03:02:35 -0700
Subject: Re: [PATCH v7 rebased 0/5] readmirror feature (sysfs and in-memory
 only approach; with new read_policy device)
To:     dsterba@suse.cz, dsterba@suse.com, linux-btrfs@vger.kernel.org
References: <1586173871-5559-1-git-send-email-anand.jain@oracle.com>
 <a963d6c8-f0ec-7d41-ff0a-26d3ef9d013d@oracle.com>
 <20200515195858.GS18421@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <c61a44bf-04ab-01a0-3fbe-4d5970827085@oracle.com>
Date:   Tue, 19 May 2020 18:02:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515195858.GS18421@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9625 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005190090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9625 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 cotscore=-2147483648 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005190090
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 16/5/20 3:58 am, David Sterba wrote:
> On Thu, Apr 30, 2020 at 05:02:27PM +0800, Anand Jain wrote:
>>    I am not sure if this will be integrated in 5.8 and worth the time to
>>    rebase. Kindly suggest.
> 
> The preparatory work is ok, but the actual mirror selection policy
> addresses a usecase that I think is not the one most users are
> interested in. Devices of vastly different performance capabilities like
> rotational disks vs nvme vs ssd vs network block devices in one
> filesystem are not something commonly found.
> 
> What we really need is a saner balancing mechanism than pid-based, that
> is also going to be used any time there are more devices from the same
> speed class for the fast devices too.
> 

There are two things here, the read_policy framework in the preparatory
patches and a new balancing or read_policy, device.

> So, no the patchset is not on track for a merge without the improved
> default balancing.

It can be worked on top of the preparatory read_policy framework?
This patchset does not change any default read_policy (or balancing)
which is pid as of now. Working on a default read_policy/balancing
was out of the scope of this patchset.

> The preferred device for reads can be one of the
> policies, I understand the usecase and have not problem with that
> although wouldn't probably have use for it.

For us, read_policy:device helps to reproduce raid1 data corruption
    https://patchwork.kernel.org/patch/11475417/
And xfstests btrfs/14[0-3] can be improved so that the reads directly
go the device of the choice, instead of waiting for the odd/even pid.

Common configuration won't need this, advance configurations assembled
with heterogeneous devices where read performance is more critical than
write will find read_policy:device useful.

Thanks, Anand
