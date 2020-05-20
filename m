Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C7F1DAE0C
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 May 2020 10:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgETIyM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 May 2020 04:54:12 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55458 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgETIyM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 May 2020 04:54:12 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04K8rEsI068104;
        Wed, 20 May 2020 08:54:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=+KuBv+iuCPsg+E2ycN7p9nPKKdh7bDOVBm8rsN33mWI=;
 b=IDYj9iKWtWBwTAfx1xRfiq0r17IGYo48JD54YTlk00ty76UqYRvQp1adaBxg29GzlhxV
 QoYKdcq1bQ+omMyLIVrhHGvoyMgi9026bMEMfBpIYZ1ThkrvF2pe4YVVZV8cvHeSxHKY
 QD4gADKkXTpodUzxHjKYITGU0WyHF2FGb3ijmF9Od7038SA+KP84m0p+I30vUX/+U+bI
 +5jKqbiFO8xIHWRYIlLhPdqw3HqO9uR944trsMD84s3tZaknNSAiSpttjOQlzCaoQ1jD
 HGM5lOnPTgBEtywnNqTLYhQRWCe2g13oexCEgMt/fzU1ohHAo1wvgR99kR6EPwV2WVTu tQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 3127kr9yux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 May 2020 08:54:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04K8mRbY034195;
        Wed, 20 May 2020 08:54:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 314gm6pm1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 May 2020 08:54:10 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04K8s93H020191;
        Wed, 20 May 2020 08:54:09 GMT
Received: from [192.168.1.102] (/39.109.177.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 May 2020 01:54:09 -0700
Subject: Re: [PATCH v7 3/5] btrfs: create read policy sysfs attribute, pid
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <1586173871-5559-1-git-send-email-anand.jain@oracle.com>
 <1586173871-5559-4-git-send-email-anand.jain@oracle.com>
 <SN4PR0401MB3598EF0DF22C63F087969E8D9BB90@SN4PR0401MB3598.namprd04.prod.outlook.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <3369903c-77d7-7cc1-aa14-85183793e74b@oracle.com>
Date:   Wed, 20 May 2020 16:54:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB3598EF0DF22C63F087969E8D9BB90@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 phishscore=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005200077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 cotscore=-2147483648
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005200078
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/5/20 6:07 pm, Johannes Thumshirn wrote:
> On 06/04/2020 13:51, Anand Jain wrote:
>> +static ssize_t btrfs_read_policy_store(struct kobject *kobj,
>> +				       struct kobj_attribute *a,
>> +				       const char *buf, size_t len)
>> +{
>> +	int i;
>> +	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
>> +
>> +	for (i = 0; i < BTRFS_NR_READ_POLICY; i++) {
>> +		if (btrfs_strmatch(buf, btrfs_read_policy_name[i]) == 0) {
>> +			if (i != fs_devices->read_policy) {
>> +				fs_devices->read_policy = i;
>> +				btrfs_info(fs_devices->fs_info,
>> +					   "read policy set to '%s'",
>> +					   btrfs_read_policy_name[i]);
>> +			}
>> +			return len;
>> +		}
>> +	}
> 
> Naive question, what's the advantage over sysfs_match_string()?

We strip both leading and trailing whitespaces, its not
possible to do the same with sysfs_match_string().

For example:
echo ==== These should pass ======
run_nocheck "echo ' pid' > $sysfs_path/read_policy"
run_nocheck "echo ' pid ' > $sysfs_path/read_policy"
run_nocheck "echo -n ' pid ' > $sysfs_path/read_policy"
run_nocheck "echo -n ' pid' > $sysfs_path/read_policy"
run_nocheck "echo 'pid ' > $sysfs_path/read_policy"
run_nocheck "echo -n 'pid ' > $sysfs_path/read_policy"
run_nocheck "echo -n pid > $sysfs_path/read_policy"
run_nocheck "echo pid > $sysfs_path/read_policy"

Thanks, Anand
