Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F0F252BB8
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 12:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgHZKut (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Aug 2020 06:50:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48826 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728754AbgHZKum (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Aug 2020 06:50:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07QAnDtx066352;
        Wed, 26 Aug 2020 10:50:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=cIpfR1+f026tJyCCXa8+Y0eGryrNVG5MAH7MYZ4IG5k=;
 b=TdyUZgRrcsZxO3HRgaOJbCtaOdSmC27o3ekmQLMhUakgsKOwA88a/qEpw4kC2j6LClyM
 GtItLLKAtJEp/I90B+VvQvx2WDK/qqPgJozfyNFsKUfz+rFL/B+2wEeuXOm4eamEGzEA
 lIVg7KNAcXR8Pob/acyz2eAMuQyd66L4b67e/szHVG3kuxOMDFPzZiSe2I//yIXwnRdY
 ehRIts5VQuVSfTqZPhWRBRO6tD4u8faeFMNGNY1YedtOS1tt3usWn9sEoEWB3a0dy3Z/
 cgpYyic34raFsHeaf4glc9AsyGPGupf9ezVALCHxxe6KWDOeKTMLP/BPKZFixYcsS9R6 7w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 335gw81h1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Aug 2020 10:50:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07QAkFDc033785;
        Wed, 26 Aug 2020 10:50:36 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 333ru9yvh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Aug 2020 10:50:36 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07QAoZ24031948;
        Wed, 26 Aug 2020 10:50:35 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Aug 2020 03:50:35 -0700
Subject: Re: [PATCH 4/5] btrfs: Simplify setting/clearing fs_info to
 btrfs_fs_devices
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200715104850.19071-1-nborisov@suse.com>
 <20200715104850.19071-5-nborisov@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <3ae321dd-66d7-ebb2-8f68-89796bff73f4@oracle.com>
Date:   Wed, 26 Aug 2020 18:50:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200715104850.19071-5-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 lowpriorityscore=0
 mlxscore=0 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260087
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/7/20 6:48 pm, Nikolay Borisov wrote:
> It makes no sense to have sysfs-related routines be responsible for
> properly initialising the fs_info pointer of struct btrfs_fs_device.
> Instead this can be streamlined by making it the responsibility of
> btrfs_init_devices_late to initialize it. That function already
> initializes fs_info of every individual device in btrfs_fs_devices.
> 
> As far as clearing it is concerned it makes sense to move it to
> close_fs_devices. That function is only called when struct
> btrfs_fs_devices is no longer in use - either for holding seeds or main
> devices for a mounted filesystem.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>


Reviewed-by: Anand Jain <anand.jain@oracle.com>

