Return-Path: <linux-btrfs+bounces-21255-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBbYNe1VfWn9RQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21255-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Jan 2026 02:07:57 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F163BFDDD
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Jan 2026 02:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94E64303FF21
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Jan 2026 01:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1647F31A572;
	Sat, 31 Jan 2026 01:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="hnJIyZEQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657613164BB
	for <linux-btrfs@vger.kernel.org>; Sat, 31 Jan 2026 01:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769821633; cv=none; b=OA3hZyGoOM+XkfkZiFFE/11MWb7P+jExcOruEbPply+cuzKnAeaj10sZKwfvLXW3WmWX4M7WTjwWgxY1n22uwfKDELzT+3aGiWBePyLvhUbq6dREjlIPWb0vIIKx9GGSvFvUtSq2EEjHW4YYTB2hdfSWg4LF4jki5vHAVVO4BwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769821633; c=relaxed/simple;
	bh=sMBxLoDuoX2R1v0jBCiJgef7L56uFzZAYgHm6SCryi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dCqHSmHoITlfchbKQCRgF3ZlkLflaEwrhX7idWgwWby+Yj2dxKWyHz9ooynYQX4b6WrcDXS1FPJKCy9xR0X8ZmwmazZqe6/6OpbQQZihenx+r2mgAIL3a1Qp7R7TVtCfJ3WXyE12WOppAoMncIdbZ7MqBEIj/Jubj1jwsVui+34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=hnJIyZEQ; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1769821618; x=1770426418; i=quwenruo.btrfs@gmx.com;
	bh=hW8uIMJuZK9CMpQOBDmsFJ766T+K+NgTpEAjidRLrkc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hnJIyZEQayp9i/ibSCC/n6Cdoh5WpVpEOtcskZD06nUuMXx9vwzgjOwmTQa8RF8Y
	 gEtZzsrMcOmbEoNzM7APVIbTQuZRqlaMQ09Q8Xv7s/tsFwNtnh59Zxn9QhzlHcCSq
	 FgTbznFvSBv0fVEZ5vjBC2J5j6tgkyTrcXvBdeDtz5gafbAmFlcoCoT8VljiPAfuN
	 RBSbUmY+b+c7/S/Xv+euWdN6LEtf5V6ZeulztiYxu59t0XQa3oWd2aZvJZPp6G584
	 xHVWQgf/fNi/u+QcC6IuA8T3IGLU5akblqG1qrx6k+Rrg85v1MVNsZgAq2eW4Cqvl
	 rNMqTFiL5HByj/DMow==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MmlXK-1wC0Wq0kf0-00oJHm; Sat, 31
 Jan 2026 02:06:58 +0100
Message-ID: <94167ea3-8174-4d35-a316-1f9e46fdb988@gmx.com>
Date: Sat, 31 Jan 2026 11:36:54 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: prevent COW amplification during btrfs_search_slot
To: Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>
Cc: Leo Martins <loemra.dev@gmail.com>, Filipe Manana <fdmanana@kernel.org>,
 linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20260130214319.3714908-1-loemra.dev@gmail.com>
 <4bff1e42-57de-4169-b3c0-a2085182cbb3@suse.com>
 <20260131001118.GA1432933@zen.localdomain>
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
In-Reply-To: <20260131001118.GA1432933@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fys7eqLGLh5MXBCxzacNymvPOnk8WHWrjhlUoQAn5mMv0ilCW5m
 BzUtRrg8WR1yQD3vOnqyB+rrSn8M49bhFdWW11qJGzfrx/8g/vsRD0NNNhXq1dABfpv1ACT
 gBhbiKJMEO+TJPW52Fjts1LpcGKNCLAZKUfeFZwOHC4grQQKgewD9W2KjCjl6ibyh5IpfWG
 obWihpcuJVOjccZn/dBbQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZX7lwrQp4bw=;k8f3gcNkzVtex/sIEEsg1b1XhAQ
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21255-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,fb.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.com:mid,gmx.com:dkim]
X-Rspamd-Queue-Id: 3F163BFDDD
X-Rspamd-Action: no action



=E5=9C=A8 2026/1/31 10:41, Boris Burkov =E5=86=99=E9=81=93:
> On Sat, Jan 31, 2026 at 09:04:03AM +1030, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2026/1/31 08:13, Leo Martins =E5=86=99=E9=81=93:
>>> On Fri, 30 Jan 2026 12:49:55 +0000 Filipe Manana <fdmanana@kernel.org>=
 wrote:
>>>
>> [...]
>>>
>>>>
>>>> This was before a recent refactoring of should_cow_block(), but you
>>>> should get the ideia.
>>>> IIRC all fstests were passing back then, except for one or two which =
I
>>>> never spent time debugging.
>>>>
>>>> And as that attempt was before the tree checker existed, we would nee=
d
>>>> to make sure we don't change and eb while the tree checker is
>>>> verifying it - making sure the tree checker read locks the eb should
>>>> be enough.
>>
>> That may still be racy not just to tree-checker, but with the extent bu=
ffer
>> writeback path.
>>
>> Even we locked the eb for tree-checker, but someone still modified the =
the
>> eb after tree-checker but before submission, it can still be very
>> problematic.
>=20
> Agreed that it feels very fishy, like we can write an eb with bad csum,
> much like DIO and unstable pages. But do we think it *actually* matters?
>=20
> In principle, if I buffered an eb, wrote total garbage to the disk durin=
g
> the transaction, but then during the commit wrote out the correct eb, I
> think that is still OK. If we crash, that bad eb isn't reachable from
> any root when we mount again, right?

