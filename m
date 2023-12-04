Return-Path: <linux-btrfs+bounces-594-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 805C28040D0
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 22:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B107B1C20B36
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 21:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86FC364AD;
	Mon,  4 Dec 2023 21:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="D/DWRyQQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9356BAA
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 13:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1701724258; x=1702329058; i=quwenruo.btrfs@gmx.com;
	bh=/aQC1tKrP3DErWi4gvNx512OLIMu0jfjXOwL54awCeA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=D/DWRyQQ8pCsp4bRtKFsqTaq2fe8PkcSj1AvNj8PZ6z1oW4rqsygkaNWc4XBo7LX
	 ScQu5EgamzMHcE387ZG6Q4m0gtInnSZFemCpmGVM4jIVKVMIp89eGt0ffSAB4WUwQ
	 1ZmhL66rH6ejFuBy/MEnyO3zEdpeDdiNi1bhAg2Y9a3r0ccrwGcpErVGvVLDPfM7a
	 jgkQ2lLNuSVRys7b+Zxru1OJKIqinAbNK9tmP0v7GHJC8+YzzEcQ+vtZz4jwiNkK8
	 wB3tKODEAdyRvtFrWF09O//8bAr3ljADqUar0KTw1wJiSMHDgD1eZ0/h25PnAkN/k
	 Kw7O8PMO/p16oVHV5Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQMuX-1qxHm40td3-00MIe0; Mon, 04
 Dec 2023 22:10:57 +0100
Message-ID: <59a3a8d7-1f00-4d79-94e7-e77528d610ab@gmx.com>
Date: Tue, 5 Dec 2023 07:40:55 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] btrfs: migrate extent_buffer::pages[] to folio and
 more cleanups
Content-Language: en-US
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1701410200.git.wqu@suse.com>
 <20231204162624.GC2205@twin.jikos.cz>
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
In-Reply-To: <20231204162624.GC2205@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yi/oBrKE3vjOqcC3DGC460SHhNBPxnytMkShr/KnktgvXIPnxjs
 gcFMxcaJZQsQmLgZzc/mioNvFXVE9MbN3hH9EFRks+paYB8o4pffOfiAXTvxyMONglnE0sj
 mbiGvsCJ74ZdRQ2vEZ3JVQb2CwupiEKFNWdiZYCw7WCRtavK6acf+wknVwMO37wQ1F6Jj4e
 LDviVt4+NW0ysoyPjDxuA==
UI-OutboundReport: notjunk:1;M01:P0:JlM/7oIISFg=;sE6tv5Wo/F6P4aRTsNPNBy1wus6
 k5Ub5IisZfaXlW+32dbf2I6JB+blY4Vqmgi5+E2QIy4+k9t9LZRcDPARDP72NmTHrGc7QsCFD
 CY7BLbKxbU5Ly9UdoKfvC+PcwxFX+ibFkxFS+YHps0rsxXSWOFx6ZzSqM47T4IeWQzodu6vtR
 LOIJcJKTVR6GAjas801LmHctF9NMUZoqvIgWnB67GLSE18ihvL3i6VD7NizQBxo54t84x5OK+
 yR5oDxcJz/o6XTzlflE68gHeXvcclq0atL/DUVrRrb+7nb9VZvKNYxXmf0UHooOtlkVpz/R+Q
 BL+r3OyDHKBvWK5KLFTMc8HPMCZeiIWo7/ZNldJ3mP+8O5WCe3Rb9OidNrN/muoF8bRMMycAl
 +TUNg9YyTUIZZn2m00gdKyT0sRYZSqfgP/qDXYwsdsESkh2jHwdYZU631pUylpqb+695XrzX3
 zbkYZeIxZhK4VyG+51OmFoWDKsxKLgibKMcJdGqzwQ6H9SFejlhHNahl13+rlFZZvL1tYQcVw
 P0VXUQDQS2kiNgOOIntkLTinAIIGaRmk9Vsd1OfM+tI6xIqxRMuRFyz74eGmlUzRObbkDTXqt
 sHTrsH3vp1gxE8Z3x/eWIWQLiScsk3cN22X5lgjG05WrqBdYHPYX8BxdYR0AvFYM1rGwwIo7F
 2p5G3+iF+S7UCuS8uI6hrfa6CCwFgh8lg/7mwzC8cPwcZzGPWk63frfIt/kvJv4VwWM7Jg+Bx
 bZDVCobD08EnwDSe3Eth0mGnxoN4fQvRTQUuRLlf9qrAYz7kIwY9xaAs/k3MLh1pjW+reiL+L
 Kb/u5RGnnFdjnvVX02C9jD2GZnOHwwSYemETmJvIWHjwJLOFBrv4cq2Jw2+xSkmdXvPOyRN7v
 Tjt75QvP9wjAVKFdvh1DEnbSlTR4BELGcwlRV2YvvFe0wp+DjMVWs5T5gwVoVCoRmXV7lCImY
 QlxKFA==



On 2023/12/5 02:56, David Sterba wrote:
> On Fri, Dec 01, 2023 at 04:36:53PM +1030, Qu Wenruo wrote:
>> [CHANGELOG]
>> v2:
>> - Adda new patch to do more cleanups for metadata page pointers usage
>>
>> This patchset would migrate extent_buffer::pages[] to folios[], then
>> cleanup the existing metadata page pointer usage to proper folios ones.
>>
>> This cleanup would help future higher order folios usage for metadata i=
n
>> the following aspects:
>>
>> - No more need to iterate through the remaining pages for page flags
>>    We just call folio_set/mark/start_*() helpers, for the single folio.
>>    The helper would only set the flag (mostly for the leading page).
>>
>> - Single bio_add_folio() call for the whole eb
>>
>> - Better filio helpers naming
>>    PageUptodate() compared to folio_test_uptodate().
>>
>> The first patch would do a very simple conversion, then the 2nd patch d=
o
>> the prepartion for the higher order folio situation.
>>
>> There are two locations which won't be converted to folios yet:
>>
>> - Subpage code
>>    There is no meaning to support higher order folio for subpage.
>>    The two conditions are just conflicting with each other.
>>
>> - Data page pointers
>>    That would be more useful in the future, before we going to support
>>    multi-page sectorsize.
>>
>> However the 2nd one would also add a new corner case:
>>
>> - Order mismatch in filemap and eb folios
>>    Unforatunately I don't have a better plan other than re-allocate the
>>    folios to the same order.
>>    Maybe in the future we would have better ways to handle it? Like
>>    migrating the pages to the higher order one?
>
> As long as it's a no-op for now this is OK, we can do the higher order
> allocation for eb pages afterwards.
>
Yep, it won't cause any problem for now.

Although this corner case is making me wondering if the new
alloc-then-attach is really any better than the original
alloc-and-attach solution.

If the mm (filemap) layer can allow us to allocate larger folios, it may
be much simpler.
The current code only needs to setlarge folio support for the mapping,
then go with high order fpg_flags.
The filemap code is already doing the retry and unalignment check.

But the existing filemap code would also try to reduce the order, which
can lead to other problems, like one extent buffer with multiple
different order folios.
Meanwhile alloc-and-attach gives us full control on the order, thus
allowing all-or-none (one single large folio, or all single page ones)
solution required by the 2nd patch.

Anyway, I would continue with the current alloc-then-attach method to
experiment the higher order folios allocation first to find out all the
pitfalls first.

Thanks,
Qu

