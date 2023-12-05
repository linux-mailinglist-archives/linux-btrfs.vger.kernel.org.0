Return-Path: <linux-btrfs+bounces-676-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C079805F3F
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 21:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2D011F216DD
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 20:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028416DD01;
	Tue,  5 Dec 2023 20:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="FAWLDroy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0DCD41
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Dec 2023 12:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1701807398; x=1702412198; i=quwenruo.btrfs@gmx.com;
	bh=NGMVYZ17EPxeptm0tK/lGhPlUKiRR2xnQgyoiRSn/Jc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=FAWLDroyLmqrwCS/ndGSqoKg7czEvyRAo3/5WE01jNfTeKqaQ2si20IajoU2UBh3
	 zmhnuiKCZHxLWtyOR4NBMhwejTUgWGl8lENS5ZyfJ8i+s86ZnEW9BR1KpS6RLdIUY
	 pVnZUp/hRQU4sZ/+ryRbGZN27VxZvzeY53XpFpALlxGi3+sw7pPabddjcTTSNeCEg
	 6AvndOG3CSqBt/tECW8UrvGtVb1WWWl73enT+8PhW6GJb1KOgcWUI4MJYT5jJ7QmW
	 fbhltpUsa7zFTGEQil72tpPnypWbkpMgly/TIO3rVPUVHPvA3s/Ot2wyifNKDmqY7
	 kzYPfAlNsMkFmUOQ4Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MPXdC-1qwwsh1iJG-00MeBP; Tue, 05
 Dec 2023 21:16:38 +0100
Message-ID: <6452fd26-efb9-476b-aa22-13e4b33dc735@gmx.com>
Date: Wed, 6 Dec 2023 06:46:33 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] btrfs: free qgroup rsv on ioerr ordered_extent
Content-Language: en-US
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1701464169.git.boris@bur.io>
 <301bc827ef330a961a95791e6c4d3dbe3e2a6108.1701464169.git.boris@bur.io>
 <a72c5e7a-13ab-4f2f-8371-7ef4e2e2646e@gmx.com>
 <ZW99IahvTeLvQ0yv@devvm9258.prn0.facebook.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <ZW99IahvTeLvQ0yv@devvm9258.prn0.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qWn2xi6jJJdAFPwpnFWyd4b/9BrjMemJZOnq0qWhfGuGbKNGfEW
 Hqt6StwXNF0/avlw6b0rc+fLfq4bNTFjip7jEw7D2HxHYCvqif6l2V/Hy9XhYemmNP0f01C
 DNSYjrJ7jmZOE8imaoxISiFi3ygzBPaFN6eZvrbNwZ02i19SB5VNJ59g+AAoUEXhSAlIo5/
 jl45h53c2UK6PIeSu5XRg==
UI-OutboundReport: notjunk:1;M01:P0:12TD30fnnos=;L19J8yOXzE4InRgCUVcEEmIDuzh
 m79RAaO6y9g0omLvsdWE13xeQGbw6yVwMyRHH58v1Yux08b8WzPIOX+znjXYoY4QBeV4X/trv
 Om/g8fURq+o+TbysM2BbyHviI9sL58fklzgrBFsucpEuNs8eCz41T++dtV1TegWitRiOhxoh8
 dUJmr0M1PstDCGQIYrfAUpkyGN6t8oB+xQARoH8I9WYeqk4fMFcvBIpICR+ZEfNQxIJ5Tmk1R
 FKt+lfQwXP22y4vo6kXLeDFhsKxzq8WcLe3mxhXGNNprthceL8neTImNaYtq8D6z0sGalWJDA
 ENVjTu2p1RfACIW1IyxkxKRUAd/HNXIwK/u8YixUIMwo/9NwYG4qmUUCdCjiPMO81nXk/q2VM
 pt3o3ySuWnYwpwXIgVRdDNP2SHyUdpln32sH0/0hmOADEM7WkWmHymj2gCnh1SQkXXtnVfq5A
 c9K8xgzlra8zVa+DHIWzXEgorW7hG4bSJVPOdxqLV/kjQWtp20lt9kh645fOdBE7Al8HZ3tXV
 blaK6963D7fepTau3foseqNSFD8DfzjAsdeHhaxXwuKmwUa0W/ECbK4z7YrK6LerelT0ivifO
 SyAfdE0CEC/BzFZeHJ+57XB9KzrfqrMAIrXFG5G2Q2cwtj4W5MemrTgcfDkIZV4rNJV/i5qeA
 Zhvr5RRLK99EyugljQ+68D23K3StCLAvGb+3uEifaBlo80cY5SnQZ4ouVqxZEXe2wl2tA+Osb
 /LrZbo00FVs9n6GgmGEnEjihp30XkaP/JN2viB0PxHNUU7iCGG1REmuMgD3UTrBzBiEZjLg3b
 gHA8Py4q0gyl5F3xAi1eXWXyT9V0DQK/NDpFtvgQdlJYgjsDnJFVHcX9XPKz5dC6HPbLYNWW6
 Qr99AL2dRb7/khhrF21uBLeEbUmbCKpdFTCaLLjB2bt9NpVyLQ88kV+oxphcd46LVYy8PvnIe
 rNEwwNIovVQ9Z81KsyxQmVH7qUo=



