Return-Path: <linux-btrfs+bounces-2472-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D921A858E53
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Feb 2024 10:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E1DC1F21E60
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Feb 2024 09:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1011D53C;
	Sat, 17 Feb 2024 09:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KCdzMhjR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214DE1CA86
	for <linux-btrfs@vger.kernel.org>; Sat, 17 Feb 2024 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708162294; cv=none; b=SnEywXXmP8RGKtPMHiWRUPyrIP0tvOvG5B+05DIICGL+hNoOz9VT9dy0+A4lcHmyHwdom5B1DbXZ62uaS05y63gvmVzLMmw8xZhn4ym/eieFdwpR89nHLwAKhV6MlROfZwI8/lDMkwlwiS5xkZJMImY7oYuUh1yaej+jGcOZnzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708162294; c=relaxed/simple;
	bh=/+VVou+7x0qjLg6ShaydQjjiNMeL+0T802ytQMF3+sg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=O5iHLDHvua/ax8pi/sc972LqSD+eR10f1irgakpha5e4FjBE6nQxvknCFvj5S0qE1Ya7nQl9igqZovjWBaaaoYkCtHbIxzxsTT0wK1QzgQR2RSi3p1Rt8ZCiP/qY13bzGK4kip0kcpDKO5hiybOccnPS3/xyqDgq26R0eeL/mog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KCdzMhjR; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d0cdbd67f0so39528521fa.3
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Feb 2024 01:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1708162286; x=1708767086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AAg8r278QlNExvnpu5jrbibudRzXtG3KWVJiC4utMto=;
        b=KCdzMhjRFCFTJNnTX4dINe1zWE2zjuRZspZcljvRsMEkNzL3vnYJI6QWoq/V+3E5+O
         Bwq3wwDyFnDfLVjHQrkw9JRcunAE1U51FzGrGROCVdTZ4YuVD3Kfx5sN9YYpMpmS5z+M
         6n78QqhaHmaSygs5o84S0YTRfbfTVazJsnhcBvdWynTOdHzAc6snjwoQ+2eQyAyd4+OT
         GlOj5wiq/nLSrT2YGIdtFpQUXR7f9p4n+EKosJPyXhyEWbnuLEbRpJMCJDCSsS6TPg6d
         aHPoOdVyNego/bQd9Day5D++ZKZicPcSYvQ46PRT1LyifWkl7Mh4NXhbcFJwZxTzAbCe
         yRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708162286; x=1708767086;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AAg8r278QlNExvnpu5jrbibudRzXtG3KWVJiC4utMto=;
        b=HX0G5SvJ+c2v95sexxsLytzoJNwXeqQN+BT9Oe6hGEThI1iX+Qpd3AfvPt70iYJzVy
         o6xN+FzTxr7NizAVjHS2pJZ6szYeGsbL2YmedP7iD+wUk+2XM609t/tTl926v2mYdPKk
         m3lt0vQjascH2r0CCyeJrlyrXXBwh7Igb+2oGGxX1e6JfhxPxQQZHGT77zLaXFIehDTJ
         7T4r75CCEMgrPjMXJ3zkLHv2J+2fd4Nve+hnn9pZgOdfSVZMlhzi5ohbRpglTuKM1urs
         rCRTArTCh/qtXE1/e52gaXrjgiG/GTiD8OCphDV2nCGaToazi4VEShZaoW8EMUamXnW2
         m5NA==
X-Gm-Message-State: AOJu0YzKGvKtCqAtZLItEs4mamSiKVDdAtdkpr5sQPJq4Farh/V/TfYE
	B1p9ERzu/gNV9CLE2UcdBKcE9VPStw/RJhDEfqg3AlJPza53z37k67hgWFMmzm9eiBP0XoMC6Vw
	41vQ=
X-Google-Smtp-Source: AGHT+IGaqeH/3Gmg8KUpHHSHjc3tJAw11pn0r8K0dHA5K39CaheZh7/A4IyD+qewrDs38W0TKZ09Cg==
X-Received: by 2002:a2e:3a07:0:b0:2d2:1d51:333e with SMTP id h7-20020a2e3a07000000b002d21d51333emr2219665lja.49.1708162286260;
        Sat, 17 Feb 2024 01:31:26 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id l9-20020a170902eb0900b001db63cfe07dsm1081632plb.283.2024.02.17.01.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 01:31:25 -0800 (PST)
