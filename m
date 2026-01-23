Return-Path: <linux-btrfs+bounces-20932-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCNyIJvQcmnKpgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20932-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 02:36:27 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C766F272
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 02:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 693A230251F6
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 01:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DDF37BE69;
	Fri, 23 Jan 2026 01:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="StufZ+h5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2BC33B6F3
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Jan 2026 01:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769131886; cv=none; b=sUE6OS5w1BW+e7M/HOsoHvWxJnFiAHTDu5i0criuyjx2ud3d8Sm0rreATItlDYaBR3m3gUSdZKMArHbKNUjkCdi+ncWPW+l6r3tbOHpfJPv5A2Pzchh/3Jd2SNQxOydAMpE4VqL+ygapodzmmF8Y1Rg7beXXzf2r6lnzbjDSCIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769131886; c=relaxed/simple;
	bh=f6TeI0WhEDqMyBm19XYLqR+c+k/4U6Hdn/198r8jk9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZeqQWsQdY04nNHBnRuxzjyVB2Ce5FhsHBp4avTFpXH1RA3npBtPFvoN0w41dlxnFM374N6H319dUSEsOb/6H8EFK7RMew7u6BByWfUa/DOEsI5sovbuPEbYKU6Mf3+8fJx1DIPacr+yuQwnK/gPCYqo8LtgB1WENImaTiciaVKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=StufZ+h5; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1769131861; x=1769736661; i=quwenruo.btrfs@gmx.com;
	bh=HIdjIu/4wevIwt/uDZwP/eqmflg9zybD32K/tu/+tUI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=StufZ+h50QN095wYMXzqh+lb+kRPkO2OZheTrGZOAXqvVKe2CQJ0J0p2ea3Oh/KU
	 k2jQfPVApoc1jNDaf+RmKHsbycWj2WnU0moQrvTzMcpo6pdiwTP6e098zcaDmTd55
	 JdJEk3P/Tz0YeEAMF5Jfcgy4VtcsCIK+jvaSvMUoEK4n2kkNcWxtIAsAZD/sASJdU
	 12Vge3DPpM3v/P5DItTsCnj8L3SlOus3gKSHVE+LipSBQH2w8wEgny1NPbLdJ6ysd
	 x4hdQtVkKE98ouI4x1HubyZwvYjXhIvATJCyCpWSdQ9TbBPKoU+XdCoiFRNlizrpF
	 HXOT+nVponiLD4AZFA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MmULx-1w9fL33GhF-00kFXq; Fri, 23
 Jan 2026 02:31:01 +0100
Message-ID: <33e83be1-111c-4420-8b09-ed46959d1b84@gmx.com>
Date: Fri, 23 Jan 2026 12:00:57 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix EEXIST abort due to non-consecutive gaps in
 chunk allocation
