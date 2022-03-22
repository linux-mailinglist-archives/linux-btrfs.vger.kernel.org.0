Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4F04E4668
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Mar 2022 20:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiCVTDt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 15:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiCVTDs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 15:03:48 -0400
Received: from libero.it (smtp-32.italiaonline.it [213.209.10.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56AC8E193
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 12:02:20 -0700 (PDT)
Received: from [192.168.1.27] ([84.220.27.216])
        by smtp-32.iol.local with ESMTPA
        id WjlqnqensptnyWjlqnfju5; Tue, 22 Mar 2022 20:02:19 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1647975739; bh=xsVOKAdkH2v0TQL2FiZw7R6MgulR29WQyVpGc3MLwvI=;
        h=From;
        b=hFgBe07OAZIhM6POQgRVsBJf7NFTUse+ZMw9vxjGYbecO8df7aehOiEWI1HxxuplG
         CYljspOOdl1GKg8NRpl3IQAkWPw6omMjT0iC7cGgNpG5LDx0rb6HlHdhaqGYd1Mi3D
         Mq9mvaEbjNKnY/KxTSIfRM6DTzA/8mg1FoqpRqaWgNPicN4fOXm9BWo3PZBTBA5hox
         P4B3TXfBrp8T05Gdm4Oa+/lM2XI2G5k6O5lLFqqjAM9f9yuAwshc0IX0X40IG60e+B
         Q+elWlZXjCaatWGuTx+le9ZxzkryPjRK0BRvabSx+JP6dHwt4IG1xY6A4aw9XY4jJH
         qjCo/D3+pXLXQ==
X-CNFS-Analysis: v=2.4 cv=fIX8YbWe c=1 sm=1 tr=0 ts=623a1d3b cx=a_exe
 a=jMrWlYnwW16pavatx/Gsew==:117 a=jMrWlYnwW16pavatx/Gsew==:17
 a=IkcTkHD0fZMA:10 a=LluS8ZgY1OMtl3kMy4wA:9 a=QEXdDO2ut3YA:10
Message-ID: <956f2fd2-8669-1354-d4e6-417deb67845b@libero.it>
Date:   Tue, 22 Mar 2022 20:02:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 2/5] btrfs: export the device allocation_hint property in
 sysfs
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>,
        Goffredo Baroncelli <kreijack@inwind.it>
References: <cover.1646589622.git.kreijack@inwind.it>
 <aa62c61a0a9858d010d7d3ec67019332bd20d801.1646589622.git.kreijack@inwind.it>
 <YjoP3lreFX3eA4Ic@localhost.localdomain>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <YjoP3lreFX3eA4Ic@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDuEzHeID6l2FK6WxeguoAzxPZPyPsMmbT/iZeWD9yqOHA9fZI2/MJrwJMmQakO28g5HcrFB/p7wS2GJhdXQ/TUzS2szXNQUUgBLDGlNTB7avYnjNOnw
 JW9asj8c1NChb7SlTnyoBn/m1F8x7tvopiZnLV7A+hdaaO69T/hBRjA6Nkk3p1U3xNtDZAKhLUezN8hBkozrsvuF5dLjkox4epeVnooybCg5dztIKAbmYfLO
 PX2GOS+JfMN2f99+UfUChqSJnmaCUqQqY5PN2BFvA1RSoYdl/Q5WPmgbHbAC+xDtvNovtPeAjx5AdroUU5GJQrbo2wQPQ+YYKzdDZEW8elWITqdsuc5Fddqw
 zvjVJDrYqTKAbFPxADnpbwh1NuAFpzDY8v25qGkflS5MWFdocZQrbzJKYq4LqZwQXIL2adez
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/03/2022 19.05, Josef Bacik wrote:
> On Sun, Mar 06, 2022 at 07:14:40PM +0100, Goffredo Baroncelli wrote:
>> From: Goffredo Baroncelli <kreijack@inwind.it>
>>
>> Export the device allocation_hint property via
>> /sys/fs/btrfs/<uuid>/devinfo/<devid>/allocation_hint
>>
>> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
>> ---
>>   fs/btrfs/sysfs.c | 31 +++++++++++++++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>
>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>> index 17389a42a3ab..59d92a385a96 100644
>> --- a/fs/btrfs/sysfs.c
>> +++ b/fs/btrfs/sysfs.c
>> @@ -1578,6 +1578,36 @@ static ssize_t btrfs_devinfo_error_stats_show(struct kobject *kobj,
>>   }
>>   BTRFS_ATTR(devid, error_stats, btrfs_devinfo_error_stats_show);
>>   
>> +
>> +struct allocation_hint_name_t {
>> +	const char *name;
>> +	const u64 value;
>> +} allocation_hint_name[] = {
>> +	{ "DATA_PREFERRED", BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED },
>> +	{ "METADATA_PREFERRED", BTRFS_DEV_ALLOCATION_HINT_METADATA_PREFERRED },
>> +	{ "DATA_ONLY", BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY },
>> +	{ "METADATA_ONLY", BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY },
>> +};
>> +
> 
> The ktest robot complained about this, but also we don't need to be this clever,
> also it looks better to have the flags first with standard tabbing.
> 
Yes, ktest is more fine than gcc. I didn't tough about the fact that outside sysfs.c
allocation_hints[] is not used. If in the future it will be used, we can remove "static".

> struct allocation_hint_name {
> 	const u64 val;
> 	const char *name;
> };
> 
> static struct allocation_hint_name allocation_hints[] = {
> 	{ BTRFS_DEV_ALLOCATION_HINT_DATA_PREFERRED,	"DATA_PREFERRED"	},
> 	{ BTRFS_DEV_ALLOCATION_HINT_METADATA_PREFERRED,	"METADATA_PREFERRED"	},
> 	...
> };
> 
Ok

> 
>> +static ssize_t btrfs_devinfo_allocation_hint_show(struct kobject *kobj,
>> +					struct kobj_attribute *a, char *buf)
>> +{
>> +	int i;
>> +	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
>> +						   devid_kobj);
>> +
>> +	for (i = 0 ; i < ARRAY_SIZE(allocation_hint_name) ; i++) {
>> +		if ((device->type & BTRFS_DEV_ALLOCATION_HINT_MASK) !=
>> +		    allocation_hint_name[i].value)
>> +			continue;
>> +
>> +		return scnprintf(buf, PAGE_SIZE, "%s\n",
>> +			allocation_hint_name[i].name);
>> +	}
>> +	return scnprintf(buf, PAGE_SIZE, "<UNKNOWN>\n");
> 
> Since we have fs'es that won't use this you should just spit out "NONE".
> Thanks,
> 
To me NONE means -> I dont' use it
Unknown means -> it is not a understood value

Because BTRFS_DEV_ALLOCATION_HINT_MASK is 2 bits, and we have 4 possible values now it is impossible to get UNKNOWN.
If future if we increase the allocation-hint bits, and we don't map all the possible combination, it is possible that in the disk it is stored an UNKNOWN value. But it may be VALID for a more newer kernel.


> Josef


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
