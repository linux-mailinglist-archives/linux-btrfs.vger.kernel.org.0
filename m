Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EA2550D53
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jun 2022 23:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbiFSViJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jun 2022 17:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiFSViI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jun 2022 17:38:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40D65F7F
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jun 2022 14:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655674679;
        bh=sbZRAAlUFPmKQCDieiEPgjbT87AVa2sfJDKbCB5cOLc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Sj890q/bIyFkpRDFN3twgmMr8REGjPAWBmDg/1JYTmBctZk23CvLgYPp8EAk/hRex
         +UQFv5DeCpQmO9C+ZWKotFr5lehZS7kW0KueyIabSmV1gzK2LGsv/FCuW/OEbtXClg
         W429BGJois7/uHagf5PhsB0eN5nlNrnV5HoyuAjw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mkpap-1nGokz40Jr-00mGOY; Sun, 19
 Jun 2022 23:37:59 +0200
Message-ID: <f787a218-5f40-5d8f-2817-7cca666c5e1a@gmx.com>
Date:   Mon, 20 Jun 2022 05:37:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] btrfs: output mirror number for bad metadata
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <ae3c7264a3aefe55c64e3c6a0426289800023742.1655646447.git.wqu@suse.com>
 <20220619221013.BD1C.409509F4@e16-tech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220619221013.BD1C.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gXG08BNYm/4EoeW/2sjXud2KIVK1z+SGT5OmBJK5BkmQitnGSWo
 5halv77LAJjCQywYluM2l7pw0kWzFI9ZdrQqCfLGY9rheV2FNkjzW4FLP+mTyyXiUPmr0KL
 FCh1DX+qC+5hipDRujU7wbKjFRmrhSZssmeS6JIxbXI4ImU26ZXHuFhqIT2I52tob+5dVVF
 nFBb84iwaPo2vthjb+Www==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+GaMuxBiqrs=:wAq84HKUGZakkC/7oC1LdI
 RKG1j6h0m4GmzINHS1LOmAx8TterX2b+ncC7wdlayCO8uFTVcYeMBssY8+nBHzcdoqRc+Yw+S
 7h4LRmJ3lsWvwlgsQ5GOK+qSEDfHdSp0OGRUcJZlxYNKtN65XpDf1a0h6lcnwNHQoblgkXyP9
 VpYri7R/ZzHM4eQ70HTxvXk/xN7cS2h1bbP5/trjX5v9VGcc95TnjoTFn/+Ssey6ntbh9jZY5
 WH0CL3/wu1YKbaTQ69SqHn2tWeTODO8xr7jHOEqMQMb/VkThwmGTVycUBa7911GExhMSZ6YA3
 3HcCwIE1UgBL/OoW2wN/KUUFpKbVS4uQcamXhoT25FWLDnEdgnmXZMkgW6TxkzWiWLn9EctE1
 Ap/ALRHN4wjLl37NhW20qF/ckqISSlhR1RX5gS80MEqDpogA8016Fj1ervOlrA/X3IerZKe5I
 /GP/4No7kQGa2/6TRIqLtZjAbkwEYYHa8WieSS9JWIYrLx+5+0ISVpaATAj6Zsn/ah2q0CSsY
 DvxFHSwpmBNE8I+EsVVi9t5/kJkp+d//8jtsS/t03BVRdZXLbLbSCDOka0+DEbMeCu1W0DKaP
 uBjfVvFmJKvi0cWm7nHYx7Al7OgUC5WKQFiQNZ5QfX+oz6OJdfVZU6ZQ3/TX3SuBHQkgyYZvt
 NHSfhzvtGUlYnfX7LFZJN12wSFlArw8vzsGK/c1EvhrnKyCtbewj4yiSgQ4IDLjqgVjQUyCft
 a1CofqvbvUUxcnzoyp0nt2Lpg+4Z9Fjw3WgDlqjYG9DBP3Ru6C3MsVlNc6mcymIz6ebDJHbVG
 7yWhB6kfkPi/pMoUny7mftbsXaHPDReTG68eEHEJLkwnRwR9n+S9bxk2hglhgxS/evNOStgvT
 AwhPCLKJAYf5HkqCqas2xomQlDAmhsyVGS8V0BqsWI425mtqKGXl/I+0+JEGUy79DY6FHcXE/
 9vXJY+YTPDwEnCqgoO88GKREfr94CNWddHB0VuqIPtMWLA+uWlUce0ZaJS6aRgKNtg5IRoYAB
 ErV2qPYtuXf7HKWt50yFa0SCzOntvRqIEpP3Au5Xpw/TvpsRbREhVPtTAUuHvkAhRi/mIXPFe
 KPFhNtog12j45hORfb1ilp30fZZPTDU+xi5laqj2J3d2LZvNrPiX4JgMQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/19 22:10, Wang Yugui wrote:
