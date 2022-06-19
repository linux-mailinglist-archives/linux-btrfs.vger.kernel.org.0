Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFD1550D58
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jun 2022 23:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbiFSVvE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jun 2022 17:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiFSVvD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jun 2022 17:51:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EABE45
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jun 2022 14:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655675457;
        bh=skRZJ7WW7XLXdo7QHX03ehVEUr+K4XAWFdwX2Jiamyg=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=Vgz5Hi4qCIK1D5DwAFaZsqqaN7DWOct2sKwQMTiEDzV4pHnrKPW3+wUUYM0TziwUP
         xqdLLPgeDRp7Al3tqkaBizr8JAzMIIUSEJ4tvvtgHJlCQGqD+qxaheOTQUykYxDJRW
         5D2r24P6Ueb7lSCmI1qv9WQWFOmJqCYLDN97XSw0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N8GQs-1ngzjs2n0y-0149gv; Sun, 19
 Jun 2022 23:50:57 +0200
Message-ID: <1b21e3e9-cdd9-baa6-bd39-e9489de883ff@gmx.com>
Date:   Mon, 20 Jun 2022 05:50:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220617100414.1159680-1-hch@lst.de>
 <20220617100414.1159680-7-hch@lst.de>
 <59dc5c97-36c6-9737-b7ab-1d4fcfaba2e3@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 06/10] btrfs: transfer the bio counter reference to the
 raid submission helpers
In-Reply-To: <59dc5c97-36c6-9737-b7ab-1d4fcfaba2e3@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OcJXfndhG81h8pS4b1s9vIE9663gt9BPRfVQemdOM9Zg81fTe0Z
 7yet2sj0Gd0sqW7D5fSHfbx2U9JqUsoHQaIJ9yTTRCSW8SBPc5e8aG7p9H65EFD5w/R4QkA
 cuM3p0Z+aLOQNwJ5bWsZO9dUz7hcbds8RqnPcqplMeP5f8bKXJGkzVCIfqYKkHGAF4nNfjP
 /kjCQnmmyByY4fBPnHkiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lv4xWx5PlY8=:i7psa6X3qltxMfAl6vc9W/
 GITyF2clJghUHSTsIu2omvElKl/uHs0tGMKs4BMgbTVzfkRSK8ZAzUw2YLy4Tk9WxjAIazfuH
 bkxRTjAOr20MOAgVm+FLURlM8ndilOcIeeUfXqZOPMTv5mBaz6pbLtirl1Z77Y4TqvaL4qTu0
 wRwG1rG8aWHFpEyIAfwDht3znNvzt1yQb01JgCmfBB/HWN4q33SKdV6TF6ze4RDrkadEn6C8B
 4G184KjbU26Xufby8O4ftwThs6Ad1l6fxlMxHLzAgTctFaklEFiyV7Xtf9JfKepsoHWwu0KeE
 +7l3UDvDLmvwRK3HblVW3KFwmj0/rCH95VSAP2tps+zxXCfu3nGLn1jG+1dwzy03B9fEixfsr
 G177S1ldVpTzmHNmKWXyvCGeLYcJ01+0sKSWS6AmdSlVWQ8ZhY+81Hl6KNrMyOdeZb+ZIU63V
 xtp7iDpIF53SfZbWcvxaSAHrXQBdelZb/Dn94Anjbg471dYE49jW62PGokxxfC/cik4eNc4k3
 BJ3DZE1zpunpeeS4UMPdDJaBTim+ZDYxFJWZnyyL14WzdKlFe687QO4AVglbUWUUqd5arruh+
 uVZvuECWaVcWCFp+5JZ99jn0IJ56Us/Bj/cafOPxu2JMunDbU5960Mr9rA9Vh4qXIbN58qMvA
 JPxdHare0RGqVPJDg2JI+Kca5gdvLxmb9Gg7dRxLrvjuze+EAvQwBdzPgc/5iNfkbLp1cKMbT
 A6i9+zwcMuiBsGJMcSgaUBGFSrK/2gWeTqxQOEiRa/URLY/TnLLqI5VI4QseX3yFzqwrtw1Xc
 zCpZfV00iqkeacW4zMz76FOzzqK7h0liTbzobXk8MdJtgnRC+ynxyMw4dK7onVqKvq/YghLH5
 jGF+6iZkpw1JDcdVa6KcqTPmXGU+FaCs+uoBzrQBJ6xonfUsHLDXmipeweJw2/F6Owz6xgvDj
 OL7Sz+r0r9OWL9veSvcR+lh9Azcr+UvDD6RolWif+1aHge5wswygtLeJWMke3mZ9dNKTPbs/H
 23JLS9e0RMiS9HHD2E/kWXBDjqBvodBxpeQt+XiuW0Uv10OIIYep4+7fDIEc0BDezlob7FQrA
 2dgRctqk7prM2ew7rkcx1MLB6CRqd8ZhR4hQSsTruTnLT5g/Yg+sTWcUw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/19 18:45, Qu Wenruo wrote:
>
>
> On 2022/6/17 18:04, Christoph Hellwig wrote:
>> Transfer the bio counter reference acquired by btrfs_submit_bio to
>> raid56_parity_write and raid56_parity_recovery together with the bio th=
at
>> the reference was acuired for instead of acquiring another reference in
>> those helpers and dropping the original one in btrfs_submit_bio.
>
> Btrfs_submit_bio() has called btrfs_bio_counter_inc_blocked(), then call
> btrfs_bio_counter_dec() in its out_dec: tag.
>
> Thus the bio counter is already paired.
>
> Then why we want to dec the counter again in RAID56 path?
>
> Or did I miss some patches in the past modifying the behavior?

