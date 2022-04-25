Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36CB50EC3E
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Apr 2022 00:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbiDYWrS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 18:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiDYWrS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 18:47:18 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23F548891
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 15:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650926648;
        bh=Ag+w5FtGBGwcWS/O7hL7zIoY8gpWnVY6TnrplKwo9tY=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=Js+KDMhTQfb0i282Ev5QdXqOod7PKoZrH8sVJIOwJgzPV4Givt21TYJtC1ClhGSBC
         pm8gPV4lZKXqPuEstr6KWbD9SaW+U36URIu6w1+cfYzIIiMwcHYocik7gfErdzBgHl
         w1kibCIQ+FSfCC4ZHdGEr15EvKCPjvc6XcBhYvPw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mzyuc-1o3gor2pTK-00x7M3; Tue, 26
 Apr 2022 00:44:08 +0200
Message-ID: <57d6192b-e1fd-bd14-d869-d03559c34eb1@gmx.com>
Date:   Tue, 26 Apr 2022 06:44:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] btrfs-progs: fsck-tests: check warning for seed and
 sprouted filesystems
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1650180472.git.wqu@suse.com>
 <c1c97aca3ca89edfb23788858d186a50ed80d488.1650180472.git.wqu@suse.com>
 <20220425170408.GR18596@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220425170408.GR18596@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bYwvyS0yxT5XPMmEXUStskUc6+dGkoeVrc0hRe+BSNmgXlg55lP
 R94MU/8iN9T19NWs7kZNv3zkbQi1/utS3iDLEmvElpoA0DEHKPVk6Ioorq/SVd33uAMKPdx
 QBONIW0rP+jPXDQVXRLLcILNpVBguGhOEpDa9OMxyUS8iBflcM7Mtc9P29DooNmeI0L55N2
 HE0nKI7SylWKT5dcgwv/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tH2PS+Elmuo=:t7h57WtaSf+rE/3NQvo12H
 wrzqm+6X48paKmpyoC8MyDJZnYtIW9vPJj93pTHYvCUd3/gGXCCl1K+qnQhdt6s0OqiDusL0D
 gAtZnCfE6M+OqGg/1WBEBavA6sf8NCfmAjTRKg2VteWudrUTxzdai/rvnGV8jqLGEIlV7mX4S
 Gca/5qDuZyMU5d37NyWp6zsM2Y0Q/pQRNVsFukom8q4aquyl0SumM/coPD7KMIBNIFJj+4oHy
 GN1v3/cp1u8Uhd4Iwk1LuKs+CmluVvLNiZFK60BWcsbOE7sn85ArDuJ7WZ+N7+Z8g3qsOSzSk
 i3NHNdy7QErkAamaynt3a7OFAc25NxwYOejsglvDafJRcj37OFgtsKDs8uQzs6DzwaPStMCGs
 LQbwM1LN8E7iWYcBeWRbxj/lf6FYOt+y53FZG4E2QHUaU/HQwxCG+mraTeVFfIc7F2MAzzLJD
 SI4dKAM3/4+pNVsDNYd2HLycEIr73zqvLVBSrAK4Rdkq8nXvbkr5fBNHxWmpsXu1Kqrkl2SHD
 FCPZWIwzKhsWqWsOK0UHzB8VEXTJZ6ziFYQTLl4mGJRJ4qcjk6eyTXgRX6TSXzaQy1WIqlCHH
 Th823TRUvjpLzoLutTgKk3ae1SMpHEGsubBhoLFx2sLBfT+K4RyJ+mPXO+p6b9bcr3nPw4eKy
 vwd6P5WiHu7EB1oyTag1C4lV1s/lr2x0jAb/6pqP01CaQ6mnp4CwhUuvKEi28qHJGBbz3ijpx
 HdZiox3HvG/jJfCemOFuj2vwhg8HCWT92v+uMR/H8qsjf68xhKnHJTzrMMJPyyGgXwZPcLR7G
 TnUH5zBM/XTm6nGNMVA5IswB2I7Xwh0qlkBBAr4U7lNm1uL4fpFlK69iQdGrDsXAnqpZZdyd6
 E8Eievu/5H7Zhz6R54qpcTn11F8Lw130oMLzDPSr5cGikZI+SWtOnOYfuNbFrDTvqy981pLaE
 Unb3+bPZUGSYtJHA53Mns72+zOA8BbRn1nCrH1lAZaB8M+5FWPgREiToyruoT+Do58QUDnRzt
 2qzDy+6dVlBCCcs/wqAQ9zUl/Rj1+snH51qUGMHSKMwlp55JG7BTTzL/0t3PNr0w+U84LwT1T
 YAa7twuuCSi2H0=
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/26 01:04, David Sterba wrote:
> On Sun, Apr 17, 2022 at 03:30:36PM +0800, Qu Wenruo wrote:
>> Previously we had a bug that btrfs check would report false warning for
>> a sprouted filesystem.
>>
>> So this patch will add a new test case to make sure neither seed nor
>> and sprouted filesystem will cause such false warning.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   .../fsck-tests/057-seed-false-alerts/test.sh  | 51 ++++++++++++++++++=
+
>>   1 file changed, 51 insertions(+)
>>   create mode 100755 tests/fsck-tests/057-seed-false-alerts/test.sh
>>
>> diff --git a/tests/fsck-tests/057-seed-false-alerts/test.sh b/tests/fsc=
k-tests/057-seed-false-alerts/test.sh
>> new file mode 100755
>> index 000000000000..3a442c1202d0
>> --- /dev/null
>> +++ b/tests/fsck-tests/057-seed-false-alerts/test.sh
>> @@ -0,0 +1,51 @@
>> +#!/bin/bash
>> +#
>> +# Make sure "btrfs check" won't report false alerts on sprouted filesy=
stems
>> +#
>> +
>> +source "$TEST_TOP/common"
>> +
>> +check_prereq btrfs
>> +check_prereq mkfs.btrfs
>> +check_prereq btrfstune
>> +check_global_prereq losetup
>> +
>> +setup_loopdevs 2
>> +prepare_loopdevs
>> +dev1=3D${loopdevs[1]}
>> +dev2=3D${loopdevs[2]}
>> +TEST_DEV=3D$dev1
>> +
>> +setup_root_helper
>> +
>> +run_check $SUDO_HELPERS "$TOP/mkfs.btrfs" -f $dev1
>               ^^^^^^^^^^^^^
>
> It's $SUDO_HELPER, otherwise it does not work, also please quote all
> shell variables, everywhere.
>
>> +run_check $SUDO_HELPERS "$TOP/btrfstune" -S1 $dev1
>> +run_check_mount_test_dev
>> +run_check $SUDO_HELPERS "$TOP/btrfs" device add -f $dev2 $TEST_MNT
>> +
>> +# Here we can not use umount helper, as it uses the seed device to do =
the
>> +# umount. We need to manually unmout using the mount point
>> +run_check $SUDO_HELPERS umount $TEST_MNT
>> +
>> +seed_output=3D$(_mktemp --tmpdir btrfs-progs-seed-check-stdout.XXXXXX)
>
> This won't work as intended, there's a helper _mktemp_dir that creates a
> temporary directory, otherwise --tmpdir is interpreted as the direcotry
> name.

My bad, it should be mktemp without the "_" prefix, just like what we
did in all the run* helpers.

And I'm not expected to create a directory, thus I don't need to
_mktemp_dir.

Thanks,
Qu
