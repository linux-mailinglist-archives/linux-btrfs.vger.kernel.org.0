Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8930C741032
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jun 2023 13:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjF1Lk2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jun 2023 07:40:28 -0400
Received: from mout.gmx.net ([212.227.17.20]:36241 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231521AbjF1LkW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jun 2023 07:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1687952418; x=1688557218; i=quwenruo.btrfs@gmx.com;
 bh=VQa54Tj/an0wd1cUISmUDYE5GDX1s2Jc8poAqhQ+EfQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Tbx+PQFdbD0xV2OYU0pDdijyVWADVuRzChUbOZUSxPK0XBxS23pp4KZuydCuy7s6DXc2r94
 9jK/aOYv0k5xTMNLukZ58t9wI8Un4ryteZ8G7kx1a5n7mLDrpEllArHGEvdodbeqvEWLXy6N8
 TnB98r2JFVx8H7M6HVDPaeZwZlXiaN1FQxu3ZGoYBvEPe2wzbd0jgsSDK82rrlQafXfZTHlRD
 Ms9pgBxcLFIL9mvyVZ96v+bOtc/3potf8760ZgOwgRf+/ov9GR13ctATmunWotWthu0zQ0s/7
 9DjS4jqKDNYzazhXDAKL/whN8rwmI7Bmtg6dvIW/DzQ6KZ4+ES4A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N6sn1-1pz12s44w3-018HNf; Wed, 28
 Jun 2023 13:40:18 +0200
Message-ID: <98f33b4e-7cb9-4819-fe0a-4decb555ca23@gmx.com>
Date:   Wed, 28 Jun 2023 19:40:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] common/btrfs: handle dmdust as mounted device in
 _btrfs_buffered_read_on_mirror()
Content-Language: en-US
To:     Zorro Lang <zlang@redhat.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <20230626060052.8913-1-wqu@suse.com>
 <20230626173212.edlu34txg5t4luc6@zlang-mailbox>
 <c06e6b05-0a88-1466-0283-fa53cec2e06a@gmx.com>
 <20230628113403.yymofvkvzrix7uev@zlang-mailbox>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230628113403.yymofvkvzrix7uev@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NkLplIFpEz1n7du9nfUbeNVpauSrXTnO+nbTWF39XKJGt8C0y+T
 BcN1ic7PRdMCSBF2bZ2NMc8l0DhImfL44HWS+FhEiAx7KJ4HwGA0lg9H9jHddZqVm1irURF
 rh42R1mwuKePRoCwdhO0dqP2AtW437J90u7Rs8H3/PQwqcXiqNqkr/zYaxUR/nPGZ/QCxax
 x1goQQ2ILYu21Pc8RVYhw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dVaDk3Ipau4=;GV7X9aBynGUjR0W/zXiPoyin3uj
 6zTdk207FQp2voUEqzuGlg94W7Nzlxd6tBdWCpEWS26lkC1/LY6OsoGG+IA8XmAeYBPeL29Jl
 mIBBB3FCKK7BIeXg/nNsAN6Fn++LQ86CEUmpwr4CR6F+hh5h7S9P+CTitHld/kBQVqX/o3CEW
 hLdGfB/FRYEEqe+On8hwOFyXhquHDWdf4VMVhnu3q2AkeqvN+ezxrrvYkhLuqQYwZwZfLhlTK
 xxVFEy5a0Ah3VnR+Z27A06xx+a6/rUST+6hszmN3HmBBL8uGTpP3VgnXj6Rd5rAjruAn9Xcvt
 P+oECSke40wUnDMJyhKq10MBv1Y3Z/c1UqTlDT0iFCgR56IrS7RwEFTPK0qnwh85lqok2B6ph
 t31XD/uThHZigIbO/L9AFNO+zc8D0rxD3mhW9/4N1AYVDODM/u9VZI+H27JscuTltdkeit2p+
 KMRykkApT1VLJBNISQKyYvPr6IQ0coh+SbWRiWdHg7enH0wfWNI1rnoGQ0JFG3GS62TkEfHU7
 xmhu3JwAT/4h61BnGeQD++NEvUb5/tUoo6/zb8o3guKjgvbYuPe6CZQFO5MFI0a2Ie4lGKz1q
 GZMCUnbrCYOybV2fvDwaL1tg0CpIgQakRaA1RfiIVumvwbrrRLj0dFJJp8VXKEbTshdiaTp1w
 zFioVxIHz8eGTARWafSQdkxOjsgMXxKPIy0Wk6eSI0VXfM2pG665JpAPsNokcVrsQiQJzH2h6
 g77053ShGZr4GfNZS2//39BhINqAcAHPQ3K26tec9g9rrFu7okNhDlWRjBti5rKvje7aWLuUp
 Qk+/oVDa1ZH5gIETNEBTCdbJH0lLo6V2pRua/uJUopRBcdzGX+O7O5bmSUW1mrVR3k6bQpTUp
 uJM+ZXOzYZ26ti5fYFMVT15cZiKz/LE+y0IZrtnxI4vwq7j8caHCUnBmkvY0yU4AKlaja5DxU
 M8Mp0u/YYC3v2RqYwJhVcZAUDNk=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/28 19:34, Zorro Lang wrote:
