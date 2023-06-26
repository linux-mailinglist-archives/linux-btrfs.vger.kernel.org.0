Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4285E73ECD1
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jun 2023 23:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjFZVXq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jun 2023 17:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjFZVXn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jun 2023 17:23:43 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FAFB1;
        Mon, 26 Jun 2023 14:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1687814616; x=1688419416; i=quwenruo.btrfs@gmx.com;
 bh=UwP09Akvg1XGbiRQscD9xroA92Fcvt1/PTBtP9k8wzs=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=dTRWmq2X1+DZNwOghfpPIf3q8IrduLDbsb5BkfJyRH+I0YytUPNOceVAsavx6FBaiPDBHKH
 tn68nUgj1SPxBWEElBjSnyRZAWSuzVWSEyoAwvVxCtRYIWC7rjS9U/bTqJE77lTcyHVk72SHy
 r85E6kPMV7dWg12ZSMcyqzJwiqkvD/dGjrSdR9QjxFfZRDuruOamfgZaLOZIQSf2MNZw217u8
 NqD1Kcb/wizIGVCjT4KUGIzzt4LHEiM9u/pVYTLU8hhxJawrN/eGk/dt02wM2uRSxBpGl3pvs
 Un2xeIk7yjx8OP6yNTFD8y3IauTPRNJayp59E/AP84kJgycVe/Wg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MA7GM-1qJzZ71RFa-00Bcjn; Mon, 26
 Jun 2023 23:23:36 +0200
Message-ID: <c06e6b05-0a88-1466-0283-fa53cec2e06a@gmx.com>
Date:   Tue, 27 Jun 2023 05:23:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] common/btrfs: handle dmdust as mounted device in
 _btrfs_buffered_read_on_mirror()
To:     Zorro Lang <zlang@redhat.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
References: <20230626060052.8913-1-wqu@suse.com>
 <20230626173212.edlu34txg5t4luc6@zlang-mailbox>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230626173212.edlu34txg5t4luc6@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tissjajE9VJMIu0g97fIydHzFjPpgmDRUUXTuIJEcGwgtSS16ap
 POsRMZcp8J//VOPFU3zh+avWLvA1edqTg29deAB7BTxTQJ6xs3UHcOp/8NvNVjoGDAHqjlq
 KGCDSjHJHczoDCy1P90cd5UjezxFpTgkW57wrolsdqZUYzRzLcbHRaeQupYccbyzVrGCn1Q
 VmiZ9hGrJG5VzYDBqzTlg==
UI-OutboundReport: notjunk:1;M01:P0:MEPdkMkJoGA=;lbTotzBXgCn6aX7BkbNyAFhS3wu
 YjkFyGz7BUtBpdd+9UmjS5k0jcXF0udmC2BO1UPif+N615COhhiUDQYw9mQ6fzpNekjR3hXcH
 rFtrA98CqQtPGEUnUiOLRa8N4eOwVQP7ew8ixALKzMZi7N76yjMta2+0AzP5ZukGbbiyKK3y4
 tDkNGz4Gfg6FyktEcL3KFpAcqUNm5jI0T5WZ9NUxPuLD6dIVFLypFXgGOMchUPExS7ivR7Nqf
 cXNoNbSEUhSD77YOzfetY3JMx8ujbB68aJo0aqLy2Ljm6StsZykJWaPSJOfYG52aEhyE2l9Dv
 chYZ1oSWSJkhyZ7AnvmSice0YSwNEZi7Mf6kRjkAMBPT2Ia/2it7saJL4ieKWAUFvue3v4iMF
 dhh6kjSOoQdXRCMMW5usepDu9kKUVayYpZhO7q9t+A17+l1uk1hat80v/qm1mt2mvu5XsOlgW
 P/FBFcnlZ4hdMCPT2+BEHJ233vFYFbRQmW05v+6HlIdAPsDOdSK719plQDzWltN0a2BVsR4Dj
 O67PrKDh4ea12VzD3UvR7N22k4bylNmQES/YeC1pwbTY4DFnM+rie5Us8UHGgSJHqLkNeqZbf
 AM7XwCaSQpvqZdVjtpGBq+m2Z6fcl8yEl6dI1dbyRiL5AaTpoSXZPcOIPCbuwEgAmfW10U43B
 pJn0sUVg99KxazbrNdhgnSxt654+Du4swf1rJyQPNG8fQzB7dMr8Z37tousavrAJiYxebc56N
 W6C1pK0uY5130G/lrc4ABckFKctoe7APhk/Af6SHbgBoeYx/gpWT3/8kfnHCHhJqNG+HihyeO
 dRlLNztAcsXdvm46Rfhn3/YY8enS50EnofifkR9Ces/hlNym0h3I5NJILHUOtXvUkiENUZkyA
 Ep824UZ1hRAeBkFhtUb4S5WKUqeBqLc+mFjBo1M3eQCaG07xjZHakX7tMCbVaJjhw6hXXExwu
 3buWeboV77yeeEiM9oXrabfGhGo=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/27 01:32, Zorro Lang wrote:
