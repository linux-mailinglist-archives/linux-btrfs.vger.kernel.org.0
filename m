Return-Path: <linux-btrfs+bounces-21851-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MdmCk3InGkwKQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21851-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 22:36:13 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF9717D9F2
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 22:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D8FC3073F6D
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 21:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CE3378D93;
	Mon, 23 Feb 2026 21:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HEi3My4o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7166361654
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Feb 2026 21:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771882564; cv=none; b=syOSGLHrEWMrqq89jsAk3pxUj9RZaSh5PpQO94jKaBt6M0ZehGgFq0r7zM8IBGXO4yF1OYBrM9EXv6xusQf2K66eJ0/Pl5rJsGO7oMPrxPgigH8mg2eGzL3VAiN/7GyZTuMdHn79hr/csNONCeoeyqZsSsrA6y029z9/mthgfyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771882564; c=relaxed/simple;
	bh=LDBchX5PYmKdxQClG+R4sN5orz/iaXqV54sTC0DrPrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tQAdhcADZSzkfVxwxBK1c5ShzdS1ecAmJl3QZhibc173njAwV9NTO5Wtgpn9m6CERy92tWLCQFFSd2LG8eq7WJuPaAjkvpjQ4rQZ12LsJGP36t8Inw+bVFPMkMCE7W2sfj7nTlIoIixEHf6YcjKpMNl153EWro31+/Wp8vEQS4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HEi3My4o; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48375f1defeso33959845e9.0
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Feb 2026 13:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771882561; x=1772487361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rz/Cm5Np5EDzyjh59ifpNpC1iYoQiucpqM3inqKa8Mc=;
        b=HEi3My4oK/V6OHM3USaJjX+vIt4Tg8O73W+j1uUx02aCWov+feFZFDZSbND/XPOqxg
         38CTvdkd9fPn2/5CnfGnH45iU+S8OrdmTS8sEb/UUXYtQie0r0X6RgBwY/HR8nGTGyIv
         61gAVF4atcEupYIMfMg0zNG5dW4MY6+DFaQv1zkWbTufXyt6bqyiyoybohYr991nRtsn
         uPQ3/5HunxTxYoDpAUjHDDzexdL5V2lf9Y14TQx+QM2IzFSflStx/yn92RKTvrd0wCbO
         o8DLiI4M91ndzAs8RDHAB/Q5pIx6Kbf0aOubHrdKPgzkVneQbCveU1cL0LZEtYqg7Tio
         HT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771882561; x=1772487361;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rz/Cm5Np5EDzyjh59ifpNpC1iYoQiucpqM3inqKa8Mc=;
        b=U2fCNKkBWqKeSLRUZ0y5ZB8u+u2nVov5+umaPeyofVbkVKeXjnuq6O/cEyHGjpgTaT
         cKFF3Rdp0R+JHmcv6nk7G8jWEml69X05gyuX9pFaYDVjNgfDYfTxmwIYdz2bx33WSQVP
         y9fAnBQHdD9puZSJh5rrXc3aQaxcluS/huqlHK6/a374LgCN3TxjhJyVrT4XamWd6zin
         Aa2Oj0QhEeFI//Fx4gFMLtBx+JXu/8+AAGUca41sa7gcY8wtcZ9u6JfgG/7pS2zab4Lq
         cjamW1SJNQSQu5g4pMiA2RfjffBkfB9RswkrPe3QM2VdKBSGggDh91qcbXMN/GdgYCxU
         q0NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXLa7OORap7+Q5gB+uAZgN+jr7VoH39KD3YHdY+G8pZqnVwjm7M9X3rYd9U7YOrr7sXQPnWu/bv0GVkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2iDiPHhwyuH15RVOrS5hZt6FYuFkaeVce5X5j92nbo6Gc3MGf
	pmuQOyOvhACURf6MqVpQPsfAWNoxnDc3JDjJOhYzbI4TewCeoXHcriMT2QyDAPYrU/5E4SmoJpA
	XyDYyS6E=