Message-ID: <8352b5c0-0820-4156-b2a1-d80aa03418a7@suse.com>
Date: Sat, 17 Feb 2024 20:01:21 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/016: fix a false alert due to xattrs mismatch
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <ae441bd376587124becd9141ed690598d4ed281a.1703741660.git.wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <ae441bd376587124becd9141ed690598d4ed281a.1703741660.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

A gentle ping.

As the test case still failed in the latest for-next branch due to the 
SELinux xattr mismatch.

Thanks,
Qu

在 2023/12/28 16:06, Qu Wenruo 写道:
> [BUG]
> When running btrfs/016 after any other test case, it would fail on a
> SELinux enabled environment:
> 
>    btrfs/015 1s ...  0s
>    btrfs/016 1s ... [failed, exit status 1]- output mismatch (see ~/xfstests-dev/results//btrfs/016.out.bad)
>        --- tests/btrfs/016.out	2023-12-28 10:39:36.481027970 +1030
>        +++ ~/xfstests-dev/results//btrfs/016.out.bad	2023-12-28 15:53:10.745436664 +1030
>        @@ -1,2 +1,3 @@
>         QA output created by 016
>        -Silence is golden
>        +fssum failed
>        +(see ~/xfstests-dev/results//btrfs/016.full for details)
>        ...
>        (Run 'diff -u ~/xfstests-dev/tests/btrfs/016.out ~/xfstests-dev/results//btrfs/016.out.bad'  to see the entire diff)
>    Ran: btrfs/015 btrfs/016
>    Failures: btrfs/016
>    Failed 1 of 2 tests
> 
> [CAUSE]
> The test case itself would try to use a blank SELinux context for the
> SCRATCH_MNT, to control the xattrs.
> 
> But the initial send stream is generated from $TEST_DIR, which may still
> have the default SELinux mount context.
> 
> And such mismatch in the SELinux xattr (source on $TEST_DIR still has
> the extra xattr, meanwhile the receve end on $SCRATCH_MNT doesn't) would
> lead to above mismatch.
> 
> [FIX]
> Instead of doing all the edge juggling using $TEST_DIR, this time we do
> all the work on $SCRATCH_MNT.
> 
> This means we would generate the initial send stream from $SCRATCH_MNT,
> then reformat the fs, mount scratch again, receive and verify.
> 
> This does not only fix the above false alerts, but also simplify the
> cleanup.
> We no longer needs to cleanup the extra file for the initial send
> stream, as they are on the scratch device and would be formatted anyway.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   tests/btrfs/016 | 46 ++++++++++++++++++++++------------------------
>   1 file changed, 22 insertions(+), 24 deletions(-)
> 
> diff --git a/tests/btrfs/016 b/tests/btrfs/016
> index 35609329ba0e..9371b3316332 100755
> --- a/tests/btrfs/016
> +++ b/tests/btrfs/016
> @@ -12,22 +12,11 @@ _begin_fstest auto quick send prealloc
>   tmp=`mktemp -d`
>   tmp_dir=send_temp_$seq
>   
> -# Override the default cleanup function.
> -_cleanup()
> -{
> -	$BTRFS_UTIL_PROG subvolume delete $TEST_DIR/$tmp_dir/snap > /dev/null 2>&1
> -	$BTRFS_UTIL_PROG subvolume delete $TEST_DIR/$tmp_dir/snap1 > /dev/null 2>&1
> -	$BTRFS_UTIL_PROG subvolume delete $TEST_DIR/$tmp_dir/send > /dev/null 2>&1
> -	rm -rf $TEST_DIR/$tmp_dir
> -	rm -f $tmp.*
> -}
> -
>   # Import common functions.
>   . ./common/filter
>   
>   # real QA test starts here
>   _supported_fs btrfs
> -_require_test
>   _require_scratch
>   _require_fssum
>   _require_xfs_io_command "falloc"
> @@ -41,29 +30,33 @@ export SELINUX_MOUNT_OPTIONS=""
>   
>   _scratch_mount
>   
> -mkdir $TEST_DIR/$tmp_dir
> -$BTRFS_UTIL_PROG subvolume create $TEST_DIR/$tmp_dir/send \
> +mkdir $SCRATCH_MNT/$tmp_dir
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/$tmp_dir/send \
>   	> $seqres.full 2>&1 || _fail "failed subvolume create"
>   
> -_ddt of=$TEST_DIR/$tmp_dir/send/foo bs=1M count=10 >> $seqres.full \
> +_ddt of=$SCRATCH_MNT/$tmp_dir/send/foo bs=1M count=10 >> $seqres.full \
>   	2>&1 || _fail "dd failed"
> -$BTRFS_UTIL_PROG subvolume snapshot -r $TEST_DIR/$tmp_dir/send \
> -	$TEST_DIR/$tmp_dir/snap >> $seqres.full 2>&1 || _fail "failed snap"
> -$XFS_IO_PROG -c "fpunch 1m 1m" $TEST_DIR/$tmp_dir/send/foo
> -$BTRFS_UTIL_PROG subvolume snapshot -r $TEST_DIR/$tmp_dir/send \
> -	$TEST_DIR/$tmp_dir/snap1 >> $seqres.full 2>&1 || _fail "failed snap"
> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/$tmp_dir/send \
> +	$SCRATCH_MNT/$tmp_dir/snap >> $seqres.full 2>&1 || _fail "failed snap"
> +$XFS_IO_PROG -c "fpunch 1m 1m" $SCRATCH_MNT/$tmp_dir/send/foo
> +$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/$tmp_dir/send \
> +	$SCRATCH_MNT/$tmp_dir/snap1 >> $seqres.full 2>&1 || _fail "failed snap"
>   
> -$FSSUM_PROG -A -f -w $tmp/fssum.snap $TEST_DIR/$tmp_dir/snap >> $seqres.full \
> +$FSSUM_PROG -A -f -w $tmp/fssum.snap $SCRATCH_MNT/$tmp_dir/snap >> $seqres.full \
>   	2>&1 || _fail "fssum gen failed"
> -$FSSUM_PROG -A -f -w $tmp/fssum.snap1 $TEST_DIR/$tmp_dir/snap1 >> $seqres.full \
> +$FSSUM_PROG -A -f -w $tmp/fssum.snap1 $SCRATCH_MNT/$tmp_dir/snap1 >> $seqres.full \
>   	2>&1 || _fail "fssum gen failed"
>   
> -$BTRFS_UTIL_PROG send -f $tmp/send.snap $TEST_DIR/$tmp_dir/snap >> \
> +$BTRFS_UTIL_PROG send -f $tmp/send.snap $SCRATCH_MNT/$tmp_dir/snap >> \
>   	$seqres.full 2>&1 || _fail "failed send"
> -$BTRFS_UTIL_PROG send -p $TEST_DIR/$tmp_dir/snap \
> -	-f $tmp/send.snap1 $TEST_DIR/$tmp_dir/snap1 \
> +$BTRFS_UTIL_PROG send -p $SCRATCH_MNT/$tmp_dir/snap \
> +	-f $tmp/send.snap1 $SCRATCH_MNT/$tmp_dir/snap1 \
>   	>> $seqres.full 2>&1 || _fail "failed send"
>   
> +_scratch_unmount
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +
>   $BTRFS_UTIL_PROG receive -f $tmp/send.snap $SCRATCH_MNT >> $seqres.full 2>&1 \
>   	|| _fail "failed recv"
>   $BTRFS_UTIL_PROG receive -f $tmp/send.snap1 $SCRATCH_MNT >> $seqres.full 2>&1 \
> @@ -74,5 +67,10 @@ $FSSUM_PROG -r $tmp/fssum.snap $SCRATCH_MNT/snap >> $seqres.full 2>&1 \
>   $FSSUM_PROG -r $tmp/fssum.snap1 $SCRATCH_MNT/snap1 >> $seqres.full 2>&1 \
>   	|| _fail "fssum failed"
>   
> +# Unset the selinux mount options and restore whatever the default one for
> +# test device.
> +unset SELINUX_MOUNT_OPTIONS
> +_test_cycle_mount
> +
>   echo "Silence is golden"
>   status=0 ; exit

