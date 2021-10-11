Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CE1428BCC
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 13:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbhJKLOV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 07:14:21 -0400
Received: from mout.gmx.net ([212.227.15.15]:46429 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235970AbhJKLOV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 07:14:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633950738;
        bh=tHqvvleBuVM7bL09TRNImFEEuXUOqsBFE66S2MoN4Vo=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=GUQXuPb9XOqPJiiW0di2C6dVGmG5MOEqUzAVQ7hRHs6TWkpbrFE8H4MUBx6+9M032
         E50ZqTpbA3t2NFmKBaOZNJpeIIZX0eXZsof4vhUtIGDE91NGPq/HNL7oV52pTdloug
         o73yWVZnYhCXI33kbaKQTngLEaD/khDIAYPxB/SM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N0oFz-1mvFYt0ZYD-00wn3c; Mon, 11
 Oct 2021 13:12:18 +0200
Message-ID: <c0b7ac80-686a-5511-52f2-f784f370d47d@gmx.com>
Date:   Mon, 11 Oct 2021 19:12:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 3/3] btrfs-progs: mfks-tests: make sure mkfs.btrfs cleans
 up temporary chunks
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211011094300.97504-1-wqu@suse.com>
 <20211011094300.97504-4-wqu@suse.com> <20211011104013.GF9286@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20211011104013.GF9286@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s11EOUdFN8w3aKG4m9wani91k3/j3WRhayJnlW9K37U4R0Y0Dxn
 uT2X2W6hizU8GxEaKssOU+0bwj8kW4Vl1fP2uH35DBI6bzqezn62dIMwDHon/HG/9HSV151
 QYC4RsLwJyTcttbflgWvO9lmSQK7HNmgJlcqKPiqQ4OK5X+4ovIlihdyItdGdHNTpitmP4D
 WZ7/i2FBZTCPWagkSHjcw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:g6V0z4NtDLY=:PiieBo/vhrNBf9a5F0Tnxl
 /4ijXPGgNU0z4WabBYomcaxtZU+smRtcHeh10uK42mEBaZyrXOkTdNSCQ/7m9nfqyBueodcYT
 Zju3PmvlAYsOv+uetdgGmCCfrbTZUHQTPR9KPbS52Tp6WWQimm9S18J41WPwk/nUlFy/Gak2y
 /cVghFgsWFHDmE/RqJBmN1mh2PVWGWnS6zMm1/9oblSx7p17g47PrixBKcxLHu2RsbO9nswLe
 LCUN/PA61up5jMvBXSIyhI5yGDKs1I9+dbIgs6v2IMxI+wSixt3t+hY2cyBkglo4j0ok/64Vh
 bIdB/vuP0MgvhdYeFAVrqdVJ0gZKBq0ccrNhVpJbeDTlkxRR83M91NFHPOyX3dxbwRFnPofmX
 dFRbfXQrcdQjesFQLJ8ggD6x/tGr6CkSMgWQrDoleZPM8UZiVT1fiE2CeLmsbQtC1vZucxMjj
 wPTmcIyBVvEcC4x1xjTfsr6Z/TROVnQLr1RGPSbpAer2DvX8Vn1r4yoojAD1YxukqdL/dIkQ1
 RGKZPyTrYn2shbSRV3BUWe2jj2H+7py3Xs9XPMT2pX4vjHzLTZIBh/7rFec2Fb6WGKFWRcpUq
 /CLyPXxL0sAI9p4zqAqCUmSrLKhqew+NMd7a1yimAzfzW+Znej0Ie0ZXl5e5KOFiet9kZ3Svk
 CuwC6459UIF1m9OxQybpP6rhU545q30nFYaliGvfwEOxJSWyTfTRbwLDJrxtLneSMsGw7ePIE
 AacVfU1Xr9e5KawMSRIJolrQaPXrizrwxzkemHtWfw68QOZnZWoB2jhyfAkkw2T/ZtI3GrHUz
 r/x+OjTJGqjrI8bWTtrkpNxxakmPpiWnkWRzbb7bL0faCvswzVHkgEvWQiykQVXR9DaFfLzvb
 dWWuyV7nXwsE8AyKmMiIUBnokF6nlcNFW2NI3BEu8f5ds/NxNKYXSDvK2eOagNFHqSePaKFjE
 +N+cj3Qvwz4Oc8kUuFSJ6A90MnoOlDrpGgRE/EyT0LrjUw3bp3vEnA3swqKDQNkqk/yiL/thC
 eT4D/0W51Ea3uP8XCl26ilUySy/PDHuOUfRjgKaxt9SROpVwQ5zXdew1iPaTq21DUwZpalxlW
 cKAm0+p0Am6uQ4=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/11 18:40, David Sterba wrote:
