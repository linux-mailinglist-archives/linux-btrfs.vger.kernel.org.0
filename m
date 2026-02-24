Return-Path: <linux-btrfs+bounces-21888-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFKqLTrbnWmuSQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21888-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 18:09:14 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E86218A53F
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 18:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9345B3030A12
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 17:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D58C3A9D8D;
	Tue, 24 Feb 2026 17:08:54 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287053A9D8E
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 17:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771952934; cv=none; b=ALgype3CgHQo4cUCm852+5kqVFhAfv3oSn/aQC3rsr0BAkFh3ux/Xloa+/+jigG1aOslqGLzWGpdXUyV3RqNaSu0tu2LjlTs1tOlYbUgX21EdSpLu/UY4xlOCMMfr0it6t/ORFAHtX6A5h8PZMoiLqsH3650P6yHJ5/fFTsxdoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771952934; c=relaxed/simple;
	bh=Ran1npH4m61wxc9zJQHSx6DlYQKvr9WT45NvedV6jqM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=FjIvDo4hk2nKEwx49PVos2mEia87CHmlrgvBuoz6WH8oSH8pXJTwOzQx9QqCAxr1DQNAItkyewiUdKSpp5bSiXgiPF/S//2RWnSYmrs3DuW3x7i8YGqoeboqHe35+ln5TQuy87CHAJqbnSvNxLnGIm0S6tqq3Xx6SZhrUtByPKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from [IPV6:2a01:e0a:156:6850:7018:89ff:fecb:6f21] (unknown [IPv6:2a01:e0a:156:6850:7018:89ff:fecb:6f21])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 6D3A719F576;
	Tue, 24 Feb 2026 18:08:48 +0100 (CET)
Message-ID: <72eece35-d5f3-476a-ae0f-5fbd99cb2d60@free.fr>
Date: Tue, 24 Feb 2026 18:08:48 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Stuck on a BTRFS problem
From: Phako <phako@free.fr>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <77535c20-da3e-4dfb-b3d7-9426c25b5da3@free.fr>
 <0211658c-8d28-46d1-8e41-21dc02cab276@suse.com>
 <b1c1247f-df00-4045-a508-fb9a5666114a@free.fr>
 <cb183999-6a95-456a-80f4-f703da298d74@suse.com>
 <deb56ee2-b5d6-4beb-9554-05da125dde54@free.fr>
 <51597107-5a23-4f15-9481-b4d58e18bbe1@suse.com>
 <2f7fe549-676d-45fb-b97a-82096027c89c@free.fr>
