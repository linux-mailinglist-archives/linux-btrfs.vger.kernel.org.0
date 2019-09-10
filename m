Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFAE3AE64F
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2019 11:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfIJJHi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Sep 2019 05:07:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40250 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfIJJHi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Sep 2019 05:07:38 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8A93qsD072320;
        Tue, 10 Sep 2019 09:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=743zzefuoXALvD9A+/t6ZSLbjH1Uslfdtc7/3Vdupvs=;
 b=XhWxejF+ck2rnr7cvdcMBArBsH4gfGx4mgMSmHDCTAZXForLyQMNZOXlNShNhDrZhZ+r
 hqPkZh5W3IsNEOULhqRrnZUsBuYMswhCFPIBtqqcS+VnNa2hMyDQ1QelSAcBh+f3Suzc
 Yezf4+TNPmhKf1RX6xbryrDJ9ou9VIU3PLNr9g7foC5OKZ2fn5mttgaL+JWy3237suFx
 xtz9i5ye+NopEZzA/Hrd7GUwgh7QMG+blfoB2HjFOqn/ApVukI/mTCwx6Nbi4GOZODyQ
 efhNOAuDJzL5vsM++/3+TpGko9teMCMWOLxanBvvzvC8C59EMq6XAIF++4CECjKOteze Xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2uw1jk9yee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Sep 2019 09:07:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8A937J8028288;
        Tue, 10 Sep 2019 09:07:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2uwqktfygw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Sep 2019 09:07:11 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8A97AhQ019899;
        Tue, 10 Sep 2019 09:07:10 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Sep 2019 02:07:10 -0700
Subject: Re: [PATCH v3 2/2] btrfs: tree-checker: Fix wrong check on max devid
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20190828023313.22417-1-wqu@suse.com>
 <20190828023313.22417-2-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <325a8560-b172-0826-95b7-c0922f8e2c50@oracle.com>
Date:   Tue, 10 Sep 2019 17:07:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190828023313.22417-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9375 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909100092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9375 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909100092
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org





> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index ccd5706199d7..15d1aa7cef1f 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -686,9 +686,7 @@ static void dev_item_err(const struct extent_buffer *eb, int slot,
>   static int check_dev_item(struct extent_buffer *leaf,
>   			  struct btrfs_key *key, int slot)
>   {
> -	struct btrfs_fs_info *fs_info = leaf->fs_info;
>   	struct btrfs_dev_item *ditem;
> -	u64 max_devid = max(BTRFS_MAX_DEVS(fs_info), BTRFS_MAX_DEVS_SYS_CHUNK);

As I commented in v2.
I see that BTRFS_MAX_DEVS_SYS_CHUNK is not being used anywhere
else after this being removed. So good to delete the define.
I am bit surprised as well if I am missing?

Thanks, Anand
