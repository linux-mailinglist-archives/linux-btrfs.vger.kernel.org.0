Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADD34153ECA
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 07:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgBFGdR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 01:33:17 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48952 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgBFGdR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 01:33:17 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0166Sws8112862;
        Thu, 6 Feb 2020 06:33:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=XUW26hplB+v21NEcNSKQA4ybbU+AImpQkchp36Ng5iE=;
 b=XCOivmCkyVSx8DcNjs2cpi7U5nzgn6OuIxfN9lVcx0lYI4yqUPDV7DkQM+rL03088Q6I
 Au6hWbM0oNHOPB5hrD25Sux0WpAstAdbcBGjO3+4uzo9zr1d6n3HU07kwi0oID8PuEfg
 GigJEd07r1rkhaM9v0/zWA+ZDmWW0gaS4NCYrjS5B8mmghGwLQzdvtbB07B898CrGmw2
 4XnaitObyXZ4POQAneWPgK05ax3hqUxCoKlZ5RQS7VNO583NRCQ0wJYLeFbzX39zkM8u
 cX37zGG+n/GjxHvL2gQndzT0OQc1NSEON15IVrHqRtpxHEUSUq48kUegsO7SJUIvDjuc PQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=XUW26hplB+v21NEcNSKQA4ybbU+AImpQkchp36Ng5iE=;
 b=b7me3yt64RVjc9z9v0zW/3PAE2WHECzT7DUta18kdkOe7T20CXLTJ6aDynskUUSJ98uG
 AsJ4Fqj6MD2i9L6nb3PXeRhffcC8ezJ0HQeDCa5iuAfe9RynPNFa1Zm49s0ndvi/VFXL
 vFltMofXRbKh1kt0fxd665/6Ht3NATPvoNXW4nNfc3Jld/ZU5r6OMq1b6go0i3CImQDw
 DVbyNad+WsB+tHvN0pG+/CFqj9coEoXw5m64wcTHYOu1YqoATO/QP1Yfxcw+ZRu6BM1r
 xsUq8kkIi4tQlHxbRYSAK1BPy0uwZp/SUcZBLNbKlk+NznmYfVmjJTXVl05045HrjXiW /g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2xykbpfn2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Feb 2020 06:33:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0166TUqb094766;
        Thu, 6 Feb 2020 06:31:09 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2y080cbpuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Feb 2020 06:31:09 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0166V7ZX016009;
        Thu, 6 Feb 2020 06:31:07 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Feb 2020 22:31:07 -0800
Subject: Re: [PATCH 0/4 RESEND 1-3/4 v5 4/4] btrfs, sysfs cleanup and add
 dev_state
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <20200203110012.5954-1-anand.jain@oracle.com>
 <20200203171659.GA2654@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <c0ac6404-ed46-be94-ac05-01c723f05134@oracle.com>
Date:   Thu, 6 Feb 2020 14:31:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203171659.GA2654@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9522 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002060049
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9522 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002060049
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2/4/20 1:16 AM, David Sterba wrote:
> On Mon, Feb 03, 2020 at 07:00:08PM +0800, Anand Jain wrote:
>> Resend:
>>    Patch 4/4 is already integrated without the cleanup and preparatory
>>    patches (1,2,3)/4. So I am resending those 3 patches. And the changes
>>    in patch 4/4 as in misc-next is imported into patch v5 4/4 here. Patch
>>    4/4 has the details of the changes.
> 
> All the patches have been merged and now are in linus/master branch.


David,

> I haven't reordered the patches so they're not in a group and the
> preparatory patches are about 10 commits above v5.5-rc7 which is the
> beginning of the branch.


  It will cause problem during bisect, without the preparatory patches
  the devid kobject lands under devices instead of under devinfo,
  that's how I noticed that preparatory patches are missing.

Thanks, Anand