Content-Language: en-US, fr
In-Reply-To: <2f7fe549-676d-45fb-b97a-82096027c89c@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[free.fr : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21888-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[free.fr];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phako@free.fr,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7E86218A53F
X-Rspamd-Action: no action

Le 24/02/2026 à 16:53, Phako a écrit :
> Le 23/02/2026 à 22:35, Qu Wenruo a écrit :
>>
>>
>> 在 2026/2/24 02:11, Phako 写道:
>>> Le 23/02/2026 à 08:32, Qu Wenruo a écrit :
>> [...]
>>>
>>> I get that you might think this issue is not BTRFS related, but I'm 
>>> still not 100% sure of what is the cause of the error. So I'm still 
>>> having a couple of questions to rule out wrong hypothesis or direct 
>>> me on the right track:
>>>
>>> Do you think that if I copy a good copy of file_B.mp4 over the 
>>> corrupt file_B.mp4 (eg: cat b.mp4 > b_corrupt.mp4) it will overwrite 
>>> the metadata and the same physical LBAs?
>>
>> The metadata is not involved. It's fully the data part (and its 
>> checksum).
>>
>> And unfortunately, a full over-write doesn't not guarantee the new 
>> data will be written into the same the location.
>>
>>> Are there any btrfs commands I could run before and/or after to check 
>>> if it worked, and to map this reported corrupt logical blocks with 
>>> actual LBAs?
>>
>> But if you have the correct original file, you can try to manually 
>> over- write the data, using "btrfs-map-logical" command to calculate 
>> the on- disk physical LBA, then using whatever tool (dd for example) 
>> to directly write the content into that physical address.
>>
>> Using your previous scrub dmesg as an example:
>>
>>  > Feb 09 16:18:02 soleil kernel: BTRFS warning (device sda3): csum 
>> failed
>>  > root 257 ino 40442 off 46100480 csum 0xc9e01f9a expected csum 
>> 0xb20f9f0e
>>  > mirror 1
>>
>>
>> The first line of "csum failed" shows exactly where the corruption is 
>> in the file (subvolume 257, inode number 40442, file offset 46100480).
>>
>> Then you can use fiemap to map the file offset to the btrfs logical 
>> address:
>>
>>   $ xfs_io -c "fiemap 46100480 4096" <path_to_the_file>
>>
>> It would show something like this (just an example, not matching your 
>> output):
>>
>> Filesystem type is: 9123683e
>> File size of /mnt/btrfs/foobar is 1048576 (256 blocks of 4096 bytes)
>>   ext:     logical_offset:        physical_offset: length:   expected: 
>> flags:
>>     0:        0..     255:       3328..      3583:    256: last,eof
>> /mnt/btrfs/foobar: 1 extent found
>>
>> The "logical_offset" part is the offset inside the file, the 
>> "physical_offset" is the logical address inside btrfs.
>> The unit is a block (4096 bytes shown after the filesystem type line).
>>
>> The range should cover your 46100480 file offset.
>>
>> You need to grab the btrfs logical address by converting the number.
>>
>> Then with the logical bytenr, you can convert it to the physical 
>> address by using "btrfs-map-logical"
>>
>>   $ btrfs-map-logical -l <logical> <device>
>>
>> It will output something like this:
>>
>>   $ btrfs-map-logical -l 13635584 test.img
>>   mirror 1 logical 13631488 physical 13635584 device test.img
>>
>> The number 13631488 is 3329 * 4096, corresponding to the file offset 
>> 4K of my previous example.
>>
>>
>> The resulted physical bytenr and device is where you should write the 
>> data into.
>>
>>
>> This can be very complex, so please paste the output of "$ xfs_io -c 
>> "fiemap 46100480 4096" <path_to_the_file>" first, then we can figure 
>> the exact command to use in the next step.
> 
> The output I get is quite different, more terse:
> $ xfs_io -c "fiemap 31494144 4096" 'file_B.mp4'
> file_B.mp4:
>          0: [0..87103]: 6658490256..6658577359
> 
> And when I do 6658490257*4096=27273176092672
> I get an error.
> $ btrfs-map-logical -l 27273176092672 /dev/sda3
> ERROR: failed to find any extent at [27273176092672,27273176109056)
> 
> 
> 
> 

I just found a way to dump one corrupt block and to compare it the same 
block on the good file_B.mp4
I just did 3409178460160-31449088+31494144 = 3409178505216 (it's a pity 
that all the info are not in the same place, the first two numbers are 
in the scrub result and the other is in the error log with the bad 
checksum info when we try to read the corrupt file)
I then run that to dump the corrupted block
$ btrfs-map-logical -l 3409178505216 -o 31494144.bin -b 4096 /dev/sda3$

and when I compare it the good file, the blocks are the same until the 
3585 byte when random (no bit flip) and zeroed bytes are mixed until the 
end of the block.

