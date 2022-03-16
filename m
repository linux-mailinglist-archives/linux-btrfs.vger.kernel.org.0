Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EDA4DBB14
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Mar 2022 00:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239550AbiCPXb5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Mar 2022 19:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbiCPXb5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Mar 2022 19:31:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E66167C0;
        Wed, 16 Mar 2022 16:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647473434;
        bh=rK/jWEulh9ssWmz2krX0rC0OcdJw22aqasKTpxCx6ws=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=TfUOVntrqKpRQSwwyVS1p2X6E6DBz3uJWhwAoouuK/HuCOPUXsQ4XgL4/SShcU+27
         tVR+3Mg9J54KWoTXI7S7pvU4X7kYO79nqEdBh/ApDT6l1BGEDPX110uUbG5yEmPR7X
         5SxCa8rbAd5R2ZcvoisNJb85DW05STzlO70gqPfw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MNKhm-1njOoy0auw-00Oq4X; Thu, 17
 Mar 2022 00:30:34 +0100
Message-ID: <99f7371d-f818-f533-d82b-71729a5bfb9d@gmx.com>
Date:   Thu, 17 Mar 2022 07:30:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 11/17] btrfs: make dec_and_test_compressed_bio() to be
 split bio compatible
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com
References: <20211201051756.53742-1-wqu@suse.com>
 <20211201051756.53742-12-wqu@suse.com>
 <YjI+hkhhTTWMmPkz@localhost.localdomain>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YjI+hkhhTTWMmPkz@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gIK32EJoOO5bu//AY9fiTTXVQGmcy8/RH/SJQkoLy1CqCCD6YXU
 Aj7i0u6LDFMEVOMHUFzRgdiGVdhM5b/YEVbhmI1oH9t2Xya7fdVSWDF8NV6vqlQVEyb5yIG
 gSt4ibL2JA2J8+L1sWs6/VWl3GpOD0YfauA9tJ4pAIY6tMWbN3EKSTvfiDq0Q0iZhO18I95
 0ynMUpHrleUlAOhHlcB3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G/+nrPI6jcc=:K/mLfXhJc31KhMjgACSmUf
 yPezyPL/7b7u6w5LSlGltvz6UozPQxuboZ/K6cPrzPI5fFA6P7FuStf05UA/uURA3mNTuZE+F
 WRqvEU/yCMGnIzf3NuqJEjnPe9UCIEGPk9Z24wRgU+oz0O18acjEFc5KobhkUA4h0SmKLmKeS
 yvsLBiPbftH1BvvGg4fiE4fYyK8lQR0oTJLfF6drx+79qehBslYlhc5Xlro/byHGw9Ea39QLg
 ip9v7vyAJxw3xWhIt8/HPZMvlTJ9kzd0tdPGVQ+0GCtj9WGACdoR4VNDBJ//0Rxo89FwcWFN/
 JFTYqiq5BKeHMlpj+99lE+Q5sS3xqV9DNZXDkZC7Yi2ITbBQt+YtihPhs5A9yKndLO/4Bn3pH
 HgoWU1nM8HpPmrgDjRlUngUbVdHLuA6oNznkO5bVppm3Yts34Ai6vNPp0uA5sb0VETUWgCCQd
 rzq0LzkxsaYtkKJKa36ajxaxGqlFCp4Qj7x+lEEUepeiR7dwtkmlNajWPmDanfNJMinujhw1y
 YSYL3apD2oUkxtLNnWMpKVbYnXiMVA1Q/xU1+f1CsC5CGsMEQognWfGyAeU1wSiz+BIqyc7/i
 LeSDqiN/N23UD35mnu2h+4ci1awwPmbKCyWC+HXb5d3j5tUj9wpuOZqYa5NP7rTPaFKhzmcyk
 rNQEduop8lz0OYWOybr2zvHHiDajsJg4SDP4qDFcpaVuKdXD0QMtjwZYEKjSZ/HcJqa7j2W7s
 aD07hMJgRUR/X7YKQqDOKIALzX+zu9kskvJVIEdq+ovi1Do9yPVsur8BwkwMW/RHxMuGjImkA
 iYTb6yA/nZUCm+6N037oo7c6oGTf9u9LTNXargMkQdIKhA7tis30pXIMBiod6wgguinkZCm5+
 PcG3utB8XI08CG9f/P0li+YPFIgHMq02cq6cqZgUUtdtv59BHGKzyQN7M4TVJUY/nexmTLu1D
 Vz5LwQL2RRrWIFFPB3NezuKYHXcOjZcLUTYCYtqjMGKV89bNw+/M6emRvNFE7DGdeZfo9gaor
 KNIowE6OiqraVG2/mmIfASVbgJGExuJPOM4ebfBHD2da6uoSMl+4WUZyv+ROL+uB+L9W539+Q
 bPc//0d8l07/ng=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/17 03:46, Josef Bacik wrote:
> On Wed, Dec 01, 2021 at 01:17:50PM +0800, Qu Wenruo wrote:
>> For compression read write endio functions, they all rely on
>> dec_and_test_compressed_bio() to determine if they are the last bio.
>>
>> So here we only need to convert the bio_for_each_segment_all() call int=
o
>> __bio_for_each_segment() so that compression read/write endio functions
>> will handle both split and unsplit bios well.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/compression.c | 14 +++++---------
>>   1 file changed, 5 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
>> index 8668c5190805..8b4b84b59b0c 100644
>> --- a/fs/btrfs/compression.c
>> +++ b/fs/btrfs/compression.c
>> @@ -205,18 +205,14 @@ static int check_compressed_csum(struct btrfs_ino=
de *inode, struct bio *bio,
>>   static bool dec_and_test_compressed_bio(struct compressed_bio *cb, st=
ruct bio *bio)
>>   {
>>   	struct btrfs_fs_info *fs_info =3D btrfs_sb(cb->inode->i_sb);
>> +	struct bio_vec bvec;
>> +	struct bvec_iter iter;
>>   	unsigned int bi_size =3D 0;
>>   	bool last_io =3D false;
>> -	struct bio_vec *bvec;
>> -	struct bvec_iter_all iter_all;
>>
>> -	/*
>> -	 * At endio time, bi_iter.bi_size doesn't represent the real bio size=
.
>> -	 * Thus here we have to iterate through all segments to grab correct
>> -	 * bio size.
>> -	 */
>> -	bio_for_each_segment_all(bvec, bio, iter_all)
>> -		bi_size +=3D bvec->bv_len;
>> +	ASSERT(btrfs_bio(bio)->iter.bi_size);
>
> We're tripping this assert with generic/476 with -o compress, so I assum=
e
> there's some error condition that isn't being handled properly.  Thanks,

Thank you very much for catching it.

It turns out the ASSERT() is really helpful to detect uninitialized
btrfs_bio::iter.

The problem is related to two call sites:
- btrfs_submit_compressed_read()
- btrfs_submit_compressed_write()

The compressed bio doesn't have its iter properly initialized for error
path, thus it's causing the problem.

Just two new lines and the problem can be fixed.

I'll refresh the patchset.

Thank you again for catching this,
Qu

>
> Josef
