Return-Path: <linux-btrfs+bounces-21690-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id RQxjGuN5k2nV5gEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21690-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 21:11:15 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC8E147605
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 21:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E504302B3B3
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 20:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0546D2E7F1D;
	Mon, 16 Feb 2026 20:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phys.ethz.ch header.i=@phys.ethz.ch header.b="EBEZJSBE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from phd-imap.ethz.ch (phd-imap.ethz.ch [129.132.80.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057ED28D8DB
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Feb 2026 20:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.132.80.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771272664; cv=none; b=sou2Y36a9uVMAWCRQAN0jMulU7sCs63vVcLDElria/nBvJHBvNyVbMYbLYVTtsm5gzByAS8NDa5GcYsqCV3cNb4t2+mggE9UJOWKDT+Sssn0kRCiDFhUZQOgZPRRFwcAoAT+6twrnRRcHVaTU1+9Gyn3qp+T3i2PuaoNSF2J/cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771272664; c=relaxed/simple;
	bh=wUw3Zx2cR7GlBWbCSUO6H6o5djWUkbuvibf6Te2eQpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sJqxpwlvQgNvZ/Wk0QGdvvQT0ZjkuoxTw8zfF7Ut2MNkOn22VDIdxivQFm+ZqGRn+xxZ2IHCLPlZmlR3+5CRzQy065uw/ntha7jgDCwXuNQafgz7iw6tuFOI+33U1IOc/smQnbcyKW8YYfJUMU9AbToWyOpbghtCf4nmJ5YRaXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phys.ethz.ch; spf=pass smtp.mailfrom=phys.ethz.ch; dkim=pass (2048-bit key) header.d=phys.ethz.ch header.i=@phys.ethz.ch header.b=EBEZJSBE; arc=none smtp.client-ip=129.132.80.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phys.ethz.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phys.ethz.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phys.ethz.ch;
	s=2023; t=1771272653;
	bh=rXPWQuD1FvmccfzNCsSqoOM0sMp5qc55bzBKxarK+vA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=EBEZJSBEqEGF8zI1Z8obPJh6ihj2KCF80wRD+QWStI+J260UE4BJJpVEAa/vnAilb
	 n9UyTRFVomzyN1UqxJCNXjlg9GHZcf2ECmc3Vv3PjNtCirS6X6dNGBBb7Ve2hVvhn4
	 g+HAi6uJ+W3Y4euyMj9sfLXrEVRUjNY4FqWcHe5gF8HI7PHgavIDhZnZ/IEZioxn3c
	 hhLWadTw+Tcq6CA9hMvCpk71KWzhxo9o3XJlxCSwiePf4mcZr5AN/nOW5YlYYhMa4L
	 Ily8fkXY9RCpFVdJyejGKDnbl3DeG/medkGZoR1a5qT2ViqyEAGWlqE4QBPkYn5SFq
	 CVMye1rNJTk6A==
Received: from localhost (192-168-127-49.net4.ethz.ch [192.168.127.49])
	by phd-imap.ethz.ch (Postfix) with ESMTP id 4fFDRd0zWXzBv
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Feb 2026 21:10:53 +0100 (CET)
X-Virus-Scanned: Debian amavis at phys.ethz.ch
Received: from phd-mxin.ethz.ch ([192.168.127.53])
 by localhost (phd-mailscan.ethz.ch [192.168.127.49]) (amavis, port 10024)
 with LMTP id B_XJc9p4F1WW for <linux-btrfs@vger.kernel.org>;
 Mon, 16 Feb 2026 21:10:53 +0100 (CET)
