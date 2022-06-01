Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA6553AFCE
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 00:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbiFAVgW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 17:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbiFAVgU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 17:36:20 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE571F615
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 14:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654119374;
        bh=Es8RsQmnkKmIaHXRYhsynXMHVUjTVilbrjpn7wmodPY=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=Vkn9YIcXxyR98BdtxXdypvKFVE/yXExEokQ9kMzS9tULEBgDl5IAucXC72rzrYK+F
         yE5qFeICqZZT5QNTt0RFfUorFbRs4GvWYzcE0RrqqiDhARtO0A5v4RuFYmgHMI8jiZ
         wiui3D4d4ixXGcyu1OyQzuBR6W6aPFR1MGiLVLJw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mlw3X-1nVBYE2GYt-00iyg0; Wed, 01
 Jun 2022 23:36:14 +0200
Message-ID: <5bc82c0a-5dbe-58f3-9025-d02bf1c607be@gmx.com>
Date:   Thu, 2 Jun 2022 05:36:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] btrfs: add RAID56 submitted bio trace events
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <56cbf892eb0bec3b26da3e26f46537e94fb358af.1654076723.git.wqu@suse.com>
 <20220601141209.GO20633@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220601141209.GO20633@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6J0mdLFBWB0qvGL6eRc51wmwClW7MqvNhQrG4Wwr0LWpgtjkRMg
 avDnDm3DXESWLDpuol6csw6L8F9U2ak6AAO49asZ7fQU4FwajIDUzQHxQCq3sUMQx8wpzeW
 I0R/W9Sw4vSKZLeFpsn+/gUTZqLKc5vOpv46hhTo6nrGPZbWAtvUh0XWcds7BxEf40Cs/9K
 Qmd3gjyDkOZmNSlFQizRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YpBC3KMYiwI=:Df9AXkzKckUlGcOuM3n/U0
 RFS3nIJOR1aowgCV3Ow11w9gHvjqcslKUk+RArtDnk4NrwEkOVS54NmZI22rgJiuu0LuwdFSz
 oUwO/FCNDt4hwkiygEYmJGJ7ZrOrxqT3QfTnhQ+YAYno8AoPVisAPRHzsD0kLOkgJVn3mV7XR
 5p3lfVmOGr1uzCVEjo7uv7iLTrr6kZkVfYpbA80o2z/+PYGbRADpn4Q3/ARHvfVILShj2sMhs
 XVWV1YeX9CBU0NiVUAsw9cygyad3ApTn0KVZUqc9umDD0cHqnWcjQYAU4I5W8Kr65hV2P7u+M
 4ryQvBBxaJCFqMGde34BANk2rFn5drEPMNsg/shYkOT5A0PtuMRqCVrj1G34uXK1LzlOxymvw
 nZkhDlGXOYryvdiKt5rmQi0eEeow6APwEK0mIiKSbaeAZATBGkgdsRMZ5iRH8YMi7izHGJX16
 qrWo7HWHLUxdM2K4+VzzvsEx9z+c2FtJqFLsvl9m6+0a08/K6988s/v23Bo/EOVtNzclJqait
 5zGGWDVWdIV3fBbVWhs748r7hTINtgQeRlYzEyEc4IqAR8C3ElEd8flgQDQelNdU1e7Aa0DH8
 VBcGod7WG4Y13mfTFR2HEvuIIl1JkM1iySCAezvJxIi0yBf11V/HFWz9C//BZ0YXCvWLy1ciO
 i+3O+xO3c0ZIQgTGpTKX0TEfAeOypXBuR0W6jlbUyU5hrseg8/0YB40+zl4l8vj6EDUZ49wHv
 YDJ7vK3kS/8UXntTN2kbvSaWIqHBm0GC6Z8DsRb1YlOoiEWCte4YwfdWhtD24B6UNcx0bdniK
 IvNiBMLrglfc4I+aPtSmXbhRr7f0MnxVKfLpjjvcL7OC0LtlV+KZxHzCUxkJMcPlI1RniKIjJ
 wROB0nJvwqPAk7ZkZXhgrDtLo2IV5J3uUmt6QCD7BZhsvxQOu/xN6bBExYhaLi+ma38p5i8B/
 6Mm27HVj0KKHZw7C4mzul2ppqcq9hmoskMqDHguBlm9XT4yqfsI2ukDSmH8fga3OUnjhxpgJK
 0NC0FBwBvjnJjVltr0+YKQMH6X/0KbR2QYtWeqhW2cfTcbG7UBA+aQwy/2Psm7I77QO6fwmAT
 AncYQ2K1eOmd0DBuDXNb1nrQF0YLuDaZm4NMmLURMPr+pdu4Lv/MYYRog==
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/1 22:12, David Sterba wrote:
> On Wed, Jun 01, 2022 at 05:46:59PM +0800, Qu Wenruo wrote:
>> For the later incoming RAID56J, it's better to know each bio we're
>> submitting from btrfs RAID56 layer, so this patch will introduce the
>> trace events for every bio submitted by btrfs RAID56 layer.
>
> I'd phrase that it's useful in general, not in connection with some RFC
> patchset.
>
>> The output looks like this: (trace event header and UUID skipped)
>>
>>     raid56_read_partial: full_stripe=3D389152768 devid=3D3 type=3DDATA1=
 offset=3D32768 opf=3D0x0 physical=3D323059712 len=3D32768