cmp -lb 31494144-bad.bin 31494144-good.bin
3585  50 (    255 M--
3586 163 s    356 M-n
3587  52 *    167 w
3588 301 M-A  107 G
3589  37 ^_    46 &
3590 370 M-x   35 ^]
3591 322 M-R  316 M-N
3592  21 ^Q   155 m
3593 272 M-:   46 &
3594 113 K    240 M-
3595   0 ^@   357 M-o
3596 240 M-    23 ^S
3597 311 M-I   70 8
3598  76 >    314 M-L
3599 311 M-I  326 M-V
3600  73 ;    104 D
3601 240 M-   114 L
3602 364 M-t  370 M-x
3603  73 ;    151 i
3604 240 M-    35 ^]
3605 166 v    137 _
3606 316 M-N  133 [
3607  50 (    326 M-V
3608 115 M    263 M-3
3609 220 M-^P 276 M->
3611  40      207 M-^G
3612 337 M-_  365 M-u
3613 334 M-\  223 M-^S
3614 211 M-^I  16 ^N
3615 113 K     72 :
3616 333 M-[  133 [
3617   0 ^@   172 z
3618  10 ^H   152 j
3619   0 ^@   222 M-^R
3620   0 ^@    24 ^T
3621   0 ^@   176 ~
3622   0 ^@    54 ,
3623   0 ^@   210 M-^H
3624   0 ^@   273 M-;
3625 377 M-^?  33 ^[
3626 237 M-^_ 223 M-^S
3627   7 ^G   233 M-^[
3628   0 ^@   151 i
3629   0 ^@    63 3
3630   0 ^@   301 M-A
3631   0 ^@   142 b
3632   0 ^@   306 M-F
3633   0 ^@   262 M-2
3634   0 ^@   147 g
3635   0 ^@   344 M-d
3636   0 ^@   362 M-r
3637   0 ^@    60 0
3638   0 ^@    75 =
3639   0 ^@   353 M-k
3640   0 ^@   140 `
3641   0 ^@   343 M-c
3642   0 ^@    24 ^T
3643   0 ^@   157 o
3644   0 ^@    46 &
3645   0 ^@   134 \
3646   0 ^@   314 M-L
3647   0 ^@   241 M-!
3648   0 ^@   337 M-_
3649   0 ^@     3 ^C
3650   0 ^@   345 M-e
3651   0 ^@   305 M-E
3652   0 ^@    66 6
3653   0 ^@   256 M-.
3654   0 ^@    36 ^^
3655   0 ^@   111 I
3656   0 ^@    17 ^O
3657   0 ^@    41 !
3658   0 ^@    24 ^T
3659   0 ^@    17 ^O
3660   0 ^@   314 M-L
3661   0 ^@   114 L
3662   0 ^@   330 M-X
3663   0 ^@    57 /
3664   0 ^@   377 M-^?
3665   0 ^@   366 M-v
3666   0 ^@   133 [
3667   0 ^@   143 c
3668   0 ^@   154 l
3669   0 ^@   304 M-D
3670   0 ^@   107 G
3671   0 ^@    36 ^^
3672   0 ^@   175 }
3673   0 ^@    21 ^Q
3674   0 ^@    41 !
3675   0 ^@   306 M-F
3676   0 ^@   133 [
3677   0 ^@   162 r
3678   0 ^@    67 7
3679   0 ^@    76 >
3680   0 ^@   275 M-=
3681   0 ^@   247 M-'
3682   0 ^@   331 M-Y
3683   0 ^@    14 ^L
3684   0 ^@   266 M-6
3685   0 ^@   337 M-_
3686   0 ^@   247 M-'
3687   0 ^@   263 M-3
3688   0 ^@   363 M-s
3689   0 ^@   234 M-^\
3690   0 ^@    72 :
3691   0 ^@    11 ^I
3692   0 ^@   314 M-L
3693   0 ^@   307 M-G
3694   0 ^@   144 d
3695   0 ^@     6 ^F
3696   0 ^@    62 2
3697   0 ^@   145 e
3698   0 ^@   207 M-^G
3699   0 ^@    44 $
3700   0 ^@    34 ^\
3701   0 ^@   372 M-z
3702   0 ^@   233 M-^[
3703   0 ^@    77 ?
3704   0 ^@   143 c
3705   0 ^@   240 M-
3706   0 ^@   227 M-^W
3707   0 ^@    64 4
3708   0 ^@   217 M-^O
3709   0 ^@   152 j
3710   0 ^@   225 M-^U
3711   0 ^@    35 ^]
3712   0 ^@   222 M-^R
3713 155 m    245 M-%
3714 375 M-}  232 M-^Z
3715 127 W    354 M-l
3716   6 ^F   214 M-^L
3717 253 M-+  231 M-^Y
3718 244 M-$    1 ^A
3719 304 M-D   55 -
3720 103 C      7 ^G
3721 204 M-^D 343 M-c
3722 345 M-e   17 ^O
3723  11 ^I   116 N
3724  63 3    153 k
3725 310 M-H   65 5
3726 113 K    211 M-^I
3727 117 O    331 M-Y
3728 117 O    111 I
3729  37 ^_   144 d
3730  23 ^S   323 M-S
3731   6 ^F    44 $
3732  21 ^Q   271 M-9
3733 327 M-W   17 ^O
3734  47 '    321 M-Q
3735   4 ^D     3 ^C
3736 105 E    223 M-^S
3737 236 M-^^ 112 J
3738 336 M-^   74 <
3739  21 ^Q    42 "
3740 104 D    163 s
3741 260 M-0   47 '
3742 232 M-^Z 157 o
3743 310 M-H  146 f
3744 373 M-{  154 l
3745   0 ^@   123 S
3746 240 M-   164 t
3747   7 ^G   250 M-(
3748   0 ^@   346 M-f
3749   0 ^@    11 ^I
3750   0 ^@   234 M-^\
3751   0 ^@   370 M-x
3752   0 ^@   122 R
3753 377 M-^? 203 M-^C
3754 167 w     60 0
3755 344 M-d  102 B
3756   1 ^A   162 r
3757   0 ^@   212 M-^J
3758   0 ^@    41 !
3759   0 ^@    33 ^[
3760   0 ^@    67 7
3761   0 ^@     7 ^G
3762   0 ^@   347 M-g
3763   0 ^@    34 ^\
3764   0 ^@   121 Q
3765   0 ^@   231 M-^Y
3766   0 ^@   326 M-V
3767   0 ^@   366 M-v
3768   0 ^@   100 @
3769   0 ^@   223 M-^S
3770   0 ^@   341 M-a
3771   0 ^@   223 M-^S
3772   0 ^@     1 ^A
3773   0 ^@   256 M-.
3774   0 ^@   155 m
3775   0 ^@    62 2
3776   0 ^@    41 !
3777   0 ^@   205 M-^E
3778   0 ^@   103 C
3779   0 ^@   326 M-V
3780   0 ^@   215 M-^M
3781   0 ^@   354 M-l
3782   0 ^@   141 a
3783   0 ^@    72 :
3784   0 ^@    21 ^Q
3785   0 ^@   213 M-^K
3786   0 ^@   155 m
3787   0 ^@   313 M-K
3788   0 ^@    10 ^H
3789   0 ^@   102 B
3790   0 ^@   355 M-m
3791   0 ^@   205 M-^E
3792   0 ^@   273 M-;
3793   0 ^@   245 M-%
3794   0 ^@   300 M-@
3795   0 ^@    67 7
3796   0 ^@   126 V
3797   0 ^@   206 M-^F
3798   0 ^@   327 M-W
3799   0 ^@   272 M-:
3800   0 ^@   142 b
3801   0 ^@   313 M-K
3802   0 ^@   317 M-O
3803   0 ^@   126 V
3804   0 ^@   322 M-R
3805   0 ^@   245 M-%
3806   0 ^@    61 1
3807   0 ^@    30 ^X
3808   0 ^@   110 H
3809   0 ^@    55 -
3810   0 ^@   124 T
3811   0 ^@   130 X
3812   0 ^@   375 M-}
3813   0 ^@    32 ^Z
3814   0 ^@   153 k
3815   0 ^@   275 M-=
3816   0 ^@   343 M-c
3817   0 ^@    20 ^P
3818   0 ^@    30 ^X
3819   0 ^@   135 ]
3820   0 ^@   150 h
3821   0 ^@   266 M-6
3822   0 ^@   346 M-f
3823   0 ^@   135 ]
3824   0 ^@   164 t
3825   0 ^@   337 M-_
3826   0 ^@   247 M-'
3827   0 ^@    43 #
3828   0 ^@   354 M-l
3829   0 ^@   126 V
3830   0 ^@   103 C
3831   0 ^@   256 M-.
3832   0 ^@   114 L
3833   0 ^@   143 c
3834   0 ^@   373 M-{
3835   0 ^@    61 1
3836   0 ^@    76 >
3837   0 ^@   303 M-C
3838   0 ^@   167 w
3839   0 ^@   307 M-G
3840   0 ^@   243 M-#
3841 257 M-/  365 M-u
3842  75 =    326 M-V
3843 306 M-F  242 M-"
3844  17 ^O     1 ^A
3845 203 M-^C 232 M-^Z
3846 204 M-^D 153 k
3847 162 r    325 M-U
3848 107 G    336 M-^
3849 216 M-^N 242 M-"
3850 171 y     46 &
3851  75 =     56 .
3852 151 i    244 M-$
3853 330 M-X  115 M
3855 175 }    370 M-x
3856 344 M-d   35 ^]
3857 154 l    111 I
3858 114 L     45 %
3859 162 r    324 M-T
3860 206 M-^F  77 ?
3861 115 M    277 M-?
3862 323 M-S  207 M-^G
3863   1 ^A   277 M-?
3864 111 I    355 M-m
3865 246 M-&   43 #
3866 144 d     13 ^K
3867 147 g    320 M-P
3868 377 M-^?  27 ^W
3869 323 M-S   22 ^R
3870 264 M-4   44 $
3871 246 M-&   24 ^T
3872  47 '    274 M-<
3873   0 ^@    12 ^J
3874 170 x    155 m
3875 344 M-d  201 M-^A
3876   1 ^A   227 M-^W
3877   0 ^@   124 T
3878   0 ^@   262 M-2
3879   0 ^@   215 M-^M
3880   0 ^@   253 M-+
3881 377 M-^? 260 M-0
3882  37 ^_   176 ~
3883 245 M-%  175 }
3884 106 F    270 M-8
3885   7 ^G   171 y
3886   0 ^@   224 M-^T
3887   0 ^@   225 M-^U
3888   0 ^@   105 E
3889   0 ^@   335 M-]
3890   0 ^@   364 M-t
3891   0 ^@   362 M-r
3892   0 ^@   207 M-^G
3893   0 ^@   274 M-<
3894   0 ^@    55 -
3895   0 ^@   311 M-I
3896   0 ^@    24 ^T
3897   0 ^@   310 M-H
3898   0 ^@    64 4
3899   0 ^@   155 m
3900   0 ^@   276 M->
3901   0 ^@   334 M-\
3902   0 ^@   270 M-8
3903   0 ^@   223 M-^S
3904   0 ^@    44 $
3905   0 ^@    16 ^N
3906   0 ^@   120 P
3907   0 ^@    47 '
3908   0 ^@    30 ^X
3909   0 ^@   122 R
3910   0 ^@    44 $
3911   0 ^@   336 M-^
3912   0 ^@   234 M-^\
3913   0 ^@   203 M-^C
3914   0 ^@   146 f
3915   0 ^@   274 M-<
3916   0 ^@   264 M-4
3917   0 ^@   174 |
3918   0 ^@   167 w
3919   0 ^@    37 ^_
3920   0 ^@   126 V
3921   0 ^@   262 M-2
3922   0 ^@     2 ^B
3923   0 ^@     4 ^D
3924   0 ^@   131 Y
3925   0 ^@   306 M-F
3926   0 ^@   144 d
3927   0 ^@   215 M-^M
3928   0 ^@   364 M-t
3929   0 ^@   175 }
3930   0 ^@    20 ^P
3931   0 ^@   272 M-:
3932   0 ^@   251 M-)
3933   0 ^@   112 J
3934   0 ^@    41 !
3935   0 ^@   217 M-^O
3936   0 ^@   131 Y
3937   0 ^@   135 ]
3938   0 ^@   275 M-=
3939   0 ^@   203 M-^C
3940   0 ^@   364 M-t
3941   0 ^@   246 M-&
3942   0 ^@   236 M-^^
3943   0 ^@   172 z
3944   0 ^@    37 ^_
3945   0 ^@   254 M-,
3946   0 ^@   277 M-?
3947   0 ^@   126 V
3948   0 ^@   313 M-K
3949   0 ^@   366 M-v
3950   0 ^@    55 -
3951   0 ^@   230 M-^X
3952   0 ^@   301 M-A
3953   0 ^@   252 M-*
3954   0 ^@   144 d
3955   0 ^@   377 M-^?
3956   0 ^@    41 !
3957   0 ^@   266 M-6
3958   0 ^@   223 M-^S
3959   0 ^@   212 M-^J
3960   0 ^@   376 M-~
3961   0 ^@   261 M-1
3962   0 ^@    27 ^W
3963   0 ^@    20 ^P
3964   0 ^@   364 M-t
3965   0 ^@   153 k
3966   0 ^@    55 -
3967   0 ^@   137 _
3968   0 ^@   353 M-k
3969   0 ^@   225 M-^U
3970   0 ^@   372 M-z
3971   0 ^@    55 -
3972   0 ^@   260 M-0
3973   0 ^@   201 M-^A
3974   0 ^@   163 s
3975   0 ^@   137 _
3976   0 ^@    16 ^N
3977   0 ^@   322 M-R
3978   0 ^@    71 9
3979   0 ^@   223 M-^S
3980   0 ^@   212 M-^J
3981   0 ^@   162 r
3982   0 ^@   116 N
3983   0 ^@   236 M-^^
3984   0 ^@   237 M-^_
3985   0 ^@   364 M-t
3986   0 ^@   163 s
3987   0 ^@    11 ^I
3988   0 ^@   263 M-3
3989   0 ^@   115 M
3990   0 ^@    77 ?
3991   0 ^@    32 ^Z
3992   0 ^@   125 U
3993   0 ^@   257 M-/
3994   0 ^@   307 M-G
3995   0 ^@    41 !
3996   0 ^@    22 ^R
3997   0 ^@    67 7
3998   0 ^@    36 ^^
3999   0 ^@   173 {
4000   0 ^@    77 ?
4001   0 ^@   161 q
4002   0 ^@   272 M-:
4003   0 ^@   264 M-4
4004   0 ^@   101 A
4005   0 ^@   277 M-?
4006   0 ^@   143 c
4007   0 ^@   275 M-=
4008   0 ^@    41 !
4009   0 ^@   366 M-v
4010   0 ^@   174 |
4011   0 ^@   214 M-^L
4012   0 ^@   317 M-O
4013   0 ^@    52 *
4014   0 ^@   371 M-y
4015   0 ^@   163 s
4016   0 ^@   157 o
4017   0 ^@    57 /
4018   0 ^@   302 M-B
4019   0 ^@   271 M-9
4020   0 ^@   133 [
4021   0 ^@   251 M-)
4022   0 ^@   160 p
4023   0 ^@   271 M-9
4024   0 ^@   240 M-
4025   0 ^@   125 U
4026   0 ^@   327 M-W
4027   0 ^@    32 ^Z
4028   0 ^@    32 ^Z
4029   0 ^@   162 r
4030   0 ^@   245 M-%
4031   0 ^@   371 M-y
4032   0 ^@   315 M-M
4033   0 ^@   331 M-Y
4034   0 ^@    12 ^J
4035   0 ^@   220 M-^P
4036   0 ^@   147 g
4037   0 ^@   262 M-2
4038   0 ^@   133 [
4039   0 ^@   331 M-Y
4040   0 ^@   340 M-`
4041   0 ^@   311 M-I
4042   0 ^@   131 Y
4043   0 ^@   316 M-N
4044   0 ^@   155 m
4045   0 ^@   360 M-p
4046   0 ^@   123 S
4047   0 ^@   227 M-^W
4048   0 ^@   174 |
4049   0 ^@   153 k
4050   0 ^@   116 N
4051   0 ^@    47 '
4052   0 ^@   340 M-`
4053   0 ^@   250 M-(
4054   0 ^@   346 M-f
4055   0 ^@   275 M-=
4056   0 ^@   376 M-~
4057   0 ^@    63 3
4058   0 ^@   253 M-+
4059   0 ^@   231 M-^Y
4060   0 ^@   113 K
4061   0 ^@    17 ^O
4062   0 ^@   323 M-S
4063   0 ^@   274 M-<
4064   0 ^@   114 L
4065   0 ^@   356 M-n
4066   0 ^@   162 r
4067   0 ^@    55 -
4068   0 ^@   342 M-b
4069   0 ^@   351 M-i
4070   0 ^@   104 D
4071   0 ^@   205 M-^E
4072   0 ^@   271 M-9
4073   0 ^@   270 M-8
4074   0 ^@   261 M-1
4075   0 ^@   375 M-}
4076   0 ^@   376 M-~
4077   0 ^@   201 M-^A
4078   0 ^@   207 M-^G
4079   0 ^@   266 M-6
4080   0 ^@   115 M
4081   0 ^@   350 M-h
4082   0 ^@   355 M-m
4083   0 ^@   201 M-^A
4084   0 ^@   103 C
4085   0 ^@   270 M-8
4086   0 ^@   332 M-Z
4087   0 ^@   325 M-U
4088   0 ^@   167 w
4089   0 ^@   261 M-1
4090   0 ^@   175 }
4091   0 ^@    64 4
4092   0 ^@   100 @
4093   0 ^@   210 M-^H
4094   0 ^@   104 D
4095   0 ^@   160 p
4096   0 ^@   155 m

To me it look like the remnants of data that were before in this block.


