Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE1818350D
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2019 17:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732298AbfHFPUv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Aug 2019 11:20:51 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42424 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfHFPUv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Aug 2019 11:20:51 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x76FDVo2058039;
        Tue, 6 Aug 2019 15:20:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=4eRpe1+h0SkaNG6q2rxXH5tTDhpbxAqt/q0I3g/AjQc=;
 b=YOMXwj1NWsiaQhlo64WXM+IcDit4Y56fE4OS97u1Pt1dTzZwuxR15gT+j/xL2jY1vPLT
 G3XMPl2fi1C/D0Gtr9gr8PmBqsdopnGnbQq5hcStcG7mcBZdWnD81JX9Z+bPF8w4ViWN
 S4meUhEAtkY0IdGolvocZO0EjCUYsQLj+6cRU9LeP5LxRq2wfWP+GGqIrc7R1LYHGcvM
 hGmopPbwBPlmlRM0LbOkHatSBTjX1E48flGT4wNwyWp+GuXVv6tkjLR1U/oe0zAUG2Kv
 GM5+pYwIa9GIEAg6VanwoTPxkd5LHUh1l/sTSIXxow1v4tMkvA2GC2mca0aM/tupyFQS tQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2u527pptm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Aug 2019 15:20:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x76FGJIs194869;
        Tue, 6 Aug 2019 15:20:43 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2u75bvkb2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Aug 2019 15:20:43 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x76FKVjN015187;
        Tue, 6 Aug 2019 15:20:32 GMT
Received: from [192.168.1.147] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 06 Aug 2019 08:20:31 -0700
Subject: Re: [PATCH] btrfs-progs: docs: fix label property description
To:     Hans van Kranenburg <hans@knorrie.org>, linux-btrfs@vger.kernel.org
Cc:     Hans van Kranenburg <hans.van.kranenburg@mendix.com>
References: <20190803214403.1040-1-hans@knorrie.org>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <f2b90bc0-1a23-5879-d3d4-e0c1b259e1cc@oracle.com>
Date:   Tue, 6 Aug 2019 23:20:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190803214403.1040-1-hans@knorrie.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9341 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908060150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9341 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908060150
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/4/19 5:44 AM, Hans van Kranenburg wrote:
> From: Hans van Kranenburg <hans.van.kranenburg@mendix.com>
> 
> Recently, commit c9da5695b2 improved the description for the label
> property, to clarify it's a filesystem property, and not a device
> property. Follow this change in the man page for btrfs-property.
> 
> Also add a little hint about what to specify as object.
> 
> Signed-off-by: Hans van Kranenburg <hans.van.kranenburg@mendix.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>



> ---
>   Documentation/btrfs-property.asciidoc | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/btrfs-property.asciidoc b/Documentation/btrfs-property.asciidoc
> index b562717b..47960833 100644
> --- a/Documentation/btrfs-property.asciidoc
> +++ b/Documentation/btrfs-property.asciidoc
> @@ -43,7 +43,8 @@ the following:
>   ro::::
>   read-only flag of subvolume: true or false
>   label::::
> -label of device
> +label of the filesystem. For an unmounted filesystem, provide a path to a block
> +device as object. For a mounted filesystem, specify a mount point.
>   compression::::
>   compression algorithm set for an inode, possible values: 'lzo', 'zlib', 'zstd'.
>   To disable compression use "" (empty string), 'no' or 'none'.
> 

