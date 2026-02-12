Return-Path: <linux-btrfs+bounces-21653-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oB6aGgs+jmkMBQEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21653-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Feb 2026 21:54:35 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1D31310FB
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Feb 2026 21:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63593304A20D
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Feb 2026 20:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4ABC2ED84C;
	Thu, 12 Feb 2026 20:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="JlDdeEvJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E282C326A;
	Thu, 12 Feb 2026 20:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770929666; cv=none; b=gKnafpZh/36ySm0aoLbwYA7nQJXwy/zjJIuUgf08uEaG6elCDMqm4zJaxlkDl66BjucVbind56E+S9MQxdksi8Tf/Sb1MGmstkdyGOvOM6pOu7XjcbsZLRPo2QCcc9IaKOH5U0ImWKLdf8uwGNlj/I+p6298+gBf4wewSs/Cg9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770929666; c=relaxed/simple;
	bh=fNCrntDcX2q17a4JHP/QXYP/wXcVsecow/Q6zKREpDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a1ty5e03DCzk23tGc6LsWqRvOoHGFRCui2ri+PY8H+/dN3UYbienpQa/2wmjZ3t38Z5GWFOqRCUAhwxARKCSvSIBC514V9j98+87UIpo487ryYmK3jcGeq81INEy8H61W+78zenRiqnsGcaY7VrXzbpXP9xZAdoOd/usg6kHPwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=JlDdeEvJ; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1770929662; x=1771534462; i=quwenruo.btrfs@gmx.com;
	bh=YVHYgrD3YGEdLdcTSeKEIdvQ4sodIfuVHHqASZOraow=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JlDdeEvJ2GmzVNkzlztZG01f5N1c6wdwCGXGz3PpdhMj0t9TujUNgeSwUusyrvXj
	 Ho3ws0Iu4kEOvYYwsg0WhG4SQh56bEeGnC9mNULcbYXkCUVTDKcHrkMBjLAd8C3td
	 kLzxUFRRZSnVZBAR6Ld/DwagXZS+vJ/qrRh37tH/TA9Wq8X+bHMwxcv9xg3GDw4Ef
	 IXUNbYXpPSO1Q5yUcqhnfR7AW9/NDIJRwf1fa1lfONnYZs9CxHAkKZ4Ev27Wurljx
	 ctKr+NqyR0YD2+leE5kVcDGTi6fLyvJbodO/7wrILTvCxuFru7F0cD3AQg1c/61Dy
	 NbrT5odVdptgOp/5Ig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M5QFB-1vpoDo3F7l-00F9A0; Thu, 12
 Feb 2026 21:54:22 +0100
Message-ID: <74b8dbc6-34cc-470b-9812-b595af95c5b6@gmx.com>
Date: Fri, 13 Feb 2026 07:24:17 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fstests: btrfs: add a regression test for incorrect
 inode incompressible flag
To: Zorro Lang <zlang@redhat.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
 Filipe Manana <fdmanana@suse.com>
References: <20260209095735.130049-1-wqu@suse.com>
 <20260212184006.5pyxjnwxd5n5uad2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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
In-Reply-To: <20260212184006.5pyxjnwxd5n5uad2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AVjSwLPKPrznFKaWFz3S0nnLhNzeXuWxh3mrpIgyfWuFEhROFN8
 fyF4clIh9r+O8Z/ADP2JVKZGqk5R4FOXiAgvdDPw3/VgZeDqGe1anafTObqZy6EIBMHbPz9
 gJyt8k0DwboTKIPpWTwCD0GJnlqhS2Fl0Zl8kqiJ1sDKTjQT7vuQhKm6Ov9lrSAXQWiYF7P
 T3aEP+85IqkEH5IhKvycg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FuWlMkpvCeA=;NxWEwgTdSuDudvYUsIxN7n1bBZV
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21653-lists,linux-btrfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmx.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gmx.com:mid,gmx.com:dkim]
X-Rspamd-Queue-Id: 2C1D31310FB
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/13 05:10, Zorro Lang =E5=86=99=E9=81=93:
[...]
>> +
>> +blocksize=3D$(_get_block_size $SCRATCH_MNT)
>=20
> Do you mind I replace _get_block_size with _get_file_block_size when I m=
erge it?

Sure, and I'll try to remember to use that newer helper in the future.

And if needed, I can replace the existing callsites with the newer=20
helper in a dedicated patch.

Thanks,
Qu

> Even though btrfs currently doesn't require special handling to get the =
correct block
> size, using this interface is more future-proof. It will help us to easi=
ly add specific
> logic later if btrfs ever needs it. Others are good to me,
>=20
> Reviewed-by: Zorro Lang <zlang@redhat.com>
>=20
>> +
>> +# Create a sparse file which is 2 * blocksize, then try a small write =
at
>> +# file offset 0 which should not be inlined.
>> +# Sync so that [0, 2K) range is written, then write a larger range whi=
ch
>> +# should be able to be compressed.
>> +$XFS_IO_PROG -f -c "truncate $((2 * $blocksize))" -c "pwrite 0 2k" -c =
sync \
>> +		-c "pwrite 1m 1m" $SCRATCH_MNT/foobar >> $seqres.full
>> +ino=3D$(stat -c "%i" $SCRATCH_MNT/foobar)
>> +_scratch_unmount
>> +
>> +# Dump the fstree into seqres.full for debug.
>> +$BTRFS_UTIL_PROG inspect-internal dump-tree -t 5 $SCRATCH_DEV >> $seqr=
es.full
>> +
>> +# Check the NOCOMPRESS flag of the inode.
>> +$BTRFS_UTIL_PROG inspect-internal dump-tree -t 5 $SCRATCH_DEV |\
>> +grep -A 4 -e "item .* key ($ino INODE_ITEM 0)" | grep -q NOCOMPRESS
>> +[ $? -eq 0 ] && echo "inode $ino has NOCOMPRESS flag"
>> +
>> +# Check the file extent at fileoffset 1m.
>> +$BTRFS_UTIL_PROG inspect-internal dump-tree -t 5 $SCRATCH_DEV |\
>> +grep -A 4 -e "item .* key ($ino EXTENT_DATA 1048576)" | grep -q "compr=
ession 0"
>> +[ $? -eq 0 ] && echo "inode $ino file offset 1M is not compressed"
>> +
>> +echo "Silence is golden"
>> +# success, all done
>> +_exit 0
>> diff --git a/tests/btrfs/343.out b/tests/btrfs/343.out
>> new file mode 100644
>> index 00000000..2eb30e4f
>> --- /dev/null
>> +++ b/tests/btrfs/343.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 343
>> +Silence is golden
>> --=20
>> 2.51.2
>>
>>
>=20
>=20


