Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E0A52B7D4
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 May 2022 12:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbiERKVQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 May 2022 06:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235128AbiERKVL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 May 2022 06:21:11 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA791326EC
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 03:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652869258;
        bh=S6VoJOZyFMksjOUVk4P8I+uTKSQK9IbB8QNoDt6P7/I=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=ADLYK5mK8xOcQxmtNTLtzFzi+T2gTforN69gV3qPjIAVTDAXCpKeOGiZ9VvWt50M8
         +tQwa5StEUaCZYSP+9k38+UA8HMcVy+Ibn3z+cwhv7KUoA7HhQ4ZKbxJ1M05bgimux
         wUwAetuJuMUf1pjg8jHS2UQBgibaYr7/B5rImecs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MS3mt-1oKeag1uIt-00TSEk; Wed, 18
 May 2022 12:20:58 +0200
Message-ID: <779bd017-ad7c-10d0-0943-9c0080c55795@gmx.com>
Date:   Wed, 18 May 2022 18:20:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220517145039.3202184-1-hch@lst.de>
 <20220517145039.3202184-13-hch@lst.de>
 <e2c4e54c-548b-2221-3bf7-31f6c14a03ee@gmx.com> <20220518085409.GG6933@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 12/15] btrfs: add new read repair infrastructure
In-Reply-To: <20220518085409.GG6933@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CBYvAVIGtWDnkGfbFa4UCospGQMnEeTPMC4ttyvrBuIqZg/slip
 jGE8Xwf46PntCt8L3jYPDmNGGRljoCPyIbqm4cNtW/HQlfazHIgIuJ+SUWAzM+d67d7Tqxk
 RDcUzYOTw16eWoJwyzXqB9/5hHk+CmFvw/rxryttzo3rVWMbpJM4/5gCCfYAGMmaTVEQU0C
 lfWOV6dMM9eqZlb9i6Vyw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9H1P16PdNdg=:zzQYr8Qk4MpmDUKTVuQ0qw
 17TMWZA7+Z7ctzRMz97MTX8zFyhS+vqm+RsRmRCCa3M3t/ef3pvVOSYqez7wAEKel/fKLPIxD
 Z0Mbd4dLTv03h8rCSlg0twOyZZ9PCb2sO9ohCMh2Z9G/81fmfcpf5zrMn9WUREwAeoLPCJYh3
 9BttyZ7Os38MclIhBrFzocBmLCPBdTlNqkb0AkJ0yeAwaTdUpt/EHnchjkXkbdZk/tOj6Z+Dw
 mPZ+f1j6feauOS/QdZcThSFCvoNAzVSZD5KoBsgBGtj4hIRWjprXU3/P3/vKvJ+TqX2IC8zng
 Tlf4vBRoUTWxKs/QkuNoOjPEtmbrzYUCDiBX4jMI0chZxiFxzbqOqv8TMzbESCNOA+8md2WXq
 lnv/19ja9vxkQ1C85GVrODRunoILYcYrKFYOwfRBMljr/q5O5NgEiCNFTqrSR1OwjeRewybAq
 qbdzAEoTFrrrmJl+pw3RJjUJl+olUOjBmWaMPGtk7qSjPjntoFS+Unm3MRzggO5VtYHJZX891
 GPxyS9G0gMmDrnYfJFygQ6HbdTydsdB1PAX0Hqm4MEljoRTzAUNrSoe5cm65A/vrecESK8xOF
 PGOCl7GvZxXVHk7tT6fi4nWMQdYxLFtWQIuGT4HIEtYZ6LgiTndVFG2bMk9suJbJZreNAEL1+
 kTccO3tchI9O9Ppz38en7I+ndidCl6J4OSWAxPB64L9BfFc04F+ijRC6ORT5Ch1SzYal99X3F
 JqYAz06MB67mduUGrqZPdxPO573NT7ZyJ7n/96nEFnmXKOXiaXIA7EpdJaso/coY8Eo3pP5r8
 DNp3axZzMWtL073Ixz0kI3iNNOuja32nXOf8/UWyRmBuGA5W+ALVctTDm3ldt4Iu10P1Wc/n5
 /pzy7cCXpcDOk/AF8uFr3biiWlNiIsnOTQKHHsd6Ep6uyq2xxF1v1Q/3m+jOXEePhw0ylvo0U
 A0DcTeYUWd+IXJRTy/vjAn2NLktqfMLcywtM1SCekR3xmu05Cf2NLqQH3eJo/QXvrwFiAwvgi
 U5F17oefPIcizckUXFBibqHOSt1Aac+38scJEYT6VuJUwHoAMb72Olfj8PqZtkgShcVwGIt4g
 Rz5bw4yXRXq26+TDdyEdh2ml2uo9y7PZzOhUD+lTbclaNKDzoIy2za7gQ==
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/18 16:54, Christoph Hellwig wrote:
> On Wed, May 18, 2022 at 07:04:22AM +0800, Qu Wenruo wrote:
>>> +static struct btrfs_bio *btrfs_repair_bio_clone(struct btrfs_bio *src=
_bbio,
>>> +		u64 offset, u32 size, unsigned int op)
>>> +{
>>> +	struct btrfs_bio *bbio;
>>> +	struct bio *bio;
>>> +
>>> +	bio =3D bio_alloc_bioset(NULL, 0, op | REQ_SYNC, GFP_NOFS,
>>> +			       &read_repair_bioset);
>>> +	bio_set_flag(bio, BIO_CLONED);
>>
>> Do we need to bother setting the CLONED flag?
>
> The CLONED flag should never be set.  Except for the one bogus check
> in btrfs that I have a pending removal for it is only used for debugging
> checks.
>
>> Without CLONED flag, we can easily go bio_for_each_segment_all() in the
>> endio function without the need of bbio->iter, thus can save some memor=
y.
>
> bio_for_each_segment_all ignores the iter and walks over bi_io_vec
> directly.  And that is something we absolutely can't do here, as the
> bio reuses the bio_vecs from the failed bio, and depending on what
> failed reduces the size.

My bad, I see the bio_alloc_bioset() but didn't check it's allocating a
bi_io_vec with size 0, and soon utilize the original bi_io_vec.

So the function matches its name, it's really bio clone.

And it's very different from my version, which really allocates a new
bio with larger enough bi_io_vec then adding back the needed sectors
from the original bio.

Then I guess the BIO_CLONE flag is completely fine.

But in that case, you may want to call bio_alloc_clone() directly? Which
can handle bioset without problem.
>
>>> +	/*
>>> +	 * Otherwise just clone the whole bio and write it back to the
>>> +	 * previously bad mirror.
>>> +	 */
>>> +	write_bbio =3D btrfs_repair_bio_clone(read_bbio, 0,
>>> +			read_bbio->iter.bi_size, REQ_OP_WRITE);
>>
>> Do we need to clone the whole bio?
>>
>> Considering under most cases the read repair is already the cold path,
>> have more than one corruption is already rare.
>
> The read bio is trimmed to only cover the bad area, so this already
> potentially does not cover the whole failed bbio.  But except for
> the case you note below we do need to write back the whole bio.
>
>>> +bool __btrfs_read_repair_end(struct btrfs_read_repair *rr,
>>> +		struct btrfs_bio *failed_bbio, struct inode *inode,
>>> +		u64 end_offset, repair_endio_t endio)
>>
>> The reason I don't use "end" in my patchset is, any thing related "end"
>> will let people to think it has something related with endio.
>
> That seems like an odd conotation.  Without io in the word end just
> conotates the end of a range in most of the Linux I/O stack.

OK, thanks for explaining this, I guess it's my problem linking "end" to
"end_io" or "endio".

Then no problem using this current naming.

Thanks,
Qu
>
>> And in fact when checking the function, I really thought it's something
>> related to endio, but it's the equivalent of btrfs_read_repair_finish()=
.
>
> But if there is a strong preference I can use finish instead of end.
