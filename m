Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B14F2AA17A
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Nov 2020 00:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgKFXnL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 18:43:11 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39002 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbgKFXnJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Nov 2020 18:43:09 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A6NZQCZ096468;
        Fri, 6 Nov 2020 23:43:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=jZv1m0wjC5buHLqq0HlmQZUZ021xGMsbGmpqos7U64M=;
 b=Km9HhKSkUZeBjVmHhpeziEmcqLdzP4wzdZDPSfheAJY2YgTVb2LTf6nGIsa/hZgH240W
 jBe2sJUe1uOx8mge7Lfnf70ETbwIiOMziXYsQNyUXZtybHEwSZJcf144cIU4S1216QYR
 ReZwiKb1A/iYARW2Kwxugea/6RGVDe61ketNmBJcy56eZzKW+gNQfeCTpUg+Tbeyfauc
 3l6X/bBpKBgtkVV7Q+BpkaHKs9LakI2aSrQ3Dj5pTXUh8SSucjxaM1KBdC9AXZFVuTGw
 H+T3dApaTbYKG4+kJkclux0gV2E2wE5DqeQ03+kV6OirDeddP//2ywxJOQBJAA8z2CH7 8w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 34hhw33h3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 06 Nov 2020 23:43:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A6Neqwd191157;
        Fri, 6 Nov 2020 23:41:06 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 34hw0m3ggm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Nov 2020 23:41:06 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A6Nf66D030595;
        Fri, 6 Nov 2020 23:41:06 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Nov 2020 15:41:05 -0800
Subject: Re: [PATCH 1/1] btrfs: cleanup btrfs_free_extra_devids() drop arg
 step
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <cover.1604649817.git.anand.jain@oracle.com>
 <a20a37162b49e5b1de7a5ec70607102b61ac94eb.1604649817.git.anand.jain@oracle.com>
 <4275cb92-5451-a193-d7cf-a3f76b7c7cf6@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <f03b2ced-ed51-bbe4-acfd-147546abddbc@oracle.com>
Date:   Sat, 7 Nov 2020 07:41:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <4275cb92-5451-a193-d7cf-a3f76b7c7cf6@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9797 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011060159
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9797 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=2 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011060158
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 7/11/20 1:02 am, Josef Bacik wrote:
> On 11/6/20 3:06 AM, Anand Jain wrote:
>> Following patch
>>   btrfs: dev-replace: fail mount if we don't have replace item with 
>> target device
>> dropped the multi ops of the function btrfs_free_extra_devids(), where 
>> now
>> it doesn't check the replace target device. So btrfs_free_extra_devid()
>> doesn't need the 2nd argument %step anymore. Perpetuate the related
>> changes back to the functions in the stack.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> Actually nm,  I forgot to build, this thing doesn't compile.  Thanks,

  The compile fail is not real to this patch. It happened due change in
  patch's order in the misc-next. In specific, the compile fail happens
  due to the dependent patch as below,

    btrfs: fix btrfs_find_device unused arg seed

  which I fixed locally as below. As David is reviewing the above patch,
  I didn't want to send another revision and confuse him more. To compile
  successfully, pls, after the above patch apply for the following
  changes,

-----------------------------------------------
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index f6e1a4b0ae84..dc3481014f16 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -96,7 +96,7 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
                  * a replace target, fail the mount.
                  */
                 if (btrfs_find_device(fs_info->fs_devices,
-                                     BTRFS_DEV_REPLACE_DEVID, NULL, 
NULL, false)) {
+                                     BTRFS_DEV_REPLACE_DEVID, NULL, 
NULL)) {
                         btrfs_err(fs_info,
                         "found replace target device without a valid 
replace item");
                         ret = -EUCLEAN;
@@ -159,7 +159,7 @@ int btrfs_init_dev_replace(struct btrfs_fs_info 
*fs_info)
                  * replace target, fail the mount.
                  */
                 if (btrfs_find_device(fs_info->fs_devices,
-                                     BTRFS_DEV_REPLACE_DEVID, NULL, 
NULL, false)) {
+                                     BTRFS_DEV_REPLACE_DEVID, NULL, 
NULL)) {
                         btrfs_err(fs_info,
                         "replace devid present without an active 
replace item");
                         ret = -EUCLEAN;
-------------------------

When this patch was sent, it was tested with fstests btrfs and finds no 
new regression.

Thanks, Anand

> 
> Josef
