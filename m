Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E8C70BC58
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 May 2023 13:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbjEVLwH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 May 2023 07:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbjEVLvp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 May 2023 07:51:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D17EC2
        for <linux-btrfs@vger.kernel.org>; Mon, 22 May 2023 04:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1684756281; i=quwenruo.btrfs@gmx.com;
        bh=lWbkMwKnJZCx0n1f2LHLyR55Wm/dIQTqFyMi3LEbk10=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=VB1avnIEaZogenV8RbVRLA2UPDNSidG7u6Pwn9XOYwMqHTJEwphRA3O/1sCQTGjh6
         5TQuIv4Xz5dAs+AbzNccw4inED/I/9i2vKxQA8J0v3TAQ5DPJuhq77uf+zzfcCpi0p
         gl7l/GsjWWNOkp0DUVScS2GdVFQM5SMOBmiHoPK8eATyiSc4TsPnb03nFO8MS6gg/+
         uaxnzMnO7Eaf//2TEab9Q5+zED4Ie4s2gA8Bta2QQebQk9tM9oQCDUMzCrbBYFWTGX
         GjNgJDn6+iouDqZ+UV1nxez780tWFsenYHACijvKyB8mhVuhvIKEq05m1gAwfV50f9
         tjBvJxal8LpPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Msq24-1qGXeS2Wkq-00tCjW; Mon, 22
 May 2023 13:51:21 +0200
Message-ID: <89804ef5-2dfc-ecb0-cc48-87bed8694e67@gmx.com>
Date:   Mon, 22 May 2023 19:51:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH RFC] btrfs: trigger orphan inodes cleanup during sync
 ioctl
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <79d32abc0d6c1a3afcf9224bd44875f5594c80b6.1683848508.git.wqu@suse.com>
 <20230522114329.GK32559@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230522114329.GK32559@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eAQeYVWm0eb+z3JWnsljp40yDn5h1gNC5R96ITfVvIdB07niTRz
 Foe6S9Pxu3uY+mOvmkPo2w2g+MRGVky0VRWCtaLdiihnQtiGXX5mR9nUVY9qGYHmxxcHP+6
 bedXNPndkREP5FIxamyWguFqBZj3gj10XVjrskM6IPIUo/4Jt95kOJ8hDJ6kNYcxMAq58sG
 wx437u6C0IiJXk4f6t/aA==
UI-OutboundReport: notjunk:1;M01:P0:Iyt9DFduNPI=;bI4E2cFMppYW9kyAAyytbH76wmP
 XuQKV+T5kGg9tcO7oEGeVHpRdbFnw1ertFmTOhQdKUMCB/OKRC3Gc1Zh7uTVLUzNAbyqidtxn
 l1TTu40ppDcpckv0iHyBXWc7dXeX3eJQKeeiaef43H4D36OD5Q2BqPIUvJDcVWowC48drZN9z
 3rK5PQ0EotFdRTIcBPXtm/Nwvb7JtB3r1xHalan9+JpblNT/BkiIBrWREVtig2e3Dh+Xc+/4a
 YHWldNYcbIwsjSXMPJ8rkd49RSmQuXMNh0XbQjtZGXUYADig8vJFa3J80lmGa9fw/D3DZtaGL
 +016PMYG23nfDRngqhpABnjm8MRmGjpKgsw3ULZxzgibpn/BFAGN/2RUc1oaz2ycKNq5kSg50
 bVJgob5NKLOx+bizKNunh0VkI8JCwXvmrBrEudlTjbUSQw4DXllgTFS526/1OAmEZ5vyNmPUH
 2UQl/M/EqhM77olukAuD0iIzbF0UmZ0/za+9XGVZ4IjRDK7aapGbT1S7kwU8Y/PZe5LsJekdV
 NuxXUUfCcOWwuwst6dYopI/bs5TIb453qvYy0uUH+7XyI2cR15tOeRnJInkIt+SVQQ141kDc0
 WjBp/AMCFYQttknPOq8GGpsEbtKdref9gIhty29SODZ45bwEIKB7ztEW6yPHeH6CJTzqpOU1T
 woqNoHTPNIzJ1IEVxuguAmaB/szw/b6wAXsPXP6d/6LkUAjLiypjtRXA5QTQybiz3xPXgJsbg
 MgkO8iK0FJlPJszWfGdG4zZIeMRN3IYhKWRYx1Yf6yq4bo2553zOLNx3GJXK23np0uOLgH2S4
 Vcx/rdUi9fmJ8Ahp2VXrPfDDUT8uPcnfNOGwvBmxFIiqonC+bUZjsCniGA3AnBCNoL89Hrgst
 JlpS8xg6aIF5SLTTa0jbz3+t8hQZN+RCbRqUFiKB8uhvq7aFxaEro+QAqlPp9bCc8dXZVl9Wh
 9KH2RAixA9l5GSQKJyQjjA0WINU=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/22 19:43, David Sterba wrote:
> On Fri, May 12, 2023 at 07:42:05AM +0800, Qu Wenruo wrote:
>> There is an internal error report that scrub found an error in an orpha=
n
>> inode's data.
>>
>> However there are very limited ways to cleanup such orphan inodes:
>>
>> - btrfs_start_pre_rw_mount()
>>    This happens at either mount, or RO->RW switch.
>>    This is not a valiable solution for rootfs which may not be unmounte=
d
>>    or RO mounted.
>>
>>    Furthermore this doesn't cover every subvolume, it only covers the
>>    currently cached subvolumes.
>>
>> - btrfs_lookup_dentry()
>>    This happens when we first lookup the subvolume dentry.
>>    But dentry can be cached thus it's not ensured to be triggered every
>>    time.
>>
>> - create_snapshot()
>>    This only happens for the created snapshot, not the source one.
>>
>> This means if we didn't trigger orphan items cleanup, there is really n=
o
>> way to manually trigger it.
>>
>> Thus this patch would add a manual trigger for sync ioctl.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Reason for RFC:
>> Although this patch is very small, it involves a behavior change and
>> hugely delay the sync ioctl.
>> ---
>>   fs/btrfs/ioctl.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index df7603c30686..51ad2f0f9dd8 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -3111,6 +3111,11 @@ static noinline long btrfs_ioctl_start_sync(stru=
ct btrfs_root *root,
>>   {
>>   	struct btrfs_trans_handle *trans;
>>   	u64 transid;
>> +	int ret;
>> +
>> +	ret =3D btrfs_orphan_cleanup(root);
>> +	if (ret < 0)
>> +		return ret;
>
> I think this should not fail the whole sync ioctl, namely when it would
> not even try to start the transaction commit.

If the cleanup failed, it's mostly possible that the subvolume tree is
corrupted, and we would still abort transaction during that subvolume
tree operation.

Thanks,
Qu