On 2023/12/6 06:12, Boris Burkov wrote:
> On Tue, Dec 05, 2023 at 07:34:10AM +1030, Qu Wenruo wrote:
>>
>>
>> On 2023/12/2 07:30, Boris Burkov wrote:
>>> An ordered extent completing is a critical moment in qgroup rsv
>>> handling, as the ownership of the reservation is handed off from the
>>> ordered extent to the delayed ref. In the happy path we release (unloc=
k)
>>> but do not free (decrement counter) the reservation, and the delayed r=
ef
>>> drives the free. However, on an error, we don't create a delayed ref,
>>> since there is no ref to add. Therefore, free on the error path.
>>
>> And I believe this would cause btrfs to be noisy at the unmount time,
>> due to unreleased qgroup rsv.
>>
>> Have you hit any one during your tests? If so, mind to add some dmesg
>> output for it?
>>
>> Or if no hit so far, would it be possible to add a new test case for it=
?
>
> I hit the conditions for all of these fixes running xfstests with
> MKFS_OPTIONS including -O squota or -O quota. IIRC the failures were
> almost all in the umount path in btrfs_check_quota_leak, though some of
> the issues manifested as reservation freeing underflows in
> qgroup_rsv_release. generic/475 triggered most of the bugs but a handful
> of other tests hit some others. Unfortunately, I did not take perfect
> notes on which test was fixed by which patch. I can try to recover that
> information by removing the patches and running the full suite while
> iteratively adding them back in. That is obviously fairly time consuming=
,
> so I would only do it if people really want that information in the comm=
it
> messages or something.

Oh no worries, in that case I'm totally fine with the current commit
message.

Although a CC to stable would be nicer for patches 1~4.

Thanks,
Qu
>
> Thanks for the review!
> Boris
>
>>
>>>
>>> Signed-off-by: Boris Burkov <boris@bur.io>
>>
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
>> Thanks,
>> Qu
>>
>>> ---
>>>    fs/btrfs/ordered-data.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
>>> index 574e8a55e24a..8d4ab5ecfa5d 100644
>>> --- a/fs/btrfs/ordered-data.c
>>> +++ b/fs/btrfs/ordered-data.c
>>> @@ -599,7 +599,8 @@ void btrfs_remove_ordered_extent(struct btrfs_inod=
e *btrfs_inode,
>>>    			release =3D entry->disk_num_bytes;
>>>    		else
>>>    			release =3D entry->num_bytes;
>>> -		btrfs_delalloc_release_metadata(btrfs_inode, release, false);
>>> +		btrfs_delalloc_release_metadata(btrfs_inode, release,
>>> +						test_bit(BTRFS_ORDERED_IOERR, &entry->flags));
>>>    	}
>>>
>>>    	percpu_counter_add_batch(&fs_info->ordered_bytes, -entry->num_byte=
s,