Yes, that's correct, however still I'd prefer a more consistent behavior=
=20
that doesn't introduce any bad csum at any timing.

Causing temporary unreachable bad csum seems harmless, but it brings a=20
much bigger opening, that may or may not lead to bad csums for valid=20
tree blocks in the future.

[...]
>> Although before all the new ideas/attempts, I'm wondering the following=
 two
>> points:
>>
>> - With the AS_KERNEL_FILE flag, how frequent we're re-dirtying COWed eb=
s
>>    We need extra benchmarks on this first.
>=20
> As far as I am concerned, any amount more than zero is a bug when you
> consider it from the perspective of the transaction block_rsv. If you
> had an 8 deep tree doing splitting, then a single re-cow you didn't plan
> on will use space not in the block_rsv.

I also have one question related to the exhausted block_rsv.

If we COWed a tree block (the old is eb A, older than the current=20
trans), write the new one (eb B) back to disk, the space of eb A will=20
not be available until a full transaction is committed.

But if we need to re-dirty eb B and COW it to eb C, shouldn't the space=20
of eb B be available again?

So from the perspective of space usage, re-dirtying a COWed block (in=20
the current transaction, except log trees) should not cause extra space=20
usage except the temporary usage before freeing eb B and copy its=20
content to eb C.

It should always be the space of the original old on-disk eb, and the=20
new COWed eb, no matter how many times we redirtied it.

Or is the problem exactly at the space reservation for such eb B?

>=20
> In practice today we see 30x amplification at least. To flip it around,
> what amount is "OK"? An amount that doesn't happen to cause ENOSPCs on
> most machines?

30x amplification itself should not be the cause of exhausted space, but=
=20
whether we can reuse the space of eb B of the above example.

Although I agree 30x re-dirtying is very bad, but re-using the eb=20
in-place also means we will still see the same 30x write amplification,=20
and more chance to screw up the writeback handling.

I'd like to know more about the source of such aggressive writeback first.

Especially if the risk of chances of data race/bad csum is really worthy=
=20
after the AS_KERNEL_FILE feature.

Thanks,
Qu

>=20
> I don't think it's responsible to let it slide and hope it doesn't happe=
n
> too much. There's always systems in global reclaim to worry about as wel=
l..
>=20
> I do, however, completely agree that this argument means we should try
> to avoid inventing some really wild and costly solution. Ideally we can
> find something tidy to plug up the hole :)
>=20
>>
>> - Is there any pattern of the re-dirtying COWed ebs
>>    E.g. which trees are re-drity the most frequently? Extent or csum or
>>    log trees?
>=20
> In the Meta fleet data, the subvol trees and the csum tree see by far
> the most lock contention, which I think is likely going to be correlated
> with COW amplification. But we don't have detailed COW re-dirtying data
> yet.
>=20
>>
>>    Can we take advantage of such patterns if they exist?
>>
>=20
> That is why I wasted everyone's time and brain-cells on those very trick=
y
> csum commit root patches I kept messing up for like nine iterations :D
>=20
> If there are other heuristic improvements I think it's a good idea, but
> I think also doesn't change the reality of the transaction block_rsv
> over-spend bug.
>=20
>> - Is there any less invasive alternatives to changing COW basics?
>>    E.g. Changing btree_writepages() to utilize some LRU so only the
>>    oldest/least frequent accessed dirty ebs are written back first.
>=20
> With sufficient sustained memory pressure I am not sure that something
> like this will work, even to satisfactorily reduce the problem,
> but I have not yet reproduced it without resorting to small cgroups
> and no AS_KERNEL_FILE (as we have discussed elsewhere)
>=20
> Ideas we have considered, which I think would fully solve the bug:
> (in no particular order, and I'm sure there are others)
>=20
> - Leo's xarray to block writeback on the shortest scope
> - Block writeback on a longer but easier to manage scope (e.g. trans_han=
dle)
> - Block writeback to the whole tree while it's being cow-ed.
> - Have writeback also take a new type of tree lock which cow paths do no=
t release
> - Relax the strictness of the transaction block rsv guarantee
>=20
> Personally, I am still quite excited about Filipe's idea and hope we can
> make it work. That would be really slick.
>=20
> Thanks,
> Boris
>=20
>>
>> Thanks,
>> Qu
>>
>>>>
>>>> Thanks.
>>>>
>>>>>
>>>>> Please let me know if you see any issues with this approach or
>>>>> if you can think of a better method.
>>>>>
>>>>> Thanks,
>>>>> Leo
>=20


