Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011C4421ED5
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 08:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbhJEG0u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 02:26:50 -0400
Received: from mout.gmx.net ([212.227.17.21]:37287 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231597AbhJEG0t (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 Oct 2021 02:26:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633415097;
        bh=ynhLphjoi8sPoFnY5ipySJYNqYdw4DaEREzXi2dE3Oo=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=FV0ya7DruYbXkJw1gx6sukLrZPygL0XPfOlLs33EyAliGCRBedG56bwYcoGHzj9SA
         Cjj5p9SDLKJxqXluw1PcNoS/NoDOAyjKeEDyZZgAPveggxTlPBhOhyDroVp2tY1W8G
         J0mMPjig1p5/g10f0r2JTQSxKr+7kV5jaufBEb2I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4s0t-1mXuT12iMJ-00235i; Tue, 05
 Oct 2021 08:24:57 +0200
Message-ID: <93270dd7-df09-793c-9ee5-9a756ad30196@gmx.com>
Date:   Tue, 5 Oct 2021 14:24:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v3 12/26] btrfs: make btrfs_submit_compressed_read() to
 determine stripe boundary at bio allocation time
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210927072208.21634-1-wqu@suse.com>
 <20210927072208.21634-13-wqu@suse.com> <20211004201054.GD9286@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20211004201054.GD9286@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i4DSFAwPWw9p5anHuZY5dx26GhylMX/jEN75JWEXxuElpLMBBNH
 cADF/me8VJy8S6awRvy/T8d6wsyWf+jVg0kVr0Yd2W9GgGEZZHclsYWKy7oeFIBPlZx7Uas
 ITSOnrBic6XmoVitlnrjIcldjsqMyGU9i7cLhVI7SASOGxz91oYLLgbdOXowkJ+0Rsmp7Pa
 xg6HFH15OEP6SCQx8CS1Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bbl5ARqe7WI=:ZwWgdIbuImgt/kHB8hgevO
 hq7eUKzRV1BqcgbJLm4+Yy5/ic7SZeYObzvj3eH2qxFtpl+0N1j2huXXEib2XeaqoR29wPO9i
 WmPbDUBIKGE38l4splQMp73f+GrPEAvSaw3bsp3b4r/B/GWkGCr4jqYCyYTC+AGrxGgtYzNn8
 0+0jxIaIh6Q6xnRGDq6ScHt7VWKhs68XekRvOlhSvnCTtixDXUx7yFc7lZOHjFeKunL6MOOz9
 VHG4/kbPOqP07CKRTlXjRUs8qBbWfOCGwgWxXqAKB/RRlbCvZ+5x4ppTUulgijViyujSFClsA
 i2NFOKYYYnQ4Z/GBbSDoBMP6AyRbjvWlzRkk8tQR7Vdr06uc0K7xmXeGfSDqfWwq0rOWyU0c/
 u9sn/DrBnmWEy8R2CTu5otBlngGvTmCslLhEveVFD2jvzUZMR2hwrKW4m/R9lV2b9UW36Kdh2
 naop+YcjFbJC94N5sHNxWZ9rSNMNqYrXNnT5CYda8dMez0Sqpqu2c3Q4V9E6PyST8GYCqBIv1
 bst8WhJQvPH47ttQUFri6eZk97t41F7w+qZo6H/IASFqHDozQb+9joL3LeeCQPFE87BH6lDYm
 zyHGhgBOUpZLDKw8C26Zo8+SbaF+cNFvLFBA7oMY4pctl8J3fvNpleSB8BKcJ71koG46Avote
 nilHzeeVYTr6FAUNgHRgKH48hJgVk6dRtL4QixkeHWIP5tTWpzKIQzThYOuC4ZetGhYrUCcIK
 TxYXjwIZ36ObUi1IXsx9Gjt97JrQrqZp15rV56aK5gzgU9uFUuw8/b2V3GeR4DQIt7LFx4KdG
 eHTH7avtbYjZtmLxaq9xyVGWQcPL+GPcESIRv8MQldq48dmWlnx154UucLnXcGFt1xL9G5hQC
 UeDR2/WdYILH1aHp0NW0SVJozJeT09QguZcQJXYBsXLk73YdDZoGZ1M4iRRPmwz5R/FPRUanA
 1+Np1WgdEGramOff9MTmGb1WzVyUx/9XGmrvMFpXoM+CBz45Mcq1SOLiBmZ3qw7pZjfV7is2T
 iwuPsJUhznK+ScYiU4vmzjqaOYOaarB9u5xGUS8RQnw2AG5qO7qmvecfPwCmCzcqPuIf4lSt6
 VbvypMBrrzcue8=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/5 04:10, David Sterba wrote:
> On Mon, Sep 27, 2021 at 03:21:54PM +0800, Qu Wenruo wrote:
>> Currently btrfs_submit_compressed_read() will check
>> btrfs_bio_fits_in_stripe() each time a new page is going to be added.
>>
>> Even compressed extent is small, we don't really need to do that for
>> every page.
>>
>> This patch will align the behavior to extent_io.c, by determining the
>> stripe boundary when allocating a bio.
>>
>> Unlike extent_io.c, in compressed.c we don't need to bother things like
>> different bio flags, thus no need to re-use bio_ctrl.
>>
>> Here we just manually introduce new local variable, next_stripe_start,
>> and teach alloc_compressed_bio() to calculate the stripe boundary.
>>
>> Then each time we add some page range into the bio, we check if we
>> reached the boundary.
>> And if reached, submit it.
>>
>> Also, since we have @cur_disk_byte to determine whether we're the last
>> bio, we don't need a explicit last_bio: tag for error handling any more=
.
>>
>> And we can use @cur_disk_byte to track which range has been added to
>> bio, we can also use @cur_disk_byte to calculate the wait condition, no
>> need for @pending_bios.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/compression.c | 164 +++++++++++++++++++++++-----------------=
-
>>   1 file changed, 93 insertions(+), 71 deletions(-)
>>
>> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
>> index 1b62677cd0f3..319d39fd1afa 100644
>> --- a/fs/btrfs/compression.c
>> +++ b/fs/btrfs/compression.c
>> @@ -439,11 +439,18 @@ static blk_status_t submit_compressed_bio(struct =
btrfs_fs_info *fs_info,
>>
>>   /*
>>    * To allocate a compressed_bio, which will be used to read/write on-=
disk data.
>> + *
>> + * @next_stripe_start:	Disk bytenr of next stripe start
>
> Please send an incremental followup to also document all the remaining
> parameters. We're not strict about the kdoc warnings but if the code
> gets touched it's better to complete it.

Sent, can be found here:

https://lore.kernel.org/linux-btrfs/20211005062144.68489-1-wqu@suse.com/ra=
w

Thanks,
Qu

>
>>    */
>>   static struct bio *alloc_compressed_bio(struct compressed_bio *cb, u6=
4 disk_bytenr,
>> -					unsigned int opf, bio_end_io_t endio_func)
>> +					unsigned int opf, bio_end_io_t endio_func,
>> +					u64 *next_stripe_start)