Received: from [192.168.1.225] (212-51-151-34.fiber7.init7.net [212.51.151.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stepmueller@phd-mxin.ethz.ch)
	by phd-mxin.ethz.ch (Postfix) with ESMTPSA id 4fFDRc6y8Rz9n
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Feb 2026 21:10:52 +0100 (CET)
Message-ID: <5d30494a-cce8-4d31-8c88-b49b50117cdd@phys.ethz.ch>
Date: Mon, 16 Feb 2026 21:10:52 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Lots of tiny writes without merging
To: linux-btrfs@vger.kernel.org
References: <8825adec963bc5dbf8c8c745289dab15@phys.ethz.ch>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Stephan_M=C3=BCller?= <stephan.mueller@phys.ethz.ch>
Organization: ETH Zurich
In-Reply-To: <8825adec963bc5dbf8c8c745289dab15@phys.ethz.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[phys.ethz.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[phys.ethz.ch:s=2023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[phys.ethz.ch:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21690-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FROM_NEQ_ENVFROM(0.00)[stephan.mueller@phys.ethz.ch,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: ACC8E147605
X-Rspamd-Action: no action

Am 10.02.26 um 16:43 schrieb Stephan Mueller:
> Hello
>
> I have an rsync writing a (new) large file to a btrfs, the rates are 
> pretty slow around 5MB/s. I know my 12 devices are not the fastest, 
> iscsi imported raid6 luns. But I am worried about something else.
>
> Starring at a btrace on the devices, I see a lot of tiny writes: 88 * 
> 512B = 44KB each.
> In my understanding, rsync fills the page cache quite fast and pid 
> 4126276 (kworker/u82:7+btrfs-delalloc) writes out the dirty pages. I 
> see writes to sectors 14023466344, 14023466432, 14023466520, ... all 
> are 88 sectors apart. The mq-deadline scheduler should be able to 
> merge all these requests, right? However the requests are separated by 
> plug and unplugs. I guess this makes them unmergable. Am I totally 
> misreading the btrace or does this sound reasonable. How can I 
> investigate this further?
>
> I think the think the 44K are compressed 128K blocks, does this make 
> sense? The file compresses (zstd:3) actually quite well, compsize 
> reports 40%.
>
> The System is a Debian with a 6.18.4 kernel and the mount options are 
> rw,noatime,compress=zstd:3,space_cache=v2,skip_balance,subvolid=5,subvol=/
>
> Bonus: the very first line, the complete event on a different cpu, is 
> probably just an btrace oddity. According to the time stamp it should 
> be together with the other completions. This pattern, 4 plug separated 
> writes + completions, repeats all the time. Sometimes the writes go up 
> to 120 instead of 88, though. Does any of this ring a bell for you?
>
> Bonus 2: Sometimes I do see some merges of 32 sector writes to a 
> larger request. I guess this is metadata, because it goes to devices 
> holding the metadata raid. So the scheduler and nomerges=0 are effective.
>
> Any pointers and help is welcome.
>
>   Have a nice day
>   Stephan
>
> btrace /dev/sdfk /dev/sdfc /dev/sdey /dev/sddj /dev/sddc /dev/sdcx 
> /dev/sdct /dev/sdcr /dev/sdci /dev/sdcg /dev/sdez /dev/sdeo
> [...]
> 129,176  6        2     2.536153684 4172873  C   W 14023466344 + 88 [0]
> 129,176  0        1     2.535593727 4126276  Q   W 14023466344 + 88 
> [kworker/u82:7] # queue an 44K write at sector 14023466344
> 129,176  0        2     2.535599088 4126276  G   W 14023466344 + 88 
> [kworker/u82:7]
> 129,176  0        3     2.535600754 4126276  P   N [kworker/u82:7]
> 129,176  0        4     2.535601170 4126276  U   N [kworker/u82:7] 1
> 129,176  0        5     2.535602068 4126276  I   W 14023466344 + 88 
> [kworker/u82:7]
> 129,176  0        6     2.535608586 4126276  D   W 14023466344 + 88 
> [kworker/u82:7]
> 129,176  0        7     2.535645786 4126276  Q   W 14023466432 + 88 
> [kworker/u82:7] # queue an 44K write at sector 14023466344 = 
> 14023466344 + 44K
> 129,176  0        8     2.535646590 4126276  G   W 14023466432 + 88 
> [kworker/u82:7]
> 129,176  0        9     2.535646766 4126276  P   N [kworker/u82:7]
> 129,176  0       10     2.535646882 4126276  U   N [kworker/u82:7] 1
> 129,176  0       11     2.535647112 4126276  I   W 14023466432 + 88 
> [kworker/u82:7]
> 129,176  0       12     2.535648715 4126276  D   W 14023466432 + 88 
> [kworker/u82:7]
> 129,176  0       13     2.535678884 4126276  Q   W 14023466520 + 88 
> [kworker/u82:7] # queue an 44K write at sector 14023466520 = 
> 14023466344 + 44K
> 129,176  0       14     2.535679583 4126276  G   W 14023466520 + 88 
> [kworker/u82:7]
> 129,176  0       15     2.535679718 4126276  P   N [kworker/u82:7]
> 129,176  0       16     2.535679922 4126276  U   N [kworker/u82:7] 1
> 129,176  0       17     2.535680163 4126276  I   W 14023466520 + 88 
> [kworker/u82:7]
> 129,176  0       18     2.535681631 4126276  D   W 14023466520 + 88 
> [kworker/u82:7]
> 129,176  0       19     2.535713385 4126276  Q   W 14023466608 + 88 
> [kworker/u82:7] # queue an 44K write at sector 14023466608 = 
> 14023466520 + 44K
> 129,176  0       20     2.535714105 4126276  G   W 14023466608 + 88 
> [kworker/u82:7]
> 129,176  0       21     2.535714420 4126276  P   N [kworker/u82:7]
> 129,176  0       22     2.535714653 4126276  U   N [kworker/u82:7] 1
> 129,176  0       23     2.535714781 4126276  I   W 14023466608 + 88 
> [kworker/u82:7]
> 129,176  0       24     2.535716200 4126276  D   W 14023466608 + 88 
> [kworker/u82:7]
> 129,176  0       25     2.536346556 4126276  C   W 14023466432 + 88 
> [0]             # write complete
> 129,176  0       26     2.536598810 4126276  C   W 14023466520 + 88 
> [0]             # write complete
> 129,176  0       27     2.536740142 4126276  C   W 14023466608 + 88 
> [0]             # write complete
> 129,176  0       28     2.579774641 4126276  Q   W 14023466696 + 80 
> [kworker/u82:7]
> 129,176  0       29     2.579778279 4126276  G   W 14023466696 + 80 
> [kworker/u82:7]
> 129,176  0       30     2.579780071 4126276  P   N [kworker/u82:7]
> 129,176  0       31     2.579780441 4126276  U   N [kworker/u82:7]  1
> 129,176  0       32     2.579781159 4126276  I   W 14023466696 + 80 
> [kworker/u82:7]
> 129,176  0       33     2.579786115 4126276  D   W 14023466696 + 80 
> [kworker/u82:7]
> 129,176  0       34     2.579825607 4126276  Q   W 14023466776 + 88 
> [kworker/u82:7]
> 129,176  0       35     2.579826206 4126276  G   W 14023466776 + 88 
> [kworker/u82:7]
> 129,176  0       36     2.579826401 4126276  P   N [kworker/u82:7]
> 129,176  0       37     2.579826471 4126276  U   N [kworker/u82:7] 1
> 129,176  0       38     2.579826578 4126276  I   W 14023466776 + 88 
> [kworker/u82:7]
> 129,176  0       39     2.579827737 4126276  D   W 14023466776 + 88 
> [kworker/u82:7]
> 129,176  0       40     2.579854059 4126276  Q   W 14023466864 + 88 
> [kworker/u82:7]
> 129,176  0       41     2.579854691 4126276  G   W 14023466864 + 88 
> [kworker/u82:7]
> 129,176  0       42     2.579854814 4126276  P   N [kworker/u82:7]
> 129,176  0       43     2.579855039 4126276  U   N [kworker/u82:7] 1
> 129,176  0       44     2.579855301 4126276  I   W 14023466864 + 88 
> [kworker/u82:7]
> 129,176  0       45     2.579856473 4126276  D   W 14023466864 + 88 
> [kworker/u82:7]
> 129,176  0       46     2.579882377 4126276  Q   W 14023466952 + 88 
> [kworker/u82:7]
> 129,176  0       47     2.579883069 4126276  G   W 14023466952 + 88 
> [kworker/u82:7]
> 129,176  0       48     2.579883373 4126276  P   N [kworker/u82:7] 

Everything seems to be compression related. A short time after I disable 
compression for the file in transfer, the write back is much faster. I 
then see individual IO operations each 1-2MB and moreover these are 
getting merged up to a single 4MB request, see below.

I think this is how things should be. However I am still puzzled how 
compression forces things to tiny unmerged writes.
Any thoughts are welcome.

   ~stephan

[...]
129,176 10     4994   114.508018684 1313277  Q   W 16192977184 + 2080 
[kworker/u82:15]
129,176 10     4995   114.508028502 1313277  G   W 16192977184 + 2080 
[kworker/u82:15]
129,176 10     4996   114.508031263 1313277  U   N [kworker/u82:15] 1
129,176 10     4997   114.508031764 1313277  I   W 16192970976 + 6208 
[kworker/u82:15]
129,176 10     4998   114.508087116 1313277  D   W 16192970976 + 6208 
[kworker/u82:15]
129,176 10     4999   114.508089425 1313277  P   N [kworker/u82:15]
129,176 10     5000   114.508924791 1313277  Q   W 16192979264 + 2056 
[kworker/u82:15]
129,176 10     5001   114.508933471 1313277  M   W 16192979264 + 2056 
[kworker/u82:15]
129,176 10     5002   114.509771882 1313277  Q   W 16192981320 + 2056 
[kworker/u82:15]
129,176 10     5003   114.509780756 1313277  M   W 16192981320 + 2056 
[kworker/u82:15]
129,176 10     5004   114.510622705 1313277  Q   W 16192983376 + 2048 
[kworker/u82:15]
129,176 10     5005   114.510632483 1313277  G   W 16192983376 + 2048 
[kworker/u82:15]
129,176 10     5006   114.510633151 1313277  U   N [kworker/u82:15] 1
129,176 10     5007   114.510633545 1313277  I   W 16192977184 + 6192 
[kworker/u82:15]
129,176 10     5008   114.510687514 1313277  D   W 16192977184 + 6192 
[kworker/u82:15]
129,176 10     5009   114.510689231 1313277  P   N [kworker/u82:15]
129,176 10     5010   114.511547227 1313277  Q   W 16192985424 + 2048 
[kworker/u82:15]
129,176 10     5011   114.511556095 1313277  M   W 16192985424 + 2048 
[kworker/u82:15]
129,176 10     5012   114.512386365 1313277  Q   W 16192987472 + 2048 
[kworker/u82:15]
129,176 10     5013   114.512392491 1313277  M   W 16192987472 + 2048 
[kworker/u82:15]
129,176 10     5014   114.513057530 1313277  Q   W 16192989520 + 2048 
[kworker/u82:15]
129,176 10     5015   114.513063756 1313277  M   W 16192989520 + 2048 
[kworker/u82:15]
129,176 10     5016   114.513729694 1313277  Q   W 16192991568 + 2048 
[kworker/u82:15]
129,176 10     5017   114.513737261 1313277  G   W 16192991568 + 2048 
[kworker/u82:15]
129,176 10     5018   114.513738697 1313277  U   N [kworker/u82:15] 1
129,176 10     5019   114.513739005 1313277  I   W 16192983376 + 8192 
[kworker/u82:15]
129,176 10     5020   114.513788724 1313277  D   W 16192983376 + 8192 
[kworker/u82:15]
129,176 10     5021   114.513789905 1313277  P   N [kworker/u82:15]
129,176 10     5022   114.514445239 1313277  Q   W 16192993616 + 2056 
[kworker/u82:15]
129,176 10     5023   114.514451541 1313277  M   W 16192993616 + 2056 
[kworker/u82:15]
129,176 10     5024   114.515121252 1313277  Q   W 16192995672 + 2048 
[kworker/u82:15]
129,176 10     5025   114.515127423 1313277  M   W 16192995672 + 2048 
[kworker/u82:15]
129,176 10     5026   114.515804026 1313277  Q   W 16192997720 + 2048 
[kworker/u82:15]
129,176 10     5027   114.515811469 1313277  G   W 16192997720 + 2048 
[kworker/u82:15]
129,176 10     5028   114.515812486 1313277  U   N [kworker/u82:15] 1
129,176 10     5029   114.515812811 1313277  I   W 16192991568 + 6152 
[kworker/u82:15]
129,176 10     5030   114.515852970 1313277  D   W 16192991568 + 6152 
[kworker/u82:15]
129,176 10     5031   114.515854237 1313277  P   N [kworker/u82:15]
129,176 10     5032   114.516526546 1313277  Q   W 16192999768 + 2064 
[kworker/u82:15]
129,176 10     5033   114.516533100 1313277  M   W 16192999768 + 2064 
[kworker/u82:15]
129,176 10     5034   114.517192285 1313277  Q   W 16193001832 + 2048 
[kworker/u82:15]
129,176 10     5035   114.517198423 1313277  M   W 16193001832 + 2048 
[kworker/u82:15]
129,176 10     5036   114.517862333 1313277  Q   W 16193003880 + 2048 
[kworker/u82:15]
129,176 10     5037   114.517869473 1313277 UT   N [kworker/u82:15] 1
129,176 10     5038   114.517869845 1313277  I   W 16192997720 + 6160 
[kworker/u82:15]
129,176 10     5039   114.517923869 1894054  D   W 16192997720 + 6160 
[kworker/10:2H]
129,176 16     3725   114.535013734     0  C   W 16192970976 + 6208 [0]
129,176 16     3726   114.550351249 1383484  C   W 16192977184 + 6192 [0]
129,176 16     3727   114.550998373 1383484  C   W 16192991568 + 6152 [0]
129,176 16     3728   114.551438627 1383484  C   W 16192997720 + 6160 [0]


