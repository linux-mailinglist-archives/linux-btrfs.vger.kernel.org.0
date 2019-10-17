Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDCF9DA2E8
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 03:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391692AbfJQBDN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Oct 2019 21:03:13 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33468 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfJQBDM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Oct 2019 21:03:12 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9H0wn8O060144;
        Thu, 17 Oct 2019 01:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2019-08-05;
 bh=n2OqJZEJomA4PMWWxuifxCwpJn80BmCeV+5rIQLSa+Y=;
 b=CajPXxvYrTjAx1IJ233ii/q01WI6sbKshWxoCk/TmuLerJkkVSCeX+Ph3sw2Cq6rqs5h
 Mzrh3Q6S9wY+plWWCCFHGSnBHCknjDfNdJAL5Bp0cYgpsdFLE0Czu8itHJ2Yo7x/qAqv
 BENttvYja+bhj7yhJnfIpuJgfGEZI/B2iZdZbI3vUv5OjDalogmuMghpPo9ZaiIodEJB
 +L6GoGGPthezQBlPfu839QqU+rf0epmIXQXKjVxt/UzW/6CiZt8lthSGZH7ozblTWno5
 FQDtSMxUT2dJggLhpxlCjqZFjIuk43glgjh+6yGKYDxkun8PWqWrX/Iuc0rDCSxtk3t/ EQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2vk6sqtt1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 01:03:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9H12p27009063;
        Thu, 17 Oct 2019 01:03:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2vpcm1vhm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 01:03:08 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9H1384u030716;
        Thu, 17 Oct 2019 01:03:08 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Oct 2019 01:03:08 +0000
Subject: Re: [PATCH RESEND] btrfs-progs: btrfstune -M|m drop test_uuid_unique
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <20191010075352.8352-1-anand.jain@oracle.com>
Message-ID: <51f0c05b-4c12-d835-5615-f8a0cd063508@oracle.com>
Date:   Thu, 17 Oct 2019 09:03:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191010075352.8352-1-anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910170004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910170003
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


David,

Ping (4th time).

Per general rule of thumb tools like btrfs-progs must be flexible and
kernel should be harden for the duplicate fsid.

This patch relaxes the unnecessary check in btrfstune -M.

Without this patch there is no way to undo a changed fsid on the system.

Per original author there is no reasonable explanation why this check is
there in the first place until now.

IMO this patch is good integrate.

Please let me know if otherwise.

Thanks, Anand


On 10/10/19 3:53 PM, Anand Jain wrote:
> It's common to copy/snapshot an OS image to run another instance of the OS.
> A duplicate fsid can't be mounted on the same system unless the fsid is
> changed by using btrfstune -m.
> 
> However in some circumstances the image needs to go back to the original
> fsid /metadata_uuid.
> 
> As of now btrfstune -M fails if the specified uuid isn't unique, as show
> below.
> 
> btrfstune -M $(btrfs in dump-super ./2-2g.img | grep metadata_uuid | \
> 					awk '{print $2}') ./2-2g.img
> ERROR: fsid 87f8d9c5-a8b7-438e-a890-17bbe11c95e5 is not unique
> 
> But as we are changing the fsid of an unmounted image, so its ok to
> leave it to the users choice if the fsid is not unique, so that the
> image can be sent back the system where it was used with that fsid.
> 
> So this patch drops the check test_uuid_unique() in btrfstune -M|m.
> Thanks.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> Previous sent patch and its discussions:
> https://patchwork.kernel.org/patch/11134157/
> 
>   btrfstune.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/btrfstune.c b/btrfstune.c
> index afa3aae35412..4befcadef8b1 100644
> --- a/btrfstune.c
> +++ b/btrfstune.c
> @@ -570,10 +570,6 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>   			error("could not parse UUID: %s", new_fsid_str);
>   			return 1;
>   		}
> -		if (!test_uuid_unique(new_fsid_str)) {
> -			error("fsid %s is not unique", new_fsid_str);
> -			return 1;
> -		}
>   	}
>   
>   	fd = open(device, O_RDWR);
> 