> Hi,
>
>> When handling a real world transid mismatch image, it's hard to know
>> which copy is corrupted, as the error messages just look like this:
>>
>> BTRFS warning (device dm-3): checksum verify failed on 30408704 wanted =
0xcdcdcdcd found 0x3c0adc8e level 0
>> BTRFS warning (device dm-3): checksum verify failed on 30408704 wanted =
0xcdcdcdcd found 0x3c0adc8e level 0
>> BTRFS warning (device dm-3): checksum verify failed on 30408704 wanted =
0xcdcdcdcd found 0x3c0adc8e level 0
>> BTRFS warning (device dm-3): checksum verify failed on 30408704 wanted =
0xcdcdcdcd found 0x3c0adc8e level 0
>
> Is this case like the flowing:
> metadata minor 1: updated with new data
> metadata minor 2: old data
> data minor 1: old data
> data minor 2: old data

It's a crafted case that all metadata copies are corrupted (0xcdcd is
the default xfs io pwrite pattern)
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/06/19
>
>
>> We don't even know if the retry is caused by btrfs or the VFS retry.
>>
>> To make things a little easier to read, this patch will add mirror
>> number for all related tree block read errors.
>>
>> So the above messages would look like this:
>>
>>   BTRFS warning (device dm-3): checksum verify failed on 30408704 mirro=
r 1 wanted 0xcdcdcdcd found 0x3c0adc8e level 0
>>   BTRFS warning (device dm-3): checksum verify failed on 30408704 mirro=
r 2 wanted 0xcdcdcdcd found 0x3c0adc8e level 0
>>   BTRFS warning (device dm-3): checksum verify failed on 30408704 mirro=
r 1 wanted 0xcdcdcdcd found 0x3c0adc8e level 0
>>   BTRFS warning (device dm-3): checksum verify failed on 30408704 mirro=
r 2 wanted 0xcdcdcdcd found 0x3c0adc8e level 0
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/disk-io.c | 25 +++++++++++++------------
>>   1 file changed, 13 insertions(+), 12 deletions(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 800ad3a9c68e..506d48b5fd7e 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -220,8 +220,8 @@ static int verify_parent_transid(struct extent_io_t=
ree *io_tree,
>>   		goto out;
>>   	}
>>   	btrfs_err_rl(eb->fs_info,
>> -		"parent transid verify failed on %llu wanted %llu found %llu",
>> -			eb->start,
>> +	"parent transid verify failed on %llu mirror %u wanted %llu found %ll=
u",
>> +			eb->start, eb->read_mirror,
>>   			parent_transid, btrfs_header_generation(eb));
>>   	ret =3D 1;
>>   	clear_extent_buffer_uptodate(eb);
>> @@ -551,21 +551,22 @@ static int validate_extent_buffer(struct extent_b=
uffer *eb)
>>
>>   	found_start =3D btrfs_header_bytenr(eb);
>>   	if (found_start !=3D eb->start) {
>> -		btrfs_err_rl(fs_info, "bad tree block start, want %llu have %llu",
>> -			     eb->start, found_start);
>> +		btrfs_err_rl(fs_info,
>> +			"bad tree block start, mirror %u want %llu have %llu",
>> +			     eb->read_mirror, eb->start, found_start);
>>   		ret =3D -EIO;
>>   		goto out;
>>   	}
>>   	if (check_tree_block_fsid(eb)) {
>> -		btrfs_err_rl(fs_info, "bad fsid on block %llu",
>> -			     eb->start);
>> +		btrfs_err_rl(fs_info, "bad fsid on block %llu mirror %u",
>> +			     eb->start, eb->read_mirror);
>>   		ret =3D -EIO;
>>   		goto out;
>>   	}
>>   	found_level =3D btrfs_header_level(eb);
>>   	if (found_level >=3D BTRFS_MAX_LEVEL) {
>> -		btrfs_err(fs_info, "bad tree block level %d on %llu",
>> -			  (int)btrfs_header_level(eb), eb->start);
>> +		btrfs_err(fs_info, "bad tree block mirror %u level %d on %llu",
>> +			  eb->read_mirror, btrfs_header_level(eb), eb->start);
>>   		ret =3D -EIO;
>>   		goto out;
>>   	}
>> @@ -576,8 +577,8 @@ static int validate_extent_buffer(struct extent_buf=
fer *eb)
>>
>>   	if (memcmp(result, header_csum, csum_size) !=3D 0) {
>>   		btrfs_warn_rl(fs_info,
>> -	"checksum verify failed on %llu wanted " CSUM_FMT " found " CSUM_FMT =
" level %d",
>> -			      eb->start,
>> +	"checksum verify failed on %llu mirror %u wanted " CSUM_FMT " found "=
 CSUM_FMT " level %d",
>> +			      eb->start, eb->read_mirror,
>>   			      CSUM_FMT_VALUE(csum_size, header_csum),
>>   			      CSUM_FMT_VALUE(csum_size, result),
>>   			      btrfs_header_level(eb));
>> @@ -602,8 +603,8 @@ static int validate_extent_buffer(struct extent_buf=
fer *eb)
>>   		set_extent_buffer_uptodate(eb);
>>   	else
>>   		btrfs_err(fs_info,
>> -			  "block=3D%llu read time tree block corruption detected",
>> -			  eb->start);
>> +		"block=3D%llu mirror %u read time tree block corruption detected",
>> +			  eb->start, eb->read_mirror);
>>   out:
>>   	return ret;
>>   }
>> --
>> 2.36.1
>
>