To: Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <ce8537968dd7228cc7cbde394b854fde6bb78e3c.1769119556.git.boris@bur.io>
 <424c4694-c89d-43bd-a78e-910b6d0db3ba@suse.com>
 <20260123002011.GA832741@zen.localdomain>
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
In-Reply-To: <20260123002011.GA832741@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cqaTGWQNOg7H0dAdjLDVNLzm+GHul0zLDEphtDBNd310AuOnYNU
 SVijmSMM5D1q+bNcVDSxInAL6YjGxpajss/o3vKutLqMi4HTAjubkSDkX5VvtWMd4Ky65Sg
 wBZVSB50imn2SiUzE6qO3BNtmNOxjsaTzUSezR5ZIX7TIQQtK6KmKdAa5uPPVZt8cbZMBFP
 U2vPxgEakFR87WiPvfvBQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qX8DwTA2WnI=;3oSLGIDoevzi//l2trTSze1s/OH
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20932-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FREEMAIL_FROM(0.00)[gmx.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.com:mid,gmx.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 83C766F272
X-Rspamd-Action: no action



=E5=9C=A8 2026/1/23 10:50, Boris Burkov =E5=86=99=E9=81=93:
> On Fri, Jan 23, 2026 at 10:18:55AM +1030, Qu Wenruo wrote:
[...]
>> I'm wondering, can we just stop the unused bg cleaner if there is any
>> pending bgs.
>>
>=20
> I think it's a valid idea, but it's not totally obvious to me how to do =
this.
>=20
> We would have to do something like:
>=20
> - set some global bit that there are pending bgs (already exists on txn =
but
> maybe not fs_info IIRC?)
> - on each loop of delete_unused_bgs check the bit and blow out if not,
>    but also hold a lock that is exclusive with the code paths that set
>    the bit for the duration, to guarantee a new one doesn't sneak in
>    after we check the bit?

You're right, we need something new to exclude new pending bgs, and that=
=20
will definitely delay any new bg allocations.

>=20
> Would that be sufficient? We also need to worry about relocation. I
> haven't considered it as carefully since balance has to persist balance
> state and stuff so it makes more txns, but I think reclaim_bgs is likely
> to have roughly the same risks.

Relocation is fine, as we already have exclusive operations checks in=20
btrfs_reclaim_bgs_work().

>=20
> And furthermore we have to document and ensure forever that we only ever
> see sequential pending extents with no gaps in the bitmap.
>=20
> It feels worthwhile to harden the bitmap processing, if we are going to
> have the bitmap at all.

Right, even if we block the reclaim to avoid gaps for now, it's not as=20
future proof as better bitmap handling.

After more readings about the current fix, it is not as scary as I=20
originally thought, thus there isn't too much need to go for a simpler=20
but less future-proof solution.

[...]
>=20
>>
>>
>> Another thing is, I'm not sure if it's really that important/useful to =
delay
>> dev-extent tree update.
>> Considering new pending block groups will be created at commit transact=
ion
>> time, I'm wondering why not just updating dev-extent tree, so that the
>> current dev-extent tree will always reflect the real usage, without the=
 need
>> to bother the bitmap.
>>
>> And even if a power loss happened, we will only see the old dev-extent =
tree,
>> no mismatch between chunk/bg trees.
>>
>> Of course it will slow down chunk allocation, but should also be less
>> complex.
>=20
> This is interesting too. I would be worried about introducing novel
> inconsistencies between the various trees and items. Like right now the
> bitmap is sort of a major synchronization point and we'd have to make
> sure we don't mess up removing it.
>=20
> I do probably prefer this approach to "just block concurrent deletions"
> which feels more fragile and less future proof to me. Maybe I just feel
> that way because I bothered to debug this :)
>=20
> I'm curious what you and others think about the best way forward. But I
> can start looking into this option if the bitmap fix is too complex.

The current bitmap fix looks good to me.