X-Gm-Gg: AZuq6aI99xUvyYdF+tidJKAiHdoTyHX4G4h10LlljqqSzbiizQTDW3SwWiFLEGWcJdt
	O0w/lOS65tiJuZlmgx5XX+B5mrNfKuo2ujMXlJMVrXIP3cnYVhNwfmFPBOuCt5cT6ew9BX50Pv8
	LLo5cQesXPJkN5JzIWz8ORmslsWs1IjNcK3fmyXywmgj5shrN/tzqKRZcKwRA4SlJRVnWmMgHxa
	NF4XZrjsNHU4jMh++wOztvr/Jtosrlp4uTEq8wSbu/tr+vJVy1aaTIH9cF62/34BW/mp9tjjUUL
	UzunKVGiHzs5Y8ZzmZJ0/OY5frrHBEU6XUnvni+C1Au6VPqPI2xnhQQUBokXnkQzAypTOl8Swuv
	4kw/8kOMYZ5mkFB6421VLfcdwzm8WvFfF2wp3JmUy5aCanw3oBMw8l7m2qHWjAEuT/AoEPauVNq
	PuCFs+kqPaw3UFhk2+2w0Zi2tFV4SjPm+l0h+yr1G/hX1r6crNJEs=
X-Received: by 2002:a05:600c:8109:b0:483:8e43:6dce with SMTP id 5b1f17b1804b1-483a963a003mr156063475e9.29.1771882560871;
        Mon, 23 Feb 2026 13:36:00 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-358af701af7sm9342428a91.4.2026.02.23.13.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 13:36:00 -0800 (PST)
