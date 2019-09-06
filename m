Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6E44AB4E1
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2019 11:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392864AbfIFJ13 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Sep 2019 05:27:29 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53822 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfIFJ13 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Sep 2019 05:27:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x869O48i004154;
        Fri, 6 Sep 2019 09:27:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=4vtA4TrCDSrAfXnJgvttGzQEl5OpH712NFRkuSuYZdE=;
 b=ngA7m4GTNdTa1pnsnQDclopna/1uO0ddWAHWoF4VF+9l+kkIpcVMbl6V2vHrlrzsn2aw
 JRMo3Wq5NZdFONpNs9CYyQmeyTkZsSgI9UcjbqgLDRLC+QfN3z2KwXz/erF+au2q3UWE
 oKPeqg6GCn3ITUsXIT+PWjgGXgaBi2I84gNJMdslVTKRYDLAeyKxpPD+JsT3Zh6zNdlP
 L6WcguEJzJsYL8rzIsVZYW13zGjaUTD0jZjgrJJ5qMpA4N3NvDa6W2lRSFb517Iivaw4
 e7BBDPX3cKuVFGY5v8MLaB1qXpHN+9I1EkENGViJmucFvp1Bd5UtrAvcUj82bR5/6PwB cw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2uumbp87tt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Sep 2019 09:27:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x869NTgG105179;
        Fri, 6 Sep 2019 09:27:02 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2uud7pb8hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Sep 2019 09:27:02 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x869R1WT006760;
        Fri, 6 Sep 2019 09:27:01 GMT
Received: from [10.186.51.128] (/10.186.51.128)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Sep 2019 02:27:00 -0700
Subject: Re: [PATCH] btrfs-progs: drop unique uuid test for btrfstune -M
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20190906005025.2678-1-anand.jain@oracle.com>
 <f3d33e1d-803e-34a5-4dfa-7eeceec6177c@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <232bccd3-3623-8ee9-18db-98edf7cd2e25@oracle.com>
Date:   Fri, 6 Sep 2019 17:27:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f3d33e1d-803e-34a5-4dfa-7eeceec6177c@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9371 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909060098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9371 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909060098
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


<snip>

> This is intended. Otherwise it's an open avenue for the user to shoot
> themselves in the foot.

  I don't understand how?

> If you know what you are doing and are
> absolutely sure the original fs is no longer present 
> - then just flush
> libblkid cache and you'll be able to set the FSID back to the original one.
> 
<snip>

  No no its not about the stale cache holding the original fsid. The use
  case is - a golden copy of the bootable OS image is being used and
  shares the same fsid on multiple hosts.
  Now if you want to mount another copy it for some changes, you need to
  btrfstune -m on the copy. And later if you want to boot it
  successfully, it needs its original fsid back.

HTH, Anand