I was a little concerned about the amount of new code, but it's mostly=20
helpful comments.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>=20
> I can also try harder to make a small hacky bitmap fix that just adds
> more checks/looping to find_free_dev_extent. That will likely have to
> have bugs that miss available space (if the hole starts with a hole but
> contains a pending extent), but it can probably avoid EEXIST aborts.
>=20
>>
>> Thanks,
>> Qu
>>
>=20
> Thanks,
> Boris
>=20
[...]
>>> +	lockdep_assert_held(&device->fs_info->chunk_mutex);
>>> +
>>> +	if (*len =3D=3D 0)
>>> +		return false;
>>> +
>>> +	end =3D *start + *len - 1;
>>> +
>>> +	while (true) {
>>> +		if (first_pending_extent(device, *start, *len, &pending_start, &pen=
ding_end)) {
>>> +			/*
>>> +			 * Case 1: the pending extent overlaps the start of
>>> +			 * candidate hole. That means the true hole is after the
>>> +			 * pending extent, but we need to find the next pending
>>> +			 * extent to properly size the hole. In the next loop,
>>> +			 * we will reduce to case 2 or 3.
>>> +			 * e.g.,
>>> +			 *   |----pending A----|    real hole     |----pending B----|
>>> +			 *            |           candidate hole        |
>>> +			 *         *start                              end
>>> +			 */
>>> +			if (pending_start <=3D *start) {
>>> +				*start =3D pending_end + 1;
>>> +				goto next;
>>> +			}
>>> +			/*
>>> +			 * Case 2: The pending extent starts after *start (and overlaps
>>> +			 * [*start, end), so the first hole just goes up to the start
>>> +			 * of the pending extent.
>>> +			 * e.g.,
>>> +			 *   |    real hole    |----pending A----|
>>> +			 *   |       candidate hole     |
>>> +			 * *start                      end
>>> +			 *
>>> +			 */
>>> +			*len =3D pending_start - *start;
>>> +			if (*len >=3D min_hole_size) {
>>> +				success =3D true;
>>> +				break;
>>> +			}
>>> +			/*
>>> +			 * If the hole wasn't big enough, then we advance past
>>> +			 * the pending extent and keep looking.
>>> +			 */
>>> +			*start =3D pending_end + 1;
>>> +			goto next;
>>> +		} else {
>>> +			/*
>>> +			 * Case 3: There is no pending extent overlapping the
>>> +			 * range [*start, *start + *len - 1], so the only remaining
>>> +			 * hole is the remaining range.
>>> +			 * e.g.,
>>> +			 *   |       candidate hole           |
>>> +			 *   |          real hole             |
>>> +			 * *start                            end
>>> +			 */
>>> +			if (*len >=3D min_hole_size)
>>> +				success =3D true;
>>> +			break;
>>> +		}
>>> +next:
>>> +		if (*start > end) {
>>> +			*start =3D end + 1;
>>> +			*len =3D 0;
>>> +			return false;
>>> +		}
>>> +		*len =3D end - *start + 1;
>>> +	}
>>> +	return success;
>>> +}
>>> +
>>>    static u64 dev_extent_search_start(struct btrfs_device *device)
>>>    {
>>>    	switch (device->fs_devices->chunk_alloc_policy) {
>>> @@ -1597,59 +1706,51 @@ static bool dev_extent_hole_check_zoned(struct=
 btrfs_device *device,
>>>    }
>>>    /*
>>> - * Check if specified hole is suitable for allocation.
>>> + * Validate and adjust a hole for chunk allocation
>>>     *
>>> - * @device:	the device which we have the hole
>>> - * @hole_start: starting position of the hole
>>> - * @hole_size:	the size of the hole
>>> - * @num_bytes:	the size of the free space that we need
>>> + * @device: the device containing the candidate hole
>>> + * @hole_start: input/output pointer for the hole start position
>>> + * @hole_size: input/output pointer for the hole size
>>> + * @num_bytes: minimum allocation size required
>>>     *
>>> - * This function may modify @hole_start and @hole_size to reflect the=
 suitable
>>> - * position for allocation. Returns 1 if hole position is updated, 0 =
otherwise.
>>> + * Check if the specified hole is suitable for allocation and adjust =
it if
>>> + * necessary. The hole may be modified to skip over pending chunk all=
ocations
>>> + * and to satisfy stricter zoned requirements on zoned fs-es.
>>> + *
>>> + * For regular (non-zoned) allocation, if the hole after adjustment i=
s smaller
>>> + * than @num_bytes, the search continues past additional pending exte=
nts until
>>> + * either a sufficiently large hole is found or no more pending exten=
ts exist.
>>> + *
>>> + * Return: true if a suitable hole was found and false otherwise.
>>>     */
>>>    static bool dev_extent_hole_check(struct btrfs_device *device, u64 =
*hole_start,
>>>    				  u64 *hole_size, u64 num_bytes)
>>>    {
>>> -	bool changed =3D false;
>>> -	u64 hole_end =3D *hole_start + *hole_size;
>>> +	bool found =3D false;
>>> +	u64 hole_end =3D *hole_start + *hole_size - 1;
>>> -	for (;;) {
>>> -		/*
>>> -		 * Check before we set max_hole_start, otherwise we could end up
>>> -		 * sending back this offset anyway.
>>> -		 */
>>> -		if (contains_pending_extent(device, hole_start, *hole_size)) {
>>> -			if (hole_end >=3D *hole_start)
>>> -				*hole_size =3D hole_end - *hole_start;
>>> -			else
>>> -				*hole_size =3D 0;
>>> -			changed =3D true;
>>> -		}
>>> +	ASSERT(*hole_size > 0);
>>> -		switch (device->fs_devices->chunk_alloc_policy) {
>>> -		default:
>>> -			btrfs_warn_unknown_chunk_allocation(device->fs_devices->chunk_allo=
c_policy);
>>> -			fallthrough;
>>> -		case BTRFS_CHUNK_ALLOC_REGULAR:
>>> -			/* No extra check */
>>> -			break;
>>> -		case BTRFS_CHUNK_ALLOC_ZONED:
>>> -			if (dev_extent_hole_check_zoned(device, hole_start,
>>> -							hole_size, num_bytes)) {
>>> -				changed =3D true;
>>> -				/*
>>> -				 * The changed hole can contain pending extent.
>>> -				 * Loop again to check that.
>>> -				 */
>>> -				continue;
>>> -			}
>>> -			break;
>>> -		}
>>> +again:
>>> +	*hole_size =3D hole_end - *hole_start + 1;
>>> +	found =3D find_hole_in_pending_extents(device, hole_start, hole_size=
, num_bytes);
>>> +	if (!found)
>>> +		return found;
>>> -		break;
>>> +	switch (device->fs_devices->chunk_alloc_policy) {
>>> +	default:
>>> +		btrfs_warn_unknown_chunk_allocation(device->fs_devices->chunk_alloc=
_policy);
>>> +		fallthrough;
>>> +	case BTRFS_CHUNK_ALLOC_REGULAR:
>>> +		return found;
>>> +	case BTRFS_CHUNK_ALLOC_ZONED:
>>> +		if (dev_extent_hole_check_zoned(device, hole_start,
>>> +						hole_size, num_bytes)) {
>>> +			goto again;
>>> +		}
>>>    	}
>>> -	return changed;
>>> +	return found;
>>>    }
>>>    /*
>>> @@ -1708,7 +1809,7 @@ static int find_free_dev_extent(struct btrfs_dev=
ice *device, u64 num_bytes,
>>>    		ret =3D -ENOMEM;
>>>    		goto out;
>>>    	}
>>> -again:
>>> +
>>>    	if (search_start >=3D search_end ||
>>>    		test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state)) {
>>>    		ret =3D -ENOSPC;
>>> @@ -1795,11 +1896,7 @@ static int find_free_dev_extent(struct btrfs_de=
vice *device, u64 num_bytes,
>>>    	 */
>>>    	if (search_end > search_start) {
>>>    		hole_size =3D search_end - search_start;
>>> -		if (dev_extent_hole_check(device, &search_start, &hole_size,
>>> -					  num_bytes)) {
>>> -			btrfs_release_path(path);
>>> -			goto again;
>>> -		}
>>> +		dev_extent_hole_check(device, &search_start, &hole_size, num_bytes)=
;
>>>    		if (hole_size > max_hole_size) {
>>>    			max_hole_start =3D search_start;
>>> @@ -5023,6 +5120,7 @@ int btrfs_shrink_device(struct btrfs_device *dev=
ice, u64 new_size)
>>>    	u64 diff;
>>>    	u64 start;
>>>    	u64 free_diff =3D 0;
>>> +	u64 pending_start, pending_end;
>>>    	new_size =3D round_down(new_size, fs_info->sectorsize);
>>>    	start =3D new_size;
>>> @@ -5068,7 +5166,8 @@ int btrfs_shrink_device(struct btrfs_device *dev=
ice, u64 new_size)
>>>    	 * in-memory chunks are synced to disk so that the loop below sees=
 them
>>>    	 * and relocates them accordingly.
>>>    	 */
>>> -	if (contains_pending_extent(device, &start, diff)) {
>>> +	if (first_pending_extent(device, start, diff,
>>> +				 &pending_start, &pending_end)) {
>>>    		mutex_unlock(&fs_info->chunk_mutex);
>>>    		ret =3D btrfs_commit_transaction(trans);
>>>    		if (ret)
>>
>=20