> On Mon, Jun 26, 2023 at 02:00:52PM +0800, Qu Wenruo wrote:
>> [BUG]
>> After commit ab41f0bddb73 ("common/btrfs: use _scratch_cycle_mount to
>> ensure all page caches are dropped"), the test case btrfs/143 can fail
>> like below:
>>
>>   btrfs/143 6s ... [failed, exit status 1]- output mismatch (see ~/xfst=
ests/results//btrfs/143.out.bad)
>>      --- tests/btrfs/143.out 2020-06-10 19:29:03.818519162 +0100
>>      +++ ~/xfstests/results//btrfs/143.out.bad 2023-06-19 17:04:00.5750=
33899 +0100
>>      @@ -1,37 +1,6 @@
>>       QA output created by 143
>>       wrote 131072/131072 bytes
>>       XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>      -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>>      -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>>      -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>>      -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>> ................
>>
>> [CAUSE]
>> Test case btrfs/143 uses dm-dust device to emulate read errors, this
>> means we can not use _scratch_cycle_mount to cycle mount $SCRATCH_MNT.
>>
>> As it would go mount $SCRATCH_DEV, not the dm-dust device to
>> $SCRATCH_MNT.
>> This prevents us to trigger read-repair (since no error would be hit)
>> thus fail the test.
>>
>> [FIX]
>> Since we can mount whatever device at $SCRATCH_MNT, we can not use
>> _scratch_cycle_mount in this case.
>>
>> Instead implement a small helper to grab the mounted device and its
>> mount options, and use the same device and mount options to cycle
>> $SCRATCH_MNT mount.
>>
>> This would fix btrfs/143 and hopefully future test cases which use dm
>> devices.
>>
>> Reported-by: Filipe Manana <fdmanana@suse.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   common/btrfs | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/common/btrfs b/common/btrfs
>> index 175b33ae..4a02b2cc 100644
>> --- a/common/btrfs
>> +++ b/common/btrfs
>> @@ -601,8 +601,18 @@ _btrfs_buffered_read_on_mirror()
>>   	# The drop_caches doesn't seem to drop every pages on aarch64 with
>>   	# 64K page size.
>>   	# So here as another workaround, cycle mount the SCRATCH_MNT to ensu=
re
>> -	# the cache are dropped.
>> -	_scratch_cycle_mount
>> +	# the cache are dropped, but we can not use _scratch_cycle_mount, as
>> +	# we may mount whatever dm device at SCRATCH_MNT.
>> +	# So here we grab the mounted block device and its mount options, the=
n
>> +	# unmount and re-mount with the same device and options.
>> +	local mount_info=3D$(_mount | grep "$SCRATCH_MNT")
>> +	if [ -z "$mount_info" ]; then
>> +		_fail "failed to grab mount info of $SCRATCH_MNT"
>> +	fi
>> +	local dev=3D$(echo $mount_info | $AWK_PROG '{print $1}')
>> +	local opts=3D$(echo $mount_info | $AWK_PROG '{print $6}' | sed 's/[()=
]//g')
>
> The `findmnt` can help to get $dev and $opts:
>
>    local dev=3D$(findmnt -n -T $SCRATCH_MNT -o SOURCE)
>    local opts=3D$(findmnt -n -T $SCRATCH_MNT -o OPTIONS)
>
> If you hope to check you can keep:
>
>    if [ -z "$dev" -o -z "$opts" ];then
>            _fail "failed to grab mount info of $SCRATCH_MNT"
>    fi

That's really helpful!

>
>> +	_scratch_unmount
>> +	_mount $dev -o $opts $SCRATCH_MNT
>
> I'm wondering can this help that, after you get the "real" device name:
>
>    SCRATCH_DEV=3D$dev _scratch_cycle_mount

AFAIK we still need to specify the mount option.

As it's possible previous mount is specifying certain mount option
that's not in MOUNT_OPTIONS environment variables.

E.g. mounting a specific subvolume or a temporary mount option.

Thus I believe we may still need to specific the mount options.

Thanks,
Qu

>
> Thanks,
> Zorro
>
>>   	while [[ -z $( (( BASHPID % nr_mirrors =3D=3D mirror )) &&
>>   		exec $XFS_IO_PROG \
>>   			-c "pread -b $size $offset $size" $file) ]]; do
>> --
>> 2.39.0
>>
>
