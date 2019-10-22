Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 624EDE01AE
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 12:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbfJVKKf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Oct 2019 06:10:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42168 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727609AbfJVKKe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Oct 2019 06:10:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9MA3drG006339;
        Tue, 22 Oct 2019 10:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=0Oqr+k0HBOPw7ecvCltzYqG5AbcdaP80Pndej6LcARM=;
 b=H1hgy/k3L6GGE++h7OrC4IZ43Y59WIngcWMsSsAU7G/4m0bKmBZ4dC986GZgUH/0y+8Q
 a4/iCtNCL+3zNd9m//N5hmqlWztRl5bO9SjVaS08cxGLOi5TbSEyoqg4He1lxl3Nuq97
 5i2vNGiGF8if5VAPb6VS8yJnPHRBv9FUftGWciBpLuaQ0Sw/XVXdOD4rXwalA+YSYCGe
 twjpn2Bs7VmOrCGebtpBmR/qEJqQzJxHy+BlzN7pzOI9TO4HFwMFD4q85JgolUeqWq8l
 kfe/JmwgLIW5aPG2vV0IVnw1KYDZzC9SfIfAX7t5FoUEhUf8XHr/U4h11HQfNOrehlZa zQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2vqu4qnd99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Oct 2019 10:10:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9MA8Xca049715;
        Tue, 22 Oct 2019 10:10:26 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2vsp3xtwwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Oct 2019 10:10:26 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9MAANQa026794;
        Tue, 22 Oct 2019 10:10:24 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Oct 2019 03:10:23 -0700
Subject: Re: feature request, explicit mount and unmount kernel messages
From:   Anand Jain <anand.jain@oracle.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtTPAm6eGA80y9LYc+Jaeo1wB0+vOMvO6B02o5JJKRFrhw@mail.gmail.com>
 <d1b51dc7-38c0-89d2-e51f-803e19773936@oracle.com>
Message-ID: <c31f8248-4097-34ff-6d5d-7f0d7d05a61c@oracle.com>
Date:   Tue, 22 Oct 2019 18:10:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d1b51dc7-38c0-89d2-e51f-803e19773936@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9417 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910220093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9417 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910220093
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/22/19 5:55 PM, Anand Jain wrote:
> 
>   I agree, I sent patches for it in 2017.
> 
>   VFS version.
>     https://patchwork.kernel.org/patch/9745295/
> 
>   btrfs version:
>     https://patchwork.kernel.org/patch/9745295/

David, I mean, do you think I should revive the above btrfs patch?

Thanks, Anand

