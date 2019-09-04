Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6640EA80F1
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 13:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbfIDLN3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 07:13:29 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60466 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729020AbfIDLN3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Sep 2019 07:13:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x84BCMDV009368;
        Wed, 4 Sep 2019 11:13:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=j5rHjrylLvwHDG3SFghJ+23YW7OjNsfR1xz+uE+PgEs=;
 b=VjXlge+vO3lik5bkl4kI/d99ecR6nT43BCRtKpWmflZQ7R7bIl+H75VCWRrmBOqSxjjt
 wgiQHg1sn2RNvJsIvKxw0wWTTy1EnDtQiw+ps18xztyY4Oy7bM0raniRl8IwIHwogxDQ
 dYRhXPe+mCJyvSlslN9br+bRB527tS3r+SRGPy0/ezqz8b5q+cGB906I/bQC3NKewJDd
 VxC/4Q/PkNA7N6xbnD25CQAJkzRpYPdXH5vaunTQxQzmMacyl3sQk02L0pqnyT4MM3YF
 Tj9mtoC2sG9CrKQDIKqvECJ8eJVXj8IVimb1m23m78a4+lRP/9d7MZsg/sVG+2u0Gu6r tw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2utc6e00aa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Sep 2019 11:13:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x84B9GDZ119977;
        Wed, 4 Sep 2019 11:10:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2ut1hnb2cm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Sep 2019 11:10:42 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x84BAfYg020141;
        Wed, 4 Sep 2019 11:10:41 GMT
Received: from [10.191.51.161] (/10.191.51.161)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Sep 2019 04:10:41 -0700
Subject: Re: [PATCH] btrfs_progs: mkfs: match devid order to the stripe index
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20190628022611.2844-1-anand.jain@oracle.com>
 <20190703132158.GV20977@twin.jikos.cz>
 <e2ab1be9-8b83-987f-0d88-c1f5547060d4@oracle.com>
 <51c42306-b4ae-a243-ac96-fb3acb1a317c@oracle.com>
 <20190902162230.GY2752@twin.jikos.cz> <20190903120603.GB2752@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <96fcc4f1-350f-4c5b-0b0c-c4a70dd9e2c1@oracle.com>
Date:   Wed, 4 Sep 2019 19:10:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903120603.GB2752@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909040113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909040113
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9/3/19 8:06 PM, David Sterba wrote:
> On Mon, Sep 02, 2019 at 06:22:30PM +0200, David Sterba wrote:
>> On Mon, Sep 02, 2019 at 04:01:56PM +0800, Anand Jain wrote:
>>>
>>> David,
>>>
>>>    I don't see this patch is integrated. Can you please integrated this
>>> patch thanks.
>>
>> I don't know why but the patch got lost somewhere, adding to devel
>> again.
> 
> Not lost, but dropped, misc-tests/021 fails. So dropped again, please
> fix it and test before posting again. Thanks.
> 

I have unit tested this patch successfully, misc-tests/021 is a false 
positive failure. Because it assumes btrfs-image collects the data and 
attempts to read the file on the restored image, and rightly ends up 
with IO error.

-------
md5sum: /Volumes/ws/btrfs-progs/tests//mnt/foobar: Input/output error
failed: md5sum /Volumes/ws/btrfs-progs/tests//mnt/foobar
------

The test case is successful so far because the images is restored on the 
same loop device, and unfortunately stale data on the loop device 
matched and helped read from the restored image to succeed.

Tweak the test case a little as below and it fails even without this patch.

----------------------
diff --git a/tests/misc-tests/021-image-multi-devices/test.sh 
b/tests/misc-tests/021-image-multi-devices/test.sh
index b1013b5d2596..05f4146b6007 100755
--- a/tests/misc-tests/021-image-multi-devices/test.sh
+++ b/tests/misc-tests/021-image-multi-devices/test.sh
@@ -17,7 +17,7 @@ loop2=${loopdevs[2]}

  # Create the test file system.

-run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f "$loop1" "$loop2"
+run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f "$loop2" "$loop1"
  run_check $SUDO_HELPER mount "$loop1" "$TEST_MNT"
  run_check $SUDO_HELPER dd bs=1M count=1 if=/dev/zero of="$TEST_MNT/foobar"
  orig_md5=$(run_check_stdout md5sum "$TEST_MNT/foobar" | cut -d ' ' -f 1)
----------------------


This patch is good to integrate.

Thanks, Anand
