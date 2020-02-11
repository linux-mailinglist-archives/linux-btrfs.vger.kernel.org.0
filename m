Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 277ED158934
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 05:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbgBKErR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Feb 2020 23:47:17 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59068 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgBKErR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Feb 2020 23:47:17 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01B4iVSk183487;
        Tue, 11 Feb 2020 04:47:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=pN8N1CwLoOzcHosaL8zxV/ZwcuhMs1YVUnUw95sVxDM=;
 b=gnEZY0DBlKTIAc/g33UH9JOCU4gUrd9gIYQX3Gam+GjWesnfJTr2747hBeCW/NgxgYoz
 CuW+rghTFpmqNvXZDSraT2OHnX6CIrmvjXBy2GLePzruiGjwTJS6IqHagspkFK1bNQZR
 N5AzLj5j8YZKonDvolgsnXMjhheVtInLHHxDZeiooo6k6DLdq51tO2XSEt+rYyrIlIW4
 Z0NqUSlk6HlOV7HRoBGRPPXfXMMBqOsnosQ6nwaPu50ywTlgkoypHyQOsm/mWw10P+ht
 crvOhxt+19ZbWjtToizZWzr8ffjPL2yOtuTIYtJP9sEqkcNN95gtoH8jWdliFc5kRtHZ 6w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2y2k880tup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Feb 2020 04:47:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01B4gPf1068196;
        Tue, 11 Feb 2020 04:47:08 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2y26snubmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Feb 2020 04:47:08 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01B4l7pj031588;
        Tue, 11 Feb 2020 04:47:07 GMT
Received: from [192.168.1.145] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Feb 2020 20:47:06 -0800
Subject: Re: [PATCH 0/4 RESEND 1-3/4 v5 4/4] btrfs, sysfs cleanup and add
 dev_state
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <20200203110012.5954-1-anand.jain@oracle.com>
 <20200203171659.GA2654@twin.jikos.cz>
 <c0ac6404-ed46-be94-ac05-01c723f05134@oracle.com>
 <20200206141136.GX2654@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <5a9e45e2-645c-e15e-c87c-6914d3e2f397@oracle.com>
Date:   Tue, 11 Feb 2020 12:46:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206141136.GX2654@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9527 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002110032
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9527 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002110032
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/6/20 10:11 PM, David Sterba wrote:
> On Thu, Feb 06, 2020 at 02:31:02PM +0800, Anand Jain wrote:
>>
>>
>> On 2/4/20 1:16 AM, David Sterba wrote:
>>> On Mon, Feb 03, 2020 at 07:00:08PM +0800, Anand Jain wrote:
>>>> Resend:
>>>>     Patch 4/4 is already integrated without the cleanup and preparatory
>>>>     patches (1,2,3)/4. So I am resending those 3 patches. And the changes
>>>>     in patch 4/4 as in misc-next is imported into patch v5 4/4 here. Patch
>>>>     4/4 has the details of the changes.
>>>
>>> All the patches have been merged and now are in linus/master branch.
>>
>>
>> David,
>>
>>> I haven't reordered the patches so they're not in a group and the
>>> preparatory patches are about 10 commits above v5.5-rc7 which is the
>>> beginning of the branch.
>>
>>
>>    It will cause problem during bisect, without the preparatory patches
>>    the devid kobject lands under devices instead of under devinfo,
>>    that's how I noticed that preparatory patches are missing.
> 
> I've tested current master and the device ids are indeed placed under
> device/ and there is no devinfo/, so this needs to be fixed.
> 
> Preparatory patches I was referring to are:
> 
> bc036bb33524  btrfs: sysfs, merge btrfs_sysfs_add devices_kobj and fsid
> be2cf92e0a2f  btrfs: sysfs, rename btrfs_sysfs_add_device()
> c6761a9ed329  btrfs: sysfs, btrfs_sysfs_add_fsid() drop unused argument parent
> b5501504cb6a  btrfs: sysfs, rename devices kobject holder to devices_kobj
> 
> so I'll have another look at what you sent.
> 
David,

  Busy? Can I ping on this?

  Those aren't the preparatory patches. The patches sent here applies
  nicely on misc-next with git revert 668e48af7a94

Thanks, Anand
