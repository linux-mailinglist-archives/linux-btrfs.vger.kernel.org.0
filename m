Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93621F12DC
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jun 2020 08:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgFHGbq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jun 2020 02:31:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52464 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgFHGbp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Jun 2020 02:31:45 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0586Ghwq195626;
        Mon, 8 Jun 2020 06:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2020-01-29;
 bh=l+bC9inXpPUw6/3CiTKCWHKErAOhK12mf9g9GvVM5sY=;
 b=lDj1J3UjNbp3O68FXaIPO2UTeFWQqAzzlG6m0xiIe3nVcG8u4lhzDuOAsJ14XsJULUpy
 wR2fxioWzJc4nLs2KN7IPs+beuLHwybvecuL6ZkZmIY0PES2NA78mEANob5/SoCLsTPU
 FDBvixvok7958tfIlhTj9dZ5PdxzkMZbYqrx50dRi/Eut5JV0VsnuWs1k0Fg6IeMiHJz
 heZrAc00iGaEoXgOAirO/OIlqqxKhTwQrVDDdPiDijl8Tnav/a3i57HhKFXxJiqrL+zg
 FWrWPsuarDfE5+X/Gmqdnw0TYdMNSA5GrsMK5GXVDrAZ9LOTz2wQeK500zwZCoAV6LzO Ew== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 31g33kw37p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 08 Jun 2020 06:31:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0586Hkqs016784;
        Mon, 8 Jun 2020 06:31:41 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 31gmqkt1wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jun 2020 06:31:40 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0586VdDY027278;
        Mon, 8 Jun 2020 06:31:39 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 07 Jun 2020 23:31:39 -0700
Subject: Re: [PATCH v2 06/16] btrfs-progs: filesystem defragment: use global
 verbose option
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.cz>
References: <1574678357-22222-1-git-send-email-anand.jain@oracle.com>
 <1574678357-22222-7-git-send-email-anand.jain@oracle.com>
Message-ID: <6c3bc461-c8e7-2fe8-4ffe-a71b105cf671@oracle.com>
Date:   Mon, 8 Jun 2020 14:31:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1574678357-22222-7-git-send-email-anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9645 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080048
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9645 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 cotscore=-2147483648 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006080048
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


There is small nit change as below, which I have done locally.
I haven't sent an updated patch yet as I think its better to
send this and other changes if any.

> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
> index 4f22089abeaa..fc1736d9fe66 100644
> --- a/cmds/filesystem.c
> +++ b/cmds/filesystem.c
> @@ -840,6 +840,8 @@ static const char * const cmd_filesystem_defrag_usage[] = {
>   	"-l len              defragment only up to len bytes",
>   	"-t size             target extent size hint (default: 32M)",
>   	"",
> +	HELPINFO_INSERT_GLOBALS,
> +	HELPINFO_INSERT_VERBOSE,
>   	"Warning: most Linux kernels will break up the ref-links of COW data",
>   	"(e.g., files copied with 'cp --reflink', snapshots) which may cause",
>   	"considerable increase of space usage. See btrfs-filesystem(8) for",

Move the new line "" from before HELPINFO_INSERT_GLOBALS to before Warning.

Thanks, Anand
