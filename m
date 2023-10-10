Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3447BF678
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 10:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjJJIve (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 04:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjJJIvc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 04:51:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06432AF
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 01:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1696927884; x=1697532684; i=quwenruo.btrfs@gmx.com;
 bh=ndvCH63Y42vqXMSs4pBh6MbooILqqrPcSspee15cUjk=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=NVTgXek3BBldzRlzp36DEcwAdA9DESXjB0qO0d28CP/LecoeStCfLpDzX3PDbYHvM0Yvfn5eQdW
 f0hca81lEzMWp846EZVuYrxvo45dC9jFIPcqYRPLHlvy8JlPvESOUtaL8/rrXcK2OwnzE9TGz94/Y
 DCrSHJz9yTQpZ1cq7vgKXVc9zXoBnsBWyr9XMJE4K3a2peKIuwkrQ5dfT+41RIFgC9H/A49WJFYgw
 G1X0uI7hYvngxwDUKJ9BVPqhcfs6ILUJpT3cOPgYRZp3djfCQZzxO6R75B6/qef0IbY3pR+4ENzVh
 OCc5l6DjKpwdfqL7RuOU4DZploBRRMSR1rFw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8GMq-1rckup1hU8-0148nq; Tue, 10
 Oct 2023 10:51:24 +0200
Message-ID: <6058a6b8-ef09-4508-a1f4-bf9a2e2b4f11@gmx.com>
Date:   Tue, 10 Oct 2023 19:21:19 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: perform stripe tree lookup for scrub
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.cz>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <4895772fd73872ee2cc23d152e50db28a5ca5bbc.1696867165.git.johannes.thumshirn@wdc.com>
 <cdfbc6c3-d43e-456f-9616-441c3b50a1dd@suse.com>
 <77b7ae4f-d353-46ee-9b35-f7eb64bba110@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
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
In-Reply-To: <77b7ae4f-d353-46ee-9b35-f7eb64bba110@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hPx2iMaboh2S/eRBZSNKOJr2P5NsMAgNtsywW+MWZYw2tunsrEm
 ImhkRYN+e9F8iFN93jfLuIhWfK9hQ8y+DDAgCqUh+1gdV35xIw8KaT1MC4HjA2r9QQpnF8P
 qXfG92qdGiKVsW/gs7at0T2bJK+o38fyjPpgNF42xvAKa25lxSkD6hF/HEBOwpZ+V0SIn4t
 FUnH2IzzFXCfkE2Y90eqQ==
UI-OutboundReport: notjunk:1;M01:P0:1qozYVFxqD8=;JDPnY0U0wc4yYGMAwjxFzxMV+k4
 Ow6yckcmc2FpIlrWse0GrMQ5g6A1tkRQkWNNLG7EY6t/5NDrRdHabPry/0eYxmKQvEvOQR6Tk
 L+fsXCbjyIbjRbWAZv9Q08iV1bGG3Y4gksk5NcwxJbXUkwJwpglaPzQVmjqcZriu8u0HgNjjT
 lyukC6Eu02xir8ra3yjidBXZrypiQA1p2wQw06BgWhWOaJsi3GKC3ptd6h0t2iFHV1Ge5savD
 uAGlUw8FoNm00PwH9bnsJ6K1yXAUe5hOQ8mGbM/BZNhW6AVxteE8WIr8nCeF1MIfpDhFiJJXa
 3kGkZYS03hcJVTaYGCaNWGe6B7CkLAk7z+tAVhq7MZdsWIDmcdAix9E7y2/Bb82Q+qaomqImV
 fQO2nlGtF8169MxZSK/2aOl2Dy5YAlj2wU8WH2EG4s1TbL1a2aUqFcmWY4+GJx6I4e6n9hiBu
 qdaDWrz+ecnqM+CP8LhAOuDdvyLSfNudkM0ef+fBfFvsSFZpbaIwsRWzFInHD1AFGRArVrykp
 ViyIBW/tpXauxq9SqxeRrZTvJkyFzhkeHwRmF1ROKhhSJLq92ALrt1uyzl9CJezq6FK2BunCV
 rnCfxuYoOXKENpkx0lxudPCxLH7rzccU68YV3AWygj5xATmBHxdF8nrkFO2bUPj3qaBGSmJPx
 C5KTTU4g92Hm2ZChkotQvASKFAwyMrU4McfW2TWgg1yqVKJ1vrwFCUXW4EsIOTAjw0Bl5hw+7
 SDDcBeVljhzX1VEb/4PwKFdiMHVLmPgQq6p7flybBe4AcpD8eX6xBk3VrWfRdoWFozlHrgt+3
 uNiIIFU5gn/MNu6I9OzuP24euDPiro4j3JaDZLapQm4mrt7fs24EToo5fQ9JMkEPufBDBWl8n
 cGPxN4Fxe2Hkr5zdqm0M7HW2DP8BXCxaY2t68mpzz+F97z6vU+VtJ/2Inr0MHNLvmvL8MRj76
 axMYpUklB8YyAxGd2q1biK+QWPI=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/10/10 19:07, Johannes Thumshirn wrote:
> On 09.10.23 22:48, Qu Wenruo wrote:
>>
>>
>> On 2023/10/10 02:30, Johannes Thumshirn wrote:
>>> In case we're scrubbing a filesystem which uses the RAID stripe tree f=
or
>>> multi-device logical to physical address translation, perform an extra
>>> block mapping step to get the real on0disk stripe length from the stri=
pe
>>> tree when scrubbing the sectors.
>>>
>>> This prevents a double completion of the btrfs_bio caused by splitting=
 the
>>> underlying bio and ultimately a use-after-free.
>>
>> My concern is still the same, why we hit double endio calls in the firs=
t
>> place?
>>
>> In the bio layer, if the bbio->inode is NULL, the real endio would only
>> be called when all the split bios finished, thus it doesn't seem to
>> cause double endio calls.
>>
>> Mind to explain it more?
>
>
> Hmm indeed you're right. The patch probably only masks the UAF. On the
> other hand, there's no point in submitting a bio for a range that needs
> to be split, if we can avoid it.

This is the opposite IIRC, the idea of introducing bio layer is to move
the RAID stripe split into that new bio layer, so upper layer doesn't
need to bother the split.

The same applies to the RST stripe AFAIK.

>
> Regarding the UAF, the KASAN report points to an object allocated by
> btrfs_bio_alloc() in scrub_submit_extent_sector_read(), so it's the bbio=
.
>
> Let me check if changing bbio->pending_ios from atomic_t to refcount_t
> does give some hints here.
>
> Still I think the patch is still useful regardless of the UAF.
>
>>> @@ -1660,10 +1662,26 @@ static void scrub_submit_extent_sector_read(st=
ruct scrub_ctx *sctx,
>>>     		}
>>>
>>>     		if (!bbio) {
>>> +			struct btrfs_io_stripe io_stripe =3D {};
>>> +			struct btrfs_io_context *bioc =3D NULL;
>>> +			const u64 logical =3D stripe->logical +
>>> +					    (i << fs_info->sectorsize_bits);
>>> +			int err;
>>> +
>>>     			bbio =3D btrfs_bio_alloc(stripe->nr_sectors, REQ_OP_READ,
>>>     					       fs_info, scrub_read_endio, stripe);
>>> -			bbio->bio.bi_iter.bi_sector =3D (stripe->logical +
>>> -				(i << fs_info->sectorsize_bits)) >> SECTOR_SHIFT;
>>> +			bbio->bio.bi_iter.bi_sector =3D logical >> SECTOR_SHIFT;
>>> +
>>> +			io_stripe.is_scrub =3D true;
>>> +			err =3D btrfs_map_block(fs_info, BTRFS_MAP_READ, logical,
>>> +					      &stripe_len, &bioc, &io_stripe,
>>> +					      &mirror);
>>
>> Another thing is, I noticed that for zoned devices, we still go through
>> the repair path, just skip the writeback and rely on relocation to repa=
ir.
>>
>> In that case, would scrub_stripe_submit_repair_read() need the same
>> treatment or can be completely skipped instead?
>
> I think for zoned devices we should go via relocation repair. But
> currently there is nothing that prevents RST form being used with
> regular non-zoned devices (and for the RAID56 write hole fixes with RST
> we'd have regular devies as well) so we need the fix there as well.
>

Can we have a more unified behavior? Like if we go emulated zoned mode
(running zoned mode on non-zoned devices), we just go all the zoned way
by relocation other than in-place write.

Or is the balance too heavy for just repairing one sector?
If so, you may want to considering splitting the per-fs zoned status
between per-device zoned status.
As in that case, we need to determine how the repair should be done.
(in-place write for emulated zoned RST mode, or relocation if that bad
mirror is on a real zoned device).

I have no special preference here, either would work for me.

Thanks,
Qu
