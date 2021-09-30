Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A046E41D785
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Sep 2021 12:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349856AbhI3KUI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Sep 2021 06:20:08 -0400
Received: from mout.gmx.net ([212.227.15.15]:45035 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349811AbhI3KUH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Sep 2021 06:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632997102;
        bh=ThhdqwCz2k2Z8+BaGdF5TtvJsFzLg+GlF3PKmEH/XL4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=f3v0Tk0oc30FLBfRLkIXH58D1BgEsUSjE+y9RoVlCXRTM0xbp5fhqlWIDhPJ4zoa+
         ImqeTTJBzyNZm8yF/LbCr0VjQwd15KleAVuoemmGduNM3fiDeZhYpvhUSLgoiaSF+1
         ZdBUH9dwdfERqeglm2zgVybcXP7W7W191yruPwG8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MlNpH-1nEawa3OUX-00lpuY; Thu, 30
 Sep 2021 12:18:22 +0200
Message-ID: <7c1442f6-9d2c-03f8-200a-1a6132a1a419@gmx.com>
Date:   Thu, 30 Sep 2021 18:18:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 2/2] btrfs-progs: misc-tests: add test case for receive
 --clone-fallback
Content-Language: en-US
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210930000042.10147-1-wqu@suse.com>
 <20210930000042.10147-3-wqu@suse.com>
 <CAL3q7H7ccjnLQM9Hawe3VtRkcYVM__jCqJRZ-BjaYJzfYQ+2Yg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAL3q7H7ccjnLQM9Hawe3VtRkcYVM__jCqJRZ-BjaYJzfYQ+2Yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ao9rqZoLN4KSI7UMWFwg2WXU5nN3kXCB7MQolvd2vWU3cisnuwJ
 MtUtFp20F8jY7UKZpt2tw6hbUEoy8a3Pes3AKhy+bjOdkV8xwyUAFFcEUDw4YqcIEIz+IxL
 LHHRj3fGYTtYwGXWqn76EeEn0mHsyZLq90IaYF9xC2Mef6pJUNIZ6egZ4hEqLj0+HsOzKfh
 O3QuFaVv4na/uGcM6wbJA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VfPRtILFamQ=:gC+Ioj2mLO0coK3sGSMFI3
 n23g8GMBaWR99lCsP8WOsorQVQ8f82W1JGDWL5cPGcV3GYarZCzeKepFAaFTy46u/zSQQwAI2
 M0dPmItZUOSbJ7ATf/jRokAMzFtUjhHJaNGezs3czfOcaZaC1FbYGaIAdghyvJ15lStBTB/Lo
 xDAlmRumbbSa65//q1Qs5wr2RlDhwhRePWP5OwvBN3BeKsjuzwER0KUppCXgir2Kbd76JDbNu
 CkGciXaClKGzCmmc4r07kBSgXUa5G0/MV4PGr/AW0DMIuJ8Qlmcx4ULzVuwrl3czgTCn20gdo
 0T4cNHJB6RNbmM9yRzRh5VxwpiTv36kuLxevJxM0TsGl1DIOnosS9Zg58ec1ICrsHhCY+QaCW
 zFeM3k0c+aAC2k+kOipb5sQXXxlka8cNoGZpORDZEJdEte110w2ZW8pW+H5IzzP0B6VAo+Kw+
 R6dKfNhm8gu5IdaZ92wKwgdySdlm+MWHcEWjfAH+UDMdMnDZZ4/j5528hXvn/wlr8EcLrdFV/
 vkk4DuP/qUhYTJem71RJaSF3oxiaQgtBBTgYCN+XY5d+8LAYctCJ+S2a8/qpC4+21fX0lZHZL
 w7yi2WUpNFGKyvBbIOX6N6spYtUu6TS4Jf9Oae2MRAqTyp3YjaIbwINf1zRdKLQfjL8NuRmgL
 tPCjZForQ/an+Jfcz85jwkEwUJpnTNcc8EM3NOFaHiU2T3IB7505RmHfP3XIPKCTLIIzgC3wU
 N+ba2hBn9980nygA8yC2ZG/X+7UP6Bit6BMwvupf70pd+nujlAKNl3ogmNeroXVLEv8CeK5Jn
 ZvHYwX/e6FmgxcrBsW865/bduiH+Ui3AoT7iKLKyyGDMDsDlR6vns4Ct2UuopelQuLZBySlXe
 E+9w7Ju+WVpmiBSGAf82CISeWd0JGgw6DHz6R5eV58dmcJKb3IFqdEOlAtDu5v2FzG5y/moWN
 pDxtCxd6jV99RU9FVXwhqowHyJL70/RwAP0xxb/j7zbeIk/BILzCl8mhDVeTvHOhOpESXL2AV
 G0yALtyJcdwThkPFbNxm7y0KWozOyYwiBs061qMqm+jMHK7dlFXjlnKrL4M2gHtsy0oXxuLh7
 piEU7vfbbSATjk=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/30 18:03, Filipe Manana wrote:
