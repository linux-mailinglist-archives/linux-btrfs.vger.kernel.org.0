Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1DD1CEEE8
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 May 2020 10:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbgELIOp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 May 2020 04:14:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58858 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgELIOp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 May 2020 04:14:45 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04C872ij189494;
        Tue, 12 May 2020 08:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=GQuingKlYsvDURAPKeIHbcaWUM2x52C8xJwssJEqQrc=;
 b=JfOxMj3U1mRDpdYmf4F6g3Smx7OlfCFKqgJwB4xvo43ej1xpCZexEhLQK98A1xLsCM/V
 mTvAahMIN0ouW3K5V05s5QKlC2MEWONRIPToyGY8WmltgfOtICnIAvm6l3hwj2VClE4H
 HXIvF4a+o5RZ9QMbF1XXKqVVogvr+ePphhmltngmzZijAh0mxMHCQPInYMg1VH+MS5wi
 XUnATlXVjjI9+n7OdPpqyHB9KV60tH/+P7TXuOofbAMh/WO7633xuQmdFPZExgKMGyz0
 PwFPsmiA2/S5kvYasDFBP2qA9KCb9N01ULKM+jX3aas3RO+UkvxQTaV2XABsnxll9a9/ 4A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 30x3gshf2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 May 2020 08:14:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04C8DuMJ136925;
        Tue, 12 May 2020 08:14:41 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 30ydspy68f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 May 2020 08:14:40 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04C8EdUW009620;
        Tue, 12 May 2020 08:14:40 GMT
Received: from [192.168.1.102] (/39.109.177.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 May 2020 01:14:39 -0700
Subject: Re: [PATCH] btrfs: unexport btrfs_compress_set_level()
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc:     "dsterba@suse.com" <dsterba@suse.com>
References: <20200512053751.22092-1-anand.jain@oracle.com>
 <SN4PR0401MB3598A397B1E8CDAE64C51DF59BBE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <8acf6de2-38dd-034a-c666-4d1861f7b175@oracle.com>
Date:   Tue, 12 May 2020 16:14:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB3598A397B1E8CDAE64C51DF59BBE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005120070
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 clxscore=1011 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005120069
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> Why did you move the function?

  Oh. In the original code, in compression.c the function call
  (in btrfs_compress_pages()) come first before the function definition.
  So to avoid the re-declaration moved the function up.

> Apart from that,
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Thanks.
