Return-Path: <linux-btrfs+bounces-16625-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0080B4485D
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Sep 2025 23:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76593165013
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Sep 2025 21:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE492BD01E;
	Thu,  4 Sep 2025 21:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="qixTKu1z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA1F267AF2;
	Thu,  4 Sep 2025 21:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757020705; cv=none; b=QUqXzqJvptlXJp92yoYeo/j5Ih2WO/06PCCEXOKNV9L/7wYEmRsSJZS0jEvSZU2mxtnNHh0YTID1zyX+s6obadnswV5SyS4c3D4Dpg0NKQHMJzpioDRrGFmmNtPmSi1bneBS/nlgfA6KqlmiKWVfslEic3WVBxbb4mzHZFd8cWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757020705; c=relaxed/simple;
	bh=VrLwWELugF6mqpulOo0DhWkjRiinNZhMz0LgXsdIRJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kf0AF+VjITFpik8BtInqJ8Y2xICbtt84hInZSsViNvG19wJQxxqsnQMx7Xw+Bva0aOoYDR8N5nXVK9q9zMgsTCAddkAKNQOrO+ctzis+TIWXXT5O6X2gFWLoM5n3/FsizIjWCrozt49Ea9FsBxvpz3Bg8KhG44+itp30zixxK5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=qixTKu1z; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1757020695; x=1757625495; i=quwenruo.btrfs@gmx.com;
	bh=PSSCRQuWBHT4ziNyCUr5d0MGmxmZK5/nqfTsI1G6OMU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qixTKu1z4Yft/tM6Ie9C2qw7Y4oJgEIV2uqFQXR+FJXdRBT+CehLDLQ46wVE5E2Y
	 WO5MMTu6rEkmJYHNneXmL7Y3n9jMkEqBsQz484ndms+YRkaomb5yyC2OUacSy5vzb
	 gaXHoCTBjpTJ/D7lS62/G9l2hf9b4wa3v7vWoPgLfFzVUI4jKOY9yfGJTWOPF0TNC
	 zqwb+TmAO+ZTtzU0x49mDvNw1D1Sg5Xpt4rJI3dysxhMUCxMGsjnl6+k09MP+30px
	 BvQ0HCPWfee9XUj1J4KaXlERCuEvOvJ+OF8YcxM0lMGuoXcuf5+zE6S1x6qu6XFXA
	 nAMRfDXo+SFxB26WEw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MBlxW-1ukQWY2Q7Y-003qcJ; Thu, 04
 Sep 2025 23:18:15 +0200
Message-ID: <d7709558-2bc7-40cc-81ca-f2cb3b612175@gmx.com>
Date: Fri, 5 Sep 2025 06:48:11 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: generic/733: avoid output difference due to
 bash's version
To: "Darrick J. Wong" <djwong@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20250904081429.114716-1-wqu@suse.com>
 <20250904150022.GE8092@frogsfrogsfrogs>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <20250904150022.GE8092@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qTmOlE+H/zo+OTrc1Cb5Tw0RaI3EDrKbqzvb+uN/biOqGMnJbi8
 ZYihWMEWcLFxqGpka+reWrRDNMRa12XznbD3BjsWGzBSdN7tJfD+e5RSVEMLpqZSsDg/bYL
 d2DEjzfc02ldKAsCu8xy1IyHvAUStMnO2HlHiqz5FjZqqrmdsEHfhHKENWiWXrHrL4cHmrE
 D3ooMiCd8SXz2/rFksRCw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tQPX9o1rSzM=;cZi2bGGasrJXNv3Ph/JlkbbKgfH
 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
 8JEHWC8Z8qgyyD5kwVgILSf1kHwKN2Ig==



