Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 634A9A8861
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 21:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbfIDOGF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 10:06:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:55004 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730462AbfIDOGE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Sep 2019 10:06:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C3645AC7D;
        Wed,  4 Sep 2019 14:06:03 +0000 (UTC)
Subject: Re: [PATCH Fix-title-prefix] btrfs-progs: misc-tests-021 fix restore
 overlapped on disk's stale data
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz, jthumshirn@suse.de
References: <23f82b13-5050-0acd-49fb-1ecd06811b8d@suse.de>
 <20190904132947.1232-1-anand.jain@oracle.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <86a5df7f-851f-0760-6247-330c4e156f7e@suse.com>
Date:   Wed, 4 Sep 2019 17:06:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904132947.1232-1-anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 4.09.19 г. 16:29 ч., Anand Jain wrote:
> As misc-tests/021 image dump is restored on the same original loop
> device, this overlaps with the stale data and makes the test pass
> falsely.
> 
> Fix this by using a new device for restore.
> 
> And also, the btrfs-image dump and restore doesn't not collect the data,
> so any read on the files should be avoided. So instead of file data use
> file stat data for the md5sum.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> Reported-by: Johannes Thumshirn <jthumshirn@suse.de>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> ---
>  tests/misc-tests/021-image-multi-devices/test.sh | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/misc-tests/021-image-multi-devices/test.sh b/tests/misc-tests/021-image-multi-devices/test.sh
> index b1013b5d2596..5ed8f4b01457 100755
> --- a/tests/misc-tests/021-image-multi-devices/test.sh
> +++ b/tests/misc-tests/021-image-multi-devices/test.sh
> @@ -10,17 +10,18 @@ check_prereq btrfs
>  
>  setup_root_helper
>  
> -setup_loopdevs 2
> +setup_loopdevs 3
>  prepare_loopdevs
>  loop1=${loopdevs[1]}
>  loop2=${loopdevs[2]}
> +loop3=${loopdevs[3]}
>  
>  # Create the test file system.
>  
>  run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f "$loop1" "$loop2"
>  run_check $SUDO_HELPER mount "$loop1" "$TEST_MNT"
>  run_check $SUDO_HELPER dd bs=1M count=1 if=/dev/zero of="$TEST_MNT/foobar"
> -orig_md5=$(run_check_stdout md5sum "$TEST_MNT/foobar" | cut -d ' ' -f 1)
> +orig_md5=$(run_check_stdout stat "$TEST_MNT/foobar" | md5sum | cut -d ' ' -f 1)
>  run_check $SUDO_HELPER umount "$TEST_MNT"
>  
>  # Create the image to restore later.
> @@ -32,13 +33,13 @@ run_check $SUDO_HELPER "$TOP/btrfs-image" "$loop1" "$IMAGE"
>  run_check $SUDO_HELPER wipefs -a "$loop1"
>  run_check $SUDO_HELPER wipefs -a "$loop2"
>  
> -run_check $SUDO_HELPER "$TOP/btrfs-image" -r "$IMAGE" "$loop1"
> +run_check $SUDO_HELPER "$TOP/btrfs-image" -r "$IMAGE" "$loop3"
>  
>  # Run check to make sure there is nothing wrong for the recovered image
> -run_check $SUDO_HELPER "$TOP/btrfs" check "$loop1"
> +run_check $SUDO_HELPER "$TOP/btrfs" check "$loop3"
>  
> -run_check $SUDO_HELPER mount "$loop1" "$TEST_MNT"
> -new_md5=$(run_check_stdout md5sum "$TEST_MNT/foobar" | cut -d ' ' -f 1)
> +run_check $SUDO_HELPER mount "$loop3" "$TEST_MNT"
> +new_md5=$(run_check_stdout stat "$TEST_MNT/foobar" | md5sum | cut -d ' ' -f 1)
>  run_check $SUDO_HELPER umount "$TEST_MNT"
>  
>  cleanup_loopdevs
> 