Message-ID: <51597107-5a23-4f15-9481-b4d58e18bbe1@suse.com>
Date: Tue, 24 Feb 2026 08:05:54 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Stuck on a BTRFS problem
To: Phako <phako@free.fr>, linux-btrfs@vger.kernel.org
References: <77535c20-da3e-4dfb-b3d7-9426c25b5da3@free.fr>
 <0211658c-8d28-46d1-8e41-21dc02cab276@suse.com>
 <b1c1247f-df00-4045-a508-fb9a5666114a@free.fr>
 <cb183999-6a95-456a-80f4-f703da298d74@suse.com>
 <deb56ee2-b5d6-4beb-9554-05da125dde54@free.fr>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <deb56ee2-b5d6-4beb-9554-05da125dde54@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21851-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[free.fr,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: 7EF9717D9F2
X-Rspamd-Action: no action



在 2026/2/24 02:11, Phako 写道:
> Le 23/02/2026 à 08:32, Qu Wenruo a écrit :
[...]
> 
> I get that you might think this issue is not BTRFS related, but I'm 
> still not 100% sure of what is the cause of the error. So I'm still 
> having a couple of questions to rule out wrong hypothesis or direct me 
> on the right track:
> 
> Do you think that if I copy a good copy of file_B.mp4 over the corrupt 
> file_B.mp4 (eg: cat b.mp4 > b_corrupt.mp4) it will overwrite the 
> metadata and the same physical LBAs?

The metadata is not involved. It's fully the data part (and its checksum).

And unfortunately, a full over-write doesn't not guarantee the new data 
will be written into the same the location.

> Are there any btrfs commands I could run before and/or after to check if 
> it worked, and to map this reported corrupt logical blocks with actual 
> LBAs?

But if you have the correct original file, you can try to manually 
over-write the data, using "btrfs-map-logical" command to calculate the 
on-disk physical LBA, then using whatever tool (dd for example) to 
directly write the content into that physical address.

Using your previous scrub dmesg as an example:

 > Feb 09 16:18:02 soleil kernel: BTRFS warning (device sda3): csum failed
 > root 257 ino 40442 off 46100480 csum 0xc9e01f9a expected csum 0xb20f9f0e
 > mirror 1


The first line of "csum failed" shows exactly where the corruption is in 
the file (subvolume 257, inode number 40442, file offset 46100480).

Then you can use fiemap to map the file offset to the btrfs logical address:

  $ xfs_io -c "fiemap 46100480 4096" <path_to_the_file>

It would show something like this (just an example, not matching your 
output):

Filesystem type is: 9123683e
File size of /mnt/btrfs/foobar is 1048576 (256 blocks of 4096 bytes)
  ext:     logical_offset:        physical_offset: length:   expected: 
flags:
    0:        0..     255:       3328..      3583:    256: 
last,eof
/mnt/btrfs/foobar: 1 extent found

The "logical_offset" part is the offset inside the file, the 
"physical_offset" is the logical address inside btrfs.
The unit is a block (4096 bytes shown after the filesystem type line).

The range should cover your 46100480 file offset.

You need to grab the btrfs logical address by converting the number.

Then with the logical bytenr, you can convert it to the physical address 
by using "btrfs-map-logical"

  $ btrfs-map-logical -l <logical> <device>

It will output something like this:

  $ btrfs-map-logical -l 13635584 test.img
  mirror 1 logical 13631488 physical 13635584 device test.img

The number 13631488 is 3329 * 4096, corresponding to the file offset 4K 
of my previous example.


The resulted physical bytenr and device is where you should write the 
data into.


This can be very complex, so please paste the output of "$ xfs_io -c 
"fiemap 46100480 4096" <path_to_the_file>" first, then we can figure the 
exact command to use in the next step.

Considering how complex and how much manual work there is, I will add a 
new btrfs-inspect subcommand to do all the resolving in the future.

Thanks,
Qu

> 
> To be 100% sure that there is no read error, I would like to read 
> directly the LBA concerned, I'm wrong when I think that the physical 
> address reported by the scrub is in bytes and can be read by a command 
> of the like "dd if=/dev/sda3 skip=(physical/block-size) ... " ?
> 
> And for your information (maybe you will see something I can't) here the 
> log of the csum error I got with the corrupt old and new files when I 
> opened them where we can see that several blocks have the same bad 
> checksum on both files (0x8941f998), I tend to interpret this as an 
> evidence of a hardware problem (blocks with the same erroneous pattern, 
> maybe all zero or all one, I don't know how to check that), but I'm not 
> sure either if that could be the result of the direct I/O bug discussed 
> above.
> 
> file A
> Feb 09 16:18:02 soleil kernel: BTRFS warning (device sda3): csum failed 
> root 257 ino 40442 off 46100480 csum 0xc9e01f9a expected csum 0xb20f9f0e 
> mirror 1
> Feb 09 16:18:02 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
> errs: wr 0, rd 0, flush 0, corrupt 6, gen 0
> Feb 09 16:18:02 soleil kernel: BTRFS warning (device sda3): csum failed 
> root 257 ino 40442 off 46104576 csum 0x8941f998 expected csum 0xab595bcc 
> mirror 1
> Feb 09 16:18:02 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
> errs: wr 0, rd 0, flush 0, corrupt 7, gen 0
> Feb 09 16:18:02 soleil kernel: BTRFS warning (device sda3): csum failed 
> root 257 ino 40442 off 46108672 csum 0x8941f998 expected csum 0x1486c38f 
> mirror 1
> Feb 09 16:18:02 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
> errs: wr 0, rd 0, flush 0, corrupt 8, gen 0
> Feb 09 16:18:02 soleil kernel: BTRFS warning (device sda3): csum failed 
> root 257 ino 40442 off 46112768 csum 0x8941f998 expected csum 0xc28892df 
> mirror 1
> Feb 09 16:18:02 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
> errs: wr 0, rd 0, flush 0, corrupt 9, gen 0
> Feb 09 16:18:02 soleil kernel: BTRFS warning (device sda3): csum failed 
> root 257 ino 40442 off 46116864 csum 0xf43cb1df expected csum 0xb62dc162 
> mirror 1
> Feb 09 16:18:02 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
> errs: wr 0, rd 0, flush 0, corrupt 10, gen 0
> Feb 09 16:18:02 soleil kernel: BTRFS warning (device sda3): csum failed 
> root 257 ino 40442 off 46100480 csum 0xc9e01f9a expected csum 0xb20f9f0e 
> mirror 1
> Feb 09 16:18:02 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
> errs: wr 0, rd 0, flush 0, corrupt 11, gen 0
> Feb 09 16:18:02 soleil kernel: BTRFS warning (device sda3): csum failed 
> root 257 ino 40442 off 46100480 csum 0xc9e01f9a expected csum 0xb20f9f0e 
> mirror 1
> Feb 09 16:18:02 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
> errs: wr 0, rd 0, flush 0, corrupt 12, gen 0
> Feb 09 16:18:02 soleil kernel: BTRFS warning (device sda3): csum failed 
> root 257 ino 40442 off 46100480 csum 0xc9e01f9a expected csum 0xb20f9f0e 
> mirror 1
> Feb 09 16:18:02 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
> errs: wr 0, rd 0, flush 0, corrupt 13, gen 0
> Feb 09 16:18:02 soleil kernel: BTRFS warning (device sda3): csum failed 
> root 257 ino 40442 off 46100480 csum 0xc9e01f9a expected csum 0xb20f9f0e 
> mirror 1
> Feb 09 16:18:02 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
> errs: wr 0, rd 0, flush 0, corrupt 14, gen 0
> Feb 09 16:18:02 soleil kernel: BTRFS warning (device sda3): csum failed 
> root 257 ino 40442 off 46100480 csum 0xc9e01f9a expected csum 0xb20f9f0e 
> mirror 1
> Feb 09 16:18:02 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
> errs: wr 0, rd 0, flush 0, corrupt 15, gen 0
> 
> 
> 
> file B
> Feb 22 06:45:48 soleil kernel: BTRFS warning (device sda3): csum failed 
> root 257 ino 230235 off 31494144 csum 0x6741cf10 expected csum 
> 0xca5f6f32 mirror 1
> Feb 22 06:45:48 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
> errs: wr 0, rd 0, flush 0, corrupt 46, gen 0
> Feb 22 06:45:48 soleil kernel: BTRFS warning (device sda3): csum failed 
> root 257 ino 230235 off 31498240 csum 0x8941f998 expected csum 
> 0xee146cb6 mirror 1
> Feb 22 06:45:48 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
> errs: wr 0, rd 0, flush 0, corrupt 47, gen 0
> Feb 22 06:45:48 soleil kernel: BTRFS warning (device sda3): csum failed 
> root 257 ino 230235 off 31502336 csum 0x8941f998 expected csum 
> 0x4dd93576 mirror 1
> Feb 22 06:45:48 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
> errs: wr 0, rd 0, flush 0, corrupt 48, gen 0
> Feb 22 06:45:48 soleil kernel: BTRFS warning (device sda3): csum failed 
> root 257 ino 230235 off 31506432 csum 0x8941f998 expected csum 
> 0x2876e5c4 mirror 1
> Feb 22 06:45:48 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
> errs: wr 0, rd 0, flush 0, corrupt 49, gen 0
> Feb 22 06:45:48 soleil kernel: BTRFS warning (device sda3): csum failed 
> root 257 ino 230235 off 31510528 csum 0xf43cb1df expected csum 
> 0xb6436c41 mirror 1
> Feb 22 06:45:48 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
> errs: wr 0, rd 0, flush 0, corrupt 50, gen 0
> Feb 22 06:45:48 soleil kernel: BTRFS warning (device sda3): csum failed 
> root 257 ino 230235 off 31494144 csum 0x6741cf10 expected csum 
> 0xca5f6f32 mirror 1
> Feb 22 06:45:48 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
> errs: wr 0, rd 0, flush 0, corrupt 51, gen 0
> Feb 22 06:45:48 soleil kernel: BTRFS warning (device sda3): csum failed 
> root 257 ino 230235 off 31494144 csum 0x6741cf10 expected csum 
> 0xca5f6f32 mirror 1
> Feb 22 06:45:48 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
> errs: wr 0, rd 0, flush 0, corrupt 52, gen 0
> Feb 22 06:45:48 soleil kernel: BTRFS warning (device sda3): csum failed 
> root 257 ino 230235 off 31494144 csum 0x6741cf10 expected csum 
> 0xca5f6f32 mirror 1
> Feb 22 06:45:48 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
> errs: wr 0, rd 0, flush 0, corrupt 53, gen 0
> Feb 22 06:45:48 soleil kernel: BTRFS warning (device sda3): csum failed 
> root 257 ino 230235 off 31494144 csum 0x6741cf10 expected csum 
> 0xca5f6f32 mirror 1
> Feb 22 06:45:48 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
> errs: wr 0, rd 0, flush 0, corrupt 54, gen 0
> Feb 22 06:45:48 soleil kernel: BTRFS warning (device sda3): csum failed 
> root 257 ino 230235 off 31494144 csum 0x6741cf10 expected csum 
> 0xca5f6f32 mirror 1
> Feb 22 06:45:48 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
> errs: wr 0, rd 0, flush 0, corrupt 55, gen 0
> 
> 
> Meanwhile, I'm gonna run a memtest, because I've no idea what else to do.
> 
> Thank in advance.
> 