In fact, the bio counter for btrfs_map_bio() is just increased and to
allow the real bios (either the RAID56 code, or submit_stripe_bio()) to
grab extra counter to cover the full lifespan of the real bio.

Thus I don't think there is any bio counter to be "transferred" here.

Yes, you can argue in that case, btrfs_map_bio() should not grab the
counter instead, but unfortunately I'm not able to answer if that's the
case.

But for now, all the existing call patterns are that, the real bios
submission code grab the counter to cover the full lifespan of the bios,
while the counter from btrfs_map_bio() really only covers its execution
time (which is not covering the underlying bios)

Thanks,
Qu
>
> Thanks,
> Qu
>
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>> =C2=A0 fs/btrfs/raid56.c=C2=A0 | 16 ++++++----------
>> =C2=A0 fs/btrfs/volumes.c | 15 +++++++--------
>> =C2=A0 2 files changed, 13 insertions(+), 18 deletions(-)
>>
>> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
>> index cd39c233dfdeb..00a0a2d472d88 100644
>> --- a/fs/btrfs/raid56.c
>> +++ b/fs/btrfs/raid56.c
>> @@ -1815,12 +1815,11 @@ void raid56_parity_write(struct bio *bio,
>> struct btrfs_io_context *bioc)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(rbio)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_put_bioc(b=
ioc);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D PTR_ERR(=
rbio);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_dec_counter;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rbio->operation =3D BTRFS_RBIO_WRITE;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rbio_add_bio(rbio, bio);
>>
>> -=C2=A0=C2=A0=C2=A0 btrfs_bio_counter_inc_noblocked(fs_info);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rbio->generic_bio_cnt =3D 1;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> @@ -1852,7 +1851,6 @@ void raid56_parity_write(struct bio *bio, struct
>> btrfs_io_context *bioc)
>>
>> =C2=A0 out_dec_counter:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_bio_counter_dec(fs_info);
>> -out:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bio->bi_status =3D errno_to_blk_status(r=
et);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bio_endio(bio);
>> =C2=A0 }
>> @@ -2209,6 +2207,8 @@ void raid56_parity_recover(struct bio *bio,
>> struct btrfs_io_context *bioc,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (generic_io) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASSERT(bioc->mir=
ror_num =3D=3D mirror_num);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_bio(bio)->=
mirror_num =3D mirror_num;
>> +=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_get_bioc(bioc);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rbio =3D alloc_rbio(fs_info, bioc);
>> @@ -2231,12 +2231,8 @@ void raid56_parity_recover(struct bio *bio,
>> struct btrfs_io_context *bioc,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_end_bio=
;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> -=C2=A0=C2=A0=C2=A0 if (generic_io) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_bio_counter_inc_noblo=
cked(fs_info);
>> +=C2=A0=C2=A0=C2=A0 if (generic_io)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rbio->generic_bi=
o_cnt =3D 1;
>> -=C2=A0=C2=A0=C2=A0 } else {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_get_bioc(bioc);
>> -=C2=A0=C2=A0=C2=A0 }
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Loop retry:
>> @@ -2266,8 +2262,8 @@ void raid56_parity_recover(struct bio *bio,
>> struct btrfs_io_context *bioc,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>
>> =C2=A0 out_end_bio:
>> -=C2=A0=C2=A0=C2=A0 if (generic_io)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_put_bioc(bioc);
>> +=C2=A0=C2=A0=C2=A0 btrfs_bio_counter_dec(fs_info);
>> +=C2=A0=C2=A0=C2=A0 btrfs_put_bioc(bioc);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bio_endio(bio);
>> =C2=A0 }
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 844ad637a0269..fea139d628c04 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -6756,8 +6756,12 @@ void btrfs_submit_bio(struct btrfs_fs_info
>> *fs_info, struct bio *bio,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_bio_counter_inc_blocked(fs_info);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D __btrfs_map_block(fs_info, btrfs=
_op(bio), logical,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &map_length, &bioc, mirror_num, 1);
>> -=C2=A0=C2=A0=C2=A0 if (ret)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_dec;
>> +=C2=A0=C2=A0=C2=A0 if (ret) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_bio_counter_dec(fs_in=
fo);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bio->bi_status =3D errno_to=
_blk_status(ret);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bio_endio(bio);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 }
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 total_devs =3D bioc->num_stripes;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bioc->orig_bio =3D bio;
>> @@ -6771,7 +6775,7 @@ void btrfs_submit_bio(struct btrfs_fs_info
>> *fs_info, struct bio *bio,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 raid56_parity_write(bio, bioc);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 raid56_parity_recover(bio, bioc, mirror_num, true);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_dec;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (map_length < length) {
>> @@ -6786,12 +6790,7 @@ void btrfs_submit_bio(struct btrfs_fs_info
>> *fs_info, struct bio *bio,
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 submit_stripe_bi=
o(bioc, bio, dev_nr, should_clone);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -out_dec:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_bio_counter_dec(fs_info);
>> -=C2=A0=C2=A0=C2=A0 if (ret) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bio->bi_status =3D errno_to=
_blk_status(ret);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bio_endio(bio);
>> -=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>>
>> =C2=A0 static bool dev_args_match_fs_devices(const struct
>> btrfs_dev_lookup_args *args,