> On Mon, Oct 11, 2021 at 05:43:00PM +0800, Qu Wenruo wrote:
>> Since current "btrfs filesystem df" command will warn if there are
>> multiple profiles of the same type, it's a good way to detect left-over
>> temporary chunks.
>>
>> This patch will enhance the existing mkfs-tests/001-basic-profiles test
>> case to also check for the warning messages, to make sure mkfs.btrfs ha=
s
>> properly cleaned up all temporary chunks.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   tests/mkfs-tests/001-basic-profiles/test.sh | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/mkfs-tests/001-basic-profiles/test.sh b/tests/mkfs-t=
ests/001-basic-profiles/test.sh
>> index b3ba50d71ddc..e44f9344bc6f 100755
>> --- a/tests/mkfs-tests/001-basic-profiles/test.sh
>> +++ b/tests/mkfs-tests/001-basic-profiles/test.sh
>> @@ -11,11 +11,17 @@ setup_root_helper
>>
>>   test_get_info()
>>   {
>> +	tmp_out=3D$(mktemp --tmpdir btrfs-progs-mkfs-tests-get-info.XXXXXX)
>>   	run_check $SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super "$de=
v1"
>>   	run_check $SUDO_HELPER "$TOP/btrfs" check "$dev1"
>>   	run_check $SUDO_HELPER mount "$dev1" "$TEST_MNT"
>> -	run_check "$TOP/btrfs" filesystem df "$TEST_MNT"
>> -	run_check $SUDO_HELPER "$TOP/btrfs" filesystem usage "$TEST_MNT"
>> +	run_check_stdout "$TOP/btrfs" filesystem df "$TEST_MNT" > "$tmp_out"
>> +	if grep -q "Multiple block group profiles detected" "$tmp_out"; then
>> +		rm -- "$tmp_out"
>> +		_fail "temporary chunks are not properly cleaned up"
>> +	fi
>> +	rm -- "$tmp_out"
>> +	run_check$SUDO_HELPER "$TOP/btrfs" filesystem usage "$TEST_MNT"
>>   	run_check $SUDO_HELPER "$TOP/btrfs" device usage "$TEST_MNT"
>>   	run_check $SUDO_HELPER umount "$TEST_MNT"
>
> This still fails in case mkfs/001-basic-tests with '-d raid0 -m raid0'
>
> =3D=3D=3D=3D=3D=3D RUN CHECK root_helper mount /dev/loop0 .../btrfs-prog=
s/tests/mnt
> =3D=3D=3D=3D=3D=3D RUN CHECK .../btrfs-progs/btrfs filesystem df .../btr=
fs-progs/tests/mnt
> WARNING: Multiple block group profiles detected, see 'man btrfs(5)'.
> WARNING:   Metadata: single, raid0
> WARNING:   System: single, raid0
> Data, raid0: total=3D204.75MiB, used=3D0.00B
> System, raid0: total=3D8.00MiB, used=3D0.00B
> System, single: total=3D32.00MiB, used=3D16.00KiB
> Metadata, raid0: total=3D204.75MiB, used=3D128.00KiB
> Metadata, single: total=3D208.00MiB, used=3D0.00B
> GlobalReserve, unknown: total=3D3.25MiB, used=3D0.00B
> temporary chunks are not properly cleaned up
> test failed for case 001-basic-profiles
>
It passes here (as I'm using sudo make test-mkfs, the missing space is
not causing problem).

BTW, my branch is based on v5.14.2 directly, thus I guess there may be
some extra bugs introduced in devel.

Mind to test my branch directly?
https://github.com/adam900710/btrfs-progs/tree/mkfs_profile_regression

Let me re-check when rebased to devel branch.

Thanks,
Qu
