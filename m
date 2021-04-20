Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C58364FC0
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Apr 2021 03:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbhDTBQW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Apr 2021 21:16:22 -0400
Received: from mout.gmx.net ([212.227.17.22]:60529 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229994AbhDTBQV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Apr 2021 21:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1618881346;
        bh=2bBlqc3QhWvCGGJYovevdH1IeB1n0khKAxDawJVRS4o=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=So2KoLLdlswEA/o42eEqAaTuGRIs7pMEehBBUK7/2X87F8fUT1QKwjuEdlNkrNnAe
         m+Slg5gbC9L6/U3CZgiQH6UYYnlSbOBdj/8+fQ/Tk8PsD2/gSGdH98nIR7QxBxJV0w
         +a4AFU7VwgysN0imyCu+UPWpsCk3192sw1Kjt1Io=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MyKDU-1limMP36WS-00yjtn; Tue, 20
 Apr 2021 03:15:46 +0200
Subject: Re: [PATCH v2] btrfs-progs: mkfs: only output the warning if the
 sectorsize is not supported
To:     Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20210419064512.92213-1-wqu@suse.com> <YH2wTkX/coo94uTF@zen>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <2a07368b-8185-a268-2ed6-7cb73583f066@gmx.com>
Date:   Tue, 20 Apr 2021 09:15:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YH2wTkX/coo94uTF@zen>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lFtwNkgPknnp5o6bx+dtAqQO1tz4GGAoOPWQXLzWpIhyxDZLw0d
 BMwWNoIRQVy2JUxwSWAyFOYuDTBNwZdn/82YB8b5hneu0smuyovMJEtI0664eS6Rv2NizxX
 730zXCq043fIOz4Duyvxl1s0UiYWtBLQWhf/enTiMSO2QJwjIEFRHTBA1mOenqY3OCfFPz8
 gg6aGWiCPmWeGZ2IxhYrg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nvu9rm7rPKc=:eF7SAmo3DaY8tAg5RAtgh+
 LjcSsaT32nl9KdC4znYxqVBwtG/eDPMSYGa95plbLS3dAAuIqAcf+CV0wG+6JmUfXHfjjuKsY
 HMA6VSQbusKwCM+Umoti9UqFVaBsHFc0TKV3kpngcwVcfqJF9KOVN/6bKGMhVM1F6EQy0t8LN
 5EahZvQhP8SkbLPHlXz8XgaoYOw2rReMRwfKsvwjQZlVigv+5laD2TdWeS6K0JFj6eC4ylfH3
 TJsqPrd30hTfKmY1IFmVVdB71Wwk2qzLrtUQxtSRFI+NHrq4roWIDzlgwQXv29vJOlo9AvZgd
 gfsxo9MRXIb2ihdzm40cV+hy0Az7zH8X3kKfNcN6EhkuI1C1VM1ircTh4uZvGqLhrc/B+OTxb
 df44cfKZMq7cnMDgrbydASLz6tM1Hp77XA/YLoRL/pgXnO8p2LhFezskpeq74q5vJpgltw3XF
 iYdrVqOxkCXit0ff/CJo7dQh0FKHbjX0y2wDY9DK0lS7p5/BXanqo8zBtG8Xvcc+wfSTDdeLg
 0DE6n62gXH9u2tMsd7zzcqI0cAncmh0t606kY1jM7ZEu0GfXF/qSPy7oW46B/kPhr/ocV/qBA
 6c/jNDPxdaKeZnuc6wZtrjSX3HIglttSNycx6dD3gzya//LdWhUTILTDNiWLpg8M/nnJqmheY
 yFNEd34G1N20gPUxjJN8sRFpzEAMCWdO98OSviwkRrp1BcYmtRuVfeqCOFdqKq9qbDlJqv1U3
 zPP3PYHqIOedDylcH8Z3TiQ79XGORsWi3uwL4DUusUHWbC0td/FcXEHhnGhXKKXZuL4j7nOCz
 H/u1Cb0/U3gp2l4bJLcaxAMLAe/ybWiAPiJPMSam7T1ypBG8vJrgIROxnMwN1RMjMoUDb8jKu
 Po0LTL1bWZNtg7kdDI+h3+s3SAZjTiLZjcCzXZnTaW4dHj2TBL0EmUC0uEfC4C0VyPN9JFhsL
 F5GWa5TYAlZw7FysXGEpQjE4jxH1dKs4MU08Av7iTm8MDi6si6Dc9qX2e0Jas5rsggAdv5Zia
 UTaLW5FXEvdHeUxN8F+cMTE3lRq7yjGy+gzm/XZEm5iQETFCCnVZ3QoR88DfWCPPISOTs3mZc
 8NWF1npinbmzFTwsND9nKZY5sZhBafUJfmdW2V2ojfpvg93kJlCkY233kmpjJCawJxCFMuvzD
 kAr1DBQvCvDcvgxVQb65utkVsqibx/i0YPjXYv6KgFau3nG66iKaKaavwLzVhEv6HZCM9/mjn
 IN1yVn3SzMhYELV9a
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/20 =E4=B8=8A=E5=8D=8812:31, Boris Burkov wrote:
> On Mon, Apr 19, 2021 at 02:45:12PM +0800, Qu Wenruo wrote:
>> Currently mkfs.btrfs will output a warning message if the sectorsize is
>> not the same as page size:
>>    WARNING: the filesystem may not be mountable, sectorsize 4096 doesn'=
t match page size 65536
>>
>> But since btrfs subpage support for 64K page size is comming, this
>> output is populating the golden output of fstests, causing tons of fals=
e
>> alerts.
>>
>> This patch will make teach mkfs.btrfs to check
>> /sys/fs/btrfs/features/supported_sectorsizes, and compare if the sector
>> size is supported.
>>
>> Then only output above warning message if the sector size is not
>> supported.
>>
>> This patch will also introduce a new helper,
>> sysfs_open_global_feature_file() to make it more obvious which global
>> feature file we're opening.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> changelog:
>> v2:
>> - Introduce new helper to open global feature file
>> - Extra the supported sectorsize check into its own function
>> - Do proper token check other than strstr()
>> - Fix the bug that we're passing @page_size to check
>> ---
>>   common/fsfeatures.c | 49 ++++++++++++++++++++++++++++++++++++++++++++=
-
>>   common/utils.c      | 15 ++++++++++++++
>>   common/utils.h      |  1 +
>>   3 files changed, 64 insertions(+), 1 deletion(-)
>>
>> diff --git a/common/fsfeatures.c b/common/fsfeatures.c
>> index 569208a9e5b1..6641c44dfa45 100644
>> --- a/common/fsfeatures.c
>> +++ b/common/fsfeatures.c
>> @@ -327,8 +327,50 @@ u32 get_running_kernel_version(void)
>>
>>   	return version;
>>   }
>> +
>> +/*
>> + * The buffer size should be strlen("4096 8192 16384 32768 65536"),
>> + * which is 28, then we just round it up to 32.
>> + */
>> +#define SUPPORTED_SECTORSIZE_BUF_SIZE	32
>> +
>> +/*
>> + * Check if the current kernel supports given sectorsize.
>> + *
>> + * Return true if the sectorsize is supported.
>> + * Return false otherwise.
>> + */
>> +static bool check_supported_sectorsize(u32 sectorsize)
>> +{
>> +	char supported_buf[SUPPORTED_SECTORSIZE_BUF_SIZE] =3D { 0 };
>> +	char sectorsize_buf[SUPPORTED_SECTORSIZE_BUF_SIZE] =3D { 0 };
>> +	char *this_char;
>> +	char *save_ptr =3D NULL;
>> +	int fd;
>> +	int ret;
>> +
>> +	fd =3D sysfs_open_global_feature_file("supported_sectorsizes");
>> +	if (fd < 0)
>> +		return false;
>> +	ret =3D sysfs_read_file(fd, supported_buf, SUPPORTED_SECTORSIZE_BUF_S=
IZE);
>> +	close(fd);
>> +	if (ret < 0)
>> +		return false;
>> +	snprintf(sectorsize_buf, SUPPORTED_SECTORSIZE_BUF_SIZE,
>> +		 "%u", sectorsize);
>> +
>> +	for (this_char =3D strtok_r(supported_buf, " ", &save_ptr);
>> +	     this_char !=3D NULL;
>> +	     this_char =3D strtok_r(NULL, ",", &save_ptr)) {
>
> Based on the example file contents in the comment, I would expect " " as
> the delimeter for looping through the supported sizes, not ",".

What am I doing, (facepalm...

Thanks for pointing this out,
Qu
>
>> +		if (!strncmp(this_char, sectorsize_buf, strlen(sectorsize_buf)))
>> +			return true;
>> +	}
>> +	return false;
>> +}
>> +
>>   int btrfs_check_sectorsize(u32 sectorsize)
>>   {
>> +	bool sectorsize_checked =3D false;
>>   	u32 page_size =3D (u32)sysconf(_SC_PAGESIZE);
>>
>>   	if (!is_power_of_2(sectorsize)) {
>> @@ -340,7 +382,12 @@ int btrfs_check_sectorsize(u32 sectorsize)
>>   		      sectorsize);
>>   		return -EINVAL;
>>   	}
>> -	if (page_size !=3D sectorsize)
>> +	if (page_size =3D=3D sectorsize)
>> +		sectorsize_checked =3D true;
>> +	else
>> +		sectorsize_checked =3D check_supported_sectorsize(sectorsize);
>> +
>> +	if (!sectorsize_checked)
>>   		warning(
>>   "the filesystem may not be mountable, sectorsize %u doesn't match pag=
e size %u",
>>   			sectorsize, page_size);
>> diff --git a/common/utils.c b/common/utils.c
>> index 57e41432c8fb..e8b35879f19f 100644
>> --- a/common/utils.c
>> +++ b/common/utils.c
>> @@ -2205,6 +2205,21 @@ int sysfs_open_fsid_file(int fd, const char *fil=
ename)
>>   	return open(sysfs_file, O_RDONLY);
>>   }
>>
>> +/*
>> + * Open a file in global btrfs features directory and return the file
>> + * descriptor or error.
>> + */
>> +int sysfs_open_global_feature_file(const char *feature_name)
>> +{
>> +	char path[PATH_MAX];
>> +	int ret;
>> +
>> +	ret =3D path_cat_out(path, "/sys/fs/btrfs/features", feature_name);
>> +	if (ret < 0)
>> +		return ret;
>> +	return open(path, O_RDONLY);
>> +}
>> +
>>   /*
>>    * Read up to @size bytes to @buf from @fd
>>    */
>> diff --git a/common/utils.h b/common/utils.h
>> index c38bdb08077c..d2f6416a9b5a 100644
>> --- a/common/utils.h
>> +++ b/common/utils.h
>> @@ -169,6 +169,7 @@ char *btrfs_test_for_multiple_profiles(int fd);
>>   int btrfs_warn_multiple_profiles(int fd);
>>
>>   int sysfs_open_fsid_file(int fd, const char *filename);
>> +int sysfs_open_global_feature_file(const char *feature_name);
>>   int sysfs_read_file(int fd, char *buf, size_t size);
>>
>>   #endif
>> --
>> 2.31.1
>>
