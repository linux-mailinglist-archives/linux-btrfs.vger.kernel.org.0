Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C127295963
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Oct 2020 09:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508735AbgJVHkm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Oct 2020 03:40:42 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:58606 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508723AbgJVHkl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Oct 2020 03:40:41 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09M7Z4mF019901;
        Thu, 22 Oct 2020 07:40:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Tn56/nuDGI4MiKzFSijkGNbxkrKoxrBiOdYriFs43E8=;
 b=GqQ16HToNS6sCd7Y8EMjyKT00RsR6PCXwtk0NocZbcUF6XWPiMzTzUvQbSu+S7E+F/Xj
 sqTZW22Yixnhf4Z49UDzajbUtQIAfEvTF5baLYzaeZrzBzbhXRuBzYKElUIZtmalaIvM
 3Pf47rIZ5wZJIUAhHrHpR115iQAYuuuhEvyLDEH5Lqdbo8ZYyrTC04GgNst4KUiZyIsX
 ipWg8GjMlyxIVQszlhxGLzav9p7bZC/+XdvgOse/KWvvc03UOYlsXe7uxFIPxq+9noli
 Fcs/JKQvoiPEDCP8MkOHSgZTfnnbOZQrvD5uQrlilg7h2hAKEUeE1fLGNn9sWDDBJLia KA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 347p4b4ee8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Oct 2020 07:40:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09M7Z1f4027194;
        Thu, 22 Oct 2020 07:40:34 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 348ahyft1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Oct 2020 07:40:34 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09M7eXOl011245;
        Thu, 22 Oct 2020 07:40:33 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 22 Oct 2020 00:40:32 -0700
Subject: Re: [PATCH v8 3/3] btrfs: create read policy sysfs attribute, pid
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <cover.1602756068.git.anand.jain@oracle.com>
 <806bf3aaa5cb0243dd2cea6bb79e5ac9ae347111.1602756068.git.anand.jain@oracle.com>
 <78f8abc7-d7de-77be-6e4a-81beb683fced@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <c5605c0d-b19a-d067-85cd-e7809f8b2963@oracle.com>
Date:   Thu, 22 Oct 2020 15:40:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <78f8abc7-d7de-77be-6e4a-81beb683fced@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010220049
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9781 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010220049
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org




>> @@ -886,6 +886,54 @@ static int btrfs_strmatch(const char *given, 
>> const char *golden)
>>       return -EINVAL;
>>   }
>> +static const char* const btrfs_read_policy_name[] = { "pid" };
> 
> This fails checkpatch.pl, it should be
> 
> static const char * const.  Thanks,


  This is taken care in v9. Thanks.
Anand

> 
> Josef