=E5=9C=A8 2025/9/5 00:30, Darrick J. Wong =E5=86=99=E9=81=93:
> On Thu, Sep 04, 2025 at 05:44:29PM +0930, Qu Wenruo wrote:
>> [FALSE ALERT]
>> When running generic/733 with bash 5.3.3 (any thing newer than 5.3.0
>> will reproduce the bug), the test case will fail like the following:
>>
>> generic/733 19s ... - output mismatch (see /home/adam/xfstests/results/=
/generic/733.out.bad)
>>      --- tests/generic/733.out	2025-09-04 17:30:08.568000000 +0930
>>      +++ /home/adam/xfstests/results//generic/733.out.bad	2025-09-04 17=
:30:32.898475103 +0930
>>      @@ -2,5 +2,5 @@
>>       Format and mount
>>       Create a many-block file
>>       Reflink the big file
>>      -Terminated
>>      +Terminated                 $here/src/t_reflink_read_race "$testdi=
r/file1" "$testdir/file2" "$testdir/outcome" &>> $seqres.full
>>       test completed successfully
>>      ...
>>      (Run 'diff -u /home/adam/xfstests/tests/generic/733.out /home/adam=
/xfstests/results//generic/733.out.bad'  to see the entire diff)
>>
>> [CAUSE]
>> The failure is fs independent, but bash version dependent.
>>
>> In bash v5.3.x, the job control will output the command which triggered
>> the job control (from termination to core dump etc).
>>
>> The "Terminated" message is not from the program, but from bash's job
>> control, thus redirection won't hide that message.
>>
>> [FIX]
>> Instead of relying on the job control behavior from bash, run the
>> t_reflink_read_race tool in background, and wait for it to finish.
>>
>> Background bash will be non-interactive, thus no job control and no
>> "Terminated" message.
>>
>> Thankfully this particular test case does extra checks on the outcome
>> file to determine if the program is properly terminated, thus we are
>> safe to delete the "Terminated" line from the golden output.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   tests/generic/733     | 15 ++++++++++++++-
>>   tests/generic/733.out |  1 -
>>   2 files changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/generic/733 b/tests/generic/733
>> index aa7ad994..b8321abc 100755
>> --- a/tests/generic/733
>> +++ b/tests/generic/733
>> @@ -70,8 +70,21 @@ done
>>   echo "fnr=3D$fnr" >> $seqres.full
>>  =20
>>   echo "Reflink the big file"
>> +# Workaround the default job control by running it at background.
>> +#
>> +# Job control of bash v5.3.x will output the command which triggered t=
he job
>> +# control (terminated, core dump etc).
>> +# And since it's handled by bash itself, redirection won't work for th=
e job
>> +# control message.
>> +#
>> +# Running the command in background will disable the job control thus
>> +# there will be no extra message like "Terminated".
>> +#
>> +# We will check the outcome file to determine if the program is proper=
ly
>> +# terminated, thus no need to bother the job control message.
>>   $here/src/t_reflink_read_race "$testdir/file1" "$testdir/file2" \
>> -	"$testdir/outcome" &>> $seqres.full
>> +	"$testdir/outcome" &>> $seqres.full &
>> +wait
>=20
> Hrmm, the only problem I can see is what happens if someone hits ^C to
> terminate fstests while t_reflink_read_race is running?  Will anything
> wait for it to terminate, or will the user be stuck with it running in
> the background, pinning the mount, etc. ?
>=20
> Or can we use shell command groups here:
>=20
> { $here/src/t_reflink_read_race <params> ; } 2>/dev/null
>=20
> (the semicolon is significant)

That also works, and it keeps the foreground job control output, and=20
this time we can redirect the job control message.

And of course no extra cleanup requirement.

Will go this solution.

Thanks a lot for pointing this out,
Qu
>=20
> to run t_reflink_read_race as a foreground job but redirect the
> shell's helpful termination messages to /dev/null?
>=20
> --D
>=20
>>  =20
>>   if [ ! -e "$testdir/outcome" ]; then
>>   	echo "Could not set up program"
>> diff --git a/tests/generic/733.out b/tests/generic/733.out
>> index d4f5a7c7..2383cc8d 100644
>> --- a/tests/generic/733.out
>> +++ b/tests/generic/733.out
>> @@ -2,5 +2,4 @@ QA output created by 733
>>   Format and mount
>>   Create a many-block file
>>   Reflink the big file
>> -Terminated
>>   test completed successfully
>> --=20
>> 2.51.0
>>
>>
>=20