> On Tue, Jun 27, 2023 at 05:23:31AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2023/6/27 01:32, Zorro Lang wrote:
>>> On Mon, Jun 26, 2023 at 02:00:52PM +0800, Qu Wenruo wrote:
>>>> [BUG]
>>>> After commit ab41f0bddb73 ("common/btrfs: use _scratch_cycle_mount to
>>>> ensure all page caches are dropped"), the test case btrfs/143 can fai=
l
>>>> like below:
>>>>
>>>>    btrfs/143 6s ... [failed, exit status 1]- output mismatch (see ~/x=
fstests/results//btrfs/143.out.bad)
>>>>       --- tests/btrfs/143.out 2020-06-10 19:29:03.818519162 +0100
>>>>       +++ ~/xfstests/results//btrfs/143.out.bad 2023-06-19 17:04:00.5=
75033899 +0100
>>>>       @@ -1,37 +1,6 @@
>>>>        QA output created by 143
>>>>        wrote 131072/131072 bytes
>>>>        XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>>>       -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>>       -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>>       -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>>       -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>>
>>>> [CAUSE]
>>>> Test case btrfs/143 uses dm-dust device to emulate read errors, this
>>>> means we can not use _scratch_cycle_mount to cycle mount $SCRATCH_MNT=
.
>>>>
>>>> As it would go mount $SCRATCH_DEV, not the dm-dust device to
>>>> $SCRATCH_MNT.
>>>> This prevents us to trigger read-repair (since no error would be hit)
>>>> thus fail the test.
>>>>
>>>> [FIX]
>>>> Since we can mount whatever device at $SCRATCH_MNT, we can not use
>>>> _scratch_cycle_mount in this case.
>>>>
>>>> Instead implement a small helper to grab the mounted device and its
>>>> mount options, and use the same device and mount options to cycle
>>>> $SCRATCH_MNT mount.
>>>>
>>>> This would fix btrfs/143 and hopefully future test cases which use dm
>>>> devices.
>>>>
>>>> Reported-by: Filipe Manana <fdmanana@suse.com>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>    common/btrfs | 14 ++++++++++++--
>>>>    1 file changed, 12 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/common/btrfs b/common/btrfs
>>>> index 175b33ae..4a02b2cc 100644
>>>> --- a/common/btrfs
>>>> +++ b/common/btrfs
>>>> @@ -601,8 +601,18 @@ _btrfs_buffered_read_on_mirror()
>>>>    	# The drop_caches doesn't seem to drop every pages on aarch64 wit=
h
>>>>    	# 64K page size.
>>>>    	# So here as another workaround, cycle mount the SCRATCH_MNT to e=
nsure
>>>> -	# the cache are dropped.
>>>> -	_scratch_cycle_mount
>>>> +	# the cache are dropped, but we can not use _scratch_cycle_mount, a=
s
>>>> +	# we may mount whatever dm device at SCRATCH_MNT.
>>>> +	# So here we grab the mounted block device and its mount options, t=
hen
>>>> +	# unmount and re-mount with the same device and options.
>>>> +	local mount_info=3D$(_mount | grep "$SCRATCH_MNT")
>>>> +	if [ -z "$mount_info" ]; then
>>>> +		_fail "failed to grab mount info of $SCRATCH_MNT"
>>>> +	fi
>>>> +	local dev=3D$(echo $mount_info | $AWK_PROG '{print $1}')
>>>> +	local opts=3D$(echo $mount_info | $AWK_PROG '{print $6}' | sed 's/[=
()]//g')
>>>
>>> The `findmnt` can help to get $dev and $opts:
>>>
>>>     local dev=3D$(findmnt -n -T $SCRATCH_MNT -o SOURCE)
>>>     local opts=3D$(findmnt -n -T $SCRATCH_MNT -o OPTIONS)
>>>
>>> If you hope to check you can keep:
>>>
>>>     if [ -z "$dev" -o -z "$opts" ];then
>>>             _fail "failed to grab mount info of $SCRATCH_MNT"
>>>     fi
>>
>> That's really helpful!
>>
>>>
>>>> +	_scratch_unmount
>>>> +	_mount $dev -o $opts $SCRATCH_MNT
>>>
>>> I'm wondering can this help that, after you get the "real" device name=
:
>>>
>>>     SCRATCH_DEV=3D$dev _scratch_cycle_mount
>>
>> AFAIK we still need to specify the mount option.
>>
>> As it's possible previous mount is specifying certain mount option
>> that's not in MOUNT_OPTIONS environment variables.
>>
>> E.g. mounting a specific subvolume or a temporary mount option.
>>
>> Thus I believe we may still need to specific the mount options.
>
> Hmm... if the _scratch_cycle_mount doesn't support dmdust, others dmxxxx
> (e.g. dmdelay, dmthin, dmerror, dmflaky) have similar problem, right?

Yes, but my point here is, although "SCRATCH_DEV=3D$dev
_scratch_cycle_mount" can work for most cases, it can still miss the
specific mount option of the current mount.

Thus we still need to go "_mount $dev -o $opts $SCRATCH_MNT", just for
the extra mount options.

Thanks,
Qu
>
> Thanks,
> Zorro
>
>>
>> Thanks,
>> Qu
>>
>>>
>>> Thanks,
>>> Zorro
>>>
>>>>    	while [[ -z $( (( BASHPID % nr_mirrors =3D=3D mirror )) &&
>>>>    		exec $XFS_IO_PROG \
>>>>    			-c "pread -b $size $offset $size" $file) ]]; do
>>>> --
>>>> 2.39.0
>>>>
>>>
>>
>