>>     raid56_read_partial: full_stripe=3D389152768 devid=3D1 type=3DDATA2=
 offset=3D0 opf=3D0x0 physical=3D67174400 len=3D65536
>>     raid56_write_stripe: full_stripe=3D389152768 devid=3D3 type=3DDATA1=
 offset=3D0 opf=3D0x1 physical=3D323026944 len=3D32768
>>     raid56_write_stripe: full_stripe=3D389152768 devid=3D2 type=3DPQ1 o=
ffset=3D0 opf=3D0x1 physical=3D323026944 len=3D32768
>>
>> The above debug output is from a 32K data write into an empty RAID56
>> data chunk.
>>
>> Some explanation on the event output:
>>   full_stripe:	the logical bytenr of the full stripe
>>   devid:		btrfs devid
>>   type:		raid stripe type.
>> 		DATA1:	the first data stripe
>> 		DATA2:	the second data stripe
>> 		PQ1:	the P stripe
>> 		PQ2:	the Q stripe
>>   offset:	the offset inside the stripe.
>>   opf:		the bio op type
>>   physical:	the physical offset the bio is for
>>   len:		the length of the bio
>>
>> The first two lines are from partial RMW read, which is reading the
>> remaining data stripes from disks.
>>
>> The last two lines are for full stripe RMW write, which is writing the
>> involved two 16K stripes (one for DATA1 stripe, one for P stripe).
>> The stripe for DATA2 doesn't need to be written.
>>
>> There are 5 types of trace events:
>> - raid56_read_partial
>>    Read remaining data for regular read/write path.
>>
>> - raid56_write_stripe
>>    Write the modified stripes for regular read/write path.
>>
>> - raid56_scrub_read_recover
>>    Read remaining data for scrub recovery path.
>>
>> - raid56_scrub_write_stripe
>>    Write the modified stripes for scrub path.
>>
>> - raid56_scrub_read
>>    Read remaining data for scrub path.
>>
>> Also, since the trace events are included at super.c, we have to export
>> needed structure definitions into "raid56.h" and include the header in
>> super.c, or we're unable to access those members.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
>> @@ -1426,8 +1322,13 @@ static noinline void finish_rmw(struct btrfs_rai=
d_bio *rbio)
>>   	BUG_ON(atomic_read(&rbio->stripes_pending) =3D=3D 0);
>>
>>   	while ((bio =3D bio_list_pop(&bio_list))) {
>> +		struct raid56_bio_trace_info trace_info =3D {0};
>
> 						          { 0 }
>> +
>>   		bio->bi_end_io =3D raid_write_end_io;
>>
>> +		if (trace_raid56_write_stripe_enabled())
>> +			bio_get_trace_info(rbio, bio, &trace_info);
>> +		trace_raid56_write_stripe(rbio, bio, &trace_info);
>
> The definition of trace_info and the call to trace_... should be inside
> the if body.
>
>>   		submit_bio(bio);
>>   	}
>>   	return;
>> --- a/fs/btrfs/raid56.h
>> +++ b/fs/btrfs/raid56.h
>> @@ -7,6 +7,163 @@
>>   #ifndef BTRFS_RAID56_H
>>   #define BTRFS_RAID56_H
>>
>> +#include <linux/workqueue.h>
>> +#include "volumes.h"
>> +
>> +enum btrfs_rbio_ops {
>> +	BTRFS_RBIO_WRITE,
>> +	BTRFS_RBIO_READ_REBUILD,
>> +	BTRFS_RBIO_PARITY_SCRUB,
>> +	BTRFS_RBIO_REBUILD_MISSING,
>> +};
>> +
>> +struct btrfs_raid_bio {
>> +	struct btrfs_io_context *bioc;
>> +
>> +	/* while we're doing rmw on a stripe
>> +	 * we put it into a hash table so we can
>> +	 * lock the stripe and merge more rbios
>> +	 * into it.
>> +	 */
>
> Moved comments should be reformatted and fixed.
>
>> +/*
>> + * For trace event usage only. Records useful debug info for each bio =
submitted
>> + * by RAID56 to each physical device.
>> + *
>> + * No matter signed or not, (-1) is always the one indicating we can n=
ot grab
>> + * the proper stripe number.
>> + */
>> +struct raid56_bio_trace_info {
>> +	u64 devid;
>> +
>> +	/* The offset inside the stripe. (<=3D STRIPE_LEN) */
>> +	u32 offset;
>> +
>> +	/*
>> +	 * Stripe number.
>> +	 * 0 is the first data stripe, and nr_data for P stripe,
>> +	 * nr_data + 1 for Q stripe.
>> +	 * >=3D real_stripes for
>
> This looks unfinished, please let me know what to write the I'll update
> the commit.

Sorry, that's for dev replace target stripe.

Thanks,
Qu
>
>> +	 */
>> +	u8 stripe_nr;
>
> Besides the above comment, I've reformatted the comments and moved the
> tracepoint under the _enabled() condition, patch in misc-next. Thanks.