> On Thu, Sep 30, 2021 at 1:06 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> The new test case will create two send streams:
>>
>> - parent_stream
>>    A full send stream.
>>    Contains one file, as clone source.
>>
>> - clone_stream
>>    An incremental send stream.
>>    Contains one clone operation.
>>
>> Then we will receive the parent_stream with default mount options, whil=
e
>> try to receive the clone_stream with nodatasum mount option.
>>
>> This should result clone failure due to nodatasum flag mismatch.
>>
>> Then check if the receive can continue with --clone-fallback option.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   .../049-receive-clone-fallback/test.sh        | 60 ++++++++++++++++++=
+
>>   1 file changed, 60 insertions(+)
>>   create mode 100755 tests/misc-tests/049-receive-clone-fallback/test.s=
h
>>
>> diff --git a/tests/misc-tests/049-receive-clone-fallback/test.sh b/test=
s/misc-tests/049-receive-clone-fallback/test.sh
>> new file mode 100755
>> index 000000000000..d383c0e08a68
>> --- /dev/null
>> +++ b/tests/misc-tests/049-receive-clone-fallback/test.sh
>> @@ -0,0 +1,60 @@
>> +#!/bin/bash
>> +# Verify that btrfs receive can fallback to buffered copy when clone
>> +# failed
>> +
>> +source "$TEST_TOP/common"
>> +
>> +check_prereq mkfs.btrfs
>> +check_prereq btrfs
>> +setup_root_helper
>> +prepare_test_dev
>> +
>> +tmp=3D$(mktemp -d --tmpdir btrfs-progs-send-stream.XXXXXX)
>> +
>> +# Create two send stream, one as the parent and the other as an increm=
ental
>
> stream -> streams
>
>> +# stream with one clone operation.
>> +run_check_mkfs_test_dev
>> +run_check_mount_test_dev -o datacow,datasum
>> +run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "$TEST_MNT/subv"
>
> You can use the default subvolume and therefore avoid creating a
> subvolume and making the test longer than needed.
> Your call.

I understand we can use the default fs tree, but I just can't find my
mind at peace when doing snapshoting of fs tree.

It always remind me of the bad memories using hacky way to solve the
qgroup problem for such snapshot.

Thus I always try to avoid snapshotting fs tree.

>
>> +run_check $SUDO_HELPER dd if=3D/dev/zero bs=3D1M count=3D1 of=3D"$TEST=
_MNT/subv/file1"
>> +run_check $SUDO_HELPER "$TOP/btrfs" subvolume snapshot -r "$TEST_MNT/s=
ubv" \
>> +       "$TEST_MNT/snap1"
>> +run_check $SUDO_HELPER cp --reflink=3Dalways "$TEST_MNT/subv/file1" \
>> +       "$TEST_MNT/subv/file2"
>> +run_check $SUDO_HELPER "$TOP/btrfs" subvolume snapshot -r "$TEST_MNT/s=
ubv" \
>> +       "$TEST_MNT/snap2"
>> +
>> +run_check $SUDO_HELPER "$TOP/btrfs" send -f "$tmp/parent_stream" \
>> +       "$TEST_MNT/snap1"
>> +run_check $SUDO_HELPER "$TOP/btrfs" send -f "$tmp/clone_stream" \
>> +       -p "$TEST_MNT/snap1" "$TEST_MNT/snap2"
>> +
>> +run_check_umount_test_dev
>> +run_check_mkfs_test_dev
>> +
>> +# Now we have the needed stream, try to receive them with different mo=
unt
>
> Reading this is confusing, it mentions receiving them with different
> mount options, but they are the same for the first receive.
>
>> +# options
>> +run_check_mount_test_dev -o datacow -o datasum
>> +
>> +# Receiving the full stream should not fail
>> +run_check $SUDO_HELPER "$TOP/btrfs" receive -f "$tmp/parent_stream" "$=
TEST_MNT"
>> +
>> +# No remount helper, so here we manually unmoutn and re-mount with dif=
ferent
>> +# nodatasum option
>
> Seems pointless to mention there's a lack of a remount helper in the
> test framework.
> Just say that now we mount the filesystem with nodatasum so that the
> new file received through the incremental stream ends up with the
> nodatasum flag set.

Or maybe I should just add run_check_remount_test().

Thanks for the review,
Qu

>
> Thanks.
>
>> +run_check_umount_test_dev
>> +run_check_mount_test_dev -o datacow,nodatasum
>> +
>> +# Receiving incremental send stream without --clone-fallback should fa=
il.
>> +# As the clone source and destination have different NODATASUM flags
>> +run_mustfail "receiving clone with different NODATASUM should fail" \
>> +       $SUDO_HELPER "$TOP/btrfs" receive -f "$tmp/clone_stream" "$TEST=
_MNT"
>> +
>> +# Firstly we need to cleanup the partially received subvolume
>> +run_check $SUDO_HELPER "$TOP/btrfs" subvolume delete "$TEST_MNT/snap2"
>> +
>> +# With --clone-fallback specified, the receive should finish without p=
roblem
>> +run_check $SUDO_HELPER "$TOP/btrfs" receive --clone-fallback \
>> +       -f "$tmp/clone_stream" "$TEST_MNT"
>> +run_check_umount_test_dev
>> +
>> +rm -rf -- "$tmp"
>> --
>> 2.33.0
>>
>
>
