Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA5D42E443
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Oct 2021 00:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhJNWit (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Oct 2021 18:38:49 -0400
Received: from mout.gmx.net ([212.227.17.21]:36779 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230030AbhJNWis (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Oct 2021 18:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634251000;
        bh=5zX6c/tPi1WEOy4Pw06rwKe7J3wBeqXYdwvB+X7GVi4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=G+BtE4LQG/Kl+saEMqzW5ybn5CbfCWhmLLC+ijoVpPZz6yS/tYED+uB8CNwIUk4k/
         M456AJpMwFirr7lUK5JJQ36l3553enZmwo1pcyHUkTv9C85ZTaqrziW0GLN8XvF4iz
         iDiMXJexcWG3K/lTw9adxFa4/2wrVKr5q+FWFux4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M9Fnj-1mhSrI3RRv-006NfY; Fri, 15
 Oct 2021 00:36:40 +0200
Message-ID: <5bd2f336-baeb-de19-1eff-9ef766cc2ff6@gmx.com>
Date:   Fri, 15 Oct 2021 06:36:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2] btrfs-progs: test-misc: search the backup slot to use
 at runtime
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20211013011233.9254-1-wqu@suse.com>
 <YWhOiG3rQvcbiys+@localhost.localdomain>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YWhOiG3rQvcbiys+@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H8fZ6F1K+St3Trokb7y8/LBvk8vJMpBisNdnH/xFoirBN4OeqsW
 RB74Fh+o2df9KtZb4dzzgEDg+LEt8RBYsDXZqpOoUNhJyW48K/jyntkDiBNayNgU3GybXZe
 BiiVK6bK40oaMaBkzR1jgeEG3dJZ9O6pBlhDqpXjClPAcy68freVHBYSxwv6PE5xZ5OYKTV
 Rwwj+kUxbN+4rDqC0jrIw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WS8bBziK1Rk=:MjKnUeFei7gFmFqTQOXuTQ
 Gbl2xB13eqcsRB9d70pkiP+04g0Z0YTiG5Nt3GGhWl4xeVlz7Y6wkIHTt8uHbqxlNjupayA3O
 MLSUzvqUQAcZgwTi1zSDxfm2WfvBhpVWLcJqURn/wYfKbGW3B/KkCs18itNXr5n+8V1QrzWDp
 6ziHainEHsaWiLYSkaUjhtUWjnFwwhnYAYUMPJClxA7l7rxNc3S40zilR/HwDOFKyn6o0LWra
 cpzE0VFThLzWfc4poQuoDMfrwCv40hG/HK78rLZcY0ZuLGFt6qVvsHwlCgolN5XEgmJqm8E/B
 XwtKVAg20km9CrhMMPRcPL+nZOTDGB0Zl4u8sgspR+7bUBo3viKQhW1whN79rw8a6wVAAUxjH
 XBjbF4kcOKDhzck37Pq35t3LVaiIwC7QKjhK2IljhC1DHCokavo6ExDNC2xg87FCAKCVmH52E
 hjRPMJ5cp0IPotmLDmGpuRBAWJWmA8qmbdC1nMhxpzdxMvuvc4IAuHZPwWfHb4u+58srAAHVV
 kqYwlgBJcqNLSyWN///qa0X7kyAZKPwMGUU+zi9polBIvatw6Lv/o9S0akEBZrogaO1U//rCG
 bFsp4mf0gSrN8ca0/LfSgu3bnyomFbCGtKRJ1nOpmuJcxDaOxIszvvSkwL5ZdrQ22HTKsAK8p
 8VC4ZMC+jQJZkSVaIIGI3jhsuzy1EAekrgEPAM+4Tp1G9jp6eBrFLJaMAhVsyTpns8EedIvUH
 b7Ujrs6IcG4XjOJNCW1wdqskeeu/APUGO0yd9UJ4gpcyvAntu/CJMUdVI460sN6//mKSDyHgW
 1M8yMGwmLckbxJm1x9PX/t4QwxW4uEF7WRmPrLPbWsop/KlA56DXCfEaD8XfcrMrRi9zECZx5
 atDVjGqk5C+uA5Mca2bGa6hIWdVS1bdiYyQDYLKR5x+nUQXuKx9/mf8CzpOUiVuZTKGuef4h0
 TnSIqWIAgt+XvDTFaaPL7rCM6rJaL5hzXkonCk1xE5kTbowo2MKoMMuiOoL7y3o+xPWTY3TXr
 7gjdErBcwUyN83Cm7T8dTIwJIELQx+8ckWy6kq2g1rMoOv904wRhrDbW9MzCXu6B/4Kbq5jdg
 Mhx4kr/SFdfPiY=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/14 23:36, Josef Bacik wrote:
> On Wed, Oct 13, 2021 at 09:12:33AM +0800, Qu Wenruo wrote:
>> Test case misc/038 uses hardcoded backup slot number, this means if we
>> change how many transactions we commit during mkfs, it will immediately
>> break the tests.
>>
>> Such hardcoded tests will be a big pain for later btrfs-progs updates.
>>
>> Update it with runtime backup slot search.
>>
>> Such search is done by using current filesystem generation as a search
>> target and grab the slot number.
>>
>> By this, no matter how many transactions we commit during mkfs, the tes=
t
>> case should be able to handle it.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Use run_check() instead of manually redirect output to "$RESULT"
>> - Quote "$main_root_ptr"
>> ---
>>   .../038-backup-root-corruption/test.sh        | 47 ++++++++++++------=
-
>>   1 file changed, 29 insertions(+), 18 deletions(-)
>>
>> diff --git a/tests/misc-tests/038-backup-root-corruption/test.sh b/test=
s/misc-tests/038-backup-root-corruption/test.sh
>> index b6c3671f2c3a..bf41f1e0952b 100755
>> --- a/tests/misc-tests/038-backup-root-corruption/test.sh
>> +++ b/tests/misc-tests/038-backup-root-corruption/test.sh
>> @@ -17,25 +17,35 @@ run_check $SUDO_HELPER touch "$TEST_MNT/file"
>>   run_check_umount_test_dev
>>
>>   dump_super() {
>> -	run_check_stdout $SUDO_HELPER "$TOP/btrfs" inspect-internal dump-supe=
r -f "$TEST_DEV"
>> +	# In this test, we will dump super block multiple times, while the
>> +	# existing run_check*() helpers will always dump all the output into
>> +	# the log, flooding the log and hide real important info.
>> +	# Thus here we call "btrfs" directly.
>> +	$SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super -f "$TEST_DEV"
>>   }
>>
>> -# Ensure currently active backup slot is the expected one (slot 3)
>> -backup2_root_ptr=3D$(dump_super | grep -A1 "backup 2" | grep backup_tr=
ee_root | awk '{print $2}')
>> -
>>   main_root_ptr=3D$(dump_super | awk '/^root\t/{print $2}')
>> +# Grab current fs generation, and it will be used to determine which b=
ackup
>> +# slot to use
>> +cur_gen=3D$(dump_super | grep ^generation | awk '{print $2}')
>> +backup_gen=3D$(($cur_gen - 1))
>> +
>> +# Grab the slot which matches @backup_gen
>> +found=3D$(dump_super | grep backup_tree_root | grep -n "gen: $backup_g=
en")
>>
>> -if [ "$backup2_root_ptr" -ne "$main_root_ptr" ]; then
>> -	_log "Backup slot 2 not in use, trying slot 3"
>> -	# Or use the next slot in case of free-space-tree
>> -	backup3_root_ptr=3D$(dump_super | grep -A1 "backup 3" | grep backup_t=
ree_root | awk '{print $2}')
>> -	if [ "$backup3_root_ptr" -ne "$main_root_ptr" ]; then
>> -		_fail "Neither backup slot 2 nor slot 3 are in use"
>> -	fi
>> -	_log "Backup slot 3 in use"
>> +if [ -z "$found" ]; then
>> +	_fail "Unable to find a backup slot with generation $backup_gen"
>>   fi
>>
>> -run_check "$INTERNAL_BIN/btrfs-corrupt-block" -m $main_root_ptr -f gen=
eration "$TEST_DEV"
>> +slot_num=3D$(echo $found | cut -f1 -d:)
>> +# To follow the dump-super output, where backup slot starts at 0.
>> +slot_num=3D$(($slot_num - 1))
>
> What happens if we're on $slot_num =3D=3D 0?  Seems like this would mess=
 up, right?
> Thanks,

Note that, the $found is from "grep -n" which starts its line number at 1.

Thus $slot_num will always be >=3D 1, and nothing will be wrong.

Thanks,
Qu

>
> Josef
>
